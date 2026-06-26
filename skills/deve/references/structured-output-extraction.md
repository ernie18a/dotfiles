# Structured Output Extraction Pattern

## Problem

An LLM worker returns unstructured prose (summaries, markdown tables, bullet lists, Chinese/English mixed text) instead of the requested structured JSON. The system needs a validated schema object, not raw prose.

## Pattern: Extractor Fallback

Instead of failing hard when parsing fails, route through a focused extraction LLM call:

```
raw_response = provider.call(prompt=worker_prompt, model=worker_model)
try:
    return parse_structured(raw_response)       # direct parse
except ValueError:
    extracted = extractor.call(prompt=extraction_prompt(raw_response))  # extractor
    return validate_and_return(extracted)        # same schema validator
```

## Key Design Rules

1. **Schema validation is never relaxed** — both direct and extracted results pass the same strict validator.
2. **Extraction prompt is focused** — no tool-use, no multi-turn, no code-writing. Just "convert this prose to JSON."
3. **Context is minimal** — only the raw response + relevant state (active plan, known files). Don't dump full state.
4. **Extractor output must be parseable JSON** — same `parse_json_object` or equivalent used for direct responses.
5. **Provider choice** — use the same provider as the worker. The extraction prompt is simpler than the worker prompt, so even a model that produced prose can usually extract JSON from its own output.
6. **Recovery hierarchy for resume** — on resume with saved raw response:
   - (1) Direct parse (may succeed if prose+valid-JSON-in-fence)
   - (2) Extractor call
   - (3) Protocol error → rerun worker

## Pitfalls

- **Infinite loop risk**: If the worker always returns unparseable prose and the extractor always fails, you get repeated reruns. Use the existing recovery flow (protocol error logging + rerun) without a hard loop counter — or add one only when the outer system demands it.
- **Extractor consuming rerun response**: In test/mock scenarios, the extractor call consumes one provider response slot. Tests with prose worker_raw_response need an extra fake response for the extractor before the rerun response.
- **Provider call overhead**: Each extraction adds one provider call and latency. Only attempt extraction when direct parse fails.
- **Raw response must be preserved until extraction resolves**: Save the raw response to state before parsing so the extractor can access it if parsing fails. Clear it only on successful extraction.

## Verification

Test these paths:

1. Fresh call → prose → extractor succeeds → validated report in state
2. Resume → prose checkpoint → extractor succeeds → no rerun (event marks result="extractor")
3. Resume → fenced JSON → direct parse succeeds → event marks result="direct"
4. Resume → prose checkpoint → extractor also fails → protocol error → rerun worker
