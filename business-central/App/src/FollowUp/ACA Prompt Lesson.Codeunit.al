codeunit 50102 "ACA Prompt Lesson"
{
    var
        AsOfDateDimensionKeyTok: Label 'AsOfDate', Locked = true;

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
        CheckFollowUpDate(FollowUp, AsOfDate);
        CheckNotCompleted(FollowUp);
        CheckNotScheduledAfter(FollowUp, AsOfDate);
    end;

    /// <summary>
    /// Sets a missing follow-up date from an actionable validation error.
    /// </summary>
    /// <param name="ValidationErrorInfo">The actionable validation error.</param>
    procedure SetFollowUpDateFromError(ValidationErrorInfo: ErrorInfo)
    var
        FollowUp: Record "ACA Follow-up";
        FollowUpDate: Date;
        FollowUpDateText: Text;
        CustomDimensions: Dictionary of [Text, Text];
    begin
        if not TryGetFollowUpFromErrorInfo(ValidationErrorInfo, FollowUp) then
            exit;

        if FollowUp."Follow-up Date" <> 0D then
            exit;

        CustomDimensions := ValidationErrorInfo.CustomDimensions();
        if not CustomDimensions.Get(AsOfDateDimensionKeyTok, FollowUpDateText) then
            exit;

        if not Evaluate(FollowUpDate, FollowUpDateText, 9) then
            exit;

        if FollowUpDate = 0D then
            exit;

        FollowUp.Validate("Follow-up Date", FollowUpDate);
        FollowUp.Modify(true);
    end;

    /// <summary>
    /// Reopens a completed follow-up from an actionable validation error.
    /// </summary>
    /// <param name="ValidationErrorInfo">The actionable validation error.</param>
    procedure ReopenFollowUpFromError(ValidationErrorInfo: ErrorInfo)
    var
        FollowUp: Record "ACA Follow-up";
    begin
        if not TryGetFollowUpFromErrorInfo(ValidationErrorInfo, FollowUp) then
            exit;

        if not FollowUp.Completed then
            exit;

        FollowUp.Validate(Completed, false);
        FollowUp.Modify(true);
    end;

    /// <summary>
    /// Checks that the reminder date is specified.
    /// </summary>
    /// <param name="AsOfDate">The date on which the reminder will be sent.</param>
    local procedure CheckAsOfDate(AsOfDate: Date)
    var
        ReminderDateRequiredErr: Label 'A reminder date is required.';
    begin
        if AsOfDate <> 0D then
            exit;

        Error(ReminderDateRequiredErr);
    end;

    /// <summary>
    /// Checks that the follow-up has an identifier.
    /// </summary>
    /// <param name="FollowUp">The follow-up to validate.</param>
    local procedure CheckFollowUpNo(FollowUp: Record "ACA Follow-up")
    var
        FollowUpNoRequiredErr: Label 'A follow-up number is required.';
    begin
        if FollowUp."No." <> '' then
            exit;


        Error(FollowUpNoRequiredErr);
    end;

    /// <summary>
    /// Checks that the follow-up identifies the person to contact.
    /// </summary>
    /// <param name="FollowUp">The follow-up to validate.</param>
    local procedure CheckContactName(FollowUp: Record "ACA Follow-up")
    var
        ContactNameRequiredErr: Label 'A contact name is required.';
    begin
        if FollowUp."Contact Name" <> '' then
            exit;

        Error(ContactNameRequiredErr);
    end;

    /// <summary>
    /// Checks that the follow-up has been scheduled.
    /// </summary>
    /// <param name="FollowUp">The follow-up to validate.</param>
    /// <param name="AsOfDate">The date on which the reminder will be sent.</param>
    local procedure CheckFollowUpDate(FollowUp: Record "ACA Follow-up"; AsOfDate: Date)
    var
        PersistedRecordId: RecordId;
        CustomDimensions: Dictionary of [Text, Text];
        ValidationErrorInfo: ErrorInfo;
        FollowUpDateRequiredErr: Label 'A follow-up date is required.';
        FollowUpDateRequiredDetailedMsg: Label 'Follow-up %1 is persisted with an empty Follow-up Date. The reminder date is %2. RecordId=%3; FieldNo=%4. The fix action only fills the missing Follow-up Date.', Comment = '%1 = follow-up number, %2 = reminder date, %3 = follow-up record ID, %4 = Follow-up Date field number.';
        SetFollowUpDateActionLbl: Label 'Set follow-up date to %1', Comment = '%1 = reminder date.';
        SetFollowUpDateActionToolTipLbl: Label 'Sets the missing follow-up date to the reminder date.';
    begin
        if FollowUp."Follow-up Date" <> 0D then
            exit;

        if not TryGetPersistedFollowUpRecordId(FollowUp, PersistedRecordId) then
            Error(FollowUpDateRequiredErr);

        CustomDimensions.Add(AsOfDateDimensionKeyTok, Format(AsOfDate, 0, 9));
        ValidationErrorInfo.ErrorType(ErrorType::Client);
        ValidationErrorInfo.Verbosity(Verbosity::Error);
        ValidationErrorInfo.DataClassification(DataClassification::CustomerContent);
        ValidationErrorInfo.Message(FollowUpDateRequiredErr);
        ValidationErrorInfo.DetailedMessage(
            StrSubstNo(
                FollowUpDateRequiredDetailedMsg,
                FollowUp."No.",
                Format(AsOfDate),
                Format(PersistedRecordId, 0, 1),
                FollowUp.FieldNo("Follow-up Date")));
        ValidationErrorInfo.TableId(Database::"ACA Follow-up");
        ValidationErrorInfo.RecordId(PersistedRecordId);
        ValidationErrorInfo.FieldNo(FollowUp.FieldNo("Follow-up Date"));
        ValidationErrorInfo.CustomDimensions(CustomDimensions);
        ValidationErrorInfo.AddAction(
            StrSubstNo(SetFollowUpDateActionLbl, Format(AsOfDate)),
            Codeunit::"ACA Prompt Lesson",
            'SetFollowUpDateFromError',
            SetFollowUpDateActionToolTipLbl);
        Error(ValidationErrorInfo);
    end;

    /// <summary>
    /// Checks that the follow-up still requires attention.
    /// </summary>
    /// <param name="FollowUp">The follow-up to validate.</param>
    local procedure CheckNotCompleted(FollowUp: Record "ACA Follow-up")
    var
        PersistedRecordId: RecordId;
        ValidationErrorInfo: ErrorInfo;
        CompletedFollowUpReminderErr: Label 'A completed follow-up cannot receive a reminder.';
        CompletedFollowUpReminderDetailedMsg: Label 'Follow-up %1 is persisted with Completed set to true. RecordId=%2; FieldNo=%3. The fix action only changes Completed to false so the reminder can be validated again.', Comment = '%1 = follow-up number, %2 = follow-up record ID, %3 = Completed field number.';
        ReopenFollowUpActionLbl: Label 'Reopen follow-up';
        ReopenFollowUpActionToolTipLbl: Label 'Marks the completed follow-up as open.';
    begin
        if not FollowUp.Completed then
            exit;

        if not TryGetPersistedFollowUpRecordId(FollowUp, PersistedRecordId) then
            Error(CompletedFollowUpReminderErr);

        ValidationErrorInfo.ErrorType(ErrorType::Client);
        ValidationErrorInfo.Verbosity(Verbosity::Error);
        ValidationErrorInfo.DataClassification(DataClassification::CustomerContent);
        ValidationErrorInfo.Message(CompletedFollowUpReminderErr);
        ValidationErrorInfo.DetailedMessage(
            StrSubstNo(
                CompletedFollowUpReminderDetailedMsg,
                FollowUp."No.",
                Format(PersistedRecordId, 0, 1),
                FollowUp.FieldNo(Completed)));
        ValidationErrorInfo.TableId(Database::"ACA Follow-up");
        ValidationErrorInfo.RecordId(PersistedRecordId);
        ValidationErrorInfo.FieldNo(FollowUp.FieldNo(Completed));
        ValidationErrorInfo.AddAction(
            ReopenFollowUpActionLbl,
            Codeunit::"ACA Prompt Lesson",
            'ReopenFollowUpFromError',
            ReopenFollowUpActionToolTipLbl);
        Error(ValidationErrorInfo);
    end;

    /// <summary>
    /// Checks that the follow-up is due by the reminder date.
    /// </summary>
    /// <param name="FollowUp">The follow-up to validate.</param>
    /// <param name="AsOfDate">The date on which the reminder will be sent.</param>
    local procedure CheckNotScheduledAfter(FollowUp: Record "ACA Follow-up"; AsOfDate: Date)
    var
        FollowUpNotDueErr: Label 'The follow-up is not due yet.';
    begin
        if FollowUp."Follow-up Date" <= AsOfDate then
            exit;

        Error(FollowUpNotDueErr);
    end;

    local procedure TryGetPersistedFollowUpRecordId(FollowUp: Record "ACA Follow-up"; var PersistedRecordId: RecordId): Boolean
    var
        PersistedFollowUp: Record "ACA Follow-up";
    begin
        if FollowUp.IsTemporary() then
            exit(false);

        if not PersistedFollowUp.Get(FollowUp."No.") then
            exit(false);

        if PersistedFollowUp.SystemId <> FollowUp.SystemId then
            exit(false);

        PersistedRecordId := PersistedFollowUp.RecordId();
        exit(true);
    end;

    local procedure TryGetFollowUpFromErrorInfo(ValidationErrorInfo: ErrorInfo; var FollowUp: Record "ACA Follow-up"): Boolean
    var
        FollowUpRecordRef: RecordRef;
    begin
        if not FollowUpRecordRef.Get(ValidationErrorInfo.RecordId()) then
            exit(false);

        FollowUpRecordRef.SetTable(FollowUp);
        exit(true);
    end;
}