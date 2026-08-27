codeunit 50103 "ACA Reminder Dispatcher"
{
    /// <summary>
    /// Sends one follow-up reminder to the configured external service.
    /// </summary>
    /// <param name="FollowUp">The follow-up to send.</param>
    /// <param name="ReminderSetup">The external reminder service configuration.</param>
    procedure SendReminder(FollowUp: Record "ACA Follow-up"; ReminderSetup: Record "ACA Reminder Setup")
    var
        Client: HttpClient;
        Content: HttpContent;
        Headers: HttpHeaders;
        Response: HttpResponseMessage;
        AuthorizationHeader: Text;
        Payload: Text;
    begin
        Payload := CreatePayload(FollowUp);
        Content.WriteFrom(Payload);

        Headers := Client.DefaultRequestHeaders();
        AuthorizationHeader := StrSubstNo(BearerTokenTxt, ReminderSetup."API Key");
        Headers.Add('Authorization', AuthorizationHeader);

        if not Client.Post(ReminderSetup."Service URL", Content, Response) then
            Error(ReminderRequestFailedErr);

        if not Response.IsSuccessStatusCode() then
            Error(ReminderServiceErrorErr, Response.HttpStatusCode());
    end;

    local procedure CreatePayload(FollowUp: Record "ACA Follow-up") Payload: Text
    var
        PayloadObject: JsonObject;
    begin
        PayloadObject.Add('number', FollowUp."No.");
        PayloadObject.Add('contactName', FollowUp."Contact Name");
        PayloadObject.Add('followUpDate', FollowUp."Follow-up Date");
        PayloadObject.WriteTo(Payload);
    end;

    var
        BearerTokenTxt: Label 'Bearer %1', Comment = '%1 = API key', Locked = true;
        ReminderRequestFailedErr: Label 'The reminder service could not be reached.';
        ReminderServiceErrorErr: Label 'The reminder service returned HTTP status code %1.', Comment = '%1 = HTTP status code';
}