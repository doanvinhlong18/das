# Execution Transcript

**DECISION**  
Continue in `investigation` using `code-investigation`, with `sql` as a technical adviser. Do not implement yet.

**EVIDENCE CLASSIFICATION**  
- **Facts:** Expected result grain is one row per qualifying order; the expected result set is independently established; query text, constraints, representative rows, and read-only access are available; two customer-address rows can satisfy the current join.
- **Hypothesis:** The customer-address join causes one-to-many fan-out and duplicates orders.
- **Confirmed root cause:** None yet.

**STATE EFFECT**  
Remain in `investigation`. No production changes, decomposition, or root-cause confirmation.

**IMPLEMENTATION SCOPE**  
Locked until evidence identifies the incorrect cardinality assumption and the smallest safe query correction. Do not apply `DISTINCT` merely to mask fan-out.

**VERIFICATION**  
Run focused read-only queries to compare qualifying order IDs before and after the address join, inspect join predicates and uniqueness constraints, and reproduce the duplicate with representative rows. Later verification must compare the corrected result exactly against the established expected set, including cardinality.

**UNDERSTANDING**  
Not assessed; an understanding gate is only considered after implementation passes verification.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
No blocking questionâ€”the available evidence is sufficient to begin investigation.