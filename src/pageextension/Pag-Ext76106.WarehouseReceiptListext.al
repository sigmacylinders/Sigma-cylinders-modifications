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
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Name field.', Comment = '%';
            }
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Invoice No. field.', Comment = '%';
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

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId()) then
            if UserSetup."Whse. Receipt Source Document" <> "Warehouse Activity Source Document"::" " then begin
                Rec.FilterGroup(2);
                Rec.SetRange("Source Document", UserSetup."Whse. Receipt Source Document");
                rec.FilterGroup(0);
            end;

    end;

    var
        myInt: Integer;
}