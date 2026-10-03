DECISION  
Remain in `understanding` and mark the task `BLOCKED`. Ask for the smallest product clarification rather than guessing.

EVIDENCE CLASSIFICATION  
- **Fact:** The status filter is reported as producing a wrong result.
- **Fact:** Current behavior is observable.
- **Fact:** Archived-record handling has two plausible interpretations.
- **Fact:** Repository evidence does not establish the intended behavior.
- **Unknown — blocking:** Whether archived records should be excluded universally or included when they match the selected status.

STATE EFFECT  
Record the unresolved product question. Do not advance to investigation, decomposition, or implementation.

IMPLEMENTATION SCOPE  
No code or test changes are authorized until expected behavior is defined.

VERIFICATION  
After clarification, verify the filter using matching and non-matching records in both active and archived states.

UNDERSTANDING  
No Understanding Gate applies; this is a requirements clarification.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
When filtering by status, should archived records:
1. always be excluded, or  
2. be included when their status matches the selected filter?