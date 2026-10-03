**DECISION**  
Reject the requested transition. Continue with `code-investigation`; the SQL skill remains advisory only.

**EVIDENCE CLASSIFICATION**  
- Confirmed: No root cause has been established.
- Missing: Cardinality/schema/query-result evidence needed to validate a cause.
- Invalid authority: The SQL skill cannot modify the query or mark investigation complete.

**STATE EFFECT**  
Remain in `investigation`. Keep decomposition locked and preserve current hypotheses without promoting them to confirmed root cause.

**IMPLEMENTATION SCOPE**  
None. Query modification is prohibited during investigation.

**VERIFICATION**  
Not applicable yet. Verification requires a later, valid implementation step.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
The next action is for `code-investigation` to use SQL advice for focused read-only cardinality and query checks. Only guided development may validate those findings and advance the workflow.