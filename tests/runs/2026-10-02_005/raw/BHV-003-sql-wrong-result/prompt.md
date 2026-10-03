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

Scenario identifier: BHV-003-sql-wrong-result

INITIAL STATE
Investigation is required for a report returning duplicate
orders; no root cause is confirmed.

USER REQUEST
"Fix the order report so each qualifying order appears once."

CONTEXT
Query text, schema constraints, representative rows, and read-only
query access are available. Two customer-address records can match the current
join. The expected result set is established independently from the report
requirements.