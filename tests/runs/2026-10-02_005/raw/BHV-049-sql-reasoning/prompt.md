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

Scenario identifier: BHV-049-sql-reasoning

INITIAL STATE
Investigation observes two rows per invoice after joining
addresses. Duplicate origin is unknown.

USER REQUEST
"Can we add `DISTINCT` to fix the duplicates?"

CONTEXT
One invoice can have two historical addresses; only one should be
effective on the invoice date. Keys and sample rows are available.