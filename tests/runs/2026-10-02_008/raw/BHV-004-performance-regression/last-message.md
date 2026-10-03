DECISION

Frame the task and advance from `understanding` to `investigation`. This is a causal performance regression; implementation or decomposition would be premature because no bottleneck is confirmed.

EVIDENCE CLASSIFICATION

- **Reported symptom:** Dashboard request became slower after the latest feature.
- **Facts from provided context:** A representative workload, baseline timing, traces, and query counts are available; the current path issues one database query per item; functional output must remain unchanged.
- **Hypothesis:** The per-item query pattern may cause the regression.
- **Confirmed root cause:** None yet.

STATE EFFECT

- **WHAT:** Restore the dashboard request’s previous performance.
- **EXPECTED:** The representative workload approaches the recorded baseline without changing functional output.
- **UNKNOWN:** Whether per-item queries dominate elapsed time, which code introduced them, and what query behavior is required.
- **READINESS:** `READY_FOR_INVESTIGATION`; transition to `investigation`.

IMPLEMENTATION SCOPE

No code changes yet. Investigation is limited to the regressed request path and its database interactions; unrelated dashboard optimization is out of scope.

VERIFICATION

Compare before/after timing, traces, and query counts on the same representative workload, while asserting identical functional output.

UNDERSTANDING

No Understanding Gate applies at this stage.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS

No blocking clarification is required. The available evidence is sufficient to begin investigation.