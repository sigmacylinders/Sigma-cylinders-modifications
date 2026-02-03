pageextension 76101 "item card extension SCM" extends "Item card"
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