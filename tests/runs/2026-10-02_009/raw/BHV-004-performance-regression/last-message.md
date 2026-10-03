DECISION

Transition from `understanding` to `investigation`. The task is causal and non-trivial; the one-query-per-item pattern is not yet a confirmed bottleneck.

EVIDENCE CLASSIFICATION

- **FACT:** A representative workload, baseline timing, traces, and query counts are available.
- **FACT:** The current request path executes one database query per item.
- **REPORTED SYMPTOM:** Dashboard latency regressed after the last feature.
- **HYPOTHESIS:** The per-item query pattern causes the regression. Confirm by correlating query growth and database time with the timing delta while excluding other trace regressions.

STATE EFFECT

Record the goal, unchanged functional-output requirement, performance scope, evidence sources, and unresolved causal question; advance to `investigation`.

IMPLEMENTATION SCOPE

No implementation yet. Investigation should locate the controlling call path and determine whether queries can be batched, joined, or prefetched without changing output.

VERIFICATION

Use the representative workload to compare against baseline timing and query counts, while asserting identical functional output.

UNDERSTANDING

No Understanding Gate applies at this stage.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS

No blocking question; the available evidence is sufficient to begin investigation.