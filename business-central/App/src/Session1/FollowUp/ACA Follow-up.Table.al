table 50100 "ACA Follow-up"
{
    Caption = 'Follow-up';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            ToolTip = 'Specifies the identifier of the follow-up.';
        }
        field(2; "Contact Name"; Text[100])
        {
            Caption = 'Contact Name';
            ToolTip = 'Specifies the name of the person to contact.';
        }
        field(3; "Follow-up Date"; Date)
        {
            Caption = 'Follow-up Date';
            ToolTip = 'Specifies the date when the follow-up is due.';
        }
        field(4; Completed; Boolean)
        {
            Caption = 'Completed';
            ToolTip = 'Specifies whether the follow-up has been completed.';
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
    /// Checks whether the follow-up is still open.
    /// </summary>
    /// <returns>True when the follow-up is not completed; otherwise, false.</returns>
    procedure IsOpen(): Boolean
    begin
        exit(not Completed);
    end;

    /// <summary>
    /// Checks whether the open follow-up is overdue on the supplied date.
    /// </summary>
    /// <param name="AsOfDate">The date on which to check the follow-up.</param>
    /// <returns>True when the follow-up is open and its date is before the supplied date; otherwise, false.</returns>
    procedure IsOverdue(AsOfDate: Date): Boolean
    begin
        if not IsOpen() then
            exit(false);

        if ("Follow-up Date" = 0D) or (AsOfDate = 0D) then
            exit(false);

        exit("Follow-up Date" < AsOfDate);
    end;
}