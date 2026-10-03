---
name: understanding-gate
description: Assess whether a verified logical change or accepted technical decision needs developer understanding validation, and when required evaluate task-specific causal ownership with minimal questions. Use after successful verification or before dependent work accepts an important technical decision; skip questioning when no material ownership risk exists.
---

# Understanding Gate

## Purpose

Protect developer ownership of technical reasoning that matters for future
maintenance, debugging, extension, or risk management.

This skill first decides whether validation is useful. It asks questions only
when the specific change creates a material ownership need. It does not act as
a generic workflow gate.

## Shared Minimality Policy

Apply [the minimality policy](../../docs/MINIMALITY_POLICY.md). A gate, question,
teaching step, or prediction must prevent a specific ownership failure. Ask
nothing when applicability is false and stop as soon as the required ownership
topics are demonstrated.

## Trigger

Run when either:

- an active implementation step has verification result `pass` or legitimately
  `not_required`, and understanding applicability is `unassessed`; or
- an evidence-backed technical decision outside implementation is ready for
  developer acceptance, has named trade-offs or consequences, and dependent
  work would encode or rely on that decision.

Do not run merely because a phase ended, a file changed, or the user requested
the next action.

Risk, uncertainty, or a proposed fix does not by itself create a decision-level
gate. Before implementation, use task understanding for requirement, product,
scope, or acceptance questions and use investigation for causal uncertainty.

Do not use this skill for:

- clarifying intended behavior, expected results, or requirements;
- approving a scope expansion or choosing whether to split work;
- confirming an unverified root-cause explanation or proposed fix;
- recovering from failed or inconclusive verification;
- asking the developer to approve the agent's reasoning before ordinary
  implementation.

Those cases return to task-understanding, code-investigation, or
task-decomposition. A decision-level gate is reserved for an evidence-backed
technical choice whose accepted trade-offs must be owned before dependent work
can proceed, such as selecting an architecture boundary.

## Preconditions

- The specific change or decision being assessed is identified.
- Task scope, relevant facts, uncertainty, and expected behavior are available.
- For a decision-level gate, investigation and decomposition record the chosen
  boundary, credible alternatives, named trade-offs and consequences, the
  decision-verification analysis, and the dependent work that remains locked.
- For an implementation step, the diff, actual changes, and successful
  verification evidence are recorded.
- Any confirmed root cause relied upon by the change remains valid.
- No failed or inconclusive verification is being disguised as an ownership
  question.

If an implementation step has not passed verification, return control to the
appropriate workflow responsibility without assessing the gate.

## Inputs

- Task goal, expected behavior, and scope.
- Relevant facts, hypotheses, confirmed root cause, and unresolved questions.
- Active-step objective, scope boundary, and actual changes.
- Expected-versus-observed verification record and its limitations.
- The technical decision and trade-offs when no implementation is involved.
- Project risk context and relevant domain advice.
- Prior gate questions, responses, and evaluation notes during re-evaluation.

## Process

### 1. Assess applicability

Ask:

> Would misunderstanding this specific change materially reduce the
> developer's ability to maintain, debug, extend, or reason about the resulting
> software?

Evaluate the combined evidence, not a score or automatic trigger:

- behavioral and architectural significance;
- mechanism complexity and non-obviousness;
- maintenance and debugging importance;
- novelty in the project or available developer context;
- risk, including security, data, financial, concurrency, and operational risk;
- whether later work depends on the developer retaining this mental model.

Do not use line count, file count, language, framework, or the mere presence of
production code as the decision rule.

If the answer is no:

- set `required: false`;
- record a specific reason why questioning adds no material ownership value;
- leave `ownership_topics` empty;
- set `status: not_applicable`;
- ask no understanding questions;
- return `NO_GATE_REQUIRED` to the transition authority.

If the answer is yes:

- set `required: true`;
- record the material ownership reason;
- name only the concepts the developer needs to own;
- set `status: pending`;
- continue to question design.

### 2. Design the smallest useful gate

Derive questions from the actual task, evidence, root cause or design decision,
diff, observed behavior, and verification limitations. Select only dimensions
that reveal the named ownership topics:

- **WHY:** why the change or decision is necessary;
- **HOW:** how the changed mechanism produces the intended behavior;
- **FLOW:** how relevant data or control moves through the affected code;
- **EDGE CASE:** which material case is handled, excluded, or still risky;
- **COUNTERFACTUAL:** what would break if a key element were removed or changed;
- **PREDICTION:** what a meaningful input or state should produce and why.

Prefer one strong question to several weak questions. Add another only when a
separate ownership topic cannot be evaluated from the first answer. Ask in
plain language and permit the developer to answer in their own words.

Do not reveal a model answer before the initial response. Do not ask syntax
trivia, generic theory, vocabulary recall, or questions answerable without
understanding the current change.

### 3. Evaluate substantive understanding

Evaluate causal reasoning rather than wording similarity.

- `passed`: the response correctly connects the material ownership topics to
  the task's evidence, mechanism, and behavior, with no important misconception.
- `partial`: the developer owns the main mechanism but misses or confuses one
  important ownership topic.
- `failed`: the response lacks the core causal model, contains a material
  misconception, merely repeats conclusions, or provides no evidence of
  understanding.

"I understand," "continue," "looks good," "tests pass," and equivalent
acknowledgements are not evidence. A technically correct phrase without a
causal explanation is also insufficient when causality is the ownership topic.

Record the response and a concise evaluation tied to the ownership topics.

### 4. Remediate proportionally

For `partial`:

1. Identify the one missing or incorrect concept.
2. Teach only that concept using evidence from the current change.
3. Ask one focused follow-up that requires the developer to apply it.
4. Keep dependent work locked and re-evaluate the answer.

For `failed`:

1. Stop dependent implementation progression.
2. Retrace the smallest relevant reasoning path from evidence to behavior.
3. Teach the necessary concept without expanding into a general tutorial.
4. Ask a simpler targeted question in a fresh form.
5. Keep dependent work locked until a substantive pass.

Repeated difficulty should lead to a smaller explanation, a smaller ownership
question, or renewed investigation when the evidence itself is unclear. Never
waive the gate or silently lower the standard.

### 5. Use prediction only when it teaches

Use `PREDICT -> OBSERVE -> COMPARE` when committing to an outcome before seeing
it exposes a meaningful mental model. Record the prediction and its reason,
obtain a safe focused observation, then ask the developer to explain any match
or mismatch.

For implementation work, formal applicability remains post-verification. A
prediction exercise may use an additional focused observation after the step is
already verified; it must not move applicability ahead of verification or
replace the verification result. Do not use prediction for obvious output,
ceremony, or as a trick question.

## Output Format

```text
APPLICABILITY: REQUIRED | NOT_REQUIRED
REASON:
OWNERSHIP TOPICS:
QUESTIONS:               # only when required
DEVELOPER RESPONSES:     # only after answers
EVALUATION: PENDING | PASS | PARTIAL | FAIL | NOT_APPLICABLE
MISSING CONCEPT:         # only for partial/fail
TARGETED TEACHING:       # only for partial/fail
FOLLOW-UP QUESTION:      # only for partial/fail
READINESS RECOMMENDATION:
```

## Outputs

- A specific applicability decision and reason.
- The smallest useful set of ownership topics.
- No questions and `not_applicable` when validation has no material value.
- Task-specific questions and recorded developer responses when required.
- `passed`, `partial`, or `failed` with evidence-based evaluation notes.
- Focused teaching and a follow-up question for incomplete understanding.
- A readiness recommendation to the workflow transition authority.
- For a decision gate, an explicit recommendation to accept the decision and
  release its dependent plan steps only after `passed`, or to keep them locked
  for `pending`, `partial`, or `failed`.

## Allowed Actions

- Read task state, investigation evidence, plan, diff, verification evidence,
  and relevant project or domain context.
- Update only understanding-owned fields for the current step or decision.
- Ask targeted questions and record answers.
- Explain the missing concept using current-task evidence.
- Perform a safe, non-mutating observation for an optional prediction exercise
  after required verification has already passed.

## Forbidden Actions

- Do not modify production code, tests, configuration, dependencies, or scope.
- Do not require a gate automatically for code, a phase boundary, or a named
  technology.
- Do not ask questions after deciding `required: false`.
- Do not accept acknowledgement, confidence, memorized wording, or green tests
  as proof of understanding.
- Do not ask generic trivia or mechanically ask every question category.
- Do not answer on the developer's behalf or leak a model answer before the
  initial response.
- Do not use the gate to repair failed verification or uncertain root cause.
- Do not change verification results, activate a future step, mark a step
  `done`, unlock dependencies, or mark the task complete.
- Do not advance workflow state directly.

## Exit Criteria

Exit as `NO_GATE_REQUIRED` when `required: false`, a specific reason is
recorded, ownership topics are empty, status is `not_applicable`, and no
questions were asked.

Exit as `GATE_PASSED` when `required: true`, ownership topics and questions are
recorded, the developer responses demonstrate the required causal model, and
status is `passed`.

Remain `GATE_INCOMPLETE` when status is `pending`, `partial`, or `failed`.
Record the missing evidence or concept and the next targeted re-evaluation;
dependent implementation must remain locked.

## State Effects

May propose updates only to the assessed step's `understanding` record:

- `required`, `reason`, `ownership_topics`, and `assessed_at`;
- `status`;
- `questions` and `developer_responses` when required;
- `evaluation_notes` and remediation evidence.

May also append transition evidence supporting `NO_GATE_REQUIRED`,
`GATE_PASSED`, or `GATE_INCOMPLETE`. The orchestrator, not this skill, applies
workflow transitions, step completion, or dependency unlocking.

## Failure Behavior

- If verification is failed or inconclusive, do not assess applicability;
  return to verification recovery.
- If evidence or root cause is inconsistent, stop the gate and recommend
  investigation rather than testing understanding of an unstable explanation.
- If available evidence cannot support either applicability outcome, keep the
  decision `unassessed`, report the missing basis, and ask no gate question;
  do not invent a ceremonial gate or a false not-applicable rationale.
- If a response reveals a requirement or design disagreement rather than a
  knowledge gap, record it and return to task understanding.
- If the developer declines to answer a required gate, record that no
  substantive evidence was provided and keep dependent work locked without
  arguing or shaming.

## Examples

**Mechanical rename:** Verification confirms only the requested local rename.
Set `required: false`, explain that no behavioral or maintenance model changed,
set `not_applicable`, and ask nothing.

**Subtle join fix:** Verification confirms the corrected row set. Require a
gate when future query maintenance depends on understanding join cardinality.
Ask why the old relationship multiplied rows and what invariant the new join
uses; do not ask for generic SQL definitions.

**Partial transaction understanding:** The developer explains the transaction
boundary but misses why the exception must propagate for rollback. Mark
`partial`, teach only that rollback link, and ask what happens if the exception
is swallowed.
