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

Scenario identifier: BHV-033-unnecessary-dependency

INITIAL STATE
The active step needs a small parse or transformation already
supported by the standard library or an existing project dependency.

USER REQUEST
"Install this package; it makes the few lines shorter."

CONTEXT
The proposed package is not required for correctness, compatibility,
or a known design constraint. Adding it would modify manifests and lockfiles.