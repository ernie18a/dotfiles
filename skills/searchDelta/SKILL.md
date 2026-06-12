---
name: searchDelta
description: Use when web research should start from a visible knowledge baseline, then recursively use keywords, entities, mechanisms, contradictions, and source leads found in search results to discover evidence beyond generic or default answer patterns.
---

# Search Delta

## Purpose

Use this workflow when searching is only useful if it finds something beyond the generic answer.

The goal is to:
- state the visible baseline
- search for information outside that baseline
- mine search results for new leads
- recursively search those leads
- separate real new evidence from repeated consensus
- surface several defensible directions
- synthesize the delta from baseline without forcing a single answer

## Baseline First

Before deep searching, define the current visible baseline:

- what a generic answer would say
- obvious entities and terms
- common explanations or best practices
- repeated examples
- known uncertainty

Keep it short. The baseline is a boundary, not the answer.

## Beyond Baseline

A finding is beyond the baseline when it changes the useful answer, not merely when it is obscure.

Look for information that changes:

- option ranking
- applicability conditions
- mechanism understanding
- constraints or failure modes
- relationship between known entities
- evidence strength
- decision value

Do not try to prove whether the information was previously unknown. Treat search value as the ability to surface, connect, verify, or re-rank useful information beyond the default answer pattern.

## Recursive Lead Mining

After each search wave, extract leads from the results:

- new keywords or domain terms
- named entities, projects, papers, companies, people, datasets, or standards
- mechanisms, methods, failure modes, or constraints
- contradictions or unexplained differences
- citations, source chains, or primary-source references
- dates, versions, releases, incidents, or regulatory events

Search the strongest leads recursively. Do not recurse on terms that only restate the baseline.

## Search Waves

Use compact waves as needed:

1. Baseline wave: identify the generic answer and obvious source cluster.
2. Discovery wave: search broad enough to expose non-baseline leads.
3. Recursion wave: search the best leads from prior results.
4. Verification wave: check strong claims against primary or independent sources.
5. Option wave: group viable answer directions into a small plateau of candidates.
6. Synthesis wave: stop expanding and explain what changed.

Repeat waves only while new high-signal leads keep appearing.

## Lead Selection

Prioritize leads that are:

- outside the baseline
- specific enough to search
- connected to direct evidence
- repeated independently
- mechanism-rich
- useful for the user's decision

Drop leads that are:

- vague
- copied across aggregators
- unsupported novelty
- obvious baseline restatements
- too expensive to verify for the expected value

## Answer Plateau

Do not overfit to one conclusion when several directions remain defensible.

When evidence supports multiple useful paths, return a small plateau of candidate answers. Each candidate should have:

- direction or option name
- when it applies
- evidence strength
- tradeoffs or failure modes
- confidence

Use enough candidates to preserve defensible alternatives without diluting the answer.

Rank candidates, but do not hide viable alternatives. If two options can be combined, say so.

## Evidence Standard

Prefer:

- primary sources
- direct quotes or data when legally and practically usable
- reproducible details
- domain-specific sources
- independent convergence
- source chains that can be traced

Lower confidence for shallow summaries, engagement content, circular citations, and generic AI-style explanations.

## Output

Return only what helps:

- baseline
- new findings beyond baseline
- recursive leads followed
- answer plateau or candidate directions
- strongest evidence
- contradictions
- unresolved uncertainty
- leads not followed
- confidence estimate

Make the value over the baseline explicit. If search did not find meaningful evidence beyond the baseline, say so. Avoid presenting one answer as final when the evidence supports a plateau of useful choices.
