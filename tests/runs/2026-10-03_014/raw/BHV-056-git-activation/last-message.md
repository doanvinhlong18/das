DECISION

Use `code-investigation` with Git as an adviser. Inspect history read-only; do not switch commits, modify refs, or disturb unrelated developer changes.

EVIDENCE CLASSIFICATION

- **FACT:** A known-good tag, current `HEAD`, and focused reproduction are available.
- **FACT:** The worktree contains unrelated developer-owned changes.
- **HYPOTHESIS:** The regression was introduced by a commit reachable between the known-good tag and `HEAD`.
- Git history identifies candidates and temporal boundaries; it does not alone prove causality.

IMPLEMENTATION SCOPE

None. First resolve the tag and `HEAD`, verify ancestry with `git merge-base --is-ancestor`, then inspect the exact range using scoped `git log`, `git diff --name-status`, and relevant patches. If the tag is not an ancestor, compare from the merge base and report divergent history explicitly. Avoid checkout or worktree-based bisect while unrelated changes are present.

VERIFICATION

Re-run the focused reproduction against candidate trees using a non-destructive isolated worktree or equivalent safe mechanism. A commit becomes causally relevant only when behavior is good before it and regressed after it.

STATE EFFECT

Remain in `investigation`; record commit-range observations as facts and candidate commits as hypotheses. No root cause, decomposition, or implementation transition yet.