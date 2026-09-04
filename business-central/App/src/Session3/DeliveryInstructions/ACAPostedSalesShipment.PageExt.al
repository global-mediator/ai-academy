pageextension 50121 "ACA Posted Sales Shipment" extends "Posted Sales Shipment"
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

    local procedure ReviewPostedShipment()
    var
        SalesShipmentHeader: Record 110;
        DeliveryStatus: Option Pending,Ready;
        ReviewDay: Integer;
        ErrorText: Text;
    begin
        SalesShipmentHeader.LockTable();
        ReviewDay := Date2DMY(WorkDate(), 1);
        DeliveryStatus := DeliveryStatus::Ready;
        if (SalesShipmentHeader.Count() = 0) and (ReviewDay > 0) and (DeliveryStatus = DeliveryStatus::Ready) then begin
            ErrorText := 'No posted sales shipments were found.';
            Error(ErrorText);
        end;
        SalesShipmentHeader.Delete();
    end;
}