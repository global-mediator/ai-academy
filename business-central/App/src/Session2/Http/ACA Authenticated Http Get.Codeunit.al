codeunit 50104 "ACA Authenticated Http Get"
{
    /// <summary>
    /// Sends an authenticated GET request and returns the successful response body.
    /// </summary>
    /// <param name="pRequestUri">The URI to request.</param>
    /// <param name="pBearerToken">The bearer token used for authentication.</param>
    procedure GetResponseBody(pRequestUri: Text; pBearerToken: SecretText) ResponseBody: Text
    var
        lClient: HttpClient;
        lHeaders: HttpHeaders;
        lResponse: HttpResponseMessage;
        lAuthorizationHeader: SecretText;
    begin
        lAuthorizationHeader := SecretStrSubstNo(BearerHeaderTemplateTxt, pBearerToken);
        lHeaders := lClient.DefaultRequestHeaders();

        if not lHeaders.Add('Authorization', lAuthorizationHeader) then
            Error(AuthorizationHeaderAddErr);

        if not lClient.Get(pRequestUri, lResponse) then
            Error(HttpRequestFailedErr);

        if not lResponse.IsSuccessStatusCode() then
            Error(HttpResponseStatusErr, lResponse.HttpStatusCode());

        lResponse.Content().ReadAs(ResponseBody);
    end;

    var
        AuthorizationHeaderAddErr: Label 'The Authorization header could not be added.';
        BearerHeaderTemplateTxt: Label 'Bearer %1', Locked = true;
        HttpRequestFailedErr: Label 'The HTTP request could not be sent.';
        HttpResponseStatusErr: Label 'The HTTP request returned HTTP status code %1.', Comment = '%1 = HTTP status code';
}
