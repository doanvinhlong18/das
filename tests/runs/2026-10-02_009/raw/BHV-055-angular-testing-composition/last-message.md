DECISION

Choose one focused Angular component test spanning route-parameter emission → real RxJS component stream → `HttpTestingController` → rendered DOM.

EVIDENCE CLASSIFICATION

- Known: route parameters, stream implementation, HTTP mocking, and expected rendered behavior are available.
- Verification design: emit parameter A, capture request A; emit parameter B before A completes; assert request A is cancelled; flush request B; run change detection; assert the DOM renders only B.
- This check would fail if stale requests remain subscribed, the wrong flattening behavior is used, or the newest response does not reach the template.

STATE EFFECT

Remain in verification planning. No verification result or workflow transition is justified until the check runs.

IMPLEMENTATION SCOPE

No files modified. Use the existing component and template with a controllable `ActivatedRoute.paramMap` test double and mocked HTTP transport. A router harness or end-to-end test is unnecessary unless actual navigation behavior is part of the stated risk.

VERIFICATION

Expected: the second route emission cancels the first HTTP request and only the second response is rendered.

UNDERSTANDING

Not assessed; verification has not produced a result.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS

None.