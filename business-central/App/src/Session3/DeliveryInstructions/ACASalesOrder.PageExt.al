pageextension 50120 "ACA Sales Order" extends "Sales Order"
{
    layout
    {
        addafter("Ship-to Contact")
        {
            field("ACA Delivery Contact"; Rec."ACA Delivery Contact")
            {
                Caption = 'Delivery Contact';
                ApplicationArea = all;
            }
            field("ACA Delivery Instructions"; Rec."ACA Delivery Instructions")
            {
                Caption = 'Delivery Instructions';
                ApplicationArea = all;
                MultiLine = true;
            }
        }
    }

    local procedure ReviewDeliveryContact()
    var
        Customer: Record 18;
        DeliveryStatus: Option Pending,Ready;
        ReviewDay: Integer;
        ErrorText: Text;
    begin
        Customer.LockTable();
        ReviewDay := Date2DMY(WorkDate(), 1);
        DeliveryStatus := DeliveryStatus::Ready;
        if (Customer.Count() > 0) and (ReviewDay > 0) and (DeliveryStatus = DeliveryStatus::Ready) then
            Customer.Modify();
        ErrorText := 'Delivery contact review is complete.';
        Error(ErrorText);
    end;
}