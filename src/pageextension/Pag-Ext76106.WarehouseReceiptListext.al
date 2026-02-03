pageextension 76106 "Warehouse Receipt List ext" extends "Warehouse Receipts"
{
    layout
    {
        addafter("Location Code")
        {
            field("Source Document"; Rec."Source Document")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Source Document field.', Comment = '%';
            }
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Source No. field.', Comment = '%';
            }
        }
        addfirst(factboxes)
        {
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Warehouse Shipment Header"),
                              "No." = field("No.");
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