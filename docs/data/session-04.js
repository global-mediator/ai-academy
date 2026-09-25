window.quizData = {
    title: "Agents, Subagents, and Handoffs Check",
    outcomes: [
        [90, "Ready to design multi-agent workflows.", "You understand agent files, subagent calls, handoffs, and the limits of both."],
        [70, "Good operational foundation.", "Review the explanations for any missed questions, especially statelessness and tool boundaries."],
        [50, "The pattern is taking shape.", "Revisit how subagent calls differ from handoffs, and what each setting controls."],
        [0, "Worth another pass.", "Review the agent, subagent, and handoff sections, then try again. Nothing here is graded or stored."]
    ],
    questions: [
        {
            topic: "Custom agent files",
            question: "How is a custom agent defined in VS Code?",
            options: [
                "As a compiled extension registered with the VS Code extension host.",
                "As a JSON file that lists approved npm packages.",
                "As an .agent.md file with frontmatter fields such as name, description, and tools, plus a Markdown body of instructions.",
                "As a folder of automated tests that run before each chat session."
            ],
            correct: 2,
            feedback: "A custom agent is a Markdown file with a .agent.md extension. Frontmatter fields such as name, description, tools, model, agents, handoffs, user-invocable, and disable-model-invocation configure it, and the Markdown body holds the instructions."
        },
        {
            topic: "Subagent access",
            question: "What controls whether an agent can call a subagent, and which specific custom agents it may call?",
            options: [
                "The caller needs the agent tool in its tools list, and its agents list (an empty list means none) restricts which custom agents it may call.",
                "Any agent can call any other agent as a subagent with no configuration required.",
                "The agents list controls handoffs only, not subagent calls.",
                "The caller needs a build tool before it can call any subagent."
            ],
            correct: 0,
            feedback: "A subagent call is agent-initiated. The model decides to call it while it works, but only if the caller has the agent tool and the target agent is allowed by the caller's agents list."
        },
        {
            topic: "Subagent execution",
            question: "What happens when an agent calls a subagent?",
            options: [
                "The subagent joins the conversation permanently and the parent can address it directly afterward.",
                "Each invocation is stateless. The subagent starts with its own context, receives only the prompt it was sent, and returns only a summary or result. The caller stays the active agent.",
                "The subagent becomes the new active agent for the rest of the conversation.",
                "The subagent automatically receives the full chat history from the parent agent."
            ],
            correct: 1,
            feedback: "The subagent cannot see the ongoing chat, and the parent cannot send follow-up messages to that same subagent call. This is why a caller must state needed details, such as a project path, an app name, or changed files, directly in the prompt it sends."
        },
        {
            topic: "Subagent model selection",
            question: "Which model does a subagent use when it runs?",
            options: [
                "Always the least expensive model installed, regardless of any configuration.",
                "An explicit model parameter first, then the subagent's own model frontmatter, then the parent's model. A subagent cannot request a model more expensive than the parent's.",
                "Always the parent agent's model, with no possible override.",
                "Whichever model the user last selected in an unrelated chat."
            ],
            correct: 1,
            feedback: "Model selection follows a priority order: an explicit model parameter wins first, then the subagent's own frontmatter setting, then the parent's model. A subagent cannot pick a more expensive model than its parent."
        },
        {
            topic: "Subagent visibility",
            question: "How can you inspect a subagent call after it appears in the chat?",
            options: [
                "It appears as a collapsible tool call, and you can open its read-only chat side by side with Alt+click.",
                "It appears as a new editable chat tab where you can send further prompts.",
                "It runs with no visible trace in the chat transcript.",
                "It replaces the parent agent's chat window entirely."
            ],
            correct: 0,
            feedback: "Subagent calls show up as collapsible tool calls in the parent chat. Alt+click opens the subagent's chat side by side, but that chat is read-only."
        },
        {
            topic: "Handoffs",
            question: "What is a handoff in VS Code custom agents?",
            options: [
                "A background subagent call that the user never sees.",
                "A button shown after a response that the user selects to switch the active agent, carrying the conversation history with it.",
                "A setting that merges the tool lists of two agents into one.",
                "A required step before any agent can call a subagent."
            ],
            correct: 1,
            feedback: "A handoff is user-initiated, unlike a subagent call. The user selects the button, and the conversation history carries over to the newly active agent."
        },
        {
            topic: "Handoff prompts",
            question: "What is the difference between send: false and send: true on a handoff?",
            options: [
                "send: false disables the handoff button, and send: true enables it.",
                "send: false hides the target agent from the agents dropdown, and send: true shows it.",
                "send: false restricts the target agent's tools, and send: true restores them.",
                "send: false pre-fills the prompt so the user can review and edit it before sending, and send: true submits the prompt automatically."
            ],
            correct: 3,
            feedback: "Both settings control what happens to the pre-filled prompt after the handoff switches the active agent. send: false leaves it for review, and send: true submits it right away."
        },
        {
            topic: "Agent visibility settings",
            question: "What is the difference between user-invocable: false and disable-model-invocation: true on a custom agent?",
            options: [
                "The two settings are interchangeable and produce the same result.",
                "user-invocable: false disables handoffs to the agent, and disable-model-invocation: true disables the agent's own tools.",
                "user-invocable: false hides the agent from the agents dropdown but still allows it to be called as a subagent. disable-model-invocation: true prevents other agents from calling it as a subagent but does not affect handoffs.",
                "user-invocable: false deletes the agent's frontmatter, and disable-model-invocation: true deletes the agent file."
            ],
            correct: 2,
            feedback: "These settings target different callers. user-invocable: false hides an agent from the picker while keeping it callable as a subagent, and disable-model-invocation: true blocks subagent calls to it. It does not block handoffs."
        },
        {
            topic: "Tool governance",
            question: "If a custom agent's Markdown instructions say \"Do not edit files,\" is the agent guaranteed to be read-only?",
            options: [
                "Yes, Markdown instructions are enforced the same way as tool restrictions.",
                "Yes, VS Code blocks any tool call that contradicts the agent's stated instructions.",
                "No, the model always ignores its own written instructions.",
                "No, instructions only ask. The agent is read-only only when its tool list has no edit or build tools."
            ],
            correct: 3,
            feedback: "The tool list sets what an agent can actually do. Written instructions are a request, not a boundary, so check the tool list, not the wording, to confirm an agent cannot modify files."
        },
        {
            topic: "Course scenario",
            question: "In the course scenario, how does the AI Academy AL Developer agent get its code compiled?",
            options: [
                "It calls the AI Academy AL Compiler as a subagent, because it has no al_build tool of its own.",
                "It uses its own al_build tool directly, without calling any other agent.",
                "It hands off to the AI Academy AL Reviewer, which compiles the code before reviewing it.",
                "It asks the user to run the compiler manually before it continues."
            ],
            correct: 0,
            feedback: "The Developer has no al_build tool, so it can only compile through the Compiler subagent, which returns PASS, FAIL, or BLOCKED and is hidden from the agent picker. A PASS proves the code compiles, not that its runtime behavior is correct. After a PASS, the Developer offers a Review the change handoff to the AI Academy AL Reviewer, which can hand off Fix the findings back."
        }
    ]
};
