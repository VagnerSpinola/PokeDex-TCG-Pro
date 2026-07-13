"""Build the FAISS scan index from catalog card images (phase 2).

Usage (from backend/ so the venv and .env are picked up):
    python -m etl.build_scan_index [--limit N]

For every card with an image URL: download the image transiently (never stored
on disk — licensing guardrail), extract a normalized CNN embedding and add it
to the FAISS index. Resumable: cards already in the index are skipped, and the
index is checkpointed every 500 cards.

First run downloads MobileNetV2 (ONNX, ~14MB) from the official onnx/models
repository and exposes its GlobalAveragePool layer as the feature output.
"""

import argparse
import asyncio
import sys

import httpx
from sqlalchemy import select
from sqlalchemy.ext.asyncio import create_async_engine

from app.config import get_settings
from app.models import Card
from app.services import scan_service
from app.services.scan_service import DATA_DIR, MODEL_PATH, Embedder, ScanIndex

MODEL_URL = (
    "https://github.com/onnx/models/raw/main/validated/vision/"
    "classification/mobilenet/model/mobilenetv2-12.onnx"
)
CHECKPOINT_EVERY = 500
DOWNLOAD_CONCURRENCY = 8


def ensure_model() -> None:
    """Download MobileNetV2 and re-emit it with the GAP feature layer as output."""
    if MODEL_PATH.exists():
        return
    DATA_DIR.mkdir(parents=True, exist_ok=True)
    print("downloading embedding model (MobileNetV2 ONNX)...", flush=True)
    raw_path = DATA_DIR / "mobilenetv2-12.onnx"
    with httpx.stream("GET", MODEL_URL, follow_redirects=True, timeout=120) as resp:
        resp.raise_for_status()
        with open(raw_path, "wb") as fh:
            for chunk in resp.iter_bytes():
                fh.write(chunk)

    import onnx
    from onnx import TensorProto, helper

    model = onnx.load(str(raw_path))
    gap_nodes = [n for n in model.graph.node if n.op_type == "GlobalAveragePool"]
    if not gap_nodes:
        raise RuntimeError("GlobalAveragePool layer not found in model")
    feature_output = gap_nodes[-1].output[0]
    model.graph.output.append(
        helper.make_tensor_value_info(feature_output, TensorProto.FLOAT, None)
    )
    onnx.save(model, str(MODEL_PATH))
    raw_path.unlink()
    print(f"model ready: {MODEL_PATH}", flush=True)


async def build(limit: int | None) -> None:
    ensure_model()
    embedder = Embedder()

    try:
        index = ScanIndex.load()
        print(f"resuming existing index with {index.index.ntotal} cards", flush=True)
    except scan_service.IndexNotBuiltError:
        # Dimension probed from a dummy embedding.
        import numpy as np

        dummy = embedder.embed(
            bytes(
                httpx.get(
                    "https://images.pokemontcg.io/sv1/1.png", timeout=60, follow_redirects=True
                ).content
            )
        )
        index = ScanIndex.create(len(np.asarray(dummy)))
        print(f"new index (dim={len(dummy)})", flush=True)

    done = set(index.card_ids)
    engine = create_async_engine(get_settings().database_url)
    async with engine.connect() as conn:
        rows = (
            await conn.execute(
                select(Card.id, Card.image_small_url).where(Card.image_small_url.is_not(None))
            )
        ).all()
    await engine.dispose()

    todo = [(cid, url) for cid, url in rows if cid not in done]
    if limit:
        todo = todo[:limit]
    print(f"{len(done)} already indexed, {len(todo)} to embed", flush=True)

    sem = asyncio.Semaphore(DOWNLOAD_CONCURRENCY)
    client = httpx.AsyncClient(timeout=60, follow_redirects=True)

    async def fetch(card_id: str, url: str) -> tuple[str, bytes | None]:
        async with sem:
            for attempt in (1, 2, 3):
                try:
                    resp = await client.get(url)
                    resp.raise_for_status()
                    return card_id, resp.content
                except httpx.HTTPError:
                    if attempt == 3:
                        return card_id, None
                    await asyncio.sleep(2 * attempt)
        return card_id, None

    processed = failed = 0
    try:
        for start in range(0, len(todo), CHECKPOINT_EVERY):
            batch = todo[start : start + CHECKPOINT_EVERY]
            results = await asyncio.gather(*(fetch(cid, url) for cid, url in batch))
            for card_id, content in results:
                if content is None:
                    failed += 1
                    continue
                try:
                    index.add(card_id, embedder.embed(content))
                    processed += 1
                except ValueError:
                    failed += 1
            index.save()
            print(
                f"checkpoint: {index.index.ntotal} indexed (+{processed}, {failed} failed)",
                flush=True,
            )
    finally:
        await client.aclose()
        index.save()
    print(f"done: {index.index.ntotal} cards in index ({failed} failures)", flush=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Build the FAISS card scan index")
    parser.add_argument("--limit", type=int, help="only embed the first N missing cards")
    args = parser.parse_args()

    if sys.platform == "win32":
        asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())
    import truststore

    truststore.inject_into_ssl()
    asyncio.run(build(args.limit))
