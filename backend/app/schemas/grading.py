from pydantic import BaseModel

from app.services.grading_service import DISCLAIMER


class GradeSubScores(BaseModel):
    centering: float
    corners: float
    edges: float
    surface: float


class GradeResponse(BaseModel):
    """Experimental estimate — the disclaimer is part of the contract
    (AGENTS.md §2) and must be rendered visibly by every client."""

    experimental: bool = True
    estimated_grade: float
    sub_scores: GradeSubScores
    warnings: list[str]
    disclaimer: str = DISCLAIMER
