pageextension 50101 "Doc Attachment Factbox Ext" extends "Document Attachment Factbox"
{
    layout
    {
        addafter(Documents)
        {
            usercontrol(PDFViewer; "PDF Viewer")
            {
                ApplicationArea = All;

                trigger ControlAddinReady()
                begin
                    SetPDFDocument();
                end;

                trigger onView()
                begin
                    RunFullView();
                end;
            }
        }
    }
    local procedure SetPDFDocument()
    var
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        InStreamVar: InStream;
        OutStreamVar: OutStream;
        PDFAsTxt: Text;
        DocumentAttachment: Record "Document Attachment";
    begin
        CurrPage.PDFViewer.SetVisible(Rec."Document Reference ID".HasValue());
        if not Rec."Document Reference ID".HasValue then
            exit;

        TempBlob.CreateInStream(InStreamVar);
        TempBlob.CreateOutStream(OutStreamVar);

        DocumentAttachment.Reset();
        DocumentAttachment.SetRange("No.", Rec."No.");
        DocumentAttachment.FindLast();
        DocumentAttachment."Document Reference ID".ExportStream(OutStreamVar);

        PDFAsTxt := Base64Convert.ToBase64(InStreamVar);

        CurrPage.PDFViewer.LoadPDF(PDFAsTxt, true);
    end;

    local procedure RunFullView()
    var
        PDFViewerDocumentAttachment: Page "PDF Viewer Document Attachment";
    begin
        if Rec.IsEmpty() then
            exit;
        PDFViewerDocumentAttachment.SetRecord(Rec);
        PDFViewerDocumentAttachment.SetTableView(Rec);
        PDFViewerDocumentAttachment.Run();
    end;

    procedure SetRecord(DocumentAttachment: Record "Document Attachment")
    begin
        Rec := DocumentAttachment;
        SetPDFDocument();
        CurrPage.Update(false);
    end;

    trigger OnAfterGetRecord()
    begin
        if not Rec.IsEmpty() then
            SetRecord(Rec);
    end;
}
codeunit 50100 PDFViewerDocAttFactboxCodeunit
{
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeOnAfterGetCurrRecord', '', false, false)]
    local procedure OnBeforeOnAfterGetCurrRecord(var DocumentAttachment: Record "Document Attachment"; var AttachmentCount: Integer; var IsHandled: Boolean)
    var
        PDFViewerDocAttFactboxExt: Page "Document Attachment Factbox";
    begin
        // PDFViewerDocAttFactboxExt.Update(true);
        // PDFViewerDocAttFactboxExt.SetRecord(DocumentAttachment);
        // PDFViewerDocAttFactboxExt.SetVisible(DocumentAttachment."Document Reference ID".HasValue);
    end;
}