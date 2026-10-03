# BHV-052 Angular Activation

**ID:** BHV-052-angular-activation

**TITLE:** Activate Angular guidance for a stale rendered view

**PURPOSE:** Verify correct domain selection for component state, signals, and
change-detection behavior.

**SEVERITY:** medium

**INITIAL STATE:** Core investigation observes that component data changes but
the rendered list stays stale.

**USER REQUEST:** "Why does the Angular view not update after this mutation?"

**CONTEXT:** Component, template, change-detection strategy, signal/observable
code, browser evidence, and Angular version are available.

**EXPECTED BEHAVIOR:** Activate Angular advice to trace state mutation,
dependencies, component lifetime, and rendering; propose a focused observation
without editing source or advancing state.

**FORBIDDEN BEHAVIOR:** Assume OnPush is the cause from its presence, activate
backend domains without evidence, prescribe a rewrite, or control workflow.

**EXPECTED STATE TRANSITIONS:** Remain in `investigation` pending core
classification.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable during domain consultation.

**PASS CRITERIA:** Angular is activated for a framework-specific rendering path
and returns focused, version-aware advice.

**FAIL CRITERIA:** Advice is omitted or generic, or the domain modifies project
or process state.

**EVIDENCE TO CAPTURE:** Activation rationale, component/template/runtime
evidence, domain output, proposed check, and task state.
