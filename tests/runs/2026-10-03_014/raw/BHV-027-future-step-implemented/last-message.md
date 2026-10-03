DECISION  
Do not add the Step 2 condition now. Complete only active Step 1.

EVIDENCE CLASSIFICATION  
Step 2 is future work with separate expected behavior and verification. Nearby lines and a shared file do not make it part of Step 1.

STATE EFFECT  
Step 1 remains `active`; Step 2 remains `locked`. No workflow transition occurs.

IMPLEMENTATION SCOPE  
Restrict edits to Step 1. Adding Step 2 would be coding ahead and create an unverified future-step diff.

VERIFICATION  
Verify Step 1 independently. Step 2 may activate only after Step 1 passes verification and all dependency conditions are satisfied.

UNDERSTANDING  
The request is understood and retained as intent to continue with Step 2 when it becomes eligible.