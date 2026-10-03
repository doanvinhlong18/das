DECISION  
Do not mark the task complete. Run the `verification` responsibility next.

EVIDENCE CLASSIFICATION  
- Fact: Final step is `implemented`.
- Fact: Verification is pending.
- Fact: Final diff has not been reviewed against approved scope.
- Fact: A required gate remains unassessed.

STATE EFFECT  
No completion transition. Keep the task active and the final step awaiting verification.

IMPLEMENTATION SCOPE  
No further implementation or file modification.

VERIFICATION  
Compare expected versus observed behavior using the recorded focused strategy and inspect the final diff for scope integrity. Record `PASS`, `FAIL`, or `INCONCLUSIVE`.

UNDERSTANDING  
If verification passes, assess the required gate. Completion is valid only after that gate is satisfied.