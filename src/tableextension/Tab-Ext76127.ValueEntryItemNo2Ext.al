tableextension 76127 "ValueEntry ItemNo2 Ext" extends "Value Entry"
{
    fields
    {
        field(76100; "Item No. 2"; Code[20])
        {
            Caption = 'Item No. 2';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."No. 2" where("No." = field("Item No.")));
        }
    }
}