from fastapi import FastAPI

app = FastAPI(
    title="PokeDex TCG Pro API",
    version="0.1.0",
    description="Card database, collection manager and auth (phase 1).",
)


@app.get("/health", tags=["meta"])
async def health() -> dict[str, str]:
    return {"status": "ok"}
