DECISION
- I won't fold the schema work into Step 2, and I won't keep coding Step 2 on an assumption that is false.
- Step 2's plan assumes a schema capability that the repository shows is absent. That invalidates its dependency, so I pause Step 2 and return to `task-decomposition`. Investigation isn't needed, because the evidence is already in hand.
- "Add the missing schema support while you are there" is an explicit request for more scope. I record it as an approved expansion and don't ask again.
- The schema work becomes its own prerequisite step, placed before Step 2. It has separate migration risk and needs its own verification.
- I won't "finish the feature" in one pass. The request doesn't override the one-active-step and verify-before-pass invariants.

EVIDENCE CLASSIFICATION
- Fact: the schema capability is absent, from repository evidence.
- Fact: Step 2 depends on it and has partial changes in the worktree.
- Fact: the partial Step 2 changes can be safely reconciled.
- Not evidence: the user's urgency. It says nothing about whether the migration is safe.
- I have no migration or runtime evidence yet, so I won't claim any.

STATE EFFECT
- The Step 2 dependency assumption is invalidated. Step 2 goes from active/`in_progress` back to `locked`, and `plan.active_step_id` is reset to null.
- Its partial diff is reconciled and kept as Step 2 work, not discarded and not counted as verified. I'll check the diff against recorded state first and won't normalize any change outside Step 2's boundary.
- Decomposition adds a new Step 2a for the schema capability, with these fields:
  - objective and reason;
  - affected area;
  - migration risk, with included and excluded scope;
  - a verification strategy and expected result recorded before coding;
  - Step 2 as dependent on Step 2a.
- Step 2a becomes the only `ready` step. The orchestrator then activates it, and Step 2 stays `locked`.
- The scope expansion goes into `task.scope.approved_expansions` as the user's explicit approval.

IMPLEMENTATION SCOPE
- Now: no further edits. I only reconcile and re-plan.
- Next: Step 2a only, the minimal schema and migration change. Step 2 behavior is excluded.
- Later: after Step 2a passes verification, Step 2 unlocks and I resume from the reconciled partial changes. Both steps are verified separately.

VERIFICATION
- Step 2a is verified on its own, for example by applying the migration and checking the schema result. The exact checks are defined at decomposition from repository tooling, and I won't invent them now.
- I'll also check that the migration is safe for existing data and can be rolled back, if the project supports that.
- Step 2 is verified only after Step 2a passes, and the final result won't be claimed without observed results from both.

UNDERSTANDING
- No gate is assumed. After Step 2a verifies, I assess whether a developer-understanding gate applies. Migration risk makes that plausible, but the assessment decides it, not me.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS
- No blocking question now.
- I'd ask only if the repository gives no clear migration convention, such as rollback policy or a data-backfill decision.
- Out of scope unless approved: any schema changes beyond what Step 2 needs.