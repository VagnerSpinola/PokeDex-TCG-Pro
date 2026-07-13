import pytest
from httpx import AsyncClient

REGISTER = {"email": "ash@example.com", "password": "pikachu-123"}


async def _register(client: AsyncClient, **overrides) -> dict:
    resp = await client.post("/auth/register", json={**REGISTER, **overrides})
    assert resp.status_code == 201, resp.text
    return resp.json()


async def _login(client: AsyncClient) -> dict:
    resp = await client.post("/auth/login", json=REGISTER)
    assert resp.status_code == 200, resp.text
    return resp.json()


async def test_register_returns_user_without_password(client: AsyncClient):
    body = await _register(client)
    assert body["email"] == REGISTER["email"]
    assert body["role"] == "user"
    assert body["is_verified"] is False
    assert "password" not in body and "hashed_password" not in body


async def test_register_duplicate_email_conflicts(client: AsyncClient):
    await _register(client)
    resp = await client.post("/auth/register", json=REGISTER)
    assert resp.status_code == 409


async def test_register_rejects_short_password(client: AsyncClient):
    resp = await client.post(
        "/auth/register", json={"email": "misty@example.com", "password": "short"}
    )
    assert resp.status_code == 422


async def test_login_returns_token_pair(client: AsyncClient):
    await _register(client)
    tokens = await _login(client)
    assert tokens["token_type"] == "bearer"
    assert tokens["access_token"] and tokens["refresh_token"]


async def test_login_wrong_password_unauthorized(client: AsyncClient):
    await _register(client)
    resp = await client.post(
        "/auth/login", json={"email": REGISTER["email"], "password": "wrong-password"}
    )
    assert resp.status_code == 401


async def test_me_with_access_token(client: AsyncClient):
    await _register(client)
    tokens = await _login(client)
    resp = await client.get(
        "/auth/me", headers={"Authorization": f"Bearer {tokens['access_token']}"}
    )
    assert resp.status_code == 200
    assert resp.json()["email"] == REGISTER["email"]


async def test_me_without_token_unauthorized(client: AsyncClient):
    resp = await client.get("/auth/me")
    assert resp.status_code == 401


async def test_me_rejects_refresh_token(client: AsyncClient):
    await _register(client)
    tokens = await _login(client)
    resp = await client.get(
        "/auth/me", headers={"Authorization": f"Bearer {tokens['refresh_token']}"}
    )
    assert resp.status_code == 401


async def test_refresh_rotates_tokens(client: AsyncClient):
    await _register(client)
    tokens = await _login(client)
    resp = await client.post("/auth/refresh", json={"refresh_token": tokens["refresh_token"]})
    assert resp.status_code == 200
    assert resp.json()["access_token"]


async def test_refresh_rejects_access_token(client: AsyncClient):
    await _register(client)
    tokens = await _login(client)
    resp = await client.post("/auth/refresh", json={"refresh_token": tokens["access_token"]})
    assert resp.status_code == 401


async def test_refresh_rejects_garbage(client: AsyncClient):
    resp = await client.post("/auth/refresh", json={"refresh_token": "not-a-jwt"})
    assert resp.status_code == 401
