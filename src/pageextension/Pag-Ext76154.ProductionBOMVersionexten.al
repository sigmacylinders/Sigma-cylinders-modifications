pageextension 76154 "Production BOM Version exten" extends "Production BOM Version"
{
    layout
    {
        // Add changes to page layout here
        addafter("Version Code")
        {
            field("Item Engineering Code"; Rec."Item Engineering Code")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the Engineering Code (Item."Engineering Code") for this production BOM.';
            }
        }
    }


    var
        myInt: Integer;
}