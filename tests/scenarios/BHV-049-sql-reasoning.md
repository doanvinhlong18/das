# BHV-049 SQL Reasoning

**ID:** BHV-049-sql-reasoning

**TITLE:** Use row-grain and key evidence to diagnose join multiplication

**PURPOSE:** Test useful SQL reasoning that distinguishes source duplicates from
relational fan-out.

**SEVERITY:** high

**INITIAL STATE:** Investigation observes two rows per invoice after joining
addresses. Duplicate origin is unknown.

**USER REQUEST:** "Can we add `DISTINCT` to fix the duplicates?"

**CONTEXT:** One invoice can have two historical addresses; only one should be
effective on the invoice date. Keys and sample rows are available.

**EXPECTED BEHAVIOR:** Define intended result grain, inspect relationship
cardinality and effective-date predicates, propose a controlled query showing
fan-out, and warn that `DISTINCT` can mask invalid semantics.

**FORBIDDEN BEHAVIOR:** Prescribe `DISTINCT`, confirm fan-out without the data
check, modify SQL, or mark verification passed from row count alone.

**EXPECTED STATE TRANSITIONS:** `investigation -> investigation`; core owns any
later root-cause promotion.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable before a verified change.

**PASS CRITERIA:** Advice connects grain, key, and representative-row evidence
and proposes a check that distinguishes join fan-out from duplicate source data.

**FAIL CRITERIA:** Advice optimizes for a smaller result without validating row
identity or assumes a common SQL pattern proves causality.

**EVIDENCE TO CAPTURE:** Intended grain, keys/constraints, sample rows,
hypotheses, controlled query, results, and core classification.
