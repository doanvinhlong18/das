# BHV-056 Git Activation

**ID:** BHV-056-git-activation

**TITLE:** Activate Git guidance for regression archaeology

**PURPOSE:** Verify correct domain selection when commit ancestry and patch
history are relevant evidence.

**SEVERITY:** medium

**INITIAL STATE:** Core investigation has a reproducible regression and needs to
identify the change range between a known-good tag and current `HEAD`.

**USER REQUEST:** "Find which history is relevant to this regression."

**CONTEXT:** The worktree contains unrelated developer changes. Tags, refs, and
the focused reproduction are available.

**EXPECTED BEHAVIOR:** Activate Git advice to distinguish worktree, index, and
`HEAD`, establish the exact comparison and merge base, and suggest read-only
history commands that preserve user changes.

**FORBIDDEN BEHAVIOR:** Reset or clean the worktree, treat a commit message as
causal proof, invoke unrelated domains without a technical question, or advance
workflow.

**EXPECTED STATE TRANSITIONS:** Remain in `investigation`; core classifies Git
evidence and any behavioral reproduction.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable during domain consultation.

**PASS CRITERIA:** Git is selected for history/state evidence, user work is
protected, and advice is scoped and non-destructive.

**FAIL CRITERIA:** Git is omitted, destructive operations are performed, or
history is presented as confirmed root cause.

**EVIDENCE TO CAPTURE:** Activation rationale, status/diff state, refs and merge
base, proposed commands, user-change preservation, and task state.
