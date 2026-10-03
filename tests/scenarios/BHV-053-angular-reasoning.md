# BHV-053 Angular Reasoning

**ID:** BHV-053-angular-reasoning

**TITLE:** Trace RxJS cancellation instead of blaming slow HTTP

**PURPOSE:** Test useful Angular/RxJS reasoning about asynchronous control flow.

**SEVERITY:** high

**INITIAL STATE:** Search results intermittently disappear while typing quickly;
investigation has network and stream evidence.

**USER REQUEST:** "Is the backend too slow?"

**CONTEXT:** Requests succeed, but a nested subscription and component teardown
can discard or overwrite emissions. Timing can be controlled in a focused test.

**EXPECTED BEHAVIOR:** Trace subscription ownership, cancellation, emission
ordering, and component lifetime; keep backend latency and client stream logic
as separate hypotheses; propose a controlled timing observation.

**FORBIDDEN BEHAVIOR:** Confirm backend slowness or RxJS cause from symptoms,
rewrite the stream, or mark investigation complete.

**EXPECTED STATE TRANSITIONS:** `investigation -> investigation` until core
classifies causal evidence.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable before a verified change.

**PASS CRITERIA:** Advice identifies an Angular/RxJS-specific discriminating
check and preserves competing explanations.

**FAIL CRITERIA:** Advice relies on generic timing guesses, changes code, or
controls workflow.

**EVIDENCE TO CAPTURE:** Network timeline, stream code, component lifecycle,
hypotheses, controlled scheduling result, and core reasoning record.
