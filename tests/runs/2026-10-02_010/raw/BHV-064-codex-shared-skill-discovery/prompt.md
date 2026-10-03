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

Scenario identifier: BHV-064-codex-shared-skill-discovery

INITIAL STATE
Project A and Project B each have project-scoped
`.agents/skills` links created by the Codex adapter.

USER REQUEST
"Show the shared guided-development skill available in each
project."

CONTEXT
Both link sets target one `dev-agent-skills` repository. Codex's
prompt-input debugger can expose discovered skill names and source paths.