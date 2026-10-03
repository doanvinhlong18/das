**DECISION**

Remain in `understanding`; the task is **BLOCKED** on a product-behavior clarification.

**EVIDENCE CLASSIFICATION**

- **Fact:** The user reports the status filter returns a wrong result.
- **Fact:** Current behavior is observable.
- **Fact:** Archived records have two plausible interpretations producing different expected results.
- **Unknown:** Which archived-record behavior is intended.
- **Not established:** Root cause or required code change.

**STATE EFFECT**

No transition to investigation or implementation. Record the archived-record rule as a blocking unresolved question.

**IMPLEMENTATION SCOPE**

None authorized. Do not modify code, tests, or configuration.

**VERIFICATION**

After clarification, verify each status selection against active and archived records, including the clarified archived-record rule.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**

When filtering by status, should archived records:

1. remain included according to their stored status, or  
2. be excluded/treated as a separate archived status?