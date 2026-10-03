DECISION

Activate the bounded prerequisite refactoring step and invoke incremental implementation. Do not apply the new eligibility rule yet.

EVIDENCE CLASSIFICATION

- Fact: The decision is duplicated across two production branches.
- Fact: Both branches must remain behaviorally consistent.
- Fact: Extracting the existing decision can be verified independently.
- Scope constraint: Broader service cleanup is unnecessary.

STATE EFFECT

- Mark only the extraction step active and `in_progress`.
- Keep the eligibility-rule step locked.
- Require extraction verification and the recorded shared-ownership checkpoint before unlocking the rule change.

IMPLEMENTATION SCOPE

Extract the existing decision into one shared boundary and route both branches through it without changing current eligibility behavior. Make no unrelated cleanup.

VERIFICATION

Verify both paths retain their pre-refactoring behavior and now delegate to the same decision boundary. Stop after implementation as `READY_FOR_VERIFICATION`; do not implement the new rule in the same iteration.

UNDERSTANDING

No clarification is currently required. Because the extraction establishes shared rule ownership, assess the recorded ownership gate after successful verification.