from httpx import AsyncClient


async def _add(client: AsyncClient, headers: dict, **overrides) -> dict:
    payload = {"card_id": "sv1-25", "quantity": 2, "condition": "near_mint", **overrides}
    resp = await client.post("/collection", json=payload, headers=headers)
    assert resp.status_code == 201, resp.text
    return resp.json()


async def test_collection_works_without_token_as_default_user(client: AsyncClient, seed_cards):
    """Auth is out of the app flow for now: anonymous requests share a local user."""
    resp = await client.get("/collection")
    assert resp.status_code == 200
    assert resp.json()["total"] == 0

    resp = await client.post("/collection", json={"card_id": "sv1-25", "quantity": 1})
    assert resp.status_code == 201

    resp = await client.get("/collection")
    assert resp.json()["total"] == 1


async def test_invalid_token_still_rejected(client: AsyncClient):
    resp = await client.get("/collection", headers={"Authorization": "Bearer not-a-jwt"})
    assert resp.status_code == 401


async def test_anonymous_and_logged_user_collections_are_separate(
    client: AsyncClient, seed_cards, auth_headers
):
    await client.post("/collection", json={"card_id": "sv1-25", "quantity": 1})
    await _add(client, auth_headers, card_id="swsh1-1")

    anon = await client.get("/collection")
    logged = await client.get("/collection", headers=auth_headers)
    assert anon.json()["total"] == 1
    assert logged.json()["total"] == 1
    assert anon.json()["items"][0]["card_id"] == "sv1-25"
    assert logged.json()["items"][0]["card_id"] == "swsh1-1"


async def test_add_and_list_item(client: AsyncClient, seed_cards, auth_headers):
    item = await _add(client, auth_headers)
    assert item["quantity"] == 2
    assert item["card"]["name"] == "Pikachu"

    resp = await client.get("/collection", headers=auth_headers)
    body = resp.json()
    assert body["total"] == 1
    assert body["items"][0]["card_id"] == "sv1-25"


async def test_add_same_card_condition_sums_quantity(client: AsyncClient, seed_cards, auth_headers):
    await _add(client, auth_headers, quantity=2)
    item = await _add(client, auth_headers, quantity=3)
    assert item["quantity"] == 5

    resp = await client.get("/collection", headers=auth_headers)
    assert resp.json()["total"] == 1  # still one row


async def test_add_same_card_other_condition_new_row(client: AsyncClient, seed_cards, auth_headers):
    await _add(client, auth_headers, condition="near_mint")
    await _add(client, auth_headers, condition="played")
    resp = await client.get("/collection", headers=auth_headers)
    assert resp.json()["total"] == 2


async def test_add_unknown_card_404(client: AsyncClient, seed_cards, auth_headers):
    resp = await client.post(
        "/collection", json={"card_id": "nope-1"}, headers=auth_headers
    )
    assert resp.status_code == 404


async def test_update_item(client: AsyncClient, seed_cards, auth_headers):
    item = await _add(client, auth_headers)
    resp = await client.patch(
        f"/collection/{item['id']}",
        json={"quantity": 7, "condition": "excellent", "notes": "binder A"},
        headers=auth_headers,
    )
    assert resp.status_code == 200
    body = resp.json()
    assert (body["quantity"], body["condition"], body["notes"]) == (7, "excellent", "binder A")


async def test_delete_item(client: AsyncClient, seed_cards, auth_headers):
    item = await _add(client, auth_headers)
    resp = await client.delete(f"/collection/{item['id']}", headers=auth_headers)
    assert resp.status_code == 204
    resp = await client.get("/collection", headers=auth_headers)
    assert resp.json()["total"] == 0


async def test_cannot_touch_other_users_item(client: AsyncClient, seed_cards, auth_headers):
    item = await _add(client, auth_headers)

    other = {"email": "gary@example.com", "password": "eevee-1234"}
    assert (await client.post("/auth/register", json=other)).status_code == 201
    login = await client.post("/auth/login", json=other)
    other_headers = {"Authorization": f"Bearer {login.json()['access_token']}"}

    patch = await client.patch(
        f"/collection/{item['id']}", json={"quantity": 99}, headers=other_headers
    )
    assert patch.status_code == 404
    delete = await client.delete(f"/collection/{item['id']}", headers=other_headers)
    assert delete.status_code == 404


async def test_stats(client: AsyncClient, seed_cards, auth_headers):
    await _add(client, auth_headers, card_id="sv1-25", quantity=2)
    await _add(client, auth_headers, card_id="sv1-198", quantity=1)
    await _add(client, auth_headers, card_id="swsh1-1", quantity=4)

    resp = await client.get("/collection/stats", headers=auth_headers)
    assert resp.status_code == 200
    body = resp.json()
    assert body["total_cards"] == 7
    assert body["unique_cards"] == 3
    by_set = {s["set_id"]: s["count"] for s in body["sets"]}
    assert by_set == {"sv1": 3, "swsh1": 4}
    assert body["value_usd"] is None  # no price data seeded
    assert body["value_eur"] is None


async def test_stats_estimated_value(client: AsyncClient, seed_cards, auth_headers, db):
    from datetime import date, timedelta

    from app.models import Price

    today = date.today()
    db.add_all([
        # sv1-25: two variants today -> cheapest (2.00) wins; older snapshot ignored
        Price(card_id="sv1-25", source="tcgplayer", variant="normal", date=today,
              currency="USD", low=1, mid=3, high=5, market=2),
        Price(card_id="sv1-25", source="tcgplayer", variant="holofoil", date=today,
              currency="USD", low=8, mid=12, high=30, market=10),
        Price(card_id="sv1-25", source="tcgplayer", variant="normal",
              date=today - timedelta(days=5), currency="USD", low=1, mid=3, high=5, market=99),
        # cardmarket EUR view; market missing -> falls back to mid
        Price(card_id="sv1-25", source="cardmarket", variant="default", date=today,
              currency="EUR", low=1, mid=1.5, high=None, market=None),
        # swsh1-1 only on tcgplayer
        Price(card_id="swsh1-1", source="tcgplayer", variant="holofoil", date=today,
              currency="USD", low=3, mid=5, high=9, market=4),
    ])
    await db.commit()

    await _add(client, auth_headers, card_id="sv1-25", quantity=2)
    await _add(client, auth_headers, card_id="swsh1-1", quantity=3)
    await _add(client, auth_headers, card_id="sv1-198", quantity=1)  # sem preço

    resp = await client.get("/collection/stats", headers=auth_headers)
    body = resp.json()
    # USD: 2 x 2.00 (sv1-25 cheapest variant) + 3 x 4.00 (swsh1-1) = 16.00
    assert body["value_usd"] == 16.0
    # EUR: 2 x 1.50 (mid fallback) = 3.00
    assert body["value_eur"] == 3.0
