---
name: code-investigation
description: Collect and classify evidence for a software task without modifying project code. Use when behavior, location, cause, call flow, configuration, data, tests, or runtime evidence must be investigated and facts must remain distinct from hypotheses and confirmed root causes.
---

# Code Investigation

## Purpose

Establish where relevant behavior lives and what evidence explains it. Preserve
the boundary between observation, inference, and confirmed causality.

## Shared Minimality Policy

Apply [the minimality policy](../../docs/MINIMALITY_POLICY.md). Gather the
smallest discriminating evidence set, broaden only for a credible alternative
or unknown blast radius, and stop when the exit criteria make the next decision
safe. Use the shared out-of-scope observation format for unrelated findings.

## Trigger

Run when workflow state permits `investigation`, including recovery after failed
verification, disproven hypotheses, invalidated root causes, or material new
evidence.

## Preconditions

- Task understanding records WHAT, EXPECTED, scope, and investigation questions.
- Material requirement ambiguity is resolved or recorded as a blocker.
- Repository and tool boundaries are known.
- No implementation step is currently allowed to write project files.

## Inputs

- Task goal, expected behavior, scope, known facts, and unresolved questions.
- Repository code, call chains, tests, configuration, logs, queries, runtime
  behavior, and authoritative documentation available to the task.
- Relevant project configuration and advisory domain guidance.
- Prior hypotheses, verification evidence, or invalidated root causes.

## Process

1. Turn each blocking unknown into an investigation question.
2. Trace the smallest relevant behavior path before broadening the search. Use
   entry points, callers, callees, configuration, data access, and tests as
   evidence, not as filenames to edit.
3. Record every material observation as a **FACT** with a reproducible source.
4. Record each explanatory inference as a **HYPOTHESIS**. State supporting
   evidence, contradictory evidence, credible alternatives, and a
   falsification or discrimination method when material.
5. Seek evidence from the most direct available source: focused code paths,
   call chains, existing tests, logs, configuration, read-only queries, runtime
   behavior, or authoritative documentation.
6. Update hypotheses explicitly as `supported`, `weakened`, or `disproven`.
   Never change the label silently.
7. Create a **CONFIRMED ROOT CAUSE** record only when evidence connects cause to
   symptom and distinguishes credible alternatives. Link the originating
   hypothesis and causal evidence.
8. Record contradictory evidence even when it weakens the leading explanation.
9. Record unrelated findings as out-of-scope observations with action
   `not_modified`.
10. Return readiness:
    - `READY_FOR_DECOMPOSITION` when evidence is sufficient to define bounded
      logical changes;
    - `CONTINUE_INVESTIGATION` when a discriminating check remains available;
    - `BLOCKED` when required evidence or access is unavailable.

When investigation concerns an architecture or technical-boundary choice that
dependent implementation will encode, the readiness output must also state the
post-investigation lock: decomposition records the selected option,
alternatives, trade-offs and verification analysis, and no dependent
implementation becomes ready until any required decision-level Understanding
Gate passes. A user-selected direction narrows the comparison but is not by
itself evidence and does not remove this gate dependency.

Use explicit labels in investigation output:

```text
FACT:
Source:

HYPOTHESIS:
Supports:
Contradicts:
Would confirm or falsify:

CONFIRMED ROOT CAUSE:
Causal evidence:

UNCERTAINTY:
READINESS:
```

## Outputs

- Sourced facts.
- Explicit hypotheses and their current status.
- Contradictory evidence and remaining uncertainty.
- Confirmed root-cause records only where justified.
- Relevant behavior locations and causal or control/data-flow explanation.
- Out-of-scope observations.
- A readiness recommendation for decomposition, continued investigation, or a
  blocker.

## Allowed Actions

- Read and search source, tests, configuration, history, and documentation.
- Trace callers, callees, data flow, and configuration resolution.
- Run existing focused tests and non-mutating diagnostic commands.
- Inspect logs, traces, runtime output, and read-only query results.
- Consult domain skills for technology-specific evidence strategies.
- Update investigation-owned task-state fields.

## Forbidden Actions

- Do not modify production code, tests, configuration, generated files, or
  dependencies.
- Do not create a speculative patch to test a hypothesis.
- Do not call a hypothesis a fact or confirmed root cause because it is
  plausible, conventional, or followed by a matching symptom.
- Do not hide, delete, or minimize contradictory evidence.
- Do not broaden task scope or silently fix an unrelated issue.
- Do not decompose or implement the solution.
- Do not quiz the developer for workflow readiness.
- Do not advance workflow state directly.

## Exit Criteria

Exit as `READY_FOR_DECOMPOSITION` only when:

- the controlling behavior and expected behavior are sufficiently located;
- relevant facts have reproducible sources;
- material hypotheses have explicit status;
- a material root cause is confirmed for causal bug work, or root cause is
  explicitly not applicable for the task type;
- credible contradictory evidence has been addressed or remains visible as a
  blocker;
- remaining uncertainty does not require implementation to guess.

## State Effects

May propose updates only to:

- `reasoning.facts`;
- `reasoning.hypotheses`;
- `reasoning.confirmed_root_causes`;
- `reasoning.unresolved_questions`;
- `out_of_scope_observations`;
- transition evidence supporting continued investigation or decomposition.

Must not update project files, plan step readiness, implementation status,
verification results, understanding status, or task completion.

## Failure Behavior

- If a hypothesis is disproven, preserve it with contradicting evidence and
  investigate the next credible explanation.
- If a confirmed root cause is invalidated, mark it invalidated, reopen the
  question, and report which downstream assumptions must be reconsidered.
- If evidence is unavailable, state what is missing, why it matters, and whether
  the task is blocked or merely uncertain.
- If runtime evidence would require unsafe or unauthorized mutation, stop and
  request the needed access or an alternative observation method.
- If investigation reveals a requirement conflict, return to task understanding
  instead of resolving the product choice implicitly.

## Examples

**SQL duplicates:** "The join is multiplying rows" begins as a HYPOTHESIS. The
query text and duplicate result set are FACTS. Confirm the root cause only after
schema/cardinality evidence or a controlled query shows which relationship
causes the multiplication and rules out another join or upstream duplicate.

**Null failure:** A stack trace line is a FACT. "The repository returned null"
is a HYPOTHESIS until the call path, return contract, and focused reproduction
show that value crossing into the failing dereference.
