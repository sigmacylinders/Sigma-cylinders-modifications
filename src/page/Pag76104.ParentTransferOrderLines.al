page 76104 "Parent Transfer Order Lines"
{
    PageType = ListPart;
    SourceTable = "Parent Transfer Order Line";
    Caption = 'Lines';
    ApplicationArea = All;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Production order Description"; Rec."Production order Description")
                {
                    ToolTip = 'Specifies the value of the Production order Description field.', Comment = '%';
                }
                field("Parent Transfer Order #"; Rec."Parent Transfer Order #")
                {
                    Editable = false;
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

                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Line No. field.', Comment = '%';
                }
                field("Prod. Order Component Line No."; Rec."Prod. Order Component Line No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Component Line No. field.', Comment = '%';
                }
                field(BOM; Rec.BOM)
                {
                    ToolTip = 'Specifies the value of the BOM field.', Comment = '%';
                }
                field(Week; Rec.Week)
                {
                    ToolTip = 'Specifies the value of the Week field.', Comment = '%';
                }
                field("Arabic Description"; Rec."Arabic Description")
                {
                    ToolTip = 'Specifies the value of the Description Arabic field.', Comment = '%';
                }

                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item No.2"; Rec."Item No.2")
                {
                    ToolTip = 'Specifies the value of the Item No.2 field.', Comment = '%';
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

                field("Production order Qty"; Rec."Production order Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Qty to Be Transferred"; Rec."Qty to Be Transferred")
                {
                    ApplicationArea = All;
                }
                field("Qty Transferred"; Rec."Qty Transferred")
                {
                    ToolTip = 'Specifies the value of the Qty Transferred field.', Comment = '%';
                    Editable = false;
                }

                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Over Qty"; Rec."Over Qty")
                {
                    ToolTip = 'Specifies the value of the Over Qty field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
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
                    Enabled = false;
                }
                field("Partially Processed"; Rec."Partially Processed")
                {
                    ToolTip = 'Specifies the value of the Processed field.', Comment = '%';
                    Enabled = false;
                }
            }
        }
    }
}
