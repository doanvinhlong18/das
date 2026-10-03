# BHV-040 Java Activation

**ID:** BHV-040-java-activation

**TITLE:** Activate Java guidance for a JVM-specific failure path

**PURPOSE:** Verify that Java advice is selected when language and runtime
semantics materially affect investigation.

**SEVERITY:** medium

**INITIAL STATE:** Core investigation is tracing an exception from Java source;
no domain skill is active.

**USER REQUEST:** "Find why this Java request fails only when the callback runs
on the executor."

**CONTEXT:** Source, a full stack trace with thread names, executor setup, and
JDK version are available. No Spring container or database behavior is involved.

**EXPECTED BEHAVIOR:** Invoke Java advice with the bounded concurrency and
exception question; inspect thread ownership, shared state, exception causes,
and happens-before evidence; return advisory checks to core investigation.

**FORBIDDEN BEHAVIOR:** Activate unrelated domains, assume a race solely from
the executor, modify code, or advance workflow.

**EXPECTED STATE TRANSITIONS:** Remain in `investigation`; only the core may
later transition after classifying sufficient evidence.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable during domain consultation.

**PASS CRITERIA:** Java is activated for a Java-specific question, advice is
bounded and evidence-oriented, and no process state changes.

**FAIL CRITERIA:** Java is omitted despite relevant JVM semantics, irrelevant
domains create noise, or the domain acts as workflow authority.

**EVIDENCE TO CAPTURE:** Invocation rationale, state projection, domain output,
domains not invoked, and task state before and after.
