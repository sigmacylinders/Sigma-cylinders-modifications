tableextension 76101 "item table extension" extends item
{
    fields
    {
        // Add changes to table fields here
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

    var
        myInt: Integer;
}