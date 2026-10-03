DECISION  
Continue `code-investigation`; do not implement the requested retry centralization yet.

EVIDENCE CLASSIFICATION  
- FACT: Constraints, failure modes, consumer behavior, and observability requirements are available for comparing ownership boundaries.
- FACT: Centralized retries do not eliminate the requirement for idempotent consumers.
- DIRECTION: “Move retries into a shared processing boundary” selects a preferred option but is not evidence that the option satisfies the known constraints.
- ROOT CAUSE: Not applicable; this is an architecture-boundary decision.

STATE EFFECT  
Remain in `investigation`. Compare the shared boundary against credible alternatives and record trade-offs, failure semantics, observability effects, and compatibility with existing consumers.

IMPLEMENTATION SCOPE  
None. Dependent implementation remains locked.

VERIFICATION  
Before decomposition, establish evidence that the selected boundary preserves required processing behavior and explicitly retains consumer idempotency.

UNDERSTANDING  
If investigation supports the shared boundary, decomposition must record the selected option, rejected alternatives, trade-offs, and verification strategy. A decision-level Understanding Gate must then accept ownership of those trade-offs before any dependent implementation becomes ready.