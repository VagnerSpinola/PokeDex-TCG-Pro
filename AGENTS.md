# AGENTS.md — PokeDex TCG Pro

This file guides any AI coding agent (Claude Code, Cursor, etc.) working in this
repository. Read this fully before making changes. If something here conflicts
with a specific instruction from the user in a session, the user's instruction
wins — but flag the conflict first.

---

## 1. What this project is

A Pokémon TCG card scanner, collection manager, and price tracker.
Mobile app (Flutter, iOS + Android) + backend (FastAPI/Python) + Postgres.

**This is NOT being built as one giant v1.** It is explicitly phased. Do not
implement features from a later phase while working on an earlier one unless
asked. See Section 3.

---

## 2. Non-negotiable guardrails

These override "just get it working" instincts:

- **No marketplace/payments code** (buy/sell/trade, escrow, payouts) until
  explicitly requested and a licensing/compliance review has happened. If asked
  to scaffold this, stop and ask which payment processor and legal structure
  is intended first — do not default to a naive wallet/balance system.
- **No redistribution of third-party card images/price data at scale** without
  confirming the licensing terms of the data source (Pokémon TCG API,
  TCGPlayer, CardMarket) allow caching/mirroring. Default to fetching +
  short-TTL caching, not permanent mirroring, unless told otherwise.
- **AI grading and "investment score" outputs must always carry a visible
  "estimate only, not an official grade" disclaimer** in any UI or API
  response that surfaces them. Never format these as if they were authoritative.
- **Never invent card data.** If the scanner/matcher returns low confidence,
  surface it as low confidence with a manual-correction UI path — don't
  silently guess and present it as a match.
- Don't add new third-party services, SDKs, or paid APIs without flagging the
  cost/tradeoff first.

---

## 3. Build phases — work within the current phase only

| Phase | Scope |
|---|---|
| **1 (current default)** | Card database: browse/search/filter + manual collection manager (add/remove/track condition & quantity). No AI. |
| 2 | Card scanner: OCR + embedding match, with manual correction fallback |
| 3 | Price tracking: historical charts, daily sync job |
| 4 | AI grading assistant (experimental, clearly labeled) |
| 5 | Marketplace (buy/sell/trade) — last, due to compliance load |

If a task description sounds like it belongs to a later phase, say so and ask
whether to proceed anyway rather than silently building it.

---

## 4. Tech stack (do not substitute without asking)

**Mobile**
- Flutter, Riverpod (state), GoRouter (nav), Freezed (models), Dio (http),
  Hive (local KV/offline cache), sqflite (relational local store)

**Backend**
- Python, FastAPI, SQLAlchemy 2.x, Alembic (migrations), PostgreSQL, Redis
  (cache/queues), Celery (background jobs)

**AI/CV (phase 2+)**
- On-device: lightweight TFLite embedding model for feature extraction only
- Server-side: FAISS vector search (do NOT run FAISS on-device — see below),
  OpenCV for preprocessing, OCR via a server-side engine

**Infra (later, not phase 1)**
- Docker / Docker Compose for local dev, Terraform for AWS (ECS Fargate, RDS,
  S3, CloudFront), GitHub Actions for CI/CD

### Explicit architecture decision: FAISS runs server-side, not on-device
The phone extracts an embedding locally, sends it to the backend, backend runs
FAISS search and returns top-k candidates for user confirmation. Do not
attempt to bundle a full vector index into the mobile app.

---

## 5. Database conventions

- Every table needs `created_at` / `updated_at` timestamps unless it's a pure
  join table.
- `prices` table: enforce a unique constraint on `(card_id, source, date)` —
  ETL jobs must upsert, never blind-insert, or you'll get duplicate rows.
- Add indexes for any column used in a WHERE/JOIN on a table expected to grow
  past ~10k rows (`cards.name`, `cards.set_id`, `prices(card_id, date)`, etc.)
- `users` needs `role`, `oauth_provider`, `is_verified` — auth is not
  optional scaffolding, build it as part of phase 1's foundation even though
  the collection manager is the visible feature.
- Migrations go through Alembic — never hand-edit schema in prod, never
  suggest `Base.metadata.create_all()` as a substitute for migrations.

---

## 6. Coding conventions

**Python/FastAPI**
- Type hints everywhere, Pydantic v2 schemas for request/response models,
  keep route handlers thin — business logic goes in a service layer, not in
  the route function.
- Async endpoints by default (`async def`), async SQLAlchemy session.
- All new endpoints need a corresponding test in the same PR/commit, not
  deferred.

**Flutter**
- Feature-first folder structure (`lib/features/<feature>/{data,domain,presentation}`),
  not type-first (`lib/screens`, `lib/models` at the root).
- Riverpod providers colocated with the feature that owns them.
- No business logic in widgets — widgets call providers/notifiers.

**General**
- Prefer explicit over clever. This codebase will be touched by multiple
  agents/sessions over time — optimize for the next reader, not brevity.
- If you're about to write a TODO comment instead of finishing something,
  say so out loud in your response, don't just leave it silently in the code.

---

## 7. Testing expectations

- Backend: pytest, one test file per router/service, use a test DB (not
  mocked SQLAlchemy) for anything touching the ORM.
- Flutter: widget tests for screens with logic, unit tests for
  providers/notifiers. Golden tests are nice-to-have, not required for phase 1.
- Don't mark a task "done" without running the relevant test suite. If you
  can't run it (no environment), say so explicitly rather than implying it
  passed.

---

## 8. What to do when requirements are ambiguous

- Pick the most reasonable interpretation, state the assumption in one line,
  and proceed — don't stall on small ambiguities.
- Do stop and ask when: the ambiguity touches Section 2's guardrails, involves
  a schema change that's hard to reverse, or involves adding a paid
  dependency/service.

---

## 9. Repo layout (target structure)

```
/mobile          Flutter app
/backend          FastAPI service
  /app
    /routers
    /services
    /models
    /schemas
  /alembic
  /tests
/etl               Ingestion jobs (Pokémon TCG API sync, price sync)
/infra             Docker, Terraform (added in later phase)
/docs              API docs, architecture notes
AGENTS.md          this file
README.md
```

---

## 10. Current status

Phase 1 in progress. Marketplace, AI grading, and full infra/deployment are
explicitly out of scope until earlier phases are stable — see Section 3.
