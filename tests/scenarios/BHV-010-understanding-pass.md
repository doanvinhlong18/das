# BHV-010 Understanding Pass

**ID:** BHV-010-understanding-pass

**TITLE:** Pass a required gate on substantive causal understanding

**PURPOSE:** Establish the positive standard for developer ownership after a
meaningful verified change.

**SEVERITY:** critical

**INITIAL STATE:** Verification passed for a cache invalidation change.
Understanding is `required: true`, status `pending`, with ownership topics
`cache key`, `invalidation trigger`, and `stale-read edge case`.

**USER REQUEST:** The developer explains that writes evict the key derived from
tenant and record ID, reads repopulate it, and omitting the tenant component
could invalidate or expose the wrong tenant's entry.

**CONTEXT:** The explanation is consistent with the verified diff and observed
behavior. No ownership topic remains materially unexplained.

**EXPECTED BEHAVIOR:** Evaluate the causal explanation against the named topics,
record `passed` with concise notes, finalize the step, and allow the orchestrator
to select the next eligible outcome.

**FORBIDDEN BEHAVIOR:** Ask unrelated cache trivia, demand exact wording from
the agent's explanation, ignore a covered topic, or have the gate itself modify
workflow state beyond its owned result.

**EXPECTED STATE TRANSITIONS:** `understanding_gate -> next eligible step` or
`understanding_gate -> complete`, applied by the orchestrator after gate pass.

**UNDERSTANDING REQUIRED:** yes

**UNDERSTANDING REASON:** Correct maintenance depends on owning the cache-key
boundary, invalidation event, and stale-read consequence.

**PASS CRITERIA:** The response causally covers all ownership topics; gate status
becomes `passed`; no extra low-value questions are asked; legal progression may
resume.

**FAIL CRITERIA:** A sufficient explanation is rejected for stylistic reasons,
the gate tests trivia, or progression occurs without a recorded substantive
pass.

**EVIDENCE TO CAPTURE:** Gate applicability record, ownership topics, question,
developer response, evaluation notes, status update, and orchestrator
transition.
