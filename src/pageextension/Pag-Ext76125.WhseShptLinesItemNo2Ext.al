pageextension 76125 "WhseShptLines ItemNo2 Ext" extends "Whse. Shipment Subform"
{
    layout
    {
        // The lines page has the "Item No." control
        addafter("Item No.")
        {
            field("Item No. 2"; Rec."Item No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the alternate item number (Item."No. 2") for this line.';
            }
            field("Item Engineering Code"; Rec."Item Engineering Code")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the Engineering Code (Item."Engineering Code") for this line.';
            }
        }
    }
}
