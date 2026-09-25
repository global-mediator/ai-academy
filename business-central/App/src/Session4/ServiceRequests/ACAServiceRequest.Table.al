table 50140 "ACA Service Request"
{
    Caption = 'Service Request';
    DataClassification = CustomerContent;
    LookupPageId = "ACA Service Requests";
    DrillDownPageId = "ACA Service Requests";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            ToolTip = 'Specifies the identifier of the service request.';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            ToolTip = 'Specifies the customer who raised the service request.';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies what the customer needs.';
        }
        field(4; "Requested Date"; Date)
        {
            Caption = 'Requested Date';
            ToolTip = 'Specifies the date when the customer needs the service.';
        }
        field(5; Urgent; Boolean)
        {
            Caption = 'Urgent';
            ToolTip = 'Specifies whether the service request must be handled before other requests.';
        }
        field(6; Closed; Boolean)
        {
            Caption = 'Closed';
            ToolTip = 'Specifies whether the service request is closed.';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(RequestedDate; "Requested Date")
        {
        }
    }
}
