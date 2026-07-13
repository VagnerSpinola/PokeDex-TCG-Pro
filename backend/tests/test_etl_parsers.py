"""Offline tests for the ETL payload → row mapping (no network)."""

import sys
from pathlib import Path

# etl/ lives at the repo root, one level above backend/.
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from datetime import date

from etl.parsers import card_row, parse_hp, parse_release_date, price_rows, set_row

SET_PAYLOAD = {
    "id": "sv1",
    "name": "Scarlet & Violet",
    "series": "Scarlet & Violet",
    "printedTotal": 198,
    "total": 258,
    "releaseDate": "2023/03/31",
    "images": {
        "symbol": "https://images.pokemontcg.io/sv1/symbol.png",
        "logo": "https://images.pokemontcg.io/sv1/logo.png",
    },
}

CARD_PAYLOAD = {
    "id": "sv1-25",
    "name": "Pikachu",
    "supertype": "Pokémon",
    "subtypes": ["Basic"],
    "hp": "60",
    "types": ["Lightning"],
    "number": "25",
    "artist": "Ken Sugimori",
    "rarity": "Common",
    "flavorText": "It stores electricity in its cheeks.",
    "set": {"id": "sv1", "name": "Scarlet & Violet"},
    "images": {
        "small": "https://images.pokemontcg.io/sv1/25.png",
        "large": "https://images.pokemontcg.io/sv1/25_hires.png",
    },
}


def test_set_row_maps_fields():
    row = set_row(SET_PAYLOAD)
    assert row == {
        "id": "sv1",
        "name": "Scarlet & Violet",
        "series": "Scarlet & Violet",
        "printed_total": 198,
        "total": 258,
        "release_date": date(2023, 3, 31),
        "symbol_url": "https://images.pokemontcg.io/sv1/symbol.png",
        "logo_url": "https://images.pokemontcg.io/sv1/logo.png",
    }


def test_set_row_tolerates_missing_optionals():
    row = set_row({"id": "x", "name": "X"})
    assert row["release_date"] is None
    assert row["symbol_url"] is None


def test_card_row_maps_fields():
    row = card_row(CARD_PAYLOAD)
    assert row["id"] == "sv1-25"
    assert row["set_id"] == "sv1"
    assert row["hp"] == 60
    assert row["types"] == ["Lightning"]
    assert row["image_large_url"].endswith("25_hires.png")
    assert row["flavor_text"].startswith("It stores")


def test_card_row_tolerates_missing_optionals():
    row = card_row({"id": "x-1", "name": "X", "set": {"id": "x"}})
    assert row["hp"] is None
    assert row["types"] is None
    assert row["image_small_url"] is None


def test_parse_hp_non_numeric():
    assert parse_hp("None") is None
    assert parse_hp(None) is None
    assert parse_hp("120") == 120


def test_parse_release_date_bad_format():
    assert parse_release_date("31-03-2023") is None
    assert parse_release_date(None) is None


PRICED_CARD = {
    **CARD_PAYLOAD,
    "tcgplayer": {
        "url": "https://prices.pokemontcg.io/tcgplayer/sv1-25",
        "updatedAt": "2026/07/12",
        "prices": {
            "normal": {"low": 0.02, "mid": 0.08, "high": 1.0, "market": 0.05},
            "reverseHolofoil": {"low": 0.05, "mid": 0.2, "high": 2.0, "market": 0.15},
        },
    },
    "cardmarket": {
        "url": "https://prices.pokemontcg.io/cardmarket/sv1-25",
        "updatedAt": "2026/07/13",
        "prices": {"lowPrice": 0.02, "averageSellPrice": 0.09, "trendPrice": 0.07},
    },
}


def test_price_rows_maps_both_sources():
    rows = price_rows(PRICED_CARD)
    assert len(rows) == 3

    tp = {r["variant"]: r for r in rows if r["source"] == "tcgplayer"}
    assert set(tp) == {"normal", "reverseHolofoil"}
    assert tp["normal"]["date"] == date(2026, 7, 12)
    assert tp["normal"]["currency"] == "USD"
    assert tp["normal"]["market"] == 0.05

    (cm,) = [r for r in rows if r["source"] == "cardmarket"]
    assert cm["variant"] == "default"
    assert cm["date"] == date(2026, 7, 13)
    assert cm["currency"] == "EUR"
    assert (cm["low"], cm["mid"], cm["market"]) == (0.02, 0.09, 0.07)


def test_price_rows_card_without_prices():
    assert price_rows(CARD_PAYLOAD) == []


def test_price_rows_ignores_blocks_without_date():
    payload = {**CARD_PAYLOAD, "tcgplayer": {"prices": {"normal": {"market": 1.0}}}}
    assert price_rows(payload) == []
