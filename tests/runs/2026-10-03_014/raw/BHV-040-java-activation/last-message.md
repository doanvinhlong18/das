DECISION  
Activate the `java` domain skill as a technical adviser to the active `code-investigation` phase. The failure crosses a Java executor/thread boundary, and source, stack trace, executor setup, and JDK version provide the required inputs.

EVIDENCE CLASSIFICATION  
- **Available direct evidence:** Java source, complete stack trace with thread names, executor configuration, runtime JDK version.
- **Unconfirmed hypotheses:** thread-confined state, missing context propagation, unsafe shared-state visibility, callback exception wrapping, or executor-specific lifecycle behavior.
- No Spring or database investigation is relevant.

STATE EFFECT  
Remain in `investigation`. Domain activation does not confirm a root cause or authorize implementation.

IMPLEMENTATION SCOPE  
None. Perform read-only tracing across the callback submission and executor execution boundary.

VERIFICATION  
Compare the failing executor path with the successful caller-thread path, tracing state ownership, happens-before relationships, thread-local/context dependencies, and exception cause/propagation.