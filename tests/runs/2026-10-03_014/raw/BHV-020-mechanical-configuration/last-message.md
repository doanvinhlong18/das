DECISION  
Use the minimal workflow. Task understanding is complete with `READY_FOR_MINIMAL_DECOMPOSITION`; no separate investigation or Understanding Gate is warranted.

EVIDENCE CLASSIFICATION  
- **Fact:** Authoritative local documentation defines a one-to-one key rename.
- **Fact:** Search identifies exactly one in-scope occurrence.
- **Fact:** No secrets, production values, security policy, fallback, or compatibility behavior is affected.
- **Unknowns:** None material or blocking.

STATE EFFECT  
Set task mode to `minimal` and transition from `understanding` to `decomposition`. Implementation remains locked until one concise step records its expected result and verification strategy.

IMPLEMENTATION SCOPE  
Replace only the single old key with the documented new key. Do not change its value, surrounding configuration, documentation, or add compatibility aliases.

VERIFICATION  
After implementation, confirm the old key has no in-scope occurrences, the new key appears at the intended location with the unchanged value, and the configuration remains syntactically valid.

UNDERSTANDING  
Not applicable: this is a documented mechanical configuration rename with no meaningful ownership or design decision.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
None.