---
name: al-security-review
description: "Review Business Central AL code for credential exposure, unsafe HttpClient usage, untrusted URLs, insecure secret storage, and permission risks. Use for AL security review or BC security audit requests."
argument-hint: "AL file or change to review"
user-invocable: true
---

# AL Security Review

Perform a read-only security review of the requested AL file or change. Do not edit files.

## Procedure

1. Establish the AL files and changed procedures in scope.
2. Read [the focused security rules](./references/security-rules.md).
3. Trace credentials and configurable URLs from their source to any `HttpClient` sink.
4. Report only concrete violations. Do not report general style or error-handling concerns.
5. Prefer the most specific rule when one line matches more than one rule.

## Output

List findings first, ordered `blocker`, `major`, then `minor`. For each finding include:

- Severity and short title
- File and line
- Concrete evidence from the code
- Security impact
- Recommended correction
- BCQuality rule name

If no violations are found, state that clearly and identify any security behavior that could not be verified from the available code.