"""Grading pipeline tests over synthetic card photos (no network, no model)."""

import io

import cv2
import numpy as np
import pytest
from httpx import AsyncClient

from app.services import grading_service

BG = (35, 55, 35)  # dark table
BORDER = (0, 210, 255)  # pokemon-yellow (BGR)
ART = (120, 60, 20)  # dark inner frame


def make_card_photo(
    *,
    left: int = 40,
    right: int = 40,
    top: int = 55,
    bottom: int = 55,
    white_corner: bool = False,
    white_edges: bool = False,
) -> bytes:
    """Draw a card (600x840) centered on a dark background."""
    img = np.full((1000, 800, 3), BG, dtype=np.uint8)
    x0, y0, w, h = 100, 80, 600, 840
    cv2.rectangle(img, (x0, y0), (x0 + w, y0 + h), BORDER, -1)
    # inner art frame — asymmetric borders simulate off-center printing
    cv2.rectangle(
        img, (x0 + left, y0 + top), (x0 + w - right, y0 + h - bottom), ART, -1
    )
    if white_corner:
        cv2.rectangle(img, (x0, y0), (x0 + 34, y0 + 34), (255, 255, 255), -1)
    if white_edges:
        cv2.rectangle(img, (x0, y0), (x0 + w, y0 + 6), (255, 255, 255), -1)
        cv2.rectangle(img, (x0, y0 + h - 6), (x0 + w, y0 + h), (255, 255, 255), -1)
    ok, buf = cv2.imencode(".png", img)
    assert ok
    return buf.tobytes()


def test_perfect_card_scores_high():
    est = grading_service.grade_card(make_card_photo())
    assert est.centering >= 9
    assert est.corners >= 9
    assert est.edges >= 9
    assert est.overall >= 9


def test_off_center_card_scores_lower():
    perfect = grading_service.grade_card(make_card_photo())
    skewed = grading_service.grade_card(make_card_photo(left=15, right=65))
    assert skewed.centering < perfect.centering
    assert skewed.centering <= 6


def test_whitened_corner_lowers_corner_score():
    perfect = grading_service.grade_card(make_card_photo())
    damaged = grading_service.grade_card(make_card_photo(white_corner=True))
    assert damaged.corners < perfect.corners
    assert damaged.corners <= 5


def test_whitened_edges_lower_edge_score():
    perfect = grading_service.grade_card(make_card_photo())
    worn = grading_service.grade_card(make_card_photo(white_edges=True))
    assert worn.edges < perfect.edges


def test_no_card_in_photo_raises():
    img = np.full((600, 600, 3), BG, dtype=np.uint8)
    ok, buf = cv2.imencode(".png", img)
    assert ok
    with pytest.raises(grading_service.CardNotFoundError):
        grading_service.grade_card(buf.tobytes())


# --- /grade endpoint ---


async def test_grade_endpoint_carries_disclaimer(client: AsyncClient):
    resp = await client.post(
        "/grade", files={"file": ("card.png", io.BytesIO(make_card_photo()), "image/png")}
    )
    assert resp.status_code == 200, resp.text
    body = resp.json()
    assert body["experimental"] is True
    assert "NÃO é uma avaliação oficial" in body["disclaimer"]
    assert 1 <= body["estimated_grade"] <= 10
    assert set(body["sub_scores"]) == {"centering", "corners", "edges", "surface"}
    assert body["warnings"]


async def test_grade_endpoint_card_not_found_422(client: AsyncClient):
    img = np.full((400, 400, 3), BG, dtype=np.uint8)
    _, buf = cv2.imencode(".png", img)
    resp = await client.post(
        "/grade", files={"file": ("photo.png", io.BytesIO(buf.tobytes()), "image/png")}
    )
    assert resp.status_code == 422
    assert "enquadre" in resp.json()["detail"]


async def test_grade_endpoint_invalid_file_422(client: AsyncClient):
    resp = await client.post(
        "/grade", files={"file": ("x.png", io.BytesIO(b"not-an-image"), "image/png")}
    )
    assert resp.status_code == 422


async def test_grade_endpoint_empty_file_422(client: AsyncClient):
    # An empty upload makes cv2.imdecode raise cv2.error, not return None —
    # must still surface as a clean 422, never a 500.
    resp = await client.post(
        "/grade", files={"file": ("x.png", io.BytesIO(b""), "image/png")}
    )
    assert resp.status_code == 422


def test_decode_empty_buffer_raises_valueerror():
    with pytest.raises(ValueError):
        grading_service._decode(b"")
