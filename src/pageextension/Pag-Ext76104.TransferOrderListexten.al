pageextension 76104 "Transfer Order List exten" extends "Transfer Orders"
{
    layout
    {
        // Add changes to page layout here
        addafter("Transfer-to Code")
        {
            field("Parent Transfer Order #"; Rec."Parent Transfer Order #")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Parent Transfer Order # field.', Comment = '%';
            }
        }
        addafter("No.")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the posting date of the transfer order.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here

        addafter("Create &Whse. Receipt")
        {
            action("Create Whse. S&hipment(Selection)")
            {
                AccessByPermission = TableData "Warehouse Shipment Header" = R;
                ApplicationArea = Warehouse;
                Caption = 'Create Whse. S&hipment(Selection)';
                Image = NewShipment;
                ToolTip = 'Create a warehouse shipment to start a pick a ship process according to an advanced warehouse configuration.';

                trigger OnAction()
                var
                    TransferHeader: Record "Transfer Header";
                    ReleaseTransferDoc: Codeunit "Release Transfer Document";
                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                begin


                    CurrPage.SetSelectionFilter(TransferHeader);
                    //    Message(Format(TransferHeader.Count));
                    if TransferHeader.FindSet() then
                        repeat
                            IF TransferHeader.Status <> TransferHeader.Status::Released then
                                ReleaseTransferDoc.Run(TransferHeader);

                            GetSourceDocOutbound.CreateFromOutbndTransferOrder(TransferHeader);

                        until TransferHeader.Next() = 0;

                end;
            }
            action("Create &Whse. Receipt(Selection)")
            {
                AccessByPermission = TableData "Warehouse Receipt Header" = R;
                ApplicationArea = Warehouse;
                Caption = 'Create &Whse. Receipt(Selection)';
                Image = NewReceipt;
                ToolTip = 'Create a warehouse receipt to start a receive and put-away process according to an advanced warehouse configuration.';

                trigger OnAction()
                var
                    TransferHeader: Record "Transfer Header";
                    ReleaseTransferDoc: Codeunit "Release Transfer Document";
                    GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                begin


                    CurrPage.SetSelectionFilter(TransferHeader);
                    //  Message(Format(TransferHeader.Count));
                    if TransferHeader.FindSet() then
                        repeat
                            IF TransferHeader.Status <> TransferHeader.Status::Released then
                                ReleaseTransferDoc.Run(TransferHeader);

                            GetSourceDocInbound.CreateFromInbndTransferOrder(TransferHeader);

                        until TransferHeader.Next() = 0;

                end;
            }

        }

    }


    var
        myInt: Integer;
}