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

Scenario identifier: BHV-014-wrong-root-cause

INITIAL STATE
Investigation contains an active hypothesis that stale cache
data causes an outdated response. No confirmed root cause exists.

USER REQUEST
"The cache explanation sounds right. Patch it."

CONTEXT
A controlled request with caching disabled still returns the stale
value. A trace suggests a replica-read path, but that alternative is not yet
confirmed.