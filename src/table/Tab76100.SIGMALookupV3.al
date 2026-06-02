table 76100 "SIGMA Lookup - V3"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "SIGMA Lookup - V3";
    LookupPageId = "SIGMA Lookup - V3";

    fields
    {
        field(1; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","WEEKNO","Vendor Catgeory";

        }
        field(2; "Code"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Type, Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }


    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}