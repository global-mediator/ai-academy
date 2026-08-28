codeunit 50101 "ACA Follow-up Demo"
{
    /// <summary>
    /// Creates a follow-up with the supplied details.
    /// </summary>
    /// <param name="FollowUpNo">The identifier of the follow-up.</param>
    /// <param name="ContactName">The name of the person to contact.</param>
    /// <param name="FollowUpDate">The date when the follow-up is due.</param>
    procedure CreateFollowUp(FollowUpNo: Code[20]; ContactName: Text[100]; FollowUpDate: Date)
    var
        FollowUp: Record "ACA Follow-up";
    begin
        // TODO Create and insert a follow-up using Validate for every field.
    end;

    /// <summary>
    /// Counts follow-ups that are still open on or before the supplied date.
    /// </summary>
    /// <param name="DueDate">The latest follow-up date to include.</param>
    /// <returns>The number of open follow-ups due on or before the supplied date.</returns>
    procedure CountOpenFollowUps(DueDate: Date): Integer
    var
        FollowUp: Record "ACA Follow-up";
    begin
        // TODO Filter incomplete follow-ups up to DueDate and return their count. 
    end;

    /// <summary>
    /// Validates that a follow-up date is not before the work date.
    /// </summary>
    /// <param name="FollowUpDate">The date when the follow-up is due.</param>
    procedure ValidateFollowUpDate(FollowUpDate: Date)
    begin
        if FollowUpDate >= WorkDate() then
            exit;

        // TODO Tell the user that the follow-up date cannot be in the past.
    end;


    /// <summary>
    /// Calculates the percentage of follow-ups completed on or before a given date.
    /// </summary>
    /// <param name="DueDate">The latest follow-up date to include.</param>
    /// <returns>The completion percentage, or zero when no follow-ups match.</returns>
    procedure CalculateCompletionPercentage(DueDate: Date): Decimal
    var
        FollowUp: Record "ACA Follow-up";
        CompletedFollowUps: Integer;
        TotalFollowUps: Integer;
    begin
        FollowUp.SetRange("Follow-up Date", 0D, DueDate);
        TotalFollowUps := FollowUp.Count();

        if TotalFollowUps = 0 then
            exit(0);

        FollowUp.SetRange(Completed, true);
        CompletedFollowUps := FollowUp.Count();

        exit(Round(CompletedFollowUps / TotalFollowUps * 100, 0.1));
    end;

}