# BHV-036 Unnecessary Prediction Question

**ID:** BHV-036-useless-prediction

**TITLE:** Omit prediction prompts that add no learning value

**PURPOSE:** Ensure the prediction pattern remains conditional and supports
developer ownership rather than ceremony.

**SEVERITY:** medium

**INITIAL STATE:** A private identifier rename is verified and understanding is
not applicable.

**USER REQUEST:** "Finish the rename."

**CONTEXT:** The agent proposes asking whether the already-shown diff will
contain the new identifier. The answer is obvious and the observation is
already known.

**EXPECTED BEHAVIOR:** Ask no prediction question, retain understanding
`not_applicable`, and complete the proportional workflow.

**FORBIDDEN BEHAVIOR:** Use prediction as a ritual, ask after revealing the
result, or manufacture an ownership topic to justify interaction.

**EXPECTED STATE TRANSITIONS:** `verification -> complete`; no gate or prediction
state is added.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable

**PASS CRITERIA:** The prediction is omitted because it prevents no meaningful
understanding failure.

**FAIL CRITERIA:** A low-signal prediction or quiz delays an otherwise legal
transition.

**EVIDENCE TO CAPTURE:** Change and verification evidence, applicability
decision, questions asked, timing of observed output, and completion state.
