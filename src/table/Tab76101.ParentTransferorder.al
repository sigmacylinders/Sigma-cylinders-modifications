table 76101 "Parent Transfer order"
{
    Caption = 'Parent Transfer Order';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Parent Transfer Order #"; Code[20])
        {
            Caption = 'Parent Transfer Order #';
            DataClassification = CustomerContent;
        }

        field(2; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = SystemMetadata;
        }

        field(3; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = SystemMetadata;
            //   TableRelation = User."Full Name";
        }
        field(4; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = SystemMetadata;
        }
        field(5; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'LOB';
            ToolTip = 'Specifies the code for LOB (Shortcut Dimension 1).';
            TableRelation = "Dimension Value".Code
        where(
            "Global Dimension No." = const(1),
            Blocked = const(false)
        );

            trigger OnValidate()
            begin

                Validatedimensiononthelines(1, Rec."Shortcut Dimension 1 Code");
            end;
        }

        field(6; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Branch';
            ToolTip = 'Specifies the code for Branch (Shortcut Dimension 2).';
            TableRelation = "Dimension Value".Code
        where(
            "Global Dimension No." = const(2),
            Blocked = const(false)
        );

            trigger OnValidate()
            begin
                Validatedimensiononthelines(2, "Shortcut Dimension 2 Code");
            end;
        }

        field(7; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Dept';
            ToolTip = 'Specifies the code for Dept (Shortcut Dimension 3).';
            TableRelation = "Dimension Value".Code
        where(
            "Dimension Code" = const('DEPT'),
            Blocked = const(false)
        );

            trigger OnValidate()
            begin
                Validatedimensiononthelines(3, "Shortcut Dimension 3 Code");
            end;
        }

        field(8; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'SubDept';
            ToolTip = 'Specifies the code for SubDept (Shortcut Dimension 4).';
            TableRelation = "Dimension Value".Code
        where(
            "Dimension Code" = const('SUBDEPT'),
            Blocked = const(false)
        );

            trigger OnValidate()
            begin
                Validatedimensiononthelines(4, "Shortcut Dimension 4 Code");
            end;
        }


        field(9; "Employee Dimension Code"; Code[20])
        {
            Caption = 'Employee';
            TableRelation = "Dimension Value".Code
        where("Dimension Code" = const('EMPLOYEE'));
            DataClassification = CustomerContent;
        }

        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";


            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
    }

    keys
    {
        key(PK; "Parent Transfer Order #")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var


        NoSeries: Codeunit "No. Series";
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        GLSetup: Record "General Ledger Setup";
        // NoSeriesManagement: Codeunit NoSeriesManagement; // Removed as per deprecation notice
        "No. Series": Codeunit "No. Series";
    begin
        if "Parent Transfer Order #" = '' then begin
            GLSetup.Get();
            GLSetup.TestField("Parent TO No. Series");
            if NoSeries.AreRelated(GLSetup."Parent TO No. Series", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series"
            else
                Rec."No. Series" := GLSetup."Parent TO No. Series";

            Rec."Parent Transfer Order #" := NoSeries.GetNextNo(Rec."No. Series");

            //   end;
        end;

        "Creation Date" := Today;
        "Created By" := UserId;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode, IsHandled);
        if IsHandled then
            exit;

        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if Rec."Parent Transfer Order #" <> '' then
            Modify();

        if OldDimSetID <> "Dimension Set ID" then begin
            //  OnValidateShortcutDimCodeOnBeforeUpdateAllLineDim(Rec, xRec, FieldNumber);
            if not IsNullGuid(Rec.SystemId) then
                Modify();
            if ParentTransferLinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;

        // OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
    end;




    procedure ParentTransferLinesExist(): Boolean
    var
        IsHandled: Boolean;
        Result: Boolean;
    begin
        IsHandled := false;
        // OnBeforeSalesLinesExist(Rec, IsHandled, Result);
        if IsHandled then
            exit(Result);

        ParentTransferLine.Reset();

        ParentTransferLine.SetRange("Parent Transfer Order #", Rec."Parent Transfer Order #");
        exit(not ParentTransferLine.IsEmpty());
    end;

    procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        ATOLink: Record "Assemble-to-Order Link";
        xParentTransferLine: Record "Parent Transfer Order Line";
        NewDimSetID: Integer;
        ShippedReceivedItemLineDimChangeConfirmed: Boolean;
        IsHandled: Boolean;
    begin
        IsHandled := false;

        if IsHandled then
            exit;

        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not GetHideValidationDialog() and GuiAllowed then
            if not ConfirmUpdateAllLineDim(NewParentDimSetID, OldParentDimSetID) then
                exit;

        ParentTransferLine.Reset();

        ParentTransferLine.SetRange("Parent Transfer Order #", Rec."Parent Transfer Order #");
        ParentTransferLine.LockTable();
        if ParentTransferLine.Find('-') then
            repeat

                NewDimSetID := DimMgt.GetDeltaDimSetID(ParentTransferLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);

                if ParentTransferLine."Dimension Set ID" <> NewDimSetID then begin
                    xParentTransferLine := ParentTransferLine;
                    ParentTransferLine."Dimension Set ID" := NewDimSetID;



                    DimMgt.UpdateGlobalDimFromDimSetID(
                      ParentTransferLine."Dimension Set ID", ParentTransferLine."Shortcut Dimension 1 Code", ParentTransferLine."Shortcut Dimension 2 Code");


                    ParentTransferLine.Modify();

                end;
            until ParentTransferLine.Next() = 0;
    end;

    procedure GetHideValidationDialog(): Boolean
    begin
        exit(HideValidationDialog);
    end;

    local procedure ConfirmUpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer) Confirmed: Boolean;
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeConfirmUpdateAllLineDim(Rec, xRec, NewParentDimSetID, OldParentDimSetID, Confirmed, IsHandled);
        if not IsHandled then
            Confirmed := Confirm(Text064);
    end;

    local procedure Validatedimensiononthelines(Dimensionnumber: Integer; dimensionvaluecode: code[50])
    var
        Parenttransferlines: Record "Parent Transfer Order Line";
    begin
        Clear(Parenttransferlines);
        Parenttransferlines.SetRange("Parent Transfer Order #", Rec."Parent Transfer Order #");
        case DimensionNumber of
            1:
                begin
                    // Logic for Dimension 1
                    Parenttransferlines.ModifyAll("Shortcut Dimension 1 Code", dimensionvaluecode);
                end;
            2:
                begin
                    // Logic for Dimension 2
                    Parenttransferlines.ModifyAll("Shortcut Dimension 2 Code", dimensionvaluecode);
                end;
            3:
                begin
                    // Logic for Dimension 3
                    Parenttransferlines.ModifyAll("Shortcut Dimension 3 Code", dimensionvaluecode);
                end;
            4:
                begin
                    // Logic for Dimension 4
                    Parenttransferlines.ModifyAll("Shortcut Dimension 4 Code", dimensionvaluecode);
                end;
            5:
                begin
                    // Logic for Dimension 5
                end;
            6:
                begin
                    // Logic for Dimension 6
                end;
            7:
                begin
                    // Logic for Dimension 7
                end;
            8:
                begin
                    // Logic for Dimension 8
                end;
            else
                Error('Invalid Dimension Number: %1', DimensionNumber);
        end;

    end;

    var
        DimMgt: Codeunit DimensionManagement;
        ParentTransferLine: Record "Parent Transfer Order Line";
        Text064: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        HideValidationDialog: Boolean;


}
