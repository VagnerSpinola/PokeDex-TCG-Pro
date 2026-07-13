from fastapi import FastAPI

from app.routers import auth, cards, collection, sets

app = FastAPI(
    title="PokeDex TCG Pro API",
    version="0.1.0",
    description="Card database, collection manager and auth (phase 1).",
)

app.include_router(auth.router)
app.include_router(cards.router)
app.include_router(sets.router)
app.include_router(collection.router)


@app.get("/health", tags=["meta"])
async def health() -> dict[str, str]:
    return {"status": "ok"}
