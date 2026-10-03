DECISION  
Use the lightweight path: `task-understanding` returns `READY_FOR_MINIMAL_DECOMPOSITION`. This is a local, mechanical, low-risk documentation correction with no software-behavior or architectural decision.

EVIDENCE CLASSIFICATION  
- Fact: authoritative setup commands and link targets are known.
- Fact: focused documentation validation can establish correctness.
- Unknowns: none currently blocking.

STATE EFFECT  
Transition from `understanding` to `decomposition`; do not invoke investigation or an Understanding Gate.

IMPLEMENTATION SCOPE  
Update only the setup guide’s outdated commands and broken links. Exclude application code, configuration, dependencies, architecture, and runtime behavior.

VERIFICATION  
Check that documented commands exactly match the authoritative commands and that all updated links resolve to the authoritative targets.

UNDERSTANDING  
No developer-understanding gate applies because no meaningful technical decision or trade-off is being accepted.