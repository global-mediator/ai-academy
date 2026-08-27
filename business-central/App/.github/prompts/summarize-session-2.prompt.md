---
name: "Summarize Session 2"
description: "Summarize the Session 2 AL files, instructions, prompts, and skills as a short end-of-session recap."
agent: "agent"
---

Review the Session 2 learning materials in this workspace:

- AL code and documentation under `src/Session2/`
- Instruction files under `.github/instructions/`
- Prompt files under `.github/prompts/`
- Skills under `.github/skills/`

Summarize what was learned about writing AL code and customizing an AI coding agent. Mention the purpose of the reminder example and explain how instructions, prompts, and skills each guide the agent differently.

Include this short, beginner-friendly comparison as a Markdown table:

| Type | How it is applied | Best used for | Resources it can include |
| --- | --- | --- | --- |
| Instructions | Automatically applied to files matched by `applyTo` | Ongoing rules and coding conventions | Normally one instruction file |
| Skills | Manually invoked or discovered by the AI | Reusable knowledge and multi-step workflows | Scripts, references, templates, and assets loaded or run when needed |
| Prompts | Manually invoked by the user | Repeatable, focused requests | Normally one prompt file that can reference files and tools |

Keep the recap and table brief, clear, and suitable for presenting aloud to beginners at the end of a training session. Avoid technical details beyond the differences shown in the table. Use clickable workspace-relative links when referring to files.

Start exactly with:

> Here is what we have learned today...

End exactly with:

> See you next time.