page 50100 "Report Preview Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Report Preview Setup Table";
    DeleteAllowed = false;
    InsertAllowed = false;
    Caption = 'Report Preview Setup';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(ReportPreviewActive; Rec.ReportPreviewActive)
                {
                }
                field(MaxNumberOfSavedReports; Rec.MaxNumberOfSavedReports)
                {
                }
                field(MaxNumberOfLinesForAutoPreview; Rec.MaxNumberOfLinesForAutoPreview)
                {
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}