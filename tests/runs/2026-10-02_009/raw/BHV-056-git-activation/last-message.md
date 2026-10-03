**DECISION**  
Continue `code-investigation`; activate the `git` skill only as a technical adviser. Determine the regression-introducing commit across `<known-good-tag>..HEAD`.

**EVIDENCE CLASSIFICATION**  
- **FACT:** The regression has a focused reproduction.
- **FACT:** The known-good tag, current `HEAD`, and required refs are available.
- **FACT:** The current worktree contains unrelated developer changes.
- **UNKNOWN:** Which commit introduced the regression.
- Commit messages and diffs are candidate-selection evidence, not causal proof.

**STATE EFFECT**  
Remain in investigation. Do not advance to decomposition or implementation until history testing connects a commit to the behavior change.

**IMPLEMENTATION SCOPE**  
None. Preserve the dirty worktree. Inspect `git log <tag>..HEAD` and relevant diffs read-only, then run `git bisect` with the focused reproduction only in an isolated clean worktree or clone—not the developer’s current worktree.

**VERIFICATION**  
Confirm the bisect boundary by running the same reproduction on the candidate commit, its first-parent predecessor as applicable, the known-good tag, and `HEAD`. Record observed pass/fail results and inspect the candidate diff before declaring it relevant.

**UNDERSTANDING**  
Not applicable during investigation.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
No blocking question. Unrelated worktree changes remain untouched and out of scope.