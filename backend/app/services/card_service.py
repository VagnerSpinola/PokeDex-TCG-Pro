from datetime import date, timedelta

from sqlalchemy import Integer, Select, Text, func, or_, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import aliased

from app.models import Card, Price, Set


def _apply_card_filters(
    stmt: Select,
    *,
    q: str | None,
    set_ids: list[str] | None,
    rarities: list[str] | None,
    supertype: str | None,
    card_type: str | None,
) -> Select:
    if q:
        # Every token must match somewhere: card name, set name, or the card
        # number — so "charizard base" finds Charizard in Base Set.
        stmt = stmt.join(Set, Card.set_id == Set.id)
        for token in q.split():
            stmt = stmt.where(
                or_(
                    Card.name.ilike(f"%{token}%"),
                    Set.name.ilike(f"%{token}%"),
                    Card.number.ilike(token),
                )
            )
    if set_ids:
        stmt = stmt.where(Card.set_id.in_(set_ids))
    if rarities:
        stmt = stmt.where(Card.rarity.in_(rarities))
    if supertype:
        stmt = stmt.where(Card.supertype == supertype)
    if card_type:
        # `types` is a JSON array of strings; cast to text and match the quoted element.
        stmt = stmt.where(Card.types.cast(Text).ilike(f'%"{card_type}"%'))
    return stmt


# Card.number is text ("25", "TG12", "177a"); extract the digits so 2 < 10.
_number_numeric = func.nullif(func.regexp_replace(Card.number, r"\D", "", "g"), "").cast(Integer)


def _latest_usd_market():
    """Correlated subquery: highest USD market at the card's newest snapshot."""
    latest = aliased(Price)
    latest_date = (
        select(func.max(latest.date))
        .where(latest.card_id == Card.id, latest.currency == "USD")
        .correlate(Card)
        .scalar_subquery()
    )
    return (
        select(func.max(Price.market))
        .where(Price.card_id == Card.id, Price.currency == "USD", Price.date == latest_date)
        .correlate(Card)
        .scalar_subquery()
    )


def _order_clause(sort: str | None) -> tuple:
    match sort:
        case "name":
            return (Card.name.asc(), Card.id)
        case "-name":
            return (Card.name.desc(), Card.id)
        case "number":
            return (_number_numeric.asc().nulls_last(), Card.number, Card.id)
        case "-number":
            return (_number_numeric.desc().nulls_last(), Card.number, Card.id)
        case "price":
            return (_latest_usd_market().asc().nulls_last(), Card.id)
        case "-price":
            return (_latest_usd_market().desc().nulls_last(), Card.id)
        case _:
            return (Card.set_id, _number_numeric, Card.number)


async def list_cards(
    db: AsyncSession,
    *,
    page: int,
    page_size: int,
    q: str | None = None,
    set_ids: list[str] | None = None,
    rarities: list[str] | None = None,
    supertype: str | None = None,
    card_type: str | None = None,
    sort: str | None = None,
) -> tuple[list[Card], int]:
    filters = dict(
        q=q, set_ids=set_ids, rarities=rarities, supertype=supertype, card_type=card_type
    )

    count_stmt = _apply_card_filters(select(func.count(Card.id)), **filters)
    total = await db.scalar(count_stmt) or 0

    stmt = (
        _apply_card_filters(select(Card), **filters)
        .order_by(*_order_clause(sort))
        .offset((page - 1) * page_size)
        .limit(page_size)
    )
    cards = (await db.scalars(stmt)).all()
    return list(cards), total


async def get_card(db: AsyncSession, card_id: str) -> Card | None:
    return await db.get(Card, card_id)


async def latest_prices(db: AsyncSession, card_id: str) -> list[Price]:
    """Most recent snapshot per (source, variant)."""
    stmt = (
        select(Price)
        .where(Price.card_id == card_id)
        .order_by(Price.source, Price.variant, Price.date.desc())
    )
    rows = (await db.scalars(stmt)).all()
    seen: set[tuple[str, str]] = set()
    out: list[Price] = []
    for price in rows:
        key = (price.source, price.variant)
        if key not in seen:
            seen.add(key)
            out.append(price)
    return out


async def price_history(db: AsyncSession, card_id: str, days: int) -> list[Price]:
    cutoff = date.today() - timedelta(days=days)
    stmt = (
        select(Price)
        .where(Price.card_id == card_id, Price.date >= cutoff)
        .order_by(Price.date, Price.source, Price.variant)
    )
    return list((await db.scalars(stmt)).all())


async def list_sets(db: AsyncSession) -> list[Set]:
    stmt = select(Set).order_by(Set.release_date.desc().nulls_last(), Set.id)
    return list((await db.scalars(stmt)).all())


async def get_set(db: AsyncSession, set_id: str) -> Set | None:
    return await db.get(Set, set_id)
