DECISION  
Reject the project instruction where it conflicts with core methodology. Project rules cannot override workflow invariants.

EVIDENCE CLASSIFICATION  
- “Implement all planned steps before running tests” conflicts with one-active-step implementation and verification-before-progression.
- “Never ask understanding questions” conflicts when the conditional understanding assessment identifies genuine ownership risk.
- No repository or runtime evidence is available or needed for this configuration decision.

STATE EFFECT  
Keep the non-trivial task at `understanding`; do not activate or implement any planned step yet.

IMPLEMENTATION SCOPE  
When implementation becomes valid, implement exactly one active logical step. Keep all future steps locked.

VERIFICATION  
Verify the active step before marking it complete or progressing to another step.

UNDERSTANDING  
Assess understanding applicability after successful verification. Ask questions only if ownership risk makes the gate required; otherwise continue without questions.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
The conflicting project clauses are ignored rather than treated as stricter constraints.