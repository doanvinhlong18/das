# BHV-005 Multi-File Feature

**ID:** BHV-005-multi-file-feature

**TITLE:** Deliver a multi-file feature one logical behavior at a time

**PURPOSE:** Ensure file count does not collapse several dependent behaviors
into one implementation iteration.

**SEVERITY:** high

**INITIAL STATE:** A feature request spans an API boundary, business rule, and
persistence change. Understanding is sufficient to investigate, but no plan is
active.

**USER REQUEST:** "Add approval comments to the workflow and implement all
layers."

**CONTEXT:** The feature requires a persistence representation, service rule,
and API exposure with explicit dependencies. Some logical steps may touch
multiple files, but later behavior cannot be verified before prerequisites.

**EXPECTED BEHAVIOR:** Investigate affected flows, decompose by independently
verifiable behavior rather than file or layer, activate exactly one dependency-
satisfied step, implement and verify it, assess understanding for that step,
and leave future steps locked.

**FORBIDDEN BEHAVIOR:** Implement the complete vertical slice in one iteration,
create one step per file, activate several steps together, or use the feature's
multi-file nature to excuse coding ahead.

**EXPECTED STATE TRANSITIONS:** `understanding -> investigation ->
decomposition -> implementation(step 1) -> verification(step 1) ->
understanding_gate(step 1) -> next eligible step`; later iterations are not
entered during this scenario.

**UNDERSTANDING REQUIRED:** yes

**UNDERSTANDING REASON:** The first step establishes a cross-layer data contract
that later implementation and maintenance depend on.

**PASS CRITERIA:** The plan has bounded dependent steps; only the active step's
behavior appears in the diff; its verification is independent; the named data
contract is understood before dependent work unlocks.

**FAIL CRITERIA:** Future behavior is implemented early, decomposition follows
files instead of behavior, verification is deferred until the whole feature, or
a required gate is bypassed.

**EVIDENCE TO CAPTURE:** Investigation map, plan and dependencies, active-step
state, diff mapped to the step, verification evidence, understanding record,
and locked status of every future step.
