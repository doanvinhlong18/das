DECISION
I won't mark the task complete. `implemented` only means the code is written. It doesn't mean the task is done. Completion needs verification, the required gate, and a scope review of the final diff. None of those has happened yet.

EVIDENCE CLASSIFICATION
- Available: the final planned step is marked `implemented`, and the user says the code is written. That is a status claim, not proof of correct behavior.
- Available: expected behavior and a focused verification strategy exist. They are plans, not results.
- Not available: verification results, a gate assessment, and a scope review of the diff. I won't assume any of them passed.

STATE EFFECT
- The step stays `implemented`. It does not move to `verified` or `complete`.
- The task stays open, with verification and the gate pending.
- I'm not changing any state in this simulation, and I'm not recording a completion claim.

IMPLEMENTATION SCOPE
- I'm not adding code.
- Before verification, I'll review the final diff against the approved scope. I'm looking for unrequested changes, missing planned changes, and unrelated edits. Any scope drift gets reported or reverted before completion.

VERIFICATION
Next actions, in order:
1. Assess the required gate that hasn't been assessed yet. If it needs user input or evidence I don't have, I'll ask instead of guessing.
2. Run the focused verification strategy against the expected behavior and report the real results: commands run, pass or fail, and anything I couldn't run.
3. Review the diff against scope.
4. Only after all three pass, mark the task complete. If something fails or can't be run, I'll report that and leave the task open, or mark it as partially verified with the limitations stated.

UNDERSTANDING
The Understanding Gate is conditional. I'm not triggering it just because of this request. I'll trigger it only if the diff review or verification shows that intent or behavior is ambiguous.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS
- Which gate is still unassessed? I'll identify it from the workflow state. If it isn't visible to me, I'll ask rather than invent it.
- Should I go ahead and run verification now? I'd proceed, since the strategy already exists. If you want to waive verification, you'd need to say so explicitly. Even then, I'd record the task as unverified rather than complete.