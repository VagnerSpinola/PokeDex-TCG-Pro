from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import Card, CardCondition, CollectionItem, Price, Set


class CardNotFoundError(Exception):
    pass


class ItemNotFoundError(Exception):
    pass


async def list_items(
    db: AsyncSession, user_id: int, *, page: int, page_size: int
) -> tuple[list[CollectionItem], int]:
    base = select(CollectionItem).where(CollectionItem.user_id == user_id)
    total = (
        await db.scalar(
            select(func.count(CollectionItem.id)).where(CollectionItem.user_id == user_id)
        )
        or 0
    )
    stmt = base.order_by(CollectionItem.created_at.desc()).offset((page - 1) * page_size).limit(
        page_size
    )
    items = (await db.scalars(stmt)).all()
    return list(items), total


async def add_item(
    db: AsyncSession,
    user_id: int,
    *,
    card_id: str,
    quantity: int,
    condition: CardCondition,
    notes: str | None,
) -> CollectionItem:
    """Upsert: adding the same card+condition again sums quantities (AGENTS.md §5)."""
    card = await db.get(Card, card_id)
    if card is None:
        raise CardNotFoundError

    existing = await db.scalar(
        select(CollectionItem).where(
            CollectionItem.user_id == user_id,
            CollectionItem.card_id == card_id,
            CollectionItem.condition == condition,
        )
    )
    if existing is not None:
        existing.quantity += quantity
        if notes is not None:
            existing.notes = notes
        await db.commit()
        await db.refresh(existing)
        return existing

    item = CollectionItem(
        user_id=user_id, card_id=card_id, quantity=quantity, condition=condition, notes=notes
    )
    db.add(item)
    await db.commit()
    await db.refresh(item)
    return item


async def _get_owned_item(db: AsyncSession, user_id: int, item_id: int) -> CollectionItem:
    item = await db.get(CollectionItem, item_id)
    # Another user's item is reported as absent, not forbidden — don't leak existence.
    if item is None or item.user_id != user_id:
        raise ItemNotFoundError
    return item


async def update_item(
    db: AsyncSession,
    user_id: int,
    item_id: int,
    *,
    quantity: int | None,
    condition: CardCondition | None,
    notes: str | None,
) -> CollectionItem:
    item = await _get_owned_item(db, user_id, item_id)
    if quantity is not None:
        item.quantity = quantity
    if condition is not None:
        item.condition = condition
    if notes is not None:
        item.notes = notes
    await db.commit()
    await db.refresh(item)
    return item


async def delete_item(db: AsyncSession, user_id: int, item_id: int) -> None:
    item = await _get_owned_item(db, user_id, item_id)
    await db.delete(item)
    await db.commit()


async def get_stats(db: AsyncSession, user_id: int) -> dict:
    total_cards = (
        await db.scalar(
            select(func.coalesce(func.sum(CollectionItem.quantity), 0)).where(
                CollectionItem.user_id == user_id
            )
        )
        or 0
    )
    unique_cards = (
        await db.scalar(
            select(func.count(func.distinct(CollectionItem.card_id))).where(
                CollectionItem.user_id == user_id
            )
        )
        or 0
    )
    per_set = (
        await db.execute(
            select(Set.id, Set.name, func.sum(CollectionItem.quantity))
            .join(Card, Card.set_id == Set.id)
            .join(CollectionItem, CollectionItem.card_id == Card.id)
            .where(CollectionItem.user_id == user_id)
            .group_by(Set.id, Set.name)
            .order_by(func.sum(CollectionItem.quantity).desc())
        )
    ).all()
    value_usd, value_eur = await _estimated_value(db, user_id)
    return {
        "total_cards": int(total_cards),
        "unique_cards": int(unique_cards),
        "sets": [{"set_id": s, "set_name": n, "count": int(c)} for s, n, c in per_set],
        "value_usd": value_usd,
        "value_eur": value_eur,
    }


async def _estimated_value(
    db: AsyncSession, user_id: int
) -> tuple[float | None, float | None]:
    """Conservative market value: latest snapshot per (card, source, variant),
    cheapest variant per card (a collection row doesn't know its printing),
    times owned quantity. USD = TCGplayer view, EUR = Cardmarket view."""
    qty = dict(
        (
            await db.execute(
                select(CollectionItem.card_id, func.sum(CollectionItem.quantity))
                .where(CollectionItem.user_id == user_id)
                .group_by(CollectionItem.card_id)
            )
        ).all()
    )
    if not qty:
        return None, None

    latest = (
        select(
            Price.card_id,
            Price.source,
            Price.variant,
            func.max(Price.date).label("max_date"),
        )
        .where(Price.card_id.in_(qty))
        .group_by(Price.card_id, Price.source, Price.variant)
        .subquery()
    )
    rows = (
        await db.execute(
            select(Price.card_id, Price.source, Price.currency, Price.market, Price.mid).join(
                latest,
                (Price.card_id == latest.c.card_id)
                & (Price.source == latest.c.source)
                & (Price.variant == latest.c.variant)
                & (Price.date == latest.c.max_date),
            )
        )
    ).all()

    best: dict[tuple[str, str], tuple[str, float]] = {}
    for card_id, source, currency, market, mid in rows:
        raw = market if market is not None else mid
        if raw is None:
            continue
        value = float(raw)
        key = (card_id, source)
        if key not in best or value < best[key][1]:
            best[key] = (currency, value)

    totals: dict[str, float] = {}
    for (card_id, _source), (currency, value) in best.items():
        totals[currency] = totals.get(currency, 0.0) + value * int(qty[card_id])

    usd = round(totals["USD"], 2) if "USD" in totals else None
    eur = round(totals["EUR"], 2) if "EUR" in totals else None
    return usd, eur
