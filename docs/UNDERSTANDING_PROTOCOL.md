# Conditional Developer Understanding Protocol

## Status and purpose

This document defines the behavioral contract for conditional developer
understanding validation in `dev-agent-skills`. It refines the constitutional
rules in [PHILOSOPHY.md](PHILOSOPHY.md) and
[CORE_PRINCIPLES.md](CORE_PRINCIPLES.md), and uses the state semantics in
[STATE_MACHINE.md](STATE_MACHINE.md).

The protocol protects developer ownership of technical reasoning that will
matter later. It is not a generic approval step, phase-transition quiz, or
substitute for verification.

The terms **MUST**, **MUST NOT**, **REQUIRED**, and **FORBIDDEN** are normative.

## 1. Relationship to workflow readiness

Workflow readiness and developer understanding answer different questions:

- **Workflow readiness:** Are the evidence, artifacts, and state invariants
  sufficient for the process to continue?
- **Developer understanding:** Does the developer own technical reasoning whose
  misunderstanding would materially harm later maintenance, debugging,
  extension, or operation?

A workflow transition can be valid without a developer quiz. Investigation,
planning, decomposition, documentation, formatting, repository setup, and
administrative work normally use artifact and evidence checks only.

For an implementation step, understanding applicability is assessed only after
verification passes or is legitimately not required. A failed or inconclusive
verification returns to reasoning; it MUST NOT be converted into an
Understanding Gate.

```text
VERIFICATION PASS
        |
        v
ASSESS OWNERSHIP VALUE
    |             |
    | no          | yes
    v             v
NOT_APPLICABLE   PENDING GATE
    |             |
    v             +--> PARTIAL/FAIL --> TEACH --> RE-GATE
NEXT STEP         |
                  +--> PASS ----------> NEXT STEP
```

An important technical decision made outside implementation may be assessed at
its acceptance point, before dependent work relies on it. The surrounding
phase alone is never the reason for a gate.

That exception is narrow. The decision MUST already be evidence-backed, its
trade-offs and consequences MUST be named, and dependent work MUST encode or
rely on it. It does not include requirement clarification, expected-behavior
selection, scope-expansion approval, root-cause confirmation, proposed-fix
approval, or recovery from failed or inconclusive verification. Route those to
task understanding, investigation, or decomposition without changing
understanding-gate state.

Decomposition MUST represent that acceptance point as a dependency: dependent
implementation stays locked, the workflow transitions
`decomposition -> understanding_gate(decision)`, and only a substantive pass
can accept the decision and release the next eligible step.

Risk can make a gate required later, but risk alone MUST NOT move an
implementation gate before verification. For implementation, the fixed order
is implementation, verification, applicability assessment, then any required
question.

## 2. Applicability assessment

Before asking an understanding question, evaluate:

> Would misunderstanding this specific change materially reduce the
> developer's ability to maintain, debug, extend, or reason about the resulting
> software?

Use the actual task, investigation evidence, root cause or design rationale,
diff, observed behavior, and verification limitations. Consider:

- behavioral significance;
- complexity or non-obvious mechanism;
- architectural significance;
- maintenance and debugging importance;
- novelty in the project or known developer context;
- security, data, concurrency, financial, reliability, or operational risk;
- whether future work depends on retaining this mental model.

These are judgment factors, not a score. File count, line count, framework,
phase name, or the presence of production code MUST NOT decide applicability by
themselves. A one-line concurrency change can require a gate; a large generated
update may not.

### Not required

Set:

```yaml
required: false
reason: "<specific reason the change has no material ownership value>"
ownership_topics: []
status: not_applicable
```

Ask no questions. Continue according to ordinary workflow readiness.

Mechanical renames, formatting, import corrections, documentation edits,
generated output, and obvious low-risk local fixes are normally in this class.
They are examples, not exemptions: unusual risk or an important accepted
technical decision can change the result.

### Required

Set:

```yaml
required: true
reason: "<specific maintenance, debugging, architecture, or risk reason>"
ownership_topics:
  - "<concept the developer must be able to reason about>"
status: pending
```

The reason MUST explain the ownership consequence, not merely name the
technology. "Uses SQL" is insufficient; "future query changes require
understanding why one-to-many join cardinality multiplied invoice rows" is
specific.

Transaction behavior, concurrency, caching, non-obvious SQL, authorization,
distributed messaging, architecture boundaries, important data transforms,
subtle root causes, and significant edge cases often carry ownership value.
None is an automatic trigger.

## 3. State semantics

Understanding state belongs to the current logical step or accepted technical
decision.

| `required` | Valid status | Meaning |
| --- | --- | --- |
| `null` | `unassessed` | Applicability has not been decided |
| `false` | `not_applicable` | A reasoned decision found no useful gate |
| `true` | `pending` | Questions are required but not yet passed |
| `true` | `partial` | Core reasoning is present, but an ownership topic is missing |
| `true` | `failed` | Core causal understanding is absent or materially wrong |
| `true` | `passed` | Required ownership has been demonstrated |

Both applicability outcomes require a specific reason. `required: true` also
requires at least one ownership topic. Questions and responses MUST be recorded
only for a required gate.

The understanding skill may propose these field updates. It MUST NOT mark the
step done, activate another step, unlock dependencies, or complete the task.
Those effects belong to workflow transition authority.

## 4. Question design

Generate the smallest useful question set from the actual change. A question
must discriminate between having and lacking the relevant mental model.

Useful dimensions include:

- **WHY:** connect the change to the established problem or design need;
- **HOW:** explain the mechanism that creates the new behavior;
- **FLOW:** trace relevant data or control through affected boundaries;
- **EDGE CASE:** identify a material handled, excluded, or remaining case;
- **COUNTERFACTUAL:** predict what would happen if a key element changed;
- **PREDICTION:** predict a meaningful outcome from an input or state and
  explain why.

Do not mechanically cover every dimension. One question may test several
ownership topics. Add questions only when a distinct topic cannot otherwise be
evaluated.

Questions MUST NOT:

- test syntax, definitions, or generic framework trivia;
- be answerable without reference to the current task;
- disclose the expected answer before the developer responds;
- demand the agent's exact wording;
- inflate a trivial task into an exam.

## 5. Evaluation standard

Evaluate the substance and causal links in the developer's own words.

### PASS

Use `passed` when the response correctly connects the required ownership topics
to the relevant evidence, mechanism, behavior, or trade-off. Minor wording or
irrelevant detail gaps do not prevent a pass.

### PARTIAL

Use `partial` when the developer explains the core mechanism but misses or
confuses an important ownership topic. Record the missing concept, teach only
that concept using task evidence, and ask one focused application question.
Dependent work remains locked.

### FAIL

Use `failed` when the core causal model is absent, materially incorrect, merely
memorized without the needed causal link, or not demonstrated. Retrace the
smallest relevant reasoning chain, teach the necessary concept, and ask a
simpler question in a fresh form. Dependent work remains locked.

"I understand," "continue," "looks good," "OK," "tests pass," and equivalent
acknowledgements are not answers. They cannot produce `passed`.

Teaching MUST remain supportive and proportional. It MUST NOT shame the
developer, turn into an unrelated tutorial, answer the follow-up on the
developer's behalf, or silently lower the passing standard.

## 6. Prediction pattern

Use `PREDICT -> OBSERVE -> COMPARE` only when committing to an outcome before
seeing it provides useful evidence of the developer's mental model.

1. Ask for a concrete prediction and causal reason.
2. Record the prediction before the observation.
3. Obtain a safe, focused observation.
4. Compare predicted and observed behavior.
5. Ask the developer to explain a material match or mismatch.

For implementation work, the formal applicability decision remains after the
required verification result. A gate may use an additional focused observation
after that pass; it MUST NOT delay primary verification, rewrite its expected
result, or treat prediction as a replacement for verification. An important
technical decision outside implementation may use prediction before acceptance
when the state already records that ownership validation is required.

When a verified prerequisite refactor establishes a boundary that dependent
work will use, decomposition may record the material ownership reason and
topics in advance, but MUST NOT ask the question before verification. After
verification passes, that required checkpoint remains a dependency; dependent
work stays locked until the gate passes.

The checkpoint is not an instruction to "assess whether a gate applies later."
Its applicability was established by the specific dependency evidence. Only
new evidence that invalidates that reason may return it to `unassessed`; absent
that, successful verification transitions directly to the required gate.

Skip prediction when the outcome is obvious, no useful observation exists, or
the exercise would add interaction without improving ownership.

## 7. Remediation and recovery

- **Partial understanding:** keep `required: true`, set `partial`, explain the
  missing topic, ask a focused follow-up, and re-evaluate.
- **Failed understanding:** keep `required: true`, set `failed`, retrace the
  relevant evidence and mechanism, ask a simpler question, and re-evaluate.
- **Unstable evidence:** stop the gate and return to investigation when the
  explanation being tested is contradicted or the root cause is invalidated.
- **Requirement disagreement:** return to task understanding when the response
  reveals a product or design choice rather than a knowledge gap.
- **Developer declines:** record that no substantive evidence was provided and
  keep the required gate incomplete without argument.
- **Repeated difficulty:** reduce the explanation or question boundary, or
  revisit investigation; never waive a required gate.

## 8. Anti-ceremony rules

The protocol optimizes for the least interaction that establishes meaningful
ownership:

- decide applicability before asking anything;
- ask nothing when `required: false`;
- prefer one high-signal question;
- scale depth to significance, risk, novelty, and maintenance value;
- reuse a strong causal answer across overlapping ownership topics;
- stop questioning as soon as the required topics are demonstrated;
- do not create gates for administrative progress or user approval.

A small diff is not automatically trivial, and a large diff is not
automatically important. The content of the reasoning controls the gate.

## 9. Enforcement boundary

State-machine or adapter tooling can enforce that:

- applicability is explicitly `true` or `false` before a step passes;
- a false decision has `not_applicable` and asks no questions;
- a true decision has a reason, ownership topics, and a valid status;
- dependent work remains locked for `pending`, `partial`, or `failed`;
- only `passed` can satisfy a required gate.

Prompting and tooling cannot prove genuine human understanding. The evaluation
still requires judgment based on the developer's explanation. Behavioral
scenarios are therefore required to detect ceremonial questions, answer
leakage, superficial passes, and overuse.

## 10. Scenario coverage

Focused behavioral examples are defined in
[understanding-gate.md](../tests/scenarios/understanding-gate.md). They cover
not-applicable decisions, all evaluation outcomes, superficial acknowledgement,
trivial work, subtle SQL reasoning, and architectural ownership.
