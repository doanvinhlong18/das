---
name: spring
description: Provide advisory Spring Framework and Spring Boot investigation guidance for bean resolution, proxies, transactions, configuration, MVC, validation, security chains, data access, events, and asynchronous behavior. Use during an active core workflow when Spring-specific evidence or verification is needed; do not use it to control transitions, require gates, or modify project files.
---

# Spring Reasoning

## Purpose

Improve reasoning about Spring-managed runtime behavior without treating
annotations or conventions as proof. Follow the shared advisory boundary in
[DOMAIN_SKILLS.md](../../docs/DOMAIN_SKILLS.md).

## Preconditions and Inputs

- A core skill supplies the active question, scope, expected behavior, and
  relevant task-state projection.
- Spring and Boot versions, active profiles, configuration sources, runtime
  path, and test context are available or recorded as unknown.
- Framework-specific advice remains subordinate to observed repository and
  runtime evidence.

## Investigation Patterns

1. Trace the request, event, or method call through filters, controllers,
   proxies, beans, repositories, and thread boundaries.
2. Determine which bean instance and configuration actually won: qualifiers,
   conditional beans, profiles, property precedence, and component scanning.
3. For transactions, identify the real proxy boundary, propagation, isolation,
   rollback rules, exception flow, data-source manager, and thread changes.
4. For MVC or validation, inspect binding, conversion, validation groups,
   exception mapping, content negotiation, and serialization.
5. For security, inspect the effective filter chain, matcher ordering,
   authentication source, authorization decision, and method-security proxy.
6. For events and async behavior, distinguish synchronous publication from
   executor-backed work and commit-relative behavior.

## Important Evidence Sources

- source, annotations, configuration classes, and generated metadata;
- startup logs, condition evaluation, bean-definition and proxy evidence;
- effective property sources and active profiles;
- request/security/transaction logs and focused runtime traces;
- actuator or diagnostic endpoints when safely available;
- slice, context, integration, and focused unit tests with their actual test
  configuration;
- authoritative Spring documentation matching the repository version.

## Common Failure Modes and Dangerous Assumptions

- Annotation presence is assumed to prove proxy interception.
- Self-invocation is assumed to cross a transaction or method-security proxy.
- Every exception is assumed to trigger rollback.
- Test slices or mocks are assumed to reproduce the production container.
- Property file presence is assumed to mean that value is effective.
- Filter, matcher, advice, or bean order is assumed from source order.
- `@Async` or event execution is assumed to retain transaction and security
  context across threads.
- Repository method names are assumed to guarantee intended SQL semantics.

## Verification Guidance

- Verify the effective bean, proxy, property, filter chain, or transaction path,
  not only the declared annotation.
- Use the smallest Spring test context that still contains the behavior under
  investigation; escalate to integration only when container behavior matters.
- For transactions, observe committed state and rollback outcomes across the
  real boundary, including material exception cases.
- For security, verify both allowed and denied paths at the effective matcher
  and method boundary.
- For configuration, verify precedence under the relevant profile and launch
  mode.

## Useful Reasoning Questions

- Which concrete bean and proxy handles this call at runtime?
- Does the call cross the proxy from outside, or is it self-invocation?
- Which configuration source and profile supplies the effective value?
- Where does the transaction begin, suspend, commit, or roll back?
- Does execution cross a thread or commit boundary?
- Which focused observation would distinguish framework configuration from
  application logic as the cause?

## Outputs and Exit Criteria

Return sourced observations, hypotheses with discriminating checks, dangerous
assumptions, focused verification options, limitations, and candidate ownership
topics such as transaction or security boundaries. Exit when Spring-specific
guidance is sufficient for the active core decision or the missing runtime
evidence is explicit.

## Allowed Actions

- Read Spring source, configuration, tests, logs, diagnostics, and versioned
  documentation.
- Suggest safe focused diagnostics and verification techniques.
- Interpret proxy, container, configuration, and lifecycle evidence.
- Compose through core with Java, SQL, Angular, Git, or Testing advice.

## Forbidden Actions and State Effects

- Do not modify application code or configuration.
- Do not infer root cause from annotation presence or convention alone.
- Do not control workflow, activate steps, waive verification, require or pass
  an Understanding Gate, or mark completion.
- Transaction or security significance may be returned only as a candidate
  ownership topic; core decides applicability.
- Propose no direct task-state update.

## Composition Examples

- With SQL, Spring identifies transaction, repository, and parameter-binding
  behavior while SQL evaluates query, schema, data, and plan semantics.
- With Java, separate container/proxy effects from language, exception, and
  concurrency semantics.
- With Testing, identify which container behavior must be present so a focused
  test does not pass under an unrealistic mock or slice.
