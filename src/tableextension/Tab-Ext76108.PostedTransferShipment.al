tableextension 76108 "Posted Transfer Shipment" extends "Transfer Shipment Header"
{
    fields
    {
        // Add changes to table fields here
        field(76100; "Parent Transfer Order #"; Code[50])
        {
            DataClassification = ToBeClassified;
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