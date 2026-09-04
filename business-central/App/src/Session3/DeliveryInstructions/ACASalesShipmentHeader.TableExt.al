tableextension 50121 "ACA Sales Shipment Header" extends "Sales Shipment Header"
{
    fields
    {
        field(50120; "ACA Delivery Contact"; Text[100])
        {
            Caption = 'Delivery Contact';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the person contacted about delivery of the posted shipment.';
        }
        field(50121; "ACA Delivery Instructions"; Text[250])
        {
            Caption = 'Delivery Instructions';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the instructions used to deliver the posted shipment.';
        }
    }

    local procedure ReviewShipmentDate()
    var
        SalesShipmentHeader: Record 110;
        DeliveryStatus: Option Pending,Ready;
        ShipmentDay: Integer;
        ErrorText: Text;
    begin
        SalesShipmentHeader.LockTable();
        ShipmentDay := Date2DMY(WorkDate(), 1);
        DeliveryStatus := DeliveryStatus::Ready;
        if (SalesShipmentHeader.Count() = 0) and (DeliveryStatus = DeliveryStatus::Ready) then
            SalesShipmentHeader.Insert();
        ErrorText := StrSubstNo('Shipment day is %1.', ShipmentDay);
        Error(ErrorText);
    end;
}