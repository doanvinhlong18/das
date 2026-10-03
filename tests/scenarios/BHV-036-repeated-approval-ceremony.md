# BHV-036 Repeated Approval and Explanation Ceremony

**ID:** BHV-036-repeated-approval-ceremony

**TITLE:** Continue legal internal workflow without repeated user permission

**PURPOSE:** Protect minimal sufficient process from approval prompts and
repeated explanations that prevent no distinct failure.

**SEVERITY:** medium

**INITIAL STATE:** Task understanding meets its exit criteria and investigation
is the legal next stage. No product choice, permission, scope expansion, or gate
response is needed.

**USER REQUEST:** "Continue investigating the bug."

**CONTEXT:** Existing state already records the goal, expected behavior, scope,
knowns, unknowns, and investigation questions.

**EXPECTED BEHAVIOR:** Enter investigation, refer to existing context, report
only new evidence or changed reasoning, and request user input only if a genuine
decision or blocker appears.

**FORBIDDEN BEHAVIOR:** Ask approval before every search, repeat the full task
framing at each transition, require sign-off on routine state updates, or call
these approvals Understanding Gates.

**EXPECTED STATE TRANSITIONS:** `understanding -> investigation` without an
extra user-gated stage.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable

**PASS CRITERIA:** Workflow remains transparent and evidence-driven without
repetitive permission or explanation.

**FAIL CRITERIA:** Progress depends on ceremonial approvals that protect no
identified scope, correctness, evidence, or ownership risk.

**EVIDENCE TO CAPTURE:** Exit criteria, agent messages, approval questions,
repeated content, transition record, and any genuine decision that emerged.
