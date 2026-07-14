# PokeDex TCG Pro

Pokémon TCG card scanner, collection manager and price tracker.
Currently in **Phase 1**: card database (browse/search/filter) + manual collection
manager, with auth as the foundation. See [AGENTS.md](AGENTS.md) for the full
phased roadmap and engineering conventions.

## Stack

- **Backend:** Python 3.12, FastAPI, SQLAlchemy 2.x (async), Alembic, PostgreSQL, Redis
- **Mobile:** Flutter (Riverpod, GoRouter, Freezed, Dio, Hive, sqflite)
- **Data source:** [Pokémon TCG API](https://pokemontcg.io) (image URLs only — no mirroring)

## Repo layout

```
mobile/    Flutter app (feature-first)
backend/   FastAPI service (routers / services / models / schemas, Alembic, tests)
etl/       Ingestion jobs (Pokémon TCG API sync)
docs/      Architecture notes
```

## Local development

Prerequisites: Python 3.12+, Flutter SDK, Docker Desktop.

```bash
# 1. Dev services (Postgres + Redis)
docker compose up -d

# 2. Backend
cd backend
python -m venv .venv && .venv/Scripts/activate   # Windows
pip install -e ".[dev]"
cp ../.env.example ../.env                        # then edit JWT_SECRET_KEY
alembic upgrade head
uvicorn app.main:app --reload                     # http://localhost:8000/docs

# 3. Seed card data (optional API key: https://dev.pokemontcg.io)
python -m etl.sync_cards --set sv1

# 4. Mobile
cd ../mobile
flutter pub get
dart run build_runner build --force-jit --delete-conflicting-outputs
flutter run          # Android emulator reaches the API via 10.0.2.2:8000
```

### Running on a physical Android device

The emulator alias 10.0.2.2 does not exist on real phones — point the app at
your machine's LAN IP instead, with phone and PC on the same Wi-Fi:

```bash
# 1. Backend must listen on the network, not only localhost
uvicorn app.main:app --host 0.0.0.0 --port 8000

# 2. Allow inbound 8000 once (admin PowerShell)
netsh advfirewall firewall add rule name="PokeDex TCG API dev (8000)" dir=in action=allow protocol=TCP localport=8000

# 3. Run pointing at your LAN IP (ipconfig -> IPv4 of the Wi-Fi/Ethernet adapter)
flutter run --dart-define=API_BASE_URL=http://192.168.1.91:8000
```

In Android Studio put the `--dart-define=...` in Run > Edit Configurations >
Additional run args. Debug/profile builds allow plain HTTP (cleartext) via
their manifests; release builds keep it blocked.

> Note: the dev Postgres is published on host port **15432** (5432/5433 are
> taken by native installs on this machine). See docs/architecture.md.

## Tests

```bash
cd backend && pytest
cd mobile && flutter test
```
