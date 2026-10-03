DECISION  
Continue investigation by composing Java exception-flow evidence with Spring transaction/proxy evidence. Do not modify code or confirm causality yet.

EVIDENCE CLASSIFICATION  
- FACT: The Java source catches and rethrows a checked failure.
- FACT: The call is between methods on the same service instance.
- FACT: Spring configuration and runtime proxy evidence exist, but their exact contents are not provided here.
- HYPOTHESIS: Self-invocation bypasses Spring’s transactional proxy, so transaction metadata on the called method is not applied.
- HYPOTHESIS: The effective transaction sees a checked exception and uses default rollback rules, which normally do not mark rollback unless configured with `rollbackFor` or marked rollback-only explicitly.

STATE EFFECT  
Remain in `investigation`. No confirmed root cause or implementation step is recorded.

VERIFICATION  
Correlate the exact rethrown exception type with the effective outer transaction’s rollback rules, then confirm from runtime evidence that the internal call does not cross the proxy. The committed database state is the observable rollback result.

UNDERSTANDING  
If both hypotheses are supported, the composed explanation is: Java preserves a checked exception at the transaction boundary, while Spring self-invocation prevents the inner transactional advice from running; the effective transaction therefore commits under its checked-exception rollback policy.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
The exact annotations/configuration and proxy trace are required before promoting this explanation to a confirmed root cause.