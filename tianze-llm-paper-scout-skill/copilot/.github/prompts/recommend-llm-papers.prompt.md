---
mode: ask
description: Recommend 3-5 recent engineering-oriented AI/LLM papers from arXiv and Hugging Face Papers
---

Recommend **3 to 5** recent AI / LLM papers using arXiv and Hugging Face Papers (`https://huggingface.co/papers`) as sources.

Selection policy:
- Optimize for engineering usefulness, not theory-heavy depth.
- Assume the reader knows the basics but is weak on mathematical proofs.
- Prefer recent papers.
- It is fine if the same paper appears in both sources.
- Give high priority to new, relevant published papers or preprints from OpenAI or Anthropic.
- It is fine to use OpenAI or Anthropic website pages to discover a paper, but only recommend the item if there is an actual paper/preprint record such as arXiv, Hugging Face Papers, a conference/journal page, or a PDF.
- Do not recommend standalone company blog posts, product posts, or research posts in this skill; I have another skill for digesting posts.
- Do not force-include an OpenAI or Anthropic paper if it is off-topic, weakly supported, or not useful for my goals.
- Prefer these topics unless I specify otherwise:
  1. Agent systems and workflows
  2. Memory mechanisms for agents
  3. RAG and retrieval systems
  4. Post-training, distillation, compression
  5. Inference / serving / scheduling / systems optimization
  6. LLMs for software engineering
  7. Human-AI relationship: sensemaking, cognitive offloading, cooperation, trust, agency, and how humans should think or work with AI
  8. New, relevant published papers or preprints from OpenAI or Anthropic
- Avoid papers that are mainly proof-driven or mathematically dense without clear engineering relevance.
- If I ask whether a paper is worth reading, judge it by: clear problem, concrete method, credible evidence, realistic setup, and transfer value.
- If I ask for objective signals before reading, use: accepted venue or journal reference, code availability, benchmark placement, OpenReview scores/comments, citation count for older papers, and version history as a weak signal only.
- Do not present any of those as an official arXiv score.

For each paper, provide:
- **Title**
- **Links**: arXiv, Hugging Face Papers, conference/journal, or PDF link when available
- **Why selected**
- **Rough summary** in 2-4 brief bullets
- **Engineering takeaway**
- **Difficulty**: Easy / Medium / Hard

Then provide:
- **Recommended reading order** from easiest to hardest
- **One paper to skip if I only have time for 3**
