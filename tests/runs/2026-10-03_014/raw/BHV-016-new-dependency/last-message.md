**DECISION**

Stop Step 2 implementation. Treat schema support as an explicitly approved scope expansion and a new prerequisite; route back to **task decomposition**, not ad hoc implementation.

**EVIDENCE CLASSIFICATION**

- Confirmed fact: required schema capability is absent.
- Invalidated assumption: Step 2’s plan assumed that capability already existed.
- Risk: schema migration is independently consequential and must precede the behavior change.

**STATE EFFECT**

- Preserve the invalidated assumption and contradictory repository evidence.
- Reconcile and record Step 2’s partial changes; safe reconciliation is available.
- Release Step 2, record the approved expansion, and lock Step 2 behind the schema prerequisite.
- Transition from implementation to decomposition.

**IMPLEMENTATION SCOPE**

Decompose a separate schema/migration step with its own expected behavior and verification. Only that prerequisite may become active; Step 2 remains locked until it passes verification and any required ownership checkpoint.

**VERIFICATION**

Verify the migration independently before resuming Step 2. “Finish the feature” does not permit combining both steps or bypassing verification.