from fastapi import APIRouter, HTTPException, status

from app.dependencies import DbSession
from app.schemas.card import SetOut
from app.services import card_service

router = APIRouter(prefix="/sets", tags=["sets"])


@router.get("", response_model=list[SetOut])
async def list_sets(db: DbSession) -> list[SetOut]:
    return [SetOut.model_validate(s) for s in await card_service.list_sets(db)]


@router.get("/{set_id}", response_model=SetOut)
async def get_set(set_id: str, db: DbSession) -> SetOut:
    s = await card_service.get_set(db, set_id)
    if s is None:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Set not found")
    return SetOut.model_validate(s)
