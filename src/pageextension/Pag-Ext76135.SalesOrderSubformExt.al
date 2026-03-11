pageextension 76135 "Sales Order Subform Ext." extends "Sales Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            /* field("Item Availability"; SalesInfoPaneMgt.CalcAvailability(Rec))
             {
                 ApplicationArea = Basic, Suite;
                 Caption = 'Item Availability';
                 DecimalPlaces = 0 : 5;
                 DrillDown = true;
                 ToolTip = 'Specifies how may units of the item on the sales line are available, in inventory or incoming before the shipment date.';

                 trigger OnDrillDown()
                 begin
 #if not CLEAN25
                     ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, "Item Availability Type"::"Event".AsInteger());
 #else
                         SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::"Event");
 #endif
                     CurrPage.Update(true);
                 end;
             }*/
            field("Available Inventory"; SalesInfoPaneMgt.CalcAvailableInventory(Rec))
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Available Inventory';
                DecimalPlaces = 0 : 5;
                ToolTip = 'Specifies the quantity of the item that is currently in inventory and not reserved for other demand.';
            }
        }
    }

    var
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
#if not CLEAN25
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
#else
        SalesAvailabilityMgt: Codeunit "Sales Availability Mgt.";
#endif
}
