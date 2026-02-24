tableextension 76103 "Warehouse Receipt Header ext" extends "Warehouse Receipt Header"
{
    fields
    {
        // Add changes to table fields here


        field(76100; "Source Document"; Enum "Warehouse Activity Source Document")
        {
            Caption = 'Source Document';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Receipt Line"."Source Document" where("No." = field("No.")));
        }
        field(76101; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Receipt Line"."Source No." where("No." = field("No.")));
        }
        field(76102; "Parent Transfer Order #"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(76103; "Vendor Name"; text[100])
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            Enabled = true;
            Editable = true;
            CalcFormula = lookup("Purchase Header"."Buy-from Vendor Name" where("No." = field("Source No."), "Document Type" = const(Order)));
        }
        field(76104; "Vendor Invoice No."; code[35])
        {
            FieldClass = FlowField;
            Enabled = true;
            Editable = true;
            CalcFormula = lookup("Purchase Header"."Vendor Invoice No." where("No." = field("Source No."), "Document Type" = const(Order)));
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