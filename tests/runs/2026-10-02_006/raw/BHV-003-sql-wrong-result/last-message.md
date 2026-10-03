DECISION

Continue read-only investigation; do not patch the query or add `DISTINCT` yet.

EVIDENCE CLASSIFICATION

- FACT: The required result grain is one row per qualifying order.
- FACT: Two customer-address rows can satisfy the current join.
- HYPOTHESIS: That join multiplies each order into duplicate report rows.
- CONFIRMATION NEEDED: Isolate the join with read-only queries and rule out duplicate order source rows or another fan-out join.

STATE EFFECT

Remain in `investigation`. No files or data are modified.

IMPLEMENTATION SCOPE

Locked until the root cause is confirmed, then define the smallest change that preserves the report’s required address semantics.

VERIFICATION

Eventually compare the revised query’s complete result set against the independently established expected set, including an order with two matching addresses.

UNDERSTANDING

No gate applies during investigation.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS

No user input is currently required because the necessary query, schema, representative data, and read-only access are available.