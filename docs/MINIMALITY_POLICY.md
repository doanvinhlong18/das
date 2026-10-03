# Minimal Sufficient Change and Process Policy

## Status and purpose

This document defines the cross-cutting minimality policy for
`dev-agent-skills`. It is subordinate to
[PHILOSOPHY.md](PHILOSOPHY.md) and
[CORE_PRINCIPLES.md](CORE_PRINCIPLES.md), and applies to every core skill,
domain consultation, adapter, and project configuration.

The policy prevents two symmetric failures:

- doing more engineering work than the verified objective requires; and
- imposing more workflow than correctness, evidence, and meaningful developer
  ownership require.

The terms **MUST**, **MUST NOT**, **REQUIRED**, and **FORBIDDEN** are normative.

## Contents

- [1. The failure-prevention test](#1-the-failure-prevention-test)
- [2. Minimal sufficient change](#2-minimal-sufficient-change)
- [3. Out-of-scope observations](#3-out-of-scope-observations)
- [4. Minimal sufficient process](#4-minimal-sufficient-process)
- [5. Applying the policy by core responsibility](#5-applying-the-policy-by-core-responsibility)
- [6. Enforcement boundary](#6-enforcement-boundary)

## 1. The failure-prevention test

Before every optional edit, artifact, investigation branch, workflow step,
question, approval request, explanation, or verification check, ask:

> What failure is this action preventing?

A useful answer names a credible failure in the current task, such as:

- implementing the wrong behavior;
- changing the wrong code path;
- accepting an unsupported root cause;
- coding beyond approved scope;
- being unable to distinguish success from failure;
- creating known design damage;
- leaving the developer unable to maintain an important technical decision.

"The process requires it" is not a sufficient answer by itself. The agent MUST
connect the action to the invariant or task risk it protects. If no meaningful
failure can be named, omit, combine, or shorten the action.

This test does not waive core invariants. Scope, evidence classification, one
active logical step, a prior verification expectation, actual verification,
and conditional understanding applicability have established failure modes.
The amount of work used to satisfy them remains proportional.

## 2. Minimal sufficient change

### Definition

The **minimal sufficient change** is:

> The smallest well-designed change that correctly satisfies the verified
> objective without known design damage.

It means minimizing unnecessary behavioral and review scope. It does not mean:

- the fewest changed lines or files;
- preserving a defective design when a bounded refactor is necessary;
- accepting duplication, unsafe coupling, or another known design failure;
- refusing tests, migration work, or configuration changes required by the
  current objective;
- preferring a local hack over a coherent implementation.

### Change-necessity test

Every changed behavior, file, symbol, dependency, test, configuration value,
or generated artifact MUST satisfy all of these:

1. It maps to the active step's objective or a specifically approved
   prerequisite.
2. Evidence shows it is necessary for correct behavior or to avoid known design
   damage now, not for a hypothetical future need.
3. Its behavior and risk fit inside the active scope boundary.
4. Its result can be covered by the active verification strategy or by a
   separately decomposed step.
5. A materially narrower well-designed alternative is unavailable or
   insufficient.

If an edit fails this test, do not make it.

### Refactoring

Necessary refactoring is allowed when evidence shows the objective cannot be
implemented correctly without it, or when the apparent shortcut would create
known design damage in the current system.

- Keep an inseparable local structural adjustment in the current step only when
  it serves the same observable behavior and verification.
- Make a prerequisite refactor a separate logical step when it has independent
  behavior, risk, or verification value.
- Bound the refactor to the dependency or invariant that blocks the objective.
- Do not turn a local fix into layer replacement, framework migration, broad
  API redesign, or architecture cleanup without an explicit scope decision.

Code being old, unattractive, duplicated nearby, or inconsistent with a
preferred style is not evidence that refactoring is necessary now.

### Dependencies and abstractions

Introduce a dependency or abstraction only when current evidence shows that it
is necessary for the active objective and existing project mechanisms cannot
meet the need safely and coherently.

Before adding one, record:

- the current requirement it satisfies;
- the existing alternatives considered;
- why those alternatives are insufficient;
- the maintenance, security, operational, and verification consequences that
  are material to the task.

Do not add a library, service, interface, generic layer, plugin point, or
configuration system for possible reuse, imagined scale, stylistic preference,
or a future step.

### Test integrity

Tests are part of the change boundary, not obstacles to make green.

- Add or modify tests when they express the expected behavior recorded before
  implementation or cover a material regression case.
- If an existing assertion conflicts with authoritative expected behavior,
  return to task understanding and decomposition before changing it.
- Inspect snapshot or generated expectation changes against the independent
  expected behavior before accepting them.
- Never delete, weaken, skip, broaden tolerances, rewrite fixtures, or update
  snapshots merely to remove a failure.
- Never change test infrastructure or unrelated tests because a focused change
  is inconvenient to verify.

Verification itself MUST NOT modify tests. A justified test change belongs to a
planned implementation step and remains subject to independent verification.

### Future and adjacent work

Do not implement:

- a future plan step because the same file is already open;
- cleanup because the relevant area looks untidy;
- another instance of a bug because the current fix suggests a pattern;
- performance, compatibility, observability, or resilience improvements not
  required by the active objective;
- architecture redesign hidden inside a small bug fix.

File locality does not make behaviors one logical change.

## 3. Out-of-scope observations

When useful evidence reveals an unrelated issue, record it in this form:

```text
OUT-OF-SCOPE OBSERVATION

Evidence:
<reproducible source or observation>

Impact:
<credible consequence, including uncertainty>

Action:
Not modified.

Potential follow-up:
<optional bounded future task or none>
```

Recording an observation MUST NOT add it to the current plan, approve it, or
authorize implementation.

- If it is non-blocking, preserve it and continue the current task.
- If it blocks the active objective, stop and propose either a bounded
  prerequisite or explicit scope expansion.
- If its impact is uncertain, say so; do not inflate it to justify expansion.
- Do not create a follow-up task automatically unless the developer requests
  one or project policy explicitly requires issue creation.

## 4. Minimal sufficient process

### Definition

The **minimal sufficient process** is:

> The smallest workflow that preserves correctness, inspectable evidence, and
> developer ownership where ownership is materially valuable.

The process serves engineering. Engineering does not serve the process.

Minimal process does not remove required invariants. It reduces the size,
number, and repetition of artifacts and interactions to what the current risk
actually needs.

### Investigation

- Investigate the smallest relevant path and use the most discriminating
  available evidence.
- Stop when exit criteria are satisfied and remaining uncertainty cannot change
  the bounded next decision.
- Do not inspect the entire repository, enumerate remote possibilities, or run
  every diagnostic merely to appear thorough.
- Broaden investigation only when current evidence leaves a credible competing
  explanation or unknown blast radius.

### Decomposition

- Create the fewest logical steps that still isolate behavior, dependencies,
  risk, verification, and required ownership.
- Do not create one step per file, layer, command, or tiny mechanical edit.
- Do not combine independently risky behaviors merely to reduce step count.
- Use one compact step for trivial work.
- Keep required fields concise when their meaning is obvious from direct
  evidence.

### State documentation

- Record decisions and evidence that control scope, transitions, verification,
  recovery, or ownership.
- Use short values and omit empty optional history in minimal mode.
- Do not duplicate the same explanation across task, step, transition, and
  report fields when a stable reference is sufficient.
- Do not remove fields whose absence would permit coding ahead, post-hoc
  expectations, hidden uncertainty, or a gate bypass.

### User interaction and explanation

- Ask for user input only when a requirement, product/design choice, scope
  expansion, permission, or required understanding response genuinely needs
  the developer.
- Do not request approval after ordinary evidence-based phase transitions.
- Explain new reasoning and material changes; reference prior established
  reasoning instead of repeating it verbatim.
- Do not restate the methodology unless the developer needs to understand why a
  requested action remains locked.
- Keep phase and iteration reports concise while preserving failures,
  uncertainty, scope deviations, and the next valid action.

### Understanding and prediction

- Assess applicability before asking an understanding question.
- Ask the smallest number of high-signal questions needed for the ownership
  topics.
- Stop questioning when those topics are demonstrated.
- Do not quiz documentation, formatting, setup, administrative work, or
  ordinary reasoning-stage transitions.
- Use prediction only when committing before observation reveals a meaningful
  causal model. Do not add prediction to obvious cases or repeat an already
  demonstrated concept.

### Verification

- Select the smallest evidence set capable of distinguishing the expected
  behavior from credible failure modes at the change's risk level.
- Prefer focused checks; add broader checks only for a plausible regression or
  blast-radius reason.
- Do not run every available suite by default or repeat checks that add no new
  evidence.
- Do not reduce verification below what is needed merely because the task is
  small or the full check is inconvenient.

### Trivial work

Use the fast path when behavior is explicit, impact is local, change is
mechanical, risk is low, uncertainty is absent, and one focused check can
demonstrate the result.

Trivial work still needs a bounded change, a prior expectation, an observation,
and an applicability outcome. It normally does not need broad investigation,
multi-step narration, extensive state prose, user approvals, prediction, or an
Understanding Gate.

Small size alone is insufficient. A one-line security, concurrency,
transaction, public-contract, or data-integrity change may require the full
workflow.

## 5. Applying the policy by core responsibility

| Core responsibility | Minimality obligation |
| --- | --- |
| `task-understanding` | Record only enough detail to make behavior, scope, uncertainty, and verification direction unambiguous |
| `code-investigation` | Gather the smallest discriminating evidence set and stop when the next decision is safe |
| `task-decomposition` | Create the fewest coherent independently verifiable logical steps |
| `incremental-implementation` | Make the minimal sufficient change and nothing from future or adjacent scope |
| `verification` | Use proportional evidence without weakening tests or multiplying checks without purpose |
| `understanding-gate` | Ask nothing when not applicable and the smallest useful question set when required |
| `guided-development` | Choose the smallest valid workflow and require user interaction only for genuine decisions or ownership evidence |

Each skill references this policy and adds only responsibility-specific rules.
It MUST NOT copy the full policy into its own contract.

## 6. Enforcement boundary

State and tooling can detect some violations:

- changed files or dependencies not mapped to the active step;
- future-step changes while another step is active;
- missing scope, expectation, verification, or applicability records;
- test and snapshot changes outside the approved implementation boundary;
- gates or questions where applicability is false;
- large standard-mode records for tasks classified as minimal.

They cannot reliably decide whether a refactor is truly necessary, an
abstraction is speculative, a question is high-signal, or an explanation is
redundant. Those judgments require explicit rationale, review, and adversarial
behavior scenarios rather than numeric thresholds.
