codeunit 76100 "Sigma Modif. Func and Subs"
{
    trigger OnRun()
    begin

    end;

    //transdfers attachments
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", 'OnAfterGetRefTable', '', false, false)]
    local procedure OnAfterGetRefTable(var RecRef: RecordRef; DocumentAttachment: Record "Document Attachment")
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";

    begin
        case DocumentAttachment."Table ID" of


            Database::"Warehouse Shipment Header":
                begin
                    RecRef.Open(Database::"Warehouse Shipment Header");
                    if WarehouseShipmentHeader.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(WarehouseShipmentHeader);
                end;
            Database::"Warehouse Receipt Header":
                begin
                    RecRef.Open(Database::"Warehouse Receipt Header");
                    if WarehouseReceiptHeader.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(WarehouseReceiptHeader);
                end;
        end;
    end;

    //OnAfterGetRecRefFail (Page Event)
    [EventSubscriber(ObjectType::Page, Page::"Doc. Attachment List Factbox", 'OnAfterGetRecRefFail', '', false, false)]
    local procedure DocAttachmentListFactbox_OnAfterGetRecRefFail(var Sender: Page "Doc. Attachment List Factbox"; DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
    begin
        case DocumentAttachment."Table ID" of
            DATABASE::"Warehouse Shipment Header":
                begin
                    RecRef.Open(DATABASE::"Warehouse Shipment Header");
                    if WarehouseShipmentHeader.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(WarehouseShipmentHeader);
                end;

            Database::"Warehouse Receipt Header":
                begin
                    RecRef.Open(Database::"Warehouse Receipt Header");
                    if WarehouseReceiptHeader.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(WarehouseReceiptHeader);
                end;
        end;
    end;
    //OnAfterInitFieldsFromRecRef (Table Event)
    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure DocumentAttachment_OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            Database::"Warehouse Shipment Header", Database::"Warehouse Receipt Header":
                begin
                    FieldRef := RecRef.Field(1); // Assuming Entry No. is the first field
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", 'OnAfterTableHasNumberFieldPrimaryKey', '', false, false)]
    local procedure OnAfterTableHasNumberFieldPrimaryKey(TableNo: Integer; var Result: Boolean; var FieldNo: Integer)
    begin
        case TableNo of
            Database::"Warehouse Shipment Header", Database::"Warehouse Receipt Header":
                begin
                    FieldNo := 1;
                    Result := true;
                end;
        end;
    end;
    //send field to posted transfers
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptHeader', '', false, false)]
    local procedure OnBeforeInsertTransShptHeader(var TransShptHeader: Record "Transfer Shipment Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    begin
        TransShptHeader."Parent Transfer Order #" := TransHeader."Parent Transfer Order #";
        TransShptHeader."Production Order No." := TransHeader."Production Order No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnBeforeInsertTransRcptHeader, '', false, false)]
    local procedure OnBeforeInsertTransRcptHeader(var TransRcptHeader: Record "Transfer Receipt Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var Handled: Boolean)
    begin
        TransRcptHeader."Parent Transfer Order #" := TransHeader."Parent Transfer Order #";
        TransRcptHeader."Production Order No." := TransHeader."Production Order No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterInsertTransShptLine', '', false, false)]
    local procedure OnAfterInsertTransShptLine(var TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; TransShptHeader: Record "Transfer Shipment Header")
    begin
        TransShptLine."Parent Transfer Order #" := TransLine."Parent Transfer Order #";
        TransShptLine."Parent Transfer Order line #" := TransLine."Parent Transfer Order line #";
        TransShptLine."Prod. Order No." := TransLine."Prod. Order No.";
        TransShptLine."Prod. Order Line No." := TransLine."Prod. Order Line No.";
        TransShptLine."Prod. Order Component Line No." := TransLine."Prod. Order Component Line No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnAfterInsertTransRcptLine, '', false, false)]
    local procedure OnAfterInsertTransRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; TransferReceiptHeader: Record "Transfer Receipt Header")
    begin
        TransRcptLine."Parent Transfer Order #" := TransLine."Parent Transfer Order #";
        TransRcptLine."Parent Transfer Order line #" := TransLine."Parent Transfer Order line #";
        TransRcptLine."Prod. Order No." := TransLine."Prod. Order No.";
        TransRcptLine."Prod. Order Line No." := TransLine."Prod. Order Line No.";
        TransRcptLine."Prod. Order Component Line No." := TransLine."Prod. Order Component Line No.";
    end;



    //create PTO
    procedure CreateParentTransferorder(var ReleasedProductionOrder: Record "Production Order")
    var

        ParentTransferOrder: Record "Parent Transfer order";
        ParentTransferorderLines: Record "Parent Transfer Order Line";
        ProductionOrderComponents: Record "Prod. Order Component";
        LineNo: Integer;
    begin
        ReleasedProductionOrder.TestField("To Location");
        LineNo := 10000;
        ParentTransferOrder.Init();
        ParentTransferOrder.Insert(true);
        Clear(ProductionOrderComponents);
        ProductionOrderComponents.SetRange(Status, ProductionOrderComponents.Status::Released);
        ProductionOrderComponents.SetRange("Prod. Order No.", ReleasedProductionOrder."No.");
        ProductionOrderComponents.SetFilter("Transfer From Location", '<> %1', '');
        ProductionOrderComponents.SetRange(Processed, false);
        if ProductionOrderComponents.FindSet() then
            repeat
                Clear(ParentTransferorderLines);
                ParentTransferorderLines."Parent Transfer Order #" := ParentTransferOrder."Parent Transfer Order #";
                ParentTransferorderLines."Line No." := LineNo;
                LineNo := LineNo + 10000;
                ParentTransferorderLines."Production order Description" := ReleasedProductionOrder.Description;
                ParentTransferorderLines.Select := false;
                ParentTransferorderLines."Prod. Order No." := ReleasedProductionOrder."No.";
                ParentTransferorderLines."Prod. Order Line No." := ProductionOrderComponents."Prod. Order Line No.";
                ParentTransferorderLines."Prod. Order Component Line No." := ProductionOrderComponents."Line No.";
                ParentTransferorderLines.Week := ReleasedProductionOrder."Week No.";
                ParentTransferorderLines."Arabic Description" := '';
                ParentTransferorderLines."Item No." := ProductionOrderComponents."Item No.";
                ParentTransferorderLines.Description := ProductionOrderComponents.Description;
                ParentTransferorderLines."Unit of Measure Code" := ProductionOrderComponents."Unit of Measure Code";
                ParentTransferorderLines."Due Date" := ProductionOrderComponents."Due Date";
                ParentTransferorderLines."Production order Qty" := ProductionOrderComponents."Expected Quantity";
                ParentTransferorderLines."Qty to Be Transferred" := ProductionOrderComponents."Expected Quantity";
                ParentTransferorderLines."Remaining Quantity" := 0;
                ParentTransferorderLines."Over Qty" := 0;
                ParentTransferorderLines.Date := DT2Date(ReleasedProductionOrder.SystemCreatedAt);
                ParentTransferorderLines."Transfer From Location" := ProductionOrderComponents."Transfer From Location";
                ParentTransferorderLines."Transfer To" := ReleasedProductionOrder."To Location";
                ParentTransferorderLines."Shortcut Dimension 1 Code" := ReleasedProductionOrder."Shortcut Dimension 1 Code";
                ParentTransferorderLines."Shortcut Dimension 2 Code" := ReleasedProductionOrder."Shortcut Dimension 2 Code";
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

    procedure CreateParentTransferorderSelection(var ReleasedProductionOrders: Record "Production Order")
    var

        ParentTransferOrder: Record "Parent Transfer order";
        ParentTransferorderLines: Record "Parent Transfer Order Line";
        ProductionOrderComponents: Record "Prod. Order Component";
        LineNo: Integer;
        PTOCreated: Boolean;
    begin
        LineNo := 10000;
        PTOCreated := false;
        if ReleasedProductionOrders.FindSet() then
            repeat
                ReleasedProductionOrders.TestField("To Location");




                IF NOT PTOCreated then begin
                    ParentTransferOrder.Init();
                    ParentTransferOrder.Insert(true);
                    PTOCreated := true;
                end;

                Clear(ProductionOrderComponents);
                ProductionOrderComponents.SetRange(Status, ProductionOrderComponents.Status::Released);
                ProductionOrderComponents.SetRange("Prod. Order No.", ReleasedProductionOrders."No.");
                //  ProductionOrderComponents.SetFilter("Transfer From Location", '<> %1', '');
                ProductionOrderComponents.SetRange(Processed, false);
                if ProductionOrderComponents.FindSet() then
                    repeat

                        ProductionOrderComponents.TestField("Transfer From Location");
                        Clear(ParentTransferorderLines);
                        ParentTransferorderLines."Parent Transfer Order #" := ParentTransferOrder."Parent Transfer Order #";
                        ParentTransferorderLines."Line No." := LineNo;
                        LineNo := LineNo + 10000;
                        ParentTransferorderLines."Production order Description" := ReleasedProductionOrders.Description;
                        ParentTransferorderLines.Select := false;
                        ParentTransferorderLines."Prod. Order No." := ReleasedProductionOrders."No.";
                        ParentTransferorderLines."Prod. Order Line No." := ProductionOrderComponents."Prod. Order Line No.";
                        ParentTransferorderLines."Prod. Order Component Line No." := ProductionOrderComponents."Line No.";
                        ParentTransferorderLines.Week := ReleasedProductionOrders."Week No.";
                        ParentTransferorderLines."Arabic Description" := '';
                        ParentTransferorderLines."Item No." := ProductionOrderComponents."Item No.";
                        ParentTransferorderLines.Description := ProductionOrderComponents.Description;
                        ParentTransferorderLines."Unit of Measure Code" := ProductionOrderComponents."Unit of Measure Code";
                        ParentTransferorderLines."Due Date" := ProductionOrderComponents."Due Date";
                        ParentTransferorderLines."Production order Qty" := ProductionOrderComponents."Expected Quantity";
                        ParentTransferorderLines."Qty to Be Transferred" := ProductionOrderComponents."Expected Quantity";
                        ParentTransferorderLines."Remaining Quantity" := 0;
                        ParentTransferorderLines."Over Qty" := 0;
                        ParentTransferorderLines.Date := DT2Date(ReleasedProductionOrders.SystemCreatedAt);
                        ParentTransferorderLines."Transfer From Location" := ProductionOrderComponents."Transfer From Location";
                        ParentTransferorderLines."Transfer To" := ReleasedProductionOrders."To Location";
                        ParentTransferorderLines."Shortcut Dimension 1 Code" := ReleasedProductionOrders."Shortcut Dimension 1 Code";
                        ParentTransferorderLines."Shortcut Dimension 2 Code" := ReleasedProductionOrders."Shortcut Dimension 2 Code";
                        ParentTransferorderLines."Shortcut Dimension 3 Code" := '';
                        ParentTransferorderLines."Shortcut Dimension 4 Code" := '';
                        ParentTransferorderLines."Employee Dimension Code" := '';
                        ParentTransferorderLines."Fully Processed" := false;
                        ParentTransferorderLines."Partially Processed" := false;
                        ParentTransferorderLines.Insert();

                        ProductionOrderComponents.Processed := true;
                        ProductionOrderComponents.Modify();
                    until ProductionOrderComponents.Next() = 0;

            until ReleasedProductionOrders.Next() = 0;

        Page.Run(page::"Parent Transfer Order Card", ParentTransferOrder);


    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post",
                     'OnBeforePurchInvHeaderInsert', '', false, false)]
    local procedure CopyCashSupplierNameToPostedInv(
        PurchHeader: Record "Purchase Header";
        var PurchInvHeader: Record "Purch. Inv. Header")
    begin
        PurchInvHeader."Cash Supplier Name" := PurchHeader."Cash Supplier Name";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post",
                     'OnBeforePurchRcptHeaderInsert', '', false, false)]
    local procedure CopyCashSupplierNameToPostedRcpt(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WhseReceive: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean)
    begin

        PurchRcptHeader."Cash Supplier Name" := PurchaseHeader."Cash Supplier Name";
    end;





    var
        myInt: Integer;
}