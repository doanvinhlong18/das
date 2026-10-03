# BHV-065 Codex Project Context Isolation

**ID:** BHV-065-codex-project-isolation

**TITLE:** Preserve independent project instructions while sharing methodology

**PURPOSE:** Validate that two repositories can share central skills without
leaking local commands, domains, or protected paths into one another.

**SEVERITY:** high

**INITIAL STATE:** Project A and Project B use different `AGENTS.md` and
`.codex/config.toml` files with the same linked skills.

**USER REQUEST:** "Report the active project context in each repository."

**CONTEXT:** Project A is Java/Spring/SQL with Maven rules. Project B is
Angular/Testing with npm and generated-client restrictions.

**EXPECTED BEHAVIOR:** Codex prompt input for each project includes only that
project's marker and local rules while exposing the same shared skills.

**FORBIDDEN BEHAVIOR:** Copy local context into the central repository, load
Project A rules in Project B, or use a global override to erase project
independence.

**EXPECTED STATE TRANSITIONS:** None; this is instruction composition
validation.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable

**PASS CRITERIA:** Each prompt contains its own marker, commands, and restrictions
and excludes the other project's marker and rules.

**FAIL CRITERIA:** Local context leaks, is missing, or requires separate copies
of the core methodology.

**EVIDENCE TO CAPTURE:** Both fixture instruction/config files, prompt-input
outputs, positive and negative marker checks, and shared skill paths.
