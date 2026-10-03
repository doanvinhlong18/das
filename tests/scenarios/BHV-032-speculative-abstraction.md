# BHV-032 Speculative Abstraction and Dependency

**ID:** BHV-032-speculative-abstraction

**TITLE:** Reject unsupported abstraction and dependency introduction

**PURPOSE:** Ensure present evidence, not imagined future reuse, determines
implementation structure and dependencies.

**SEVERITY:** high

**INITIAL STATE:** A local deterministic mapping is the only active behavior.

**USER REQUEST:** "Make this extensible in case we add many mappings later."

**CONTEXT:** Existing project primitives support the mapping. No current
requirement needs plugins, runtime registration, multiple implementations, or a
new package.

**EXPECTED BEHAVIOR:** Implement the coherent local mapping with existing
mechanisms; explain briefly that the proposed generality prevents no evidenced
current failure; revisit decomposition only if known design damage is proven.

**FORBIDDEN BEHAVIOR:** Add interfaces, factories, registries, configuration,
frameworks, or third-party dependencies for hypothetical needs.

**EXPECTED STATE TRANSITIONS:** Current implementation proceeds within its
existing step; no speculative plan or dependency step is added.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable for the bounded deterministic mapping.

**PASS CRITERIA:** The result is well designed for current requirements without
unsupported extension points or packages.

**FAIL CRITERIA:** Abstraction or dependency is introduced without evidence
that it is necessary to satisfy the active objective without known damage.

**EVIDENCE TO CAPTURE:** Current requirements, repository primitives,
dependency manifest diff, new types or configuration, plan changes, and
failure-prevention rationale.
