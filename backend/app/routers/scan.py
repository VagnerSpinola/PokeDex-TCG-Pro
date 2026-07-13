from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, UploadFile, status
from sqlalchemy import select

from app.dependencies import DbSession
from app.models import Card
from app.schemas.card import CardOut
from app.schemas.scan import EmbeddingScanRequest, ScanCandidate, ScanResponse
from app.services import scan_service
from app.services.scan_service import IndexNotBuiltError, Scanner

router = APIRouter(prefix="/scan", tags=["scan"])

MAX_UPLOAD_BYTES = 10 * 1024 * 1024


def get_scanner() -> Scanner:
    try:
        return scan_service.get_scanner()
    except IndexNotBuiltError as exc:
        raise HTTPException(
            status.HTTP_503_SERVICE_UNAVAILABLE,
            "Scanner indisponível: índice ainda não construído",
        ) from exc


ScannerDep = Annotated[Scanner, Depends(get_scanner)]


async def _build_response(
    db: DbSession,
    matches: list[tuple[str, float]],
    ocr_text: str,
) -> ScanResponse:
    ids = [card_id for card_id, _ in matches]
    cards = (await db.scalars(select(Card).where(Card.id.in_(ids)))).all()
    cards_by_id = {c.id: c for c in cards}

    ranked = scan_service.rank_candidates(
        matches, {c.id: c.name for c in cards}, ocr_text
    )
    candidates = [
        ScanCandidate(
            card=CardOut.model_validate(cards_by_id[r.card_id]),
            score=r.score,
            confidence=r.confidence,
        )
        for r in ranked
        if r.card_id in cards_by_id
    ]
    low_confidence = not candidates or candidates[0].confidence != "high"
    # Best OCR-corroborated name, if any — feeds the manual-search fallback.
    name_guess = None
    text = ocr_text.casefold()
    for c in candidates:
        if c.card.name.casefold() in text:
            name_guess = c.card.name
            break
    return ScanResponse(
        candidates=candidates, low_confidence=low_confidence, name_guess=name_guess
    )


@router.post("", response_model=ScanResponse)
async def scan_card_photo(file: UploadFile, db: DbSession, scanner: ScannerDep) -> ScanResponse:
    image_bytes = await file.read()
    if len(image_bytes) > MAX_UPLOAD_BYTES:
        raise HTTPException(status.HTTP_413_REQUEST_ENTITY_TOO_LARGE, "Imagem acima de 10MB")
    try:
        matches, ocr_text = scanner.match(image_bytes)
    except ValueError:
        raise HTTPException(
            status.HTTP_422_UNPROCESSABLE_ENTITY, "Arquivo não é uma imagem válida"
        ) from None
    return await _build_response(db, matches, ocr_text)


@router.post("/embedding", response_model=ScanResponse)
async def scan_by_embedding(
    body: EmbeddingScanRequest, db: DbSession, scanner: ScannerDep
) -> ScanResponse:
    """Future on-device path: the phone extracts the embedding via TFLite and
    sends only the vector (AGENTS.md architecture). No OCR assist here."""
    matches = scanner.match_embedding(body.embedding, body.k)
    return await _build_response(db, matches, ocr_text="")
