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
}