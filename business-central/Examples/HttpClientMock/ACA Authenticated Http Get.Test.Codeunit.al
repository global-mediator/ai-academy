codeunit 50105 "ACA Auth HTTP Get Test"
{
    Subtype = Test;
    TestHttpRequestPolicy = AllowOutboundFromHandler;

    [Test]
    [HandlerFunctions('GetResponseHandler')]
    procedure GetResponseBodyReturnsMockedBody()
    var
        lService: Codeunit "ACA Authenticated Http Get";
        lBearerToken: SecretText;
        lResponseBody: Text;
    begin
        lBearerToken := GetTestToken();
        lResponseBody := lService.GetResponseBody('https://example.test/resource', lBearerToken);

        if lResponseBody <> 'mock response body' then
            Error(UnexpectedResponseBodyErr, lResponseBody);
    end;

    [Test]
    [HandlerFunctions('GetResponseHandler')]
    procedure NonSuccessStatusRaisesError()
    var
        lService: Codeunit "ACA Authenticated Http Get";
        lBearerToken: SecretText;
    begin
        lBearerToken := GetTestToken();

        if TryGetFailureResponse(lService, lBearerToken) then
            Error(ExpectedErrorMissingErr);
    end;

    [TryFunction]
    local procedure TryGetFailureResponse(var pService: Codeunit "ACA Authenticated Http Get"; pBearerToken: SecretText)
    begin
        pService.GetResponseBody('https://example.test/failure', pBearerToken);
    end;

    [HttpClientHandler]
    procedure GetResponseHandler(pRequest: TestHttpRequestMessage; var pResponse: TestHttpResponseMessage): Boolean
    begin
        if pRequest.RequestType <> HttpRequestType::Get then
            Error(UnexpectedRequestTypeErr);

        if pRequest.Path = 'https://example.test/resource' then begin
            pResponse.Content.WriteFrom('mock response body');
            pResponse.HttpStatusCode := 200;
            pResponse.ReasonPhrase := 'OK';
            exit(false);
        end;

        if pRequest.Path = 'https://example.test/failure' then begin
            pResponse.Content.WriteFrom('service unavailable');
            pResponse.HttpStatusCode := 503;
            pResponse.ReasonPhrase := 'Service Unavailable';
            exit(false);
        end;

        exit(true);
    end;

    [NonDebuggable]
    local procedure GetTestToken() Token: SecretText
    var
        lPlainTextToken: Text;
    begin
        lPlainTextToken := 'test-token';
        Token := lPlainTextToken;
    end;

    var
        ExpectedErrorMissingErr: Label 'The expected HTTP error was not raised.';
        UnexpectedRequestTypeErr: Label 'The handler received an unexpected HTTP request type.';
        UnexpectedResponseBodyErr: Label 'Unexpected response body: %1.', Comment = '%1 = response body';
}
