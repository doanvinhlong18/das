DECISION  
Activate the **behavior-preserving extraction** as the single implementation step. Do not change the eligibility rule yet.

EVIDENCE CLASSIFICATION  
- **Fact:** The decision is duplicated across two production branches.
- **Fact:** Both branches must remain behaviorally consistent.
- **Fact:** A shared decision boundary can be verified independently.
- **Out of scope:** Broader service cleanup is unnecessary.

STATE EFFECT  
Move from decomposition to implementation with only the extraction step active. Keep the new-rule step locked pending successful verification.

IMPLEMENTATION SCOPE  
Extract the existing eligibility decision into one shared boundary and route both branches through it without changing current behavior.

VERIFICATION  
Verify both paths preserve their existing outcomes and now use the shared decision. After PASS, assess whether an understanding gate applies before activating the rule-change step.