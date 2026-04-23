#!/usr/bin/env bash
# Copies personal ~/.claude config files into this repo's .claude/ directory.
# Run from the repo root. Review git diff afterward to decide what to commit.

set -euo pipefail

SRC="$HOME/.claude"
DEST="$(cd "$(dirname "$0")" && pwd)/.claude"

cp "$SRC/CLAUDE.md"               "$DEST/CLAUDE.md"
cp "$SRC/settings.json"           "$DEST/settings.json"
cp "$SRC/statusline-command.sh"   "$DEST/statusline-command.sh"

cp "$SRC/agents/"*.md             "$DEST/agents/"

cp "$SRC/skills/resolve-pr-feedback/SKILL.md"                    "$DEST/skills/resolve-pr-feedback/SKILL.md"
cp "$SRC/skills/resolve-pr-feedback/fetch-and-evaluate-prompt.md" "$DEST/skills/resolve-pr-feedback/fetch-and-evaluate-prompt.md"
cp "$SRC/skills/resolve-pr-feedback/implementer-prompt.md"        "$DEST/skills/resolve-pr-feedback/implementer-prompt.md"

echo "Sync complete. Run 'git diff' to review changes."
