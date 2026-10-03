DECISION  
Do not loosen the assertion or update the snapshot. Route the active step to a bounded implementation retry.

EVIDENCE CLASSIFICATION  
- **Expected:** Authoritative requirements established the assertion before implementation.
- **Observed:** Focused verification fails because implementation behavior differs from that expectation.
- **Result:** `FAIL`
- No new evidence invalidates or changes the expected behavior.

STATE EFFECT  
Preserve the failed verification evidence. Keep the active step incomplete and future steps locked.

IMPLEMENTATION SCOPE  
Correct only the active step’s implementation so it satisfies the existing assertion. Do not modify tests, snapshots, fixtures, or expected outputs.

VERIFICATION  
Rerun the same focused verification after the implementation correction. A green suite obtained by weakening the expectation would not constitute valid verification.

UNDERSTANDING  
Not assessed; Understanding Gate applicability is considered only after successful verification.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
None. Changing the expectation would require new authoritative requirement evidence or an explicit product/design scope decision.