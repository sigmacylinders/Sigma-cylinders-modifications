pageextension 76130 "ValueEntries Page ItemNo2 Ext" extends "Value Entries"
{
    layout
    {
        addafter("Item No.")
        {
            field("Item No. 2"; Rec."Item No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Alternate item number from the Item Card for the selected value entry.';
            }
        }
    }
}