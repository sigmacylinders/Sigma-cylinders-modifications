report 76100 "Sales Customer Ledger Entries"
{
    Caption = 'Sales Customer Ledger Entries';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src\report\SalesCustLedgerEntries.rdl';

    dataset
    {
        dataitem(CustLedgEntry; "Cust. Ledger Entry")
        {
            // Sales-type documents only. Add "Finance Charge Memo"|Reminder here if you want them included.
            DataItemTableView = where("Document Type" = filter(Invoice | "Credit Memo"));
            RequestFilterFields = "Posting Date", "Customer No.", "Salesperson Code", "Currency Code";

            column(CompanyName; CompanyProperty.DisplayName()) { }
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(ReportFilters; FilterText) { }
            column(EntryNo; "Entry No.") { }
            column(PostingDate; "Posting Date") { }
            column(DocumentType; "Document Type") { }
            column(DocumentNo; "Document No.") { }
            column(ExternalDocNo; "External Document No.") { }
            column(CustomerNo; "Customer No.") { }
            column(CustomerName; CustomerName) { }
            column(Description; Description) { }
            column(CurrencyCode; CurrencyCodeText) { }
            column(SalespersonCode; "Salesperson Code") { }
            column(DueDate; "Due Date") { }
            column(SalesLCY; "Sales (LCY)") { }     // net sales value in LCY (credit memos are negative)
            column(AmountLCY; AmountLCY) { }          // posted entry amount (LCY)
            column(RemainingAmtLCY; RemainingAmtLCY) { } // open balance (LCY)
            column(picture; CompanyInfo.Picture) { }

            trigger OnAfterGetRecord()
            begin
                if Customer.Get("Customer No.") then
                    CustomerName := Customer.Name
                else
                    CustomerName := '';

                CalcFields("Amount (LCY)", "Remaining Amt. (LCY)");
                AmountLCY := "Amount (LCY)";
                RemainingAmtLCY := "Remaining Amt. (LCY)";

                if "Currency Code" = '' then
                    CurrencyCodeText := LCYCodeTxt
                else
                    CurrencyCodeText := "Currency Code";
            end;

            trigger OnPreDataItem()
            begin
                if CompanyInfo.Get() then;
                CompanyInfo.CalcFields(Picture);
                FilterText := GetFilters();
            end;
        }
    }


    labels
    {
        ReportTitleLbl = 'Sales Customer Ledger Entries';
        PostingDateLbl = 'Posting Date';
        DocTypeLbl = 'Document Type';
        DocNoLbl = 'Document No.';
        CustomerLbl = 'Customer';
        DescriptionLbl = 'Description';
        CurrencyLbl = 'Currency';
        SalesLbl = 'Sales (LCY)';
        AmountLbl = 'Amount (LCY)';
        RemainingLbl = 'Remaining (LCY)';
        TotalLbl = 'Total';
    }

    var
        Customer: Record Customer;
        CompanyInfo: Record "Company Information";
        CustomerName: Text[100];
        CurrencyCodeText: Code[10];
        AmountLCY: Decimal;
        RemainingAmtLCY: Decimal;
        FilterText: Text;
        LCYCodeTxt: Label 'LCY', Locked = true;
}
