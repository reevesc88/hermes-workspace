# Setup

Reproducible install + integration setup for hermes-workspace. Run `scripts/setup.sh` to do all of this automatically, or follow the steps by hand below. Both are safe to re-run.

## 0. Requirements

- Node.js 22+ (repo requirement — see `package.json` engines badge and `docs/windows-setup-guide.md`)
- git, curl
- pnpm (installed via corepack in step 2 if missing)
- Optional: `hermes` CLI (NousResearch hermes-agent) if you want a local gateway/dashboard instead of pointing at a remote one

## 1. Install Node 22

Pick one version manager:

```bash
# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
nvm install 22 && nvm use 22

# fnm
curl -fsSL https://fnm.vercel.app/install | bash
fnm install 22 && fnm use 22
```

Verify:

```bash
node --version   # must print v22.x.x or higher
```

## 2. Enable pnpm

`package.json` has no `packageManager` field pinning a version as of this writing, so activate latest via corepack:

```bash
corepack enable
corepack prepare pnpm@latest --activate
pnpm --version
```

If a `packageManager` field is added later, run `corepack prepare` with no arguments and it picks up the pin automatically.

## 3. Install dependencies

From the repo root:

```bash
pnpm install
```

## 4. Env files (placeholders only — never commit real keys)

Three files are involved. `scripts/setup.sh` creates the first two from templates automatically if they don't already exist; it never overwrites an existing file.

| File | Purpose | Template in this repo |
|---|---|---|
| `hermes-workspace/.env` | Workspace (this app): gateway/dashboard URLs, auth token, port | `.env.example` (already in repo) |
| `~/.hermes/.env` (macOS/Linux) | Gateway + CLI config: provider key, `API_SERVER_ENABLED`, `API_SERVER_KEY` | `.env.hermes-agent.example` (added by this setup) |
| Windows only: `%LOCALAPPDATA%\hermes\.env` (gateway) and `%USERPROFILE%\.hermes\.env` (CLI) are two separate files | same as above, split in two | `.env.hermes-agent.example` (added by this setup) — copy to both Windows locations |

```bash
# Workspace env
cp .env.example .env
chmod 600 .env

# Gateway/CLI env (macOS/Linux; resolves the real path via the hermes CLI if installed)
HERMES_ENV_PATH="$(hermes config env-path 2>/dev/null || echo "$HOME/.hermes/.env")"
mkdir -p "$(dirname "$HERMES_ENV_PATH")"
cp .env.hermes-agent.example "$HERMES_ENV_PATH"
chmod 600 "$HERMES_ENV_PATH"
```

Then open both files and fill in real values yourself. Never commit either — both are already gitignored (`.env`, and `~/.hermes/.env` is outside the repo entirely).

Note on variable names — checked against source, not just docs: the workspace reads `HERMES_API_URL` / `HERMES_API_TOKEN` / `HERMES_DASHBOARD_URL` as primary, falling back to legacy `CLAUDE_API_URL` / `CLAUDE_API_TOKEN` / `CLAUDE_DASHBOARD_URL` for back-compat (see `src/server/gateway-capabilities.ts`). This repo's `CLAUDE.md` currently documents it the other way round (`CLAUDE_*` as primary) — that line is stale; `.env.example`, `README.md`, and `install.sh` all agree with the source and with this file.

## 5. Build

```bash
pnpm build
```

Output goes to `dist/`. Other build variants (`electron:build`, `electron:build:mac`, `electron:build:win`) package the Electron app and are not required for local dev.

## 6. Run

Sanity-check before starting a second gateway — a stale "Offline" badge in the UI does not mean no gateway is running:

```bash
curl http://127.0.0.1:3000/api/sessions
```

If that returns session data, refresh/reprobe the UI instead of spawning a duplicate gateway.

**Option A — three services individually (three terminals):**

```bash
hermes gateway run                                         # :8642
hermes dashboard --port 9119 --host 127.0.0.1 --no-open    # :9119
pnpm dev                                                    # :3000
```

**Option B — one Electron process starts all three:**

```bash
pnpm electron:dev
```

Open http://localhost:3000 (or the Electron window) and complete onboarding.

## Other package.json scripts

```bash
pnpm test        # vitest run
pnpm lint        # eslint
pnpm format      # prettier
pnpm check       # prettier --write . && eslint --fix
```

There is no `typecheck` script; CI (`.github/workflows/ci.yml`) falls back to `pnpm exec tsc --noEmit`.

## Automated setup script

```bash
./scripts/setup.sh
```

Runs steps 1 (verify only) through 6 (prints run instructions). Idempotent — re-running skips anything already done and never overwrites an existing `.env` or gateway env file.

Env vars it honors:

- `SKIP_INSTALL=1` — skip `pnpm install`
- `SKIP_BUILD=1` — skip `pnpm build`
