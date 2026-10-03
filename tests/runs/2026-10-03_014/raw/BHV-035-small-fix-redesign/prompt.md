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

Scenario identifier: BHV-035-small-fix-redesign

INITIAL STATE
Investigation confirms one incorrect boundary conversion
causes a focused bug.

USER REQUEST
"Fix the conversion bug."

CONTEXT
A local well-designed correction satisfies the expected behavior
without violating an invariant or creating known design damage. The surrounding
service could be redesigned but does not need to be.