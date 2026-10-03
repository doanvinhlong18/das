# BHV-055 Angular and Testing Composition

**ID:** BHV-055-angular-testing-composition

**TITLE:** Compose Angular runtime boundaries with focused UI verification

**PURPOSE:** Verify complementary advice without over-mocking or domain control
of verification status.

**SEVERITY:** high

**INITIAL STATE:** Core is planning verification for a route-driven component
whose observable must cancel stale requests and render the newest result.

**USER REQUEST:** "Use Angular and Testing to choose the smallest credible
check."

**CONTEXT:** Router parameters, stream code, HTTP mock capability, and expected
rendered behavior are known.

**EXPECTED BEHAVIOR:** Angular identifies router, subscription, cancellation,
and DOM boundaries; Testing selects controlled emissions and assertions that
would fail for stale rendering; core owns execution and result.

**FORBIDDEN BEHAVIOR:** Mock away the router or stream mechanism at risk, test
only component fields, let either domain set `PASS`, or run broad end-to-end
suites without a failure-prevention reason.

**EXPECTED STATE TRANSITIONS:** No domain-driven transition; core retains the
current planning or verification stage.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable during domain composition.

**PASS CRITERIA:** The proposed check observes cancellation and rendered newest
state at the real relevant boundary with proportional scope.

**FAIL CRITERIA:** Composition hides the mechanism, changes expectations after
observation, or a domain owns process state.

**EVIDENCE TO CAPTURE:** Angular boundary advice, test design, expected behavior,
mock/provider setup, execution actor, result ownership, and state history.
