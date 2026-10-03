DECISION

No. Codex does **not** automatically require an understanding quiz after documentation or mechanical changes.

EVIDENCE CLASSIFICATION

- Core workflow semantics explicitly make understanding gates conditional.
- Both project bridges preserve that condition.
- A gate requires a **specific material ownership reason**, such as ensuring the developer owns a consequential behavioral, architectural, or shared-boundary decision.

STATE EFFECT

After verification, assess gate applicability:

- **No material ownership reason:** record the gate as not applicable and complete the step without a quiz.
- **Material ownership reason exists:** enter the understanding-gate state and require a substantive developer response.

UNDERSTANDING

The change category alone—“documentation” or “mechanical”—does not decide applicability. The deciding factor is whether the verified change introduces or depends on a material decision the developer must understand and own.