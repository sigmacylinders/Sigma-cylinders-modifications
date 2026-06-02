pageextension 76129 "ILE Page ItemNo2 Ext" extends "Item Ledger Entries"
{
    layout
    {
        // This list has "Item No." as a column
        addafter("Item No.")
        {
            field("Item No. 2"; Rec."Item No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Alternate item number from the Item Card for the selected entry.';
            }
        }

        addafter("Document No.")
        {
            field("Purchase Order No."; Rec."Purchase Order No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the Purchase Order No. related to this entry.';
            }
        }
    }
}