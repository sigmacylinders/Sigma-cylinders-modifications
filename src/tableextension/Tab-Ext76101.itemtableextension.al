tableextension 76101 "item table extension" extends item
{
    fields
    {
        field(76105; Classification; Enum "Item Classification")
        {
            Caption = 'Classification';
            DataClassification = CustomerContent;
        }
        field(76106; "Sort Code"; Integer)
        {
            Caption = 'Sort Code';
            DataClassification = CustomerContent;
        }

        // Add changes to table fields here
        modify("No. 2")
        {
            trigger OnAfterValidate()
            var

            begin
                CheckDuplicateNo2();
            end;
        }
        field(76107; "Engineering Code"; Code[100])
        {
            Caption = 'Engineering Code';
            DataClassification = CustomerContent;
        }
        field(76108; "Cylinder Category"; Code[50])
        {
            Caption = 'Cylinder Category';
            DataClassification = CustomerContent;
            TableRelation = "SIGMA Lookup - V3".Code
                WHERE(Type = CONST("Cylinder Category"));
        }


    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
        addlast(DropDown; "No. 2", "Engineering Code") { }
        addlast(Brick; "No. 2", "Engineering Code") { }


    }

    local procedure CheckDuplicateNo2()
    var
        ItemRec: Record Item;
    begin
        if "No. 2" = '' then
            exit;

        ItemRec.Reset();
        ItemRec.SetRange("No. 2", Rec."No. 2");
        ItemRec.SetFilter("No.", '<>%1', Rec."No."); // Exclude current item

        if ItemRec.FindFirst() then
            Error(
              'The value %1 in field No. 2 already exists for Item %2.',
              "No. 2",
              ItemRec."No."
            );
    end;

    local procedure CheckDuplicateEngineeringCode()
    var
        ItemRec: Record Item;
    begin
        if "Engineering Code" = '' then
            exit;

        ItemRec.Reset();
        ItemRec.SetRange("Engineering Code", Rec."Engineering Code");
        ItemRec.SetFilter("No.", '<>%1', Rec."No."); // Exclude current item

        if ItemRec.FindFirst() then
            Error(
              'The value %1 in field Engineering Code already exists for Item %2.',
              "Engineering Code",
              ItemRec."No."
            );
    end;

    var
        myInt: Integer;
}