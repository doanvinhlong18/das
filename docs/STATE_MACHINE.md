# Task State and Transition Semantics

## Status and purpose

This document defines the portable task-state contract for
`dev-agent-skills`. It implements the ownership boundaries in
[ARCHITECTURE.md](ARCHITECTURE.md) and remains subordinate to
[PHILOSOPHY.md](PHILOSOPHY.md) and
[CORE_PRINCIPLES.md](CORE_PRINCIPLES.md).

The state exists to preserve reasoning, prevent coding ahead, make transitions
reviewable, distinguish evidence from assumptions, track verification, and
conditionally track developer understanding. It is a file-based contract, not
a workflow server or general-purpose execution engine.

The reference representation is
[task-state.yaml](../templates/task-state.yaml).

## 1. Design principles

The state model follows these rules:

1. **One source of task truth:** workflow decisions use the explicit task state,
   not an agent's hidden recollection.
2. **Orthogonal status fields:** workflow stage, step readiness, implementation,
   verification, and understanding are recorded separately. This avoids one
   overloaded status with ambiguous meanings.
3. **Evidence remains typed:** facts, hypotheses, and confirmed root causes use
   different structures and cannot be silently interchanged.
4. **One active step:** at most one logical step may be `active` or
   `in_progress` at a time.
5. **Expectations precede observations:** verification records the expected
   result before implementation and before the post-change observation whenever
   practical.
6. **Understanding is conditional:** `required` is not assumed from code size,
   implementation, or a phase boundary.
7. **Proportional records:** trivial work may use a compact state instance, but
   omitted prose must not remove a required invariant.
8. **Core-owned transitions:** adapters persist state and domains advise; only
   core workflow policy authorizes transitions.
9. **Minimal sufficient records:** state captures every invariant and decision
   needed to prevent a credible failure, but does not duplicate explanations or
   require optional detail without a task-specific purpose.

## 2. State structure

### 2.1 Task

`task` identifies the work and its boundary:

- `id` and `title` provide stable identity;
- `goal` states the desired outcome;
- `expected_behavior` states the observable task-level result;
- `status` is `active`, `blocked`, or `complete`;
- `mode` is `minimal` or `standard`;
- `scope.in_scope` and `scope.out_of_scope` bound the work;
- `scope.approved_expansions` records explicit scope changes rather than
  silently rewriting the original boundary.

`mode: minimal` reduces documentation volume. It does not relax scope,
verification, evidence classification, or one-active-step constraints.

`task.status` mirrors workflow state: it is `blocked` exactly when
`workflow.stage` is `blocked`, `complete` exactly when the stage is `complete`,
and `active` otherwise. A transition must update both fields atomically.

### 2.2 Workflow

`workflow.stage` uses these stable stages:

| Stage | Responsibility |
| --- | --- |
| `understanding` | Establish goal, expected behavior, scope, knowns, and unknowns |
| `investigation` | Collect and classify evidence; evaluate causal explanations |
| `decomposition` | Define bounded logical steps, dependencies, and verification strategies |
| `implementation` | Modify only the active ready step |
| `verification` | Compare observed behavior with the independently recorded expectation |
| `understanding_gate` | Evaluate a required developer-ownership gate |
| `complete` | Record task completion after every completion condition passes |
| `blocked` | Stop because a required input, permission, or safe next action is unavailable |

`previous_stage` supports resuming from `blocked`. `transition_log` records the
time, prior and next stage, reason, and evidence references for each applied
transition. The log is append-only in normal operation; corrections should add
a correcting entry instead of erasing decision history.

`NEXT_STEP` and gate applicability are transition decisions, not permanent
workflow stages. After verification passes, the core evaluates understanding
applicability and either activates the next eligible step, enters
`understanding_gate`, or completes the task.

### 2.3 Reasoning

#### Facts

A fact is directly observed and includes:

- a stable `id`;
- a factual `statement`;
- `source.type`, such as `repository`, `runtime`, `test`, `log`, `query`, or
  `documentation`;
- a reproducible `source.reference`;
- `observed_at` when time affects reproducibility.

Facts are not conclusions. For example, "the query returned two rows for order
42" may be a fact; "the join is wrong" is a hypothesis until supported.

#### Hypotheses

A hypothesis includes a statement, its current status, supporting and
conflicting evidence references, and a falsification test when one is relevant.
Its status is one of:

- `active`: not yet distinguished from credible alternatives;
- `supported`: evidence favors it but does not yet establish causality;
- `weakened`: conflicting evidence reduces confidence;
- `disproven`: discriminating evidence contradicts it.

Changing a hypothesis to `supported` does not create a confirmed root cause.

#### Confirmed root causes

A confirmed root-cause record is separate from the hypothesis list and must
contain:

- the causal statement;
- the originating hypothesis identifier when applicable;
- evidence references that connect the cause to the observed behavior and
  distinguish credible alternatives;
- confirmation time;
- invalidation time when later evidence overturns it.

Root cause may be `not applicable` conceptually for feature work, mechanical
changes, or tasks that do not make a causal defect claim. An empty root-cause
list must not be interpreted as permission to implement a non-trivial bug fix
whose cause remains material and unresolved.

#### Unresolved questions

Each unresolved question records whether it is blocking and which decision or
stage needs its resolution. Non-blocking uncertainty remains visible but does
not freeze unrelated actions.

### 2.4 Plan and logical steps

`plan.active_step_id` is null outside active implementation or references
exactly one step. Each step records:

- `objective` and `reason`;
- dependencies by step identifier;
- expected affected area;
- step-level expected behavior;
- included and excluded scope;
- readiness and implementation state;
- actual changes and unexpected observations;
- verification and conditional understanding records;
- derived completion status.

Step readiness uses:

| Value | Meaning |
| --- | --- |
| `locked` | Dependencies or prior gates prevent implementation |
| `ready` | Preconditions pass and the step may be selected |
| `active` | This is the only step currently selected for implementation |
| `done` | Verification passed and any required understanding gate passed |

Implementation status uses:

| Value | Meaning |
| --- | --- |
| `not_started` | No project modification for this step has begun |
| `in_progress` | The current implementation action is underway |
| `implemented` | The scoped modification is complete and must be verified |
| `not_applicable` | The step is a non-implementation decision or artifact |

`completion: passed` is a derived assertion. It is valid only when:

1. implementation is `implemented` or legitimately `not_applicable`;
2. verification is `pass` or legitimately `not_required`;
3. understanding is `passed` when required, or `not_applicable` when not
   required;
4. no blocking question or unresolved scope change invalidates the step.

Keeping the source fields separate makes this assertion auditable and prevents
a single status edit from bypassing verification or understanding.

The active step keeps readiness `active` while it awaits verification or a
required gate, even after implementation becomes `implemented`. When the step
passes, readiness becomes `done` and `plan.active_step_id` is cleared before a
later step is selected.

### 2.5 Verification

Each step records whether verification is required and why. When required:

- `strategy` identifies focused checks appropriate to the behavior and risk;
- `expected_result` and `expected_recorded_at` are populated before
  implementation begins and before the post-change result is judged;
- `observed_result` and `observed_at` record what actually happened;
- `result` is `pending`, `pass`, `fail`, or `inconclusive`;
- `evidence_refs` identify commands, tests, queries, logs, runtime observations,
  or diff inspection;
- `limitations` state what the evidence does not prove.

If verification is genuinely unnecessary, `required` is false, `reason` must
explain why, and `result` is `not_required`. Lack of a convenient test is not a
valid reason to mark verification unnecessary.

When timestamps are available, `expected_recorded_at` must not be later than the
implementation `started_at` or verification `observed_at`. If an exceptional
workflow observes behavior before an independent expectation can be recorded,
that observation cannot produce `pass`; establish the expectation and perform a
fresh verification observation instead of converting the first observation
into the expected result.

### 2.6 Developer understanding

Understanding is stored per logical step or evidence-backed technical decision
because ownership value depends on the specific change or accepted boundary,
not the task or phase name.

`understanding.required` has three lifecycle values:

- `null`: applicability has not yet been evaluated;
- `false`: no gate is required;
- `true`: a gate is required.

The related status rules are:

| `required` | Valid status |
| --- | --- |
| `null` | `unassessed` |
| `false` | `not_applicable` |
| `true` | `pending`, `partial`, `failed`, or `passed` |

After verification is `pass` or legitimately `not_required`, understanding
`required` must be resolved to true or false before the step can pass. For an
important technical decision outside implementation, it is resolved at the
point the decision would be accepted and before dependent work relies on it.

A plan may also contain a required ownership-checkpoint dependency for a
prerequisite boundary. It records the reason and topics before implementation
but does not ask or evaluate the gate early. After prerequisite verification
passes, the checkpoint requires `verification -> understanding_gate`; it may
not be downgraded to an optional applicability assessment without new evidence
that invalidates the recorded reason.

Both true and false require a meaningful `reason`. When true,
`ownership_topics` must identify the actual causal, architectural, data-flow,
or risk concepts the developer needs to own. When false, the list is normally
empty; it must not contain questions disguised as a gate.

Questions, developer responses, and evaluation notes are recorded only when a
gate is required. A superficial acknowledgement cannot produce `passed`.

### 2.7 Out-of-scope observations

An out-of-scope record contains the observation, evidence, potential impact,
the action taken, and a possible future step. Its normal action is
`not_modified`. Recording an observation does not add it to the plan or expand
scope.

Human-readable reports use the standardized block in
[MINIMALITY_POLICY.md](MINIMALITY_POLICY.md); its Evidence, Impact, Action, and
Potential follow-up values map directly to this record.

## 3. Transition authority and atomicity

`guided-development` is the transition authority defined by the architecture.
Child skills may propose limited field updates, but the orchestrator validates
all cross-field invariants before applying a transition.

A transition and its required state changes should be treated as one logical
update. For example, entering `implementation` requires all of these together:

- one selected step changes from `ready` to `active`;
- `plan.active_step_id` becomes that step's identifier;
- the step implementation changes from `not_started` to `in_progress`;
- every other unfinished step remains `locked` or `ready`, never `active`.

Adapters may serialize or persist this update. Domains may advise the active
core skill. Neither may authorize or apply a workflow transition independently.

## 4. Legal workflow transitions

| From | To | Required conditions |
| --- | --- | --- |
| start | `understanding` | Task identity and request exist |
| `understanding` | `investigation` | Goal, expected behavior, scope, knowns, unknowns, and initial verification direction are recorded |
| `understanding` | `decomposition` | Minimal-mode task only; direct evidence shows a mechanical, low-risk change and no causal investigation is needed; create one compact bounded step |
| `investigation` | `investigation` | A hypothesis is tested or new evidence is classified |
| `investigation` | `understanding` | Evidence exposes an unresolved requirement, expected-behavior conflict, or scope ambiguity that investigation cannot decide |
| `investigation` | `decomposition` | Evidence is sufficient for bounded steps; material causal claims are confirmed or explicitly unresolved as blockers |
| `decomposition` | `understanding` | Planning exposes a requirement, expected-behavior, or approved-scope decision that must be resolved first |
| `decomposition` | `investigation` | Evidence is insufficient for a bounded step or a material causal assumption remains unresolved |
| `decomposition` | `understanding_gate` | An evidence-backed technical decision outside implementation has named alternatives, trade-offs, consequences, and verification analysis; dependent work is explicitly locked on a required decision gate |
| `decomposition` | `implementation` | Exactly one dependency-satisfied step is `ready` and selected as active; future steps remain locked |
| `implementation` | `understanding` | Expected behavior or scope meaning becomes ambiguous; implementation stops and any partial work is reconciled first |
| `implementation` | `investigation` | Root cause or a material implementation assumption is invalidated; implementation stops and any partial work is reconciled first |
| `implementation` | `decomposition` | A new dependency, invalid step boundary, or approved scope-model change is recorded; implementation stops and any partial work is reconciled first |
| `implementation` | `verification` | Active step is `implemented` or legitimately `not_applicable`; actual output, changes, and unexpected observations are recorded; no future step was modified |
| `verification` | `understanding` | Evidence shows the expected behavior or product decision is wrong or unresolved; original expectation and observation remain preserved |
| `verification` | `investigation` | Result is `fail` or `inconclusive`, new causal evidence appears, or the root cause is invalidated |
| `verification` | `decomposition` | A new dependency, legitimate scope change, or invalid plan boundary is recorded |
| `verification` | `implementation` | Failure evidence conclusively identifies a bounded defect in the same active step; the retry reason is recorded; verification is reset; this is not an automatic patch loop |
| `verification` | `understanding_gate` | Verification is `pass` or legitimately `not_required`, understanding is `required: true`, and status is `pending` |
| `verification` | next eligible step | Verification is `pass` or legitimately `not_required`, understanding is `required: false` with `not_applicable`, and the current step becomes `done` |
| `understanding_gate` | `understanding_gate` | Status is `partial` or `failed`; focused teaching occurs and a targeted re-evaluation is recorded |
| `understanding_gate` | `understanding` | A gate response exposes a requirement or design disagreement rather than a knowledge gap |
| `understanding_gate` | `investigation` | Gate evaluation exposes unstable evidence or an invalidated causal explanation |
| `understanding_gate` | next eligible step | Status is `passed`; the current implementation step becomes `done` or the technical decision becomes `accepted`; dependencies are recalculated |
| next eligible step | `implementation` | Exactly one newly eligible step becomes `ready` then `active` |
| next eligible step | `complete` | No unfinished required steps, blocking questions, unresolved scope changes, failed verification, or required pending gates remain; final diff scope review passes |
| any active stage | `blocked` | A required input, permission, or safe action is unavailable and the reason is recorded |
| `blocked` | previous valid stage | The blocker is resolved and prior-stage invariants still hold |

"Next eligible step" is a decision outcome, not a stored stage. If multiple
steps are dependency-ready, the orchestrator selects at most one as `ready` and
keeps the others `locked` until a later selection; it never activates more than
one.

A decision-level gate is not requirement clarification, scope approval, root-
cause confirmation, or approval of an unverified proposal. It is legal only
after investigation and decomposition have produced an evidence-backed choice
with named trade-offs and a dependency graph showing which work would rely on
it. Until the gate passes, those implementation steps remain locked and none is
selected as `ready`.

A recovery transition out of `implementation` is legal only after project
state and task state agree. If the current iteration made no project change, or
its own partial changes were safely removed, the orchestrator sets the step
implementation back to `not_started`, sets its readiness to `locked`, clears
`plan.active_step_id`, and routes to reasoning. If partial changes remain, they
must be recorded without overwriting pre-existing developer work and the task
enters `blocked` until reconciliation is possible. A reasoning skill must not
run against an unrecorded partial implementation.

The minimal-mode transition from `understanding` to `decomposition` skips a
separate investigation phase only when direct evidence makes causal analysis
unnecessary. Decomposition still creates one bounded step with a predeclared
verification expectation before implementation begins.

## 5. Legal reasoning transitions

Reasoning records have their own rules independent of workflow stage:

| From | To | Required evidence |
| --- | --- | --- |
| observation | fact | Direct source and reproducible reference |
| fact set | hypothesis | Explicit inference plus a falsification or discrimination method when material |
| active hypothesis | supported | Evidence favors it but causal alternatives remain |
| active/supported hypothesis | disproven | Evidence contradicts its prediction |
| active/supported hypothesis | confirmed root-cause record | Evidence connects cause and symptom and distinguishes credible alternatives |
| confirmed root cause | invalidated root cause | New evidence contradicts the causal account; downstream assumptions are reopened |

Confirmation creates a separate root-cause record; it does not relabel the
hypothesis in place. This preserves the promotion evidence and prevents silent
changes in certainty.

## 6. Illegal transitions and states

The following must be rejected:

- `locked` step to `in_progress` or `implemented`;
- any step becoming `implemented` while another step is active;
- future-step file changes while a different step is active;
- hypothesis to confirmed root cause without causal evidence references;
- `implemented` step to `completion: passed` when required verification is
  pending, failed, or inconclusive;
- implementation directly to task `complete` without the verification decision;
- verification `pass` to a next step while `understanding.required: true` and
  status is `pending`, `partial`, or `failed`;
- `understanding.required: false` with any status other than `not_applicable`;
- `understanding.required: true` without a meaningful reason or ownership topic;
- failed verification followed by repeated silent edits without a recorded
  recovery transition and reset expectation;
- two active steps or two `in_progress` implementations;
- task `complete` with an unfinished planned step, blocking question, invalidated
  root cause still relied upon, unresolved approved scope change, or unreviewed
  final diff;
- a domain skill, adapter, project setting, or user pressure directly changing
  the workflow stage;
- using a line-count, file-count, or phase-name threshold as the sole reason for
  requiring an Understanding Gate.

Invalid state must fail closed: preserve the evidence, record the inconsistency,
and return control to the earliest stage that can repair it. It must not be
normalized by silently inventing missing evidence.

## 7. Recovery paths

### Failed verification

Record `result: fail`, the observed result, evidence, and limitations. Do not
patch inside verification. Return to:

- `investigation` when the cause or expectation is uncertain;
- `decomposition` when the plan, dependency, or scope boundary is wrong;
- `implementation` only when the failure conclusively identifies a bounded
  defect in the same step and a deliberate retry is recorded.

Each retry resets the verification result to `pending` while preserving prior
observations in evidence or transition history.

### Inconclusive verification

Record what the check did and did not establish. Return to investigation to find
better evidence, or mark the task blocked if required evidence is unavailable.
`inconclusive` never unlocks a next step.

### Disproven hypothesis

Mark the hypothesis `disproven`, link the contradicting evidence, and continue
investigation. Do not delete the hypothesis; its history prevents repeated
rediscovery and shows why it was rejected.

### Changed or invalidated root cause

Set `invalidated_at`, reopen the relevant unresolved question, move to
investigation, and lock every unfinished step that depends on the invalidated
cause. Previously completed steps are re-examined if their correctness depended
on it.

### New dependency during implementation

Stop implementation, record the dependency as an unexpected observation, and
return to decomposition. Add or revise steps explicitly; do not implement the
dependency under the current step unless it is proven to be inside the existing
scope boundary.

### Partial developer understanding

Keep `required: true`, set status to `partial`, identify the missing concept,
teach only that concept, and remain in `understanding_gate` for a targeted
follow-up. No future step unlocks.

### Failed developer understanding

Keep `required: true`, set status to `failed`, stop implementation, retrace the
relevant reasoning with current evidence, and ask a simpler targeted question.
The workflow remains in `understanding_gate` until a substantive pass.

### Unrelated issue

Add an `out_of_scope_observations` record with evidence, impact, action
`not_modified`, and an optional future step. Do not add it to the active plan
unless it blocks the current task and the developer approves a scope change.

### Legitimate scope expansion

Record the proposed expansion and reason, obtain explicit approval, append it to
`scope.approved_expansions`, and return to the earliest affected stage. New work
is decomposed and remains locked until its dependencies and normal transition
requirements pass.

## 8. Deciding Understanding Gate applicability

After successful verification, or at the acceptance point of an important
technical decision outside implementation, evaluate:

> Would misunderstanding this specific change materially reduce the
> developer's ability to maintain, debug, extend, or reason about the resulting
> software?

Consider the combined evidence, not a numeric score:

- **complexity:** is the mechanism non-obvious or easy to misread?
- **behavioral significance:** does the change alter user-visible or system
  behavior?
- **architectural significance:** does it establish boundaries, dependencies,
  or patterns later work will rely on?
- **maintenance importance:** will future changes require this mental model?
- **debugging importance:** would failure diagnosis depend on understanding the
  changed flow or invariant?
- **novelty:** is the concept unfamiliar in this project or to the developer?
- **risk:** could misunderstanding cause data loss, security issues, financial
  errors, outages, or subtle regressions?

Set `required: true` only when the answer is materially yes, record a specific
reason, and name the smallest useful set of ownership topics. Otherwise set
`required: false`, record why a gate adds no material ownership value, leave
topics empty, and set status to `not_applicable`.

File count, line count, language, framework, phase name, and the mere presence
of code are not sufficient gate rules. A one-line transaction change may
require a gate; a large generated-file update may not.

## 9. Ceremony control

Apply the failure-prevention test from
[MINIMALITY_POLICY.md](MINIMALITY_POLICY.md): "What failure is this step
preventing?" Keep an action or record when it protects a workflow invariant or
credible task risk; otherwise omit, combine, or shorten it.

A minimal-mode state may keep:

- short scalar task fields;
- one directly observed fact;
- no hypotheses or root cause when no causal claim is needed;
- one step with no dependencies;
- one expected result and focused verification strategy;
- a concise `understanding.required: false` rationale when no ownership value
  exists.

It may omit empty optional history detail, but must not omit the active-step
boundary, expected-versus-observed result, scope, or gate applicability outcome.
If the task becomes ambiguous, cross-layer, causally uncertain, or risky, change
`mode` to `standard` and populate the needed records before continuing.

The YAML template shows the standard shape because it is easier to remove empty
optional detail than to reconstruct lost reasoning later. Adapters may present a
compact view while preserving the same semantic fields.

## 10. Validation scenarios

### 10.1 Trivial rename

**State path:** `understanding -> decomposition -> implementation ->
verification -> complete` in `minimal` mode.

Record the requested name, one fact showing the incorrect local identifier, one
bounded step, and a focused diff/search or compile check. No causal hypothesis
or multi-step decomposition is needed.

**Understanding:** `required: false`, status `not_applicable`.

**Reason:** a mechanical local rename with no behavioral change creates no
material maintenance or debugging concept to test.

### 10.2 SQL bug

**State path:** `understanding -> investigation -> decomposition ->
implementation -> verification -> understanding_gate -> complete`.

Facts record the incorrect rows, query text, schema, and focused query results.
A duplicate-row explanation remains a hypothesis until join cardinality or a
controlled query proves it. The step records the expected row set before the
query change and compares it with the observed result afterward.

**Understanding:** `required: true` for a non-obvious cardinality fix.

**Reason:** future maintenance and debugging require the developer to understand
why the join multiplied rows and why the corrected relationship is valid.

### 10.3 Multi-layer feature

**State path:** standard understanding, investigation, and decomposition,
followed by repeated one-step implementation and verification cycles.

Controller, service, repository, and database work are represented as logical
behavior steps with explicit dependencies, not activated together. Each step's
gate applicability is evaluated independently.

**Understanding:** mixed. Mechanical endpoint wiring may be `required: false`,
while a transaction boundary or cross-layer data-flow decision may be
`required: true`.

**Reason:** ownership value follows the reasoning in each logical change, not
the size of the overall feature.

### 10.4 Failed verification

**State path:** `implementation -> verification -> investigation` (or a
justified recovery stage), never directly to the next step.

Record the failed observed result and preserve the original expectation. Gate
applicability remains `null` and status `unassessed` because the step has not
been successfully verified.

**Understanding:** not yet evaluated.

**Reason:** a gate cannot compensate for an implementation whose behavior does
not match the expected result.

### 10.5 Meaningful architecture change

**State path:** the decision is investigated and documented; applicability is
evaluated at acceptance before dependent implementation is unlocked.

Verification may consist of constraint analysis, dependency-direction review,
and scenario evaluation rather than runtime tests.

**Understanding:** `required: true`.

**Reason:** later implementation, maintenance, and debugging will depend on the
developer understanding the chosen boundary and its trade-offs.

### 10.6 Documentation-only task

**State path:** proportional understanding, one bounded documentation step,
focused verification, and completion.

Verification may check requested-topic coverage, links, examples, and
consistency. Documentation does not automatically mean verification is
unnecessary.

**Understanding:** normally `required: false`, status `not_applicable`.

**Reason:** wording, formatting, or administrative documentation alone carries
no material software reasoning to own. If the document accepts an important
architecture decision, Scenario 10.5 applies instead.

## 11. Completion conditions

A task may enter `complete` only when:

- the requested goal and scope are satisfied;
- every required plan step has `completion: passed`;
- verification supports the pre-established expected behavior;
- all required Understanding Gates have passed;
- no blocking question or invalidated assumption remains;
- no unapproved scope expansion was implemented;
- the final diff has been reviewed against scope;
- limitations and out-of-scope observations remain visible.

Task completion is not inferred from compilation, green tests, an implemented
status, or developer pressure to move on.

## 12. Deliberate limits

This protocol does not define file locking, concurrent writers, digital
signatures, database persistence, event sourcing, or executable transition
code. It also cannot prove that evidence is truthful or that developer
understanding is genuine.

The initial contract is intentionally inspectable YAML plus normative Markdown.
Later adapters and validation scripts may enforce structural invariants, but a
workflow service is not justified until real-task use demonstrates the need.
