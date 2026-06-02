tableextension 76120 "Sales Line Ext" extends "Sales Line"
{
    fields
    {
        field(76100; "No. 2"; Code[20])
        {
            Caption = 'No. 2';
            Editable = false;
            // FlowField to pull a numeric field from Item table
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."No. 2" where("No." = FIELD("No.")));
        }
        field(76101; "Warehouse shipment Qty to Ship"; Decimal)//platinum
        {
            //      DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Shipment Line"."Qty. to Ship" where("Source Document" = const("Sales Order"), "Source No." = field("Document No."), "Source Line No." = field("Line No.")));
        }
        field(76102; "Warehouse shipment Qty Shipped"; Decimal)//platinum
        {
            //      DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Shipment Line"."Qty. Shipped" where("Source Document" = const("Sales Order"), "Source No." = field("Document No."), "Source Line No." = field("Line No.")));
        }
    }
}