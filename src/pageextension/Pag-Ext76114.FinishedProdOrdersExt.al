pageextension 76114 "Finished ProdOrders Ext" extends "Finished Production Orders"
{
    layout
    {
        addafter("Ending Date-Time")
        {
            field("Week No."; Rec."Week No.")
            {
                ApplicationArea = All;
                Caption = 'Week No.';
            }
        }
    }


    actions
    {
        addafter(Dimensions)
        {
            action("Create Transfer Order")
            {
                ApplicationArea = All;
                Caption = 'Create Transfer Order';
                Image = TransferOrder;
                ToolTip = 'Creates a transfer order for each selected finished production order.';
                trigger OnAction()
                var
                    SelectedProdOrders: Record "Production Order";
                    SigmaModifFunc: Codeunit "Sigma Modif. Func and Subs";
                begin
                    CurrPage.SetSelectionFilter(SelectedProdOrders);
                    // message(Format(SelectedProdOrders.Count) + ' record(s) selected.');
                    if SelectedProdOrders.IsEmpty() then begin
                        Message('No records selected.');
                        exit;
                    end;
                    SelectedProdOrders.SetRange("transfer Created", false);
                    SigmaModifFunc.CreateTransferOrderFromFinishedPO(SelectedProdOrders);


                end;
            }
        }
    }

    var
        WeekNo: Integer;

    trigger OnAfterGetRecord()
    begin
        IF Rec."Week No." = '' then
            if Rec.SystemCreatedAt <> 0DT then
                Rec."Week No." := 'WEEK ' + format(Date2DWY(DT2Date(Rec.SystemCreatedAt), 2));
    end;
}
