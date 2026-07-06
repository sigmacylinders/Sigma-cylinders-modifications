tableextension 76125 "PostedWhseRcptLine ItemNo2 Ext" extends "Posted Whse. Receipt Line"
{
    fields
    {
        field(76100; "Item No. 2"; Code[20])
        {
            Caption = 'Item No. 2';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."No. 2" where("No." = field("Item No.")));
        }
        field(76101; "Item Engineering Code"; Code[100])
        {
            Caption = 'Item Engineering Code';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Engineering Code" where("No." = field("Item No.")));
        }
    }


}