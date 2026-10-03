DECISION  
Proceed from task understanding to focused investigation; do not declare root cause from the annotation alone.

EVIDENCE CLASSIFICATION  
- **Fact:** Partial database changes remain after the inner method throws.
- **Fact:** The outer method invokes the annotated method through `this`.
- **Hypothesis:** Self-invocation bypasses Spring’s transactional proxy, so the inner `@Transactional` interceptor never starts or joins a transaction.
- **Alternatives:** The exception was caught, excluded by rollback rules, or changes used another transaction manager/thread.

STATE EFFECT  
Investigation active; no implementation or decomposition yet.

IMPLEMENTATION SCOPE  
Read-only inspection of bean/proxy identity, call path, effective transaction manager, propagation, exception flow, and transaction begin/commit/rollback logs.

VERIFICATION  
Confirm whether the call crosses a Spring proxy and whether logs show a transaction beginning before the inner method. If `this.innerMethod()` executes on the target with no transactional interceptor, the annotation is ineffective for that call, explaining the missing rollback.

UNDERSTANDING  
`@Transactional` normally applies through Spring proxy interception. An internal `this` call does not cross that proxy; annotation presence alone does not establish an active transaction.