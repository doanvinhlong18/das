# Behavioral Test Specification

This directory defines behavioral tests for the `dev-agent-skills`
methodology. It does not contain evidence that the methodology or any coding
agent currently passes them.

## Layout

- `scenarios/BHV-*.md`: normative, stable-ID behavior specifications;
- `scenarios/*.md` without a `BHV-` prefix: coverage indexes retained from
  earlier design phases; they are not independent test cases;
- `fixtures/`: agent-neutral contexts for future executable runs;
- `runs/`: immutable execution evidence, metadata, and per-scenario results;
- `../docs/BEHAVIORAL_TESTING.md`: normative format and evaluation rules.

## Scenario use

Evaluate one scenario from its stated initial state. Capture observable agent
behavior and compare it with both the pass and fail criteria. Record `PASS`,
`FAIL`, or `INCONCLUSIVE`; do not edit the scenario to match observed behavior.

The scenario ID is the historical key. Keep it unchanged when wording is
clarified, files are reorganized, or the scenario is run against another
agent. Never place dates, agent names, or skill versions in the ID.

## Authoring checklist

A normative scenario is complete only when it contains every field required by
`docs/BEHAVIORAL_TESTING.md`, uses one of the four defined severities, states a
specific Understanding Gate decision, and names the evidence needed for an
evaluator to decide the result.

Do not add scenarios to increase coverage counts. Add one when it protects a
distinct invariant or exercises a bypass not already observable in the suite.

## Execution boundary

Full-suite runs execute each scenario once as a read-only Codex simulation with `tests/tools/run-codex-behavioral.ps1` and are evaluated against the scenario contracts. Run `2026-10-02_009` is the pre-fix baseline and `2026-10-02_010` the post-fix run; see their `summary.md` files for results. A simulated answer shows the decision an agent states, not tool behavior, so adapter scenarios `BHV-064` through `BHV-069` need static or prompt-input evidence and stay INCONCLUSIVE in a simulation. Focused run `2026-10-02_003` supplies that evidence for the adapter.

The evaluator of runs 009 and 010 is the controlling session, not an independent reviewer, and each scenario has a single sample. Passing the suite does not establish real-task conformance; dogfooding on real tasks is still required. See `docs/V1_AUDIT.md`.

Post-audit remediation runs `2026-10-03_011` through `020` preserve focused and
full evidence for F-01/F-02. Full run 014 preceded the final BHV-017 hardening;
runs 018 through 020 provide 3/3 focused passes afterward. A final full-suite
run is still required before changing the audit classification.

Never overwrite a run directory. A failed or inconclusive run remains part of
the history; corrections are validated in a new run with a new ID.
