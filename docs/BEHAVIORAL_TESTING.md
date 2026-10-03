# Behavioral Testing Specification

## Status and scope

This document defines how `dev-agent-skills` methodology behavior is tested.
It specifies scenarios and evaluation rules. Focused adapter runs may exercise
named subsets, but no current result claims that an agent or adapter passes the
complete suite.

Behavioral tests evaluate observable agent decisions, state changes, edits,
questions, and evidence handling. They do not evaluate whether a sample
application is generally well designed or whether an answer merely appears
helpful.

## 1. Testing philosophy

Each scenario places an agent under a pressure that could violate a documented
workflow invariant. The evaluator asks whether the agent preserved that
invariant while continuing to help with the engineering objective.

Prefer observable criteria:

- files or logical steps modified;
- facts, hypotheses, and root causes recorded separately;
- expectations timestamped or otherwise shown to precede observations;
- verification evidence and its limitations;
- workflow and per-step state before and after the response;
- the presence and rationale of an Understanding Gate;
- questions asked of the developer;
- scope additions, dependency changes, or test changes;
- recovery routing after contradictory or failed evidence.

Avoid criteria such as "the answer feels good" or "the agent sounded
confident." When expert judgment is unavoidable, the scenario must name the
artifact or reasoning relationship the evaluator should inspect.

## 2. Normative scenario format

Normative scenarios live in `tests/scenarios/` and use a filename beginning
with their stable ID. Every scenario defines:

- **ID**: stable unique identifier;
- **TITLE**: concise behavior under test;
- **PURPOSE**: invariant or failure mode protected;
- **SEVERITY**: methodology impact if violated;
- **INITIAL STATE**: relevant task and workflow state;
- **USER REQUEST**: pressure or request presented to the agent;
- **CONTEXT**: evidence and constraints available to the agent;
- **EXPECTED BEHAVIOR**: observable compliant response;
- **FORBIDDEN BEHAVIOR**: observable violation;
- **EXPECTED STATE TRANSITIONS**: legal stage and status changes;
- **UNDERSTANDING REQUIRED**: `yes` or `no` for this scenario;
- **UNDERSTANDING REASON**: specific ownership reason or `not_applicable`;
- **PASS CRITERIA**: minimum evidence for a pass;
- **FAIL CRITERIA**: evidence that forces a fail;
- **EVIDENCE TO CAPTURE**: artifacts needed for repeatable evaluation.

Scenario wording may improve without changing its ID. If the protected
invariant changes so substantially that historical results are no longer
comparable, create a new scenario ID and retire the old scenario explicitly.
Do not reuse retired IDs.

## 3. Stable scenario ID policy

IDs use `BHV-NNN-short-name`:

- `BHV` identifies a methodology behavior scenario;
- `NNN` is a zero-padded sequence allocated once;
- `short-name` is descriptive and contains no date, agent name, technology
  version, or skill version.

An ID never changes because a scenario is reordered, moved, clarified, or run
against a different coding agent. IDs are unique across the repository, not
merely within one file. Historical run data refers to the ID, not a heading or
file position.

## 4. Severity model

Severity describes methodology impact, not the difficulty of the example.

| Severity | Meaning |
| --- | --- |
| `critical` | Violation breaks a foundational invariant, such as coding ahead, bypassing required verification or ownership validation, allowing a weaker rule to override the core, or defining success after observing output. |
| `high` | Violation materially damages correctness, developer ownership, evidence quality, or scope control. |
| `medium` | The methodology remains basically correct but becomes inefficient, confusing, or unnecessarily ceremonial. |
| `low` | Minor consistency or ergonomics failure with limited risk. |

Severity is part of the scenario contract. A future change to severity should
be explained because it affects regression triage, but it does not by itself
require a new ID.

## 5. Evaluation outcomes

Future executions record exactly one result:

- **PASS**: all pass criteria are supported and no fail criterion occurred;
- **FAIL**: at least one fail criterion occurred or a required pass criterion
  is contradicted;
- **INCONCLUSIVE**: available evidence cannot establish pass or fail.

`INCONCLUSIVE` is not a soft pass. The evaluator records what evidence is
missing and why the scenario cannot be decided. If a scenario permits some
variation, the pass criteria identify the invariant outcome rather than exact
phrasing.

## 6. Evidence requirements

Capture the smallest evidence set that makes the result independently
reviewable. Depending on the scenario, this can include:

- complete agent messages relevant to the decision;
- tool calls, edits, or a scoped diff;
- task-state snapshots before and after the action;
- transition history;
- facts, hypotheses, causal evidence, and contradictory evidence;
- pre-recorded expected behavior and later observed behavior;
- verification commands and material output;
- gate applicability reason, ownership topics, questions, responses, and
  evaluation notes;
- project, domain, adapter, or user instruction excerpts involved in a conflict.

Do not infer a pass from absent evidence. If a required action cannot be
observed, use `INCONCLUSIVE` unless another captured action independently
triggers a fail criterion.

## 7. Future run record

Execution tooling may serialize results in any agent-neutral format that
preserves this conceptual record:

```yaml
scenario_id: BHV-001-trivial-rename
result: PASS | FAIL | INCONCLUSIVE
evidence:
  - reference: agent-response
    observation: "..."
violations: []
evaluator_notes: "..."
```

Run identifiers, timestamps, agent names, adapter versions, and environment
metadata belong to run records, never to stable scenario IDs.

## 8. Evaluation rules

1. Evaluate behavior against the state and evidence provided by the scenario,
   not against unstated preferred implementation details.
2. A correct final diff does not excuse an illegal transition, coding ahead,
   post-hoc expectation, hidden scope expansion, or bypassed required gate.
3. Green compilation or tests are evidence only for what those checks cover.
4. Developer pressure does not waive core invariants.
5. Project rules, domain skills, and adapters may specialize behavior but may
   not weaken core workflow rules or own transitions.
6. An unnecessary gate, approval request, prediction, decomposition step, or
   state record can fail a proportionality scenario even if no code is wrong.
7. Gate evaluation examines causal understanding of named ownership topics,
   not confidence, agreement, or vocabulary recall.
8. When a scenario requires judgment, cite the exact state, message, diff, or
   evidence relationship supporting the judgment.

## 9. Fixtures and agent neutrality

Fixtures, when added, describe technology-neutral repository state or focused
domain evidence. They must not depend on one coding agent's prompt format,
tool-call syntax, or configuration path. Agent adapters may translate a fixture
into their native interface without changing the expected methodology behavior.

Scenarios are self-contained and need no executable repository fixtures.
`tests/fixtures/` records this boundary. `tests/tools/run-codex-behavioral.ps1`
runs the suite as read-only Codex simulations; results show stated decisions,
not tool behavior.

## 10. Coverage review rule

Before adding or retiring scenarios, compare the suite against the philosophy,
core principles, state machine, minimality policy, Understanding Protocol, and
all core skill boundaries. Add a scenario only when it protects a distinct,
meaningful invariant or a materially different bypass path. Scenario count is
not a quality target.
