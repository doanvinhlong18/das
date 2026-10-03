**DECISION**  
Continue with `code-investigation`; do not modify the report query yet.

**EVIDENCE CLASSIFICATION**  
- **Fact:** Each qualifying order must appear once; the expected result set is independently established.
- **Fact:** Two customer-address rows can satisfy the current join.
- **Hypothesis:** The address join multiplies order rows because its predicate does not select a unique address.
- **Not yet confirmed:** That this fan-out fully explains the report duplicates.

**STATE EFFECT**  
Remain in `investigation`. No root cause, decomposition, or implementation step is recorded yet.

**IMPLEMENTATION SCOPE**  
None until confirmed. Do not add `DISTINCT` merely to suppress duplicate rows.

**VERIFICATION**  
Run focused read-only queries that:
- Identify the intended result grain and order key.
- Compare the report output with the established expected order set.
- Count matching address rows per duplicated order.
- Remove or uniquely constrain the address join experimentally and confirm whether cardinality becomes one row per order without changing qualification semantics.

**UNDERSTANDING**  
Not assessed; understanding gates occur only after implementation passes verification.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
None currently—the provided SQL, constraints, representative rows, and read-only access are sufficient for the next investigation step.