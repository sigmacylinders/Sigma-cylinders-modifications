pageextension 76139 PostedPurchaseReceiptExt extends "Posted Purchase Receipts"
{
    layout
    {
        addafter("Location Code")
        {
            field("Creation Date"; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                Editable = false;

            }
        }
    }
}
