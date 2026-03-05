tableextension 76114 "Purchase header extension" extends "Purchase Header"
{
    fields
    {
        // Add changes to table fields here
        field(76100; "Cash Supplier Name"; Text[100])
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