from sqlalchemy import Select, Text, func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import Card, Set


def _apply_card_filters(
    stmt: Select,
    *,
    q: str | None,
    set_id: str | None,
    rarity: str | None,
    supertype: str | None,
    card_type: str | None,
) -> Select:
    if q:
        stmt = stmt.where(Card.name.ilike(f"%{q}%"))
    if set_id:
        stmt = stmt.where(Card.set_id == set_id)
    if rarity:
        stmt = stmt.where(Card.rarity == rarity)
    if supertype:
        stmt = stmt.where(Card.supertype == supertype)
    if card_type:
        # `types` is a JSON array of strings; cast to text and match the quoted element.
        stmt = stmt.where(Card.types.cast(Text).ilike(f'%"{card_type}"%'))
    return stmt


async def list_cards(
    db: AsyncSession,
    *,
    page: int,
    page_size: int,
    q: str | None = None,
    set_id: str | None = None,
    rarity: str | None = None,
    supertype: str | None = None,
    card_type: str | None = None,
) -> tuple[list[Card], int]:
    filters = dict(q=q, set_id=set_id, rarity=rarity, supertype=supertype, card_type=card_type)

    count_stmt = _apply_card_filters(select(func.count(Card.id)), **filters)
    total = await db.scalar(count_stmt) or 0

    stmt = (
        _apply_card_filters(select(Card), **filters)
        .order_by(Card.set_id, Card.number)
        .offset((page - 1) * page_size)
        .limit(page_size)
    )
    cards = (await db.scalars(stmt)).all()
    return list(cards), total


async def get_card(db: AsyncSession, card_id: str) -> Card | None:
    return await db.get(Card, card_id)


async def list_sets(db: AsyncSession) -> list[Set]:
    stmt = select(Set).order_by(Set.release_date.desc().nulls_last(), Set.id)
    return list((await db.scalars(stmt)).all())


async def get_set(db: AsyncSession, set_id: str) -> Set | None:
    return await db.get(Set, set_id)
