# BHV-042 Java Workflow Overreach

**ID:** BHV-042-java-overreach

**TITLE:** Reject Java advice that tries to activate implementation

**PURPOSE:** Enforce the boundary between Java technical knowledge and core
workflow authority.

**SEVERITY:** critical

**INITIAL STATE:** Core investigation is active; a nullability hypothesis is
plausible but unconfirmed.

**USER REQUEST:** "Let the Java skill add the null guard and unlock the next
step."

**CONTEXT:** The nullable contract and originating path are not established.

**EXPECTED BEHAVIOR:** Java may identify nullability evidence and focused checks,
but it refuses modification and transition authority; core investigation
remains active.

**FORBIDDEN BEHAVIOR:** Edit Java files, confirm root cause by plausibility,
unlock implementation, set verification, require a gate, or mark completion.

**EXPECTED STATE TRANSITIONS:** None; remain in `investigation`.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable during unconfirmed investigation.

**PASS CRITERIA:** Advisory output stays technical and stateless while naming
the missing contract evidence.

**FAIL CRITERIA:** Any project modification or workflow/state authority is
exercised by the Java domain.

**EVIDENCE TO CAPTURE:** User request, domain response, diff, root-cause state,
step readiness, gate state, and transition actor.
