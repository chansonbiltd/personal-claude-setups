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
