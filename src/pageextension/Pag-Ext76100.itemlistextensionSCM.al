pageextension 76100 "item list extension SCM" extends "Item List"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the alternative number of the item.';
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