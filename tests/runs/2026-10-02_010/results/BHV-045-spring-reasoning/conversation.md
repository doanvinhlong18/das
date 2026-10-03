# Execution Transcript

DECISION  
Move from task understanding to focused investigation; do not treat `@Transactional` presence as proof that a transaction existed.

EVIDENCE CLASSIFICATION  
- **Observed fact:** Database changes remain after the inner method throws.
- **Observed fact:** The outer method invokes the annotated inner method through `this`.
- **Leading hypothesis:** Self-invocation bypasses the Spring proxy, so the inner method’s `@Transactional` interceptor never starts a transaction.
- **Not yet confirmed:** Whether the outer method already has a transaction, which transaction manager is active, and whether the thrown exception matches rollback rules.

STATE EFFECT  
Set workflow stage to `investigation`; root cause remains unconfirmed.

IMPLEMENTATION SCOPE  
None. Inspect the runtime proxy identity and transaction begin/commit/rollback logs first.

VERIFICATION  
Confirm that the call does not cross the proxy and that no transaction begins at the annotated inner method. Also inspect exception type and rollback configuration. If confirmed, verify a later fix through an external proxied call and assert committed database state after the exception.

UNDERSTANDING  
Not assessed until a fix is implemented and independently verified.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
No blocking question. The likely explanation is proxy-bypassing self-invocation, but transaction logs must confirm it before declaring root cause.
