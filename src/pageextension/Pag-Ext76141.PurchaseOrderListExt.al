pageextension 76141 "Purchase Order List Ext" extends "Purchase Order List"
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
        IF User.Get(Rec.SystemCreatedBy) then begin
            UserName := User."User Name";
        end;
    end;

    var
        User: Record User;
        UserName: Code[20];
}
