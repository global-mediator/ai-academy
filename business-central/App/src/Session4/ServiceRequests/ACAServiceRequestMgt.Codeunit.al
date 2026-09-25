codeunit 50140 "ACA Service Request Mgt."
{
    var
        RequestClosedErr: Label 'Service request %1 is closed. Reopen it before you change it.', Comment = '%1 = Service request number';

    /// <summary>
    /// Marks the supplied service request as urgent.
    /// </summary>
    /// <param name="ServiceRequest">The service request to mark.</param>
    procedure MarkAsUrgent(var ServiceRequest: Record "ACA Service Request")
    begin
        if ServiceRequest.Closed then
            Error(RequestClosedErr, ServiceRequest."No.");

        ServiceRequest.Validate(Urgent, true);
        ServiceRequest.Modify(true);
    end;

    /// <summary>
    /// Counts the open service requests that are marked as urgent.
    /// </summary>
    /// <returns>The number of open urgent service requests.</returns>
    procedure CountOpenUrgentRequests(): Integer
    var
        ServiceRequest: Record "ACA Service Request";
    begin
        ServiceRequest.SetRange(Closed, false);
        ServiceRequest.SetRange(Urgent, true);
        exit(ServiceRequest.Count());
    end;
}
