table 76102 "Parent Transfer Order Line"
{
    Caption = 'Parent Transfer Order Line';
    DataClassification = ToBeClassified;

    fields
    {
        // 🔑 Primary Key Fields
        field(1; "Parent Transfer Order #"; Code[20])
        {
            Caption = 'Parent Transfer Order #';
            DataClassification = CustomerContent;
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }

        // 📦 Line Details
        field(3; "MO Description"; Text[100])
        {
            Caption = 'MO Description';
        }

        field(4; Select; Boolean)
        {
            Caption = 'Select';
        }

        field(5; "MO #"; Code[20])
        {
            Caption = 'MO #';
        }

        field(6; BOM; Code[20])
        {
            Caption = 'BOM';
        }

        field(7; Week; Integer)
        {
            Caption = 'Week';
        }

        field(8; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }

        field(9; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }

        field(10; Description; Text[100])
        {
            Caption = 'Description';
        }

        field(11; "Description Arabic"; Text[100])
        {
            Caption = 'Description Arabic';
        }

        field(12; "Quantity per"; Decimal)
        {
            Caption = 'Quantity per';
            DecimalPlaces = 0 : 5;
        }

        field(13; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";
        }

        field(14; "MO Qty"; Decimal)
        {
            Caption = 'MO Qty';
            DecimalPlaces = 0 : 5;
        }

        field(15; "Qty to Be Transferred"; Decimal)
        {
            Caption = 'Qty to Be Transferred';
            DecimalPlaces = 0 : 5;
        }

        field(16; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            DecimalPlaces = 0 : 5;
        }

        field(17; "Over Qty"; Decimal)
        {
            Caption = 'Over Qty';
            DecimalPlaces = 0 : 5;
        }

        field(18; "Transfer From Location"; Code[10])
        {
            Caption = 'Transfer From Location';
            TableRelation = Location;
        }

        field(19; "Transfer To"; Code[10])
        {
            Caption = 'Transfer To';
            TableRelation = Location;
        }

        field(20; "Fully Processed"; Boolean)
        {
            Caption = 'Processed';
        }

        field(21; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'LOB';
            ToolTip = 'Specifies the code for LOB (Shortcut Dimension 1).';
            TableRelation = "Dimension Value".Code
        where(
            "Global Dimension No." = const(1),
            Blocked = const(false)
        );

            // trigger OnValidate()
            // begin

            //     Rec.ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            // end;
        }

        field(22; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Branch';
            ToolTip = 'Specifies the code for Branch (Shortcut Dimension 2).';
            TableRelation = "Dimension Value".Code
        where(
            "Global Dimension No." = const(2),
            Blocked = const(false)
        );

            // trigger OnValidate()
            // begin
            //     Rec.ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            // end;
        }

        field(23; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Dept';
            ToolTip = 'Specifies the code for Dept (Shortcut Dimension 3).';
            TableRelation = "Dimension Value".Code
        where(
            "Dimension Code" = const('DEPT'),
            Blocked = const(false)
        );

            // trigger OnValidate()
            // begin
            //     Rec.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            // end;
        }

        field(24; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'SubDept';
            ToolTip = 'Specifies the code for SubDept (Shortcut Dimension 4).';
            TableRelation = "Dimension Value".Code
        where(
            "Dimension Code" = const('SUBDEPT'),
            Blocked = const(false)
        );

            // trigger OnValidate()
            // begin
            //     Rec.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            // end;
        }
        field(26; "Partially Processed"; Boolean)
        {
            Caption = 'Processed';
        }


        field(25; "Employee Dimension Code"; Code[20])
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

            trigger OnLookup()
            begin

            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
    }
    keys
    {
        key(PK; "Parent Transfer Order #", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode, IsHandled);
        if IsHandled then
            exit;

        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        //  VerifyItemLineDim();

        //   OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
    end;



    var
        DimMgt: Codeunit DimensionManagement;
}
