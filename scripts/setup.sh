#!/usr/bin/env bash
# Hermes Workspace — reproducible install + integration setup.
#
# Usage:
#   ./scripts/setup.sh
#
# Safe to re-run: every step is idempotent. Does not overwrite an existing
# .env or gateway/CLI env file, does not commit anything, does not print or
# store secrets. See SETUP.md for the same steps as copy-pasteable commands
# and background on each one.
#
# Env vars this script reads (all optional):
#   SKIP_BUILD=1   Skip the `pnpm build` step.
#   SKIP_INSTALL=1 Skip `pnpm install` (assumes deps already installed).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

REQUIRED_NODE_MAJOR=22

log()  { printf '\033[36m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[33m!!\033[0m %s\n' "$*" >&2; }
err()  { printf '\033[31mXX\033[0m %s\n' "$*" >&2; }

# ─── 1. Node 22+ ────────────────────────────────────────────────────────────

log "Checking Node.js version (need >= ${REQUIRED_NODE_MAJOR})..."
if ! command -v node >/dev/null 2>&1; then
  err "Node.js not found on PATH."
  cat <<'EOF'
Install Node 22 with one of:
  nvm:  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
        nvm install 22 && nvm use 22
  fnm:  curl -fsSL https://fnm.vercel.app/install | bash
        fnm install 22 && fnm use 22
Then re-run this script.
EOF
  exit 1
fi

NODE_MAJOR="$(node -v | sed -E 's/^v([0-9]+).*/\1/')"
if [[ "$NODE_MAJOR" -lt "$REQUIRED_NODE_MAJOR" ]]; then
  err "Node $(node -v) detected; this repo needs >= ${REQUIRED_NODE_MAJOR}."
  cat <<'EOF'
Upgrade with one of:
  nvm:  nvm install 22 && nvm use 22
  fnm:  fnm install 22 && fnm use 22
Then re-run this script.
EOF
  exit 1
fi
log "Node $(node -v) OK"

# ─── 2. pnpm via corepack ───────────────────────────────────────────────────

log "Ensuring pnpm is available..."
if command -v pnpm >/dev/null 2>&1; then
  log "pnpm $(pnpm --version) already on PATH"
else
  if command -v corepack >/dev/null 2>&1; then
    corepack enable
    corepack prepare pnpm@latest --activate
  else
    err "Neither pnpm nor corepack found. Install pnpm manually: https://pnpm.io/installation"
    exit 1
  fi
fi
log "pnpm $(pnpm --version) ready"
# Note: package.json has no "packageManager" field pinning a pnpm version as
# of this writing, so corepack activates latest. If one is added later,
# prefer `corepack prepare` (no args) to pick it up automatically.

# ─── 3. Install workspace dependencies ─────────────────────────────────────

if [[ "${SKIP_INSTALL:-0}" == "1" ]]; then
  log "SKIP_INSTALL=1 set, skipping pnpm install"
else
  log "Installing workspace dependencies (pnpm install)..."
  pnpm install
  log "Dependencies installed"
fi

# ─── 4. .env templates (placeholders only — never real keys) ──────────────

log "Setting up .env files..."

# 4a. Workspace .env (this repo, read by `pnpm dev` / electron / server-entry.js)
if [[ -f "$REPO_ROOT/.env" ]]; then
  log "  $REPO_ROOT/.env already exists — leaving it as-is"
else
  cp "$REPO_ROOT/.env.example" "$REPO_ROOT/.env"
  log "  Created $REPO_ROOT/.env from .env.example (placeholders only)"
fi

# 4b. Gateway / CLI env (hermes-agent side, NOT part of this repo).
# On macOS/Linux the gateway and CLI share one file, resolved via
# `hermes config env-path` when the hermes CLI is installed, falling back to
# ~/.hermes/.env (same convention this repo's own install.sh uses).
# On Windows these are two separate files — see SETUP.md / docs/windows-setup-guide.md.
HERMES_ENV_PATH="$(hermes config env-path 2>/dev/null || true)"
if [[ -z "$HERMES_ENV_PATH" ]]; then
  HERMES_ENV_PATH="$HOME/.hermes/.env"
fi

if [[ -f "$HERMES_ENV_PATH" ]]; then
  log "  $HERMES_ENV_PATH already exists — leaving it as-is"
else
  mkdir -p "$(dirname "$HERMES_ENV_PATH")"
  cp "$REPO_ROOT/.env.hermes-agent.example" "$HERMES_ENV_PATH"
  log "  Created $HERMES_ENV_PATH from .env.hermes-agent.example (placeholders only)"
fi

warn "Fill in real API keys/tokens yourself in:"
warn "  - $REPO_ROOT/.env"
warn "  - $HERMES_ENV_PATH"
warn "Neither file is committed (both are gitignored). Never paste real keys into a commit, PR, or chat."

# ─── 5. Build ───────────────────────────────────────────────────────────────

if [[ "${SKIP_BUILD:-0}" == "1" ]]; then
  log "SKIP_BUILD=1 set, skipping pnpm build"
else
  log "Building workspace (pnpm build)..."
  pnpm build
  log "Build complete (output: $REPO_ROOT/dist)"
fi

# ─── 6. Run instructions ───────────────────────────────────────────────────

cat <<'EOF'

Setup complete.

Before starting a NEW gateway, sanity-check one isn't already serving this workspace:
  curl http://127.0.0.1:3000/api/sessions
If that returns session data, refresh/reprobe the UI instead of spawning a duplicate gateway.

Run the three services individually (3 terminals):
  hermes gateway run                                              # :8642
  hermes dashboard --port 9119 --host 127.0.0.1 --no-open         # :9119
  pnpm dev                                                         # :3000

Or start all three from one Electron process:
  pnpm electron:dev

Then open http://localhost:3000 (or the Electron window) and complete onboarding.
EOF
