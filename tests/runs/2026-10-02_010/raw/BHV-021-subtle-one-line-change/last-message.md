DECISION  
Move from **understanding** to **investigation** in standard mode. Do not change `<` to `<=` yet; the edit is syntactically trivial but financially significant and its expected boundary behavior is unresolved.

EVIDENCE CLASSIFICATION  
- **Fact:** The comparison controls settlement expiration at the exact deadline.
- **Proposed solution:** The user requested `<` → `<=`; this does not prove the intended business rule.
- **Relevant evidence to inspect:** Authoritative documentation, timezone/deadline normalization, and existing boundary tests.
- **Unknown:** Whether a transaction is expired exactly at the deadline.

STATE EFFECT  
Record the boundary semantics as unresolved and set the next responsibility to `code-investigation`. No root cause or implementation is confirmed.

IMPLEMENTATION SCOPE  
No implementation is authorized until investigation establishes whether equality means expired and identifies the controlling time representation.

VERIFICATION  
Eventually test immediately before, exactly at, and immediately after the deadline, including the applicable timezone behavior.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
No clarification is needed before investigation. If documentation and tests conflict, stop and request a product decision rather than choosing silently.