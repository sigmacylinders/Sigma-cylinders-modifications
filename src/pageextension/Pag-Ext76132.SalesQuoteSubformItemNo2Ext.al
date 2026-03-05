pageextension 76132 "SalesQuoteSubform ItemNo2 Ext" extends "Sales Quote Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Item No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Alternate item number from the Item Card for this sales quote line.';
                Visible = true;
            }
        }
    }
}