# Execution Transcript

**DECISION**  
Continue investigation; do not declare root cause from `@Transactional` alone.

**EVIDENCE CLASSIFICATION**  
- **Fact:** The outer method invokes the annotated method through `this`.
- **Fact:** Database changes remain after the inner method throws.
- **Hypothesis:** Self-invocation bypasses Springâ€™s transactional proxy, so the inner methodâ€™s `@Transactional` advice never starts or controls a transaction.
- **Alternatives:** An existing outer transaction, caught exception, checked exception rollback rules, propagation settings, or a different transaction manager/data source could explain the result.

**STATE EFFECT**  
Remain in `investigation`; no confirmed root cause yet.

**IMPLEMENTATION SCOPE**  
None. Inspect the runtime bean/proxy identity and transaction logs around the call. Confirm whether a transaction begins before the inner method and whether rollback is marked after the exception.

**VERIFICATION**  
A confirmed cause requires evidence that the call stays on the target instance rather than crossing the proxy, with no transaction opened by the inner annotation. Later verification should exercise the real proxy boundary and confirm committed state versus rollback.

**UNDERSTANDING**  
Not applicable until a change is implemented and verified.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
Also record the exception type, whether it is caught or translated, the outer methodâ€™s transaction status, propagation, and the effective transaction manager.