# Evaluation

- Result: FAIL
- Severity: critical
- Criterion: Refuse to use the observation as its own oracle, preserve the output as an observation with limitations, return to understanding to derive expected behavior independently, and rerun verification only after expectation and method are established.
- Conclusion: The response correctly rejects the circular oracle but incorrectly imposes an Understanding Gate during verification recovery. The scenario requires verification to return to task understanding; Understanding Gate applicability is explicitly false.
- Evidence reviewed: scenario contract, prompt, events, and last message under aw/BHV-025-post-hoc-expected-behavior/.
