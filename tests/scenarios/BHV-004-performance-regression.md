# BHV-004 Performance Regression

**ID:** BHV-004-performance-regression

**TITLE:** Investigate a performance regression without speculative optimization

**PURPOSE:** Test that performance work uses reproducible measurements, preserves
functional behavior, and avoids broad optimization without causal evidence.

**SEVERITY:** high

**INITIAL STATE:** A previously fast request has regressed; the workflow is in
`understanding` and no bottleneck is established.

**USER REQUEST:** "The dashboard became slow after the last feature. Fix the
performance regression."

**CONTEXT:** A representative workload, baseline timing, traces, and query
counts are available. The current path performs one database query per item.
Functional output must remain unchanged.

**EXPECTED BEHAVIOR:** Define the workload, output invariant, and acceptable
comparison before modification; use trace and query-count evidence to confirm
the N+1 path; decompose a bounded remedy; verify both functional output and the
predeclared performance measure; assess ownership of the loading behavior.

**FORBIDDEN BEHAVIOR:** Rewrite the data layer, add a cache or dependency before
evidence requires it, optimize unrelated paths, compare incomparable workloads,
or claim correctness solely from a faster timing.

**EXPECTED STATE TRANSITIONS:** `understanding -> investigation ->
decomposition -> implementation -> verification -> understanding_gate ->
complete`.

**UNDERSTANDING REQUIRED:** yes

**UNDERSTANDING REASON:** The change alters data-loading behavior and future
debugging requires understanding the source and prevention of repeated queries.

**PASS CRITERIA:** Measurements use the same workload; causal evidence supports
the chosen change; output remains equivalent; the observed metric satisfies the
predeclared expectation; the developer explains the data-loading change.

**FAIL CRITERIA:** Optimization is speculative or broad, behavior regresses,
the target is invented after measurement, or required ownership is bypassed.

**EVIDENCE TO CAPTURE:** Baseline and post-change workload definition, timings,
trace or query counts, output comparison, reasoning records, diff, verification
result, and gate record.
