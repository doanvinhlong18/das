---
name: task-decomposition
description: Convert sufficiently established task understanding into bounded, dependency-aware, independently verifiable logical steps. Use after investigation for non-trivial work or after direct evidence for a minimal task, before any production-code implementation begins.
---

# Task Decomposition

## Purpose

Turn confirmed understanding into an ordered plan of logical changes that can
be implemented and verified one at a time.

## Shared Minimality Policy

Apply [the minimality policy](../../docs/MINIMALITY_POLICY.md). Create the fewest
coherent steps that still isolate behavior, dependencies, risk, verification,
and required ownership. Do not split work by file or layer, and do not combine
independently risky changes merely to reduce step count.

## Trigger

Run when workflow state permits `decomposition`, including initial planning,
recovery from a newly discovered dependency, or revision after evidence changes
the valid plan boundary.

## Preconditions

- WHAT, EXPECTED, SCOPE, and verification direction are recorded.
- Non-trivial tasks have sufficient investigation evidence.
- Material causal claims for bug work are confirmed or explicitly blocking.
- No unresolved requirement or product/design choice would change the plan.
- No implementation is currently in progress.

For `minimal` mode, direct evidence may make a separate investigation phase
unnecessary, but the evidence and reason must be recorded.

## Inputs

- Task goal, expected behavior, mode, and scope.
- Facts, hypotheses, confirmed root cause, uncertainty, and unresolved questions.
- Relevant behavior locations and project boundaries.
- Out-of-scope observations and approved scope expansions.
- Verification constraints and project-specific commands or restrictions.

## Process

1. Identify behavioral increments, not files to edit. A logical step may touch
   multiple files when every edit is necessary for one observable change.
2. Make each step the smallest coherent change that produces independently
   verifiable progress without relying on unimplemented future behavior.
3. For every step define:
   - `objective`;
   - `reason`;
   - `expected_behavior`;
   - expected `affected_area`;
   - `dependencies`;
   - verification `strategy` and `expected_result`;
   - included and excluded `scope_boundary`.
4. Record the verification expectation before any implementation begins.
5. Reject vague steps such as "fix backend," "update service," or "refactor
   everything." Split them by observable behavior and causal responsibility.
6. Separate a necessary prerequisite refactor into its own justified,
   independently verified step. Do not hide it inside feature or bug work.
7. When a prerequisite establishes a shared rule, ownership, transaction,
   security, data-integrity, or architecture boundary that a dependent step
   will rely on, record that ownership checkpoint in the plan. Keep the
   dependent step locked until the prerequisite passes verification and the
   required gate passes. The decomposition output must name both lock
   conditions and record `gate_dependency.required: true`, its reason, and the
   smallest ownership topics; "assess a gate later" is insufficient. This does
   not ask or evaluate the gate during decomposition. The question remains
   deferred until prerequisite verification passes.
   When the evidence is duplicated production decisions plus a required
   cross-path consistency invariant and the dependent step will change the new
   shared decision, this checkpoint is mandatory rather than discretionary.
8. When decomposition accepts an evidence-backed technical decision outside
   implementation, record its alternatives, trade-offs, consequences,
   verification analysis, ownership topics, and a decision-gate dependency.
   Keep all implementation that relies on the decision locked; return the
   decision to the orchestrator for the gate before selecting an implementation
   step.
9. Order dependencies explicitly and check for cycles or steps that cannot be
   verified until the whole task is complete.
10. Set only the first dependency-satisfied step to `ready`. Leave every future
   step `locked`. Leave `plan.active_step_id` null for the orchestrator to select.
    If a decision gate is the next dependency, leave every implementation step
    locked and return `READY_FOR_DECISION_GATE` instead.
11. For a minimal task, create one concise step with no unnecessary plan prose.
12. Return `READY_FOR_IMPLEMENTATION`, `READY_FOR_DECISION_GATE`,
    `RETURN_TO_INVESTIGATION`, or `BLOCKED`.

## Outputs

- An ordered set of logical step records conforming to the task-state contract.
- Explicit dependencies and locked future steps.
- One ready step at most, with no active implementation step.
- A recorded decision-gate or ownership-checkpoint dependency when applicable.
- Step-level expected behavior and verification strategy established before
  coding.
- Plan risks, blockers, and scope-change requests.

## Allowed Actions

- Read task state, project configuration, and existing investigation evidence.
- Inspect repository structure read-only to validate affected-area boundaries.
- Create or revise plan records and dependency links.
- Ask for clarification only when a genuine scope or design choice prevents a
  safe plan.
- Recommend returning to investigation when evidence is insufficient.

## Forbidden Actions

- Do not modify production code, tests, configuration, or dependencies.
- Do not implement or partially scaffold any step.
- Do not mark more than one step `ready` when parallel readiness could invite
  coding ahead; select the next intended step and keep later work locked.
- Do not activate a step or set implementation `in_progress`.
- Do not combine unrelated cleanup, refactoring, or discovered bugs with the
  requested behavior.
- Do not create speculative abstractions as future steps without current
  evidence that they are necessary.
- Do not define success criteria after implementation.
- Do not quiz the developer to approve workflow readiness.
- Do not advance workflow state directly.

## Exit Criteria

Exit as `READY_FOR_IMPLEMENTATION` only when:

- every step represents one logical change;
- every step has all required fields and a bounded scope;
- dependencies are explicit and acyclic;
- each step is independently verifiable or has a documented, justified reason
  for the smallest combined boundary;
- exactly one next step is `ready` and future steps are `locked`;
- `plan.active_step_id` is null;
- no blocking question or unapproved scope expansion remains.

## State Effects

May propose updates only to:

- `plan.steps` and their objectives, reasons, dependencies, affected areas,
  expected behavior, scope boundaries, and verification records;
- step readiness as `ready` or `locked`;
- `plan.active_step_id` reset to null while decomposing;
- `reasoning.unresolved_questions` for plan blockers;
- scope-expansion proposals as transition evidence, without adding them to
  `task.scope.approved_expansions` before explicit approval;
- transition evidence supporting implementation readiness or a return to
  investigation.

Must not update project files, implementation status, observed verification
results, understanding status, or task completion.

## Failure Behavior

- If evidence cannot support a bounded step, return to investigation with the
  exact missing question.
- If a step is vague or too broad, split it before marking anything ready.
- If steps form a dependency cycle, expose the cycle and revise boundaries;
  never activate all steps to work around it.
- If independent verification is impossible, explain why and define the
  smallest justified combined step.
- If a new requirement expands scope, stop and request explicit approval before
  adding it to the plan.
- If a trivial task grows in risk or uncertainty, switch to `standard` mode and
  require the missing investigation.

## Examples

**Bad:** "Fix backend."

**Better:** "Change repository filtering so archived records are excluded for
the existing list endpoint; verify the focused repository result contains only
active records."

**Minimal rename:** Create one step covering the local symbol and its references,
with a diff/reference check. Mark it `ready`; do not create artificial substeps.

**Multi-layer feature:** Decompose by independently observable behavior and
dependency, not automatically by controller/service/repository files. Later
steps remain locked until the current step is implemented and verified.
