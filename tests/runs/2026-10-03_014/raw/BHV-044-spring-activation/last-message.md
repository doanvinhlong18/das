**DECISION**  
Continue `code-investigation`; do not name a bean until runtime selection evidence identifies it.

**UNDERSTANDING**  
Determine the concrete bean injected in production and the local test, then explain which condition, profile, or effective property caused the difference.

**EVIDENCE CLASSIFICATION**  
- **FACT:** Conditional definitions, profiles, property sources, startup logs, and Spring Boot version are available evidence categories.
- **UNKNOWN:** The winning bean definition, active conditions, effective property values, and injection-point qualifiers.
- **HYPOTHESIS:** Production and test activate different bean definitions because their profiles or effective property sources differ.
- **Would confirm or falsify:** Compare each environment’s condition-evaluation report, active profiles, property-source precedence, and registered bean type/name at the injection point.

**STATE EFFECT**  
Remain in `investigation`; no root cause is confirmed and no transition is justified.

**IMPLEMENTATION SCOPE**  
Read-only inspection only. No code or configuration changes.

**VERIFICATION**  
Confirm the selected bean from direct container evidence—startup condition report, bean registry/Actuator diagnostics, or logged runtime class including any proxy—rather than inferring it from annotations.