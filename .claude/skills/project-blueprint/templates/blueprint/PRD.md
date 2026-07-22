# PRD - <Project Name>

<!--
Tier 1 blueprint doc. Complements the `to-spec` skill: run `/to-spec` to turn this
filled-in PRD into an implementation-ready spec. Keep this doc product-level (what and
why), not implementation-level (how). Delete every guidance comment before shipping.
Grounding: Atlassian PRD structure.
-->

| Field | Value |
|-------|-------|
| Status | <!-- Draft / In review / Approved --> |
| Owner | <!-- name --> |
| Last updated | <!-- YYYY-MM-DD --> |
| Related docs | <!-- links to NFR.md, DATA-MODEL.md, APP-FLOW.md, DECISION_LOG.md --> |

## Problem

<!-- One paragraph. What is broken or missing today, and for whom. Evidence, not assertion. -->

## Target user

<!-- Who this is for. Be specific: role, context, what they are trying to get done.
One primary persona beats three vague ones. -->

## Goals

<!-- Bullet the outcomes this release must achieve. Each goal maps to a success metric below. -->

- <!-- goal 1 -->
- <!-- goal 2 -->

## Non-goals

<!-- What you are deliberately NOT doing this release. This is where scope discipline lives. -->

- <!-- non-goal 1 -->

## Top user stories

<!-- Format: As a <user>, I want <capability>, so that <outcome>. Order by priority. -->

1. As a <!-- user -->, I want <!-- capability -->, so that <!-- outcome -->.
2. As a <!-- user -->, I want <!-- capability -->, so that <!-- outcome -->.

## Functional summary

<!-- Bullet the capabilities the product must provide. One line each. This is the WHAT.
Detailed flows live in APP-FLOW.md, data in DATA-MODEL.md. -->

- <!-- capability -->

## Non-functional summary

<!-- Do not restate the numbers here. Point to NFR.md and name the categories that matter
most for this project (e.g. latency, concurrency, availability). -->

See `NFR.md` for targets. Load-bearing categories for this project: <!-- e.g. p95 latency, uptime, data volume -->.

## Success metrics

<!-- How you will know each goal was met. Measurable. Baseline -> target where possible. -->

| Metric | Baseline | Target | How measured |
|--------|----------|--------|--------------|
| <!-- metric --> | <!-- --> | <!-- --> | <!-- --> |

## Key risks

<!-- Top product/delivery risks. Scored risks with mitigations live in RISK_REGISTER.md;
list the headline ones here so the PRD stands alone. -->

- <!-- risk + why it matters -->

## Acceptance criteria

<!-- The release is done when all of these are true. Testable, binary, no "should". -->

- [ ] <!-- criterion -->
- [ ] <!-- criterion -->

## Out of scope

<!-- Explicitly parked. Distinct from non-goals: these are things a reader might reasonably
assume are included. Name them so nobody has to ask. -->

- <!-- item -->
