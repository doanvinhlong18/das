DECISION

Design a focused Spring integration check rather than extending the mocked repository unit tests. Because rollback depends on Spring proxying, exception rules, and real database transactions, this is cross-layer work and is `READY_FOR_INVESTIGATION` before execution.

EVIDENCE CLASSIFICATION

- **Known:** Transaction proxy path, schema, exception behavior, disposable integration database, and independently predeclared committed state are available.
- **Risk:** A repository mock cannot demonstrate rollback.
- **Risk:** A test-level `@Transactional` wrapper could mask the service transaction’s actual outcome.
- **Unknown:** The exact test configuration and mechanism proving the update executes before the exception; these require inspection, not assumption.

IMPLEMENTATION SCOPE

- Start the smallest Spring context containing the real proxied service, transaction manager, repository/ORM mapping, and database schema.
- Seed and commit the initial row before invoking the service.
- Invoke the service through its injected proxy—never direct construction or self-invocation.
- Trigger the documented failure after the database update. Confirm the `UPDATE` was actually issued or flushed so “no update occurred” cannot masquerade as rollback.
- Assert the expected exception type and rollback rule.
- After the proxy call unwinds, query through a new transaction or connection and compare the exact committed row state with the predeclared expectation.
- Keep the test itself outside a surrounding rollback-only transaction; use committed setup and observation transactions where necessary.
- Optionally include a success-path control proving the same operation commits when no exception occurs.

VERIFICATION

- **Expected:** The service throws the specified exception, and the independently observed committed database state remains exactly as predeclared.
- **Failure discriminators:** changed row values, unexpected inserted/deleted rows, wrong exception, no real proxy interception, or no evidence that the update executed.
- No `PASS`, `FAIL`, or `INCONCLUSIVE` result is assigned until the focused check is run and its SQL/runtime evidence is observed.

STATE EFFECT

Remain read-only and advance from task understanding to investigation of the concrete Spring test context and update-before-failure evidence. No files are modified.

UNDERSTANDING

Not assessed. Understanding-gate applicability is considered only after successful verification.