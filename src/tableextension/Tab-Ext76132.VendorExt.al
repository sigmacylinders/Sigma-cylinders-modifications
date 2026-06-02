tableextension 76132 "Vendor Ext" extends Vendor
{
    fields
    {
        field(76100; "Category"; Code[50])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
            TableRelation = "SIGMA Lookup - V3".Code where(Type = const("Vendor Catgeory"));
        }
    }
}
