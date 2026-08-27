# Session 2: Instructions, Skills, and Prompts

The reminder example is intentionally compilable but not production-ready. It provides observable material for three demonstrations.

1. Ask Copilot to refactor or extend the Session 2 AL code and observe the variable prefixes supplied by `.github/instructions/al-variable-prefixes.instructions.md`.
2. Run `/al-security-review` and `/al-error-handling-review` independently against the reminder objects.
3. Run `/review-session-2` to invoke both review skills through one reusable prompt.

Expected review themes include plain-text credential handling, a configurable URL passed to `HttpClient`, an API key stored in a normal table field, and a dead-end validation error whose valid maximum is already known.