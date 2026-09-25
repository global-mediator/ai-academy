---
name: al-feature-development
description: "Plan and implement focused Business Central AL features in AI Academy exercises. Use when adding or extending fields, pages, actions, validation, or business logic. Do not use for review-only requests or build-only tasks."
argument-hint: "Describe the AL feature and its expected behavior"
user-invocable: true
---

# AL Feature Development

Turn a feature request into a small implementation with observable acceptance
checks. Keep the explanation suitable for a learner without adding unrelated
architecture or documentation.

This skill covers feature design and implementation. Follow the active agent's
compilation, reporting, and handoff instructions after the change.

## Define the Behavior

1. Identify the user action, affected record, and expected result.
2. Read the relevant exercise instructions and existing implementation.
3. State the scope and acceptance checks before editing.
4. Include the normal case and a relevant invalid-input or boundary case.
5. Ask only about missing details that would change the implementation.

For example, a field-copy feature needs a source value, destination record,
copying event, and expected result when the source is blank.

## Find the Implementation Point

Read the owning project's `app.json` for its runtime, dependencies, and object
ID range. This workspace separates application code in App from test code in
Test. Identify which project owns each planned change.

Trace the behavior to the table, page, codeunit, or event that controls it.
Inspect one nearby implementation or test for conventions.
Check object names, available members, and event signatures against the
project's symbols or matching source. Do not invent extension points.

Choose the smallest change that satisfies the acceptance checks. Keep reusable
business rules in the owning logic rather than only in a page action.

## Implement the Feature

Follow applicable AL instructions and preserve unrelated user changes.
Reuse existing helpers and test files where they fit the behavior.
Keep object IDs within the project range and dependencies within the declared
compatibility requirements. Do not change versions to make an implementation fit.

Consider validation, permissions, transaction behavior, and error handling only
where the feature affects them. Avoid unrelated refactoring and speculative
abstractions. Explain any implementation trade-off that changes user behavior.

## Prepare Validation

Map each acceptance check to an existing test, a focused test change, or a manual
check. Scale testing to the risk of the change. A posting or persisted-data
change needs checks for both stored values and relevant failure behavior.

For each manual check, give the setup, action, and expected result. Distinguish
planned checks from executed checks. Return to the active agent's validation
workflow after implementation. Compilation alone does not check these cases.

## Documentation Lookup

Use project symbols for exact API availability. Use Microsoft Learn when a
runtime rule or AL behavior is unclear. Match the documentation to the target
version before applying an example.

- [Manifest settings](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-json-files) describe runtime and dependency requirements.
- [AL symbol packages](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/al-agent-tools/al-tool-download-symbols) describe type information from dependencies.
- [Application testing](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-testing-application) covers successful and failing conditions.

Useful searches include `Business Central AL app.json runtime compatibility`
and `Business Central AL test methods positive negative tests`.
Search first, then fetch the relevant page. Request code samples only when a
concrete AL pattern needs clarification.

If Microsoft Learn MCP is unavailable, use the CLI equivalents:

| Operation | CLI command |
|-----------|-------------|
| Search documentation | `npx @microsoft/learn-cli search "<query>"` |
| Read a documentation page | `npx @microsoft/learn-cli fetch "<url>"` |
| Find code samples | `npx @microsoft/learn-cli code-search "<query>" --language al` |