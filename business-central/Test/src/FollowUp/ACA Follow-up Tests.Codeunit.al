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
}