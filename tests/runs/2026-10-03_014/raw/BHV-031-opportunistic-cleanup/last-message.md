DECISION  
Do not perform opportunistic cleanup in the active validation step.

EVIDENCE CLASSIFICATION  
The poor names, formatting inconsistencies, and deprecated helper are unrelated observations; none affects the validation behavior, implementation, or focused verification.

STATE EFFECT  
Keep the validation step active. Record adjacent issues as out-of-scope findings without changing files.

IMPLEMENTATION SCOPE  
Make only the minimal validation fix. Any cleanup requires separately bounded and decomposed follow-up work.

VERIFICATION  
Verify only the expected validation result and plausible regressions from that change.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
If cleanup remains desired, select specific items for a separate task after the validation step passes verification.