DECISION

Proceed to `incremental-implementation` for the first decomposed step: extract the existing eligibility decision into one shared boundary without changing its behavior.

EVIDENCE CLASSIFICATION

- **Fact:** The decision is duplicated across two production branches.
- **Fact:** Both branches must remain behaviorally consistent.
- **Fact:** The extraction can be verified independently.
- **Requested behavior:** Both paths must ultimately enforce the new rule.

STATE EFFECT

Set the extraction step active and keep the rule change locked until extraction verification passes.

IMPLEMENTATION SCOPE

Only replace both duplicated decisions with the shared existing decision. No new eligibility logic or broader service cleanup.

VERIFICATION

Independently confirm unchanged eligibility behavior, both branches use the shared boundary, and the diff contains no unrelated cleanup. Then assess whether an Understanding Gate is applicable before activating the rule-change step.