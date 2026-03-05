pageextension 76121 "Posted Purch Rcpt Ext" extends "Posted Purchase Receipt"
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