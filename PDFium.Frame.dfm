object PDFiumFrame: TPDFiumFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  HorzScrollBar.Tracking = True
  VertScrollBar.Increment = 27
  VertScrollBar.Tracking = True
  Align = alClient
  DoubleBuffered = True
  Color = clGray
  ParentBackground = False
  ParentColor = False
  ParentDoubleBuffered = False
  PopupMenu = pmPdf
  TabOrder = 0
  object pmPdf: TPopupMenu
    OnPopup = pmPdfPopup
    Left = 64
    Top = 40
    object mniCopy: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1072#1085#1077
      OnClick = mniCopyClick
    end
  end
end
