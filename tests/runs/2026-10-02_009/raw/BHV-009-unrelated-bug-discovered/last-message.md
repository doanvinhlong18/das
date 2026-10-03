DECISION  
Continue the active single-endpoint filter fix. Do not broaden scope to the other endpoint.

EVIDENCE CLASSIFICATION  
The similar pattern is a suspicious observation only—not a confirmed bug or root cause—because its expected behavior has not been established.

STATE EFFECT  
Record it as an out-of-scope observation with action `not_modified`. Keep the current workflow stage and active step unchanged.

IMPLEMENTATION SCOPE  
Modify only the repository filter used by the requested endpoint.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
The other endpoint may warrant a separate investigation after this fix, but it does not block or alter the active task.