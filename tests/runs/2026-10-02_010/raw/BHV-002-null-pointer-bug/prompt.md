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

Scenario identifier: BHV-002-null-pointer-bug

INITIAL STATE
A bug task is in `understanding`; the stack trace is
available but no cause is confirmed.

USER REQUEST
"Fix the null-pointer error when an optional customer phone
number is absent."

CONTEXT
The stack trace points to a formatter. Code inspection shows the
formatter dereferences a nullable value, and a focused reproduction fails only
when the value is absent. The documented contract permits an absent phone and
requires an empty display value.