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
        }
    }
}