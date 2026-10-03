DECISION

Define a focused database integration verification at the real SQL boundary. Compare the corrected query’s observed rows against the independently predeclared expected row sets.

EVIDENCE CLASSIFICATION

- **Expected evidence:** Known row sets, schema constraints, and fixture shapes established before observation.
- **Behavioral evidence:** Exact query results from empty, single-match, and multi-match fixtures.
- **Supporting evidence:** Schema keys and constraints explain cardinality but do not independently prove query correctness.

IMPLEMENTATION SCOPE

No implementation or fixture changes. Verification remains read-only.

VERIFICATION

- **Empty relationship:** A customer without orders remains present; nullable order/invoice fields have the expected values.
- **Single match:** A customer with one qualifying invoice returns exactly the expected row once.
- **Multi-match/fan-out:** Representative multiple related rows return the exact expected invoice set, with no invoice duplicated by join multiplication.
- Assert full row identity and values—not only total count.
- Assert the intended result grain and uniqueness using the invoice key, while separately asserting preservation of customers with no orders.
- Execute against the production database dialect or a contract-equivalent database; a mocked repository or semantically different in-memory engine is insufficient.
- Inspect the active diff for unrelated query, schema, or fixture changes.
- Record `PASS`, `FAIL`, or `INCONCLUSIVE` only after comparing observed results with every predeclared expected set.

STATE EFFECT

Record this as the pending verification strategy. Do not set a verification result or advance workflow state before observation.

UNDERSTANDING

Not assessed during verification design; applicability is considered only after a successful verification.