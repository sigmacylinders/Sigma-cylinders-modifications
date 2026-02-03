page 76104 "Parent Transfer Order Lines"
{
    PageType = ListPart;
    SourceTable = "Parent Transfer Order Line";
    Caption = 'Lines';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("MO Description"; Rec."MO Description")
                {
                    ToolTip = 'Specifies the value of the MO Description field.', Comment = '%';
                }
                field("Parent Transfer Order #"; Rec."Parent Transfer Order #")
                {
                    ToolTip = 'Specifies the value of the Parent Transfer Order # field.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }

                field("MO #"; Rec."MO #")
                {
                    ApplicationArea = All;
                }
                field(BOM; Rec.BOM)
                {
                    ToolTip = 'Specifies the value of the BOM field.', Comment = '%';
                }
                field(Week; Rec.Week)
                {
                    ToolTip = 'Specifies the value of the Week field.', Comment = '%';
                }
                field("Description Arabic"; Rec."Description Arabic")
                {
                    ToolTip = 'Specifies the value of the Description Arabic field.', Comment = '%';
                }

                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.', Comment = '%';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }

                field("MO Qty"; Rec."MO Qty")
                {
                    ApplicationArea = All;
                }

                field("Qty to Be Transferred"; Rec."Qty to Be Transferred")
                {
                    ApplicationArea = All;
                }

                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                }
                field("Over Qty"; Rec."Over Qty")
                {
                    ToolTip = 'Specifies the value of the Over Qty field.', Comment = '%';
                }

                field("Transfer From Location"; Rec."Transfer From Location")
                {
                    ToolTip = 'Specifies the value of the Transfer From Location field.', Comment = '%';
                }
                field("Transfer To"; Rec."Transfer To")
                {
                    ToolTip = 'Specifies the value of the Transfer To field.', Comment = '%';
                }

                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }

                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }

                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }

                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
                field("Employee Dimension Code"; Rec."Employee Dimension Code")
                {
                    ToolTip = 'Specifies the value of the Employee field.', Comment = '%';
                }

                field("Fully Processed"; Rec."Fully Processed")
                {
                    ApplicationArea = All;
                }
                field("Partially Processed"; Rec."Partially Processed")
                {
                    ToolTip = 'Specifies the value of the Processed field.', Comment = '%';
                }
            }
        }
    }
}
