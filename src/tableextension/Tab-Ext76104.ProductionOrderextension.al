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
        field(76101; "Item No. 2"; Code[20])
        {
            Caption = 'Item No. 2';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."No. 2" where("No." = field("Source No.")));
        }
        field(76102; "Item Engineering Code"; Code[100])
        {
            Caption = 'Item Engineering Code';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Engineering Code" where("No." = field("Source No.")));
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