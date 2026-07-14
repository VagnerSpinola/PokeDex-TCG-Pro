"""Card scanner (phase 2): embedding search + OCR assist.

Architecture (AGENTS.md): FAISS runs server-side only. The index maps
L2-normalized CNN embeddings of catalog card images to card ids; a scanned
photo is embedded with the same model and matched via inner product (cosine).
OCR text is used to boost candidates whose name appears in the photo.

Guardrail: results always carry an explicit confidence level and the API never
auto-confirms a match — the client must ask the user, and low confidence must
route to manual correction.
"""

import json
from dataclasses import dataclass
from pathlib import Path

import cv2
import faiss
import numpy as np
import onnxruntime as ort

DATA_DIR = Path(__file__).resolve().parents[2] / "data"
MODEL_PATH = DATA_DIR / "embedder.onnx"
INDEX_PATH = DATA_DIR / "scan.index"
IDS_PATH = DATA_DIR / "scan_ids.json"

EMBED_INPUT_SIZE = 224
HIGH_CONFIDENCE = 0.90
MEDIUM_CONFIDENCE = 0.80
OCR_NAME_BOOST = 0.12

_IMAGENET_MEAN = np.array([0.485, 0.456, 0.406], dtype=np.float32)
_IMAGENET_STD = np.array([0.229, 0.224, 0.225], dtype=np.float32)


class IndexNotBuiltError(Exception):
    """Raised when the FAISS index/model files are missing (run the ETL)."""


class Embedder:
    """MobileNetV2 feature extractor (ONNX, GAP layer output, L2-normalized)."""

    def __init__(self, model_path: Path = MODEL_PATH) -> None:
        if not model_path.exists():
            raise IndexNotBuiltError(f"embedding model missing: {model_path}")
        self._session = ort.InferenceSession(
            str(model_path), providers=["CPUExecutionProvider"]
        )
        self._input_name = self._session.get_inputs()[0].name
        self._output_name = self._session.get_outputs()[-1].name

    def preprocess(self, image_bytes: bytes) -> np.ndarray:
        raw = np.frombuffer(image_bytes, dtype=np.uint8)
        # An empty/corrupt buffer makes imdecode raise cv2.error instead of
        # returning None — treat both as an invalid image.
        try:
            img = cv2.imdecode(raw, cv2.IMREAD_COLOR)
        except cv2.error:
            img = None
        if img is None:
            raise ValueError("could not decode image")
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        img = cv2.resize(img, (EMBED_INPUT_SIZE, EMBED_INPUT_SIZE), interpolation=cv2.INTER_AREA)
        arr = img.astype(np.float32) / 255.0
        arr = (arr - _IMAGENET_MEAN) / _IMAGENET_STD
        return arr.transpose(2, 0, 1)[np.newaxis]  # NCHW

    def embed(self, image_bytes: bytes) -> np.ndarray:
        batch = self.preprocess(image_bytes)
        out = self._session.run([self._output_name], {self._input_name: batch})[0]
        vec = out.reshape(-1).astype(np.float32)
        norm = np.linalg.norm(vec)
        if norm > 0:
            vec /= norm
        return vec


class ScanIndex:
    """FAISS inner-product index over normalized embeddings + card-id mapping."""

    def __init__(self, index: faiss.Index, card_ids: list[str]) -> None:
        self.index = index
        self.card_ids = card_ids

    @classmethod
    def create(cls, dim: int) -> "ScanIndex":
        return cls(faiss.IndexFlatIP(dim), [])

    @classmethod
    def load(cls) -> "ScanIndex":
        if not INDEX_PATH.exists() or not IDS_PATH.exists():
            raise IndexNotBuiltError("scan index not built — run: python -m etl.build_scan_index")
        index = faiss.read_index(str(INDEX_PATH))
        card_ids = json.loads(IDS_PATH.read_text(encoding="utf-8"))
        return cls(index, card_ids)

    def save(self) -> None:
        DATA_DIR.mkdir(parents=True, exist_ok=True)
        faiss.write_index(self.index, str(INDEX_PATH))
        IDS_PATH.write_text(json.dumps(self.card_ids), encoding="utf-8")

    def add(self, card_id: str, vector: np.ndarray) -> None:
        self.index.add(vector[np.newaxis, :])
        self.card_ids.append(card_id)

    def search(self, vector: np.ndarray, k: int) -> list[tuple[str, float]]:
        if self.index.ntotal == 0:
            return []
        scores, idx = self.index.search(vector[np.newaxis, :], min(k, self.index.ntotal))
        return [
            (self.card_ids[i], float(s))
            for i, s in zip(idx[0], scores[0], strict=True)
            if i >= 0
        ]


class Scanner:
    """Bundles embedder + index + OCR; loaded lazily once per process."""

    def __init__(self, embedder: Embedder, index: ScanIndex) -> None:
        self.embedder = embedder
        self.index = index
        self._ocr = None

    def ocr_text(self, image_bytes: bytes) -> str:
        if self._ocr is None:
            from rapidocr_onnxruntime import RapidOCR

            self._ocr = RapidOCR()
        raw = np.frombuffer(image_bytes, dtype=np.uint8)
        img = cv2.imdecode(raw, cv2.IMREAD_COLOR)
        if img is None:
            return ""
        result, _ = self._ocr(img)
        if not result:
            return ""
        return " ".join(line[1] for line in result)

    def match(self, image_bytes: bytes, k: int = 5) -> tuple[list[tuple[str, float]], str]:
        vec = self.embedder.embed(image_bytes)
        matches = self.index.search(vec, k)
        text = self.ocr_text(image_bytes)
        return matches, text

    def match_embedding(self, vector: list[float], k: int = 5) -> list[tuple[str, float]]:
        vec = np.asarray(vector, dtype=np.float32)
        norm = np.linalg.norm(vec)
        if norm > 0:
            vec /= norm
        return self.index.search(vec, k)


@dataclass
class RankedCandidate:
    card_id: str
    score: float
    confidence: str  # high | medium | low


def rank_candidates(
    matches: list[tuple[str, float]], card_names: dict[str, str], ocr_text: str
) -> list[RankedCandidate]:
    """Order matches by embedding score, boosting names confirmed by OCR.

    Pure function — unit-tested without model/index.
    """
    text = ocr_text.casefold()
    ranked = []
    for card_id, score in matches:
        name = card_names.get(card_id, "")
        boosted = score
        if name and name.casefold() in text:
            boosted = min(1.0, score + OCR_NAME_BOOST)
        if boosted >= HIGH_CONFIDENCE:
            confidence = "high"
        elif boosted >= MEDIUM_CONFIDENCE:
            confidence = "medium"
        else:
            confidence = "low"
        ranked.append(RankedCandidate(card_id=card_id, score=round(boosted, 4), confidence=confidence))
    ranked.sort(key=lambda c: c.score, reverse=True)
    return ranked


_scanner: Scanner | None = None


def get_scanner() -> Scanner:
    global _scanner
    if _scanner is None:
        _scanner = Scanner(Embedder(), ScanIndex.load())
    return _scanner
