# Execution Transcript

**DECISION**

Remain in `investigation`. Compose Java exception-flow evidence with Springâ€™s effective transaction/proxy path before confirming causality.

**EVIDENCE CLASSIFICATION**

- **FACT:** A same-instance method call is ordinary Java dispatch; it does not independently pass through the surrounding Spring proxy.
- **FACT:** Catching and rethrowing preserves a checked exception unless the code wraps or converts it.
- **HYPOTHESIS:** The inner methodâ€™s transactional advice is bypassed by self-invocation, while the outer advised method receives a checked exception that does not match its effective rollback rules. Spring therefore permits the transaction to commit.
- **Would confirm:** Runtime evidence identifies the proxy entry point; source confirms self-invocation and the exact escaping checked type; effective configuration has no matching `rollbackFor`; no code calls `setRollbackOnly()`.
- **Would falsify:** The outer boundary has a matching rollback rule, an unchecked exception escapes, rollback-only is set, or runtime evidence shows another advised proxy boundary.

**STATE EFFECT**

`CONTINUE_INVESTIGATION` until those available sources are correlated. No root cause is confirmed from annotation presence or convention alone.

**IMPLEMENTATION SCOPE**

None. Read-only investigation; no files or configuration should change.

**VERIFICATION**

If causality is confirmed later, verify through the real proxied boundary by observing committed database state for the checked-failure path, not merely the thrown exception.

**UNDERSTANDING**

Not applicable yet; understanding assessment occurs only after an implemented change passes verification.