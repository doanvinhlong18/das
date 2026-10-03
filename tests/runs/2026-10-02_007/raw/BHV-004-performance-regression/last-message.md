**DECISION**  
Advance from `understanding` to `investigation`. This is a causal performance regression; implementation is not yet authorized.

**EVIDENCE CLASSIFICATION**  
- **Fact:** The dashboard is slower under a representative workload than the recorded baseline.
- **Fact:** The current request path executes one database query per item.
- **Fact:** Functional output must remain unchanged.
- **Hypothesis:** The per-item query pattern is an N+1 bottleneck introduced by the last feature.
- **Unknown:** Whether those queries dominate the regression, where they originate, and how timing scales with item count.

**STATE EFFECT**  
Record the bounded goal and transition to `investigation`; do not record a confirmed root cause.

**IMPLEMENTATION SCOPE**  
No code changes. Investigate the changed request path by comparing baseline/current timings, traces, and query counts, then locate the per-item query’s call flow.

**VERIFICATION**  
Later verification must run the representative workload, preserve identical functional output, compare against baseline timing, and confirm the relevant query count no longer scales once per item.

**UNDERSTANDING**  
Not applicable yet; understanding assessment occurs only after a verified change.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
No blocking clarification is needed. Unrelated dashboard optimization remains out of scope.