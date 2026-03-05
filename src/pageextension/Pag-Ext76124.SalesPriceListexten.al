pageextension 76124 "Sales Price List exten" extends "Sales Price List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(SuggestLines)
        {
            action("Import price list")
            {
                Image = Import;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    InStr: InStream;
                    pricelistimportmgmt: Codeunit "Price List Import Mgt.";
                begin
                    pricelistimportmgmt.ImportSalesPriceListLines2(Rec.Code)
                end;
            }
        }
    }

    var
        myInt: Integer;
}