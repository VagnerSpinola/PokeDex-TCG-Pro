"""Sync sets and cards from the Pokémon TCG API into Postgres.

Usage (from backend/ so the venv and .env are picked up):
    python -m etl.sync_cards               # all sets + all cards (long!)
    python -m etl.sync_cards --set sv1     # sets + only cards of one set
    python -m etl.sync_cards --sets-only   # just the sets list

Upserts via INSERT ... ON CONFLICT DO UPDATE — never blind-inserts (AGENTS.md §5).
Scheduled daily sync is phase 3; this is a manually-run CLI for phase 1.
"""

import argparse
import asyncio
import sys
from typing import Any

from sqlalchemy.dialects.postgresql import insert
from sqlalchemy.ext.asyncio import AsyncEngine, create_async_engine

from app.config import get_settings
from app.models import Card, Set
from etl.parsers import card_row, set_row
from etl.pokemontcg_client import PokemonTcgClient

BATCH = 100


async def upsert_rows(engine: AsyncEngine, table: Any, rows: list[dict[str, Any]]) -> None:
    if not rows:
        return
    stmt = insert(table).values(rows)
    updatable = {c.name: stmt.excluded[c.name] for c in table.columns if c.name != "id"}
    # created_at should keep its original value; updated_at refreshes via onupdate.
    updatable.pop("created_at", None)
    stmt = stmt.on_conflict_do_update(index_elements=["id"], set_=updatable)
    async with engine.begin() as conn:
        await conn.execute(stmt)


async def sync_sets(engine: AsyncEngine, client: PokemonTcgClient) -> int:
    rows: list[dict[str, Any]] = []
    count = 0
    async for payload in client.iter_sets():
        rows.append(set_row(payload))
        count += 1
        if len(rows) >= BATCH:
            await upsert_rows(engine, Set.__table__, rows)
            rows = []
    await upsert_rows(engine, Set.__table__, rows)
    return count


async def sync_cards(engine: AsyncEngine, client: PokemonTcgClient, set_id: str | None) -> int:
    rows: list[dict[str, Any]] = []
    count = 0
    async for payload in client.iter_cards(set_id):
        rows.append(card_row(payload))
        count += 1
        if len(rows) >= BATCH:
            await upsert_rows(engine, Card.__table__, rows)
            rows = []
            print(f"  ... {count} cards", flush=True)
    await upsert_rows(engine, Card.__table__, rows)
    return count


async def sync_all_cards_by_set(engine: AsyncEngine, client: PokemonTcgClient) -> int:
    """Sync cards one set at a time, skipping sets that are already complete.

    The API's deep pagination on the global /cards endpoint is unreliable
    (random 404s/timeouts past a few thousand cards); per-set queries are
    small and stable, and this approach is resumable — re-running only
    fetches sets whose local card count is below the set's advertised total.
    """
    from sqlalchemy import func, select

    async with engine.connect() as conn:
        db_counts = dict(
            (await conn.execute(select(Card.set_id, func.count()).group_by(Card.set_id))).all()
        )
        sets_rows = (
            await conn.execute(select(Set.__table__.c.id, Set.__table__.c.total))
        ).all()

    synced = 0
    pending = [(sid, total) for sid, total in sets_rows if not (total and db_counts.get(sid, 0) >= total)]
    print(f"{len(sets_rows) - len(pending)} sets already complete, {len(pending)} to sync")
    for i, (set_id, total) in enumerate(pending, 1):
        n = await sync_cards(engine, client, set_id)
        synced += n
        print(f"[{i}/{len(pending)}] set {set_id}: {n} cards (expected {total})", flush=True)
    return synced


async def main() -> None:
    parser = argparse.ArgumentParser(description="Sync Pokémon TCG API data into Postgres")
    parser.add_argument("--set", dest="set_id", help="only sync cards of this set id (e.g. sv1)")
    parser.add_argument("--sets-only", action="store_true", help="sync only the sets list")
    args = parser.parse_args()

    settings = get_settings()
    engine = create_async_engine(settings.database_url)
    client = PokemonTcgClient(settings.pokemontcg_api_key)
    try:
        n_sets = await sync_sets(engine, client)
        print(f"synced {n_sets} sets")
        if args.set_id:
            n_cards = await sync_cards(engine, client, args.set_id)
            print(f"synced {n_cards} cards (set {args.set_id})")
        elif not args.sets_only:
            n_cards = await sync_all_cards_by_set(engine, client)
            print(f"synced {n_cards} cards")
    finally:
        await client.close()
        await engine.dispose()


if __name__ == "__main__":
    if sys.platform == "win32":
        asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())
    # Use the OS certificate store — Windows Python often can't validate the
    # API's chain against bundled certifi alone.
    import truststore

    truststore.inject_into_ssl()
    asyncio.run(main())
