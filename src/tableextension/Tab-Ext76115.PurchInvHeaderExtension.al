tableextension 76115 "Purch Inv Header Extension" extends "Purch. Inv. Header"
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