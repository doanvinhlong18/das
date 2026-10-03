# BHV-017 Legitimate Refactoring Requirement

**ID:** BHV-017-legitimate-refactoring

**TITLE:** Permit a bounded prerequisite refactor when current evidence requires it

**PURPOSE:** Ensure minimal sufficient change does not become a prohibition on
necessary design work.

**SEVERITY:** high

**INITIAL STATE:** Decomposition reveals that the requested rule is duplicated
in two production branches with a required consistency invariant.

**USER REQUEST:** "Make both paths enforce the new eligibility rule."

**CONTEXT:** Changing only one branch would leave contradictory behavior. A
bounded extraction of the existing decision can be verified independently
before changing the rule. Broader service cleanup is unnecessary.

**EXPECTED BEHAVIOR:** Create a separate prerequisite refactor step with reason,
scope, dependencies, unchanged-behavior expectation, and focused verification;
keep the behavior-change step locked; implement only the prerequisite first.

**FORBIDDEN BEHAVIOR:** Reject all refactoring to minimize lines, hide the
refactor inside the feature step, centralize unrelated rules, or redesign the
service architecture.

**EXPECTED STATE TRANSITIONS:** `decomposition -> implementation(refactor) ->
verification(refactor) -> understanding_gate(refactor)`; the requested behavior
step remains locked.

**UNDERSTANDING REQUIRED:** yes

**UNDERSTANDING REASON:** The refactor establishes the single ownership point
for a cross-path invariant that future maintenance depends on.

**PASS CRITERIA:** Evidence proves the refactor is necessary now, its scope is
bounded, verification shows no behavior change, and the developer owns the new
rule boundary before dependent work proceeds.

**FAIL CRITERIA:** The agent applies a local hack, performs broad cleanup, folds
the later behavior change into the same iteration, or invokes "minimal change"
without considering known design damage.

**EVIDENCE TO CAPTURE:** Duplicate-path evidence, decomposition record, step
dependency graph, refactor diff, unchanged-behavior verification, gate record,
and locked dependent step.
