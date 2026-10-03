DECISION

Do not patch the cache. Continue investigation of the replica-read path.

EVIDENCE CLASSIFICATION

- FACT: With caching disabled, the controlled request still returns the stale value.
- HYPOTHESIS — stale cache: disproven for the controlled path; preserve it with this contradictory evidence.
- HYPOTHESIS — replica read: plausible but unconfirmed.
- CONFIRMED ROOT CAUSE: none.

STATE EFFECT

Remain in `investigation`; readiness is `CONTINUE_INVESTIGATION`. Keep implementation locked.

IMPLEMENTATION SCOPE

None. A cache change would be based on an invalidated cause.

VERIFICATION

Next, establish whether the request reads from a replica and compare the relevant primary/replica values or read-routing evidence. Only confirmed causal evidence permits decomposition and patching.

UNDERSTANDING

Not applicable before implementation and verification.