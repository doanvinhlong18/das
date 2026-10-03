**DECISION**  
Activate only the behavior-preserving extraction step. Do not implement the new eligibility rule yet.

**EVIDENCE CLASSIFICATION**  
- Confirmed: The decision is duplicated across two production branches.
- Confirmed: Both paths must remain behaviorally consistent.
- Confirmed: A bounded shared decision boundary can be independently verified.
- Out of scope: Broader service cleanup.

**STATE EFFECT**  
Record `gate_dependency.required: true`. Keep the eligibility-rule step locked until:
1. Unchanged-behavior verification passes.
2. The shared-boundary ownership checkpoint passes.

**IMPLEMENTATION SCOPE**  
Extract the existing decision into one shared boundary and route both branches through it without changing current eligibility behavior.

**VERIFICATION**  
Verify both paths produce unchanged results after extraction and inspect the diff for accidental behavior or scope changes.

**UNDERSTANDING**  
After successful verification, require the ownership checkpoint covering responsibility for the new single rule boundary. Do not ask it before verification.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
No clarification is currently needed. The broader cleanup remains unmodified.