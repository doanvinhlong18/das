**DECISION**
- `guided-development` stays the only workflow authority. Spring, SQL and Testing are advisers that feed one core decision.
- The request is to design a check, so this is not a trivial fast path. I'm staying in understanding/verification design and not implementing or editing anything.
- Recorded as not provided: Spring and Boot versions, database product and version, the service, repository and table names, and the exception types. I won't invent them. I'll bind them to the supplied transaction proxy path, schema and exception behavior when I write the test.

**EVIDENCE CLASSIFICATION**
- Facts provided:
  - The transaction proxy path, schema, exception behavior and a disposable integration database are available.
  - The expected committed state is predeclared.
  - Existing unit tests mock the repository.
- Limitation: the mocked unit tests cannot prove rollback. A mock has no transaction, proxy or SQL semantics, so those tests say nothing about committed state.
- Hypothesis, not proven: rollback occurs when the service fails after the update. The check is meant to confirm or refute this.

**IMPLEMENTATION SCOPE**
- One focused integration check, with no production changes. Test creation or editing is a later step and needs a valid active plan step.
- Spring advice (boundary):
  - Use the smallest real Spring context that includes the real transaction manager, the `@Transactional` proxy and the real repository against the disposable DB.
  - Call the service from outside the proxy. Self-invocation would not cross it.
  - Confirm the effective bean is the proxy and that the transaction manager is bound to the same data source.
  - Exercise the actual exception type. Default rollback applies to unchecked exceptions and `Error`. Checked exceptions need an explicit `rollbackFor`.
  - Don't wrap the test in a test-managed transaction that rolls back by itself, because that would mask the result. Use a non-transactional test method and assert after the call returns.
- SQL advice (state):
  - Seed a minimal row set in the disposable DB.
  - Record the predeclared expected committed state before running the check.
  - After the failing service call, read the state through a separate connection or transaction.
  - Assert the exact row values, row count and any constraint-relevant columns. Don't assert only that an exception was thrown.
  - Include a boundary case where the failure happens after the update statement has executed, so rollback is the only thing that restores the state.
- Testing advice (discrimination):
  - Failing case: the service throws after the update, and the DB state equals the pre-update seed.
  - Positive control: on success, the update is committed. This guards against a check that passes because nothing was ever written.
  - Optional, if the exception behavior includes a non-rollback type: one case showing the declared commit-or-rollback result for it.
  - Cleanup: reset the disposable DB between cases to prevent shared state.
  - The check should fail for the credible bugs: a missing or bypassed proxy, a wrong rollback rule, or a swallowed exception.
  - Keep the mocked unit tests for service logic. The integration check supplements them and doesn't replace them.

**VERIFICATION**
- Pass/fail/inconclusive is owned by core `verification`, not by the advisers.
- Pass: observed committed state equals the predeclared expected state in the failure case, and the control case commits.
- Fail: any difference. I'd preserve the failure evidence and not edit assertions to get green.
- Inconclusive: the DB isn't disposable, the proxy isn't actually crossed, or the test ran inside an outer transaction.
- A green result would prove rollback on this path, with this exception and this database. It would not prove other propagation settings, concurrency or production dialect differences.

**UNDERSTANDING**
- Transaction boundary is a candidate ownership topic. Applicability is assessed by core after verification passes, so no gate is required or passed now.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**
- No blocking question. To finalize the test I need the concrete service method, the exception type and the predeclared expected state.
- Next valid action: record this as the verification design, then proceed through the workflow to a single active step for writing the test.