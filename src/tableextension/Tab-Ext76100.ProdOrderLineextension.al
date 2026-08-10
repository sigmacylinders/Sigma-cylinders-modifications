tableextension 76100 "Prod. Order Line extension" extends "Prod. Order Line"
{
    fields
    {
        // Add changes to table fields here
        field(76100; "Item No.2"; code[20])
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup(Item."No. 2" where("No." = field("Item No.")));

        }
        field(76101; "Engineering Code"; code[100])
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            calcformula = lookup(Item."Engineering Code" where("No." = field("Item No.")));
        }
        field(76102; "Variant Code 2"; Code[50])
        {
            //      DataClassification = ToBeClassified;
            fieldclass = FlowField;
            CalcFormula = lookup("Item Variant"."Variant Code" where("Item No." = field("Item No."), "Variant Code" = field("Variant Code")));
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