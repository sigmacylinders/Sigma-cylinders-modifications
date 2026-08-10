tableextension 76135 "Production BOM Line exte" extends "Production BOM Line"
{
    fields
    {
        // Add changes to table fields here
        field(76100; "Item No. 2"; Code[20])
        {
            Caption = 'Item No. 2';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."No. 2" where("No." = field("No.")));
        }
        field(76101; "Item Engineering Code"; Code[100])
        {
            Caption = 'Item Engineering Code';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Engineering Code" where("No." = field("No.")));
        }
        field(76102; "Variant Code 2"; Code[50])
        {
            //      DataClassification = ToBeClassified;
            fieldclass = FlowField;
            CalcFormula = lookup("Item Variant"."Variant Code" where("Item No." = field("No."), "Code" = field("Variant Code")));
        }
        field(76103; "Scrap Tolerance"; Decimal)
        {
            Caption = 'Scrap Tolerance';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                UpdateScrapPct();
            end;
        }
        field(76104; "Work Center Scrap %"; Decimal)
        {
            Caption = 'Work Center Scrap %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                UpdateScrapPct();
            end;
        }
        field(76105; "Qty per net"; decimal)
        {
            Caption = 'Qty per net  ';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
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

    local procedure UpdateScrapPct()
    begin
        Rec.Validate("Scrap %", Rec."Scrap Tolerance" + Rec."Work Center Scrap %");
    end;
}