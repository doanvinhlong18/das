DECISION

Continue **read-only investigation**. Do not implement `DISTINCT`, aggregation, or join changes yet.

EVIDENCE CLASSIFICATION

- **FACT:** The report requirement independently establishes one row per qualifying order.
- **FACT:** Query text, constraints, representative rows, and read-only query access are available.
- **FACT:** Two customer-address records can satisfy the current join.
- **HYPOTHESIS:** The address join fans out one qualifying order into multiple report rows.
- **Discriminating check:** Run the report query for representative duplicated orders while exposing order and address keys; compare with the qualifying-order set and rule out duplicate order sources or fan-out from other joins.

STATE EFFECT

- Remain in `investigation`.
- Record the join-multiplication explanation as a hypothesis, not a confirmed root cause.
- Advance to decomposition only if the focused query connects the address cardinality to the duplicate rows and excludes credible alternatives.

IMPLEMENTATION SCOPE

- None permitted during this step.
- Any later change must preserve qualification semantics and the intended handling of address-derived columns, rather than merely hiding duplicates.

VERIFICATION

- Later verification must compare the complete result with the independently established expected set.
- Assert every qualifying order appears exactly once, including an order whose customer has two matching address records.
- Also confirm no qualifying orders disappear and no non-qualifying orders appear.

UNDERSTANDING

- No Understanding Gate applies during investigation; no developer decision is currently required.