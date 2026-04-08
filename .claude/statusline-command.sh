#!/usr/bin/env bash

input=$(cat)

# Try to locate jq — check common Windows locations if not on PATH
JQ=jq
if ! command -v jq >/dev/null 2>&1; then
    for candidate in \
        "/c/Program Files/jq/jq.exe" \
        "/c/ProgramData/chocolatey/bin/jq.exe" \
        "/c/tools/jq/jq.exe" \
        "$LOCALAPPDATA/Microsoft/WinGet/Packages/jqlang.jq/jq.exe"
    do
        if [ -x "$candidate" ]; then
            JQ="$candidate"
            break
        fi
    done
fi

# If jq still not found, emit a diagnostic and exit
if ! command -v "$JQ" >/dev/null 2>&1 && [ ! -x "$JQ" ]; then
    printf "[jq not found]"
    exit 0
fi

model_full=$(echo "$input" | "$JQ" -r '.model.display_name // .model.id // "unknown"')
model=$(echo "$model_full" | sed 's/ [0-9].*//')

# On Windows paths may use backslashes — normalise to get the leaf name
cwd=$(echo "$input" | "$JQ" -r '.workspace.current_dir // .cwd // ""')
# Replace backslashes with forward slashes, then take basename
cwd_unix=$(echo "$cwd" | sed 's|\\|/|g')
project_dir=$(basename "$cwd_unix")

used_pct=$(echo "$input" | "$JQ" -r '.context_window.used_percentage // empty')
total_input=$(echo "$input" | "$JQ" -r '.context_window.total_input_tokens // 0')
total_output=$(echo "$input" | "$JQ" -r '.context_window.total_output_tokens // 0')

# Format a raw integer into a compact human-readable string (e.g. 1200 -> 1.2k, 1200000 -> 1.2M)
fmt_tokens() {
    echo "$1" | awk '{
        if ($1 >= 1000000)      printf "%.3gM", $1/1000000
        else if ($1 >= 1000)    printf "%.3gk", $1/1000
        else                    printf "%d",    $1
    }'
}

# Context window used percentage
if [ -n "$used_pct" ]; then
    ctx_seg="$(printf '%.0f' "$used_pct")% ctx"
else
    ctx_seg="0% ctx"
fi

# Session cost (provided by Claude Code, model-aware)
cost=$(echo "$input" | "$JQ" -r '.cost.total_cost_usd // 0' | awk '{printf "%.2f", $1}')
cost_seg="\$${cost} USD"

# Cumulative session token totals
tok_total_in=$(fmt_tokens "$total_input")
tok_total_out=$(fmt_tokens "$total_output")
tokens_seg="${tok_total_in} in / ${tok_total_out} out tokens"

printf "[%s] %s | %s | %s | %s" \
    "$model" \
    "$project_dir" \
    "$ctx_seg" \
    "$cost_seg" \
    "$tokens_seg"
