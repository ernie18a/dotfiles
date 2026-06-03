---
name: clip
description: Use when a user asks to extract or score short-form video segments from a transcript.
---

# Short-Form Content Segment Extraction

## Objective

Analyze a complete transcript and identify segments with strong potential for short-form video distribution.

The goal is not to summarize the transcript or subjectively select "interesting" content. Instead, evaluate transcript sections using observable characteristics that commonly contribute to audience retention, engagement, and shareability.

Extract segments that can function as independent short-form content units, ideally between 30 and 90 seconds in duration.

---

# Segment Characteristics

A high-value segment may contain one or more of the following characteristics:

### 1. Counterintuitive Insight

* Challenges common assumptions
* Corrects a widespread misunderstanding
* Creates a clear contrast between expectation and reality

### 2. Actionable Knowledge

* Includes practical steps, methods, frameworks, or strategies
* Enables immediate application

### 3. Complete Narrative Structure

* Contains a clear beginning, conflict/problem, turning point, and outcome
* Or presents a complete standalone event

### 4. Emotional Dynamics

* Includes noticeable emotional shifts such as:

  * frustration
  * surprise
  * excitement
  * regret
  * realization
  * disbelief

### 5. Quotable Statements

* Contains memorable phrases that remain meaningful without additional context
* Suitable for titles, hooks, or social sharing

### 6. High Information Density

* Delivers multiple meaningful insights in a short duration
* Avoids unnecessary setup or repetition

---

# Selection Rules

Apply the following requirements when selecting segments:

### Include

* Segments that can be understood independently
* Segments that maintain meaning without surrounding context
* Segments suitable for editing into approximately 30–90 second clips

### Exclude

* Greetings and introductions
* Transitional statements
* Repeated explanations
* Filler conversation
* Segments requiring substantial external context

If a segment cannot stand on its own, exclude it.

---

# Scoring Framework

Evaluate each candidate segment on a scale of 0–10.

Criteria:

* Counterintuitive Insight
* Emotional Dynamics
* Narrative Completeness
* Actionability
* Distribution Potential

Overall Score:

Average of all category scores.

Retain only the highest-ranking 10–15 segments.

---

# Output Format

## Core Transcript Value

Provide a single sentence summarizing the primary value delivered by the transcript.

---

## Segment #N

### Time Range

[Start – End]

or

Approximate Minute Marker

### Title

Maximum 10 words.

### Overall Score

X.X / 10

### Category Scores

* Counterintuitive Insight:
* Emotional Dynamics:
* Narrative Completeness:
* Actionability:
* Distribution Potential:

### Selection Rationale

Explain why the segment was selected using observable characteristics.

### Recommended Hook

A concise opening statement suitable for the first few seconds of a short-form video.

### Summary

Maximum 100 words.

Preserve the original information structure.

### Key Transcript Excerpt

Include the most important original quotation without modification.

---

Repeat for each selected segment.

---

# Input

Transcript:

"""
{{TRANSCRIPT}}
"""
