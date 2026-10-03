**DECISION**

Activate SQL advisory reasoning within the existing investigation. No implementation is needed because the request asks for an explanation.

**EVIDENCE CLASSIFICATION**

- **Fact:** The query uses a `LEFT JOIN`.
- **Fact:** `WHERE` contains a predicate on the right-side orders table.
- **Confirmed root cause:** Customers without orders produce `NULL` right-side columns. The right-table predicate evaluates to `UNKNOWN` and is rejected by `WHERE`, effectively making that condition behave like an inner join.

**STATE EFFECT**

Investigation can record the root cause as confirmed. The task remains explanation-only and requires no decomposition or code changes.

**IMPLEMENTATION SCOPE**

None. If a later change is requested, moving the order predicate into the `ON` clause is the usual way to filter matching orders while retaining customers with no orders; the exact rewrite must preserve the known expected customer set.

**VERIFICATION**

Compare the known sample rows against the expected set, specifically confirming that a customer with no matching order remains present with `NULL` order columns after any rewrite.

**UNDERSTANDING**

No understanding gate is warranted for this explanation-only task.