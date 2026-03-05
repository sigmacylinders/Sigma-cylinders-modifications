tableextension 76107 "Transfer Line SCM exten" extends "Transfer Line"
{
    fields
    {
        // Add changes to table fields here\

        field(76100; "Parent Transfer Order #"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(76101; "Parent Transfer Order line #"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(76102; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
        }
        field(76103; "Prod. Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(76104; "Prod. Order Component Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(76105; "Item No. 2"; Code[20])
        {
            Caption = 'Item No. 2';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."No. 2" where("No." = field("Item No.")));
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