table 76103 "Item Subcategory Code"
{
    Caption = 'Item Subcategory Code';
    DataClassification = ToBeClassified;
    LookupPageId = "Item Subcategory Codes";
    DrillDownPageId = "Item Subcategory Codes";

    fields
    {
        field(1; "Type"; Enum "Item Subcategory Type")
        {
            Caption = 'Type';
        }

        field(2; "Code"; Code[50])
        {
            Caption = 'Code';
        }

        field(3; "Description"; Text[100])
        {
            Caption = 'Description';
        }

        field(4; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category".Code;
        }
    }

    keys
    {
        key(PK; "Type", "Code")
        {
            Clustered = true;
        }
    }
}
