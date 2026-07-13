from pydantic import BaseModel, Field

from app.schemas.card import CardOut


class ScanCandidate(BaseModel):
    card: CardOut
    score: float
    confidence: str  # high | medium | low


class ScanResponse(BaseModel):
    """Match candidates for user confirmation — never an automatic answer.

    `low_confidence` means the client MUST steer the user to the manual
    correction flow (AGENTS.md §2: never invent card data).
    """

    candidates: list[ScanCandidate]
    low_confidence: bool
    name_guess: str | None = None
    disclaimer: str = (
        "Correspondência estimada — confirme a carta antes de adicionar. "
        "Baixa confiança exige correção manual."
    )


class EmbeddingScanRequest(BaseModel):
    embedding: list[float] = Field(min_length=8, max_length=4096)
    k: int = Field(default=5, ge=1, le=10)
