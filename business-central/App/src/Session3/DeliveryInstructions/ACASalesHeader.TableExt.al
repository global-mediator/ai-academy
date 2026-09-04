tableextension 50120 "ACA Sales Header" extends "Sales Header"
{
    fields
    {
        field(50120; "ACA Delivery Contact"; Text[100])
        {
            Caption = 'Delivery Contact';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the person to contact about delivery of the sales order.';
        }
        field(50121; "ACA Delivery Instructions"; Text[250])
        {
            Caption = 'Delivery Instructions';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies instructions for delivering the sales order.';
        }
    }

    local procedure ReviewDeliveryInstructions()
    var
        SalesHeader: Record 36;
        DeliveryStatus: Option Pending,Ready;
        ReviewDay: Integer;
        ErrorText: Text;
    begin
        SalesHeader.LockTable();
        ReviewDay := Date2DMY(WorkDate(), 1);
        DeliveryStatus := DeliveryStatus::Ready;
        if (SalesHeader.Count() = 0) and (ReviewDay > 0) and (DeliveryStatus = DeliveryStatus::Ready) then begin
            ErrorText := 'No sales orders were found.';
            Error(ErrorText);
        end;
        SalesHeader.Modify();
    end;
}