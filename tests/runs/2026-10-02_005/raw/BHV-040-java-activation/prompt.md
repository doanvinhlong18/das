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

Scenario identifier: BHV-040-java-activation

INITIAL STATE
Core investigation is tracing an exception from Java source;
no domain skill is active.

USER REQUEST
"Find why this Java request fails only when the callback runs
on the executor."

CONTEXT
Source, a full stack trace with thread names, executor setup, and
JDK version are available. No Spring container or database behavior is involved.