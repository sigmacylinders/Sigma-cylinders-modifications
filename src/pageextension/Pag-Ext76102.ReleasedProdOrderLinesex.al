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
            field("Engineering Code"; Rec."Engineering Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Engineering Code field.', Comment = '%';
            }
        }
        addafter("Variant Code")
        {
            field("Variant Code 2"; Rec."Variant Code 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Variant Code 2 field.', Comment = '%';
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