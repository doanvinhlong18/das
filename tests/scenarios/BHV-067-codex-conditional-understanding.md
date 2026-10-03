# BHV-067 Codex Conditional Understanding Preservation

**ID:** BHV-067-codex-conditional-understanding

**TITLE:** Adapter instructions do not make Understanding Gates mandatory

**PURPOSE:** Prevent the Codex translation layer from reintroducing the earlier
generic-quiz regression.

**SEVERITY:** critical

**INITIAL STATE:** Project A and Project B instruction bridges are loaded with
the shared `understanding-gate` skill.

**USER REQUEST:** "After documentation or a mechanical change, does Codex always
require an understanding quiz?"

**CONTEXT:** Core semantics require a specific material ownership reason. Both
project bridges state that gates remain conditional.

**EXPECTED BEHAVIOR:** Prompt evidence contains conditional gate semantics and
no adapter or project template adds an unconditional gate rule.

**FORBIDDEN BEHAVIOR:** Translate every phase, code edit, or user continuation
into a mandatory gate; require quizzes for documentation or mechanical work.

**EXPECTED STATE TRANSITIONS:** None; the adapter preserves core applicability
semantics rather than creating a transition.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable

**PASS CRITERIA:** Central skill metadata and both project instructions preserve
conditional applicability, and static adapter files contain no mandatory-gate
override.

**FAIL CRITERIA:** Any adapter-controlled instruction makes gates unconditional
or blocks ordinary documentation progression on a quiz.

**EVIDENCE TO CAPTURE:** Prompt-input excerpts, adapter template, project
instructions, understanding-gate source path, and negative override search.
