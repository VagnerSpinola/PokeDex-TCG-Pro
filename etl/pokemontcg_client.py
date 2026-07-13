"""Thin client for the Pokémon TCG API (https://docs.pokemontcg.io).

Fetches sets and cards with pagination. An API key (free, https://dev.pokemontcg.io)
raises rate limits but is optional. Per AGENTS.md guardrails we store image URLs
only — no downloading/mirroring of image assets.
"""

import asyncio
from collections.abc import AsyncGenerator
from typing import Any

import httpx

BASE_URL = "https://api.pokemontcg.io/v2"
PAGE_SIZE = 250
MAX_RETRIES = 3


class PokemonTcgClient:
    def __init__(self, api_key: str = "") -> None:
        headers = {"X-Api-Key": api_key} if api_key else {}
        self._http = httpx.AsyncClient(base_url=BASE_URL, headers=headers, timeout=60)

    async def close(self) -> None:
        await self._http.aclose()

    async def _get(self, path: str, params: dict[str, Any]) -> dict[str, Any]:
        for attempt in range(1, MAX_RETRIES + 1):
            resp = await self._http.get(path, params=params)
            if resp.status_code == 429 and attempt < MAX_RETRIES:
                await asyncio.sleep(5 * attempt)  # basic backoff on rate limit
                continue
            resp.raise_for_status()
            return resp.json()
        raise RuntimeError("unreachable")

    async def iter_sets(self) -> AsyncGenerator[dict[str, Any], None]:
        page = 1
        while True:
            body = await self._get("/sets", {"page": page, "pageSize": PAGE_SIZE})
            for item in body.get("data", []):
                yield item
            if page * PAGE_SIZE >= body.get("totalCount", 0):
                return
            page += 1

    async def iter_cards(self, set_id: str | None = None) -> AsyncGenerator[dict[str, Any], None]:
        page = 1
        params: dict[str, Any] = {"pageSize": PAGE_SIZE}
        if set_id:
            params["q"] = f"set.id:{set_id}"
        while True:
            body = await self._get("/cards", {**params, "page": page})
            data = body.get("data", [])
            for item in data:
                yield item
            if page * PAGE_SIZE >= body.get("totalCount", 0) or not data:
                return
            page += 1
