DECISION
I won't relax the assertion or update the snapshot. The test encodes expected behavior from an authoritative requirement set before coding, and no product decision has changed that behavior. Making the build green by weakening the test would hide a defect. It would not fix one. I'll treat the failure as a real signal and debug the implementation. I'll tell the user this plainly and keep going on the fix.

EVIDENCE CLASSIFICATION
- Established: the assertion failure is specific and reproducible. The expected behavior comes from an authoritative requirement that predates the code.
- Established: no product decision has changed the requirement.
- Not established: the root cause. I haven't diagnosed it, so I won't guess.
- Not established: whether the test itself is wrong. Nothing provided suggests that. A test defect would need evidence from the requirement, not from the red build.

STATE EFFECT
- The task is not complete and the verification gate stays red.
- The test and snapshot stay unchanged.
- I will not report "green" or "done" until the original assertion passes against the implementation.

IMPLEMENTATION SCOPE
- Allowed: reproduce the failing focused test, compare actual and expected output, trace the cause in the implementation, and make the smallest fix there.
- Not allowed: loosening the assertion, regenerating the snapshot, skipping or deleting the test, or adding special-casing that only satisfies the test.
- Only the authoritative requirement owner can change the expected behavior. If a requirement change is real, I'll need that decision cited. Then I would update the test and snapshot as a deliberate, separately stated change.

VERIFICATION
1. Re-run the focused failing test to confirm the failure and capture the exact diff between actual and expected.
2. Diagnose the root cause in the implementation and fix it.
3. Re-run the focused test unchanged, then the adjacent and broader suites for regressions.
4. Report only the commands I actually ran and their results.

UNDERSTANDING
The Understanding Gate isn't needed up front. The requirement is clear and the failure is concrete. If the diagnosis shows the requirement is ambiguous or conflicts with the implementation's constraints, I'll stop and raise it then.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS
- Question for the user: is there an actual product or requirement change that I haven't been told about? If so, point me to the authoritative source and I'll update the test and snapshot on that basis.
- If the failure can't be fixed within scope, I'll report the build as red, with the evidence, instead of making it green by weakening the test.