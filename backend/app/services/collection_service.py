from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import Card, CardCondition, CollectionItem, Set


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
    return {
        "total_cards": int(total_cards),
        "unique_cards": int(unique_cards),
        "sets": [{"set_id": s, "set_name": n, "count": int(c)} for s, n, c in per_set],
    }
