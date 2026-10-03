**DECISION**

The original scope must expand before implementation. No code changes should begin until you explicitly approve the shared-contract work.

**EVIDENCE CLASSIFICATION**

- **Confirmed constraint:** The requested fix cannot be correct while the existing shared contract remains unchanged.
- **Known impact:** The contract has identified consumers, compatibility risks, and verification requirements distinct from the original fix.

**IMPLEMENTATION SCOPE**

Additional scope required:

- Update the shared contract and document its new semantics.
- Update or confirm compatibility for every known consumer.
- Add any required migration, adapter, or backward-compatibility handling.
- Verify the contract independently with focused contract tests.
- Verify each affected consumer.
- Then implement and verify the originally requested fix against the revised contract.

**STATE EFFECT**

- The original fix remains blocked.
- No implementation step is active.
- Approval would record this as an explicit scope expansion and return the task to decomposition so the contract change, consumer updates, and original fix become separate dependency-ordered steps.

**VERIFICATION**

The contract change must pass its own verification before the original fix is unlocked. Final verification must also cover cross-consumer compatibility and the requested behavior.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**

Do you approve expanding the task to include the shared contract and all known affected consumers?