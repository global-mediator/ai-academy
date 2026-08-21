codeunit 50110 "ACA Follow-up Tests"
{
    Subtype = Test;
    TestType = UnitTest;
    RequiredTestIsolation = Codeunit;

    [Test]
    procedure GivenFollowUpWhenPlannedThenDateIsSaved()
    var
        FollowUp: Record "ACA Follow-up";
        FollowUpMgt: Codeunit "ACA Follow-up Mgt.";
        FollowUpDateNotSavedErr: Label 'The follow-up date was not saved.';
        FollowUpWasCompletedErr: Label 'The follow-up was unexpectedly marked as completed.';
    begin
        // [GIVEN] A new follow-up exists.
        FollowUp.Init();
        FollowUp."No." := 'PLAN-001';
        FollowUp.Insert();

        // [WHEN] The follow-up is planned.
        FollowUpMgt.PlanFollowUp(FollowUp, WorkDate());

        // [THEN] Its date is saved and it remains open.
        if FollowUp."Follow-up Date" <> WorkDate() then
            Error(FollowUpDateNotSavedErr);

        if FollowUp.Completed then
            Error(FollowUpWasCompletedErr);
    end;

    [Test]
    procedure GivenIncompleteFollowUpWhenCheckedThenItIsOpen()
    var
        FollowUp: Record "ACA Follow-up";
        FollowUpWasNotOpenErr: Label 'The incomplete follow-up was not open.';
    begin
        // [GIVEN] An incomplete follow-up.
        FollowUp.Init();
        FollowUp.Validate(Completed, false);

        // [WHEN] Its open status is checked.
        // [THEN] It is open.
        if not FollowUp.IsOpen() then
            Error(FollowUpWasNotOpenErr);
    end;

    [Test]
    procedure GivenPastOpenFollowUpWhenCheckedThenItIsOverdue()
    var
        FollowUp: Record "ACA Follow-up";
        FollowUpWasNotOverdueErr: Label 'The past open follow-up was not overdue.';
    begin
        // [GIVEN] An open follow-up dated before today.
        FollowUp.Init();
        FollowUp.Validate("Follow-up Date", WorkDate() - 1);

        // [WHEN] Its overdue status is checked today.
        // [THEN] It is overdue.
        if not FollowUp.IsOverdue(WorkDate()) then
            Error(FollowUpWasNotOverdueErr);
    end;

    [Test]
    procedure GivenPastCompletedFollowUpWhenCheckedThenItIsNotOverdue()
    var
        FollowUp: Record "ACA Follow-up";
        FollowUpWasOverdueErr: Label 'The completed follow-up was overdue.';
    begin
        // [GIVEN] A completed follow-up dated before today.
        FollowUp.Init();
        FollowUp.Validate("Follow-up Date", WorkDate() - 1);
        FollowUp.Validate(Completed, true);

        // [WHEN] Its overdue status is checked today.
        // [THEN] It is not overdue.
        if FollowUp.IsOverdue(WorkDate()) then
            Error(FollowUpWasOverdueErr);
    end;

    [Test]
    procedure GivenPersistedUndatedFollowUpWhenDateFixIsAppliedThenDateIsSaved()
    var
        FollowUp: Record "ACA Follow-up";
        PromptLesson: Codeunit "ACA Prompt Lesson";
        ValidationErrorInfo: ErrorInfo;
        CustomDimensions: Dictionary of [Text, Text];
        ExpectedFollowUpDate: Date;
        FollowUpDateDimensionKeyTok: Label 'AsOfDate', Locked = true;
        FollowUpDateNotSavedErr: Label 'The actionable error did not save the follow-up date.';
    begin
        ExpectedFollowUpDate := WorkDate() + 1;
        FollowUp.Init();
        FollowUp.Validate("No.", 'FIX-001');
        FollowUp.Validate("Contact Name", 'Ada Lovelace');
        FollowUp.Insert();

        ValidationErrorInfo.RecordId(FollowUp.RecordId());
        CustomDimensions.Add(FollowUpDateDimensionKeyTok, Format(ExpectedFollowUpDate, 0, 9));
        ValidationErrorInfo.CustomDimensions(CustomDimensions);

        PromptLesson.SetFollowUpDateFromError(ValidationErrorInfo);

        Clear(FollowUp);
        if not FollowUp.Get('FIX-001') then
            Error(FollowUpDateNotSavedErr);

        if FollowUp."Follow-up Date" <> ExpectedFollowUpDate then
            Error(FollowUpDateNotSavedErr);
    end;

    [Test]
    procedure GivenPersistedCompletedFollowUpWhenReopenFixIsAppliedThenFollowUpIsOpen()
    var
        FollowUp: Record "ACA Follow-up";
        PromptLesson: Codeunit "ACA Prompt Lesson";
        ValidationErrorInfo: ErrorInfo;
        FollowUpNotReopenedErr: Label 'The actionable error did not reopen the follow-up.';
    begin
        FollowUp.Init();
        FollowUp.Validate("No.", 'FIX-002');
        FollowUp.Validate("Contact Name", 'Grace Hopper');
        FollowUp.Validate("Follow-up Date", WorkDate());
        FollowUp.Validate(Completed, true);
        FollowUp.Insert();

        ValidationErrorInfo.RecordId(FollowUp.RecordId());

        PromptLesson.ReopenFollowUpFromError(ValidationErrorInfo);

        Clear(FollowUp);
        if not FollowUp.Get('FIX-002') then
            Error(FollowUpNotReopenedErr);

        if FollowUp.Completed then
            Error(FollowUpNotReopenedErr);
    end;

    [Test]
    procedure GivenMissingReminderDateWhenValidatedThenReminderDateErrorIsRaised()
    var
        FollowUp: Record "ACA Follow-up";
        PromptLesson: Codeunit "ACA Prompt Lesson";
        ValidationUnexpectedlySucceededErr: Label 'Validation unexpectedly succeeded.';
        ReminderDateRequiredErr: Label 'A reminder date is required.';
    begin
        FollowUp.Init();

        if TryValidateForReminder(PromptLesson, FollowUp, 0D) then
            Error(ValidationUnexpectedlySucceededErr);

        if GetLastErrorText() <> ReminderDateRequiredErr then
            Error(ValidationUnexpectedlySucceededErr);
    end;

    [Test]
    procedure GivenUnsavedUndatedFollowUpWhenValidatedThenDateErrorIsRaisedWithoutFix()
    var
        FollowUp: Record "ACA Follow-up";
        PromptLesson: Codeunit "ACA Prompt Lesson";
        ValidationUnexpectedlySucceededErr: Label 'Validation unexpectedly succeeded.';
        FollowUpDateRequiredErr: Label 'A follow-up date is required.';
    begin
        FollowUp.Init();
        FollowUp.Validate("No.", 'UNSAVED-001');
        FollowUp.Validate("Contact Name", 'Katherine Johnson');

        if TryValidateForReminder(PromptLesson, FollowUp, WorkDate()) then
            Error(ValidationUnexpectedlySucceededErr);

        if GetLastErrorText() <> FollowUpDateRequiredErr then
            Error(ValidationUnexpectedlySucceededErr);
    end;

    [TryFunction]
    local procedure TryValidateForReminder(PromptLesson: Codeunit "ACA Prompt Lesson"; FollowUp: Record "ACA Follow-up"; AsOfDate: Date)
    begin
        PromptLesson.ValidateForReminder(FollowUp, AsOfDate);
    end;
}