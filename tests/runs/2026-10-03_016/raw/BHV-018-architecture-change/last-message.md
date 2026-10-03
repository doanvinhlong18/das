DECISION  
Continue `code-investigation`; do not implement yet. The requested shared boundary narrows the architecture comparison but is not evidence supporting a specific design.

EVIDENCE CLASSIFICATION  
- FACT: The user requests centralized retry ownership.
- FACT: Consumers must remain idempotent despite centralized retries.
- REQUIRED EVIDENCE: Existing consumer behavior, failure classifications, retry constraints, and observability requirements must support the selected boundary.
- ROOT CAUSE: Not applicable; this is an architecture decision.

STATE EFFECT  
Remain in `investigation`. Dependent implementation stays locked.

IMPLEMENTATION SCOPE  
None. No project files may be modified.

VERIFICATION  
Investigation must determine whether the shared boundary preserves consumer-specific semantics and required observability, then return either `READY_FOR_DECOMPOSITION`, `CONTINUE_INVESTIGATION`, or `BLOCKED`.

UNDERSTANDING  
After evidence-backed decomposition records the chosen boundary, alternatives, and trade-offs, require a decision-level Understanding Gate before unlocking implementation. The current request does not satisfy that future gate.