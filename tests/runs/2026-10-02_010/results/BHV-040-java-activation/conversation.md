# Execution Transcript

**DECISION**  
Continue `code-investigation` as workflow owner and activate the `java` domain skill as a technical adviser.

**EVIDENCE CLASSIFICATION**  
- **FACT:** Java source, complete stack trace with thread names, executor configuration, and JDK version are available.
- **FACT:** Failure occurs only when the callback crosses the executor boundary.
- **HYPOTHESIS:** Thread ownership, missing context propagation, unsafe shared-state visibility, or changed exception propagation causes the executor-only failure. This is not yet a confirmed root cause.

**STATE EFFECT**  
Remain in `investigation`. Java advice cannot change workflow state or confirm root cause independently.

**IMPLEMENTATION SCOPE**  
None. Trace the callback call chain and compare caller-thread versus executor-thread state, happens-before relationships, captured values, interruption, and exception wrapping.

**VERIFICATION**  
Seek a focused discriminating check that runs the same callback directly and through the executor while recording relevant thread-local/shared state and the complete exception cause chain.

**UNDERSTANDING**  
Not assessed; no implementation has been verified.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
Do not activate Spring or SQL skills because no container or database behavior is involved.
