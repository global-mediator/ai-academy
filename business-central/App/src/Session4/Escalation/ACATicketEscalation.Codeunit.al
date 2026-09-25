codeunit 50130 "ACA Ticket Escalation"
{
    var
        NegativeGraceDaysErr: Label 'The grace period cannot be negative. Enter 0 or a positive number of days.';

    /// <summary>
    /// Counts the open tickets that are overdue by more than the grace period.
    /// </summary>
    /// <param name="AsOfDate">The date on which to check the tickets.</param>
    /// <param name="GraceDays">The number of days a ticket can be overdue before escalation.</param>
    /// <returns>The number of tickets that must be escalated.</returns>
    procedure CountTicketsToEscalate(AsOfDate: Date; GraceDays: Integer): Integer
    var
        SupportTicket: Record "ACA Support Ticket";
        TicketCount: Integer;
    begin
        CheckGraceDays(GraceDays);

        SupportTicket.SetLoadFields("Due Date", Closed);
        SupportTicket.SetRange(Closed, false);
        if SupportTicket.FindSet() then
            repeat
                if SupportTicket.IsOverdueBeyondGrace(AsOfDate, GraceDays) then
                    TicketCount += 1;
            until SupportTicket.Next() = 0;

        exit(TicketCount);
    end;

    local procedure CheckGraceDays(GraceDays: Integer)
    begin
        if GraceDays < 0 then
            Error(NegativeGraceDaysErr);
    end;
}
