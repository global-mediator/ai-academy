# Focused BCQuality Error-Handling Rules

This workshop checklist is adapted from the Microsoft-layer BCQuality error-handling guidance for BC 23 and later.

## Prefer ErrorInfo for Actionable Errors

**Anti-pattern:** A validation raises a plain `Error` even though the code knows the valid replacement value or the related page where the user can correct the issue.

**Preferred pattern:** Build an `ErrorInfo` with `Title`, `Message`, and `DetailedMessage`. Use `AddAction` for a known safe Fix-it correction, or set `PageNo` and `RecordId` and use `AddNavigationAction` for a Show-it action. Raise it with `Error(ErrorInfo)`.

Do not flag connectivity failures or unknown service errors merely because they use plain `Error`; they do not necessarily have a safe recommended action.

Primary BCQuality rule: `prefer-errorinfo-for-actionable-errors.md`.

## Preserve TryFunction Semantics

**Anti-pattern:** Calling a `[TryFunction]` procedure as a standalone statement and ignoring its Boolean result, which disables the intended try behavior.

**Preferred pattern:** Use the call in an assignment or conditional and handle the `false` result explicitly.

Primary BCQuality rule: `ignored-tryfunction-return-disables-try-semantics.md`.

## Match Error Type to Audience

**Anti-pattern:** Developer-only invariant details are shown as client errors, or user-actionable validation is hidden as an internal error.

**Preferred pattern:** Use client-visible errors for corrections users can make. Use `ErrorType::Internal` for unexpected implementation failures that belong in diagnostics rather than the user interface.

Primary BCQuality rule: `errortype-internal-vs-client-for-diagnostics.md`.

## Severity

- `major`: A recoverable workflow is blocked even though the code knows a safe correction.
- `minor`: Error metadata, audience, or diagnostics are incomplete but the user can still recover.
- `blocker`: Reserve for violations of an explicit platform guarantee.