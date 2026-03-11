pageextension 76134 "PurchOrderSubform Ext" extends "Purchase Order Subform"
{
    layout
    {
        // Insert the column directly after the Quantity field
        addafter(Quantity)
        {
            field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
            {
                ApplicationArea = All;
                ToolTip = 'Shows the quantity contained in one unit of measure for this purchase line.';
            }
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity (Base) field.', Comment = '%';
                Editable = false;
            }
        }
    }
}