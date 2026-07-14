from pydantic import BaseModel

from app.services.grading_service import DISCLAIMER


class GradeSubScores(BaseModel):
    centering: float
    corners: float
    edges: float
    surface: float


class CenteringOut(BaseModel):
    left_right: str   # "57/43"
    top_bottom: str
    cap: float        # PSA ceiling from centering alone


class CornerOut(BaseModel):
    corner: str
    whitening_pct: float
    score: float


class EdgeOut(BaseModel):
    edge: str
    whitening_pct: float
    clustered: bool
    score: float


class SurfaceOut(BaseModel):
    glare_pct: float
    scratch_index: float
    crease_detected: bool
    severe_crease: bool
    print_line: bool
    score: float


class QualityOut(BaseModel):
    ok: bool
    sharpness: float
    glare_pct: float
    issues: list[str]


class GradeResponse(BaseModel):
    """Experimental estimate following PSA's published standards — the
    disclaimer is part of the contract (AGENTS.md §2) and every client must
    render it visibly. The grade is a RANGE, never an authoritative point."""

    experimental: bool = True
    estimated_grade: float
    grade_range: list[float]          # [min, max]
    sub_scores: GradeSubScores
    centering: CenteringOut
    corners: list[CornerOut]
    edges: list[EdgeOut]
    surface: SurfaceOut
    quality: QualityOut
    frames_analyzed: int
    warnings: list[str]
    disclaimer: str = DISCLAIMER
