**DECISION**  
Do not install the package. Shorter syntax alone does not justify a new dependency.

**EVIDENCE CLASSIFICATION**  
- Fact: The standard library or an existing dependency already supports the transformation.
- Fact: The package is unnecessary for correctness, compatibility, or a known design constraint.
- Fact: Installation would expand the change into manifests and lockfiles.

**STATE EFFECT**  
Keep the active step unchanged; do not authorize dependency or lockfile changes.

**IMPLEMENTATION SCOPE**  
Implement the small transformation using existing project capabilities only.

**VERIFICATION**  
Run the focused behavioral check already defined for the active step. No dependency-specific verification is needed.