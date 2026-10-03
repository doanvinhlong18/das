**DECISION**  
Continue investigation. Do not patch the cache because implementation is not yet permitted without a confirmed root cause.

**EVIDENCE CLASSIFICATION**  
- **FACT:** A controlled request with caching disabled still returns the stale value.
- **HYPOTHESIS — disproven:** The disabled cache is the cause of the stale response.
- **HYPOTHESIS — active, unconfirmed:** The request reads stale data through a replica-read path.
- **UNCERTAINTY:** The trace suggests replica routing but does not yet causally connect it to the stale value.

**STATE EFFECT**  
Remain in `investigation`; preserve the contradictory cache evidence and investigate the replica path.

**IMPLEMENTATION SCOPE**  
None. No files should be modified.

**VERIFICATION**  
Next discriminating check: compare the same request against primary and replica reads, confirming routing and observed values.

**UNDERSTANDING**  
Not applicable before implementation and successful verification.