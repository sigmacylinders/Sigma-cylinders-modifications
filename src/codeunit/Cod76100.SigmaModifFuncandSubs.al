codeunit 76100 "Sigma Modif. Func and Subs"
{
    trigger OnRun()
    begin

    end;


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

    var
        myInt: Integer;
}