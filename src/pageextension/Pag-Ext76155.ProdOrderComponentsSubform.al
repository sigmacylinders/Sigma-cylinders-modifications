pageextension 76155 "Prod. Order Components Subform" extends "Prod. Order Components Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Item No.")
        {
            field("Item No. 2"; Rec."Item No. 2")
            {
                ApplicationArea = All;
            }
            field("Item Engineering Code"; Rec."Item Engineering Code")
            {
                ApplicationArea = All;
                ToolTip = 'Engineering Code from the Item Card for this production order component line.';
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