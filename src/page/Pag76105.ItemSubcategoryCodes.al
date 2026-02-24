page 76105 "Item Subcategory Codes"
{
    PageType = List;
    SourceTable = "Item Subcategory Code";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Item Subcategory Codes';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                }

                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }

                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }

                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}
