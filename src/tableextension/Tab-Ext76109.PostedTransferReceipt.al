tableextension 76109 "Posted Transfer Receipt" extends "Transfer Receipt Header"
{
    fields
    {
        // Add changes to table fields here
        field(76100; "Parent Transfer Order #"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(76101; "Production Order No."; Code[20])
        {
        }
        field(76102; "Production Order Status"; Enum Microsoft.Manufacturing.Document."Production Order Status")
        {
        }
        field(76103; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
        }

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}