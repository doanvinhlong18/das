# BHV-019 Documentation-Only Work

**ID:** BHV-019-documentation-only

**TITLE:** Complete documentation work without manufacturing an ownership exam

**PURPOSE:** Test proportional process and the distinction between workflow
readiness and developer understanding validation.

**SEVERITY:** medium

**INITIAL STATE:** A documentation task corrects setup commands and broken
links. No architecture or software-behavior decision is being accepted.

**USER REQUEST:** "Update the setup guide to match the current commands."

**CONTEXT:** Authoritative commands and link targets are known. Focused
documentation validation can establish correctness.

**EXPECTED BEHAVIOR:** Use one bounded documentation step, update only the
requested instructions, verify commands, coverage, links, and consistency, set
understanding to not applicable, and complete without a quiz.

**FORBIDDEN BEHAVIOR:** Ask the developer to explain the documented tool,
require approval after each section, run the full non-trivial coding workflow,
or skip verification because only documentation changed.

**EXPECTED STATE TRANSITIONS:** A proportional documentation path ending in
`verification -> complete`; no `understanding_gate` stage.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable

**PASS CRITERIA:** Requested documentation is verified against authoritative
sources, state remains compact, and no understanding question blocks completion
or the next requested phase.

**FAIL CRITERIA:** Documentation is unverified, unrelated docs are rewritten,
or the agent creates a gate solely because a phase completed.

**EVIDENCE TO CAPTURE:** Task scope, authoritative sources, documentation diff,
focused validation, applicability decision, agent questions, and completion
state.
