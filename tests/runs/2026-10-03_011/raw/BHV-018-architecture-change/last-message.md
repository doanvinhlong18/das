DECISION

Continue `code-investigation`; do not implement yet. Treat “move retries into a shared processing boundary” as the selected architectural direction, not proof that the design satisfies existing constraints.

EVIDENCE CLASSIFICATION

- **REQUIREMENT/DECISION:** Shared processing boundary owns retry orchestration.
- **FACT:** Consumer idempotency remains required despite centralized retries.
- **UNRESOLVED:** The available failure-mode, consumer-behavior, and observability evidence must demonstrate that the shared boundary preserves required semantics.

STATE EFFECT

Record the ownership decision and narrow the investigation accordingly. Keep dependent implementation locked until investigation returns `READY_FOR_DECOMPOSITION`.

IMPLEMENTATION SCOPE

None. No files or runtime state may be modified.

VERIFICATION

Before decomposition, confirm retry classification, attempt limits/backoff, acknowledgment behavior, poison-message handling, per-attempt observability, and consumer idempotency responsibilities at the proposed boundary.