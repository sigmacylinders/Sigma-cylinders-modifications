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
        field(76102; "Parent Transfer Order #"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(76103; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Sell-to Customer Name" where("No." = field("Source No."), "Document Type" = const(Order)));
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