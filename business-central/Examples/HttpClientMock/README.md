# Authenticated HTTP GET example

The production codeunit in the App project:

- receives the bearer token as `SecretText`;
- builds the `Authorization` value with `SecretStrSubstNo`;
- adds it with the `HttpHeaders.Add(Text, SecretText)` overload;
- checks both transport success and the HTTP status code; and
- reads the response body only after a successful response.

The test codeunit uses `[HttpClientHandler]` and `TestHttpRequestMessage` /
`TestHttpResponseMessage` to return a response without calling the network.

`HttpClientHandler` is supported only for on-premises Business Central test
execution. The App project is a Cloud/Extension project, so this test source is
kept in this example folder and should be copied into an on-premises test
project that references the App project.

Official Microsoft Learn documentation:

- [Call external services with HttpClient](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-httpclient)
- [Protecting sensitive values with SecretText](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-secret-text)
- [Mock outbound HttpClient web service calls during testing](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-httpclient-mock-outbound-calls)
- [HttpHeaders.Add(Text, SecretText)](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/methods-auto/httpheaders/httpheaders-add-string-secrettext-method)
