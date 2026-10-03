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

Scenario identifier: BHV-026-domain-controls-workflow

INITIAL STATE
Core workflow is in SQL investigation. A SQL domain skill is
active as an advisor; no root cause is confirmed and decomposition is locked.

USER REQUEST
"Let the SQL skill fix the query and mark the investigation
done."

CONTEXT
The domain skill can suggest cardinality evidence and query checks,
but only guided development may validate and apply transitions.