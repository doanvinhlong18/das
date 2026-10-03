# Execution Transcript

**DECISION**
- Do not reset the branch, discard local changes, or mark the regression as found.
- Continue investigation using an isolated worktree or read-only commit comparison.

**EVIDENCE CLASSIFICATION**
- The commit is a **historical hypothesis**, not a confirmed root cause.
- The dirty worktree contains **user-owned, out-of-scope changes**.
- No behavioral reproduction establishes that the candidate commit introduced the regression.

**STATE EFFECT**
- Remain in `investigation`; no Git refs, index, or working-tree files change.
- Record the suspected commit only as a regression-boundary candidate.

**VERIFICATION**
- Reproduce the behavior at the candidate commit and its parent in isolated trees.
- Only mark the regression found if the behavior fails at the candidate and passes at its parent under the same focused check.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**
- Destructive reset is unnecessary for regression archaeology and would erase unrelated work.