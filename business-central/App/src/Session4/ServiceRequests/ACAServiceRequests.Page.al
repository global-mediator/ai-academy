page 50140 "ACA Service Requests"
{
    Caption = 'Service Requests';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ACA Service Request";
    SourceTableView = sorting("Requested Date") where(Closed = const(false));

    layout
    {
        area(Content)
        {
            repeater(Requests)
            {
                field("No."; Rec."No.")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Requested Date"; Rec."Requested Date")
                {
                }
                field(Urgent; Rec.Urgent)
                {
                    StyleExpr = UrgentStyle;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(MarkAsUrgent)
            {
                Caption = 'Mark as Urgent';
                Image = Warning;
                ToolTip = 'Mark the selected service request as urgent.';

                trigger OnAction()
                var
                    ServiceRequestMgt: Codeunit "ACA Service Request Mgt.";
                begin
                    ServiceRequestMgt.MarkAsUrgent(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UrgentStyle := 'Standard';
        if Rec.Urgent then
            UrgentStyle := 'Unfavorable';
    end;

    var
        UrgentStyle: Text;
}
