pageextension 76128 "PostedWhseRcptLines Ext" extends "Posted Whse. Receipt Subform"
{
    layout
    {
        addafter("Item No.")
        {
            field("Item No. 2"; Rec."Item No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the alternate item number (Item."No. 2") for this posted receipt line.';
            }
            field("Item Engineering Code"; Rec."Item Engineering Code")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the Engineering Code (Item."Engineering Code") for this posted receipt line.';
            }
        }
    }
}