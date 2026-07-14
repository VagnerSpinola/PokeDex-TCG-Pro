from pydantic import BaseModel, ConfigDict, Field

from app.models import CardCondition
from app.schemas.card import CardOut


class CollectionItemCreate(BaseModel):
    card_id: str
    quantity: int = Field(default=1, ge=1, le=10_000)
    condition: CardCondition = CardCondition.near_mint
    notes: str | None = Field(default=None, max_length=1000)


class CollectionItemUpdate(BaseModel):
    quantity: int | None = Field(default=None, ge=1, le=10_000)
    condition: CardCondition | None = None
    notes: str | None = Field(default=None, max_length=1000)


class CollectionItemOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    card_id: str
    quantity: int
    condition: CardCondition
    notes: str | None
    card: CardOut


class PaginatedCollection(BaseModel):
    items: list[CollectionItemOut]
    page: int
    page_size: int
    total: int


class SetCount(BaseModel):
    set_id: str
    set_name: str
    count: int


class CollectionStats(BaseModel):
    total_cards: int
    unique_cards: int
    sets: list[SetCount]
    # Conservative market estimates (cheapest variant, latest snapshot);
    # None until the owned cards have price data.
    value_usd: float | None = None
    value_eur: float | None = None
