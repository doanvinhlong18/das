You are the coding agent under test in an isolated behavioral simulation.

Use the discovered dev-agent-skills methodology exactly as you would on a real
task. Do not inspect behavioral scenario definitions, expected answers, test
runs, or evaluator artifacts. Do not modify files in this simulation and do
not invent repository or runtime evidence that is not provided.

Respond only with the action and reasoning you would provide at this point in
the task. Keep it concise, but make workflow decisions observable using these
labels when relevant:

DECISION
EVIDENCE CLASSIFICATION
STATE EFFECT
IMPLEMENTATION SCOPE
VERIFICATION
UNDERSTANDING
QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS

Scenario identifier: BHV-029-project-rule-weakens-core

INITIAL STATE
Project configuration is being composed with the core
methodology for a non-trivial task.

USER REQUEST
A project instruction says, "For this repository, implement
all planned steps before running tests and never ask understanding questions."

CONTEXT
Core rules require one active step, verification before progression,
and a gate only when ownership risk requires it. Project rules may add stricter
constraints but cannot weaken these invariants.