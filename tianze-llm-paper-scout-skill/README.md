# Tianze LLM Paper Scout Skill

A lightweight cross-tool paper recommendation skill for:
- OpenAI Codex
- GitHub Copilot

Goal: each run recommends 3 recent arXiv papers by default, unless you explicitly ask for a different count. The picks should be more useful for engineering practice than for theory-heavy study.

It also includes a quick rubric for deciding whether a paper is worth reading and a short list of objective pre-read signals to check before investing time.

## What it prioritizes
- Agent systems and workflows
- RAG / retrieval systems / graph-based retrieval
- Post-training, distillation, compression, and inference efficiency
- LLM serving, scheduling, and systems optimization
- LLMs for software engineering

## What it deprioritizes
- Pure theorem/proof papers
- Math-heavy papers with weak engineering relevance
- Papers without experiments, benchmarks, or system implications

## Install in Codex
1. Copy `codex/AGENTS.md` to your repo root as `AGENTS.md`, or merge its content into your existing `AGENTS.md`.
2. Copy `codex/.codex/skills/tianze-llm-paper-scout-skill/` into your repo at the same path.
3. In Codex, ask something like:
   - `Use the tianze-llm-paper-scout-skill skill to recommend papers for this week.`
   - `Recommend recent papers on agent systems and RAG.`

## Install in GitHub Copilot
1. Copy `copilot/.github/copilot-instructions.md` into your repo.
2. Copy `copilot/.github/prompts/recommend-llm-papers.prompt.md` into your repo.
3. In Copilot Chat, open the prompt file or reuse its text. Example asks:
   - `Recommend 3 recent arXiv papers on LLM serving and distillation.`
   - `Use the repository instructions and recommend 5 engineering-oriented LLM papers.`

## Notes
Codex has a first-class skill format with `SKILL.md`. GitHub Copilot does not use the same skill package format; the closest equivalent is repository custom instructions plus reusable prompt files.
