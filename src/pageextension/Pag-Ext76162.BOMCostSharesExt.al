pageextension 76162 "BOM Cost Shares Ext" extends "BOM Cost Shares"
{
    layout
    {
        addafter("No.")
        {
            field("Item No. 2"; Rec."Item No. 2")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Shows the alternate item number (Item."No. 2") for this BOM line.';
            }
        }

        addafter("Qty. per Parent")
        {
            field("Scrap"; Rec."Scrap")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies whether the item on this BOM line is marked as scrap.';
            }
        }
    }
}
