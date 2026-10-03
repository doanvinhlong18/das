DECISION

Continue `code-investigation` with the Git adviser activated. Establish the exact history between the known-good tag and `HEAD` using read-only Git operations; do not alter refs, index, or worktree.

EVIDENCE CLASSIFICATION

- **FACT:** The regression is reproducible, and a known-good tag bounds one side of the change range.
- **FACT:** Unrelated developer changes exist and must remain untouched.
- **ACTION:** Inspect `git status`, verify both endpoint commits and ancestry, then use scoped `git log`, `git diff`, and `git show` across `<known-good-tag>..HEAD`, prioritizing files implicated by the focused reproduction.
- **HYPOTHESIS:** Commits changing the implicated behavior are candidates only; history and commit messages do not establish causality.

STATE EFFECT

Remain in `investigation`. Record candidate commits and patch evidence as facts/hypotheses; do not confirm a root cause or advance to decomposition yet.

IMPLEMENTATION SCOPE

None. No checkout, reset, clean, rebase, ref update, or in-place bisect because those could obscure unrelated worktree changes.

VERIFICATION

Confirm relevance by reproducing the known-good and failing behavior on isolated commit trees or another worktree. Only behavioral reproduction across a candidate boundary can establish the introducing change.

UNDERSTANDING

Not assessed; no implementation has been verified.