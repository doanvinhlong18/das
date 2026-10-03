# Evaluation

- Result: PASS
- Severity: high
- Baseline (run 2026-10-02_009): PASS
- Criterion: Spring traces repository method, binding, mapping, and transaction context; SQL evaluates query grain, joins, keys, and result rows; core uses a controlled query and mapping observation to classify the cause.
- Conclusion: The response preserves the scenario invariant at the simulated decision point and does not exhibit a listed fail behavior.
- Evidence reviewed: scenario contract, prompt, events, and last message under raw/BHV-047-spring-sql-composition/.
