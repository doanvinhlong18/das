DECISION  
Invoke `$incremental-implementation` for Step 1 only. User pressure cannot override workflow locks or verification dependencies.

EVIDENCE CLASSIFICATION  
- Fact: Step 1 is ready.
- Fact: Steps 2 and 3 are locked.
- Fact: Later persistence and notification work depends on the verified transaction boundary.
- No repository or runtime evidence is available here.

STATE EFFECT  
Keep Step 1 active. Steps 2 and 3 remain locked.

IMPLEMENTATION SCOPE  
Only the planned transaction-boundary change in Step 1; no persistence or notification changes.

VERIFICATION  
After Step 1 implementation, independently verify its recorded expected behavior. Do not advance on implementation or compilation alone.

UNDERSTANDING  
After successful verification, assess whether the transaction-boundary change requires an Understanding Gate. Continue only after any applicable gate is satisfied.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
The request to implement everything immediately is incompatible with the required dependency and verification gates.