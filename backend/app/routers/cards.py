from typing import Annotated

from fastapi import APIRouter, HTTPException, Query, status

from app.dependencies import DbSession
from app.schemas.card import CardDetailOut, PaginatedCards
from app.services import card_service

router = APIRouter(prefix="/cards", tags=["cards"])


@router.get("", response_model=PaginatedCards)
async def list_cards(
    db: DbSession,
    page: Annotated[int, Query(ge=1)] = 1,
    page_size: Annotated[int, Query(ge=1, le=100)] = 20,
    q: Annotated[str | None, Query(max_length=100)] = None,
    set_id: str | None = None,
    rarity: str | None = None,
    supertype: str | None = None,
    type: str | None = None,
) -> PaginatedCards:
    cards, total = await card_service.list_cards(
        db,
        page=page,
        page_size=page_size,
        q=q,
        set_id=set_id,
        rarity=rarity,
        supertype=supertype,
        card_type=type,
    )
    return PaginatedCards(items=cards, page=page, page_size=page_size, total=total)


@router.get("/{card_id}", response_model=CardDetailOut)
async def get_card(card_id: str, db: DbSession) -> CardDetailOut:
    card = await card_service.get_card(db, card_id)
    if card is None:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Card not found")
    return CardDetailOut.model_validate(card)
