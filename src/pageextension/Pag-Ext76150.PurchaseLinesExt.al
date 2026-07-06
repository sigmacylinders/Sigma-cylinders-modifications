pageextension 76150 "Purchase Lines Ext" extends "Purchase Lines"
{
    layout
    {
        addafter("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
            }
            field("Engineering Code"; Rec."Engineering Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
