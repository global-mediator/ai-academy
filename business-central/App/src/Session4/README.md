# Session 4: Agents, Subagents, and Handoffs

This session shows how custom agents in VS Code divide work. One agent writes code, a second agent compiles it, and a third agent reviews it. You watch two ways that work moves between them: a subagent call and a handoff.

## Learning outcomes

By the end of the session, you can:

1. Explain what a custom agent is: instructions, tools, and a model.
2. Describe the difference between a subagent call and a handoff.
3. Read the frontmatter fields that connect agents: `agents`, `handoffs`, `tools`, `user-invocable`, and `disable-model-invocation`.
4. Check what a subagent received and what it returned.
5. Explain why the tool list, not the instructions, sets the limits of an agent.

## Before the session

Open `business-central.code-workspace`. Package the App project once, so that symbols are available. Then open Copilot Chat and check that these agents appear in the agent picker:

- **AI Academy AL Developer**
- **AI Academy AL Reviewer**

**AI Academy AL Compiler** must not appear in the picker. That is intended. The next section explains why.

## The three agents

The agent files are in `App/.github/agents/`.

| Agent | File | Role | Can edit files | Started by |
| --- | --- | --- | --- | --- |
| AI Academy AL Developer | `al-developer.agent.md` | Implements the change | Yes | You, from the picker |
| AI Academy AL Compiler | `al-compiler.agent.md` | Compiles one project and returns `PASS`, `FAIL`, or `BLOCKED` | No | The Developer, as a subagent |
| AI Academy AL Reviewer | `al-reviewer.agent.md` | Reviews the change and reports findings | No | You, from the picker or a handoff |

## Subagent or handoff

| | Subagent | Handoff |
| --- | --- | --- |
| Example | The Developer calls the Compiler | The Developer passes the work to the Reviewer |
| Who decides | The model, while it works | You, when you select a button |
| Context | The subagent starts empty and receives only the prompt from the caller | The conversation history stays available |
| Active agent afterwards | Still the Developer | The Reviewer |
| What returns | A result that the caller reads and uses | Nothing. The next agent continues the work |
| Frontmatter | `agents:` and the `agent` tool | `handoffs:` |

A subagent is a call: the Developer asks a question and waits for the answer. A handoff is a transfer: the Developer stops and another agent continues.

## Guided lab

### 1. Read the agent files

Open the three agent files and find these fields:

- `agents:` in the Developer lists the only agent that it can call as a subagent.
- `tools:` in the Developer contains `agent` but not `al_build`. The Developer can only compile through the Compiler.
- `user-invocable: false` in the Compiler hides it from the picker.
- `disable-model-invocation: true` in the Developer and the Reviewer stops other agents from calling them as subagents.
- `handoffs:` in the Developer and the Reviewer define the buttons that appear after a response.

Compare the Reviewer instructions ("Do not edit files") with its `tools:` list. The list contains no edit tool. An instruction asks the model to behave in a certain way. The tool list decides what the model can do.

### 2. Read the starter code

The starter is in `App/src/Session4/Escalation/`:

- `ACASupportTicket.Table.al` stores support tickets and checks whether a ticket is overdue beyond a grace period.
- `ACATicketEscalation.Codeunit.al` counts the tickets that must be escalated.

The feature in this session uses these acceptance checks:

1. The `ACA Support Ticket` table has a Boolean field `Escalated`.
2. `ACA Ticket Escalation` has a procedure `EscalateOverdueTickets(AsOfDate: Date; GraceDays: Integer): Integer`.
3. The procedure sets `Escalated` on each open ticket that is overdue by more than `GraceDays` days and returns the number of tickets that it escalated.
4. A ticket with due date 1 January and a grace period of 3 days is not escalated on 4 January. It is escalated on 5 January.
5. A closed ticket or a ticket that is already escalated is not changed.
6. A negative grace period shows the existing error.

### 3. Watch a subagent call

Select **AI Academy AL Developer** and send this prompt:

> Implement the Session 4 escalation feature in `App/src/Session4/Escalation`. Add a Boolean field `Escalated` to `ACA Support Ticket`. Add `EscalateOverdueTickets(AsOfDate: Date; GraceDays: Integer): Integer` to `ACA Ticket Escalation`. It must escalate each open, not yet escalated ticket that is overdue beyond the grace period, and return the number of escalated tickets. Reuse the existing overdue check. Compile the App project when you finish.

While the Developer works, find the subagent call in the chat and expand it. Alt+click the call to open the subagent chat next to the main chat. The subagent chat is read-only. Answer these questions:

- Which prompt did the Developer send to the Compiler?
- Which result did the Compiler return?
- Did the Compiler see your original prompt? How do you know?

The Developer stays the active agent during the whole call. It reads the Compiler result and continues.

### 4. Hand off to the Reviewer

When the compilation passes, the Developer tells you that **Review the change** is available. Select the button. The chat now shows a prepared prompt for the Reviewer. The prompt is not sent yet because the handoff uses `send: false`. You can read and edit it first.

Send the prompt. Check the agent picker: the active agent is now **AI Academy AL Reviewer**. The Reviewer can read the earlier conversation, so it knows the acceptance checks from step 2.

Read the findings. Compare each finding with the acceptance checks and with the code.

### 5. Close the loop

If the Reviewer reports a blocker or a major finding, select **Fix the findings**. The Developer becomes active again, fixes the findings, and calls the Compiler again. You can hand off to the Reviewer a second time to check the fix.

### 6. Change an agent and watch the effect

Make one change at a time. Run the same prompt again after each change, then undo the change.

- Remove `agent` from the Developer `tools:` list. Check whether the Developer can still compile.
- Change `send: false` to `send: true` in the Developer handoff. Check what happens when you select the button.
- Remove `AI Academy AL Compiler` from the Developer `agents:` list. Check which agents the Developer can call.

## Homework

Add tests for the escalation boundary with the same agents:

1. Select **AI Academy AL Developer** and ask it to add tests to the Test project for acceptance checks 4 and 5.
2. Check that the Developer calls the Compiler twice: first for App, then for Test.
3. Hand off to the Reviewer and ask it to check that the tests cover the boundary on 4 and 5 January.
4. Commit only the files needed for the exercise, push your branch, and open a pull request.

## Definition of done

- `EscalateOverdueTickets` escalates only open tickets that are overdue by more than the grace period.
- The boundary example in acceptance check 4 gives the expected result.
- The App project compiles. The Test project compiles if you did the homework.
- You can explain the difference between the Compiler call and the Reviewer handoff.
- Only the files needed for the exercise are committed.

## Knowledge check

After the session, take the [Agents, Subagents, and Handoffs Check](https://global-mediator.github.io/ai-academy/session-04.html). The quiz contains ten questions, does not submit or store answers, and can be retried at any time.

## References

- [VS Code custom agents](https://code.visualstudio.com/docs/agent-customization/custom-agents)
- [VS Code subagents](https://code.visualstudio.com/docs/copilot/agents/subagents)
