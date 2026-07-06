tableextension 76140 "Routing Version exte" extends "Routing Version"
{
    fields
    {
        // Add changes to table fields here
        field(76101; "Item Engineering Code"; Code[100])
        {
            Caption = 'Item Engineering Code';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Engineering Code" where("No. 2" = field("Routing No.")));
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