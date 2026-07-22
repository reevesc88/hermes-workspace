# Technical Decisions (TRD) - <Project Name>

<!--
Tier 2 blueprint doc. The real Technical Requirements Doc: the stack, chosen deliberately,
with the WHY recorded - not just a list of technologies. Pairs with the
`architecture-decision-records` skill: each significant, hard-to-reverse choice below should
also have a full ADR record, indexed at the bottom. Grounding: Azure / Google Cloud
Well-Architected guidance on architecture decision records. Record the rationale and the
constraints it satisfies, so a future reader knows why, not just what. Delete guidance
comments before shipping.
-->

| Field | Value |
|-------|-------|
| Owner | <!-- name --> |
| Last updated | <!-- YYYY-MM-DD --> |

## Stack selection matrix

<!-- One row per layer. "Why" is the load-bearing column - fill it. "Constraints/NFRs it meets"
ties the choice back to NFR.md (e.g. p95 budget, concurrency, zero-ops). -->

| Layer | Chosen | Alternatives considered | Why | Constraints/NFRs it meets |
|-------|--------|-------------------------|-----|---------------------------|
| Web frontend | <!-- e.g. Preact + Vite --> | <!-- React, Svelte --> | <!-- --> | <!-- bundle size, TTI --> |
| Mobile | <!-- e.g. responsive web / none --> | <!-- native, RN --> | <!-- --> | <!-- --> |
| Backend | <!-- e.g. Hono on Workers --> | <!-- Express, Fastify --> | <!-- --> | <!-- latency, zero-ops --> |
| Database | <!-- e.g. D1 + Drizzle --> | <!-- Postgres, Turso --> | <!-- --> | <!-- scale, cost --> |
| Cloud / hosting | <!-- e.g. Cloudflare --> | <!-- AWS, Vercel --> | <!-- --> | <!-- edge, egress cost --> |
| Auth | <!-- --> | <!-- --> | <!-- --> | <!-- --> |
| File storage | <!-- --> | <!-- --> | <!-- --> | <!-- --> |

## ADR index

<!-- Point at the full ADR records. Keep one ADR per significant decision. Status: Proposed /
Accepted / Superseded. Cross-link every ADR to a DEC-NNN in DECISION_LOG.md; where the two
overlap, the DEC status is BINDING and the ADR status is the architecture detail. A project that
prefers one system can drop this ADR index and record architecture decisions as DEC-NNN directly. -->

| ADR | Title | Status | Date | DEC | Link |
|-----|-------|--------|------|-----|------|
| ADR-0001 | <!-- e.g. Use Cloudflare Workers for backend --> | <!-- Accepted --> | <!-- YYYY-MM-DD --> | <!-- DEC-NNN --> | <!-- path/URL --> |
| ADR-0002 | <!-- --> | <!-- --> | <!-- --> | <!-- --> | <!-- --> |
