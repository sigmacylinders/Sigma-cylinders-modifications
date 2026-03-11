pageextension 76101 "item card extension SCM" extends "Item card"
{
    layout
    {
        // Add changes to page layout here
        // addafter("No.")
        // {
        //     // field("No. 2"; Rec."No. 2")
        //     // {
        //     //     ApplicationArea = All;
        //     //     ToolTip = 'Specifies the alternative number of the item.';
        //     // }
        // }


        addafter("Item Category Code")
        {
            group("Item Subcategories")
            {
                field("Category 2 Code"; Rec."Category 2 Code")
                {
                    ApplicationArea = All;
                }

                field("Category 3 Code"; Rec."Category 3 Code")
                {
                    ApplicationArea = All;
                }

                field("Category 4 Code"; Rec."Category 4 Code")
                {
                    ApplicationArea = All;
                }

                field("Category 5 Code"; Rec."Category 5 Code")
                {
                    ApplicationArea = All;
                }

                field("Category 6 Code"; Rec."Category 6 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}