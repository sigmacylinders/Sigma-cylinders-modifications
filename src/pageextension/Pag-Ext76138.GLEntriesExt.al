pageextension 76138 GLEntriesExt extends "General Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("Foreign Service"; Rec."Foreign Service")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies if this entry is related to a foreign service.';
            }
        }
    }
}
