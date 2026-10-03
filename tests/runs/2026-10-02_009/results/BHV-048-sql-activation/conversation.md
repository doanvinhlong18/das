# Execution Transcript

**DECISION**  
Use `code-investigation` with SQL advisory reasoning. No implementation or additional evidence collection is needed.

**EVIDENCE CLASSIFICATION**  
- **FACT:** The query uses a `LEFT JOIN`, but its `WHERE` clause requires a condition on the right-side orders table.
- **FACT:** Customers without orders produce `NULL` values for all order columns.
- **CONFIRMED ROOT CAUSE:** SQL three-valued logic makes the right-table predicate evaluate to `UNKNOWN` for those `NULL` rows. `WHERE` retains only `TRUE`, so the unmatched customers are removed. The predicate effectively turns the outer join into an inner join for that condition.

**STATE EFFECT**  
The causal question is resolved. For this explanation-only request, no decomposition or implementation phase is necessary.

**IMPLEMENTATION SCOPE**  
None. If a fix is later requested, consider moving the right-table predicate into the `ON` clause, subject to the intended result semantics.

**VERIFICATION**  
The supplied sample rows distinguish matched customers from customers whose joined order columns are `NULL`; no runtime verification is required for the current â€œwhyâ€ question.

**UNDERSTANDING**  
No understanding gate is warranted.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
None.