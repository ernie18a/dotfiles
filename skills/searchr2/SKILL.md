---
name: searchr2
description: Conduct decision-driven opportunity or research discovery under high uncertainty. Use when a user needs a practical, non-consensus answer about markets, products, strategy, technology, operations, or forecasts; when public commentary may be misleading; or when the work must turn observable signals into falsifiable hypotheses and next experiments rather than a generic research report.
---

# SearchR2

Turn uncertain decisions into an evidence, hypothesis, and experiment loop. Seek information that could change an action, not material that merely explains the topic.

Do not treat public discussion as the object of research. Treat it as one possible signal source. Prefer direct observations of behaviour, constraints, incentives, transactions, workflows, failures, and changes over commentary about them.

## Research contract

Before searching, write a compact contract containing:

- **Decision:** the action, allocation, or choice this work can change.
- **Outcome:** the measurable result and time window that make the action worthwhile.
- **Scope:** geography, actors, market, technical boundary, and exclusions.
- **Loss:** the cost of a false positive, false negative, delay, and inaction.
- **Access:** available first-party data, permitted external sources, tools, budget, and ability to run experiments.
- **Stop rule:** the evidence or experiment result sufficient to choose, defer, or reject.

Reject a request framed only as “what is best,” “what will win,” or “what should I build.” Convert it into a decision contract. State an unresolved contract item rather than inventing it.

## Stage 1: Map observability

Separate the target reality from the narratives about it. Build a signal map with these source classes where relevant:

| Class | Examples | Default evidential use |
|---|---|---|
| First-party behaviour | product events, sales calls, support tickets, interview recordings, churn reasons | demand, friction, willingness to pay |
| Market actions | prices, procurement, hiring, contracts, inventory, lead times, product releases | incentives, capacity, timing |
| Primary records | filings, regulations, datasets, source code, methods, court records | facts, constraints, provenance |
| Direct participants | buyers, operators, suppliers, domain experts | workflow and causal mechanism leads |
| Public commentary | media, blogs, social posts, analyst summaries | vocabulary, hypotheses, discovery leads only |

For every material claim, record which class supports it, who benefits if it is believed, the time and population it covers, and what it fails to observe. Do not count repeated reporting or derivative summaries as independent evidence.

If the necessary signal is not observable through available sources, record an access gap and propose the smallest lawful acquisition or experiment. Do not convert the gap into confidence.

## Stage 2: Build competing hypotheses

Model the opportunity or explanation as a hypothesis tree, not a single answer. Each node must include:

- a precise claim;
- the affected actor and mechanism;
- observable predictions;
- disconfirming observations;
- dependencies and alternative explanations;
- decision impact if true or false.

Generate materially different branches. For opportunity work, test at least the possibility that:

- the problem is real but not expensive enough to solve;
- the buyer, user, and budget owner differ;
- an incumbent workaround is good enough;
- the apparent demand is temporary, regulated, subsidised, or selection-biased;
- the constraint is distribution, trust, integration, timing, or supply rather than product capability;
- no opportunity exists under the stated economics.

Novelty is not a goal by itself. Keep hypotheses that predict observations not already explained by the dominant narrative and that can alter the decision.

## Stage 3: Plan investigations

Treat a query, source pull, interview, analysis, or experiment as an investigation. Select the next investigation by expected decision value:

1. Which unresolved hypothesis could materially change the decision?
2. What observation would most sharply distinguish its branches?
3. Which accessible source or action can produce that observation?
4. Is its expected information value greater than its time, money, and contamination cost?

Prioritise high-impact uncertainty, contradictory evidence, and cheap disconfirmation. Deprioritise searches that only add examples or rhetorical support to an already supported claim.

## Stage 4: Design query portfolios

Do not hand-pick a static list of keywords. For each selected uncertainty, generate a small, diverse portfolio of investigations across relevant axes:

- **entity:** actors, products, locations, institutions, datasets, standards;
- **mechanism:** process steps, inputs, constraints, substitutes, failure modes;
- **behaviour:** complaints, workarounds, abandonment, switching, purchases, hiring, usage;
- **economics:** prices, margins, budgets, procurement, costs, lead times, capacity;
- **time:** before/after a change, cohort, release, regulation, season, event;
- **negative case:** failure, cancellation, rejection, churn, fraud, unmet prediction;
- **provenance:** primary record, original dataset, direct participant, implementation;
- **counterfactual:** opposite claim, competing mechanism, alternative buyer, null hypothesis.

Every planned query or action must state its target uncertainty, expected discriminating observation, preferred source class, and update rule. Reformulate from retrieved evidence: extract entities, mechanisms, missing preconditions, source chains, contradictions, and terminology that could change a branch. Do not reformulate merely for lexical variety.

Use query expansion or semantic retrieval only as candidate generation. Judge candidates by marginal evidence quality, independence, decision relevance, and contradiction potential.

## Stage 5: Acquire and normalise evidence

Create an evidence record for each usable observation:

- identifier and verbatim or reproducible observation;
- source, source class, access date, event date, and provenance chain;
- population, scope, method, incentives, and known limitations;
- hypotheses supported, contradicted, or left unresolved;
- independence from existing evidence;
- confidence in the observation, separate from confidence in its interpretation.

Preserve raw locations or artifacts needed for audit. Label inference explicitly. A claim without linked evidence remains a lead, never a conclusion.

## Stage 6: Attack and update

For each decision-relevant hypothesis, search directly for its strongest invalidator. Check selection effects, survivorship, confounding, reverse causality, timing mismatch, metric gaming, incentive conflict, and missing base rates.

Use adversarial roles only when they pursue distinct evidence targets. Do not use multiple agents to restate the same corpus. Merge branches that depend on the same mechanism or source chain.

Update hypothesis status after each material observation: `supported`, `contradicted`, `uncertain`, `out_of_scope`, or `unobservable`. Retain the update reason and the observation that caused it.

## Stage 7: Convert uncertainty into a test

When web or document evidence cannot decide, design the minimum reversible test that distinguishes the leading hypotheses. Specify:

- target actor and recruitment or acquisition path;
- intervention or observation;
- success, failure, and stop thresholds decided before execution;
- sample or exposure needed for a useful signal;
- cost, ethical, legal, and operational constraints;
- how each result updates the decision.

For commercial opportunities, prefer revealed behaviour—payment, commitment, repeated use, switching cost, response to outreach, or operational adoption—over stated preference. For forecasts and investments, distinguish a causal thesis from a tradable thesis; define time horizon, benchmark, falsifier, and risk limit. Never present a forecast as verified fact.

## Stage 8: Converge and report

Converge only when the decision contract is satisfied, the next investigation has insufficient expected decision value, a decisive experiment is pending, or a required signal is inaccessible. Do not stop because a report appears complete.

Return only:

1. **Decision state:** choose, reject, defer, or test; include scope and confidence.
2. **Evidence that changed the decision:** linked primary observations and independent corroboration.
3. **Competing hypotheses:** surviving branch, strongest alternative, and their discriminators.
4. **Limits:** access gaps, unresolved assumptions, bias risks, and non-transferable scope.
5. **Next highest-value action:** one investigation or experiment, its expected update, and its stop condition.

Do not produce a long narrative, generic best practices, a source-count proxy for confidence, fixed query counts, fixed agent counts, or a claim of creativity. The quality criterion is a better-calibrated next action under real constraints.

## Concrete tooling

For an **automated, replayable, evidence-grounded runtime** that implements this methodology end-to-end, see `/g/app/researchr`. It turns a YAML task contract (decision, outcome, scope, loss, access, stop) into structured output:

- **Observability map** derived from the task's `access` field (gap detection).
- **Competing hypotheses** generated from the `decision` and `outcome` fields (at least two branches with predictions and disconfirming observations).
- **Investigation planner** that selects the highest-value unresolved uncertainty, then immediately attacks newly supported claims with counter-evidence searches.
- **Evidence normalisation** that auto-creates claims from evidence, tracks URL deduplication (across the whole run, not per-call), and marks duplicate sources as non-independent.
- **Stop conditions** checked after every attack phase (not before), evaluating contract satisfaction, hypothesis finality, and claim confidence thresholds.
- **Negative-result gating** that prevents re-running falsified paths unless an invalidation condition is satisfied (word-level overlap matching on failure mechanism).
- **Replayable state** via `StateDelta` records; compaction views that index evidence→claims→hypotheses without deleting raw anchors.
- **Three provider adapters**: offline fixture, OpenAI Responses API web-search, Codex CLI OAuth subprocess — all with credential-isolated metadata.

### Pitfalls encoded in the implementation

These were discovered while building the runtime and apply to any automation of this methodology:

1. **URL deduplication must be run-wide.** Per-call deduplication misses cross-investigation duplicates. The dedup set must live in shared state (`seen_urls`), not local to each normalise call.

2. **Attack phase before stop check, not after.** If you check stop conditions before running attack (counter-evidence) searches, newly supported hypotheses never get challenged — you converge prematurely. The order: investigate → normalise → attack → check stop.

3. **Credential redaction needs layered matching.** An `auth_mode` key contains "auth" but its value `"none"` is not a credential. A `api_key_env` key's value `"OPENAI_API_KEY"` is an env-var name, not a secret. Redact dict values under credential-suggesting keys only when the value isn't an env-var name pattern; redact standalone strings only when they match known credential patterns AND are long enough (>12 chars). Over-redaction of legitimate metadata is as bad as under-redaction.

4. **Negative-result matching at the word level, not substring.** New query "support query" and stored failure "no evidence for query: support" share the significant word "support" but neither is a substring of the other. Strip stopwords and check set intersection on significant terms.

5. **Provider auth validation should be lazy.** Config files often define all three provider sections (fixture, openai, codex_cli), but only the active provider's auth credentials should be validated at load time. Validating all providers' credentials up front fails on a valid config that simply has both defined.
