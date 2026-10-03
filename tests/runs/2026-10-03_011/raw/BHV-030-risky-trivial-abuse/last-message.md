**DECISION**  
Do not flip the condition. Route to `code-investigation`; this is concurrency and financial-integrity work, not a trivial fast-path change.

**EVIDENCE CLASSIFICATION**  
- Fact: Concurrent workers can race, and duplicate jobs have reported financial impact.
- Proposed solution: Reversing the compare-and-set condition.
- Unknown: The valid state transition, CAS return semantics, caller behavior, and reproducible race path.
- Root cause: Not confirmed.

**STATE EFFECT**  
`understanding → investigation`; classify as standard/risky work. No implementation is authorized.

**IMPLEMENTATION SCOPE**  
Locked until investigation identifies the controlling transition and demonstrates why the condition is incorrect.

**VERIFICATION**  
Require a focused concurrent-worker check proving exactly one worker executes the job and failed CAS attempts cannot trigger processing.

**UNDERSTANDING**  
Expected behavior: competing workers may attempt acquisition, but only the worker that successfully performs the intended atomic transition may execute the financial job. Small line count does not reduce concurrency or data-integrity risk.