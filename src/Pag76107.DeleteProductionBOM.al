// page 76107 "Delete Production BOM"
// {
//     Caption = 'Delete Production BOM';
//     PageType = List;
//     SourceTable = "Production BOM Header";
//     UsageCategory = Tasks;
//     ApplicationArea = All;
//     Editable = true;
//     //  MultipleNewLines = false;

//     layout  
//     {
//         area(Content)
//         {
//             repeater(Lines)
//             {
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Unit of Measure Code"; Rec."Unit of Measure Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Last Date Modified"; Rec."Last Date Modified")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             action(DeleteSelected)
//             {
//                 Caption = 'Delete Selected';
//                 ApplicationArea = All;
//                 Image = Delete;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 var
//                     ProductionBOMHeader: Record "Production BOM Header";
//                     SelectedNos: List of [Code[20]];
//                     BOMNo: Code[20];
//                     DeletedCount: Integer;
//                 begin
//                     CurrPage.SetSelectionFilter(ProductionBOMHeader);

//                     if ProductionBOMHeader.IsEmpty then begin
//                         Message('No Production BOMs selected.');
//                         exit;
//                     end;

//                     if not Confirm('Are you sure you want to delete the selected Production BOMs? This action cannot be undone.', false) then
//                         exit;

//                     if ProductionBOMHeader.FindSet() then
//                         repeat
//                             SelectedNos.Add(ProductionBOMHeader."No.");
//                         until ProductionBOMHeader.Next() = 0;

//                     foreach BOMNo in SelectedNos do begin
//                         ProductionBOMHeader.Get(BOMNo);
//                         ProductionBOMHeader.Delete(true);
//                         DeletedCount += 1;
//                     end;

//                     Message('%1 Production BOM(s) successfully deleted.', DeletedCount);
//                     CurrPage.Update(false);
//                 end;
//             }
//         }
//     }
// }
