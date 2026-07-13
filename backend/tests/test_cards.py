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
