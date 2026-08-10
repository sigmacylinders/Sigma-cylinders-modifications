pageextension 76151 "Production BOM Line Ext" extends "Production BOM Version Lines"
{
    layout
    {
        addafter("No.")
        {
            field("Item No. 2"; Rec."Item No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the alternate item number (Item."No. 2") for this production BOM line.';
            }
            field("Item Engineering Code"; Rec."Item Engineering Code")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the Engineering Code (Item."Engineering Code") for this production BOM line.';
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
        addafter("Quantity per")
        {
            field("Qty per net"; Rec."Qty per net")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity per net.';
            }
        }

        // modify("Scrap %")
        // {
        //     Editable = false;
        // }
    }
}
