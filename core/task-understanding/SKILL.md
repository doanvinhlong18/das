---
name: task-understanding
description: Frame a software task before investigation or modification. Use when a new request, bug report, feature, or approved scope change needs explicit requested behavior, expected behavior, evidence-backed knowns, unknowns, scope boundaries, and a future verification direction.
---

# Task Understanding

## Purpose

Establish what the task means before investigation or implementation. Produce a
bounded problem statement without inventing causes or prescribing a patch.

## Shared Minimality Policy

Apply [the minimality policy](../../docs/MINIMALITY_POLICY.md). Before adding
detail or user interaction, ask what failure it prevents. Record only enough to
make expected behavior, scope, uncertainty, and verification direction
unambiguous.

## Trigger

Run when task state is new or has returned to `understanding` because the goal,
expected behavior, scope, or a material assumption changed.

## Preconditions

- A user request or approved scope amendment exists.
- The current workflow stage permits understanding work.
- Available project configuration and prior task state are identified.

## Inputs

- The user's request and clarifications.
- Existing task state, if any.
- Project configuration, repository boundaries, and directly relevant
  documentation.
- Read-only repository evidence needed to interpret the request.

## Process

1. State **WHAT** is requested or incorrect in observable terms. Separate the
   reported symptom from any proposed solution.
2. State **EXPECTED** behavior precisely enough to distinguish success from the
   current or undesired behavior.
3. Record **KNOWN** information only when supported by a source. A user report
   is evidence that the behavior was reported, not automatic proof of the
   underlying mechanism.
4. Record **UNKNOWN** questions that investigation must answer. Mark a question
   blocking only when continuing would require a material guess.
5. Define **SCOPE** with explicit included and excluded behavior. Preserve
   unrelated findings for later rather than expanding the task.
6. Define **VERIFY** as an initial observable demonstration of correctness. Do
   not claim that this is the final verification strategy before investigation
   identifies the controlling behavior.
7. Select a readiness outcome:
   - `READY_FOR_INVESTIGATION` for non-trivial, ambiguous, causal, cross-layer,
     or risky work;
   - `READY_FOR_MINIMAL_DECOMPOSITION` only when direct evidence shows a local,
     mechanical, low-risk change with no meaningful uncertainty;
   - `BLOCKED` when expected behavior or a genuine product/design choice cannot
     be inferred safely.

Use this output shape:

```text
WHAT:
EXPECTED:
KNOWN:
UNKNOWN:
SCOPE:
VERIFY:
READINESS:
```

## Outputs

- A task goal and observable expected behavior.
- Evidence-backed knowns and explicit unknowns.
- In-scope and out-of-scope boundaries.
- An initial verification direction.
- A readiness recommendation with rationale.

## Allowed Actions

- Read task state and project configuration.
- Read and search repository files or authoritative documentation to clarify
  terminology and boundaries.
- Ask focused requirement, product, or design clarification questions.
- Record facts, unresolved questions, task fields, scope, and task mode.

## Forbidden Actions

- Do not modify production code, tests, configuration, or dependencies.
- Do not run a speculative edit to discover what the request means.
- Do not invent or confirm a root cause.
- Do not prescribe implementation details or produce a patch plan prematurely.
- Do not treat a requested solution as proof that it is the correct solution.
- Do not expand scope to adjacent behavior without explicit approval.
- Do not quiz the developer to cross this workflow stage. A clarification about
  requirements is not an Understanding Gate.
- Do not advance workflow state directly; return readiness to the orchestrator.

## Exit Criteria

Exit successfully when:

- WHAT and EXPECTED are unambiguous enough for the next permitted activity;
- KNOWN items have inspectable sources;
- material UNKNOWN items are recorded with blocking status;
- scope is bounded;
- a future verification direction exists;
- readiness is justified as investigation, minimal decomposition, or blocked.

## State Effects

May propose updates only to:

- `task.goal`, `task.expected_behavior`, `task.mode`, and `task.scope`;
- `reasoning.facts` for directly observed context;
- `reasoning.unresolved_questions`;
- transition evidence supporting a move from `understanding`.

Must not create confirmed root causes, implementation changes, verification
results, Understanding Gate results, or completed task state.

## Failure Behavior

- If expected behavior cannot be inferred, remain in `understanding`, add a
  blocking question, and ask the smallest useful clarification.
- If requirements conflict, show the conflict and its consequences rather than
  selecting one silently.
- If repository context is unavailable, record the limitation and avoid claims
  about where behavior lives.
- If a supposedly trivial task reveals ambiguity, risk, or cross-layer impact,
  switch to `standard` mode and recommend investigation.

## Lightweight Path

Use `READY_FOR_MINIMAL_DECOMPOSITION` when all of these are true:

- requested and expected behavior are explicit;
- the affected area is directly observable and local;
- the change is mechanical rather than causal or architectural;
- blast radius and risk are low;
- one focused verification can demonstrate the result.

Keep the output brief, but still record scope, direct evidence, and verification
direction. Do not bypass decomposition or authorize implementation.

## Examples

**Local rename:** Record the incorrect identifier and requested identifier as
WHAT/EXPECTED, cite the declaration and references as KNOWN, set UNKNOWN empty,
bound scope to that local symbol, propose a focused reference/compile check, and
return `READY_FOR_MINIMAL_DECOMPOSITION`.

**Ambiguous report:** For "checkout is broken," record the report as KNOWN but
leave the actual incorrect behavior UNKNOWN. Ask which input, result, and
environment reproduce it; remain `BLOCKED` rather than guessing.
