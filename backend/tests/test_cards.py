from httpx import AsyncClient


async def test_list_cards_paginated(client: AsyncClient, seed_cards):
    resp = await client.get("/cards")
    assert resp.status_code == 200
    body = resp.json()
    assert body["total"] == 3
    assert len(body["items"]) == 3
    assert body["page"] == 1


async def test_list_cards_search_by_name(client: AsyncClient, seed_cards):
    resp = await client.get("/cards", params={"q": "pika"})
    assert resp.status_code == 200
    body = resp.json()
    assert body["total"] == 1
    assert body["items"][0]["name"] == "Pikachu"


async def test_list_cards_filter_by_set(client: AsyncClient, seed_cards):
    resp = await client.get("/cards", params={"set_id": "sv1"})
    assert resp.json()["total"] == 2


async def test_list_cards_filter_by_rarity(client: AsyncClient, seed_cards):
    resp = await client.get("/cards", params={"rarity": "Ultra Rare"})
    body = resp.json()
    assert body["total"] == 1
    assert body["items"][0]["id"] == "sv1-198"


async def test_list_cards_filter_by_type(client: AsyncClient, seed_cards):
    resp = await client.get("/cards", params={"type": "Grass"})
    body = resp.json()
    assert body["total"] == 1
    assert body["items"][0]["id"] == "swsh1-1"


async def test_list_cards_page_size(client: AsyncClient, seed_cards):
    resp = await client.get("/cards", params={"page_size": 2})
    body = resp.json()
    assert len(body["items"]) == 2
    assert body["total"] == 3
    resp2 = await client.get("/cards", params={"page_size": 2, "page": 2})
    assert len(resp2.json()["items"]) == 1


async def test_get_card_detail_includes_set(client: AsyncClient, seed_cards):
    resp = await client.get("/cards/sv1-25")
    assert resp.status_code == 200
    body = resp.json()
    assert body["name"] == "Pikachu"
    assert body["set"]["name"] == "Scarlet & Violet"


async def test_get_card_not_found(client: AsyncClient, seed_cards):
    resp = await client.get("/cards/does-not-exist")
    assert resp.status_code == 404


async def test_list_sets_ordered_by_release_desc(client: AsyncClient, seed_cards):
    resp = await client.get("/sets")
    assert resp.status_code == 200
    ids = [s["id"] for s in resp.json()]
    assert ids == ["sv1", "swsh1"]


async def test_get_set(client: AsyncClient, seed_cards):
    resp = await client.get("/sets/sv1")
    assert resp.status_code == 200
    assert resp.json()["name"] == "Scarlet & Violet"


async def test_get_set_not_found(client: AsyncClient):
    resp = await client.get("/sets/nope")
    assert resp.status_code == 404


async def _seed_prices(db):
    from datetime import date, timedelta

    from app.models import Price

    today = date.today()
    db.add_all([
        # two snapshots of the same source/variant — only the newest should
        # appear on the card detail
        Price(card_id="sv1-25", source="tcgplayer", variant="normal", date=today,
              currency="USD", low=1, mid=2, high=5, market=3),
        Price(card_id="sv1-25", source="tcgplayer", variant="normal",
              date=today - timedelta(days=1), currency="USD", low=1, mid=2, high=5, market=2),
        Price(card_id="sv1-25", source="tcgplayer", variant="holofoil", date=today,
              currency="USD", low=5, mid=8, high=20, market=9),
        Price(card_id="sv1-25", source="cardmarket", variant="default", date=today,
              currency="EUR", low=1, mid=2, high=None, market=2.5),
        # old snapshot outside a 30-day window
        Price(card_id="sv1-25", source="cardmarket", variant="default",
              date=today - timedelta(days=200), currency="EUR", low=9, mid=9, high=None, market=9),
    ])
    await db.commit()


async def test_card_detail_includes_latest_prices_only(client: AsyncClient, seed_cards, db):
    await _seed_prices(db)

    resp = await client.get("/cards/sv1-25")
    assert resp.status_code == 200
    prices = resp.json()["prices"]
    assert len(prices) == 3  # tcgplayer normal + holofoil, cardmarket default

    normal = next(p for p in prices if p["source"] == "tcgplayer" and p["variant"] == "normal")
    assert normal["market"] == 3.0  # today's snapshot, not yesterday's
    assert normal["currency"] == "USD"


async def test_card_detail_without_prices_has_empty_list(client: AsyncClient, seed_cards):
    resp = await client.get("/cards/sv1-25")
    assert resp.status_code == 200
    assert resp.json()["prices"] == []


async def test_price_history_window_and_order(client: AsyncClient, seed_cards, db):
    await _seed_prices(db)

    resp = await client.get("/cards/sv1-25/prices", params={"days": 30})
    assert resp.status_code == 200
    history = resp.json()
    assert len(history) == 4  # excludes the 200-day-old snapshot
    dates = [p["date"] for p in history]
    assert dates == sorted(dates)

    resp = await client.get("/cards/sv1-25/prices", params={"days": 365})
    assert len(resp.json()) == 5


async def test_price_history_unknown_card_404(client: AsyncClient, seed_cards):
    resp = await client.get("/cards/nope-1/prices")
    assert resp.status_code == 404
