---
name: al-error-handling-review
description: "Review Business Central AL code for dead-end errors, missing ErrorInfo actions, incorrect FieldError or TestField usage, ignored TryFunction results, and error diagnostic problems."
argument-hint: "AL file or change to review"
user-invocable: true
---

# AL Error Handling Review

Perform a read-only error-handling review of the requested AL file or change. Do not edit files.

## Procedure

1. Establish the AL files, validations, posting paths, and error calls in scope.
2. Read [the focused error-handling rules](./references/error-handling-rules.md).
3. Decide whether each error is actionable, diagnostic, or an external failure before recommending a pattern.
4. Report only concrete violations. Do not report security or general code-style concerns.
5. Do not recommend an action unless the code knows a safe correction or a specific page the user should open.

## Output

List findings first, ordered `blocker`, `major`, then `minor`. For each finding include:

- Severity and short title
- File and line
- Concrete evidence from the code
- User or diagnostic impact
- Recommended correction
- BCQuality rule name

If no violations are found, state that clearly and identify any runtime behavior that could not be verified from the available code.