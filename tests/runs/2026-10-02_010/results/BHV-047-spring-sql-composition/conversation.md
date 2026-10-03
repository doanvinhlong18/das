# Execution Transcript

**DECISION**  
Continue `code-investigation`, using Spring and SQL only as advisers. Trace the smallest path from repository mapping to generated SQL, schema cardinality, representative rows, and effective transaction boundary.

**EVIDENCE CLASSIFICATION**  
- FACT: Duplicate invoices are reported; supporting artifacts are available but not yet analyzed.
- HYPOTHESES: Join fan-out, duplicate source rows, incorrect ORM collection/fetch mapping, or transaction/concurrency effects.
- CONFIRMED ROOT CAUSE: None. Generated SQL alone cannot establish causality.

**STATE EFFECT**  
Remain in `investigation`; record sourced facts and test each hypothesis with discriminating, read-only evidence.

**IMPLEMENTATION SCOPE**  
None. Do not modify repository code, SQL, mappings, configuration, tests, schema, or data.

**VERIFICATION**  
Compare the intended invoice-row grain against actual keys and join cardinalities. Use representative rows to determine whether duplication exists before the join or is introduced by a specific relationship; then confirm the effective Spring transaction/proxy path does not provide a competing explanation.

**UNDERSTANDING**  
Not applicable during investigation.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
No developer decision is required yet. Proceed with the available evidence; do not apply `DISTINCT` as a speculative fix.
