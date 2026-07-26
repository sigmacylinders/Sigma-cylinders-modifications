pageextension 76159 "Item Variants Ext" extends "Item Variants"
{
    layout
    {
        addafter(Code)
        {
            field("Variant Code"; Rec."Variant Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the variant code for the item.';
            }
        }
        addafter(Description)
        {
            field(Company; Rec.Company)
            {
                ApplicationArea = All;
                Visible = CompanyVisible;
                ToolTip = 'Specifies the company code for the variant.';
            }
            field(Stamping; Rec.Stamping)
            {
                ApplicationArea = All;
                Visible = StampingVisible;
                ToolTip = 'Specifies whether the variant has stamping.';
            }
            field(Embossing; Rec.Embossing)
            {
                ApplicationArea = All;
                Visible = EmbossingVisible;
                ToolTip = 'Specifies whether the variant has embossing.';
            }
            field("Version"; Rec."Version")
            {
                ApplicationArea = All;
                Visible = VersionVisible;
                ToolTip = 'Specifies the sequential version number of the variant.';
            }
            field(Joggling; Rec.Joggling)
            {
                ApplicationArea = All;
                Visible = JogglingVisible;
                ToolTip = 'Specifies whether the variant is joggled (00 = No Joggling, 01 = Joggling).';
            }
            field(Destination; Rec.Destination)
            {
                ApplicationArea = All;
                Visible = DestinationVisible;
                ToolTip = 'Specifies the destination country code for the variant.';
            }

        }
    }

    trigger OnOpenPage()
    begin


        UpdateFieldVisibility();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateFieldVisibility();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateFieldVisibility();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        ItemVariant: Record "Item Variant";
    begin
        if Rec.Code <> '' then
            exit;

        ItemVariant.SetRange("Item No.", Rec."Item No.");
        if ItemVariant.FindLast() then
            Rec.Code := IncStr(ItemVariant.Code)
        else
            Rec.Code := 'ITMV000001';
    end;


    local procedure UpdateFieldVisibility()
    var
        Item: Record Item;
        CylinderCategory: Code[50];
        ItemNo: Code[20];
    begin
        CompanyVisible := false;
        StampingVisible := false;
        EmbossingVisible := false;
        VersionVisible := false;
        JogglingVisible := false;
        DestinationVisible := false;

        ItemNo := Rec."Item No.";
        if ItemNo = '' then
            if Rec.GetFilter("Item No.") <> '' then
                ItemNo := Rec.GetRangeMin("Item No.");

        if Item.Get(ItemNo) then
            CylinderCategory := Item."Cylinder Category";

        case CylinderCategory of
            'FR', 'HA':
                begin
                    CompanyVisible := true;
                    StampingVisible := true;
                    EmbossingVisible := true;
                    VersionVisible := true;
                end;
            'US':
                begin
                    CompanyVisible := true;
                    StampingVisible := true;
                    EmbossingVisible := true;
                    VersionVisible := true;
                    JogglingVisible := true;
                end;
            'LS':
                begin
                    VersionVisible := true;
                    JogglingVisible := true;
                end;
            'NW', 'UP', 'LP':
                begin
                    CompanyVisible := true;
                    VersionVisible := true;
                end;
            'SFC', 'CP', 'PPC', 'PC', 'PCV', 'FC':
                DestinationVisible := true;
        // 'DC', 'SS' and any unmapped category: all fields remain hidden
        end;
    end;

    var
        CompanyVisible: Boolean;
        StampingVisible: Boolean;
        EmbossingVisible: Boolean;
        VersionVisible: Boolean;
        JogglingVisible: Boolean;
        DestinationVisible: Boolean;
}
