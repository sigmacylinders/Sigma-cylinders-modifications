pageextension 76140 "Items by Location Matrix Ext" extends "Items by Location Matrix"
{
    layout
    {
        addafter("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the item''s alternate number.';
            }
        }
    }
}
