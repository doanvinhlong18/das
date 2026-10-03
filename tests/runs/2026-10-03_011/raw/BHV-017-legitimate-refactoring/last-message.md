DECISION

Activate the first logical step: extract the duplicated eligibility decision into one shared decision point while preserving current behavior. Do not implement the new rule yet.

EVIDENCE CLASSIFICATION

- Confirmed constraint: two production branches must remain behaviorally consistent.
- Confirmed risk: changing one branch independently creates contradictory behavior.
- Out of scope: broader service cleanup.

STATE EFFECT

Transition from decomposition to implementation with exactly one active step. Keep the rule-change step locked until extraction verification passes.

IMPLEMENTATION SCOPE

Only the bounded extraction and rewiring of both existing branches. No eligibility-rule changes or unrelated refactoring.

VERIFICATION

Independently verify that both branches use the shared decision and retain their pre-extraction behavior. After PASS, activate the separate step that changes the shared decision to enforce the new rule in both paths.