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
            question: "Which capabilities does the Microsoft Learn MCP server provide in this session?",
            options: [
                "Searching official documentation, retrieving complete documentation pages, and finding official code samples.",
                "Compiling AL projects and publishing extensions to Business Central.",
                "Converting local Word documents and editing their contents.",
                "Analyzing compiled .app packages and applying AL code fixes."
            ],
            correct: 0,
            feedback: "Microsoft Learn MCP gives the agent access to official Microsoft documentation through search, full-page retrieval, and code-sample search tools."
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
            feedback: "AI coding assistants cannot normally see compiled AL packages or understand Business Central object relationships, creating a blind spot in AL development. The AL MCP Server bridges this gap by exposing the workspace's compiled symbols (.app files) through the Model Context Protocol, making dependency contracts visible even when their source is not in the repository."
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
                "Listing the available rules and analyzing the project.",
                "Analyzing the project and reviewing available fixes.",
                "Applying an individual fix or applying all available fixes.",
                "Reading search results from Microsoft Learn."
            ],
            correct: 2,
            feedback: "Applying a fix changes files on disk, whether you apply one fix or all available fixes. Review the proposed changes and require explicit approval before applying them."
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
            topic: "Troubleshooting",
            question: "What should you do first if a configured MCP server fails to start in VS Code?",
            options: [
                "Open MCP: List Servers, select the server, and inspect Show Output.",
                "Delete the shared MCP configuration and recreate it from memory.",
                "Enable every MCP tool and approve all future actions.",
                "Reinstall VS Code before checking the error message."
            ],
            correct: 0,
            feedback: "The server output shows the actual launch or connection error. Check it first so you can fix the specific command, prerequisite, path, or network problem."
        },
        {
            topic: "Tool capabilities",
            question: "If an agent's dedicated file-editing tool is disabled, can the agent still modify files?",
            options: [
                "No. Disabling that tool removes every possible way to write files.",
                "Yes. Another enabled tool may execute Python or a command that writes files.",
                "Only when the files are stored in a GitHub repository.",
                "Only when an MCP server is listed in the workspace configuration."
            ],
            correct: 1,
            feedback: "Tools are interfaces, not complete capability boundaries. Disabling one editing tool does not prevent file changes if another enabled tool can run code or commands with write access. Consider the combined capabilities and permissions of all enabled tools."
        }
    ]
};