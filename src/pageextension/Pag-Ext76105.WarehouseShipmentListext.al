pageextension 76105 "Warehouse Shipment List ext" extends "Warehouse Shipment List"
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

    /*  actions
      {
          // Add changes to page actions here
          modify("Post Shipment")
          {
              trigger onafteraction()
              var
                  GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                  TransferOrderHeader: Record "Transfer Header";
                  ReleaseTransferDoc: Codeunit "Release Transfer Document";
                  WhseShipHeader: Record "Warehouse Shipment Header";
              begin
                  //message('Warehouse Shipment %1 has been posted. You can subscribe to this event to perform additional actions after posting a warehouse shipment.', WarehouseShipmentHeader."No.");
                  WhseShipHeader.Get(Rec."No.");
                  WhseShipHeader.CalcFields("Source Document", "Source No.");
                  Message('Source Document: %1, Source No.: %2',
                      Format(WhseShipHeader."Source Document"),
                      WhseShipHeader."Source No.");
                  /* if Rec."Source Document" <> Rec."Source Document"::"Outbound Transfer" then begin
                       exit;

                       if not Confirm('The shipment has been posted.\Do you want to create a Warehouse Receipt for the in-transit items?', true) then
                           exit;

                       clear(TransferOrderHeader);
                       IF transferOrderHeader.Get(Rec."Source No.") then begin
                           begin
                               ReleaseTransferDoc.Run(transferOrderHeader);
                               GetSourceDocInbound.CreateFromInbndTransferOrder(transferOrderHeader);
                           end;
                       end;
                   end;
              end;
          }*/




    var
        myInt: Integer;
}