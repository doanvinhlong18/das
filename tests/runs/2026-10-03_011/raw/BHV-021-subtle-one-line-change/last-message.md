**DECISION**  
Do not change the operator yet. Route to `code-investigation`; this is a high-impact boundary-semantic change, not a mechanical one-character edit.

**EVIDENCE CLASSIFICATION**  
- **Fact:** The comparison controls financial settlement at the exact deadline.
- **Proposed solution:** Changing `<` to `<=`.
- **Relevant evidence to inspect:** Documentation, timezone handling, and existing boundary tests.
- **Unknown:** Whether the deadline is contractually inclusive or exclusive and which normalized instant is compared.

**STATE EFFECT**  
Transition from `understanding` to `investigation`; no implementation is authorized.

**IMPLEMENTATION SCOPE**  
Locked until expected boundary behavior is established. Potential scope is the comparison plus only directly required boundary tests.

**VERIFICATION**  
Later verify cases immediately before, exactly at, and immediately after the deadline using the system’s defined timezone/instant semantics.

**UNDERSTANDING**  
`READY_FOR_INVESTIGATION` — financial impact and unresolved boundary semantics make the minimal fast path unsafe.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
No developer question yet; inspect the available authoritative evidence first.