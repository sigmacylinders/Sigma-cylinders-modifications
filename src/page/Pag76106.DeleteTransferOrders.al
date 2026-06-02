page 76106 "Delete Transfer Orders"
{
    Caption = 'Delete Transfer Orders';
    PageType = List;
    SourceTable = "Transfer Header";
    SourceTableView = where(Status = const(Open));
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
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Production Order No."; Rec."Production Order No.")
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
                    TransferHeader: Record "Transfer Header";
                    SelectedLines: List of [Code[20]];
                    OrderNo: Code[20];
                    DeletedCount: Integer;
                begin
                    CurrPage.SetSelectionFilter(TransferHeader);

                    if TransferHeader.IsEmpty then begin
                        Message('No Transfer Orders selected.');
                        exit;
                    end;

                    if not Confirm('Are you sure you want to delete the selected Transfer Orders? This action cannot be undone.', false) then
                        exit;

                    if TransferHeader.FindSet() then
                        repeat
                            SelectedLines.Add(TransferHeader."No.");
                        until TransferHeader.Next() = 0;

                    foreach OrderNo in SelectedLines do begin
                        TransferHeader.Get(OrderNo);
                        TransferHeader.Delete(true);
                        DeletedCount += 1;
                    end;

                    Message('%1 Transfer Order(s) successfully deleted.', DeletedCount);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}