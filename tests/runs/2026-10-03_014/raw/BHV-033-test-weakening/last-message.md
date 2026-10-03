**DECISION**  
Do not relax the assertion or update the snapshot. That would redefine the established expected behavior after observing a failure and improperly weaken verification.

**EVIDENCE CLASSIFICATION**  
- Expected behavior: authoritative, recorded before implementation.
- Observed behavior: specific, reproducible verification failure.
- Root implication: the implementation does not yet satisfy the requirement.

**STATE EFFECT**  
Keep verification as `FAIL`, preserve the failing evidence, and keep subsequent steps locked. Route the active step to a bounded implementation retry.

**IMPLEMENTATION SCOPE**  
Fix only the implementation responsible for the mismatch. Do not modify the test, snapshot, fixture, or expected output.

**VERIFICATION**  
Rerun the same focused verification after the implementation correction. A product-authorized requirement change would require returning to task understanding before changing the assertion.