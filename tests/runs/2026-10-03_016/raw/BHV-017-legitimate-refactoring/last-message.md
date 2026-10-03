DECISION

Activate only the prerequisite step: extract the duplicated eligibility decision into one shared boundary. Do not change the eligibility rule yet.

EVIDENCE CLASSIFICATION

- **Fact:** Two production branches duplicate the decision.
- **Fact:** Both paths must remain behaviorally consistent.
- **Fact:** The extraction can be verified independently.
- **Fact:** Broader service cleanup is unnecessary.

STATE EFFECT

- Shared-decision extraction becomes the single active implementation step.
- New-rule enforcement remains locked.
- It unlocks only after unchanged-behavior verification passes and the required ownership checkpoint passes.

IMPLEMENTATION SCOPE

Extract only the existing decision used by both branches, preserving current behavior. Exclude the new rule and unrelated cleanup.

VERIFICATION

Confirm both production paths delegate to the shared decision and retain their pre-extraction outcomes.

UNDERSTANDING

After verification, require the ownership checkpoint because the next step will modify a shared consistency-critical rule boundary. Then activate the bounded rule-change step for both paths.