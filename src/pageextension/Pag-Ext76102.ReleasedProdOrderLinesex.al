pageextension 76102 "Released Prod. Order Lines ex" extends "Released Prod. Order Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter("Item No.")
        {
            field("Item No.2"; Rec."Item No.2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item No.2 field.', Comment = '%';
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