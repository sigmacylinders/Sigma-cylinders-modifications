page 76101 "SIGMA Lookup - V3"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SIGMA Lookup - V3";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
        }
    }
}