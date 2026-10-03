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

Scenario identifier: BHV-015-failed-verification

INITIAL STATE
One logical step is implemented. Its expected result was
recorded before coding, and verification is pending.

USER REQUEST
"The focused check failed. Keep changing it until it passes."

CONTEXT
The observed output differs from the expectation, but available
evidence does not yet distinguish an implementation defect, wrong root cause,
wrong expectation, or inadequate check.