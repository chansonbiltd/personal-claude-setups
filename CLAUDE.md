# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

A shareable Claude Code home-directory configuration for .NET/C# development on Windows 11. It contains agents, skills, and settings intended to be placed in `~/.claude/` on the target machine.

## Repository Structure

```
.claude/
  CLAUDE.md                  # Personal environment/workflow instructions (copied to ~/.claude/)
  settings.json              # Claude Code model, plugins, statusline config
  statusline-command.sh      # Bash/Git Bash script providing real-time session metrics in the status bar
  statusline-command.ps1     # PowerShell equivalent of the above
  agents/                    # Domain-specific AI sub-agents
  skills/
    resolve-pr-feedback/     # Gated multi-step PR review resolution workflow
```

## Working With Agents

Agent files live in `.claude/agents/`. Each is a markdown file with YAML frontmatter (`name`, `description`, `model`, `tools`) followed by the agent's system prompt. When adding or editing agents:

- The `description` field is used by Claude Code to decide when to invoke the agent automatically — make it precise and trigger-oriented.
- Keep agent responsibilities narrow. Cross-cutting concerns (logging, security) have their own dedicated agents.
- Reference `.claude/CLAUDE.md` conventions (Git Bash, UTF-8, Unix paths) in agents that run shell commands.

## Working With Skills

Skills live in `.claude/skills/<skill-name>/`. Each skill has:
- `SKILL.md` — the skill entry point; invoked via the `Skill` tool
- Optional subagent prompt files referenced inside `SKILL.md`

The `resolve-pr-feedback` skill uses an approval-gate pattern: fetch → evaluate → user approval → plan → user approval → implement → diff review → commit/push. Preserve these gates when editing; skipping them is explicitly called out as a red flag in the skill.

## Working With `statusline-command.sh`

The script reads a Claude Code session JSON from stdin and outputs a formatted status line. It probes multiple Windows `jq` install locations (Chocolatey, WinGet, manual) before falling back to PATH. Test changes by piping sample JSON:

```bash
echo '{"model":"claude-opus-4-5","costUSD":0.12,"totalTokens":50000}' | bash .claude/statusline-command.sh
```

## Conventions

- **Shell:** Git Bash only — no PowerShell syntax, no `NUL`, no `%VAR%`
- **Encoding:** UTF-8 without BOM on all files
- **Paths:** Unix-style forward slashes everywhere
- **Target stack:** .NET 10+, C#, Blazor, MudBlazor, EF Core, xUnit, Serilog
