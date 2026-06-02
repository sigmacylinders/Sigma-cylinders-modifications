pageextension 76117 "Sales Order Subform Ext" extends "Sales Order Subform"
{
    layout
    {
        modify("Location Code")
        {
            ShowMandatory = true;
        }
        addafter(Quantity)
        {
            field("Warehouse shipment Qty to Ship"; Rec."Warehouse shipment Qty to Ship")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Warehouse shipment Qty to Ship field.', Comment = '%';
                Editable = false;
            }
            field("Warehouse shipment Qty Shipped"; Rec."Warehouse shipment Qty Shipped")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Warehouse shipment Qty Shipped field.', Comment = '%';
                Editable = false;
            }
        }
    }


}
