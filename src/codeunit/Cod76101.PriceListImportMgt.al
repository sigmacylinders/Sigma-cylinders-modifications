codeunit 76101 "Price List Import Mgt."
{
    SingleInstance = false;
    Subtype = Normal;



    local procedure GetLastRow(var ExcelBuffer: Record "Excel Buffer" temporary): Integer
    var
        EB: Record "Excel Buffer" temporary;
    begin
        EB.Copy(ExcelBuffer);
        // EB.Reset();
        if EB.FindLast() then
            exit(EB."Row No.");
        exit(0);
    end;

    local procedure GetCellText(var ExcelBuffer: Record "Excel Buffer" temporary; RowNo: Integer; ColNo: Integer): Text
    begin
        ExcelBuffer.SetRange("Row No.", RowNo);
        ExcelBuffer.SetRange("Column No.", ColNo);
        if ExcelBuffer.FindFirst() then
            exit(ExcelBuffer."Cell Value as Text");
        exit('');
    end;

    local procedure ToDecimal(S: Text): Decimal
    var
        D: Decimal;
        Clean: Text;
    begin
        Clean := DelChr(S, '=', ','); // remove thousand separators (commas)
        Clean := Clean.Trim();
        if Clean = '' then
            exit(0);
        if not Evaluate(D, Clean) then
            Error('Cannot convert "%1" to Decimal.', S);
        exit(D);
    end;

    local procedure ToDate(S: Text): Date
    var
        D: Date;
    begin
        S := S.Trim();
        if (S = '') then
            exit(0D);
        if not Evaluate(D, S) then
            Error('Cannot convert "%1" to Date. Use a recognizable date format.', S);
        exit(D);
    end;

    local procedure ToBool(S: Text): Boolean
    var
        N: Text;
    begin
        N := LowerCase(DelChr(S, '=', ' '));
        exit((N = 'yes') or (N = 'y') or (N = 'true') or (N = '1'));
    end;

    local procedure ToAssignToType(S: Text): Enum "Price Source Type"
    var
        P: Enum "Price Source Type";
        N: Text;
    begin
        // Normalize input:
        // 1) Replace non-breaking space (char 160) with normal space
        // 2) Lowercase
        // 3) Trim
        // 4) Remove dots, slashes, dashes, underscores
        // 5) Collapse spaces (remove all spaces for simplified matching)
        N := S;
        N := N.Replace(Format(160), ' '); // NBSP -> space
        N := LowerCase(N);
        N := N.Trim();
        N := DelChr(N, '=', '.-/\_');     // remove common punctuation
        N := DelChr(N, '=', ' ');        // remove spaces to make matching resilient
                                         // Message(N);
        case N of
            // --- All Customers
            'allcustomers', 'all':
                exit(P::"All Customers");

            // --- Customer (single)
            'customer', 'customers':
                exit(P::Customer);

            // --- Customer Price Group (many aliases)
            'customerpricegroup',
            'custpricegroup',
            'custpricegrp',
            'customerpricegrp',
            'customergrpprice',
            'pricegroup',
            'pricegrp',
            'cpg':
                exit(P::"Customer Price Group");

            // --- Campaign
            'campaign':
                exit(P::Campaign);

            // --- Job
            'job':
                exit(P::Job);
        end;

        Error('Unsupported "Assign-to Type": %1', S);
    end;

    local procedure ToAssetType(S: Text): Enum "Price Asset Type"
    var
        A: Enum "Price Asset Type";
        N: Text;
    begin
        N := LowerCase(S);
        case N of
            'item', 'items':
                exit(A::Item);
            'resource', 'resources':
                exit(A::Resource);
            'g/l account', 'gl account', 'account':
                exit(A::"G/L Account");
            'item discount group', 'item disc. group', 'idg':
                exit(A::"Item Discount Group");
            else
                Error('Unsupported "Product Type": %1', S);
        end;
    end;

    local procedure GetNextLineNo(PriceListCode: Code[20]): Integer
    var
        PLL: Record "Price List Line";
    begin
        PLL.SetRange("Price List Code", PriceListCode);
        if PLL.FindLast() then
            exit(PLL."Line No." + 10000);
        exit(10000);
    end;


    procedure ImportSalesPriceListLines2(PriceListCode: Code[20])
    var
        UploadedFileName: Text[250];
        index: Integer;
        RowNo: Integer;
        cellFound: Boolean;
        cellValue: Text[250];
        MaxRow: Integer;
        Window: Dialog;
        ExcelBuf: Record "Excel Buffer";
        FileName: Text[250];
        SheetName: Text[250];
        AttendanceNo: Integer;
        EmployeeName: Text[100];
        PunchDateTime: DateTime;
        PunchType: Code[20];

        FileMgt: Codeunit "File Management";
        Text006: TextConst ENU = 'Import Excel File';
        ImportWindowTitle: TextConst ENU = 'Import Excel File';
        ExcelExtensionTok: TextConst ENU = '.xlsx';
        Instr: InStream;
        FileUploaded: Boolean;
        Columns: Integer;
        Rows: integer;        // Parsed values
        AssignToTypeTxt: Text;
        AssignToNoTxt: Text;
        ProductTypeTxt: Text;
        CurrencyCodeTxt: Code[10];
        StartingDateTxt: Text;
        EndingDateTxt: Text;
        ProductNoTxt: Code[20];
        DescriptionTxt: Text[100];
        VariantCodeTxt: Code[10];
        WorkTypeCodeTxt: Code[10];
        UOMTxt: Code[10];
        MinQtyTxt: Text;
        AmountTypeText: Text;
        UnitPriceTxt: Text;
        AllowLineDiscTxt: Text;
        AllowInvoiceDiscTxt: Text;
        PriceInclVATTxt: Text;
        VATBusPostingPriceTxt: Code[20];
        ExcelBuffer: Record "Excel Buffer" temporary;        // Enums
        PriceType: Enum "Price Type";
        AssignToType: Enum "Price Source Type";
        AssetType: Enum "Price Asset Type";
        // Temp vars
        MinQty: Decimal;
        UnitPrice: Decimal;
        StartingDate: Date;
        EndingDate: Date;
        PriceListLine: Record "Price List Line";
        PriceListHeader: Record "Price List Header";
        LineNo: Integer;
    begin
        //Excel Format : Attendance No   | Employee Name |  Punch Date Time     | Punch Type
        //                   1           |   Rana        |   16.06.2016 8:00 AM |   IN


        //EDM_KM_09062020
        //UploadedFileName := FileMgt.UploadFile(ImportWindowTitle, ExcelExtensionTok);
        //   FileName := UploadedFileName;
        //  SheetName := ExcelBuf.SelectSheetsName(FileName);
        //  ExcelBuf.OpenBook(FileName, SheetName);
        //  ExcelBuf.ReadSheet;

        //EDM_KM_09062020
        FileUploaded := UploadIntoStream('Select File to Upload', '', '', Filename, Instr);

        if Filename <> '' then
            Sheetname := ExcelBuf.SelectSheetsNameStream(Instr)
        else
            exit;

        ExcelBuf.Reset;
        ExcelBuf.OpenBookStream(Instr, Sheetname);
        ExcelBuf.ReadSheet();

        Commit();

        RowNo := 2;
        Window.OPEN('Price Process \' +
                    'Row No.: #1########\');

        if ExcelBuf.FINDFIRST then
            repeat
                ExcelBuf.SETCURRENTKEY("Row No.");
                IF ExcelBuf.FINDLAST THEN
                    MaxRow := ExcelBuf."Row No.";

                LineNo := GetNextLineNo(PriceListCode);
                While RowNo <= MaxRow Do Begin
                    ProductNoTxt := GetCellText(ExcelBuf, RowNo, 7);
                    // DescriptionTxt := CopyStr(GetCellText(ExcelBuf, RowNo, ColDescription), 1, MaxStrLen(DescriptionTxt));

                    // Determine end-of-data: skip completely empty rows
                    if (ProductNoTxt = '') then
                        continue;

                    AssignToTypeTxt := GetCellText(ExcelBuf, RowNo, 1);
                    AssignToNoTxt := GetCellText(ExcelBuf, RowNo, 2);
                    CurrencyCodeTxt := GetCellText(ExcelBuf, RowNo, 3);
                    StartingDateTxt := GetCellText(ExcelBuf, RowNo, 4);
                    EndingDateTxt := GetCellText(ExcelBuf, RowNo, 5);
                    ProductTypeTxt := GetCellText(ExcelBuf, RowNo, 6);
                    // VariantCodeTxt := CopyStr(GetCellText(ExcelBuf, RowNo, ColVariantCode), 1, MaxStrLen(VariantCodeTxt));
                    // WorkTypeCodeTxt := CopyStr(GetCellText(ExcelBuf, RowNo, ColWorkTypeCode), 1, MaxStrLen(WorkTypeCodeTxt));
                    // UOMTxt := CopyStr(GetCellText(ExcelBuf, RowNo, ColUOM), 1, MaxStrLen(UOMTxt));
                    AmountTypeText := GetCellText(ExcelBuf, RowNo, 9);
                    MinQtyTxt := GetCellText(ExcelBuf, RowNo, 8);
                    UnitPriceTxt := GetCellText(ExcelBuf, RowNo, 10);
                    //  AllowLineDiscTxt := GetCellText(ExcelBuf, RowNo, ColAllowLineDisc);
                    //  AllowInvoiceDiscTxt := GetCellText(ExcelBuf, RowNo, ColAllowInvoiceDisc);
                    PriceInclVATTxt := GetCellText(ExcelBuf, RowNo, 11);
                    //  VATBusPostingPriceTxt := CopyStr(GetCellText(ExcelBuf, RowNo, ColVATBusPostingPrice), 1, MaxStrLen(VATBusPostingPriceTxt));

                    // Parse/convert
                    AssetType := ToAssetType(ProductTypeTxt);
                    //  AssignToType := ToAssignToType(AssignToTypeTxt);
                    AssignToType := ToAssignToType(AssignToTypeTxt);
                    MinQty := ToDecimal(MinQtyTxt);
                    UnitPrice := ToDecimal(UnitPriceTxt);
                    StartingDate := ToDate(StartingDateTxt);
                    EndingDate := ToDate(EndingDateTxt);

                    // 5) Insert line
                    PriceListLine.Init();
                    PriceListLine."Price List Code" := PriceListCode;
                    PriceListLine."Line No." := LineNo;
                    PriceListLine."Price Type" := PriceType::Sale;
                    PriceListLine.Validate("Source Type", AssignToType);
                    PriceListLine.Validate("Source No.", AssignToNoTxt);
                    // Assignment (who the price applies to)
                    PriceListLine.Validate("Asset Type", AssetType
                    );
                    PriceListLine.Validate("Assign-to No.", AssignToNoTxt);

                    // Product/asset related
                    PriceListLine.Validate("Asset Type", AssetType);
                    PriceListLine.Validate("Asset No.", ProductNoTxt);
                    PriceListLine.Validate("Product No.", ProductNoTxt);
                    // if DescriptionTxt <> '' then
                    //     PriceListLine.Validate(Description, DescriptionTxt);

                    //   PriceListLine.Validate("Variant Code", VariantCodeTxt);
                    //   PriceListLine.Validate("Unit of Measure Code", UOMTxt);
                    //   if AssetType = AssetType::Resource then
                    //      PriceListLine.Validate("Work Type Code", WorkTypeCodeTxt);

                    // Commercials
                    PriceListLine.Validate("Currency Code", CurrencyCodeTxt);
                    if StartingDate <> 0D then
                        PriceListLine.Validate("Starting Date", StartingDate);
                    if EndingDate <> 0D then
                        PriceListLine.Validate("Ending Date", EndingDate);

                    PriceListLine.Validate("Minimum Quantity", MinQty);
                    PriceListLine.Validate("Amount Type", PriceListLine."Amount Type"::Price);

                    PriceListLine.Validate("Unit Price", UnitPrice);

                    //  PriceListLine.Validate("Allow Line Disc.", ToBool(AllowLineDiscTxt));
                    //  PriceListLine.Validate("Allow Invoice Disc.", ToBool(AllowInvoiceDiscTxt));
                    PriceListLine.Validate("Price Includes VAT", ToBool(PriceInclVATTxt));
                    //    PriceListLine.Validate("VAT Bus. Posting Gr. (Price)", VATBusPostingPriceTxt);

                    PriceListLine.Insert(true);

                    LineNo += 10000;
                    RowNo += 1;
                    Window.UPDATE(1, AttendanceNo);

                end;
            UNTIL ExcelBuf.NEXT = 0;
        Window.CLOSE;
        UploadedFileName := '';

    end;


}
