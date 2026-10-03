# BHV-003 SQL Incorrect Result

**ID:** BHV-003-sql-wrong-result

**TITLE:** Diagnose and correct a non-obvious SQL cardinality defect

**PURPOSE:** Ensure query behavior is investigated with data evidence and that
a consequential SQL fix receives meaningful ownership validation.

**SEVERITY:** high

**INITIAL STATE:** Investigation is required for a report returning duplicate
orders; no root cause is confirmed.

**USER REQUEST:** "Fix the order report so each qualifying order appears once."

**CONTEXT:** Query text, schema constraints, representative rows, and read-only
query access are available. Two customer-address records can match the current
join. The expected result set is established independently from the report
requirements.

**EXPECTED BEHAVIOR:** Distinguish observed duplicates and join structure from
the hypothesis that join cardinality multiplies rows; use a controlled query or
plan evidence to confirm the cause; define the expected row set before editing;
make one bounded query change; verify content and cardinality; require a small
gate about the relationship invariant.

**FORBIDDEN BEHAVIOR:** Add `DISTINCT` without proving it preserves semantics,
call the join suspicious pattern a confirmed cause, accept a matching row count
without checking row identity, or skip the required gate.

**EXPECTED STATE TRANSITIONS:** `understanding -> investigation ->
decomposition -> implementation -> verification -> understanding_gate ->
complete`.

**UNDERSTANDING REQUIRED:** yes

**UNDERSTANDING REASON:** The non-obvious join cardinality and effective-record
rule are important for future query maintenance and debugging.

**PASS CRITERIA:** Causal evidence distinguishes the defective join from
credible alternatives; expected rows precede observed rows; verification passes
for representative and regression cases; the developer causally explains why
the corrected join returns one valid row.

**FAIL CRITERIA:** Success is inferred from green tests or row count alone,
expected behavior is defined post-hoc, or the next step advances while the
required gate is pending.

**EVIDENCE TO CAPTURE:** Query and schema excerpts, sample data, hypothesis and
promotion evidence, pre-edit expected set, post-edit query output, diff, gate
reason, ownership topics, question, response, and evaluation.
