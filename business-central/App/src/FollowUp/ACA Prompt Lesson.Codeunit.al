codeunit 50102 "ACA Prompt Lesson"
{
    /// <summary>
    /// Validates that a follow-up is ready for a reminder.
    /// </summary>
    /// <param name="FollowUp">The follow-up to validate.</param>
    /// <param name="AsOfDate">The date on which the reminder will be sent.</param>
    procedure ValidateForReminder(FollowUp: Record "ACA Follow-up"; AsOfDate: Date)
    begin
        CheckAsOfDate(AsOfDate);
        CheckFollowUpNo(FollowUp);
        CheckContactName(FollowUp);
        CheckFollowUpDate(FollowUp);
        CheckNotCompleted(FollowUp);
        CheckNotScheduledAfter(FollowUp, AsOfDate);
    end;

    /// <summary>
    /// Checks that the reminder date is specified.
    /// </summary>
    /// <param name="AsOfDate">The date on which the reminder will be sent.</param>
    local procedure CheckAsOfDate(AsOfDate: Date)
    begin
        if AsOfDate <> 0D then
            exit;

        // TODO: Tell the user that a reminder date is required.
    end;

    /// <summary>
    /// Checks that the follow-up has an identifier.
    /// </summary>
    /// <param name="FollowUp">The follow-up to validate.</param>
    local procedure CheckFollowUpNo(FollowUp: Record "ACA Follow-up")
    begin
        if FollowUp."No." <> '' then
            exit;

        // TODO: Tell the user that a follow-up number is required.
    end;

    /// <summary>
    /// Checks that the follow-up identifies the person to contact.
    /// </summary>
    /// <param name="FollowUp">The follow-up to validate.</param>
    local procedure CheckContactName(FollowUp: Record "ACA Follow-up")
    begin
        if FollowUp."Contact Name" <> '' then
            exit;

        // TODO: Tell the user that a contact name is required.
    end;

    /// <summary>
    /// Checks that the follow-up has been scheduled.
    /// </summary>
    /// <param name="FollowUp">The follow-up to validate.</param>
    local procedure CheckFollowUpDate(FollowUp: Record "ACA Follow-up")
    begin
        if FollowUp."Follow-up Date" <> 0D then
            exit;

        // TODO: Tell the user that a follow-up date is required.
    end;

    /// <summary>
    /// Checks that the follow-up still requires attention.
    /// </summary>
    /// <param name="FollowUp">The follow-up to validate.</param>
    local procedure CheckNotCompleted(FollowUp: Record "ACA Follow-up")
    begin
        if not FollowUp.Completed then
            exit;

        // TODO: Tell the user that a completed follow-up cannot receive a reminder.
    end;

    /// <summary>
    /// Checks that the follow-up is due by the reminder date.
    /// </summary>
    /// <param name="FollowUp">The follow-up to validate.</param>
    /// <param name="AsOfDate">The date on which the reminder will be sent.</param>
    local procedure CheckNotScheduledAfter(FollowUp: Record "ACA Follow-up"; AsOfDate: Date)
    begin
        if FollowUp."Follow-up Date" <= AsOfDate then
            exit;

        // TODO: Tell the user that the follow-up is not due yet.
    end;
}