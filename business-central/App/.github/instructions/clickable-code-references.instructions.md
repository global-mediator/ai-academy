---
name: "Clickable Code References"
description: "Use when producing chat output that references workspace files, code, rules, or documentation. Format references as clickable Markdown links to exact lines when known."
applyTo: "**"
---

# Clickable Code References

When referencing workspace files in chat output, always use clickable Markdown links. Link to the exact 1-based line or line range whenever the location is known.

Use these formats:

- Single line: `[Descriptive label](relative/path/to/file.ext#L42)`
- Line range: `[Descriptive label](relative/path/to/file.ext#L42-L48)`
- Whole file when no precise location is available: `[relative/path/to/file.ext](relative/path/to/file.ext)`

Rules:

- Use workspace-relative paths with forward slashes.
- Use descriptive link labels when citing a specific symbol, behavior, or piece of evidence.
- Link each distinct code location separately, even when multiple locations are in the same file.
- Do not wrap Markdown links in backticks.
- Do not use `file://`, `vscode://`, absolute paths, or plain-text file references when a workspace link can be provided.
- Do not invent line numbers. If an exact line is unknown, link the whole file.
- For review findings, make every evidence location and every referenced local rule or documentation file clickable.

Example:

```markdown
- **Blocker: API key handled as plain text**
- Evidence: [API key declaration](src/Reminders/ACAReminderDispatcher.Codeunit.al#L42) and [authorization header assignment](src/Reminders/ACAReminderDispatcher.Codeunit.al#L67-L69)
- Correction: Use `SecretText`, `SecretStrSubstNo`, and the secret-aware `HttpHeaders.Add` overload.
- BCQuality rule: [secrettext-with-httpclient.md](docs/rules/secrettext-with-httpclient.md)
```