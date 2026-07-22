# Observability - <Project Name>

<!--
Tier 2 blueprint doc. How you will see what the running system is doing: logs, metrics,
traces, alerts, dashboards. If it breaks in production, this doc is what lets you find out
before a user tells you. Delete guidance comments before shipping.
-->

| Field | Value |
|-------|-------|
| Owner | <!-- name --> |
| Last updated | <!-- YYYY-MM-DD --> |

## Logging

<!-- Structured logs preferred (JSON). Name the fields every log line carries and the levels. -->

- Format: <!-- structured JSON --> . Standard fields: <!-- request_id, user_id (if safe), route, status, latency_ms -->
- Levels: <!-- error / warn / info; debug off in prod -->
- Never log: <!-- secrets, full PII, tokens -->

## Metrics

<!-- The handful of numbers that tell you if the system is healthy. RED: Rate, Errors,
Duration. Plus any business metric worth a graph. -->

| Metric | Type | Why it matters |
|--------|------|----------------|
| Request rate | counter | <!-- traffic --> |
| Error rate | counter | <!-- health --> |
| p95 latency | histogram | <!-- ties to NFR.md budget --> |
| <!-- business metric --> | <!-- --> | <!-- --> |

## Tracing

<!-- Request-level tracing: correlation id propagated through the stack so one request can be
followed end to end. Note if not yet wired. -->

- Correlation id: <!-- generated at edge, propagated to logs --> .
- Distributed tracing: <!-- tool / not yet -->

## Alerting and on-call

<!-- What pages a human, at what threshold, and who responds. An alert nobody owns is noise. -->

| Alert | Condition | Severity | Notify |
|-------|-----------|----------|--------|
| <!-- error spike --> | <!-- error rate > X% for 5m --> | <!-- page --> | <!-- who --> |
| <!-- latency breach --> | <!-- p95 > budget for 10m --> | <!-- ticket --> | <!-- who --> |

## Dashboards

<!-- Where the above is visualised, and the one dashboard you would open first in an incident. -->

- Primary dashboard: <!-- link --> .

## Cloudflare Workers note

<!-- Common stack for these projects. Workers observability differs from a long-lived server:
there is no process to attach to, so logs and analytics are the primary window. -->

- **Workers Analytics Engine** for custom metrics (write data points from the Worker, query via SQL API).
- **Logpush** to ship request/Worker logs to R2 or an external sink for retention and search (`wrangler tail` is live-only, not a store).
- **Workers Trace Events / `tail` Workers** to capture structured events per request.
- Watch the free-tier limits (CPU ms, subrequests) as an operational signal, not just a billing one.
