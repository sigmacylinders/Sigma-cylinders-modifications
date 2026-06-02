pageextension 76137 GeneralJournalExt extends "General Journal"
{
    layout
    {
        addafter(Description)
        {
            field("Foreign Service"; Rec."Foreign Service")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies if this journal line is related to a foreign service.';
            }
        }
    }
}
