---
name: guided-development
description: Coordinate an evidence-driven software task across understanding, investigation, decomposition, one-step implementation, verification, conditional developer understanding, recovery, and completion. Use to start or resume guided development from task state, choose the only valid child skill, enforce legal transitions, resist coding ahead, and provide a proportional fast path for genuinely trivial work.
---

# Guided Development

## Purpose

Own workflow coordination and transition decisions while delegating detailed
reasoning and project work to the appropriate child skill.

Treat task state as the source of truth. Select the next valid responsibility,
validate its result, and apply only legal state transitions. Do not reproduce
the child skill's investigation, planning, implementation, verification, or
teaching process.

## Non-Negotiable Gate Dependencies

- A verified implementation gate is never asked before verification.
- An evidence-backed architecture decision may require a decision gate before
  dependent implementation.
- When a bounded prerequisite centralizes duplicated production decisions that
  must remain consistent, and the next step will change that new shared
  decision, the plan MUST record a required ownership checkpoint. Activate only
  the prerequisite; keep the behavior step locked until unchanged-behavior
  verification and the checkpoint both pass. Do not rewrite this as "assess
  whether a gate applies later" or decide that no gate is justified.
- These rules do not create gates for documentation, setup, or mechanical work
  without a material ownership dependency.

## Shared Minimality Policy

Apply [the minimality policy](../../docs/MINIMALITY_POLICY.md). For every
optional workflow action ask what failure it prevents. Choose the smallest
valid path, avoid repeated explanation, and request developer input only for a
genuine decision, permission, scope change, or required ownership response.

## Trigger

Run when:

- a software task starts under the guided-development workflow;
- an existing task resumes from recorded state;
- a child skill returns evidence, readiness, failure, or recovery advice;
- the developer provides a clarification, scope decision, or required gate
  response; or
- new evidence may invalidate the current workflow position.

## Preconditions

- A task request exists.
- The state contract and applicable project instructions are available.
- Existing task state is readable, or a new state can be initialized from the
  shared template.
- Tool, repository, and permission boundaries are known before invoking a child
  action that uses them.

Do not infer a later stage from conversation history when persisted state says
otherwise. If state and observable repository evidence conflict, fail closed
and reconcile the conflict before further implementation.

## Inputs

- Current task state and transition history.
- User request, clarifications, scope approvals, and gate responses.
- Project configuration and repository instructions.
- Child-skill outputs and their proposed field updates.
- Relevant domain advice requested by the active child skill.
- Current diff or worktree evidence needed for scope and completion checks.

## Orchestration Invariants

- Keep exactly one workflow authority: this orchestrator.
- Invoke only the child responsibility valid for the current state.
- Keep at most one step active and one implementation in progress.
- Implement only the active logical step.
- Require verification before a step can pass.
- Assess understanding applicability after successful verification; do not
  assume a gate is required.
- Keep future work locked while the active step is incomplete.
- Preserve facts, hypotheses, root-cause history, verification observations,
  gate responses, limitations, and out-of-scope findings.
- Never use user pressure, adapter behavior, domain advice, or project settings
  as independent transition authority.
- Do not require user approval for ordinary evidence-based phase transitions.

## Process

### 1. Load or initialize state

For a new task, initialize task identity, goal placeholder, active status, and
`workflow.stage: understanding` from the task-state contract. Do not prefill a
root cause, plan, verification result, or understanding decision.

For an existing task, validate at least:

- task status agrees with workflow stage;
- `plan.active_step_id` is null or names exactly one active step;
- no second step is active or `in_progress`;
- the active step's implementation, verification, and understanding fields are
  mutually valid;
- when a prerequisite creates a shared boundary that a dependent step will
  rely on, the dependency record names both unlock conditions: prerequisite
  verification and the recorded ownership checkpoint;
- facts, hypotheses, and confirmed root causes remain structurally distinct;
- no transition relies on an invalidated root cause or blocking question;
- no unapproved scope change or future-step diff is being normalized away.

Reject invalid state rather than inventing missing evidence. Route to the
earliest responsibility that can repair it, or block when safe repair requires
developer input or worktree reconciliation.

### 2. Select the valid responsibility

Use this dispatch contract. The named child owns the detailed work; the
orchestrator owns only selection and the eventual transition.

| Current condition | Invoke or decide |
| --- | --- |
| New task or `understanding` | `task-understanding` |
| `investigation` | `code-investigation` |
| `decomposition` | `task-decomposition` |
| Evidence-backed technical decision is decomposed, its trade-offs are recorded, and dependent work is locked on developer acceptance | `understanding-gate` for decision-level applicability and evaluation before implementation |
| `implementation` with one active in-progress step | `incremental-implementation` |
| `verification` with implementation complete and verification pending | `verification` |
| Verification passed and understanding is unassessed | `understanding-gate` for applicability assessment |
| Verification passed and understanding is false/not applicable | Finalize the current step and select the next outcome |
| Verification passed and understanding is true/pending | Enter `understanding_gate` and invoke `understanding-gate` |
| `understanding_gate` with pending, partial, or failed status | `understanding-gate` for evaluation or targeted re-gate |
| `understanding_gate` with passed status | Finalize the current step and select the next outcome |
| `blocked` | Report the blocker; resume only after it is resolved and invariants still hold |
| `complete` | Report completion; invoke no implementation behavior |

Do not invoke implementation because a plan exists. The orchestrator must first
select exactly one `ready` step and apply the atomic activation transition.

### 3. Invoke one child contract

Provide only the relevant state projection, project constraints, and available
evidence. Let the child perform its own documented process.

Do not tell a child to produce a desired result. Domain skills may advise the
active child, but they cannot be invoked as substitutes for a core stage and
cannot update workflow position.

### 4. Validate the child result

Before applying it, confirm that:

- the child was valid for the current stage and condition;
- its preconditions and exit criteria are satisfied;
- its proposed updates stay within its documented state ownership;
- required evidence and limitations are present;
- the result does not modify a future step, broaden scope, or erase contrary
  evidence;
- a readiness label is supported by the actual returned artifacts;
- the repository or diff does not contradict the proposed state.

Reject an invalid child result and keep the current transition unapplied. Do
not synthesize evidence or silently repair another skill's output.

### 5. Apply transitions atomically

Apply child-owned updates and workflow-owned cross-field changes as one logical
state update. Append a transition record containing the prior stage, next
stage, reason, and evidence references.

Entering `blocked` must set `task.status: blocked`, preserve the prior stage,
and record the exact resumption condition. Leaving it restores
`task.status: active` only after the blocker is resolved and prior-stage
invariants still hold. Entering `complete` sets both workflow stage and task
status to `complete` in the same update.

When entering implementation:

- select exactly one dependency-satisfied `ready` step;
- set its readiness to `active`;
- set `plan.active_step_id` to that step;
- set its implementation status to `in_progress`;
- leave every other unfinished step non-active;
- confirm expected behavior and verification strategy were recorded first.

When a step passes verification and its understanding outcome is either
`passed` when required or `not_applicable` when not required:

- set its readiness to `done` and completion to `passed`;
- clear `plan.active_step_id`;
- recalculate dependencies;
- make at most one selected next step `ready` and keep other future work locked;
- choose a new implementation iteration or task-completion evaluation.

Do not mark a step done merely because implementation finished or tests are
green.

### 6. Preserve the implementation-iteration boundary

One implementation iteration contains one logical change, its verification,
and any required understanding gate. For non-trivial work, expose the completed
cycle, evidence, and next-step readiness before beginning another
implementation iteration. A plain "continue" is sufficient to start an
already-ready next step when no clarification, scope approval, permission, or
understanding response is outstanding.

This checkpoint is not a quiz and is not approval for every workflow phase.
Reasoning stages may advance automatically when their evidence contracts pass.

## Transition Routing

Use the child result and recorded evidence to choose the recovery destination:

| Evidence or result | Route |
| --- | --- |
| Goal, expected behavior, or product choice is ambiguous | `understanding` |
| Hypothesis, root cause, call flow, or verification evidence is uncertain | `investigation` |
| Step boundary, dependency, ordering, or approved scope model is wrong | `decomposition` |
| Evidence-backed technical decision has named trade-offs and dependent work would rely on it | `understanding_gate` before any dependent implementation |
| Current implementation is complete | `verification` |
| Verification conclusively identifies a bounded defect in the same step | Deliberate retry in `implementation` after recording the reason and resetting verification |
| Verification fails because cause or expectation is uncertain | `investigation` or `understanding`, as evidenced |
| Verification is inconclusive because observation is inadequate | `investigation` or `blocked` |
| Verification passes and applicability is unassessed | `understanding-gate` applicability assessment without assuming a quiz |
| Gate is required and pending | `understanding_gate` |
| Gate is partial or failed | Remain `understanding_gate` for focused teaching and re-evaluation |
| Gate reveals unstable causal evidence | `investigation` |
| Gate reveals a requirement or design disagreement | `understanding` |
| Active step passes all applicable conditions | Next eligible step or completion evaluation |

Never turn failed verification into an automatic patch loop. Never use an
Understanding Gate to compensate for unstable evidence or an incorrect
implementation.

### Recovery while implementation is incomplete

If implementation discovers a new dependency, invalid assumption, changed
expected behavior, or invalid step boundary, stop the child immediately.
Before routing to a reasoning stage, reconcile state with the actual worktree:

- preserve and report every partial effect;
- release the active step only when no unrecorded project modification remains;
- restore only changes created by the current iteration when doing so is safe
  and does not affect pre-existing developer work;
- otherwise enter `blocked` with the exact reconciliation needed.

Do not let a reasoning child operate against a worktree that task state falsely
describes as untouched or complete.

## Scope and Evidence Changes

### Invalidated assumptions

When new evidence disproves a hypothesis or invalidates a root cause:

- preserve the old record and attach contradictory evidence;
- reopen the affected question;
- route to investigation;
- lock unfinished dependent steps;
- re-examine completed steps only when their correctness depended on the
  invalidated claim.

### New dependency

Stop implementation, record the dependency, reconcile partial work, and route
to decomposition. Do not implement the dependency inside the current step
unless evidence shows it was already inside the approved boundary.

### Unrelated finding

Record an out-of-scope observation with evidence, impact, action
`not_modified`, and an optional future step. Do not add it to the current plan
or fix it unless it blocks the task and receives an explicit scope decision.

### Legitimate scope expansion

Present the proposed expansion, reason, consequences, and earliest stage it
invalidates. Wait for explicit developer approval. If approved, append it to
`scope.approved_expansions`, return to that earliest stage, and decompose the
new work normally. A vague request to "fix everything" is not precise scope
approval.

## Conditional Understanding

Use one of two legal entry paths:

1. **Implementation gate:** after successful verification, invoke
   `understanding-gate` to assess ownership value.
2. **Decision gate:** after investigation and decomposition establish an
   evidence-backed technical decision with named trade-offs, invoke
   `understanding-gate` before any dependent implementation relies on it.

For either path, validate one of two outcomes:

- `required: false`, a specific reason, empty ownership topics, and
  `status: not_applicable`: ask nothing and continue normally;
- `required: true`, a specific reason, ownership topics, and `status: pending`:
  enter `understanding_gate` and present the child's smallest useful question.

Only a substantive `passed` result satisfies a required gate. `partial` and
`failed` remain in the remediation loop. "Continue" or "I understand" does not
pass a required gate, but it may start a ready next step when no gate is
required.

For a prerequisite implementation step that establishes a shared boundary,
keep every dependent behavior step locked through both prerequisite
verification and the gate outcome. If decomposition already records a material
ownership reason and topics for that boundary, successful verification does not
erase or downgrade them: invoke the required gate, and unlock dependent work
only after `passed`. This is still an implementation gate, so its question is
not asked before verification.

A recorded required ownership checkpoint is a dependency, not a suggestion to
reassess whether a gate might apply. For example, centralizing a duplicated
cross-path invariant into one shared decision point establishes a concrete
maintenance boundary for the dependent rule change. Record the checkpoint as
required during decomposition, keep its question deferred until verification,
then enter the gate directly after verification passes.

This example is normative when all of its evidence is present: duplicated
production decisions, a required cross-path consistency invariant, a bounded
behavior-preserving extraction, and a later behavior step that will modify the
new shared decision. In that case the shared-boundary ownership checkpoint is
`required: true`; the agent must not replace it with "assess later" or "no gate
is justified." The gate is about ownership of the new single rule boundary,
not about approving an ordinary refactor.

## Trivial Fast Path

Use `mode: minimal` only when evidence supports all of these:

- requested and expected behavior are explicit;
- the affected area is local and directly observable;
- the change is mechanical, with no meaningful causal or architectural
  uncertainty;
- risk and blast radius are low;
- one focused verification can demonstrate the result;
- no security, concurrency, data-integrity, public-contract, migration, or
  similarly consequential context makes the reasoning important.

The fast path is:

```text
brief understanding
-> compact single-step decomposition
-> implementation
-> proportional verification
-> applicability assessment
-> completion when no gate is required
```

Keep the compact step in state because it preserves scope and the independent
expectation, but do not turn it into visible planning ceremony. Skip separate
investigation only when direct evidence makes it unnecessary. Ask no
understanding question unless the applicability assessment finds material
ownership value.

A small diff is not enough. A one-line authorization, transaction, concurrency,
or data-integrity change is non-trivial when its behavior, risk, or causal
reasoning matters. If new uncertainty appears, switch to `standard` mode and
route to the missing responsibility.

## Clarification Versus Understanding

- Ask a **clarification** in `understanding` when intended behavior, scope, or a
  product/design choice is unknown. It resolves what should be built and does
  not update understanding-gate status.
- Ask an **Understanding Gate question** only after applicability is required
  for verified implementation or an important technical decision. It tests why
  the accepted mechanism works and does update the understanding record.

Route these cases explicitly:

| Situation | Correct route | Not an Understanding Gate |
| --- | --- | --- |
| Expected behavior or requirement is unknown | `understanding` | Ask the product or requirement clarification |
| Scope expansion needs approval | `understanding` | Ask whether the bounded scope change is approved |
| Root cause or proposed fix is unconfirmed | `investigation` | Gather discriminating evidence |
| Verification is `FAIL` or `INCONCLUSIVE` | Evidenced recovery route | Preserve the result and repair evidence, expectation, plan, or implementation |
| High-risk code has not passed verification | Normal workflow through verification | Risk can make a later gate required, but cannot move it before verification |
| Evidence-backed architecture or technical boundary is ready for acceptance | Decision-level `understanding-gate` when material ownership is required | Test ownership of the accepted trade-offs before dependent work |

For implementation work, even when applicability is obviously required, do not
ask the gate question before verification passes. Record the likely ownership
topics as inputs, then verify, assess applicability, and gate in that order.

Do not quiz the developer to resolve workflow readiness. Do not treat a product
choice as a failed understanding answer.

## Handling User Pressure

Remain concise and cooperative:

- **"Just fix everything" / "Do it all":** continue with the current valid
  action, preserve the agreed scope and one-step boundary, and state briefly
  what remains locked.
- **"Skip explanation" / "Don't explain":** minimize narration, but retain
  required evidence, verification, and any materially required gate.
- **"Skip the questions":** ask nothing if applicability is false; if it is
  true, explain in one sentence why the specific ownership topic matters and
  keep the smallest useful question.
- **"Continue":** proceed when the next action is already valid. Do not treat
  it as an answer to a required gate, a product clarification, or approval for
  an undefined scope expansion.

Do not argue, moralize, or repeat the entire methodology. Keep helping toward
the engineering outcome within the workflow invariants.

## Task Completion

Distinguish an implemented step from a complete task. Before setting
`workflow.stage: complete` and `task.status: complete`, confirm:

- the requested goal and approved scope are satisfied;
- every required plan step has completion `passed`;
- required verification passed or is legitimately not required;
- every required Understanding Gate passed and every non-required gate is
  explicitly `not_applicable`;
- no blocking question, invalidated assumption still in use, failed or
  inconclusive verification, or unresolved approved scope change remains;
- no unapproved or future-step change is present;
- the relevant final diff has been reviewed against task scope;
- limitations and out-of-scope observations remain visible.

Do not add a final quiz merely because the task is ending. A concise final
reasoning summary may reference prior evidence and gates without repeating
them.

## Output Format

```text
CURRENT STATE:
STATE VALIDITY:
NEXT RESPONSIBILITY:
WHY THIS ACTION IS VALID:
CHILD RESULT:
APPLIED TRANSITION:
ACTIVE OR NEXT STEP:
BLOCKER OR REQUIRED USER INPUT:
```

Keep the output proportional. Omit empty fields for trivial progress, but never
hide a blocker, failed check, scope change, or required developer response.

## Outputs

- The one valid next responsibility.
- Validated child results and applied state updates.
- Atomic transition records with evidence references.
- Explicit remediation routes and blockers.
- Active-step, next-step, or completion decisions.
- Concise interaction when genuine developer input is required.

## Allowed Actions

- Read project context, task state, relevant evidence, and current diff.
- Initialize portable task state for a new request.
- Invoke the valid core child skill and pass advisory domain context to it.
- Validate child-owned updates and apply legal transitions atomically.
- Select and activate one ready step.
- Lock or unlock plan readiness according to dependencies and completed gates.
- Record explicit scope approval and route to the earliest affected stage.
- Perform final diff-to-scope review and mark task completion when every
  condition passes.

## Forbidden Actions

- Do not duplicate a child skill's detailed reasoning or perform its work
  directly.
- Do not modify production code except through a valid invocation of
  `incremental-implementation` for the active step.
- Do not invent facts, confirm root causes, author plan details, redefine
  expectations, self-verify implementation, or answer a gate for the developer.
- Do not activate a locked or future step or keep two steps active.
- Do not bypass investigation or decomposition for non-trivial work.
- Do not advance from implementation without verification.
- Do not advance past a required pending, partial, or failed gate.
- Do not create a gate for every implementation or phase.
- Do not allow adapters, domains, project configuration, or user pressure to
  apply transitions.
- Do not repeatedly patch verification failures without a recorded recovery.
- Do not mark a task complete because implementation ended, compilation passed,
  tests are green, or the developer said to continue.

## Exit Criteria

Yield when one of these is true:

- a non-trivial logical step completed its verification and any required gate,
  with the next-step outcome exposed before another implementation iteration;
- the task satisfies every completion condition;
- a clarification, explicit scope approval, permission, or required gate answer
  is needed from the developer;
- the task is safely blocked with the exact reason and resumption condition;
- invalid state or an inconsistent worktree requires reconciliation.

Trivial work may complete its entire fast path in one invocation. Reasoning
stages may continue without user approval when their contracts are satisfied
and no genuine user decision is required.

## State Effects

The orchestrator may update workflow-owned fields:

- `workflow.stage`, `previous_stage`, `blocked_reason`, and `transition_log`;
- `task.status` and a validated child recommendation for `task.mode`;
- `plan.active_step_id`;
- step readiness activation, completion, and dependency-based next readiness;
- implementation status from `not_started` to `in_progress` during activation;
- `task.scope.approved_expansions` after explicit approval;
- final task completion.

It may persist child-owned updates only after validating that they remain
inside the child's contract. It must not author those child-owned findings in
place of invoking the child.

## Failure Behavior

- **Invalid state:** reject the transition, preserve evidence, and route to the
  earliest repair stage or block.
- **Invalid child output:** keep the current stage, explain the missing contract
  condition, and re-invoke or block; do not fabricate it.
- **Unexpected repository change:** stop, preserve the observed diff, and ask
  how to proceed when ownership or safe reconciliation is unclear.
- **Unavailable required evidence or permission:** enter `blocked` with the
  exact missing capability and prior valid stage.
- **User changes the requested behavior:** return to understanding and
  invalidate downstream assumptions and plans as needed.
- **Child reports partial side effects:** reconcile state and worktree before
  invoking a different responsibility.

## Examples

**No gate required:** Verification passes a mechanical local change. Invoke
`understanding-gate` for applicability; after it records false/not applicable,
mark the step done without asking the developer a question.

**Required gate:** Verification passes a transaction change. Applicability is
true; enter `understanding_gate`. A plain "continue" keeps the gate incomplete,
while a substantive pass permits the next-step decision.

**Prerequisite boundary:** Decomposition separates a behavior-preserving
refactor that creates one shared rule boundary from the later behavior change.
Activate only the refactor. Keep the later behavior step locked on two explicit
conditions: unchanged-behavior verification passes, then the required gate on
ownership of the shared boundary passes. Do not collapse the gate into a vague
"assess later" note.

**Architecture decision:** Investigation compares ownership boundaries and
produces an evidence-backed choice with named trade-offs. Decomposition records
dependent implementation but leaves every such step locked, then enters the
decision-level gate. Only a substantive pass accepts the choice and makes one
dependent step eligible.

**User requests everything:** A multi-step feature has Step 1 active and Step 2
locked. Complete only Step 1's implementation cycle, report Step 2 as still
locked, and remain ready to continue without arguing.
