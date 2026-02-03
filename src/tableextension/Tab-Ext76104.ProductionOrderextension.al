tableextension 76104 "Production Order extension" extends "Production Order"
{
    fields
    {
        // Add changes to table fields here
        field(76100; "Week No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "SIGMA Lookup - V3".Code where(Type = const(WEEKNO));
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