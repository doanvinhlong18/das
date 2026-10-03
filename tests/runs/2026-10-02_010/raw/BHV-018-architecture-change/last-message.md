DECISION  
Return from investigation to task understanding. The user has resolved the architectural ownership choice; this is not authorization to implement immediately.

EVIDENCE CLASSIFICATION  
- **FACT:** Retry orchestration is requested in the shared processing boundary.
- **FACT:** Consumers must remain idempotent because centralized retries still permit repeated delivery or processing.
- **HYPOTHESIS:** The shared boundary can satisfy the available failure-mode and observability requirements; investigation must validate this before decomposition.
- **ROOT CAUSE:** Not applicable; this is an architecture change.

STATE EFFECT  
Update the requested behavior and invalidate the unresolved ownership comparison. Keep dependent implementation locked, then resume investigation against the selected architecture.

IMPLEMENTATION SCOPE  
No files modified. No production step activated.

VERIFICATION  
Later verification must cover retry eligibility, attempt limits/backoff, terminal failure handling, consumer idempotency, and per-attempt observability.

UNDERSTANDING  
No understanding gate applies at this stage.