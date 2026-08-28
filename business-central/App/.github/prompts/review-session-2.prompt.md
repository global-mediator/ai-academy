---
name: "Review Session 2"
description: "Review AL files attached to the chat using the security and error-handling skills."
argument-hint: "Attach AL files, then optionally enter a review focus"
agent: "agent"
---

Review every AL file attached to or included in the current chat context. Treat the supplied files as the complete review scope; do not search the workspace for additional source files. If no AL files were supplied, ask the user to attach them and stop.

Apply both workspace skills independently:

1. `al-security-review`
2. `al-error-handling-review`

Do not modify any files. Consolidate duplicate findings, keep security and error-handling findings in separate sections, and order findings by severity. Every finding must include a file location, concrete evidence, the applicable BCQuality rule, and a recommended correction.

Finish with a one-sentence accept-or-reject recommendation for the supplied code in its current form. Consider this additional focus: `${input:focus}`.