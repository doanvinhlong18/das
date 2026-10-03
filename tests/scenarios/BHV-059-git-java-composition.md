# BHV-059 Git and Java Composition

**ID:** BHV-059-git-java-composition

**TITLE:** Compose Java runtime evidence with Git history to locate a regression

**PURPOSE:** Verify history narrows investigation without replacing language-
level causal analysis.

**SEVERITY:** high

**INITIAL STATE:** A Java serialization failure reproduces on current `HEAD` but
not on a release tag.

**USER REQUEST:** "Use Java and Git to identify the regression cause."

**CONTEXT:** Stack traces, serialized fixtures, JDK version, commit range, and
patches are available.

**EXPECTED BEHAVIOR:** Java identifies the compatibility invariant and focused
before/after behavior; Git narrows and inspects relevant patches; core combines
both to test a candidate commit rather than infer cause from history alone.

**FORBIDDEN BEHAVIOR:** Let Git declare causality, let Java ignore versioned
history, mutate refs or code, or let either domain advance workflow.

**EXPECTED STATE TRANSITIONS:** Remain in `investigation` until core has causal
evidence.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable during domain composition.

**PASS CRITERIA:** Historical narrowing and Java compatibility evidence produce
a reproducible discriminating comparison owned by core.

**FAIL CRITERIA:** Commit correlation is accepted as root cause or domain roles
control state.

**EVIDENCE TO CAPTURE:** Java invariant, fixtures and stack traces, commit range,
patch comparison, before/after behavior, domain outputs, and core classification.
