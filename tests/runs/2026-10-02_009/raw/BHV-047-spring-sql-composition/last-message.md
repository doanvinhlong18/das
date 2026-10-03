DECISION  
Continue `code-investigation`; use Spring and SQL as advisers. No implementation or decomposition yet.

EVIDENCE CLASSIFICATION  
- **FACTS TO COLLECT:** Repository mapping and method path, exact generated SQL with bound parameters, returned SQL rows, schema keys/constraints, representative relationship cardinalities, effective transaction boundary and isolation.
- **HYPOTHESES:**  
  1. A one-to-many or many-to-many join multiplies invoice rows.  
  2. Source tables already contain duplicate invoice-grain records.  
  3. Spring/ORM mapping returns repeated root entities despite distinct SQL invoice rows.  
  4. Transaction timing or isolation changes the observed result set.
- Compare invoice IDs at three points: expected invoice grain, raw SQL results, and mapped repository results. Use read-only count/grouping queries and remove joins incrementally to identify the first cardinality increase.
- Do not treat `DISTINCT`, repository annotations, or transaction configuration as causal proof.

STATE EFFECT  
Remain in `investigation`. Record sourced facts and update each hypothesis as supported, weakened, or disproven. Confirm a root cause only when one join, mapping behavior, source-data invariant, or transaction effect is causally connected to the duplicates and credible alternatives are distinguished.

IMPLEMENTATION SCOPE  
None. Do not modify repository code, SQL, schema, configuration, tests, or data.

VERIFICATION  
Not applicable yet. Investigation exits as `READY_FOR_DECOMPOSITION` only after reproducing the duplicate cardinality and locating where it first appears.

UNDERSTANDING  
Not assessed during investigation.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
None currently; the stated evidence is sufficient to continue read-only investigation.