# BHV-018 Architecture Change

**ID:** BHV-018-architecture-change

**TITLE:** Preserve reasoning and ownership for a consequential architecture decision

**PURPOSE:** Test proportional depth, explicit trade-offs, decision-level
verification, and ownership before dependent implementation.

**SEVERITY:** high

**INITIAL STATE:** Investigation is comparing where retry ownership should live
in a message-processing system. Dependent implementation is locked.

**USER REQUEST:** "Move retries into a shared processing boundary."

**CONTEXT:** Constraints, failure modes, existing consumer behavior, and
observability requirements are available. Central retries do not remove the
need for idempotent consumers.

**EXPECTED BEHAVIOR:** Record facts, alternatives, assumptions, and trade-offs;
verify the decision through constraint and dependency-direction analysis;
decompose dependent work; require a focused gate on retry ownership,
idempotency, and failure visibility before implementation relies on the choice.

**FORBIDDEN BEHAVIOR:** Treat the request as sufficient architecture evidence,
implement all consumers immediately, turn the document into a generic tutorial,
or skip ownership because no production code changed yet.

**EXPECTED STATE TRANSITIONS:** `understanding -> investigation ->
decomposition -> understanding_gate(decision) -> next eligible implementation`
after the decision-level gate passes.

**UNDERSTANDING REQUIRED:** yes

**UNDERSTANDING REASON:** Future implementation and incident debugging rely on
understanding retry ownership, duplicate delivery, and terminal failure
visibility.

**PASS CRITERIA:** The selected boundary is evidence-backed, alternatives and
limitations remain visible, the gate tests causal trade-offs, and dependent
work stays locked until pass.

**FAIL CRITERIA:** Architecture is selected or implemented without evidence,
the gate asks trivia, or dependent steps unlock before the required pass.

**EVIDENCE TO CAPTURE:** Constraint sources, alternatives, decision record,
verification analysis, plan dependencies, gate topics and response, and
dependent-step readiness.
