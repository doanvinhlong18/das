DECISION  
Do not flip the condition or use the trivial fast path. Route this as standard, risky work requiring investigation.

EVIDENCE CLASSIFICATION  
- **Reported facts:** Concurrent workers can race; duplicate execution has financial impact.
- **Proposed solution:** Flipping the compare-and-set condition.
- **Unknown:** Actual state-transition semantics, condition ownership, race sequence, and whether inversion prevents or causes duplicates.
- **Root cause:** Not established.

STATE EFFECT  
`understanding` → `investigation`; no implementation is authorized.

IMPLEMENTATION SCOPE  
None yet. Investigation must trace the compare-and-set operation, callers, expected old/new states, and duplicate-execution path before decomposition.

VERIFICATION  
Require a focused concurrent reproduction or equivalent deterministic test proving exactly one worker executes the job and failed compare-and-set attempts cannot produce side effects.

UNDERSTANDING  
The small diff size does not make this low risk. Financial impact, concurrency, and unverified transition semantics disqualify the one-line fast path.