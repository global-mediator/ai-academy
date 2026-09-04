window.quizData = {
    title: "MCP Servers and Tools Check",
    outcomes: [
        [90, "Ready to use MCP deliberately.", "You understand setup, tool boundaries, and the controls needed for enterprise use."],
        [70, "Good operational foundation.", "Review the explanations for any missed questions, especially approval and data-access boundaries."],
        [50, "The workflow is taking shape.", "Revisit which server answers each question and which tools can modify files."],
        [0, "Worth another pass.", "Review the setup and governance sections, then try again. Nothing here is graded or stored."]
    ],
    questions: [
        {
            topic: "Configuration scope",
            question: "Where should a reproducible MCP server configuration shared by a project team be stored in VS Code?",
            options: [
                "In a committed .vscode/mcp.json file.",
                "Inside an AL source file.",
                "In each developer's chat history.",
                "In a committed file containing every developer's credentials."
            ],
            correct: 0,
            feedback: "Workspace MCP configuration can be committed and shared. Secrets and machine-specific values must remain outside it."
        },
        {
            topic: "Server trust",
            question: "What should you review before starting a newly configured local MCP server?",
            options: [
                "Only the server's display name.",
                "Its publisher, source, launch command, requested access, and transport.",
                "Only whether another developer has used MCP before.",
                "Nothing, because MCP servers are sandboxed automatically on Windows."
            ],
            correct: 1,
            feedback: "A local server can execute code with the user's privileges. Review its provenance and configuration before granting trust."
        },
        {
            topic: "MarkItDown",
            question: "What does MarkItDown MCP do in the Session 3 workflow?",
            options: [
                "It implements the AL requirements automatically.",
                "It validates whether the requirements are correct.",
                "It converts the Word document into structured Markdown for the agent.",
                "It publishes the extension to Business Central."
            ],
            correct: 2,
            feedback: "MarkItDown converts the document. The agent interprets the Markdown, and the developer verifies that interpretation."
        },
        {
            topic: "Microsoft Learn",
            question: "After Microsoft Learn search returns a promising result, what is the best next step for an implementation decision?",
            options: [
                "Use the search snippet as the complete source.",
                "Fetch the official page and verify the relevant guidance in context.",
                "Replace the source with an unauthenticated forum answer.",
                "Assume the model already knows the current behavior."
            ],
            correct: 1,
            feedback: "Search gives breadth. Fetch the official page when the decision depends on complete, current guidance."
        },
        {
            topic: "AL Symbols",
            question: "What does AL Symbols MCP analyze?",
            options: [
                "Only raw AL files currently open in the editor.",
                "Compiled .app package symbols and their object relationships.",
                "Word documents containing functional requirements.",
                "The user's Jira permissions."
            ],
            correct: 1,
            feedback: "AL Symbols indexes compiled packages, making dependency contracts visible even when their source is not in the repository."
        },
        {
            topic: "Efficient retrieval",
            question: "How should you begin an AL Symbols investigation?",
            options: [
                "Request every full object definition at once.",
                "Start with search or summaries, then retrieve details only when needed.",
                "Ask the model to invent the event signature.",
                "Disable package loading and search the internet instead."
            ],
            correct: 1,
            feedback: "Search and summary tools reduce noise and context cost. Full definitions belong later in the investigation."
        },
        {
            topic: "ALCops",
            question: "Which ALCops operations require special care because they can modify repository files?",
            options: [
                "list_rules and analyze",
                "analyze and get_fixes",
                "apply_fix and apply_fix_all",
                "Every search result from Microsoft Learn"
            ],
            correct: 2,
            feedback: "The apply operations write changes to disk. Inspect the fix and retain explicit approval before applying it."
        },
        {
            topic: "Tool governance",
            question: "What is the least-privilege approach to MCP tools during a task?",
            options: [
                "Enable every installed tool permanently.",
                "Enable only the required tools and approve consequential actions at the narrowest useful scope.",
                "Bypass all approvals after trusting one server.",
                "Store credentials in mcp.json so every tool can reuse them."
            ],
            correct: 1,
            feedback: "Limit both capability and approval duration. Server trust does not mean every tool invocation should be permanently approved."
        },
        {
            topic: "Enterprise control",
            question: "Which control best supports a governed enterprise MCP catalogue?",
            options: [
                "Allow any package name as long as it starts through npx.",
                "Use a curated registry with ownership, version review, and lifecycle management.",
                "Ask every developer to maintain a private list with no central review.",
                "Disable source control for MCP configuration."
            ],
            correct: 1,
            feedback: "A curated registry makes approved servers discoverable while supporting ownership, review, updates, and retirement."
        },
        {
            topic: "MCP and CLI",
            question: "Why might an enterprise prioritize an approved MCP tool over giving an agent unrestricted CLI access?",
            options: [
                "MCP guarantees that every server is secure.",
                "CLI commands cannot return structured data.",
                "An MCP tool exposes a named, schema-defined capability that can be enabled, approved, and governed independently.",
                "MCP removes the need for code review and CI."
            ],
            correct: 2,
            feedback: "MCP creates a structured control surface. Its safety still depends on the server, permissions, configuration, and enterprise controls."
        }
    ]
};