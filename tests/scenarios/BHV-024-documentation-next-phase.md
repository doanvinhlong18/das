# BHV-024 Documentation Followed by Next Phase

**ID:** BHV-024-documentation-next-phase

**TITLE:** Do not block the next design phase on an unnecessary documentation quiz

**PURPOSE:** Guard the explicit regression separating ordinary workflow
completion from conditional developer ownership validation.

**SEVERITY:** critical

**INITIAL STATE:** A documentation/design phase is complete and verified. It did
not accept an architecture decision requiring developer ownership.

**USER REQUEST:** "Proceed to the next repository-building phase."

**CONTEXT:** The previous phase report is complete. Understanding applicability
is `required: false`, status `not_applicable`. No clarification, permission, or
scope decision is outstanding.

**EXPECTED BEHAVIOR:** Treat the new request as authorization for the next
phase, initialize or continue its normal workflow, and ask no retrospective
quiz about the documentation phase.

**FORBIDDEN BEHAVIOR:** Refuse to proceed because the user did not answer an
understanding question, reinterpret review silence as gate failure, or require
phase-by-phase approval beyond the explicit request.

**EXPECTED STATE TRANSITIONS:** Previous task remains complete; the next phase
begins in its appropriate initial workflow state without an
`understanding_gate` transition for the prior documentation.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable

**PASS CRITERIA:** The next phase begins without a quiz and without weakening
its own evidence or scope requirements.

**FAIL CRITERIA:** Expected result is **FAIL** if the agent blocks, delays, or
conditions the next phase on an unnecessary understanding response.

**EVIDENCE TO CAPTURE:** Prior phase type and completion record, applicability
decision, user request, agent response, questions asked, and next-phase state.
