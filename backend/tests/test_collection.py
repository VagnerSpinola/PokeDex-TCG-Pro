from httpx import AsyncClient


async def _add(client: AsyncClient, headers: dict, **overrides) -> dict:
    payload = {"card_id": "sv1-25", "quantity": 2, "condition": "near_mint", **overrides}
    resp = await client.post("/collection", json=payload, headers=headers)
    assert resp.status_code == 201, resp.text
    return resp.json()


async def test_collection_requires_auth(client: AsyncClient):
    assert (await client.get("/collection")).status_code == 401
    assert (await client.post("/collection", json={"card_id": "x"})).status_code == 401


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
