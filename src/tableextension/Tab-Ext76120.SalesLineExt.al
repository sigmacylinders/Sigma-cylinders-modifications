tableextension 76120 "Sales Line Ext" extends "Sales Line"
{
    fields
    {
        field(76100; "No. 2"; Code[20])
        {
            Caption = 'No. 2';
            Editable = false;
            // FlowField to pull a numeric field from Item table
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."No. 2" where("No." = FIELD("No.")));
        }
    }
}