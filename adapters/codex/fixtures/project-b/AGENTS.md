# Project B Codex Context

PROJECT_B_CONTEXT

## Shared methodology

- Use `$guided-development` for non-trivial software changes.
- Shared core workflow invariants cannot be weakened by project rules.
- Understanding Gates remain conditional and require a material ownership
  reason; documentation and mechanical work are not automatically gated.
- Domain skills provide technical advice only and cannot advance workflow.
- Linked skill changes may require a new Codex run or TUI session to reload.

## Local rules

- Relevant domains: Angular and Testing.
- Primary focused test command: `npm test -- --runInBand`.
- Generated client files must not be modified directly.
