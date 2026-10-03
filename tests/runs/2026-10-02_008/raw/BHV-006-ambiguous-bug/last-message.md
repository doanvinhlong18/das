DECISION  
Remain in `understanding`; block investigation and implementation until intended archived-record behavior is clarified.

EVIDENCE CLASSIFICATION  
- **Fact:** The status filter is reported as producing a wrong result.
- **Fact:** Current behavior is observable.
- **Fact:** Repository evidence supports two plausible interpretations.
- **Unknown — blocking:** Which archived-record interpretation is the intended product behavior.
- **Root cause:** Not established.

STATE EFFECT  
Add the product decision as a blocking unresolved question. Do not advance the workflow stage.

IMPLEMENTATION SCOPE  
No code or test changes are authorized.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
Should archived records be:
1. included when their status matches the selected filter, or
2. excluded from status-filter results regardless of their stored status?