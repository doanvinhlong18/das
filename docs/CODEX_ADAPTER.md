# Codex Adapter

## Status

This adapter translates the portable `dev-agent-skills` methodology into the
current Codex skill and instruction mechanisms. It does not redefine core
workflow behavior.

Authoritative behavior was checked on 2026-10-02 against:

- Codex CLI `0.146.0-alpha.3` installed in this environment;
- [Build skills](https://learn.chatgpt.com/docs/build-skills.md);
- [Custom instructions with AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md.md);
- [Config basics](https://learn.chatgpt.com/docs/config-file/config-basic.md);
- [Advanced configuration](https://learn.chatgpt.com/docs/config-file/config-advanced.md).

## 1. Architecture

The central repository remains the only source of methodology definitions:

```text
dev-agent-skills/
  core/*/SKILL.md
  domains/*/SKILL.md
  adapters/codex/
```

Codex discovers links to those skill directories from a supported skill
location. Each consuming project keeps only its own instructions and host
configuration:

```text
project-a/
  AGENTS.md
  .codex/config.toml        # Optional Codex host settings
  .agents/skills/*          # Optional links when using project scope
```

For many unrelated repositories, install the central links once at user scope
and keep only `AGENTS.md` plus optional `.codex/config.toml` in each project.
For selective project use, create project-scoped links instead.

## 2. Skill discovery

Codex progressively discloses skills: it initially loads skill `name`,
`description`, and path, then reads the full `SKILL.md` when explicitly invoked
or when the request matches the description.

Current documented local locations are:

| Scope | Location |
| --- | --- |
| Repository | `.agents/skills` from the current directory up to repository root |
| User | `$HOME/.agents/skills` |
| Administrator | `/etc/codex/skills` on supported systems |
| System | Skills bundled with Codex |

Codex supports symlinked skill folders and follows their targets. If two
discovered skills have the same `name`, Codex does not merge them; both may
appear. Avoid shadow copies of central skills in projects.

The current environment also contains system-managed skills under a private
`.codex/skills` tree. The adapter does not depend on that implementation detail
because it is not the documented user/repository installation surface.

## 3. Instruction discovery

Codex builds the instruction chain once per run or TUI session:

1. In Codex home, load `AGENTS.override.md` when non-empty; otherwise load
   `AGENTS.md`.
2. From project root to the current directory, load at most one file per
   directory in this order: `AGENTS.override.md`, `AGENTS.md`, then configured
   fallback filenames.
3. Concatenate root-to-leaf; guidance nearer the current directory appears
   later and has instruction precedence.

Empty files are skipped. Combined project instruction content is bounded by
`project_doc_max_bytes`, 32 KiB by default. Start a new run after changing
instruction files because discovery occurs at session startup.

Use project `AGENTS.md` for:

- local build and verification commands;
- repository architecture and protected areas;
- relevant domain skills;
- project-specific restrictions and evidence sources;
- a concise bridge stating that shared core invariants remain authoritative.

Do not copy the core methodology into `AGENTS.md`. The project file specializes
context; it does not replace the linked skills.

## 4. Configuration and precedence

User Codex configuration lives in `~/.codex/config.toml`. Trusted repositories
may add `.codex/config.toml`; Codex walks from project root to the current
directory and the closest project value wins.

Documented configuration precedence, highest first:

1. CLI flags and `--config` overrides;
2. trusted project `.codex/config.toml` files, closest first;
3. the selected `$CODEX_HOME/<profile>.config.toml` profile;
4. user `~/.codex/config.toml`;
5. cloud-managed defaults;
6. system configuration;
7. built-in defaults.

Project `.codex` layers are ignored when the project is untrusted. Relative
paths in project config resolve from the containing `.codex` directory.

Keep methodology semantics out of `config.toml`. Use it for Codex host settings
such as sandbox defaults, MCP, hooks, model defaults, and instruction discovery
limits. Neither configuration precedence nor a closer `AGENTS.md` grants
permission to weaken core workflow invariants.

## 5. Adapter responsibility

The adapter:

- exposes central core and domain skills through supported links;
- provides a concise project-instruction bridge;
- documents Codex discovery and precedence;
- validates link targets, project isolation, and prompt visibility;
- preserves project-local context outside the central repository.

The adapter must not redefine or weaken:

- workflow and transition semantics;
- evidence classification or investigation requirements;
- one-step incremental implementation;
- expected-versus-observed verification;
- conditional Understanding Gate applicability;
- scope and minimality policies.

Codex instruction precedence is prompt-based, not a hard policy engine. The
bridge explicitly rejects weakening project rules, and behavioral scenarios
test the boundary, but a future hook or state validator may be needed for
mechanical enforcement.

## 6. Installation

### User scope

Install links once for all repositories:

```powershell
powershell -ExecutionPolicy Bypass -File adapters\codex\scripts\install.ps1 `
  -Scope User
```

The destination is `%USERPROFILE%\.agents\skills` on Windows when `HOME` is
unset. No global `AGENTS.md` is modified.

### Project scope

Expose the methodology only to one repository:

```powershell
powershell -ExecutionPolicy Bypass -File adapters\codex\scripts\install.ps1 `
  -Scope Project `
  -ProjectRoot D:\work\project-a
```

Then adapt [project-AGENTS.template.md](../adapters/codex/templates/project-AGENTS.template.md)
as the project's `AGENTS.md`. Optional Codex host settings can start from
[project-config.template.toml](../adapters/codex/templates/project-config.template.toml).

The installer never overwrites an existing directory or a link with a different
target. On Windows, `Auto` first attempts a directory symbolic link and falls
back to a junction. Junctions require local filesystem targets; use a symbolic
link for network or cross-platform locations.

Central updates are visible through links without reinstalling. Restart Codex
if an updated skill is not reflected in an existing session.

## 7. Project overrides

A project may add stricter validation, protected paths, technology versions,
commands, and domain relevance. It may not:

- skip core investigation or verification;
- implement multiple logical steps at once;
- make every task require an Understanding Gate;
- waive a gate that core applicability requires;
- authorize domain skills to change workflow state;
- redefine success after observing output.

When project guidance conflicts with a core invariant, surface the conflict and
retain the core invariant. A project may explicitly change its product scope or
expected behavior, but normal reasoning and transition requirements still
apply.

## 8. Windows behavior

- `%USERPROFILE%` is used when `HOME` is missing; this environment has that
  exact condition.
- Directory symbolic links can require Developer Mode or elevated permission.
- The installer falls back to NTFS junctions without copying skill content.
- Junctions may be unsuitable for network shares or non-NTFS destinations.
- PowerShell execution policy may require `-ExecutionPolicy Bypass` for the
  local script.
- Do not use copied skills as the normal fallback: copies stop central updates
  from propagating and create divergent sources of truth.

## 9. Limitations

- Project `.codex/config.toml` is ignored until the project is trusted.
- `AGENTS.md` and skill behavior are instruction-based; they cannot guarantee
  enforcement against every model failure.
- Codex budgets the initial skill metadata list. Very large skill collections
  may have descriptions shortened or some skills omitted with a warning.
- Duplicate skill names are not merged and can create ambiguous selection.
- Skill and instruction changes may require a new session to become visible.
- This adapter does not install plugins, edit global user configuration, or
  modify unrelated repositories automatically.

## 10. Validation status

Validation evidence belongs to immutable focused test runs under `tests/runs/`.
Use these labels precisely:

- **DESIGNED:** behavior is documented but not configured or observed.
- **CONFIGURED:** files and links exist in a validation or consuming project.
- **VALIDATED:** current Codex tooling observed the expected discovery or
  isolation behavior with recorded evidence.
- **NOT VALIDATED:** no sufficient observation exists.

Do not claim broad Codex integration from filesystem inspection alone. The
focused adapter run validates only the cases and environment named in its
metadata; full behavioral regression remains separate.

Current Phase 11 status:

- **DESIGNED:** discovery, precedence, adapter boundaries, Windows setup, and
  project composition are documented here.
- **CONFIGURED:** the installer configured two temporary Project-scope
  fixtures from the central repository. No user-level installation or
  unrelated repository was modified.
- **VALIDATED:** focused run
  [`2026-10-02_003`](../tests/runs/2026-10-02_003/summary.md) passed scenarios
  `BHV-064` through `BHV-069` using Codex CLI `0.146.0-alpha.3` and actual
  `codex debug prompt-input` output.
- **NOT VALIDATED:** live model adherence, user-scope installation in the
  developer's real home directory, and effective trusted-project config
  precedence were not exercised. The latter is documented from the current
  Codex manual but is not exposed by `prompt-input`.

Full-suite simulation runs `2026-10-02_009` (pre-fix) and `2026-10-02_010` (post-fix) leave `BHV-064`, `065`, `067`, `068` and `069` INCONCLUSIVE and `BHV-066` INCONCLUSIVE after the reload caveat was added, because a simulated answer cannot show link or prompt-input evidence. Run 003 remains the only adapter validation evidence.

Runs `2026-10-02_001` and `2026-10-02_002` are retained as immutable pre-fix
evidence. Run 001 found a validator strict-mode error. Run 002 completed but
independent review found a false-positive collision assertion; run 003 is the
post-fix validation.
