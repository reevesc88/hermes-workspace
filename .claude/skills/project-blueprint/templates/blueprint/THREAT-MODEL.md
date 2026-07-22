# Threat Model - <Project Name>

<!--
Tier 1 blueprint doc. Lightweight security model. Grounding: OWASP threat modeling - the
guidance is explicit that for most teams this is a lightweight CHECKLIST run early and often,
not a heavy one-off ritual. Aim for one honest pass that names the real risks and their
mitigations, then revisit when the design changes. Delete guidance comments before shipping.
-->

| Field | Value |
|-------|-------|
| Owner | <!-- name --> |
| Last updated | <!-- YYYY-MM-DD --> |
| Scope | <!-- what system boundary this covers --> |

## Authentication and authorization design

<!-- How identity is established (authn) and what each identity is allowed to do (authz).
Name the mechanism, session model, and where the authz check lives. -->

- **Authentication:** <!-- e.g. email+password, sessions in DB, cookie flags -->
- **Authorization:** <!-- e.g. every resource scoped by user_id, check in service layer -->
- **Session handling:** <!-- lifetime, revocation, refresh -->

## Data classification

<!-- Classify what you store so the mitigations can be proportionate. Sensitivity drives
storage choice and retention. -->

| Data | Sensitivity | Storage | Retention |
|------|-------------|---------|-----------|
| <!-- e.g. email --> | <!-- PII --> | <!-- D1, encrypted at rest --> | <!-- until account deletion --> |
| <!-- e.g. session token --> | <!-- secret --> | <!-- DB, httpOnly cookie --> | <!-- session lifetime --> |
| <!-- e.g. uploaded file --> | <!-- user content --> | <!-- R2, per-user prefix --> | <!-- see PRIVACY-AU.md --> |

## STRIDE checklist

<!-- One line per category. If a category does not apply, say why rather than deleting the row -
"N/A because ..." is a decision; a blank is an oversight. -->

| Category | Risk | Mitigation |
|----------|------|------------|
| Spoofing | <!-- impersonation of a user/service --> | <!-- auth, TLS, signed tokens --> |
| Tampering | <!-- unauthorised data modification --> | <!-- authz checks, input validation, integrity --> |
| Repudiation | <!-- action denied later, no proof --> | <!-- audit log, request ids --> |
| Information disclosure | <!-- data leak across users/boundaries --> | <!-- user scoping, no oracle in errors --> |
| Denial of service | <!-- resource exhaustion --> | <!-- rate limits, size caps, timeouts --> |
| Elevation of privilege | <!-- gaining rights not granted --> | <!-- least privilege, deny-by-default --> |

## Secrets handling

<!-- Where secrets live, how they are injected, and the rule that keeps them out of the repo. -->

- Secrets live in <!-- e.g. Wrangler secrets / env, never committed -->.
- `.env` is gitignored; `.env.example` documents the keys with no values.
- No secret in source, PR body, logs, or chat. <!-- rotation policy if any -->
