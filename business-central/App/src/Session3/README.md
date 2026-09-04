# Session 3: Using MCP Servers and Tools

This session is about operating existing MCP servers in VS Code.

## Learning outcomes

By the end of the session, you can:

1. Configure local STDIO and remote HTTP MCP servers in VS Code.
2. Inspect and enable only the tools needed for a task.
3. Use MarkItDown, Microsoft Learn, AL Symbols, and ALCops in one development workflow.
4. Explain the access and governance boundary of each server.
5. Submit a reviewable implementation through a pull request.

## Before the session

Open `business-central.code-workspace`, then check these prerequisites:

| Server | Prerequisite | Transport |
| --- | --- | --- |
| MarkItDown | Python and `uv`/`uvx` | Local STDIO |
| Microsoft Learn | Network access to `learn.microsoft.com` | Remote HTTP |
| AL Symbols | Node.js 18+, .NET SDK 8+, compiled `.app` symbols | Local STDIO |
| ALCops | .NET 10 and AL Language extension 17+ | Local STDIO |

Install ALCops once with `dotnet tool install -g ALCops.Mcp`. The other local servers are launched on demand by the shared `business-central/.vscode/mcp.json` configuration.

Never add credentials, tokens, private endpoints, or machine-specific symbol paths to the shared MCP configuration.

## Setup check

1. Run **MCP: List Servers** from the Command Palette.
2. Start each configured server and review its trust prompt and command before approving it.
3. Open **Configure Tools** in Copilot Chat and locate the tools listed below.
4. Disable tools that are not needed for the current exercise.
5. If a server fails, use **MCP: List Servers > Show Output** before changing its configuration.

Expected tools:

- MarkItDown: `convert_to_markdown`
- Microsoft Learn: `microsoft_docs_search`, `microsoft_docs_fetch`, `microsoft_code_sample_search`
- AL Symbols: `al_packages`, `al_search_objects`, `al_get_object_summary`, `al_get_object_definition`, `al_search_object_members`, `al_find_references`
- ALCops: `list_rules`, `analyze`, `get_fixes`, `apply_fix`, `apply_fix_all`

## Guided lab

### 1. Turn the Word specification into context

Use MarkItDown `convert_to_markdown` on `Session3/DeliveryInstructions/Delivery Instructions Requirements.docx` with an absolute `file:` URI. Ask the agent to return:

- numbered functional requirements;
- acceptance criteria;
- constraints and exclusions;
- ambiguities that require a decision.

MarkItDown converts the document. The agent interprets the returned Markdown. Check the extraction against the Word document before coding.

### 2. Inspect the real BC contracts

Use `al_packages` to confirm that packages are loaded. If none are loaded, load the symbol directory configured in your VS Code `al.packageCachePath`; do not commit that machine-specific path.

Use AL Symbols to inspect, in this order:

1. `Sales Header` table and the relevant custom fields.
2. `Sales Order` page and a suitable placement anchor.
3. `Sales Shipment Header` table.
4. `Posted Sales Shipment` page.
5. The posting objects or references that can identify where a shipment header is created.

Start with search or summary tools. Retrieve a full definition only when the summary does not answer the question. Record the object, member, or event evidence used in your design.

### 3. Verify guidance with Microsoft Learn

Ask the agent to use Microsoft Learn for current guidance on AL table extensions, page extensions, event subscribers, and validation. The server can search official documentation, retrieve a complete page when more context is useful, and find official code samples.

Review the guidance the agent uses before accepting its implementation.

### 4. Complete the implementation

The starter already adds the two fields to sales orders and posted sales shipments and displays them on both pages. Complete the missing behavior:

1. A sales order with delivery instructions must also have a delivery contact.
2. The error must tell the user how to correct the order and must use a `Label`.
3. Posting a shipment must copy both fields to the posted sales shipment.
4. The implementation must extend standard behavior through supported extension points.

### 5. Analyze, inspect, fix, verify

Run ALCops `analyze` on the Session 3 files. Read the reported rules and ask the agent to explain anything you do not understand. If you apply a suggested fix, review the change before keeping it.

Package the App project when the implementation is complete. `apply_fix` and `apply_fix_all` write files, so keep explicit approval enabled for both.

## Homework

Complete the delivery-instructions feature in your own branch:

1. Require a delivery contact when delivery instructions are entered.
2. Show an actionable validation error stored in a `Label`.
3. Copy the delivery contact and instructions to the posted sales shipment.
4. Use supported Business Central extension points without modifying standard objects.

Open Copilot Chat in **Agent** mode and use this prompt:

> Complete the Session 3 delivery-instructions homework. Use MarkItDown MCP to read the requirements document, then inspect the starter AL files in `App/src/Session3/DeliveryInstructions`. Use AL Symbols MCP to find a supported posting event, and use Microsoft Learn MCP if you need to verify current AL guidance. Implement the required validation and copy both delivery fields to the posted sales shipment. Use a Label for the actionable error message. Keep the change limited to this feature, run ALCops on the changed AL files, and package the App project. Explain the changes when finished.

Review Copilot's changes and ask it to explain anything you do not understand. When the App packages successfully, commit and push your changes, then open a pull request using the Session 3 template. You do not need to add tests, screenshots, chat transcripts, or evidence tables.

A GitHub agent will compare your submission with the reference implementation and provide feedback. Do not commit generated Markdown from the Word conversion, secrets, personal configuration, package caches, or `.app` files.

## Definition of done

- Delivery contact is required when delivery instructions are entered.
- The validation message tells the user how to correct the order.
- Both fields are copied to the posted sales shipment.
- The App project packages successfully.
- Only the files needed for the exercise are committed.
- No credentials or machine-specific paths are committed.

## Knowledge check

After the session, take the [MCP Servers and Tools Check](https://global-mediator.github.io/ai-academy/session-03.html). The quiz contains ten questions, does not submit or store answers, and can be retried at any time.

## References

- [VS Code MCP server configuration](https://code.visualstudio.com/docs/agent-customization/mcp-servers)
- [VS Code AI security](https://code.visualstudio.com/docs/agents/run/security)
- [MarkItDown MCP](https://github.com/microsoft/markitdown/tree/main/packages/markitdown-mcp)
- [Microsoft Learn MCP](https://github.com/MicrosoftDocs/mcp)
- [AL Symbols MCP](https://github.com/StefanMaron/AL-Dependency-MCP-Server)
- [ALCops MCP](https://github.com/ALCops/mcp-server)