tableextension 76102 "Warehouse Shipment Header ext" extends "Warehouse Shipment Header"
{
    fields
    {
        // Add changes to table fields here


        field(76100; "Source Document"; Enum "Warehouse Activity Source Document")
        {
            Caption = 'Source Document';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Shipment Line"."Source Document" where("No." = field("No.")));
        }
        field(76101; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Shipment Line"."Source No." where("No." = field("No.")));
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}