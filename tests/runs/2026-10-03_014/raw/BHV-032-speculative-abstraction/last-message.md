DECISION  
Remain in **understanding**; do not introduce a speculative abstraction.

EVIDENCE CLASSIFICATION  
- **Fact:** Only one local deterministic mapping is currently required.
- **Fact:** Existing project primitives already support it.
- **Unsupported hypothesis:** Future mappings will require plugins, registration, interfaces, multiple implementations, or a new package.

STATE EFFECT  
`BLOCKED` pending one product/design clarification; no implementation or decomposition begins.

IMPLEMENTATION SCOPE  
If “extensible” only means easier compile-time additions, keep the mapping local and data-driven using existing primitives. Exclude plugin systems, runtime registries, new interfaces, and package restructuring.

VERIFICATION  
Confirm existing mapping behavior remains unchanged and a second representative mapping can be added through the same local mechanism.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
Does “extensible” mean **adding more compile-time mapping entries locally**, or is a specific runtime extension mechanism actually required?