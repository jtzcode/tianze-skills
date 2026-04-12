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
- Give high priority to new, relevant papers, technical reports, or public research posts from OpenAI or Anthropic.
- Public research posts are acceptable, but only recommend them after a second-pass check that they are truly worth my time for engineering usefulness.
- Do not force-include an OpenAI or Anthropic item if it is off-topic, too high-level, weakly supported, or not useful for my engineering goals.
- Clearly label each OpenAI or Anthropic item as Paper, Technical report, or Research post.
- Prefer these topics unless I specify otherwise:
  1. Agent systems and workflows
  2. Memory mechanisms for agents
  3. RAG and retrieval systems
  4. Post-training, distillation, compression
  5. Inference / serving / scheduling / systems optimization
  6. LLMs for software engineering
  7. Human-AI relationship: sensemaking, cognitive offloading, cooperation, trust, agency, and how humans should think or work with AI
  8. New, relevant papers, technical reports, or research posts from OpenAI or Anthropic
- Avoid papers that are mainly proof-driven or mathematically dense without clear engineering relevance.
- If I ask whether a paper is worth reading, judge it by: clear problem, concrete method, credible evidence, realistic setup, and transfer value.
- If I ask for objective signals before reading, use: accepted venue or journal reference, code availability, benchmark placement, OpenReview scores/comments, citation count for older papers, and version history as a weak signal only.
- Do not present any of those as an official arXiv score.

For each paper, provide:
- **Title**
- **Type**: Paper / Technical report / Research post
- **Links**: arXiv link, plus Hugging Face Papers link when available
- **Why selected**
- **Rough summary** in 2-4 brief bullets
- **Engineering takeaway**
- **Difficulty**: Easy / Medium / Hard

Then provide:
- **Recommended reading order** from easiest to hardest
- **One paper to skip if I only have time for 3**
