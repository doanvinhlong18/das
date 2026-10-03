**DECISION**
- I stay in the core guided-development investigation workflow and activate the Java domain skill as a technical adviser. The trigger is that the evidence is Java source, a stack trace with thread names, executor setup and the JDK version, and the failure depends on Java concurrency behavior.
- The Java skill only advises on JDK and executor semantics. It doesn't change the workflow, and it doesn't relax the evidence or verification rules.
- I don't activate Spring or database skills, because the context says no container or database behavior is involved.

**EVIDENCE CLASSIFICATION**
- Provided and observed: the source, the full stack trace with thread names, the executor configuration, and the JDK version.
- Not yet established: why the executor thread differs from the working path. Candidates are thread-local or context state that doesn't propagate (MDC, security, locale), a different classloader or context class loader, an unhandled exception wrapped in `ExecutionException` or `CompletionException`, a pool-size or queue effect, and a shared mutable state race. These are hypotheses until the trace and code support them.
- I won't claim a reproduction, since none has been run.

**STATE EFFECT**
- The investigation continues, with the Java skill as an adviser.
- No files change and no runtime state is touched.

**IMPLEMENTATION SCOPE**
- Diagnosis only. The user asked why it fails, not for a fix.
- I'll propose a fix only if asked, and I'll keep it separate from the root-cause finding.

**VERIFICATION**
- First I'll trace the trace. I'll compare the failing executor thread's frames with the non-executor path, find where the exception originates and what the callback assumes about its thread, and check the executor setup (thread factory, context class loader, wrapping or decorating of tasks).
- I'll cross-check each candidate cause against the JDK version's documented behavior.
- Any conclusion will cite the specific frames and source lines. If the evidence can't separate two causes, I'll say so and name the check that would separate them, such as a targeted test or log, rather than guess.

**UNDERSTANDING**
- The Understanding Gate isn't triggered. This is a bounded read-only diagnostic with sufficient evidence and no design decision pending.
- I'd raise it only if the trace pointed to behavior I can't explain from the available evidence.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**
- No blocking questions.
- If I notice unrelated problems while reading, such as unsafe shared state elsewhere, I'll list them separately and won't act on them.