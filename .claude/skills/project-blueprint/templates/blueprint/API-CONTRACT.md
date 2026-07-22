# API Contract - <Project Name>

<!--
Tier 2 blueprint doc. The wire contract between client and server: endpoints, auth, request
and response shapes, and the standard error model. Pairs with the `api-design` skill - run it
for URL structure, status-code, and versioning conventions. Keep the OpenAPI stub in sync with
the endpoint table. Delete guidance comments before shipping.
-->

| Field | Value |
|-------|-------|
| Owner | <!-- name --> |
| Last updated | <!-- YYYY-MM-DD --> |
| Base URL | <!-- e.g. /api/v1 --> |
| Auth scheme | <!-- e.g. session cookie / bearer token --> |

## Endpoints

<!-- One row per endpoint. Auth: what identity/permission is required. Request/Response: the
schema name or a one-line shape. Errors: the status codes this endpoint can return. -->

| Method | Path | Purpose | Auth | Request | Response | Errors |
|--------|------|---------|------|---------|----------|--------|
| GET | /items | <!-- list items --> | <!-- session --> | <!-- query params --> | <!-- Item[] --> | <!-- 401 --> |
| POST | /items | <!-- create item --> | <!-- session --> | <!-- CreateItem --> | <!-- Item --> | <!-- 400, 401 --> |
| GET | /items/:id | <!-- get one --> | <!-- session --> | <!-- - --> | <!-- Item --> | <!-- 401, 404 --> |
| DELETE | /items/:id | <!-- delete --> | <!-- session --> | <!-- - --> | <!-- {id} --> | <!-- 401, 404 --> |

## Standard error model

<!-- One shape for every error response, so clients parse errors uniformly. -->

```json
{
  "error": "human-readable message",
  "code": "MACHINE_READABLE_CODE",
  "details": {}
}
```

<!-- Conventions:
  400 validation error, 401 unauthenticated, 403 forbidden, 404 not found, 409 conflict,
  422 semantic validation, 429 rate limited, 500 server error.
  Do not leak which of "not found" vs "not yours" occurred - return 404 for both. -->

## OpenAPI stub

<!-- Minimal OpenAPI 3.1. Grow this into the real spec; keep it aligned with the table above. -->

```yaml
openapi: 3.1.0
info:
  title: <Project Name> API
  version: 0.1.0
servers:
  - url: /api/v1
paths:
  /items:
    get:
      summary: List items
      security:
        - sessionCookie: []
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Item'
        '401':
          $ref: '#/components/responses/Error'
    post:
      summary: Create item
      security:
        - sessionCookie: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateItem'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Item'
        '400':
          $ref: '#/components/responses/Error'
components:
  securitySchemes:
    sessionCookie:
      type: apiKey
      in: cookie
      name: session
  schemas:
    Item:
      type: object
      required: [id, name]
      properties:
        id: { type: string }
        name: { type: string }
    CreateItem:
      type: object
      required: [name]
      properties:
        name: { type: string }
    Error:
      type: object
      required: [error]
      properties:
        error: { type: string }
        code: { type: string }
        details: { type: object }
  responses:
    Error:
      description: Error response
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
```
