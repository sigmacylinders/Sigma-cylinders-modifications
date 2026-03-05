
pageextension 76122 "Sales Order Subform Exte" extends "Sales Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
            }
        }
    }
}