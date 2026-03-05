pageextension 76118 "Purch. Receipt Lines extension" extends "Purch. Receipt Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter("Buy-from Vendor No.")

        {

            field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Buy-from Vendor Name field.', Comment = '%';
            }
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Invoice No. field.', Comment = '%';
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