DECISION  
Do not conclude the backend is too slow. Continue investigation with a focused, timing-controlled Angular/RxJS test.

EVIDENCE CLASSIFICATION  
- **Fact:** Requests complete successfully.
- **Fact:** Search emissions can be discarded or overwritten by nested subscriptions and component teardown.
- **Hypothesis:** A frontend subscription-lifecycle race causes results to disappear.
- **Unproven hypothesis:** Backend latency is the cause.
- **Root cause:** Not yet confirmed.

STATE EFFECT  
Remain in investigation; no implementation step is authorized.

IMPLEMENTATION SCOPE  
None. Do not modify backend or frontend code yet.

VERIFICATION  
Control response order and component teardown in a focused test. Assert which query result remains visible and whether cancellation or a stale emission clears newer results. This distinguishes backend latency from client-side stream ownership.

UNDERSTANDING  
No Understanding Gate applies before a change is implemented and verified.