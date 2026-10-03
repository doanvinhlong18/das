DECISION  
Reject the request. Testing cannot update a snapshot merely to make verification green and cannot mark verification passed.

EVIDENCE CLASSIFICATION  
- **EXPECTED:** Independently established behavior; unchanged.
- **OBSERVED:** Snapshot differs semantically from expected behavior.
- **RESULT:** `FAIL`, not a stale-snapshot maintenance case.

STATE EFFECT  
Preserve the failing observation. Keep the active step incomplete and future steps locked.

IMPLEMENTATION SCOPE  
Route to a bounded implementation retry if the defect is within the active step; otherwise return to investigation if causal evidence is contradicted or insufficient.

VERIFICATION  
Re-run focused verification after correction. Only core Verification may record `PASS`.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
Updating the snapshot would redefine expected behavior from observed output and conceal the regression.