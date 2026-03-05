pageextension 76133 "PurchQuoteSubform ItemNo2 Ext" extends "Purchase Quote Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Item No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Alternate item number from the Item Card for this purchase quote line.';
                Visible = true;
            }
        }
    }
}