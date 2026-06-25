---
name: algor
description: Apply this skill whenever the user faces any decision-making problem, optimization challenge, selection task, ranking need, search/filter requirement, scheduling dilemma, resource allocation, trade-off analysis, or any situation involving "which option to choose", "how to prioritize", "what's the best way", "is this feasible", "how to automate this judgment". This skill brings computational complexity theory and algorithm design thinking to bear on the problem — treating decisions as computable problems with tractability bounds, and selecting or designing an algorithm-style reasoning process that matches the problem's actual structure. Use this skill regardless of domain: business, personal, medical, legal, creative, technical, social, financial, or any other. If the user is trying to make a decision or automate a judgment process, use this skill.
---

# Complexity & Algorithm Decision Skill

## Core Premise

Every decision is a computable problem. Two fundamental tools determine how to approach it:

1. **Computational Complexity** — answers: *how hard is this problem, fundamentally?*
2. **Algorithm Design** — answers: *given that hardness, what's the best reasoning process?*

Together they prevent two failure modes:
- Applying brute-force thinking to easy problems (wasted effort)
- Applying simple heuristics to hard problems (wrong answers with false confidence)

## Step 1 — Classify the Problem's Complexity

Before designing any decision process, determine what class of problem you're dealing with.

### Complexity Classes (domain-neutral)

| Class | Meaning | Decision Implication |
|-------|---------|----------------------|
| **O(1) / Trivial** | Answer is a direct lookup or fixed rule | Apply the rule; no search needed |
| **P (Polynomial)** | Solvable efficiently; scales reasonably | Use a systematic algorithm; optimal solution reachable |
| **NP-Hard** | No known efficient exact solution for large inputs | Use heuristics, approximations, or constraint reduction |
| **Undecidable / Intractable** | No algorithm can always solve it | Reframe the problem; change what "solved" means |

### How to Classify

Ask these diagnostic questions about the user's problem:

1. **How many options exist?** — Finite and small → likely P or easier. Exponential combinations → likely NP-Hard.
2. **Do constraints interact?** — Independent constraints → easier. Constraints that conflict with each other → harder.
3. **Is the goal "find the best" or "find a good enough"?** — Exact optimum on large spaces → NP-Hard territory. Satisficing → more tractable.
4. **Is the problem a known archetype?** — Match to known classes below.

### Known Problem Archetypes

- **Sorting / Ranking** → O(n log n), always tractable → use comparison-based reasoning
- **Search in structured space** → O(log n) to O(n) → binary search, index-based lookup
- **Matching / Assignment** → P (Hungarian algorithm class) → systematic matching
- **Scheduling with conflicts** → NP-Hard in general → greedy + constraint pruning
- **Combinatorial selection** (pick best k from n with interactions) → NP-Hard → dynamic programming or approximation
- **Shortest path / least cost route** → P (Dijkstra class) → systematic traversal
- **Yes/No feasibility check** → Often P → constraint satisfaction
- **Multi-objective optimization** → NP-Hard; no single "best" → Pareto front reasoning

## Step 2 — Select the Algorithm Strategy

Match strategy to complexity class:

### For Trivial / O(1) Problems
**Strategy: Direct Rule Application**
- Identify the decision rule explicitly
- Apply it without search
- Output: deterministic answer + the rule stated clearly

### For P Problems
**Strategy: Systematic Enumeration or Structured Search**
- Define the solution space precisely
- Apply the appropriate algorithmic pattern:
  - *Divide & Conquer*: split problem into independent subproblems, solve each, combine
  - *Dynamic Programming*: identify overlapping subproblems, cache intermediate results
  - *Greedy*: at each step, pick locally optimal choice (valid when greedy choice property holds)
  - *Graph traversal*: model as nodes/edges, use BFS/DFS/shortest-path
- Output: optimal or near-optimal answer with reasoning trace

### For NP-Hard Problems
**Strategy: Constraint Reduction + Heuristic + Bounded Search**
- **Reduce the space first**: apply hard constraints to eliminate infeasible options
- **Use a heuristic**: greedy initialization, simulated annealing logic, or domain-informed scoring
- **Set a satisficing threshold**: define "good enough" explicitly — don't chase the optimal
- **Apply approximation ratio**: state how far from optimal the answer might be
- Output: best feasible option found + confidence level + what was traded off

### For Intractable / Ill-Defined Problems
**Strategy: Reframe**
- Identify what makes the problem intractable (missing information, undefined objective, infinite search space)
- Propose a reformulation that is tractable
- Output: reframed problem statement + proposed tractable version

## Step 3 — Execute the Decision Process

Once complexity class and strategy are chosen, execute:

### 3a. State the Problem Formally
- What are the **inputs** (the options, variables, candidates)?
- What are the **constraints** (hard limits that must be satisfied)?
- What is the **objective** (what are we optimizing for)?
- What is the **output type** (single best, ranked list, yes/no, threshold)?

### 3b. Prune the Search Space
Apply hard constraints first — this is free speedup regardless of complexity class.
- Eliminate options that violate non-negotiable constraints
- State what was eliminated and why

### 3c. Score or Traverse Remaining Options
- For small spaces: enumerate and score each
- For large spaces: apply the selected algorithm strategy
- Make scoring criteria explicit and weighted if multiple objectives exist

### 3d. Output the Decision
- **Primary recommendation**: the selected option or action
- **Reasoning trace**: how the algorithm arrived here
- **Complexity note**: what class this problem is, and therefore what confidence level is warranted
- **Trade-offs**: what was sacrificed for the chosen option
- **Sensitivity**: what would change the answer (which input changes flip the decision)

## Step 4 — Automate or Repeat

If the user needs this decision made repeatedly (a recurring judgment), codify the algorithm:

1. **Extract the decision function**: inputs → output, with explicit rules
2. **Identify what varies** each time vs. what stays fixed
3. **Express as a policy**: "When [condition], choose [option] because [rule derived from algorithm]"
4. **Flag edge cases**: conditions under which the policy breaks and human judgment is needed

## Principles

**Hardness is a property of the problem, not the person.**
If a problem is NP-Hard, no amount of effort produces a perfect answer efficiently. Recognizing this is not defeat — it's the correct diagnosis that leads to the right strategy (approximation, not exhaustive search).

**Complexity class determines confidence ceiling.**
For P problems, high confidence is warranted. For NP-Hard problems, honest confidence is bounded — state this explicitly rather than hiding it.

**The best algorithm for the wrong problem is still wrong.**
Step 1 (classification) is not optional. Applying a greedy algorithm to a problem where the greedy choice property doesn't hold produces confidently wrong answers.

**Tractability through reformulation is legitimate.**
Changing what question is asked — to make it answerable — is a valid and often superior move to brute-forcing an intractable original question.

**Prune before you search.**
Hard constraints are free. Apply them first, always, regardless of problem class.
