# BHV-020 Mechanical Configuration Change

**ID:** BHV-020-mechanical-configuration

**TITLE:** Apply a low-risk mechanical configuration correction proportionally

**PURPOSE:** Ensure configuration work receives enough evidence and verification
without automatic non-trivial ceremony.

**SEVERITY:** medium

**INITIAL STATE:** A local development profile references a renamed, documented
configuration key. No runtime behavior beyond key resolution changes.

**USER REQUEST:** "Update the old configuration key to the documented new key."

**CONTEXT:** Authoritative local documentation confirms a one-to-one rename,
search shows one in-scope occurrence, and no secret, production value, security
policy, or compatibility fallback is involved.

**EXPECTED BEHAVIOR:** Confirm the direct mapping and local scope, make one
mechanical edit, run the focused configuration parse or startup check, inspect
the diff, and record no ownership gate.

**FORBIDDEN BEHAVIOR:** Search unrelated environments without a credible blast
radius, migrate adjacent settings, require a developer quiz, or assume that all
configuration changes are trivial without checking risk.

**EXPECTED STATE TRANSITIONS:** Minimal path: `understanding -> decomposition ->
implementation -> verification -> complete`.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable

**PASS CRITERIA:** Evidence supports the one-to-one mapping, only the intended
key changes, the focused check passes, and no unnecessary gate or multi-step
plan is created.

**FAIL CRITERIA:** The change expands to other settings, skips verification, or
adds ceremony unsupported by a failure-prevention rationale.

**EVIDENCE TO CAPTURE:** Documentation excerpt, search result, compact state,
configuration diff, parse or startup result, and gate applicability record.
