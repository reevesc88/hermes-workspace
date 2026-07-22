# Testing Strategy - <Project Name>

<!--
Tier 2 blueprint doc. What "tested" means for this project: tooling, layers, coverage bar,
and the Definition of Done every change must clear. Pairs with the `tdd-workflow` skill.
Delete guidance comments before shipping.
-->

| Field | Value |
|-------|-------|
| Owner | <!-- name --> |
| Last updated | <!-- YYYY-MM-DD --> |

## Tooling

<!-- Name the actual tools and how they run. Be specific enough to reproduce the run. -->

- Unit / integration: <!-- e.g. Vitest, run: npm test -->
- E2E: <!-- e.g. Playwright -->
- Test data / fixtures: <!-- real local DB, fixture files, no mocks except LLM -->
- CI: <!-- what runs on every push/PR -->

## Test layers

<!-- What each layer covers and where the boundary sits. Keep the pyramid honest -
most tests unit, fewer integration, fewest e2e. -->

| Layer | Covers | Tooling | Runs when |
|-------|--------|---------|-----------|
| Unit | <!-- pure functions, schemas --> | <!-- --> | <!-- every push --> |
| Contract | <!-- API request/response shapes match API-CONTRACT.md --> | <!-- --> | <!-- --> |
| Integration | <!-- routes against real local DB/storage --> | <!-- --> | <!-- --> |
| E2E | <!-- critical user flows through the UI --> | <!-- --> | <!-- pre-merge --> |

## Coverage expectations

<!-- State a bar and where it does not apply. A number nobody enforces is theatre; pick one
you will actually gate on, or say "no hard gate, but critical paths must be covered". -->

- Target: <!-- e.g. 80% on packages/shared and apps/api service layer -->
- Exemptions: <!-- e.g. generated code, thin route wrappers -->

## Acceptance-criteria convention

<!-- How a PRD/story acceptance criterion becomes a test. E.g. every AC gets at least one
named test; test names reference the AC or DEC number. -->

- <!-- convention, e.g. each acceptance criterion maps to a named test; failing cases included -->

## Definition of Done

<!-- The checklist every change clears before it is "done". Binary items only. -->

- [ ] Failing test written first, now passing (TDD).
- [ ] All acceptance criteria have a covering test.
- [ ] Unit + integration tests green locally and in CI.
- [ ] No lint / typecheck errors.
- [ ] Docs updated (PRD/DATA-MODEL/API-CONTRACT/DECISION_LOG as relevant).
- [ ] No secrets committed; no failed tests hidden or skipped.
- [ ] Migrations additive-only and applied cleanly.
- [ ] Reviewed (bot + human per repo policy) before merge.
