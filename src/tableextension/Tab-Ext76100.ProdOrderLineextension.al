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