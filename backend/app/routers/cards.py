from typing import Annotated

from fastapi import APIRouter, HTTPException, Query, status

from app.dependencies import DbSession
from app.schemas.card import CardDetailOut, PaginatedCards, PriceOut
from app.services import card_service

router = APIRouter(prefix="/cards", tags=["cards"])


@router.get("", response_model=PaginatedCards)
async def list_cards(
    db: DbSession,
    page: Annotated[int, Query(ge=1)] = 1,
    page_size: Annotated[int, Query(ge=1, le=100)] = 20,
    q: Annotated[str | None, Query(max_length=100)] = None,
    # Repeatable: ?set_id=sv1&set_id=base1 filters across all selected sets.
    set_id: Annotated[list[str] | None, Query(max_length=50)] = None,
    rarity: Annotated[list[str] | None, Query(max_length=50)] = None,
    supertype: str | None = None,
    type: str | None = None,
) -> PaginatedCards:
    cards, total = await card_service.list_cards(
        db,
        page=page,
        page_size=page_size,
        q=q,
        set_ids=set_id,
        rarities=rarity,
        supertype=supertype,
        card_type=type,
    )
    return PaginatedCards(items=cards, page=page, page_size=page_size, total=total)


@router.get("/{card_id}", response_model=CardDetailOut)
async def get_card(card_id: str, db: DbSession) -> CardDetailOut:
    card = await card_service.get_card(db, card_id)
    if card is None:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Card not found")
    prices = await card_service.latest_prices(db, card_id)
    detail = CardDetailOut.model_validate(card)
    return detail.model_copy(update={"prices": [PriceOut.model_validate(p) for p in prices]})


@router.get("/{card_id}/prices", response_model=list[PriceOut])
async def get_card_price_history(
    card_id: str,
    db: DbSession,
    days: Annotated[int, Query(ge=1, le=365)] = 90,
) -> list[PriceOut]:
    card = await card_service.get_card(db, card_id)
    if card is None:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Card not found")
    history = await card_service.price_history(db, card_id, days)
    return [PriceOut.model_validate(p) for p in history]
