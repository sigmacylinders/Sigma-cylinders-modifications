tableextension 76113 "purchase receipt lines ex" extends "Purch. Rcpt. Line"
{
    fields
    {
        // Add changes to table fields here
        field(76100; "Buy-from Vendor Name"; Text[100])
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Header"."Buy-from Vendor Name" where("No." = field("Order No.")));
        }
        field(76101; "Vendor Invoice No."; Code[35])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Header"."Vendor Invoice No." where("No." = field("Order No.")));
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