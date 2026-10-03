DECISION

Route `investigation -> understanding -> investigation` to record the architecture choice, then evaluate it against the available constraints. Do not implement yet.

EVIDENCE CLASSIFICATION

- FACT: Retry ownership is requested at the shared processing boundary.
- FACT: Consumers must remain idempotent despite centralized retries.
- UNKNOWN: Whether shared retries preserve existing failure semantics, exhaustion handling, and observability across consumers.
- Root cause: Not applicable; this is an architecture change.

STATE EFFECT

Update expected behavior and invalidate prior retry-location assumptions. Dependent implementation remains locked. Readiness is `READY_FOR_INVESTIGATION`.

IMPLEMENTATION SCOPE

Eventually centralize retry orchestration while preserving consumer idempotency and required metrics/tracing. No files change now.

VERIFICATION

Later demonstrate shared retry policy, correct exhaustion routing, preserved observability, no nested duplicate retries, and safe duplicate delivery handling.

UNDERSTANDING

No gate question now. Assess applicability once the architecture is evidence-supported; this cross-cutting ownership decision may warrant a gate before dependent implementation proceeds.