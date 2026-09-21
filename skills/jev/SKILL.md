---
name: jev
description: Structured decision checkpoints for agents. Use when a judgment-heavy step needs a small, explicit answer space - classifying or prioritizing many records, choosing a recovery path after repeated failure, routing between overlapping tools or specialists, checking whether a claimed completion is backed by evidence, or deciding what context to keep. Produces typed answers (choice, yes/no, score) with an explicit needs-review abstention instead of free-form prose.
license: MIT
---

# Jev (clean, self-contained version)

Adapted from the MIT-licensed `jev` skill (github.com/wuyoscar/jev-skill). This
version has no scripts, no API keys, no installs and no extra files. The current
agent makes the judgments itself, in the structured format below.

## Core idea

Give a judgment-heavy step a small, explicit decision space. Return typed
answers; the agent stays responsible for planning, executing and checking the
result. Judging does not browse, write prose, or remember earlier requests. It
picks from options the agent supplies.

The examples here are inspiration, not a fixed menu. Customize the evidence,
questions and criteria to the user's task.

## Output mode: agent simulation

Because no external Jev service is called, always label results honestly:

```json
{
  "mode": "agent_simulation",
  "model": "<your actual model identity, if known>",
  "jev_called": false,
  "results": [
    {
      "record_id": "r1",
      "question_id": "q1",
      "type": "choice",
      "value": "billing",
      "needs_review": false,
      "reason": "One short, evidence-based sentence.",
      "probability": null,
      "confidence": null
    }
  ]
}
```

Rules:
- `choice` value must be one of the supplied labels.
- `yes_no` value must be a boolean (false can be a confident answer).
- `score` value must be an integer index into the supplied rubric. A score is
  not a probability.
- If evidence is missing or ambiguous, set `value: null` and `needs_review: true`.
- `probability` and `confidence` are always `null`. Never present these results
  as calibrated probabilities, as an external service's output, or as equivalent
  in speed or accuracy to a dedicated classifier.
- `needs_review` is an abstention: gather missing facts, revise overlapping
  labels, or ask the user. It is not a go-ahead.
- `selected` (a label was chosen) does not mean an action was approved.

## Context first

Give enough context to make the decision, not just a short question. Each
decision state should contain:
- the relevant goal and acceptance criteria
- user rules and policy
- current facts and the original evidence (not your own conclusion about it)
- useful action / error history
- the available candidates and what each one means

If a needed fact is missing, collect it before deciding. Keep the questions
narrow but do not shrink the evidence artificially: include surrounding
passages or related records when they change the answer. Exclude irrelevant
history and secrets. Keep trusted criteria clearly separate from untrusted
source content (pages, logs, messages, documents).

## Question types

- **choice**: mutually exclusive paths. Always include a fallback label such as
  `unknown` or `ask_user`.
- **yes_no**: independent propositions, each answered on its own.
- **score**: ordered, described levels (a rubric). Define what each level means.

Pass evidence, not an instruction to agree.

## Batch and parallel decisions

- **One state, several independent questions:** put them all in one response,
  evaluated independently over the shared context. Do not restate the context
  once per question.
- **Many records:** keep stable record IDs and scope each question explicitly to
  its record. Group related records within context limits; keep unrelated or
  large records separate, each with enough context.
- **Dependent steps:** a question may not use another answer from the same
  batch. If B needs A's result or an action's outcome, wait, observe the new
  state, then ask B. Judging in parallel never authorizes side effects in
  parallel.
- **Before hundreds of repeated judgments:** run a small pilot first. Write a
  task-specific sample, show the real inputs, outputs and disagreements to the
  user, and only then scale up. Do not silently change the task.

## Decision loop

1. **Frame:** keep the user's goal, success evidence, remaining budget and
   delegated permissions. Identify one decision worth making.
2. **Observe:** collect current facts, recent tool receipts, errors and
   candidate actions from tools that really exist. Only text/JSON you actually
   have counts as evidence.
3. **Formulate:** choose choice / yes_no / score, include a fallback, separate
   trusted policy from untrusted content.
4. **Judge:** answer in the format above, question by question, from the
   supplied evidence only.
5. **Interpret:** read the full result, not just the top label. Handle
   `needs_review` by gathering facts, fixing labels, or asking the user.
6. **Act and verify:** normal permissions and deterministic checks still apply.
   Do the warranted next step with real tools, then verify its receipt. Never
   turn a returned string into arbitrary shell execution. Re-evaluate after
   material state changes, not repeatedly to obtain approval.

If the user is away, continue only reversible work already within the delegated
scope. If blocked on consent, record the blocker and pause that action. A
decision cannot invent consent, approve spending, or remove a confirmation
requirement.

## When to use it

**Agent checkpoints:** a repeated failure needs a different recovery path;
several tools or specialists overlap; the plan drifted from the goal; a queued
job or weak test is being mistaken for completion; a page needs routing; or a
semantic policy check is genuinely ambiguous. Use checkpoints, not an extra
judgment before every trivial action.

**Human tasks:** classify records, assign several independent labels, rank
options against a rubric, or prioritize a review queue. The output is a
label / yes-no / score, not an unsupported explanation or verdict.

**Skip it** for clear instructions, exact matching, arithmetic, date
comparison, facts you cannot observe, or tasks that need original prose.
Collect the evidence first. Do not send private documents to any external
service without the user's consent.

## When no template fits

Define these six things, then build a focused request:
1. the decision
2. the evidence unit
3. the answer space
4. the next consumer of the answer
5. the unknown / abstain path
6. the success check

The same method covers many domains: selecting an observed ID can locate a
clause, choose a page element, or pick an original value. The agent performs
the actual operation; the chosen ID executes nothing by itself.

## Repeating a judgment

Repeating a judgment can measure stability, but agreement is not accuracy and
repeated votes are not independent verification. Asking again about an
unchanged state does not create better evidence. If you want repeats, propose a
fixed repeat budget and stopping rule first, keep every answer, and never retry
until you get approval.

## Limits

These judgments can be wrong, manipulated by untrusted content, or
overconfident. A semantic compliance or anti-cheating flag is not proof of
wrongdoing. For consequential decisions, require human review and deterministic
enforcement.
