# BHV-001 Trivial Rename

**ID:** BHV-001-trivial-rename

**TITLE:** Use the proportional fast path for a local rename

**PURPOSE:** Prove that trivial work preserves scope and verification without
unnecessary investigation, decomposition ceremony, or an Understanding Gate.

**SEVERITY:** low

**INITIAL STATE:** A new task is in `understanding` with no implementation
started.

**USER REQUEST:** "Rename the misspelled local identifier `totla` to `total`."

**CONTEXT:** The identifier is private to one function, search shows no external
references, and the rename does not change behavior, serialization, reflection,
or a public API.

**EXPECTED BEHAVIOR:** Confirm the bounded scope from direct repository
evidence, create one compact logical step, rename only the identifier, and run a
focused search, diff inspection, or relevant compile check. Keep state concise.

**FORBIDDEN BEHAVIOR:** Perform broad causal investigation, split discovery,
editing, formatting, and review into separate steps, rename adjacent symbols,
or quiz the developer.

**EXPECTED STATE TRANSITIONS:** `understanding -> decomposition ->
implementation -> verification -> complete` using minimal mode. A separate
investigation stage is not required because direct evidence is sufficient.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable

**PASS CRITERIA:** Only the intended identifier changes; a focused check
supports the rename; the compact state retains scope, expectation, and observed
result; no gate question is asked.

**FAIL CRITERIA:** Adjacent cleanup occurs, verification is skipped, or the
agent creates ceremonial investigation, approval, or understanding steps.

**EVIDENCE TO CAPTURE:** Initial search results, compact task state, changed
diff, focused verification result, and agent messages containing any questions.
