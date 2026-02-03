pageextension 76115 "GL Setup Parent TO Ext" extends "General Ledger Setup"
{
    layout
    {
        addlast(General)
        {
            field("Parent TO No. Series"; Rec."Parent TO No. Series")
            {
                ApplicationArea = All;
            }
        }
    }
}
