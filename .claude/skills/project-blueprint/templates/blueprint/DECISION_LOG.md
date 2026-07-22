# DECISION_LOG.md

<!--
Tier 1 blueprint doc. The canonical, numbered record of locked decisions for this project.
This is the highest source of truth: when this log and any other doc disagree, this wins.

Relationship to ADRs (`TECH-DECISIONS.md`): ADR-NNNN records are the detailed architecture
rationale; the DEC-NNN status here is the BINDING one. Every significant ADR should be
cross-linked to a DEC-NNN, and if an ADR and its DEC ever disagree on status, the DEC wins.
A project that prefers a single system can drop the ADR index and record architecture
decisions as DEC-NNN entries directly.

Format:
- One decision per `## DEC-NNN` block, numbered sequentially and never reused.
- Fields: Date (YYYY-MM-DD), Decision (what was decided), Reason (why, incl. alternatives),
  Related ADR (optional: the ADR-NNNN in TECH-DECISIONS.md this decision details, if any),
  Status (Proposed / Accepted / Superseded).
- Append-only. Never edit a decided block to reverse it: add a later DEC that supersedes it,
  or an `### Addendum (YYYY-MM-DD)` under the original for clarifications and follow-ups.
- Mark a reversed decision `Status: Superseded by DEC-NNN`.

Delete this comment block before shipping; keep the DEC-001 example or replace it with a real one.
-->

## DEC-001

Date: <!-- YYYY-MM-DD -->

Decision: <!-- The single thing that was decided, stated plainly. -->

Reason: <!-- Why this over the alternatives. Name the alternatives considered. -->

Related ADR: <!-- ADR-NNNN if this decision has a detailed ADR in TECH-DECISIONS.md, else - -->

Status: Accepted
