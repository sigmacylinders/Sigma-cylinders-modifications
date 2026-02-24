tableextension 76101 "item table extension" extends item
{
    fields
    {
        // Add changes to table fields here
        modify("No. 2")
        {
            trigger OnAfterValidate()
            var

            begin
                CheckDuplicateNo2();
            end;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
        addlast(DropDown; "No. 2") { }
        addlast(Brick; "No. 2") { }


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

    var
        myInt: Integer;
}