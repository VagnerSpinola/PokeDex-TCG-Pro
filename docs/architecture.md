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

## Phase 3 — prices (built 2026-07-13, user request)

- `prices` table: unique on **(card_id, source, variant, date)** — `variant`
  added to the AGENTS.md key because TCGplayer prices several printings of the
  same card on the same day (normal, holofoil, ...). Cardmarket → 'default'.
- `python -m etl.sync_prices` is the daily job for now (manual/scheduler);
  Celery orchestration stays deferred to the infra phase.
- Latest snapshot per source/variant is embedded in `GET /cards/{id}`;
  history at `GET /cards/{id}/prices?days=N` for future charts.

## Phase 2 — scanner (built 2026-07-13, user request)

- **FAISS server-side only** (AGENTS.md architecture): `backend/data/` holds
  the index + MobileNetV2 ONNX feature extractor (GAP layer, 1280-d,
  L2-normalized, cosine/IP search). Derived data, gitignored; rebuild with
  `python -m etl.build_scan_index` (resumable, checkpoints every 500 cards;
  card images are fetched transiently and never stored — licensing guardrail).
- `POST /scan` (multipart photo): OpenCV preprocess → embedding → FAISS top-5
  → RapidOCR text boosts candidates whose name appears in the photo. Response
  always carries per-candidate confidence (high/medium/low ≈ ≥0.90/≥0.80),
  a `low_confidence` flag and a disclaimer — the app must ask the user to
  confirm and routes low confidence to manual search (never auto-adds).
- `POST /scan/embedding` accepts a raw vector — the future on-device TFLite
  path per AGENTS.md. **Deviation, flagged:** on-device extraction is not
  implemented yet (no physical device to validate); the phone currently
  uploads the photo and the server embeds it with the same model.
- OCR engine: RapidOCR (onnxruntime) — pip-only, no system Tesseract needed.

## Phase 4 — AI grading assistant (v2 PSA-rulebook, 2026-07-14)

- **CV pipeline structured after PSA's PUBLISHED standards, not a trained
  model**: centering caps per grade (55/45→10 ... 90/10→3, worst axis is the
  ceiling; back one band looser), per-corner/per-edge whitening forensics
  (worst-dominates weighting), surface (adaptive scratch detection normalized
  to the card's own texture so holofoil isn't punished; crease evidence via
  long diagonal Hough ridges — tuned to under-report; print-line heuristic
  ignores the card's own frame structure). FINAL grade = lowest sub-grade
  (PSA rule); crease caps at 6 (light) / 3 (severe); print line caps 9.
- **Output is a RANGE** (±0.5 good photo, ±1.5 poor photo), never a point.
  Photo quality gates (sharpness ≥80 Laplacian, glare ≤6%, card ≥600px)
  return actionable retake instructions (45°/45° diffuse light, 5000-6500K).
- `POST /grade` accepts front + optional back photo; `POST /grade/video`
  (720p+, 2s+) samples frames, keeps the sharpest with a detected card and
  takes the median consensus — defects persisting across angles count,
  moving glare doesn't.
- Every response still carries `experimental: true` + the mandatory
  disclaimer (AGENTS.md §2). A trained model on labeled graded cards remains
  the future upgrade path; the report schema is ready for it.

### ML grade model — evaluated and NOT integrated (2026-07-14)

Trained locally on the public samsilverman/PSA-Baseball-Grades dataset
(11.5k images, PSA 1-10, 150x200px, no declared license — local evaluation
only, never redistributed): MobileNetV2 embeddings -> HistGradientBoosting.
Held-out results: MAE 1.60 grades, only 40% within ±1, heavy regression to
the mean (true PSA 1 predicted ~3.5, true PSA 10 predicted ~7.7). Fails
precisely at the 8/9/10 boundary that matters. Root causes: 150x200px kills
corner/surface detail, baseball slabs ≠ raw Pokémon photos, generic
ImageNet embeddings. Decision: keep the rulebook pipeline as the grader.
Viable future paths: (1) first-party dataset — app feature where users
photograph their own already-graded slabs (trusted label + hi-res + consent);
(2) PSA public API images (post-2021 certs) collected within its terms;
(3) condition-specific embedder fine-tuning once data exists.

## Discarded

- **Marketplace (former phase 5)** — dropped by owner decision on 2026-07-14.
  Do not build or propose buy/sell/trade features. The payments/compliance
  guardrail in AGENTS.md §2 stays in force should this ever be revisited.

## Explicitly deferred

On-device TFLite embedding extraction (phase 2 follow-up), scheduled/Celery
jobs (daily price sync), price history charts in the app, re-enabling auth,
Docker images for the apps, Terraform, CI/CD.
