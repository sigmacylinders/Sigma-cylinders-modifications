tableextension 76112 "Item Ext - Subcategories" extends Item
{
    fields
    {
        field(76100; "Category 2 Code"; Code[50])
        {
            Caption = 'Category 2 Code';
            TableRelation = "Item Subcategory Code".Code
                WHERE(Type = CONST("Category 2"));
        }

        field(76101; "Category 3 Code"; Code[50])
        {
            Caption = 'Category 3 Code';
            TableRelation = "Item Subcategory Code".Code
                WHERE(Type = CONST("Category 3"));
        }

        field(76102; "Category 4 Code"; Code[50])
        {
            Caption = 'Category 4 Code';
            TableRelation = "Item Subcategory Code".Code
                WHERE(Type = CONST("Category 4"));
        }

        field(76103; "Category 5 Code"; Code[50])
        {
            Caption = 'Category 5 Code';
            TableRelation = "Item Subcategory Code".Code
                WHERE(Type = CONST("Category 5"));
        }

        field(76104; "Category 6 Code"; Code[50])
        {
            Caption = 'Category 6 Code';
            TableRelation = "Item Subcategory Code".Code
                WHERE(Type = CONST("Category 6"));
        }
    }
}
