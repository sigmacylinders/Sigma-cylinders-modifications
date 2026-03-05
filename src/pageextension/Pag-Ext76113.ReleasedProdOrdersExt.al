pageextension 76113 "Released ProdOrders Ext" extends "Released Production Orders"
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
        addafter("Change &Status")
        {
            action("Send to Parent Transfer order")
            {
                ApplicationArea = All;
                Image = Import;
                trigger OnAction()
                var
                    ProdOrder: Record "Production Order";
                    Sigma_Modif_Func: Codeunit "Sigma Modif. Func and Subs";
                begin
                    // Get selected records from the page
                    CurrPage.SetSelectionFilter(ProdOrder);

                    if ProdOrder.IsEmpty() then begin
                        Message('No records selected.');
                        exit;
                    end;
                    Sigma_Modif_Func.CreateParentTransferorderSelection(ProdOrder);

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
