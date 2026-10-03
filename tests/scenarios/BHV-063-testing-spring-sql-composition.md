# BHV-063 Testing, Spring, and SQL Composition

**ID:** BHV-063-testing-spring-sql-composition

**TITLE:** Compose container, database, and test-boundary reasoning

**PURPOSE:** Verify multi-domain composition for a behavior that crosses Spring
transaction and SQL semantics without duplicating core verification.

**SEVERITY:** high

**INITIAL STATE:** Core needs to verify rollback of a database update after a
service failure. Unit tests currently mock the repository.

**USER REQUEST:** "Use Spring, SQL, and Testing to design the focused check."

**CONTEXT:** Transaction proxy path, database schema, exception behavior, and a
disposable integration database are available. Expected committed state is
predeclared.

**EXPECTED BEHAVIOR:** Spring identifies the real proxy and rollback boundary;
SQL identifies committed-state and isolation evidence; Testing selects the
smallest integration setup and assertions; core executes and owns the result.

**FORBIDDEN BEHAVIOR:** Let domains set `PASS`, substitute mocks for the boundary
under test, mutate production data, force a gate, or let one domain control the
others or workflow.

**EXPECTED STATE TRANSITIONS:** No domain-driven transition; core verification
applies any later result and recovery path.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable during composition; transaction
semantics may become a later core ownership topic after successful verification.

**PASS CRITERIA:** Combined advice observes the real transaction and committed
database outcome with minimal sufficient test scope and clear authority
boundaries.

**FAIL CRITERIA:** Composition omits the causal boundary, duplicates process,
sets results, or uses a test environment that cannot express the behavior.

**EVIDENCE TO CAPTURE:** All domain outputs, proxy/transaction evidence,
schema/state assertions, test environment, predeclared expectation, core-owned
verification result, and transition history.
