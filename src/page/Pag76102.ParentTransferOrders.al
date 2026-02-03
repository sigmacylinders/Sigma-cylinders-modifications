page 76102 "Parent Transfer Orders"
{
    PageType = List;
    SourceTable = "Parent Transfer Order";
    Caption = 'Parent Transfer Orders';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Parent Transfer Order #"; Rec."Parent Transfer Order #")
                {
                    ApplicationArea = All;
                }

                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }

                field("Created By"; Rec."Created By")
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
            action(OpenCard)
            {
                Caption = 'Open';
                Image = EditLines;
                ApplicationArea = All;
                RunObject = page "Parent Transfer Order Card";
                RunPageLink = "Parent Transfer Order #" = field("Parent Transfer Order #");
            }
        }
    }
}
