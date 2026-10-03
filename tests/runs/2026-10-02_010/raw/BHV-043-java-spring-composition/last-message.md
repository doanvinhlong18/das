**DECISION**  
Explain the result as a composition of Java exception semantics and Spring proxy-based transaction rules; no implementation is appropriate.

**EVIDENCE CLASSIFICATION**  
- **Java evidence:** Catching and rethrowing the same checked exception does not convert it into an unchecked exception. The transaction interceptor ultimately receives a checked failure.
- **Spring evidence:** The external service call crosses the runtime transactional proxy, but the subsequent same-instance call is self-invocation and does not cross that proxy.
- **Combined result:** Any `@Transactional(rollbackFor = ...)` or propagation setting declared only on the internally called method is not independently applied. The active outer transaction uses its own rollback rules.
- Under Spring’s default rules, a checked exception does not cause rollback unless the effective outer transaction explicitly includes it through `rollbackFor` or is marked rollback-only.

**STATE EFFECT**  
The evidence supports the root cause: **self-invocation bypasses the inner transactional advice, and the effective outer transaction does not roll back for the rethrown checked exception**.

**IMPLEMENTATION SCOPE**  
None requested. A future fix must target the effective proxy boundary—for example, configure `rollbackFor` on the externally invoked method or move the inner operation behind another proxied bean.

**VERIFICATION**  
Confirm with a focused Spring integration test that calls the external proxy, triggers the checked exception, and observes committed state; then repeat with the rollback rule applied at the effective outer boundary and observe rollback.

**UNDERSTANDING**  
No Understanding Gate is needed because no code change or ownership-sensitive technical decision has been made.