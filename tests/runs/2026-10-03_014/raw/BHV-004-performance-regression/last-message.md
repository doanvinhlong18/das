DECISION

Transition from `understanding` to `investigation`. This is causal performance work; implementation is not yet permitted.

UNDERSTANDING

- **WHAT:** The dashboard request regressed after the latest feature.
- **EXPECTED:** Restore representative-workload performance toward the recorded baseline while preserving identical functional output.
- **KNOWN:** Baseline timing, current traces, and query counts are available. The current path executes one database query per item.
- **UNKNOWN:** Whether per-item querying was introduced by the feature, whether it dominates elapsed time, where it originates, and whether other bottlenecks materially contribute.
- **SCOPE:** Dashboard request path and feature-related performance changes; no unrelated optimization or functional changes.
- **VERIFY:** Compare the same representative workload before and after any eventual change, including elapsed time, query count, and functional output.

EVIDENCE CLASSIFICATION

- **FACT:** The current workload performs one query per item.
- **HYPOTHESIS:** An N+1 query pattern introduced or exposed by the feature causes the regression.
- **CONFIRMED ROOT CAUSE:** None yet; correlation and credible alternatives must be examined.

STATE EFFECT

Set mode to standard and advance to `investigation`, recording the unknowns and initial verification direction.

IMPLEMENTATION SCOPE

Locked. First trace the per-item query to its controlling code, compare baseline/current query scaling and timing, and confirm causality before decomposition.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS

No developer clarification is currently blocking investigation.