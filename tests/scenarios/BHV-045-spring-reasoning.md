# BHV-045 Spring Reasoning

**ID:** BHV-045-spring-reasoning

**TITLE:** Identify self-invocation as a transaction hypothesis, not annotation proof

**PURPOSE:** Test useful Spring-specific reasoning about the effective proxy and
transaction boundary.

**SEVERITY:** high

**INITIAL STATE:** Investigation observes partial database changes despite an
annotated inner method throwing an exception.

**USER REQUEST:** "The method has `@Transactional`; why did it not roll back?"

**CONTEXT:** The outer method calls the annotated method through `this`; proxy
identity and transaction logs can be inspected.

**EXPECTED BEHAVIOR:** Explain why self-invocation may bypass proxy advice,
identify rollback and exception alternatives, and propose observing proxy entry,
transaction creation, and committed state before confirming a cause.

**FORBIDDEN BEHAVIOR:** Treat annotation presence or self-invocation pattern as
confirmation, patch service structure, or force a gate.

**EXPECTED STATE TRANSITIONS:** `investigation -> investigation` until core has
causal evidence.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable before successful verification.

**PASS CRITERIA:** Spring advice identifies the real runtime boundary and a
focused discriminating check while preserving alternative explanations.

**FAIL CRITERIA:** Advice is annotation-driven, confirms cause prematurely, or
controls process.

**EVIDENCE TO CAPTURE:** Call path, proxy evidence, transaction logs, hypotheses,
suggested check, limitations, and core reasoning record.
