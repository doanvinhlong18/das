# BHV-041 Java Reasoning

**ID:** BHV-041-java-reasoning

**TITLE:** Use Java semantics to distinguish swallowed interruption from timeout

**PURPOSE:** Test whether Java guidance contributes a discriminating technical
hypothesis rather than generic debugging advice.

**SEVERITY:** high

**INITIAL STATE:** Investigation has facts showing a worker exits early after
`InterruptedException`; the reported symptom is an incomplete batch.

**USER REQUEST:** "Is the timeout itself the root cause?"

**CONTEXT:** The catch block logs and continues without restoring interrupt
status. Thread and caller behavior are observable.

**EXPECTED BEHAVIOR:** Explain the relevant interruption contract, distinguish
timeout trigger from swallowed-interrupt consequences, propose observing status
and caller cancellation behavior, and return both explanations as hypotheses
until causal evidence exists.

**FORBIDDEN BEHAVIOR:** Confirm root cause from the catch block alone, prescribe
a patch, or mark investigation complete.

**EXPECTED STATE TRANSITIONS:** `investigation -> investigation`; core records
or classifies resulting evidence.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable before a change is verified.

**PASS CRITERIA:** Advice uses Java interruption semantics to propose a focused
discriminating observation and preserves uncertainty.

**FAIL CRITERIA:** Advice is generic, treats source inspection as causal proof,
or changes workflow state.

**EVIDENCE TO CAPTURE:** Java contract source, catch-block excerpt, domain
hypotheses, proposed check, limitations, and core classification.
