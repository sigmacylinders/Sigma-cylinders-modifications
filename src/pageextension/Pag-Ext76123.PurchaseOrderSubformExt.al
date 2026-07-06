pageextension 76123 "Purchase Order Subform Ext" extends "Purchase Order Subform"
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
                ToolTip = 'Engineering Code from the Item Card for this purchase quote line.';
            }
        }
    }
}