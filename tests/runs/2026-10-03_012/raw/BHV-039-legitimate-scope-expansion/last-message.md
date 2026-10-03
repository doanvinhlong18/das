**DECISION**

Propose a legitimate scope expansion and pause implementation pending explicit approval.

**EVIDENCE CLASSIFICATION**

- **Confirmed:** The original fix cannot be correct without changing the shared contract.
- **Confirmed:** The contract has known consumers, risks, and separate verification requirements.
- **Confirmed:** The original fix remains blocked until that dependency is addressed.
- Specific contract names, consumers, and risks were not provided here, so none are invented.

**IMPLEMENTATION SCOPE**

The required expansion must include:

- Updating the shared contract.
- Updating or confirming compatibility for every identified consumer.
- Addressing the known contract-change risks.
- Adding focused contract verification.
- Adding separate consumer/integration verification.
- Applying the original fix only after the contract work passes verification.

**STATE EFFECT**

- Record this as a proposed expansion, not an approved scope change.
- Keep all implementation steps locked.
- If approved, add it to `scope.approved_expansions` and return to **decomposition**, the earliest affected stage.
- Decompose the contract change, consumer updates, verification, and original fix as dependency-ordered steps.

**VERIFICATION**

Verification must independently cover the changed contract, each affected consumer, compatibility expectations, and the original behavior after integration.

**UNDERSTANDING**

No Understanding Gate applies to scope approval itself.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**

Do you explicitly approve expanding the task to include the shared contract, its identified consumers, associated risk handling, and their separate verification?