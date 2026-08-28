window.quizData = {
    title: "Instructions, Skills, and Prompts Check",
    outcomes: [
        [90, "Ready to customize.", "You understand when to use instructions, skills, and prompts, and you know that AI output still needs verification."],
        [70, "Good grasp of the essentials.", "Review the explanations for any questions you missed, then try using each customization once."],
        [50, "The main ideas are landing.", "Revisit how each customization starts and what resources a skill can include."],
        [0, "Worth another pass.", "Read the explanations, then try again. Nothing here is graded and nothing is stored."]
    ],
    questions: [
        {
            topic: "Instructions",
            question: "When is an instruction file applied?",
            options: [
                "Only when the user types its filename.",
                "Automatically when the current file matches its applyTo pattern.",
                "Only after the application is compiled.",
                "Every time a skill is installed."
            ],
            correct: 1,
            feedback: "Instructions provide ongoing rules. The applyTo pattern decides which files they apply to."
        },
        {
            topic: "Instruction scope",
            question: "What does the Session 2 variable-prefix instruction ask the agent to do?",
            options: [
                "Prefix local variables with l, global variables with g, and parameters with p.",
                "Prefix every AL object with Session2.",
                "Use the same prefix for every variable.",
                "Rename all procedures automatically."
            ],
            correct: 0,
            feedback: "The instruction applies a small, consistent naming convention to Session 2 AL code."
        },
        {
            topic: "Skills",
            question: "How can a skill be started?",
            options: [
                "Only by restarting VS Code.",
                "Only when an applyTo pattern matches.",
                "The user can invoke it, or the AI can discover it when the task matches.",
                "It runs automatically after every file save."
            ],
            correct: 2,
            feedback: "Skills can be selected by the user, and the AI can discover a relevant skill from its description."
        },
        {
            topic: "Skill resources",
            question: "A team creates a skill that validates AL code and produces a report. What could the skill bundle?",
            options: [
                "A validation script, reference guidance, and a report template.",
                "An applyTo pattern that automatically runs the skill for every AL file.",
                "A saved chat transcript used as permanent project memory.",
                "A compiler extension automatically installed for every user."
            ],
            correct: 0,
            feedback: "Skills can bundle scripts, reference material, templates, and other assets that support their workflow."
        },
        {
            topic: "Prompts",
            question: "What is a prompt file best used for?",
            options: [
                "An automatic rule for every matching source file.",
                "A repeatable, focused request that the user starts manually.",
                "A replacement for source control.",
                "A script that always runs after compilation."
            ],
            correct: 1,
            feedback: "Prompt files save useful requests so users can run the same focused task again."
        },
        {
            topic: "Combining customizations",
            question: "What does the Review Session 2 prompt demonstrate?",
            options: [
                "One prompt can coordinate more than one skill for the files supplied in chat.",
                "A prompt automatically changes every attached file.",
                "Skills cannot be used from prompts.",
                "Instructions stop working when a prompt is used."
            ],
            correct: 0,
            feedback: "The prompt is a reusable entry point that asks the security and error-handling skills to review the supplied files."
        },
        {
            topic: "Security review",
            question: "Why is storing an API key in a normal Text field a concern?",
            options: [
                "Text fields cannot contain letters.",
                "The value is a secret but is being handled like ordinary text.",
                "API keys must be object IDs.",
                "The field is too short for a URL."
            ],
            correct: 1,
            feedback: "Credentials need secret-aware storage and handling instead of ordinary text values."
        },
        {
            topic: "External requests",
            question: "A service URL is stored in setup and passed to HttpClient. What should the extension do first?",
            options: [
                "Compare it with an approved host or URL pattern using the Uri codeunit.",
                "Check only that the URL field is not empty.",
                "Trust it because only setup users can change it.",
                "Send the request and rely on the HTTP status code."
            ],
            correct: 0,
            feedback: "A configurable URL is still input. Use Uri.AreURIsHaveSameHost or Uri.IsValidURIPattern to restrict it to an approved destination before calling HttpClient."
        },
        {
            topic: "Helpful errors",
            question: "A user enters too many reminders, and the valid maximum is known. What should the error do?",
            options: [
                "Say only that the value is invalid.",
                "Delete the setup record.",
                "Tell the user the allowed maximum so they can correct the value.",
                "Silently replace the value without explanation."
            ],
            correct: 2,
            feedback: "An actionable error explains how to recover. Include the known maximum in the message."
        },
        {
            topic: "Developer responsibility",
            question: "What should you do with findings produced by an AI review skill?",
            options: [
                "Accept every finding automatically.",
                "Verify the evidence and recommended correction before changing the code.",
                "Ignore every finding from a reusable skill.",
                "Publish the extension immediately."
            ],
            correct: 1,
            feedback: "Skills provide structured guidance, but the developer remains responsible for checking evidence and validating changes."
        }
    ]
};