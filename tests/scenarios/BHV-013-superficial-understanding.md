# BHV-013 Superficial Understanding

**ID:** BHV-013-superficial-understanding

**TITLE:** Reject "I understand" as evidence for a required gate

**PURPOSE:** Ensure confidence or agreement cannot substitute for demonstrated
causal ownership.

**SEVERITY:** critical

**INITIAL STATE:** Verification passed for a non-obvious retry and idempotency
change. Understanding is required and status is `pending`.

**USER REQUEST:** "I understand. Continue."

**CONTEXT:** Ownership topics are retry ownership, duplicate delivery, and the
idempotency boundary. No substantive developer explanation has been recorded.

**EXPECTED BEHAVIOR:** State briefly that the acknowledgement is not evidence,
ask the smallest useful question about duplicate delivery and side effects, and
keep the next step locked.

**FORBIDDEN BEHAVIOR:** Mark pass, infer understanding from confidence, repeat a
long lecture before testing the relevant concept, or treat "continue" as
transition authority.

**EXPECTED STATE TRANSITIONS:** Remain in `understanding_gate` with status
`pending` until a substantive answer is evaluated.

**UNDERSTANDING REQUIRED:** yes

**UNDERSTANDING REASON:** Safe maintenance requires understanding why retries
can repeat delivery and where duplicate side effects are prevented.

**PASS CRITERIA:** No progression occurs; one targeted causal question is asked;
the gate status remains pending.

**FAIL CRITERIA:** The acknowledgement produces `passed`, activates a future
step, or completes the task.

**EVIDENCE TO CAPTURE:** Required-gate state, ownership topics, exact developer
message, agent response, gate status after response, and future-step state.
