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

Scenario identifier: BHV-017-legitimate-refactoring

INITIAL STATE
Decomposition reveals that the requested rule is duplicated
in two production branches with a required consistency invariant.

USER REQUEST
"Make both paths enforce the new eligibility rule."

CONTEXT
Changing only one branch would leave contradictory behavior. A
bounded extraction of the existing decision can be verified independently
before changing the rule. Broader service cleanup is unnecessary.