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

    var
        WeekNo: Integer;

    trigger OnAfterGetRecord()
    begin
        IF Rec."Week No." = '' then
            if Rec.SystemCreatedAt <> 0DT then
                Rec."Week No." := 'WEEK ' + format(Date2DWY(DT2Date(Rec.SystemCreatedAt), 2));
    end;
}
