from typing import Annotated

from fastapi import APIRouter, HTTPException, Query, status

from app.dependencies import CurrentUserOrDefault, DbSession
from app.schemas.collection import (
    CollectionItemCreate,
    CollectionItemOut,
    CollectionItemUpdate,
    CollectionStats,
    PaginatedCollection,
)
from app.services import collection_service

router = APIRouter(prefix="/collection", tags=["collection"])


@router.get("", response_model=PaginatedCollection)
async def list_collection(
    user: CurrentUserOrDefault,
    db: DbSession,
    page: Annotated[int, Query(ge=1)] = 1,
    page_size: Annotated[int, Query(ge=1, le=100)] = 20,
) -> PaginatedCollection:
    items, total = await collection_service.list_items(
        db, user.id, page=page, page_size=page_size
    )
    return PaginatedCollection(items=items, page=page, page_size=page_size, total=total)


@router.post("", response_model=CollectionItemOut, status_code=status.HTTP_201_CREATED)
async def add_to_collection(
    body: CollectionItemCreate, user: CurrentUserOrDefault, db: DbSession
) -> CollectionItemOut:
    try:
        item = await collection_service.add_item(
            db,
            user.id,
            card_id=body.card_id,
            quantity=body.quantity,
            condition=body.condition,
            notes=body.notes,
        )
    except collection_service.CardNotFoundError:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Card not found") from None
    return CollectionItemOut.model_validate(item)


@router.patch("/{item_id}", response_model=CollectionItemOut)
async def update_collection_item(
    item_id: int, body: CollectionItemUpdate, user: CurrentUserOrDefault, db: DbSession
) -> CollectionItemOut:
    try:
        item = await collection_service.update_item(
            db,
            user.id,
            item_id,
            quantity=body.quantity,
            condition=body.condition,
            notes=body.notes,
        )
    except collection_service.ItemNotFoundError:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Collection item not found") from None
    return CollectionItemOut.model_validate(item)


@router.delete("/{item_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_collection_item(item_id: int, user: CurrentUserOrDefault, db: DbSession) -> None:
    try:
        await collection_service.delete_item(db, user.id, item_id)
    except collection_service.ItemNotFoundError:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Collection item not found") from None


@router.get("/stats", response_model=CollectionStats)
async def collection_stats(user: CurrentUserOrDefault, db: DbSession) -> CollectionStats:
    return CollectionStats(**await collection_service.get_stats(db, user.id))
