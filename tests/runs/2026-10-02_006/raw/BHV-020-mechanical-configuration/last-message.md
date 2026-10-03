DECISION

Use the minimal fast path. The evidence supports `READY_FOR_MINIMAL_DECOMPOSITION`; no separate investigation or clarification is needed.

EVIDENCE CLASSIFICATION

Facts: authoritative documentation confirms a one-to-one rename; exactly one in-scope occurrence exists; no sensitive, production, compatibility, or behavioral concerns are involved. No hypotheses or unknowns remain.

STATE EFFECT

Transition from `understanding` to `decomposition` in `minimal` mode. No files are modified in this read-only simulation.

IMPLEMENTATION SCOPE

One logical step: replace only the old key in the local development profile with the documented new key. Do not change its value or add a fallback.

VERIFICATION

After implementation, confirm the old key is absent, the new key occurs once in scope, and the configuration remains valid.

UNDERSTANDING

Assess only after verification; this mechanical rename is expected to require no Understanding Gate.