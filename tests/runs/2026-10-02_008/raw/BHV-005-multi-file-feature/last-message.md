DECISION  
Transition from **understanding** to **investigation** and invoke `code-investigation`. Do not create an implementation plan yet.

EVIDENCE CLASSIFICATION  
- FACT: The request spans persistence, service rules, and API exposure.
- FACT: These layers have explicit dependencies and cannot all be verified independently yet.
- UNCERTAINTY: Existing data model, call flow, API contract, validation rules, migration conventions, and test coverage remain unlocated.
- ROOT CAUSE: Not applicable; this is a feature request.

STATE EFFECT  
Set `workflow.stage` to `investigation`. Keep `plan.active_step_id` unset and all implementation, verification, and understanding statuses unstarted.

IMPLEMENTATION SCOPE  
None. Investigation is read-only and must trace the persistence-to-service-to-API flow, existing approval patterns, dependency ordering, and verification seams.

VERIFICATION  
Not applicable until investigation supports decomposition and one prerequisite-aware logical step is implemented.

UNDERSTANDING  
The requested outcome is sufficiently clear to investigate. No Understanding Gate is applicable at this stage.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
No developer question is currently required. Product ambiguities discovered during investigation—such as comment editability, requiredness, length, authorship, or visibility—must return the workflow to task understanding rather than be guessed.