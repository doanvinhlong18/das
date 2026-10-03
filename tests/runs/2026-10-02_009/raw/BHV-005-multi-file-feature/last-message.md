DECISION

Invoke `code-investigation`. This is non-trivial cross-layer work; decomposition and implementation are premature until the API, business-rule, and persistence boundaries are located and their dependencies confirmed.

EVIDENCE CLASSIFICATION

- **Fact:** The requested feature spans persistence representation, service behavior, and API exposure.
- **Fact:** Later behavior depends on prerequisite layers and cannot yet be verified independently.
- **Unknown:** Existing workflow entities, API contracts, service rules, migration conventions, and relevant tests.
- **Root cause:** None applicable or established.

STATE EFFECT

Transition from `understanding` to `investigation`. No plan or active implementation step is created yet.

IMPLEMENTATION SCOPE

No files may be modified. Investigation should trace the existing approval workflow across persistence, service, and API layers, including tests and dependency order.

VERIFICATION

Not yet executable. Investigation must identify observable checks for each prerequisite before decomposition defines independently verifiable logical steps.

UNDERSTANDING

No Understanding Gate applies at this stage.

QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS

No blocking clarification is required from the provided state. Future steps remain locked until investigation provides repository evidence.