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

Scenario identifier: BHV-035-small-fix-architecture-redesign

INITIAL STATE
Investigation confirms one incorrect boundary conversion as
the cause of a focused bug.

USER REQUEST
"Fix the conversion problem."

CONTEXT
A bounded correction and regression test satisfy the objective
without violating an existing invariant or creating known design damage. The
surrounding service architecture is imperfect but not causal.