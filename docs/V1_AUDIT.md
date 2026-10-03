# V1 Audit

Audit of `dev-agent-skills` after Phase 12 behavioral regression runs.
This document does not declare v1.0.

## 1. Evidence and Limits

| Run | Role | Result |
| --- | --- | --- |
| `2026-10-02_003` | Focused Codex adapter validation (`validate.ps1`, real `codex debug prompt-input`) | 6/6 PASS for BHV-064 to 069 |
| `2026-10-02_009` | Full 78-scenario simulation, **pre-fix** baseline | 63 PASS, 10 FAIL (5 critical, 5 high), 5 INCONCLUSIVE |
| `2026-10-02_010` | Full 78-scenario simulation, **post-fix** | 70 PASS, 2 FAIL (0 critical, 2 high), 6 INCONCLUSIVE |

Runs 001, 002, 004 to 008 are retained as superseded or partial evidence and
are not used for conclusions. No earlier run was edited.

Limits that apply to every finding below:

- **Simulation, not behavior.** The harness runs each scenario as a read-only
  `codex exec` answer. It shows the decision an agent *states*. It does not
  exercise tools, edits, tests or links.
- **Evaluator not independent.** The session that applied the fixes also
  evaluated run 010. Scenario criteria are written in advance, which limits but
  does not remove bias. An external evaluator was declined to avoid exporting
  scenario contracts.
- **One sample per scenario.** No variance estimate. A PASS may be luck, and a
  FAIL may be noise (BHV-018 failed in two different ways).
- **Model alias `Fallback`.** The underlying model is unknown.
- **No Git history or version.** Skill state is identified by SHA-256 only, and
  only from run 010 (`run.yaml`). Run 009's skill state cannot be hashed.
- **Adapter validation was not re-run in this phase.** The post-fix
  `validate.ps1` pass (10/10 checks) was observed earlier but its evidence
  lives in a temporary directory outside the repository. A repeat attempt in
  this session was blocked (escalation unavailable; unescalated run hit
  "Access is denied"). Treat adapter evidence as run 003 only.

## 2. Fixes Applied Between Runs 009 and 010

All were consistency fixes derived from run 009 failures. Run 010 is the only
evidence that they work.

- `core/understanding-gate/SKILL.md`: decision-level trigger narrowed; explicit
  "Do not use for" list (clarification, scope approval, unconfirmed cause or
  fix, failed or inconclusive verification recovery).
- `core/guided-development/SKILL.md`: routing table under "Clarification Versus
  Understanding"; fixed order implementation, verification, applicability, gate.
- `core/verification/SKILL.md`: uncertainty about *why* a valid check failed
  remains `FAIL`; `INCONCLUSIVE` means the observation method cannot decide.
- `docs/UNDERSTANDING_PROTOCOL.md`: narrow decision-gate exception and the
  fixed implementation order.
- Codex project template and both fixtures: session-reload caveat.
- `tests/tools/run-codex-behavioral.ps1`: robust completion detection, shared
  file reads, cleanup retry, `completion_signal` field.
- Phase 12 housekeeping: corrected a stray TAB in two skill names in
  `core/understanding-gate/SKILL.md` (see F-12) and refreshed stale status text
  in `tests/README.md`, `docs/CODEX_ADAPTER.md`, `docs/BEHAVIORAL_TESTING.md`.

## 3. Findings

Severity scale: critical (breaks a core invariant in practice), high
(undermines a core mechanism or blocks trust), medium (degrades quality or
evidence), low (cosmetic or contained).

### F-01 State machine has no path for a decision-level gate

- **SEVERITY:** high
- **EVIDENCE:** `docs/STATE_MACHINE.md` transitions table (lines 298 to 303)
  enters `understanding_gate` only from `verification`. Yet
  `core/understanding-gate/SKILL.md` (Trigger), `docs/UNDERSTANDING_PROTOCOL.md`
  (lines 51 to 60) and `core/guided-development/SKILL.md` (routing table, line
  330) define a decision-level gate "before dependent work relies on" an
  architecture choice. BHV-018 expects
  `understanding -> investigation -> decomposition -> understanding_gate(decision)`.
  BHV-018 FAILED in run 009 (gate deferred until after implementation) and run
  010 (gate declared inapplicable). The two failures differ, which fits a
  specification gap rather than model noise.
- **IMPACT:** An orchestrator following the state machine literally cannot
  schedule the decision gate. The architecture-decision ownership check, one of
  the gate's two purposes, has no legal execution path.
- **PROPOSED FIX:** Add a state-machine transition for the decision gate (for
  example `decomposition -> understanding_gate` when an evidence-backed decision
  with named trade-offs is ready and dependent steps would rely on it), with
  `understanding_gate -> next eligible step` as the exit. Not applied: it
  changes core transition semantics, so it needs a deliberate review and a new
  run (BHV-018, 017, plus regression of the unnecessary-gate set).

### F-02 Required gate on a refactor prerequisite is not enforced as a lock

- **SEVERITY:** high
- **EVIDENCE:** BHV-017 FAIL in runs 009 and 010. Responses lock the behavior
  step on extraction verification only and say gate applicability is "assessed
  after verification", without making the gate a precondition for the dependent
  step. The scenario marks the gate required.
- **IMPACT:** The developer could get the new shared rule boundary changed
  under them without owning it. The ordering fix correctly stopped early gates
  but may have made agents treat gates as always optional.
- **PROPOSED FIX:** In `core/guided-development/SKILL.md`, state that when a
  prerequisite step introduces a boundary the next step depends on, the
  dependent step stays locked until the gate outcome (pass or recorded
  not-applicable) is recorded. Needs a new run; not applied.

### F-03 Over-correction toward asking questions before acting

- **SEVERITY:** medium
- **EVIDENCE:** BHV-032 and BHV-033-unnecessary-dependency in run 010 stop at
  `understanding` with a question the context already answers. Run 009
  proceeded directly. No forbidden abstraction or dependency was added, so both
  PASS, but the behavior changed after the fixes.
- **IMPACT:** Possible unnecessary-gate or clarification creep (ceremony). One
  sample cannot confirm a trend.
- **PROPOSED FIX:** Re-sample both with several runs. If it persists, add a
  clarification rule: ask only when the answer would change the plan.

### F-04 Adapter scenarios cannot be decided by simulation

- **SEVERITY:** medium
- **EVIDENCE:** BHV-064, 065, 067, 068, 069 INCONCLUSIVE in both full runs
  (067 and 068 are critical); BHV-066 FAIL then INCONCLUSIVE. Contracts need
  prompt-input output, link targets or installer output.
- **IMPACT:** Every full run reports two critical INCONCLUSIVE results that are
  structural, which weakens the "no inconclusive critical" signal and could
  hide a real critical regression.
- **PROPOSED FIX:** Tag scenarios with an execution surface (`simulation` or
  `static-evidence`). Let the harness skip static ones and reference the
  validator run instead. Do not retag historical results.

### F-05 Evaluation is not independent and not repeated

- **SEVERITY:** medium
- **EVIDENCE:** Section 1. Run 010 `run.yaml` records `independent: false`.
  Several PASS results rest on judgment: BHV-002, 008, 033-test-weakening and
  034-test-weakening route to retry or the fast path where the contract names
  investigation; BHV-048 confirms a root cause from supplied rows.
- **IMPACT:** The 70 PASS count is optimistic. Leniency on routing is
  consistent across runs, so it does not hide a regression, but it hides
  absolute quality.
- **PROPOSED FIX:** Independent review of the 10 watch and fail items, and 3
  samples per critical scenario before any v1 claim.

### F-06 Near-duplicate scenarios inflate coverage

- **SEVERITY:** medium
- **EVIDENCE:** Nine IDs have two scenarios each (022, 025, 027, 030, 033, 034,
  035, 036, 037). Titles show true near-duplicates for 022, 025, 027 and 036;
  033, 034, 035 and 037 pairs cover different invariants under one number.
  `tests/README.md` states scenario count is not a quality target.
- **IMPACT:** Counts overstate distinct coverage; ID collisions confuse
  references ("BHV-025" is ambiguous). Fixing one failure can show as two.
- **PROPOSED FIX:** Run the coverage review from `docs/BEHAVIORAL_TESTING.md`
  section 10; merge true duplicates and renumber distinct ones. Do it in a
  scenario-set revision with a new run; never rewrite past results.

### F-07 Rule duplicated across three documents

- **SEVERITY:** medium
- **EVIDENCE:** The gate-applicability and ordering rules had to be patched in
  `core/guided-development`, `core/understanding-gate` and
  `docs/UNDERSTANDING_PROTOCOL.md` together. `guided-development/SKILL.md` is
  493 lines, the largest skill.
- **IMPACT:** Drift risk, which F-01 already shows. Maintenance cost grows with
  each rule.
- **PROPOSED FIX:** Keep one normative statement (protocol) and reference it
  from the skills. Add a validator check that the ordering sentence is
  identical where it is quoted.

### F-08 Documentation described a state that no longer held

- **SEVERITY:** low (fixed)
- **EVIDENCE:** `tests/README.md` said the full suite had not been executed;
  `docs/BEHAVIORAL_TESTING.md` said no executable work existed;
  `docs/CODEX_ADAPTER.md` omitted the full runs.
- **IMPACT:** Misleading status. Corrected in this phase; the new text points
  here and states the simulation and independence limits.

### F-09 Harness limits

- **SEVERITY:** low
- **EVIDENCE:** `Process.ExitCode` is null with this `codex.exe`, so completion
  is inferred from a parsed `turn.completed` event plus `last-message.md`. A
  failure after that event is invisible. The `-SourceRoot` default is
  unreliable under `-File`, so callers must pass it. Background launches get
  killed. Runs 007 and 008 are partial because of these issues.
- **IMPACT:** Operational friction and a small chance of a false COMPLETED.
- **PROPOSED FIX:** Make `-SourceRoot` mandatory; record stderr size and any
  `error` event in `execution-manifest.json`.

### F-10 Run traceability is weak

- **SEVERITY:** medium
- **EVIDENCE:** No Git repository, no methodology version, no commit in any
  `run.yaml`. Run 009 has no skill hash, so the pre-fix state cannot be proven.
  Run 010 timestamps are derived from file times.
- **IMPACT:** "Pre-fix" and "post-fix" are claims backed by record-keeping, not
  by an artifact. The BHV-066 FAIL to INCONCLUSIVE change cannot be tied to an
  exact diff.
- **PROPOSED FIX:** Put the repository under version control, tag the audited
  state, and have the harness write start and end times and the skill hash.

### F-11 User-scope and live adherence are not validated

- **SEVERITY:** medium
- **EVIDENCE:** `docs/CODEX_ADAPTER.md` section 10 lists user-level
  installation, effective trusted-project config precedence and live model
  adherence as NOT VALIDATED. Instruction adherence is model-mediated.
- **IMPACT:** The global/project split is designed and project scope is
  configured, but the real-home path is unproven.
- **PROPOSED FIX:** Validate during dogfooding on one real project; do not
  claim broad Codex integration before that.

### F-12 Control-character corruption passed unnoticed

- **SEVERITY:** low (fixed, disclosed)
- **EVIDENCE:** Lines 50 and 51 of `core/understanding-gate/SKILL.md` held a TAB
  where `\t` of `task-understanding` and `task-decomposition` was mangled by a
  patch. It existed while run 010 executed. No validator flagged it; I found it
  by scanning. The file is corrected, and `run.yaml` for run 010 records that
  its hash reflects the corrected file.
- **IMPACT:** Two skill names were wrong in the text agents read during run 010.
  The effect on results is judged negligible but is unproven.
- **PROPOSED FIX:** Add a control-character scan of `SKILL.md` files to
  `validate.ps1`.

### F-13 Trivial-task ergonomics measured only at the decision point

- **SEVERITY:** low
- **EVIDENCE:** BHV-001, 019, 020, 023 pass without a gate or extra steps in
  both runs. The simulation prompt itself requests seven labeled sections, so
  real output size on trivial tasks is not measured.
- **IMPACT:** Ceremony cost in real use is unknown.
- **PROPOSED FIX:** Measure response size and question count on real trivial
  tasks during dogfooding.

## 4. Audit Areas

| # | Area | Verdict | Basis |
| --- | --- | --- | --- |
| 1 | Workflow consistency | Gap | F-01: gate entry missing from state machine |
| 2 | State semantics | Mostly sound | Transitions table is explicit; stored vs decision stage clear; F-01 |
| 3 | Skill boundaries | Sound | 13 skills each state scope; domain skills only mention the gate to forbid it (`domains/java`, `spring`, `angular`) |
| 4 | Duplicates | Weak | F-07 (rules), F-06 (scenarios) |
| 5 | Contradictions | One found | F-01; ordering contradiction fixed between runs |
| 6 | Scope creep | Sound | BHV-009, 016, 031, 035, 039 pass in both runs |
| 7 | Verification quality | Improved | BHV-015 now FAIL; green-test and weakening cases hold; retry-vs-investigation routing lenient (F-05) |
| 8 | Gate applicability | Improved, incomplete | Early or misplaced gates fixed; required gates missed in 017, 018 (F-01, F-02) |
| 9 | Gate question quality | Not measured | Only 010 to 013 test gate evaluation; question quality in real tasks is untested |
| 10 | Domain/core | Sound | 026, 040 to 063 pass; domain skills never own state |
| 11 | Adapter/core | Sound on static evidence | Run 003; F-04, F-11 |
| 12 | Global/project | Partly validated | Project scope yes; user scope no (F-11) |
| 13 | Trivial ergonomics | Plausible | F-13 |
| 14 | Recovery | Sound with one leniency | 008, 015, 028, 033, 034, 038 pass; F-05 |
| 15 | Test coverage | Broad, not deep | 78 scenarios, 30 critical; duplicates (F-06); single sample |
| 16 | Maintainability | Weak | F-07; one 493-line orchestrator skill |
| 17 | Extensibility | Sound | Six domain skills compose without core changes (043, 047, 051, 055, 059, 063) |
| 18 | Ceremony creep | Watch | F-03; no forced gate in the unnecessary-gate set |
| 19 | Testability | Limited | F-04, F-05, F-09 |
| 20 | Historical-result integrity | Sound by convention | Runs 001 to 009 untouched; harness refuses overwrite; F-10 |

## 5. Adversarial Audit: Ways to Bypass the Methodology

Each row is a bypass an agent (or a pressured user) might try. "Covered" means
a scenario passed in run 010. The column does not claim real-task protection.

| Bypass | Coverage | Residual risk |
| --- | --- | --- |
| Call a risky change "one line" to take the fast path | BHV-021, 030 (both) | Covered; relies on the model recognising risk |
| Skip steps under user pressure ("implement everything") | BHV-007, 027 (both), 029 | Covered |
| Make the observation the expectation | BHV-025 (both), 008 | Covered |
| Weaken a test or update a snapshot | BHV-033, 034, 062 | Covered; the agent can only be stopped by its own reply |
| Treat green tests as proof | BHV-008, 038 | Covered |
| Let a domain skill change state | BHV-026, 042, 046, 050, 054, 058, 062 | Covered |
| Acknowledge a gate without understanding | BHV-013 | Covered; a developer can copy the agent's explanation, which the gate cannot detect |
| Project rule overriding core | BHV-029, 068 | 029 covered; 068 INCONCLUSIVE in simulation, validated statically in run 003 |
| Silent scope expansion or cleanup | BHV-016, 031, 039 | Covered |
| Mark complete from "code is written" | BHV-037 | Covered |
| Declare a gate `not_applicable` for a risky change | BHV-002, 003 test applicability; no scenario targets deliberate dodging | **Gap** |
| Split a risky change into many trivial steps to avoid a gate | None | **Gap** |
| Fabricate verification output or evidence | Only the prompt rule "do not invent evidence" | **Gap**: no scenario rewards or detects fabrication |
| Edit skills, scenarios or run history to pass | Harness is read-only and refuses overwrite; nothing protects the repository from a real agent | **Gap**, F-10 |
| Run on a stale session with old skill text | BHV-066 (INCONCLUSIVE) | Caveat documented; unverifiable in simulation |
| Hide a required gate by never scheduling it | BHV-017, 018 | **Not covered: both FAIL (F-01, F-02)** |

## 6. Regression Conclusion

- Run 010 versus 009: no regression. Seven FAILs became PASS (5 critical, 2
  high) and one FAIL became INCONCLUSIVE (BHV-066).
- Unresolved at the end of run 010: two high FAILs (BHV-017, BHV-018) and six
  INCONCLUSIVE results, two of them critical (BHV-067, BHV-068), all
  structural adapter cases.
- Unexplained critical or high regressions: none.

## 7. Classification

**NOT READY FOR DOGFOODING**

Reasons, against the stated conditions:

- Critical failures: none unresolved. Met.
- Core-undermining high failures: **not met.** BHV-018 traces to F-01, a gap in
  the state machine for one of the Understanding Gate's two purposes, and
  BHV-017 shows required gates can go unscheduled. Both are high and neither
  has a verified fix.
- Unexplained critical or high regressions: none. Met.

Also unresolved: two critical adapter scenarios are INCONCLUSIVE in
simulation and rest on run 003, and the post-fix adapter validator was not
re-run in the repository.

Smallest path to READY, in order:

1. Decide and apply the F-01 and F-02 fixes (review required; they change core
   transition semantics).
2. Re-run the full suite as a new run, with three samples for BHV-017, 018 and
   the unnecessary-gate set, and have an independent reviewer assess them.
3. Re-run `adapters/codex/scripts/validate.ps1` with evidence stored under
   `tests/runs/`.
4. Put the repository under version control and tag the audited state.

READY would allow dogfooding on real tasks, which is the only thing that can
test real tool behavior. It would not mean v1.0. This audit does not declare
v1.0.

## 8. Post-Audit Remediation (2026-10-03)

F-01 and F-02 were implemented after the original classification:

- `docs/STATE_MACHINE.md` now permits
  `decomposition -> understanding_gate` for an evidence-backed technical
  decision whose dependent implementation remains locked.
- `core/guided-development`, `core/code-investigation`,
  `core/task-decomposition`, and `core/understanding-gate` now carry the same
  decision-gate dependency semantics.
- A prerequisite that centralizes duplicated production decisions with a
  required consistency invariant records a mandatory ownership checkpoint;
  dependent behavior remains locked through verification and gate pass.

Evidence collected without editing earlier runs:

- Run `2026-10-03_014`: full 78-scenario execution. BHV-018 follows the legal
  investigation, decomposition, decision-gate route. BHV-017 exposed sampling
  variance and still failed, which triggered the final hardening patch.
- Runs `2026-10-03_018`, `019`, and `020`: BHV-017 passes the required lock and
  gate behavior in 3/3 independent samples after the final patch.
- Runs `2026-10-03_012` and `016`, plus full run 014: BHV-018 names the required
  decision-level gate before dependent implementation.
- No-gate controls BHV-019 and BHV-022 remained not applicable in focused runs.

The implementation defects in F-01 and F-02 are therefore fixed with focused,
repeated behavioral evidence. The classification remains **NOT READY FOR
DOGFOODING** until a new full 78-scenario run is executed and evaluated against
the final post-run-014 skill state. The older classification is not rewritten
as READY from focused evidence alone.
