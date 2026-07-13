"""Pure mapping from Pokémon TCG API payloads to our table rows (unit-tested offline)."""

from datetime import date, datetime
from typing import Any


def parse_release_date(raw: str | None) -> date | None:
    if not raw:
        return None
    try:
        return datetime.strptime(raw, "%Y/%m/%d").date()
    except ValueError:
        return None


def parse_hp(raw: Any) -> int | None:
    """API sends hp as a string; some cards have non-numeric values (e.g. 'None')."""
    try:
        return int(raw)
    except (TypeError, ValueError):
        return None


def set_row(payload: dict[str, Any]) -> dict[str, Any]:
    images = payload.get("images") or {}
    return {
        "id": payload["id"],
        "name": payload["name"],
        "series": payload.get("series"),
        "printed_total": payload.get("printedTotal"),
        "total": payload.get("total"),
        "release_date": parse_release_date(payload.get("releaseDate")),
        "symbol_url": images.get("symbol"),
        "logo_url": images.get("logo"),
    }


def price_rows(payload: dict[str, Any]) -> list[dict[str, Any]]:
    """Extract daily price snapshots from a card payload.

    TCGplayer publishes one block per printing variant (normal, holofoil, ...)
    in USD; Cardmarket publishes a single EUR block mapped to variant 'default'
    (low=lowPrice, mid=averageSellPrice, market=trendPrice).
    """
    card_id = payload["id"]
    rows: list[dict[str, Any]] = []

    tcgplayer = payload.get("tcgplayer") or {}
    tp_date = parse_release_date(tcgplayer.get("updatedAt"))
    if tp_date:
        for variant, p in (tcgplayer.get("prices") or {}).items():
            rows.append({
                "card_id": card_id,
                "source": "tcgplayer",
                "variant": variant,
                "date": tp_date,
                "currency": "USD",
                "low": p.get("low"),
                "mid": p.get("mid"),
                "high": p.get("high"),
                "market": p.get("market"),
            })

    cardmarket = payload.get("cardmarket") or {}
    cm_date = parse_release_date(cardmarket.get("updatedAt"))
    cm_prices = cardmarket.get("prices") or {}
    if cm_date and cm_prices:
        rows.append({
            "card_id": card_id,
            "source": "cardmarket",
            "variant": "default",
            "date": cm_date,
            "currency": "EUR",
            "low": cm_prices.get("lowPrice"),
            "mid": cm_prices.get("averageSellPrice"),
            "high": None,
            "market": cm_prices.get("trendPrice"),
        })
    return rows


def card_row(payload: dict[str, Any]) -> dict[str, Any]:
    images = payload.get("images") or {}
    return {
        "id": payload["id"],
        "name": payload["name"],
        "set_id": payload["set"]["id"],
        "number": payload.get("number"),
        "supertype": payload.get("supertype"),
        "subtypes": payload.get("subtypes"),
        "types": payload.get("types"),
        "rarity": payload.get("rarity"),
        "hp": parse_hp(payload.get("hp")),
        "artist": payload.get("artist"),
        "image_small_url": images.get("small"),
        "image_large_url": images.get("large"),
        "flavor_text": payload.get("flavorText"),
    }
