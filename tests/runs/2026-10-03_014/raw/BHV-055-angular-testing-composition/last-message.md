**DECISION**

Use one focused Angular component test with a controllable `ActivatedRoute`, real component RxJS stream, and `HttpTestingController`.

**EVIDENCE CLASSIFICATION**

- Known: route parameters, HTTP mocking, stream path, and expected DOM output are available.
- Planned—not observed: verification has not run, so no `PASS`/`FAIL` result exists.

**VERIFICATION**

1. Emit route parameter `A`; capture HTTP request `A`.
2. Emit parameter `B` before responding to `A`.
3. Assert request `A` is cancelled/unsubscribed.
4. Capture and flush request `B`.
5. Run change detection and assert the DOM renders only result `B`.

This single test crosses the mechanism at risk—route emission → RxJS cancellation → HTTP → rendered DOM—and would fail for a non-cancelling flattening operator or stale rendering. A full router harness, marble test, or broader suite is unnecessary unless real navigation configuration or scheduling is separately at risk.

**STATE EFFECT**

Record this as the active step’s verification strategy and expected evidence. Do not assign a verification result or advance workflow state yet.