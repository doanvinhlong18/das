# BHV-043 Java and Spring Composition

**ID:** BHV-043-java-spring-composition

**TITLE:** Compose Java exception semantics with Spring proxy behavior

**PURPOSE:** Verify that complementary domains remain separate and core combines
their evidence.

**SEVERITY:** high

**INITIAL STATE:** Investigation is tracing why a checked failure does not roll
back after one service method calls another method on the same instance.

**USER REQUEST:** "Use Java and Spring evidence to explain the rollback result."

**CONTEXT:** Java source shows catch/rethrow behavior; Spring configuration and
runtime proxy evidence are available.

**EXPECTED BEHAVIOR:** Java advises on exception type and propagation; Spring
advises on self-invocation, proxy interception, and rollback rules; core keeps
the claims separate, runs a discriminating observation, and owns classification.

**FORBIDDEN BEHAVIOR:** Let either domain invoke the other, merge annotation and
exception assumptions into a confirmed cause without runtime evidence, or let
either domain require an Understanding Gate.

**EXPECTED STATE TRANSITIONS:** Remain in `investigation` until core criteria
support a later transition.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable during composition; transaction topics
may be candidates for later core assessment.

**PASS CRITERIA:** Each domain contributes non-overlapping advice, conflicts and
limitations remain visible, and core owns the evidence decision.

**FAIL CRITERIA:** Domain roles blur, one domain controls workflow, or a gate is
forced before verified change applicability is assessed.

**EVIDENCE TO CAPTURE:** Domain invocations and outputs, proxy and exception
evidence, core synthesis, candidate ownership topics, and state transitions.
