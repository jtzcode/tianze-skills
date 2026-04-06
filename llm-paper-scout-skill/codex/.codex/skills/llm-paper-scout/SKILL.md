---
name: llm-paper-scout
description: Recommend 3 recent arXiv papers about AI and LLMs by default, unless the user explicitly asks for a different count, with emphasis on engineering usefulness over theory-heavy work.
---

# LLM Paper Scout

## Purpose
Use this skill when the user wants AI / LLM paper recommendations, especially from arXiv, and wants:
- a lightweight weekly or on-demand reading list
- awareness of current frontiers
- papers with practical engineering value
- short, high-level summaries instead of deep technical walkthroughs

## Default behavior
On each run, recommend exactly **3 papers** unless the user explicitly asks for a different count.
When the user does not specify a number, choose the **3 best overall matches** for the reader profile instead of aiming for broad coverage.

## Reader profile to optimize for
Assume the reader:
- knows the basic ideas of AI and LLMs
- is not strong in mathematical proofs
- wants to understand research frontiers through an engineering lens
- prefers work that can help solve real system, product, or workflow problems

## Topic priorities
Prefer papers in these areas, unless the user narrows the topic:
1. Agent systems and workflows
2. RAG, retrieval systems, graph-based retrieval, and context engineering
3. Post-training, distillation, compression, and reasoning transfer
4. Inference, serving, scheduling, memory, and systems optimization
5. LLMs for software engineering and coding agents

## Deprioritize
Avoid or strongly deprioritize papers that are mainly:
- theorem/proof driven
- optimization-bound or sample-complexity heavy
- mathematically dense with weak practical implications
- incremental papers without strong experiments or clear engineering insight

## Selection rules
When choosing papers:
1. Favor recent arXiv papers.
2. Optimize first for **fit to the user's interests and reader profile**, not for topic coverage.
3. Among plausible candidates, choose the **highest-quality** papers based on clarity of problem, strength of method, credibility of evaluation, and practical relevance.
4. Prefer papers that clearly state a system problem, method, and evaluation.
5. Prefer papers with experiments, benchmarks, ablations, or deployment implications.
6. Prefer survey papers only when the user asks for a map of a topic; otherwise prefer concrete recent papers.
7. If the user does not specify a count, do **not** add honorable mentions or backup picks beyond the selected 3.

## Output format
For each paper, provide:
- **Title**
- **arXiv link**
- **Why it was selected**: 1 sentence
- **Rough summary**: 2-4 short bullets, high level only
- **Engineering takeaway**: 1 bullet
- **Difficulty**: Easy / Medium / Hard

Then finish with:
- **Reading order recommendation**: easiest to hardest
- **Skip if busy**: 1 paper the reader can postpone

## Tone and depth
- Keep summaries concise.
- Explain in plain language.
- Do not spend much space on proofs.
- Translate research into implementation relevance whenever possible.

## Example invocation
- Recommend recent arXiv papers about agent workflows and RAG.
- Recommend 3 engineering-oriented LLM papers from the last 2 months.
- Recommend 5 papers about distillation and LLM serving, but avoid theory-heavy work.
