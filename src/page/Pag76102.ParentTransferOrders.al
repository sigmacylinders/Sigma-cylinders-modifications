page 76102 "Parent Transfer Orders"
{
    PageType = List;
    SourceTable = "Parent Transfer Order";
    Caption = 'Parent Transfer Orders';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Parent Transfer Order Card";

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
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the LOB field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Branch field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Dept field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the SubDept field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Employee Dimension Code"; Rec."Employee Dimension Code")
                {
                    ToolTip = 'Specifies the value of the Employee field.', Comment = '%';
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
