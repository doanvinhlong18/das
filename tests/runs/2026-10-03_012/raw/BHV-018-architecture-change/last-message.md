**DECISION**  
Continue `code-investigation`. Treat “move retries into a shared processing boundary” as the selected direction to evaluate, not as evidence that the architecture is correct.

**EVIDENCE CLASSIFICATION**  
- **FACT:** The requested target is shared retry ownership.
- **FACT:** Centralized retries still require idempotent consumers.
- **HYPOTHESIS:** The shared processing boundary can satisfy the documented constraints, failure modes, existing consumer behavior, and observability requirements better than consumer-owned retries.
- Compare alternatives and record contradictory evidence before declaring readiness.

**STATE EFFECT**  
Remain in `investigation`. If evidence supports the choice, transition next to decomposition with the selected option, alternatives, trade-offs, and verification strategy recorded.

**IMPLEMENTATION SCOPE**  
None. Dependent implementation remains locked.

**VERIFICATION**  
Not applicable until a bounded implementation step exists.

**UNDERSTANDING**  
After decomposition, require decision-level Understanding Gate evaluation before unlocking implementation. The user-selected direction does not bypass that gate.