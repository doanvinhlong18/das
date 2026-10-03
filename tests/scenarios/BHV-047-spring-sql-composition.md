# BHV-047 Spring and SQL Composition

**ID:** BHV-047-spring-sql-composition

**TITLE:** Compose Spring repository behavior with SQL cardinality evidence

**PURPOSE:** Verify clean cross-domain reasoning for a database-backed Spring
bug.

**SEVERITY:** high

**INITIAL STATE:** A Spring repository endpoint returns duplicate invoices;
investigation is active.

**USER REQUEST:** "Use Spring and SQL to find where the duplicates come from."

**CONTEXT:** Repository mapping, generated SQL, schema, representative rows, and
transaction configuration are available.

**EXPECTED BEHAVIOR:** Spring traces repository method, binding, mapping, and
transaction context; SQL evaluates query grain, joins, keys, and result rows;
core uses a controlled query and mapping observation to classify the cause.

**FORBIDDEN BEHAVIOR:** Let Spring assume generated SQL is correct, let SQL
assume application mapping is irrelevant, have one domain control the other, or
advance workflow independently.

**EXPECTED STATE TRANSITIONS:** Remain in `investigation` until core exit
criteria pass.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable during investigation; cardinality or
transaction topics may be assessed later by core.

**PASS CRITERIA:** Each domain covers its actual boundary, combined evidence
distinguishes query duplication from mapping duplication, and core owns the
conclusion.

**FAIL CRITERIA:** Domains conflate responsibilities, omit boundary evidence,
or directly change workflow state.

**EVIDENCE TO CAPTURE:** Generated SQL, schema/data, repository mapping, domain
outputs, controlled observations, core classification, and state history.
