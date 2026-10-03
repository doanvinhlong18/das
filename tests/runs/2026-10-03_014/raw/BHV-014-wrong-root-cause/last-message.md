DECISION  
Do not patch the cache. Continue investigation.

EVIDENCE CLASSIFICATION  
- FACT: With caching disabled, the request still returns the stale value.
- HYPOTHESIS — stale cache: Disproven as the cause of this observed response.
- HYPOTHESIS — replica-read path: Plausible but unconfirmed; the trace only suggests it.
- CONFIRMED ROOT CAUSE: None.

STATE EFFECT  
Remain in `investigation`. Preserve the contradictory cache evidence and evaluate the replica-read hypothesis next.

IMPLEMENTATION SCOPE  
No files may be modified. A cache patch would be speculative and unsupported.

VERIFICATION  
Perform a discriminating read-path check: confirm which datasource handles the request and compare the relevant value from the primary and replica. Advance to decomposition only if evidence causally connects that path to the stale response.