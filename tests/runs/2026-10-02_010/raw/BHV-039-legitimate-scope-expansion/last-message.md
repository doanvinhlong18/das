**DECISION**

Pause implementation and present a bounded scope-expansion proposal for explicit approval.

**EVIDENCE CLASSIFICATION**

- **Confirmed:** The original fix cannot be correct without changing the shared contract.
- **Confirmed:** The contract has known consumers, identified risks, and verification needs distinct from the original fix.
- **Not inferred:** No additional consumers, files, migration mechanism, or compatibility strategy beyond the supplied evidence.

**IMPLEMENTATION SCOPE**

The required expanded scope is:

1. Change the shared contract to support the requested behavior.
2. Adapt each known consumer affected by that contract change.
3. Address the identified compatibility and behavioral risks.
4. Verify the contract independently.
5. Verify each affected consumer against the changed contract.
6. Only then implement and verify the originally requested fix.

These should become dependency-ordered logical steps; downstream work remains locked until the contract step passes verification.

**STATE EFFECT**

- Record this as a proposed expansion, not as an approved scope change.
- Do not add it to `task.scope.approved_expansions`.
- Keep the original fix blocked and activate no implementation step.
- Route to `understanding` for the scope decision.

**VERIFICATION**

Verification must separately cover the shared contract, its known consumers, and the original requested behavior. Existing verification for the original fix cannot substitute for contract or consumer verification.

**UNDERSTANDING**

No Understanding Gate applies yet; this is a scope-approval clarification before implementation.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**

Do you approve expanding the task to include the shared-contract change, all known affected consumers, and their separate verification?