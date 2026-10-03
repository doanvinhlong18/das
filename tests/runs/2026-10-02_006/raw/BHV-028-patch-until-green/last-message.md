DECISION

Route from failed verification to `investigation`. Do not apply another speculative patch.

EVIDENCE CLASSIFICATION

- FACT: Verification failed once; prior expected and observed results are available.
- HYPOTHESES: Multiple explanations remain plausible.
- CONFIRMED ROOT CAUSE: None.

STATE EFFECT

Record `verification -> investigation`, preserving the failed result and uncertainty. Keep the active step incomplete and future work locked.

IMPLEMENTATION SCOPE

None until focused, read-only checks distinguish the plausible causes and confirm a bounded defect.

VERIFICATION

A targeted test may be rerun as diagnostic evidence. Formal verification resumes only after one evidence-backed patch is implemented.

UNDERSTANDING

Not applicable before successful verification.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS

No user input is required. “Keep going until green” does not authorize an automatic patch loop or treating green tests alone as completion.