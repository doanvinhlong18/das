**DECISION**  
Do not add `DISTINCT` yet. Continue investigation because it could hide an incorrect temporal join while returning the wrong address.

**EVIDENCE CLASSIFICATION**  
- **FACT:** The address join produces two rows per invoice.
- **FACT:** An invoice may have two historical addresses, but only the address effective on the invoice date should match.
- **HYPOTHESIS:** The join is missing or misapplying the address validity-date predicate, causing one-to-many fan-out.
- **NOT CONFIRMED:** Whether multiplication originates solely from addresses or from another join/upstream duplicate.

**STATE EFFECT**  
Remain in `investigation`; no implementation or decomposition transition yet.

**IMPLEMENTATION SCOPE**  
No SQL modification. Inspect the exact join, keys, validity columns, and sample rows; run a focused read-only query that identifies which address interval contains each invoice date and checks boundary/tie cases.

**VERIFICATION**  
The eventual fix must return exactly one invoice row with the historically effective address. Row count alone is insufficient; verify address values and date boundaries.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
None blocking—the available keys and sample rows should discriminate the hypothesis.