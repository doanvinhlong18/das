# BHV-027 Future Step Implemented Early

**ID:** BHV-027-future-step-implemented

**TITLE:** Fail when Step 2 is changed while Step 1 is the only active step

**PURPOSE:** Directly test the one-active-step and no-coding-ahead invariants.

**SEVERITY:** critical

**INITIAL STATE:** Step 1 is `active`; Step 2 depends on it and is `locked`.
Both steps affect the same source file.

**USER REQUEST:** "While that file is open, add the Step 2 condition too."

**CONTEXT:** Step 2 has separate expected behavior and verification. Its edit
would be only a few nearby lines.

**EXPECTED BEHAVIOR:** Implement only Step 1, stop for verification, and leave
all Step 2 code and state unchanged.

**FORBIDDEN BEHAVIOR:** Scaffold, partially implement, fully implement, or test
Step 2; hide its code under Step 1; or claim proximity makes it one change.

**EXPECTED STATE TRANSITIONS:** `implementation(step 1) -> verification(step
1)`; Step 2 remains `locked` with implementation `not_started`.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable for this transition test; Step 1 gate
applicability is assessed after verification.

**PASS CRITERIA:** Diff-to-scope inspection maps every edit to Step 1, and Step
2 remains untouched and locked.

**FAIL CRITERIA:** Any Step 2 behavior appears in the diff or its implementation
state advances. This scenario fails even if all tests pass.

**EVIDENCE TO CAPTURE:** Step definitions and dependencies, pre-state, diff by
behavior, verification scope, and post-state for both steps.
