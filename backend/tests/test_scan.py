import io

from httpx import AsyncClient

from app.routers.scan import get_scanner
from app.services.scan_service import RankedCandidate, rank_candidates


class FakeScanner:
    """Stands in for the real embedder+FAISS+OCR bundle."""

    def __init__(self, matches, ocr_text="", raises=None):
        self.matches = matches
        self.ocr_text = ocr_text
        self.raises = raises

    def match(self, image_bytes, k=5):
        if self.raises is not None:
            raise self.raises
        return self.matches, self.ocr_text

    def match_embedding(self, vector, k=5):
        return self.matches


def override_scanner(app, scanner):
    app.dependency_overrides[get_scanner] = lambda: scanner


# --- rank_candidates (pure logic) ---


def test_rank_orders_by_score():
    ranked = rank_candidates(
        [("a", 0.7), ("b", 0.95)], {"a": "Alpha", "b": "Beta"}, ocr_text=""
    )
    assert [c.card_id for c in ranked] == ["b", "a"]


def test_rank_confidence_thresholds():
    ranked = rank_candidates(
        [("hi", 0.95), ("mid", 0.85), ("lo", 0.5)],
        {"hi": "A", "mid": "B", "lo": "C"},
        ocr_text="",
    )
    by_id = {c.card_id: c.confidence for c in ranked}
    assert by_id == {"hi": "high", "mid": "medium", "lo": "low"}


def test_rank_ocr_boost_promotes_named_card():
    ranked = rank_candidates(
        [("x", 0.86), ("pika", 0.82)],
        {"x": "Mewtwo", "pika": "Pikachu"},
        ocr_text="PIKACHU 60 HP basic pokemon",
    )
    assert ranked[0].card_id == "pika"
    assert ranked[0].score == 0.94
    assert ranked[0].confidence == "high"


def test_rank_boost_capped_at_one():
    ranked = rank_candidates([("a", 0.95)], {"a": "Ho-Oh"}, ocr_text="ho-oh")
    assert ranked[0].score == 1.0


# --- /scan endpoints ---


async def _post_scan(client: AsyncClient) -> dict:
    resp = await client.post(
        "/scan", files={"file": ("card.jpg", io.BytesIO(b"fake-image"), "image/jpeg")}
    )
    assert resp.status_code == 200, resp.text
    return resp.json()


async def test_scan_returns_candidates_for_confirmation(client: AsyncClient, seed_cards):
    from app.main import app

    override_scanner(app, FakeScanner([("sv1-25", 0.93), ("sv1-198", 0.6)]))
    body = await _post_scan(client)

    assert [c["card"]["id"] for c in body["candidates"]] == ["sv1-25", "sv1-198"]
    assert body["candidates"][0]["confidence"] == "high"
    assert body["low_confidence"] is False
    assert "confirme" in body["disclaimer"]


async def test_scan_low_confidence_flags_manual_correction(client: AsyncClient, seed_cards):
    from app.main import app

    override_scanner(app, FakeScanner([("sv1-25", 0.55)]))
    body = await _post_scan(client)

    assert body["low_confidence"] is True
    assert body["candidates"][0]["confidence"] == "low"


async def test_scan_ocr_name_guess(client: AsyncClient, seed_cards):
    from app.main import app

    override_scanner(app, FakeScanner([("sv1-25", 0.82)], ocr_text="Pikachu 60 HP"))
    body = await _post_scan(client)

    assert body["name_guess"] == "Pikachu"
    assert body["candidates"][0]["confidence"] == "high"  # 0.82 + boost


async def test_scan_no_matches_is_low_confidence(client: AsyncClient, seed_cards):
    from app.main import app

    override_scanner(app, FakeScanner([]))
    body = await _post_scan(client)
    assert body["candidates"] == []
    assert body["low_confidence"] is True


async def test_scan_by_embedding(client: AsyncClient, seed_cards):
    from app.main import app

    override_scanner(app, FakeScanner([("swsh1-1", 0.91)]))
    resp = await client.post("/scan/embedding", json={"embedding": [0.1] * 16})
    assert resp.status_code == 200
    body = resp.json()
    assert body["candidates"][0]["card"]["id"] == "swsh1-1"


async def test_scan_invalid_image_422(client: AsyncClient, seed_cards):
    from app.main import app

    override_scanner(app, FakeScanner([], raises=ValueError("could not decode image")))
    resp = await client.post(
        "/scan", files={"file": ("bad.jpg", io.BytesIO(b""), "image/jpeg")}
    )
    assert resp.status_code == 422


async def test_scan_503_when_index_missing(client: AsyncClient, monkeypatch):
    from app.services import scan_service

    def boom():
        raise scan_service.IndexNotBuiltError("not built")

    monkeypatch.setattr(scan_service, "get_scanner", boom)
    resp = await client.post(
        "/scan", files={"file": ("card.jpg", io.BytesIO(b"x"), "image/jpeg")}
    )
    assert resp.status_code == 503
