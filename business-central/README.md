# Business Central Project

Hands-on GitHub Copilot exercises for Business Central developers. The repository uses a self-contained Follow-up extension, so participants can practice in AL without relying on a pre-existing customer or sales customization.

## Course Outcome

Participants can use GitHub Copilot in VS Code to understand AL, write a focused prompt, implement and validate a small change, diagnose a failure, write a test, and review AI-generated code before accepting it.

## Start Here

1. Open `business-central.code-workspace` in VS Code.
2. Sign in to GitHub Copilot and confirm that Copilot Chat and inline suggestions work.
3. Configure a personal AL sandbox launch configuration. Do not commit credentials or environment settings.
4. Download symbols for the configured sandbox, then package the App project.

## Repository Layout

- `App/`: the self-contained Follow-up extension used in the exercises.
- `Test/`: a separate test application, as required by the AL project structure guidance.
- `business-central.code-workspace`: opens both AL projects in VS Code.

## Validation Commands

Use the VS Code AL commands to download symbols, package, publish, and run the test app against a sandbox. Treat Copilot output as a proposal: package it, run the relevant test, and review the diff before keeping it.
