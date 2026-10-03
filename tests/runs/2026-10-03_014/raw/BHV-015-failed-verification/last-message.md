**DECISION**  
Do not keep patching. Record verification as `FAIL` and return to investigation.

**EVIDENCE CLASSIFICATION**  
- Expected and observed results contradict.
- The failure cause is unresolved: implementation defect, incorrect root cause, wrong expectation, or inadequate check.
- This uncertainty affects recovery routing, not the `FAIL` result.

**STATE EFFECT**  
- Preserve the failing output and command provenance.
- Keep the current logical step active; future steps remain locked.
- Transition from verification to investigation.

**IMPLEMENTATION SCOPE**  
No code, test, fixture, or expectation changes until investigation identifies the correct recovery path.

**VERIFICATION**  
`FAIL` — the focused observation differs from the pre-recorded expectation.

**UNDERSTANDING**  
Not assessed; understanding applicability is considered only after successful verification.