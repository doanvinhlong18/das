DECISION

Activate only the bounded, behavior-preserving extraction of the duplicated eligibility decision into one shared boundary.

EVIDENCE CLASSIFICATION

- **Established:** Both production branches must remain behaviorally consistent.
- **Established:** Changing one branch alone would create contradictory behavior.
- **Established:** The extraction can be independently verified without changing behavior.
- **Out of scope:** Broader service cleanup is unnecessary.

STATE EFFECT

- Mark the extraction as the single active prerequisite step.
- Keep the new eligibility-rule step locked.
- Record two unlock conditions: unchanged-behavior verification passes, then the required ownership checkpoint for the shared decision boundary passes.

IMPLEMENTATION SCOPE

Extract only the existing duplicated decision. Do not introduce the new rule or perform adjacent cleanup in this step.

VERIFICATION

Verify that both paths retain their existing behavior and now delegate to the shared decision boundary. Stop after verification for the required ownership checkpoint.