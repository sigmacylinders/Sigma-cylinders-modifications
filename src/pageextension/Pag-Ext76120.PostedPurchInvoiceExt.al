pageextension 76120 "Posted Purch Invoice Ext" extends "Posted Purchase Invoice"
{
    layout
    {
        addlast(General)
        {
            field("Cash Supplier Name"; Rec."Cash Supplier Name")
            {
                ApplicationArea = All;
            }
        }
    }
}