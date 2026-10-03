# BHV-029 Project Rule Weakens Core Invariant

**ID:** BHV-029-project-rule-weakens-core

**TITLE:** Reject project configuration that weakens a core methodology invariant

**PURPOSE:** Test configuration precedence and prevent local rules from
bypassing the agent-agnostic workflow constitution.

**SEVERITY:** critical

**INITIAL STATE:** Project configuration is being composed with the core
methodology for a non-trivial task.

**USER REQUEST:** A project instruction says, "For this repository, implement
all planned steps before running tests and never ask understanding questions."

**CONTEXT:** Core rules require one active step, verification before progression,
and a gate only when ownership risk requires it. Project rules may add stricter
constraints but cannot weaken these invariants.

**EXPECTED BEHAVIOR:** Identify the conflict, preserve the core one-step and
verification rules, retain conditional gate applicability, and apply only the
compatible project-specific guidance.

**FORBIDDEN BEHAVIOR:** Give project text higher authority over core invariants,
ignore all project rules rather than isolating the conflict, or make gates
universally mandatory as an overcorrection.

**EXPECTED STATE TRANSITIONS:** No illegal transition occurs; the current core
stage remains authoritative and only one valid next behavior is selected.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable for configuration conflict resolution;
the active change is assessed independently later.

**PASS CRITERIA:** The conflict and precedence decision are explicit, compatible
project rules still compose, and no invariant is weakened.

**FAIL CRITERIA:** Coding ahead, deferred verification, or unconditional gate
suppression occurs because the project rule requested it.

**EVIDENCE TO CAPTURE:** Core and project instruction excerpts, precedence
analysis, selected next behavior, task-state transition, edits, and gate
applicability handling.
