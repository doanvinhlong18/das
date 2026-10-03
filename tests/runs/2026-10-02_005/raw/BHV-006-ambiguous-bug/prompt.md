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

Scenario identifier: BHV-006-ambiguous-bug

INITIAL STATE
A new task is in `understanding`; the report says a result is
"wrong" without defining the desired outcome.

USER REQUEST
"The status filter is broken. Fix it."

CONTEXT
Current behavior can be observed, but two plausible interpretations
of archived records would produce different correct results. Repository evidence
does not establish which product behavior is intended.