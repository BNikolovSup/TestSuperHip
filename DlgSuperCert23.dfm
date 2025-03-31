object frmCertDlg: TfrmCertDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1061#1080#1087#1086#1082#1088#1072#1090' - '#1080#1079#1073#1086#1088' '#1085#1072' '#1089#1077#1088#1090#1080#1092#1080#1082#1072#1090
  ClientHeight = 540
  ClientWidth = 399
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object grdCert: TStringGrid
    Left = 0
    Top = 0
    Width = 399
    Height = 482
    Align = alClient
    Color = clInfoBk
    ColCount = 1
    DefaultColWidth = 300
    DefaultRowHeight = 80
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Options = [goFixedVertLine, goFixedHorzLine, goRowSelect]
    ParentFont = False
    TabOrder = 0
    OnDblClick = grdCertDblClick
    OnDrawCell = grdCertDrawCell
    ColWidths = (
      300)
    RowHeights = (
      80)
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 482
    Width = 399
    Height = 58
    Align = alBottom
    Color = clMedGray
    ParentBackground = False
    TabOrder = 1
    object btnOK: TBitBtn
      Left = 15
      Top = 13
      Width = 91
      Height = 28
      Caption = #1055#1086#1090#1074#1098#1088#1076#1080
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 112
      Top = 13
      Width = 113
      Height = 28
      Caption = #1054#1090#1082#1072#1079
      ModalResult = 2
      TabOrder = 1
    end
    object btnDetail: TBitBtn
      Left = 231
      Top = 13
      Width = 162
      Height = 27
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1079#1072' '#1089#1077#1088#1090#1080#1092#1080#1082#1072#1090#1072
      TabOrder = 2
      OnClick = btnDetailClick
    end
  end
end
