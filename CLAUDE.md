# CLAUDE.md — Hermes Workspace
# Role: Claude Code (Builder Agent) — Tier 2 Project Config
# Last updated: 2026-06-28

## What This Is

**Hermes Workspace** (v2.3.0, MIT) is the **web UI / dashboard layer** for the Jarvis system.
TypeScript monorepo — Electron desktop app + Vite web client + Hermes gateway integration.

This is **separate from** the `reevesc88/hermes-agent` skills/framework repo.

---

## Architecture

```
hermes-workspace/
├── src/              ← Vite/React web client
├── electron/         ← Electron main process (electron/main.cjs)
├── agents/           ← Agent definitions
├── skills/           ← Workspace-specific skills
├── memory/           ← Persistent memory
├── docs/             ← User documentation
├── e2e/              ← End-to-end tests
├── scripts/          ← Build and utility scripts
├── swarm.yaml        ← Swarm worker roster (source of truth for routing)
├── docker-compose.yml
├── package.json
├── pnpm-workspace.yaml
└── vite.config.ts
```

---

## Three Services (all must run for full functionality)

| Service | Command | Port |
|---------|---------|------|
| Gateway | `hermes gateway run` | `:8642` |
| Dashboard | `hermes dashboard --port 9119 --host 127.0.0.1 --no-open` | `:9119` |
| Workspace | `pnpm dev` | `:3000` |
| **Or: Electron** | `pnpm electron:dev` (auto-starts all three) | all |

**Canonical setup:** one gateway on `:8642` + one dashboard on `:9119`. Before starting another gateway, verify `curl http://127.0.0.1:3000/api/sessions` — if Sessions returns data, refresh UI instead of spawning duplicate.

---

## Swarm Workers (10 semantic agents)

Defined in `swarm.yaml` — source of truth for routing. Each worker has:
- A profile under `~/.hermes/profiles/<worker-id>/`
- A role skill `<worker-id>-core`
- A wrapper in `~/.local/bin/`

| Worker | Wrapper | Primary Role |
|--------|---------|-------------|
| `orchestrator` | `orchestrator:plan` | Routes tasks, enforces greenlight |
| `km-agent` | `km:health` | Knowledge management, GBrain, Obsidian |
| `builder` | `builder:task` | Implements; uses TDD, GitHub PR workflow |
| `reviewer` | `reviewer:gate` | Gates PRs; code review |
| `qa` | `qa:smoke` | Browser testing, dogfood |
| `researcher` | `researcher:quick` | Web, arXiv, YouTube content, Polymarket |
| `ops-watch` | `ops:health` | Monitoring, cron, webhooks |
| `maintainer` | `maintainer:check` | GitHub repo management, PR ops |
| `strategist` | `strategist:review` | Planning, roadmap, Polymarket |
| `inbox-triage` | `inbox:triage` | Inbox processing, Obsidian notes |

All workers use **GBrain MCP** for context retrieval.

**Division of labour:** Builder implements → Reviewer gates → QA verifies → Orchestrator routes.

---

## Windows-Specific Notes

- **Node 22+ required.** Check: `node --version`
- **Three `.env` files** — keep API keys in sync across all:
  - Gateway: `C:\Users\<you>\AppData\Local\hermes\.env`
  - CLI: `C:\Users\<you>\.hermes\.env`
  - Workspace: `hermes-workspace\.env`
- **Gateway API:** Requires `API_SERVER_ENABLED=true` + `API_SERVER_KEY` in gateway `.env`
- **Workspace env vars:** Uses `CLAUDE_API_URL` / `CLAUDE_API_TOKEN` / `CLAUDE_DASHBOARD_URL` (not `HERMES_*`)
- **sqlite3:** Not bundled on Windows. Install via `winget install SQLite.SQLite`, copy to Git Bash PATH
- **Port conflicts:** `netstat -ano | findstr :<port>` + `Stop-Process -Id <PID> -Force` (PowerShell)
- **Electron build:** `electron:build:win` → NSIS installer in `release/`. Test: `release/win-unpacked/hermes-workspace.exe`
- **Default model:** `gpt-5.4` / `openai-codex` — requires live `codex login`
- **PWA:** Dashboard at `http://127.0.0.1:3000` can be installed as PWA; prefer Electron for production

---

## Key Files

| File | Purpose |
|------|--------|
| `swarm.yaml` | Worker roster — source of truth for routing |
| `AGENTS.md` | Agent contract (detailed swarm roles, tools, skills, MCP per worker) |
| `FEATURES-INVENTORY.md` | Full feature list (31KB) |
| `OVERNIGHT-PR-SHAKEDOWN.md` | Integration test log (29KB, ~23 PRs) |
| `SECURITY.md` | Security policies |
| `electron/main.cjs` | Electron main process |

---

## Development Rules

- Keep `swarm.yaml`, worker profiles, core skills, and wrappers aligned when changing a worker
- GBrain-first lookup for context decisions
- Never enable optional Hermes plugins globally — record toolset alignment in `swarm.yaml` first
- Feature branches + conventional commits; never push to main directly
- Draft PR on push; un-draft before merging
- `NODE_OPTIONS` env var prefix doesn't work on Windows — stripped from npm scripts

---

## Ecosystem Context

- **Orchestrator:** The Conductor (Base44 app `6a361353388578905fc5e0cd`)
- **Knowledge hub:** reevesc88/jarvis-command-center
- **Hermes framework:** reevesc88/hermes-agent (skills repo — separate from this workspace)
- **Conductor brain:** reevesc88/conductor-brain (locked decisions, brand guidelines)
- **Brand:** `#F97316` Powerline Orange (LOCKED for AI1AU). Dashboard UI uses `#38bdf8` electric blue.
