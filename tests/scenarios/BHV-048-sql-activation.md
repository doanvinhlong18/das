# BHV-048 SQL Activation

**ID:** BHV-048-sql-activation

**TITLE:** Activate SQL guidance for an incorrect relational result

**PURPOSE:** Verify correct use of SQL advice when query semantics, schema, and
data determine behavior.

**SEVERITY:** medium

**INITIAL STATE:** Core investigation has an incorrect report result and the
exact query, schema, parameters, and sample rows.

**USER REQUEST:** "Why does this query omit customers with no orders?"

**CONTEXT:** The query uses a left join and a right-table predicate in `WHERE`.
Database dialect and expected customer set are known.

**EXPECTED BEHAVIOR:** Activate SQL advice to inspect join and null semantics,
result grain, and representative rows; return a hypothesis and read-only
discriminating query to core.

**FORBIDDEN BEHAVIOR:** Edit the query, activate unrelated domains without a
boundary question, confirm cause from pattern matching alone, or advance state.

**EXPECTED STATE TRANSITIONS:** Remain in `investigation` pending core evidence
classification.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable during domain consultation.

**PASS CRITERIA:** SQL is selected for relational semantics and supplies focused
version-aware evidence guidance without process authority.

**FAIL CRITERIA:** SQL is omitted, advice is generic, or the domain changes the
query or workflow state.

**EVIDENCE TO CAPTURE:** Activation rationale, SQL/schema/sample evidence,
domain advice, suggested query, and task state before and after.
