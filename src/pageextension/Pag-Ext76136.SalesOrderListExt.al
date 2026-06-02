pageextension 76136 SalesOrderListExt extends "Sales Order List"
{
    layout
    {
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


    trigger OnAfterGetRecord()
    var
    begin
        IF user.Get(Rec.SystemCreatedBy) then begin
            UserName := User."User Name";
        end;
    end;

    var
        User: Record User;
        UserName: Code[20];
}
