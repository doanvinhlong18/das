DECISION

Define a focused database integration verification against the production SQL dialect and real schema constraints. Use disposable fixtures or a rolled-back transaction; do not rely on mocks or an alternate in-memory database.

EVIDENCE CLASSIFICATION

- **Predeclared expectation:** Exact row sets and cardinalities are known independently before observation.
- **Representative fixtures:** Empty, single-match, and multi-match relationship shapes are known.
- **Risk targeted:** Outer-join filtering may remove customers without orders; join fan-out may duplicate invoices.
- **Not yet evidence:** No query result has been observed, so no `PASS`, `FAIL`, or `INCONCLUSIVE` result is available.

VERIFICATION

1. **Empty match:** Create a customer with no orders. Assert the customer remains in the exact result set, with the expected nullable order/invoice values.
2. **Single match:** Create one customer, one order, and one invoice. Assert the exact expected row appears once.
3. **Multi-match/fan-out:** Create the representative multi-order or multi-join shape. Assert the complete expected invoice set and that each invoice identity occurs exactly once.
4. Compare the full result as a set or multiset, not merely total row count. Also assert:
   - expected customer identities are present;
   - no unexpected rows exist;
   - `COUNT(*) GROUP BY invoice_id` is `1` for every non-null invoice;
   - null invoice rows are evaluated separately and are not collapsed into the uniqueness assertion.
5. Run the focused repository/query integration test first. Add only the smallest broader mapping check if ORM result mapping or shared repository behavior creates a credible regression boundary.

STATE EFFECT

Record this as the active step’s verification strategy and expected result. Remain before observation; do not modify fixtures, SQL, or expectations during verification.

IMPLEMENTATION SCOPE

Verification only. No production-code, query, schema, or test changes are authorized.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS

None blocking; the supplied expectations, constraints, and data shapes are sufficient to define the focused check.