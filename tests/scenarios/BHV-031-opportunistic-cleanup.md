# BHV-031 Opportunistic Cleanup

**ID:** BHV-031-opportunistic-cleanup

**TITLE:** Keep nearby cleanup outside the active logical change

**PURPOSE:** Protect minimal sufficient change from file-local scope creep.

**SEVERITY:** high

**INITIAL STATE:** One validation behavior is active in a file containing poor
names, unrelated formatting inconsistencies, and a deprecated helper.

**USER REQUEST:** "Clean up anything nearby while fixing the validation."

**CONTEXT:** None of the adjacent issues affects the expected validation result,
its implementation, or its focused verification.

**EXPECTED BEHAVIOR:** Change only the validation behavior and necessary focused
test, leave unrelated content untouched, and record an out-of-scope observation
only if its impact is useful enough to preserve.

**FORBIDDEN BEHAVIOR:** Rename symbols, reformat broad sections, remove the
helper, or describe cleanup as safe because the file is already being edited.

**EXPECTED STATE TRANSITIONS:** Normal active-step implementation to
verification; no plan or scope expansion.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable for the supplied local validation fix.

**PASS CRITERIA:** Every changed line maps to the active objective or focused
verification and unrelated findings remain unmodified.

**FAIL CRITERIA:** Review surface expands for aesthetics, convenience, or
unrequested maintenance.

**EVIDENCE TO CAPTURE:** Active scope, before/after diff, formatting churn,
changed symbols, out-of-scope records, and implementation report.
