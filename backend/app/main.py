from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.routers import auth, cards, collection, grading, scan, sets

app = FastAPI(
    title="PokeDex TCG Pro API",
    version="0.1.0",
    description="Card database, collection manager and auth (phase 1).",
)

# Dev-only: allow the Flutter web build (any localhost port) to call the API.
# Mobile apps don't use CORS; tighten before any real deployment.
app.add_middleware(
    CORSMiddleware,
    allow_origin_regex=r"http://(localhost|127\.0\.0\.1)(:\d+)?",
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router)
app.include_router(cards.router)
app.include_router(sets.router)
app.include_router(collection.router)
app.include_router(scan.router)
app.include_router(grading.router)


@app.get("/health", tags=["meta"])
async def health() -> dict[str, str]:
    return {"status": "ok"}
