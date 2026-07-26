codeunit 76103 "Sigma Install Setup"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        SeedCylinderCategories();
    end;

    procedure SeedCylinderCategories()
    var
        SigmaLookup: Record "SIGMA Lookup - V3";
        Codes: List of [Code[50]];
        LookupCode: Code[50];
    begin
        Codes.Add('DC');
        Codes.Add('SS');
        Codes.Add('FR');
        Codes.Add('HA');
        Codes.Add('US');
        Codes.Add('LS');
        Codes.Add('NW');
        Codes.Add('UP');
        Codes.Add('LP');
        Codes.Add('SFC');
        Codes.Add('CP');
        Codes.Add('PPC');
        Codes.Add('PC');
        Codes.Add('PCV');
        Codes.Add('FC');

        foreach LookupCode in Codes do begin
            if not SigmaLookup.Get(SigmaLookup.Type::"Cylinder Category", LookupCode) then begin
                SigmaLookup.Init();
                SigmaLookup.Type := SigmaLookup.Type::"Cylinder Category";
                SigmaLookup.Code := LookupCode;
                SigmaLookup.Insert(true);
            end;
        end;
    end;
}
