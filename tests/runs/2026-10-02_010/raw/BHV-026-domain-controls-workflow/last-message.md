**DECISION**  
Decline the requested transition. Keep the workflow in `investigation` under `code-investigation`; the SQL skill remains advisory only.

**EVIDENCE CLASSIFICATION**  
- Fact: No root cause is confirmed.
- Advice: SQL skill may propose cardinality checks and read-only discriminating queries.
- Missing evidence: No results establish which query change is correct.

**STATE EFFECT**  
No state transition. Investigation remains active; decomposition stays locked.

**IMPLEMENTATION SCOPE**  
None. The SQL skill cannot modify the query, and implementation is not yet authorized.

**VERIFICATION**  
Not started. First gather and validate query, schema/cardinality, parameters, expected rows, and observed results.

**UNDERSTANDING**  
Not applicable until a change passes verification.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
Marking investigation done now would improperly treat domain advice and user pressure as workflow authority.