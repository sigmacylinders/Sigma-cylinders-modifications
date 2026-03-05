pageextension 76127 "WhseRcptLines ItemNo2 Ext" extends "WHSE. Receipt Subform"
{
    layout
    {
        addafter("Item No.")
        {
            field("Item No. 2"; Rec."Item No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the alternate item number (Item."No. 2") for this receipt line.';
            }
        }
    }
}