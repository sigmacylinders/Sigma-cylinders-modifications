pageextension 76131 "TransferLines ItemNo2 Ext" extends "Transfer Order Subform"
{
    layout
    {
        addafter("Item No.")
        {
            field("Item No. 2"; Rec."Item No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the alternate item number (Item."No. 2") for this transfer line.';
            }
        }
    }
}