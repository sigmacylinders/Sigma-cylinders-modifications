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


        addafter(Description)
        {
            field(Classification; Rec.Classification)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the procurement and usage classification of the item: Active, New, Preferred, Restricted, Phased Out, Obsolete, Inactive, or Archived.';
            }
            field("Sort Code"; Rec."Sort Code")
            {
                ApplicationArea = All;
            }
            field("Engineering Code"; Rec."Engineering Code")
            {
                ApplicationArea = All;
            }
            field("Cylinder Category"; Rec."Cylinder Category")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the cylinder category of the item.';
            }
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