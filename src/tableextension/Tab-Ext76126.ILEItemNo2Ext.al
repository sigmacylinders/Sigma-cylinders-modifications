tableextension 76126 "ILE ItemNo2 Ext" extends "Item Ledger Entry"
{
    fields
    {
        field(76100; "Item No. 2"; Code[20])
        {
            Caption = 'Item No. 2';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."No. 2" where("No." = field("Item No.")));
        }
        field(76101; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Rcpt. Header"."Order No." where("No." = field("Document No.")));
            Editable = false;
        }
    }
}