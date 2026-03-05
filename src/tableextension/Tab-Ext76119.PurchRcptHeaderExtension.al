tableextension 76119 "Purch Rcpt Header Extension" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(76100; "Cash Supplier Name"; Text[100])
        {
            Caption = 'Cash Supplier Name';
            DataClassification = CustomerContent;
        }
    }
}