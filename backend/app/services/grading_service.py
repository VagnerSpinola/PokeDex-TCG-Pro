"""Experimental AI grading assistant v2 — PSA-rulebook CV pipeline (phase 4).

Pixel-level OpenCV analysis structured after PSA's PUBLISHED standards:

- centering caps per grade (front: 55/45→10, 60/40→9, 65/35→8, 70/30→7,
  75/25→6, 80/20→5, 85/15→4, 90/10→3, worse→2; back one band looser);
  the WORST axis is the ceiling;
- per-corner and per-edge whitening analysis (worst corner dominates);
- surface: glare, scratch/crease evidence, print-line heuristic (print line
  caps modern cards at 9; a light crease caps ~6, severe ~3);
- the FINAL grade is limited by the LOWEST sub-grade (PSA rule);
- photo quality gates (sharpness, glare budget, card resolution) modeled on
  pro guidance: diffuse 45°/45° lighting, 5000–6500K, no glare;
- video: multiple frames under a moving angle — defects that persist across
  frames are real, glare that moves is not.

Honesty guardrails (AGENTS.md §2): this is NOT a trained model and NOT an
official grade. Every response carries the disclaimer; results are a range,
never an authoritative point. Crease detection is tuned to under-report
(false negatives) rather than invent damage on busy card art.
"""

from dataclasses import dataclass, field

import cv2
import numpy as np

DISCLAIMER = (
    "Estimativa experimental por visão computacional seguindo os padrões "
    "publicados da PSA — NÃO é uma avaliação oficial (PSA/BGS/CGC) e não deve "
    "ser usada como laudo. Qualidade da foto afeta fortemente o resultado."
)

CARD_W, CARD_H = 744, 1040  # ~2x v1: enough pixels for corner/edge forensics
CORNER_PATCH = 66
EDGE_STRIP = 12

MIN_SHARPNESS = 80.0  # Laplacian variance on the warped card
MAX_GLARE_PCT = 0.06
MIN_CARD_SRC_HEIGHT = 600  # px of the card in the ORIGINAL photo

# (worst-axis share ceiling, grade cap) — front of the card, per PSA.
FRONT_CENTERING_CAPS = [
    (0.55, 10.0), (0.60, 9.0), (0.65, 8.0), (0.70, 7.0),
    (0.75, 6.0), (0.80, 5.0), (0.85, 4.0), (0.90, 3.0),
]
# Back is one band more forgiving.
BACK_CENTERING_CAPS = [
    (0.60, 10.0), (0.65, 9.0), (0.70, 8.0), (0.75, 7.0),
    (0.80, 6.0), (0.85, 5.0), (0.90, 4.0), (0.95, 3.0),
]

LIGHT_CREASE_CAP = 6.0   # "even a light crease usually caps at PSA 6"
SEVERE_CREASE_CAP = 3.0
PRINT_LINE_CAP = 9.0


class CardNotFoundError(Exception):
    """The card outline could not be located in the photo."""


class VideoTooPoorError(Exception):
    """The video does not meet the minimum quality requirements."""

    def __init__(self, reason: str) -> None:
        super().__init__(reason)
        self.reason = reason


# --------------------------------------------------------------------------
# report dataclasses
# --------------------------------------------------------------------------


@dataclass
class QualityReport:
    ok: bool
    sharpness: float
    glare_pct: float
    card_src_height: int
    issues: list[str] = field(default_factory=list)


@dataclass
class CenteringReport:
    left_right: str          # e.g. "57/43"
    top_bottom: str
    worst_share: float       # 0.5 = perfect
    cap: float               # PSA grade ceiling from centering alone
    score: float


@dataclass
class CornerReport:
    corner: str              # top_left | top_right | bottom_left | bottom_right
    whitening_pct: float
    score: float


@dataclass
class EdgeReport:
    edge: str                # top | bottom | left | right
    whitening_pct: float
    clustered: bool          # chipping-like (worse than uniform wear)
    score: float


@dataclass
class SurfaceReport:
    glare_pct: float
    scratch_index: float
    crease_detected: bool
    severe_crease: bool
    print_line: bool
    score: float


@dataclass
class GradeReport:
    estimated_grade: float
    grade_min: float
    grade_max: float
    centering: CenteringReport
    corners: list[CornerReport]
    edges: list[EdgeReport]
    surface: SurfaceReport
    quality: QualityReport
    warnings: list[str]
    frames_analyzed: int = 1


# --------------------------------------------------------------------------
# geometry
# --------------------------------------------------------------------------


def _decode(image_bytes: bytes) -> np.ndarray:
    raw = np.frombuffer(image_bytes, dtype=np.uint8)
    try:
        img = cv2.imdecode(raw, cv2.IMREAD_COLOR)
    except cv2.error:
        img = None
    if img is None:
        raise ValueError("could not decode image")
    scale = 1600 / max(img.shape[:2])
    if scale < 1:
        img = cv2.resize(img, None, fx=scale, fy=scale, interpolation=cv2.INTER_AREA)
    return img


def _find_card_quad(img: np.ndarray) -> np.ndarray:
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    edges = cv2.Canny(blurred, 40, 120)
    edges = cv2.dilate(edges, np.ones((3, 3), np.uint8))
    contours, _ = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    img_area = img.shape[0] * img.shape[1]
    best, best_area = None, 0.0
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
    )


def _warp(img: np.ndarray, quad: np.ndarray) -> np.ndarray:
    dst = np.array(
        [[0, 0], [CARD_W - 1, 0], [CARD_W - 1, CARD_H - 1], [0, CARD_H - 1]],
        dtype=np.float32,
    )
    matrix = cv2.getPerspectiveTransform(_order_quad(quad), dst)
    return cv2.warpPerspective(img, matrix, (CARD_W, CARD_H))


def _quad_height(quad: np.ndarray) -> int:
    q = _order_quad(quad)
    return int(max(np.linalg.norm(q[3] - q[0]), np.linalg.norm(q[2] - q[1])))


# --------------------------------------------------------------------------
# quality gates (photo standards: sharp, diffuse light, no glare)
# --------------------------------------------------------------------------


def _glare_pct(card: np.ndarray) -> float:
    hsv = cv2.cvtColor(card, cv2.COLOR_BGR2HSV)
    return float(((hsv[:, :, 2] > 250) & (hsv[:, :, 1] < 30)).mean())


def assess_quality(card: np.ndarray, card_src_height: int) -> QualityReport:
    gray = cv2.cvtColor(card, cv2.COLOR_BGR2GRAY)
    sharpness = float(cv2.Laplacian(gray, cv2.CV_64F).var())
    glare = _glare_pct(card)

    issues: list[str] = []
    if sharpness < MIN_SHARPNESS:
        issues.append(
            "Foto desfocada — apoie o celular e toque na carta para focar antes de fotografar."
        )
    if glare > MAX_GLARE_PCT:
        issues.append(
            "Reflexo forte na carta — use luz difusa em ângulo de 45° dos dois lados "
            "(nunca luz direta de cima) e evite flash."
        )
    if card_src_height < MIN_CARD_SRC_HEIGHT:
        issues.append(
            "Carta pequena no enquadramento — aproxime a câmera até a carta ocupar "
            "a maior parte da foto."
        )
    return QualityReport(
        ok=not issues,
        sharpness=round(sharpness, 1),
        glare_pct=round(glare, 4),
        card_src_height=card_src_height,
        issues=issues,
    )


# --------------------------------------------------------------------------
# centering (PSA caps, worst axis rules)
# --------------------------------------------------------------------------


def _border_widths(card: np.ndarray) -> tuple[float, float, float, float]:
    """Median border width per side, scanned over five bands for robustness."""
    gray = cv2.cvtColor(card, cv2.COLOR_BGR2GRAY).astype(np.float32)

    def first_edge(profile: np.ndarray, limit: int) -> float | None:
        start = 6
        grad = np.abs(np.diff(profile[start:limit]))
        if grad.max() < 8:
            return None
        threshold = max(12.0, 0.5 * float(grad.max()))
        hits = np.nonzero(grad >= threshold)[0]
        return float(start + hits[0]) if len(hits) else None

    def side_width(horizontal: bool, from_end: bool) -> float:
        limit = (CARD_W if horizontal else CARD_H) // 4
        results = []
        for frac in (0.30, 0.40, 0.50, 0.60, 0.70):
            if horizontal:
                row = int(CARD_H * frac)
                profile = gray[max(0, row - 8) : row + 8, :].mean(axis=0)
            else:
                col = int(CARD_W * frac)
                profile = gray[:, max(0, col - 8) : col + 8].mean(axis=1)
            if from_end:
                profile = profile[::-1]
            width = first_edge(profile, limit)
            if width is not None:
                results.append(width)
        return float(np.median(results)) if results else limit / 2

    left = side_width(horizontal=True, from_end=False)
    right = side_width(horizontal=True, from_end=True)
    top = side_width(horizontal=False, from_end=False)
    bottom = side_width(horizontal=False, from_end=True)
    return left, right, top, bottom


def centering_cap(worst_share: float, *, back: bool = False) -> float:
    caps = BACK_CENTERING_CAPS if back else FRONT_CENTERING_CAPS
    for ceiling, grade in caps:
        if worst_share <= ceiling + 1e-9:
            return grade
    return 2.0


def measure_centering(card: np.ndarray, *, back: bool = False) -> CenteringReport:
    left, right, top, bottom = _border_widths(card)

    def axis(a: float, b: float) -> tuple[str, float]:
        if a + b == 0:
            return "50/50", 0.5
        big = max(a, b) / (a + b)
        first = big if a >= b else 1 - big
        return f"{round(first * 100)}/{round((1 - first) * 100)}", big

    lr_label, lr_share = axis(left, right)
    tb_label, tb_share = axis(top, bottom)
    worst = max(lr_share, tb_share)
    cap = centering_cap(worst, back=back)
    return CenteringReport(
        left_right=lr_label,
        top_bottom=tb_label,
        worst_share=round(worst, 4),
        cap=cap,
        score=cap,
    )


# --------------------------------------------------------------------------
# corners / edges (whitening forensics)
# --------------------------------------------------------------------------


def _whiteness(patch: np.ndarray) -> float:
    hsv = cv2.cvtColor(patch, cv2.COLOR_BGR2HSV)
    white = (hsv[:, :, 1] < 40) & (hsv[:, :, 2] > 200)
    return float(white.mean())


def analyze_corners(card: np.ndarray) -> list[CornerReport]:
    p = CORNER_PATCH
    patches = {
        "top_left": card[:p, :p],
        "top_right": card[:p, -p:],
        "bottom_left": card[-p:, :p],
        "bottom_right": card[-p:, -p:],
    }
    reports = []
    for name, patch in patches.items():
        wh = _whiteness(patch)
        # sharp corner ≈ 0% white; 10% fray → ~8; 30% → ~4; 45%+ heavy rounding
        score = float(np.clip(10 - wh * 20, 1, 10))
        reports.append(CornerReport(corner=name, whitening_pct=round(wh, 4), score=round(score, 1)))
    return reports


def analyze_edges(card: np.ndarray) -> list[EdgeReport]:
    s = EDGE_STRIP
    strips = {
        "top": card[:s, :],
        "bottom": card[-s:, :],
        "left": card[:, :s].transpose(1, 0, 2),
        "right": card[:, -s:].transpose(1, 0, 2),
    }
    reports = []
    for name, strip in strips.items():
        wh = _whiteness(strip)
        # chipping check: whitening concentrated in a few windows is worse
        # than the same amount spread evenly (manufacturing wear tolerance).
        hsv = cv2.cvtColor(strip, cv2.COLOR_BGR2HSV)
        white = ((hsv[:, :, 1] < 40) & (hsv[:, :, 2] > 200)).astype(np.float32)
        windows = np.array_split(white, 12, axis=1)
        peak = max(float(w.mean()) for w in windows)
        clustered = peak > max(0.25, wh * 3)
        score = float(np.clip(10 - wh * 16 - (1.5 if clustered else 0), 1, 10))
        reports.append(
            EdgeReport(edge=name, whitening_pct=round(wh, 4), clustered=clustered,
                       score=round(score, 1))
        )
    return reports


def _worst_weighted(scores: list[float]) -> float:
    """PSA looks at the worst corner/edge first: 60% worst + 40% average."""
    worst = min(scores)
    avg = sum(scores) / len(scores)
    return round(worst * 0.6 + avg * 0.4, 1)


# --------------------------------------------------------------------------
# surface (scratches, creases, print lines)
# --------------------------------------------------------------------------


def analyze_surface(card: np.ndarray) -> SurfaceReport:
    # Crop INSIDE the card's own art frame so the frame's straight edges are
    # never mistaken for print lines/creases.
    left, right, top, bottom = _border_widths(card)
    lx = int(left) + 16
    rx = CARD_W - int(right) - 16
    ty = int(top) + 16
    by = CARD_H - int(bottom) - 16
    interior = card[ty:by, lx:rx]
    if interior.shape[0] < 100 or interior.shape[1] < 100:
        interior = card[EDGE_STRIP * 3 : -EDGE_STRIP * 3, EDGE_STRIP * 3 : -EDGE_STRIP * 3]
    gray = cv2.cvtColor(interior, cv2.COLOR_BGR2GRAY)
    glare = _glare_pct(card)

    # Line evidence via probabilistic Hough over a conservative edge map.
    edges = cv2.Canny(cv2.GaussianBlur(gray, (3, 3), 0), 60, 160)
    min_len = int(min(interior.shape[:2]) * 0.45)
    lines = cv2.HoughLinesP(
        edges, 1, np.pi / 180, threshold=120, minLineLength=min_len, maxLineGap=6
    )

    crease_like = 0
    print_like = 0
    if lines is not None:
        # OpenCV 4 returns (N,1,4); OpenCV 5 returns (N,4) — normalize.
        for (x1, y1, x2, y2) in np.asarray(lines).reshape(-1, 4):
            angle = abs(np.degrees(np.arctan2(y2 - y1, x2 - x1))) % 180
            axis_aligned = min(angle, abs(angle - 90), abs(angle - 180)) < 1.5
            length = float(np.hypot(x2 - x1, y2 - y1))
            span = length / (interior.shape[1] if angle < 45 or angle > 135 else interior.shape[0])
            if axis_aligned and span > 0.85:
                print_like += 1
            elif not axis_aligned and span > 0.60:
                # long diagonal ridge crossing the art ≈ crease candidate.
                # Tuned to under-report: art rarely has 60%-span straight diagonals.
                crease_like += 1

    crease_detected = crease_like >= 2
    severe_crease = crease_like >= 5
    # 1-2 isolated razor-straight axis lines ≈ print line (modern cap 9);
    # 3+ is the card's own art-frame structure — never punish the artwork.
    print_line = 1 <= print_like <= 2 and not crease_detected

    # scratch index: residual high-frequency energy after removing art
    # structure (median blur) — sharp thin marks survive the difference.
    # The threshold adapts to the card's own texture (holofoil patterns are
    # globally noisy; a scratch is a LOCAL outlier above that baseline).
    residual = cv2.absdiff(gray, cv2.medianBlur(gray, 7))
    texture_baseline = float(np.percentile(residual, 99))
    threshold = max(40.0, texture_baseline * 1.6)
    scratch_index = float((residual > threshold).mean())

    score = 10.0
    score -= min(3.0, glare * 25)               # glare hides/creates artifacts
    score -= min(4.0, scratch_index * 300)      # thin sharp marks
    if print_line:
        score = min(score, PRINT_LINE_CAP)
    if crease_detected:
        score = min(score, LIGHT_CREASE_CAP)
    if severe_crease:
        score = min(score, SEVERE_CREASE_CAP)
    return SurfaceReport(
        glare_pct=round(glare, 4),
        scratch_index=round(scratch_index, 4),
        crease_detected=crease_detected,
        severe_crease=severe_crease,
        print_line=print_line,
        score=round(max(1.0, score), 1),
    )


# --------------------------------------------------------------------------
# synthesis (PSA: final grade limited by the lowest sub-grade)
# --------------------------------------------------------------------------


def _half(value: float) -> float:
    return round(round(value * 2) / 2, 1)


def synthesize(
    centering: CenteringReport,
    corners: list[CornerReport],
    edges: list[EdgeReport],
    surface: SurfaceReport,
    quality: QualityReport,
) -> tuple[float, float, float, list[str]]:
    corner_sub = _worst_weighted([c.score for c in corners])
    edge_sub = _worst_weighted([e.score for e in edges])
    subs = [centering.score, corner_sub, edge_sub, surface.score]

    estimated = _half(min(subs))
    if surface.severe_crease:
        estimated = min(estimated, SEVERE_CREASE_CAP)
    elif surface.crease_detected:
        estimated = min(estimated, LIGHT_CREASE_CAP)

    # Uncertainty band: photo analysis can't see what a grader's loupe sees.
    spread = 0.5 if quality.ok else 1.5
    low = max(1.0, _half(estimated - spread))
    high = min(10.0, _half(estimated + spread))

    warnings = [
        "Análise de superfície tem menor confiança: riscos finos e vincos leves "
        "podem não aparecer em foto.",
    ]
    if surface.crease_detected:
        warnings.append(
            "Possível vinco detectado — vincos limitam fortemente a nota profissional."
        )
    if surface.print_line:
        warnings.append("Possível print line — em cartas modernas costuma limitar a nota a 9.")
    if not quality.ok:
        warnings.append(
            "A foto não atinge a qualidade mínima — a estimativa está com faixa ampliada. "
            "Refaça seguindo as instruções acima."
        )
    return estimated, low, high, warnings


# --------------------------------------------------------------------------
# entry points
# --------------------------------------------------------------------------


def _analyze_frame(img: np.ndarray, *, back: bool = False):
    quad = _find_card_quad(img)
    card = _warp(img, quad)
    quality = assess_quality(card, _quad_height(quad))
    centering = measure_centering(card, back=back)
    corners = analyze_corners(card)
    edges = analyze_edges(card)
    surface = analyze_surface(card)
    return quality, centering, corners, edges, surface


def grade_card(image_bytes: bytes, back_bytes: bytes | None = None) -> GradeReport:
    img = _decode(image_bytes)
    quality, centering, corners, edges, surface = _analyze_frame(img)
    estimated, low, high, warnings = synthesize(centering, corners, edges, surface, quality)

    if back_bytes is not None:
        try:
            back_img = _decode(back_bytes)
            b_quality, b_cent, b_corners, b_edges, b_surface = _analyze_frame(
                back_img, back=True
            )
            back_est, back_low, _, _ = synthesize(
                b_cent, b_corners, b_edges, b_surface, b_quality
            )
            if back_est < estimated:
                estimated, low = back_est, min(low, back_low)
                warnings.append(
                    f"O verso limita a nota (centralização {b_cent.left_right} / "
                    f"{b_cent.top_bottom})."
                )
        except (CardNotFoundError, ValueError):
            warnings.append("Não foi possível analisar a foto do verso — ignorada.")

    return GradeReport(
        estimated_grade=estimated,
        grade_min=low,
        grade_max=high,
        centering=centering,
        corners=corners,
        edges=edges,
        surface=surface,
        quality=quality,
        warnings=warnings,
    )


MIN_VIDEO_HEIGHT = 720
MIN_VIDEO_SECONDS = 2.0
MIN_USABLE_FRAMES = 3
MAX_SAMPLED_FRAMES = 24
TOP_FRAMES = 6


def grade_video(video_path: str) -> GradeReport:
    cap = cv2.VideoCapture(video_path)
    if not cap.isOpened():
        raise VideoTooPoorError("Não foi possível ler o vídeo — envie MP4 ou MOV.")
    try:
        fps = cap.get(cv2.CAP_PROP_FPS) or 30
        total = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
        height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
        width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
        duration = total / fps if fps else 0

        if min(height, width) < MIN_VIDEO_HEIGHT:
            raise VideoTooPoorError(
                f"Resolução mínima: {MIN_VIDEO_HEIGHT}p — o vídeo tem {min(height, width)}p. "
                "Grave em 1080p, com a carta preenchendo o quadro."
            )
        if duration < MIN_VIDEO_SECONDS:
            raise VideoTooPoorError(
                "Vídeo curto demais — grave 3 a 10 segundos inclinando a carta "
                "lentamente sob a luz."
            )

        stride = max(1, total // MAX_SAMPLED_FRAMES)
        frames: list[np.ndarray] = []
        idx = 0
        while True:
            ok, frame = cap.read()
            if not ok:
                break
            if idx % stride == 0:
                frames.append(frame)
            idx += 1
    finally:
        cap.release()

    # Rank frames by sharpness where a card is actually found.
    analyzed = []
    for frame in frames:
        try:
            quad = _find_card_quad(frame)
        except CardNotFoundError:
            continue
        card = _warp(frame, quad)
        sharp = float(cv2.Laplacian(cv2.cvtColor(card, cv2.COLOR_BGR2GRAY), cv2.CV_64F).var())
        analyzed.append((sharp, frame, quad))
    analyzed.sort(key=lambda t: t[0], reverse=True)
    analyzed = analyzed[:TOP_FRAMES]

    if len(analyzed) < MIN_USABLE_FRAMES:
        raise VideoTooPoorError(
            "Poucos quadros utilizáveis — mantenha a carta inteira no quadro, "
            "em foco, sobre fundo contrastante."
        )

    results = []
    for _, frame, quad in analyzed:
        card = _warp(frame, quad)
        quality = assess_quality(card, _quad_height(quad))
        results.append(
            (
                quality,
                measure_centering(card),
                analyze_corners(card),
                analyze_edges(card),
                analyze_surface(card),
            )
        )

    # Consensus: median centering/corner/edge; surface defects must persist in
    # at least half the frames (glare moves between angles, damage does not).
    def med(values: list[float]) -> float:
        return float(np.median(values))

    centerings = [r[1] for r in results]
    best_c = min(centerings, key=lambda c: c.worst_share)
    n = len(results)

    corner_names = ["top_left", "top_right", "bottom_left", "bottom_right"]
    corners = [
        CornerReport(
            corner=name,
            whitening_pct=round(med([r[2][i].whitening_pct for r in results]), 4),
            score=round(med([r[2][i].score for r in results]), 1),
        )
        for i, name in enumerate(corner_names)
    ]
    edge_names = ["top", "bottom", "left", "right"]
    edges = [
        EdgeReport(
            edge=name,
            whitening_pct=round(med([r[3][i].whitening_pct for r in results]), 4),
            clustered=sum(r[3][i].clustered for r in results) > n / 2,
            score=round(med([r[3][i].score for r in results]), 1),
        )
        for i, name in enumerate(edge_names)
    ]
    surface = SurfaceReport(
        glare_pct=round(med([r[4].glare_pct for r in results]), 4),
        scratch_index=round(med([r[4].scratch_index for r in results]), 4),
        crease_detected=sum(r[4].crease_detected for r in results) > n / 2,
        severe_crease=sum(r[4].severe_crease for r in results) > n / 2,
        print_line=sum(r[4].print_line for r in results) > n / 2,
        score=round(med([r[4].score for r in results]), 1),
    )
    quality = max((r[0] for r in results), key=lambda q: q.sharpness)

    estimated, low, high, warnings = synthesize(best_c, corners, edges, surface, quality)
    # Multi-frame consensus narrows the uncertainty band.
    per_frame = [
        synthesize(r[1], r[2], r[3], r[4], r[0])[0] for r in results
    ]
    low = max(low, _half(min(per_frame)))
    high = min(high, _half(max(per_frame) + 0.5))
    warnings.insert(
        0,
        f"Consenso de {n} quadros do vídeo — defeitos que persistem entre ângulos "
        "contam; reflexos que se movem são descartados.",
    )
    return GradeReport(
        estimated_grade=estimated,
        grade_min=low,
        grade_max=high,
        centering=best_c,
        corners=corners,
        edges=edges,
        surface=surface,
        quality=quality,
        warnings=warnings,
        frames_analyzed=n,
    )
