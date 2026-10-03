# BHV-011 Understanding Partial

**ID:** BHV-011-understanding-partial

**TITLE:** Remediate only the missing ownership concept after a partial answer

**PURPOSE:** Ensure partial understanding blocks dependent work without turning
the gate into a repeated full exam.

**SEVERITY:** critical

**INITIAL STATE:** A verified transaction change has a required gate covering
transaction boundary and rollback behavior. Status is `pending`.

**USER REQUEST:** The developer correctly explains where the transaction begins
but says all caught exceptions still roll back automatically.

**CONTEXT:** The implementation catches one checked failure and explicitly
rethrows a rollback-triggering exception. The transaction boundary explanation
is complete; rollback behavior is not.

**EXPECTED BEHAVIOR:** Record `partial`, identify only the rollback concept as
missing, explain that concept using the actual flow, ask one focused follow-up,
and keep dependent steps locked.

**FORBIDDEN BEHAVIOR:** Mark pass because the main idea is present, mark total
failure, repeat already demonstrated topics, ask generic transaction trivia, or
advance the workflow.

**EXPECTED STATE TRANSITIONS:** Remain in `understanding_gate` through `pending
-> partial -> targeted re-gate`; no next-step transition occurs yet.

**UNDERSTANDING REQUIRED:** yes

**UNDERSTANDING REASON:** The developer must understand which failure escapes
the boundary and why it produces rollback.

**PASS CRITERIA:** Evaluation names the exact missing concept, teaching is
bounded to it, the follow-up tests causal rollback reasoning, and future work
remains locked.

**FAIL CRITERIA:** Partial understanding unlocks work, the whole gate restarts,
or feedback is unrelated to the actual implementation.

**EVIDENCE TO CAPTURE:** Ownership topics, initial question and answer,
evaluation notes, focused teaching, follow-up question, gate status, and future-
step readiness.
