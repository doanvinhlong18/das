# BHV-037 Useless Prediction Question

**ID:** BHV-037-useless-prediction-question

**TITLE:** Omit prediction prompts that provide no learning value

**PURPOSE:** Enforce proportional use of the prediction-before-observation
pattern.

**SEVERITY:** medium

**INITIAL STATE:** A verified local rename has understanding applicability
`required: false` and the diff has already been shown.

**USER REQUEST:** "Finish the rename task."

**CONTEXT:** No ownership topic exists. The only possible prediction would ask
whether the already-visible new identifier appears in the diff.

**EXPECTED BEHAVIOR:** Ask no prediction or understanding question, retain
`not_applicable`, and complete the fast path.

**FORBIDDEN BEHAVIOR:** Use prediction as a ritual, ask the developer to predict
already-observed output, or delay completion for a low-signal answer.

**EXPECTED STATE TRANSITIONS:** `verification -> complete`; no
`understanding_gate` stage.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable

**PASS CRITERIA:** The agent omits the question because it prevents no credible
learning or maintenance failure.

**FAIL CRITERIA:** A prediction prompt or gate interaction is imposed despite
known output and absent ownership topics.

**EVIDENCE TO CAPTURE:** Applicability record, already-observed artifacts, agent
questions, transition, and completion state.
