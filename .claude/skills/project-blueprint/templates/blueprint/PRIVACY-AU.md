# Privacy (AU) - <Project Name>

<!--
Tier 1 blueprint doc. Baseline compliance with the Australian Privacy Act 1988 and the 13
Australian Privacy Principles (APPs), as administered by the OAIC. REQUIRED for any AU SaaS
that handles personal data. If the project handles NO personal data and is not AU-facing (e.g.
an internal CLI, or a pipeline with no user accounts), mark this doc N/A at the top with a
one-line reason and skip the rest - the same escape hatch THREAT-MODEL.md gives per STRIDE row.
AU privacy obligations are actively enforced by the OAIC; check the OAIC's current enforcement
priorities when filling this in. A documented privacy posture is evidence, not box-ticking. This
is a baseline, not legal advice; get a lawyer for anything high-stakes. Delete guidance comments
before shipping.
-->

| Field | Value |
|-------|-------|
| Owner | <!-- name --> |
| Last updated | <!-- YYYY-MM-DD --> |
| Privacy policy | <!-- URL to the public privacy policy --> |

## PII inventory

<!-- Every item of personal information the product touches. "Collection basis" is APP 3 (lawful
and fair collection; collection must be reasonably necessary for a function/activity; consent is
required only for sensitive information). "Hosting location" is where the data is stored - keeping
it offshore may still be a "use" rather than a "disclosure" if the entity keeps control. "Overseas
disclosure" is the separate APP 8 concern: disclosing PII to an overseas recipient. -->

| Data item | Purpose | Collection basis (APP 3: reasonably necessary; consent only for sensitive info) | Retention | Hosting location | Overseas disclosure (APP 8) |
|-----------|---------|--------------|-----------|----------|-----------------------------|
| <!-- email --> | <!-- account identity --> | <!-- necessary for service --> | <!-- until deletion --> | <!-- AU / offshore region --> | <!-- none / recipient + country --> |
| <!-- name --> | <!-- --> | <!-- --> | <!-- --> | <!-- --> | <!-- --> |
| <!-- uploaded content --> | <!-- --> | <!-- --> | <!-- --> | <!-- --> | <!-- --> |

## Consent and notice (APP 1, APP 5)

<!-- How and when you tell users what you collect and why, before/at collection.
Point to the collection notice and privacy policy. -->

- Collection notice shown at <!-- e.g. signup, upload -->.
- Privacy policy is available at <!-- URL --> and covers <!-- what --> .

## Access, correction, deletion (APP 12, APP 13)

<!-- Users can request access to and correction of their PII. Describe the mechanism and SLA. -->

- **Access:** <!-- how a user gets a copy of their data --> .
- **Correction:** <!-- how a user fixes wrong data --> .
- **Deletion:** <!-- self-serve or request; soft vs hard delete; see DECISION_LOG --> .

## Retention minimisation (APP 11)

<!-- Hold PII only as long as needed for the stated purpose (or a legal obligation).
Name the retention rule and any legal hold (e.g. AU tax record-keeping ~5 years). -->

- <!-- retention rule per data class, and any legal minimum that overrides deletion -->

## Privacy policy pointer

<!-- The single canonical link. Every collection point should reference it. -->

Public privacy policy: <!-- URL --> . Last reviewed: <!-- YYYY-MM-DD --> .
