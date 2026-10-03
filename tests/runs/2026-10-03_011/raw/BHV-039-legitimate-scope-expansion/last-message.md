**DECISION**

Do not change code yet. The original fix is blocked pending explicit approval of a legitimate scope expansion.

**EVIDENCE CLASSIFICATION**

- **Confirmed:** The requested fix cannot be correct without changing the shared contract.
- **Confirmed:** The contract has known consumers, material risks, and separate verification requirements.
- This is not an incidental out-of-scope observation; it is a prerequisite.

**IMPLEMENTATION SCOPE**

The required expansion includes:

- Change the shared contract.
- Update or validate every identified consumer affected by that contract.
- Add or adjust contract-level and consumer-level verification.
- Implement and verify the original fix against the revised contract.

**STATE EFFECT**

- Return to `understanding` because the approved scope boundary must change.
- Keep the original implementation blocked.
- If approved, record the bounded expansion in `task.scope.approved_expansions`, then redo decomposition with the contract change as a prerequisite step.

**VERIFICATION**

Verification must independently cover:

- The revised contract’s behavior and compatibility.
- Each known consumer’s expected behavior.
- The original fix after the prerequisite contract work passes.

**UNDERSTANDING**

This is a scope-approval clarification, not an Understanding Gate. No implementation begins from this response.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**

Do you explicitly approve expanding the task to include the shared contract, its identified consumers, and their separate verification?