DECISION  
Define a focused database integration verification using the corrected query, real schema constraints, production SQL dialect, and representative fixtures. Do not use mocks or an alternate in-memory dialect that could hide join/null behavior.

EVIDENCE CLASSIFICATION  
- **Known before observation:** Expected row sets, schema constraints, query parameters, and empty/single/multi-match data shapes.
- **Verification evidence to collect:** Exact returned rows, values, cardinality, and identifiers from each case.
- **Not yet evidence:** No query execution or test result has been observed; no PASS/FAIL decision is available.

IMPLEMENTATION SCOPE  
Verification only; do not modify the query, fixtures, schema, tests, or expected outputs during observation.

VERIFICATION  
- **No matching order:** Assert the customer remains exactly once with the expected null/absent order and invoice fields.
- **Single match:** Assert the complete result equals the predeclared row set, including the expected customer and invoice identity.
- **Multiple matches:** Assert the complete result equals the predeclared set and each expected invoice appears exactly once.
- **Cardinality invariant:** Result count equals the expected set size; row count alone is insufficient.
- **Uniqueness invariant:** Group by the intended invoice identity and assert no identity has count greater than one.
- **Preservation invariant:** Every expected customer remains present, including customers with zero orders.
- **Execution boundary:** Exercise the actual repository/query path with the real database semantics and bound parameters.
- **Scope check:** Inspect the active diff separately to confirm only the corrected-query step is present.

STATE EFFECT  
Record this as the pre-observation verification strategy and expected result. Remain in verification design; do not assign `PASS`, `FAIL`, or `INCONCLUSIVE`.

UNDERSTANDING  
Not assessed. Verification design does not trigger or resolve an Understanding Gate.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
None; the supplied expectations, constraints, and representative data shapes are sufficient to define the focused verification.