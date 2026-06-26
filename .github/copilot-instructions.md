# Copilot Instructions — hermes-workspace

Full-stack web workspace application for interacting with local Hermes AI agents.

## Stack
- Frontend: TypeScript/React (check package.json for specifics)
- Connects to Hermes API on port 8642
- Dashboard served on port 9119
- Cal accesses from iPhone — keep mobile-responsive

## Key Rules
- API keys and secrets in `.env` only — never committed
- Services bind to `0.0.0.0` for Tailnet access (IP: 100.108.75.69)
- Do not use `127.0.0.1` if Tailnet access is needed
- Keep features behind feature flags where possible

## Token Budget
See conductor-brain repo (CONTEXT_CONTROL.md) for agent delegation rules.
