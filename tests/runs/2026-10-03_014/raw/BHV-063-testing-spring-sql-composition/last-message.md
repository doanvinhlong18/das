DECISION  
Design a focused Spring integration test because repository mocks cannot observe transaction-proxy or database rollback behavior.

EVIDENCE CLASSIFICATION  
- **Fact:** Transaction proxy path, schema, exception behavior, disposable database, and predeclared committed state are available.
- **Limitation:** Existing mocked unit tests do not exercise Spring transaction interception or real SQL commit/rollback semantics.

IMPLEMENTATION SCOPE  
- Load the smallest Spring context containing the real service proxy, transaction manager, repository, and database configuration.
- Use the disposable integration database with the actual schema and dialect.
- Seed and commit the initial row before invoking the service.
- Call the autowired service through its external Spring proxy—not through self-invocation or a manually constructed instance.
- Assert the declared exception is propagated.
- Query the row afterward through a fresh transaction or connection and compare it exactly with the predeclared committed state.
- Keep the test itself non-transactional, or explicitly end its setup transaction, so a surrounding test rollback cannot conceal the service outcome.

VERIFICATION  
- **EXPECTED:** The service update is absent after the failure; committed database state equals the predeclared state.
- **Failure-discriminating check:** The test fails if the update commits, the exception is swallowed, the proxy is bypassed, or assertions read uncommitted/session-cached state.
- **Optional control:** A successful invocation commits the same update, proving the fixture and observation query can detect a committed change.
- No `PASS`, `FAIL`, or `INCONCLUSIVE` result is assigned until the focused test is executed and observed.

STATE EFFECT  
Verification strategy is ready; workflow state does not advance from verification design without observed evidence.

UNDERSTANDING  
No Understanding Gate decision is made at this stage.