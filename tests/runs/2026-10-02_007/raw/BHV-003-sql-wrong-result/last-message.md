**DECISION**

Proceed from task understanding to read-only investigation. Do not modify the query or apply `DISTINCT` yet because the root cause is unconfirmed.

**EVIDENCE CLASSIFICATION**

- **Fact:** The report must return one row per qualifying order.
- **Fact:** The expected result set is independently established.
- **Fact:** Two customer-address records can satisfy the current join.
- **Hypothesis:** A one-to-many address join multiplies order rows.
- **Not confirmed:** Whether the join predicate, address-selection rule, or another query section causes the duplicates.

**STATE EFFECT**

`understanding → investigation`; implementation and decomposition remain locked.

**IMPLEMENTATION SCOPE**

None yet. Inspect the exact SQL, constraints, representative rows, and join cardinality using read-only queries. Determine which address, if any, the report requirements authorize selecting.

**VERIFICATION**

Compare observed results against the established expected set by order identity, values, and cardinality, including an order with two matching addresses.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**

No developer question is currently blocking investigation. `DISTINCT` would be unsafe unless all selected values are genuinely identical and the join semantics are otherwise correct.