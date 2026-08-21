window.quizData = {
    title: "Copilot Foundations Check",
    questions: [
        {
            topic: "Autocomplete → Copilot",
            question: "Which statement best captures the shift from traditional autocomplete to GitHub Copilot?",
            options: [
                "Copilot only completes one keyword at a time.",
                "Copilot can generate context-aware code from comments and surrounding code, but suggestions still require review.",
                "Copilot compiles every suggestion before showing it.",
                "Copilot removes the need to understand the programming language."
            ],
            correct: 1,
            feedback: "Copilot can work from intent, comments, and surrounding code to propose larger pieces of code. The proposal is still untrusted until the developer understands and validates it."
        },
        {
            topic: "Accept, reject, refine",
            question: "An inline completion is unrelated to your task, and you do not want to use it. What should you do?",
            options: [
                "Accept it and edit until it works.",
                "Dismiss it. If suggestions remain irrelevant, clarify the comment, code, or context.",
                "Ask Copilot to finish the entire application.",
                "Turn off all editor suggestions permanently."
            ],
            correct: 1,
            feedback: "Dismiss code that does not match your intent. If irrelevant suggestions continue, make the nearby intent or context clearer."
        },
        {
            topic: "Writing the first prompt",
            question: "Which prompt is most likely to produce a useful, source-based explanation of the Follow-up table?",
            options: [
                "Explain this.",
                "Tell me about AL.",
                "Explain this table. List each field and its purpose, then identify one validation risk supported by this file.",
                "Generate something useful."
            ],
            correct: 2,
            feedback: "The prompt states the goal, requested output, and evidence boundary."
        },
        {
            topic: "Context: active file and selection",
            question: "You want Copilot to explain one procedure without making changes. Which context choice is most focused?",
            options: [
                "Select the procedure and ask Copilot to explain only that selection without editing files.",
                "Attach every file in the repository without adding a question.",
                "Use the whole active file without selecting the procedure.",
                "Start by asking Copilot to rewrite the project."
            ],
            correct: 0,
            feedback: "A focused selection reduces unrelated context. Explicitly saying not to edit files keeps the request read-only."
        },
        {
            topic: "Context: related files",
            question: "Copilot says the Follow-up table contains a field. What should you do before trusting the claim?",
            options: [
                "Trust the explanation because Copilot saw the workspace.",
                "Ask for a shorter answer.",
                "Check the actual source or authoritative symbols, then correct or refine the prompt.",
                "Add the missing field immediately."
            ],
            correct: 2,
            feedback: "A plausible response is not evidence. Check the source and authoritative symbols before accepting or rejecting Copilot's claim."
        },
        {
            topic: "Context: references and constraints",
            question: "Which prompt gives Copilot the clearest task boundary?",
            options: [
                "Improve this.",
                "Use the selected procedure and the related table. Explain the current behavior only; do not edit files.",
                "Make it production ready somehow.",
                "Do everything needed."
            ],
            correct: 1,
            feedback: "The prompt names the relevant context, the desired action, and a constraint. It also prevents an explanation request from turning into an unsolicited edit."
        },
        {
            topic: "Conversation history",
            question: "A follow-up question depends on the explanation Copilot just gave. What can conversation history provide?",
            options: [
                "Continuity for the follow-up, while still requiring you to verify claims.",
                "A guarantee that every previous statement is correct.",
                "Permission to skip reading the source.",
                "A permanent record available to every future chat."
            ],
            correct: 0,
            feedback: "Conversation history can preserve useful context between turns. It does not make earlier claims authoritative, and it may become stale or contain wrong assumptions."
        },
        {
            topic: "Stale context",
            question: "After several prompt revisions, the chat contains conflicting assumptions. What is a sound reset?",
            options: [
                "Keep adding messages until the model guesses correctly.",
                "Start a focused new conversation with the current files, constraints, and acceptance criteria.",
                "Delete the source code.",
                "Accept the last suggestion without review."
            ],
            correct: 1,
            feedback: "A fresh, bounded conversation can remove stale assumptions. Re-state the current evidence and acceptance criteria before asking for the next response."
        },
        {
            topic: "The developer remains accountable",
            question: "Copilot produces code that looks plausible. What evidence should decide whether you keep it?",
            options: [
                "The confidence of the wording.",
                "The number of lines generated.",
                "Source inspection, compiler or analyzer feedback, tests, and human review.",
                "Whether the code appeared quickly."
            ],
            correct: 2,
            feedback: "Plausibility is not proof. Review the diff and validate the result with the tools and evidence appropriate to the change."
        },
        {
            topic: "Verify explanations",
            question: "Copilot explains the Follow-up table. What should you do before relying on the explanation?",
            options: [
                "Compare important claims with the actual table source.",
                "Assume every statement is correct because the table is open.",
                "Ask for a longer explanation instead of checking the source.",
                "Copy the explanation into the documentation immediately."
            ],
            correct: 0,
            feedback: "Copilot's explanation is a useful starting point, but the source remains the evidence. Check important claims before relying on them."
        }
    ]
};
