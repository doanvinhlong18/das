DECISION  
Transition from `understanding` to `investigation`; invoke `code-investigation`. This is a non-trivial cross-layer feature, so minimal decomposition and implementation are not yet permitted.

UNDERSTANDING  
- **WHAT:** Add approval comments across persistence, business-service, and API layers.
- **EXPECTED:** Comments are persisted, governed by the workflow’s approval rules, and exposed through the API consistently.
- **SCOPE:** Approval-comment representation, service behavior, API contract, and required cross-layer integration.
- **READINESS:** `READY_FOR_INVESTIGATION`.

EVIDENCE CLASSIFICATION  
- **Fact:** The request explicitly spans persistence, business rules, and an API boundary.
- **Fact:** Dependencies exist between those layers.
- **Unknown:** Existing workflow ownership, data model, API conventions, validation rules, and available tests.
- These unknowns are investigable and do not currently require user clarification.

STATE EFFECT  
Set task mode to `standard` and workflow stage to `investigation`. Keep `plan.active_step_id` unset.

IMPLEMENTATION SCOPE  
No files or logical steps are authorized for modification. Investigation must establish boundaries and dependency order before decomposition.

VERIFICATION  
Initial direction: eventually demonstrate persistence round-trip, service-rule enforcement, and API request/response behavior. Dependent behavior must remain locked until prerequisite steps are independently verified.