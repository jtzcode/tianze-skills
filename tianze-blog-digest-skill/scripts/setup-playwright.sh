#!/usr/bin/env bash
set -euo pipefail

# ─────────────────────────────────────────────────────────────
# setup-playwright.sh — Install Playwright MCP for tianze-blog-digest
#
# Installs @playwright/mcp and Chromium, then prints config
# snippets for popular coding agents.
#
# Usage:
#   chmod +x scripts/setup-playwright.sh && ./scripts/setup-playwright.sh
# ─────────────────────────────────────────────────────────────

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

info()  { echo -e "${GREEN}[✓]${NC} $*"; }
warn()  { echo -e "${YELLOW}[!]${NC} $*"; }
error() { echo -e "${RED}[✗]${NC} $*"; exit 1; }

# ── 1. Check prerequisites ──────────────────────────────────

command -v node  >/dev/null 2>&1 || error "Node.js is required but not found. Install it first: https://nodejs.org"
command -v npx   >/dev/null 2>&1 || error "npx is required but not found. It ships with Node.js >= 5.2.0"

NODE_MAJOR=$(node -v | sed 's/v//' | cut -d. -f1)
if [[ "$NODE_MAJOR" -lt 18 ]]; then
  error "Node.js >= 18 required (found $(node -v))"
fi
info "Node.js $(node -v) — OK"

# ── 2. Install @playwright/mcp globally ─────────────────────

if npm list -g @playwright/mcp >/dev/null 2>&1; then
  info "@playwright/mcp already installed globally"
else
  warn "Installing @playwright/mcp globally..."
  npm install -g @playwright/mcp
  info "@playwright/mcp installed"
fi

# ── 3. Install Chromium browser ──────────────────────────────

warn "Installing Playwright Chromium browser (if not cached)..."
npx playwright install chromium 2>/dev/null || npx playwright install chromium
info "Chromium browser ready"

# ── 4. Print config snippets ────────────────────────────────

PLAYWRIGHT_CMD="npx"
PLAYWRIGHT_ARGS='["@playwright/mcp@latest"]'

echo ""
echo "════════════════════════════════════════════════════════════"
echo "  Playwright MCP installed. Configure your coding agent:"
echo "════════════════════════════════════════════════════════════"

# --- VS Code / Copilot ---
cat <<'VSCODE'

┌─ VS Code / GitHub Copilot ──────────────────────────────────┐
│                                                             │
│  File: <project>/.vscode/mcp.json                          │
│                                                             │
│  {                                                          │
│    "servers": {                                             │
│      "playwright": {                                        │
│        "command": "npx",                                    │
│        "args": ["@playwright/mcp@latest"]                   │
│      }                                                      │
│    }                                                        │
│  }                                                          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
VSCODE

# --- Claude Code ---
cat <<'CLAUDE'
┌─ Claude Code ───────────────────────────────────────────────┐
│                                                             │
│  Run:                                                       │
│  claude mcp add playwright -- npx @playwright/mcp@latest    │
│                                                             │
└─────────────────────────────────────────────────────────────┘
CLAUDE

# --- Cursor ---
cat <<'CURSOR'
┌─ Cursor ────────────────────────────────────────────────────┐
│                                                             │
│  File: <project>/.cursor/mcp.json                          │
│                                                             │
│  {                                                          │
│    "mcpServers": {                                          │
│      "playwright": {                                        │
│        "command": "npx",                                    │
│        "args": ["@playwright/mcp@latest"]                   │
│      }                                                      │
│    }                                                        │
│  }                                                          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
CURSOR

# --- Windsurf ---
cat <<'WINDSURF'
┌─ Windsurf ──────────────────────────────────────────────────┐
│                                                             │
│  File: ~/.codeium/windsurf/mcp_config.json                 │
│                                                             │
│  {                                                          │
│    "mcpServers": {                                          │
│      "playwright": {                                        │
│        "command": "npx",                                    │
│        "args": ["@playwright/mcp@latest"]                   │
│      }                                                      │
│    }                                                        │
│  }                                                          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
WINDSURF

echo ""
info "Done! Restart your coding agent to activate the Playwright MCP server."
echo ""
