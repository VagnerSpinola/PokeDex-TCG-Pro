"""Grading v2 tests over synthetic card photos/videos (no network, no model)."""

import io

import cv2
import numpy as np
import pytest
from httpx import AsyncClient

from app.services import grading_service
from app.services.grading_service import centering_cap

BG = (35, 55, 35)  # dark table
BORDER = (0, 210, 255)  # pokemon-yellow (BGR)
ART = (120, 60, 20)  # dark inner frame


def make_card_img(
    *,
    left: int = 40,
    right: int = 40,
    top: int = 55,
    bottom: int = 55,
    white_corner: bool = False,
    white_edges: bool = False,
    crease: bool = False,
    print_line: bool = False,
    blur: bool = False,
    shift: tuple[int, int] = (0, 0),
) -> np.ndarray:
    img = np.full((1000, 800, 3), BG, dtype=np.uint8)
    x0, y0, w, h = 100 + shift[0], 80 + shift[1], 600, 840
    cv2.rectangle(img, (x0, y0), (x0 + w, y0 + h), BORDER, -1)
    cv2.rectangle(img, (x0 + left, y0 + top), (x0 + w - right, y0 + h - bottom), ART, -1)
    if white_corner:
        cv2.rectangle(img, (x0, y0), (x0 + 40, y0 + 40), (255, 255, 255), -1)
    if white_edges:
        cv2.rectangle(img, (x0, y0), (x0 + w, y0 + 7), (255, 255, 255), -1)
        cv2.rectangle(img, (x0, y0 + h - 7), (x0 + w, y0 + h), (255, 255, 255), -1)
    if crease:
        # diagonal bright ridge across the artwork
        cv2.line(img, (x0 + 90, y0 + 150), (x0 + w - 90, y0 + h - 150), (230, 230, 235), 3)
    if print_line:
        # razor-straight vertical line across the artwork
        cv2.line(img, (x0 + w // 2, y0 + top + 5), (x0 + w // 2, y0 + h - bottom - 5),
                 (250, 250, 250), 2)
    if blur:
        img = cv2.GaussianBlur(img, (17, 17), 0)
    return img


def make_card_photo(**kw) -> bytes:
    ok, buf = cv2.imencode(".png", make_card_img(**kw))
    assert ok
    return buf.tobytes()


# --- PSA centering caps (pure rulebook) ---


def test_front_centering_caps_follow_psa_table():
    assert centering_cap(0.55) == 10
    assert centering_cap(0.58) == 9
    assert centering_cap(0.63) == 8
    assert centering_cap(0.69) == 7
    assert centering_cap(0.74) == 6
    assert centering_cap(0.79) == 5
    assert centering_cap(0.84) == 4
    assert centering_cap(0.89) == 3
    assert centering_cap(0.95) == 2


def test_back_centering_is_one_band_looser():
    assert centering_cap(0.58, back=True) == 10
    assert centering_cap(0.63, back=True) == 9


# --- photo pipeline ---


def test_perfect_card_scores_high_with_narrow_range():
    r = grading_service.grade_card(make_card_photo())
    assert r.estimated_grade >= 9
    assert r.quality.ok, r.quality.issues
    assert r.grade_max - r.grade_min <= 1.0
    assert r.centering.left_right in ("50/50", "51/49", "49/51")


def test_off_center_card_capped_by_psa_table():
    # 15/65 -> worst share 0.8125 -> PSA cap 4
    r = grading_service.grade_card(make_card_photo(left=15, right=65))
    assert r.centering.cap == 4
    assert r.estimated_grade <= 4


def test_whitened_corner_reported_per_corner():
    r = grading_service.grade_card(make_card_photo(white_corner=True))
    by_name = {c.corner: c for c in r.corners}
    assert by_name["top_left"].score < by_name["bottom_right"].score
    assert by_name["top_left"].whitening_pct > 0.2


def test_whitened_edges_lower_edge_scores():
    perfect = grading_service.grade_card(make_card_photo())
    worn = grading_service.grade_card(make_card_photo(white_edges=True))
    assert min(e.score for e in worn.edges) < min(e.score for e in perfect.edges)


def test_crease_caps_grade_at_six():
    r = grading_service.grade_card(make_card_photo(crease=True))
    assert r.surface.crease_detected
    assert r.estimated_grade <= grading_service.LIGHT_CREASE_CAP


def test_print_line_caps_surface_at_nine():
    r = grading_service.grade_card(make_card_photo(print_line=True))
    assert r.surface.print_line
    assert r.surface.score <= grading_service.PRINT_LINE_CAP


def test_blurry_photo_fails_quality_and_widens_range():
    r = grading_service.grade_card(make_card_photo(blur=True))
    assert not r.quality.ok
    assert any("desfocada" in i for i in r.quality.issues)
    # poor quality widens the band by 1.5 on each side (clamped to [1, 10])
    assert r.grade_min <= r.estimated_grade - 1.5


def test_back_photo_can_lower_the_estimate():
    front = make_card_photo()
    bad_back = make_card_photo(left=10, right=70)  # heavy off-center back
    solo = grading_service.grade_card(front)
    with_back = grading_service.grade_card(front, bad_back)
    assert with_back.estimated_grade < solo.estimated_grade


def test_no_card_in_photo_raises():
    img = np.full((700, 700, 3), BG, dtype=np.uint8)
    ok, buf = cv2.imencode(".png", img)
    assert ok
    with pytest.raises(grading_service.CardNotFoundError):
        grading_service.grade_card(buf.tobytes())


# --- video pipeline ---


def _write_video(path: str, *, frames: int, size=(800, 1000), fps=10, **card_kw) -> None:
    writer = cv2.VideoWriter(path, cv2.VideoWriter_fourcc(*"mp4v"), fps, size)
    assert writer.isOpened()
    for i in range(frames):
        writer.write(make_card_img(shift=((i % 5) - 2, (i % 3) - 1), **card_kw))
    writer.release()


def test_video_grades_with_frame_consensus(tmp_path):
    path = str(tmp_path / "card.mp4")
    _write_video(path, frames=30)  # 3s at 10fps
    r = grading_service.grade_video(path)
    assert r.frames_analyzed >= grading_service.MIN_USABLE_FRAMES
    assert r.estimated_grade >= 9


def test_video_too_short_rejected(tmp_path):
    path = str(tmp_path / "short.mp4")
    _write_video(path, frames=10)  # 1s
    with pytest.raises(grading_service.VideoTooPoorError):
        grading_service.grade_video(path)


def test_video_low_resolution_rejected(tmp_path):
    path = str(tmp_path / "small.mp4")
    writer = cv2.VideoWriter(path, cv2.VideoWriter_fourcc(*"mp4v"), 10, (400, 500))
    assert writer.isOpened()
    small = cv2.resize(make_card_img(), (400, 500))
    for _ in range(30):
        writer.write(small)
    writer.release()
    with pytest.raises(grading_service.VideoTooPoorError):
        grading_service.grade_video(path)


# --- endpoints ---


async def test_grade_endpoint_full_report(client: AsyncClient):
    resp = await client.post(
        "/grade", files={"file": ("card.png", io.BytesIO(make_card_photo()), "image/png")}
    )
    assert resp.status_code == 200, resp.text
    body = resp.json()
    assert body["experimental"] is True
    assert "NÃO é uma avaliação oficial" in body["disclaimer"]
    assert len(body["grade_range"]) == 2
    assert body["grade_range"][0] <= body["estimated_grade"] <= body["grade_range"][1]
    assert body["centering"]["left_right"]
    assert len(body["corners"]) == 4
    assert len(body["edges"]) == 4
    assert body["quality"]["ok"] is True


async def test_grade_endpoint_with_back_photo(client: AsyncClient):
    resp = await client.post(
        "/grade",
        files={
            "file": ("front.png", io.BytesIO(make_card_photo()), "image/png"),
            "back": ("back.png", io.BytesIO(make_card_photo(left=10, right=70)), "image/png"),
        },
    )
    assert resp.status_code == 200
    assert any("verso" in w for w in resp.json()["warnings"])


async def test_grade_video_endpoint(client: AsyncClient, tmp_path):
    path = tmp_path / "clip.mp4"
    _write_video(str(path), frames=30)
    resp = await client.post(
        "/grade/video",
        files={"file": ("clip.mp4", io.BytesIO(path.read_bytes()), "video/mp4")},
    )
    assert resp.status_code == 200, resp.text
    body = resp.json()
    assert body["frames_analyzed"] >= 3
    assert any("quadros do vídeo" in w for w in body["warnings"])


async def test_grade_video_endpoint_rejects_short(client: AsyncClient, tmp_path):
    path = tmp_path / "short.mp4"
    _write_video(str(path), frames=10)
    resp = await client.post(
        "/grade/video",
        files={"file": ("short.mp4", io.BytesIO(path.read_bytes()), "video/mp4")},
    )
    assert resp.status_code == 422


async def test_grade_endpoint_card_not_found_422(client: AsyncClient):
    img = np.full((500, 500, 3), BG, dtype=np.uint8)
    _, buf = cv2.imencode(".png", img)
    resp = await client.post(
        "/grade", files={"file": ("photo.png", io.BytesIO(buf.tobytes()), "image/png")}
    )
    assert resp.status_code == 422
    assert "Enquadre" in resp.json()["detail"]


async def test_grade_endpoint_invalid_and_empty_file_422(client: AsyncClient):
    for payload in (b"not-an-image", b""):
        resp = await client.post(
            "/grade", files={"file": ("x.png", io.BytesIO(payload), "image/png")}
        )
        assert resp.status_code == 422
