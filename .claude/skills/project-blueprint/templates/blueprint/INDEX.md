# Project Blueprint Standard - Index

<!--
Master index for the tiered project-blueprint standard. Copy the docs you need from this
directory into a new project and fill them in. This index is the map; the other files are
the territory.
-->

## What this is

A tiered set of planning artifacts every project should produce before (and during) build.
It is the **artifact arm of the Plan-Gate (Gospel Rule 6)**: the Plan-Gate says do not
implement without a complete plan; this standard defines what "complete" concretely means as
a set of documents. Some artifacts are **templates that live here `[T]`**; others are
**routed to an existing skill `[S]`** that already produces them - do not rebuild what a skill
already does (Gospel Rule 9, skills-first).

## The three tiers

- **Tier 1 - Product and safety baseline.** What is being built, for whom, the data, the flows,
  the quality bar, and the security/privacy floor. Every project owes Tier 1.
- **Tier 2 - Technical depth.** The stack rationale, the API contract, the test and
  observability plans, the scored risks. Owed by anything real - shared, paid, or
  production-bound (see SKILL.md Step 1 for the exact Complexity-Scale -> Tier mapping; a
  Moderate project stays Tier 1 unless it will persist).
- **Tier 3 - At scale.** Deepened versions of the Tier 1/2 docs, owed only under team / revenue /
  compliance pressure: a full STRIDE threat model, a formal cost model, an incident-response
  runbook, and a formal ADR / risk-review cadence. Mostly deeper use of the same skills, not new
  templates.

**Weekend-project rule:** a weekend project only owes **Tier 1**. Do not make a throwaway
carry Tier 2/3 ceremony. Scale the artifact set to the stakes.

## Tier 1 (template docs `[T]`)

| Doc | Tier | Type | Purpose | Also routes to |
|-----|------|------|---------|----------------|
| `PRD.md` | 1 | `[T]` | Problem, users, goals, stories, acceptance criteria | also `[S]` `to-spec` |
| `DATA-MODEL.md` | 1 | `[T]` | Entities, fields, relationships (mermaid erDiagram) | - |
| `APP-FLOW.md` | 1 | `[T]` | Screen map + per-screen empty/loading/error states | - |
| `NFR.md` | 1 | `[T]` | Concurrency, latency budgets, uptime, volume, device support | - |
| `THREAT-MODEL.md` | 1 | `[T]` | Lightweight authn/authz, data classification, STRIDE, secrets | also `[S]` `security-review` for deep pass |
| `PRIVACY-AU.md` | 1* | `[T]` | AU Privacy Act / 13 APPs baseline, PII inventory (*Tier 1 if the project handles personal data or is AU-facing; else mark N/A) | - |
| `DECISION_LOG.md` | 1 | `[T]` | Canonical numbered decision record (DEC-NNN) | - |

## Tier 2 (template docs `[T]`)

| Doc | Tier | Type | Purpose | Also routes to |
|-----|------|------|---------|----------------|
| `TECH-DECISIONS.md` | 2 | `[T]` | Stack-selection matrix + ADR index (the TRD) | also `[S]` `architecture-decision-records` |
| `API-CONTRACT.md` | 2 | `[T]` | Endpoint list, error model, OpenAPI 3.1 stub | also `[S]` `api-design` |
| `TESTING-STRATEGY.md` | 2 | `[T]` | Tooling, test layers, coverage, Definition of Done | also `[S]` `tdd-workflow` |
| `OBSERVABILITY.md` | 2 | `[T]` | Logging, metrics, tracing, alerting, dashboards | - |
| `RISK_REGISTER.md` | 2 | `[T]` | Scored risk matrix with owners and review dates | - |

## Tier 3 (at scale - no static template)

Owed only under team / revenue / compliance pressure. These are deeper versions of the Tier 1/2
docs, produced mostly through the same skills, not new templates:

- Full STRIDE threat model + data-classification scheme (deepens `THREAT-MODEL.md`).
- Formal cost model / budget (compute, storage, API/LLM spend).
- Incident-response runbook + rollback playbook (deepens `OBSERVABILITY.md`).
- Formal ADR discipline + a risk-review cadence (deepens `TECH-DECISIONS.md` / `RISK_REGISTER.md`).

## Routing: artifacts an existing skill already owns `[S]`

Do NOT template these - invoke the skill (Gospel Rule 9). They apply across tiers, not only Tier 3.

| Artifact | Skill |
|----------|-------|
| PRD synthesis | `to-spec` |
| Design brief / UI direction | `design-system`, `frontend-design-direction` |
| Roadmap / implementation plan | `writing-plans` |
| Architecture Decision Records | `architecture-decision-records` |
| Deep security review | `security-review` |
| API standards / conventions | `api-design` |
| Test practice / TDD loop | `tdd-workflow` |

## Grounding sources

- **arc42** - non-functional / quality requirements (`NFR.md`).
- **OWASP** - threat modeling as a lightweight checklist, run early, not a heavy ritual (`THREAT-MODEL.md`).
- **Azure / Google Cloud Well-Architected** - architecture decision records, record the why (`TECH-DECISIONS.md`, ADRs).
- **Atlassian** - product requirements doc structure (`PRD.md`).
- **AU OAIC / Australian Privacy Principles** - privacy baseline for AU SaaS (`PRIVACY-AU.md`).
