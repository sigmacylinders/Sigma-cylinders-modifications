pageextension 76148 "Purchase Quote Ext" extends "Purchase Quote"
{
    layout
    {
        modify("Buy-from Vendor No.")
        {
            ShowMandatory = true;
        }
        addafter("Buy-from Vendor Name")
        {
            field("Cash Supplier Name"; Rec."Cash Supplier Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Assigned User ID")
        {
            field("Creation Date"; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Created By"; UserName)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }


    actions
    {
        addfirst(Reporting)
        {
            action(Print2)
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                caption = 'Platinum Print Quote';
                trigger OnAction()

                begin
                    CurrPage.SetSelectionFilter(Rec);
                    Report.Run(Report::"Platinum Purchase Quote", true, false, Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if User.Get(Rec.SystemCreatedBy) then
            UserName := User."User Name";
    end;

    var
        User: Record User;
        UserName: Code[20];
}
