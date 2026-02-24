pageextension 76110 "Released ProdOrder Ext" extends "Released Production Order"
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
                    ParentTransferOrder: Record "Parent Transfer order";
                    ParentTransferorderLines: Record "Parent Transfer Order Line";
                    ProductionOrderComponents: Record "Prod. Order Component";
                    LineNo: Integer;
                begin
                    Rec.TestField("To Location");
                    LineNo := 10000;
                    ParentTransferOrder.Init();
                    ParentTransferOrder.Insert(true);
                    Clear(ProductionOrderComponents);
                    ProductionOrderComponents.SetRange(Status, ProductionOrderComponents.Status::Released);
                    ProductionOrderComponents.SetRange("Prod. Order No.", Rec."No.");
                    ProductionOrderComponents.SetFilter("Transfer From Location", '<> %1', '');
                    ProductionOrderComponents.SetRange(Processed, false);
                    if ProductionOrderComponents.FindSet() then
                        repeat
                            Clear(ParentTransferorderLines);
                            ParentTransferorderLines."Parent Transfer Order #" := ParentTransferOrder."Parent Transfer Order #";
                            ParentTransferorderLines."Line No." := LineNo;
                            LineNo := LineNo + 10000;
                            ParentTransferorderLines."MO Description" := Rec.Description;
                            ParentTransferorderLines.Select := false;
                            ParentTransferorderLines."MO #" := Rec."No.";
                            ParentTransferorderLines.Week := Rec."Week No.";
                            ParentTransferorderLines."Arabic Description" := '';
                            ParentTransferorderLines."Item No." := ProductionOrderComponents."Item No.";
                            ParentTransferorderLines.Description := ProductionOrderComponents.Description;
                            ParentTransferorderLines."Unit of Measure Code" := ProductionOrderComponents."Unit of Measure Code";
                            ParentTransferorderLines."Due Date" := ProductionOrderComponents."Due Date";
                            ParentTransferorderLines."MO Qty" := ProductionOrderComponents."Expected Quantity";
                            ParentTransferorderLines."Qty to Be Transferred" := ProductionOrderComponents."Expected Quantity";
                            ParentTransferorderLines."Remaining Quantity" := 0;
                            ParentTransferorderLines."Over Qty" := 0;
                            ParentTransferorderLines.Date := DT2Date(Rec.SystemCreatedAt);
                            ParentTransferorderLines."Transfer From Location" := ProductionOrderComponents."Transfer From Location";
                            ParentTransferorderLines."Transfer To" := Rec."To Location";
                            ParentTransferorderLines."Shortcut Dimension 1 Code" := rec."Shortcut Dimension 1 Code";
                            ParentTransferorderLines."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                            ParentTransferorderLines."Shortcut Dimension 3 Code" := '';
                            ParentTransferorderLines."Shortcut Dimension 4 Code" := '';
                            ParentTransferorderLines."Employee Dimension Code" := '';
                            ParentTransferorderLines."Fully Processed" := false;
                            ParentTransferorderLines."Partially Processed" := false;
                            ParentTransferorderLines.Insert();

                            ProductionOrderComponents.Processed := true;
                            ProductionOrderComponents.Modify();
                        until ProductionOrderComponents.Next() = 0;

                    Page.Run(page::"Parent Transfer Order Card", ParentTransferOrder);

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
