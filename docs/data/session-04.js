window.quizData = {
    title: "Agents, Subagents, and Handoffs Check",
    outcomes: [
        [90, "Ready to design multi-agent workflows.", "You understand agent files, subagent calls, handoffs, and tool limits."],
        [70, "Good operational foundation.", "Review the explanations for any missed questions, especially context and tool limits."],
        [50, "The pattern is taking shape.", "Revisit how a subagent call differs from a handoff."],
        [0, "Worth another pass.", "Review the agent, subagent, and handoff sections, then try again. Nothing here is graded or stored."]
    ],
    questions: [
        {
            topic: "Custom agent files",
            question: "You want to create your own custom agent in a repository. Which file do you add?",
            options: [
                "An AGENTS.md file in the root of the repository.",
                "A settings.json file in the .vscode folder.",
                "A *.agent.md file, for example in .github/agents.",
                "A comment block at the top of a source file."
            ],
            correct: 2,
            feedback: "A custom agent is a file whose name ends in .agent.md, for example reviewer.agent.md. AGENTS.md is different: it holds instructions that all agents in the repository follow. A VS Code extension can also contribute agents, which is how a team can share agents across repositories."
        },
        {
            topic: "Subagent access",
            question: "Which tool does an agent need to call a subagent?",
            options: [
                "edit",
                "agent",
                "search",
                "read"
            ],
            correct: 1,
            feedback: "Without the agent tool, an agent cannot call other agents. The agents list in the frontmatter can also limit which agents it may call."
        },
        {
            topic: "Subagent or handoff",
            question: "What is the main difference between a subagent call and a handoff?",
            options: [
                "The agent starts a subagent call. You start a handoff.",
                "A subagent call edits files. A handoff only reads them.",
                "A subagent call is slower than a handoff.",
                "There is no difference. Both names mean the same thing."
            ],
            correct: 0,
            feedback: "The agent decides to call a subagent while it works. A handoff is a button that you select when you want another agent to continue."
        },
        {
            topic: "Subagent context",
            question: "What does a subagent see when it starts?",
            options: [
                "The full chat history of the calling agent.",
                "All files that are open in the editor.",
                "The results of all earlier subagent calls.",
                "Only the prompt that the calling agent sends."
            ],
            correct: 3,
            feedback: "A subagent runs in its own context window and does not get the chat history. The calling agent must put every detail the subagent needs into the prompt."
        },
        {
            topic: "Subagent models",
            question: "A subagent file has no model setting. Which model does the subagent use?",
            options: [
                "The cheapest model that is available.",
                "The model of the chat that called it.",
                "A model that VS Code picks at random.",
                "The model you used in your last chat."
            ],
            correct: 1,
            feedback: "VS Code checks three places in order: a model named in the call, the model in the agent file, and the model of the calling chat."
        },
        {
            topic: "Subagent models",
            question: "Can a subagent use a more expensive model than the main chat?",
            options: [
                "Yes, if its agent file names that model.",
                "Yes, but only when you approve each call.",
                "Only when the subagent has no edit tool.",
                "No, it cannot go above the main model's cost tier."
            ],
            correct: 3,
            feedback: "A subagent can use the same or a cheaper model. This lets you give simple jobs, such as search, to a fast and cheap model."
        },
        {
            topic: "Subagent models",
            question: "The model setting in an agent file lists two models. What does that mean?",
            options: [
                "VS Code uses the first model that is available.",
                "Both models answer, and you pick the better answer.",
                "The agent switches models after each message.",
                "The second model reviews the first model's work."
            ],
            correct: 0,
            feedback: "A list is a fallback order. If the first model is not available, VS Code tries the next one."
        },
        {
            topic: "Handoffs",
            question: "After a handoff, which agent is active?",
            options: [
                "The first agent, which waits for a result.",
                "The new agent, which can see the conversation.",
                "Both agents, which answer at the same time.",
                "No agent, until you start a new chat."
            ],
            correct: 1,
            feedback: "A handoff changes the active agent. The conversation history stays, so the new agent knows what happened before."
        },
        {
            topic: "Handoff prompts",
            question: "A handoff has send: false. What happens when you select the handoff button?",
            options: [
                "The prompt is sent to the next agent at once.",
                "The button stays disabled until the build passes.",
                "The next agent is hidden from the agent picker.",
                "The prompt is filled in, and you can edit it first."
            ],
            correct: 3,
            feedback: "With send: false, you can read and change the prompt before you send it. With send: true, the prompt is sent at once."
        },
        {
            topic: "Agent visibility",
            question: "An agent has user-invocable: false. What does that mean?",
            options: [
                "It is not in the picker, but other agents can call it.",
                "It has no tools, so it can only answer questions.",
                "It can call other agents, but it cannot edit files.",
                "It is deleted after the first time it runs."
            ],
            correct: 0,
            feedback: "Use this setting for a helper agent that only other agents call. You do not see it in the agent picker."
        },
        {
            topic: "Tool limits",
            question: "An agent's instructions say \"Do not edit files.\" What really stops it from editing?",
            options: [
                "The instruction text in the agent file.",
                "The model that the agent uses.",
                "Its tool list has no edit tool.",
                "The name of the agent file."
            ],
            correct: 2,
            feedback: "Instructions only ask the model to behave in a certain way. The tool list decides what the agent can do."
        },
        {
            topic: "Subagent visibility",
            question: "How do you see what a subagent did?",
            options: [
                "Select the subagent in the agent picker.",
                "Open the Output panel and select Copilot.",
                "You cannot, because subagent calls are hidden.",
                "Expand the subagent call in the chat."
            ],
            correct: 3,
            feedback: "The subagent call shows as a collapsible item in the chat. Select it to see the prompt that the subagent received and the result that it returned."
        },
        {
            topic: "Context window",
            question: "A model has a context window of 1 million tokens. What happens as a long chat fills it?",
            options: [
                "Quality stays the same until the window is full.",
                "The model gets smarter because it knows more.",
                "Quality drops well before the window is full.",
                "VS Code stops the chat when half is used."
            ],
            correct: 2,
            feedback: "The more the context holds, the more the model misses details and makes things up. The part of the window where the model still works well is much smaller than the maximum size."
        },
        {
            topic: "Context",
            question: "Why should a subagent return a short result instead of whole files?",
            options: [
                "Short results make the build run faster.",
                "The calling agent keeps its context small.",
                "Subagents cannot read files longer than 100 lines.",
                "VS Code deletes long results from the chat."
            ],
            correct: 1,
            feedback: "The calling agent reads everything that the subagent returns. A short result with file and line references leaves room for the actual work."
        }
    ]
};
