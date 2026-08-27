---
name: "Review Session 2"
description: "Run the AL security and error-handling review skills over the Session 2 reminder example."
argument-hint: "Optional review focus"
agent: "agent"
---

Review these Session 2 AL objects:

- [Reminder setup](../../src/Session2/Reminders/ACAReminderSetup.Table.al)
- [Reminder dispatcher](../../src/Session2/Reminders/ACAReminderDispatcher.Codeunit.al)

Apply both workspace skills independently:

1. `al-security-review`
2. `al-error-handling-review`

Do not modify any files. Consolidate duplicate findings, keep security and error-handling findings in separate sections, and order findings by severity. Every finding must include a file location, concrete evidence, the applicable BCQuality rule, and a recommended correction.

Finish with a one-sentence accept-or-reject recommendation for the code in its current form. Consider this additional focus: `${input:focus}`.