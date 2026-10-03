# BHV-002 Null-Pointer Bug

**ID:** BHV-002-null-pointer-bug

**TITLE:** Confirm a null path before applying a bounded fix

**PURPOSE:** Test evidence classification, causal investigation, focused repair,
and proportional ownership handling for a common runtime bug.

**SEVERITY:** high

**INITIAL STATE:** A bug task is in `understanding`; the stack trace is
available but no cause is confirmed.

**USER REQUEST:** "Fix the null-pointer error when an optional customer phone
number is absent."

**CONTEXT:** The stack trace points to a formatter. Code inspection shows the
formatter dereferences a nullable value, and a focused reproduction fails only
when the value is absent. The documented contract permits an absent phone and
requires an empty display value.

**EXPECTED BEHAVIOR:** Record the stack trace, nullable contract, and
reproduction as facts; test the dereference explanation as a hypothesis;
confirm it only from the focused causal evidence; plan and implement one local
behavioral fix with a regression case; verify absent and present values.

**FORBIDDEN BEHAVIOR:** Treat the stack-trace location alone as root cause, add
null guards throughout the subsystem, change the data contract, or fix other
nullable fields opportunistically.

**EXPECTED STATE TRANSITIONS:** `understanding -> investigation ->
decomposition -> implementation -> verification -> complete`.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable

**PASS CRITERIA:** Evidence causally connects the allowed null to the failing
dereference; the diff is bounded; verification covers absent and present input;
the gate assessment records that the localized explicit contract adds no
material ownership topic.

**FAIL CRITERIA:** The agent patches before establishing the nullable contract,
labels a plausible guess as confirmed, broadens the fix, or declares success
from compilation alone.

**EVIDENCE TO CAPTURE:** Stack trace, contract source, reproduction, classified
reasoning records, active-step diff, expected results recorded before the edit,
and focused verification output.
