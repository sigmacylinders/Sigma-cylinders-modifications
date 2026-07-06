pageextension 76147 "Sales Order Ext" extends "Sales Order"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Cash Client Name"; Rec."Cash Client Name")
            {
                ApplicationArea = All;
            }
        }
    }
}
