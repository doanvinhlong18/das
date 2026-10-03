---
name: angular
description: Provide advisory Angular investigation guidance for components, templates, signals, RxJS streams, dependency injection, routing, forms, HTTP interceptors, change detection, lazy loading, and browser-visible behavior. Use during an active core workflow when Angular-specific evidence or focused verification is needed; do not use it to control workflow or modify project files.
---

# Angular Reasoning

## Purpose

Improve reasoning about Angular application behavior across templates,
components, services, routing, and asynchronous data flow. Follow the shared
advisory boundary in [DOMAIN_SKILLS.md](../../docs/DOMAIN_SKILLS.md).

## Preconditions and Inputs

- A core skill supplies the active question, expected behavior, scope, and
  relevant task-state projection.
- Angular/RxJS versions, standalone or module structure, build configuration,
  runtime evidence, and test environment are available or marked unknown.
- Browser behavior and backend contracts are kept distinct unless the active
  question explicitly spans them.

## Investigation Patterns

1. Trace data and control from route/input/event through component state,
   signals or observables, services, HTTP, and template rendering.
2. Identify component and provider lifetime, injection scope, lazy-loaded
   boundaries, and whether state is shared or recreated.
3. For rendering defects, inspect mutation versus replacement, change-detection
   strategy, signal dependencies, zone boundaries, lifecycle timing, and
   template guards.
4. For RxJS, identify subscription ownership, hot/cold behavior, flattening
   operator semantics, cancellation, error handling, completion, and sharing.
5. For forms and routing, inspect value/status propagation, validators, route
   order, guards, resolvers, parameters, and navigation timing.
6. For HTTP, inspect request construction, interceptors, retries, cancellation,
   caching, response mapping, and network evidence.

## Important Evidence Sources

- components, templates, services, routes, providers, forms, and interceptors;
- browser console, network trace, DOM state, and Angular diagnostics;
- focused component/service tests and their TestBed/provider setup;
- RxJS timeline or marble evidence when timing and cancellation matter;
- production and test build configuration, environment replacement, and source
  maps;
- authoritative Angular and RxJS documentation for the repository versions.

## Common Failure Modes and Dangerous Assumptions

- In-place mutation is assumed to trigger the intended OnPush or signal update.
- Observable subscription, cancellation, and error behavior is inferred from
  operator names without tracing the stream.
- A route guard is treated as a server-side security boundary.
- TestBed mocks are assumed to match provider scope, router, or HTTP runtime.
- A template symptom is assumed to originate in the template rather than the
  data or timing path.
- Browser refresh, lazy loading, and client navigation are assumed equivalent.
- Passing development builds are assumed to prove production build behavior.

## Verification Guidance

- Verify the smallest user-observable behavior plus the component/service
  contract that causes it.
- Use focused component or service tests when they include the required Angular
  behavior; use router, HTTP, or integration tests when boundaries matter.
- For asynchronous flows, control scheduling and assert emission order,
  cancellation, errors, and loading/final states rather than only the final
  value.
- Inspect the DOM and accessibility-relevant state when behavior is rendered,
  not only component fields.
- Run a relevant production build or configuration check when compilation,
  optimization, or environment replacement is part of the risk.

## Useful Reasoning Questions

- Which event or emission first makes state incorrect?
- Who owns the subscription and when is it cancelled?
- Does the component/provider instance survive this navigation?
- Which change-detection or signal dependency makes the view update?
- Is this client-side check behavior, usability, or a real security boundary?
- What focused observation distinguishes timing from mapping or rendering?

## Outputs and Exit Criteria

Return sourced observations, hypotheses with discriminating checks, dangerous
assumptions, focused verification options, limitations, and candidate ownership
topics such as stream cancellation or shared-state lifetime. Exit when the
active core skill has enough Angular-specific guidance or the missing browser
or runtime evidence is explicit.

## Allowed Actions

- Read Angular source, templates, configuration, tests, browser evidence, and
  versioned documentation.
- Suggest safe diagnostics and focused UI or stream checks.
- Interpret Angular, RxJS, router, forms, and change-detection behavior.
- Compose through core with Testing, Java, Spring, Git, or SQL advice.

## Forbidden Actions and State Effects

- Do not modify application source, templates, configuration, or tests.
- Do not equate a client guard with authoritative backend authorization.
- Do not control workflow, activate steps, set verification pass, require or
  pass an Understanding Gate, or mark completion.
- Candidate ownership topics remain advisory; propose no task-state update.

## Composition Examples

- With Testing, Angular identifies the real component/router/stream boundary
  while Testing selects a check that observes it without over-mocking.
- With Spring, keep browser and API evidence separate, then let core
  investigation connect them through the documented contract.
- With Git, use history to locate changes to templates or stream operators but
  confirm current behavior from current source and runtime evidence.
