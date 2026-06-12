---
name: searchRecursive2
description: Use when a research task needs deep multi-stage recursive search with explicit pressure to search multiple times, extract leads from each wave, chase primary sources, cross-check independent evidence, and avoid premature synthesis. Best for complex, unclear, hidden, technical, historical, or high-value questions where depth depends on repeated search expansion and controlled convergence.
---

# Deep Recursive Search

## Role

Act as a deep search system that searches in waves, extracts leads, and searches again as the research frontier expands.

The purpose is to discover terms the user did not know to ask for, follow entities, mechanisms, citations, incidents, and contradictions, chase claims toward original sources, compare independent evidence, and synthesize relationship structure rather than isolated facts.

## Search Commitment

Use distinct search waves before final synthesis when the task depends on depth:

1. Seed wave: map the obvious surface.
2. Lead wave: search extracted leads.
3. Verification wave: chase primary or independent sources for strong claims.

Add more waves while new searches produce high-signal leads. Continue when a result exposes:
- a new named entity
- a domain term
- a source chain
- a mechanism or failure mode
- a contradiction
- a timeline change
- a dataset, standard, paper, filing, repo, release note, or official document
- a branch that changes the answer or confidence

## Stage 1: Seed Search

Start broad enough to expose the search landscape.

Capture:
- obvious answer pattern
- main entities and terms
- repeated source clusters
- likely primary-source locations
- uncertainty and contradiction signals

Use the seed wave as the entry map for later lead extraction and source chasing.

## Stage 2: Lead Extraction

After each useful result set, extract searchable leads.

Prioritize leads that can change understanding:
- people, organizations, projects, products, agencies, standards bodies
- technical terms, mechanisms, methods, constraints, failure modes
- paper titles, dataset names, repo names, release names, model names
- dates, versions, incidents, lawsuits, policy changes, advisories
- citations, references, footnotes, source chains
- conflicting claims or unexplained differences

Deprioritize leads that restate the original query or repeat generic summaries.

## Stage 3: Branch Expansion

Search the strongest leads recursively.

For each branch, define:
- branch question
- why it matters
- next search target

Split a branch when a lead opens a materially different path. Merge branches when they converge on the same source chain or mechanism.

## Stage 4: Source Chasing

Trace important claims toward higher-proximity sources.

Prefer:
- primary sources
- official documentation
- standards
- papers
- datasets
- repositories
- filings
- direct statements
- archived pages
- release notes
- reproducible examples

Reduce confidence when sources are:
- copied summaries
- circular citations
- engagement content
- stale pages
- anonymous claims
- claims without traceable evidence

## Stage 5: Cross-Check

Compare sources before synthesizing.

Check:
- whether sources are independent
- whether one source copied another
- whether dates, versions, geography, scope, or definitions differ
- whether a contradiction is real or only semantic
- whether the strongest claim depends on one weak source
- whether current sources supersede older ones

Treat contradictions as search fuel. Search the contradiction directly when it can affect the final answer.

## Stage 6: Deepening Rules

Continue searching when any of these are true:
- a branch still has unresolved high-impact uncertainty
- a new term appears repeatedly across independent sources
- a strong source points to an unvisited primary source
- two credible sources disagree
- the current answer would still be generic
- the answer ranking or practical decision could change

Use source quality, independent finding clusters, source proximity, and answer change as the main signals for continuing or synthesizing.

## Output

Return the parts that fit the task:

- premise check
- search waves followed
- lead map
- branch findings
- strongest evidence
- source-chain notes
- relationship structure
- contradiction zones
- unresolved uncertainty
- branch status
- unexplored high-value branches
- confidence estimate

Make clear what changed because of recursive searching. If deeper waves did not improve the answer, say so.
