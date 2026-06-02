pageextension 76143 "Vendor List Ext" extends "Vendor List"
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
