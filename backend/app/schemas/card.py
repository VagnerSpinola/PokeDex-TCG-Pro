from datetime import date

from pydantic import BaseModel, ConfigDict


class SetOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: str
    name: str
    series: str | None
    printed_total: int | None
    total: int | None
    release_date: date | None
    symbol_url: str | None
    logo_url: str | None


class CardOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: str
    name: str
    set_id: str
    number: str | None
    supertype: str | None
    subtypes: list[str] | None
    types: list[str] | None
    rarity: str | None
    hp: int | None
    artist: str | None
    image_small_url: str | None
    image_large_url: str | None
    flavor_text: str | None


class PriceOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    source: str
    variant: str
    date: date
    currency: str
    low: float | None
    mid: float | None
    high: float | None
    market: float | None


class CardDetailOut(CardOut):
    set: SetOut
    # Latest snapshot per (source, variant); empty until the price sync runs.
    prices: list[PriceOut] = []


class PaginatedCards(BaseModel):
    items: list[CardOut]
    page: int
    page_size: int
    total: int
