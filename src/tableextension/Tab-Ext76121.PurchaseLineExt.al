tableextension 76121 "Purchase Line Ext" extends "Purchase Line"
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
        field(76101; "Engineering Code"; Code[100])
        {
            Caption = 'Engineering Code';
            Editable = false;
            // FlowField to pull the Engineering Code from the Item table
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Engineering Code" where("No." = FIELD("No.")));
        }
    }
}