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

Scenario identifier: BHV-063-testing-spring-sql-composition

INITIAL STATE
Core needs to verify rollback of a database update after a
service failure. Unit tests currently mock the repository.

USER REQUEST
"Use Spring, SQL, and Testing to design the focused check."

CONTEXT
Transaction proxy path, database schema, exception behavior, and a
disposable integration database are available. Expected committed state is
predeclared.