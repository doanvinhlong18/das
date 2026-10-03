# Domain Skill Contract

## Status and purpose

Domain skills provide technology-specific reasoning during an active core
workflow. They improve how the agent investigates evidence and designs focused
verification. They do not own process, task state, project modification, or
completion.

This contract applies to every skill under `domains/` and is subordinate to
[CORE_PRINCIPLES.md](CORE_PRINCIPLES.md),
[ARCHITECTURE.md](ARCHITECTURE.md), and
[MINIMALITY_POLICY.md](MINIMALITY_POLICY.md).

## Advisory boundary

The active core skill invokes a domain skill with a bounded question and the
smallest relevant task-state projection. A domain skill may return:

- relevant technology and version assumptions;
- source-backed observations for the core to classify;
- explicit technical hypotheses and discriminating checks;
- likely failure modes and dangerous assumptions;
- focused verification techniques;
- limitations and conflicts in available evidence;
- candidate ownership topics for later core applicability assessment.

A domain skill must not:

- change workflow stage, active step, readiness, or completion state;
- promote a hypothesis to confirmed root cause on authority alone;
- modify project files;
- authorize implementation, scope expansion, or dependency changes;
- waive investigation, decomposition, or verification;
- require, waive, evaluate, or pass an Understanding Gate;
- mark verification, a logical step, or the task complete.

The core may use domain output as evidence. The core remains responsible for
classification, sufficiency, transition legality, and state updates.

## Invocation and output

Invoke only domains relevant to the active question. Provide repository and
runtime version evidence when behavior varies by version. Ask:

> What failure is this domain consultation preventing?

Do not invoke several domains merely because the repository uses them.

Return a compact advisory record:

```text
DOMAIN ADVICE:
Relevance: ...
Observed evidence: source and observation
Hypotheses: explanation plus discriminating check
Dangerous assumptions: ...
Suggested verification: ...
Candidate ownership topics: ...
Limitations: ...
```

Omit empty sections. "Candidate ownership topics" are input to core policy, not
a gate decision.

## Composition

`guided-development` remains the workflow authority when several domains are
relevant. The active core skill selects and coordinates domains; one domain
does not import, invoke, or control another.

Examples:

- `guided-development + spring + sql`: Spring traces proxy and transaction
  behavior; SQL analyzes query semantics and database evidence; core
  investigation classifies the combined evidence.
- `guided-development + angular + testing`: Angular traces component, signal,
  observable, and template behavior; Testing evaluates which focused checks
  discriminate the expected UI behavior; core verification owns the result.
- `guided-development + java + git`: Java interprets a failure path; Git locates
  the introducing change and surrounding history; neither may prescribe or
  activate a fix.

## Conflict resolution

When domain advice conflicts:

1. Preserve both claims as advice or hypotheses.
2. Check technology versions, configuration, runtime path, and source quality.
3. Prefer direct repository or runtime evidence over general convention.
4. Ask the active investigation to run the smallest discriminating check.
5. Keep the workflow in its current state until core exit criteria pass.

Project configuration may supply versions, commands, schema facts, and stricter
restrictions. It cannot grant a domain workflow authority or weaken a core
invariant. If a suggested command is unsafe or unavailable, the domain records
the limitation and proposes a safer evidence source.

## Minimality

Use the smallest useful domain consultation. Do not turn an active task into a
tutorial, enumerate every possible failure mode, or recommend broad diagnostic
suites without a credible link to the question. Stop when the active core skill
has enough discriminating technical guidance for its next valid decision.
