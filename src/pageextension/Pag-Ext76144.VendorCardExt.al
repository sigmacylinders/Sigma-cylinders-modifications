pageextension 76144 "Vendor Card Ext" extends "Vendor Card"
{
    layout
    {
        addafter(Name)
        {
            field(Category; Rec.Category)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the vendor category.';
            }
        }
    }
}
