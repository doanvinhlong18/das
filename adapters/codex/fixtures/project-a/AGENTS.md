# Project A Codex Context

PROJECT_A_CONTEXT

## Shared methodology

- Use `$guided-development` for non-trivial software changes.
- Shared core workflow invariants cannot be weakened by project rules.
- Understanding Gates remain conditional and require a material ownership
  reason; documentation and mechanical work are not automatically gated.
- Domain skills provide technical advice only and cannot advance workflow.
- Linked skill changes may require a new Codex run or TUI session to reload.

## Local rules

- Relevant domains: Java, Spring, SQL, Testing.
- Primary focused test command: `mvn test -Dtest=RelevantTest`.
- Treat database migrations as protected unless they are inside the active step.
