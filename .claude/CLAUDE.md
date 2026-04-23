# Claude Code - Personal Configuration

## Environment

- **OS:** Windows 11
- **Shell:** Git Bash (bash on Windows — NOT PowerShell, NOT cmd.exe)
- Always use Unix-style paths (forward slashes: `C:/Users/...` or `/c/Users/...`)
- Use `/dev/null`, not `NUL`
- Use Unix shell syntax in all Bash commands (e.g., `&&`, `||`, `$()`, not `%VAR%`)
- Subagents and tools should assume Git Bash is the execution environment

## File Encoding

- All files must be **UTF-8 without BOM**
- If a file has a UTF-8 BOM, remove it when editing that file

## GitHub Operations

- Both `gh` CLI and `mcp__plugin_github_github__*` MCP tools are available
- Prefer MCP tools for read operations (listing PRs, reading comments, etc.)
- Use `gh` CLI when MCP tools lack capability (e.g., resolving PR review threads)

## Workflow Preferences

- For new features or multi-step tasks: use superpowers skills (brainstorm -> plan -> implement via SDD)
- For 2+ independent tasks: dispatch parallel agents
- Prefer dispatching subagents for discrete implementation tasks to keep main context clean
- For commits: use /commit
- For PR feedback: use /resolve-pr-feedback

## Tech Stack

- Primary: .NET 10+, C#, Blazor, MudBlazor, EF Core
- Use project-level CLAUDE.md in each repo for repo-specific patterns
