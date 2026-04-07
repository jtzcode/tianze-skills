---
name: tianze-blog-digest
description: "Fetch and summarize the latest posts from curated AI/tech blogs into a digest report. Use when: blog digest, tech blog summary, what's new in AI blogs, latest blog posts, AI blog roundup, weekly digest, blog updates, 'check the blogs', 'what did Anthropic/OpenAI/Fowler post lately', or reading list digest."
argument-hint: "Optionally provide specific blog URLs to check, or omit to use the default list"
---

# Blog Digest

Fetch the latest posts from a curated list of AI/tech blogs, summarize key insights, and present a structured digest report.

## Usage

Use the skill directly with prompts like:

- `Give me a blog digest`
- `What's new on the AI blogs?`
- `Summarize the latest posts from Anthropic, OpenAI, and Martin Fowler`

Optional: if you want a `/digest` slash prompt in VS Code Copilot Chat, this skill includes a source-controlled prompt file at [reference/digest.prompt.md](./reference/digest.prompt.md).

Install it into your user prompts folder with either:

```bash
mkdir -p ~/.config/Code/User/prompts
cp tianze-blog-digest-skill/reference/digest.prompt.md ~/.config/Code/User/prompts/digest.prompt.md
```

or a symlink so updates in this repo stay in sync:

```bash
mkdir -p ~/.config/Code/User/prompts
ln -sf "$PWD/tianze-blog-digest-skill/reference/digest.prompt.md" ~/.config/Code/User/prompts/digest.prompt.md
```

After that, type `/digest` in Copilot Chat to trigger this skill.

## Workflow

### Step 0 — Detect available fetch tools

Before fetching any content, determine which tools are available:

1. **Check for Playwright MCP tools** — search your available tools for names matching the pattern `playwright.*navigate` and `playwright.*snapshot` (e.g. `mcp_playwright_browser_navigate`, `browser_navigate`, or any variant). If a navigate + snapshot pair is found, mark **Playwright mode = on**.
2. If Playwright mode = on, attempt **every** index-page fetch and **every** article fetch with Playwright first.
3. Only use `fetch_webpage` as a fallback if Playwright tools are unavailable, or if a specific page fails to load or extract in Playwright.

Playwright mode fully renders JavaScript and bypasses CDN caches, solving both SPA/JS-rendered pages and stale-content issues. Prefer it when available.

> **Setup:** If Playwright MCP is not installed, run [`scripts/setup-playwright.sh`](./scripts/setup-playwright.sh) from this skill's directory. It installs `@playwright/mcp` + Chromium and prints config snippets for VS Code, Claude Code, Cursor, and Windsurf.

### Step 1 — Load digest history

Read `~/.copilot/state/blog-digest/history.md`. This file tracks previously summarized posts so they are not repeated. Each line has the format:
```
<date> | <post_url> | <post_title>
```

If the file or directory does not exist, create them. Treat every URL listed here as "already digested".

### Step 1.5 — Load or initialize the archive repo

This skill can archive each daily digest into a separate git repository chosen by the user.

Use these local state files to remember the archive repo configuration:

- `~/.copilot/state/blog-digest/archive-repo-url.txt`
- `~/.copilot/state/blog-digest/archive-repo-path.txt`

1. Read `~/.copilot/state/blog-digest/archive-repo-url.txt`.
2. If it does not exist, ask the user which git repo URL should be used for archive storage, then save that URL into `~/.copilot/state/blog-digest/archive-repo-url.txt`.
3. Read `~/.copilot/state/blog-digest/archive-repo-path.txt`.
4. If it does not exist, ask the user where the archive repo should live locally, then save that path into `~/.copilot/state/blog-digest/archive-repo-path.txt`.
5. If the local path does not already contain a clone of the configured archive repo, clone the stored repo URL into that path.
6. Validate that the directory is a git repo and that its `origin` remote matches the stored repo URL. If not, stop and ask the user how to proceed.

This archive repo is updated only when there is at least one newly summarized post.

### Step 2 — Load the blog list

Read the default blog list from [reference/blogs.md](./reference/blogs.md) in this skill's directory.

If the user provided specific blog URLs in their prompt, use those **instead** of the default list. If the user asks to "add" a blog, append it to `reference/blogs.md` for future runs, then include it in this run.

Each entry in `reference/blogs.md` has the format:
```
<name> | <index_url>
```

### Step 3 — Fetch each blog's index page

**If Playwright mode = on:**
- First attempt the blog index URL with the Playwright **navigate** tool, then use **snapshot** and/or DOM extraction tools to read the rendered content.
- Do this for every blog before considering any fallback.
- This handles SPA/JS-rendered pages and always returns fresh content (no caching issues).

**If Playwright mode = off, or the specific Playwright attempt fails (fallback):**
- Use `fetch_webpage` to retrieve the blog index page:
  - Set `query` to: `"latest blog post title, date, and link"`
  - Set `urls` to the blog's index URL
- To avoid stale/cached responses from CDNs, append a cache-busting query parameter to HTML URLs — e.g. `?_t=<unix_timestamp>`. This is not needed for Atom/RSS feed URLs.

> **Tip:** RSS/Atom feed URLs (e.g. `feed.atom`, `feed.xml`) are preferred over HTML index pages when available — they update faster and parse more reliably.

From the fetched content, extract:
- **Title** of the most recent post
- **Date** of the most recent post
- **URL** to the full post (resolve relative URLs against the blog's base URL)

**If a blog fetch fails or no posts are found**, skip it and note it in the report.

**If multiple posts are found**, select only the latest one (by date). If dates are ambiguous, select the first listed post (blogs typically list newest first).

**If the latest post URL already appears in `history.md`**, skip the blog entirely and note "no new posts" in the report. Do **not** fall back to older posts.

### Step 4 — Fetch and summarize each latest post

For each latest post identified in Step 3:

**If Playwright mode = on:**
- First attempt the post URL with the Playwright **navigate** tool, then use **snapshot** and/or DOM extraction tools to read the rendered content.
- Only fall back if that specific Playwright attempt fails.

**If Playwright mode = off, or the specific Playwright attempt fails (fallback):**
- Use `fetch_webpage` to retrieve the full article:
  - Set `query` to: `"main argument, key insights, and conclusions"`
  - Set `urls` to the post's URL
- If `fetch_webpage` returns empty or minimal content (SPA page), note it in the report as "content not extractable (JS-rendered page)".

Summarize each post into:
- **3-5 key insight bullets** — the most important ideas, findings, or arguments
- **One-line takeaway** — the single most important thing a reader should know

### Step 5 — Compile the digest report

Present the digest as a structured report directly in the chat response. Use this format:

```markdown
# Blog Digest — <today's date>

---

## <Blog Name>
**[<Post Title>](<post_url>)** — <date>

**Key Insights:**
- Insight 1
- Insight 2
- Insight 3

**Takeaway:** <one-line summary>

---

## <Next Blog Name>
...

---

*Skipped (no updates or fetch failed): <list of skipped blog names, if any>*
```

### Step 6 — Write the daily archive file

If at least one new post was summarized in this run:

1. Create or update a markdown file in the archive repo using today's date in the file name:
  ```
  <archive_repo_path>/<YYYY-MM-DD>.md
  ```
2. If the file does not exist, create it using the digest report content from Step 5.
3. If the file already exists for today, update it in place rather than creating a second file for the same date.
4. Preserve any existing deep-dive sections already appended for today's digest.
5. Stage the updated daily file, commit it with a concise message such as:
  ```
  Add digest for <YYYY-MM-DD>
  ```
  or
  ```
  Update digest for <YYYY-MM-DD>
  ```
6. Push the commit to the archive repo's default branch.

If there are no new posts from any checked blog, skip archive file creation entirely.

### Step 7 — Update digest history

After compiling the report, append every newly summarized post to `~/.copilot/state/blog-digest/history.md`. Use the format:
```
<today's date> | <post_url> | <post_title>
```

This ensures the next digest run skips these posts automatically.

### Step 8 — Offer follow-up

After presenting the digest, offer:
- *"Would you like me to deep-dive into any of these posts?"*

If the user selects a post for deep-dive, fetch it again and provide a structured analysis using exactly this order:

1. **What problem it solves**
2. **How it solves it**
3. **What are the keys here**
4. **Insights or takeaways for developers**
5. **Other things worth learning**

For deep-dives:
- Use clear section headers in that order.
- Ground every point in the fetched article content.
- Include direct quotes only when they materially support the explanation.
- Prefer concrete mechanisms, tradeoffs, and implementation patterns over marketing language.
- If the article content is thin on one of the five sections, say that explicitly instead of filling gaps with guesses.

After generating the deep-dive response:

1. Check whether today's archive file exists in the configured archive repo.
2. If it exists, append a clearly labeled deep-dive section for that post, or replace the existing deep-dive section for the same post if one is already present.
3. Commit and push that archive file update automatically.
4. If today's archive file does not exist because the digest had no new posts, do not create a deep-dive-only file unless the user explicitly asks for that behavior.

### Follow-up discussions

Any follow-up question or discussion that is grounded in the content of a blog post from today's digest (e.g. "explain more about X", "what does Y mean?", "can you expand on Z?") should also be archived:

1. Write the response in the chat as normal.
2. Append it to today's archive file under a clearly labeled `## Follow-up:` section heading that identifies the topic.
3. If a follow-up section on the same topic already exists, replace it rather than duplicating.
4. Commit and push the updated archive file automatically with a message such as:
   ```
   Update digest for <YYYY-MM-DD>: add <topic> follow-up discussion
   ```
5. Do **not** archive follow-up questions that are purely meta (e.g. questions about the skill itself, tool configuration, or workflow) — only content-focused discussions tied to the blog posts.

## Rules

1. **Always read `reference/blogs.md` first** unless the user provides an explicit list of URLs.
2. **One post per blog.** Select only the latest post from each blog.
3. **Skip gracefully.** If a blog can't be fetched or has no identifiable posts, skip it — don't fail the entire digest.
4. **Try Playwright first when available.** Use browser-based fetching for each index and article URL before any non-browser fallback.
5. **Don't fabricate content.** Only summarize what was actually fetched. If the fetch returns insufficient content, say so.
6. **Keep summaries concise.** 3-5 bullets per post, not paragraphs.
7. **Respect the user's time.** The digest should be scannable in under 2 minutes.
8. **Archive only real updates.** If no new posts were summarized, do not create a daily markdown file in the archive repo.
9. **Use one file per day.** Reuse and update the same `<YYYY-MM-DD>.md` file for later deep dives and follow-up discussions on that day's digest.
10. **Auto-push archive updates.** When the daily archive file changes, commit and push it automatically.
11. **Archive all content-focused follow-ups.** Any follow-up discussion grounded in a blog post from the digest — not just formal deep-dives — must be appended to the archive file and pushed.
