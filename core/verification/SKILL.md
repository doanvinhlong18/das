---
name: verification
description: Compare an implemented logical step with the expected behavior recorded before coding. Use after one active step is implemented to gather focused evidence, report PASS, FAIL, or INCONCLUSIVE, inspect scope, and route failures without modifying production code.
---

# Verification

## Purpose

Answer one question:

> Did the implementation produce the behavior predicted before coding?

Verification owns evidence collection and comparison. It does not own repair,
expectation revision, Understanding Gate applicability, or task completion.

## Shared Minimality Policy

Apply [the minimality policy](../../docs/MINIMALITY_POLICY.md). Run the smallest
evidence set that can distinguish the expected result from credible failure at
the current risk level. Add broader checks only for a stated regression or
blast-radius reason, and never alter tests or expectations to obtain green.

## Trigger

Run only when workflow state permits `verification` and the active step's
implementation status is `implemented` or legitimately `not_applicable`.

## Preconditions

- Exactly one step remains active.
- Actual changes or decision output are recorded.
- Verification `required`, strategy, expected result, and rationale are present.
- For required verification, expected behavior was recorded before
  implementation began.
- The active diff is available for scope inspection. Any future-step or
  unrelated change must be treated as a scope failure, not assumed away.

If the expectation is missing or was created from the observed result, do not
reconstruct it after the fact. Return `INCONCLUSIVE` and route to the reasoning
stage that must establish an independent expectation before a fresh observation.

## Inputs

- Active step objective, scope, expected behavior, and verification strategy.
- Expected result and its recording time.
- Actual changes, changed files, and unexpected observations.
- Relevant facts, confirmed root cause, and unresolved uncertainty.
- Project build/test commands and applicable domain verification advice.
- Current diff and available runtime, query, log, or test evidence.

## Process

1. Restate **EXPECTED** exactly as recorded before implementation. Preserve its
   meaning and identify the evidence needed to distinguish it from failure.
2. Check the active diff against step scope. An unrelated change prevents a
   clean pass until it is resolved outside verification.
3. Run a proportional evidence set appropriate to behavior and risk. Consider:
   - focused tests;
   - integration tests;
   - compilation and static checks;
   - read-only query output;
   - runtime behavior and logs;
   - relevant regression cases;
   - diff inspection.
4. Record **OBSERVED** behavior, command/query provenance, failures, and
   limitations. Do not summarize away contradictory evidence.
5. Compare EXPECTED and OBSERVED directly.
6. Assign exactly one result:
   - `PASS`: evidence supports the expected behavior and no material
     contradictory evidence remains;
   - `FAIL`: observed behavior contradicts the expected result or the active
     diff violates scope;
   - `INCONCLUSIVE`: available evidence cannot distinguish success from failure.
   Uncertainty about *why* a valid check contradicted the expectation does not
   make the verification result inconclusive. Record `FAIL`; keep the recovery
   destination uncertain until investigation distinguishes implementation,
   expectation, causal-model, or environment defects. Use `INCONCLUSIVE` only
   when the observation method cannot tell whether EXPECTED occurred.
7. For `FAIL` or `INCONCLUSIVE`, classify the likely recovery destination using
   evidence rather than patching:
   - implementation is wrong -> bounded implementation retry only when the
     failure is conclusive and remains inside the same step;
   - hypothesis or root cause is wrong -> investigation;
   - expected behavior is wrong or ambiguous -> task understanding;
   - plan boundary or dependency is wrong -> decomposition;
   - verification method is inadequate -> investigation for better evidence or
     blocked if required evidence is unavailable.
8. For `PASS`, record gate-applicability inputs: technical mechanism changed,
   complexity, behavioral or architectural significance, maintenance/debugging
   importance, novelty, risk, and possible ownership topics. Leave the actual
   applicability decision unresolved.
9. Return the result and recovery/readiness recommendation to the orchestrator.
   Do not modify project code.

## Output Format

```text
EXPECTED:
OBSERVED:
EVIDENCE:
LIMITATIONS:
RESULT: PASS | FAIL | INCONCLUSIVE
RECOVERY OR READINESS:
GATE-APPLICABILITY INPUTS:  # only after PASS
```

## Interpreting Evidence

- Compilation proves that selected compilation constraints passed; it does not
  prove runtime or business behavior.
- Existing tests prove only the cases and assertions they exercise.
- Green tests do not prove a reported bug is fixed when the failing behavior is
  still reproducible or untested.
- A focused reproduction can outweigh broad green tests for the behavior under
  review.
- Diff inspection supports scope correctness but does not prove behavior.
- Absence of an observed failure is weaker than evidence of the expected result.

## Outputs

- Expected-versus-observed comparison.
- Reproducible verification evidence and limitations.
- `PASS`, `FAIL`, or `INCONCLUSIVE`.
- A reasoned recovery destination when not passing.
- On pass, evidence useful for later Understanding Gate applicability without a
  gate decision.

## Allowed Actions

- Read task state, implementation report, relevant source, tests, configuration,
  and diff.
- Run approved compilation, static analysis, tests, read-only queries, runtime
  observations, and regression checks.
- Consult domain skills for technology-specific verification techniques.
- Record verification evidence, result, limitations, and transition evidence.
- Record unrelated findings as out-of-scope observations without modifying them.

## Forbidden Actions

- Do not modify production code, tests, configuration, fixtures, dependencies,
  snapshots, or expected outputs during verification.
- Do not use update modes that rewrite tests or snapshots to make failures pass.
- Do not repeatedly patch and rerun until something turns green.
- Do not redefine EXPECTED after observing the result.
- Do not mark `PASS` solely because compilation, lint, or existing tests pass.
- Do not omit a focused failing reproduction because broader checks are green.
- Do not implement a recovery, future step, cleanup, or unrelated fix.
- Do not set `understanding.required` to true or false, invoke a gate, or evaluate
  developer understanding.
- Do not mark the step `done`, unlock another step, or mark the task complete.
- Do not advance workflow state directly.

## Exit Criteria

Exit only when:

- EXPECTED remains traceable to the pre-implementation record;
- OBSERVED and its provenance are recorded;
- RESULT is justified as PASS, FAIL, or INCONCLUSIVE;
- limitations and contradictory evidence are visible;
- the active diff has been inspected against scope;
- failures have a reasoned recovery destination without a patch;
- a pass includes gate-applicability evidence while understanding remains
  unassessed.

## State Effects

May propose updates only to the active step's verification record:

- `observed_result` and `observed_at`;
- `result`;
- `evidence_refs`;
- `limitations`;
- out-of-scope observations with action `not_modified`;
- transition evidence containing recovery rationale or gate-applicability
  inputs.

Do not change the recorded expectation, implementation status, understanding
`required` or `status`, step readiness, active-step selection, or task status.

## Failure Behavior

- Preserve every failing or inconclusive observation before recommending a
  transition.
- If implementation is conclusively wrong inside the same step, recommend a
  deliberate bounded retry; do not perform it.
- If causal evidence is contradicted, return to investigation and identify the
  invalidated hypothesis or root cause.
- If expected behavior is incorrect or genuinely undecidable, return to task
  understanding for a product/design decision.
- If the verification method cannot observe the behavior, return to
  investigation for a better method or block with the missing capability.
- If the diff includes unrelated changes, report `FAIL` for scope integrity and
  return to the appropriate state; do not clean the diff inside verification.

## Examples

**Green suite, persistent bug:** Existing tests pass, but the focused request
still returns duplicate rows. OBSERVED contradicts EXPECTED, so RESULT is FAIL.
Route to investigation or implementation based on the causal evidence.

**Compilation only:** A build passes after a transaction change. Record the
build as evidence, but return INCONCLUSIVE until rollback behavior is observed
through a focused test or runtime evidence.

**Trivial rename:** Diff inspection plus a focused reference/compile check may
support PASS. Record that the change is mechanical and local as applicability
input, but do not set understanding to not required.
