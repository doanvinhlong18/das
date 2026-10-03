**DECISION**  
Run `task-understanding` and return `READY_FOR_MINIMAL_DECOMPOSITION`. Direct evidence supports a local, mechanical, low-risk fix; separate investigation is unnecessary. Do not implement yet.

**EVIDENCE CLASSIFICATION**  
- Facts: stack trace identifies the formatter; inspected code dereferences the nullable phone; focused reproduction fails only when phone is absent; documented contract allows absence and requires an empty display value.
- Unknowns: none blocking.
- Do not record a confirmed root cause during `understanding`; preserve the observations as direct evidence.

**STATE EFFECT**  
Set the task to minimal mode and transition from `understanding` to `decomposition`.

**IMPLEMENTATION SCOPE**  
Prepare one bounded step: make the formatter render an absent phone as empty while preserving existing formatting for present values. Exclude unrelated formatter refactoring or customer-model changes.

**VERIFICATION**  
Define focused checks before coding: absent phone produces an empty display without exception; present phone behavior remains unchanged.

**UNDERSTANDING**  
Not applicable yet; assess only after successful verification.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
None.