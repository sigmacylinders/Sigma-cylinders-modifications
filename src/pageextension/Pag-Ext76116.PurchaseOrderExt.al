pageextension 76116 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        modify("Buy-from Vendor No.")
        {
            ShowMandatory = true;
        }
        addafter("Buy-from Vendor Name"
       )
        {
            field("Cash Supplier Name"; Rec."Cash Supplier Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Assigned User ID")
        {
            field("Creation Date"; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Created By"; UserName)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
    begin
        IF User.Get(Rec.SystemCreatedBy) then begin
            UserName := User."User Name";
        end;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        PurchHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
        Rec.TestField("Buy-from Vendor No.");

        Clear(PurchaseLine);
        PurchaseLine.SetRange("Document Type", Rec."Document Type");
        PurchaseLine.SetRange("Document No.", Rec."No.");
        PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
        if PurchaseLine.FindSet() then
            repeat
                PurchaseLine.TestField("Location Code");
            until PurchaseLine.Next() = 0;



    end;

    var
        User: Record User;
        UserName: Code[20];
}
