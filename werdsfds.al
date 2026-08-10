tableextension 76162 "BOM Buffer extension" extends "BOM Buffer"
{
    fields
    {
        // Add changes to table fields here
        field(76100; "Item No. 2"; Code[20])
        {
            Caption = 'Item No. 2';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."No. 2" where("No." = field("No.")));
        }
        field(76101; "Scrap"; boolean)
        {
            Caption = 'Scrap';
            FieldClass = FlowField;
            CalcFormula = exist(Item where("No." = field("No."), scrap = CONST(true)));
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