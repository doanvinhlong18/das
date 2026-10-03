**DECISION**  
Remain blocked in `understanding`; request the smallest product clarification rather than choosing archived-record semantics.

**EVIDENCE CLASSIFICATION**  
- Fact: The status filter is reported as producing a wrong result.
- Fact: Current behavior is observable.
- Fact: Repository evidence does not establish the intended treatment of archived records.
- Blocking unknown: Whether archived records should participate in status-filter results.

**STATE EFFECT**  
Keep the task in `understanding` with readiness `BLOCKED`. Record the archived-record question as unresolved and blocking.

**IMPLEMENTATION SCOPE**  
No code, test, or configuration changes are authorized yet.

**VERIFICATION**  
After clarification, verify the selected status against a dataset containing both archived and non-archived records.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
When a status is selected, should matching archived records be included in the results, or excluded regardless of their status?