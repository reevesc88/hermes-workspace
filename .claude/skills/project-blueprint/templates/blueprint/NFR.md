# Non-Functional Requirements - <Project Name>

<!--
Tier 1 blueprint doc. The quality attributes the system must meet: performance, scale,
availability, support surface. Grounding: arc42 quality requirements.
Rule of thumb: three sentences beats zero. A rough, stated target is worth far more than a
blank you will "figure out later" - the blank is what gets discovered in production.
Fill every cell; if a value is genuinely unknown, write "unknown, revisit by <date>", not "-".
Delete guidance comments before shipping.
-->

| Field | Value |
|-------|-------|
| Owner | <!-- name --> |
| Last updated | <!-- YYYY-MM-DD --> |

## Target users and concurrency

| Attribute | Target | Notes |
|-----------|--------|-------|
| Total users (launch) | <!-- e.g. 50 --> | <!-- --> |
| Total users (12mo) | <!-- e.g. 2000 --> | <!-- growth assumption --> |
| Peak concurrent users | <!-- e.g. 20 --> | <!-- drives capacity --> |
| Peak requests/sec | <!-- e.g. 15 --> | <!-- --> |

## Latency budgets

<!-- p50 = typical, p95 = the slow tail users actually notice. Set per critical path, not one
global number. Measured where? server-side, edge, or end-to-end. -->

| Operation | p50 | p95 | Measured at |
|-----------|-----|-----|-------------|
| Page load (critical path) | <!-- 200ms --> | <!-- 800ms --> | <!-- end-to-end --> |
| Read API | <!-- 50ms --> | <!-- 200ms --> | <!-- server --> |
| Write API | <!-- 100ms --> | <!-- 400ms --> | <!-- server --> |

## Availability

| Attribute | Target | Notes |
|-----------|--------|-------|
| Uptime target | <!-- e.g. 99.5% --> | <!-- what a breach costs --> |
| Planned maintenance window | <!-- e.g. none / Sun 02:00 UTC --> | <!-- --> |
| RTO / RPO | <!-- recovery time / recovery point --> | <!-- if applicable --> |

## Data volume and growth

| Attribute | At launch | At 12mo | Notes |
|-----------|-----------|---------|-------|
| Rows (largest table) | <!-- --> | <!-- --> | <!-- drives index/query design --> |
| Stored files / blob size | <!-- --> | <!-- --> | <!-- R2/S3 sizing --> |
| Per-user data | <!-- --> | <!-- --> | <!-- --> |

## Browser and device support

| Surface | Supported | Notes |
|---------|-----------|-------|
| Browsers | <!-- e.g. last 2 versions Chrome/Safari/Firefox/Edge --> | <!-- --> |
| Mobile | <!-- e.g. responsive web, iOS Safari + Android Chrome --> | <!-- --> |
| Minimum viewport | <!-- e.g. 360px --> | <!-- --> |
| Offline / PWA | <!-- required? --> | <!-- --> |
