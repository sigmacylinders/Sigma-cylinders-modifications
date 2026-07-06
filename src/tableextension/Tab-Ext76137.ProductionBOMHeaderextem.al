tableextension 76137 "Production BOM Header extem" extends "Production BOM Header"
{
    fields
    {
        // Add changes to table fields here
        field(76101; "Item Engineering Code"; Code[100])
        {
            Caption = 'Item Engineering Code';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Engineering Code" where("No. 2" = field("No.")));
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