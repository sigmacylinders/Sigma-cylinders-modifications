page 76107 "Delete Warehouse Shipments"
{
    Caption = 'Delete Warehouse Shipments';
    PageType = List;
    SourceTable = "Warehouse Shipment Header";
    // SourceTableView = where(Status = const(Open));
    UsageCategory = Tasks;
    ApplicationArea = All;
    Editable = false;
    MultipleNewLines = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Source Document"; Rec."Source Document")
                {
                    ToolTip = 'Specifies the value of the Source Document field.', Comment = '%';
                }
                field("Source No."; Rec."Source No.")
                {
                    ToolTip = 'Specifies the value of the Source No. field.', Comment = '%';
                }

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Parent Transfer Order #"; Rec."Parent Transfer Order #")
                {
                    ToolTip = 'Specifies the value of the Production Order No. field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DeleteSelected)
            {
                Caption = 'Delete Selected';
                ApplicationArea = All;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    WarehouseShipment: Record "Warehouse Shipment Header";
                    SelectedLines: List of [Code[20]];
                    OrderNo: Code[20];
                    DeletedCount: Integer;
                begin
                    CurrPage.SetSelectionFilter(WarehouseShipment);

                    if WarehouseShipment.IsEmpty then begin
                        Message('No Warehouse Shipment selected.');
                        exit;
                    end;

                    if not Confirm('Are you sure you want to delete the selected Warehouse Shipment? This action cannot be undone.', false) then
                        exit;

                    if WarehouseShipment.FindSet() then
                        repeat
                            SelectedLines.Add(WarehouseShipment."No.");
                        until WarehouseShipment.Next() = 0;

                    foreach OrderNo in SelectedLines do begin
                        WarehouseShipment.Get(OrderNo);
                        WarehouseShipment.Delete(true);
                        DeletedCount += 1;
                    end;

                    Message('%1 WarehouseShipment(s) successfully deleted.', DeletedCount);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}