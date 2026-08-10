pageextension 76160 "Production BOM Lines Ext" extends "Production BOM Lines"
{
    layout
    {
        addbefore("Scrap %")
        {
            field("Scrap Tolerance"; Rec."Scrap Tolerance")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the scrap tolerance percentage. It is added to the work center scrap percentage to make up the Scrap % of this line.';
            }
            field("Work Center Scrap %"; Rec."Work Center Scrap %")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the work center scrap percentage. It is added to the scrap tolerance to make up the Scrap % of this line.';
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


        // modify("Scrap %")
        // {
        //     Editable = false;
        // }
    }
}
