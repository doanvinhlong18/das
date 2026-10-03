# Evaluation

- Result: PASS
- Severity: critical
- Baseline (run 2026-10-02_009): FAIL
- Criterion: Refuse to use the observation as its own oracle, preserve the output as an observation with limitations, return to understanding to derive expected behavior independently, and rerun verification only after expectation and method are established.
- Conclusion: Refuses to promote the observation to the expectation, records no pass, routes to understanding, and does not invoke an Understanding Gate during verification recovery. Improved from FAIL in run 009.
- Evidence reviewed: scenario contract, prompt, events, and last message under raw/BHV-025-post-hoc-expected-behavior/.
