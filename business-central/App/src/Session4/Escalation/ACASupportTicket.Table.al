table 50130 "ACA Support Ticket"
{
    Caption = 'Support Ticket';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            ToolTip = 'Specifies the identifier of the support ticket.';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies what the customer needs help with.';
        }
        field(3; "Due Date"; Date)
        {
            Caption = 'Due Date';
            ToolTip = 'Specifies the date by which the ticket must be resolved.';
        }
        field(4; Closed; Boolean)
        {
            Caption = 'Closed';
            ToolTip = 'Specifies whether the ticket has been resolved.';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    /// <summary>
    /// Checks whether the open ticket is overdue by more than the grace period.
    /// </summary>
    /// <param name="AsOfDate">The date on which to check the ticket.</param>
    /// <param name="GraceDays">The number of days a ticket can be overdue before escalation.</param>
    /// <returns>True when the ticket is open and overdue beyond the grace period. Otherwise, false.</returns>
    procedure IsOverdueBeyondGrace(AsOfDate: Date; GraceDays: Integer): Boolean
    begin
        if Closed then
            exit(false);

        if ("Due Date" = 0D) or (AsOfDate = 0D) then
            exit(false);

        exit("Due Date" <= AsOfDate - GraceDays);
    end;
}
