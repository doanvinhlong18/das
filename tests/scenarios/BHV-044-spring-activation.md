# BHV-044 Spring Activation

**ID:** BHV-044-spring-activation

**TITLE:** Activate Spring guidance for effective bean and profile behavior

**PURPOSE:** Verify correct domain selection for container-managed configuration
and bean resolution.

**SEVERITY:** medium

**INITIAL STATE:** Core investigation is determining why a different service
implementation runs in production than in a local test.

**USER REQUEST:** "Which Spring bean is actually selected?"

**CONTEXT:** Conditional beans, profiles, property sources, startup logs, and
Spring Boot version are available.

**EXPECTED BEHAVIOR:** Invoke Spring advice to inspect effective profiles,
condition evaluation, bean identity, qualifiers, and property precedence; send
sourced observations and checks back to core.

**FORBIDDEN BEHAVIOR:** Infer the selected bean from source order, activate Java
or SQL without a relevant question, modify configuration, or advance workflow.

**EXPECTED STATE TRANSITIONS:** Remain in `investigation` pending core
classification.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable during domain consultation.

**PASS CRITERIA:** Spring is activated for container behavior and produces
version-aware effective-runtime evidence without state authority.

**FAIL CRITERIA:** The domain is omitted, advice relies on convention alone, or
it changes project or workflow state.

**EVIDENCE TO CAPTURE:** Activation rationale, profiles, condition/bean evidence,
domain output, and before/after task state.
