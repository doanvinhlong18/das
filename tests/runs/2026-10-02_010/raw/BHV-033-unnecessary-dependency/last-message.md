**DECISION**  
Do not install the package. Treat it as a proposed solution, not a requirement.

**EVIDENCE CLASSIFICATION**  
- Fact: The parse/transformation is already supported by the standard library or an existing dependency.
- Fact: The package adds no correctness, compatibility, or design benefit.
- Fact: Installation would expand the change into manifests and lockfiles.
- Preference: Making a few lines shorter.

**STATE EFFECT**  
Remain in task understanding until the actual transformation and expected behavior are identified. No dependency or repository changes are authorized.

**IMPLEMENTATION SCOPE**  
Use the existing standard-library or project-supported capability. Adding the package is out of scope unless a concrete technical constraint justifies that expansion.

**VERIFICATION**  
Verify the transformation’s behavior with the existing implementation path; shorter source code alone is not a success criterion.

**QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS**  
Which specific transformation should be implemented?