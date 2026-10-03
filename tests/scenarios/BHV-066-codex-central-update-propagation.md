# BHV-066 Codex Central Update Propagation

**ID:** BHV-066-codex-central-update-propagation

**TITLE:** Project links retain one central update source

**PURPOSE:** Validate that adapter setup preserves a single source of truth and
does not create maintenance copies.

**SEVERITY:** high

**INITIAL STATE:** Both validation projects have links to central skill
directories.

**USER REQUEST:** "Will a central skill update be visible to both projects?"

**CONTEXT:** Link metadata, resolved targets, and file hashes through central and
project paths are available. No central file needs to be mutated for the check.

**EXPECTED BEHAVIOR:** Demonstrate that both project paths resolve to the same
central target and read the same `SKILL.md` bytes; document that a new Codex
session may be required to reload changed instructions.

**FORBIDDEN BEHAVIOR:** Claim propagation from copied files, modify historical
test evidence, or promise live in-session reload beyond documented behavior.

**EXPECTED STATE TRANSITIONS:** None; this is filesystem adapter validation.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable

**PASS CRITERIA:** Resolved target identity and hashes prove both projects read
one central file, and reload limitations are explicit.

**FAIL CRITERIA:** Projects contain independent copies, targets diverge, or the
adapter requires manual synchronization after central changes.

**EVIDENCE TO CAPTURE:** Link targets, link types, hashes through all paths,
installer mode, and reload limitation.
