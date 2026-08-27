(() => {
    "use strict";

    const quiz = window.quizData;

    const elements = {
        questionPanel: document.getElementById("question-panel"),
        completionPanel: document.getElementById("completion-panel"),
        questionCount: document.getElementById("question-count"),
        scoreSummary: document.getElementById("score-summary"),
        progressBar: document.getElementById("progress-bar"),
        questionTopic: document.getElementById("question-topic"),
        questionText: document.getElementById("question-text"),
        options: document.getElementById("options"),
        feedback: document.getElementById("feedback"),
        feedbackResult: document.getElementById("feedback-result"),
        feedbackCopy: document.getElementById("feedback-copy"),
        correctAnswer: document.getElementById("correct-answer"),
        prevButton: document.getElementById("prev-button"),
        nextButton: document.getElementById("next-button"),
        nextLabel: document.getElementById("next-label"),
        completionMark: document.getElementById("completion-mark"),
        finalScore: document.getElementById("final-score"),
        completionTitle: document.getElementById("completion-title"),
        completionMessage: document.getElementById("completion-message"),
        resetButton: document.getElementById("reset-button"),
        reviewButton: document.getElementById("review-button"),
        footerResetButton: document.getElementById("footer-reset-button"),
        liveRegion: document.getElementById("live-region")
    };

    if (!quiz || !Array.isArray(quiz.questions) || quiz.questions.length === 0) {
        elements.questionTopic.textContent = "Question data unavailable";
        elements.questionText.textContent = "The question set failed to load. Check that the quiz data file is present.";
        return;
    }

    const total = quiz.questions.length;

    /* picks[i] is the option index the learner committed for question i, or null.
       Score and progress are derived from it rather than accumulated, so moving
       backwards and forwards can never double-count or lose an answer. */
    const state = {
        questionIndex: 0,
        picks: new Array(total).fill(null),
        completed: false,
        started: false
    };

    /* Outcome bands: [minimum percentage, heading, message]. First match wins. */
    const DEFAULT_OUTCOMES = [
        [90, "Solid foundation.", "You are ready for the first lab. Keep the same habit in VS Code: predict what the model will miss, run the prompt, then compare the answer against the source."],
        [70, "Good grasp of the essentials.", "The core ideas are in place. Re-read the explanations for the ones you missed before the first lab."],
        [50, "The main ideas are landing.", "Revisit context boundaries and validation. Those two decide whether Copilot helps or quietly costs you time."],
        [0, "Worth another pass.", "Read the explanations, then run the questions again. Nothing here is graded and nothing is stored."]
    ];
    const outcomes = Array.isArray(quiz.outcomes) && quiz.outcomes.length > 0
        ? quiz.outcomes
        : DEFAULT_OUTCOMES;

    const currentQuestion = () => quiz.questions[state.questionIndex];
    const currentPick = () => state.picks[state.questionIndex];
    const isAnswered = () => currentPick() !== null;
    const isLast = () => state.questionIndex === total - 1;

    const score = () => state.picks.reduce(
        (n, pick, i) => n + (pick !== null && pick === quiz.questions[i].correct ? 1 : 0), 0);
    const answeredCount = () => state.picks.reduce((n, pick) => n + (pick === null ? 0 : 1), 0);

    function correctLabel(value) {
        return value === 1 ? "1 correct" : value + " correct";
    }

    function announce(message) {
        /* The live region stays in the DOM at all times. Unhiding an element that
           already contains a live region is unreliable across screen readers, so
           the visible feedback panel carries no aria-live of its own. The short
           delay lets the region re-fire when the same text is announced twice. */
        elements.liveRegion.textContent = "";
        window.setTimeout(() => { elements.liveRegion.textContent = message; }, 60);
    }

    function optionButtons() {
        return Array.from(elements.options.querySelectorAll(".option"));
    }

    function updateMeta() {
        elements.questionCount.textContent = "Question " + (state.questionIndex + 1) + " of " + total;
        elements.scoreSummary.textContent = correctLabel(score());
        /* Progress tracks answers given, not position, so browsing backwards
           never makes the bar retreat. */
        elements.progressBar.style.width = ((answeredCount() / total) * 100) + "%";
    }

    function clearFeedback() {
        elements.feedback.hidden = true;
        elements.feedback.className = "feedback";
        elements.feedbackResult.textContent = "";
        elements.feedbackCopy.textContent = "";
        elements.correctAnswer.textContent = "";
        elements.correctAnswer.hidden = true;
    }

    /* Paints the committed answer for the current question. Called both when an
       answer is first given and when the learner navigates back to it. */
    function revealAnswer() {
        const question = currentQuestion();
        const pick = currentPick();
        const wasCorrect = pick === question.correct;

        optionButtons().forEach((option, index) => {
            option.disabled = true;
            const status = option.querySelector(".option-status");
            status.textContent = "";
            option.classList.remove("is-correct", "is-wrong");

            if (index === question.correct) {
                option.classList.add("is-correct");
                status.textContent = index === pick
                    ? " (your answer, correct)"
                    : " (correct answer)";
            }
            if (index === pick && !wasCorrect) {
                option.classList.add("is-wrong");
                status.textContent = " (your answer, incorrect)";
            }
        });

        elements.feedback.hidden = false;
        elements.feedback.className = "feedback " + (wasCorrect ? "is-correct" : "is-wrong");
        elements.feedbackResult.textContent = wasCorrect ? "Correct" : "Not quite";
        elements.feedbackCopy.textContent = question.feedback;
        elements.correctAnswer.hidden = wasCorrect;
        elements.correctAnswer.textContent = wasCorrect
            ? ""
            : "Correct answer: " + question.options[question.correct];

        elements.nextButton.disabled = false;
        elements.nextLabel.textContent = isLast() ? "See your result" : "Next question";
        return wasCorrect;
    }

    function renderQuestion() {
        const question = currentQuestion();

        elements.questionPanel.hidden = false;
        elements.completionPanel.hidden = true;
        state.completed = false;

        updateMeta();
        elements.questionTopic.textContent = question.topic;
        elements.questionText.textContent = question.question;
        elements.prevButton.disabled = state.questionIndex === 0;

        elements.options.replaceChildren();
        question.options.forEach((optionText, optionIndex) => {
            const option = document.createElement("button");
            option.className = "option";
            option.type = "button";
            option.dataset.index = String(optionIndex);

            const marker = document.createElement("span");
            marker.className = "option-marker";
            marker.textContent = String.fromCharCode(65 + optionIndex);
            marker.setAttribute("aria-hidden", "true");

            const label = document.createElement("span");
            label.className = "option-label";
            label.textContent = optionText;

            /* Filled in on reveal so a screen reader hears the outcome on the
               option itself, not only in the feedback panel below. */
            const status = document.createElement("span");
            status.className = "sr-only option-status";

            option.append(marker, label, status);
            option.addEventListener("click", () => chooseAnswer(optionIndex));
            elements.options.appendChild(option);
        });

        if (isAnswered()) {
            revealAnswer();
        } else {
            clearFeedback();
            elements.nextButton.disabled = true;
            elements.nextLabel.textContent = "Choose an answer";
        }

        /* Move focus to the heading on every question after the first, so the new
           question is announced without stealing focus on initial page load. */
        if (state.started) {
            elements.questionText.focus();
            if (isAnswered()) {
                announce("Question " + (state.questionIndex + 1) + " of " + total +
                    ", already answered " +
                    (currentPick() === currentQuestion().correct ? "correctly." : "incorrectly."));
            }
        }
        state.started = true;
    }

    function chooseAnswer(optionIndex) {
        if (isAnswered()) {
            return;
        }

        state.picks[state.questionIndex] = optionIndex;
        const question = currentQuestion();
        const wasCorrect = revealAnswer();
        updateMeta();
        elements.nextButton.focus();

        announce([
            wasCorrect
                ? "Correct."
                : "Incorrect. The correct answer is: " + question.options[question.correct] + ".",
            question.feedback
        ].join(" "));
    }

    function renderCompletion() {
        const finalCount = score();
        const percentage = Math.round((finalCount / total) * 100);
        const band = outcomes.find((entry) => percentage >= entry[0]);

        elements.questionPanel.hidden = true;
        elements.completionPanel.hidden = false;
        state.completed = true;

        elements.questionCount.textContent = "Complete";
        elements.scoreSummary.textContent = finalCount + " / " + total;
        elements.progressBar.style.width = "100%";

        elements.completionMark.textContent = finalCount + " / " + total;
        elements.finalScore.textContent = percentage + "% correct";
        elements.completionTitle.textContent = band[1];
        elements.completionMessage.textContent = band[2];

        elements.completionTitle.focus();
        announce("Quiz complete. " + finalCount + " out of " + total + ", " +
            percentage + " percent. " + band[1] + " " + band[2]);
    }

    function goNext() {
        if (state.completed || !isAnswered()) {
            return;
        }
        if (isLast()) {
            renderCompletion();
            return;
        }
        state.questionIndex += 1;
        renderQuestion();
    }

    function goPrevious() {
        /* From the result screen, "back" returns to the last question so the
           learner can re-read the explanations. */
        if (state.completed) {
            state.questionIndex = total - 1;
            renderQuestion();
            return;
        }
        if (state.questionIndex === 0) {
            return;
        }
        state.questionIndex -= 1;
        renderQuestion();
    }

    function resetQuiz() {
        state.questionIndex = 0;
        state.picks.fill(null);
        state.completed = false;
        renderQuestion();
        announce("Quiz reset. Question 1 of " + total + ".");
    }

    /* ── Keyboard ─────────────────────────────────────────────────────────── */

    function moveOptionFocus(direction) {
        const buttons = optionButtons().filter((button) => !button.disabled);
        if (buttons.length === 0) {
            return;
        }
        const current = buttons.indexOf(document.activeElement);
        const nextIndex = current === -1
            ? 0
            : (current + direction + buttons.length) % buttons.length;
        buttons[nextIndex].focus();
    }

    document.addEventListener("keydown", (event) => {
        if (event.metaKey || event.ctrlKey || event.altKey) {
            return;
        }

        const key = event.key;

        /* Backspace works from the result screen too, so it is handled before
           the question-panel guard. preventDefault stops browsers that still
           map Backspace to history-back. */
        if (key === "Backspace") {
            event.preventDefault();
            goPrevious();
            return;
        }

        if (elements.questionPanel.hidden) {
            return;
        }

        const inOptions = elements.options.contains(document.activeElement);

        if (inOptions && (key === "ArrowDown" || key === "ArrowRight")) {
            event.preventDefault();
            moveOptionFocus(1);
            return;
        }
        if (inOptions && (key === "ArrowUp" || key === "ArrowLeft")) {
            event.preventDefault();
            moveOptionFocus(-1);
            return;
        }

        if (key === "Enter" && isAnswered()) {
            /* A focused button handles its own Enter natively; do not double-fire. */
            if (document.activeElement && document.activeElement.tagName === "BUTTON") {
                return;
            }
            event.preventDefault();
            goNext();
            return;
        }

        if (isAnswered()) {
            return;
        }

        let index = -1;
        if (key >= "1" && key <= "9") {
            index = Number(key) - 1;
        } else if (key.length === 1 && /[a-z]/i.test(key)) {
            index = key.toUpperCase().charCodeAt(0) - 65;
        }

        const buttons = optionButtons();
        if (index >= 0 && index < buttons.length) {
            event.preventDefault();
            buttons[index].focus();
            chooseAnswer(index);
        }
    });

    elements.prevButton.addEventListener("click", goPrevious);
    elements.nextButton.addEventListener("click", goNext);
    elements.reviewButton.addEventListener("click", goPrevious);
    elements.resetButton.addEventListener("click", resetQuiz);
    elements.footerResetButton.addEventListener("click", resetQuiz);

    renderQuestion();
})();
