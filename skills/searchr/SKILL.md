---
name: searchr
description: Conduct evidence-driven recursive research that escapes a weak initial query or conventional answer. Use for unclear, high-stakes, technical, historical, or open-ended questions where findings, contradictions, source chains, and practical constraints continuously evolve the search direction.
---

# SearchR

Use the initial query to orient the investigation. Build and revise the research frame from its assumptions, evidence, and conditions.

Prioritize decision impact over answer completeness. Continue only when the next search can materially change the conclusion, action, confidence, or risk.

## Research Loop

### 1. Frame the inquiry

Separate user intent, initial wording, and the provisional search frame. Retain only assumptions material to the question; discard accidental constraints, literal examples, stale framing, and duplicates. Identify the conclusion or decision the research could affect.

State what evidence, condition, or counterexample could change the answer. Identify:

- the decision, action, or judgment this research could change
- the acceptable uncertainty for that decision
- the signs that further search would have low value

Build the search frame from the resulting premise check.

### 2. Orient, then detach

Map the dominant answer pattern, repeated source clusters, key entities and terms, likely original evidence, and signs of uncertainty or disagreement.

Use this orientation to locate mechanisms, constraints, failures, counterexamples, incentives, dependencies, and source chains beyond the dominant answer. Carry its findings forward as leads for verification.

### 3. Recurse from evidence

After every useful wave, extract leads that can change understanding:

- new entities, terminology, mechanisms, dependencies, constraints, or failure modes
- original sources, citations, datasets, records, implementations, or direct statements
- conflicting claims, changed definitions, timelines, scope, or incentives
- missing preconditions or observations that would falsify a claim

Form the next query around the strongest lead or relationship. Rank leads by:

- likelihood of changing the conclusion, action, or risk
- proximity to direct evidence
- ability to resolve a consequential contradiction
- expected information gain relative to search cost

Give low priority to generic restatements, repeated summaries, and improvements that would only make the answer look more complete without materially changing its use.

### 4. Branch only on material divergence

Keep one active path by default. Create a branch only when distinct mechanisms, source chains, or interpretations could lead to materially different conclusions, confidence, applicability, or next actions.

For each branch, state its question, why it matters, and the next evidence target. Retain branches that yield distinct, material evidence; merge branches that converge on the same mechanism or evidence.

### 5. Verify the surviving claims

Trace important claims toward the most direct evidence available. Prefer sources with proximity to the claim and enough detail to inspect the method, context, date, scope, and limitations.

Cross-check source independence. Compare definitions, versions, geography, timing, incentives, and selection effects before treating disagreement as substantive. Search consequential contradictions directly. Treat independent, claim-proximate evidence as corroboration.

### 6. Converge deliberately

Continue while a high-impact uncertainty remains, a credible source points to closer evidence, a new lead can change the answer, or credible sources materially disagree.

Converge when the answer is stable across independent evidence, new searches mostly repeat known claims, remaining uncertainty exceeds available evidence, or further research cannot change the conclusion enough to justify its cost.

Stop early when:

- the next likely finding would not change the action or recommendation
- only cosmetic confidence gains remain
- the remaining branch affects an edge case outside the user's scope
- the cost of another search wave exceeds the expected decision value

Classify the result by evidential status and state the remaining uncertainty.

## Output

Return only what the task requires. Make clear:

- the premise check and current conclusion
- evidence that changed the initial framing
- strongest evidence and source-chain limits
- material contradictions, assumptions, and unresolved uncertainty
- the scope in which the conclusion holds
- why further search is or is not justified

Report the evidence changes, constraints, and support status that affect the answer.
