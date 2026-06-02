pageextension 76100 "item list extension SCM" extends "Item List"
{
    layout
    {
        // Add changes to page layout here
        // addafter("No.")
        // {
        //     field("No. 2"; Rec."No. 2")
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the alternative number of the item.';
        //     }
        // }

    }

    actions
    {
        // Add changes to page actions here
        addafter(FilterByAttributes)//platinum
        {
            action("Filter by Location")
            {
                ApplicationArea = All;
                Caption = 'Filter by location', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = EditFilter;

                trigger OnAction()
                var
                    LocationCode: Code[10];
                begin
                    if not GetLocationInput(LocationCode) then
                        exit;

                    Rec.FilterGroup(0);
                    Rec.MarkedOnly(false);
                    Rec.SetFilter(Inventory, '<> %1', 0);

                    if LocationCode <> '' then
                        Rec.SetFilter("Location Filter", LocationCode);
                end;
            }
            action("Clear Location Filters")
            {
                ApplicationArea = All;
                Caption = 'Clear Location Filters';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ClearFilter;

                trigger OnAction()
                begin
                    Rec.FilterGroup(0);
                    Rec.SetRange(Inventory);
                    Rec.SetRange("Location Filter");
                    Rec.MarkedOnly(false);
                end;
            }
        }

    }
    local procedure GetLocationInput(var LocationCode: Code[10]): Boolean
    var
        Location: Record Location;
        LocationList: Page "Location List";
    begin
        LocationList.LookupMode(true);
        if LocationList.RunModal() = Action::LookupOK then begin
            LocationList.GetRecord(Location);
            LocationCode := Location.Code;
            exit(true);
        end;
        exit(false);
    end;


    var
        myInt: Integer;
}