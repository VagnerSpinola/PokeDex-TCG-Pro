import tempfile
from pathlib import Path

from fastapi import APIRouter, HTTPException, UploadFile, status

from app.schemas.grading import (
    CenteringOut,
    CornerOut,
    EdgeOut,
    GradeResponse,
    GradeSubScores,
    QualityOut,
    SurfaceOut,
)
from app.services import grading_service
from app.services.grading_service import GradeReport

router = APIRouter(prefix="/grade", tags=["grading"])

MAX_IMAGE_BYTES = 12 * 1024 * 1024
MAX_VIDEO_BYTES = 80 * 1024 * 1024

FRAME_TIPS = (
    "Enquadre a carta inteira sobre fundo contrastante, com luz difusa em 45° "
    "dos dois lados (5000–6500K) e sem flash."
)


def _to_response(report: GradeReport) -> GradeResponse:
    corner_scores = [c.score for c in report.corners]
    edge_scores = [e.score for e in report.edges]
    return GradeResponse(
        estimated_grade=report.estimated_grade,
        grade_range=[report.grade_min, report.grade_max],
        sub_scores=GradeSubScores(
            centering=report.centering.score,
            corners=grading_service._worst_weighted(corner_scores),
            edges=grading_service._worst_weighted(edge_scores),
            surface=report.surface.score,
        ),
        centering=CenteringOut(
            left_right=report.centering.left_right,
            top_bottom=report.centering.top_bottom,
            cap=report.centering.cap,
        ),
        corners=[
            CornerOut(corner=c.corner, whitening_pct=c.whitening_pct, score=c.score)
            for c in report.corners
        ],
        edges=[
            EdgeOut(edge=e.edge, whitening_pct=e.whitening_pct, clustered=e.clustered,
                    score=e.score)
            for e in report.edges
        ],
        surface=SurfaceOut(
            glare_pct=report.surface.glare_pct,
            scratch_index=report.surface.scratch_index,
            crease_detected=report.surface.crease_detected,
            severe_crease=report.surface.severe_crease,
            print_line=report.surface.print_line,
            score=report.surface.score,
        ),
        quality=QualityOut(
            ok=report.quality.ok,
            sharpness=report.quality.sharpness,
            glare_pct=report.quality.glare_pct,
            issues=report.quality.issues,
        ),
        frames_analyzed=report.frames_analyzed,
        warnings=report.warnings,
    )


@router.post("", response_model=GradeResponse)
async def grade_card_photo(
    file: UploadFile, back: UploadFile | None = None
) -> GradeResponse:
    """Experimental PSA-style condition estimate from a card photo.

    Optional `back` photo: PSA grades both sides (back centering is one band
    more forgiving); the final estimate is limited by the worse side.
    """
    image_bytes = await file.read()
    if len(image_bytes) > MAX_IMAGE_BYTES:
        raise HTTPException(status.HTTP_413_REQUEST_ENTITY_TOO_LARGE, "Imagem acima de 12MB")
    back_bytes = await back.read() if back is not None else None
    try:
        report = grading_service.grade_card(image_bytes, back_bytes)
    except ValueError:
        raise HTTPException(
            status.HTTP_422_UNPROCESSABLE_ENTITY, "Arquivo não é uma imagem válida"
        ) from None
    except grading_service.CardNotFoundError:
        raise HTTPException(
            status.HTTP_422_UNPROCESSABLE_ENTITY,
            f"Não foi possível localizar uma carta na foto — {FRAME_TIPS}",
        ) from None
    return _to_response(report)


@router.post("/video", response_model=GradeResponse)
async def grade_card_video(file: UploadFile) -> GradeResponse:
    """Video-based estimate: tilt the card slowly under the light for 3-10s.

    Defects that persist across frames/angles count; moving glare is
    discarded. Minimums: 720p, 2s, card in frame and in focus.
    """
    video_bytes = await file.read()
    if len(video_bytes) > MAX_VIDEO_BYTES:
        raise HTTPException(status.HTTP_413_REQUEST_ENTITY_TOO_LARGE, "Vídeo acima de 80MB")

    suffix = Path(file.filename or "clip.mp4").suffix or ".mp4"
    with tempfile.NamedTemporaryFile(suffix=suffix, delete=False) as tmp:
        tmp.write(video_bytes)
        tmp_path = tmp.name
    try:
        report = grading_service.grade_video(tmp_path)
    except grading_service.VideoTooPoorError as exc:
        raise HTTPException(status.HTTP_422_UNPROCESSABLE_ENTITY, exc.reason) from None
    finally:
        Path(tmp_path).unlink(missing_ok=True)
    return _to_response(report)
