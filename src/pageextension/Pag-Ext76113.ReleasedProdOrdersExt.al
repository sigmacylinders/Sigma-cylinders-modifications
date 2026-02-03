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

  /*  actions
    {
        addafter("Change &Status")
        {
            action("Fill the Week No Field")
            {
                ApplicationArea = All;
                Image = Import;
                trigger OnAction()
                var
                    ProductionOrder: Record "Production Order";
                begin
                    Clear(ProductionOrder);
                    ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);
                    if ProductionOrder.FindSet() then
                        repeat
                            if ProductionOrder.SystemCreatedAt <> 0DT then begin
                                ProductionOrder."Week No." := 'WEEK ' + format(Date2DWY(DT2Date(ProductionOrder.SystemCreatedAt), 2));
                                ProductionOrder.Modify();
                            end

                        until ProductionOrder.Next() = 0;
                end;
            }
        }
    }*/


    var
        WeekNo: Integer;

    trigger OnAfterGetRecord()
    begin
        IF Rec."Week No." = '' then
            if Rec.SystemCreatedAt <> 0DT then
                Rec."Week No." := 'WEEK ' + format(Date2DWY(DT2Date(Rec.SystemCreatedAt), 2));
    end;


}
