# AI Academy: GitHub Copilot for Business Central

This student repository contains a Business Central AL project and a self-assessment quiz.

## Repository Layout

- `business-central/`: the AL application, test application, and VS Code workspace.
- `docs/`: the static quiz published with GitHub Pages.

## Business Central Project

See [business-central/README.md](business-central/README.md) for setup and validation instructions.

## Quiz and GitHub Pages

The quiz files are stored in `docs/` and can be published directly with GitHub Pages. After Pages is enabled, open the [AI Academy quiz](https://global-mediator.github.io/ai-academy/).

1. Open the repository on GitHub and go to **Settings > Pages**.
2. Under **Build and deployment**, select **Deploy from a branch**.
3. Select the `main` branch and the `/docs` folder.
4. Save the configuration and wait for GitHub to publish the site.

Changes under `docs/` are published when they are pushed to `main`. No CI workflow is required, and the quiz does not submit or store students' answers.