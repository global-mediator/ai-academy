table 50101 "ACA Reminder Setup"
{
    Caption = 'Reminder Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            NotBlank = true;
        }
        field(2; "Service URL"; Text[250])
        {
            Caption = 'Service URL';
            ToolTip = 'Specifies the endpoint that receives reminder notifications.';
        }
        field(3; "API Key"; Text[250])
        {
            Caption = 'API Key';
            ToolTip = 'Specifies the credential used to call the reminder service.';
        }
        field(4; "Maximum Reminders per Run"; Integer)
        {
            Caption = 'Maximum Reminders per Run';
            ToolTip = 'Specifies the maximum number of reminders that can be sent in one run.';

            trigger OnValidate()
            begin
                if "Maximum Reminders per Run" > GetMaximumRemindersPerRun() then
                    Error(MaximumRemindersExceededErr, GetMaximumRemindersPerRun());
            end;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        MaximumRemindersExceededErr: Label 'You cannot send more than %1 reminders in one run.', Comment = '%1 = Maximum reminders per run';

    local procedure GetMaximumRemindersPerRun(): Integer
    begin
        exit(100);
    end;
}