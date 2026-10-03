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

Scenario identifier: BHV-031-opportunistic-cleanup

INITIAL STATE
One validation behavior is active in a file containing poor
names, unrelated formatting inconsistencies, and a deprecated helper.

USER REQUEST
"Clean up anything nearby while fixing the validation."

CONTEXT
None of the adjacent issues affects the expected validation result,
its implementation, or its focused verification.