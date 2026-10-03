---
name: sql
description: Provide advisory SQL and relational database investigation guidance for result correctness, joins, null semantics, aggregation, constraints, transactions, isolation, query plans, indexes, and data distribution. Use during an active core workflow when query, schema, data, or database evidence is needed; do not use it to control workflow, modify data, or declare verification complete.
---

# SQL Reasoning

## Purpose

Improve reasoning about relational behavior using query, schema, data, and plan
evidence. Follow the shared advisory boundary in
[DOMAIN_SKILLS.md](../../docs/DOMAIN_SKILLS.md).

## Preconditions and Inputs

- A core skill supplies the bounded question, approved scope, expected behavior,
  and relevant facts or hypotheses.
- Database product/version, schema, constraints, query parameters, representative
  data, and transaction context are available or explicitly unknown.
- Read-only evidence collection is preferred; any mutation remains outside this
  advisory skill.

## Investigation Patterns

1. Establish the expected row set, values, ordering, and cardinality from an
   independent requirement before changing SQL.
2. Trace tables, keys, constraints, join predicates, filters, grouping, window
   functions, and null behavior using representative rows.
3. Test fan-out and optional relationships explicitly; distinguish duplicate
   source rows from join multiplication.
4. For incorrect values, inspect type conversion, precision, collation,
   timezone, aggregation level, and three-valued logic.
5. For performance, compare equivalent workloads and inspect actual plans,
   estimates, indexes, statistics, parameter values, and returned row counts.
6. For concurrency, identify isolation, locking, statement order, and the
   transaction boundary supplied by the application layer.

## Important Evidence Sources

- exact SQL, bound parameters, and database dialect/version;
- schema definitions, keys, constraints, indexes, and statistics;
- minimal representative data and focused read-only query results;
- actual and estimated query plans with row estimates and timings;
- database logs, lock/wait evidence, and transaction traces;
- migration history and authoritative database documentation;
- application mapping or ORM evidence when it changes generated SQL.

## Common Failure Modes and Dangerous Assumptions

- `DISTINCT` is used to hide an invalid join.
- Row count is treated as proof that the returned rows are correct.
- Result ordering is assumed without an effective `ORDER BY`.
- A `LEFT JOIN` remains optional after a right-side predicate is placed in
  `WHERE`.
- Null comparison, integer division, precision, collation, or timezone behavior
  is assumed from another database.
- An index is assumed useful without plan and data-distribution evidence.
- An estimated plan is treated as observed runtime behavior.
- Green ORM tests are assumed to reproduce the production dialect and schema.

## Verification Guidance

- Compare the predeclared expected set with observed rows, values, cardinality,
  and ordering for representative and boundary data.
- Include empty, null, duplicate, many-to-many, and date-boundary cases when
  material to the query.
- For performance, preserve functional equivalence and compare the same data,
  parameters, cache conditions, and workload; record plan limitations.
- For transaction behavior, verify committed results and material concurrent
  interleavings rather than SQL text alone.
- Prefer read-only checks or disposable fixtures; do not mutate live data for
  convenience.

## Useful Reasoning Questions

- What is the intended grain of one result row?
- Which key or constraint proves the assumed relationship cardinality?
- Can null or an optional relationship change the predicate result?
- Are ordering and tie-breaking explicit?
- Does the plan operate on the same parameters and data distribution as the
  reported problem?
- Which application or transaction boundary affects the SQL observation?

## Outputs and Exit Criteria

Return sourced observations, explicit hypotheses and discriminating queries,
dangerous assumptions, focused verification guidance, limitations, and
candidate ownership topics such as cardinality, isolation, or data invariants.
Exit when the active core skill can make its next evidence-based decision or
the missing database evidence is named.

## Allowed Actions

- Read SQL, schema, migrations, plans, logs, query results, and documentation.
- Suggest safe read-only queries, plan inspection, and focused database checks.
- Interpret database-specific semantics and version differences.
- Compose through core with Spring, Java, Git, or Testing advice.

## Forbidden Actions and State Effects

- Do not modify schemas, queries, migrations, tests, or data.
- Do not execute or recommend unsafe production mutations as investigation.
- Do not declare a hypothesis confirmed, set verification pass, control
  workflow, require a gate, or mark completion.
- Candidate ownership topics do not imply `understanding.required: true`.
- Propose no direct task-state update.

## Composition Examples

- With Spring, separate repository/transaction behavior from relational query
  semantics and combine evidence only through the active core skill.
- With Testing, define the data shapes and invariants that focused tests must
  distinguish without allowing fixtures to encode the observed bug as expected.
- With Git, use migration and query history to locate changes, not to replace
  current schema and runtime evidence.
