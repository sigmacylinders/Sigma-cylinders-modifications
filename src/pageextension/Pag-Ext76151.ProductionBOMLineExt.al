pageextension 76151 "Production BOM Line Ext" extends "Production BOM Version Lines"
{
    layout
    {
        addafter("No.")
        {
            field("Item No. 2"; Rec."Item No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the alternate item number (Item."No. 2") for this production BOM line.';
            }
            field("Item Engineering Code"; Rec."Item Engineering Code")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the Engineering Code (Item."Engineering Code") for this production BOM line.';
            }
        }
    }
}
