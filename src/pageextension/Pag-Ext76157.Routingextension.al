pageextension 76157 "Routing extension" extends "Routing"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Item Engineering Code"; Rec."Item Engineering Code")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the Engineering Code (Item."Engineering Code") for this production BOM.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}