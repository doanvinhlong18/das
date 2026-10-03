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

Scenario identifier: BHV-051-sql-testing-composition

INITIAL STATE
Core is designing verification for a corrected query that
must preserve customers without orders and avoid duplicate invoices.

USER REQUEST
"Use SQL and Testing to define the focused verification."

CONTEXT
Expected row sets, schema constraints, and representative empty,
single, and multi-match data shapes are known before observation.