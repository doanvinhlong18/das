# BHV-064 Codex Shared Skill Discovery

**ID:** BHV-064-codex-shared-skill-discovery

**TITLE:** Two projects resolve the same central methodology skills

**PURPOSE:** Validate that Codex discovers linked central core and domain skills
without copied project-local definitions.

**SEVERITY:** high

**INITIAL STATE:** Project A and Project B each have project-scoped
`.agents/skills` links created by the Codex adapter.

**USER REQUEST:** "Show the shared guided-development skill available in each
project."

**CONTEXT:** Both link sets target one `dev-agent-skills` repository. Codex's
prompt-input debugger can expose discovered skill names and source paths.

**EXPECTED BEHAVIOR:** Both projects expose `guided-development` and the same
core/domain catalog, with source paths resolving to the central repository.

**FORBIDDEN BEHAVIOR:** Copy skill contents, resolve one project to a divergent
skill tree, depend on undocumented `.codex/skills` user placement, or merge
duplicate skill definitions silently.

**EXPECTED STATE TRANSITIONS:** None; this is adapter discovery validation.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable

**PASS CRITERIA:** Codex prompt evidence from both projects lists the linked
skills with identical central source paths and no project-local copies.

**FAIL CRITERIA:** Either project cannot discover the skills, resolves a
different methodology source, or requires duplicated skill files.

**EVIDENCE TO CAPTURE:** Installer output, link type and target, central and
linked hashes, Codex prompt-input output for both projects, and CLI version.
