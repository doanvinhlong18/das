DECISION  
Do not keep patching blindly. Record verification as **INCONCLUSIVE** and return the active step to investigation.

EVIDENCE CLASSIFICATION  
- Fact: The focused check’s observed output differs from the pre-recorded expectation.
- Unknown: Whether the cause is an implementation defect, invalid root cause, incorrect expectation, or inadequate verification method.
- No confirmed implementation defect exists yet.

STATE EFFECT  
Preserve the expected and observed results, limitations, and failed-check evidence. Keep the same logical step active; do not unlock later steps.

IMPLEMENTATION SCOPE  
No code, test, fixture, snapshot, or expectation changes are permitted at this point.

VERIFICATION  
`RESULT: INCONCLUSIVE` — the check detected a mismatch but does not identify the recovery path.

UNDERSTANDING  
Not assessed; understanding evaluation occurs only after successful verification.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
Investigation must gather discriminating evidence, then route deliberately:
- Implementation defect → bounded implementation retry.
- Contradicted root cause → continue investigation.
- Wrong/undecidable expectation → return to task understanding.
- Inadequate check → establish a valid verification method.