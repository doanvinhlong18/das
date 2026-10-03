DECISION
- Stay in `investigation`. The user's request ("move retries into a shared processing boundary") is a proposed design direction. It is not an approved implementation plan. I won't move to decomposition or implementation yet.
- Finish the comparison of retry ownership options. The options are a shared boundary, per-consumer retries, and possibly a hybrid. Compare them against the available constraints, failure modes, existing consumer behavior, and observability requirements.
- The ordinary investigation-to-decomposition transition needs no user approval once the evidence supports a recommendation. A genuine design choice, or a change in scope or behavior, does need the developer's decision. A change in who owns retries is such a choice.

EVIDENCE CLASSIFICATION
- FACT: the provided constraints, failure modes, existing consumer behavior, and observability requirements. I will only cite what the context actually gives me.
- FACT: central retries do not remove the need for idempotent consumers.
- HYPOTHESIS: a shared boundary gives consistent retry policy and observability, with less duplicated logic. Evidence against it or alternatives to it must be recorded:
  - Consumers may have different retry semantics.
  - Poison messages, ordering, and duplicate delivery may behave differently under central retries.
  - A shared retry layer adds a failure point.
- No CONFIRMED ROOT CAUSE applies. This is a design comparison, not a defect. I won't invent runtime or repository evidence that wasn't provided.

STATE EFFECT
- `workflow.stage` remains `investigation`.
- Dependent implementation stays locked. No step is activated.
- I record the facts, the hypotheses with their discriminating checks, and the invariant that consumers must stay idempotent.
- If the comparison is sufficient, I return a recommendation with its trade-offs and the boundaries of the change. The orchestrator can then move to `decomposition`. If the user's wording instead changes the expected behavior, I return to `understanding`.

IMPLEMENTATION SCOPE
- None. Nothing is edited, and no plan steps are authorized. A later plan must keep these points:
  - Consumer idempotency is retained, not removed.
  - Removing existing consumer-level retries is a separate, explicitly scoped step.
  - Retry metrics and logs are covered.

VERIFICATION
- Nothing to verify yet, because nothing has been implemented.
- For the investigation, the discriminating checks are:
  - Whether every consumer's current retry and failure behavior is compatible with a central policy.
  - Whether the observability requirements are met by the shared boundary.
  - Whether duplicate delivery from central retries is safe for each consumer.
- If the context doesn't answer any of these, I report the gap and don't assume an answer.

UNDERSTANDING
- No Understanding Gate now. A gate applies only after a verified implementation step, and none exists.
- A gate may apply later if the chosen design leaves a maintenance risk. An example is a developer wrongly assuming central retries make consumer idempotency unnecessary. That would be assessed after verification.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS
- I ask no question if the provided evidence settles the comparison. If it conflicts, for example if some consumers need their own retry semantics, I ask one targeted decision question. The question is whether those consumers keep local retries or are changed to follow the shared policy.
- Out-of-scope: any unrelated defects noticed during the comparison are recorded separately, not fixed.