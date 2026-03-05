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
        }
    }
}