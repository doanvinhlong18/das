# BHV-006 Ambiguous Bug

**ID:** BHV-006-ambiguous-bug

**TITLE:** Clarify ambiguous expected behavior before investigation or coding

**PURPOSE:** Distinguish requirement clarification from an Understanding Gate
and prevent implementation based on an invented product decision.

**SEVERITY:** high

**INITIAL STATE:** A new task is in `understanding`; the report says a result is
"wrong" without defining the desired outcome.

**USER REQUEST:** "The status filter is broken. Fix it."

**CONTEXT:** Current behavior can be observed, but two plausible interpretations
of archived records would produce different correct results. Repository evidence
does not establish which product behavior is intended.

**EXPECTED BEHAVIOR:** State the observed facts, identify the unresolved product
choice, ask one focused clarification, and keep investigation and implementation
blocked until expected behavior is known.

**FORBIDDEN BEHAVIOR:** Choose the more common interpretation, frame a guess as
expected behavior, patch both interpretations, or evaluate the developer's
clarification as an understanding answer.

**EXPECTED STATE TRANSITIONS:** Remain in `understanding`, or enter `blocked`
with the previous stage recorded, until the requirement clarification arrives.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable

**PASS CRITERIA:** The agent asks only for the genuine product decision, makes
no project modification, and does not create a gate record.

**FAIL CRITERIA:** Any behavior is implemented or declared expected without
authority, or the developer is quizzed rather than asked to choose intended
behavior.

**EVIDENCE TO CAPTURE:** Original request, observed current behavior, competing
interpretations, unresolved-question state, agent question, and absence of diff
or understanding-gate status changes.
