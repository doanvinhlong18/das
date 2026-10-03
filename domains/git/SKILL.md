---
name: git
description: Provide advisory Git investigation guidance for working-tree state, diffs, staging, commit history, ancestry, blame, merges, rebases, conflicts, reflogs, and regression archaeology. Use during an active core workflow when repository history or Git state is evidence; do not use it to perform destructive operations, control workflow, or treat history as causal proof.
---

# Git Reasoning

## Purpose

Use Git state and history as technical evidence while protecting user work and
avoiding causal overclaims. Follow the shared advisory boundary in
[DOMAIN_SKILLS.md](../../docs/DOMAIN_SKILLS.md).

## Preconditions and Inputs

- A core skill supplies the bounded historical or repository-state question.
- Repository path, current worktree state, relevant refs/remotes, and task scope
  are available or explicitly unknown.
- Existing developer changes are treated as user-owned unless evidence shows
  they were created by the active iteration.

## Investigation Patterns

1. Distinguish `HEAD`, index, working tree, untracked files, and upstream state
   before interpreting a diff or proposing an operation.
2. Use focused `log`, `show`, `diff`, `blame`, `merge-base`, `reflog`, or
   `range-diff` evidence appropriate to the question.
3. Trace line/file history across renames and refactors when ordinary blame is
   insufficient.
4. Separate temporal introduction from causal responsibility: a commit can
   introduce a line without proving the root cause of current behavior.
5. For branches and merges, establish ancestry and patch differences rather
   than relying on branch names or visual order.
6. For conflicts, identify both sides' behavioral intent and current expected
   behavior before recommending a resolution.

## Important Evidence Sources

- `git status`, scoped working-tree and staged diffs, and untracked-file list;
- commit objects, parent relationships, tags, merge bases, and branch refs;
- file and line history with rename/copy awareness;
- reflog when local reference movement matters;
- remote tracking state after an explicit safe refresh when permitted;
- commit messages and review metadata as context, not authoritative behavior;
- current repository tests, source, and runtime evidence for causal validation.

## Common Failure Modes and Dangerous Assumptions

- `git blame` is treated as proof of authorship, intent, or root cause.
- A clean unstaged diff is assumed to mean the index or repository is clean.
- Branch names or local remote-tracking refs are assumed current.
- A commit message is assumed to match the effective code change.
- Rebase, reset, checkout, clean, force push, or conflict resolution is assumed
  safe without exact targets and worktree protection.
- Generated or vendored changes are mistaken for the logical source change.
- Historical correlation replaces present behavioral investigation.

## Verification Guidance

- Recheck `status` and scoped diffs after any core-authorized repository action.
- Verify the exact commits and merge base used in comparisons.
- Compare patch content and resulting tree, not only commit counts or hashes.
- For regression archaeology, reproduce behavior before and after a candidate
  change when practical; history alone does not confirm causality.
- For conflict resolutions, run the behavior-specific verification selected by
  the active core skill and inspect the final diff for lost intent.

## Useful Reasoning Questions

- Which tree is being examined: `HEAD`, index, working tree, or another ref?
- Are remote and local refs known to be current?
- Does this history show correlation, intent, or causal behavioral evidence?
- What user changes could this operation overwrite or obscure?
- Which exact patch or parent introduced the relevant behavior?
- How will the resulting tree be verified, beyond Git reporting success?

## Outputs and Exit Criteria

Return the relevant repository-state observations, safe read-only command
suggestions, historical hypotheses, limitations, risk warnings, and focused
follow-up evidence. Exit when the active core skill can use Git evidence safely
or the missing refs/history are clearly named.

## Allowed Actions

- Read Git status, diffs, objects, refs, logs, blame, and reflog.
- Suggest scoped non-destructive history and comparison commands.
- Identify destructive or worktree-risking operations before they occur.
- Compose through core with Java, Spring, SQL, Angular, or Testing advice.

## Forbidden Actions and State Effects

- Do not modify refs, index, worktree, commits, remotes, or configuration.
- Do not recommend destructive commands without core authorization, exact
  validated targets, and user-work protection.
- Do not call a commit the confirmed root cause from history alone.
- Do not control workflow, activate steps, waive verification, require a gate,
  or mark completion.
- Propose no direct task-state update.

## Composition Examples

- With Java or Angular, identify the introducing patch while the language or
  framework domain evaluates current behavior.
- With Testing, identify historical regression boundaries while Testing defines
  the focused reproduction that can establish causality.
- With any domain, treat commit metadata as contextual evidence and preserve
  current repository/runtime evidence as the behavioral source of truth.
