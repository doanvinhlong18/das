---
name: java
description: Provide advisory Java and JVM investigation guidance for Java source, stack traces, compiler failures, runtime behavior, concurrency, serialization, class loading, and dependency compatibility. Use during an active core workflow when Java-specific evidence, failure modes, or focused verification techniques are needed; do not use it to control workflow or modify project files.
---

# Java Reasoning

## Purpose

Improve technical reasoning about Java source and JVM behavior. Return focused
advice to the active core skill; follow the shared advisory boundary in
[DOMAIN_SKILLS.md](../../docs/DOMAIN_SKILLS.md).

## Preconditions and Inputs

- A core skill owns the current workflow action and supplies a bounded question.
- Relevant Java/JDK versions, source paths, build configuration, evidence, and
  task scope are available or explicitly unknown.
- Existing facts, hypotheses, expected behavior, and verification needs are
  provided when they affect the question.

## Investigation Patterns

1. Reproduce or locate the exact failing path before generalizing from an
   exception type or compiler message.
2. Follow the call chain, including asynchronous boundaries, callbacks,
   reflection, generated code, exception causes, and suppressed exceptions.
3. Establish type and value contracts: nullability, generic types, equality,
   mutability, numeric conversion, time zones, and collection semantics.
4. For concurrency, identify shared state, synchronization, thread ownership,
   happens-before relationships, interruption, and executor boundaries.
5. For compatibility, compare source, bytecode target, runtime JDK, dependency
   versions, class path/module path, and serialization format.
6. Prefer a discriminating example over a broad speculative rewrite.

## Important Evidence Sources

- Java source and generated source actually compiled;
- complete stack traces, causes, thread names, and relevant logs;
- focused tests or minimal reproductions;
- compiler diagnostics and build-tool dependency resolution;
- runtime JDK and flags, thread dumps, JFR/profile evidence, or `javap` output
  when needed;
- serialization payloads, class metadata, and compatibility fixtures;
- authoritative documentation for the active JDK or library version.

## Common Failure Modes and Dangerous Assumptions

- The exception site is assumed to be where the invalid value originated.
- A caught or wrapped exception is assumed to preserve rollback, interruption,
  or caller-visible semantics.
- `equals`/`hashCode`, ordering, mutability, or stream laziness is overlooked.
- A passing repeated concurrency test is treated as proof of thread safety.
- Source compatibility is assumed to imply binary or serialization
  compatibility.
- The local JDK, dependency graph, or generated source is assumed to match the
  runtime environment.
- A broad null guard is added without establishing the actual contract.

## Verification Guidance

- Exercise the smallest input that distinguishes the expected value or control
  flow, then include material boundary and regression cases.
- Use compilation and static analysis for type and API evidence, but do not
  treat them as behavioral proof.
- Verify exception type, cause, propagation, cleanup, and externally visible
  outcome when error handling changes.
- For concurrency, combine invariant-focused tests with thread/trace evidence;
  state explicitly what nondeterministic checks cannot prove.
- Verify compatibility against the relevant runtime or serialized form when
  version boundaries matter.

## Useful Reasoning Questions

- Where was the invalid value or state first introduced, not merely observed?
- Which language or library contract determines the behavior?
- Does the call cross a thread, reflection, proxy, serialization, or generated-
  code boundary?
- What input distinguishes this hypothesis from another plausible cause?
- Which observable behavior must remain unchanged?

## Outputs and Exit Criteria

Return concise domain advice with sourced observations, explicit hypotheses,
dangerous assumptions, focused checks, limitations, and candidate ownership
topics when material. Exit when the active core skill has enough Java-specific
guidance for its next decision or the missing evidence is clearly named.

## Allowed Actions

- Read Java source, tests, build files, logs, traces, dumps, and documentation.
- Suggest safe read-only commands, focused experiments, and verification checks.
- Interpret supplied evidence and identify version-sensitive behavior.
- Compose through the core with Spring, SQL, Git, or Testing advice.

## Forbidden Actions and State Effects

- Do not modify source, tests, build files, or runtime state.
- Do not confirm root cause without the core investigation's causal evidence.
- Do not activate steps, change workflow state, set verification results,
  require an Understanding Gate, or mark work complete.
- Propose no direct task-state update. Return advice to the invoking core skill.

## Composition Examples

- With Spring, separate Java exception and thread semantics from proxy,
  transaction, or container behavior.
- With Git, use history as evidence about when a Java contract changed, not as
  proof that a particular author or commit caused the bug.
- With Testing, identify the language-level invariant while Testing selects the
  smallest check that can observe it.
