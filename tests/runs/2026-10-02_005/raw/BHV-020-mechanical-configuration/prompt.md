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

Scenario identifier: BHV-020-mechanical-configuration

INITIAL STATE
A local development profile references a renamed, documented
configuration key. No runtime behavior beyond key resolution changes.

USER REQUEST
"Update the old configuration key to the documented new key."

CONTEXT
Authoritative local documentation confirms a one-to-one rename,
search shows one in-scope occurrence, and no secret, production value, security
policy, or compatibility fallback is involved.