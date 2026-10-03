**DECISION**  
Use the trivial fast path and proceed to minimal decomposition without additional investigation or user clarification.

**EVIDENCE CLASSIFICATION**  
- Fact: Authoritative local documentation defines a one-to-one key rename.
- Fact: Search identified exactly one in-scope occurrence.
- Fact: No secrets, production values, security policy, fallback, or compatibility behavior is involved.
- Unknowns: None blocking.

**UNDERSTANDING**  
- Requested: Replace the obsolete local-development configuration key.
- Expected: The profile uses the documented new key with its existing value unchanged.
- Scope: One configuration-key substitution only; no fallback, value, or unrelated configuration changes.

**STATE EFFECT**  
Set `mode: minimal`; transition from understanding to minimal decomposition.

**IMPLEMENTATION SCOPE**  
Create one logical step: replace the single old key with the documented new key.

**VERIFICATION**  
After implementation, confirm the old key has no in-scope occurrences and the new key appears once with the unchanged value. Understanding Gate applicability should be recorded as not applicable.