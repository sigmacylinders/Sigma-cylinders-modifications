tableextension 76110 "Posted Transfer Shipment line" extends "Transfer Shipment Line"
{
    fields
    {
        // Add changes to table fields here
        field(76100; "Parent Transfer Order #"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(76101; "Parent Transfer Order line #"; Integer)
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