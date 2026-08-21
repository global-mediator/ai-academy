codeunit 50100 "ACA Follow-up Mgt."
{
    var
        FollowUpDateRequiredErr: Label 'A follow-up date is required.';

    /// <summary>
    /// Plans a follow-up for the supplied record.
    /// </summary>
    /// <param name="FollowUp">The follow-up to plan.</param>
    /// <param name="FollowUpDate">The date when the follow-up is due.</param>
    procedure PlanFollowUp(var FollowUp: Record "ACA Follow-up"; FollowUpDate: Date)
    begin
        if FollowUpDate = 0D then
            Error(FollowUpDateRequiredErr);

        FollowUp.Validate("Follow-up Date", FollowUpDate);
        FollowUp.Validate(Completed, false);
        FollowUp.Modify(true);
    end;

    /// <summary>
    /// Marks the supplied follow-up as completed.
    /// </summary>
    /// <param name="FollowUp">The follow-up to complete.</param>
    procedure CompleteFollowUp(var FollowUp: Record "ACA Follow-up")
    begin
        FollowUp.Validate(Completed, true);
        FollowUp.Modify(true);
    end;
}