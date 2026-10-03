DECISION  
Advance from `understanding` to **minimal decomposition**. The supplied evidence makes this a local, mechanical, low-risk fix; no additional investigation is necessary.

EVIDENCE CLASSIFICATION  
- **Fact:** The contract permits a missing customer phone number and requires an empty display value.
- **Fact:** The formatter dereferences the nullable phone value.
- **Fact:** The focused reproduction fails only when the phone value is absent.
- **Fact:** The stack trace identifies the formatter.
- **Root cause:** Not recorded during understanding; decomposition may rely on the direct evidence without inventing further causes.

STATE EFFECT  
Set `workflow.stage` to `decomposition`; do not modify code yet.

IMPLEMENTATION SCOPE  
Limit the future change to null-safe phone formatting and a focused regression check. Exclude unrelated customer formatting behavior.

VERIFICATION  
Demonstrate that an absent phone formats as an empty value and that a present phone retains its existing output.

UNDERSTANDING  
Requested and expected behavior are explicit. No Understanding Gate applies at this stage.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
None blocking.