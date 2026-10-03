---
name: testing
description: Provide advisory testing strategy for focused behavioral checks, unit and integration boundaries, test doubles, fixtures, contracts, regression cases, nondeterminism, coverage limitations, and expected-versus-observed evidence. Use during an active core workflow when investigation or verification needs testing expertise; do not use it to set verification results, rewrite expectations, control workflow, or modify tests.
---

# Testing Reasoning

## Purpose

Help the active core skill choose the smallest credible evidence set that can
distinguish expected behavior from likely failure modes. Follow the shared
advisory boundary in [DOMAIN_SKILLS.md](../../docs/DOMAIN_SKILLS.md).

## Preconditions and Inputs

- A core skill supplies the active objective, expected behavior, risk, known
  failure modes, scope, and available system boundaries.
- Existing tests, fixtures, environments, and verification limitations are
  available or explicitly unknown.
- Expected behavior comes from an independent requirement or contract, not from
  observed implementation output.

## Investigation Patterns

1. Translate the expected behavior into observable examples, invariants, and
   material negative or boundary cases.
2. Identify the narrowest test boundary that includes the mechanism at risk;
   use broader integration only when the boundary itself matters.
3. Inspect whether fixtures and test doubles preserve the production contract,
   lifecycle, timing, transaction, dialect, or failure semantics being tested.
4. Determine what each existing test actually proves and which reported path it
   omits.
5. For nondeterminism, identify shared state, time, randomness, ordering,
   concurrency, external services, and retry behavior before adding repetition.
6. Preserve failed evidence; do not change assertions or snapshots merely to
   obtain green output.

## Important Evidence Sources

- requirement examples and pre-recorded expected behavior;
- focused reproductions and regression cases;
- unit, component, integration, contract, end-to-end, property, and performance
  tests relevant to the boundary;
- fixture builders, seeds, mocks, stubs, fakes, and environment configuration;
- assertion detail, logs, coverage/trace evidence, and test timing;
- production-like checks when mocks or alternate engines hide the behavior;
- historical flaky-test evidence and retry configuration.

## Common Failure Modes and Dangerous Assumptions

- Green tests are treated as proof of untested reported behavior.
- Compilation or coverage percentage is treated as behavioral correctness.
- A mock is assumed to reproduce a framework, database, network, or transaction
  boundary.
- Tests assert implementation details and remain green while behavior is wrong.
- Snapshots are updated without inspecting semantic changes.
- Flaky tests are retried until green without investigating nondeterminism.
- Expected values are copied from observed output.
- The full suite is run for appearance of rigor when a smaller discriminating
  check exists, or focused checks are used when wider regression risk is known.

## Verification Guidance

- Record expected behavior before observation when practical, then compare it
  explicitly with the result.
- Select tests that fail for the credible incorrect implementation, not merely
  tests that execute changed lines.
- Include material success, failure, boundary, and regression cases in
  proportion to risk.
- Combine focused checks with the smallest relevant broader check when shared
  contracts or integration surfaces create credible regression risk.
- Treat `PASS`, `FAIL`, and `INCONCLUSIVE` as evidence decisions owned by core
  verification; state limitations precisely.

## Useful Reasoning Questions

- What incorrect implementation would this test still allow?
- Does the test cross the boundary where the defect actually occurs?
- Which fixture or mock assumption could hide production behavior?
- Was the expected result established independently and before observation?
- What does a green result prove, and what does it leave unobserved?
- Which focused negative or boundary case best distinguishes the hypothesis?

## Outputs and Exit Criteria

Return proposed test boundaries, examples, failure-discriminating assertions,
fixture risks, evidence limitations, and focused verification suggestions.
Exit when the active core skill can choose a proportional check or when missing
environment/evidence prevents a credible test.

## Allowed Actions

- Read test code, fixtures, configuration, results, coverage, and logs.
- Suggest focused tests, assertions, data cases, and safe verification order.
- Evaluate what supplied test evidence can and cannot establish.
- Compose through core with every technical domain.

## Forbidden Actions and State Effects

- Do not modify production code, tests, snapshots, fixtures, or configuration.
- Do not set verification to pass, fail, or inconclusive; advise the core
  verification skill, which owns that result.
- Do not redefine expected behavior from observed output or weaken checks for
  green results.
- Do not control workflow, activate steps, require or pass a gate, or mark
  completion.
- Propose no direct task-state update.

## Composition Examples

- With Angular, ensure the selected test includes the real stream, provider,
  router, or rendering boundary at risk.
- With Spring and SQL, distinguish application-container behavior from database
  semantics and select focused integration only where their boundary matters.
- With Git, turn a suspected introducing commit into a before/after reproduction
  rather than treating history as causal proof.
