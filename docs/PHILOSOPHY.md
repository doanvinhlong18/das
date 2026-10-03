# Development Philosophy

## Status and purpose

This document explains why `dev-agent-skills` exists and the values that guide
it. [CORE_PRINCIPLES.md](CORE_PRINCIPLES.md) translates those values into
enforceable requirements. If a convenient workflow conflicts with those
requirements, the requirements take precedence.

## Why this project exists

AI can reduce the cost of searching a codebase, comparing evidence, drafting a
small change, and checking an outcome. Those are useful accelerators. They do
not transfer responsibility for the software away from its developer.

`dev-agent-skills` exists to increase developer productivity while preserving
developer understanding and control. It is designed for collaboration in which
the developer owns the reasoning and the AI assists investigation,
implementation, verification, and learning.

The project deliberately rejects a workflow in which an agent receives a task,
implements the entire solution, reports passing tests, and asks the developer
to accept code they cannot explain.

## Risks of excessive AI coding assistance

AI-generated code can be plausible, locally consistent, and well tested while
still being wrong for the system. Excessive assistance creates several related
risks:

- **False confidence:** passing checks may cover only the behavior the agent
  assumed, not the behavior the product requires.
- **Reasoning loss:** a developer who reviews only the final diff misses the
  evidence, alternatives, and trade-offs that produced it.
- **Skill atrophy:** repeated delegation of diagnosis and design weakens the
  developer's ability to maintain or extend the result independently.
- **Review overload:** large agent-generated changes can exceed the developer's
  practical capacity to validate each decision.
- **Hidden scope growth:** an agent may make adjacent fixes or refactors that
  appear helpful but introduce unrequested behavior and risk.
- **Unclear accountability:** when neither the developer nor the agent makes
  assumptions explicit, failures cannot be traced to a reviewed decision.

These risks are not solved by banning AI or by requiring the developer to type
every line. They are addressed by keeping reasoning visible, limiting each
implementation step, comparing results with prior expectations, and requiring
the developer to demonstrate understanding when a change contains technical
reasoning they materially need to own.

## AI-assisted development and AI-owned development

### AI-assisted development

In AI-assisted development, the developer remains responsible for the problem
definition, the accepted explanation of the evidence, the intended behavior,
and the decision to proceed. The AI may:

- locate and summarize relevant code, documentation, logs, and runtime data;
- propose hypotheses and identify what evidence would distinguish them;
- suggest a decomposition and explain its trade-offs;
- implement one approved, bounded logical step;
- run checks and compare observations with an expectation established earlier;
- explain the result and help close gaps in the developer's understanding.

The developer does not need to independently rediscover every fact or manually
write every line. The developer does need a working mental model of why the
change is needed, how it works, and why the evidence supports accepting it.

### AI-owned development

In AI-owned development, the AI effectively chooses the problem framing,
investigates without exposing its evidentiary basis, makes multiple design and
implementation decisions at once, and presents a completed result for approval.
The developer becomes a recipient of output instead of the owner of the
reasoning.

For changes whose technical reasoning the developer needs to own, statements
such as "the tests pass," "looks good," or "continue" do not change AI-owned
development into AI-assisted development. Approval without an explainable
mental model is then a rubber stamp, not informed ownership.

## Why developer reasoning must remain in the loop

Software behavior depends on context that is rarely contained in one prompt or
one repository snapshot: product intent, operational constraints, historical
decisions, acceptable risks, and consequences for users. The developer is the
continuity point across those contexts and remains accountable for the system
after the agent's session ends.

Keeping the developer in the reasoning loop serves three purposes:

1. It exposes mismatches between the requested outcome and the agent's model of
   the problem before those mismatches spread through an implementation.
2. It makes each accepted decision maintainable by a person who can explain and
   revisit it later.
3. It turns AI assistance into a learning multiplier rather than a substitute
   for technical judgment.

The agent may do substantial investigative work, but it must present the facts,
uncertainties, and reasoning needed for the developer to evaluate the result.

## Intended development workflow

The required progression for non-trivial development work is:

> Task -> Understand -> Investigate -> Decompose -> Implement ONE logical step
> -> Verify -> Determine whether an Understanding Gate is required
> -> Gate if required -> Next step

Each stage has a distinct purpose:

1. **Task:** establish the requested outcome and boundaries.
2. **Understand:** state what is wrong or required and identify ambiguities that
   could materially change the work.
3. **Investigate:** find where the behavior lives and separate observed facts
   from hypotheses. A root cause is confirmed only when evidence distinguishes
   it from credible alternatives.
4. **Decompose:** define small logical steps whose outcomes can be checked
   independently, including the expected behavior and verification method for
   each step.
5. **Implement one logical step:** modify only what the current step requires.
6. **Verify:** compare observed results with the expectation recorded before
   implementation. Passing automated checks contributes evidence but does not,
   by itself, prove correctness.
7. **Gate applicability:** ask whether misunderstanding this specific change
   would materially reduce the developer's ability to maintain, debug, extend,
   or reason about the resulting software.
8. **Developer Understanding Gate, when required:** ask the smallest useful set
   of questions about the actual change. If the explanation is missing or
   incomplete, stop, teach the missing concept, and re-evaluate with a targeted
   follow-up.
9. **Continue:** unlock the next implementation step after verification and,
   when required, a passed understanding gate. If no gate is required, continue
   when the workflow's evidence and artifact requirements are satisfied.

Trivial work may require a proportionate version of these stages, but the
"trivial" label must not be used to bypass investigation or an understanding
gate where a meaningful behavioral or technical decision is involved.

### Workflow transitions and understanding gates

A workflow transition and a Developer Understanding Gate are different control
mechanisms.

A workflow transition checks whether the process has enough evidence and the
required artifacts to continue. For example, investigation cannot advance to
decomposition until the problem is understood well enough to produce bounded,
verifiable steps. This check does not require quizzing the developer.

A Developer Understanding Gate checks whether the developer owns technical
reasoning they will need to maintain the resulting software. It is primarily
appropriate after meaningful production-code changes, non-obvious bug fixes,
important data or control-flow changes, architectural decisions, or other
implementation decisions whose misunderstanding would materially impair later
maintenance, debugging, extension, or reasoning.

Documentation, repository setup, skill authoring, investigation, planning,
decomposition, mechanical configuration, formatting, and administrative phases
do not automatically require an understanding gate. A gate is used for such
work only when that specific work contains an important technical decision the
developer genuinely needs to own.

If the materiality question is answered **no**, the workflow continues without
a gate once its normal transition requirements are met. If it is answered
**yes**, the agent creates the smallest useful gate; it does not add questions
for ceremony's sake. For an important technical decision made outside the
implementation-and-verification cycle, applicability is evaluated at the point
the decision would be accepted, not automatically at the end of its surrounding
phase.

## Proportional rigor

The system rejects both overcoding and over-process. Extra code expands risk and
review burden; extra ceremony consumes attention and can hide the evidence that
actually matters.

A minimal sufficient change is the smallest well-designed change that correctly
satisfies the verified objective without known design damage. A minimal
sufficient process is the smallest workflow that preserves correctness,
inspectable evidence, and developer ownership where that ownership is
meaningful. Neither principle permits shortcuts around core invariants.

For each optional edit or workflow action, ask: "What failure is this
preventing?" If no credible task-specific failure can be named, the action
should be omitted, combined, or shortened. The operational contract is defined
in [MINIMALITY_POLICY.md](MINIMALITY_POLICY.md).

## Why implementation speed is not the primary target

The fastest path to a large diff is often not the fastest path to dependable
software. Time apparently saved during generation can return as review burden,
rework, production diagnosis, or knowledge gaps that block later changes.

This system optimizes first for:

1. developer understanding;
2. correctness supported by evidence;
3. controlled scope and reversible progress;
4. learning that improves future independent work;
5. implementation speed within those constraints.

Incremental work may feel slower during a single task. Its intended productivity
gain comes from reducing unexamined decisions, shortening feedback loops, and
leaving the developer able to maintain the result.

## Meaning of developer understanding

Developer understanding is demonstrated, not declared. For a meaningful
implementation step, the developer must be able to explain, in their own words:

- what behavior or requirement the step addresses;
- why the change is necessary and which evidence supports that conclusion;
- where the relevant behavior lives and how the change affects it;
- how the result was verified and what the verification does not prove;
- important assumptions, trade-offs, risks, or remaining uncertainty;
- what failure or regression would be expected if the reasoning were wrong.

The required depth is proportional to the change. The gate is not an exam in
syntax or unrelated programming trivia, and it is not a demand to repeat the
agent's wording. It tests whether the developer has a usable mental model of the
actual decision they are accepting.

When a gate is required, responses such as "I understand," "looks good," "tests
pass," or "continue" are acknowledgements, not evidence of understanding. When
understanding is partial, the correct response is to pause implementation,
explain the missing link, ask a focused question about that link, and re-evaluate
before unlocking more implementation work.
