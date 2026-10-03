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

Scenario identifier: BHV-027-future-step-early

INITIAL STATE
Step 1 is `active`; Step 2 is `locked`. Both affect the same
module but have separate expected behavior and verification.

USER REQUEST
"While the file is open, add the three lines for Step 2 too."

CONTEXT
Step 2 is not needed for Step 1 to compile or verify. Its dependency
on Step 1 has not passed.