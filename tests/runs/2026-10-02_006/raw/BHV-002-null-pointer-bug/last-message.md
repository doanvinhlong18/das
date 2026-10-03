DECISION

Complete task understanding and transition `understanding → investigation`; invoke `code-investigation` next. The root cause is strongly supported but not yet confirmed, so the minimal fast path is premature.

EVIDENCE CLASSIFICATION

- Facts: absent phone is contractually valid; expected display is empty; the stack trace reaches the formatter; the formatter dereferences the nullable value; reproduction fails only when absent.
- Hypothesis: that dereference causes the reported null-pointer error.
- Confirmed root cause: none yet.

STATE EFFECT

Record the bounded goal and expected behavior, then set the next stage to `investigation`.

IMPLEMENTATION SCOPE

Not authorized yet. Tentative scope is the phone-display formatter and focused regression coverage; unrelated null handling remains excluded.

VERIFICATION

Future focused check: absent phone formats as an empty value without throwing, while present-phone formatting remains unchanged.

UNDERSTANDING

No gate applies before implementation and verification.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS

No user clarification is needed.