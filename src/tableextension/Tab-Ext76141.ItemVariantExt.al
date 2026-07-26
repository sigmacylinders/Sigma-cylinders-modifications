tableextension 76141 "Item Variant Ext" extends "Item Variant"
{
    fields
    {
        field(76100; Stamping; Option)
        {
            Caption = 'Stamping';
            DataClassification = CustomerContent;
            OptionMembers = "0","1";
            OptionCaption = '0,1';
        }
        field(76101; Embossing; Option)
        {
            Caption = 'Embossing';
            DataClassification = CustomerContent;
            OptionMembers = "0","1";
            OptionCaption = '0,1';
        }
        field(76102; "Version"; Code[3])
        {
            Caption = 'Version';
            DataClassification = CustomerContent;
        }
        field(76103; Joggling; Option)
        {
            Caption = 'Joggling';
            DataClassification = CustomerContent;
            OptionMembers = "0","1";
            OptionCaption = '0,1';
        }
        field(76104; Destination; Code[10])
        {
            Caption = 'Destination';
            DataClassification = CustomerContent;
            TableRelation = "SIGMA Lookup - V3".Code where(Type = const(COUNTRY));
        }
        field(76105; Company; Code[10])
        {
            Caption = 'Company';
            DataClassification = CustomerContent;
            TableRelation = "SIGMA Lookup - V3".Code where(Type = const(Company));
        }
        field(76106; "Variant Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    fieldgroups
    {
        addlast(DropDown; "Variant Code") { }
    }



    trigger onmodify()
    var
        Item: Record Item;
        VariantCode: text[50];
        CylinderCategory: Code[50];
        ItemNo: Code[20];
    begin
        ItemNo := Rec."Item No.";
        if ItemNo = '' then
            if Rec.GetFilter("Item No.") <> '' then
                ItemNo := Rec.GetRangeMin("Item No.");

        if Item.Get(ItemNo) then
            CylinderCategory := Item."Cylinder Category";

        VariantCode := '';
        case CylinderCategory of
            'FR', 'HA':
                begin
                    // Company-Stamping-Embossing-Version   (e.g. XYZ-1-1-100)
                    AddPart(VariantCode, Rec.Company);
                    AddPart(VariantCode, FORMAT(Rec.Stamping));
                    AddPart(VariantCode, FORMAT(Rec.Embossing));
                    AddPart(VariantCode, Rec."Version");
                end;
            'US':
                begin
                    // Company-Version-Joggle   (e.g. XYZ-100-1)
                    AddPart(VariantCode, Rec.Company);
                    AddPart(VariantCode, Rec."Version");
                    AddPart(VariantCode, FORMAT(Rec.Joggling));
                end;
            'LS':
                begin
                    // Joggle-Version   (e.g. 1-1)
                    AddPart(VariantCode, FORMAT(Rec.Joggling));
                    AddPart(VariantCode, Rec."Version");
                end;
            'NW', 'UP', 'LP':
                begin
                    // Company-Version   (e.g. XYZ-1)
                    AddPart(VariantCode, Rec.Company);
                    AddPart(VariantCode, Rec."Version");
                end;
            'SFC', 'CP', 'PPC', 'PC', 'PCV', 'FC':
                // Destination   (e.g. DS)
                AddPart(VariantCode, Rec.Destination);
        // DC, SS and any unmapped category: no composed variant code
        end;

        Rec."Variant Code" := VariantCode.ToUpper();
    end;

    local procedure AddPart(var VariantCode: Text; PartValue: Text)
    begin
        if PartValue = '' then
            exit;
        if VariantCode = '' then
            VariantCode := PartValue
        else
            VariantCode := VariantCode + '-' + PartValue;
    end;


}
