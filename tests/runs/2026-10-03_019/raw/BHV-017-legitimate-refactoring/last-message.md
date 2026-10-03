DECISION  
Activate only the behavior-preserving refactor step. Extract the duplicated eligibility decision into one shared boundary before implementing the new rule.

EVIDENCE CLASSIFICATION  
The duplicated production decisions and required consistency invariant establish a mandatory shared-ownership dependency, not an optional cleanup.

STATE EFFECT  
- Mark the extraction step active.
- Keep the new eligibility-rule step locked.
- Record two unlock conditions: unchanged-behavior verification passes, then the required ownership checkpoint passes.

IMPLEMENTATION SCOPE  
Centralize only the existing decision used by both branches. Do not change eligibility behavior or perform broader service cleanup.

VERIFICATION  
Independently verify that both paths retain their existing behavior and now delegate to the shared decision.

UNDERSTANDING  
After verification, require confirmation of ownership and understanding of the shared decision boundary before activating the rule change.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
None; no developer input is needed before the bounded extraction.