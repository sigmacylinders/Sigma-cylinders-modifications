pageextension 76142 "Purch. Payables Setup Ext" extends "Purchases & Payables Setup"
{
    layout
    {
        addlast(content)
        {
            group("Dimension Mandatory on PO")
            {
                Caption = 'Dimension Mandatory on PO';

                field("Dimension 1 Mandatory on PO"; Rec."Dimension 1 Mandatory on PO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether Shortcut Dimension 1 is mandatory when releasing a Purchase Order.';
                }
                field("Dimension 2 Mandatory on PO"; Rec."Dimension 2 Mandatory on PO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether Shortcut Dimension 2 is mandatory when releasing a Purchase Order.';
                }
                field("Dimension 3 Mandatory on PO"; Rec."Dimension 3 Mandatory on PO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether Shortcut Dimension 3 is mandatory when releasing a Purchase Order.';
                }
                field("Dimension 4 Mandatory on PO"; Rec."Dimension 4 Mandatory on PO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether Shortcut Dimension 4 is mandatory when releasing a Purchase Order.';
                }
                field("Dimension 5 Mandatory on PO"; Rec."Dimension 5 Mandatory on PO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether Shortcut Dimension 8 is mandatory when releasing a Purchase Order.';
                }
            }
        }
    }
}
