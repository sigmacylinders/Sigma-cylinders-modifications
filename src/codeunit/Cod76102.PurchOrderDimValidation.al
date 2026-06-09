codeunit 76102 "Purch. Order Dim. Validation"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeReleasePurchaseDoc', '', false, false)]
    local procedure CheckDimensionsOnRelease(var PurchaseHeader: Record "Purchase Header")
    var
        GLSetup: Record "General Ledger Setup";
        PurchSetup: Record "Purchases & Payables Setup";
    begin

        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
            exit;

        GLSetup.Get();
        PurchSetup.Get();

        // Dimension 1
        if PurchSetup."Dimension 1 Mandatory on PO" then
            if PurchaseHeader."Shortcut Dimension 1 Code" = '' then
                Error('Shortcut Dimension 1 (%1) must be filled in on the Purchase Order before it can be released.', GLSetup."Shortcut Dimension 1 Code");

        // Dimension 2
        if PurchSetup."Dimension 2 Mandatory on PO" then
            if PurchaseHeader."Shortcut Dimension 2 Code" = '' then
                Error('Shortcut Dimension 2 (%1) must be filled in on the Purchase Order before it can be released.', GLSetup."Shortcut Dimension 2 Code");

        // Dimension 3
        if PurchSetup."Dimension 3 Mandatory on PO" then
            CheckDimSetEntry(PurchaseHeader."Dimension Set ID", GLSetup."Shortcut Dimension 3 Code", 3);

        // Dimension 4
        if PurchSetup."Dimension 4 Mandatory on PO" then
            CheckDimSetEntry(PurchaseHeader."Dimension Set ID", GLSetup."Shortcut Dimension 4 Code", 4);

        // Dimension 5 (Shortcut Dimension 8)
        if PurchSetup."Dimension 5 Mandatory on PO" then
            CheckDimSetEntry(PurchaseHeader."Dimension Set ID", GLSetup."Shortcut Dimension 8 Code", 8);
    end;


    local procedure CheckDimSetEntry(DimSetID: Integer; DimCode: Code[20]; DimNo: Integer)
    var
        DimSetEntry: Record "Dimension Set Entry";
    begin
        if DimCode = '' then
            exit;

        DimSetEntry.SetRange("Dimension Set ID", DimSetID);
        DimSetEntry.SetRange("Dimension Code", DimCode);
        IF NOT DimSetEntry.FindFirst() then
            Error('Shortcut Dimension %1 (%2) must be filled in on the Purchase Order before it can be released.', DimNo, DimCode);
    end;


}
