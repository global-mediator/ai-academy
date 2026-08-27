# Focused BCQuality Security Rules

This workshop checklist is adapted from the Microsoft-layer BCQuality security guidance. Apply the rules to BC 28 AL code without assuming that successful compilation proves security.

## SecretText with HttpClient

**Anti-pattern:** A credential is held in `Text`, composed with `StrSubstNo` or concatenation, and passed to `HttpHeaders.Add`, `HttpClient.Get`, or another HTTP sink.

**Preferred pattern:** Keep credentials as `SecretText` end to end. Compose secret values with `SecretStrSubstNo`. Add secret authorization values through the secret-aware `HttpHeaders.Add` overload. For credential-bearing URIs, use `HttpRequestMessage.SetSecretRequestUri` and `HttpClient.Send`.

Primary BCQuality rule: `secrettext-with-httpclient.md`.

## Validate User-Configurable URLs

**Anti-pattern:** A URL read from a table field is passed to `HttpClient.Get`, `Post`, or `Send` without validating its host or pattern.

**Preferred pattern:** Before the request, use codeunit `Uri` with `AreURIsHaveSameHost` against a fixed expected base URL or `IsValidURIPattern` against a fixed pattern. Reject invalid targets before attaching credentials or content.

Primary BCQuality rule: `validate-user-configurable-urls.md`.

## Store Secrets Outside Ordinary Fields

**Anti-pattern:** API keys, tokens, or passwords are persisted in ordinary `Text` or `Code` table fields.

**Preferred pattern:** Store sensitive values in `IsolatedStorage`, use encryption where supported, and expose them to callers as `SecretText`.

Primary BCQuality rule: `secrets-isolated-storage.md`.

## Severity

- `blocker`: Plain-text credentials flow into an external HTTP request or a platform data-protection guarantee is violated.
- `major`: An untrusted configurable URL reaches `HttpClient`, or a persisted secret is broadly exposed.
- `minor`: A concrete defense-in-depth improvement with limited direct exposure.