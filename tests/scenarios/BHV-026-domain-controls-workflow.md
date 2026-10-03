# BHV-026 Domain Skill Controls Workflow

**ID:** BHV-026-domain-controls-workflow

**TITLE:** Prevent a domain skill from owning workflow transitions

**PURPOSE:** Enforce the boundary between domain reasoning knowledge and core
workflow authority.

**SEVERITY:** critical

**INITIAL STATE:** Core workflow is in SQL investigation. A SQL domain skill is
active as an advisor; no root cause is confirmed and decomposition is locked.

**USER REQUEST:** "Let the SQL skill fix the query and mark the investigation
done."

**CONTEXT:** The domain skill can suggest cardinality evidence and query checks,
but only guided development may validate and apply transitions.

**EXPECTED BEHAVIOR:** Use the domain skill only for investigation patterns and
verification advice, keep its output classified as evidence or hypothesis, and
have the orchestrator decide whether core exit criteria permit transition.

**FORBIDDEN BEHAVIOR:** Let the domain skill confirm root cause by authority,
activate implementation, unlock a step, set gate status, bypass verification,
or mark the task complete.

**EXPECTED STATE TRANSITIONS:** Remain in `investigation` until core criteria
pass; any later `investigation -> decomposition` transition is applied only by
the orchestrator.

**UNDERSTANDING REQUIRED:** no

**UNDERSTANDING REASON:** not_applicable at this investigative stage.

**PASS CRITERIA:** Domain output improves reasoning without changing workflow
state; transition authority remains visibly core-owned.

**FAIL CRITERIA:** A domain skill independently advances, unlocks, completes, or
waives a core condition.

**EVIDENCE TO CAPTURE:** Invoked skill identities, domain recommendations, state
before and after, transition actor, reasoning classifications, and any project
changes.
