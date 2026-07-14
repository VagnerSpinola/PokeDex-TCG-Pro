"""Experimental AI grading assistant (phase 4).

Heuristic OpenCV pipeline — NOT a trained model and NOT an official grade
(AGENTS.md §2: outputs must always carry an "estimate only" disclaimer and
never be formatted as authoritative). The pipeline:

1. locate the card contour in the photo and warp it to a canonical rectangle;
2. score four real grading criteria on a 1-10 scale:
   - centering: left/right and top/bottom border-width symmetry,
   - corners:  whitening in the four corner patches,
   - edges:    whitening along the four edge strips,
   - surface:  specular highlights / texture anomalies (lowest confidence);
3. combine into a weighted overall estimate, rounded to 0.5.

Photo quality dominates the result — warnings surface the main caveats.
"""

from dataclasses import dataclass, field

import cv2
import numpy as np

DISCLAIMER = (
    "Estimativa experimental gerada por heurísticas de imagem — NÃO é uma "
    "avaliação oficial (PSA/BGS/CGC) e não deve ser usada como laudo. "
    "A qualidade da foto afeta fortemente o resultado."
)

CARD_W, CARD_H = 630, 880  # 63x88mm aspect
CORNER_PATCH = 56
EDGE_STRIP = 10

WEIGHTS = {"centering": 0.35, "corners": 0.25, "edges": 0.20, "surface": 0.20}


class CardNotFoundError(Exception):
    """The card outline could not be located in the photo."""


@dataclass
class GradeEstimate:
    centering: float
    corners: float
    edges: float
    surface: float
    overall: float
    warnings: list[str] = field(default_factory=list)


def _decode(image_bytes: bytes) -> np.ndarray:
    raw = np.frombuffer(image_bytes, dtype=np.uint8)
    # An empty/corrupt buffer makes imdecode raise cv2.error instead of
    # returning None — treat both as an invalid image.
    try:
        img = cv2.imdecode(raw, cv2.IMREAD_COLOR)
    except cv2.error:
        img = None
    if img is None:
        raise ValueError("could not decode image")
    scale = 1200 / max(img.shape[:2])
    if scale < 1:
        img = cv2.resize(img, None, fx=scale, fy=scale, interpolation=cv2.INTER_AREA)
    return img


def _find_card_quad(img: np.ndarray) -> np.ndarray:
    """Largest 4-point convex contour covering a plausible share of the photo."""
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    edges = cv2.Canny(blurred, 40, 120)
    edges = cv2.dilate(edges, np.ones((3, 3), np.uint8))
    contours, _ = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    img_area = img.shape[0] * img.shape[1]
    best = None
    best_area = 0.0
    for contour in contours:
        area = cv2.contourArea(contour)
        if area < 0.15 * img_area or area <= best_area:
            continue
        approx = cv2.approxPolyDP(contour, 0.02 * cv2.arcLength(contour, True), True)
        if len(approx) == 4 and cv2.isContourConvex(approx):
            best, best_area = approx.reshape(4, 2).astype(np.float32), area
    if best is None:
        raise CardNotFoundError
    return best


def _order_quad(quad: np.ndarray) -> np.ndarray:
    s = quad.sum(axis=1)
    d = np.diff(quad, axis=1).reshape(-1)
    return np.array(
        [quad[np.argmin(s)], quad[np.argmin(d)], quad[np.argmax(s)], quad[np.argmax(d)]],
        dtype=np.float32,
    )  # tl, tr, br, bl


def _warp(img: np.ndarray, quad: np.ndarray) -> np.ndarray:
    dst = np.array(
        [[0, 0], [CARD_W - 1, 0], [CARD_W - 1, CARD_H - 1], [0, CARD_H - 1]], dtype=np.float32
    )
    matrix = cv2.getPerspectiveTransform(_order_quad(quad), dst)
    return cv2.warpPerspective(img, matrix, (CARD_W, CARD_H))


def _border_widths(card: np.ndarray) -> tuple[float, float, float, float]:
    """Width of the outer border on each side via strong gradient scan.

    Scans inward from each side along the middle band and takes the first
    strong intensity edge as the inner-frame boundary.
    """
    gray = cv2.cvtColor(card, cv2.COLOR_BGR2GRAY).astype(np.float32)

    def first_edge(profile: np.ndarray, limit: int) -> float:
        # Skip the first pixels: the warp can leave a sliver of background whose
        # transition into the border would otherwise register as the frame edge.
        start = 5
        grad = np.abs(np.diff(profile[start:limit]))
        if grad.max() < 8:  # flat — no frame found, assume nominal border
            return limit / 2
        threshold = max(12.0, 0.5 * float(grad.max()))
        hits = np.nonzero(grad >= threshold)[0]
        return float(start + hits[0]) if len(hits) else limit / 2

    band_h = gray[CARD_H // 3 : 2 * CARD_H // 3, :].mean(axis=0)
    band_v = gray[:, CARD_W // 3 : 2 * CARD_W // 3].mean(axis=1)
    limit_w, limit_h = CARD_W // 4, CARD_H // 4

    left = first_edge(band_h, limit_w)
    right = first_edge(band_h[::-1], limit_w)
    top = first_edge(band_v, limit_h)
    bottom = first_edge(band_v[::-1], limit_h)
    return left, right, top, bottom


def _score_centering(card: np.ndarray) -> float:
    left, right, top, bottom = _border_widths(card)

    def ratio_score(a: float, b: float) -> float:
        if a + b == 0:
            return 5.0
        worst = max(a, b) / (a + b)  # 0.5 = perfect, 1.0 = fully off-center
        # 50/50 -> 10; 60/40 -> ~8; 70/30 -> ~6; 90/10 -> ~2
        return float(np.clip(10 - (worst - 0.5) * 20, 1, 10))

    return round(min(ratio_score(left, right), ratio_score(top, bottom)), 1)


def _whiteness(patch: np.ndarray) -> float:
    hsv = cv2.cvtColor(patch, cv2.COLOR_BGR2HSV)
    white = (hsv[:, :, 1] < 40) & (hsv[:, :, 2] > 200)
    return float(white.mean())


def _score_corners(card: np.ndarray) -> float:
    p = CORNER_PATCH
    patches = [card[:p, :p], card[:p, -p:], card[-p:, :p], card[-p:, -p:]]
    worst = max(_whiteness(patch) for patch in patches)
    # 0% white -> 10; 15% -> ~7; 40%+ -> heavy damage
    return round(float(np.clip(10 - worst * 22, 1, 10)), 1)


def _score_edges(card: np.ndarray) -> float:
    s = EDGE_STRIP
    strips = [card[:s, :], card[-s:, :], card[:, :s], card[:, -s:]]
    worst = max(_whiteness(strip) for strip in strips)
    return round(float(np.clip(10 - worst * 18, 1, 10)), 1)


def _score_surface(card: np.ndarray) -> float:
    hsv = cv2.cvtColor(card, cv2.COLOR_BGR2HSV)
    glare = float(((hsv[:, :, 2] > 250) & (hsv[:, :, 1] < 30)).mean())
    gray = cv2.cvtColor(card, cv2.COLOR_BGR2GRAY)
    lap_var = float(cv2.Laplacian(gray, cv2.CV_64F).var())
    blur_penalty = 1.5 if lap_var < 60 else 0.0  # out-of-focus photos hide defects
    return round(float(np.clip(10 - glare * 60 - blur_penalty, 1, 10)), 1)


def grade_card(image_bytes: bytes) -> GradeEstimate:
    img = _decode(image_bytes)
    quad = _find_card_quad(img)
    card = _warp(img, quad)

    centering = _score_centering(card)
    corners = _score_corners(card)
    edges = _score_edges(card)
    surface = _score_surface(card)
    overall = (
        WEIGHTS["centering"] * centering
        + WEIGHTS["corners"] * corners
        + WEIGHTS["edges"] * edges
        + WEIGHTS["surface"] * surface
    )
    # Real grading caps the overall near the worst criterion — stay conservative.
    overall = min(overall, min(centering, corners, edges, surface) + 2.0)
    overall = round(round(overall * 2) / 2, 1)  # 0.5 steps

    warnings = [
        "Análise de superfície tem baixa confiança em fotos com reflexo.",
    ]
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    if float(cv2.Laplacian(gray, cv2.CV_64F).var()) < 60:
        warnings.append("Foto possivelmente desfocada — a estimativa fica menos confiável.")

    return GradeEstimate(
        centering=centering,
        corners=corners,
        edges=edges,
        surface=surface,
        overall=overall,
        warnings=warnings,
    )
