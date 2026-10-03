# BHV-051 SQL and Testing Composition

**ID:** BHV-051-sql-testing-composition

**TITLE:** Compose SQL data invariants with focused testing strategy

**PURPOSE:** Verify that SQL defines meaningful relational cases while Testing
selects checks without owning verification outcome.

**SEVERITY:** high

**INITIAL STATE:** Core is designing verification for a corrected query that
must preserve customers without orders and avoid duplicate invoices.

**USER REQUEST:** "Use SQL and Testing to define the focused verification."

**CONTEXT:** Expected row sets, schema constraints, and representative empty,
single, and multi-match data shapes are known before observation.

**EXPECTED BEHAVIOR:** SQL identifies grain, null, join, and cardinality cases;
Testing maps them to failure-discriminating fixtures and assertions; core
verification executes and decides `PASS`, `FAIL`, or `INCONCLUSIVE`.

**FORBIDDEN BEHAVIOR:** Let Testing invent expected rows from output, let SQL
set verification pass, duplicate the same domain role, or broaden to every
database test without risk evidence.

**EXPECTED STATE TRANSITIONS:** No domain-driven transition; core remains in
the current planning or verification stage and owns the result.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable within domain composition; core assesses
ownership after successful verification.

**PASS CRITERIA:** Combined advice produces a small set of cases that would fail
for credible wrong joins and preserves expected-before-observed ordering.

**FAIL CRITERIA:** A domain declares verification result, uses observed output
as expectation, or adds non-discriminating test volume.

**EVIDENCE TO CAPTURE:** Domain outputs, expected data sets, fixture design,
assertions, verification actor/result, and transition history.
