pageextension 76108 "Warehouse Shipment ext" extends "Warehouse Shipment"
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
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
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
        addlast(processing)
        {
            /*   action("Post Shipment and Create Rcpt.")
               {
                   ApplicationArea = Warehouse;
                   Caption = 'Post Shipment and Create Rcpt.';
                   Image = PostShipment;
                   Promoted = true;
                   PromotedCategory = Process;
                   PromotedIsBig = true;
                   ToolTip = 'Post the warehouse shipment, then optionally create a warehouse receipt for the in-transit items.';

                   trigger OnAction()
                   var
                       WhseShipmentLine: Record "Warehouse Shipment Line";
                       WhsePostShipment: Codeunit "Whse.-Post Shipment";
                       TransOrderNos: List of [Code[20]];
                       TransOrderNo: Code[20];
                   begin
                       // Capture Transfer Order Nos. before posting – the header record is gone after
                       WhseShipmentLine.SetRange("No.", Rec."No.");
                       WhseShipmentLine.SetRange("Source Type", Database::"Transfer Line");
                       if WhseShipmentLine.FindSet() then
                           repeat
                               if not TransOrderNos.Contains(WhseShipmentLine."Source No.") then
                                   TransOrderNos.Add(WhseShipmentLine."Source No.");
                           until WhseShipmentLine.Next() = 0;

                       // Post the shipment
                       WhsePostShipment.SetPostingSettings(true);
                       WhsePostShipment.Run(Rec);
                       CurrPage.Update(false);

                       if TransOrderNos.IsEmpty() then
                           exit;

                       if not Confirm('The shipment has been posted.\Do you want to create a Warehouse Receipt for the in-transit items?', true) then
                           exit;

                       foreach TransOrderNo in TransOrderNos do
                           CreateWhseReceiptFromTransferOrder(TransOrderNo);
                   end;
               }*/
        }
    }

    /* local procedure CreateWhseReceiptFromTransferOrder(TransOrderNo: Code[20])
     var
         TransHeader: Record "Transfer Header";
         TransLine: Record "Transfer Line";
         WhseReceiptHeader: Record "Warehouse Receipt Header";
         WhseReceiptLine: Record "Warehouse Receipt Line";
         LineNo: Integer;
     begin
         if not TransHeader.Get(TransOrderNo) then
             exit;

         TransLine.SetRange("Document No.", TransOrderNo);
         TransLine.SetFilter("Qty. in Transit", '>0');
         if not TransLine.FindSet() then
             exit;

         WhseReceiptHeader.Init();
         WhseReceiptHeader.Validate("Location Code", TransHeader."Transfer-to Code");
         WhseReceiptHeader.Insert(true);

         LineNo := 10000;
         repeat
             WhseReceiptLine.Init();
             WhseReceiptLine."No." := WhseReceiptHeader."No.";
             WhseReceiptLine."Line No." := LineNo;
             LineNo += 10000;
             WhseReceiptLine."Source Type" := Database::"Transfer Line";
             WhseReceiptLine."Source Subtype" := 1;
             WhseReceiptLine."Source No." := TransOrderNo;
             WhseReceiptLine."Source Line No." := TransLine."Line No.";
             WhseReceiptLine."Location Code" := TransHeader."Transfer-to Code";
             WhseReceiptLine.Validate("Item No.", TransLine."Item No.");
             WhseReceiptLine.Validate("Variant Code", TransLine."Variant Code");
             WhseReceiptLine.Validate("Unit of Measure Code", TransLine."Unit of Measure Code");
             WhseReceiptLine.Validate(Quantity, TransLine."Qty. in Transit");
             WhseReceiptLine.Insert(true);
         until TransLine.Next() = 0;

         Page.Run(Page::"Warehouse Receipt", WhseReceiptHeader);
     end;*/

    var
        myInt: Integer;
}