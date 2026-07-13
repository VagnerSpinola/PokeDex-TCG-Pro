"""Test fixtures: real Postgres test DB (AGENTS.md §7 — no mocked SQLAlchemy).

Requires the docker-compose Postgres to be running. Creates/reuses a separate
`pokedex_tcg_test` database; each test runs against truncated tables.
"""

import os
from collections.abc import AsyncGenerator

import pytest
from httpx import ASGITransport, AsyncClient
from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine
from sqlalchemy.pool import NullPool

from app.database import get_db
from app.main import app
from app.models import Base

ADMIN_URL = os.environ.get(
    "DATABASE_URL", "postgresql+asyncpg://pokedex:pokedex@localhost:15432/pokedex_tcg"
)
TEST_DB_NAME = "pokedex_tcg_test"
TEST_URL = ADMIN_URL.rsplit("/", 1)[0] + f"/{TEST_DB_NAME}"


@pytest.fixture(scope="session")
async def engine():
    admin_engine = create_async_engine(ADMIN_URL, isolation_level="AUTOCOMMIT", poolclass=NullPool)
    async with admin_engine.connect() as conn:
        exists = await conn.scalar(
            text("SELECT 1 FROM pg_database WHERE datname = :n"), {"n": TEST_DB_NAME}
        )
        if not exists:
            await conn.execute(text(f'CREATE DATABASE "{TEST_DB_NAME}"'))
    await admin_engine.dispose()

    # NullPool: tests run on per-test event loops; pooled asyncpg connections
    # cannot be reused across loops.
    engine = create_async_engine(TEST_URL, poolclass=NullPool)
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)
        await conn.run_sync(Base.metadata.create_all)
    yield engine
    await engine.dispose()


@pytest.fixture
async def db(engine) -> AsyncGenerator[AsyncSession, None]:
    factory = async_sessionmaker(engine, expire_on_commit=False)
    async with factory() as session:
        yield session
    # Truncate everything so each test starts clean.
    async with engine.begin() as conn:
        tables = ", ".join(t.name for t in Base.metadata.sorted_tables)
        await conn.execute(text(f"TRUNCATE {tables} RESTART IDENTITY CASCADE"))


@pytest.fixture
async def client(engine, db) -> AsyncGenerator[AsyncClient, None]:
    async def override_get_db() -> AsyncGenerator[AsyncSession, None]:
        factory = async_sessionmaker(engine, expire_on_commit=False)
        async with factory() as session:
            yield session

    app.dependency_overrides[get_db] = override_get_db
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as c:
        yield c
    app.dependency_overrides.clear()


@pytest.fixture
async def seed_cards(db: AsyncSession) -> dict:
    """Two sets and three cards used by card/collection tests."""
    from datetime import date

    from app.models import Card, Set

    sv1 = Set(id="sv1", name="Scarlet & Violet", series="SV", printed_total=198, total=258,
              release_date=date(2023, 3, 31))
    swsh1 = Set(id="swsh1", name="Sword & Shield", series="SWSH", printed_total=202, total=216,
                release_date=date(2020, 2, 7))
    cards = [
        Card(id="sv1-25", name="Pikachu", set_id="sv1", number="25", supertype="Pokémon",
             types=["Lightning"], rarity="Common", hp=60),
        Card(id="sv1-198", name="Miraidon ex", set_id="sv1", number="198", supertype="Pokémon",
             types=["Lightning"], rarity="Ultra Rare", hp=220),
        Card(id="swsh1-1", name="Celebi V", set_id="swsh1", number="1", supertype="Pokémon",
             types=["Grass"], rarity="Rare Holo V", hp=180),
    ]
    db.add_all([sv1, swsh1, *cards])
    await db.commit()
    return {"sets": ["sv1", "swsh1"], "cards": [c.id for c in cards]}


@pytest.fixture
async def auth_headers(client: AsyncClient) -> dict[str, str]:
    creds = {"email": "trainer@example.com", "password": "charizard-99"}
    resp = await client.post("/auth/register", json=creds)
    assert resp.status_code == 201, resp.text
    resp = await client.post("/auth/login", json=creds)
    assert resp.status_code == 200, resp.text
    return {"Authorization": f"Bearer {resp.json()['access_token']}"}
