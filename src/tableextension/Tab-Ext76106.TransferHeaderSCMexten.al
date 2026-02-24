tableextension 76106 "Transfer Header SCM exten" extends "Transfer Header"
{
    fields
    {
        // Add changes to table fields here\

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