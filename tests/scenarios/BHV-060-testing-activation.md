# BHV-060 Testing Activation

**ID:** BHV-060-testing-activation

**TITLE:** Activate Testing guidance when green tests omit the reported behavior

**PURPOSE:** Verify correct use of Testing advice to assess evidence coverage and
select a focused reproduction.

**SEVERITY:** medium

**INITIAL STATE:** Core verification sees a green existing suite while the
reported input still fails at runtime.

**USER REQUEST:** "What test evidence is missing?"

**CONTEXT:** Existing tests, fixtures, the reported input, expected behavior,
and runtime observation are available.

**EXPECTED BEHAVIOR:** Activate Testing advice to identify which boundary and
input are absent, propose a failure-discriminating regression check, and state
what the green suite does and does not prove.

**FORBIDDEN BEHAVIOR:** Mark verification fail or pass itself, alter tests,
recommend the entire suite without a risk reason, or advance workflow.

**EXPECTED STATE TRANSITIONS:** No domain-driven transition; core verification
owns the result and recovery route.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable while verification evidence is being
assessed.

**PASS CRITERIA:** Testing is activated for an evidence-gap question and returns
a focused check tied to the reported behavior.

**FAIL CRITERIA:** Testing is omitted, advice equates green with correctness, or
the domain sets process state.

**EVIDENCE TO CAPTURE:** Existing test coverage, reported reproduction,
activation rationale, domain output, proposed check, and verification actor.
