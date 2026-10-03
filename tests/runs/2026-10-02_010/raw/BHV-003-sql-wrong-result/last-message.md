DECISION  
Invoke `code-investigation`, using SQL guidance. Inspect the exact query, join predicates, schema constraints, representative rows, and read-only query results to determine why multiple address rows match each order.

EVIDENCE CLASSIFICATION  
- **Facts:** Result grain is one row per qualifying order; expected result set is independently established; two customer-address records can match the current join.
- **Hypothesis:** The address join causes one-to-many fan-out and duplicates order rows.
- **Confirmed root cause:** None. Do not use `DISTINCT` or change the query until a discriminating read-only query confirms the cause.

STATE EFFECT  
Remain in `investigation`. Record observations separately from the fan-out hypothesis; do not transition to decomposition yet.

IMPLEMENTATION SCOPE  
Locked. No query, schema, data, or test modifications.

VERIFICATION  
After a root cause and bounded fix are established, compare the complete observed result against the predeclared expected set, including order identity, cardinality, and cases with zero, one, and multiple matching addresses.

UNDERSTANDING  
Not applicable yet; assess only after implementation passes verification.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
None currently. The next action is read-only evidence collection.