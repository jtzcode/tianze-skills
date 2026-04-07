---
name: tianze-llm-paper-scout-skill
description: Recommend 3 recent arXiv papers about AI and LLMs by default, unless the user explicitly asks for a different count, with emphasis on engineering usefulness over theory-heavy work.
---

# Tianze LLM Paper Scout Skill

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

## Quick worth-reading filter
When the user asks whether a paper is worth reading, judge it with this short rubric:
1. **Clear problem**: Can the paper's practical problem be stated in one sentence?
2. **Concrete method**: Does it propose a real mechanism, system change, or algorithm instead of vague framing?
3. **Credible evidence**: Does it use strong baselines, ablations, and meaningful metrics?
4. **Realistic setup**: Are the tasks, datasets, latency, cost, or deployment assumptions close to real use?
5. **Transfer value**: Can the reader plausibly apply the idea to a real product, system, or workflow?

Use these reading recommendations:
- **Read now**: clear problem + credible evidence + obvious engineering relevance
- **Skim only**: interesting idea, but weak evaluation or unclear transfer value
- **Skip**: mostly theory, branding, benchmark gaming, or vague conceptual framing

## Fast quality signals
Treat these as green flags when scanning a paper:
- strong baselines instead of strawman comparisons
- ablations that explain why the method works
- error analysis or failure cases
- cost, latency, memory, or token-efficiency numbers when relevant
- clear diagrams, setup details, or implementation notes
- claims that match the evidence instead of overreaching

Treat these as red flags:
- big claims with small or noisy gains
- wins only on narrow or unrealistic benchmarks
- no ablations
- mostly subjective or judge-model evaluation without stronger verification
- unclear real-world value despite headline benchmark improvements
- paper spends more effort on framing than on mechanism

## Objective signals before reading
arXiv itself does **not** provide an official quality score. Before reading in depth, use these objective proxies when available:
1. **Accepted venue / journal reference** from the arXiv comments or journal metadata
2. **Code availability** on arXiv, Papers with Code, or GitHub
3. **Benchmark placement** or a strong, clearly reported results table
4. **OpenReview scores/comments** for conference submissions when available
5. **Citation count** from Semantic Scholar or Google Scholar for non-brand-new papers
6. **Submission/version history** as a weak maintenance signal only

If a paper has none of these signals, treat it as interesting but unproven.

## Example invocation
- Recommend recent arXiv papers about agent workflows and RAG.
- Recommend 3 engineering-oriented LLM papers from the last 2 months.
- Recommend 5 papers about distillation and LLM serving, but avoid theory-heavy work.
- Is this arXiv paper worth reading for an engineer building RAG systems?
- What objective signals can I check before investing time in this paper?
