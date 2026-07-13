"""Daily price sync from the Pokémon TCG API into the prices table.

Usage (from backend/ so the venv and .env are picked up):
    python -m etl.sync_prices               # all sets
    python -m etl.sync_prices --set sv1     # a single set

Card payloads embed TCGplayer (USD, per printing variant) and Cardmarket (EUR)
price blocks stamped with their own update date. Rows are upserted on
(card_id, source, variant, date), so re-running any day is idempotent
(AGENTS.md §5: upsert, never blind-insert). Cards are refreshed in passing
since the same payload carries the card data.

This CLI *is* the daily job for now — run it manually or via any scheduler.
Celery/beat orchestration belongs to the infra phase.
"""

import argparse
import asyncio
import sys
from typing import Any

import httpx
from sqlalchemy import select
from sqlalchemy.dialects.postgresql import insert
from sqlalchemy.ext.asyncio import AsyncEngine, create_async_engine

from app.config import get_settings
from app.models import Card, Price, Set
from etl.parsers import card_row, price_rows
from etl.pokemontcg_client import PokemonTcgClient
from etl.sync_cards import upsert_rows

BATCH = 200


async def upsert_price_rows(engine: AsyncEngine, rows: list[dict[str, Any]]) -> None:
    if not rows:
        return
    stmt = insert(Price.__table__).values(rows)
    updatable = {
        c.name: stmt.excluded[c.name]
        for c in Price.__table__.columns
        if c.name not in ("id", "card_id", "source", "variant", "date", "created_at")
    }
    stmt = stmt.on_conflict_do_update(
        index_elements=["card_id", "source", "variant", "date"], set_=updatable
    )
    async with engine.begin() as conn:
        await conn.execute(stmt)


async def sync_set_prices(engine: AsyncEngine, client: PokemonTcgClient, set_id: str) -> int:
    cards: list[dict[str, Any]] = []
    prices: list[dict[str, Any]] = []
    count = 0
    async for payload in client.iter_cards(set_id):
        cards.append(card_row(payload))
        new_rows = price_rows(payload)
        prices.extend(new_rows)
        count += len(new_rows)
        if len(prices) >= BATCH:
            await upsert_rows(engine, Card.__table__, cards)
            await upsert_price_rows(engine, prices)
            cards, prices = [], []
    await upsert_rows(engine, Card.__table__, cards)
    await upsert_price_rows(engine, prices)
    return count


async def main() -> None:
    parser = argparse.ArgumentParser(description="Sync card prices into Postgres")
    parser.add_argument("--set", dest="set_id", help="only sync prices of this set id")
    args = parser.parse_args()

    settings = get_settings()
    engine = create_async_engine(settings.database_url)
    client = PokemonTcgClient(settings.pokemontcg_api_key)
    try:
        if args.set_id:
            set_ids = [args.set_id]
        else:
            async with engine.connect() as conn:
                set_ids = list((await conn.execute(select(Set.__table__.c.id))).scalars())
        total = 0
        skipped: list[str] = []
        for i, set_id in enumerate(set_ids, 1):
            try:
                n = await sync_set_prices(engine, client, set_id)
            except httpx.HTTPError as exc:
                # One flaky set must not kill the whole daily run.
                skipped.append(set_id)
                print(f"[{i}/{len(set_ids)}] set {set_id}: SKIPPED ({exc})", flush=True)
                continue
            total += n
            print(f"[{i}/{len(set_ids)}] set {set_id}: {n} price rows", flush=True)
        print(f"synced {total} price rows" + (f"; skipped sets: {skipped}" if skipped else ""))
    finally:
        await client.close()
        await engine.dispose()


if __name__ == "__main__":
    if sys.platform == "win32":
        asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())
    import truststore

    truststore.inject_into_ssl()
    asyncio.run(main())
