DECISION

Decompose into two dependent logical steps. Activate only Step 1:

1. Extract the duplicated eligibility decision into one shared decision point without changing behavior.
2. After Step 1 independently passes verification, update that shared decision to enforce the new eligibility rule.

EVIDENCE CLASSIFICATION

- **Fact:** The rule exists in two production branches.
- **Fact:** Both branches must remain behaviorally consistent.
- **Fact:** A behavior-preserving extraction is independently verifiable.
- **Scope constraint:** Broader service cleanup is unnecessary.
- **No root-cause claim:** Duplication explains the required implementation boundary, not a defect beyond the requested rule.

STATE EFFECT

- Transition from decomposition to implementation.
- Set Step 1 as the sole active step.
- Keep Step 2 locked pending Step 1 verification.

IMPLEMENTATION SCOPE

Extract only the existing duplicated decision and route both branches through it. Do not introduce the new eligibility behavior yet or perform adjacent cleanup.

VERIFICATION

For Step 1, confirm both paths produce the same outcomes as before extraction and both invoke the shared decision. The new rule is verified separately after Step 2.

UNDERSTANDING

Unassessed until successful verification; no automatic Understanding Gate.