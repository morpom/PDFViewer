pageextension 50103 "Document Attachment Detail Ext" extends "Document Attachment Details" //1173
{
    actions
    {
        addlast(processing)
        {
            action("View PDF")
            {
                ApplicationArea = All;
                Image = Text;
                Caption = 'View PDF';
                ToolTip = 'View PDF';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = Rec."File Extension" = 'pdf';
                trigger OnAction()
                var
                    PDFViewerDocAttachment: Page "PDF Viewer Document Attachment";
                begin
                    PDFViewerDocAttachment.SetRecord(Rec);
                    PDFViewerDocAttachment.SetTableView(Rec);
                    PDFViewerDocAttachment.Run();
                end;
            }
        }
    }
}
