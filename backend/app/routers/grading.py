from fastapi import APIRouter, HTTPException, UploadFile, status

from app.schemas.grading import GradeResponse, GradeSubScores
from app.services import grading_service

router = APIRouter(prefix="/grade", tags=["grading"])

MAX_UPLOAD_BYTES = 10 * 1024 * 1024


@router.post("", response_model=GradeResponse)
async def grade_card_photo(file: UploadFile) -> GradeResponse:
    """Experimental condition estimate from a card photo. Never an official grade."""
    image_bytes = await file.read()
    if len(image_bytes) > MAX_UPLOAD_BYTES:
        raise HTTPException(status.HTTP_413_REQUEST_ENTITY_TOO_LARGE, "Imagem acima de 10MB")
    try:
        estimate = grading_service.grade_card(image_bytes)
    except ValueError:
        raise HTTPException(
            status.HTTP_422_UNPROCESSABLE_ENTITY, "Arquivo não é uma imagem válida"
        ) from None
    except grading_service.CardNotFoundError:
        raise HTTPException(
            status.HTTP_422_UNPROCESSABLE_ENTITY,
            "Não foi possível localizar uma carta na foto — enquadre a carta inteira "
            "sobre um fundo contrastante",
        ) from None
    return GradeResponse(
        estimated_grade=estimate.overall,
        sub_scores=GradeSubScores(
            centering=estimate.centering,
            corners=estimate.corners,
            edges=estimate.edges,
            surface=estimate.surface,
        ),
        warnings=estimate.warnings,
    )
