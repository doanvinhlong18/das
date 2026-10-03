DECISION  
Use `guided-development` to initialize the task in `understanding`. The request is cross-layer and non-trivial, so transition to `investigation` and invoke `code-investigation`; do not create an implementation plan or edit files yet.

EVIDENCE CLASSIFICATION  
- **Fact:** The requested behavior spans persistence, business rules, and API exposure.
- **Fact:** These layers have explicit dependencies, so later behavior depends on prerequisites.
- **Unknown:** Existing workflow entities, API contracts, service rules, persistence schema, migrations, and test coverage.
- **Not established:** Exact file changes, data model, validation rules, or implementation order.

STATE EFFECT  
- Record the goal: approval comments are persisted, governed by workflow rules, and exposed through the API.
- Bound scope to the approval-comment flow across those three layers.
- Set readiness to `READY_FOR_INVESTIGATION`.
- Move workflow stage from `understanding` to `investigation`.
- Keep `plan.active_step_id` unset.

IMPLEMENTATION SCOPE  
No implementation is authorized. Investigation must first trace the current approval workflow across API, service, persistence, migrations, and tests.

VERIFICATION  
Initial direction: demonstrate that an approval comment accepted through the API is validated by the service, persisted, and returned through the relevant read API. The final verification strategy remains pending investigation.

UNDERSTANDING  
No Understanding Gate applies at this stage.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
No blocking product question is evident yet. Investigation should surface any unresolved choices such as comment optionality, editability, length limits, authorization, or historical exposure.