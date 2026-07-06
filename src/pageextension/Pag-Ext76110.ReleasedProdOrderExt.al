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
        addafter("Source No.")
        {
            field("Item No. 2"; Rec."Item No. 2")
            {
                ApplicationArea = All;
                Caption = 'Item No. 2';
                ToolTip = 'Shows the Item No. 2 (Item."No. 2") for this production order.';
            }
            field("Item Engineering Code"; Rec."Item Engineering Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Engineering Code field.', Comment = '%';
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
                    Sigma_Modif_Func: Codeunit "Sigma Modif. Func and Subs";
                begin
                    Sigma_Modif_Func.CreateParentTransferorder(Rec);
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
