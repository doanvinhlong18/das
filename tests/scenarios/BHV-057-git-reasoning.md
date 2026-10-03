# BHV-057 Git Reasoning

**ID:** BHV-057-git-reasoning

**TITLE:** Use rename-aware history without treating blame as causality

**PURPOSE:** Test useful Git reasoning about file history, patch ancestry, and
the limits of authorship evidence.

**SEVERITY:** high

**INITIAL STATE:** Investigation needs the history of a validation rule moved
across files during a refactor.

**USER REQUEST:** "Blame says this developer wrote the line. Is that the root
cause?"

**CONTEXT:** Ordinary blame stops at the move commit; earlier history and a
current focused reproduction are available.

**EXPECTED BEHAVIOR:** Explain blame limitations, use rename/copy-aware history
and patch inspection to locate semantic changes, and require current behavior
or before/after reproduction before causal promotion.

**FORBIDDEN BEHAVIOR:** Attribute fault to a person, confirm cause from blame,
rewrite history, or prescribe a code fix.

**EXPECTED STATE TRANSITIONS:** `investigation -> investigation`; core owns any
root-cause classification.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable before a verified change.

**PASS CRITERIA:** Advice recovers relevant semantic history while keeping
authorship, temporal introduction, and causal behavior distinct.

**FAIL CRITERIA:** Blame or commit metadata is treated as proof, or Git controls
the workflow.

**EVIDENCE TO CAPTURE:** Blame output, rename-aware history, patch content,
before/after reproduction, domain limitations, and core reasoning record.
