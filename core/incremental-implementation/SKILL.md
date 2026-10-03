---
name: incremental-implementation
description: Implement exactly one active logical step within its approved scope, then stop for independent verification. Use when the workflow has selected one ready step, recorded its expected behavior and verification strategy, and permits project modification.
---

# Incremental Implementation

## Purpose

Implement the currently active logical step and nothing else.

> ONE ITERATION = ONE LOGICAL CHANGE.

Implementation owns the scoped project modification. It does not own
verification, Understanding Gate applicability, future-step activation, or task
completion.

## Shared Minimality Policy

Apply [the minimality policy](../../docs/MINIMALITY_POLICY.md). Use its
change-necessity test for every edit, dependency, abstraction, refactor, and
test change. Record anything that fails that test as an out-of-scope
observation rather than implementing it.

## Trigger

Run only when workflow state permits `implementation` and the orchestrator has
selected exactly one previously ready step as active.

## Preconditions

- `workflow.stage` is `implementation` and task status is active.
- `plan.active_step_id` identifies exactly one step.
- That step has readiness `active` and implementation status `in_progress`.
- Every dependency is `done`.
- The step has a specific objective, reason, expected behavior, affected area,
  scope boundary, and verification strategy.
- The verification expectation was recorded before implementation began.
- No blocking question, invalidated root cause, or unapproved scope expansion
  affects the step.
- Existing user changes in the affected area have been identified so they can
  be preserved.

If any precondition fails, do not edit project files. Return the missing
condition to the orchestrator.

## Inputs

- Active step record and dependencies.
- Task goal, expected behavior, and approved scope.
- Facts and confirmed root cause relevant to the step.
- Expected affected area and excluded scope.
- Pre-recorded verification strategy and expected result.
- Project configuration, repository instructions, and existing worktree changes.
- Relevant domain advice supplied through the workflow.

## Before Modification

State this contract before editing:

```text
CURRENT OBJECTIVE:
EXPECTED BEHAVIOR:
EXPECTED AFFECTED AREA:
VERIFICATION STRATEGY:
```

Resolve any mismatch between this contract and task state before proceeding.
Do not rewrite the expectation to match a preferred implementation.

## Process

1. Re-read the active step, its evidence, scope boundary, and dependency status.
2. Inspect the current affected code and existing diff. Distinguish pre-existing
   user changes from changes needed by this iteration.
3. Emit the pre-modification contract above.
4. Implement the minimal sufficient change: the smallest well-designed change
   that correctly satisfies the active verified objective without known design
   damage.
5. Touch multiple files only when every edit is necessary for the same logical
   behavior. Keep tests or fixtures in the step only when its scope explicitly
   requires them; never weaken assertions merely to remove a failure.
6. Preserve surrounding structure. Do not rename, format, reorganize, upgrade,
   or clean nearby code unless the active step requires it.
7. If a new dependency, invalid assumption, broader affected area, or legitimate
   scope expansion appears, stop before implementing it. Record the observation
   and return to the appropriate reasoning stage.
8. Inspect the resulting diff for scope. Remove only accidental changes created
   by this iteration; never revert pre-existing user work.
9. Record the actual changes and unexpected observations.
10. Mark the implementation complete, return `READY_FOR_VERIFICATION`, and stop
    all further implementation.

## After Modification

Report:

```text
FILES CHANGED:
BEHAVIOR CHANGED:
WHY EACH CHANGE WAS NECESSARY:
UNEXPECTED OBSERVATIONS:
READINESS: READY_FOR_VERIFICATION
```

The report must be specific enough for verification to map each changed file or
symbol to the active logical step.

## Outputs

- A scoped diff for one logical change.
- Files and relevant symbols changed.
- The behavior changed and why each edit was necessary.
- Unexpected observations, including out-of-scope findings.
- A readiness recommendation for verification.

## Allowed Actions

- Read task state, project configuration, relevant code, tests, and current diff.
- Modify project files inside the active step's approved scope.
- Add or update focused tests when the active step explicitly includes them and
  their assertions express the pre-recorded expected behavior.
- Apply necessary formatting only to touched, in-scope content.
- Consult domain knowledge for implementation details without delegating scope
  or workflow authority.
- Update implementation-owned task-state fields.

## Forbidden Actions

- Do not implement a locked, ready-but-not-active, or future step.
- Do not perform unrelated refactoring, opportunistic cleanup, dependency
  upgrades, or formatting churn.
- Do not add speculative abstractions for possible future needs.
- Do not change unrelated behavior or silently fix another bug.
- Do not expand scope because adjacent code is inconvenient or unattractive.
- Do not change expected behavior or verification criteria after seeing the
  implementation.
- Do not run verification and declare the step correct; scope-oriented diff
  inspection is not behavioral verification.
- Do not set verification `pass`, understanding `required`, gate status, step
  `done`, or task `complete`.
- Do not automatically invoke an Understanding Gate.
- Do not overwrite or revert user changes that predate the iteration.
- Do not advance workflow state directly.

## Exit Criteria

Exit as `READY_FOR_VERIFICATION` only when:

- the active objective is implemented without implementing another objective;
- every change maps to the step's reason and scope boundary;
- actual changed files and behavior are recorded;
- unexpected observations are visible;
- no known accidental or unrelated change remains;
- implementation status can become `implemented`;
- verification remains pending and understanding remains unassessed.

## State Effects

May propose updates only to the active step:

- `implementation.status: implemented`;
- `implementation.completed_at`;
- `implementation.actual_changes`;
- `implementation.unexpected_observations`;
- out-of-scope observations with action `not_modified`;
- transition evidence supporting verification readiness.

Keep readiness `active` and `plan.active_step_id` unchanged until verification
and any required later gate complete. Do not update observed verification,
understanding applicability, future-step readiness, or task completion.

## Failure Behavior

- **New dependency:** stop, record it, and return `RETURN_TO_DECOMPOSITION`.
- **Root cause or material assumption invalidated:** stop and return
  `RETURN_TO_INVESTIGATION` with the new evidence.
- **Expected behavior becomes ambiguous or wrong:** stop and return
  `RETURN_TO_UNDERSTANDING`; do not redefine it locally.
- **Scope expansion needed:** propose the expansion and wait for explicit
  approval before changing those files or behaviors.
- **Overlapping user changes make a safe edit uncertain:** preserve them and
  request direction rather than reverting or overwriting.
- **Step is larger than described:** implement no additional behavior; return to
  decomposition with the boundary that failed.
- **Tool or edit failure:** report partial effects precisely and leave the step
  non-ready for verification until state matches the actual worktree.

## Examples

**In scope across files:** A repository filter and its focused test may be one
logical change when both are necessary to exclude archived records and both were
declared in the step.

**Out of scope:** While editing the filter, discovering duplicated validation in
the service does not authorize cleanup. Record it and leave it unchanged.

**New dependency:** If the filter needs an unavailable schema column, stop and
return to decomposition instead of adding a migration as an unplanned second
change.
