tableextension 76105 "GL Setup Parent TO Ext" extends "General Ledger Setup"
{
    fields
    {
        field(76101; "Parent TO No. Series"; Code[20])
        {
            Caption = 'Parent TO No. Series';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }
    }
}
