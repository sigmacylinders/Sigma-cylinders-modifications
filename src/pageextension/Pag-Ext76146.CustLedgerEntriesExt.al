pageextension 76146 "Cust. Ledger Entries Ext." extends "Customer Ledger Entries"
{
    actions
    {
        addlast(reporting)
        {
            action("Sales Customer Ledger Entries")
            {
                ApplicationArea = All;
                Caption = 'Sales Customer Ledger Entries';
                Image = Report;
                ToolTip = 'Run the Sales Customer Ledger Entries report.';

                trigger OnAction()
                var
                    SalesCustLedgReport: Report "Sales Customer Ledger Entries";
                begin
                    SalesCustLedgReport.SetTableView(Rec);
                    SalesCustLedgReport.Run();
                end;
            }
        }
    }
}
