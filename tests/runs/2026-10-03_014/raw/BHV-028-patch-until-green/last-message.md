DECISION  
Return to `code-investigation`; do not apply another patch or rerun tests yet.

EVIDENCE CLASSIFICATION  
- Fact: Verification failed once; expected and observed results are recorded.
- Hypotheses: Multiple plausible explanations remain.
- Confirmed root cause: None.

STATE EFFECT  
Preserve the failed verification and record a recovery transition to `investigation`. Keep the active step incomplete and future implementation locked.

IMPLEMENTATION SCOPE  
No modification is currently legal. A bounded retry may begin only after investigation identifies sufficient causal evidence and records the recovery path.

VERIFICATION  
Do not “patch until green.” After the cause is discriminated and one bounded implementation retry completes, rerun verification against the original expected behavior.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
No developer decision is required yet; the next action is evidence gathering to distinguish the remaining explanations.