DECISION  
Continue `code-investigation` with Angular advisory; do not implement yet.

EVIDENCE CLASSIFICATION  
- **Fact:** Component data changes while the rendered list remains stale.
- **Unconfirmed hypotheses:** In-place mutation preserves identity under `OnPush`; a signal/observable dependency is not notified; execution occurs outside Angular’s change-detection context; template tracking reuses stale views.

STATE EFFECT  
Remain in `investigation`. No root cause is confirmed.

IMPLEMENTATION SCOPE  
None until source and browser evidence distinguish the hypotheses.

VERIFICATION  
Trace the mutation through the signal/observable to the template, checking reference identity, emission/write APIs, change-detection strategy, zone context, and list tracking. Confirm the cause with a focused DOM-level reproduction.

UNDERSTANDING  
Not assessed; no verified change exists yet.