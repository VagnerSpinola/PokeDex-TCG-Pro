# Architecture notes — Phase 1

Companion to [AGENTS.md](../AGENTS.md) (the spec). This records decisions made
while building phase 1 and anything the next session should know.

## Backend

- **FastAPI + async SQLAlchemy 2.x.** Thin routers → service layer
  (`app/services/`) holds all business logic. Pydantic v2 schemas per domain.
- **Auth:** email/password with bcrypt; JWT access (30 min) + refresh (14 days).
  `users.oauth_provider` exists but social login is not implemented yet.
  Refresh tokens are stateless (no server-side revocation list) — acceptable
  for phase 1, revisit before marketplace phase.
- **IDs:** `sets.id` and `cards.id` reuse the Pokémon TCG API external ids
  (`sv1`, `sv1-25`) so ETL upserts are natural keys, no id-mapping table.
- **Collection upsert:** same `(user, card, condition)` sums quantities via a
  service-layer select-then-update; the DB unique constraint is the backstop.
- **Tests** run against a real Postgres test database (`pokedex_tcg_test`),
  created automatically by `tests/conftest.py`; tables are truncated between
  tests. Docker compose must be up. Test engine uses `NullPool` because
  pytest-asyncio runs per-test event loops and asyncpg connections cannot
  cross loops.

## ETL

- `python -m etl.sync_cards [--set <id>] [--sets-only]`, run manually in
  phase 1 (the scheduled daily job is phase 3).
- Upserts with `INSERT ... ON CONFLICT DO UPDATE`; re-running is idempotent.
- Stores **image URLs only** — never downloads/mirrors image assets
  (licensing guardrail in AGENTS.md §2).
- Uses `truststore` so TLS validation uses the Windows certificate store
  (bundled certifi alone fails on this dev machine).

## Mobile (Flutter)

- Feature-first: `lib/features/{auth,cards,collection}/{data,domain,presentation}`
  plus `lib/core` (Dio client, router, theme, token storage).
- **State:** Riverpod 3 with hand-written `Notifier` classes (no
  riverpod_generator — its constraints conflicted with freezed 3.x at setup
  time). Models are freezed + json_serializable.
- **HTTP:** Dio with a `QueuedInterceptor` that injects the access token and,
  on 401, refreshes once and retries; on refresh failure the session is
  cleared and the router redirects to /login.
- **Caching:** Hive box with a 30-minute TTL for card/set responses (cache,
  don't mirror). Collection has a sqflite offline mirror; the API is the
  source of truth and every successful fetch overwrites the mirror.
- **Tokens in a plain (unencrypted) Hive box** — phase-1 simplification.
  Upgrading to an encrypted box needs flutter_secure_storage for key
  management; do this before any store release.
- Base URL: `http://10.0.2.2:8000` on Android emulator, `http://localhost:8000`
  elsewhere; override with `--dart-define=API_BASE_URL=...`.
- build_runner on this machine needs `--force-jit`
  (`dart run build_runner build --force-jit --delete-conflicting-outputs`);
  AOT compilation of builders fails with current SDK/deps.

## Dev environment quirks (this machine)

- Native PostgreSQL services occupy host ports **5432 and 5433**; the compose
  Postgres is published on **15432**. All defaults point there.
- Start Docker Desktop before running tests or the backend.

## Explicitly deferred (later phases)

Scanner/OCR + FAISS (2), prices table + scheduled sync + Celery (3),
AI grading (4), marketplace (5), Docker images for the apps, Terraform, CI/CD.
