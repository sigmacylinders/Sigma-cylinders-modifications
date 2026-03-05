tableextension 76122 "WhseShptLine ItemNo2 Ext" extends "Warehouse Shipment Line"
{
    fields
    {
        field(76100; "Item No. 2"; Code[20])
        {
            Caption = 'Item No. 2';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."No. 2" where("No." = field("Item No.")));
        }
    }
}
