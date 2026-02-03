page 76103 "Parent Transfer Order Card"
{
    PageType = Card;
    SourceTable = "Parent Transfer Order";
    Caption = 'Parent Transfer Order';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Parent Transfer Order #"; Rec."Parent Transfer Order #")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            part(Lines; "Parent Transfer Order Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Parent Transfer Order #" = field("Parent Transfer Order #");
            }
        }
    }
}