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
}