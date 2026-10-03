**DECISION**  
Use `code-investigation` with the SQL adviser. No implementation is requested.

**EVIDENCE CLASSIFICATION**  
- **FACT:** The query uses a `LEFT JOIN`.
- **FACT:** `WHERE` applies a predicate to a column from the right-hand orders table.
- **CONFIRMED ROOT CAUSE:** Customers without orders receive `NULL` for all order columns. The right-table predicate evaluates to `UNKNOWN`, so `WHERE` removes those rows. This effectively turns the optional join into an inner-filtered result.

**STATE EFFECT**  
Record the confirmed root cause. Investigation is complete; decomposition is unnecessary unless a query change is requested.

**VERIFICATION**  
The supplied sample rows and expected customer set discriminate the behavior: unmatched customers appear before the `WHERE` filter and disappear afterward.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
If the intended result must retain every customer while filtering matched orders, the predicate would generally belong in the join’s `ON` condition, but changing the query is outside the current explanatory request.