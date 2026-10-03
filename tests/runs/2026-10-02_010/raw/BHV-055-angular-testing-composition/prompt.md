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

Scenario identifier: BHV-055-angular-testing-composition

INITIAL STATE
Core is planning verification for a route-driven component
whose observable must cancel stale requests and render the newest result.

USER REQUEST
"Use Angular and Testing to choose the smallest credible
check."

CONTEXT
Router parameters, stream code, HTTP mock capability, and expected
rendered behavior are known.