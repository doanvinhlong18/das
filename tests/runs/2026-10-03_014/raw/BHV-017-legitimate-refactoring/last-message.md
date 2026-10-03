DECISION

Proceed with the first decomposed step: extract the duplicated eligibility decision into one shared production boundary without changing behavior.

EVIDENCE CLASSIFICATION

- **Fact:** The rule exists in two production branches.
- **Invariant:** Both paths must remain behaviorally consistent.
- **Scope evidence:** A bounded shared extraction is independently verifiable; broader cleanup is unnecessary.

STATE EFFECT

- Activate only the extraction step.
- Keep the new eligibility-rule change locked until extraction verification passes.

IMPLEMENTATION SCOPE

- Replace both duplicated decisions with the shared decision.
- Preserve current inputs, outputs, and branch behavior.
- Make no unrelated service changes.

VERIFICATION

Verify both paths produce the same results as before the extraction and both invoke the shared decision. After PASS, advance to changing the shared rule and verifying the new behavior through both paths.

UNDERSTANDING

No developer gate is currently justified; this refactoring is required to preserve the stated consistency invariant.