page 76103 "Parent Transfer Order Card"
{
    PageType = Card;
    SourceTable = "Parent Transfer Order";
    Caption = 'Parent Transfer Order';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Parent Transfer Order #"; Rec."Parent Transfer Order #")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the LOB field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Branch field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Dept field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the SubDept field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Employee Dimension Code"; Rec."Employee Dimension Code")
                {
                    ToolTip = 'Specifies the value of the Employee field.', Comment = '%';
                    ApplicationArea = All;
                }
            }

            part(Lines; "Parent Transfer Order Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Parent Transfer Order #" = field("Parent Transfer Order #");

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreateTransferOrdersAction)
            {
                Caption = 'Create Transfer Orders';
                Image = TransferOrder;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    // Call your procedure for the current parent transfer order
                    CreateTransferOrders(Rec."Parent Transfer Order #");

                    Message('Transfer Orders created successfully for %1.', Rec."Parent Transfer Order #");
                end;
            }
        }
    }

    procedure CreateTransferOrders(ParentTransferOrderNo: Code[20])
    var
        PTOLine: Record "Parent Transfer Order Line";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit "No. Series";
        LastFromLoc: Code[10];
        LastToLoc: Code[10];
        LastDueDate: Date;
        TransferOrderNo: Code[20];
        LineNo: Integer;
        TransferHeaderFind: Record "Transfer Header";
    begin
        InventorySetup.Get();
        InventorySetup.TestField("Transfer Order Nos.");

        PTOLine.SetRange("Parent Transfer Order #", ParentTransferOrderNo);
        PTOLine.SetRange("Fully Processed", false);
        PTOLine.SetRange(Select, true);

        if not PTOLine.FindSet() then
            exit;


        IF PTOLine.FindFirst() then
            repeat
                PTOLine.TestField("Transfer From Location");
                PTOLine.TestField("Transfer From Location");
                PTOLine.TestField(Date);
                // 🔁 New combination → new Transfer Header
                Clear(TransferHeaderFind);
                TransferHeaderFind.SetRange("Parent Transfer Order #", Rec."Parent Transfer Order #");
                TransferHeaderFind.SetRange("Transfer-from Code", PTOLine."Transfer From Location");
                TransferHeaderFind.SetRange("Transfer-to Code", PTOLine."Transfer To");
                TransferHeaderFind.SetRange("Posting Date", PTOLine.Date);
                TransferHeaderFind.SetRange(Status, TransferHeaderFind.Status::Open);
                if NOT TransferHeaderFind.FindFirst() then begin

                    TransferHeader.Init();
                    TransferOrderNo :=
                               NoSeriesMgt.GetNextNo(
                                   InventorySetup."Transfer Order Nos.",
                                   WorkDate(),
                                   true
                               );
                    TransferHeader."No." := TransferOrderNo;
                    TransferHeader."Parent Transfer Order #" := Rec."Parent Transfer Order #";
                    TransferHeader."Transfer-from Code" := PTOLine."Transfer From Location";
                    TransferHeader."Transfer-to Code" := PTOLine."Transfer To";
                    TransferHeader."In-Transit Code" := 'WH-TR-001';
                    TransferHeader."Posting Date" := PTOLine.Date;
                    TransferHeader."Production Order No." := PTOLine."MO #";
                    TransferHeader."Production Order Status" := "Production Order Status"::Released;



                    TransferHeader.Insert(true);

                    // Reset for new header
                    LineNo := 10000;


                end else begin
                    TransferOrderNo := TransferHeaderFind."No.";
                    LineNo := GetLastTOlineNumber(TransferOrderNo);
                end;

                // ➕ Create Transfer Line
                TransferLine.Init();
                TransferLine."Document No." := TransferOrderNo;
                TransferLine."Line No." := LineNo;
                TransferLine.Validate("Item No.", PTOLine."Item No.");
                TransferLine.Validate(Quantity, PTOLine."Qty to Be Transferred" + PTOLine."Over Qty");
                TransferLine."Parent Transfer Order #" := PTOLine."Parent Transfer Order #";
                TransferLine."Parent Transfer Order line #" := PTOLine."Line No.";
                TransferLine.ValidateShortcutDimCode(1, PTOLine."Shortcut Dimension 1 Code");
                TransferLine.ValidateShortcutDimCode(2, PTOLine."Shortcut Dimension 2 Code");
                TransferLine.ValidateShortcutDimCode(3, PTOLine."Shortcut Dimension 3 Code");
                TransferLine.ValidateShortcutDimCode(4, PTOLine."Shortcut Dimension 4 Code");
                TransferLine.Insert(true);

                // ✅ Mark Parent Line as Processed
                PTOLine."Qty Transferred" := PTOLine."Qty Transferred" + PTOLine."Qty to Be Transferred";
                IF PTOLine."Qty Transferred" < PTOLine."MO Qty" then begin

                    PTOLine."partially Processed" := true;



                    PTOLine."Remaining Quantity" := PTOLine."MO Qty" - PTOLine."Qty Transferred";

                    PTOLine."Qty to Be Transferred" := PTOLine."MO Qty" - PTOLine."Qty Transferred";
                    ;
                    PTOLine.Modify();
                end else begin
                    PTOLine."Qty to Be Transferred" := 0;
                    PTOLine."Fully Processed" := true;
                    PTOLine."Remaining Quantity" := 0;
                    PTOLine.Modify();
                end;


                LineNo += 10000;

            until PTOLine.Next() = 0;

        Page.Run(Page::"Transfer Orders");
    end;

    procedure GetLastTOlineNumber(TOnumber: code[50]): Integer
    var
        transferLine: Record "Transfer Line";
    begin
        Clear(transferLine);
        transferLine.SetRange("Document No.", TOnumber);
        IF transferLine.FindLast() then
            exit(transferLine."Line No.");

        exit(0);
    end;

}