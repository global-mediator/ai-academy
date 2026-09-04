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
}