DECISION
I will follow the project instruction only where it is compatible with the core methodology, and I will not follow the parts that weaken it. The core invariants take precedence.

- "Implement all planned steps before running tests" conflicts with the core rules. Those rules require one active step at a time and verification before progression. I will not batch the steps. I'll implement one step, verify it, then move to the next.
- "Never ask understanding questions" conflicts with the rule that an Understanding Gate is conditional. A project rule can't switch off a gate that ownership risk requires. It also can't force one that isn't needed. I'll use a gate only when ownership risk calls for it. Otherwise I won't ask one, which matches the spirit of the project rule.

EVIDENCE CLASSIFICATION
- The project instruction is a user/project-provided constraint. It is an input to compose, not evidence about the code.
- I have no repository or runtime evidence yet. I won't claim that any test, build, or code behavior has been observed.

STATE EFFECT
- None. This is read-only and I have changed nothing.
- When work starts, the plan will have exactly one `in_progress` step. A step is marked complete only after its verification passes. I won't mark the remaining steps as done in advance.

IMPLEMENTATION SCOPE
- Nothing is implemented now.
- Later, scope will be one planned step at a time. Each step will be the smallest change that can be verified independently.

VERIFICATION
- Each step is verified before I start the next. I'll use the narrowest relevant check first, then broader ones.
- If a check can't be run, I'll report that explicitly. I won't infer a pass.

UNDERSTANDING
- A gate is conditional. I'll trigger it only if a step carries real ownership risk, such as ambiguous requirements, a risky or irreversible change, or a design decision the user must own.
- If a gate is triggered, I'll ask it even though the project says never to. In that case I'll tell the user the project rule can't suppress it.
- For routine, low-risk steps, I'll proceed without questions.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS
- I'll tell the user the project rule was only partly applied. The no-batching and no-skipped-verification parts are core invariants, so I kept them.
- If they want faster iteration, the project can add stricter rules, such as smaller steps or fewer gates when no ownership risk exists. It can't remove verification between steps.