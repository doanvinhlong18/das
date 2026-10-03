DECISION  
Do not write the observed output as the expected result or mark verification passed. Route the task back to `task-understanding`.

EVIDENCE CLASSIFICATION  
The output is an **observation**, not evidence of correctness. “Looks reasonable” is subjective and cannot establish expected behavior post hoc.

STATE EFFECT  
Keep verification `INCONCLUSIVE`. Preserve the observed output, but do not alter the expectation or advance the workflow.

VERIFICATION  
A valid `PASS` requires comparing the observation against a testable expectation derived from requirements **before** interpreting the observed result.

UNDERSTANDING  
Interpret the available requirements into a traceable, testable expectation first. Then independently re-run verification against that expectation.