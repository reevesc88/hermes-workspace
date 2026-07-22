---
name: project-blueprint
description: "Scaffolds a tiered project blueprint document set for a new or existing software project. Detects the project's complexity tier, routes to existing skills for what they already cover, and generates only the gap docs from templates in templates/blueprint/. Produces a BLUEPRINT.md index of what the project owes at its tier. Triggers on: \"project blueprint\", \"scaffold a new project\", \"what docs does this project need\", \"blueprint set\", \"plan a new app\", \"/project-blueprint\"."
version: 1.0.0
author: Claude
platforms: [cloud, local]
metadata:
  tags: [planning, blueprint, prd, architecture, requirements, scaffolding, fundamentals]
  source: https://github.com/reevesc88/claude-config/tree/782dc01717211d3c9e8d1a120a30676dd80d137c/skills/project-blueprint
---

# project-blueprint

You scaffold a tiered "project blueprint" document set for a software project (new or existing). You reuse Calum's existing skills for what they already cover, and generate only the missing gap docs from skeletons in `templates/blueprint/`. Resolve that path relative to where this skill is installed, never the consuming repository root: in the `claude-config` source repo (and in `~/.claude`) the skeletons live at the config-root `templates/blueprint/`, a sibling of `skills/`; when this skill is vendored into another repo they are bundled alongside this `SKILL.md` under the skill's own directory (`.../project-blueprint/templates/blueprint/`). The output is a canonical, tiered doc set plus a `BLUEPRINT.md` index that says exactly which docs the project owes, their status, and where each one is sourced.

## Why this exists

The viral "6 essential docs" lists doing the rounds (PRD, App Flow, Tech Stack, Frontend Guidelines, Backend Structure, one more) are a skeleton with the muscle removed. They keep the grounded, high-signal artifacts (App Flow, Design Brief, ERD) but drop the engineering spine: non-functional requirements, threat model / auth design, API contract, test strategy + Definition of Done, and observability. A project built off the skeleton alone looks planned and fails in beta.

This skill keeps the grounded artifacts, adds back the missing spine, and adds an AU-privacy baseline (relevant for Calum's AU-facing products). It is tiered so a weekend project only owes Tier 1, while a scaled system owes the full set. It does not rebuild what existing skills already do well: for those, it routes.

## Relationship to the Plan-Gate (one-way reference)

This skill is the artifact-producing arm of the Plan-Gate (Gospel Rule 6 in `reevesc88/GitHub` CLAUDE.md). The Plan-Gate requires a written plan plus an infrastructure checklist before implementation. Running this skill produces those artifacts. This is a reference only: this skill does not modify, weaken, or satisfy the Plan-Gate on its own, and it does not claim to. The Plan-Gate still gates; this skill just fills the docs it asks for.

## Do not duplicate (Gospel Rule 9)

Skills-first, skills-gated. Several blueprint concerns are already covered by mature skills. For those, ROUTE to the existing skill, never rebuild it:

- PRD synthesis / spec extraction -> `to-spec`
- Design brief / design direction -> `design-system`, `frontend-design-direction`
- Implementation plan / roadmap -> `writing-plans`
- Architecture decision records -> `architecture-decision-records`
- Security review -> `security-review`
- API design standards -> `api-design`
- TDD practice -> `tdd-workflow`

If you find yourself about to generate a doc that one of these skills owns, stop and route instead.

## How it works

### Step 1 — Detect the complexity tier

Use this repo's existing Complexity Scale (in `claude-config/CLAUDE.md`) and map it to a blueprint Tier:

| Complexity Scale (CLAUDE.md) | Blueprint Tier | Owes |
|------------------------------|----------------|------|
| Simple (1 domain, clear output) | Tier 1 | Tier 1 docs only |
| Moderate (2 domains, some ambiguity) | Tier 1 (+ Tier 2 if it will persist) | Tier 1, selectively Tier 2 |
| Complex (3+ domains, persistent artifacts) | Tier 2 | Tier 1 + Tier 2 |
| Enterprise (cross-system, long-term) | Tier 3 | Tier 1 + Tier 2 + Tier 3 |

For an EXISTING project, infer the tier from what is actually there (number of domains, persistence, cross-system coupling), not from ambition. When genuinely ambiguous between two tiers, ask one clarifying question, then proceed. A weekend project should not be pushed past Tier 1.

### Step 2 — Produce or verify the canonical tiered doc set

All `templates/blueprint/` paths below resolve to that same skeletons directory - the config-root `templates/blueprint/` in `claude-config`/`~/.claude`, or the `templates/blueprint/` bundled beside this SKILL.md when the skill is vendored - never the consuming repository root.

For each doc the project owes at its tier:

- `[S]` items: ROUTE to the named existing skill. Do not re-generate the artifact here. Record the routing in `BLUEPRINT.md`.
- `[T]` items: GENERATE from the matching skeleton in `templates/blueprint/`. If the doc already exists in the project, VERIFY it against the skeleton's required sections and flag gaps rather than overwriting.

Always: check whether the doc already exists before writing. Never clobber an existing doc; verify and flag instead.

### Step 3 — Emit the BLUEPRINT.md index

Write `BLUEPRINT.md` at the project root (or `docs/blueprint/` if the project keeps docs there). It lists every doc the project owes at its detected tier, each doc's status (present / missing), and the routing (which skill or which template). This is the single scannable answer to "what docs does this project need, and which are done".

## Canonical tiered doc set

`[T]` = generate from `templates/blueprint/` skeleton. `[S]` = route to existing skill.

### TIER 1 — ALWAYS (every project, including weekend builds)

| Doc | Kind | Contents / routing |
|-----|------|--------------------|
| `PRD.md` | [T] | problem, target user, goals + non-goals, top user stories, success metrics, key risks, acceptance criteria, out-of-scope. Complements the `to-spec` skill |
| `DATA-MODEL.md` | [T] | mermaid ERD + entity / PK / FK / relationship table |
| `APP-FLOW.md` | [T] | screen map + user flows including error / empty / loading states |
| `NFR.md` | [T] | concurrency, latency, uptime, data-volume targets |
| `THREAT-MODEL.md` | [T] | authn / authz design, data classification, top STRIDE risks + mitigations. `security-review` [S] covers the review side |
| `PRIVACY-AU.md` | [T] | AU Privacy Act 13 APPs baseline: PII inventory, lawful basis, retention, privacy-policy pointer. Tier 1 IF the project handles personal data or is AU-facing; otherwise mark it N/A with a one-line reason |
| `DECISION_LOG.md` | [T] | canonical numbered DEC record |

`README.md` + `CLAUDE.md` are already covered by existing templates in `templates/` — do not duplicate them here.

### TIER 2 — NON-TRIVIAL (Complex / persistent projects, added on top of Tier 1)

| Doc | Kind | Contents / routing |
|-----|------|--------------------|
| `TECH-DECISIONS.md` | [T] | stack-selection matrix + ADR index. Pairs with `architecture-decision-records` [S] |
| `API-CONTRACT.md` | [T] | endpoint list + error model + OpenAPI pointer. `api-design` [S] for standards |
| `TESTING-STRATEGY.md` | [T] | tooling + Definition of Done + acceptance-criteria. `tdd-workflow` [S] for practice |
| `OBSERVABILITY.md` | [T] | logging / metrics / tracing / alerting |
| `RISK_REGISTER.md` | [T] | scored risk matrix |

Design brief -> `design-system` / `frontend-design-direction` [S]. Roadmap / implementation plan -> `writing-plans` [S].

### TIER 3 — AT SCALE (Enterprise, added on top of Tier 1 + 2)

No new templates. Reference existing skills plus deepened Tier-2 docs:

- Full STRIDE threat modelling (expand `THREAT-MODEL.md`, drive with `security-review` [S])
- Formal cost model (expand `NFR.md` with a cost section)
- Incident runbook (new operational doc, expand `OBSERVABILITY.md`)
- Formal ADR + risk cadence (`architecture-decision-records` [S] on a schedule; `RISK_REGISTER.md` review cycle)

## Output format

When run, produce:

1. Detected complexity tier and the one-line reasoning for it.
2. The owed doc set for that tier as a table: doc, kind ([T]/[S]), status (present/missing), action (generate / verify / route to <skill>).
3. Generated `[T]` docs written from `templates/blueprint/` skeletons (skipping/verifying any that already exist).
4. `BLUEPRINT.md` index at the project root (or `docs/blueprint/`).
5. A short closing list: which docs were generated, which were routed, and any docs flagged as present-but-incomplete.

## Notes

- Internal repo doc: em dashes are fine here.
- Keep generated docs practical and skimmable, not ceremonial. A doc nobody reads is worse than no doc.
- If `templates/blueprint/` is missing a skeleton for a `[T]` doc, generate a minimal version from the contents column above and note that the skeleton should be added to `templates/blueprint/`.
- Never invent architecture or decisions to fill a doc. Capture what is known, mark the rest as open, and surface open items as an explicit list (Gospel Rule 13).
