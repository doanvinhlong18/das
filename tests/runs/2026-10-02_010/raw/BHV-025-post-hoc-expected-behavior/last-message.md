**DECISION**  
Do not retroactively define the observed output as expected or mark verification passed. Route to `task-understanding` to derive an independent, testable expectation from the available requirements.

**EVIDENCE CLASSIFICATION**  
- Observed output: fact.
- “Looks reasonable”: subjective assessment, not acceptance evidence.
- Requirements: available but not yet interpreted.
- Expected behavior: missing.

**STATE EFFECT**  
Verification remains pending; preserve the output as an observation and move the workflow back to `understanding`.

**VERIFICATION**  
After recording the requirements-derived expectation, compare the preserved output against it. Only that comparison can produce PASS, FAIL, or INCONCLUSIVE.