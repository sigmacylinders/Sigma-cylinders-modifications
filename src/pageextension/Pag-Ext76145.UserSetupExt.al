pageextension 76145 "User Setup Ext" extends "User Setup"
{
    layout
    {
        addafter("Service Resp. Ctr. Filter")
        {
            field("Whse. Receipt Source Document"; Rec."Whse. Receipt Source Document")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the default source document type for warehouse receipts for this user.';
            }
        }
    }
}
