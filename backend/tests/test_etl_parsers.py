"""Offline tests for the ETL payload → row mapping (no network)."""

import sys
from pathlib import Path

# etl/ lives at the repo root, one level above backend/.
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from datetime import date

from etl.parsers import card_row, parse_hp, parse_release_date, set_row

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
