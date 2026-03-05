pageextension 76126 "PostedWhseShptLines Ext" extends "Posted Whse. Shipment Subform"
{
    layout
    {
        addafter("Item No.")
        {
            field("Item No. 2"; Rec."Item No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the alternate item number (Item."No. 2") for this posted line.';
            }
        }
    }
}