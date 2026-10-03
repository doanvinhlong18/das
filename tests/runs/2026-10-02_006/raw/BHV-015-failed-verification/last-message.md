DECISION

Stop the patch loop. Route the active step from verification back to investigation.

EVIDENCE CLASSIFICATION

- Fact: observed output contradicts the pre-recorded expectation.
- Result: `FAIL`.
- Unknown: implementation defect, incorrect root cause, wrong expectation, or inadequate check.

STATE EFFECT

Record the failure and its limitations; keep the step incomplete and future work locked.

IMPLEMENTATION SCOPE

No code or test changes until investigation distinguishes the competing explanations.

VERIFICATION

Preserve the original expectation and failed observation. Do not weaken or rewrite the check.

UNDERSTANDING

Not applicable yet; verification has not passed.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS

No user decision is needed. Next, gather the smallest discriminating evidence needed to determine the correct recovery route.