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
    begin
        CurrPage.PDFViewer.SetVisible(Rec."Document Reference ID".HasValue()); //TODO The HasValue läuft hier auf einen Fehler
        if not Rec."Document Reference ID".HasValue then
            exit;

        TempBlob.CreateInStream(InStreamVar);
        TempBlob.CreateOutStream(OutStreamVar);
        Rec."Document Reference ID".ExportStream(OutStreamVar);

        PDFAsTxt := Base64Convert.ToBase64(InStreamVar);

        CurrPage.PDFViewer.LoadPDF(PDFAsTxt, false);
    end;

    procedure SetRecord(DocumentAttachment: Record "Document Attachment")
    begin
        Rec := DocumentAttachment;
        SetPDFDocument();
        CurrPage.Update(false);
    end;

    trigger OnAfterGetRecord()
    begin
        if Rec.IsEmpty() then begin
            CurrPage.PDFViewer.SetVisible(Rec."Document Reference ID".HasValue());
            Message('No Record');
        end else
            SetRecord(Rec);
    end;
}