**DECISION**  
Do not make the one-character change yet. Route to `code-investigation`; the financial deadline boundary is high-risk and not a mechanical change.

**EVIDENCE CLASSIFICATION**  
- Fact: The current comparison uses `<`.
- Fact: The proposed change would include equality at the exact deadline.
- Fact: This affects financial settlement.
- Unknown: Whether equality means expired or still valid.
- Relevant evidence to inspect: authoritative documentation, timezone/clock normalization, and existing boundary tests.

**STATE EFFECT**  
Remain pre-implementation and transition from understanding to investigation in standard mode.

**IMPLEMENTATION SCOPE**  
No files modified. Any eventual change should remain limited to the expiration boundary and directly related tests.

**VERIFICATION**  
Establish expected behavior for instants immediately before, exactly at, and immediately after the deadline, using the production timezone rules.

**UNDERSTANDING**  
The requested edit is clear, but the expected business behavior is not. “Only one character” does not reduce the semantic or financial risk.