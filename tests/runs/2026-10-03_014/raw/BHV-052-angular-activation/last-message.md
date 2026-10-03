DECISION  
Continue `code-investigation` with Angular advisory guidance; do not implement or decompose yet.

EVIDENCE CLASSIFICATION  
- **FACT:** Component data changes, while the rendered list remains stale.  
- **HYPOTHESES:** In-place mutation is not creating the notification required by `OnPush`, signals, or the observable/template boundary; execution outside Angular change detection is an alternative.  
- No root cause is confirmed yet.

STATE EFFECT  
Remain in `investigation`. No files modified.

IMPLEMENTATION SCOPE  
None. Trace the mutation through component state, signal/observable emissions, change-detection strategy, template dependency, browser evidence, and version-specific Angular behavior.

VERIFICATION  
Use the available evidence to distinguish mutation-versus-replacement, missing signal notification/emission, zone boundary, and template-guard explanations. Confirm causality only when one mechanism explains both the state change and stale DOM while alternatives are contradicted.

UNDERSTANDING  
The requested behavior is for the rendered list to reflect the component’s changed data after the mutation.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS  
No developer question yet; the stated evidence is available and should be inspected before requesting clarification.