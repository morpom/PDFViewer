table 50101 "Report Preview Setup Table"
{
    fields
    {
        field(1; PrimaryKey; Code[20])
        {
        }
        field(2; ReportPreviewActive; Boolean)
        {
            Caption = 'Report Preview Active';
            ToolTip = 'If this field is checked, the report preview is active.';
        }
        field(3; MaxNumberOfSavedReports; Integer)
        {
            Caption = 'Max. Number of Saved Reports';
            ToolTip = 'The maximum number of temporarily saved reports. If the number of saved reports exceeds this value, the oldest reports are deleted.';
        }
        field(4; MaxNumberOfLinesForAutoPreview; Integer)
        {
            Caption = 'Max. Number of Lines for Auto Preview';
            ToolTip = 'The maximum number of lines a report can have to be automatically previewed. If the number of lines exceeds this value, the report is not automatically previewed.';
        }
    }

    trigger OnModify()
    begin
        if not Rec.ReportPreviewActive and xRec.ReportPreviewActive then
            Message('The report preview was deactivated.');
    end;
}