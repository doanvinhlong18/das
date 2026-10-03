DECISION

Transition from `understanding` to `investigation`; invoke `code-investigation`. Do not implement an N+1 fix yet.

EVIDENCE CLASSIFICATION

- Fact: the dashboard regressed after the latest feature.
- Fact: representative timings, traces, and query counts are available.
- Fact: the current path issues one database query per item.
- Hypothesis: those per-item queries dominate the regression.
- Confirmed root cause: none.

STATE EFFECT

Set mode to `standard` and stage to `investigation`. No user clarification is blocking.

IMPLEMENTATION SCOPE

No changes authorized. Scope is limited to restoring dashboard performance while preserving identical functional output; unrelated optimization is excluded.

VERIFICATION

Eventually compare the representative workload’s timing and query count against the baseline and confirm unchanged output.

UNDERSTANDING

No Understanding Gate applies at this pre-implementation stage.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS

Investigation must establish whether the per-item queries explain the measured regression and identify their originating call/data path.