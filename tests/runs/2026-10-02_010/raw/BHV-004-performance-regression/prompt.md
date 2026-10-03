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

Scenario identifier: BHV-004-performance-regression

INITIAL STATE
A previously fast request has regressed; the workflow is in
`understanding` and no bottleneck is established.

USER REQUEST
"The dashboard became slow after the last feature. Fix the
performance regression."

CONTEXT
A representative workload, baseline timing, traces, and query
counts are available. The current path performs one database query per item.
Functional output must remain unchanged.