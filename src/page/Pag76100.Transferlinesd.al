page 76100 "Transfer linesd"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Transfer Line";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the document number that is associated with the line or entry.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the number of the item that is transferred.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies information in addition to the description of the item being transferred.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity of the item that will be processed as the document stipulates.';
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
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}