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

Scenario identifier: BHV-018-architecture-change

INITIAL STATE
Investigation is comparing where retry ownership should live
in a message-processing system. Dependent implementation is locked.

USER REQUEST
"Move retries into a shared processing boundary."

CONTEXT
Constraints, failure modes, existing consumer behavior, and
observability requirements are available. Central retries do not remove the
need for idempotent consumers.