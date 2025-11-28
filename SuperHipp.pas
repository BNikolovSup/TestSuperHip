unit SuperHipp;  //prac
interface

  uses
  Parnassus.FMXContainer, Parnassus.FMXContainerReg, uVSTSyncHelper,
  FMX.Forms, FMX.Edit, FMX.StdCtrls, ProfForm, FmxWelcomeScreen,
  RolePanels, OptionsForm,
  Tokens, WalkFunctions, TitleBar, RoleBar, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus,
  Vcl.Menus, Vcl.AppEvnts, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  Winapi.ActiveX, Winapi.ShellAPI,
  Vcl.Controls, Vcl.Dialogs, SynEditHighlighter, SynHighlighterXML, RoleButton,
  Vcl.ComCtrls, Vcl.StdCtrls, SynEdit, VCLTee.Control, VCLTee.Grid,
  Vcl.OleCtrls, {WMPLib_TLB,} Vcl.ToolWin, Vcl.WinXCtrls, Vcl.Forms,
  VirtualStringTreeAspect, Vcl.Imaging.GIFImg, VirtualTrees,
  VirtualStringTreeHipp, Vcl.Buttons, System.Classes,
  
  JclDebug,System.Generics.Collections, Vcl.Graphics,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  system.Diagnostics, system.TimeSpan,
  ThreadLoadDB, DM, system.Math, VTREditors,system.Types,
  HistoryThread, SearchThread, AspectPerformerThread, CertThread,
  System.Zip, frxRichEditor, frxRichEdit,
  HistoryNav, Nzis.types, FILE_SUBM_PL, Tee.GridData.Strings, Tee.Grid.CSV,

  Xml.XMLIntf, Xml.XMLDoc, ansistrings,
  RTTI, IBX.IBSQL, Tee.Grid.Ticker, Tee.Grid.Columns, tee.grid.Rows,
  ProfGraph, Options,Vcl.Clipbrd,


  GR32_Image, PDFium.Frame, FastSearch,

  system.DateUtils,
  NzisThreadFull, System.IOUtils,

  Aspects.Types, SuperObject, superxmlparser,

  Table.Role,
  Nzis.Nomen.baseCL000,
  XBookComponent2, XLSBook2,
  Xc12Utils5, XLSUtils5, XLSCellMMU5, XLSNames5, XLSFormattedObj5,
  Xc12DataStyleSheet5,
  XLSSheetData5, XBookUtils2, XBookPrint2, XLSExportCSV5,
  Table.Cl132, table.PR001, table.CL050, table.cl134, table.cl142,
  Table.Cl088, Table.CL139, Table.CL144, table.Cl037,
  table.CL022, Table.Cl038, table.CL024, Table.NomenNzis,
  table.cl006, table.nzistoken, Table.Oblast, Table.Obshtina, Table.NasMesto,
  Table.BLANKA_MED_NAPR,Table.BLANKA_MED_NAPR_3A,Table.AnalResult,

  table.doctor, table.unfav, Table.NzisReqResp,
  Table.Mkb, Table.PregledNew, Table.PatientNew, Table.PatientNZOK,
  Table.Diagnosis, Table.MDN, Table.INC_MDN,
  Table.AnalsNew, Table.practica, Table.ExamAnalysis, table.ExamImmunization,
  Table.INC_NAPR, Table.OtherDoctor, Table.Addres,
  table.Procedures, Table.NZIS_PLANNED_TYPE, Table.NZIS_QUESTIONNAIRE_RESPONSE,
  Table.NZIS_QUESTIONNAIRE_ANSWER, Table.NZIS_ANSWER_VALUE,
  Table.NZIS_DIAGNOSTIC_REPORT, Table.NZIS_RESULT_DIAGNOSTIC_REPORT,
  Table.Certificates, Table.KARTA_PROFILAKTIKA2017,
  Table.EXAM_LKK, Table.HOSPITALIZATION,


  RealObj.NzisNomen, Aspects.Collections, RealObj.RealHipp, RealNasMesto,

  FinderFormFMX, fmxImportNzisForm,
  FMX.Types, System.Bindings.Expression,
  System.Bindings.ExpressionDefaults,

  DbHelper, ADB_DataUnit,
   System.TypInfo,DlgSuperCert23,
 //import Nzis
   X006,msgX013, X014,
   msgX001, msgX002, msgX003,
   msgR001, msgR002, msgR016,
   Nzis.XMLHelper,
   Nzis.NzisImport,
 //sbx
  SBXMLSec, SBXMLSig, SBXMLEnc, SBxCertificateStorage, sbxtypes,
  SBXMLCore, SBTypes, SBXMLDefs, SBX509,   SBXMLUtils, SBWinCertStorage, SBUtils,
  SBBaseClasses, SBSocketClient, SBSocket, sbxcore,
  SBSimpleSSL, SBHTTPSClient, SBPKCS11Base, SBCustomCertStorage, SBConstants,
  SBPKCS11CertStorage, SBCertValidator, SBSSLCommon,SBLists,
  SBXMLAdESIntf, SBStrUtils, SBSSLConstants, SBHTTPSConstants, CertHelper, TempVtrHelper,
  Vcl.DBCtrls, System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls,
  WordBreakF, WMPLib_TLB
  ;
  const
  EM_GETZOOM = (WM_USER + 224);
  EM_SETZOOM = (WM_USER + 225);

  WM_AFTER_SHOW = WM_USER + 1;
  WM_AFTER_LOAD_DB = WM_USER + 2;
  WM_PROGRES_LOAD_DB = WM_USER + 3;
  WM_CNT_LOAD_DB = WM_USER + 4;

  WM_SET_PAT_ID = WM_USER + 128;
  WM_SHOW_GRID = WM_USER + 129;
  WM_AFTER_SHOW_FMX = WM_USER + 111;

  WM_SENDED_NZIS = WM_USER + 500;

  WM_Super_Start = WM_USER + 200;
  WM_Super_Check = WM_USER + 201;
  WM_Super_Resize = WM_USER + 202;
  WM_Hip_Scroll_Patient = WM_USER + 203;
  WM_Hip_Deactivate = WM_USER + 204;

  WM_Nzis_Set_NRN = WM_USER + 501;
  WM_Nzis_Set_Planed = WM_USER + 502;

  WM_Cert_Storage = WM_USER + 601;

type

  TSortPat = (spNone, spEgn, spAge, spStartPreg);



  TString = class(TObject)
    str: string;
  end;

  TFinderRec = record
    vid: TVtrVid;
    strSearch: string;
    LastFindedStr: string;
    IsFinded: Boolean;
    node: PVirtualNode;
    ACol: TColumnIndex;
  end;

  TPregledPlanedInfo = record  //  за стария Хипократ
    PregledID: Integer;
    IsDone: LongBool;
    Cl132: string[50];
  end;
  //TArrPregledPlaned = array of TPregledPlanedInfo;
//
//  TListPreg = record
//    arr: array of TPregledPlanedInfo;
//    len: Integer;
//  end;


  TTeeGRD = class(TVCLTeeGrid);
  TTeeRows = class(Tee.Grid.Rows.TRows);
  TTempVTR = class(TVirtualStringTree);

  TExHint = class(THintWindow)
    constructor Create(AOwner: TComponent); override;
  end;

  TfrmSuperHip = class(TForm)
    vtrPregledi: TVirtualStringTreeHipp;
    Edit1: TEdit;
    spl1: TSplitter;
    Panel1: TPanel;
    btn1: TButton;
    pgcWork: TPageControl;
    tsDynPanel: TTabSheet;
    btn2: TSpeedButton;
    tsMinaliPregledi: TTabSheet;
    vtrMinaliPregledi: TVirtualStringTreeHipp;
    tsTestFilter: TTabSheet;
    vtrTestFilter: TVirtualStringTreeHipp;
    pnlTree: TPanel;
    pgcTree: TPageControl;
    tsTreePregledi: TTabSheet;
    tsTreePat: TTabSheet;
    tsTreeRole: TTabSheet;
    btnFilter: TButton;
    tsMemo: TTabSheet;
    mmoTest: TMemo;
    btnUpdate: TButton;
    Button1: TButton;
    Button2: TButton;
    hntMain: TBalloonHint;
    tsPdf: TTabSheet;
    pgcRole: TPageControl;
    tsRoleSelect: TTabSheet;
    tsRoleManager: TTabSheet;
    tsRoleDescr: TTabSheet;
    tsSpisaci: TTabSheet;
    vtrSpisyci: TVirtualStringTreeHipp;
    btnSpisyci: TButton;
    pnlSpisyciTop: TPanel;
    btnNext: TSpeedButton;
    btnPrevOtcetPeriod: TSpeedButton;
    lblYear: TLabel;
    btnSaveUnfav: TButton;
    btnCancel: TButton;
    ButtonedEdit1: TButtonedEdit;
    lblHint: TLabel;
    btnExit: TButton;
    btnPatList: TButton;
    tsRTF: TTabSheet;
    btnRTF: TButton;
    tsVideo: TTabSheet;
    MPHip: TWindowsMediaPlayer;
    vtrHelpHip: TVirtualStringTreeHipp;
    scrlbxRole: TScrollBox;
    vtrRole: TVirtualStringTreeHipp;
    tsTest: TTabSheet;
    tsNomenNzis: TTabSheet;
    vtrNomenNzis: TVirtualStringTreeHipp;
    tsExcel: TTabSheet;
    pnlTopExcel: TPanel;
    lblNeosigBremFile: TLabel;
    btnTop: TButton;
    pnlRoleView: TPanelViewRoles;
    btnClearbtn: TButton;
    btnAddButton: TButton;
    icn32lst1: TIcon32List;
    RolPnlDoktorOPL: TPanelRoles;
    RolPnlAdmin: TPanelRoles;
    RolPnlNomen: TPanelRoles;
    RolPnlDoctorSpec: TPanelRoles;
    tsGrid: TTabSheet;
    grdNom: TTeeGrid;
    tsVTR_XML: TTabSheet;
    treeview: TVirtualStringTree;
    tsTreeDBFB: TTabSheet;
    vtrFDB: TVirtualStringTreeHipp;
    tsTempVTR: TTabSheet;
    vtrTemp: TVirtualStringTreeHipp;
    vtrPregledPat: TVirtualStringTreeAspect;
    pnlStatusDB: TPanel;
    pnlMetaDataDB: TPanel;
    pnlDataDB: TPanel;
    pnlWork: TPanel;
    pnlNav: TPanel;
    tsGraph: TTabSheet;
    vtrGraph: TVirtualStringTreeHipp;
    pnlGraph: TPanel;
    edtGraphDay: TEdit;
    lbl1: TLabel;
    tsNomenAnal: TTabSheet;
    tsXML: TTabSheet;
    tlbXml: TToolBar;
    btnXMLSaveAs: TToolButton;
    btnValidateXML: TToolButton;
    edtFind: TEdit;
    ToolButton1: TToolButton;
    btnFindPrev: TToolButton;
    syndtXML: TSynEdit;
    SynXML: TSynXMLSyn;
    lblGuidDB: TLabel;
    lblSizeCMD: TLabel;
    pnlStatusNomenNzis: TPanel;
    lblGuidNomenNzis: TLabel;
    lblSizeNomenNzisCMD: TLabel;
    pnlMetaDataNomenNzis: TPanel;
    pnlDataNomenNzis: TPanel;
    dlgOpenDB: TOpenDialog;
    imgList1: TImageList;
    vtrRecentDB: TVirtualStringTreeHipp;
    tsOptions: TTabSheet;
    vtrOptions: TVirtualStringTreeHipp;
    tsOptionsNotes: TTabSheet;
    imgOptionNote: TImage;
    StatusBar1: TStatusBar;
    fmxCntr1: TFireMonkeyContainer;
    tsFMXForm: TTabSheet;
    fmxCntrDyn: TFireMonkeyContainer;
    btnTestNode: TButton;
    btnAddCL: TButton;
    btn3: TButton;
    grdSearch: TTeeGrid;
    edtFilter: TEdit;
    splSearchGrid: TSplitter;
    btnPull: TButton;
    tmr1: TTimer;
    btn5: TButton;
    dlgOpenPL: TOpenDialog;
    tsVtrSearch: TTabSheet;
    tsExpression: TTabSheet;
    mmoIn: TMemo;
    mmoOut: TMemo;
    btnClc: TButton;
    btnHistNav: TButton;
    appEvntsMain: TApplicationEvents;
    dlgOpenXML_PL: TOpenDialog;
    pnlFiltertemp: TPanel;
    pmTempVtr: TPopupMenu;
    mniExpandSelect: TMenuItem;
    mniCollapseSelect: TMenuItem;
    mniOnlyCloning: TMenuItem;
    mniClearFilter: TMenuItem;
    mniRemontClonings: TMenuItem;
    mniRemontPat: TMenuItem;
    tsNZIS: TTabSheet;
    btnToken: TButton;
    edtToken: TEdit;
    btnSign: TButton;
    edtCertNom: TEdit;
    btnSend: TButton;
    edtUrl: TEdit;
    pnlNzisMessages: TPanel;
    tsVTRDoctors: TTabSheet;
    vtrDoctor: TVirtualStringTreeHipp;
    syndtNzisReq: TSynEdit;
    syndtNzisResp: TSynEdit;
    splNzisReqResp: TSplitter;
    chkLockNzisMess: TCheckBox;
    cbb1: TComboBox;
    cbb2: TComboBox;
    edtSearhTree: TEdit;
    tsProfReg: TTabSheet;
    vtrProfReg: TVirtualStringTreeHipp;
    edtPasword: TEdit;
    lblPasword: TLabel;
    chkPasword: TCheckBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit2: TEdit;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Edit3: TEdit;
    CheckBox2: TCheckBox;
    pnlProfMinaliPreg: TPanel;
    btnNzisProf: TButton;
    btnRemont142: TButton;
    pnlGridTool: TPanel;
    btn6: TButton;
    pnlNomenNzisTool: TPanel;
    btnUpdateNomen: TButton;
    pnlPregImportTool: TPanel;
    btnX006: TButton;
    pmActionPat: TPopupMenu;
    MenuItem1: TMenuItem;
    N2: TMenuItem;
    pmActionPreg: TPopupMenu;
    mniDeletePerm: TMenuItem;
    mniFindDeletedNodes: TMenuItem;
    tlbActions: TToolBar;
    btnSaveAll: TToolButton;
    mniN1: TMenuItem;
    mniSortPat: TMenuItem;
    mniSortEGN: TMenuItem;
    mniAge: TMenuItem;
    tmrHip: TTimer;
    btn7: TToolButton;
    rgNzisMessage: TRadioGroup;
    pnlEditRtf: TPanel;
    btnFind: TButton;
    btn8: TToolButton;
    btnReadL010: TButton;
    il40: TImageList;
    btnTestCert: TButton;
    btnSave088: TButton;
    edtDum: TEdit;
    btn9: TToolButton;
    chkAspectDistr: TCheckBox;
    chkAutamatNzis: TCheckBox;
    btnNextSended: TButton;
    edtTokenTo: TEdit;
    btnIdiNa: TButton;
    rgImun: TRadioGroup;
    chkAutamatL009: TCheckBox;
    rgTipove: TRadioGroup;
    pnlTopVideo: TPanel;
    btnGetSeek: TButton;
    btn10: TToolButton;
    pnlGridSearch: TPanel;
    tlb1: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    mniSortStartPreg: TMenuItem;
    btnhelp: TToolButton;
    btnIn: TButton;
    vtrNewAnal: TVirtualStringTreeAspect;
    btn11: TToolButton;
    btnCert: TToolButton;
    btnSep: TToolButton;
    pmActionPregRev: TPopupMenu;
    mniDeletePerm1: TMenuItem;
    tlbNzisMess: TToolBar;
    pmGrdSearch: TPopupMenu;
    mnimemotest1: TMenuItem;
    pmSearchTable: TPopupMenu;
    mniPregledSearchView: TMenuItem;
    mniPatientSearchView: TMenuItem;
    tsLinkOptions: TTabSheet;
    vtrLinkOptions: TVirtualStringTreeAspect;
    btn12: TButton;
    actmmb1: TActionMainMenuBar;
    fmxCntrTitleBar: TFireMonkeyContainer;
    fmxCntrRoleBar: TFireMonkeyContainer;
    pnlRoleBar: TPanel;
    tsFmxRoleSelect: TTabSheet;
    fmxCntrRoleSelect: TFireMonkeyContainer;
    edt1: TEdit;
    edtFilterTemp: TEdit;
    btnFilldiagInMkb: TButton;
    pnButtons: TPanel;
    btZPlus: TPaintBox;
    btZMinus: TPaintBox;
    btOpen: TPaintBox;
    pbZoomOld: TPaintBox;
    btPageWidth: TPaintBox;
    btFullPage: TPaintBox;
    btActualSize: TPaintBox;
    btAbout: TPaintBox;
    Button3: TButton;
    ToolBar1: TToolBar;
    btnBack: TToolButton;
    ToolButton5: TToolButton;
    btnZoomPlus: TToolButton;
    ToolButton6: TToolButton;
    pnlZoom: TPanel;
    pbZoomNew: TPaintBox;
    btnActualSize: TToolButton;
    btnFullPage: TToolButton;
    btnWidthPage: TToolButton;
    ppZoom: TPopupMenu;
    N101: TMenuItem;
    N251: TMenuItem;
    N501: TMenuItem;
    N1001: TMenuItem;
    N1002: TMenuItem;
    N1251: TMenuItem;
    N1501: TMenuItem;
    N2001: TMenuItem;
    N4001: TMenuItem;
    N8001: TMenuItem;
    N16001: TMenuItem;
    N24001: TMenuItem;
    N32001: TMenuItem;
    N64001: TMenuItem;
    MenuItem2: TMenuItem;
    mnActualSize: TMenuItem;
    mnPageLevel: TMenuItem;
    mnFitWidth: TMenuItem;
    imgListPdf: TImageList;
    tsHtml: TTabSheet;
    btn4: TToolButton;
    btnOldHip: TToolButton;
    btnLoopXml: TButton;
    btnXmlInPat: TButton;
    btnX007: TButton;
    dlgOpenNZIS: TOpenDialog;
    tsNasMesta: TTabSheet;
    vtrLinkNasMesta: TVirtualStringTreeAspect;
    Panel2: TPanel;
    Button4: TButton;
    vtrSearch: TVirtualStringTreeAspect;
    Procedure sizeMove (var msg: TWMSize); message WM_SIZE;
    procedure WMMove(var Msg: TWMMove); message WM_MOVE;
    procedure WMShowGrid(var Msg: TMessage); message WM_SHOW_GRID;
    procedure WMSuperResize(var Msg: TMessage); message WM_Super_Resize;
    procedure WMHipScrollPatient(var Msg: TMessage); message WM_Hip_Scroll_Patient;
    procedure WMHipDeactivate(var Msg: TMessage); message WM_Hip_Deactivate;
    procedure WMNzisSetNrn(var Msg: TMessage); message WM_Nzis_Set_NRN;
    procedure WMNzisSetPlaned(var Msg: TMessage); message WM_Nzis_Set_Planed;
    procedure WMCertStorage(var Msg: TMessage); message WM_Cert_Storage;
    procedure WMHelp(var Msg: TWMHelp); message WM_HELP;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure CMDialogKey(var Msg: TCMDialogKey); message CM_DIALOGKEY;
    procedure WMNCACTIVATE(var M: TWMNCACTIVATE); message WM_NCACTIVATE;
    procedure WmGetMinMaxInfo(var Msg: TMessage); message WM_GETMINMAXINFO;
    procedure WM_NCCALCSIZE(var Msg: TMessage); message WM_NCCALCSIZE;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure FormCreate(Sender: TObject);
    procedure vtrPreglediChange_Patients(Sender: TBaseVirtualTree; ANode: PVirtualNode);
    procedure vtrPreglediChange_Pregledi(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrPreglediHotChange(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure vtrPreglediInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure btnFilterClick(Sender: TObject);
    procedure vtrMinaliPreglediBeforeAutoFitColumn(Sender: TVTHeader; Column: TColumnIndex; var SmartAutoFitType: TSmartAutoFitType; var Allowed: Boolean);
    procedure Edit1Change(Sender: TObject);
    procedure vTrTestGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure Panel2MouseEnter(Sender: TObject);
    procedure Panel2MouseLeave(Sender: TObject);
    procedure rlbtn1Click(Sender: TObject);
    procedure btnSpisyciClick(Sender: TObject);
    procedure vtrSpisyciNodeClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
    procedure vtrSpisyciAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellRect: TRect);
    procedure vtrSpisyciGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure btnPrevOtcetPeriodClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveUnfavClick(Sender: TObject);
    procedure vtrSpisyciCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vtrSpisyciDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string;
      const CellRect: TRect; var DefaultDraw: Boolean);
    procedure vtrSpisyciInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure ButtonedEdit1Change(Sender: TObject);
    procedure ButtonedEdit1RightButtonClick(Sender: TObject);
    procedure ButtonedEdit1DblClick(Sender: TObject);
    procedure ButtonedEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure vtrSpisyciMouseEnter(Sender: TObject);
    procedure lblHintClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure rlbtnNzisNomenClick(Sender: TObject);
    procedure btnPatListClick(Sender: TObject);
    procedure vtrHelpHipGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure btnRTFClick(Sender: TObject);
    procedure tsVideoShow(Sender: TObject);
    procedure scrlbxRoleMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure vtrPreglediGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure rlbtnSubPreg_PatClick(Sender: TObject);
    procedure rlbtnSubPreg_PregClick(Sender: TObject);
    procedure RolPnl1Click(Sender: TObject);
    procedure vtrRoleGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure rlbtn3Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
   // procedure btnHelpClick(Sender: TObject);
    procedure btnManagerClick(Sender: TObject);
    procedure tsRoleDescrShow(Sender: TObject);
    procedure vtrHelpHipChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure lblDescrDblClick(Sender: TObject);
    procedure pnlTreeResize(Sender: TObject);
    procedure btnClearbtnClick(Sender: TObject);
    procedure btnAddButtonClick(Sender: TObject);
    procedure scrlbxRoleClick(Sender: TObject);
    procedure RolPnlAdminStartRole(Sender: TObject);
    procedure RolPnlDoktorOPLStartRole(Sender: TObject);
    procedure RolPnlNomenStartRole(Sender: TObject);
    procedure RolPnlDoctorSpecStartRole(Sender: TObject);
    procedure SubButtonNomenExcelClick(Sender: TObject);
    procedure NzisNomenClick(Sender: TObject);
    procedure vtrNomenNzisGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure SubButtonNomenXMLClick(Sender: TObject);
    procedure vtrNomenNzisDrawButton(sender: TVirtualStringTreeHipp; node: PVirtualNode; var ButonVisible: Boolean; const numButton: Integer;
      var imageIndex: Integer);
    procedure vtrNomenNzisButtonClick(sender: TVirtualStringTreeHipp; node: PVirtualNode; const numButton: Integer);
    procedure vtrNomenNzisGetImageIndexEx(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean;
      var ImageIndex: TImageIndex; var ImageList: TCustomImageList);
    procedure vtrNomenNzisChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrNomenNzisInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure treeviewGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure tsVideoHide(Sender: TObject);
    procedure pnlRoleViewRoleButtonClick(Sender: TObject);
    procedure AdminFDBClick(Sender: TObject);
    procedure vtrFDBGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure SubButonImportFDBClick(Sender: TObject);
    procedure vtrFDBChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure ImportPL_NZOK(Sender: TObject);
    procedure ImportPR001(TempColl: TPR001Coll);
    procedure FillListPL_NZOKFromDB(uin: string; collPat: TRealPatientNewColl);
    procedure FillListPL_ADB(collPat: TRealPatientNewColl);
    procedure Button1Click(Sender: TObject);
    procedure HoverChange(Sender: TObject);
    procedure ColMoved(const ACol: TColumn; const OldCol, NewCol: integer);
    procedure vtrPregledPatGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrPregledPatDrawButton(sender: TVirtualStringTreeAspect; node: PVirtualNode; var ButonVisible: Boolean; const numButton: Integer;
      var imageIndex: Integer);
    procedure vtrFDBDrawButton(sender: TVirtualStringTreeHipp; node: PVirtualNode; var ButonVisible: Boolean; const numButton: Integer;
      var imageIndex: Integer);
    procedure vtrFDBButtonClick(sender: TVirtualStringTreeHipp; node: PVirtualNode; const numButton: Integer);
    procedure vtrMinaliPreglediGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure PreglediClick(Sender: TObject);
    procedure pnlRoleViewMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure vtrGraphGetText1(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrGraphInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure ProfGraphClick(Sender: TObject);
    procedure edtGraphDayChange(Sender: TObject);
    procedure vtrGraphChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure Button2Click(Sender: TObject);
    procedure HipNomenAnalsClick(Sender: TObject);
    procedure vtrNewAnalGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrRecentDBGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrRecentDBChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OptionsClick(Sender: TObject);
    procedure vtrRecentDBKeyPress(Sender: TObject; var Key: Char);
    procedure imgOptionNoteClick(Sender: TObject);
    procedure vtrOptionsCreateEditor(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
    procedure vtrOptionsEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure vtrOptionsFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrOptionsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrOptionsGetText1(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure FireMonkeyContainer1CreateFMXForm(var Form: TCommonCustomForm);
    procedure fmxCntr1CreateFMXForm(var Form: TCommonCustomForm);
    procedure fmxCntrDynCreateFMXForm(var Form: TCommonCustomForm);
    procedure vtrRecentDBDrawButton(sender: TVirtualStringTreeHipp; node: PVirtualNode; var ButonVisible: Boolean; const numButton: Integer;
      var imageIndex: Integer);
    procedure vtrRecentDBButtonClick(sender: TVirtualStringTreeHipp; node: PVirtualNode; const numButton: Integer);
    procedure btnTestNodeClick(Sender: TObject);
    procedure btnAddCLClick(Sender: TObject);
    procedure vtrNomenNzisEdited(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure vtrNomenNzisNewText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; NewText: string);
    procedure tsTreePatShow(Sender: TObject);
    procedure scrlbx1Resize(Sender: TObject);
    procedure ckb1Enter(Sender: TObject);
    procedure fmxCntrButtonsCreateFMXForm(var Form: TCommonCustomForm);
    procedure edtFilterEnter(Sender: TObject);
    procedure edtFilterChange(Sender: TObject);
    procedure btnPullClick(Sender: TObject);
    procedure splSearchGridMoved(Sender: TObject);
    procedure fmxCntrDynDestroyFMXForm(var Form: TCommonCustomForm; var Action: TCloseHostedFMXFormAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure fmxCntrDynActivateForm(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure vtrTempChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrTempChangeSelectMKB(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrSearchGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrSearchChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tsFMXFormResize(Sender: TObject);
    procedure btnClcClick(Sender: TObject);
    procedure pgcWorkResize(Sender: TObject);
    procedure vtrOptionsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure pgcTreeChange(Sender: TObject);
    procedure btnHistNavClick(Sender: TObject);
    procedure appEvntsMainShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure vtrTempDrawButton(sender: TVirtualStringTreeHipp; node: PVirtualNode; var ButonVisible: Boolean; const numButton: Integer;
      var imageIndex: Integer);
    procedure vtrTempButtonClick(sender: TVirtualStringTreeHipp; node: PVirtualNode; const numButton: Integer);
    procedure mniExpandSelectClick(Sender: TObject);
    procedure mniCollapseSelectClick(Sender: TObject);
    procedure mniOnlyCloningClick(Sender: TObject);
    procedure mniClearFilterClick(Sender: TObject);
    procedure mniRemontCloningsClick(Sender: TObject);
    procedure mniRemontPatClick(Sender: TObject);
    procedure grdSearchSelect(Sender: TObject);
    procedure vtrNomenNzisColumnClick(Sender: TBaseVirtualTree; Column: TColumnIndex; Shift: TShiftState);
    procedure mniNomenNzisClick(Sender: TObject);
    procedure btnTokenClick(Sender: TObject);
    procedure btnSignClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure pgcWorkChange(Sender: TObject);
    procedure grdNomCellEditing(const Sender: TObject; const AEditor: TControl; const AColumn: TColumn; const ARow: Integer);
    procedure mniDataDoctorsClick(Sender: TObject);
    procedure vtrDoctorGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrDoctorDrawButton(sender: TVirtualStringTreeHipp; node: PVirtualNode; var ButonVisible: Boolean; const numButton: Integer;
      var imageIndex: Integer);
    procedure vtrDoctorButtonClick(sender: TVirtualStringTreeHipp; node: PVirtualNode; const numButton: Integer);
    procedure vtrPregledPatExpanded(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrPregledPatCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrMinaliPreglediCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vtrPregledPatColumnClick(Sender: TBaseVirtualTree; Column: TColumnIndex; Shift: TShiftState);
    procedure vtrPregledPatKeyPress(Sender: TObject; var Key: Char);
    procedure vtrPregledPatKeyAction(Sender: TBaseVirtualTree; var CharCode: Word; var Shift: TShiftState; var DoDefault: Boolean);
    procedure vtrPregledPatAdvancedHeaderDraw(Sender: TVTHeader; var PaintInfo: THeaderPaintInfo; const Elements: THeaderPaintElements);
    procedure vtrGraphCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vtrGraphGetImageIndexEx(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean;
      var ImageIndex: TImageIndex; var ImageList: TCustomImageList);
    procedure vtrProfRegGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure edtSearhTreeChange(Sender: TObject);
    procedure vtrPregledPatDrawText1(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string;
      const CellRect: TRect; var DefaultDraw: Boolean);
    procedure pnlRoleViewClick(Sender: TObject);
    procedure vtrMinaliPreglediDrawButton(sender: TVirtualStringTreeHipp; node: PVirtualNode; var ButonVisible: Boolean; const numButton: Integer;
      var imageIndex: Integer);
    procedure vtrMinaliPreglediColumnClick(Sender: TBaseVirtualTree; Column: TColumnIndex; Shift: TShiftState);
    procedure vtrMinaliPreglediAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellRect: TRect);
    procedure vtrGraphNodeClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
    procedure pnlGraphClick(Sender: TObject);
    procedure btnRemont142Click(Sender: TObject);
    procedure vtrPregledPatCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure appEvntsMainException(Sender: TObject; E: Exception);
    procedure btnNzisProfClick(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btnUpdateNomenClick(Sender: TObject);
    procedure btnX006Click(Sender: TObject);
    procedure vtrPregledPatGetPopupMenu(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; const P: TPoint;
      var AskParent: Boolean; var PopupMenu: TPopupMenu);
    procedure appEvntsMainShowHint(var HintStr: string; var CanShow: Boolean;
      var HintInfo: THintInfo);
    procedure mniDeletePermClick(Sender: TObject);
    procedure mniFindDeletedNodesClick(Sender: TObject);
    procedure tlbActionsClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure mniN1Click(Sender: TObject);
    procedure mniSortEGNClick(Sender: TObject);
    procedure mniAgeClick(Sender: TObject);
    procedure btnSaveAllClick(Sender: TObject);
    procedure tmrHipTimer(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure btnReadL010Click(Sender: TObject);
    procedure btnTestCertClick(Sender: TObject);
    procedure btnSave088Click(Sender: TObject);
    procedure grdNomCellEdited(const Sender: TObject; const AEditor: TControl;
      const AColumn: TColumn; const ARow: Integer; var ChangeData: Boolean;
      var NewData: string);
    procedure chkAspectDistrClick(Sender: TObject);
    procedure btnNextSendedClick(Sender: TObject);
    procedure grdNomDblClick(Sender: TObject);
    procedure btnIdiNaClick(Sender: TObject);
    procedure vtrPregledPatGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: TImageIndex;
      var ImageList: TCustomImageList);
    procedure rgTipoveClick(Sender: TObject);
    procedure btnGetSeekClick(Sender: TObject);
    procedure btn9Click(Sender: TObject);
    procedure btn10Click(Sender: TObject);
    procedure mniSortStartPregClick(Sender: TObject);
    procedure tsFMXFormMouseEnter(Sender: TObject);
    procedure grdSearchMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure appEvntsMainMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnInClick(Sender: TObject);
    procedure URLClick(Sender: TObject;const URL: string; Button: TMouseButton );
    procedure ToolButton5Click(Sender: TObject);
    procedure grdNomSelect(Sender: TObject);
    procedure vtrNewAnalInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtrNewAnalMeasureItem(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
    procedure btn11Click(Sender: TObject);
    procedure CertStorageUpdate(Sender: TObject);
    procedure vtrDoctorNodeCopying(Sender: TBaseVirtualTree; Node,
      Target: PVirtualNode; var Allowed: Boolean);
    procedure vtrDoctorNodeCopied(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrDoctorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vtrDoctorKeyAction(Sender: TBaseVirtualTree; var CharCode: Word;
      var Shift: TShiftState; var DoDefault: Boolean);
    procedure btnCertClick(Sender: TObject);
    procedure mniDeletePerm1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure grdSearchMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlGridSearchMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure mnimemotest1Click(Sender: TObject);
    procedure mniPregledSearchViewClick(Sender: TObject);
    procedure mniPatientSearchViewClick(Sender: TObject);
    procedure vtrLinkOptionsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure btn12Click(Sender: TObject);
    procedure vtrPregledPatNodeCopying(Sender: TBaseVirtualTree; Node,
      Target: PVirtualNode; var Allowed: Boolean);
    procedure vtrPregledPatNodeCopied(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vtrPregledPatSaveNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Stream: TStream);
    procedure vtrNewAnalSaveNode(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Stream: TStream);
    procedure vtrTempMeasureItem1(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
    procedure mniAnalsClick(Sender: TObject);
    procedure mniMkb10Click(Sender: TObject);
    procedure mniNzisNomenClick(Sender: TObject);
    procedure dtp1Change(Sender: TObject);
    procedure fmxCntrTitleBarCreateFMXForm(var Form: TCommonCustomForm);
    procedure syndtNzisReqMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure syndtNzisReqMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    function appEvntsMainHelp(Command: Word; Data: NativeInt;
      var CallHelp: Boolean): Boolean;
    procedure fmxCntrRoleBarCreateFMXForm(var Form: TCommonCustomForm);
    procedure pnlRoleBarResize(Sender: TObject);
    procedure fmxCntrRoleSelectCreateFMXForm(var Form: TCommonCustomForm);
    procedure vtrLinkOptionsDragAllowed(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure vtrLinkOptionsDragOver(Sender: TBaseVirtualTree; Source: TObject;
      Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
      var Effect: Integer; var Accept: Boolean);
    procedure vtrLinkOptionsDragDrop(Sender: TBaseVirtualTree; Source: TObject;
      DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
      Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure vtrLinkOptionsDragDropFMX(Sender: TObject;
      var IsDropted: Boolean);
    procedure vtrLinkOptionsChange(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure grdSearchMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vtrTempColumnClick1(Sender: TBaseVirtualTree; Column: TColumnIndex;
      Shift: TShiftState);
    procedure vtrTempGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: TImageIndex;
      var ImageList: TCustomImageList);
    procedure vtrRecentDBMeasureTextHeight(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      const Text: string; var Extent: Integer);
    procedure vtrTempDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; const Text: string;
      const CellRect: TRect; var DefaultDraw: Boolean);
    procedure vtrPregledPatHeaderDrawQueryElements(Sender: TVTHeader;
      var PaintInfo: THeaderPaintInfo; var Elements: THeaderPaintElements);
    procedure vtrTempChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrTempExpanded(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtrTempCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure edtFilterTempChangeMKB(Sender: TObject);
    procedure vtrTempBeforePaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas);
    procedure vtrTempAfterPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas);
    procedure vtrTempColumnResize(Sender: TVTHeader; Column: TColumnIndex);
    procedure spl1Moved(Sender: TObject);
    procedure btnFilldiagInMkbClick(Sender: TObject);
    procedure fmxCntrDynDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure vtrPregledPatDragOver(Sender: TBaseVirtualTree; Source: TObject;
      Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
      var Effect: Integer; var Accept: Boolean);
    procedure vtrTempMeasureItem(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
    procedure vtrTempColumnClick(Sender: TBaseVirtualTree; Column: TColumnIndex;
      Shift: TShiftState);
    procedure vtrTempKeyPress(Sender: TObject; var Key: Char);
    procedure vtrTempKeyAction(Sender: TBaseVirtualTree; var CharCode: Word;
      var Shift: TShiftState; var DoDefault: Boolean);
    procedure vtrPregledPatMouseLeave(Sender: TObject);
    procedure vtrGraphGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrPregledPatDrawText(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
    procedure tsHtmlShow(Sender: TObject);
    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btnOldHipClick(Sender: TObject);
    procedure vtrTempGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrTempGetText1(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrTempCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure btnLoopXmlClick(Sender: TObject);
    procedure btnXmlInPatClick(Sender: TObject);
    procedure btnX007Click(Sender: TObject);
    procedure vtrLinkOptionsChecking(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
    procedure vtrSearchDrawButton(sender: TVirtualStringTreeAspect;
      node: PVirtualNode; var ButonVisible: Boolean; const numButton: Integer;
      var imageIndex: Integer);
    procedure vtrSearchShowHintButton(sender: TVirtualStringTreeAspect;
      node: PVirtualNode; const numButton: Integer; r: TRect);
    procedure vtrSearchButtonClick(sender: TVirtualStringTreeAspect;
      node: PVirtualNode; const numButton: Integer);
  private  //RootNodes;
    vRootRole: PVirtualNode;
    vRootNomenNzis: PVirtualNode;
    vRootNzisBiznes: PVirtualNode;
    vRootGraph: PVirtualNode;
    vRootRecentDB: PVirtualNode;

    vRemontPL, vNZOK_HIP, vNZOK, vHIP, v, vCloning, vPreg: PVirtualNode;
    vHipOtpisani, vHipZapisani, vHipNovi: PVirtualNode;

    vTablesRoot: PVirtualNode;
    vNomenMKB: PVirtualNode;


    Ticker : TGridTicker;
    thrHistPerf: ThistoryThread;
    thrAspPerf: TAspectPerformerThread;
    thrSearch: TSearchThread;
    thrCert: TCertThread;
    usb: TComponentUSB;


    gADB_Dir: string;
    gAppDir: string;
    gHipAdbFileName: string;
    gHipLinkFileName: string;

    CertStorage: TsbxCertificateStorage;
    procedure WMStartEditing(var Message: TMessage); message WM_STARTEDITING;

  private

    Fdm: TDUNzis;
    frRTF: frxRichEdit.TRxRichEdit;
    httpNZIS: TElHTTPSClient;
    WinCertStorage: TElWinCertStorage;
    //CertIndex: Integer;
    CurrentCert: TelX509Certificate;
    CertForThread: TelX509Certificate;
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    maxCountPregledInPat: Integer;
    listFilterCount: TList<Integer>;
    //FilterList: TFilterList;
    FilterStringsHave: TList<TString>;
    FilterStringsNotHave: TList<TString>;
    cntPregled, cntPacient: Integer;
    FFilterCountPregled: integer;
    FSearchTextSpisyci: string;
    FHandleSB_Hip: THandle;
    vPregledi: PVirtualNode;
    DataVPregledi: PAspRec;
    CounterObj: Integer;
    xlsHipp: TXLSSpreadSheet;
    FFDbName: string;
    Option: TOptions;
    IsIndexedPregled: Boolean;
    bindExpr: TBindingExpression;
    FEgnProf: string;
    FSortPat: TSortPat;



    procedure WMSetPatID(var Msg : TMessage); message WM_SET_PAT_ID;
    procedure WmAfterShow(var Msg: TMessage); message WM_AFTER_SHOW;
    procedure WmAfterLoadDB(var Msg: TMessage); message WM_AFTER_LOAD_DB;
    procedure WmProgresLoadDB(var Msg: TMessage); message WM_PROGRES_LOAD_DB;
    procedure WmCntLoadDB(var Msg: TMessage); message WM_CNT_LOAD_DB;
    procedure WmSendedNzis(var Msg: TMessage); message WM_SENDED_NZIS;


    procedure TerminateLoadDB(Sender: TObject);
    procedure LoadDbOnProgres(sender: TObject; collType, progres: Integer);
    procedure LoadDbOnCNT(sender: TObject; collType, cnt: Integer);

    procedure IterateSendedNzisNomen(Sender: TBaseVirtualTree; Node: PVirtualNode;
          AData: Pointer; var Abort: Boolean);
    procedure IterateSendedNzisXmlToCL(Sender: TBaseVirtualTree; Node: PVirtualNode;
          AData: Pointer; var Abort: Boolean);

   procedure HideTabs;
   procedure initDB;
   procedure InitHttpNzis;
   procedure LoadADB;
   procedure OpenDB(index: Integer);
   procedure OpenADB(ADB: TMappedFile);
   procedure OpenCmd(ADB: TMappedFile);
   procedure OpenCmdNomenNzis(ADBNomenNzis: TMappedFile);
   procedure OpenLinkPatPreg(LNK: TMappedFile);
   procedure OpenLinkNomenHipAnals;
   procedure InitVTRs;
   procedure LoadLinkOptions;
   procedure LoadLinkFilter;
   //procedure InitColl;
   //procedure FreeColl;
   procedure FreeFMXDin;
   //procedure ClearColl;
   procedure InitAdb;
   procedure InitExpression;
   procedure InitFMXDyn;
   procedure InitGlobalValues;
   procedure UpdateUnfav;
   procedure OnChangeYear(sender: TObject);
   procedure FillUnfavInDoctor;
   procedure SetSearchTextSpisyci(const Value: string);
   procedure CheckForUpdate;
   procedure CheckCollForSave;
   procedure CheckCollForInsert;
   procedure FindDoctor(Down: Boolean);
   function GetFDbName: string;
   procedure AddToListNodes(data: PAspRec);
   procedure GrdSearhKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
   procedure SelectFileOrFolderInExplorer(const sFilename: string);

  protected
    procedure BtnSendToNzisNomen(node: PVirtualNode);
    procedure BtnSendToNzisNomenUpdate(node: PVirtualNode);
    procedure BtnXMLtoCL000(node: PVirtualNode);
    procedure BtnXMLtoCL000ForUpdate(node: PVirtualNode);
    procedure LoadFromNzisNewNomen(nomenId: integer);
    procedure RemontCl142;
    procedure OnProcess(streamSize, streamPos: integer);
    procedure UpdateRoot(const root: ISuperObject; Cl000Coll: TCL000EntryCollection);
    procedure GetTextToDraw(node: PVirtualNode; Column: TColumnIndex; var text: string; var strPred, strSled, filterText: string);

  protected // tempObjects
    PregledTemp: TPregledNewItem;
    preg1, preg2: TPregledNewItem;

    //DiagTemp: TDiagnosisItem;
    MDNTemp: TMDNItem;
    MNTemp: TBLANKA_MED_NAPRItem;
    MnLkkTemp: TRealEXAM_LKKItem;

    //ProfCardTemp: t
    ExamAnalTemp: TExamAnalysisItem;
    //DoctorTemp: TDoctorItem;
    AnalTemp: TAnalsNewItem;
    Cl022temp: TCL022Item;
    CL132Temp: TRealCl132Item;
    PR001Temp: TRealPR001Item;
    CL088Temp: TRealCl088Item;
    ProcTemp: TRealProceduresItem;
    //FPatientTemp: TRealPatientNewItem;
    NZIS_PLANNED_TYPETemp: TRealNZIS_PLANNED_TYPEItem;
    NZIS_QUESTIONNAIRE_RESPONSETemp: TRealNZIS_QUESTIONNAIRE_RESPONSEItem;
    NZIS_QUESTIONNAIRE_ANSWERTemp: TRealNZIS_QUESTIONNAIRE_ANSWERItem;
    NZIS_ANSWER_VALUETemp: TRealNZIS_ANSWER_VALUEItem;
    NZIS_DIAGNOSTIC_REPORTTemp: TRealNZIS_DIAGNOSTIC_REPORTItem;
    NZIS_Result_DIAGNOSTIC_REPORTTemp: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
   // procedure SetPatientTemp(const Value: TRealPatientNewItem);
   // property PatientTemp: TRealPatientNewItem read FPatientTemp write SetPatientTemp;


  protected
    procedure DoUSBArrival(sender: TObject);
    procedure DoUSBRemove(sender: TObject);

  protected  // iterate
    procedure IterateFilterGraph(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure IterateFilterOnlyCloning(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure IterateRemoveFilter(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure IterateRemontPat(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure IterateTestEmpty(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure IterateTempExpand(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure IterateTempCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);


  protected  //fill
    procedure FillPregledInPat;
    procedure FillIncMdnInPat;
    procedure FillIncMNInPat;
    procedure FillOtherDocInIncMN;
    procedure FillIncMNInPRegNrn;
    procedure FillIncMNInPRegNomer;
    procedure FillPatInDoctor;
    procedure FillDoctorInPregled;
    procedure FillOwnerDoctorInPrgled;
    procedure FillExamAnalInMDN;
    procedure FillAnalInExamAnal;
    procedure FillSecInPrim(pat: TRealPatientNewItem);

  protected //loads
    ListHistoryNav: TList<THistoryNav>;
    procedure LoadVtrPregledOnPat;

  protected //FMX
    FmxWScreen: TfrmWelcomeScreen;
    FmxFinderFrm: TfrmFinder;
    FmxProfForm: TfrmProfFormFMX;
    FmxImportNzisFrm: TfrmImportNzis;
    FmxTokensForm: TfrmFmxTokens;
    FmxTitleBar: TfrmTitlebar;
    FmxRoleBar: TfrmRolebar;
    FmxRolePanel: TfrmRolePanels;
    FmxOptionsFrm: TfrmOptionsForm;
    procedure ShowHint;

    // menu title bar
    procedure miListMedicineClick(Sender: TObject);
    procedure miListICDClick(Sender: TObject);
    procedure miListAnalysisClick(Sender: TObject);
    procedure miMainExaminationClick(Sender: TObject);
    procedure mniSetingsClick(Sender: TObject);
    procedure mniDbTablesClick(Sender: TObject);
    procedure mniImportNzisClick(Sender: TObject);
    procedure mniJurnalNzisClick(Sender: TObject);
    procedure mniNasMestoClick(Sender: TObject);
    procedure miListDoctorClick(Sender: TObject);

    procedure ExportNzisToDb;
    procedure RunInPat(patient: TRealPatientNewItem; isNew: Boolean);
    procedure RunInIncMN(IncMn: TRealINC_NAPRItem; isNew: Boolean);
    procedure RunInPregled(Preg: TRealPregledNewItem; isNew: Boolean);

    procedure FindDiagInMDN;
    procedure TestMagicIndex;
    procedure TestMagicIndex1;
    procedure DumpAdbPathIndex;


  protected // TempVtr
    tmpVtr: TTempVtrHelper;
    procedure vtrSincPLGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
        TextType: TVSTTextType; var CellText: string);

  private
    FTestPlaned: Boolean; //sign
    procedure UpdateCertificates(certNom: string);
    procedure FormatText(Sender: TObject; var Text: XMLString;
            TextType: TElXMLTextType; Level: Integer; const Path: XMLString);
    property TestPlaned: Boolean read FTestPlaned write FTestPlaned;
  public //importNzis
    vPatImportNzis, vImportNzis,
    vImportNzisPregled, vImportNzisNapr, vImportNzisRec, vImportNzisImun,
    vImportNzisHosp, vImportNzisObshti: PVirtualNode;

    LstXXXX: TList<TNzisReqRespItem>;
    LstRMDN: TList<TNzisReqRespItem>;
    LstRMN: TList<TNzisReqRespItem>;
    lstRVSD: TList<TNzisReqRespItem>;
    lstRHosp: TList<TNzisReqRespItem>;
    lstRMedExpert: TList<TNzisReqRespItem>;
    LstRIncMN: TList<TRealINC_NAPRItem>;
    ImpNzis: TNzisImport;
    procedure LoadTempVtrMSG;
    procedure LoadTempVtrMSG1;
    procedure LoadTempVtrMSG2;
    procedure LoadTempVtrMSG3;
    procedure LoadTempVtrMSG4;

    procedure AddNzisImport;
    procedure FillMsgInPatient;
    procedure FillMsgXXXInPregled;
    procedure FillMsgRIncMNInIncMN;
    procedure FillPregledInIncMN;
    procedure FillMsgRMdnInMdn;
    procedure FillReferalMdnInPreg;
    procedure FillPregInPat;
    procedure FillIncMnInPatImport;
    procedure RemoveFreePatient;
    procedure FillMsgInPregled;
    procedure FillADBInMsgColl;
    procedure FillIncDoctor;
    procedure FillRespInReq;
    procedure AddNewPatXXX;
    procedure AddNewPreg;
    procedure AddNewMdn;

    //procedure LoopXml;
    procedure RemoveDublPat;
    procedure Delete99;
    procedure CheckDublePat;
  public
    scale: Double;
    HipHandle: THandle;
    
    AZipHelpFile: TZipFile;
    DownloadedStream: TStream;
    //ListNomenNzisNames: TList<TNomenNzisRec>;
    ActiveMainButton: TRoleButton;
    ActiveSubButton: TRoleButton;
    StreamData: TMemoryStream;
    XMLStreamC001: TStringStream;
    FRoot: ISuperObject;
    CurrentID: Integer;
    currentType: TCL000Vid;
    currentIndex: Integer;

    AspectsNomFile : TMappedFile;
    AspectsNomHipFile : TMappedFile;
    //AspectsHipFile : TMappedFile;
    AspectsLinkPatPregFile : TMappedLinkFile;
    AspectsLinkNomenHipAnalFile : TMappedFile;
    AspectsOptionsLinkFile: TMappedLinkFile;
    AspectsFilterLinkFile: TMappedLinkFile;

    profGR: TProfGraph;

    streamCmdFile: TFileCmdStream;
    streamCmdFileTemp: TFileCmdStream;
    streamCmdFileNomenNzis: TFileCmdStream;
    FDBHelper: TDbHelper;
    FNasMesto: TRealNasMestoAspects;
    //nzisXml: TNzisXMLHelper;
    Adb_DM: TADBDataModule;
    ResultNzisToken: TStringList;
    token: string;
    TokenToTime: TDateTime;
    InXmlStream: TStringStream;
    FCertificate: TElX509Certificate;
    streamRes: TMemoryStream;
    FinderRec: TFinderRec;
    FinderRecMKB: TFinderRec;
    KeyCNT: boolean;
    EditorGrid: TWinControl;
    DragObj: TDropFmxObject;
    CanSelectNodeFromSearchGrid: Boolean;
    vtrTempTopNode: PVirtualNode;

    procedure LoadThreadDB(dbName: string);
    procedure StartHistoryThread(dbName: string);
    procedure StartCertThread();
    procedure StartAspectPerformerThread();

    procedure FillMedNaprInPregled;
    procedure FillMedNapr3AInPregled;
    procedure FillMedNaprHospInPregled;
    procedure FillMedNaprLkkInPregled;
    procedure FillSpecNzisInMedNapr;
    procedure FillImunInPregled;
    procedure FillMDN_inPregled;
    procedure FillPrfCard_inPregled;
    procedure LoadVtrMinaliPregledi(node: PVirtualNode; Apat: TRealPatientNewItem = nil);
    procedure LoadVtrSpisyciNeblUsl;
    procedure SortListString(list: TList<TString>);
    procedure SortListCollType(list: TList<word>);
    //procedure ImportPatFromPIS;
    procedure FillPatListPisInPatDB(uin: string; Acolpat: TRealPatientNewColl);
    procedure CopyNodesFromAspectToTempVtr(vtrAspect: TVirtualStringTreeAspect; nodeAspect: PVirtualNode);

    procedure unzipRTFHelp(zipFile: string);

    procedure LoadVtrNomenNzis(NomenNamesFile: string);
    procedure LoadVtrNomenNzis1;
    procedure LoadVtrNomenNzis2;
    procedure LoadVtrFDB;
    procedure LoadVtrSearch;
    procedure LoadVtrProfReg;
    procedure LoadVtrProfReg1;

    procedure prepareHeaders(Sender: TObject; Headers: TStringList);
    procedure OnDataNzis(Sender: TObject; Buffer: Pointer; Size: Integer);
    procedure FillXmlC001(NomenID: string);//номенклатура
    procedure NzisOnSended(Sender: TObject);
    procedure OpenExcels;
    procedure OpenBufNomenNzis(FileName: string);
    procedure OpenBufNomenHip(FileName: string);
    procedure ShowPregledFMX(dataPat,dataPreg: PAspRec; linkPreg:PVirtualNode );
    procedure ShowTokensFMX();
    procedure ShowOptionsFMX();
    procedure FindADB(AGUID: TList<TGUID>);
    procedure FindLNK(AGUID: TGUID);
    procedure CalcStatusDB;
    procedure AddCl(cl: string);
    procedure RefreshEvent(sender: TObject);
    procedure DeleteEvent(sender: TObject);
    procedure FormFMXMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure OnShowGridSearch(sender: TObject);
    procedure OnActivateFMX(sender: TObject);
    procedure ActiveControlChanged(Sender: TObject);
    procedure OnSetTextSearch(Sender: TObject);
    procedure OnSetTextSearchEDT(Vid: TVtrVid; Text: string; field: Word; Condition: TConditionSet);
    procedure OnShowFindFprm(Sender: TObject);
    procedure OnIndexedPregled(Sender: TObject);
    procedure LinkpatClick(Sender: TObject);
    procedure StatePatLogChange(Sender: TObject);
    procedure LinkPregClick(Sender: TObject);
    procedure edtChangeCOP(Sender: TObject);
    procedure StartFinder;
    procedure StartSaver;
    procedure StartInserter;
    procedure FindOldItemsForInsert;
    function FindPatientByDataPos(datapos: cardinal): PVirtualNode;// от линк-а
    procedure SignDocumentHipNzis(DokumentType: TDokumentSignType; posdata: cardinal);
    procedure SignX000All(pregledId, senderID: Integer; CertNom: string; NzisStatus: THipPregledStatus);
    procedure TerminateNzisX000(Sender: TObject);
    procedure RemontCloning;
    procedure RemontPat;
    function FillRealPregledForNzis(linkNode: PVirtualNode): TRealPregledNewItem;
    procedure httpNZISDataToken(Sender: TObject; Buffer: Pointer; Size: Integer);
    procedure httpNZISDataSender(Sender: TObject; Buffer: Pointer; Size: Integer);
    procedure ReadToken(str: string);
    function CheckTokenFromCert: Boolean;
    procedure httpNZISCertificateNeededEx(Sender: TObject;
      var Certificate: TElX509Certificate);
    procedure httpNZISCertificateValidate(Sender: TObject;
      X509Certificate: TElX509Certificate; var Validity: TSBCertificateValidity;
      var Reason: TSBCertificateValidityReason);
    procedure httpNZISPreparedHeaders(Sender: TObject; Headers: TElStringList);virtual;
    procedure InternalChangeWorkPage(Sheet: TTabSheet);
    procedure InternalChangeTreePage(Sheet: TTabSheet);
    procedure LoadVtrDoctor;
    procedure FillCertInDoctors;
    procedure FillDiagInMkb;
    function FindCertFromSerNumber(serNom: TArray<System.Byte>): TElX509Certificate;
    procedure GetPatProf(var pat: TRealPatientNewItem);
    procedure GetCurrentPatProf(pat: TRealPatientNewItem);
    procedure GetCurrentPatProf1(pat: TRealPatientNewItem);
    procedure FillOldPlanesInCurrentPlan;
    function FindNodevtrPreg(DirectionFind: TDirectionFinder; ACol: TColumnIndex): boolean;
    function FindNodevtrTemp(DirectionFind: TDirectionFinder; ACol: TColumnIndex): boolean;
    //function FindNodevtr(DirectionFind: TDirectionFinder; vtr: TVirtualStringTree): boolean;
    procedure AddNewPregled;
    procedure AddNewDiag(vPreg: PVirtualNode; cl011, cl011Add: string; rank: integer; DataPosMkb: cardinal);
    procedure RemoveDiag(vPreg: PVirtualNode; diag: TRealDiagnosisItem); overload;
    procedure RemoveDiag(vPreg: PVirtualNode; diagDataPos: cardinal); overload;
    procedure AddNewPlan(vPreg: PVirtualNode; var gr: TGraphPeriod132; var TreeLinkPlan: PVirtualNode);
    //procedure AddNewPregledOld;
    procedure AddX005Pregled(preg: TRealPregledNewItem);
    procedure AddMdnInPregled(sender: tobject; var PregledLink, MdnLink: PVirtualNode;
         var TempItem: TRealMDNItem);
    procedure AddMnInPregled(sender: tobject; var PregledLink, MnLink: PVirtualNode;
         var TempItem: TRealBLANKA_MED_NAPRItem);
    procedure DeleteMdnFromPregled(sender: tobject; var PregledLink, MdnLink: PVirtualNode;
         var mdn: TRealMDNItem);
    procedure AddAnalInMdn(sender: tobject; var MdnLink, AnalLink: PVirtualNode;
         var TempItem: TRealExamAnalysisItem);
    procedure DeleteAnalFromMdn(sender: tobject; var MdnLink, AnalLink: PVirtualNode;
         var TempItem: TRealExamAnalysisItem);
    procedure DeleteDiag(sender: tobject; var PregledLink, DiagLink: PVirtualNode;
         var TempItem: TRealDiagnosisItem);

    procedure ChangeColl(sender: TObject);
    procedure ChoiceAnal(sender: TObject);
    procedure ChoiceMKB(sender: TObject);
    procedure SelectMKB(sender: TObject);
    procedure ChoiceDoctor(sender: TObject);
    procedure SelectDoctor(sender: TObject);
    procedure OnApplicationHint(Sender: TObject);
    procedure OnFmxHint(Sender: TObject; Hint: string; r: TRect);

    procedure GetTokenNzis(Sender: TObject);
    procedure OnOpenPregled(Sender: TObject);
    procedure OnOpenPregled1(Sender: TObject);
    procedure OnClosePregled(Sender: TObject);
    procedure OnClosePregled1(Sender: TObject);
    procedure OnEditPregled1(Sender: TObject);
    procedure OnOfLinePregled(Sender: TObject);
    procedure ReShowProfForm(dataPat,dataPreg: PAspRec; linkPreg:PVirtualNode );
    procedure OnGetPlanedTypeL009(Sender: TObject);
    procedure OnGetPlanedTypeL009_1(Sender: TObject);
    procedure GenerateNzisXml(node: PVirtualNode);

    procedure GetTokenThread();
    procedure OpenPregX001(pregNode: PVirtualNode);
    procedure ClosePregX003(pregNode: PVirtualNode);
    procedure EditPregX009(pregNode: PVirtualNode);
    procedure OfLinePregX013(pregNode: PVirtualNode);
    procedure GetPlanedTypeL009(pregNode: PVirtualNode);

    procedure FillCl088Update;
    procedure CloseApp(Sender: TObject);
    procedure RestoreApp(Sender: TObject; var txt: string);
    procedure MinimizeApp(Sender: TObject);
    procedure MouseTitleDown(Sender: TObject);
    procedure MouseTitleDblClick(Sender: TObject; var txt: string);

    procedure MenuTitleDBClick(Sender: TObject);
    procedure MenuTitleLoadDBClick(Sender: TObject);
    procedure MenuTitleProfGrafClick(Sender: TObject);
    procedure TitleSetingsClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);

    procedure RoleBarOnProgres(Sender: TObject; var progres: integer);
    procedure RoleBarBtnRoleClick(Sender: TObject);
    procedure CheckIncMN;
    procedure CheckIncMNInPat;

    procedure SetStyle;

    function GetRootForNode(Node: PVirtualNode): PVirtualNode;
    function GetCollectionFromRoot(Root: PVirtualNode): TBaseCollection;

    function GetCollectionByType(ACollType: Word): TBaseCollection;
    function GetADBBuffer: Pointer;
    procedure SearchTest;
    procedure SearchTesCRC_equ;
    procedure SearchTesBMH_contain;
    procedure SearchTesStartsWith;
    procedure SearchTesStartsWith_CI;


    procedure OnAddNewNodeFilter(NewNode, adbNode: PVirtualNode);
    procedure AddOperatorNodes(FieldNode: PVirtualNode; Coll: TBaseCollection; PropIndex: Integer);
    function ConditionToStr(c: TConditionType): string;
    procedure CreateFieldGroup(FieldNode: PVirtualNode);

    procedure Adb_DMOnClearColl(Sender: TObject);

    property FilterCountPregled: integer read FFilterCountPregled write FFilterCountPregled;
    property SearchTextSpisyci: string read FSearchTextSpisyci write SetSearchTextSpisyci;
    property HandleSB_Hip: THandle read FHandleSB_Hip write FHandleSB_Hip;
    property FDbName: string read GetFDbName write FFDbName;

    property EgnProf: string read FEgnProf write FEgnProf;


end;

var
  frmSuperHip: TfrmSuperHip;

implementation

{$R *.dfm}

uses
   Vcl.Imaging.pngimage, uGridHelpers, uFilterTreeGenerator2, uFilterTreeLoader,
   Aspects.Functions, uFilterMagicIndex, uMagicQueryRunner;


function EnumChildren(hwnd: HWND; lParam: LPARAM): BOOL; stdcall;
const
  TextBoxClass = 'FMTCustomPopupForm'; //(?)
var
  ClassName: array[0..259] of Char;
begin
  Result := True;
  GetClassName(hwnd, ClassName, Length(ClassName));

  if ClassName = TextBoxClass then
  begin
    //TStrings(lParam).Add(IntToHex(hwnd, 8));
    SendMessage(hwnd,WM_CLOSE,0,0);
  end;
end;

procedure AddTagToStream(var stream:TstringStream; NameTag, ValueTag :string; amp: Boolean = true);
var
  buf, val: String;
  startPos: Integer;
begin
  val := ValueTag;
  if Val = '' then
    buf := '<'+(NameTag)+'>' + #13#10
  else
  begin
    if amp then
    begin
      Val:= Val.Replace('&', '&amp;', [rfReplaceAll]);
      Val := Val.Replace('<', '&lt;', [rfReplaceAll]);
      Val := Val.Replace('>', '&gt;', [rfReplaceAll]);
    end;
    buf :=  ('<'+(NameTag)+' '+(Val)+'/> ' + #13#10);
  end;
  stream.WriteString(buf);
end;

procedure TfrmSuperHip.btn10Click(Sender: TObject);
var
  data, dataAction: PAspRec;
  linkPos, FPosLinkData: Cardinal;
  pCardinalData: PCardinal;
  bufLink: Pointer;
  RunNode: PVirtualNode;
  node: PVirtualNode;
begin

  //if (GetKeyState(VK_CONTROL) >= 0) then Exit;
  bufLink := AspectsLinkPatPregFile.Buf;
  //node := vtrPregledPat.GetFirst();
  //dataAction := pointer(PByte(node) + lenNode);
  //if dataAction.vid = vvPatientRoot then  Exit;

  vtrPregledPat.BeginUpdate;
  //case data.vid of
    //vvPregled:
    begin
      linkPos := 100;
      pCardinalData := pointer(PByte(bufLink));
      FPosLinkData := pCardinalData^;
      while linkpos < FPosLinkData do
      begin
        RunNode := pointer(PByte(bufLink) + linkpos);
        data := pointer(PByte(RunNode) + lenNode);
        case data.vid of
          vvPregled:
          begin
            if RunNode.Index > 1 then
            begin
              vtrPregledPat.IsVisible[RunNode] := not vtrPregledPat.IsVisible[RunNode];
            end;
          end;
          vvDoctor:
          begin
            vtrPregledPat.IsVisible[RunNode] := not vtrPregledPat.IsVisible[RunNode];
          end;
          vvEvnt:
          begin
            vtrPregledPat.IsVisible[RunNode] := not vtrPregledPat.IsVisible[RunNode];
          end;
        end;

        Inc(linkPos, LenData);
      end;
    end;
  //end;

  vtrPregledPat.EndUpdate;
  //vtrPregledPat.OnExpanded := vtrPregledPatExpanded;
  vtrPregledPat.ValidateNode(vtrPregledPat.RootNode.FirstChild.FirstChild,True);
  //fmxCntrDyn.ChangeActiveForm(FmxFinderFrm);
  //chkAutamatL009.Checked := not chkAutamatL009.Checked;
end;

procedure TfrmSuperHip.btn11Click(Sender: TObject);
var
  linkPos, FPosLinkData: Cardinal;
  pCardinalData: PCardinal;
  node, nodePat, run: PVirtualNode;
  data, dataRun: PAspRec;
  collType: word;
  PCollType: ^word;
  lstObjectTYpe: TList<word>;
  i: integer;
  lst: TList<PVirtualNode>;
  prop4: Word;
begin
  SearchTesStartsWith_CI;
  Exit;
  //Stopwatch := TStopwatch.StartNew;
//  node := vtrSearch.GetFirstSelected();
//  data := Pointer(PByte(node)+ lenNode);
//  prop4 := word(PregledNew_NRN_LRN)*4;
//  for i := 0 to AspectsLinkPatPregFile.JoinResult[Data.index].AdbList.Count - 1 do
//  begin
//    run := AspectsLinkPatPregFile.JoinResult[Data.index].AdbList[i];
//    dataRun := Pointer(PByte(run)+ lenNode);
//    if Adb_DM.CollPregled.getAnsiStringMap4(dataRun.DataPos, prop4) = '111111111111111' then
//      break ;
//  end;
//  Elapsed := Stopwatch.Elapsed;
//  mmotest.Lines.Add( 'loop ' + FloatToStr(Elapsed.TotalMilliseconds));//loop 87.5099
//
//
//  Exit;
//  lstObjectTYpe := TList<word>.Create;
//  lstObjectTYpe.Capacity := vtrPregledPat.TotalCount + 10;
//  Stopwatch := TStopwatch.StartNew;
//
//
//  linkPos := 100;
//  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
//  FPosLinkData := pCardinalData^;
//  while linkPos < FPosLinkData do
//  begin
//    node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
//    data := Pointer(PByte(node)+ lenNode);
//    if data.DataPos > 0 then
//    begin
//      PCollType := Pointer(PByte(AspectsHipFile.Buf) + data.DataPos - 4);
//      lstObjectTYpe.Add(PCollType^);
//    end;
//    inc(linkPos, LenData);
//  end;
//  Elapsed := Stopwatch.Elapsed;
//  mmotest.Lines.Add( 'lstObjectTYpe ' + FloatToStr(Elapsed.TotalMilliseconds));
//  Stopwatch := TStopwatch.StartNew;
//  SortListCollType(lstObjectTYpe);
//  Elapsed := Stopwatch.Elapsed;
//  mmotest.Lines.Add( 'SortListCollType ' + FloatToStr(Elapsed.TotalMilliseconds));
//  collType := 0;
//  for i := 0 to lstObjectTYpe.Count - 1 do
//  begin
//    if lstObjectTYpe[i] = collType then Continue;
//    collType := lstObjectTYpe[i];
//    //TCollectionsType
//    mmotest.Lines.Add(IntToStr(collType) + '   ' + TRttiEnumerationType.GetName(TCollectionsType(collType)) );
//
//  end;
//  lstObjectTYpe.Free;
end;

procedure TfrmSuperHip.btn12Click(Sender: TObject);
begin
  Exit;
  if vtrNewAnal.RootNodeCount = 0 then
  begin
    HipNomenAnalsClick(nil);
  end;
  Stopwatch := TStopwatch.StartNew;
  vtrTemp.BeginUpdate;
  vtrTemp.Clear;
  vtrTemp.NodeDataSize := sizeof(TAspRec);

  CopyNodesFromAspectToTempVtr(vtrNewAnal, vtrNewAnal.RootNode.FirstChild);
  vtrTemp.OnGetText := vtrNewAnalGetText;

  //CopyNodesFromAspectToTempVtr(vtrPregledPat, vtrPregledPat.RootNode.FirstChild);
//  vtrTemp.OnGetText := vtrPregledPatGetText;

  vtrTemp.EndUpdate;
  Elapsed := Stopwatch.Elapsed;
  pgcTree.ActivePage := tsTempVTR;
  pnlGraph.Parent := nil;

  mmotest.Lines.Add( 'Copy ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.btn1Click(Sender: TObject);
var
  node: PVirtualNode;
  size: Integer;
begin
  Size := 32;

  vtrPregledPat.BeginUpdate;
  try
    for Node in vtrPregledPat.SelectedNodes do
    begin
      vtrPregledPat.NodeHeight[Node] := Size;
      vtrPregledPat.MultiLine[Node] := true;
    end;
  finally
    vtrPregledPat.EndUpdate;
  end;
  Exit;
  //Application.CreateForm(TFrmRTTIExplLite, FrmRTTIExplLite);
  //FrmRTTIExplLite.Show;
 // FmxProfForm.ChangePositionScroll(0, 2000);
end;

procedure TfrmSuperHip.btn4Click(Sender: TObject);
var
  linkPos, FPosLinkData: Cardinal;
  pCardinalData: PCardinal;
  node, nodePat: PVirtualNode;
  data: PAspRec;
  collPatExport: TRealPatientNewColl;
begin
  TestMagicIndex1;
  //FindDiagInMDN;
  //ExportNzisToDb;
  //CheckIncMN;
  //CheckIncMNInPat;
  Exit;

  InternalChangeWorkPage(tsFMXForm);
  if FmxImportNzisFrm = nil then
  begin
    FmxImportNzisFrm := TfrmImportNzis.Create(nil);

  end;
  fmxCntrDyn.ChangeActiveForm(FmxImportNzisFrm);
  Exit;
  Stopwatch := TStopwatch.StartNew;
  linkPos := 100;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  FPosLinkData := pCardinalData^;
  while linkPos < FPosLinkData do
  begin
    node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
    data := Pointer(PByte(node)+ lenNode);
    if data.vid = vvPregled then
    begin
      Adb_DM.CollPregled.getIntMap(data.DataPos, Word(PregledNew_ID));
      //if CollPregled.getIntMap(data.DataPos, Word(PregledNew_ID)) = 736130 then
//      begin
//        nodePat := node.Parent;
//        Break;
//
//      end;
    end;
    inc(linkPos, LenData);
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'Martin ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.btnNzisProfClick(Sender: TObject);
begin
  AddNewPregled;

  CheckCollForSave;
end;

procedure TfrmSuperHip.btnOldHipClick(Sender: TObject);
begin
  tmpVtr.FilterText := edtFilterTemp.Text;
  tmpVtr.ChoiceOldMenu(sender);
  pgcTree.ActivePage := tsTempVTR;
end;

procedure TfrmSuperHip.btnPullClick(Sender: TObject);
begin
  if pnlGridSearch.Visible then
  begin
    if splSearchGrid.top > pnlWork.Height - 150 - 7 then
    begin
      pnlGridSearch.height := 150;
      tlb1.Realign;
    end
    else
    begin
      pnlGridSearch.height := 1;
    end;
    splSearchGridMoved(nil);
  end
  else if pnlNzisMessages.Visible then
  begin
    if splSearchGrid.top > pnlWork.Height - 550 - 7 then
    begin
      pnlNzisMessages.height := 550;
    end
    else
    begin
      pnlNzisMessages.height := 1;
    end;
    splSearchGridMoved(nil);
  end;
end;

procedure TfrmSuperHip.btn5Click(Sender: TObject);
begin
  //WVBrowser1.navigate('file:///C:/Users/Administrator1/Downloads/helppp 1.pdf');
  Exit;
  Stopwatch := TStopwatch.StartNew;
  //vtrPregledPat.IterateSubtree(vtrPregledPat.GetFirstSelected.Parent, FmxTest.IterateCalcDraw, vtrPregledPat.GetFirstSelected);
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'iterate ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.btn6Click(Sender: TObject);
var
  csv: TCSVData;
begin

  grdNom.Selected.Range.FromRow := 0;
  grdNom.Selected.Range.FromColumn := grdNom.Columns[0];
  grdNom.Selected.Range.ToRow := 200; // TVirtualModeData(grdNom.Data).Rows - 1;
  grdNom.Selected.Range.ToColumn := grdNom.Columns[grdNom.Columns.Count - 1];
  grdNom.SetFocus;

  //csv.

  Clipboard.AsText:= TCSVData.From(grdNom.Grid, grdNom.Selected, ';', #13#10, '"');
end;

procedure TfrmSuperHip.btn7Click(Sender: TObject);
var
  run: PVirtualNode;
  i: Integer;
  start_I, End_I : Integer;
begin
  run := vtrPregledPat.RootNode.FirstChild.FirstChild;
  start_I := 100;
  End_I :=105;
  i := 0;
  while run <> nil do
  begin
    if i > End_I then Break;
    if i < start_I then
    begin
      inc(i);
      run := run.NextSibling;
      Continue;
    end;

    inc(i);
    vtrPregledPat.Selected[run] := True;
    vtrPregledPat.FocusedNode := run;
    vtrPregledPat.Repaint;
    Application.ProcessMessages;
    TestPlaned := False;
    AddNewPregled;
    while not TestPlaned do
    begin
      if not chkAutamatL009.Checked then
        Exit;
      Application.ProcessMessages;
    end;

    run := run.NextSibling;
  end;
end;

procedure TfrmSuperHip.btn8Click(Sender: TObject);
begin
  FmxProfForm.AutoFillControl;
end;

procedure TfrmSuperHip.btn9Click(Sender: TObject);
var
  pat: TRealPatientNewItem;
  data: PAspRec;
begin
  pat := TRealPatientNewItem.Create(nil);
  pat.FNode := vtrPregledPat.GetFirstSelected();
  data := Pointer(PByte(pat.FNode) + lenNode);
  pat.DataPos := Data.DataPos;
  FDBHelper.SavePatientFDB(pat, Fdm.ibsqlCommand);
  //fmxCntrDyn.ChangeActiveForm(FmxProfForm);
end;

procedure TfrmSuperHip.btnAddButtonClick(Sender: TObject);
var
  btn: TRoleButton;
  btnItem: TRoleButtonItem;
  i: Integer;
  h: integer;
begin
  h := 10;
 // for i := 0 to 5 do
//  begin
//    btn := TRoleButton.Create(self);
//    btn.SplitViewer := spltvw1;
//
//    btn.Parent := spltvw1;
//    btn.Top := h;
//    h := btn.BoundsRect.Bottom + 2;
//    btn.Icon32.Assign(icn32lst1.Icon[0]);
//    //btn.Icon32.LoadFromFile('D:\iconPng\chase_canine_patrol_paw_patrol_icon_263864.png');
//    btn.OffsetIcon := 4;
//    btn.GroupIndex := 1;
//    btn.AllowAllUp := True;
//    btn.MinValue := 0;
//    btn.MaxValue := 100;
//    btn.Position := 0;
//    btn.ColorProgres := clLime;
//    btn.Description := 'for i := 0 to spltvw1.Roles[0].MainButtons.Count - 1 do';
//  end;
 // Exit;
  for i := 0 to pnlRoleView.Roles[0].MainButtons.Count - 1 do
  begin
    btnItem := pnlRoleView.Roles[0].MainButtons.Items[i];
    btn := TRoleButton.Create(self);
    btn.SplitViewer := pnlRoleView;

    btn.Parent := pnlRoleView;
    btn.Top := h;
    h := btn.BoundsRect.Bottom + 2;

    btn.Icon32.Assign(pnlRoleView.IconList.Icon[btnItem.IconIndex]);
    btn.OffsetIcon := 4;
    btn.GroupIndex := 1;
    btn.AllowAllUp := True;
    btn.MinValue := 0;
    btn.MaxValue := 100;
    btn.Position := 0;
    btn.ColorProgres := clLime;
    btn.Description := pnlRoleView.Roles[0].MainButtons.Items[i].Description;
  end;

end;

procedure TfrmSuperHip.btnAddCLClick(Sender: TObject);
begin
  //TCL000EntryCollection.ImportNomenList(AspectsNomFile);
end;

procedure TfrmSuperHip.btnCancelClick(Sender: TObject);
begin

  btnSpisyciClick(nil);
end;

procedure TfrmSuperHip.btnCertClick(Sender: TObject);
begin
  ShowTokensFMX ;
end;

procedure TfrmSuperHip.btnClcClick(Sender: TObject);
var
  pat: TPatientNewItem;
  patRec: TPatientNewItem.TRecPatientNew;
begin
  bindExpr := TBindingExpressionDefault.Create;
  pat := TPatientNewItem.Create(nil);
  New(pat.PRecord);
  pat.PRecord.EGN := '6810101723';
  bindExpr.Source := mmoIn.Lines.Text;
  pat.DataPos := 23456;
  //CollPatient.GetCellFromRecord(6, );
  BindExpr.Compile([TBindingAssociation.Create(Adb_DM.collpatient, 'patient')]);
  mmoOut.Lines.Add (BindExpr.Evaluate.GetValue.ToString);
  Dispose(pat.PRecord);
  pat.PRecord := nil;
end;

procedure TfrmSuperHip.btnClearbtnClick(Sender: TObject);
var
  i: Integer;
begin
  for i := pnlRoleView.ControlCount - 1 downto 0 do
  begin
    if pnlRoleView.Controls[i] is TRoleButton then
    begin
      (pnlRoleView.Controls[i].Destroy);
    end;
  end;
end;

procedure TfrmSuperHip.btnExitClick(Sender: TObject);
var
  HandleSuperHip_Hip: THandle;
begin
  HandleSuperHip_Hip := GetParent(FHandleSB_Hip);
  SendMessage(HandleSuperHip_Hip, WM_CLOSE, 0, 0);
end;

procedure TfrmSuperHip.btnFilldiagInMkbClick(Sender: TObject);
begin
  FillDiagInMkb;
end;

procedure TfrmSuperHip.btnFilterClick(Sender: TObject);
var
  i: Integer;
  str: string;
  len: Word;
  //FV: TFilterValues;

  linkPos: Cardinal;
  pCardinalData: ^Cardinal;
  FPosLinkData: Cardinal;
  node: PVirtualNode;
  data: PAspRec;
  PAnsBuf, PAnsFind: PAnsiChar;
  ss: TPregledNewItem.TPropertyIndex;

begin
  //frmFilter.Left := 100;// DynWinPanel1.leftlistfilter;
//  frmFilter.Top := 100;//DynWinPanel1.topListFilter;
//
//  frmFilter.Show;
//  Exit;
  LoadVtrSearch;
  Adb_DM.CollPregled.IndexValue(PregledNew_ANAMN); // за забързване на търсенето (предизвиква операционната система да кешира ...)
  Adb_DM.CollPregled.Clear;

  Adb_DM.CollPregled.ArrPropSearch := [PregledNew_AMB_LISTN, PregledNew_NRN_LRN, PregledNew_ANAMN];

  thrSearch := TSearchThread.Create(true);
  thrSearch.CollForFind := Adb_DM.CollPregled;

  thrSearch.vtr := vtrPregledPat;
  thrSearch.bufLink := AspectsLinkPatPregFile.Buf;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  FPosLinkData := pCardinalData^;
  //thrSearch.FPosData := FPosLinkData;
  //thrSearch.BufADB := AspectsHipFile.Buf;


  thrSearch.grdSearch := grdSearch;
  thrSearch.OnShowGrid := OnShowGridSearch;
  grdSearch.Tag := Cardinal(Adb_DM.CollPatient);

  thrSearch.Resume;
  //Panel1.Visible := False;
  Exit;
  //AspectsLinkPatPregFile.Buf
  //CollPregled
  //PregledNew_ANAMN


  Stopwatch := TStopwatch.StartNew;
  Adb_DM.CollPregled.ListDataPos.Clear;
  linkPos := 100;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  FPosLinkData := pCardinalData^;
  node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);

  data := pointer(PByte(node) + lenNode);
  PAnsFind := PAnsiChar(edtFilter.Text);
  while linkPos <= FPosLinkData do
  begin
    Inc(linkPos, LenData);
    node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
    data := pointer(PByte(node) + lenNode);
    //if data.vid = vvPregled then
//    begin
//      PregledTemp.DataPos := data.DataPos;
//      PAnsBuf := PregledTemp.getPAnsiStringMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, word(PregledNew_ANAMN), len);
//      if System.SysUtils.AnsiStrPos(PAnsBuf, 'пияница') <> nil then
//      begin
//        CollPregled.ListDataPos.Add(data);
//      end;
//    end;
    //if CollPregled.ListDataPos.Count = 20  then
//    begin
//      CollPregled.ShowLinksGrid(grdSearch);
//      grdSearch.Repaint;
//    end;
  end;
  if Adb_DM.CollPregled.ListDataPos.Count > 0 then
  begin
    Adb_DM.CollPregled.ShowLinksGrid(grdSearch);
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'tgdyg ' + FloatToStr(Elapsed.TotalMilliseconds));
 Exit;
  //Stopwatch := TStopwatch.StartNew;
//  listFilterCount.Clear;
//  //FilterList.Clear;
//  FilterStringsHave.Clear;
//  //mmoTest.Lines.BeginUpdate;
//  maxCountPregledInPat := 0;
//  vtrPregledi.BeginUpdate;
//  //vtrPregledi.IterateSubtree(nil, IterateFilterPatField, nil);
//  vtrPregledi.EndUpdate;
//  SortListString(FilterStringsHave);
//  str:= '';
//  for i := 0 to FilterStringsHave.Count - 1 do
//  begin
//    if str <> FilterStringsHave[i].str then
//    begin
//      if i <> 0 then
//        //FilterList.Add(FV);
//      FV.value := FilterStringsHave[i].str;
//      //mmoTest.Lines.Add(FV.value);
//      FV.count := 1;
//      str := FilterStringsHave[i].str;
//    end
//    else
//    begin
//      inc(FV.count);
//    end;
//  end;
//  //mmoTest.Lines.EndUpdate;
//  Elapsed := Stopwatch.Elapsed;
//  //FilterStringsHave.Count;
//  //DynWinPanel1.lstvtr1.FFilterList := FilterList;
//  Stopwatch := TStopwatch.StartNew;
//  DynWinPanel1.lstvtr1.FillFilterList;
//  Elapsed := Stopwatch.Elapsed;
//  DynWinPanel1.ShowFilterList;
//  Panel1.Caption := FloatToStr(Elapsed.TotalMilliseconds);
end;

procedure TfrmSuperHip.btnFindClick(Sender: TObject);
var
  selStart: Integer;
  selLength: Integer;
begin
  selStart := frRTF.FindText('ЗОЛ с повишен риск от ',1, -1, [TRichSearchType.stMatchCase] );
  frRTF.SelStart := selStart;
  frRTF.SelLength := 10;
  frRTF.SetFocus;

  //SendMessage(frRTF.Handle, EM_SETZOOM, 32, tsRTF.tag);
end;

procedure TfrmSuperHip.btnGetSeekClick(Sender: TObject);
begin
 // Caption := MPHip.controls.currentPosition.ToString;
 MPHip.controls.currentPosition := 2800.299;
end;

//procedure TfrmSuperHip.btnHelpClick(Sender: TObject);
//var
//  res: CaptureResult;
//  hashObj: Hash;
//  hashAL: string;
//begin
//  hashAL := 'dddd';
//  hashObj := CoHash.Create();
//  hashObj.type_ := HashSHA256;
//  hashObj.add(hashAL);
//  res := sgctl1.Capture('Biser....', 'Подпис за: ....' , hashObj);
//  Exit;
//  SendMessage(Handle, WM_SYSCOMMAND, SC_CONTEXTHELP, 0);
//  //Application.WM_HELP
//  //pgcRole.ActivePage := tsRoleDescr;
//end;

procedure TfrmSuperHip.btnHistNavClick(Sender: TObject);
var
  i: Integer;
  histnav: THistoryNav;
  vpreg: PVirtualNode;
  datapreg, datapat: PAspRec;
  mkb: TMkbItem;
  LstMkb: TList<TMkbItem>;
  mkbstr: string;
   wb: TWordBreakF;
begin
  FmxProfForm.ZoomToWidth(fmxCntrDyn.Width);
  Exit;
  LstMkb := TList<TMkbItem>.Create;
  for i := 0 to Adb_DM.CollMkb.Count - 1 do
  begin
    mkb := Adb_DM.CollMkb.Items[i];
    mkbstr := Adb_DM.CollMkb.getAnsiStringMap(mkb.DataPos, word(Mkb_NAME));
    if mkbstr.StartsWith('F') then
    begin
      wb := TWordBreakF.create(canvas);
      wb.maxwidth := 123;
      wb.Inls.Text := mkbstr;
      wb.WrapMemo;
    end;
  end;
  Exit;
  FmxProfForm.Pregled.FDiagnosis.Exchange(1, 3);
  vPreg := FmxProfForm.Pregled.FNode;
  FmxProfForm.Pregled.CanDeleteDiag := False;
  datapreg := Pointer(PByte(vPreg) + lenNode);
  datapat := Pointer(PByte(vPreg.Parent) + lenNode);
  ShowPregledFMX(datapat, datapreg, vpreg);
  FmxProfForm.Pregled.CanDeleteDiag := True;
  Exit;
  for i := 0 to ListHistoryNav.Count - 1 do
  begin
    histnav := ListHistoryNav[i];
    pgcTree.ActivePage := TTabSheet(histnav.Vtr.Parent);
    Sleep(2000);
  end;
end;

procedure TfrmSuperHip.btnIdiNaClick(Sender: TObject);
var
  TempFindedItem: TBaseItem;
  data: PAspRec;
  node: PVirtualNode;
  i: Integer;
  mkb: string;
begin
  Stopwatch := TStopwatch.StartNew;
  for i := 0 to Adb_DM.CollMkb.Count - 1 do
  begin
    mkb := Adb_DM.CollMkb.getAnsiStringMap(Adb_DM.CollMkb.Items[i].DataPos, Word(Mkb_CODE));
    if mkb.StartsWith('M43.98') then
      Break;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.lines.add(Format('mkb: %f', [Elapsed.TotalMilliseconds]));

  //TempFindedItem.DataPos := CollPregled.ListNodes[grdNom.Selected.Row].DataPos;
  //data := pointer(PByte(runNode) + lenNode);
  if false then
  begin
    data := Adb_DM.CollPregled.ListNodes[grdNom.Selected.Row];
    node := Pointer(PByte(data) - lenNode);
    vtrPregledPat.Selected[node] := True;
    vtrPregledPat.FocusedNode := node;
  end;
end;

procedure TfrmSuperHip.btnInClick(Sender: TObject);
begin
  //btnIn.Parent :=

end;

procedure TfrmSuperHip.btnLoopXmlClick(Sender: TObject);
var
  i: Integer;
  msg: TNzisReqRespItem;
  AmsgX001: msgX001.IXMLMessageType;
  oXml: IXMLDocument;
  StringStream: TStringStream;
  cnt: Integer;
begin
  cnt := 0;
  for i := 0 to Adb_DM.AmsgColl.Count - 1 do
  begin
    msg := Adb_DM.AmsgColl.Items[i];
    case byte(msg.PRecord.Logical) of
      1: // X
      begin
        case msg.PRecord.msgNom of
          1: // X001
          begin
            inc(cnt);
            oXml := TXMLDocument.Create(nil);
            StringStream := TStringStream.Create(msg.PRecord.REQ, TEncoding.UTF8);
            try
              oXml.LoadFromStream(StringStream);

            finally
              StringStream.Free;
            end;
            oXml.Encoding := 'UTF-8';
            AmsgX001 := msgX001.Getmessage(oXml);
            msg.PRecord.patEgn := AmsgX001.Contents.Subject.Identifier.Value;

            if oXml.Active then
            begin
              oXml.ChildNodes.Clear;
              oXml.Active := False;
            end;
            oxml := nil;
          end;
        end;
      end;
      2:;// CellText := Format('R%.3d', [node.Dummy]);
      4:;// CellText := Format('P%.3d', [node.Dummy]);
      8:;// CellText := Format('I%.3d', [node.Dummy]);
      16:;// CellText := Format('H%.3d', [node.Dummy]);
      32:;// CellText := Format('C%.3d', [node.Dummy]);
    end;
  end;
  mmoTest.Lines.Add('X001 ' + IntToStr(cnt));
end;

procedure TfrmSuperHip.btnManagerClick(Sender: TObject);
begin
  pgcTree.ActivePage := tsTreeRole;
  pgcRole.ActivePage := tsRoleManager;
end;

procedure TfrmSuperHip.btnNextClick(Sender: TObject);
begin
  if Adb_DM.CollUnfav.CurrentYear < 2032 then
  begin
    Adb_DM.CollUnfav.CurrentYear := Adb_DM.CollUnfav.CurrentYear + 1;
  end;
end;

procedure TfrmSuperHip.btnNextSendedClick(Sender: TObject);
var
  i: Integer;
  nodeSend: TNodesSendedToNzis;
begin

  nodeSend :=  Adb_DM.LstNodeSended[btnNextSended.Tag];
  vtrPregledPat.Selected[nodeSend.node] := True;
  Adb_DM.FormatingXML(nodeSend.XmlReq);
  syndtNzisReq.Lines.Assign(nodeSend.XmlReq);
  //Adb_DM.FormatingXML(nodeSend.XmlResp);
  syndtNzisResp.Lines.Assign(nodeSend.XmlResp);

  btnNextSended.Tag := btnNextSended.Tag + 1;
  if btnNextSended.Tag > Adb_DM.LstNodeSended.Count - 1 then
    btnNextSended.Tag := 0;


  //for i := 0 to Adb_DM.LstNodeSended.Count - 1 do
//  begin
//    nodeSend :=  Adb_DM.LstNodeSended[i];
//    if nodeSend.node = pvirtualnode(tsNZIS.Tag) then
//    begin
//      Adb_DM.FormatingXML(nodeSend.XmlReq);
//      syndtNzisReq.Lines.Assign(nodeSend.XmlReq);
//
//      //Adb_DM.FormatingXML(nodeSend.XmlResp);
//      syndtNzisResp.Lines.Assign(nodeSend.XmlResp);
//    end;
//  end;
end;

procedure TfrmSuperHip.btnPatListClick(Sender: TObject);
begin
  //ImportPatFromPIS;
  //FillPatListPisInPatDB;
end;

procedure TfrmSuperHip.btnPrevOtcetPeriodClick(Sender: TObject);
begin
  if Adb_DM.CollUnfav.CurrentYear > 2024 then
  begin
    Adb_DM.CollUnfav.CurrentYear := Adb_DM.CollUnfav.CurrentYear - 1;
  end;
end;

procedure TfrmSuperHip.btnReadL010Click(Sender: TObject);
var
  data: PAspRec;
  oXml: IXMLDocument;
  stream: TMemoryStream;
  ls: TStringList;
  idx: Integer;
  XmlStream: TXmlStream;
begin
  XmlStream := TXmlStream.Create;
  Adb_DM.FillXmlStreamI001(XmlStream, vtrPregledPat.GetFirstSelected());
  edtUrl.Text := Adb_DM.GetURLFromMsgType(I001, true);

  XmlStream.Position := 0;
  try
    stream := TMemoryStream.Create;
    ls := TStringList.Create;
    ls.LoadFromStream(XmlStream, TEncoding.UTF8);
    oXml := TXMLDocument.Create(self);
    oXml.LoadFromXML(ls.Text);
    oXml.Encoding := 'UTF-8';
    oXml.SaveToStream(stream);
    stream.Position := 0;
    syndtNzisReq.Lines.LoadFromStream(stream, TEncoding.UTF8);
  finally
    XmlStream.free;
    stream.Free;
    ls.Free;
    if oXml.Active then
    begin
      oXml.ChildNodes.Clear;
      oXml.Active := False;
    end;
    oxml := nil;
  end;

end;

procedure TfrmSuperHip.btnRemont142Click(Sender: TObject);
begin
  RemontCl142;
end;

procedure TfrmSuperHip.btnRTFClick(Sender: TObject);
//var
  //TTT: set of TTablesType;
  //TFT: set of Byte;
begin
 //Caption := IntToStr(SizeOf(TfT));
  frRTF.Print('test');
end;

procedure TfrmSuperHip.btnSave088Click(Sender: TObject);
var
  oldRow: Integer;
begin
  //oldRow := grdNom.Grid.Selected.Row;
//  grdNom.Grid.Selected.Row := 1;
//  grdNom.Grid.Selected.Row := oldRow;
//  CL088Coll.UpdateCL088;
//    CL022Coll.UpdateCL022;
//    CL024Coll.UpdateCL024;
//  CL139Coll.UpdateCL139;
//  CL132Coll.UpdateCL132;
//  CL038Coll.UpdateCL038;
//  CL142Coll.UpdateCL142;
//  CL144Coll.UpdateCL144;
//  CL134Coll.UpdateCL134;
//  PR001Coll.UpdatePr001;
end;

procedure TfrmSuperHip.btnSaveAllClick(Sender: TObject);
begin
  btnSaveAll.Enabled := False;
  StartSaver;
  Exit;
  StartInserter;
end;

procedure TfrmSuperHip.btnSaveUnfavClick(Sender: TObject);
begin
  try
    UpdateUnfav;
    btnSaveUnfav.Enabled := False;
    btnCancel.Enabled := False;
    //CheckForUpdate;
    vtrSpisyci.Repaint;
  except

  end;
end;

procedure TfrmSuperHip.btnSendClick(Sender: TObject);
var
  //hipSB: TSBX_HIP;
  stream: TStringStream;
  i: Integer;
  lin: string;
  GD: TGUID;
  datStr: string;
  oXml: IXMLDocument;
  ls: TStringList;
begin
  syndtNzisResp.Clear;
  btnSignClick(nil);

  streamRes.Size := 0;
  httpNZIS.OnData := httpNZISDataSender;
  httpNZIS.Close;

  httpNZIS.Post(edtURL.Text, InXmlStream, false);

  //Caption := IntToStr(streamRes.Size);
  stream := TStringStream.Create;
  ls := TStringList.Create;
  stream.Position := 0;
  streamRes.Position := 0;
  try
    stream.Clear;
    ls.LoadFromStream(streamRes, TEncoding.UTF8);
    Adb_DM.ReadXmlL010(streamRes, syndtNzisReq.Lines);
    oXml := TXMLDocument.Create(self);
    oXml.LoadFromXML(Xml.XMLDoc.FormatXMLData(ls.Text));
    oXml.Encoding := 'UTF-8';
    oXml.SaveToStream(stream);
    stream.Position := 0;
    syndtNzisResp.Lines.LoadFromStream(stream, TEncoding.UTF8);
  finally
    stream.Free;
    ls.Free;
    if oXml.Active then
    begin
      oXml.ChildNodes.Clear;
      oXml.Active := False;
    end;
    oxml := nil;
  end;
 // syndtNzisResp.Lines.LoadFromStream(streamRes, TEncoding.UTF8);
end;

procedure TfrmSuperHip.BtnSendToNzisNomen(node: PVirtualNode);
var
  nzisThr: TNzisThread;
  data: PAspRec;
begin
  if node.Dummy > 70 then
  begin
    ActiveSubButton.MaxValue := ActiveSubButton.MaxValue - 1;
    Exit;
  end;

  data := vtrNomenNzis.GetNodeData(node);
  if data.index< 0 then exit;

  vtrNomenNzis.UpdateWaitNode(node, True, true);
  nzisThr := TNzisThread.Create(true);
  nzisThr.FreeOnTerminate := True;
  nzisThr.IsTestNZIS := False;
  if Adb_DM.NomenNzisColl.items[data.index].PRecord = nil then
  begin
    nzisThr.NomenID := Adb_DM.NomenNzisColl.items[data.index].getAnsiStringMap(Adb_DM.NomenNzisColl.Buf, Adb_DM.NomenNzisColl.posData, word(NomenNzis_NomenID));
  end
  else
  begin
    nzisThr.NomenID := Adb_DM.NomenNzisColl.items[data.index].PRecord.NomenID;
  end;
  nzisThr.OnSended := NzisOnSended;
  nzisThr.HndSuperHip := Self.Handle;
  nzisThr.Node := node;
  nzisThr.MsgType := TNzisMsgType.C001;
  nzisThr.StreamData :=  Adb_DM.ListNomenNzisNames[data.index].xmlStream;
  nzisThr.token := '';
  nzisThr.Resume;
end;

procedure TfrmSuperHip.BtnSendToNzisNomenUpdate(node: PVirtualNode);
var
  nzisThr: TNzisThread;
  data, dataUpdate: PAspRec;
  vUpdateNom: PVirtualNode;
begin
  //if node.Dummy > 70 then
//  begin
//    ActiveSubButton.MaxValue := ActiveSubButton.MaxValue - 1;
//    Exit;
//  end;
  vUpdateNom := vtrNomenNzis.AddChild(node, nil);
  vtrNomenNzis.AddWaitNode(vUpdateNom);
  vtrNomenNzis.Expanded[node] := True;

  data := vtrNomenNzis.GetNodeData(node);
  dataUpdate := vtrNomenNzis.GetNodeData(vUpdateNom);
  dataUpdate.vid := vvNomenNzisUpdate;
  dataUpdate.index := data.index;
  if data.index< 0 then exit;

  vtrNomenNzis.UpdateWaitNode(vUpdateNom, True, true);
  nzisThr := TNzisThread.Create(true);
  nzisThr.FreeOnTerminate := True;
  nzisThr.IsTestNZIS := False;
  if Adb_DM.NomenNzisColl.items[data.index].PRecord = nil then
  begin
    nzisThr.NomenID := Adb_DM.NomenNzisColl.items[data.index].getAnsiStringMap(Adb_DM.NomenNzisColl.Buf, Adb_DM.NomenNzisColl.posData, word(NomenNzis_NomenID));
  end
  else
  begin
    nzisThr.NomenID := Adb_DM.NomenNzisColl.items[data.index].PRecord.NomenID;
  end;
  nzisThr.OnSended := NzisOnSended;
  nzisThr.HndSuperHip := Self.Handle;
  nzisThr.Node := vUpdateNom;
  nzisThr.MsgType := TNzisMsgType.C001;
  nzisThr.StreamData :=  Adb_DM.ListNomenNzisNames[data.index].xmlStream;
  nzisThr.token := '';
  nzisThr.Resume;
end;

procedure TfrmSuperHip.btnSignClick(Sender: TObject);
var
  Signer : TElXMLSigner;
  SignatureNode, NzisSign : TElXMLDOMNode;
  Ref : TElXMLReference;
  refNum: Integer;
  X509KeyData: TElXMLKeyInfoX509Data;
  stream: TStringStream;
  FXMLDocument: TElXMLDOMDocument;
begin
  InXmlStream.Clear;
  SignatureNode := nil;
  Signer := TElXMLSigner.Create(nil);
  FXMLDocument := TElXMLDOMDocument.Create;
  stream := TStringStream.Create(syndtNzisReq.Text, TEncoding.UTF8);

  try
    Signer.References.Clear;
    stream.Position := 0;
    FXMLDocument.LoadFromStream(stream, 'utf-8', true);
    Signer.SignatureType := xstEnveloped;
    Signer.CanonicalizationMethod := xcmCanon;
    Signer.SignatureMethodType := xmtSig;
    Signer.SignatureMethod := xsmRSA_SHA256;
    Signer.MACMethod := xmmHMAC_SHA1;

    SignatureNode := FXMLDocument.FindNode('nhis:message', true);


    refNum := Signer.References.Add();
    Signer.References[refNum].DigestMethod := xdmSHA256;
    Signer.References[refNum].URINode := SignatureNode;
    Signer.References[refNum].URI := '';
    UpdateCertificates(edtCertNom.Text);

    X509KeyData := TElXMLKeyInfoX509Data.Create(False);
    X509KeyData.IncludeKeyValue := true;
    X509KeyData.IncludeDataParams := [xkidX509Certificate];
    X509KeyData.Certificate := FCertificate;

    Signer.KeyData := X509KeyData;
    Signer.OnFormatText := FormatText;
    Signer.References[0].TransformChain.AddEnvelopedSignatureTransform;
    Signer.UpdateReferencesDigest;
    Signer.GenerateSignature;
    Signer.Signature.SignaturePrefix := '';
    try
      Signer.Save(SignatureNode);
    except
      Exit;
    end;

    InXmlStream.Position := 0;
    //mmoInXml.Text := FXMLDocument.InnerXML;
    FXMLDocument.SaveToStream(InXmlStream);
    InXmlStream.Position := 0;
    mmoTest.Lines.LoadFromStream(InXmlStream);
    InXmlStream.Position := 0;
    //ResultNzisSsiger.LoadFromStream(InXmlStream);

  finally
    if Signer.KeyData <> nil then
      Signer.KeyData.Free;

    FreeAndNil(Signer);
  end;
end;

procedure TfrmSuperHip.btnSpisyciClick(Sender: TObject);
var
  i: integer;
  ACol: TVirtualTreeColumn;
  v: PVirtualNode;
  r: TRect;
begin
  //HideTabs;
  btnCancel.Enabled := False;
  btnSaveUnfav.Enabled := False;
  vtrSpisyci.Header.Columns.Clear;
  Adb_DM.CollUnfav.CurrentYear := CurrentYear;
  //Exit;
  //initDB;

  //AddDoctor;

  //AddUnfav;
  Adb_DM.CollDoctor.ClearUnfav;
  Adb_DM.CollUnfav.ClearReal;
  FillUnfavInDoctor;
  //CollDoctor.ClearUnfav;
  for i := 0 to 13 do
  begin
    ACol := vtrSpisyci.Header.Columns.Add;
    ACol.Text := format('%2.2d', [i - 1]);
    case  i  of
      0:
      begin
        ACol.Text := format('Лекари' + #13#10 + 'За %d г. по месеци', [Adb_DM.CollUnfav.CurrentYear]);

        //ACol.Width := CollDoctor.MaxWidth(vtrSpisyci.Canvas) + vtrSpisyci.Indent + 10;
        ACol.Options := [coAllowClick,coEnabled,coParentBidiMode,coParentColor, coFixed,
                         coResizable,coShowDropMark,coVisible,coAllowFocus,coUseCaptionAlignment, coWrapCaption];
      end;
      1:
      begin
        ACol.Text := format('Специалност', [Adb_DM.CollUnfav.CurrentYear]);

        ACol.Width := 120;
        ACol.Options := [coAllowClick,coEnabled,coParentBidiMode,coParentColor, coFixed,
                         coResizable,coShowDropMark,coVisible,coAllowFocus,coUseCaptionAlignment];
      end;
    else
      begin
        ACol.Width := 50;
        ACol.CaptionAlignment := taCenter;
        ACol.Options := [coAllowClick,coEnabled,coParentBidiMode,coParentColor,
                         coShowDropMark,coVisible,coFixed,coAllowFocus,coUseCaptionAlignment,coEditable];
      end;
    end;
  end;

  LoadVtrSpisyciNeblUsl;
  vtrSpisyci.Sort(vtrSpisyci.RootNode, 0, sdAscending, false);
  r := vtrSpisyci.GetDisplayRect(vtrSpisyci.RootNode.FirstChild, 0, true);
  vtrSpisyci.Header.Columns[0].Width := Adb_DM.CollDoctor.MaxWidth(vtrSpisyci.Canvas) + r.Left + 20; //vtrSpisyci.GetMaxColumnWidth(0, true);
 // pgcWork.ActivePage := tsSpisaci;
  InternalChangeWorkPage(tsSpisaci);
end;

procedure TfrmSuperHip.btnTestCertClick(Sender: TObject);
var
  dlgCert: TfrmCertDlg;
  stream: TMemoryStream;
begin
 // if ResultNzisToken = nil then
//    ResultNzisToken := TStringList.Create;
////  dlgCert := TfrmCertDlg.Create(Self);
// // dlgCert.ShowModal;
// // CurrentCert := dlgCert.CertHipSelect;
//  CertForThread := TelX509Certificate.Create(self);
//  //CurrentCert := TsbxCertificate.Create(self);
// // CurrentCert.Clone(CertForThread);
//  stream := TMemoryStream.Create;
//  stream.LoadFromFile('d:\certTest.crt');
//  stream.Position := 0;
//  CertForThread.LoadFromStreamPEM(stream, '1604');
//  CertForThread.Clone(CurrentCert);
//  httpNZIS.OnData := httpNZISDataToken;
//  httpNZIS.Close;
//  //edtCertNom.Text := dlgCert.CertHipSelectID;
//  stream.Free;
//  httpNZIS.Get('https://auth.his.bg/token');
//  ReadToken(ResultNzisToken.Text);
//  //ShowMessage(ResultNzisToken.Text);
// // FreeAndNil(dlgCert);
end;

procedure TfrmSuperHip.btnTestNodeClick(Sender: TObject);
var
  TreeLink, Run: PVirtualNode;
  linkpos: Cardinal;
  pCardinalData: ^Cardinal;
  data: PAspRec;
begin
  vtrPregledPat.BeginUpdate;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  linkpos := pCardinalData^;

  TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
  data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
  data.index := word(vvPregled);
  data.vid := vvNone;
  data.DataPos := 0;
  TreeLink.Index := 0;
  inc(linkpos, LenData);

  TreeLink.TotalCount := 1;
  TreeLink.TotalHeight := 27;
  TreeLink.NodeHeight := 27;
  TreeLink.States := [vsVisible];
  TreeLink.Align := 50;
  TreeLink.Dummy := 222;

  vtrPregledPat.InitNode(TreeLink);
  vtrPregledPat.InternalConnectNode_cmd(TreeLink, vtrPregledPat.GetFirstSelected(),
                    vtrPregledPat, amAddChildLast);


  vtrPregledPat.EndUpdate;
  vtrPregledPat.Selected[TreeLink] := True;
  vtrPregledPat.FocusedNode := TreeLink;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  pCardinalData^ := linkpos;
end;

procedure TfrmSuperHip.btnTokenClick(Sender: TObject);
var
  //dlgCert: TfrmCertDlg;
  cert: TElX509Certificate;
  iSlot, SlotCount: Integer;
  TokenPresent: Boolean;
  certNom: string;
  BSt: TArray<System.Byte>;
begin //'47F8E3CF78FA0DBF'
      // 2bba8d977f45f920

  CertStorage.Open ( 'pkcs11:///C:\Windows\System32\eTPKCS11.dll?slot=1&readonly=1&login=0');
  //CertStorage.Open ( 'pkcs11:///C:\Windows\System32\eTPKCS11.dll?slot=-1');
  //CertStorage.StorageID;
  SlotCount := StrToIntDef(CertStorage.Config('PKCS11SlotCount'), 0);
  for iSlot := 0 to SlotCount - 1 do
  begin
    if Uppercase(CertStorage.Config('PKCS11SlotTokenPresent[' + IntToStr(iSlot) + ']')) = 'TRUE' then
    begin
      TokenPresent := true;
      //certNom := CertStorage.Config('PKCS11SlotTokenModel[' + IntToStr(iSlot) + ']');
      //BSt := BuildByteArray(certNom);
      //cert := FindCertFromSerNumber(BSt);

    end
    else
    begin
      TokenPresent := false;
      Continue;
    end;
  end;

  CertStorage.Certificates.Count;
  CertStorage.Certificates[0].SerialNumber;

  if ResultNzisToken = nil then
    ResultNzisToken := TStringList.Create;
  //dlgCert := TfrmCertDlg.Create(Self);
  cert := FindCertFromSerNumber(CertStorage.Certificates[0].SerialNumber);
  //dlgCert.ShowModal;



  httpNZIS.OnData := httpNZISDataToken;
  httpNZIS.Close;
  //edtCertNom.Text := dlgCert.CertHipSelectID;
  edtCertNom.Text := BuildHexString(CertForThread.SerialNumber);
  httpNZIS.Get('https://auth.his.bg/token');
  ReadToken(ResultNzisToken.Text);
  //ShowMessage(ResultNzisToken.Text);
 // FreeAndNil(dlgCert);
end;

procedure TfrmSuperHip.btnUpdateNomenClick(Sender: TObject);
begin
  vtrNomenNzis.AddWaitNode(vtrNomenNzis.GetFirstSelected());
  vtrNomenNzis.UpdateWaitNode(vtrNomenNzis.GetFirstSelected(), true, true);

  //LoadFromNzisNewNomen(22);
end;

procedure TfrmSuperHip.btnX006Click(Sender: TObject);
var
  AX006: X006.IXMLMessageType;
  resExam: X006.IXMLResultsType;
  exam: X006.IXMLExaminationType;
  i, j: Integer;
  arrStrDate: TArray<string>;
  preg: TRealPregledNewItem;
  diag: TRealDiagnosisItem;
  startDateTime: TDateTime;
  nodePat: PVirtualNode;
  dataPat: PAspRec;
  patEgn: string;
  fileName: string;
begin
  //Sleep(20000);
  Exit;
  nodePat := PVirtualNode(vtrMinaliPregledi.Tag);
  dataPat := pointer(PByte(nodePat) + lenNode);
  //PatientTemp.DataPos := dataPat.DataPos;
  patEgn := Adb_DM.CollPatient.getAnsiStringMap(dataPat.DataPos, word(PatientNew_EGN));
  fileName := Format('%s\X006\%s.xml', [GetCurrentDir, patEgn]);
  if not FileExists(fileName) then Exit;

  AX006 := X006.Loadmessage(filename);

  for i := 0 to AX006.Contents.Results.Count - 1 do
  begin
    resExam := AX006.Contents.Results[i];
    if resExam.Performer.Pmi.Value <> AX006.Header.RecipientId.Value then
      Continue;
    exam := resExam.Examination;

    preg := TRealPregledNewItem(Adb_DM.CollPregled.Add);
    New(preg.PRecord);
    preg.PRecord.setProp := [PregledNew_NRN_LRN];
    preg.PRecord.Logical := [];
    Include(preg.PRecord.setProp, PregledNew_Logical);
    Include(preg.PRecord.Logical, TLogicalPregledNew.IS_FORM_VALID);
    Include(preg.PRecord.Logical, TLogicalPregledNew.PAY);
    Include(preg.PRecord.Logical, TLogicalPregledNew.IS_AMB_PR);
    if exam.IsSecondary.Value = 'false' then
    begin
      Include(preg.PRecord.Logical, TLogicalPregledNew.IS_PRIMARY);
    end;
    case StrToInt(exam.Purpose.Value) of
      1: Include(preg.PRecord.Logical, TLogicalPregledNew.IS_CONSULTATION);
      3: Include(preg.PRecord.Logical, TLogicalPregledNew.IS_PREVENTIVE_Childrens);
      4: Include(preg.PRecord.Logical, TLogicalPregledNew.IS_PREVENTIVE_Maternal);
      5: Include(preg.PRecord.Logical, TLogicalPregledNew.IS_PREVENTIVE_Adults);
      6: Include(preg.PRecord.Logical, TLogicalPregledNew.IS_RISK_GROUP);
      7: Include(preg.PRecord.Logical, TLogicalPregledNew.IS_DISPANSERY);
      8: Include(preg.PRecord.Logical, TLogicalPregledNew.IS_VSD);
      9: Include(preg.PRecord.Logical, TLogicalPregledNew.IS_RECEPTA_HOSPIT);
      10: Include(preg.PRecord.Logical, TLogicalPregledNew.IS_EXPERTIZA);
      11: Include(preg.PRecord.Logical, TLogicalPregledNew.IS_TELK);
      12: Include(preg.PRecord.Logical, TLogicalPregledNew.IS_Screening);
    end;
    if StrToInt(exam.Purpose.Value) in [3..6] then
    begin
      Include(preg.PRecord.Logical, TLogicalPregledNew.IS_PREVENTIVE);
    end;

    preg.LRN := exam.lrn.Value;
    preg.PregledID := 0;
    preg.PRecord.ID := preg.PregledID;
    Include(preg.PRecord.setProp, PregledNew_ID);
    preg.PRecord.AMB_LISTN := preg.AMB_LISTN;
    Include(preg.PRecord.setProp, PregledNew_AMB_LISTN);
    preg.PRecord.ANAMN := exam.medicalHistory.Value;
    Include(preg.PRecord.setProp, PregledNew_ANAMN);
    preg.PRecord.SYST := exam.objectiveCondition.Value;
    Include(preg.PRecord.setProp, PregledNew_SYST);
    preg.PRecord.TERAPY := exam.therapy.Note.Value;
    Include(preg.PRecord.setProp, PregledNew_TERAPY);
    for j := 0 to exam.assessment.Count - 1 do
    begin
      preg.PRecord.IZSL := preg.PRecord.IZSL + exam.assessment[j].Note.Value + #13#10;
    end;
    Include(preg.PRecord.setProp, PregledNew_IZSL);

    diag := TRealDiagnosisItem(Adb_DM.CollDiag.Add);
    New(diag.PRecord);
    diag.PRecord.setProp := [Diagnosis_code_CL011, Diagnosis_additionalCode_CL011];
    diag.PRecord.code_CL011 := exam.Diagnosis.Code.Value;
    diag.PRecord.additionalCode_CL011 := exam.Diagnosis.AdditionalCode.Value;
    diag.InsertDiagnosis;
    Dispose(diag.PRecord);
    diag.PRecord := nil;
    preg.FDiagnosis.Add(diag);

    for j := 0 to exam.Comorbidity.Count - 1 do
    begin
      diag := TRealDiagnosisItem(Adb_DM.CollDiag.Add);
      New(diag.PRecord);
      diag.PRecord.setProp := [Diagnosis_code_CL011, Diagnosis_additionalCode_CL011];
      diag.PRecord.code_CL011 := exam.Comorbidity[j].Code.Value;
      diag.PRecord.additionalCode_CL011 := exam.Comorbidity[j].AdditionalCode.Value;
      diag.InsertDiagnosis;
      Dispose(diag.PRecord);
      diag.PRecord := nil;
      preg.FDiagnosis.Add(diag);
    end;

    preg.PRecord.NZIS_STATUS := 6;
    Include(preg.PRecord.setProp, PregledNew_NZIS_STATUS);
    startDateTime := ISO8601ToDate(exam.openDate.Value, true);
    preg.PRecord.START_DATE := Floor(startDateTime);
    Include(preg.PRecord.setProp, PregledNew_START_DATE);
    preg.PRecord.START_TIME := startDateTime - preg.PRecord.START_DATE;
    Include(preg.PRecord.setProp, PregledNew_START_TIME);
    preg.PRecord.NRN_LRN := exam.NrnExamination.Value;
    Include(preg.PRecord.setProp, PregledNew_NRN_LRN);

    AddX005Pregled(preg);
    CheckCollForSave;
  end;
end;

procedure TfrmSuperHip.btnX007Click(Sender: TObject);
var
  i, j: Integer;
  msg: TNzisReqRespItem;
  pat, newPat: TRealPatientNewItem;
  node, treeLink: PVirtualNode;
  data: PAspRec;
  linkPos: Cardinal;
begin
  node := vtrTemp.GetFirstSelected();
  data := vtrTemp.GetNodeData(node);
  if data.vid <> vvPatient then
    Exit;
  pat := Adb_DM.AmsgColl.CollPat.Items[Data.index];

  newPat := TRealPatientNewItem(Adb_DM.CollPatient.add);
  New(newPat.PRecord);
  newPat.PRecord.setProp :=
     [PatientNew_EGN, PatientNew_BIRTH_DATE, PatientNew_FNAME, PatientNew_SNAME, PatientNew_LNAME, PatientNew_Logical];
  newPat.PRecord.EGN := Pat.PRecord.EGN;
  newPat.PRecord.BIRTH_DATE := Pat.PRecord.BIRTH_DATE;
  newPat.PRecord.FNAME := Pat.PRecord.FNAME;
  newPat.PRecord.SNAME := Pat.PRecord.SNAME;
  newPat.PRecord.LNAME := Pat.PRecord.LNAME;
  newPat.PRecord.Logical := Pat.PRecord.Logical;
 // newPat.GRAJD := 'българско';
 // newPat.PAT_KIND := 1;
  newPat.InsertPatientNew;
  Dispose(newPat.PRecord);
  newPat.PRecord := nil;

  AspectsLinkPatPregFile.AddNewNode(vvPatient, newPat.DataPos, vtrPregledPat.RootNode.FirstChild, amAddChildFirst, treeLink, linkPos);

  Caption := 'ddd';

  Exit;
  vtrTemp.Selected[PVirtualNode(Self.tag)] := true;
  vtrTemp.FocusedNode := PVirtualNode(Self.tag);
  Exit;
  if btnX007.tag > Adb_DM.AmsgColl.Count - 1 then
    btnX007.tag := 0;
  for i := btnX007.tag to Adb_DM.AmsgColl.Count - 1 do
  begin
    //pat := msgColl.CollPat.Items[i];
    //for j := 0 to pat.FLstMsgImportNzis.Count - 1 do
    begin
      msg := Adb_DM.AmsgColl.Items[i]; // TNzisReqRespItem(pat.FLstMsgImportNzis[j]);
      if msg.PRecord.NRN = '25188B073967' then
      //if (msg.PRecord.msgNom = 7) and (byte(msg.PRecord.Logical) = 1)  then//  (msg.PRecord.msgNom = 7) and  (msg.PRecord.NRN = '25153D04122B')
      begin
        vtrTemp.Selected[msg.Node] := true;
        vtrTemp.FocusedNode := msg.Node;
        btnX007.tag := i + 1;
        Exit;
      end;
    end;
  end;
  btnX007.tag := 0;
  //btnX007Click(Sender: TObject);
end;

procedure TfrmSuperHip.btnXmlInPatClick(Sender: TObject);
var
  data, dataAction: PAspRec;
  linkPos, FPosLinkData: Cardinal;
  pCardinalData: PCardinal;
  bufLink: Pointer;
  RunNode: PVirtualNode;
  node: PVirtualNode;

  pat: TRealPatientNewItem;
begin
  //Adb_DM.AmsgColl.CollPat.posData := AspectsHipFile.FPosData;
  //Adb_DM.AmsgColl.CollPat.buf := AspectsHipFile.Buf;
  bufLink := AspectsLinkPatPregFile.Buf;
  begin
    linkPos := 100;
    pCardinalData := pointer(PByte(bufLink));
    FPosLinkData := pCardinalData^;
    while linkpos < FPosLinkData do
    begin
      RunNode := pointer(PByte(bufLink) + linkpos);
      data := pointer(PByte(RunNode) + lenNode);
      case data.vid of
        vvPatient:
        begin
          pat := TRealPatientNewItem(Adb_DM.AmsgColl.CollPat.Add);
          pat.DataPos := Data.DataPos;
        end;
      end;
      Inc(linkPos, LenData);
    end;
  end;
  FillMsgInPatient;
end;

//procedure TfrmSuperHip.btnUpdateClick(Sender: TObject);
//var
//  i: Integer;
//  preg: TPregledItem;
//begin
//  Stopwatch := TStopwatch.StartNew;
//  for i := 0 to CollPregled.Count - 1 do
//  begin
//    CollPregledPrim.Add(CollPregled.Items[i]);
//    if (CollPregled.Items[i].AMB_PR = 2) and
//       (CollPregled.Items[i].SIMP_PRIMARY_AMBLIST_N <> 0) and
//       (CollPregled.Items[i].SIMP_PRIMARY_AMBLIST_DATE <> 0)
//    then
//      CollPregledVtor.Add(CollPregled.Items[i]);
//  end;
//  CollPregled.SortListByForPrimaryOptim1(CollPregledVtor);
//  CollPregled.SortListByForPrimaryOptim(CollPregledPrim);
//  FillPrimInSec;
//  for i := 0 to CollPregledVtor.Count - 1 do
//  begin
//    preg := CollPregledVtor[i];
//    if preg.FPrimary = nil then continue ;
//
//    frmlMainSender.du.ibsqlCommand.close;
//    frmlMainSender.du.ibsqlCommand.SQL.Text := 'INSERT INTO TEST (PR_ID, PRIMARY_NOTE_ID) VALUES (' +inttostr(preg.IdPregled) + ', '
//          + IntToStr(preg.FPrimary.IdPregled )+ ');' ;//+ inttostr(CollPregled.Items[i].IdPregled);
//    //frmlMainSender.du.ibsqlCommand.SQL.Text := 'UPDATE pregled SET PRIMARY_NOTE_ID =  ' +
////                                               IntToStr(preg.FPrimary.IdPregled) +
////                                               'where id =' + inttostr(preg.IdPregled);
//    //frmlMainSender.du.ibsqlCommand.Params[0].AsInteger := CollPregled.Items[i].IdPregled;
//    frmlMainSender.du.ibsqlCommand.ExecQuery;
//  end;
//  frmlMainSender.du.ibsqlCommand.Transaction.CommitRetaining;
//  Elapsed := Stopwatch.Elapsed;
//  Panel1.Caption := FloatToStr(Elapsed.TotalMilliseconds);
//end;

procedure TfrmSuperHip.BtnXMLtoCL000(node: PVirtualNode);
var
  data: PAspRec;
  IdNom: integer;
begin
  case node.Dummy of
    77:
    begin
      data := vtrNomenNzis.GetNodeData(node);
      if data.index< 0 then exit;

      FRoot := XMLParseStream(Adb_DM.ListNomenNzisNames[data.index].xmlStream, true, nil, OnProcess);
      UpdateRoot(FRoot, Adb_DM.ListNomenNzisNames[data.index].Cl000Coll);

      FRoot._Release;

      Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.GetColNames;
      mmoTest.Lines.Assign( Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.FieldsNames);
      Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ShowGrid(grdNom);
      node.Dummy := 78;
      vtrNomenNzis.RepaintNode(node);
    end;
    78:
    begin
      idnom := data.index;
      case idNom of
        6:  Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl006(Adb_DM.CL006Coll);
        22: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl022(Adb_DM.CL022Coll);
        24: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl024(Adb_DM.CL024Coll);
        37: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl037(Adb_DM.CL037Coll);
        38: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl038(Adb_DM.CL038Coll);
        88: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl088(Adb_DM.CL088Coll);
        132: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl132(Adb_DM.CL132Coll);
        134: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl134(Adb_DM.CL134Coll);
        139:Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl139(Adb_DM.CL139Coll);
        142:Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl142(Adb_DM.CL142Coll);
        144:Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl144(Adb_DM.CL144Coll);

      end;
      caption := '';
      //ListNomenNzisNames[data.index].ArrStr[1];
//      ListNomenNzisNames[data.index].Cl000Coll;
    end;
  end;

  //Cl000Coll.GetColNames
end;

procedure TfrmSuperHip.BtnXMLtoCL000ForUpdate(node: PVirtualNode);
var
  data: PAspRec;
  IdNom: integer;
begin
  case node.Dummy of
    81:
    begin
      data := vtrNomenNzis.GetNodeData(node);
      if data.index< 0 then exit;

      FRoot := XMLParseStream(Adb_DM.ListNomenNzisNames[data.index].xmlStream, true, nil, OnProcess);
      UpdateRoot(FRoot, Adb_DM.ListNomenNzisNames[data.index].Cl000Coll);

      FRoot._Release;

      Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.GetColNames;
      mmoTest.Lines.Assign( Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.FieldsNames);
      Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ShowGrid(grdNom);
      node.Dummy := 78;
      vtrNomenNzis.RepaintNode(node);
    end;
    80:
    begin
      data := vtrNomenNzis.GetNodeData(node);
      FRoot := XMLParseStream(Adb_DM.ListNomenNzisNames[data.index].xmlStream, true, nil, OnProcess);
      UpdateRoot(FRoot, Adb_DM.ListNomenNzisNames[data.index].Cl000Coll);

      FRoot._Release;

      Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.GetColNames;
      mmoTest.Lines.Assign( Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.FieldsNames);
      idnom := data.index;
      case idNom of
        24: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl024(Adb_DM.CL024Coll);
        38: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl038(Adb_DM.CL038Coll);
        88: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl088Local(Adb_DM.CL088Coll);
        132: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl132(Adb_DM.CL132Coll);
        134: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl134(Adb_DM.CL134Coll);
        139:Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl139(Adb_DM.CL139Coll);
        142:Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl142(Adb_DM.CL142Coll);
        144:Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl144(Adb_DM.CL144Coll);

      end;
      caption := '';
      //ListNomenNzisNames[data.index].ArrStr[1];
//      ListNomenNzisNames[data.index].Cl000Coll;
    end;

    77:
    begin
      data := vtrNomenNzis.GetNodeData(node);
      FRoot := XMLParseStream(Adb_DM.ListNomenNzisNames[data.index].xmlStream, true, nil, OnProcess);
      UpdateRoot(FRoot, Adb_DM.ListNomenNzisNames[data.index].Cl000Coll);

      FRoot._Release;

      Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.GetColNames;
      mmoTest.Lines.Assign( Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.FieldsNames);
      idnom := data.index;
      case idNom of
        24: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl024(Adb_DM.CL024Coll);
        38: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl038(Adb_DM.CL038Coll);
        88: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl088Local(Adb_DM.CL088Coll);
        132: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl132(Adb_DM.CL132Coll);
        134: Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl134(Adb_DM.CL134Coll);
        139:Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl139(Adb_DM.CL139Coll);
        142:Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl142(Adb_DM.CL142Coll);
        144:Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ImportCl144(Adb_DM.CL144Coll);

      end;
      caption := '';
      //ListNomenNzisNames[data.index].ArrStr[1];
//      ListNomenNzisNames[data.index].Cl000Coll;
    end;
  end;

  //Cl000Coll.GetColNames
end;

//procedure TfrmSuperHip.Button1Click(Sender: TObject);
//var
//  SaveFont: HFont;
//  hFnt : hFont;
//  lf : tLogfont;
//  oldH: Integer;
//  cf: TWMChooseFont_GetLogFont;
//  i: integer;
//  FilterDate: TDate;
//  preg: TPregledItem;
//begin
//  Stopwatch := TStopwatch.StartNew;
//  CollPregled.ListPregledForFilter.Clear;
//  for i := 0 to CollPregled.Count - 1 do
//  begin
//    CollPregled.ListPregledForFilter.Add(CollPregled.Items[i]);
//  end;
//  Exit;
//  //CollPregled.SortByNRN;
//  //CollPregled.SortListByAmbListNo(ListPregledForFilter);
//  CollPregled.SortListByStartDate(CollPregled.ListPregledForFilter);
//  FilterDate := 0;
//  vtrTestFilter.BeginUpdate;
//  for i := 0 to CollPregled.ListPregledForFilter.Count - 1 do
//  begin
//    preg := CollPregled.ListPregledForFilter[i];
//    if preg.StartDate <> FilterDate then
//    begin
//      vtrTestFilter.AddChild(nil, nil);
//      FilterDate := preg.StartDate;
//    end;
//  end;
//  vtrTestFilter.EndUpdate;
//  Elapsed := Stopwatch.Elapsed;
//  Panel1.Caption := FloatToStr(Elapsed.TotalMilliseconds);


  //vtrPregledi.BeginUpdate;
//  vtrPregledi.FullExpand();
//  vtrPregledi.EndUpdate;

  //if vtrPregledi.IsFiltered[vPregledi] then
//  begin
//    vtrPregledi.Expanded[vPregledi] := true;
//    vtrPregledi.IsFiltered[vPregledi] := false;
//    vtrPregledi.Repaint;
//  end
//  else
//  begin
//    vtrPregledi.Expanded[vPregledi] := False;
//    vtrPregledi.IsFiltered[vPregledi] := True;
//    vtrPregledi.Repaint;
//  end;

  //Stopwatch := TStopwatch.StartNew;
//  vtrPregledi.BeginUpdate;
//  vtrPregledi.RootNodeCount := CollPatient.Count;
//  vtrPregledi.EndUpdate;
//  Elapsed := Stopwatch.Elapsed;
//  Panel1.Caption := FloatToStr(Elapsed.TotalMilliseconds);


  //Scale := Scale*(pnl1.Font.Height/(pnl1.Font.Height + 1));
  //pnl1.ScaleBy(round(pnl1.Font.Height/(pnl1.Font.Height + 1)* 100), 100);
  //GetObject(pnl1.Font.Handle, sizeof(lf), @lf);
  //lf.lfHeight := round(lf.lfHeight * Scale);
  //hFnt := CreateFontIndirect(lf);
 // pnl1.Font.Handle := hFnt;

//end;

procedure TfrmSuperHip.Button1Click(Sender: TObject);
var
  i: Integer;
  pat: TRealPatientNewItem;
  dat: TDate;
  log: TlogicalPatientNewSet;
  dataGraph: PAspRec;
  node: PVirtualNode;
begin

  if profGR = nil then
  begin
    //LoadVtrNomenNzis1;
//    OpenBufNomenNzis('c:\temp\NzisNomen.adb');
    OpenBufNomenNzis(ParamStr(2) + 'NzisNomen.adb');
    LoadVtrNomenNzis1();
    profGR := TProfGraph.create;

    profGR := TProfGraph.create;
    profGR.BufNomen := AspectsNomFile.Buf;
    //profGR.BufADB := AspectsHipFile.Buf;
    //profGR.posDataADB := AspectsHipFile.FPosData;
    profGR.vtrGraph := vtrGraph;
    profGR.Adb_DM := Adb_DM;
  end;
  profGR.VisibleMinali := False;
  profGR.VisibleBudeshti := False;
  Stopwatch := TStopwatch.StartNew;
  vtrGraph.BeginUpdate;
  vtrGraph.Clear;
  vRootGraph := vtrGraph.AddChild(nil, nil);
    dataGraph := vtrGraph.GetNodeData(vRootGraph);
    dataGraph.vid := vvNone;
    dataGraph.index := 0;
  Adb_DM.ACollPatGR.Clear;
  Adb_DM.CollPatient.FillListNodes(AspectsLinkPatPregFile, vvPatient);

  for i := 0 to Adb_DM.CollPatient.ListNodes.Count - 1 do
  begin
    //node := pointer(PByte(CollPatient.ListNodes[i]) - lenNode);
    pat := TRealPatientNewItem(Adb_DM.ACollPatGR.Add);
    //pat := TRealPatientNewItem.Create(nil);
    pat.DataPos := Adb_DM.CollPatient.ListNodes[i].DataPos;
    pat.FNode := pointer(PByte(Adb_DM.CollPatient.ListNodes[i]) - lenNode);
    //pat := CollPatient.Items[i];
    dat := Adb_DM.CollPatient.getDateMap(Adb_DM.CollPatient.ListNodes[i].DataPos, word(PatientNew_BIRTH_DATE));
    log := TlogicalPatientNewSet(Adb_DM.CollPatient.getLogical40Map(Adb_DM.CollPatient.ListNodes[i].DataPos, word(PatientNew_Logical)));
    profGR.SexMale := (TLogicalPatientNew.SEX_TYPE_M in log) ;
    profGR.CurrDate := dat;
    profGR.GeneratePeriod(pat);
    vtrGraph.OnCompareNodes := nil;
    //vtrGraph.OnGetText := nil;
    vtrGraph.OnGetImageIndexEx := nil;
    //if i < 4100 then
    begin
      profGR.LoadVtrGraph1(pat, i);
    end;
    //FreeAndNil(pat);
  end;
  vtrGraph.EndUpdate;
  //vtrGraph.Clear;
  //CollPatGR.Clear;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.lines.add(Format('%d nodes за  проф: %f', [vtrGraph.TotalCount, Elapsed.TotalMilliseconds]));
end;


procedure TfrmSuperHip.Button2Click(Sender: TObject);
var
  i: Integer;
  linkPos: cardinal;
  pCardinalData: PCardinal;
  FPosLinkData: Cardinal;
  RunNode, vPreg: PVirtualNode;
  buflink: Pointer;
  data, dataPat, dataPreg: PAspRec;
begin
  buflink := AspectsLinkPatPregFile.Buf;
  linkPos := 100;
  i := 0;
  pCardinalData := pointer(PByte(buflink));
  FPosLinkData := pCardinalData^;
  while linkpos < FPosLinkData do
  begin
    RunNode := pointer(PByte(bufLink) + linkpos);
    data := pointer(PByte(RunNode) + lenNode);
    dataPreg := pointer(PByte(RunNode.Parent) + lenNode);
    if (data.vid = vvDiag) and (dataPreg.vid = vvPregled) then
    begin
      inc(i);
      Fdm.InsertDiag(Data.DataPos, dataPreg.DataPos, Adb_DM.CollDiag, Adb_DM.CollPregled);
    end;
    Inc(linkPos, LenData);
  end;
  Fdm.ibsqlDiag.Transaction.CommitRetaining;
  Button2.Caption := IntToStr(i);
  Exit;
 // vtrPregledPat.FullCollapse();
 // Exit;
  vtrPregledPat.BeginUpdate;
  //vtrPregledPat.FullExpand();
  //v := vtrPregledPat.RootNode.FirstChild.FirstChild;
//  i := 0;
//  while (v <> nil)  do  //and (i < 100000)
//  begin
//    vtrPregledPat.Expanded[v] := True;
//    v := v.NextSibling;
//    inc(i);
//  end;
  vtrPregledPat.EndUpdate;
  vtrPregledPat.ValidateNode(vtrPregledPat.RootNode.FirstChild.FirstChild,True);
  Button2.Tag := 1;
  Exit;
  Caption := DateToStr(UserDate);
  TCL000EntryCollection.ImportNomenList(AspectsNomFile);
  //vtrPregledPat.FullExpand();
 // for i := 1 to CL132Coll.Count - 1 do
//  begin
//    //if CL132Coll.Items[i]  then
//
//  end;
end;

procedure TfrmSuperHip.Button3Click(Sender: TObject);
begin
  //pgcWork.ActivePage := tsVideo;
  InternalChangeWorkPage(tsVideo);
end;

procedure TfrmSuperHip.ButtonedEdit1Change(Sender: TObject);
begin
  SearchTextSpisyci := ButtonedEdit1.Text;
end;

procedure TfrmSuperHip.ButtonedEdit1DblClick(Sender: TObject);
begin
  ButtonedEdit1RightButtonClick(nil);
end;

procedure TfrmSuperHip.ButtonedEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    40:// nadolu
    begin
      FindDoctor(true);
      Key := 0;
    end;
    38:// nagore
    begin
      FindDoctor(false);
      Key := 0;
    end;
  end;
end;

procedure TfrmSuperHip.ButtonedEdit1RightButtonClick(Sender: TObject);
var
  i: Integer;
  doc: TRealDoctorItem;
  node: PVirtualNode;
  data: PNodeRec;
begin
  if ButtonedEdit1.Tag = 0 then
  begin
    node := vtrSpisyci.RootNode.FirstChild;
  end
  else
  begin
    node := PVirtualNode(ButtonedEdit1.Tag).NextSibling;
  end;
  while node <> nil do
  begin
    data := vtrSpisyci.GetNodeData(node);
    doc := Adb_DM.CollDoctor.Items[data.index];
    if AnsiUpperCase(doc.FullName).Contains(AnsiUpperCase(SearchTextSpisyci)) then
    begin
      ButtonedEdit1.Tag := Integer(node);
      vtrSpisyci.FocusedNode := doc.Node;
      vtrSpisyci.Selected[doc.Node] := True;
      Exit;
    end;
    node := node.NextSibling;
  end;

  //for i := ButtonedEdit1.Tag to CollDoctor.Count - 1 do
//  begin
//    doc := CollDoctor.Items[i];
//    if AnsiUpperCase(doc.FullName).Contains(AnsiUpperCase(SearchTextSpisyci)) then
//    begin
//      ButtonedEdit1.Tag := i + 1;
//      vtrSpisyci.FocusedNode := doc.Node;
//      vtrSpisyci.Selected[doc.Node] := True;
//      Exit;
//    end;
//  end;
  ButtonedEdit1.Tag := 0;
end;

procedure TfrmSuperHip.CalcStatusDB;
var
  k: Double;
begin
  exit;
  if Adb_DM.AdbMain = nil then exit;

  lblGuidDb.caption := 'GUID: ' + Adb_DM.AdbMain.GUID.ToString;
  lblSizeCMD.Caption := 'Размер на файла: ' + inttostr(Adb_DM.AdbMain.Size);
  k := pnlStatusDB.Width / Adb_DM.AdbMain.Size;
  pnlMetaDataDB.Left := Round(Adb_DM.AdbMain.FposMetaData * k);
  pnlMetaDataDB.Width := Round(Adb_DM.AdbMain.GetLenMetaData * k);
  pnlMetaDataDB.Caption := IntToStr(Round(Adb_DM.AdbMain.GetLenMetaData/1024/1024));
  pnlDataDB.Left := Round(Adb_DM.AdbMain.FPosData * k);
  pnlDataDB.Width := Round(Adb_DM.AdbMain.GetLenData * k);
  pnlDataDB.Caption := IntToStr(Round(Adb_DM.AdbMain.GetLenData/1024/1024));

  pnlMetaDataDB.Visible := True;
  pnlDataDB.Visible := True;

  //lblSizeNomenNzisCMD.Caption := inttostr(AspectsNomFile.SizeCMD);
//  k := pnlStatusNomenNzis.Width / AspectsNomFile.Size;
//  pnlMetaDataNomenNzis.Left := Round(AspectsNomFile.FposMetaData * k);
//  pnlMetaDataNomenNzis.Width := Round(AspectsNomFile.FLenMetaData * k);
//  pnlMetaDataNomenNzis.Caption := IntToStr(Round(AspectsNomFile.FLenMetaData/1024/1024));
//  pnlDataNomenNzis.Left := Round(AspectsNomFile.FPosData * k);
//  pnlDataNomenNzis.Width := Round(AspectsNomFile.FLenData * k);
//  pnlDataNomenNzis.Caption := IntToStr(Round(AspectsNomFile.FLenData/1024/1024));
end;

procedure TfrmSuperHip.CertStorageUpdate(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_Cert_Storage, 0, 0);
end;

procedure TfrmSuperHip.CheckCollForInsert;
begin

end;

procedure TfrmSuperHip.CheckCollForSave;
var
  i: Integer;
  doc: TRealDoctorItem;
  cl132: TRealCl132Item;
  mdn: TRealMDNItem;
  anal: TRealExamAnalysisItem;
  cnt: Integer;
begin
  Stopwatch := TStopwatch.StartNew;
  cnt := 0;
  for i := 0 to Adb_DM.CollDoctor.Count - 1 do
  begin
    doc := Adb_DM.CollDoctor.Items[i];
    if doc.PRecord <> nil then
    begin
      inc(cnt);
    end;
  end;

  for i := 0 to Adb_DM.CL132Coll.Count - 1 do
  begin
    cl132 := Adb_DM.CL132Coll.Items[i];
    if cl132.PRecord <> nil then
    begin
      inc(cnt);
    end;
  end;

  for i := 0 to Adb_DM.CollMDN.Count - 1 do
  begin
    mdn := Adb_DM.CollMDN.Items[i];
    if mdn.PRecord <> nil then
    begin
      inc(cnt);
    end;
  end;

  for i := 0 to Adb_DM.CollExamAnal.Count - 1 do
  begin
    anal := Adb_DM.CollExamAnal.Items[i];
    if anal.PRecord <> nil then
    begin
      inc(cnt);
    end;
  end;

  Adb_DM.CollPatient.checkforSave(cnt);
  //for i := 0 to CollPatient.Count - 1 do
//  begin
//    if CollPatient.items[i].PRecord <> nil then
//    begin
//      inc(cnt);
//    end;
//  end;

  btnSaveAll.Enabled := (cnt > 0) or (Adb_DM.ListPregledLinkForInsert.Count > 0);
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add('CheckCollForSave  ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.CheckDublePat;
begin
  //msgColl.CollPat.so
end;

procedure TfrmSuperHip.CheckForUpdate;
var
  i, j: integer;
  doc: TRealDoctorItem;
  unfav: TUnfavItem;
  mnt, yr: word;
  MastUpdate: Boolean;
begin
  MastUpdate := False;
  for i := 0 to Adb_DM.CollDoctor.Count - 1 do
  begin
    doc := Adb_DM.CollDoctor.Items[i];
    for j := 0 to doc.FListUnfav.Count - 1 do
    begin
      mnt := (j mod 12) ;
      if mnt = 0 then mnt := 12;
      if (j mod 12) = 0 then
      begin
        yr := (j div 12) + 2023;
      end
      else
      begin
        yr := (j div 12) + 2024;
      end;
      if doc.FListUnfav[j] = nil then
      begin
        if doc.FListUnfavDB[j] = nil then Continue;
        MastUpdate := True;
        Break;
      end
      else
      begin
        if doc.FListUnfavDB[j] <> nil then Continue;
        MastUpdate := True;
        Break;
      end;
    end;
    if MastUpdate then
    Break;
  end;
  if MastUpdate then
  begin
    btnCancel.Enabled := True;
    btnSaveUnfav.Enabled := True;
  end
  else
  begin
    btnCancel.Enabled := false;
    btnSaveUnfav.Enabled := false;
  end;
end;

procedure TfrmSuperHip.CheckIncMN;
var
  patNode: PVirtualNode;
  run, runPreg: PVirtualNode;
  dataRun, dataRunPreg, dataPat: PAspRec;
  nrn, egn: string;
  cntDB, cnt360: Integer;
  prId: array[0..2] of Integer;
begin
  patNode := vtrPregledPat.RootNode.FirstChild.FirstChild;
  while patNode <> nil do
  begin
    dataPat := Pointer(PByte(patNode) + lenNode);
    egn := Adb_DM.CollPatient.getAnsiStringMap(dataPat.DataPos, word(PatientNew_EGN));

    run := patNode.FirstChild;
    while run <> nil do
    begin
      dataRun := Pointer(PByte(run) + lenNode);
      cntDB:= 0;
      cnt360 := 0;
      if dataRun.vid = vvIncMN then
      begin
        nrn := Adb_DM.CollIncMN.getAnsiStringMap(datarun.DataPos, word(INC_NAPR_NRN));
        if nrn = '' then
        begin
          run := run.NextSibling;
          Continue;
        end;
        if nrn = '22164C019A10' then
          Caption := 'ddd';
        Fdm.ibsqlCommand.Close;
        Fdm.ibsqlCommand.SQL.Text := 'select Count(*) from pregled pr where pr.copied_from_nrn = :nrn';
        Fdm.ibsqlCommand.Params[0].AsString := nrn;
        Fdm.ibsqlCommand.ExecQuery;
        cntDB := Fdm.ibsqlCommand.Fields[0].AsInteger;
        cnt360 := 0;
        prId[0] := -1;
        prId[1] := -1;
        prId[2] := -1;

        runPreg := run.FirstChild;
        while runPreg <> nil do
        begin
          dataRunPreg := Pointer(PByte(runPreg) + lenNode);
          prId[cnt360] := Adb_DM.CollPregled.getIntMap(dataRunPreg.DataPos, word(PregledNew_ID));
          if dataRunPreg.vid = vvPregled then
            inc(cnt360);

          runPreg := runPreg.NextSibling;
        end;
      end;
      if cntDB <> cnt360 then
      begin
        Fdm.ibsqlCommand.Close;
        Fdm.ibsqlCommand.SQL.Text := 'update pregled  set copied_from_nrn = :NewNrn  where id in( :id, :id1, :id2 )';
        Fdm.ibsqlCommand.ParamByName('NewNrn').AsString := nrn;
        Fdm.ibsqlCommand.ParamByName('id').AsInteger := prId[0];
        Fdm.ibsqlCommand.ParamByName('id1').AsInteger := prId[1];
        Fdm.ibsqlCommand.ParamByName('id2').AsInteger := prId[2];
        Fdm.ibsqlCommand.ExecQuery;

        mmoTest.Lines.Add(Format('cntDB: %d    cnt360: %d -- nrn: %s ; egn: %s', [cntDB, cnt360, nrn, egn]));
      end;
      run := run.NextSibling;
    end;
    patNode := patNode.NextSibling;
  end;
  Fdm.ibsqlCommand.Transaction.CommitRetaining;
end;

procedure TfrmSuperHip.CheckIncMNInPat;
var
  patNode: PVirtualNode;
  run, runPreg: PVirtualNode;
  dataRun, dataRunPreg, dataPat: PAspRec;
  nrn, egn: string;
  IdPatDB, IdPat360: Integer;
begin
  patNode := vtrPregledPat.RootNode.FirstChild.FirstChild;

  while patNode <> nil do
  begin
    dataPat := Pointer(PByte(patNode) + lenNode);
    egn := Adb_DM.CollPatient.getAnsiStringMap(dataPat.DataPos, word(PatientNew_EGN));
    run := patNode.FirstChild;
    while run <> nil do
    begin
      dataRun := Pointer(PByte(run) + lenNode);
      if dataRun.vid = vvIncMN then
      begin
        nrn := Adb_DM.CollIncMN.getAnsiStringMap(datarun.DataPos, word(INC_NAPR_NRN));
        if nrn = '' then
        begin
          run := run.NextSibling;
          Continue;
        end;

        if nrn = '22164C019A10' then
          Caption := 'ddd';
        Fdm.ibsqlCommand.Close;
        Fdm.ibsqlCommand.SQL.Text := 'select imn.pacient_id from inc_napr imn where imn.nrn = :nrn';
        Fdm.ibsqlCommand.Params[0].AsString := nrn;
        Fdm.ibsqlCommand.ExecQuery;
        IdPatDB := Fdm.ibsqlCommand.Fields[0].AsInteger;
        IdPat360 := Adb_DM.CollPatient.getIntMap(dataPat.DataPos, word(PatientNew_ID));
        //runPreg := run.FirstChild;
//        while runPreg <> nil do
//        begin
//          dataRunPreg := Pointer(PByte(runPreg) + lenNode);
//          if dataRunPreg.vid = vvPregled then
//            inc(cnt360);
//
//          runPreg := runPreg.NextSibling;
//        end;
      end;
      if IdPat360 <> IdPatDB then
      begin
        mmoTest.Lines.Add(Format('IdPatDB: %d    IdPat360: %d ------ nrn : %s; egn--- %s', [IdPatDB, IdPat360, nrn, egn]));
      end;
      run := run.NextSibling;
    end;
    patNode := patNode.NextSibling;
  end;
end;

function TfrmSuperHip.CheckTokenFromCert: Boolean;
var
  idCert: string;
  i: Integer;
  NzisToken: TNzisTokenItem;
begin
  Result := False;
  idCert := BuildHexString(CertForThread.SerialNumber);
  for i := 0 to Adb_DM.CollNzisToken.Count - 1 do
  begin
    NzisToken := Adb_DM.CollNzisToken.Items[i];
    if Now > NzisToken.getDateMap(Adb_DM.CollNzisToken.Buf, Adb_DM.CollNzisToken.posData, word(NzisToken_ToDatTime)) then
      Continue;
    Result := True;
    edtToken.Text := NzisToken.getAnsiStringMap(Adb_DM.CollNzisToken.Buf, Adb_DM.CollNzisToken.posData, word(NzisToken_Bearer));
    Exit;
  end;
end;

procedure TfrmSuperHip.chkAspectDistrClick(Sender: TObject);
begin
  if chkAspectDistr.Checked then
  begin
    StartAspectPerformerThread;
  end;
end;

procedure TfrmSuperHip.ChoiceAnal(Sender: TObject);
begin
  if vtrNewAnal.RootNodeCount = 0 then
  begin
    HipNomenAnalsClick(nil);
  end;
  Stopwatch := TStopwatch.StartNew;
  vtrTemp.BeginUpdate;
  vtrTemp.Header.Columns.Items[0].Text := 'Изследвания';
  vtrTemp.Header.Columns.Items[0].Tag := Integer(vvAnal);
  vtrTemp.Clear;
  vtrTemp.NodeDataSize := sizeof(TAspRec);

  CopyNodesFromAspectToTempVtr(vtrNewAnal, vtrNewAnal.RootNode.FirstChild);
  vtrTemp.OnGetText := vtrNewAnalGetText;

  vtrTemp.EndUpdate;
  Elapsed := Stopwatch.Elapsed;
  pgcTree.ActivePage := tsTempVTR;
  //pnlGraph.Parent := nil;

  mmotest.Lines.Add( 'CopyAnalTree ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.ChoiceDoctor(sender: TObject);
begin
  tmpVtr.FilterText := edtFilterTemp.Text;
  tmpVtr.ChoiceDoctor(sender);
  pgcTree.ActivePage := tsTempVTR;
end;

procedure TfrmSuperHip.ChoiceMKB(sender: TObject);
begin
  tmpVtr.FilterText := edtFilterTemp.Text;
  tmpVtr.ChoiceMKB(sender);
  pgcTree.ActivePage := tsTempVTR;
end;

procedure TfrmSuperHip.ckb1Enter(Sender: TObject);
begin
  //
end;

//procedure TfrmSuperHip.ClearColl;
//begin
//  CollDoctor.clear;
//  ListDoctorForFDB.Clear;
//  CollUnfav.clear;
//  CollUnfav.clear;
//  CollMkb.clear;
//  CollPregled.clear;
//  ListPregledForFDB.Clear;
//  CollPatient.clear;
//  ListPatientForFDB.Clear;
//  CollPatPis.clear;
//  CollDiag.clear;
//  CollMDN.clear;
//
//  CollDoctor.CntInADB := 0;
//  CollUnfav.CntInADB := 0;
//  CollUnfav.CntInADB := 0;
//  CollMkb.CntInADB := 0;
//  CollPregled.CntInADB := 0;
//  CollPatient.CntInADB := 0;
//  CollPatPis.CntInADB := 0;
//  CollDiag.CntInADB := 0;
//  CollMDN.CntInADB := 0;
//
//
//  //CollPregledVtor := Tlist<TRealPregledNewItem>.Create;
////  CollPregledPrim := Tlist<TRealPregledNewItem>.Create;
////  AnalsNewColl := TAnalsNewColl.Create(TAnalsNewItem);
//end;

procedure TfrmSuperHip.CloseApp(Sender: TObject);
begin
  Close;
end;

procedure TfrmSuperHip.ClosePregX003(pregNode: PVirtualNode);
var
  nzisThr: TNzisThread;
  data: PAspRec;
begin
  //if (edtToken.Text = '') or (Now > TokenToTime) then
//  begin
//    btnTokenClick(nil);
//  end;



  nzisThr := TNzisThread.Create(false, Adb_DM);
  nzisThr.FreeOnTerminate := True;
  nzisThr.IsTestNZIS := true;

  nzisThr.OnSended := NzisOnSended;
  nzisThr.HndSuperHip := Self.Handle;
  nzisThr.Node := pregNode;
  nzisThr.MsgType := TNzisMsgType.X003;
  nzisThr.token := '';//edtToken.Text;
  //nzisThr.CurrentCert := CertForThread;
  nzisThr.Resume;
end;

procedure TfrmSuperHip.CMDialogKey(var Msg: TCMDialogKey);
begin
  if Screen.ActiveControl = fmxCntrDyn then
    Msg.Result := 1;
end;

procedure TfrmSuperHip.ColMoved(const ACol: TColumn; const OldCol, NewCol: integer);
begin
  //
end;

function TfrmSuperHip.ConditionToStr(c: TConditionType): string;
begin
  case c of
    cotEqual: result := '=';
    cotNotEqual:  result := '<>';
    cotBigger:  result := '>';
    cotSmaller:  result := '<';
    cotBiggerEqual:  result := '>=';
    cotSmallerEqual:  result := '<=';
    cotIsNull:  result := 'IS NULL';
    cotNotIsNull:  result := 'IS NOT NULL';
    cotAny:  result := '*';
    cotContain:  result := 'CONTAINS';
    cotNotContain:  result := 'NOT CONTAINS';
    cotStarting:  result := 'STARTS WITH';
    cotNotStarting:  result := 'NOT STARTS WITH';
    cotEnding:  result := 'ENDS WITH';
    cotNotEnding:  result := 'NOT ENDS WITH';
    cotIn:  result := 'IN';
    cotNotIn:  result := 'NOT IN';
    cotBetween:  result := 'BETWEEN';
    cotSens:  result := 'CASE SENSITIVE';
    cotNotSmaller:  result := ' не по-малко';
    cotNotBigger:  result := 'не по-голямо';
    cotNotSmallerEqual:  result := 'не по-малко или равно';
    cotNotBiggerEqual:  result := 'не по-голямо или равно';

  else
    Result := '??';
  end;
end;


procedure TfrmSuperHip.CopyNodesFromAspectToTempVtr(
  vtrAspect: TVirtualStringTreeAspect; nodeAspect: PVirtualNode);
begin
  vtrAspect.CopyTo(nodeAspect, vtrTemp, amInsertAfter, False);
end;

procedure TfrmSuperHip.CreateFieldGroup(FieldNode: PVirtualNode);
var
  FieldOrGroupNode, newNode, objectNode: PVirtualNode;
  linkPos: Cardinal;
  dataObjNode: PAspRecFilter;
  dataFieldNode, dataNew, dataGroup : PAspRec;
  coll: TBaseCollection;
  CollType: TCollectionsType;
begin
  objectNode := FieldNode.Parent;
  dataObjNode := Pointer(PByte(objectNode) + lenNode);
  dataFieldNode := Pointer(PByte(FieldNode) + lenNode);

  // 1. създай групов възел
  AspectsFilterLinkFile.AddNewNode(vvFieldOrGroup, 0, FieldNode, amInsertBefore, FieldOrGroupNode, linkPos);
  FieldOrGroupNode.Dummy := FieldNode.Dummy;

  // 2. премести условието вътре в групата
  vtrSearch.MoveTo(FieldNode, FieldOrGroupNode, amAddChildLast, false);

  // 3. създай ново празно условие
  AspectsFilterLinkFile.AddNewNode(vvFieldFilter, 0, FieldOrGroupNode, amAddChildLast, newNode, linkPos);
  dataNew := Pointer(PByte(newNode) + lenNode);
  dataNew.index := dataFieldNode.index;
  dataNew.DataPos := dataFieldNode.DataPos;
  newNode.Dummy := FieldNode.Dummy;
  newNode.CheckType := ctCheckBox;
  newNode.CheckState := csCheckedNormal;


  //CollType := TCollectionsType(dataObjNode.DataPos);
//  coll := GetCollectionByType(Word(CollType));
  coll := Adb_DM.lstColl[ord(dataObjNode.CollType)];
  AddOperatorNodes(newNode, coll, newNode.Dummy);

  vtrSearch.Expanded[FieldOrGroupNode] := True;
end;

procedure TfrmSuperHip.CreateParams(var Params: TCreateParams);
begin
  inherited;
  //Params.Style := Params.Style  or WS_THICKFRAME;
end;

procedure TfrmSuperHip.Delete99;
var
  i: Integer;
begin
  for i := Adb_DM.AmsgColl.Count - 1 downto 0 do
  begin
    if (i mod 300) = 0 then
    begin
      FmxRoleBar.rctProgres.Width := FmxRoleBar.rctButton.Width * (i/Adb_DM.AmsgColl.Count);
      FmxRoleBar.rctProgres.EndUpdate;
      Application.ProcessMessages;
    end;
    if string(Adb_DM.AmsgColl.Items[i].PRecord.RESP).Contains('<nhis:messageType value="X099"') then
      Adb_DM.AmsgColl.Delete(i);
  end;
end;

procedure TfrmSuperHip.DeleteAnalFromMdn(sender: tobject; var MdnLink,
  AnalLink: PVirtualNode; var TempItem: TRealExamAnalysisItem);

begin
  if AnalLink = nil then Exit;

  vtrPregledPat.InternalDisconnectNode(AnalLink, false);
  vtrPregledPat.Repaint;
  Include(AnalLink.States, vsDeleting);
end;

procedure TfrmSuperHip.DeleteDiag(sender: tobject; var PregledLink,
  DiagLink: PVirtualNode; var TempItem: TRealDiagnosisItem);
begin
  Adb_DM.CollPregled.streamComm.Size := 0;
  Adb_DM.CollPregled.streamComm.OpType := toDeleteNode;
  Adb_DM.CollPregled.streamComm.Size := 12 + 4;
  Adb_DM.CollPregled.streamComm.Ver := 0;
  Adb_DM.CollPregled.streamComm.Vid := ctLink;
  Adb_DM.CollPregled.streamComm.DataPos := Cardinal(DiagLink);
  Adb_DM.CollPregled.streamComm.Propertys := [];
  Adb_DM.CollPregled.streamComm.Len := Adb_DM.CollPregled.streamComm.Size;
  streamCmdFile.CopyFrom(Adb_DM.CollPregled.streamComm, 0);
  RemoveDiag(PregledLink, TempItem);
end;

procedure TfrmSuperHip.DeleteEvent(sender: TObject);
var
  pregLink: PVirtualNode;
  PWordData: PWord;
  data: PAspRec;

begin
  pregLink := Adb_DM.CollPregled.GetNodeFromID(AspectsLinkPatPregFile.Buf, vvPregled, Word(PregledNew_ID), TRealPregledNewItem(sender).PregledID);
  if pregLink = nil then Exit;

  vtrPregledPat.InternalDisconnectNode(pregLink, false);
  vtrPregledPat.Repaint;
  Include(pregLink.States, vsDeleting);

  Adb_DM.CollPregled.streamComm.Size := 0;
  Adb_DM.CollPregled.streamComm.OpType := toDeleteNode;
  Adb_DM.CollPregled.streamComm.Size := 12 + 4;
  Adb_DM.CollPregled.streamComm.Ver := 0;
  Adb_DM.CollPregled.streamComm.Vid := ctLink;
  Adb_DM.CollPregled.streamComm.DataPos := Cardinal(pregLink);
  Adb_DM.CollPregled.streamComm.Propertys := [];
  Adb_DM.CollPregled.streamComm.Len := Adb_DM.CollPregled.streamComm.Size;
  streamCmdFile.CopyFrom(Adb_DM.CollPregled.streamComm, 0);
end;

procedure TfrmSuperHip.DeleteMdnFromPregled(sender: tobject; var PregledLink, MdnLink: PVirtualNode; var mdn: TRealMDNItem);

begin
  if MdnLink = nil then Exit;

  vtrPregledPat.InternalDisconnectNode(MdnLink, false);
  vtrPregledPat.Repaint;
  Include(MdnLink.States, vsDeleting);
end;

procedure TfrmSuperHip.DoUSBArrival(sender: TObject);
begin
  thrCert.IsFirst := True;
end;

procedure TfrmSuperHip.DoUSBRemove(sender: TObject);
begin
  thrCert.IsFirst := True;
end;

procedure TfrmSuperHip.dtp1Change(Sender: TObject);
begin
  //Option.UserDate := dtp1.Date;
end;

//procedure TfrmSuperHip.DynWinPanel1FilterButtonClick2(sender: TDynWinPanel; ctrl: TBaseControl; FltrList: TList<ComboBoxHip.TFilterValues>);
//var
//  i: Integer;
//  str: string;
//  FV: TFilterValues;
//  preg, pregGroup: TPregledItem;
//  tstr: TString;
//  dynControl: TBaseControl;
//  FilterDate: TDate;
//  filterAmbNo: Integer;
//  vFilter: PVirtualNode;
//  data: PAspRec;
//begin
//  Stopwatch := TStopwatch.StartNew;
//  listFilterCount.Clear;
//  FltrList.Clear;
//  FilterStringsHave.Clear;
//  //mmoTest.Lines.BeginUpdate;
//  maxCountPregledInPat := 0;
//
//  //vtrPregledi.BeginUpdate;
//  case ctrl.tableType of
//    1://pacienti
//    begin
//      vtrPregledi.IterateSubtree(nil, IterateFilterPatField, ctrl);
//    end;
//    20://pregledi
//    begin
//      dynControl := TBaseControl(ctrl);
//      for i := 0 to CollPregled.Count - 1 do
//      begin
//        preg := CollPregled.Items[i];
//        tstr := tstring.create;
//        case dynControl.ColIndex of
//          3: tstr.str := IntToStr(preg.AmbListNo);
//          4: tstr.str := DateToStr(preg.StartDate);
//        end;
//        FilterStringsHave.Add(tstr);
//      end;
//    end;
//    2:
//    begin
//      Stopwatch := TStopwatch.StartNew;
//      dynControl := TBaseControl(ctrl);
//      case dynControl.ColIndex of
//        4:
//        begin
//          CollPregled.SortListByStartDate(CollPregled.ListPregledForFilter);
//          FilterDate := 0;
//          DynWinPanel1.lstvtr1.vtrList.BeginUpdate;
//          DynWinPanel1.lstvtr1.vtrList.Clear;
//          DynWinPanel1.lstvtr1.vtrList.OnGetText := CollPregled.vtrFilterGetText;
//
//          for i := 0 to CollPregled.ListPregledForFilter.Count - 1 do
//          begin
//            preg := CollPregled.ListPregledForFilter[i];
//            if preg.StartDate <> FilterDate then
//            begin
//              vFilter := DynWinPanel1.lstvtr1.vtrList.AddChild(nil, nil);
//              data := DynWinPanel1.lstvtr1.vtrList.GetNodeData(vFilter);
//              data.vid := vvPregled;
//              data.index := i;
//              FilterDate := preg.StartDate;
//              pregGroup := preg;
//              pregGroup.GroupField := gfStartDate;
//              //pregGroup.CountInGroup := 1;
//            end
//            else
//            begin
//              //pregGroup.CountInGroup := pregGroup.CountInGroup + 1;
//            end;
//          end;
//        end;
//        3:
//        begin
//          CollPregled.SortListByAmbListNo(CollPregled.ListPregledForFilter);
//          filterAmbNo := -1;
//          DynWinPanel1.lstvtr1.vtrList.BeginUpdate;
//          DynWinPanel1.lstvtr1.vtrList.Clear;
//          DynWinPanel1.lstvtr1.vtrList.OnGetText := CollPregled.vtrFilterGetText;
//          for i := 0 to CollPregled.ListPregledForFilter.Count - 1 do
//          begin
//            preg := CollPregled.ListPregledForFilter[i];
//            if preg.AmbListNo <> filterAmbNo then
//            begin
//              vFilter := DynWinPanel1.lstvtr1.vtrList.AddChild(nil, nil);
//              data := DynWinPanel1.lstvtr1.vtrList.GetNodeData(vFilter);
//              data.vid := vvPregled;
//              data.index := i;
//              pregGroup := preg;
//              pregGroup.GroupField := gfAmbListNo;
//              //pregGroup.CountInGroup := 1;
//              filterAmbNo := preg.AmbListNo;
//            end
//            else
//            begin
//              //pregGroup.CountInGroup := pregGroup.CountInGroup + 1;
//            end;
//          end;
//        end;
//      end;
//
//      DynWinPanel1.lstvtr1.vtrList.EndUpdate;
//    end;
//  end;
//  Elapsed := Stopwatch.Elapsed;
//
//  //DynWinPanel1.ShowFilterList;
//  frmFilter.Left := DynWinPanel1.leftlistfilter;
//  frmFilter.Top := DynWinPanel1.topListFilter;
//  frmFilter.Show;
//
//
//  Panel1.Caption := FloatToStr(Elapsed.TotalMilliseconds) + ' fff=   ' +
//       IntToStr(DynWinPanel1.lstvtr1.vtrList.RootNode.ChildCount);
//
//  //vtrPregledi.EndUpdate;
//  Exit;
//  SortListString(FilterStringsHave);
//  str:= '';
//  for i := 0 to FilterStringsHave.Count - 1 do
//  begin
//    if str <> FilterStringsHave[i].str then
//    begin
//      if i <> 0 then
//        FltrList.Add(FV);
//      FV.value := FilterStringsHave[i].str;
//      //mmoTest.Lines.Add(FV.value);
//      FV.count := 1;
//      str := FilterStringsHave[i].str;
//    end
//    else
//    begin
//      inc(FV.count);
//    end;
//  end;
//  DynWinPanel1.lstvtr1.FillFilterList;
//
//  DynWinPanel1.ShowFilterList;
//  Elapsed := Stopwatch.Elapsed;
//  Panel1.Caption := FloatToStr(Elapsed.TotalMilliseconds);
//end;

//procedure TfrmSuperHip.DynWinPanel1FilterButtonClick3(sender: TDynWinPanel; ctrl: TBaseControl; FltrList: TList<ComboBoxHip.TFilterValues>);
//var
//  i: Integer;
//  str: string;
//  FV: TFilterValues;
//  preg, pregGroup: TPregledItem;
//  tstr: TString;
//  dynControl: TBaseControl;
//  FilterDate: TDate;
//  filterAmbNo: Integer;
//  vFilter: PVirtualNode;
//  data: PAspRec;
//begin
//  Stopwatch := TStopwatch.StartNew;
//  listFilterCount.Clear;
//  FltrList.Clear;
//  FilterStringsHave.Clear;
//  //mmoTest.Lines.BeginUpdate;
//  maxCountPregledInPat := 0;
//
//  case ctrl.tableType of
//    1://pacienti
//    begin
//      vtrPregledi.IterateSubtree(nil, IterateFilterPatField, ctrl);
//    end;
//    2:
//    begin
//      Stopwatch := TStopwatch.StartNew;
//      dynControl := TBaseControl(ctrl);
//      frmFilter.vtrFilter.BeginUpdate;
//      frmFilter.vtrFilter.Clear;
//      frmFilter.vtrFilter.OnGetText := CollPregled.vtrFilterGetText;
//      case dynControl.ColIndex of
//        4:
//        begin
//          CollPregled.SortListByStartDate(CollPregled.ListPregledForFilter);
//          Elapsed := Stopwatch.Elapsed;
//          FilterDate := 0;
//
//
//          for i := 0 to CollPregled.ListPregledForFilter.Count - 1 do
//          begin
//            preg := CollPregled.ListPregledForFilter[i];
//            if preg.StartDate <> FilterDate then
//            begin
//              vFilter := frmFilter.vtrFilter.AddChild(nil, nil);
//              vFilter.CheckType := ctTriStateCheckBox;
//              data := frmFilter.vtrFilter.GetNodeData(vFilter);
//              data.vid := vvPregled;
//              data.index := i;
//              pregGroup := preg;
//              pregGroup.GroupField := gfStartDate;
//              pregGroup.ListGroup.Clear;
//              pregGroup.ListGroup.Add(pregGroup);
//
//              FilterDate := preg.StartDate;
//            end
//            else
//            begin
//              pregGroup.ListGroup.Add(preg);
//            end;
//          end;
//        end;
//        3:
//        begin
//          CollPregled.SortListByAmbListNo(CollPregled.ListPregledForFilter);
//          filterAmbNo := -1;
//
//          for i := 0 to CollPregled.ListPregledForFilter.Count - 1 do
//          begin
//            preg := CollPregled.ListPregledForFilter[i];
//            if preg.AmbListNo <> filterAmbNo then
//            begin
//              vFilter := frmFilter.vtrFilter.AddChild(nil, nil);
//              vFilter.CheckType := ctTriStateCheckBox;
//              data := frmFilter.vtrFilter.GetNodeData(vFilter);
//              data.vid := vvPregled;
//              data.index := i;
//              pregGroup := preg;
//              pregGroup.GroupField := gfAmbListNo;
//              pregGroup.ListGroup.Clear;
//              pregGroup.ListGroup.Add(pregGroup);
//              filterAmbNo := preg.AmbListNo;
//            end
//            else
//            begin
//              pregGroup.ListGroup.Add(preg);
//            end;
//          end;
//        end;
//      end;
//
//      frmFilter.vtrFilter.EndUpdate;
//    end;
//  end;
//
//
//  frmFilter.Left := DynWinPanel1.leftlistfilter;
//  frmFilter.Top := DynWinPanel1.topListFilter;
//  frmFilter.Show;
//
//
//  Panel1.Caption := FloatToStr(Elapsed.TotalMilliseconds) + ' fff=   ' +
//       IntToStr(frmFilter.vtrFilter.RootNode.ChildCount);
//end;

//procedure TfrmSuperHip.DynWinPanel1FilterButtonClickOld(sender: TDynWinPanel;
//   ctrl: TBaseControl; FltrList: TList<ComboBoxHip.TFilterValues>);
//var
//  i: Integer;
//  str: string;
//  FV: TFilterValues;
//  preg: TPregledItem;
//  tstr: TString;
//  dynControl: TBaseControl;
//begin
//  Stopwatch := TStopwatch.StartNew;
//  listFilterCount.Clear;
//  FltrList.Clear;
//  FilterStringsHave.Clear;
//  //mmoTest.Lines.BeginUpdate;
//  maxCountPregledInPat := 0;
//
//  //vtrPregledi.BeginUpdate;
//  case ctrl.tableType of
//    1://pacienti
//    begin
//      vtrPregledi.IterateSubtree(nil, IterateFilterPatField, ctrl);
//    end;
//    2://pregledi
//    begin
//      dynControl := TBaseControl(ctrl);
//      for i := 0 to CollPregled.Count - 1 do
//      begin
//        preg := CollPregled.Items[i];
//        tstr := tstring.create;
//        case dynControl.ColIndex of
//          3: tstr.str := IntToStr(preg.AmbListNo);
//          4: tstr.str := DateToStr(preg.StartDate);
//        end;
//        FilterStringsHave.Add(tstr);
//      end;
//      //vtrPregledi.IterateSubtree(nil, IterateFilterPregledField, ctrl);
//    end;
//  end;
//
//
//  //vtrPregledi.EndUpdate;
//
//  SortListString(FilterStringsHave);
//  str:= '';
//  for i := 0 to FilterStringsHave.Count - 1 do
//  begin
//    if str <> FilterStringsHave[i].str then
//    begin
//      if i <> 0 then
//        FltrList.Add(FV);
//      FV.value := FilterStringsHave[i].str;
//      //mmoTest.Lines.Add(FV.value);
//      FV.count := 1;
//      str := FilterStringsHave[i].str;
//    end
//    else
//    begin
//      inc(FV.count);
//    end;
//  end;
//  //mmoTest.Lines.EndUpdate;
//  //Elapsed := Stopwatch.Elapsed;
//  //FilterStringsHave.Count;
//  //DynWinPanel1.lstvtr1.FFilterList := FilterList;
//  //Stopwatch := TStopwatch.StartNew;
//  DynWinPanel1.lstvtr1.FillFilterList;
//
//  DynWinPanel1.ShowFilterList;
//  Elapsed := Stopwatch.Elapsed;
//  Panel1.Caption := FloatToStr(Elapsed.TotalMilliseconds);
//end;

//procedure TfrmSuperHip.DynMemo_DIE_FROM(DynMmo: TDynMemo);
//var
//  dynBoxAddres, DynBoxPat, DynBoxDiag, DynBoxConsul : TDynGroupBox;
//  dynAddres, dynPat, dynDiag, dynConsul: TDynGroup;
//  delta,  newH, deltaBox: Integer;
//begin
//  newH := DynMmo.mmoInplace.CalcH;
// // deltaBox := (newH - dynMmo.mmoInplace.Height
//  delta := Round((newH - dynMmo.mmoInplace.Height)/ DynWinPanel1.Scale);
//  if delta  = 0 then Exit;
//
//  dynAddres :=  DynWinPanel1.ListGroups[1];
//  dynBoxAddres := TDynGroupBox(dynAddres.FDynGroupBox);
//
//  dynPat :=  DynWinPanel1.ListGroups[0];
//  DynBoxPat := TDynGroupBox(dynPat.FDynGroupBox);
//
//  dynDiag :=  DynWinPanel1.ListGroups[3];
//  DynBoxDiag := TDynGroupBox(dynDiag.FDynGroupBox);
//  DynBoxDiag.CalcChild;
//
//  dynConsul :=  DynWinPanel1.ListGroups[4];
//  DynBoxConsul := TDynGroupBox(dynConsul.FDynGroupBox);
//  DynBoxConsul.CalcChild;
//
//
//
//  DynBoxConsul.MoveChild(0, delta);
//  DynBoxConsul.FRect.Offset(0, delta);
//
//
//  DynBoxDiag.MoveChild(0, delta);
//  DynBoxDiag.FRect.Offset(0, delta);
//
//
//
//  DynBoxPat.FRect.Bottom := DynMmo.FRect.Bottom + delta + 20;
//  dynBoxAddres.FRect.Bottom := DynMmo.FRect.Bottom + delta + 10;
//  DynMmo.FRect.Height := newH;
//  if DynMmo.mmoInplace.Visible then
//    DynMmo.mmoInplace.Height := Round(DynMmo.FRect.Height);
//
//
//  DynWinPanel1.Repaint;
//end;

//procedure TfrmSuperHip.DynWinPanel1GetDateTime(Sender: TDynWinPanel; ctrl: TBaseControl; var FieldDateTime: TDateTime);
//begin
//  //case DataVPregledi.vid of
////    vvPatientRoot: DynWinPanel1GetDateTime_Patients(Sender, ctrl, FieldDateTime);
////    vvPregledRoot: DynWinPanel1GetDateTime_Pregledi(Sender, ctrl, FieldDateTime);
////  end;
//end;

//procedure TfrmSuperHip.DynWinPanel1GetDateTime_Patients(Sender: TDynWinPanel; ctrl: TBaseControl;
//      var FieldDateTime: TDateTime);
//var
//  data, dataPat: PAspRec;
//  pat: TPatientItem;
//  preg: TPregledItem;
//  node: PVirtualNode;
//begin
//  Node := sender.node;
//  if Node = nil then Exit;
//  data := vtrPregledi.GetNodeData(node);
//  case data.vid of
//    vvPatient://pacienti
//    begin
//      pat := CollPatient.Items[data.index];
//      case ctrl.ColIndex of
//        1:;// FieldText := pat.FullName;
//        //2: FieldText := pat.EGN;
//      end;
//    end;
//    vvPregled: //pregledi
//    begin
//      dataPat := vtrPregledi.GetNodeData(node.Parent);
//      pat := CollPatient.Items[dataPat.index];
//      preg := pat.FPregledi[data.index];
//      case ctrl.ColIndex of
//        4: FieldDateTime := preg.StartDate + preg.StartTime;
//      end;
//    end;
//  end;
//end;
//
//procedure TfrmSuperHip.DynWinPanel1GetDateTime_Pregledi(Sender: TDynWinPanel; ctrl: TBaseControl; var FieldDateTime: TDateTime);
//var
//  data, dataPat: PAspRec;
//  pat: TPatientItem;
//  preg: TPregledItem;
//  node: PVirtualNode;
//begin
//  Node := sender.node;
//  if Node = nil then Exit;
//  data := vtrPregledi.GetNodeData(node);
//  case data.vid of
//
//    vvPregled: //pregledi
//    begin
//      preg := CollPregled.Items[data.index];
//      case ctrl.ColIndex of
//        4: FieldDateTime := preg.StartDate + preg.StartTime;
//      end;
//    end;
//  end;
//end;

//procedure TfrmSuperHip.DynWinPanel1GetText(Sender: TDynWinPanel; ctrl: TBaseControl; var FieldText: string);
//var
//  data: PAspRec;
//  pat: TPatientNewItem;
//  dynMemo: TDynMemo;
//begin
//  if ctrl is TDynEdit then
//  begin
//    data := ctrl.PDataAspect;
//    if (data = nil)  then Exit;
//
//    case data.vid of
//      vvPatient:
//      begin
//        case ctrl.ColIndex of
//          word(PatientNew_FNAME):
//          begin
//            PatientTemp.DataPos := Data.DataPos;
//            FieldText := PatientTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_FNAME));
//            FieldText := FieldText + ' ' + PatientTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_SNAME));
//            FieldText := FieldText + ' ' + PatientTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_LNAME));
//          end;
//          word(PatientNew_EGN):
//          begin
//           // pat := CollPatient.Items[Data.index];
////            FieldText := pat.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_EGN));
//            PatientTemp.DataPos := Data.DataPos;
//            FieldText := PatientTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_EGN));
//          end;
//          word(PatientNew_DIE_FROM):
//          begin
//            if data.index < 0 then
//            begin
//              PatientTemp.DataPos := Data.DataPos;
//              FieldText := PatientTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_DIE_FROM));
//            end
//            else
//            begin
//              pat := CollPatient.Items[Data.index];
//              FieldText := pat.PRecord.DIE_FROM;
//            end;
//          end;
//        end;
//
//      end;
//      vvPregled:
//      begin
//        CollPregled.GetFieldText(Sender, ctrl.ColIndex, Data.index, FieldText);
//        //PregledTemp.DataPos := Data.DataPos;
////        FieldText := 'от ' + DateToStr(PregledTemp.getDateMap(bufNew, PregledColl.posData, word(Pregled_START_DATE)));
//      end;
//      vvPatientRoot:
//      begin
//        CollPregled.GetFieldText(Sender, ctrl.ColIndex, Data.index, FieldText);
//      end;
//      vvDiag:
//      begin
//        case ctrl.ColIndex of
//          word(Diagnosis_code_CL011) :
//          begin
//            DiagTemp.DataPos := Data.DataPos;
//            FieldText := DiagTemp.getAnsiStringMap(AspectsHipFile.Buf, CollDiag.posData, ctrl.ColIndex);
//          end;
//          word(Diagnosis_additionalCode_CL011):
//          begin
//            DiagTemp.DataPos := Data.DataPos;
//            FieldText := DiagTemp.getAnsiStringMap(AspectsHipFile.Buf, CollDiag.posData, ctrl.ColIndex);
//          end;
//        end;
//
//      end;
//    end;
//  end;
//  if ctrl is TDynMemo then
//  begin
//
//    data := ctrl.PDataAspect;
//    if (data = nil)  then Exit;
//    dynMemo := TDynMemo(ctrl);
//    case data.vid of
//      vvPatient:
//      begin
//        case ctrl.ColIndex of
//          word(PatientNew_FNAME):
//          begin
//            PatientTemp.DataPos := Data.DataPos;
//            FieldText := PatientTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_FNAME));
//            FieldText := FieldText + ' ' + PatientTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_SNAME));
//            FieldText := FieldText + ' ' + PatientTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_LNAME));
//          end;
//          word(PatientNew_EGN):
//          begin
//           // pat := CollPatient.Items[Data.index];
////            FieldText := pat.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_EGN));
//            PatientTemp.DataPos := Data.DataPos;
//            FieldText := PatientTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_EGN));
//          end;
//          word(PatientNew_DIE_FROM):
//          begin
//            if Data.index < 0 then
//            begin
//              PatientTemp.DataPos := Data.DataPos;
//              FieldText := PatientTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_DIE_FROM));
//            end
//            else
//            begin
//              pat := CollPatient.Items[Data.index];
//              if Assigned(pat.PRecord) and (PatientNew_DIE_FROM in pat.PRecord.setProp)  then
//              begin
//
//                FieldText := pat.PRecord.DIE_FROM;
//              end;
//            end;
//          end;
//        end;
//
//      end;
//      vvPregled:
//      begin
//        CollPregled.GetFieldText(Sender, ctrl.ColIndex, Data.index, FieldText);
//        //PregledTemp.DataPos := Data.DataPos;
////        FieldText := 'от ' + DateToStr(PregledTemp.getDateMap(bufNew, PregledColl.posData, word(Pregled_START_DATE)));
//      end;
//      vvPatientRoot:
//      begin
//        CollPregled.GetFieldText(Sender, ctrl.ColIndex, Data.index, FieldText);
//      end;
//    end;
//  end;
//end;
//
//procedure TfrmSuperHip.DynWinPanel1SetText(Sender: TDynWinPanel; ctrl: TBaseControl; FieldText: string);
//var
//  data: PAspRec;
//  dynMemo: TDynMemo;
//  DynBox: TDynGroupBox;
//begin
//  if ctrl is TDynEdit then
//  begin
//    data := ctrl.PDataAspect;
//    if (not Sender.FilterMode) and (data = nil) then Exit;
//
//    if not Sender.FilterMode then
//    begin
//      case data.vid of
//        vvPatient:
//        begin
//          CollPatient.SetFieldText(Sender, ctrl.ColIndex, Data.index, FieldText);
//          Sender.vtr.RepaintNode(Sender.node);
//
//        end;
//        vvPregled:
//        begin
//          CollPregled.SetFieldText(Sender, ctrl.ColIndex, Data.index, FieldText);
//          Sender.vtr.RepaintNode(Sender.node);
//        end;
//      end;
//    end
//    else
//    begin
//      case ctrl.DataAspect.vid of
//        vvPatient:
//        begin
//          if Length(FieldText) > 0 then
//          begin
//            CollPatient.SearchingValue := FieldText;
//            //CollPatient.ShowSearchedGrid(grdSearch);
//          end
//          else
//          begin
//            //PatientCollFilter.ListPatientSearch.Clear;
//            //CollPatient.ShowSearchedGrid(grdSearch);
//          end;
//
//        end;
//        vvPregled:
//        begin
//          if Length(FieldText) > 0 then
//          begin
//            CollPregled.SearchingValue := FieldText;
//            //CollPregled.ShowSearchedGrid(grdSearch);
//          end
//          else
//          begin
//            //PregledNewColl.ListPregledSearch.Clear;
//            //CollPregled.ShowSearchedGrid(grdSearch);
//          end;
//        end;
//      end;
//
//
//    end;
//  end;
//
//  if ctrl is TDynMemo then
//  begin
//    data := ctrl.PDataAspect;
//    if (not Sender.FilterMode) and (data = nil) then Exit;
//
//    if not Sender.FilterMode then
//    begin
//      case data.vid of
//        vvPatient:
//        begin
//          CollPatient.SetFieldText(Sender, ctrl.ColIndex, Data.index, FieldText);
//          case ctrl.ColIndex of
//            word(PatientNew_DIE_FROM):
//            begin
//              DynMemo_DIE_FROM(TDynMemo(ctrl));
//            end;
//          end;
//
//
//          //Sender.vtr.RepaintNode(Sender.node);
//
//        end;
//        vvPregled:
//        begin
//          CollPregled.SetFieldText(Sender, ctrl.ColIndex, Data.index, FieldText);
//          Sender.vtr.RepaintNode(Sender.node);
//        end;
//      end;
//    end
//    else
//    begin
//      case ctrl.DataAspect.vid of
//        vvPatient:
//        begin
//          if Length(FieldText) > 0 then
//          begin
//            CollPatient.SearchingValue := FieldText;
//            //CollPatient.ShowSearchedGrid(grdSearch);
//          end
//          else
//          begin
//            //PatientCollFilter.ListPatientSearch.Clear;
//            //CollPatient.ShowSearchedGrid(grdSearch);
//          end;
//
//        end;
//        vvPregled:
//        begin
//          if Length(FieldText) > 0 then
//          begin
//            CollPregled.SearchingValue := FieldText;
//            //CollPregled.ShowSearchedGrid(grdSearch);
//          end
//          else
//          begin
//            //PregledNewColl.ListPregledSearch.Clear;
//            //CollPregled.ShowSearchedGrid(grdSearch);
//          end;
//        end;
//      end;
//
//
//    end;
//  end;
//  //Caption := IntToStr(PregledNewColl.CntUpdates);
//end;

//procedure TfrmSuperHip.DynWinPanel1GetText_Patients(Sender: TDynWinPanel; ctrl: TBaseControl; var FieldText: string);
//var
//  data, dataPat: PAspRec;
//  pat: TPatientItem;
//  preg: TPregledItem;
//  node: PVirtualNode;
//begin
//  Node := sender.node;
//  if Node = nil then Exit;
//  data := vtrPregledi.GetNodeData(node);
//  case data.vid of
//    vvPatient://pacienti
//    begin
//      pat := CollPatient.Items[data.index];
//      case ctrl.ColIndex of
//        1: FieldText := pat.FullName;
//        2: FieldText := pat.EGN;
//      end;
//    end;
//    vvPregled: //pregledi
//    begin
//      dataPat := vtrPregledi.GetNodeData(node.Parent);
//      pat := CollPatient.Items[dataPat.index];
//      preg := pat.FPregledi[data.index];
//      case ctrl.ColIndex of
//        3: FieldText := IntToStr(preg.AmbListNo);
//      end;
//    end;
//  end;
//end;

//procedure TfrmSuperHip.DynWinPanel1GetText_Pregledi(Sender: TDynWinPanel; ctrl: TBaseControl; var FieldText: string);
//var
//  data, dataPat: PAspRec;
//  pat: TPatientItem;
//  preg: TPregledItem;
//  node: PVirtualNode;
//begin
//  Node := sender.node;
//  if Node = nil then Exit;
//  data := vtrPregledi.GetNodeData(node);
//  case data.vid of
//    vvPregled: //pregledi
//    begin
//      preg := CollPregled.Items[data.index];
//      case ctrl.ColIndex of
//        3: FieldText := IntToStr(preg.AmbListNo);
//      end;
//    end;
//  end;
//end;

procedure TfrmSuperHip.Edit1Change(Sender: TObject);
begin
  if Edit1.Text <> '' then
  begin
    FilterCountPregled := StrToInt(Edit1.Text);
  end
  else
  begin
    FilterCountPregled := -1;
  end;
end;

procedure TfrmSuperHip.EditPregX009(pregNode: PVirtualNode);
var
  nzisThr: TNzisThread;
  data: PAspRec;
begin
  //if (edtToken.Text = '') or (Now > TokenToTime) then
//  begin
//    btnTokenClick(nil);
//  end;

  //Adb_DM.CollPrac := CollPractica;
//  Adb_DM.CollDoc := CollDoctor;

  nzisThr := TNzisThread.Create(false, Adb_DM);
  nzisThr.FreeOnTerminate := True;
  nzisThr.IsTestNZIS := true;

  nzisThr.OnSended := NzisOnSended;
  nzisThr.HndSuperHip := Self.Handle;
  nzisThr.Node := pregNode;
  nzisThr.MsgType := TNzisMsgType.X009;
  //nzisThr.StreamData := preg.FStreamNzis;
  nzisThr.token := '';
  nzisThr.CurrentCert := nil;
  nzisThr.Resume;
end;

procedure TfrmSuperHip.edtChangeCOP(Sender: TObject);
var
  edt: fmx.Edit.TEdit;
begin
  edt := fmx.Edit.TEdit(Sender);
  //CollPatient.ListForFDB[0].ArrCondition[edt.Field] := edt.Condition;
  thrSearch.start;
end;

procedure TfrmSuperHip.edtFilterChange(Sender: TObject);
var
  data: PAspRec;
  pat: TPatientNewItem;
begin
  //thrSearch.RunItem.ClassForFind := TPregledNewItem;
//  thrSearch.RunItem.RuningType := vvPregled;
//  thrSearch.RunItem.CollForRuning := CollPregled;
//  thrSearch.CollForFind := CollPatient;
//  thrSearch.RunItem.childVid := vvNone;
//  thrSearch.RunItem.parentVid := vvPatient;
//
//  CollPregled.PRecordSearch.setProp := [PregledNew_ANAMN];
//  CollPregled.PRecordSearch.ANAMN := edtFilter.Text;
  /////////////////////////////////////////////////////
  //thrSearch.RunItem.ClassForFind := TPatientNewItem;
//  thrSearch.RunItem.RuningType := vvPatient;
//  thrSearch.RunItem.CollForRuning := CollPatient;
//  thrSearch.CollForFind := CollPatient;
//  thrSearch.RunItem.childVid := vvPregled;
//  thrSearch.RunItem.parentVid := vvNone;
//
//  CollPatient.PRecordSearch.setProp := [PatientNew_EGN];
//  CollPatient.PRecordSearch.EGN := edtFilter.Text;
 ////////////////////////////////////////////////////////////////////////////////////
  //thrSearch.RunItem.ClassForFind := TPregledNewItem;
//  thrSearch.RunItem.RuningType := vvPregled;
//  thrSearch.RunItem.CollForRuning := CollPregled;
//  thrSearch.CollForFind := CollPregled;
//  thrSearch.RunItem.childVid := vvNone;
//  thrSearch.RunItem.parentVid := vvNone;
//
//  CollPregled.PRecordSearch.setProp := [PregledNew_ANAMN];//, PregledNew_ANAMN];//, PregledNew_AMB_LISTN];
//  CollPregled.PRecordSearch.ANAMN := edtFilter.Text;
  //CollPregled.PRecordSearch.AMB_LISTN := 2936;
///////////////////////////////////////////////////////////

  Stopwatch := TStopwatch.StartNew;
  thrSearch.start;

  Exit;
  //Stopwatch := TStopwatch.StartNew;
  btnFilterClick(nil);
  //if Length(edtFilter.Text) > 0 then
//  begin
//    CollPregled.SearchingValue := edtFilter.Text;
//    CollPregled.ShowSearchedGrid(grdSearch);
//  end;
  //Elapsed := Stopwatch.Elapsed;
  //mmotest.Lines.Add( 'finded ' + FloatToStr(Elapsed.TotalMilliseconds));
  //Caption := IntToStr(PregledNewColl.CntUpdates);
end;

procedure TfrmSuperHip.edtFilterEnter(Sender: TObject);
begin
  Stopwatch := TStopwatch.StartNew;
  //CollPregled.FindedRes.DataPos := 0;
//  CollPregled.FindedRes.PropIndex := word(PregledNew_ANAMN);
//  CollPregled.IndexValue(TPregledNewItem.TPropertyIndex(CollPregled.FindedRes.PropIndex));
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'enterFind ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.edtFilterTempChangeMKB(Sender: TObject);
begin
  tmpVtr.FilterText := edtFilterTemp.Text;
  vtrTemp.Repaint;

  if edtFilterTemp.Text = '' then
  begin
    FinderRecMKB.strSearch := edtFilterTemp.Text;
    FinderRecMKB.LastFindedStr := '';
    vtrPregledPat.Repaint;//zzzzzzz може само ноде
    Exit;
  end;

  FinderRecMKB.strSearch := edtFilterTemp.Text;

  if not FindNodevtrTemp(dfnone, FinderRecMKB.ACol) then // трябва да изтрие последно въведените
  begin
    edtFilterTemp.Text := FinderRecMKB.LastFindedStr;
    edtFilterTemp.SelStart := Length(edtFilterTemp.Text);
    FinderRecMKB.strSearch := edtFilterTemp.Text;
  end
  else
  begin
    FinderRecMKB.LastFindedStr := edtFilterTemp.Text;
  end;
end;

procedure TfrmSuperHip.edtGraphDayChange(Sender: TObject);
begin
  if edtGraphDay.Text = '' then Exit;

  vtrGraph.BeginUpdate;
  vtrGraph.IterateSubtree(vRootGraph, IterateFilterGraph, nil);
  vtrGraph.EndUpdate;
end;

procedure TfrmSuperHip.edtSearhTreeChange(Sender: TObject);
begin
  if edtSearhTree.Text = '' then
  begin
    FinderRec.strSearch := edtSearhTree.Text;
    FinderRec.LastFindedStr := '';
    vtrPregledPat.Repaint;//zzzzzzz може само ноде
    Exit;
  end;

  FinderRec.strSearch := edtSearhTree.Text;

  if not FindNodevtrPreg(dfnone, FinderRec.ACol) then // трябва да изтрие последно въведените
  begin
    edtSearhTree.Text := FinderRec.LastFindedStr;
    edtSearhTree.SelStart := Length(edtSearhTree.Text);
    FinderRec.strSearch := edtSearhTree.Text;
  end
  else
  begin
    FinderRec.LastFindedStr := edtSearhTree.Text;
  end;
  vtrPregledPat.Repaint;
end;

procedure TfrmSuperHip.ExportNzisToDb;
var
  linkPos, FPosLinkData: Cardinal;
  pCardinalData: PCardinal;
  node, nodePat, RunNodeInPat: PVirtualNode;
  data, dataInPat: PAspRec;
  pat: TRealPatientNewItem;
  //collPatExport: TRealPatientNewColl;
begin
  if Adb_DM.LstPatForExportDB = nil then
  begin
    Adb_DM.LstPatForExportDB := TList<TRealPatientNewItem>.Create;
  end
  else
  begin
    Adb_DM.LstPatForExportDB.Clear;
  end;
  Stopwatch := TStopwatch.StartNew;
  linkPos := 100;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  FPosLinkData := pCardinalData^;
  while linkPos < FPosLinkData do
  begin
    node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
    data := Pointer(PByte(node)+ lenNode);
    if data.vid = vvPatient then
    begin
      pat := TRealPatientNewItem(Adb_DM.CollPatient.Add);
      pat.DataPos := data.DataPos;
      pat.FNode := node;
      if Adb_DM.CollPatient.getintMap(data.DataPos, Word(PatientNew_ID)) = 0 then //now pacient
      begin
        //mmoTest.Lines.Add('нов пациент ' + collPatExport.getAnsiStringMap(data.DataPos, Word(PatientNew_EGN)));
        Adb_DM.LstPatForExportDB.Add(pat);
        FDBHelper.SavePatientFDB(pat, Fdm.ibsqlCommand);
        RunInPat(pat, true);
      end
      else
      begin
        RunInPat(pat, false);
      end;

    end;
    inc(linkPos, LenData);
  end;

  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'exportDB ' + FloatToStr(Elapsed.TotalMilliseconds));

end;

procedure TfrmSuperHip.FillAnalInExamAnal;
var
  iCl022, iExamAnal, nextCl022: integer;
  examAnal: TRealExamAnalysisItem;
  datPos: Cardinal;
  pCardinalData: PCardinal;
begin
  Adb_DM.CollExamAnal.SortByCl022;
  Adb_DM.CL022Coll.IndexValue(CL022_Key);
  Adb_DM.CL022Coll.SortByIndexAnsiString;
  Stopwatch := TStopwatch.StartNew;
  iCl022 := 0;
  iExamAnal := 0;
  while (iCl022 < Adb_DM.CL022Coll.Count) and (iExamAnal < Adb_DM.CollExamAnal.Count) do
  begin
    if Adb_DM.CollExamAnal.Items[iExamAnal].Cl022 = '08-001' then
    begin
      Adb_DM.CollExamAnal.Items[iExamAnal].Cl022 := '08-001'
    end;
    if Adb_DM.CL022Coll.Items[iCl022].IndexAnsiStr1 = '08-001' then
    begin
      Adb_DM.CL022Coll.Items[iCl022].IndexAnsiStr1 := '08-001'
    end;

    if Adb_DM.CL022Coll.Items[iCl022].IndexAnsiStr1 = Adb_DM.CollExamAnal.Items[iExamAnal].Cl022 then
    begin
      examAnal := Adb_DM.CollExamAnal.Items[iExamAnal];
      New(examAnal.PRecord);
      examAnal.PRecord.setProp := [ExamAnalysis_PosDataNomen];
      examAnal.PRecord.PosDataNomen := Adb_DM.CL022Coll.Items[iCl022].FDataPos;

      datPos := Adb_DM.AdbMain.FPosData + Adb_DM.AdbMain.GetLenData;
      examAnal.SaveExamAnalysis(datPos);
      pCardinalData := pointer(PByte(Adb_DM.AdbMain.Buf) + 12);
      pCardinalData^  := datPos - self.Adb_DM.AdbMain.FPosData;

      inc(iExamAnal);
      nextCl022 := iCl022 + 1;
      while (nextCl022 < Adb_DM.CL022Coll.Count) and (Adb_DM.CL022Coll.Items[iCl022].IndexAnsiStr1 = Adb_DM.CL022Coll.Items[nextCl022].IndexAnsiStr1) do
      begin
        inc(iCl022);
        nextCl022 := iCl022 + 1;
      end;
    end
    else if Adb_DM.CL022Coll.Items[iCl022].IndexAnsiStr1 > Adb_DM.CollExamAnal.Items[iExamAnal].Cl022 then
    begin
      inc(iExamAnal);
    end
    else if Adb_DM.CL022Coll.Items[iCl022].IndexAnsiStr1 < Adb_DM.CollExamAnal.Items[iExamAnal].Cl022 then
    begin
      inc(iCl022);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillExamAnal ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillCertInDoctors;
var
 // hipSB: TSBX_HIP;
  WinStorage : TElWinCertStorage;
  Cert: TElX509Certificate;
  CntCert, i, j : integer;
  StrTemp, docEgn, certEgn : String;
  WithEgn: Boolean;
  doc: TRealDoctorItem;
  buf: Pointer;
  posdata: Cardinal;
  data: PAspRec;
begin
  if vtrDoctor.TotalCount < 1 then
    LoadVtrDoctor;
  WinStorage := TElWinCertStorage.Create(nil);
  buf := Adb_DM.AdbMain.Buf;
  posdata := Adb_DM.AdbMain.FPosData;

  WinStorage.SystemStores.Add('MY');
  CntCert := 0;
  try
    while CntCert < WinStorage.Count do
    begin
      try
        try
          if (WinStorage.Certificates[CntCert].ValidFrom < now) and (WinStorage.Certificates[CntCert].ValidTo > now)  then
          begin
            WithEgn := false;
            for i := 0 to WinStorage.Certificates[CntCert].SubjectRDN.Count - 1 do
            begin
              Cert := WinStorage.Certificates[CntCert];
              StrTemp := StringOfBytes(cert.SubjectRDN.Values[i]);
              if StrTemp.StartsWith('PNOBG-') then
              begin
                certEgn := Copy(StrTemp, 7, 10);
                for j := 0 to Adb_DM.CollDoctor.Count - 1 do
                begin
                  doc := Adb_DM.CollDoctor.Items[j];
                  docEgn := doc.getAnsiStringMap(buf, posdata, word(Doctor_EGN));
                  if docEgn = certEgn then
                  begin
                    doc.Cert := TElX509Certificate.Create(nil);
                    Cert.Clone(doc.Cert);
                    v := vtrDoctor.AddChild(doc.node, nil);
                    data := vtrDoctor.GetNodeData(v);
                    data.DataPos := 0;
                    data.index := 0;
                    data.vid := vvCert;
                    vtrDoctor.Expanded[doc.node] := True;
                  end;
                end;
                WithEgn := True;
                //Break;
              end;
            end;
          end;
        finally
          Inc(CntCert);
        end;
        Application.ProcessMessages;
      except
        on E : Exception do  Application.ShowException(E);
      end;
    end;
  finally

  end;
  WinStorage.Free;
end;

procedure TfrmSuperHip.FillCl088Update;
var
  iCl0088, iCl088UP: Integer;
begin
  iCl0088 := 0;
  iCl088UP := 0;

  Adb_DM.CL088Coll.IndexValue(CL088_Key);
  Adb_DM.CL088Coll.SortByIndexAnsiString;
  Adb_DM.CL088Coll.FCL088New.SortByKeyRec;

  while (iCl0088 < Adb_DM.CL088Coll.Count) and (iCl088UP < Adb_DM.CL088Coll.FCL088New.Count) do
  begin
    if Adb_DM.CL088Coll.Items[iCl0088].IndexAnsiStr1 = Adb_DM.CL088Coll.FCL088New.Items[iCl088UP].PRecord.Key then
    begin
      Adb_DM.CL088Coll.Items[iCl0088].FItemUp := Adb_DM.CL088Coll.FCL088New.Items[iCl088UP];
      Adb_DM.CL088Coll.FCL088New.Items[iCl088UP].FItemUp := Adb_DM.CL088Coll.Items[iCl0088];
      inc(iCl088UP);
      inc(iCl0088);
    end
    else if Adb_DM.CL022Coll.Items[iCl0088].IndexAnsiStr1 > Adb_DM.CL088Coll.FCL088New.Items[iCl088UP].PRecord.Key then
    begin
      inc(iCl088UP);
    end
    else if Adb_DM.CL022Coll.Items[iCl0088].IndexAnsiStr1 < Adb_DM.CL088Coll.FCL088New.Items[iCl088UP].PRecord.Key then
    begin
      inc(iCl0088);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillCL088Coll.FCL088New ' + FloatToStr(Elapsed.TotalMilliseconds));
end;


procedure TfrmSuperHip.FillDiagInMkb;
var
  iDiag, iMkb: integer;
  preg: TRealPregledNewItem;
begin
  Adb_DM.CollDiag.IndexValue(Diagnosis_code_CL011);
  Adb_DM.CollDiag.SortByIndexAnsiString;
  Adb_DM.CollMkb.IndexValue(TMkbItem.TPropertyIndex.Mkb_CODE);
  Adb_DM.CollMkb.SortByIndexAnsiString;

  Stopwatch := TStopwatch.StartNew;
  iDiag := 0;
  iMkb := 0;
  while (iDiag < Adb_DM.CollDiag.Count) and (iMkb < Adb_DM.CollMkb.Count) do
  begin
    if Adb_DM.CollDiag.Items[iDiag].getAnsiStringMap(Adb_DM.CollDiag.Buf, Adb_DM.CollDiag.posData, word(Diagnosis_code_CL011)) =
       Adb_DM.CollMkb.Items[iMkb].getAnsiStringMap(Adb_DM.CollMkb.Buf, Adb_DM.CollMkb.posData, word(Mkb_CODE)) then
    begin
      Adb_DM.CollMkb.Items[iMkb].Version :=  Adb_DM.CollMkb.Items[iMkb].Version + 1;
      inc(iDiag);
    end
    else if Adb_DM.CollDiag.Items[iDiag].getAnsiStringMap(Adb_DM.CollDiag.Buf, Adb_DM.CollDiag.posData, word(Diagnosis_code_CL011)) >
       Adb_DM.CollMkb.Items[iMkb].getAnsiStringMap(Adb_DM.CollMkb.Buf, Adb_DM.CollMkb.posData, word(Mkb_CODE)) then
    begin
      begin
        inc(iMkb);

      end;
    end
    else if Adb_DM.CollDiag.Items[iDiag].getAnsiStringMap(Adb_DM.CollDiag.Buf, Adb_DM.CollDiag.posData, word(Diagnosis_code_CL011)) <
       Adb_DM.CollMkb.Items[iMkb].getAnsiStringMap(Adb_DM.CollMkb.Buf, Adb_DM.CollMkb.posData, word(Mkb_CODE)) then
    begin
      inc(iDiag);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillmkb ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillDoctorInPregled;
var
  iDoc, iPreg: integer;
  preg: TRealPregledNewItem;
begin
  Adb_DM.CollPregled.SortByDoctorID;
  Adb_DM.CollDoctor.SortByDoctorID;

  Stopwatch := TStopwatch.StartNew;
  iDoc := 0;
  iPreg := 0;
  while (iDoc < Adb_DM.CollDoctor.Count) and (iPreg < Adb_DM.CollPregled.Count) do
  begin
    if Adb_DM.CollDoctor.Items[iDoc].DoctorId = Adb_DM.CollPregled.Items[iPreg].DoctorId then
    begin
      preg := Adb_DM.CollPregled.Items[iPreg];
      if Fdm.IsGP then
      begin
        if (preg.IS_ZAMESTVASHT) or (preg.IS_NAET) then
        begin
          Adb_DM.CollPregled.Items[ipreg].FDoctor := preg.Fpatient.FDoctor;
          Adb_DM.CollPregled.Items[ipreg].FDeput := Adb_DM.CollDoctor.Items[iDoc];
        end
        else
        begin
          Adb_DM.CollPregled.Items[ipreg].FDoctor := Adb_DM.CollDoctor.Items[iDoc];
        end;
      end
      else
      begin
        if (preg.IS_ZAMESTVASHT) or (preg.IS_NAET) then
        begin
          Adb_DM.CollPregled.Items[ipreg].FDoctor := preg.FOwnerDoctor;
          Adb_DM.CollPregled.Items[ipreg].FDeput := Adb_DM.CollDoctor.Items[iDoc];
        end
        else
        begin
          Adb_DM.CollPregled.Items[ipreg].FDoctor := Adb_DM.CollDoctor.Items[iDoc];
        end;
      end;

      inc(iPreg);
    end
    else if Adb_DM.CollDoctor.Items[iDoc].DoctorId > Adb_DM.CollPregled.Items[iPreg].DoctorId then
    begin
      begin
        inc(iPreg);

      end;
    end
    else if Adb_DM.CollDoctor.Items[iDoc].DoctorId < Adb_DM.CollPregled.Items[iPreg].DoctorId then
    begin
      inc(iDoc);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillPat ' + FloatToStr(Elapsed.TotalMilliseconds));
end;



procedure TfrmSuperHip.FillExamAnalInMDN;
var
  iExamAnal, iMdn: integer;
begin
  Adb_DM.CollExamAnal.SortByMdnID;
  Adb_DM.CollMDN.SortById;
  Stopwatch := TStopwatch.StartNew;
  iExamAnal := 0;
  iMdn := 0;
  while (iExamAnal < Adb_DM.CollExamAnal.Count) and (iMdn < Adb_DM.CollMDN.Count) do
  begin
    if Adb_DM.CollExamAnal.Items[iExamAnal].MdnId = Adb_DM.CollMDN.Items[iMdn].MdnId then
    begin
      Adb_DM.CollMDN.Items[iMdn].FExamAnals.Add(Adb_DM.CollExamAnal.Items[iExamAnal]);
      inc(iExamAnal);
    end
    else if Adb_DM.CollExamAnal.Items[iExamAnal].MdnId > Adb_DM.CollMDN.Items[iMdn].MdnId then
    begin
      inc(iMdn);
    end
    else if Adb_DM.CollExamAnal.Items[iExamAnal].MdnId < Adb_DM.CollMDN.Items[iMdn].MdnId then
    begin
      inc(iExamAnal);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillExamAnal ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillImunInPregled;
var
  iImn, iPr: integer;
begin
  Adb_DM.CollPregled.SortByPregledID;
  Adb_DM.CollExamImun.SortByPregID;
  iImn := 0;
  iPr := 0;
  while iImn < Adb_DM.CollExamImun.Count do
  begin
    if Adb_DM.CollExamImun.Items[iImn].PregledID = Adb_DM.CollPregled.Items[iPr].PregledID then
    begin
      Adb_DM.CollPregled.Items[iPr].FImmuns.Add(Adb_DM.CollExamImun.Items[iImn]);
      //CollMedNapr.Items[imn].FPregled := collPregled.Items[iPr];
      inc(iImn);
    end
    else if Adb_DM.CollExamImun.Items[iImn].PregledID > Adb_DM.CollPregled.Items[iPr].PregledID then
    begin
      begin
        inc(iPr);

      end;
    end
    else if Adb_DM.CollExamImun.Items[iImn].PregledID < Adb_DM.CollPregled.Items[iPr].PregledID then
    begin
      inc(iImn);
    end;
  end;
  //Elapsed := Stopwatch.Elapsed;
end;

procedure TfrmSuperHip.FillIncDoctor;
var
  i: Integer;
  incDoc: TRealOtherDoctorItem;
begin
  for i := 0 to Adb_DM.CollOtherDoctor.Count - 1 do
  begin
    incDoc := TRealOtherDoctorItem(Adb_DM.AmsgColl.CollIncDoc.Add);
    incDoc.DataPos := Adb_DM.CollOtherDoctor.Items[i].DataPos;
  end;
end;

procedure TfrmSuperHip.FillIncMdnInPat;
var
  iMDD, iPat: integer;
begin
  Adb_DM.CollIncMdn.SortByPatID;
  Adb_DM.CollPatient.SortByPatId;
  Stopwatch := TStopwatch.StartNew;
  iMDD := 0;
  iPat := 0;
  while iMDD < Adb_DM.CollIncMdn.Count do
  begin
    if Adb_DM.CollIncMdn.Items[iMDD].PatientID = Adb_DM.CollPatient.Items[iPat].PatID then
    begin
      Adb_DM.CollPatient.Items[iPat].FMDDs.Add(Adb_DM.CollIncMdn.Items[iMDD]);
      Adb_DM.CollIncMdn.Items[iMDD].FPatient := Adb_DM.CollPatient.Items[iPat];
      inc(iMDD);
    end
    else if Adb_DM.CollIncMdn.Items[iMDD].PatientID > Adb_DM.CollPatient.Items[iPat].PatID then
    begin
      begin
        inc(iPat);

      end;
    end
    else if Adb_DM.CollIncMdn.Items[iMDD].PatientID < Adb_DM.CollPatient.Items[iPat].PatID then
    begin
      inc(iMDD);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillMDD ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillIncMNInPat;
var
  iMN, iPat: integer;
begin
  Adb_DM.CollIncMN.SortByPatID;
  Adb_DM.CollPatient.SortByPatId;
  Stopwatch := TStopwatch.StartNew;
  iMN := 0;
  iPat := 0;
  while iMN < Adb_DM.CollIncMN.Count do
  begin
    if Adb_DM.CollIncMN.Items[iMN].NRN = '2418760164D8' then
    begin
      Caption := 'ddd';
    end;
    if Adb_DM.CollIncMN.Items[iMN].PatientID = 85386 then
    begin
      Caption := 'ddd';
    end;
    if Adb_DM.CollPatient.Items[iPat].PatEGN = '5610312202' then
    begin
      Caption := 'ddd';
    end;

    if Adb_DM.CollIncMN.Items[iMN].PatientID = Adb_DM.CollPatient.Items[iPat].PatID then
    begin
      Adb_DM.CollPatient.Items[iPat].FIncMNs.Add(Adb_DM.CollIncMN.Items[iMN]);
      Adb_DM.CollIncMN.Items[iMN].FPatient := Adb_DM.CollPatient.Items[iPat];
      inc(iMN);
    end
    else if Adb_DM.CollIncMN.Items[iMN].PatientID > Adb_DM.CollPatient.Items[iPat].PatID then
    begin
      begin
        inc(iPat);

      end;
    end
    else if Adb_DM.CollIncMN.Items[iMN].PatientID < Adb_DM.CollPatient.Items[iPat].PatID then
    begin
      inc(iMN);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillIncMN ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillIncMnInPatImport;
var
  iMN, iPac, cnt: integer;
begin
  Exit;
  Adb_DM.AmsgColl.CollIncMN.SortByPatEgn;
  Adb_DM.AmsgColl.CollPat.SortByPatEGN;
  Stopwatch := TStopwatch.StartNew;
  iMN := 0;
  iPac := 0;
  cnt := 0;
  while (iMN < Adb_DM.AmsgColl.CollIncMN.Count) and (ipac < Adb_DM.AmsgColl.CollPat.Count) do
  begin
    if Adb_DM.AmsgColl.CollIncMN.Items[iMN].PatEgn = Adb_DM.AmsgColl.CollPat.Items[iPac].PatEgn then
    begin
      if Adb_DM.AmsgColl.CollIncMN.Items[iMN].FLstMsgImportNzis.Count > 0 then
      begin
        Adb_DM.AmsgColl.CollPat.Items[iPac].FIncMNs.Add(Adb_DM.AmsgColl.CollIncMN.Items[iMN]);
        Adb_DM.AmsgColl.CollIncMN.Items[iMN].FPatient := Adb_DM.AmsgColl.CollPat.Items[iPac];
        inc(cnt);
      end;
      inc(iMN);
    end
    else if Adb_DM.AmsgColl.CollIncMN.Items[iMN].PatEgn > Adb_DM.AmsgColl.CollPat.Items[iPac].PatEgn then
    begin
      begin
        inc(iPac);

      end;
    end
    else if Adb_DM.AmsgColl.CollIncMN.Items[iMN].PatEgn < Adb_DM.AmsgColl.CollPat.Items[iPac].PatEgn then
    begin
      inc(iMN);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillIncMnXXX ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillIncMNInPRegNomer;
var
  iMN, iPreg: integer;
begin
  Exit;
  Adb_DM.CollIncMN.SortByNomer;
  Adb_DM.CollPregled.SortByIncMNNomer;
  Stopwatch := TStopwatch.StartNew;
  iMN := 0;
  iPreg := 0;
  while iMN < Adb_DM.CollIncMN.Count do
  begin
    if Adb_DM.CollIncMN.Items[iMN].NRN = '22152C02F1F8' then
      Caption := 'ddd';
    if Adb_DM.CollIncMN.Items[iMN].Nomer = Adb_DM.CollPregled.Items[iPreg].IncNaprNom then
    begin
      Adb_DM.CollPregled.Items[iPreg].FIncMN := Adb_DM.CollIncMN.Items[iMN];
      //CollIncMN.Items[iMN].FPregledi := CollPregled.Items[iPreg];
      inc(iMN);
    end
    else if Adb_DM.CollIncMN.Items[iMN].Nomer > Adb_DM.CollPregled.Items[iPreg].IncNaprNom then
    begin
      begin
        inc(iPreg);

      end;
    end
    else if Adb_DM.CollIncMN.Items[iMN].Nomer < Adb_DM.CollPregled.Items[iPreg].IncNaprNom then
    begin
      inc(iMN);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillIncMN Preg nomer ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillIncMNInPRegNrn;
var
  iMN, iPreg: integer;
begin
  Adb_DM.CollIncMN.SortByNRN;
  Adb_DM.CollPregled.SortByCopyed;
  Stopwatch := TStopwatch.StartNew;
  iMN := 0;
  iPreg := 0;
  while (iMN < Adb_DM.CollIncMN.Count) and (iPreg < Adb_DM.CollPregled.Count) do
  begin
    if Adb_DM.CollPregled.Items[iPreg].COPIED_FROM_NRN = '' then
    begin
      inc(iPreg);
      Continue;
    end;
    if Adb_DM.CollIncMN.Items[iMN].NRN = '2511870643E9' then
      Caption := 'ddd';
    if Adb_DM.CollIncMN.Items[iMN].NRN = Adb_DM.CollPregled.Items[iPreg].COPIED_FROM_NRN then
    begin
      Adb_DM.CollPregled.Items[iPreg].FIncMN := Adb_DM.CollIncMN.Items[iMN];
      //CollIncMN.Items[iMN].FPregledi := CollPregled.Items[iPreg];
      inc(iPreg);
    end
    else if Adb_DM.CollIncMN.Items[iMN].NRN > Adb_DM.CollPregled.Items[iPreg].COPIED_FROM_NRN then
    begin
      begin
        inc(iPreg);

      end;
    end
    else if Adb_DM.CollIncMN.Items[iMN].NRN < Adb_DM.CollPregled.Items[iPreg].COPIED_FROM_NRN then
    begin
      inc(iMN);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillIncMN PregNRN ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillListPL_ADB(collPat: TRealPatientNewColl);
var
  linkpos: Cardinal;
  pCardinalData: ^Cardinal;
  FPosLinkData: Cardinal;
  FPosDataADB: Cardinal;
  node, patNode, DocNode: PVirtualNode;
  data, dataPat, dataDoc, dataChild: PAspRec;
  vChildPat: PVirtualNode;
  Doc: TRealDoctorItem;
  pat: TRealPatientNewItem;
  AUin: string;
  ADateOtp, ADateZap, lastDatePreg, tempdate: TDate;
  isBreak: Boolean;
  Pregledi: TList<TrealPregledNewItem>;
  preg, lastPreg: TRealPregledNewItem;
begin
  linkpos := 100;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  FPosLinkData := pCardinalData^;
  pCardinalData := pointer(PByte(Adb_DM.AdbMain.buf) + 8);
  FPosDataADB := pCardinalData^;
  node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
  data := pointer(PByte(node) + lenNode);


  while linkPos <= FPosLinkData do
  begin
    Inc(linkPos, LenData);
    node := pointer(PByte(AspectsLinkPatPregFile.buf) + linkpos);
    data := pointer(PByte(node) + lenNode);
    case data.vid of
      vvPatient:
      begin
        patNode := node;
        isBreak := False;
        Pregledi := TList<TRealPregledNewItem>.Create;
        dataPat := pointer(PByte(patNode) + lenNode);
        vChildPat := patNode.LastChild;
        dataChild := pointer(PByte(vChildPat) + lenNode);
        ADateOtp := 0;
        while vChildPat <> nil do
        begin
          case dataChild.vid of
            vvDoctor:
            begin
              //Doc := TRealDoctorItem.Create(nil);

              lastDatePreg := 0;
              //doc.DataPos := ;
              AUin := Adb_DM.CollDoctor.getAnsiStringMap(dataChild.DataPos, word(Doctor_UIN));
              if AUin <> '0500000430' then
              begin
                isBreak := True;
                break;
              end;
            end;
            vvPregled:
            begin
              preg := TRealPregledNewItem.Create(nil);
              preg.DataPos := dataChild.DataPos;
              tempdate := preg.getDateMap(Adb_DM.AdbMain.buf, Adb_DM.CollDoctor.posData, word(PregledNew_START_DATE));
              lastDatePreg := Max(tempdate, lastDatePreg);
              if lastDatePreg = tempdate then
                lastPreg := preg;
              Pregledi.Add(preg);
            end;
            //vvEvnt:
//            begin
//              evn.DataPos := dataChild.DataPos;
//              log32 := TlogicalEventsManyTimesSet(evn.getLogical32Map(AspectsHipFile.buf,
//                  CollDoctor.posData, word(EventsManyTimes_Logical)));
//              if DATE_OTPISVANE in log32 then
//              begin
//                ADateOtp := evn.getDateMap(AspectsHipFile.buf, CollDoctor.posData, word(EventsManyTimes_valTDate));
//                //Break;
//              end;
//              if DATE_ZAPISVANE in log32 then
//              begin
//                ADateZap := evn.getDateMap(AspectsHipFile.buf, CollDoctor.posData, word(EventsManyTimes_valTDate));
//                //Break;
//              end;
//            end;
          end;
          vChildPat := vChildPat.PrevSibling;
          dataChild := pointer(PByte(vChildPat) + lenNode);

        end;
        if not isBreak then
        begin
          pat := TRealPatientNewItem(collPat.Add);
          pat.DataPos := datapat.DataPos;
          pat.DATE_OTPISVANE := ADateOtp;
          pat.DATE_ZAPISVANE := ADateZap;
          pat.FDoctor := doc;
          pat.LastPregled := lastPreg;
          pat.FPregledi := Pregledi;
          if ADateOtp <> 0 then
          begin
            mmoTest.Lines.Add(collPat.getAnsiStringMap(pat.DataPos, word(PatientNew_EGN)) + ' otp1. ' + DateToStr(ADateOtp));
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.FillListPL_NZOKFromDB(uin: string; collPat: TRealPatientNewColl);
var
  linkpos: Cardinal;
  pCardinalData: ^Cardinal;
  FPosLinkData: Cardinal;
  FPosDataADB: Cardinal;
  node, patNode, DocNode: PVirtualNode;
  data, dataPat, dataDoc, dataChild: PAspRec;
  vChildPat: PVirtualNode;
  Doc: TDoctorItem;
  pat: TRealPatientNewItem;
  AUin: string;
  ADateOtp, ADateZap: TDate;
  isBreak: Boolean;
begin
  collPat.FUin := uin;
  linkpos := 100;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  FPosLinkData := pCardinalData^;
  pCardinalData := pointer(PByte(Adb_DM.AdbMain.buf) + 8);
  FPosDataADB := pCardinalData^;
  node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
  data := pointer(PByte(node) + lenNode);
  //Doc := TDoctorItem.Create(nil);
  while linkPos <= FPosLinkData do
  begin
    Inc(linkPos, LenData);
    node := pointer(PByte(AspectsLinkPatPregFile.buf) + linkpos);
    data := pointer(PByte(node) + lenNode);
    case data.vid of
      vvPatient:
      begin
        patNode := node;
        isBreak := False;
        dataPat := pointer(PByte(patNode) + lenNode);
        vChildPat := patNode.LastChild;
        dataChild := pointer(PByte(vChildPat) + lenNode);
        ADateOtp := 0;
        while vChildPat <> nil do
        begin
          case dataChild.vid of
            vvDoctor:
            begin
              AUin := Adb_DM.CollDoctor.getAnsiStringMap(dataChild.DataPos, word(Doctor_UIN));
              if AUin <> uin then
              begin
                isBreak := True;
                Break;
              end;
            end;
            //vvEvnt:
//            begin
//              evn.DataPos := dataChild.DataPos;
//              log24 := TlogicalEventsManyTimesSet(evn.getLogical24Map(AspectsHipFile.buf,
//                  CollDoctor.posData, word(EventsManyTimes_Logical)));
//              if DATE_OTPISVANE in log24 then
//              begin
//                ADateOtp := evn.getDateMap(AspectsHipFile.buf, CollDoctor.posData, word(EventsManyTimes_valTDate));
//                //Break;
//              end;
//              if DATE_ZAPISVANE in log24 then
//              begin
//                ADateZap := evn.getDateMap(AspectsHipFile.buf, CollDoctor.posData, word(EventsManyTimes_valTDate));
//                //Break;
//              end;
//            end;
          end;
          vChildPat := vChildPat.PrevSibling;
          dataChild := pointer(PByte(vChildPat) + lenNode);

        end;
        if not isBreak then
        begin
          pat := TRealPatientNewItem(collPat.Add);
          pat.DataPos := datapat.DataPos;
          pat.DATE_OTPISVANE := ADateOtp;
          pat.DATE_ZAPISVANE := ADateZap;
          if ADateOtp <> 0 then
          begin
            mmoTest.Lines.Add(collPat.getAnsiStringMap(pat.DataPos, word(PatientNew_EGN)) + ' otp. ' + DateToStr(ADateOtp));
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.FillMDN_inPregled;
var
  i, imdn, iPreg: integer;
  preg: TRealPregledNewItem;
  mdn: TRealMDNItem;
  diagMdn, diagPreg: TRealDiagnosisItem;
begin
  Adb_DM.CollPregled.SortByPregledID;
  Adb_DM.CollMDN.SortByPregledId;
  imdn := 0;
  iPreg := 0;
  while imdn < Adb_DM.CollMDN.Count do
  begin
    if Adb_DM.CollMDN.Items[imdn].PregledID = Adb_DM.CollPregled.Items[iPreg].PregledID then
    begin
      Adb_DM.CollPregled.Items[iPreg].FMdns.Add(Adb_DM.CollMDN.Items[imdn]);
      preg := Adb_DM.CollPregled.Items[iPreg];
      mdn := Adb_DM.CollMDN.Items[imdn];
      //търся коя диагноза от прегледа е избрана за мдн-то
      diagMdn := mdn.FDiagnosis[0];
      for i := 0 to preg.FDiagnosis.Count - 1 do
      begin
        diagPreg := preg.FDiagnosis[i];
        if (diagMdn.MainMkb = diagPreg.MainMkb) and (diagMdn.AddMkb = diagPreg.AddMkb) then
        begin

          //diagMdn.PregDiag := diagPreg;
          mdn.FDiagnosis.Clear;
          Break;
        end;
      end;
      inc(imdn);
    end
    else if Adb_DM.CollMDN.Items[imdn].PregledID > Adb_DM.CollPregled.Items[iPreg].PregledID then
    begin
      begin
        inc(iPreg);

      end;
    end
    else if Adb_DM.CollMDN.Items[imdn].PregledID < Adb_DM.CollPregled.Items[iPreg].PregledID then
    begin
      inc(imdn);
    end;
  end;
end;

procedure TfrmSuperHip.FillMedNapr3AInPregled;
var
  imn, iPr: integer;
begin
  Adb_DM.CollPregled.SortByPregledID;
  Adb_DM.CollMedNapr3A.SortByPregID;
  imn := 0;
  iPr := 0;
  while imn < Adb_DM.CollMedNapr3A.Count do
  begin
    if Adb_DM.CollMedNapr3A.Items[imn].PregledID = Adb_DM.CollPregled.Items[iPr].PregledID then
    begin
      Adb_DM.CollPregled.Items[iPr].FMNs3A.Add(Adb_DM.CollMedNapr3A.Items[imn]);
      Adb_DM.CollMedNapr3A.Items[imn].FPregled := Adb_DM.CollPregled.Items[iPr];
      inc(imn);
    end
    else if Adb_DM.CollMedNapr3A.Items[imn].PregledID > Adb_DM.CollPregled.Items[iPr].PregledID then
    begin
      begin
        inc(iPr);

      end;
    end
    else if Adb_DM.CollMedNapr3A.Items[imn].PregledID < Adb_DM.CollPregled.Items[iPr].PregledID then
    begin
      inc(imn);
    end;
  end;
  //Elapsed := Stopwatch.Elapsed;
end;

procedure TfrmSuperHip.FillMedNaprHospInPregled;
var
  imn, iPr: integer;
begin
  Adb_DM.CollPregled.SortByPregledID;
  Adb_DM.CollMedNaprHosp.SortByPregID;
  imn := 0;
  iPr := 0;
  while imn < Adb_DM.CollMedNaprHosp.Count do
  begin
    if Adb_DM.CollMedNaprHosp.Items[imn].PregledID = Adb_DM.CollPregled.Items[iPr].PregledID then
    begin
      Adb_DM.CollPregled.Items[iPr].FMNsHosp.Add(Adb_DM.CollMedNaprHosp.Items[imn]);
      Adb_DM.CollMedNaprHosp.Items[imn].FPregled := Adb_DM.CollPregled.Items[iPr];
      inc(imn);
    end
    else if Adb_DM.CollMedNaprHosp.Items[imn].PregledID > Adb_DM.CollPregled.Items[iPr].PregledID then
    begin
      begin
        inc(iPr);

      end;
    end
    else if Adb_DM.CollMedNaprHosp.Items[imn].PregledID < Adb_DM.CollPregled.Items[iPr].PregledID then
    begin
      inc(imn);
    end;
  end;
  //Elapsed := Stopwatch.Elapsed;
end;

procedure TfrmSuperHip.FillMedNaprInPregled;
var
  imn, iPr: integer;
begin
  Adb_DM.CollPregled.SortByPregledID;
  Adb_DM.CollMedNapr.SortByPregID;
  imn := 0;
  iPr := 0;
  while imn < Adb_DM.CollMedNapr.Count do
  begin
    if Adb_DM.CollMedNapr.Items[imn].PregledID = Adb_DM.CollPregled.Items[iPr].PregledID then
    begin
      Adb_DM.CollPregled.Items[iPr].FMNs.Add(Adb_DM.CollMedNapr.Items[imn]);
      Adb_DM.CollMedNapr.Items[imn].FPregled := Adb_DM.CollPregled.Items[iPr];
      inc(imn);
    end
    else if Adb_DM.CollMedNapr.Items[imn].PregledID > Adb_DM.CollPregled.Items[iPr].PregledID then
    begin
      begin
        inc(iPr);

      end;
    end
    else if Adb_DM.CollMedNapr.Items[imn].PregledID < Adb_DM.CollPregled.Items[iPr].PregledID then
    begin
      inc(imn);
    end;
  end;
  //Elapsed := Stopwatch.Elapsed;
end;

procedure TfrmSuperHip.FillMedNaprLkkInPregled;
var
  imn, iPr: integer;
begin
  Adb_DM.CollPregled.SortByPregledID;
  Adb_DM.CollMedNaprLkk.SortByPregID;
  imn := 0;
  iPr := 0;
  while imn < Adb_DM.CollMedNaprLkk.Count do
  begin
    if Adb_DM.CollMedNaprLkk.Items[imn].PregledID = Adb_DM.CollPregled.Items[iPr].PregledID then
    begin
      Adb_DM.CollPregled.Items[iPr].FMNsLKK.Add(Adb_DM.CollMedNaprLkk.Items[imn]);
      Adb_DM.CollMedNaprLkk.Items[imn].FPregled := Adb_DM.CollPregled.Items[iPr];
      inc(imn);
    end
    else if Adb_DM.CollMedNaprLkk.Items[imn].PregledID > Adb_DM.CollPregled.Items[iPr].PregledID then
    begin
      begin
        inc(iPr);

      end;
    end
    else if Adb_DM.CollMedNaprLkk.Items[imn].PregledID < Adb_DM.CollPregled.Items[iPr].PregledID then
    begin
      inc(imn);
    end;
  end;
  //Elapsed := Stopwatch.Elapsed;
end;

procedure TfrmSuperHip.FillMsgInPatient;
var
  iPat, iMsg: integer;
  msg: TNzisReqRespItem;
  vPat: PVirtualNode;
  data: PAspRec;
begin
  vtrTemp.BeginUpdate;
  Adb_DM.AmsgColl.SortByPatEgn;
  Adb_DM.AmsgColl.CollPat.IndexValue(TPatientNewItem.TPropertyIndex.PatientNew_EGN);
  Adb_DM.AmsgColl.CollPat.SortByIndexAnsiString;
  Stopwatch := TStopwatch.StartNew;
  iPat := 0;
  iMsg := 0;
  while (iPat < Adb_DM.AmsgColl.CollPat.Count) and (iMsg < Adb_DM.AmsgColl.Count) do
  begin
    if Adb_DM.AmsgColl.Items[iMsg].PRecord.patEgn = '5103275350' then
      Caption := 'ddd';

    if Adb_DM.AmsgColl.CollPat.Items[iPat].IndexAnsiStr1 = Adb_DM.AmsgColl.Items[iMsg].PRecord.patEgn then
    begin

      msg := Adb_DM.AmsgColl.Items[iMsg];
      msg.Pat := Adb_DM.AmsgColl.CollPat.Items[iPat];
      Adb_DM.AmsgColl.CollPat.Items[iPat].FLstMsgImportNzis.Add(msg);
      Adb_DM.AmsgColl.CollPat.Items[iPat].PatEGN := msg.PRecord.patEgn;
      inc(iMsg);
    end
    else if Adb_DM.AmsgColl.CollPat.Items[iPat].IndexAnsiStr1 > Adb_DM.AmsgColl.Items[iMsg].PRecord.patEgn then
    begin
      begin
        inc(iMsg);

      end;
    end
    else if Adb_DM.AmsgColl.CollPat.Items[iPat].IndexAnsiStr1 < Adb_DM.AmsgColl.Items[iMsg].PRecord.patEgn then
    begin
      inc(iPat);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  vtrTemp.EndUpdate;
  mmotest.Lines.Add( 'fillMsgInPat ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillMsgInPregled;
var
  iPreg, iMsg: integer;
  msg: TNzisReqRespItem;
  vPreg, vPat: PVirtualNode;
  data: PAspRec;
begin
  vtrTemp.BeginUpdate;
  Adb_DM.AmsgColl.SortByNrn;
  Adb_DM.AmsgColl.CollPreg.IndexValue(TPregledNewItem.TPropertyIndex.PregledNew_NRN_LRN);
  Adb_DM.AmsgColl.CollPreg.SortByIndexAnsiString;
  Stopwatch := TStopwatch.StartNew;
  iPreg := 0;
  iMsg := 0;
  while (iPreg < Adb_DM.AmsgColl.CollPreg.Count) and (iMsg < Adb_DM.AmsgColl.Count) do
  begin
    if Adb_DM.AmsgColl.CollPreg.Items[iPreg].IndexAnsiStr1 = Adb_DM.AmsgColl.Items[iMsg].PRecord.NRN then
    begin
      if Adb_DM.AmsgColl.CollPreg.Items[iPreg].IndexAnsiStr1 <> '' then
      begin
        msg := Adb_DM.AmsgColl.Items[iMsg];

        msg.Preg := Adb_DM.AmsgColl.CollPreg.Items[iPreg];
        if msg.Pat = nil then
        begin
          vPat := msg.Preg.Fnode.Parent;
          data := pointer(PByte(vPat) + lenNode);
          msg.Pat := TRealPatientNewItem(Adb_DM.AmsgColl.CollPat.Add);
          msg.Pat.PatEGN := msg.PRecord.patEgn;
          msg.Pat.DataPos := Data.DataPos;
          //msg.Pat.FLstMsgImportNzis.Add(msg);
        end
        else
        begin
           Caption := 'ddd';
        end;

        //msgColl.CollPreg.Items[iPreg].FLstMsgImportNzis.Add(msg);
        inc(iMsg);
      end
      else // не трябва да има тука нещо, ама...
      begin
        //inc(iMsg);
        inc(iPreg);
      end;
    end
    else if Adb_DM.AmsgColl.CollPreg.Items[iPreg].IndexAnsiStr1 > Adb_DM.AmsgColl.Items[iMsg].PRecord.NRN then
    begin
      begin
        inc(iMsg);

      end;
    end
    else if Adb_DM.AmsgColl.CollPreg.Items[iPreg].IndexAnsiStr1 < Adb_DM.AmsgColl.Items[iMsg].PRecord.NRN then
    begin
      inc(iPreg);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  vtrTemp.EndUpdate;
  mmotest.Lines.Add( 'fillMsgInPreg ' + FloatToStr(Elapsed.TotalMilliseconds));
end;




procedure TfrmSuperHip.FillMsgRIncMNInIncMN;
var
  iIncMN, iMsg: integer;
  msg: TNzisReqRespItem;
  vPat: PVirtualNode;
  data: PAspRec;
begin
  //msgColl.SortListByNRN(LstRIncMN);
  Adb_DM.AmsgColl.CollIncMN.SortLstByNRN(LstRIncMN);
  Adb_DM.AmsgColl.CollIncMN.SortByNrn;
  Stopwatch := TStopwatch.StartNew;
  iIncMN := 0;
  iMsg := 0;
  while (iIncMN < Adb_DM.AmsgColl.CollIncMN.Count) and (iMsg < LstRIncMN.Count) do
  begin
    if Adb_DM.AmsgColl.CollIncMN.Items[iIncMN].NRN = '25244A02FFD2' then
      Caption := 'ddd';
    if Adb_DM.AmsgColl.CollIncMN.Items[iIncMN].NRN = LstRIncMN[iMsg].NRN then
    begin
      msg := TNzisReqRespItem (LstRIncMN[iMsg].msg);
      msg.IncMN := Adb_DM.AmsgColl.CollIncMN.Items[iIncMN];
      Adb_DM.AmsgColl.CollIncMN.Items[iIncMN].FLstMsgImportNzis.Add(msg);
      inc(iMsg);
    end
    else if Adb_DM.AmsgColl.CollIncMN.Items[iIncMN].NRN > LstRIncMN[iMsg].NRN then
    begin
      begin
        inc(iMsg);

      end;
    end
    else if Adb_DM.AmsgColl.CollIncMN.Items[iIncMN].NRN < LstRIncMN[iMsg].NRN then
    begin
      inc(iIncMN);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillMsgIn IncXXXX ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillMsgRMdnInMdn;
var
  iMdn, iMsg: integer;
  msg: TNzisReqRespItem;
  vPat: PVirtualNode;
  data: PAspRec;
begin
  Adb_DM.AmsgColl.SortListByNRN(LstRMDN);
  Adb_DM.AmsgColl.CollMdn.SortByNrn;
  Stopwatch := TStopwatch.StartNew;
  iMdn := 0;
  iMsg := 0;
  while (iMdn < Adb_DM.AmsgColl.CollMdn.Count) and (iMsg < LstRMDN.Count) do
  begin
    if Adb_DM.AmsgColl.CollMdn.Items[iMdn].NRN = LstRMDN[iMsg].PRecord.NRN then
    begin

      msg := LstRMDN[iMsg];
      msg.Mdn := Adb_DM.AmsgColl.CollMdn.Items[iMdn];
      if msg.PRecord.msgNom = 7 then
        Caption := 'ddd';
      Adb_DM.AmsgColl.CollMdn.Items[iMdn].FLstMsgImportNzis.Add(msg);
      inc(iMsg);
    end
    else if Adb_DM.AmsgColl.CollMdn.Items[iMdn].NRN > LstRMDN[iMsg].PRecord.NRN then
    begin
      begin
        inc(iMsg);

      end;
    end
    else if Adb_DM.AmsgColl.CollMdn.Items[iMdn].NRN < LstRMDN[iMsg].PRecord.NRN then
    begin
      inc(iMdn);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  vtrTemp.EndUpdate;
  mmotest.Lines.Add( 'fillMsgInPatXXXX ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillMsgXXXInPregled;
var
  iPreg, iMsg: integer;
  msg: TNzisReqRespItem;
  vPat: PVirtualNode;
  data: PAspRec;
begin
  Adb_DM.AmsgColl.SortListByNRN(LstXXXX);
  Adb_DM.AmsgColl.CollPreg.IndexValue(TPregledNewItem.TPropertyIndex.PregledNew_NRN_LRN);
  Adb_DM.AmsgColl.CollPreg.SortByIndexAnsiString;
  Stopwatch := TStopwatch.StartNew;
  iPreg := 0;
  iMsg := 0;
  while (iPreg < Adb_DM.AmsgColl.CollPreg.Count) and (iMsg < LstXXXX.Count) do
  begin
    if Adb_DM.AmsgColl.CollPreg.Items[iPreg].IndexAnsiStr1 = LstXXXX[iMsg].PRecord.NRN then
    begin

      msg := LstXXXX[iMsg];
      msg.preg := Adb_DM.AmsgColl.CollPreg.Items[iPreg];
      //if msg.PRecord.msgNom = 3 then
//      begin
//        msgColl.CollPreg.Items[iPreg].COPIED_FROM_NRN := msg.PRecord.BaseOn;
//      end;
      Adb_DM.AmsgColl.CollPreg.Items[iPreg].FLstMsgImportNzis.Add(msg);
      inc(iMsg);
    end
    else if Adb_DM.AmsgColl.CollPreg.Items[iPreg].IndexAnsiStr1 > LstXXXX[iMsg].PRecord.NRN then
    begin
      begin
        inc(iMsg);

      end;
    end
    else if Adb_DM.AmsgColl.CollPreg.Items[iPreg].IndexAnsiStr1 < LstXXXX[iMsg].PRecord.NRN then
    begin
      inc(iPreg);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  vtrTemp.EndUpdate;
  mmotest.Lines.Add( 'fillMsgInPatXXXX ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillOldPlanesInCurrentPlan;
begin

end;

procedure TfrmSuperHip.FillOtherDocInIncMN;
var
  iDoc, iMN: integer;
  IncMN: TRealINC_NAPRItem;
begin
  Adb_DM.CollIncMN.SortByIncDoc;
  Adb_DM.CollOtherDoctor.SortByDoctorID;
  Stopwatch := TStopwatch.StartNew;
  iDoc := 0;
  iMN := 0;
  while (iDoc < Adb_DM.CollOtherDoctor.Count) and (iMN < Adb_DM.CollIncMN.Count) do
  begin
    if Adb_DM.CollOtherDoctor.Items[iDoc].DoctorId = Adb_DM.CollIncMN.Items[iMN].IncDoctorId then
    begin
      Adb_DM.CollIncMN.Items[iMN].FIncDoctor := Adb_DM.CollOtherDoctor.Items[iDoc];
      inc(iMN);
    end
    else if Adb_DM.CollOtherDoctor.Items[iDoc].DoctorId > Adb_DM.CollIncMN.Items[iMN].IncDoctorId then
    begin
      begin
        inc(iMN);
      end;
    end
    else if Adb_DM.CollOtherDoctor.Items[iDoc].DoctorId < Adb_DM.CollIncMN.Items[iMN].IncDoctorId then
    begin
      inc(iDoc);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillincDocMN ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillOwnerDoctorInPrgled;
var
  iDoc, iPreg: integer;
  preg: TRealPregledNewItem;
begin
  Adb_DM.CollPregled.SortByOwnerDoctorID;
  Adb_DM.CollDoctor.SortByDoctorID;
  Stopwatch := TStopwatch.StartNew;
  iDoc := 0;
  iPreg := 0;
  while (iDoc < Adb_DM.CollDoctor.Count) and (iPreg < Adb_DM.CollPregled.Count) do
  begin
    if Adb_DM.CollDoctor.Items[iDoc].DoctorId = Adb_DM.CollPregled.Items[iPreg].OWNER_DOCTOR_ID then
    begin
      preg := Adb_DM.CollPregled.Items[iPreg];
      Adb_DM.CollPregled.Items[ipreg].FOwnerDoctor := Adb_DM.CollDoctor.Items[iDoc];

      inc(iPreg);
    end
    else if Adb_DM.CollDoctor.Items[iDoc].DoctorId > Adb_DM.CollPregled.Items[iPreg].OWNER_DOCTOR_ID then
    begin
      begin
        inc(iPreg);

      end;
    end
    else if Adb_DM.CollDoctor.Items[iDoc].DoctorId < Adb_DM.CollPregled.Items[iPreg].OWNER_DOCTOR_ID then
    begin
      inc(iDoc);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillPat ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

//procedure TfrmSuperHip.FillMkbInPregled;
//var
//  iMkbNom, iMkbList: integer;
//begin
//  //Stopwatch := TStopwatch.StartNew;
//  //CollMkb.SortByMKB;
//  //CollMkb.SortListByMkb(ListMainDiagPreg);
//  //CollMkb.SortListByMkb(ListAddDiagPreg);
//  Exit;
//  ////Stopwatch := TStopwatch.StartNew;
////  iMkbNom := 0;
////  iMkbList := 0;
////
////  while iMkbNom < collMkb.Count do
////  begin
////    if collMkb.Items[iMkbNom].MKB = ListMainDiagPreg.Items[iMkbList].mkb then
////    begin
////      ListMainDiagPreg.Items[iMkbList].IdMkb:= collMkb.Items[iMkbNom].;
////      collPregled.Items[iMkbNom].FPatient := CollPatient.Items[iMkbList];
////      inc(iMkbNom);
////    end
////    else if collPregled.Items[iMkbNom].PatientID > CollPatient.Items[iMkbList].IdPatient then
////    begin
////      begin
////        inc(iMkbList);
////
////      end;
////    end
////    else if collPregled.Items[iMkbNom].PatientID < CollPatient.Items[iMkbList].IdPatient then
////    begin
////      inc(iMkbNom);
////    end;
////  end;
////  Elapsed := Stopwatch.Elapsed;
////  //Memo1.Lines.Add(Format('Брой амб. листи pri doctorite: %d за %f ms',
//////    [AmbListColl.Count, Elapsed.TotalMilliseconds]));
//end;



procedure TfrmSuperHip.FillPatInDoctor;
var
  iPat, iDoc: integer;
begin
  Adb_DM.CollPatient.SortByDoctorID;
  Adb_DM.CollDoctor.SortByDoctorID;
  Stopwatch := TStopwatch.StartNew;
  iPat := 0;
  iDoc := 0;
  // понеже няма как да има ambs без пациент, очаква се първо да свършат ambs-тата или едновременно
  // затова въртим всичко до изчерпване на ambs-тата
  while iPat < Adb_DM.CollPatient.Count do
  begin
    if Adb_DM.CollPatient.Items[iPat].DoctorId = Adb_DM.CollDoctor.Items[iDoc].DoctorId then
    begin
      Adb_DM.CollPatient.Items[iPat].FDoctor := Adb_DM.CollDoctor.Items[iDoc];
      //pregledColl.Items[iamb].FPatient := PatientColl.Items[iPac];
      inc(iPat);
    end
    else if Adb_DM.CollPatient.Items[iPat].DoctorId > Adb_DM.CollDoctor.Items[iDoc].DoctorId then
    begin
      begin
        inc(iDoc);

      end;
    end
    else if Adb_DM.CollPatient.Items[iPat].DoctorId < Adb_DM.CollDoctor.Items[iDoc].DoctorId then
    begin
      inc(iPat);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillPat ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillPatListPisInPatDB(uin: string; Acolpat: TRealPatientNewColl);
var
  iPacNzok, iPacHip, i, j, k: integer;
  vEvn: PVirtualNode;
  data, dataPreg, dataEvn: PAspRec;
  pat, cloning: TRealPatientNewItem;
  preg: TRealPregledNewItem;
  PregDate, maxDate: TDate;
  node: PVirtualNode;
  sql: string;
  btnImpotPL: TRoleButton;
  egn: string;
begin
  //Exit;
  //for i := pnlRoleView.ControlCount - 1 downto 0 do
//  begin
//    if pnlRoleView.Controls[i] is TRoleButton then
//    begin
//      if TRoleButton(pnlRoleView.Controls[i]).Description = 'Импорт ПЛ НЗОК' then
//      begin
//        btnImpotPL := TRoleButton(pnlRoleView.Controls[i]);
//        btnImpotPL.MaxValue := Acolpat.Count;
//        Break;
//      end;
//    end;
//  end;

  vtrTemp.NodeDataSize := sizeof(TAspRec);
  vtrTemp.BeginUpdate;
  vtrTemp.Clear;
  vtrTemp.OnGetText := vtrSincPLGetText;
  mmotest.Lines.BeginUpdate;

  vRemontPL := vtrTemp.AddChild(nil, nil);
  data := vtrTemp.GetNodeData(vRemontPL);
  data.vid := vvNone;
  data.index := - 1;

  vNZOK_HIP := vtrTemp.AddChild(vRemontPL, nil);
  data := vtrTemp.GetNodeData(vNZOK_HIP);
  data.vid := vvPatientNewRoot;
  data.index := - 1;

  vNZOK := vtrTemp.AddChild(vRemontPL, nil);
  data := vtrTemp.GetNodeData(vNZOK);
  data.vid := vvPatientNewRoot;
  data.index := - 2;

  vHIP := vtrTemp.AddChild(vRemontPL, nil);
  data := vtrTemp.GetNodeData(vHIP);
  data.vid := vvPatientNewRoot;
  data.index := - 3;

  vHipNovi := vtrTemp.AddChild(vHIP, nil);
  data := vtrTemp.GetNodeData(vHipNovi);
  data.vid := vvPatientNewRoot;
  data.index := - 4;

  vHipOtpisani := vtrTemp.AddChild(vHIP, nil);
  data := vtrTemp.GetNodeData(vHipOtpisani);
  data.vid := vvPatientNewRoot;
  data.index := - 5;

  vHipZapisani := vtrTemp.AddChild(vHIP, nil);
  data := vtrTemp.GetNodeData(vHipZapisani);
  data.vid := vvPatientNewRoot;
  data.index := - 6;

  //CollPatPis.IndexValue(TPatientNZOKItem.TPropertyIndex.PatientNZOK_EGN);
  //CollPatPis.SortByIndexValue(TPatientNZOKItem.TPropertyIndex.PatientNZOK_EGN);
  //CollPatPis.ShowGrid(grdNom);
  Adb_DM.CollPatPis.SortByPatEGN;
  Acolpat.Buf := Adb_DM.CollPatient.Buf;
  Acolpat.posData := Adb_DM.CollPatient.posData;
  Acolpat.IndexValue(TPatientNewItem.TPropertyIndex.PatientNew_EGN);
  Acolpat.SortByIndexValue(TPatientNewItem.TPropertyIndex.PatientNew_EGN);

  Stopwatch := TStopwatch.StartNew;
  iPacNzok := 0;
  iPacHip := 0;
  pat := nil;
  while (iPacNzok < Adb_DM.CollPatPis.Count) and (iPacHip < Acolpat.Count) do
  begin
    if Acolpat.Items[iPacHip].FDoctor.getAnsiStringMap(Adb_DM.AdbMain.buf, Adb_DM.CollDoctor.posData, word(Doctor_UIN)) <> uin then
    begin
      inc(iPacHip);
      Continue;
    end;

    //btnImpotPL.Position := iPacHip;

    if Adb_DM.CollPatPis.Items[iPacNzok].PatEGN = Acolpat.Items[iPacHip].IndexAnsiStr1 then
    begin
      pat := Acolpat.Items[iPacHip];
      pat.FPatNzok := (Adb_DM.CollPatPis.Items[iPacNzok]);

      v := vtrTemp.AddChild(vNZOK_HIP, nil);
      data := vtrTemp.GetNodeData(v);
      data.vid := vvPatient;
      data.DataPos := pat.DataPos;
      data.index := iPacHip;
      pat.IsAdded := True;
      for i := 0 to pat.FClonings.Count - 1 do
      begin
        cloning := pat.FClonings[i];
        vCloning := vtrTemp.AddChild(v, nil);
        data := vtrTemp.GetNodeData(vCloning);
        data.vid := vvCloning;
        data.DataPos := pat.DataPos;
        data.index := i;
        for j := 0 to cloning.FPregledi.Count - 1 do
        begin
          preg := cloning.FPregledi[j];
          vPreg := vtrTemp.AddChild(vCloning, nil);
          data := vtrTemp.GetNodeData(vPreg);
          data.vid := vvPregled;
          data.DataPos := preg.DataPos;
          data.index := j;
        end;
      end;
      for i := 0 to pat.FPregledi.Count - 1 do
      begin
        preg := pat.FPregledi[i];
        vPreg := vtrTemp.AddChild(v, nil);
        data := vtrTemp.GetNodeData(vPreg);
        data.vid := vvPregled;
        data.DataPos := preg.DataPos;
        data.index := i;
      end;

      inc(iPacNzok);
    end
    else if Adb_DM.CollPatPis.Items[iPacNzok].PatEGN > Acolpat.Items[iPacHip].IndexAnsiStr1 then
    begin
      pat := Acolpat.Items[iPacHip];
      if not pat.IsAdded then
      begin

        if pat.DATE_OTPISVANE = 0 then
        begin
          v := vtrTemp.AddChild(vHipZapisani, nil);
        end
        else
        begin
          v := vtrTemp.AddChild(vHipOtpisani, nil);
        end;
        data := vtrTemp.GetNodeData(v);
        data.vid := vvPatient;
        data.index := iPacHip;
        data.DataPos := Acolpat.Items[iPacHip].DataPos;

        for i := 0 to pat.FClonings.Count - 1 do
        begin
          cloning := pat.FClonings[i];
          vCloning := vtrTemp.AddChild(v, nil);
          data := vtrTemp.GetNodeData(vCloning);
          data.vid := vvCloning;
          data.DataPos := pat.DataPos;
          data.index := i;
          for j := 0 to cloning.FPregledi.Count - 1 do
          begin
            preg := cloning.FPregledi[j];
            vPreg := vtrTemp.AddChild(vCloning, nil);
            data := vtrTemp.GetNodeData(vPreg);
            data.vid := vvPregled;
            data.DataPos := preg.DataPos;
            data.index := j;
          end;
        end;
        for i := 0 to pat.FPregledi.Count - 1 do
        begin
          preg := pat.FPregledi[i];
          vPreg := vtrTemp.AddChild(v, nil);
          data := vtrTemp.GetNodeData(vPreg);
          data.vid := vvPregled;
          data.DataPos := preg.DataPos;
          data.index := i;
        end;

      end;

      inc(iPacHip);
    end
    else if Adb_DM.CollPatPis.Items[iPacNzok].PatEGN < Acolpat.Items[iPacHip].IndexAnsiStr1 then
    begin

      if Assigned(pat) and (not pat.IsAdded) then
      begin
        v := vtrTemp.AddChild(vNZOK, nil);
        data := vtrTemp.GetNodeData(v);
        data.vid := vvPatient;
        data.index := iPacNzok;
        data.DataPos := Adb_DM.CollPatPis.Items[iPacNzok].DataPos;
      end;


      inc(iPacNzok);

    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillPLLLLL ' + FloatToStr(Elapsed.TotalMilliseconds));
  vtrTemp.EndUpdate;
  pgcTree.ActivePage := tsTempVTR;
  mmotest.Lines.EndUpdate;
end;

procedure TfrmSuperHip.FillPregInPat;
var
  iamb, iPac: integer;
begin
  Adb_DM.AmsgColl.CollPreg.SortByPatEGN;
  Adb_DM.AmsgColl.CollPat.SortByPatEGN;
  Stopwatch := TStopwatch.StartNew;
  iamb := 0;
  iPac := 0;
  while (iamb < Adb_DM.AmsgColl.CollPreg.Count) and (ipac < Adb_DM.AmsgColl.CollPat.Count) do
  begin
    if Adb_DM.AmsgColl.CollPreg.Items[iamb].PatEgn = Adb_DM.AmsgColl.CollPat.Items[iPac].PatEgn then
    begin
      if Adb_DM.AmsgColl.CollPreg.Items[iamb].FLstMsgImportNzis.Count > 0 then
      begin
        Adb_DM.AmsgColl.CollPat.Items[iPac].FPregledi.Add(Adb_DM.AmsgColl.CollPreg.Items[iamb]);
        Adb_DM.AmsgColl.CollPreg.Items[iamb].FPatient := Adb_DM.AmsgColl.CollPat.Items[iPac];
      end;
      inc(iamb);
    end
    else if Adb_DM.AmsgColl.CollPreg.Items[iamb].PatEgn > Adb_DM.AmsgColl.CollPat.Items[iPac].PatEgn then
    begin
      begin
        inc(iPac);

      end;
    end
    else if Adb_DM.AmsgColl.CollPreg.Items[iamb].PatEgn < Adb_DM.AmsgColl.CollPat.Items[iPac].PatEgn then
    begin
      inc(iamb);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillPregXXX ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillPregledInIncMN;
var
  iPreg, iMsg: integer;
  msg: TNzisReqRespItem;
  vPat: PVirtualNode;
  data: PAspRec;
  DummyList: TList<RealObj.RealHipp.TRealINC_NAPRItem>;
  Dummy: RealObj.RealHipp.TRealINC_NAPRItem;
begin
  Adb_DM.AmsgColl.CollIncMN.SortLstByNRN(LstRIncMN);
  Adb_DM.AmsgColl.CollPreg.SortByCopyed;
  Stopwatch := TStopwatch.StartNew;
  iPreg := 0;
  iMsg := 0;

 // DummyList := nil;
//  if False then
//    Dummy := DummyList.Items[0]; // Принуждава Delphi да задържи GetItem
  while (iPreg < Adb_DM.AmsgColl.CollPreg.Count) and (iMsg < LstRIncMN.Count) do
  begin
    if LstRIncMN.Items[iMsg].nrn = '2511870643E9' then
      Caption := 'ddd';
    if Adb_DM.AmsgColl.CollPreg.Items[iPreg].COPIED_FROM_NRN = '' then
    begin
      inc(iPreg);
      Continue;
    end;
    Caption := LstRIncMN.items[iMsg].nrn;
    if Adb_DM.AmsgColl.CollPreg.Items[iPreg].COPIED_FROM_NRN = LstRIncMN.Items[iMsg].nrn then
    begin
      LstRIncMN[iMsg].FPregledi.Add(Adb_DM.AmsgColl.CollPreg.Items[iPreg]);
      Adb_DM.AmsgColl.CollPreg.Items[iPreg].Fpatient.FIncMNs.Add(LstRIncMN.Items[iMsg]);
      Adb_DM.AmsgColl.CollPreg.Items[iPreg].FIncMN := LstRIncMN[iMsg];
      inc(iPreg);
    end
    else if Adb_DM.AmsgColl.CollPreg.Items[iPreg].COPIED_FROM_NRN > LstRIncMN[iMsg].nrn then
    begin
      begin
        inc(iMsg);

      end;
    end
    else if Adb_DM.AmsgColl.CollPreg.Items[iPreg].COPIED_FROM_NRN < LstRIncMN[iMsg].nrn then
    begin
      inc(iPreg);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillpregInIncXXXX ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillPregledInPat;
var
  iamb, iPat: integer;
begin
  Adb_DM.CollPregled.SortByPatID_StartDate;
  Adb_DM.CollPatient.SortByPatId;
  Stopwatch := TStopwatch.StartNew;
  iamb := 0;
  iPat := 0;
  // понеже няма как да има ambs без пациент, очаква се първо да свършат ambs-тата или едновременно
  // затова въртим всичко до изчерпване на ambs-тата
  while iamb < Adb_DM.CollPregled.Count do
  begin
    if Adb_DM.CollPregled.Items[iamb].PatID = Adb_DM.CollPatient.Items[iPat].PatID then
    begin
      Adb_DM.CollPatient.Items[iPat].FPregledi.Add(Adb_DM.CollPregled.Items[iamb]);
      Adb_DM.CollPregled.Items[iamb].FPatient := Adb_DM.CollPatient.Items[iPat];
      inc(iamb);
    end
    else if Adb_DM.CollPregled.Items[iamb].PatID > Adb_DM.CollPatient.Items[iPat].PatID then
    begin
      begin
        inc(iPat);

      end;
    end
    else if Adb_DM.CollPregled.Items[iamb].PatID < Adb_DM.CollPatient.Items[iPat].PatID then
    begin
      inc(iamb);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillPreg ' + FloatToStr(Elapsed.TotalMilliseconds));
end;




procedure TfrmSuperHip.FillPrfCard_inPregled;
var
  i, iCard, iPreg: integer;
  preg: TRealPregledNewItem;
  mdn: TRealMDNItem;
  diagMdn, diagPreg: TRealDiagnosisItem;
begin
  Adb_DM.CollPregled.SortByPregledID;
  Adb_DM.CollCardProf.SortByPregID;
  iCard := 0;
  iPreg := 0;
  // понеже няма как да има карта без preg, очаква се първо да свършат картите или едновременно
  // затова въртим всичко до изчерпване на картите
  while iCard < Adb_DM.CollCardProf.Count do
  begin
    if Adb_DM.CollCardProf.Items[iCard].PregledID = Adb_DM.CollPregled.Items[iPreg].PregledID then
    begin
      Adb_DM.CollPregled.Items[iPreg].FProfCards.Add(Adb_DM.CollCardProf.Items[iCard]);
      inc(iCard);
    end
    else if Adb_DM.CollCardProf.Items[iCard].PregledID > Adb_DM.CollPregled.Items[iPreg].PregledID then
    begin
      begin
        inc(iPreg);
      end;
    end
    else if Adb_DM.CollCardProf.Items[iCard].PregledID < Adb_DM.CollPregled.Items[iPreg].PregledID then
    begin
      inc(iCard);
    end;
  end;
end;

function TfrmSuperHip.FillRealPregledForNzis(linkNode: PVirtualNode): TRealPregledNewItem;
var
  vRunChildPat, vpat, vdoc: PVirtualNode;
  dataPreg ,dataPat, dataDoc, dataRunChildPat: PAspRec;
  pat: TRealPatientNewItem;
  doctor: TRealDoctorItem;
  linkPos: Cardinal;
begin
// прегледа
  Result := TRealPregledNewItem.Create(nil);
  dataPreg := pointer(PByte(linkNode) + lenNode);
  Result.DataPos := dataPreg.DataPos;
 // едно ниво по-нагоре е пациента
  vpat := linkNode.Parent;
  dataPat := pointer(PByte(vpat) + lenNode);
  pat := TRealPatientNewItem.Create(nil);
  pat.DataPos := dataPat.DataPos;
  Result.Fpatient := pat;
// започвам да обикалям всички дечица на пациента
  vRunChildPat := vpat.FirstChild;
  while vRunChildPat <> nil do
  begin
    dataRunChildPat := pointer(PByte(vRunChildPat) + lenNode);
    case dataRunChildPat.vid of
      vvDoctor:
      begin
        vdoc := vRunChildPat;
        dataDoc := dataRunChildPat;
        doctor := TRealDoctorItem.Create(nil);
        DOCTOR.DataPos := dataDoc.DataPos;
      end;
    end;
    vRunChildPat := vRunChildPat.NextSibling;
  end;
end;

procedure TfrmSuperHip.FillReferalMdnInPreg;
var
  iMdn, iAmb: integer;
begin
  Adb_DM.AmsgColl.CollPreg.SortByNrn;
  Adb_DM.AmsgColl.CollMdn.SortByPregledNRN;
  Stopwatch := TStopwatch.StartNew;
  iMdn := 0;
  iAmb := 0;
  while (iMdn < Adb_DM.AmsgColl.CollMdn.Count) and (iAmb < Adb_DM.AmsgColl.CollPreg.Count) do
  begin
    if Adb_DM.AmsgColl.CollMdn.Items[iMdn].PregledNRN = Adb_DM.AmsgColl.CollPreg.Items[iAmb].NRN then
    begin
      if Adb_DM.AmsgColl.CollMdn.Items[iMdn].FLstMsgImportNzis.Count > 0 then
      begin
        Adb_DM.AmsgColl.CollPreg.Items[iAmb].FMdns.Add(Adb_DM.AmsgColl.CollMdn.Items[iMdn]);
        Adb_DM.AmsgColl.CollMdn.Items[iMdn].FPregled := Adb_DM.AmsgColl.CollPreg.Items[iAmb];
      end;
      inc(iMdn);
    end
    else if Adb_DM.AmsgColl.CollMdn.Items[iMdn].PregledNRN > Adb_DM.AmsgColl.CollPreg.Items[iAmb].NRN then
    begin
      begin
        inc(iAmb);

      end;
    end
    else if Adb_DM.AmsgColl.CollMdn.Items[iMdn].PregledNRN < Adb_DM.AmsgColl.CollPreg.Items[iAmb].NRN then
    begin
      inc(iMdn);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillPregXXX ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillRespInReq;
var
  msgReq, msgResp: TNzisReqRespItem;
  i: Integer;
begin
  Stopwatch := TStopwatch.StartNew;
  Adb_DM.AmsgColl.SortByMessageId_nom;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('sort :двойкуване за %f ', [Elapsed.TotalMilliseconds]));
  Stopwatch := TStopwatch.StartNew;
  for i := 1 to Adb_DM.AmsgColl.Count - 1 do
  begin
    //if (i mod 300) = 0 then
//    begin
//      FmxRoleBar.rctProgres.Width := FmxRoleBar.rctButton.Width * (i/msgColl.Count);
//      FmxRoleBar.rctProgres.EndUpdate;
//      Application.ProcessMessages;
//    end;
    if Adb_DM.AmsgColl.Items[i].PRecord.messageId = Adb_DM.AmsgColl.Items[i - 1].PRecord.messageId then  // двойка са
    begin
      Adb_DM.AmsgColl.Items[i - 1].PRecord.RESP := Adb_DM.AmsgColl.Items[i].PRecord.REQ;
      //SetLength(msgColl.Items[i -1].PRecord.RESP, length(msgColl.Items[i - 1].PRecord.RESP)-2);
      //msgColl.Items[i - 1].PRecord.NRN := msgColl.Items[i].PRecord.NRN
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  for i := Adb_DM.AmsgColl.Count - 1 downto 0 do
  begin
    //if (i mod 300) = 0 then
//    begin
//      FmxRoleBar.rctProgres.Width := FmxRoleBar.rctButton.Width * (i/msgColl.Count);
//      FmxRoleBar.rctProgres.EndUpdate;
//      Application.ProcessMessages;
//    end;
    if Adb_DM.AmsgColl.Items[i].PRecord.RESP = '' then  // двойка са
    begin
      Adb_DM.AmsgColl.Delete(i);
    end;
  end;

  mmoTest.Lines.Add(Format('двойкуване за %f ', [Elapsed.TotalMilliseconds]));
end;

procedure TfrmSuperHip.FillSecInPrim(pat: TRealPatientNewItem);
var
  i: Integer;
  preg: TRealPregledNewItem;
  log: TlogicalPregledNewSet;
begin
  for i := 0 to pat.FPregledi.Count - 1 do
  begin
    preg  := pat.FPregledi[i];
    log := TlogicalPregledNewSet(preg.getLogical40Map(Adb_DM.CollPregled.Buf, Adb_DM.CollPregled.posData, word(PregledNew_Logical)));
    if (TLogicalPregledNew.IS_PRIMARY in log) then
    begin
      mmoTest.Lines.Add(IntToStr(i));
    end;
  end;
end;

procedure TfrmSuperHip.FillSpecNzisInMedNapr;
var
  icl006, imn: integer;
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
begin
  Adb_DM.CL006Coll.IndexValue(CL006_Key);
  Adb_DM.CL006Coll.SortByIndexAnsiString;
  Adb_DM.CollMedNapr.SortBySpecNzis;
  icl006 := 0;
  imn := 0;
  //pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
  //dataPosition := pCardinalData^ + self.AspectsHipFile.FPosData;
  while (icl006 < Adb_DM.CL006Coll.Count) and (imn < Adb_DM.CollMedNapr.Count) do
  begin
    if Adb_DM.CL006Coll.Items[icl006].IndexAnsiStr1 = Adb_DM.CollMedNapr.Items[imn].SpecNzis then
    begin
      Adb_DM.CollMedNapr.SetIntMap(Adb_DM.CollMedNapr.Items[imn].DataPos, word(BLANKA_MED_NAPR_SpecDataPos), Adb_DM.CL006Coll.Items[icl006].DataPos);
      //New(CollMedNapr.Items[imn].PRecord);
//
//      CollMedNapr.Items[imn].PRecord.setProp := [BLANKA_MED_NAPR_SpecDataPos];
//      CollMedNapr.Items[imn].PRecord.SpecDataPos := CL006Coll.Items[icl006].DataPos;
//      CollMedNapr.Items[imn].SaveBLANKA_MED_NAPR(dataPosition);

      inc(imn);
    end
    else if Adb_DM.CL006Coll.Items[icl006].IndexAnsiStr1 > Adb_DM.CollMedNapr.Items[imn].SpecNzis then
    begin
      begin
        inc(imn);

      end;
    end
    else if Adb_DM.CL006Coll.Items[icl006].IndexAnsiStr1 < Adb_DM.CollMedNapr.Items[imn].SpecNzis then
    begin
      inc(icl006);
    end;
  end;
  //pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
  //pCardinalData^  := dataPosition - self.AspectsHipFile.FPosData;
end;

//procedure TfrmSuperHip.FillPrimInSec;
//var
//  iPrim, iSec: integer;
//  function conditionI(i, p: integer): Boolean;
//  begin
//    if collPregledPrim[i].PatID <> CollPregledVtor[P].PatID then
//      Result := collPregledPrim[i].PatID < CollPregledVtor[P].PatID
//    else
//    if collPregledPrim[i].DoctorId <> CollPregledVtor[P].DoctorId then
//      Result := collPregledPrim[i].DoctorId < CollPregledVtor[P].DoctorId
//    else
//    if collPregledPrim[i].AmbListNo <> CollPregledVtor[P].SIMP_PRIMARY_AMBLIST_N then
//      Result := collPregledPrim[i].AmbListNo < CollPregledVtor[P].SIMP_PRIMARY_AMBLIST_N
//    else
//      Result := collPregledPrim[i].StartDate < CollPregledVtor[P].SIMP_PRIMARY_AMBLIST_DATE
//  end;
//
//  function conditionJ(i, p: integer): Boolean;
//  begin
//    if collPregledPrim[i].PatientID <> CollPregledVtor[P].PatientID then
//      Result := collPregledPrim[i].PatientID > CollPregledVtor[P].PatientID
//    else
//    if collPregledPrim[i].DoctorId <> CollPregledVtor[P].DoctorId then
//      Result := collPregledPrim[i].DoctorId > CollPregledVtor[P].DoctorId
//    else
//    if collPregledPrim[i].AmbListNo <> CollPregledVtor[P].SIMP_PRIMARY_AMBLIST_N then
//      Result := collPregledPrim[i].AmbListNo > CollPregledVtor[P].SIMP_PRIMARY_AMBLIST_N
//    else
//      Result := collPregledPrim[i].StartDate > CollPregledVtor[P].SIMP_PRIMARY_AMBLIST_DATE
//  end;
//
//
//begin
//  //Stopwatch := TStopwatch.StartNew;
//  iPrim := 0;
//  iSec := 0;
//  while (iPrim < collPregledPrim.Count) and (iSec < CollPregledVtor.count) do
//  begin
//    if (collPregledPrim[iPrim].PatientID = CollPregledVtor[iSec].PatientID ) and
//       (collPregledPrim[iPrim].DoctorId = CollPregledVtor[iSec].DoctorId ) and
//       (collPregledPrim[iPrim].AmbListNo = CollPregledVtor[iSec].SIMP_PRIMARY_AMBLIST_N ) and
//       (collPregledPrim[iPrim].StartDate = CollPregledVtor[iSec].SIMP_PRIMARY_AMBLIST_DATE )
//    then
//    begin
//      CollPregledVtor[iSec].FPrimary  := collPregledPrim[iPrim];
//      inc(iPrim);
//      inc(iSec);
//    end
//    else
//    if conditionJ(iPrim, iSec) then
//    begin
//      begin
//        inc(iSec);
//
//      end;
//    end
//    else if conditionI(iPrim, iSec) then
//    begin
//      inc(iPrim);
//    end;
//  end;
//  //Memo1.Lines.Add(Format('Брой амб. листи pri doctorite: %d за %f ms',
////    [AmbListColl.Count, Elapsed.TotalMilliseconds]));
//end;

procedure TfrmSuperHip.FillUnfavInDoctor;
var
  iun, iDoc: integer;
  indexUnfav: integer;
  Unfav: TRealUnfavItem;
begin
  Adb_DM.CollDoctor.IndexValue(Doctor_ID);
  Adb_DM.CollDoctor.SortByIndexValue(Doctor_ID);
  Adb_DM.CollUnfav.IndexValue(Unfav_DOCTOR_ID_PRAC);
  Adb_DM.CollUnfav.SortByIndexValue(Unfav_DOCTOR_ID_PRAC);
  iun := 0;
  iDoc := 0;
  while iun < Adb_DM.CollUnfav.Count do
  begin
    if Adb_DM.CollUnfav.Items[iun].DoctorID = Adb_DM.CollDoctor.Items[iDoc].DoctorID then
    begin
      unfav := Adb_DM.CollUnfav.Items[iun];
      indexUnfav := (unfav.Year - 2024) * 12 + Unfav.Month;
      Adb_DM.CollDoctor.Items[iDoc].FListUnfav[indexUnfav] := unfav;
      Adb_DM.CollDoctor.Items[iDoc].FListUnfavDB[indexUnfav] := unfav;
      inc(iun);
    end
    else if Adb_DM.CollUnfav.Items[iun].DoctorID > Adb_DM.CollDoctor.Items[iDoc].DoctorID then
    begin
      begin
        inc(iDoc);

      end;
    end
    else if Adb_DM.CollUnfav.Items[iun].DoctorID < Adb_DM.CollDoctor.Items[iDoc].DoctorID then
    begin
      inc(iun);
    end;
  end;
end;

procedure TfrmSuperHip.FillXmlC001(NomenID: string);
var
  newGUID: TGUID;
  strGuid: string;
  i, j: Integer;
  ver: string;
begin
  CreateGUID(newGUID);
  strGuid := GUIDToString(newGUID);
  strGuid := Copy(strGuid, 2, 36);
  ver := 'NzisNomen';
  XMLStreamC001.Clear;
  XMLStreamC001.Writestring(('<?xml version="1.0" encoding="UTF-8"?>' +#13#10));
  XMLStreamC001.Writestring(('<nhis:message xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:nhis="https://www.his.bg" xsi:schemaLocation="https://www.his.bg https://www.his.bg/api/v1/NHIS-C001.xsd">' +#13#10));

  AddTagToStream(XMLStreamC001,'nhis:header', '', false);
  AddTagToStream(XMLStreamC001,'nhis:sender', 'value="1"', false);

  AddTagToStream(XMLStreamC001,'nhis:senderId', Format('value="%s"',['6810101723']) , false);
  AddTagToStream(XMLStreamC001,'nhis:senderISName', Format('value="Hippocrates%s"',[ver]), false);
  AddTagToStream(XMLStreamC001,'nhis:recipient', 'value="4"', false);
  AddTagToStream(XMLStreamC001,'nhis:recipientId', 'value="NHIS"', false);

  AddTagToStream(XMLStreamC001,'nhis:messageId', Format('value="%s"',[strGuid]), false);
  AddTagToStream(XMLStreamC001,'nhis:messageType', 'value="C001"', false);
  AddTagToStream(XMLStreamC001,'nhis:createdOn', Format('value="%s"', [DateToISO8601(TTimeZone.Local.ToUniversalTime (now))]), false);
  AddTagToStream(XMLStreamC001,'/nhis:header', '');

  AddTagToStream(XMLStreamC001,'nhis:contents', '', false);
  AddTagToStream(XMLStreamC001,'nhis:nomenclatureId', Format('value="%s"',[NomenID]), false);
  AddTagToStream(XMLStreamC001,'/nhis:contents', '');
  AddTagToStream(XMLStreamC001,'/nhis:message','');
  XMLStreamC001.Position := 0;
  //Memo1.Lines.LoadFromStream(XMLStreamC001);
  //XMLStreamC007.SaveToFile('c:\work\test.xml');
end;

procedure TfrmSuperHip.FillADBInMsgColl;
var
  data, dataAction, dataPat, dataPreg: PAspRec;
  linkPos, FPosLinkData: Cardinal;
  pCardinalData: PCardinal;
  bufLink: Pointer;
  RunNode, patNode: PVirtualNode;
  node: PVirtualNode;

  pat: TRealPatientNewItem;
  preg: TRealPregledNewItem;
  mdn: TRealMDNItem;
  IncMN: TRealINC_NAPRItem;

begin
  Adb_DM.AmsgColl.CollPat.posData := Adb_DM.AdbMain.FPosData;
  Adb_DM.AmsgColl.CollPat.buf := Adb_DM.AdbMain.Buf;
  Adb_DM.AmsgColl.CollPreg.posData := Adb_DM.AdbMain.FPosData;
  Adb_DM.AmsgColl.CollPreg.buf := Adb_DM.AdbMain.Buf;
  Adb_DM.AmsgColl.CollIncMN.posData := Adb_DM.AdbMain.FPosData;
  Adb_DM.AmsgColl.CollIncMN.buf := Adb_DM.AdbMain.Buf;
  Adb_DM.AmsgColl.CollIncDoc.posData := Adb_DM.AdbMain.FPosData;
  Adb_DM.AmsgColl.CollIncDoc.buf := Adb_DM.AdbMain.Buf;
  bufLink := AspectsLinkPatPregFile.Buf;
  begin
    linkPos := 100;
    pCardinalData := pointer(PByte(bufLink));
    FPosLinkData := pCardinalData^;
    while linkpos < FPosLinkData do
    begin
      RunNode := pointer(PByte(bufLink) + linkpos);
      data := pointer(PByte(RunNode) + lenNode);
      case data.vid of
        vvPatient:
        begin
          pat := TRealPatientNewItem(Adb_DM.AmsgColl.CollPat.Add);
          pat.DataPos := Data.DataPos;
          pat.PatEGN := Adb_DM.CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_EGN));
          pat.FNode := RunNode;
        end;
        vvPregled:
        begin
          if Adb_DM.CollPregled.getAnsiStringMap(Data.DataPos, word(PregledNew_NRN_LRN)) <> '' then
          begin
            dataPat := pointer(PByte(RunNode.Parent) + lenNode);

            preg := TRealPregledNewItem(Adb_DM.AmsgColl.CollPreg.Add);
            preg.DataPos := Data.DataPos;
            preg.nrn := Adb_DM.CollPregled.getAnsiStringMap(Data.DataPos, word(PregledNew_NRN_LRN));
            preg.PatEGN := Adb_DM.CollPatient.getAnsiStringMap(DataPat.DataPos, word(PatientNew_EGN));
            preg.FNode := RunNode;
          end;
        end;
        vvmdn:
        begin
          if Adb_DM.CollMDN.getAnsiStringMap(Data.DataPos, word(MDN_NRN)) <> '' then
          begin
            dataPreg := pointer(PByte(RunNode.Parent) + lenNode);

            mdn := TRealMDNItem(Adb_DM.AmsgColl.CollMdn.Add);
            mdn.DataPos := Data.DataPos;
            mdn.NRN := Adb_DM.CollMDN.getAnsiStringMap(Data.DataPos, word(MDN_NRN));
            mdn.PregledNRN := Adb_DM.CollPatient.getAnsiStringMap(DataPreg.DataPos, word(PregledNew_NRN_LRN));
            mdn.LinkNode := RunNode;
          end;
        end;
        vvIncMN:
        begin
          if Adb_DM.CollIncMN.getAnsiStringMap(Data.DataPos, word(INC_NAPR_NRN)) <> '' then
          begin
            dataPat := pointer(PByte(RunNode.Parent) + lenNode);

            IncMN := TRealINC_NAPRItem(Adb_DM.AmsgColl.CollIncMN.Add);
            IncMN.DataPos := Data.DataPos;
            IncMN.NRN := Adb_DM.CollIncMN.getAnsiStringMap(Data.DataPos, word(INC_NAPR_NRN));
            IncMN.PatEgn := Adb_DM.CollPatient.getAnsiStringMap(dataPat.DataPos, word(PatientNew_EGN));
            IncMN.LinkNode := RunNode;
          end;
        end;

      end;
      Inc(linkPos, LenData);
    end;
  end;
end;

//procedure TfrmSuperHip.FilterClick(tableVid: TVtrVid; field: Word; FltrList: TList<ComboBoxHip.TFilterValues>);
////sender: TDynWinPanel; ctrl: TBaseControl; FltrList: TList<ComboBoxHip.TFilterValues>);
//var
//  i: Integer;
//  fv: TFilterValues;
//  MinValInt: Integer;
//  MinValAnsiString: AnsiString;
//begin
//  Stopwatch := TStopwatch.StartNew;
//  case tableVid of
//    vvPregled:
//    begin
//      if CollPregled.FindedRes.PropIndex <> field then
//      begin
//        CollPregled.FindedRes.DataPos := 0;
//        CollPregled.FindedRes.PropIndex := field;
//        CollPregled.IndexValue(TPregledNewItem.TPropertyIndex(CollPregled.FindedRes.PropIndex));
//      end;
//      CollPregled.SortByIndexValue(TPregledNewItem.TPropertyIndex(CollPregled.FindedRes.PropIndex));
//      for i := 0 to FltrList.Count - 1 do
//      begin
//        FltrList[i].lstGroup.Destroy;
//      end;
//      FltrList.Clear;
//      case TPregledNewItem.TPropertyIndex(CollPregled.FindedRes.PropIndex) of
//      PregledNew_AMB_LISTN:
//      begin
//        MinValInt := CollPregled.Items[0].IndexInt;
//        fv.value := IntToStr(MinValInt);
//        fv.count := 1;
//        fv.obj := CollPregled.Items[0];
//        fv.lstGroup := TList<TBaseItem>.Create;
//        fv.lstGroup.Add(CollPregled.Items[0]);
//        for i := 1 to  CollPregled.Count - 1 do
//        begin
//          if CollPregled.Items[i].IndexInt <> MinValInt then
//          begin
//            FltrList.Add(fv);
//            fv.value := IntToStr(CollPregled.Items[i].IndexInt);
//            fv.count := 1;
//            fv.obj := CollPregled.Items[i];
//            fv.lstGroup := TList<TBaseItem>.Create;
//            fv.lstGroup.Add(CollPregled.Items[i]);
//            MinValInt := CollPregled.Items[i].IndexInt;
//          end
//          else
//          begin
//            inc(fv.count);
//            fv.lstGroup.Add(CollPregled.Items[i]);
//          end;
//        end;
//        FltrList.Add(fv);
//      end;
//        PregledNew_NRN, PregledNew_ANAMN://, Pregled_MAIN_DIAG_MKB:
//        begin
//          MinValAnsiString := CollPregled.Items[0].IndexAnsiStr;
//          fv.value := MinValAnsiString;
//          fv.count := 1;
//          fv.obj := CollPregled.Items[0];
//          fv.lstGroup := TList<TBaseItem>.Create;
//          fv.lstGroup.Add(CollPregled.Items[0]);
//          for i := 1 to CollPregled.Count - 1 do
//          begin
//            if CollPregled.Items[i].IndexAnsiStr <> MinValAnsiString then
//            begin
//              FltrList.Add(fv);
//              fv.value := CollPregled.Items[i].IndexAnsiStr;
//              fv.count := 1;
//              fv.obj := CollPregled.Items[i];
//              fv.lstGroup := TList<TBaseItem>.Create;
//              fv.lstGroup.Add(CollPregled.Items[i]);
//              MinValAnsiString := CollPregled.Items[i].IndexAnsiStr;
//            end
//            else
//            begin
//              inc(fv.count);
//              fv.lstGroup.Add(CollPregled.Items[i]);
//            end;
//          end;
//          FltrList.Add(fv);
//        end;
//      end;
//
//    end;
//    vvPatient:
//    begin
//      if CollPatient.FindedRes.PropIndex <> field then
//      begin
//        CollPatient.FindedRes.DataPos := 0;
//        CollPatient.FindedRes.PropIndex := field;
//        CollPatient.IndexValue(TPatientNewItem.TPropertyIndex(CollPatient.FindedRes.PropIndex));
//      end;
//      CollPatient.SortByIndexValue(TPatientNewItem.TPropertyIndex(CollPatient.FindedRes.PropIndex));
//      for i := 0 to FltrList.Count - 1 do
//      begin
//        FltrList[i].lstGroup.Destroy;
//      end;
//      FltrList.Clear;
//      case TPatientNewItem.TPropertyIndex(CollPatient.FindedRes.PropIndex) of
//        PatientNew_ID:
//        begin
//        MinValInt := CollPatient.Items[0].IndexInt;
//        fv.value := IntToStr(MinValInt);
//        fv.count := 1;
//        fv.obj := CollPatient.Items[0];
//        fv.lstGroup := TList<TBaseItem>.Create;
//        fv.lstGroup.Add(CollPatient.Items[0]);
//        for i := 1 to  CollPatient.Count - 1 do
//        begin
//          if CollPatient.Items[i].IndexInt <> MinValInt then
//          begin
//            FltrList.Add(fv);
//            fv.value := IntToStr(CollPatient.Items[i].IndexInt);
//            fv.count := 1;
//            fv.obj := CollPatient.Items[i];
//            fv.lstGroup := TList<TBaseItem>.Create;
//            fv.lstGroup.Add(CollPatient.Items[i]);
//            MinValInt := CollPatient.Items[i].IndexInt;
//          end
//          else
//          begin
//            inc(fv.count);
//            fv.lstGroup.Add(CollPatient.Items[i]);
//          end;
//        end;
//        FltrList.Add(fv);
//      end;
//        PatientNew_EGN, PatientNew_FNAME://, Pregled_MAIN_DIAG_MKB:
//        begin
//          MinValAnsiString := CollPatient.Items[0].IndexAnsiStr;
//          fv.value := MinValAnsiString;
//          fv.count := 1;
//          fv.obj := CollPatient.Items[0];
//          fv.lstGroup := TList<TBaseItem>.Create;
//          fv.lstGroup.Add(CollPatient.Items[0]);
//          for i := 1 to CollPatient.Count - 1 do
//          begin
//            if CollPatient.Items[i].IndexAnsiStr <> MinValAnsiString then
//            begin
//              FltrList.Add(fv);
//              fv.value := CollPatient.Items[i].IndexAnsiStr;
//              fv.count := 1;
//              fv.obj := CollPatient.Items[i];
//              fv.lstGroup := TList<TBaseItem>.Create;
//              fv.lstGroup.Add(CollPatient.Items[i]);
//              MinValAnsiString := CollPatient.Items[i].IndexAnsiStr;
//            end
//            else
//            begin
//              inc(fv.count);
//              fv.lstGroup.Add(CollPatient.Items[i]);
//            end;
//          end;
//          FltrList.Add(fv);
//        end;
//      end;
//
//    end;
//  end;
//
//
//  LoadVtrFilter(FltrList, nil, AspectsLinkPatPregFile.Buf);
//
//
//  //FltrList.Clear;
//  //FreeAndNil(FltrList);
//  Elapsed := Stopwatch.Elapsed;
//  mmotest.Lines.Add( 'SortFilter ' + FloatToStr(Elapsed.TotalMilliseconds));
//end;

procedure TfrmSuperHip.FindADB(AGUID: TList<TGUID>);
var
  S: string;

  i, j: Integer;
  collType: TCollectionsType;
  aspVersion: Word;
  b: Byte;
  pByteData: ^Byte;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  pg: PGUID;

  AInt64: Int64;
  dirAdb: string;
begin
  if ParamStr(2) <> '' then
    dirAdb := ParamStr(2)
  else
    dirAdb := '.\';
   //ShowMessage(dirAdb);
  for S in TDirectory.GetFiles(dirAdb, '*.adb', TSearchOption.soAllDirectories) do
  begin
   // if AspectsHipFile <> nil then
     // AspectsHipFile.Free;
    Stopwatch := TStopwatch.StartNew;
    Adb_DM.AdbMain := TMappedFile.Create(S, false, TGUID.Empty);
    Elapsed := Stopwatch.Elapsed;
    mmotest.Lines.Add( S + ' Martin ' + FloatToStr(Elapsed.TotalMilliseconds));
    if Adb_DM.AdbMain.Buf <> nil then
    begin
      pCardinalData := pointer(PByte(Adb_DM.AdbMain.Buf));
      FPosMetaData := pCardinalData^;
      pCardinalData := pointer(PByte(Adb_DM.AdbMain.Buf) + 4);
      FLenMetaData := pCardinalData^;
      pCardinalData := pointer(PByte(Adb_DM.AdbMain.Buf) + 8);
      FPosData := pCardinalData^;
      pCardinalData := pointer(PByte(Adb_DM.AdbMain.Buf) + 12);
      FLenData := pCardinalData^;
      Pg := pointer(PByte(Adb_DM.AdbMain.Buf) + 16 );
      for j := 0 to AGUID.Count - 1 do
      begin
        if AGUID[j] <> TGUID.Empty then
        begin
          if AGUID[j] = pg^ then
          begin
            Panel1.Caption := 'dd';
            Exit;
          end;
        end;
      end;

      aspPos := FPosMetaData;
      Adb_DM.AdbMain.Free;
      Adb_DM.AdbMain := nil;
    end;

  end;

end;

function TfrmSuperHip.FindCertFromSerNumber(serNom: TArray<System.Byte>): TElX509Certificate;
var
  WinStorage : TElWinCertStorage;
  Cert: TElX509Certificate;
  CntCert, i, j : integer;
  StrTemp, docEgn, certEgn : String;
  WithEgn: Boolean;
  doc: TRealDoctorItem;
  //buf: Pointer;
  posdata: Cardinal;
  data: PAspRec;
  isEqu: Boolean;
begin
  Result := nil;
  WinStorage := TElWinCertStorage.Create(nil);
  //buf := Adb_DM.AdbMain.Buf;

  WinStorage.SystemStores.Add('MY');
  CntCert := 0;
  try
    while CntCert < WinStorage.Count do
    begin
      try
        try
          if (WinStorage.Certificates[CntCert].ValidFrom < now) and (WinStorage.Certificates[CntCert].ValidTo > now)  then
          begin
            Cert := WinStorage.Certificates[CntCert];
            //Cert.
            if Length(Cert.SerialNumber) <> (Length(serNom)) then  Continue;
            isEqu := True;
            for i := 0 to Length(Cert.SerialNumber) - 1 do
            begin
              if Cert.SerialNumber[i] <> serNom[i] then
              begin
                isEqu := False;
                Break;
              end;
            end;
            if not isEqu then
            Continue;
             cert.Clone(CurrentCert);
             cert.Clone(CertForThread);
            Break;
          end;
        finally
          Inc(CntCert);
        end;
        //Application.ProcessMessages;
      except
        on E : Exception do  Application.ShowException(E);
      end;
    end;
  finally

  end;
  WinStorage.Free;
end;

procedure TfrmSuperHip.FindDiagInMDN;
var
  data, dataParent: PAspRec;
  linkPos, FPosLinkData: Cardinal;
  pCardinalData: PCardinal;
  bufLink: Pointer;
  RunNode, parentNode: PVirtualNode;
  diag: TRealDiagnosisItem;
  cnt: Integer;
begin
  Stopwatch := TStopwatch.StartNew;
  bufLink := AspectsLinkPatPregFile.Buf;
  linkPos := 100;
  cnt := 0;
  pCardinalData := pointer(PByte(bufLink));
  FPosLinkData := pCardinalData^;
  while linkpos < FPosLinkData do
  begin
    RunNode := pointer(PByte(bufLink) + linkpos);
    data := pointer(PByte(RunNode) + lenNode);
    case data.vid of
      vvDiag:
      begin
        parentNode := RunNode.Parent;
        dataParent := pointer(PByte(parentNode) + lenNode);
        case dataParent.vid of
          vvMDN:
          begin
            inc(cnt);
            //vtrPregledPat.Selected[parentNode] := True;
//            vtrPregledPat.FocusedNode := parentNode;
//            Exit;
          end;
        end;
      end;
    end;
    Inc(linkPos, LenData);
  end;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('loopTree за %f',[Elapsed.TotalMilliseconds]));
end;

procedure TfrmSuperHip.FindDoctor(Down: Boolean);
var
  i: Integer;
  doc: TRealDoctorItem;
  node: PVirtualNode;
  data: PNodeRec;
begin
  if down then
  begin
    if ButtonedEdit1.Tag = 0 then
    begin
      node := vtrSpisyci.RootNode.FirstChild;
    end
    else
    begin
      node := PVirtualNode(ButtonedEdit1.Tag).NextSibling;
    end;
  end
  else
  begin
    if ButtonedEdit1.Tag = 0 then
    begin
      node := vtrSpisyci.RootNode.LastChild;
    end
    else
    begin
      node := PVirtualNode(ButtonedEdit1.Tag).PrevSibling;
    end;
  end;
  while node <> nil do
  begin
    data := vtrSpisyci.GetNodeData(node);
    doc := Adb_DM.CollDoctor.Items[data.index];
    if AnsiUpperCase(doc.FullName).Contains(AnsiUpperCase(SearchTextSpisyci)) then
    begin
      ButtonedEdit1.Tag := Integer(node);
      vtrSpisyci.FocusedNode := doc.Node;
      vtrSpisyci.Selected[doc.Node] := True;
      Exit;
    end;
    if down then
    begin
      node := node.NextSibling;
    end
    else
    begin
      node := node.PrevSibling;
    end;
  end;
  ButtonedEdit1.Tag := 0;
end;

procedure TfrmSuperHip.FindLNK(AGUID: TGUID);
var
  S: string;

  i, j: Integer;
  collType: TCollectionsType;
  aspVersion: Word;
  b: Byte;
  pByteData: ^Byte;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  pg: PGUID;

  AInt64: Int64;
  dirAdb: string;
begin
  if ParamStr(2) <> '' then
    dirAdb := ParamStr(2)
  else
    dirAdb := '.\';
  for S in TDirectory.GetFiles(dirAdb, '*Hip*.lnk', TSearchOption.soAllDirectories) do
  begin
    if AspectsLinkPatPregFile <> nil then
      AspectsLinkPatPregFile.Free;
    AspectsLinkPatPregFile := TMappedLinkFile.Create(s, false, TGUID.Empty);
    if AspectsLinkPatPregFile.Buf <> nil then
    begin
      //pCardinalData := pointer(PByte(AspectsHipFile.Buf));
//      FPosMetaData := pCardinalData^;
//      pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 4);
//      FLenMetaData := pCardinalData^;
//      pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 8);
//      FPosData := pCardinalData^;
//      pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
//      FLenData := pCardinalData^;
      Pg := pointer(PByte(AspectsLinkPatPregFile.Buf) + 16 );
      if AGUID <> TGUID.Empty then
        begin
          if AGUID = pg^ then
          begin
            Exit;
          end;
        end;

      AspectsLinkPatPregFile.Free;
      AspectsLinkPatPregFile := nil;
    end;
  end;

end;

//function TfrmSuperHip.FindNodevtr(DirectionFind: TDirectionFinder;
//  vtr: TVirtualStringTree): boolean;
//var
//  node: PVirtualNode;
//  data: PAspRec;
//
//  function FindNodeRepeat(DirectionFind: TDirectionFinder; vtr: TVirtualStringTree): boolean;
//  var
//    SaveNode: PVirtualNode;
//    prefix: string;
//  begin
//    SaveNode := node;
//    Result := False;
//    prefix := Copy(vtr.Header.Columns[0].Text, 1, vtr.Header.Columns[0].Tag);
//
//    while node <> nil do
//    begin
//      data := pointer(PByte(node) + lenNode);
//      if data.vid = FinderRec.vid then
//      begin
//        if vtr.Text[node, 0].StartsWith(prefix + FinderRec.strSearch) then
//        begin
//          vtr.Selected[node] := True;
//          vtr.RepaintNode(node);
//          FinderRec.node := node;
//          //vtrPregledPat.FocusedNode := node;
//          Result  := True;
//          Break;
//        end;
//      end;
//      case DirectionFind of
//        dfForward,dfNone:
//        begin
//          if node.NextSibling <> nil then
//          begin
//            node := node.NextSibling;
//          end
//          else
//          begin
//            node := node.Parent.FirstChild;
//          end;
//        end;
//        dfBackward:
//        begin
//          if node.PrevSibling <> nil then
//          begin
//            node := node.PrevSibling;
//          end
//          else
//          begin
//            node := node.Parent.LastChild;
//          end;
//        end;
//      end;
//
//      if node = SaveNode then Break;
//    end;
//  end;
//begin
//  if FinderRec.strSearch = '' then
//  begin
//    vtr.Repaint;
//    FinderRec.IsFinded := False;
//    FinderRec.node := nil;
//    Exit;
//  end;
//  case DirectionFind of
//    dfNone: node := FinderRec.node; //vtrPregledPat.GetFirstSelected();
//    dfForward: node :=  FinderRec.node.NextSibling; //vtrPregledPat.GetFirstSelected().NextSibling;
//    dfBackward:
//    begin
//      if  vtr.GetFirstSelected() = vtr.RootNode.FirstChild.FirstChild then
//      begin
//        node := vtr.RootNode.FirstChild.FirstChild.LastChild;
//      end
//      else
//      begin
//        node := FinderRec.node.PrevSibling; //vtrPregledPat.GetFirstSelected().PrevSibling;
//      end;
//    end;
//
//  end;
//
//  if node = nil then
//  begin
//    vtr.Repaint;
//    FinderRec.IsFinded := False;
//    FinderRec.node := nil;
//    Exit;
//  end;
//
//  Result := FindNodeRepeat(DirectionFind, ACol);
//
//  if (not Result) and (FinderRec.IsFinded) then // до сега е имало намерено, и вече няма.
//  begin
//    case DirectionFind of
//      dfForward: // намирано е напред. Затова се връщам на първия възел и търся първия след него от съответния тип
//      begin
//        node := vtr.RootNode.FirstChild; //pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);
//        if vtr is TVirtualStringTreeAspect then
//        begin
//          data := pointer(PByte(node) + lenNode);
//        end
//        else
//        begin
//          data := vtr.GetNodeData(node);
//        end;
//        while data.vid <> FinderRec.vid do
//        begin
//          node := pointer(PByte(node) + LenData);
//          data := pointer(PByte(node) + lenNode);
//        end;
//        result := FindNodeRepeat(dfForward);
//      end;
//      dfBackward: // намирано е назад. Затова се отивам на последния възел и търся първия преди него от съответния тип
//      begin
//        node := vtr.RootNode.FirstChild.LastChild; //pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);
//        data := pointer(PByte(node) + lenNode);
//        while data.vid <> FinderRec.vid do
//        begin
//          node := pointer(PByte(node) - LenData);
//          data := pointer(PByte(node) + lenNode);
//        end;
//        result := FindNodeRepeat(dfBackward);
//      end;
//    end;
//  end;
//
//  FinderRec.IsFinded := Result;
//end;

function TfrmSuperHip.FindNodevtrPreg(DirectionFind: TDirectionFinder; ACol: TColumnIndex): boolean;
var
  node: PVirtualNode;
  data: PAspRec;

  function FindNodeRepeat(DirectionFind: TDirectionFinder; ACol: TColumnIndex): boolean;
  var
    SaveNode: PVirtualNode;
    prefix: string;
    ArrStr: TArray<string>;
    StrNumber: Integer;
  begin
    SaveNode := node;
    Result := False;
    prefix := Copy(vtrPregledPat.Header.Columns[ACol].Text, 1, vtrPregledPat.Header.Columns[ACol].Tag);

    while node <> nil do
    begin
      data := pointer(PByte(node) + lenNode);
      if data.vid = FinderRec.vid then
      begin
        case data.vid of
          vvPatient:
          begin
            case ACol of
              0:
              begin
                if AnsiUpperCase(vtrPregledPat.Text[node, ACol]).StartsWith(AnsiUpperCase(prefix + FinderRec.strSearch)) then
                begin
                  vtrPregledPat.Selected[node] := True;
                  vtrPregledPat.RepaintNode(node);
                  FinderRec.node := node;
                  //vtrPregledPat.FocusedNode := node;
                  Result  := True;
                  Break;
                end;
              end;
              1:
              begin
                ArrStr := vtrPregledPat.Text[node, ACol].Split([' ']);
                StrNumber := vtrPregledPat.Header.Columns[ACol].Tag;
                if AnsiUpperCase(ArrStr[StrNumber]).StartsWith(AnsiUpperCase(FinderRec.strSearch)) then
                begin
                  vtrPregledPat.Selected[node] := True;
                  vtrPregledPat.RepaintNode(node);
                  FinderRec.node := node;
                  //vtrPregledPat.FocusedNode := node;
                  Result  := True;
                  Break;
                end;
              end;
            end;
          end;
          vvPregled:
          begin
            case ACol of
              1:
              begin
                if AnsiUpperCase(vtrPregledPat.Text[node, ACol]).StartsWith(AnsiUpperCase(prefix + FinderRec.strSearch)) then
                begin
                  vtrPregledPat.Selected[node] := True;
                  vtrPregledPat.RepaintNode(node);
                  FinderRec.node := node;
                  //vtrPregledPat.FocusedNode := node;
                  Result  := True;
                  Break;
                end;
              end;
              //1:
//              begin
//                ArrStr := vtrPregledPat.Text[node, ACol].Split([' ']);
//                StrNumber := vtrPregledPat.Header.Columns[ACol].Tag;
//                if AnsiUpperCase(ArrStr[StrNumber]).StartsWith(AnsiUpperCase(FinderRec.strSearch)) then
//                begin
//                  vtrPregledPat.Selected[node] := True;
//                  vtrPregledPat.RepaintNode(node);
//                  FinderRec.node := node;
//                  //vtrPregledPat.FocusedNode := node;
//                  Result  := True;
//                  Break;
//                end;
//              end;
            end;
          end;
        end;

      end;
      case DirectionFind of
        dfForward,dfNone:
        begin
          if node.NextSibling <> nil then
          begin
            node := node.NextSibling;
          end
          else
          begin
            node := node.Parent.FirstChild;
          end;
        end;
        dfBackward:
        begin
          if node.PrevSibling <> nil then
          begin
            node := node.PrevSibling;
          end
          else
          begin
            node := node.Parent.LastChild;
          end;
        end;
      end;

      if node = SaveNode then Break;
    end;
  end;
begin
  if FinderRec.strSearch = '' then
  begin
    vtrPregledPat.Repaint;
    FinderRec.IsFinded := False;
    FinderRec.node := nil;
    Exit;
  end;
  case DirectionFind of
    dfNone: node := FinderRec.node; //vtrPregledPat.GetFirstSelected();
    dfForward: node :=  FinderRec.node.NextSibling; //vtrPregledPat.GetFirstSelected().NextSibling;
    dfBackward:
    begin
      if  vtrPregledPat.GetFirstSelected() = vtrPregledPat.RootNode.FirstChild.FirstChild then
      begin
        node := vtrPregledPat.RootNode.FirstChild.FirstChild.LastChild;
      end
      else
      begin
        node := FinderRec.node.PrevSibling; //vtrPregledPat.GetFirstSelected().PrevSibling;
      end;
    end;

  end;

  if node = nil then
  begin
    vtrPregledPat.Repaint;
    FinderRec.IsFinded := False;
    FinderRec.node := nil;
    Exit;
  end;

  Result := FindNodeRepeat(DirectionFind, ACol);

  if (not Result) and (FinderRec.IsFinded) then // до сега е имало намерено, и вече няма.
  begin
    case DirectionFind of
      dfForward: // намирано е напред. Затова се връщам на първия възел и търся първия след него от съответния тип
      begin
        node := vtrPregledPat.RootNode.FirstChild; //pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);
        data := pointer(PByte(node) + lenNode);
        while data.vid <> FinderRec.vid do
        begin
          node := pointer(PByte(node) + LenData);
          data := pointer(PByte(node) + lenNode);
        end;
        result := FindNodeRepeat(dfForward, ACol);
      end;
      dfBackward: // намирано е назад. Затова се отивам на последния възел и търся първия преди него от съответния тип
      begin
        node := vtrPregledPat.RootNode.FirstChild.LastChild; //pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);
        data := pointer(PByte(node) + lenNode);
        while data.vid <> FinderRec.vid do
        begin
          node := pointer(PByte(node) - LenData);
          data := pointer(PByte(node) + lenNode);
        end;
        result := FindNodeRepeat(dfBackward, ACol);
      end;
    end;
  end;

  FinderRec.IsFinded := Result;
end;

function TfrmSuperHip.FindNodevtrTemp(DirectionFind: TDirectionFinder;
  ACol: TColumnIndex): boolean;
var
  node: PVirtualNode;
  data: PAspRec;

  function FindNodeRepeat(DirectionFind: TDirectionFinder; ACol: TColumnIndex): boolean;
  var
    SaveNode: PVirtualNode;
    prefix: string;
    ArrStr: TArray<string>;
    StrNumber: Integer;
  begin
    SaveNode := node;
    Result := False;
    prefix := Copy(vtrtemp.Header.Columns[ACol].Text, 1, vtrtemp.Header.Columns[ACol].Tag);

    while node <> nil do
    begin
      data := vtrtemp.GetNodeData(node);
      if data.vid = FinderRecMKB.vid then
      begin
        case data.vid of
          vvMkb:
          begin
            case ACol of
              0:
              begin
                if AnsiUpperCase(vtrtemp.Text[node, ACol]).Contains(AnsiUpperCase(prefix + FinderRecMKB.strSearch)) then
                begin
                  vtrtemp.Selected[node] := True;
                  vtrtemp.RepaintNode(node);
                  FinderRecMKB.node := node;
                  //vtrPregledPat.FocusedNode := node;
                  Result  := True;
                  Break;
                end;
              end;
              1:
              begin
                //ArrStr := vtrtemp.Text[node, ACol].Split(['']);
                StrNumber := vtrtemp.Header.Columns[ACol].Tag;
                if AnsiUpperCase(vtrtemp.Text[node, ACol]).Contains(AnsiUpperCase(FinderRecMKB.strSearch)) then
                begin
                  vtrtemp.Selected[node] := True;
                  vtrtemp.RepaintNode(node);
                  FinderRecMKB.node := node;
                  //vtrPregledPat.FocusedNode := node;
                  Result  := True;
                  Break;
                end;
              end;
            end;
          end;
        end;

      end;
      case DirectionFind of
        dfForward,dfNone:
        begin
          if node.NextSibling <> nil then
          begin
            node := node.NextSibling;
          end
          else
          begin  //  мкб-тата в подгрупата са свършили.
            if node.Parent.NextSibling = nil then //Ако и подгрупата е последна, ще трябва да иде на следващата група.
            begin
              if node.Parent.parent.NextSibling = nil then // като свършат и групите да се върне на първата група, на първата подгрупа...
              begin
                node := node.Parent.parent.Parent.FirstChild.FirstChild.FirstChild;
              end
              else
              begin
                node := node.Parent.parent.NextSibling.FirstChild.FirstChild;
              end;
            end
            else// не е последна подгрупа
            begin
              node := node.Parent.NextSibling.FirstChild;
            end;
          end;
        end;
        dfBackward:
        begin
          if node.PrevSibling <> nil then
          begin
            node := node.PrevSibling;
          end
          else
          begin  //  мкб-тата в подгрупата са свършили.
            if node.Parent.PrevSibling = nil then //Ако и подгрупата е първата, ще трябва да иде на предната група.
            begin
              if node.Parent.parent.PrevSibling = nil then // като свършат и групите да отиде на последнат група, на последната подгрупа...
              begin
                node := node.Parent.parent.Parent.LastChild.LastChild.LastChild;
              end
              else
              begin
                node := node.Parent.parent.PrevSibling.LastChild.LastChild;
              end;
            end
            else// не е ппървата подгрупа
            begin
              node := node.Parent.PrevSibling.LastChild;
            end;
          end;
        end;
      end;

      if node = SaveNode then Break;
    end;
  end;
begin
  if FinderRecMKB.strSearch = '' then
  begin
    vtrtemp.Repaint;
    FinderRecMKB.IsFinded := False;
    FinderRecMKB.node := nil;
    Exit;
  end;
  case DirectionFind of
    dfNone: node := FinderRecMKB.node;
    dfForward:
    begin
      //node :=  FinderRecMKB.node.NextSibling;
      if FinderRecMKB.node.NextSibling <> nil then
      begin
        node := FinderRecMKB.node.NextSibling;
      end
      else
      begin  //  мкб-тата в подгрупата са свършили.
        if FinderRecMKB.node.Parent.NextSibling = nil then //Ако и подгрупата е последна, ще трябва да иде на следващата група.
        begin
          if FinderRecMKB.node.Parent.parent.NextSibling = nil then // като свършат и групите да се върне на първата група, на първата подгрупа...
          begin
            node := FinderRecMKB.node.Parent.parent.Parent.FirstChild.FirstChild.FirstChild;
          end
          else
          begin
            node := FinderRecMKB.node.Parent.parent.NextSibling.FirstChild.FirstChild;
          end;
        end
        else// не е последна подгрупа
        begin
          node :=FinderRecMKB.node.Parent.NextSibling.FirstChild;
        end;
      end;
    end;
    dfBackward:
    begin
      if  vtrtemp.GetFirstSelected() = vtrtemp.RootNode.FirstChild.FirstChild then
      begin
        node := vtrtemp.RootNode.FirstChild.FirstChild.LastChild;
      end
      else
      begin
        node := FinderRecMKB.node.PrevSibling; //vtrPregledPat.GetFirstSelected().PrevSibling;
      end;
    end;

  end;

  if node = nil then
  begin
    vtrtemp.Repaint;
    FinderRecMKB.IsFinded := False;
    FinderRecMKB.node := nil;
    Exit;
  end;

  Result := FindNodeRepeat(DirectionFind, ACol);

  if (not Result) and (FinderRecMKB.IsFinded) then // до сега е имало намерено, и вече няма.
  begin
    case DirectionFind of
      dfForward: // намирано е напред. Затова се връщам на първия възел и търся първия след него от съответния тип
      begin
        node := vtrTemp.RootNode.FirstChild; //pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);
        data := pointer(PByte(node) + lenNode);
        while data.vid <> FinderRecMKB.vid do
        begin
          node := pointer(PByte(node) + LenData);
          data := pointer(PByte(node) + lenNode);
        end;
        result := FindNodeRepeat(dfForward, ACol);
      end;
      dfBackward: // намирано е назад. Затова се отивам на последния възел и търся първия преди него от съответния тип
      begin
        node := vtrTemp.RootNode.FirstChild.LastChild; //pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);
        data := pointer(PByte(node) + lenNode);
        while data.vid <> FinderRecMKB.vid do
        begin
          node := pointer(PByte(node) - LenData);
          data := pointer(PByte(node) + lenNode);
        end;
        result := FindNodeRepeat(dfBackward, ACol);
      end;
    end;
  end;

  FinderRecMKB.IsFinded := Result;
end;

procedure TfrmSuperHip.FindOldItemsForInsert;
var
  data: PAspRec;
  linkPos, FPosLinkData: Cardinal;
  pCardinalData: PCardinal;
  bufLink: Pointer;
  RunNode: PVirtualNode;

begin
  bufLink := AspectsLinkPatPregFile.Buf;
  linkPos := 100;
  pCardinalData := pointer(PByte(bufLink));
  FPosLinkData := pCardinalData^;
  while linkpos < FPosLinkData do
  begin
    RunNode := pointer(PByte(bufLink) + linkpos);
    if vsDeleting in RunNode.States then
    begin
      Inc(linkPos, LenData);
      Continue;
    end;
    data := pointer(PByte(RunNode) + lenNode);
    case data.vid of
      vvPregled:
      begin
        if Adb_DM.CollPregled.getIntMap(data.DataPos, word(PregledNew_ID)) = 0 then
        begin
          Adb_DM.ListPregledLinkForInsert.Add(RunNode);
        end;
      end;
    end;
    Inc(linkPos, LenData);
  end;
end;

function TfrmSuperHip.FindPatientByDataPos(datapos: cardinal): PVirtualNode;
var
  bufLink, BufADB: Pointer;
  i, iVid: Integer;
  linkPos: Cardinal;
  pCardinalData: ^Cardinal;
  FPosLinkData: Cardinal;
  FPosDataADB: Cardinal;
  data: PAspRec;

  node, patNode: PVirtualNode;
  dataPat: PAspRec;
begin
  Result := nil;
  bufLink := AspectsLinkPatPregFile.Buf;
  BufADB := Adb_DM.AdbMain.Buf;
  linkPos := 100;
  pCardinalData := pointer(PByte(bufLink));
  FPosLinkData := pCardinalData^;
  pCardinalData := pointer(PByte(BufADB) + 8);
  FPosDataADB := pCardinalData^;
  node := pointer(PByte(bufLink) + linkpos);
  data := pointer(PByte(node) + lenNode);

  node := pointer(PByte(bufLink) + 100);

  patNode := node.FirstChild;
  while patNode <> nil do // loop pat
  begin
    dataPat := pointer(PByte(patNode) + lenNode);
    if dataPat.DataPos = datapos then
    begin
      Result := patNode;
      Exit;
    end;
    patNode := patNode.NextSibling;
  end;
end;

procedure TfrmSuperHip.FireMonkeyContainer1CreateFMXForm(var Form: TCommonCustomForm);
begin
  //
end;

procedure TfrmSuperHip.fmxCntr1CreateFMXForm(var Form: TCommonCustomForm);
begin
  //if not Assigned(Form) then Form := TfrmStatusItem.Create(nil);
end;

procedure TfrmSuperHip.fmxCntrButtonsCreateFMXForm(var Form: TCommonCustomForm);
begin
  //if not Assigned(Form) then Form := TfrmFMXButtons.Create(nil);
end;

procedure TfrmSuperHip.fmxCntrDynActivateForm(Sender: TObject);
begin
  //tmr1.Enabled := true;
end;

procedure TfrmSuperHip.fmxCntrDynCreateFMXForm(var Form: TCommonCustomForm);
begin
  Exit;
  if not Assigned(Form) then
  begin
    FmxWScreen := TfrmWelcomeScreen.Create(nil);
    Form := FmxWScreen;

  end;
end;

procedure TfrmSuperHip.fmxCntrDynDestroyFMXForm(var Form: TCommonCustomForm; var Action: TCloseHostedFMXFormAction);
begin
  Action := fcaFree;
  FreeAndNil(form);
end;



procedure TfrmSuperHip.fmxCntrDynDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TfrmSuperHip.fmxCntrRoleBarCreateFMXForm(var Form: TCommonCustomForm);
begin
  if not Assigned(Form) then
  begin
    FmxRoleBar := TfrmRoleBar.Create(nil);
    FmxRoleBar.OnProgres := RoleBarOnProgres;
    FmxRoleBar.OnBtnRoleClick := RoleBarBtnRoleClick;
    FmxRoleBar.WidthBarClosed := 60;
    pnlRoleBar.Width := 60;
    fmxCntrRoleBar.Width := 60;
    FmxRoleBar.WidthBarExpand := 300;
    FmxRoleBar.FillRollBar;
    //FmxRoleBar.OnMinimizeApp := MinimizeApp;
    //FmxRoleBar.OnRestoreApp := RestoreApp;
    //FmxRoleBar.OnTitleMouseDown := MouseTitleDown;
    //FmxRoleBar.OnTitleDblClick := RestoreApp;
    Form := FmxRoleBar;

  end;
end;

procedure TfrmSuperHip.fmxCntrRoleSelectCreateFMXForm(
  var Form: TCommonCustomForm);
begin
  if not Assigned(Form) then
  begin
    FmxRolePanel := TfrmRolePanels.Create(nil);
    //FmxRoleBar.OnMinimizeApp := MinimizeApp;
    //FmxRoleBar.OnRestoreApp := RestoreApp;
    //FmxRoleBar.OnTitleMouseDown := MouseTitleDown;
    //FmxRoleBar.OnTitleDblClick := RestoreApp;
    Form := FmxRolePanel;

  end;
end;

procedure TfrmSuperHip.fmxCntrTitleBarCreateFMXForm(
  var Form: TCommonCustomForm);
begin
  if not Assigned(Form) then
  begin
    FmxTitleBar := TfrmTitlebar.Create(nil);
    FmxTitleBar.OnCloseApp := CloseApp;
    FmxTitleBar.OnMinimizeApp := MinimizeApp;
    FmxTitleBar.OnRestoreApp := RestoreApp;
    FmxTitleBar.OnTitleMouseDown := MouseTitleDown;
    FmxTitleBar.OnTitleDblClick := RestoreApp;
    FmxTitleBar.OnDBClick := MenuTitleDBClick;
    FmxTitleBar.OnLoadDBClick := MenuTitleLoadDBClick;


    FmxTitleBar.mniProf.OnClick := MenuTitleProfGrafClick;
    FmxTitleBar.mniJurnalNzis.OnClick := mniJurnalNzisClick;
    FmxTitleBar.OnSetingsClick := TitleSetingsClick;
    FmxTitleBar.OnHelpClick := HelpClick;
    FmxTitleBar.miListICD.OnClick := miListICDClick;
    FmxTitleBar.miListDoctor.OnClick := miListDoctorClick;
    FmxTitleBar.mniSetings.OnClick := mniSetingsClick;
    FmxTitleBar.miListAnalysis.OnClick := miListAnalysisClick;
    FmxTitleBar.mniNzisNomen.OnClick :=mniNzisNomenClick;
    FmxTitleBar.mniNasMesto.OnClick := mniNasMestoClick;
    FmxTitleBar.miMainExamination.OnClick :=miMainExaminationClick;
    FmxTitleBar.mniDbTables.OnClick :=mniDbTablesClick;
    FmxTitleBar.mniImportNzis.OnClick :=mniImportNzisClick;
    Form := FmxTitleBar;

  end;
end;

procedure TfrmSuperHip.FormatText(Sender: TObject; var Text: XMLString; TextType: TElXMLTextType; Level: Integer; const Path: XMLString);
var
  s: XMLString;
  i: Integer;
begin
  if (TextType = ttBase64) and (Length(Text) > 64) then
  begin
    s := #10;
    while Length(Text) > 0 do
    begin
      s := s + Copy(Text, 1, 64) + #10;
      Delete(Text, 1, 64);
    end;

    for i := 0 to Level - 3 do
      s := s + #9;

    Text := s;
  end;
end;

procedure TfrmSuperHip.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  if thrSearch <> nil then
    thrSearch.IsClose := true;
  if thrHistPerf <> nil then
    thrHistPerf.stop := true;
  //if thrAspPerf <> nil then
//    thrAspPerf.stop := true;
  chkAutamatL009.Checked := False;
end;

procedure TfrmSuperHip.HelpClick(Sender: TObject);
begin
  SendMessage(Handle, WM_SYSCOMMAND, SC_CONTEXTHELP, 0);
end;

procedure TfrmSuperHip.HideTabs;
begin
  Exit;
  tsNomenNzis.TabVisible := False;
  tsTreePat.TabVisible := False;
  tsTreePregledi.TabVisible := False;
  tsTreeRole.TabVisible := False;
  tsDynPanel.TabVisible := False;
  tsMinaliPregledi.TabVisible := False;
  tsTestFilter.TabVisible := False;
  tsMemo.TabVisible := False;
  tsPdf.TabVisible := False;
  tsSpisaci.TabVisible := False;
  tsRTF.TabVisible := False;
  tsVideo.TabVisible := False;
  tsTest.TabVisible := False;
  tsExcel.TabVisible := False;
  tsGrid.TabVisible := False;
  tsVTR_XML.TabVisible := False;
  tsTreeDBFB.TabVisible := False;
  tsTempVTR.TabVisible := False;
  tsGraph.TabVisible := False;
  tsFMXForm.TabVisible := False;
  tsXML.TabVisible := False;
  tsOptionsNotes.TabVisible := False;
  tsNZIS.TabVisible := False;
  tsExpression.TabVisible := False;
  tsNomenAnal.TabVisible := False;
  tsOptions.TabVisible := False;
  tsVtrSearch.TabVisible := False;
  tsVTRDoctors.TabVisible := False;
  tsProfReg.TabVisible := False;


  Panel1.Visible := False;
end;
procedure TfrmSuperHip.OnDataNzis(Sender: TObject; Buffer: Pointer; Size: Integer);
begin
   StreamData.Write(Buffer, Size);
end;

//procedure TfrmSuperHip.OnEditPregled(Sender: TObject);
//var
//  preg: TRealPregledNewItem;
//
//begin
//  if edtCertNom.Text = '' then
//  begin
//    try
//      try
//        FillCertInDoctors;
//        if CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
//        begin
//          edtCertNom.Text := BuildHexString(CollDoctor.Items[0].Cert.SerialNumber);
//          CollDoctor.Items[0].Cert.Clone(CertForThread);
//          CollDoctor.Items[0].Cert.Clone(CurrentCert);
//          GetTokenThread;
//          //if edtToken.Text = '' then
////          begin
////            httpNZIS.OnData := httpNZISDataToken;
////            httpNZIS.Close;
////            httpNZIS.Get('https://auth.his.bg/token');
////            ReadToken(ResultNzisToken.Text);
////          end;
////          if edtToken.Text <> '' then
////          begin
////            preg := TRealPregledNewItem(Sender);
////            //FmxProfForm.animNrnStatus.Enabled := true;
////            //FmxProfForm.animNrnStatus.Start;
////            EditPregX009(preg.FNode);
////          end;
//        end
//        else // Не е намерен подпис за доктора
//        begin
//          // zzzzzzzzzzzzz
//        end;
//      except
//        Exit;
//      end;
//    finally
//      //FmxProfForm.animNrnStatus.Enabled := False;
//      //FmxProfForm.animNrnStatus.stop;
////      FmxProfForm.linStatusNRN.Opacity := 1;
////      FmxProfForm.edtAmbList.Repaint;
//    end;
//  end
//  else
//  begin
//    try
//      try
//        if CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
//        begin
//          if CurrentCert = nil then
//            CurrentCert := TelX509Certificate.Create(self);
//          CollDoctor.Items[0].Cert.Clone(CertForThread);
//          CollDoctor.Items[0].Cert.Clone(CurrentCert);
//        end
//        else
//        begin
//          edtCertNom.Text := '';
//          Exit;
//        end;
//        if edtToken.Text = '' then
//        begin
//          httpNZIS.OnData := httpNZISDataToken;
//          httpNZIS.Close;
//          httpNZIS.Get('https://auth.his.bg/token');
//          ReadToken(ResultNzisToken.Text);
//        end;
//        if edtToken.Text <> '' then
//        begin
//          preg := TRealPregledNewItem(Sender);
//          //FmxProfForm.animNrnStatus.Enabled := true;
//          //FmxProfForm.animNrnStatus.Start;
//          EditPregX009(preg.FNode);
//        end;
//      except
//        Exit;
//      end;
//    finally
//      //FmxProfForm.animNrnStatus.Enabled := False;
//      //FmxProfForm.animNrnStatus.Stop;
////      FmxProfForm.linStatusNRN.Opacity := 1;
////      FmxProfForm.edtAmbList.Repaint;
//    end;
//  end;
//end;

procedure TfrmSuperHip.OnEditPregled1(Sender: TObject);
var
  preg: TRealPregledNewItem;
begin
  preg := TRealPregledNewItem(Sender);
  EditPregX009(preg.FNode);
end;

procedure TfrmSuperHip.OnFmxHint(Sender: TObject; Hint: string; r: TRect);
var
  hntWin: TCustomHintWindow;
begin
  Exit;
  if (Sender <> nil) and (Hint <> '') then
  begin
    hntMain.Title := Hint;

    hntMain.Description := 'Lorem Ipsum is simply dummy text of the' + #13#10 + 'printing and typesetting industry. Lorem Ipsum has ' + #13#10 + 'been the industrys standard dummy text ever since the 1500s, when an unknown printer took a ' + #13#10 + 'galley of type and scrambled i' + #13#10 ;
    hntMain.ShowHint(r);
  end
  else
  begin
    hntMain.HideHint;
  end;
end;

procedure TfrmSuperHip.OnGetPlanedTypeL009(Sender: TObject);
var
  preg: TRealPregledNewItem;
begin
  if edtCertNom.Text = '' then
  begin
    try
      try
        FillCertInDoctors;
        if Adb_DM.CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          edtCertNom.Text := BuildHexString(Adb_DM.CollDoctor.Items[0].Cert.SerialNumber);
          Adb_DM.CollDoctor.Items[0].Cert.Clone(CertForThread);
          Adb_DM.CollDoctor.Items[0].Cert.Clone(CurrentCert);
          GetTokenNzis(Sender);
          if edtToken.Text <> '' then
          begin
            preg := TRealPregledNewItem(Sender);
            GetPlanedTypeL009(preg.FNode);
          end;
        end
        else // Не е намерен подпис за доктора
        begin
          // zzzzzzzzzzzzz
        end;
      except
        Exit;
      end;
    finally

    end;
  end
  else
  begin
    try
      try
        if Adb_DM.CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          if CurrentCert = nil then
            CurrentCert := TelX509Certificate.Create(self);
          Adb_DM.CollDoctor.Items[0].Cert.Clone(CertForThread);
          Adb_DM.CollDoctor.Items[0].Cert.Clone(CurrentCert);
        end
        else
        begin
          edtCertNom.Text := '';
          Exit;
        end;
         GetTokenNzis(Sender);
        if edtToken.Text <> '' then
        begin
          preg := TRealPregledNewItem(Sender);
          GetPlanedTypeL009(preg.FNode);
        end;
      except
        Exit;
      end;
    finally

    end;
  end;
end;

procedure TfrmSuperHip.OnGetPlanedTypeL009_1(Sender: TObject);
var
  preg: TRealPregledNewItem;
begin
  preg := TRealPregledNewItem(Sender);
  GetPlanedTypeL009(preg.FNode);
end;

//procedure TfrmSuperHip.OnGetTextDyn(sender: TObject; tableType: word; field: Word; row: Integer; var value: string);
//var
//  PregledNew: TPregledNewItem;
//  prop: TPregledNewItem.TPropertyIndex;
//begin
//  case tableType of
//    word(PREGLED):
//    begin
//     // ACol := TVirtualModeData(Sender).IndexOf(AColumn);
//      //if CollPregled.Count = 0 then Exit;
//      PregledTemp.DataPos := tsFMXForm.Tag;
//      Value := Trim(PregledTemp.getAnsiStringMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, field));
//      //fmxFormDyn.mdyn1.Height := 5;
//
//
//
//      //PregledNew := CollPregled.Items[row];
////      prop := TPregledNewItem.TPropertyIndex(field);
////      if Assigned(PregledNew.PRecord) and (prop in PregledNew.PRecord.setProp) then
////      begin
////         CollPregled.GetCellFromRecord(field, PregledNew, Value);
////      end
////      else
////      begin
////        CollPregled.GetCellFromMap(field, Row, PregledNew, Value);
////      end;
//    end;
//    word(PACIENT):
//    begin
//
//      Value := Trim(PatientTemp.getAnsiStringMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, field));
//
//    end;
//  end;
//end;

procedure TfrmSuperHip.OnIndexedPregled(Sender: TObject);
begin
  IsIndexedPregled := True;
end;

procedure TfrmSuperHip.OnOfLinePregled(Sender: TObject);
var
  preg: TRealPregledNewItem;
  oldStatus: Word;
begin
  if edtCertNom.Text = '' then
  begin
    try
      try
        FillCertInDoctors;
        if Adb_DM.CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          edtCertNom.Text := BuildHexString(Adb_DM.CollDoctor.Items[0].Cert.SerialNumber);
          Adb_DM.CollDoctor.Items[0].Cert.Clone(CertForThread);
          Adb_DM.CollDoctor.Items[0].Cert.Clone(CurrentCert);
          GetTokenNzis(sender);
          //if edtToken.Text = '' then
//          begin
//            httpNZIS.OnData := httpNZISDataToken;
//            httpNZIS.Close;
//            try
//              httpNZIS.Get('https://auth.his.bg/token');
//              ReadToken(ResultNzisToken.Text);
//            except
//              //preg := TRealPregledNewItem(Sender);
////              oldStatus := CollPregled.GetWordMap(preg.DataPos, word(PregledNew_NZIS_STATUS));
////              if oldStatus < 100 then
////              begin
////                CollPregled.SetWordMap(preg.DataPos, word(PregledNew_NZIS_STATUS),oldStatus + 100);
////              end;
//            end;
//          end;
          if edtToken.Text <> '' then
          begin
            preg := TRealPregledNewItem(Sender);
            OfLinePregX013(preg.FNode);
          end;
        end
        else // Не е намерен подпис за доктора
        begin
          // zzzzzzzzzzzzz
        end;
      except
        Exit;
      end;
    finally
    end;
  end
  else
  begin
    try
      try
        if Adb_DM.CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          if CurrentCert = nil then
            CurrentCert := TelX509Certificate.Create(self);
          Adb_DM.CollDoctor.Items[0].Cert.Clone(CertForThread);
          Adb_DM.CollDoctor.Items[0].Cert.Clone(CurrentCert);
        end
        else
        begin
          edtCertNom.Text := '';
          Exit;
        end;
        GetTokenNzis(sender);
        //if edtToken.Text = '' then
//        begin
//          httpNZIS.OnData := httpNZISDataToken;
//          httpNZIS.Close;
//          try
//            httpNZIS.Get('https://auth.his.bg/token');
//            ReadToken(ResultNzisToken.Text);
//          except
//            //preg := TRealPregledNewItem(Sender);
////            oldStatus := CollPregled.GetWordMap(preg.DataPos, word(PregledNew_NZIS_STATUS));
////            if oldStatus < 100 then
////            begin
////              CollPregled.SetWordMap(preg.DataPos, word(PregledNew_NZIS_STATUS),oldStatus + 100);
////            end;
//          end;
//        end;
        if edtToken.Text <> '' then
        begin
          preg := TRealPregledNewItem(Sender);
          OfLinePregX013(preg.FNode);
        end;
      except
        Exit;
      end;
    finally
    end;
  end;
end;

procedure TfrmSuperHip.OnOpenPregled(Sender: TObject);
var
  preg: TRealPregledNewItem;
begin
  if edtCertNom.Text = '' then
  begin
    try
      try
        FillCertInDoctors;
        if Adb_DM.CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          edtCertNom.Text := BuildHexString(Adb_DM.CollDoctor.Items[0].Cert.SerialNumber);
          Adb_DM.CollDoctor.Items[0].Cert.Clone(CertForThread);
          Adb_DM.CollDoctor.Items[0].Cert.Clone(CurrentCert);
          GetTokenNzis(Sender);
          if edtToken.Text <> '' then
          begin
            preg := TRealPregledNewItem(Sender);
            //FmxProfForm.animNrnStatus.Enabled := true;
            //FmxProfForm.animNrnStatus.Start;
            OpenPregX001(preg.FNode);
          end;
        end
        else // Не е намерен подпис за доктора
        begin
          // zzzzzzzzzzzzz
        end;
      except
        Exit;
      end;
    finally
      //FmxProfForm.animNrnStatus.Enabled := False;
      //FmxProfForm.animNrnStatus.stop;
      //FmxProfForm.linStatusNRN.Opacity := 1;
//      FmxProfForm.edtAmbList.Repaint;
    end;
  end
  else
  begin
    try
      try
        if Adb_DM.CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          if CurrentCert = nil then
            CurrentCert := TelX509Certificate.Create(self);
          Adb_DM.CollDoctor.Items[0].Cert.Clone(CertForThread);
          Adb_DM.CollDoctor.Items[0].Cert.Clone(CurrentCert);
        end
        else
        begin
          edtCertNom.Text := '';
          Exit;
        end;
         GetTokenNzis(Sender);
        if edtToken.Text <> '' then
        begin
          preg := TRealPregledNewItem(Sender);
          //FmxProfForm.animNrnStatus.Start;
          //FmxProfForm.animNrnStatus.Enabled := true;
          OpenPregX001(preg.FNode);
        end;
      except
        Exit;
      end;
    finally
      //FmxProfForm.animNrnStatus.Enabled := False;
      //FmxProfForm.linStatusNRN.Opacity := 1;
      //FmxProfForm.edtAmbList.Repaint;
    end;
  end;
end;

procedure TfrmSuperHip.OnOpenPregled1(Sender: TObject);
var
  preg: TRealPregledNewItem;
begin
  preg := TRealPregledNewItem(Sender);
  OpenPregX001(preg.FNode);
end;

procedure TfrmSuperHip.OnProcess(streamSize, streamPos: integer);
begin
  Inc(CounterObj);
end;

procedure TfrmSuperHip.OnSetTextSearch(Sender: TObject);
var
  edt: fmx.Edit.TEdit;
  //dtEdt: DateEditDyn.TDateEditDyn;
begin
  //Stopwatch := TStopwatch.StartNew;
//  if (Sender is fmx.Edit.TEdit) then
//  begin
//    edt := fmx.Edit.TEdit(Sender);
//    OnSetTextSearchEDT(edt);
//  end
//  else
//  if (Sender is DateEditDyn.TDateEditDyn) then
//  begin
//    dtEdt := DateEditDyn.TDateEditDyn(Sender);
//    OnSetTextSearchDTEDT(dtEdt);
//  end


end;



procedure TfrmSuperHip.OnSetTextSearchEDT(Vid: TVtrVid; Text: string; field: Word; Condition: TConditionSet);
begin
Exit;
  Stopwatch := TStopwatch.StartNew;
  case Vid of
    vvPatient:
    begin
      Adb_DM.CollPatient.OnSetTextSearchEDT(Text, field, Condition);
      thrSearch.start;
    end;
    vvPregled:
    begin
      if Text = '' then
      begin
        //Exclude(CollPregForSearch.PRecordSearch.setProp, TPregledNewItem.TPropertyIndex(edt.Field));
      end
      else
      begin
        //include(CollPregForSearch.PRecordSearch.setProp, TPregledNewItem.TPropertyIndex(edt.Field));
      end;
      //CollPregForSearch.PRecordSearch.ANAMN  :=  AnsiUpperCase(Text);
      thrSearch.start;
    end;
  end;
end;

procedure TfrmSuperHip.OnShowFindFprm(Sender: TObject);
var
  i: Integer;
  act: TAspectTypeKind;
  edt: FMX.Edit.TEdit;
  logPat: TLogicalPatientNew;
  expPat: TExpander;
begin
  //FmxFinderFrm.ArrCondition := CollPatient.ListForFDB.Items[0].ArrCondition;
//  FmxFinderFrm.AddExpander(0, nil);
end;

procedure TfrmSuperHip.OnShowGridSearch(sender: TObject);
begin
  //Elapsed := Stopwatch.Elapsed;
  //mmoTest.Lines.Add( Format('loopSearch за %f',[Elapsed.TotalMilliseconds]));
  SendMessage(Self.Handle, WM_SHOW_GRID, 0, 0);
end;

procedure TfrmSuperHip.OpenADB(ADB: TMappedFile);
var
  collType: TCollectionsType;
  aspVersion: Word;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  pg: PGUID;
  mkb: TMkbItem;
begin
  mmoTest.Lines.BeginUpdate;
  Stopwatch := TStopwatch.StartNew;
  if ADB.Buf <> nil then
  begin
    pCardinalData := pointer(PByte(ADB.Buf));
    ADB.FPosMetaData := pCardinalData^;
    pCardinalData := pointer(PByte(ADB.Buf) + 4);
    ADB.FLenMetaData := pCardinalData^;
    pCardinalData := pointer(PByte(ADB.Buf) + 8);
    ADB.FPosData := pCardinalData^;
    pCardinalData := pointer(PByte(ADB.Buf) + 12);
    ADB.FLenData := pCardinalData^;
    Pg := pointer(PByte(ADB.Buf) + 16 );
    ADB.GUID := pg^;
    mmoTest.Lines.Add(pg^.ToString);
    mmoTest.Lines.Add(inttostr(SizeOf(tguid)));

    aspPos := ADB.FPosMetaData;
    while aspPos < (ADB.FPosMetaData + ADB.FLenMetaData) do
    begin
      p := Pointer(pbyte(ADB.Buf) + aspPos);
      collType := TCollectionsType(p^);
      inc(aspPos, 2);

      p := Pointer(pbyte(ADB.Buf) + aspPos);
      aspVersion := word(p^);
      inc(aspPos, 2);

      case collType of // в зависимост от това какъв е типа на колекцията.
        ctPractica:
        begin
          Adb_DM.CollPractica.OpenAdbFull(aspPos);
        end;
        ctPregledNew:
        begin
          Inc(aspPos, (Adb_DM.CollPregled.FieldCount) * 4);
          Adb_DM.CollPregled.IncCntInADB;
        end;
        ctPatientNew:
        begin
          Inc(aspPos, (Adb_DM.CollPatient.FieldCount) * 4);
          Adb_DM.CollPatient.IncCntInADB;
        end;
        ctPatientNZOK:
        begin
          Inc(aspPos, (Adb_DM.CollPatPis.FieldCount) * 4);
          Adb_DM.CollPatPis.IncCntInADB;
        end;
        ctDiagnosis:
        begin
          //CollDiag.OpenAdbFull(aspPos);
          Inc(aspPos, (Adb_DM.CollDiag.FieldCount) * 4);
          Adb_DM.CollDiag.IncCntInADB;
        end;
        ctDiagnosisDel:
        begin
          Inc(aspPos, (Adb_DM.CollDiag.FieldCount) * 4);
        end;
        ctMDN:
        begin
          Inc(aspPos, (Adb_DM.CollMDN.FieldCount) * 4);
          Adb_DM.CollMDN.IncCntInADB;
        end;
        ctDoctor:
        begin
          Adb_DM.CollDoctor.OpenAdbFull(aspPos);
        end;
        ctOtherDoctor:
        begin
          Adb_DM.CollOtherDoctor.OpenAdbFull(aspPos);
        end;
        ctUnfav:
        begin
          Inc(aspPos, (Adb_DM.CollUnfav.FieldCount) * 4);
          Adb_DM.CollUnfav.IncCntInADB;
        end;
        ctUnfavDel:
        begin
          Inc(aspPos, (Adb_DM.CollUnfav.FieldCount) * 4);
        end;
        ctMkb:
        begin
          Adb_DM.CollMkb.OpenAdbFull(aspPos);
        end;
        ctEventsManyTimes:
        begin
          //Inc(aspPos, (CollEventsManyTimes.FieldCount) * 4);
//          CollEventsManyTimes.IncCntInADB;
        end;
        ctExam_boln_list:
        begin
          Inc(aspPos, (Adb_DM.CollEbl.FieldCount) * 4);
          Adb_DM.CollEbl.IncCntInADB;
        end;
        ctExamAnalysis:
        begin
          Inc(aspPos, (Adb_DM.CollExamAnal.FieldCount) * 4);
          Adb_DM.CollExamAnal.IncCntInADB;
        end;
        ctExamImmunization:
        begin
          Inc(aspPos, (Adb_DM.CollExamImun.FieldCount) * 4);
          Adb_DM.CollExamImun.IncCntInADB;
        end;
        ctProcedures:
        begin
          Inc(aspPos, (Adb_DM.ProceduresNomenColl.FieldCount) * 4);
          Adb_DM.ProceduresNomenColl.IncCntInADB;
        end;
        ctKARTA_PROFILAKTIKA2017:
        begin
          Inc(aspPos, (Adb_DM.CollCardProf.FieldCount) * 4);
          Adb_DM.CollCardProf.IncCntInADB;
        end;
        ctBLANKA_MED_NAPR:
        begin
          Inc(aspPos, (Adb_DM.CollMedNapr.FieldCount) * 4);
          Adb_DM.CollMedNapr.IncCntInADB;
        end;
        ctBLANKA_MED_NAPR_3A:
        begin
          Inc(aspPos, (Adb_DM.CollMedNapr3A.FieldCount) * 4);
          Adb_DM.CollMedNapr3A.IncCntInADB;
        end;
        ctHOSPITALIZATION:
        begin
          Inc(aspPos, (Adb_DM.CollMedNaprHosp.FieldCount) * 4);
          Adb_DM.CollMedNaprHosp.IncCntInADB;
        end;
        ctEXAM_LKK:
        begin
          Inc(aspPos, (Adb_DM.CollMedNaprLkk.FieldCount) * 4);
          Adb_DM.CollMedNaprLkk.IncCntInADB;
        end;
        ctINC_MDN:
        begin
          //CollIncMdn.OpenAdbFull(aspPos);
          Inc(aspPos, (Adb_DM.CollIncMdn.FieldCount) * 4);
          Adb_DM.CollIncMdn.IncCntInADB;
        end;
        ctINC_NAPR:
        begin
          //CollIncMdn.OpenAdbFull(aspPos);
          Inc(aspPos, (Adb_DM.CollIncMN.FieldCount) * 4);
          Adb_DM.CollIncMN.IncCntInADB;
        end;
        ctNZIS_PLANNED_TYPE:
        begin
          Inc(aspPos, (Adb_DM.CollNZIS_PLANNED_TYPE.FieldCount) * 4);
          Adb_DM.CollNZIS_PLANNED_TYPE.IncCntInADB;
        end;
        ctNZIS_QUESTIONNAIRE_RESPONSE:
        begin
          Inc(aspPos, (Adb_DM.CollNZIS_QUESTIONNAIRE_RESPONSE.FieldCount) * 4);
          Adb_DM.CollNZIS_QUESTIONNAIRE_RESPONSE.IncCntInADB;
        end;
        ctNZIS_QUESTIONNAIRE_ANSWER:
        begin
          Inc(aspPos, (Adb_DM.CollNZIS_QUESTIONNAIRE_ANSWER.FieldCount) * 4);
          Adb_DM.CollNZIS_QUESTIONNAIRE_ANSWER.IncCntInADB;
        end;
        ctNZIS_DIAGNOSTIC_REPORT:
        begin
          Inc(aspPos, (Adb_DM.CollNZIS_DIAGNOSTIC_REPORT.FieldCount) * 4);
          Adb_DM.CollNZIS_DIAGNOSTIC_REPORT.IncCntInADB;
        end;
        ctNZIS_RESULT_DIAGNOSTIC_REPORT:
        begin
          Inc(aspPos, (Adb_DM.CollNZIS_RESULT_DIAGNOSTIC_REPORT.FieldCount) * 4);
          Adb_DM.CollNZIS_RESULT_DIAGNOSTIC_REPORT.IncCntInADB;
        end;
        ctNZIS_ANSWER_VALUE:
        begin
          Inc(aspPos, (Adb_DM.CollNZIS_ANSWER_VALUE.FieldCount) * 4);
          Adb_DM.CollNZIS_ANSWER_VALUE.IncCntInADB;
        end;
        ctNzisToken:
        begin
          Adb_DM.CollNzisToken.OpenAdbFull(aspPos);
        end;
        ctCertificates:
        begin
          Adb_DM.CollCertificates.OpenAdbFull(aspPos);
        end;
        ctAddres:
        begin
          Inc(aspPos, (FNasMesto.addresColl.FieldCount) * 4);
          FNasMesto.addresColl.IncCntInADB;
        end;
      else
        //raise Exception.Create('Непознат : collType' + TRttiEnumerationType.GetName(collType));
      end;
    end;
  end;

  
  FNasMesto.addresColl.Buf := ADB.Buf;
  FNasMesto.addresColl.posData := ADB.FPosData;


  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('Зареждане за %f',[Elapsed.TotalMilliseconds]));
  mmoTest.Lines.endUpdate;

  CalcStatusDB;
  FDBHelper.AdbHip := ADB;
  FDBHelper.Fdm := Fdm;
  FDBHelper.NasMesto := FNasMesto;
  FDBHelper.Adb_DM := Adb_DM;


  FDBHelper.AdbLink := AspectsLinkPatPregFile;
  Adb_DM.AdbMain := ADB;
  Adb_DM.AdbLink := AspectsLinkPatPregFile;
  Adb_DM.NasMesto := FNasMesto;

end;

procedure TfrmSuperHip.OpenBufNomenHip(FileName: string);
var
  i, j: Integer;
  collType: TCollectionsType;
  aspVersion: Word;
  b: Byte;
  pByteData: ^Byte;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  anal: TAnalsNewItem;

  AInt64: Int64;
begin
  if AspectsNomHipFile <> nil then
    AspectsNomHipFile.Free;
  AspectsNomHipFile := TMappedFile.Create(FileName, false, TGUID.Empty);
  FPosData := AspectsNomHipFile.FPosData;


  if AspectsNomHipFile.Buf <> nil then
  begin
    Adb_DM.CollAnalsNew.Buf := AspectsNomHipFile.Buf;
    Adb_DM.CollAnalsNew.posData := AspectsNomHipFile.FPosData;


    pCardinalData := pointer(PByte(AspectsNomHipFile.Buf));
    FPosMetaData := pCardinalData^;
    pCardinalData := pointer(PByte(AspectsNomHipFile.Buf) + 4);
    FLenMetaData := pCardinalData^;
    pCardinalData := pointer(PByte(AspectsNomHipFile.Buf) + 8);
    FPosData := pCardinalData^;
    pCardinalData := pointer(PByte(AspectsNomHipFile.Buf) + 12);
    FLenData := pCardinalData^;
    aspPos := FPosMetaData;
    begin
      while aspPos < (FPosMetaData + FLenMetaData) do
      begin
        p := Pointer(pbyte(AspectsNomHipFile.Buf) + aspPos);
        collType := TCollectionsType(p^);
        inc(aspPos, 2);

        p := Pointer(pbyte(AspectsNomHipFile.Buf) + aspPos);
        aspVersion := word(p^);
        inc(aspPos, 2);

        case collType of
          ctAnalsNew:
          begin
            anal := TAnalsNewItem(Adb_DM.CollAnalsNew.Add);
            anal.DataPos := aspPos;
            Inc(aspPos, (Adb_DM.CollAnalsNew.FieldCount) * 4);
          end;

        end;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.OpenBufNomenNzis(FileName: string);
var
  i, j: Integer;
  collType: TCollectionsType;
  aspVersion: Word;
  b: Byte;
  pByteData: ^Byte;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  //FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  Cl132: TCL132Item;
  CL050: TCL050Item;
  CL006: TCL006Item;
  CL022: TCL022Item;
  CL024: TCL024Item;
  Cl037: TCL037Item;
  CL038: TCL038Item;
  CL088: TCL088Item;
  CL134: TCL134Item;
  CL139: TCL139Item;
  CL142: TCL142Item;
  CL144: TCL144Item;
  PR001: TPR001Item;
  NomenNzis: TNomenNzisItem;
  fileStr: TFileStream;

  AInt64: Int64;
begin
  Stopwatch := TStopwatch.StartNew;
  if AspectsNomFile <> nil then
    Exit;
    //AspectsNomFile.Free;
  try
    AspectsNomFile := TMappedFile.Create(FileName, false, TGUID.Empty);

  except

  end;


  if (AspectsNomFile <> nil) and (AspectsNomFile.Buf <> nil) then
  begin

    pCardinalData := pointer(PByte(AspectsNomFile.Buf));
    AspectsNomFile.FPosMetaData := pCardinalData^;
    pCardinalData := pointer(PByte(AspectsNomFile.Buf) + 4);
    AspectsNomFile.FLenMetaData := pCardinalData^;
    pCardinalData := pointer(PByte(AspectsNomFile.Buf) + 8);
    AspectsNomFile.FPosData := pCardinalData^;
    pCardinalData := pointer(PByte(AspectsNomFile.Buf) + 12);
    AspectsNomFile.FLenData := pCardinalData^;
    aspPos := AspectsNomFile.FPosMetaData;
    begin
      while aspPos < (AspectsNomFile.FPosMetaData + AspectsNomFile.FLenMetaData) do
      begin
        p := Pointer(pbyte(AspectsNomFile.Buf) + aspPos);
        collType := TCollectionsType(p^);
        inc(aspPos, 2);

        p := Pointer(pbyte(AspectsNomFile.Buf) + aspPos);
        aspVersion := word(p^);
        inc(aspPos, 2);

        case collType of
          ctCL132:
          begin
            Cl132 := TCL132Item(Adb_DM.CL132Coll.Add);
            Cl132.DataPos := aspPos;
            Inc(aspPos, (Adb_DM.CL132Coll.FieldCount) * 4);
          end;
          ctCL050:
          begin
            Cl050 := TCL050Item(Adb_DM.CL050Coll.Add);
            Cl050.DataPos := aspPos;
            Inc(aspPos, (Adb_DM.CL050Coll.FieldCount) * 4);
          end;
          ctCL006:
          begin
            Cl006 := TCL006Item(Adb_DM.CL006Coll.Add);
            Cl006.DataPos := aspPos;
            Inc(aspPos, (Adb_DM.CL006Coll.FieldCount) * 4);
          end;
          ctCL022:
          begin
            Cl022 := TCL022Item(Adb_DM.CL022Coll.Add);
            Cl022.DataPos := aspPos;
            Inc(aspPos, (Adb_DM.CL022Coll.FieldCount) * 4);
          end;
          ctCL024:
          begin
            Cl024 := TCL024Item(Adb_DM.CL024Coll.Add);
            Cl024.DataPos := aspPos;
            Inc(aspPos, (Adb_DM.CL024Coll.FieldCount) * 4);
          end;
          ctCL037:
          begin
            Cl037 := TCL037Item(Adb_DM.CL037Coll.Add);
            Cl037.DataPos := aspPos;
            Inc(aspPos, (Adb_DM.CL037Coll.FieldCount) * 4);
          end;
          ctCL038:
          begin
            Cl038 := TCL038Item(Adb_DM.CL038Coll.Add);
            Cl038.DataPos := aspPos;
            Inc(aspPos, (Adb_DM.CL038Coll.FieldCount) * 4);
          end;
          ctCL088:
          begin
            Cl088 := TCL088Item(Adb_DM.CL088Coll.Add);
            Cl088.DataPos := aspPos;
            Inc(aspPos, (Adb_DM.CL088Coll.FieldCount) * 4);
          end;


          ctCL134:
          begin
            Cl134 := TCl134Item(Adb_DM.Cl134Coll.Add);
            Cl134.DataPos := aspPos;
            Inc(aspPos, (Adb_DM.Cl134Coll.FieldCount) * 4);
          end;
          ctCL139:
          begin
            Cl139 := TCl139Item(Adb_DM.Cl139Coll.Add);
            Cl139.DataPos := aspPos;
            Inc(aspPos, (Adb_DM.Cl139Coll.FieldCount) * 4);
          end;
          ctCL142:
          begin
            Cl142 := TCl142Item(Adb_DM.Cl142Coll.Add);
            Cl142.DataPos := aspPos;
            Inc(aspPos, (Adb_DM.Cl142Coll.FieldCount) * 4);
          end;
          ctCL144:
          begin
            Cl144 := TRealCl144Item(Adb_DM.Cl144Coll.Add);
            Cl144.DataPos := aspPos;
            Inc(aspPos, (Adb_DM.Cl144Coll.FieldCount) * 4);
          end;

          ctPR001:
          begin
            PR001 := TPR001Item(Adb_DM.PR001Coll.Add);
            PR001.DataPos := aspPos;
            Inc(aspPos, (Adb_DM.PR001Coll.FieldCount) * 4);
          end;

          ctNomenNzis:
          begin
            //NomenNzis := TNomenNzisItem(NomenNzisColl.Add);
            //NomenNzis.DataPos := aspPos;
            Inc(aspPos, (Adb_DM.NomenNzisColl.FieldCount) * 4);
          end;
        end;
      end;
    end;
  end
  else
  begin
    fileStr := TFileStream.Create(FileName, fmCreate);
    fileStr.Size := 20000000;
    fileStr.Free;
    AspectsNomFile := TMappedFile.Create(FileName, True, TGUID.Empty);
  end;



  Adb_DM.AdbNomenNzis := AspectsNomFile;
  FDBHelper.AdbNomenNzis := AspectsNomFile;


  OpenCmdNomenNzis(AspectsNomFile);

  Elapsed := Stopwatch.Elapsed;
  mmoTest.lines.add(Format('зареждане от Nom: %f', [Elapsed.TotalMilliseconds]));
end;

procedure TfrmSuperHip.OpenCmd(ADB: TMappedFile);
var
  fileName, fileNameTemp: string;
begin

  fileName := ADB.FileName.Replace('.adb', '.cmd');

  if TFile.Exists (fileName) then
  begin
    streamCmdFile := TFileCMDStream.Create(fileName, fmOpenReadWrite + fmShareDenyNone);
    FDBHelper.cmdFile := streamCmdFile;
    Adb_DM.CollPregled.cmdFile := streamCmdFile;
    Adb_DM.CollDoctor.cmdFile := streamCmdFile;
    Adb_DM.CollNZIS_ANSWER_VALUE.cmdFile := streamCmdFile;
    Adb_DM.CollNzis_RESULT_DIAGNOSTIC_REPORT.cmdFile := streamCmdFile;
    Adb_DM.CollNZIS_DIAGNOSTIC_REPORT.cmdFile := streamCmdFile;
  end
  else
  begin
    streamCmdFile := TFileCmdStream.Create(fileName, fmCreate);
    streamCmdFile.Size := 100;
  end;
  streamCmdFile.Position := streamCmdFile.Size;

  fileNameTemp := ADB.FileName.Replace('.adb', '.tmp');
  if TFile.Exists (fileNameTemp) then
  begin
    streamCmdFileTemp := TFileCMDStream.Create(fileNameTemp, fmOpenReadWrite + fmShareDenyNone);
    streamCmdFileTemp.Guid := ADB.GUID;
    //FDBHelper.cmdFile := streamCmdFile;
    //CollPregled.cmdFile := streamCmdFile;
    Adb_DM.CollDoctor.cmdFileTemp := streamCmdFileTemp;
    //CollNZIS_ANSWER_VALUE.cmdFile := streamCmdFile;
//    CollNzis_RESULT_DIAGNOSTIC_REPORT.cmdFile := streamCmdFile;
//    CollNZIS_DIAGNOSTIC_REPORT.cmdFile := streamCmdFile;
  end
  else
  begin
    streamCmdFileTemp := TFileCmdStream.Create(fileNameTemp, fmCreate);

    streamCmdFileTemp.Size := 100;

    Adb_DM.CollDoctor.cmdFileTemp := streamCmdFileTemp;
  end;
  streamCmdFileTemp.Position := streamCmdFileTemp.Size;
  Adb_DM.cmdFile := streamCmdFile;
end;

procedure TfrmSuperHip.OpenCmdNomenNzis(ADBNomenNzis: TMappedFile);
var
  fileName: string;
  TempPos: Cardinal;
begin

  fileName := ADBNomenNzis.FileName.Replace('.adb', '.cmd');

  if TFile.Exists (fileName) then
  begin
    streamCmdFileNomenNzis := TFileCmdStream.Create(fileName, fmOpenReadWrite + fmShareDenyNone);
    streamCmdFileNomenNzis.Position := 0;
    streamCmdFileNomenNzis.Read(TempPos, 4);
    streamCmdFileNomenNzis.AspectDataPos := TempPos;
  end
  else
  begin
    streamCmdFileNomenNzis := TFileCmdStream.Create(fileName, fmCreate + fmShareDenyNone);
    streamCmdFileNomenNzis.AspectDataPos := 0;
    streamCmdFileNomenNzis.Size := 100;
  end;

  streamCmdFileNomenNzis.Position := streamCmdFileNomenNzis.Size;
  Adb_DM.CL006Coll.cmdFile := streamCmdFileNomenNzis;
  Adb_DM.CL022Coll.cmdFile := streamCmdFileNomenNzis;
  Adb_DM.CL024Coll.cmdFile := streamCmdFileNomenNzis;
  Adb_DM.CL037Coll.cmdFile := streamCmdFileNomenNzis;
  Adb_DM.CL038Coll.cmdFile := streamCmdFileNomenNzis;
  Adb_DM.CL050Coll.cmdFile := streamCmdFileNomenNzis;
  Adb_DM.CL088Coll.cmdFile := streamCmdFileNomenNzis;
  Adb_DM.CL132Coll.cmdFile := streamCmdFileNomenNzis;
  Adb_DM.CL134Coll.cmdFile := streamCmdFileNomenNzis;
  Adb_DM.CL139Coll.cmdFile := streamCmdFileNomenNzis;
  Adb_DM.CL142Coll.cmdFile := streamCmdFileNomenNzis;
  Adb_DM.CL144Coll.cmdFile := streamCmdFileNomenNzis;
  Adb_DM.PR001Coll.cmdFile := streamCmdFileNomenNzis;
end;

procedure TfrmSuperHip.OpenDB(index: integer);
begin
  if index >= 0 then
  begin
    FFDbName := option.dblist[index];
  end
  else
  begin
    if ParamStr(3) = '' then
    begin
      FFDbName := '';
    end
    else
    begin
      FFDbName := ParamStr(3);
    end;
  end;
  Adb_DM.OpenDB(FFDbName);
//
//  if Assigned(Adb_DM.AdbMain) then
//    begin
//      UnmapViewOfFile(Adb_DM.AdbMain.Buf);
//      //FreeAndNil(Adb_DM.AdbMain);
//
//    end;
//    if AspectsLinkPatPregFile <> nil then
//    begin
//      vtrPregledPat.BeginUpdate;
//      nodeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);
//      vtrPregledPat.InternalDisconnectNode(nodeLink, false);
//      UnmapViewOfFile(AspectsLinkPatPregFile.Buf);
//      FreeAndNil(AspectsLinkPatPregFile);
//      vtrPregledPat.Selected[vtrPregledPat.GetFirstSelected()] := False;
//      vtrPregledPat.CanClear := True;
//      vtrPregledPat.AddChild(nil, nil);
//      //vtrPregledPat.Clear;
//
//      vtrPregledPat.CanClear := false;
//      vtrPregledPat.Repaint;
//      vtrPregledPat.endUpdate;
//    end;
//
//   // ClearColl;
//    if FmxProfForm = nil then
//      InitFMXDyn;
//
//
//
//    //if Assigned(streamCmdFile) then
////    begin
////      streamCmdFile.Free;
////    end;
//    vtrGraph.DeleteChildren(vRootGraph);
//    Adb_dm.lstPatGraph.Clear;
//    if thrHistPerf <> nil then
//      thrHistPerf.stop := true;
//    //if not nnn then
//    begin
//      initDB();
//      vtrFDB.Repaint;
//    end;
end;

procedure TfrmSuperHip.OpenExcels;
begin
  if xlsHipp = nil then
  begin
    xlsHipp := TXLSSpreadSheet.Create(Self);
    pgcWork.ActivePage := Self.tsExcel;
    //InternalChangeWorkPage(tsExcel);
    with xlsHipp do
    begin
      Name := 'xlsHippNomen';
      Parent := Self.tsExcel;
      Cursor := crCross;
      ComponentVersion := '3.00.10';
      ReadOnly := False;
      Align := alClient;
      UseDockManager := False;
      TabOrder := 0;
      TabStop := True;
    end;
  end;
  xlsHipp.Refresh;
  xlsHipp.Filename := 'D:\NzisSpec\НЗИС - Профилактика - Бизнес правила - v1.0.5.xlsx';
  xlsHipp.Read;
  //xlsHipp.OnCellChanged := XLSSpreadSheet1CellChanged;
  //LoadVtrNomen;

  //if xlsHippPregled = nil then
//  begin
//    xlsHippPregled := TXLSSpreadSheet.Create(Self);
//    pgcWork.ActivePage := Self.tsExcelPregled;
//    with xlsHippPregled do
//    begin
//      Name := 'xlsHippPregled';
//      Parent := Self.tsExcelPregled;
//      Cursor := crCross;
//      ComponentVersion := '3.00.10';
//      ReadOnly := False;
//      Align := alClient;
//      UseDockManager := False;
//      TabOrder := 0;
//      TabStop := True;
//    end;
//  end;
//  xlsHippPregled.Refresh;
//  xlsHippPregled.Filename := 'D:\Nzis\НЗИС Е-Преглед - API Спецификация v1.3.1.xlsx';
//  xlsHippPregled.Read;
//  //xlsHippNomen.OnCellChanged := XLSSpreadSheet1CellChanged;
//  LoadVtrPregled;
//
//  if xlsHippPR001 = nil then
//  begin
//    xlsHippPR001 := TXLSSpreadSheet.Create(Self);
//    pgcWork.ActivePage := Self.tsExcelPR001;
//    with xlsHippPR001 do
//    begin
//      Name := 'xlsHippPR001';
//      Parent := Self.tsExcelPR001;
//      Cursor := crCross;
//      ComponentVersion := '3.00.10';
//      ReadOnly := False;
//      Align := alClient;
//      UseDockManager := False;
//      TabOrder := 0;
//      TabStop := True;
//    end;
//  end;
//  xlsHippPR001.Refresh;
//  xlsHippPR001.Filename := 'D:\Nzis\НЗИС - Профилактика - Бизнес правила - v1.0.0.xlsx';
//  xlsHippPR001.Read;
end;

procedure TfrmSuperHip.OpenLinkNomenHipAnals;
var
  i, j: Integer;
  collType: TCollectionsType;
  aspVersion: Word;
  b: Byte;
  pByteData: ^Byte;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  FPosLinkData: Cardinal;
  node: PVirtualNode;
  linkPos: Cardinal;
  deltaBuf, oldBuf: Cardinal;
  oldRoot: Cardinal;
  fileNameLink: string;
  AInt64: Int64;
  data: PAspRec;

begin
  Stopwatch := TStopwatch.StartNew;
  fileNameLink := ParamStr(2) + 'LinkAnals.adb';

  if AspectsLinkNomenHipAnalFile <> nil then
    AspectsLinkNomenHipAnalFile.Free;
  AspectsLinkNomenHipAnalFile := TMappedFile.Create(fileNameLink, false, TGUID.Empty);

  pCardinalData := pointer(PByte(AspectsLinkNomenHipAnalFile.Buf) + 4);
  oldBuf := pCardinalData^;
  if Cardinal(AspectsLinkNomenHipAnalFile.Buf) >= oldBuf then
  begin
    deltaBuf := Cardinal(AspectsLinkNomenHipAnalFile.Buf) - oldBuf;
  end
  else
  begin
    deltaBuf := oldBuf - Cardinal(AspectsLinkNomenHipAnalFile.Buf);
  end;
  pCardinalData := pointer(PByte(AspectsLinkNomenHipAnalFile.Buf) + 4);
  pCardinalData^ := Cardinal(AspectsLinkNomenHipAnalFile.Buf);
  pCardinalData := pointer(PByte(AspectsLinkNomenHipAnalFile.Buf) + 8);
  oldRoot := pCardinalData^;

  //mmoLog.Lines.Add(Format('BufLink  = %d', [cardinal(AspectsLinkFile.Buf)]));

  linkPos := 100;
  pCardinalData := pointer(PByte(AspectsLinkNomenHipAnalFile.Buf));
  FPosLinkData := pCardinalData^;
  node := pointer(PByte(AspectsLinkNomenHipAnalFile.Buf) + linkpos);

  Exclude(node.States, vsSelected);
  Include(node.States, vsMultiline);
  Include(node.States, vsHeightMeasured);
  data := pointer(PByte(node) + lenNode);
  data.index := -1;
  //ListNodes.Add(data);
  i := 0;
  if Cardinal(AspectsLinkNomenHipAnalFile.Buf) > oldBuf then
  begin
    while linkPos <= FPosLinkData do
    begin
      if node.PrevSibling <> nil then
        node.PrevSibling := Pointer(Integer(deltaBuf) + Integer(node.PrevSibling));
      if node.NextSibling <> nil then
        node.NextSibling := Pointer(Integer(deltaBuf) + Integer(node.NextSibling));
      if node.FirstChild <> nil then
        node.FirstChild := Pointer(Integer(deltaBuf) + Integer(node.FirstChild));
      if node.LastChild <> nil then
        node.LastChild := Pointer(Integer(deltaBuf) + Integer(node.LastChild));
      if linkPos <> 100 then
      begin
        if (node.Parent <> nil)  then
          node.parent := Pointer(Integer(deltaBuf) + Integer(node.parent));
      end
      else
      begin
        node.parent := nil;
      end;
      Inc(linkPos, LenData);

      node := pointer(PByte(AspectsLinkNomenHipAnalFile.Buf) + linkpos);
      Exclude(node.States, vsSelected);
      Include(node.States, vsMultiline);
      Include(node.States, vsHeightMeasured);
      data := pointer(PByte(node) + lenNode);
      data.index := -1;
      //ListNodes.Add(data);
    end;
  end
  else
  begin
    if deltaBuf <> 0 then
    begin
      while linkPos <= FPosLinkData do
      begin
        if node.PrevSibling <> nil then
            node.PrevSibling := Pointer(-Integer(deltaBuf) + Integer(node.PrevSibling));
        if node.NextSibling <> nil then
          node.NextSibling := Pointer(-Integer(deltaBuf) + Integer(node.NextSibling));
        if node.FirstChild <> nil then
          node.FirstChild := Pointer(-Integer(deltaBuf) + Integer(node.FirstChild));
        if node.LastChild <> nil then
          node.LastChild := Pointer(-Integer(deltaBuf) + Integer(node.LastChild));
        if linkPos <> 100 then
        begin
          if (node.Parent <> nil)  then
            node.parent := Pointer(-Integer(deltaBuf) + Integer(node.parent));
        end
        else
        begin
          node.Parent := nil;
        end;
        Inc(linkPos, LenData);
        node := pointer(PByte(AspectsLinkNomenHipAnalFile.Buf) + linkpos);
        Exclude(node.States, vsSelected);
        Include(node.States, vsMultiline);
        Include(node.States, vsHeightMeasured);
        data := pointer(PByte(node) + lenNode);
        data.index := -1;
        //ListNodes.Add(data);
      end;
    end
    else
    begin
      while linkPos <= FPosLinkData do
      begin
        Inc(linkPos, LenData);
        node := pointer(PByte(AspectsLinkNomenHipAnalFile.Buf) + linkpos);
        Exclude(node.States, vsSelected);
        Include(node.States, vsMultiline);
        Include(node.States, vsHeightMeasured);
        data := pointer(PByte(node) + lenNode);
        data.index := -1;
        //ListNodes.Add(data);
        //case data.vid  of
//          vvPregled:
//          begin
//            preg := TPregledItem(PregledColl.Add);
//            preg.DataPos := Data.DataPos;
//            data.index := PregledColl.Count - 1;
//          end;
//          vvPatient:
//          begin
//            pat := TPatientItem(PatientColl.Add);
//            pat.DataPos := Data.DataPos;
//            data.index := PatientColl.Count - 1;
//          end;
//        end;

      end;
    end;
  end;


  pCardinalData := pointer(PByte(AspectsLinkNomenHipAnalFile.Buf));
  pCardinalData^ := linkpos;
  node := pointer(PByte(AspectsLinkNomenHipAnalFile.Buf) + 100);

  vtrNewAnal.InternalConnectNode_cmd(node, vtrNewAnal.RootNode, vtrNewAnal, amAddChildFirst);
  pCardinalData := pointer(PByte(AspectsLinkNomenHipAnalFile.Buf) + 8);
  pCardinalData^ := Cardinal(vtrNewAnal.RootNode);

  vtrNewAnal.EndUpdate;
  vtrNewAnal.UpdateScrollBars(true);
  vtrNewAnal.InvalidateToBottom(vtrNewAnal.RootNode);

  Elapsed := Stopwatch.Elapsed;
  tmpVtr.vtrNewAnal := vtrNewAnal;

  mmotest.Lines.Add( Format('ЗарежданеLinkAnal %d за %f',[vtrNewAnal.RootNode.TotalCount,  Elapsed.TotalMilliseconds]));
  //CalcStatusDB(GetFileSize(AfileLink, @Int64Rec(AInt64).Hi), 100, linkpos, 0, 0);
  //PregledColl.ShowGrid(TeeGrid1);
end;

procedure TfrmSuperHip.OpenLinkPatPreg(LNK: TMappedFile);
var
  i, j: Integer;
  collType: TCollectionsType;
  aspVersion: Word;
  b: Byte;
  pByteData: ^Byte;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  FPosLinkData: Cardinal;
  node: PVirtualNode;
  linkPos: Cardinal;
  deltaBuf, oldBuf: Cardinal;
  oldRoot: Cardinal;
  fileNameLink: string;
  AInt64: Int64;
  data: PAspRec;
  preg: TPregledNewItem;
  pat: TPatientNewItem;
begin
  Stopwatch := TStopwatch.StartNew;
  //ListNodes.Clear;
  vtrPregledPat.BeginUpdate;

  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf) + 4);
  oldBuf := pCardinalData^;
  if Cardinal(AspectsLinkPatPregFile.Buf) >= oldBuf then
  begin
    deltaBuf := Cardinal(AspectsLinkPatPregFile.Buf) - oldBuf;
  end
  else
  begin
    deltaBuf := oldBuf - Cardinal(AspectsLinkPatPregFile.Buf);
  end;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf) + 4);
  pCardinalData^ := Cardinal(AspectsLinkPatPregFile.Buf);
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf) + 8);
  oldRoot := pCardinalData^;

  //mmotest.Lines.Add(Format('BufLink  = %d', [cardinal(AspectsLinkPatPregFile.Buf)]));

  linkPos := 100;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  FPosLinkData := pCardinalData^;
  node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
  //node.NodeHeight := 27;

  Exclude(node.States, vsSelected);
  data := pointer(PByte(node) + lenNode);
  if not (data.vid in [vvPatientRevision]) then
    data.index := -1;
  AddToListNodes(data);
  i := 0;
  if Cardinal(AspectsLinkPatPregFile.Buf) > oldBuf then
  begin
    while linkPos <= FPosLinkData do
    begin
      if node.PrevSibling <> nil then
        node.PrevSibling := Pointer(Integer(deltaBuf) + Integer(node.PrevSibling));
      if node.NextSibling <> nil then
        node.NextSibling := Pointer(Integer(deltaBuf) + Integer(node.NextSibling));
      if node.FirstChild <> nil then
        node.FirstChild := Pointer(Integer(deltaBuf) + Integer(node.FirstChild));
      if node.LastChild <> nil then
        node.LastChild := Pointer(Integer(deltaBuf) + Integer(node.LastChild));

      if linkPos <> 100 then
      begin
        if (node.Parent <> nil)  then
          node.parent := Pointer(Integer(deltaBuf) + Integer(node.parent));
      end
      else
      begin
        node.parent := nil;
      end;
      Inc(linkPos, LenData);

      node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
      //node.NodeHeight := 27;
      Exclude(node.States, vsSelected);
      //Node.States := node.States + [vsMultiline] + [vsHeightMeasured]; // zzzzzzzzzzzzzzzzzzz за опция за редове
      data := pointer(PByte(node) + lenNode);
      if not (data.vid in [vvPatientRevision]) then
        data.index := -1;
      if data.vid = vvEvntList then
      begin
        data.DataPos := data.DataPos + deltaBuf;
      end;

      AddToListNodes(data);
    end;
  end
  else
  begin
    if deltaBuf <> 0 then
    begin
      while linkPos <= FPosLinkData do
      begin
        if node.PrevSibling <> nil then
            node.PrevSibling := Pointer(-Integer(deltaBuf) + Integer(node.PrevSibling));
        if node.NextSibling <> nil then
          node.NextSibling := Pointer(-Integer(deltaBuf) + Integer(node.NextSibling));
        if node.FirstChild <> nil then
          node.FirstChild := Pointer(-Integer(deltaBuf) + Integer(node.FirstChild));
        if node.LastChild <> nil then
          node.LastChild := Pointer(-Integer(deltaBuf) + Integer(node.LastChild));
        if linkPos <> 100 then
        begin
          if (node.Parent <> nil)  then
            node.parent := Pointer(-Integer(deltaBuf) + Integer(node.parent));
        end
        else
        begin
          node.Parent := nil;
        end;
        Inc(linkPos, LenData);
        node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
        Exclude(node.States, vsSelected);
        //Node.States := node.States + [vsMultiline] + [vsHeightMeasured]; // zzzzzzzzzzzzzzzzzzz за опция за редове
        data := pointer(PByte(node) + lenNode);
        if data.vid = vvEvntList then
        begin
          data.DataPos := data.DataPos - deltaBuf;
        end;
        if not (data.vid in [vvPatientRevision]) then
          data.index := -1;
        //if data.vid <> vvPatient then
//          Exclude(node.States, vsFiltered);
        AddToListNodes(data);
      end;
    end
    else
    begin
      //PregledColl.Capacity := 1000000;
      while linkPos <= FPosLinkData do
      begin
        Inc(linkPos, LenData);
        node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
        Exclude(node.States, vsSelected);
        //Node.States := node.States + [vsMultiline] + [vsHeightMeasured];  // zzzzzzzzzzzzzzzzzzz за опция за редове
        //Exclude(node.States, vsInitialized);
        data := pointer(PByte(node) + lenNode);
        //if data.vid <> vvPatient then
//          Exclude(node.States, vsFiltered);
        if not (data.vid in [vvPatientRevision]) then
          data.index := -1;
        AddToListNodes(data);
      end;
    end;
  end;


  //pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
//  pCardinalData^ := linkpos;
  node := pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);
   //node.NodeHeight := 27;

  vtrPregledPat.InternalConnectNode_cmd(node, vtrPregledPat.RootNode, vtrPregledPat, amAddChildFirst);
  vtrPregledPat.BufLink := AspectsLinkPatPregFile.Buf;
  //node := pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);
  //vtrPregledPat.InternalDisconnectNode(node, false);
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf) + 8);
  pCardinalData^ := Cardinal(vtrPregledPat.RootNode);
  vtrPregledPat.UpdateVerticalScrollBar(true);
  vtrPregledPat.EndUpdate;
  Stopwatch.StartNew;
  //vtrPregledPat.Sort(vtrPregledPat.RootNode.FirstChild, 0, sdAscending, false);
  Elapsed := Stopwatch.Elapsed;
  AspectsLinkPatPregFile.FVTR := vtrPregledPat;
  AspectsLinkPatPregFile.FStreamCmdFile := streamCmdFile;
  FDBHelper.AdbLink := AspectsLinkPatPregFile;
  FmxProfForm.AspLink := AspectsLinkPatPregFile;
  //Adb_DM.AdbMain := AspectsHipFile;
  Adb_DM.AdbLink := AspectsLinkPatPregFile;

  //vtrPregledPat.ValidateNode(vtrPregledPat.RootNode.FirstChild.FirstChild,True);

  //vtrPregledPat.Selected[vtrPregledPat.GetLast()] := True;
  //vtrPregledPat.IsFiltered[vtrPregledPat.Getlast()] := True;
  //vtrPregledPat.ReinitNode(vtrPregledPat.GetFirst(), true);

  //Elapsed := Stopwatch.Elapsed;

  mmoTest.Lines.Add( Format('ЗарежданеLink %d за %f',[vtrPregledPat.RootNode.TotalCount,  Elapsed.TotalMilliseconds]));
  //CalcStatusDB(GetFileSize(AfileLink, @Int64Rec(AInt64).Hi), 100, linkpos, 0, 0);
  //PregledColl.ShowGrid(TeeGrid1);

  //FindOldItemsForInsert;
  CheckCollForSave;

  
end;

procedure TfrmSuperHip.OpenPregX001(pregNode: PVirtualNode);
var
  nzisThr: TNzisThread;
  data: PAspRec;
begin
  //if (edtToken.Text = '') or (Now > TokenToTime) then
//  begin
//    btnTokenClick(nil);
//  end;

  //Adb_DM.CollPrac := CollPractica;
//  Adb_DM.CollDoc := CollDoctor;

  nzisThr := TNzisThread.Create(false, Adb_DM);
  nzisThr.FreeOnTerminate := True;
  nzisThr.IsTestNZIS := true;

  nzisThr.OnSended := NzisOnSended;
  nzisThr.HndSuperHip := Self.Handle;
  nzisThr.Node := pregNode;
  nzisThr.MsgType := TNzisMsgType.X001;
  //nzisThr.StreamData := preg.FStreamNzis;
  nzisThr.token := '';//edtToken.Text;
  nzisThr.CurrentCert := nil;
  nzisThr.Resume;
end;

procedure TfrmSuperHip.FormCreate(Sender: TObject);
var
  cntrCanvas: TControlCanvas;
begin
  Visible := False;
  edt1.Parent := grdSearch;
  edt1.SetBounds(0,0,1, 1);

  vtrPregledPat.TakeFocus := False;
  grdSearch.Header.Hover.OnChange := HoverChange;
  grdSearch.Header.Selected.OnChange := HoverChange;
  grdSearch.Header.Columns.OnMoved := ColMoved;

  FinderRec.LastFindedStr := '';
  //mmoTest.Lines.Add(IntToStr(mmMain.Handle));
  if True then //Fdm.IsGP then
  begin
    pnlProfMinaliPreg.Parent := vtrMinaliPregledi;
    pnlProfMinaliPreg.Align := alTop;
    pnlProfMinaliPreg.AlignWithMargins := True;
    pnlProfMinaliPreg.Margins.Top := 0; ;
    pnlProfMinaliPreg.Margins.Left := vtrMinaliPregledi.Header.Columns[0].Width ;
    pnlProfMinaliPreg.Height := vtrMinaliPregledi.DefaultNodeHeight - 2;
  end
  else
  begin
    pnlProfMinaliPreg.Parent := vtrMinaliPregledi;
    pnlProfMinaliPreg.Align := alTop;
    pnlProfMinaliPreg.AlignWithMargins := True;
    pnlProfMinaliPreg.Margins.Top := vtrMinaliPregledi.DefaultNodeHeight ;
    pnlProfMinaliPreg.Margins.Left := vtrMinaliPregledi.Header.Columns[0].Width ;
    pnlProfMinaliPreg.Height := vtrMinaliPregledi.DefaultNodeHeight - 2;
  end;
  pnlGridSearch.Height := 1;
  tlb1.Realign;
  //SystemParametersInfo(SPI_SETKEYBOARDSPEED,30,0,0);
  KeyCNT := True;
  Stopwatch := TStopwatch.StartNew;
  grdNom.Selected.FullRow:=True;
  grdNom.Selected.Range.Enabled:=True;
  FDBHelper := TDbHelper.Create;
  FDBHelper.Vtr := vtrPregledPat;

  ListHistoryNav := TList<THistoryNav>.Create;
  InitExpression;
  IsIndexedPregled := False;
  Screen.OnActiveControlChange := ActiveControlChanged;

  InitGlobalValues;
  HideTabs;


  Option := TOptions.create(gAppDir);
  Option.vtrRecentDB := vtrRecentDB;
  Option.vtrOptions := vtrOptions;
  //dtp1.Date := Date;


  InitHttpNzis;
  //InitColl;
  InitAdb;
  InitVTRs;

  AZipHelpFile:=TZipFile.Create;

  //ListMainDiagPreg := TList<TDiagnosisItem>.Create;
  //ListAddDiagPreg := TList<TDiagnosisItem>.Create;

  listFilterCount := tlist<Integer>.Create;

  FilterStringsHave := TList<TString>.Create;
  FilterStringsNotHave := TList<TString>.Create;
  pgcTree.ActivePage := nil;
  FFilterCountPregled := -1;

  //InitFMXDyn;//zzzzzzzzzzzzzzzzzzzzzzzzzz много бавно
  Elapsed := Stopwatch.Elapsed;
  InXmlStream := TStringStream.Create;
  streamRes := TMemoryStream.Create;
  CurrentCert := TelX509Certificate.Create(self);
  CertForThread := TelX509Certificate.Create(self);
  //Application.OnHint := OnApplicationHint;


  mmoTest.Lines.Add( Format('create  за %f',[ Elapsed.TotalMilliseconds]));
  fmxCntrRoleBar.DoubleBuffered := false;
  fmxCntrDyn.DoubleBuffered := false;
  tmpVtr := TTempVtrHelper.Create(vtrTemp, Adb_dm.CollMkb, Adb_DM, Adb_dm.CollDiag, Adb_dm.CollDoctor, mmoTest, vNomenMKB, FmxProfForm);
  Screen.HintFont.Size := 8;

  Stopwatch := TStopwatch.StartNew;
  FNasMesto := TRealNasMestoAspects.Create(vtrLinkNasMesta);
  FNasMesto.memotest := mmotest;
  Adb_dm.CollPatient.NasMesto := FNasMesto;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('TRealNasMestoAspects.Create  за %f',[ Elapsed.TotalMilliseconds]));

  Stopwatch := TStopwatch.StartNew;
  FNasMesto.LinkToColl;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('FNasMesto.LinkToColl  за %f',[ Elapsed.TotalMilliseconds]));
  //sgctl1.Licence :=
//  'eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI3YmM5Y2IxYWIxMGE0NmUxODI2N2E5MTJkYTA2' +
//  'ZTI3NiIsImV4cCI6MjE0NzQ4MzY0NywiaWF0IjoxNTYwOTUwMjcyLCJyaWdodHMiOlsiU0lHX1NES19DT1JFI' +
//  'iwiU0lHQ0FQVFhfQUNDRVNTIl0sImRldmljZXMiOlsiV0FDT01fQU5ZIl0sInR5cGUiOiJwcm9kIiwibGljX2' +
//  '5hbWUiOiJTaWduYXR1cmUgU0RLIiwid2Fjb21faWQiOiI3YmM5Y2IxYWIxMGE0NmUxODI2N2E5MTJkYTA2ZTI' +
//  '3NiIsImxpY191aWQiOiJiODUyM2ViYi0xOGI3LTQ3OGEtYTlkZS04NDlmZTIyNmIwMDIiLCJhcHBzX3dpbmRv' +
//  'd3MiOltdLCJhcHBzX2lvcyI6W10sImFwcHNfYW5kcm9pZCI6W10sIm1hY2hpbmVfaWRzIjpbXX0.ONy3iYQ7l' +
//  'C6rQhou7rz4iJT_OJ20087gWz7GtCgYX3uNtKjmnEaNuP3QkjgxOK_vgOrTdwzD-nm-ysiTDs2GcPlOdUPErS' +
//  'p_bcX8kFBZVmGLyJtmeInAW6HuSp2-57ngoGFivTH_l1kkQ1KMvzDKHJbRglsPpd4nVHhx9WkvqczXyogldyg' +
//  'vl0LRidyPOsS5H2GYmaPiyIp9In6meqeNQ1n9zkxSHo7B11mp_WXJXl0k1pek7py8XYCedCNW5qnLi4UCNlfT' +
//  'd6Mk9qz31arsiWsesPeR9PN121LBJtiPi023yQU8mgb9piw_a-ccciviJuNsEuRDN3sGnqONG3dMSA';
//  cntrCanvas := TControlCanvas.Create;
//  cntrCanvas.Control := TControl(hntMain);
//  cntrCanvas.Font.Size := 20;
//  cntrCanvas.Free;
//  Screen.HintFont.Size := 20;
end;

procedure TfrmSuperHip.FormDestroy(Sender: TObject);
var
  i: Integer;
  nomen: TNomenNzisRec;
begin
  FreeAndNil(ListHistoryNav);
  //FreeColl;
  FreeAndNil(listFilterCount);
  //FreeAndNil(LSNomenNzisNames);
  //for i := 0 to ListNomenNzisNames.Count - 1 do
//  begin
//    nomen := ListNomenNzisNames[i];
//    FreeAndNil(nomen);
//  end;
//  FreeAndNil(ListNomenNzisNames);
  //FreeAndNil(Adb_dm.lstPatGraph);
  //FreeAndNil(FilterList);
  FreeAndNil(FilterStringsHave);
  FreeAndNil(FilterStringsNotHave);
  

  FreeAndNil(AZipHelpFile);
  DownloadedStream.Free;
  if Adb_DM.AdbMain <> nil then
    Adb_DM.AdbMain.Free;
  if AspectsLinkPatPregFile <> nil then
    AspectsLinkPatPregFile.Free;
  //FreeAndNil(ListNodes);
  if Fdm <> nil then
  begin
    Fdm.Free;
  end;
  Option.Free;
  FreeAndNil(FDBHelper);
  FreeAndNil(Adb_DM);
  if ResultNzisToken = nil then
    FreeAndNil(ResultNzisToken);
  FreeAndNil(InXmlStream);
  FreeAndNil(streamRes);
  FreeAndNil(tmpVtr);
  FreeAndNil(FNasMesto);
end;

procedure TfrmSuperHip.FormFMXMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  //scrlbx1.VertScrollBar.Position := scrlbx1.VertScrollBar.Position + WheelDelta;
  //ScaleDyn(nil);
  //if WheelDelta < 0 then
//  begin
//    scrlbx1.VertScrollBar.Position := scrlbx1.VertScrollBar.Position - 8 * ;
//  end
//  else
//  begin
//    scrlbx1.VertScrollBar.Position := scrlbx1.VertScrollBar.Position + 8;
//  end;

end;

procedure TfrmSuperHip.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //
end;

procedure TfrmSuperHip.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //
end;

procedure TfrmSuperHip.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if pgcWork.ActivePage = tsRTF then
  begin
    if ssCtrl in Shift then
    begin
      if (tsRTF.tag > 5) then
      begin
        tsRTF.tag := tsRTF.tag - 1;
        SendMessage(frRTF.Handle, EM_SETZOOM, 32, tsRTF.tag);
      end;
    end;
  end;
  if pgcTree.ActivePage = tsTreePat then
  begin
    if vtrPregledPat.MouseInClient then
    begin
      //vtrPregledPat.DoMouseWheelHipp(Shift, -20, MousePos);
    end;
  end;
end;

procedure TfrmSuperHip.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if pgcWork.ActivePage = tsRTF then
  begin
    if ssCtrl in Shift then
    begin
      if (tsRTF.tag < 60) then
      begin
        tsRTF.tag := tsRTF.tag + 1;
        SendMessage(frRTF.Handle, EM_SETZOOM, 32, tsRTF.tag);
      end;
    end;
  end;
end;

procedure TfrmSuperHip.FormShow(Sender: TObject);
begin
  //DynWinPanel1.Repaint;
  //Self.Menu := nil;
  PostMessage(Self.Handle, WM_AFTER_SHOW, 0, 0);
end;


//procedure TfrmSuperHip.FreeColl;
//begin
//  FreeAndNil(CollPatGR);
//  FreeAndNil(CollDoctor);
//  FreeAndNil(CollOtherDoctor);
//  FreeAndNil(CollUnfav);
//  FreeAndNil(CollMkb);
//  FreeAndNil(CollPregled);
//  FreeAndNil(ListPregledForFDB);
//  FreeAndNil(ListPregledLinkForInsert);
//  FreeAndNil(CollPatient);
//  FreeAndNil(AcollpatFromDoctor);
//  FreeAndNil(ACollPatFDB);
//  FreeAndNil(ACollNovozapisani);
//  FreeAndNil(ListPatientForFDB);
//  FreeAndNil(CollPatPis);
//  FreeAndNil(CollDiag);
//  FreeAndNil(CollMDN);
//  FreeAndNil(CollPregledVtor);
//  FreeAndNil(CollPregledPrim);
//  FreeAndNil(CollAnalsNew);
//  FreeAndNil(CollPractica);
//  FreeAndNil(CollEbl);
//  FreeAndNil(CollExamAnal);
//  FreeAndNil(CollExamImun);
//  FreeAndNil(CollProceduresNomen);
//  FreeAndNil(CollProceduresPreg);
//  FreeAndNil(CollCardProf);
//  FreeAndNil(CollMedNapr);
//  FreeAndNil(CollMedNapr3A);
//  FreeAndNil(CollMedNaprHosp);
//  FreeAndNil(CollMedNaprLkk);
//  FreeAndNil(CollNZIS_PLANNED_TYPE);
//  FreeAndNil(CollNZIS_QUESTIONNAIRE_RESPONSE);
//  FreeAndNil(CollNZIS_QUESTIONNAIRE_ANSWER);
//  FreeAndNil(CollNZIS_ANSWER_VALUE);
//  FreeAndNil(CollNZIS_DIAGNOSTIC_REPORT);
//  FreeAndNil(CollNzis_RESULT_DIAGNOSTIC_REPORT);
//  FreeAndNil(CollIncMdn);
//  FreeAndNil(CollIncMN);
//  FreeAndNil(CollNzisToken);
//  FreeAndNil(CollCertificates);
//
//  FreeAndNil(CL132Coll);
//  FreeAndNil(CL050Coll);
//  FreeAndNil(CL006Coll);
//  FreeAndNil(CL022Coll);
//  FreeAndNil(CL024Coll);
//  FreeAndNil(CL037Coll);
//  FreeAndNil(CL038Coll);
//  FreeAndNil(CL088Coll);
//  FreeAndNil(CL134Coll);
//  FreeAndNil(CL139Coll);
//  FreeAndNil(CL142Coll);
//  FreeAndNil(CL144Coll);
//  FreeAndNil(PR001Coll);
//  FreeAndNil(NomenNzisColl);
//
//  FreeAndNil(FPatientTemp);
//  FreeAndNil(PregledTemp);
//  FreeAndNil(DiagTemp);
//  FreeAndNil(MDNTemp);
//  FreeAndNil(MNTemp);
//  FreeAndNil(ExamAnalTemp);
//  FreeAndNil(DoctorTemp);
//  FreeAndNil(AnalTemp);
//  FreeAndNil(Cl022temp);
//  FreeAndNil(Cl132temp);
//  FreeAndNil(PR001Temp);
//  FreeAndNil(CL088Temp);
//  FreeAndNil(ProcTemp);
//  FreeAndNil(NZIS_PLANNED_TYPETemp);
//  FreeAndNil(NZIS_QUESTIONNAIRE_RESPONSETemp);
//  FreeAndNil(NZIS_QUESTIONNAIRE_ANSWERTemp);
//  FreeAndNil(NZIS_DIAGNOSTIC_REPORTTemp);
//  FreeAndNil(NZIS_Result_DIAGNOSTIC_REPORTTemp);
//
//end;

procedure TfrmSuperHip.FreeFMXDin;
begin
end;

procedure TfrmSuperHip.GenerateNzisXml(node: PVirtualNode);
var
  data: PAspRec;
  oXml: IXMLDocument;
  stream: TMemoryStream;
  ls: TStringList;
  idx: Integer;
  XmlStream: TXmlStream;
begin
  if not chkLockNzisMess.Checked then Exit;
  data := pointer(PByte(node) + lenNode);
  case data.vid of
    vvPregled:
    begin
      //Adb_DM.CollPrac := CollPractica;
//      Adb_DM.CollDoc := CollDoctor;
      XMLStream := TXmlStream.Create('', TEncoding.UTF8);
      case rgNzisMessage.ItemIndex of
        0: //X001
        begin
          Adb_DM.FillXmlStreamX001(XmlStream, node, idx);
          edtUrl.Text := Adb_DM.GetURLFromMsgType(X001, true);
        end;
        1: //X003
        begin
          Adb_DM.FillXmlStreamX003(XmlStream, node, idx);
          edtUrl.Text := Adb_DM.GetURLFromMsgType(X003, true);
        end;
        2: //X005
        begin
          Adb_DM.FillXmlStreamX005(XmlStream, node);
          edtUrl.Text := Adb_DM.GetURLFromMsgType(X005, true);
        end;
        3: //X009
        begin
          Adb_DM.FillXmlStreamX009(XmlStream, node, idx);
          edtUrl.Text := Adb_DM.GetURLFromMsgType(X009, true);
        end;
        4: //X013
        begin
          Adb_DM.FillXmlStreamX013(XmlStream, node);
          edtUrl.Text := Adb_DM.GetURLFromMsgType(X013, true);
        end;
      end;
      XmlStream.Position := 0;
      try
        stream := TMemoryStream.Create;
        ls := TStringList.Create;
        ls.LoadFromStream(XmlStream, TEncoding.UTF8);
        oXml := TXMLDocument.Create(self);
        oXml.LoadFromXML(ls.Text);
        oXml.Encoding := 'UTF-8';
        oXml.SaveToStream(stream);
        stream.Position := 0;
        syndtNzisReq.Lines.LoadFromStream(stream, TEncoding.UTF8);
      finally
        XmlStream.Free;
        stream.Free;
        ls.Free;
        if oXml.Active then
        begin
          oXml.ChildNodes.Clear;
          oXml.Active := False;
        end;
        oxml := nil;
      end;
     // syndtNzisReq.Lines.LoadFromStream(Adb_DM.XmlStream);
    end;
  end;
end;

function TfrmSuperHip.GetCollectionFromRoot(
  Root: PVirtualNode): TBaseCollection;
var
  data: PAspRec;
begin
  Result := nil;
  if Root = nil then Exit;

  data := PAspRec(PByte(Root) + lenNode);

  if data^.DataPos <> 0 then
    Result := TBaseCollection(Pointer(data^.DataPos));
end;

procedure TfrmSuperHip.GetCurrentPatProf(pat: TRealPatientNewItem);
var
  preg: TRealPregledNewItem;
  diag: TRealDiagnosisItem;
  runPat, runPreg, runDiag: PVirtualNode;
  runDataPat, runDataPreg, runDataDiag, dataGraph: PAspRec;
  egn, mkb: string;
  //PregIsProf: Boolean;
  i: Integer;
  dat: TDate;
  log: TlogicalPatientNewSet;
begin
  if profGR = nil then
  begin

    OpenBufNomenNzis(ParamStr(2) + 'NzisNomen.adb');
    LoadVtrNomenNzis1();

    profGR := TProfGraph.create;

    profGR.BufNomen := AspectsNomFile.Buf;
    //profGR.BufADB := AspectsHipFile.Buf;
    //profGR.posDataADB := AspectsHipFile.FPosData;
    profGR.vtrGraph := vtrGraph;
  end;
  //vtrGraph.BeginUpdate;
  //vtrGraph.DeleteChildren(vRootGraph);
  //lstPatGraph.Clear;
  runPat := vtrPregledPat.RootNode.FirstChild.FirstChild;
  while runPat <> nil do
  begin
    runDataPat := pointer(PByte(runPat) + lenNode);

    //PatientTemp.DataPos := runDataPat.DataPos;
    egn := Adb_dm.CollPatient.getAnsiStringMap(runDataPat.DataPos, word(PatientNew_EGN));
    if egn <> Adb_DM.patEgn then //////////////////////'8403236257' then
    begin
      runPat := runPat.NextSibling;
      Continue;
    end;


    runPreg := runPat.FirstChild;
    while runPreg <> nil do
    begin
      runDataPreg := pointer(PByte(runPreg) + lenNode);
      preg := TRealPregledNewItem.Create(nil);
      preg.DataPos := runDataPreg.DataPos;
      //PregIsProf := False;
      runDiag := runPreg.FirstChild;
      while runDiag <> nil do // Тука на това ниво са и мдн-тата;
      begin
        runDataDiag := pointer(PByte(runDiag) + lenNode);
        case runDataDiag.vid of
          vvDiag:
          begin
            diag := TRealDiagnosisItem.Create(nil);
            diag.DataPos := runDataDiag.DataPos;
            mkb := diag.getAnsiStringMap(Adb_dm.CollDiag.Buf, Adb_dm.CollDiag.posData, word(Diagnosis_code_CL011));
            if 'Z00.0Z00.1Z00.2Z00.3Z10.8Z23.2Z23.8Z24.6Z27.4Z27.8'.Contains(mkb) and mkb.Contains('.') then
            begin
              //preg.ListNZIS_PLANNED_TYPEs.Count;
              pat.FPregledi.Add(preg);
              preg.FDiagnosis.Add(diag);
              //Break;
            end;
          end;
          vvmdn:
          begin

          end;
        end;

        runDiag := runDiag.NextSibling;
      end;
      runPreg := runPreg.NextSibling;
    end;


    //i := lstPatGraph.Add(CurrentPatient);
    dat := pat.getDateMap(Adb_DM.AdbMain.Buf, Adb_dm.CollPatient.posData, word(PatientNew_BIRTH_DATE));
    log := TlogicalPatientNewSet(pat.getLogical40Map(Adb_dm.CollPatient.Buf, Adb_dm.CollPatient.posData, word(PatientNew_Logical)));
    profGR.SexMale := (TLogicalPatientNew.SEX_TYPE_M in log) ;
    profGR.CurrDate := dat;
    profGR.Adb_DM := Adb_DM;
    profGR.GeneratePeriod(pat);
    vtrGraph.UpdateVerticalScrollBar(true);
    vtrGraph.Clear;

    vRootGraph := vtrGraph.AddChild(nil, nil);
    dataGraph := vtrGraph.GetNodeData(vRootGraph);
    dataGraph.vid := vvNone;
    dataGraph.index := 0;
    pat.FNode := runPat;
    profGR.LoadVtrGraph(pat, i);
    pnlProfMinaliPreg.Caption := pat.NoteProf;
    btnNzisProf.Enabled  := (pat.NoteProf <> 'Няма неизвършени дейности по профилактиката.');
    pnlProfMinaliPreg.Repaint;
    runPat := runPat.NextSibling;
    Break;
  end;

end;

procedure TfrmSuperHip.GetCurrentPatProf1(pat: TRealPatientNewItem);
var
  preg: TRealPregledNewItem;
  plan: TRealNZIS_PLANNED_TYPEItem;
  diag: TRealDiagnosisItem;
  runPat, runPreg, runPregledNodes, runPlanes: PVirtualNode;
  runDataPat, runDataPreg, runDataPregledNodes, dataGraph, runDataPlanes: PAspRec;
  egn, mkb: string;
  //PregIsProf: Boolean;
  i: Integer;
  dat: TDate;
  log: TlogicalPatientNewSet;
  CL132Key: string;
begin
  if profGR = nil then
  begin

    OpenBufNomenNzis(ParamStr(2) + 'NzisNomen.adb');
    LoadVtrNomenNzis1();

    profGR := TProfGraph.create;

    profGR.BufNomen := AspectsNomFile.Buf;
    //profGR.BufADB := AspectsHipFile.Buf;
    //profGR.posDataADB := AspectsHipFile.FPosData;
    profGR.vtrGraph := vtrGraph;
  end;
  runPat := pat.FNode;

  runPreg := runPat.FirstChild;
  preg := nil;
  while runPreg <> nil do
  begin
    runDataPreg := pointer(PByte(runPreg) + lenNode);

    runPregledNodes := runPreg.FirstChild;
    while runPregledNodes <> nil do // Тука на това ниво са и мдн-тата;
    begin
      runDataPregledNodes := pointer(PByte(runPregledNodes) + lenNode);
      case runDataPregledNodes.vid of
        vvDiag:
        begin
          diag := TRealDiagnosisItem.Create(nil);
          diag.DataPos := runDataPregledNodes.DataPos;
          mkb := diag.getAnsiStringMap(Adb_dm.CollDiag.Buf, Adb_dm.CollDiag.posData, word(Diagnosis_code_CL011));
          if 'Z00.0Z00.1Z00.2Z00.3Z10.8Z23.2Z23.8Z24.6Z27.4Z27.8'.Contains(mkb) and mkb.Contains('.') then
          begin
            //preg.ListNZIS_PLANNED_TYPEs.Count;
            preg := TRealPregledNewItem.Create(nil);
            preg.DataPos := runDataPreg.DataPos;
            pat.FPregledi.Add(preg);
            preg.FDiagnosis.Add(diag);


          end;
        end;

        vvmdn:
        begin

        end;
      end;

      runPregledNodes := runPregledNodes.NextSibling;
    end;
    runPreg := runPreg.NextSibling;
  end;


  dat := pat.getDateMap(Adb_DM.AdbMain.Buf, Adb_dm.CollPatient.posData, word(PatientNew_BIRTH_DATE));
  log := TlogicalPatientNewSet(pat.getLogical40Map(Adb_dm.CollPatient.Buf, Adb_dm.CollPatient.posData, word(PatientNew_Logical)));
  profGR.SexMale := (TLogicalPatientNew.SEX_TYPE_M in log) ;
  profGR.CurrDate := dat;
  profGR.Adb_DM := Adb_DM;
  profGR.GeneratePeriod(pat);
  //vtrGraph.UpdateVerticalScrollBar(true);
//  vtrGraph.Clear;
//
//  vRootGraph := vtrGraph.AddChild(nil, nil);
//  dataGraph := vtrGraph.GetNodeData(vRootGraph);
//  dataGraph.vid := vvNone;
//  dataGraph.index := 0;
  profGR.LoadVtrGraphOutVtr(pat, i);

  if pat.CurrentGraphIndex >= 0 then
  begin
    runPreg := runPat.FirstChild; // наново, за да се откраднат от предишен преглед останали планове
    while runPreg <> nil do
    begin
      runDataPreg := pointer(PByte(runPreg) + lenNode);

      runPregledNodes := runPreg.FirstChild;
      while runPregledNodes <> nil do // Тука на това ниво са и мдн-тата;
      begin
        runDataPregledNodes := pointer(PByte(runPregledNodes) + lenNode);
        case runDataPregledNodes.vid of
          vvNZIS_PLANNED_TYPE:
          begin
            //if (runPregledNodes.CheckType = ctCheckBox) and (runPregledNodes.CheckState = csUncheckedNormal) then
            begin
              CL132Key := Adb_dm.CollNZIS_PLANNED_TYPE.getAnsiStringMap(runDataPregledNodes.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
              if (Adb_dm.CollNZIS_PLANNED_TYPE.getDateMap(runDataPregledNodes.DataPos, word(NZIS_PLANNED_TYPE_StartDate))<=
                pat.lstGraph[pat.CurrentGraphIndex].endDate)then

              begin
                plan := TRealNZIS_PLANNED_TYPEItem.Create(nil);
                plan.DataPos := runDataPregledNodes.DataPos;
                preg.ListNZIS_PLANNED_TYPEs.Add(plan);
                plan.Node := runPregledNodes;
                //vtrPregledPat.InternalDisconnectNode(runPregledNodes, false);
              end;
            end;
          end;
          vvmdn:
          begin

          end;
        end;

        runPregledNodes := runPregledNodes.NextSibling;
      end;
      runPreg := runPreg.NextSibling;
    end;
  end;

  pnlProfMinaliPreg.Caption := pat.NoteProf;
  btnNzisProf.Enabled  := (pat.NoteProf <> 'Няма неизвършени дейности по профилактиката.');
  pnlProfMinaliPreg.Repaint;

end;

function TfrmSuperHip.GetFDbName: string;
var
  stream: TMemoryStream;
begin
  Result := FFDbName;
  if FFDbName  = '' then
  begin
    if dlgOpenDB.Execute then
    begin
      FFDbName := dlgOpenDB.FileName;
      Option.AddToDbList(FFDbName);
      Result := FFDbName;
    end;
  end;
end;

procedure TfrmSuperHip.GetPatProf(var pat: TRealPatientNewItem);
var

  preg: TRealPregledNewItem;
  diag: TRealDiagnosisItem;
  runPat, runPreg, runDiag: PVirtualNode;
  runDataPat, runDataPreg, runDataDiag: PAspRec;
  egn, mkb: string;
  PregIsProf: Boolean;
  i: Integer;
  dat: TDate;
  log: TlogicalPatientNewSet;
begin
  //if Assigned(pat) then
//  begin
//    FreeAndNil(pat);
//  end;
  pat := TRealPatientNewItem.Create(nil);
  vtrGraph.BeginUpdate;
  vtrGraph.DeleteChildren(vRootGraph);
  Adb_dm.lstPatGraph.Clear;
  //runPat := vtrPregledPat.RootNode.FirstChild.FirstChild;
  //runPat := Adb_DM.PatNodes.patNode;
  while runPat <> nil do
  begin
    runDataPat := pointer(PByte(runPat) + lenNode);

    pat.DataPos := runDataPat.DataPos;
    //egn := pat.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_EGN));
//    if egn <> Adb_DM.patEgn then //////////////////////'8403236257' then
//    begin
//      runPat := runPat.NextSibling;
//      Continue;
//    end;


    runPreg := runPat.FirstChild;
    while runPreg <> nil do
    begin
      runDataPreg := pointer(PByte(runPreg) + lenNode);
      preg := TRealPregledNewItem.Create(nil);
      preg.DataPos := runDataPreg.DataPos;
      PregIsProf := False;
      runDiag := runPreg.FirstChild;
      while runDiag <> nil do
      begin
        runDataDiag := pointer(PByte(runDiag) + lenNode);
        if runDataDiag.vid <> vvDiag then
        begin
          runDiag := runDiag.NextSibling;
          continue;
        end;
        diag := TRealDiagnosisItem.Create(nil);
        diag.DataPos := runDataDiag.DataPos;
        mkb := diag.getAnsiStringMap(Adb_dm.CollDiag.Buf, Adb_dm.CollDiag.posData, word(Diagnosis_code_CL011));
        if 'Z00.0Z00.1Z00.2Z00.3Z10.8Z23.2Z23.8Z24.6Z27.4Z27.8'.Contains(mkb) and mkb.Contains('.') then
        begin
          PregIsProf := True;
          preg.FDiagnosis.Add(diag);
          Break;
        end;
        runDiag := runDiag.NextSibling;
      end;

      if PregIsProf then
      begin
        pat.FPregledi.Add(preg);
      end;
      runPreg := runPreg.NextSibling;
    end;

    Adb_dm.lstPatGraph.Clear;
    i := Adb_dm.lstPatGraph.Add(pat);
    //pat.DataPos := runDataPat.DataPos;
    dat := pat.getDateMap(Adb_DM.AdbMain.Buf, Adb_dm.CollPatient.posData, word(PatientNew_BIRTH_DATE));
    log := TlogicalPatientNewSet(pat.getLogical40Map(Adb_dm.CollPatient.Buf, Adb_dm.CollPatient.posData, word(PatientNew_Logical)));
    profGR.SexMale := (TLogicalPatientNew.SEX_TYPE_M in log) ;
    profGR.CurrDate := dat;
    profGR.Adb_DM := Adb_DM;
    pat.FPregledi.Clear;
    pat.lstGraph.Clear;
    profGR.GeneratePeriod(pat);
    vtrGraph.DeleteChildren(vRootGraph);
    profGR.LoadVtrGraph(pat, i);

    //runPat := runPat.NextSibling;
    Break;
  end;

end;

procedure TfrmSuperHip.GetPlanedTypeL009(pregNode: PVirtualNode);
var
  nzisThr: TNzisThread;
  data: PAspRec;
begin

  //if (edtToken.Text = '') or (Now > TokenToTime) then
//  begin
//    btnTokenClick(nil);
//  end;

  //Adb_DM.CollPrac := CollPractica;
//  Adb_DM.CollDoc := CollDoctor;

  nzisThr := TNzisThread.Create(false, Adb_DM);
  nzisThr.FreeOnTerminate := True;
  nzisThr.IsTestNZIS := true;

  nzisThr.OnSended := NzisOnSended;
  nzisThr.HndSuperHip := Self.Handle;
  nzisThr.Node := pregNode;
  nzisThr.MsgType := TNzisMsgType.L009;
  nzisThr.token := '';
  nzisThr.CurrentCert := nil;
  nzisThr.Resume;
end;

function TfrmSuperHip.GetRootForNode(Node: PVirtualNode): PVirtualNode;
begin
  Result := Node;
  if Result = nil then Exit;
  Result := Node.Parent.Parent;
  //while (Result.Parent <> nil) and not (vsRoot in Result.States) do
//    Result := Result.Parent;
end;

procedure TfrmSuperHip.GetTextToDraw(node: PVirtualNode; Column: TColumnIndex; var text: string;
  var strPred, strSled, FilterText: string);
var
  prefix: string;
  p: integer;
  data: PAspRec;
  ArrStr: TArray<String>;
  StrNumber, i: Integer;
begin
  data := pointer(PByte(node) + lenNode);
  FilterText := FinderRec.strSearch;
  case data.vid of
    vvPatient:
    begin
      case Column of
        0:
        begin
          prefix := AnsiUpperCase(Copy(vtrPregledPat.Header.Columns[Column].Text, 1, vtrPregledPat.Header.Columns[Column].Tag));
          if AnsiUpperCase(Text).StartsWith(prefix + AnsiUpperCase(FinderRec.strSearch)) then
          begin
            p := AnsiUpperCase(Text).IndexOf((AnsiUpperCase(FilterText)));
            FilterText := Copy(Text, p + 1, length(FinderRec.strSearch));
            strPred := Copy(Text, 1, p);
            strSled := copy(Text, p+length(FilterText) + 1, length(Text) + 1 -   (p+length(FilterText)));
          end;
        end;
        1:
        begin
          if vtrPregledPat.Header.Columns[Column].Tag < 0 then
          begin
            text := '';
            Exit;
          end;
          ArrStr := Text.Split([' ']);
          StrNumber := vtrPregledPat.Header.Columns[Column].Tag;
          if StrNumber >= Length(ArrStr) then
          begin
            text := '';
            Exit;
          end;
          if AnsiUpperCase(ArrStr[StrNumber]).StartsWith(AnsiUpperCase(FinderRec.strSearch)) then
          begin
            p := 0;// AnsiUpperCase(Text).IndexOf((AnsiUpperCase(FilterText)));
            for i := 0 to StrNumber - 1 do
            begin
              p := p + Length(ArrStr[i]) + 1;
            end;
            FilterText := Copy(Text, p + 1, length(FinderRec.strSearch));
            strPred := Copy(Text, 1, p);
            strSled := copy(Text, p+length(FilterText) + 1, length(Text) + 1 -   (p+length(FilterText)));
          end
          else
            text := '';
        end;
      end;
    end;
  end;
  //prefix := AnsiUpperCase(Copy(vtrPregledPat.Header.Columns[Column].Text, 1, vtrPregledPat.Header.Columns[Column].Tag));
//  FilterText := FinderRec.strSearch;
//  //if AnsiUpperCase(Text).StartsWith(prefix + AnsiUpperCase(FinderRec.strSearch)) then
//  begin
//    p := AnsiUpperCase(Text).IndexOf((AnsiUpperCase(FilterText)));
//    FilterText := Copy(Text, p + 1, length(FinderRec.strSearch));
//    strPred := Copy(Text, 1, p);
//    strSled := copy(Text, p+length(FilterText) + 1, length(Text) + 1 -   (p+length(FilterText)));
//  end;
end;

procedure TfrmSuperHip.GetTokenNzis(Sender: TObject);
var
  preg: TRealPregledNewItem;
  oldStatus: Word;
begin
  if (edtToken.Text = '') or (Now > TokenToTime) then
  begin
    httpNZIS.OnData := httpNZISDataToken;
    httpNZIS.Close;
    try
      httpNZIS.Get('https://auth.his.bg/token');
      ReadToken(ResultNzisToken.Text);
    except
      if Sender is TRealPregledNewItem then
      begin
        preg := TRealPregledNewItem(Sender);
        oldStatus := Adb_dm.CollPregled.GetWordMap(preg.DataPos, word(PregledNew_NZIS_STATUS));
        case oldStatus of
          3: //
          begin
            Adb_dm.CollPregled.SetWordMap(preg.DataPos, word(PregledNew_NZIS_STATUS), 16);// провален отваряне
            FmxProfForm.CheckKep := false;
          end;
          13: //
          begin
            Adb_dm.CollPregled.SetWordMap(preg.DataPos, word(PregledNew_NZIS_STATUS), 15);// провален готов
            FmxProfForm.CheckKep := false;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.GetTokenThread;
var
  nzisThr: TNzisThread;
begin
  //Adb_DM.CollPrac := CollPractica;
//  Adb_DM.CollDoc := CollDoctor;

  nzisThr := TNzisThread.Create(false, Adb_DM);
  nzisThr.FreeOnTerminate := True;
  nzisThr.IsTestNZIS := true;

  nzisThr.OnSended := NzisOnSended;
  nzisThr.HndSuperHip := Self.Handle;
  nzisThr.Node := nil;
  nzisThr.MsgType := TNzisMsgType.NNNN;
  nzisThr.token := '';
  nzisThr.CurrentCert := CertForThread;
  nzisThr.Resume;
end;

procedure TfrmSuperHip.grdNomCellEdited(const Sender: TObject;
  const AEditor: TControl; const AColumn: TColumn; const ARow: Integer;
  var ChangeData: Boolean; var NewData: string);
begin
  //
end;

procedure TfrmSuperHip.grdNomCellEditing(const Sender: TObject; const AEditor: TControl; const AColumn: TColumn; const ARow: Integer);
begin
  EditorGrid := TWinControl(AEditor);
  //if AEditor is TEdit then
//  begin
//    TEdit(AEditor).NumbersOnly := True;
//
//  end;
end;

procedure TfrmSuperHip.grdNomDblClick(Sender: TObject);
var
  TempFindedItem: TBaseItem;
  data: PAspRec;
  node: PVirtualNode;
  baseCol: TBaseCollection;
begin


  if (grdNom.Tag > 0) and  false then
  begin
    baseCol  := TBaseCollection(grdNom.Tag);
    data := baseCol.ListNodes[grdNom.Selected.Row];
    node := Pointer(PByte(data) - lenNode);
    vtrPregledPat.Selected[node] := True;
    vtrPregledPat.FocusedNode := node;
  end;
end;

procedure TfrmSuperHip.grdNomSelect(Sender: TObject);
var
  TempFindedItem: TBaseItem;
  data: PAspRec;
  node: PVirtualNode;
begin
  if (GetKeyState(VK_CONTROL) >= 0) then Exit;

  if grdNom.Selected.Row < 0 then Exit;
  if grdNom.Tag = 0 then Exit;

  data := TBaseCollection(grdNom.Tag).ListNodes[grdNom.Selected.Row];

  node := Pointer(PByte(data) - lenNode);
  vtrPregledPat.Selected[node] := True;
  vtrPregledPat.FocusedNode := node;
end;

procedure TfrmSuperHip.grdSearchMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  FmxProfForm.Focused := nil;
  edt1.SetFocus;
  grdSearch.SetFocus;
end;

procedure TfrmSuperHip.grdSearchMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin

  if not hntMain.ShowingHint then
  begin
    hntMain.Title := 'ddd';
    hntMain.Description := 'desk';
    hntMain.HideAfter := 5000;
    hntMain.ShowHint(grdSearch.ClientToScreen(Point(x, y)));
  end;
  //else
//    hntLek.PositionAt(Rect);;
  if (thrSearch <> nil) and thrSearch.IsSorting then
  begin
    //grdSearch.Hint := 'ddddd';
    //Application.ShowHint := True;
  end;
end;

procedure TfrmSuperHip.grdSearchMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  dataList, data, dataPat: PAspRec;
  nodeList, nodePat: PVirtualNode;
  SelRow: Integer;
begin
  if not grdSearch.Focused then
  begin
    self.SetFocusedControl(grdSearch);
    //grdSearch.SetFocus;
  end;
  CanSelectNodeFromSearchGrid := true;
  //if grdSearch.Selected.Row < 0 then
//  begin
//    Exit;
//  end
//  else
//  begin
//    SelRow := grdSearch.Selected.Row;
//  end;
//  if (CollPregled.ListDataPos.count - 1) < SelRow then
//  Exit;
//  if CollPregled.lastBottom = - 1 then
//  begin
//    nodeList := CollPregled.ListDataPos[SelRow];
//  end
//  else
//  begin
//    nodeList := CollPregled.ListDataPos[SelRow + CollPregled.offsetTop];
//  end;
//  nodePat := nodeList.Parent;
//  dataPat := Pointer(PByte(nodePat) + lenNode);
//  data := Pointer(PByte(nodeList) + lenNode);
//  if vtrPregledPat.GetFirstSelected <> nodeList then
//  begin
//    vtrPregledPat.Selected[nodeList] := True;
//    InternalChangeWorkPage(tsFMXForm);
//    tsFMXForm.Tag := data.DataPos;
//    tsNZIS.Tag := integer(nodeList);
//
//
//    //GenerateNzisXml(nodeList);
//
//    ShowPregledFMX(dataPat, data, nodeList); //  показване на динамичната форма
//  end
end;

procedure TfrmSuperHip.grdSearchSelect(Sender: TObject);
var
  dataList, data, tagData, dataPat, dataPreg: PAspRec;
  runNode, nodeList, nodePat: PVirtualNode;
  bufLink: Pointer;
  linkPos, FPosLinkData: Cardinal;
  pCardinalData: PCardinal;
  SelRow: Integer;
  CollForSearch: TBaseCollection;
begin


  if not grdSearch.Focused then Exit;
  if FmxFinderFrm.IsFinding then Exit;
  if grdSearch.Selected.Row < 0 then
  begin
    Exit;
  end
  else
  begin
    SelRow := grdSearch.Selected.Row;
  end;

  CollForSearch := TBaseCollection(grdSearch.Tag);
  if (CollForSearch.ListDataPos.count - 1) < SelRow then
    Exit;
  if CollForSearch.lastBottom = - 1 then
  begin
    nodeList := CollForSearch.ListDataPos[SelRow];
  end
  else
  begin
    nodeList := CollForSearch.ListDataPos[SelRow + CollForSearch.offsetTop];
  end;

  data := pointer(PByte(nodeList) + lenNode);
  case data.vid of

    vvPregled:
    begin
      Stopwatch := TStopwatch.StartNew;
      vtrPregledPat.BeginUpdate;
      dataPreg := data;
      if vtrPregledPat.GetFirstSelected <> nodeList then
      begin
        TVSTSyncHelper.SyncToNode(vtrPregledPat, nodeList);
        //vtrPregledPat.TopNode := nodeList;
//        vtrPregledPat.FocusedNode := nodeList;
       // vtrPregledPat.ClearSelection;
       // vtrPregledPat.Selected[nodeList] := True;
        //Application.ProcessMessages;

        //InternalChangeWorkPage(tsFMXForm);
        //tsFMXForm.Tag := data.DataPos;
        //tsNZIS.Tag := integer(nodeList);

        ShowPregledFMX(dataPat, data, nodeList); //  показване на динамичната форма
        //Application.ProcessMessages;
      end ;
      vtrPregledPat.endUpdate;
      //vtrPregledPat.ScrollIntoView(nodeList, False);
      Elapsed := Stopwatch.Elapsed;
      mmoTest.Lines.Add( Format('grdSearchSelect за %f',[ Elapsed.TotalMilliseconds]));
    end;
    vvPatient:
    begin
      if vtrPregledPat.GetFirstSelected <> nodeList then
      begin
        vtrPregledPat.Selected[nodeList] := True;
      end ;
    end;
  end;

  //if vtrPregledPat.GetFirstSelected <> nodeList then
//  begin
//    vtrPregledPat.Selected[nodeList] := True;
//    Application.ProcessMessages;
//
//    InternalChangeWorkPage(tsFMXForm);
//    tsFMXForm.Tag := data.DataPos;
//    tsNZIS.Tag := integer(nodeList);
//
//    //ShowPregledFMX(dataPat, data, nodeList); //  показване на динамичната форма
//    Application.ProcessMessages;
//  end
 // else
 // begin
    //vtrPreglediChange_Patients(vtrPregledPat, nodeList);
 // end;




  //case TVtrVid(grdSearch.Tag) of
//    vvPatient:
//    begin
//      if (CollPatient.ListDataPos.count - 1) < SelRow then
//      Exit;
//      nodeList := CollPatient.ListDataPos[SelRow];
//
//      //begin
////        runNode := vtrPregledPat.RootNode.FirstChild.FirstChild;
////        while runNode <> nil  do
////        begin
////          data := pointer(PByte(runNode) + lenNode);
////          if data.DataPos = dataList.DataPos then
////          begin
////            vtrPregledPat.Selected[runNode] := True;
////            Break;
////          end;
////          runNode := runNode.NextSibling;
////        end;
////        ProfGraphClick(nil);
////        vtrGraph.Repaint;
////      end;
//    end;
//    vvPregled:
//    begin
//      if (CollPregled.ListDataPos.count - 1) < SelRow then
//      Exit;
//      if CollPregled.lastBottom = - 1 then
//      begin
//        nodeList := CollPregled.ListDataPos[SelRow];
//      end
//      else
//      begin
//        nodeList := CollPregled.ListDataPos[SelRow + CollPregled.offsetTop];
//      end;
//      nodePat := nodeList.Parent;
//      dataPat := Pointer(PByte(nodePat) + lenNode);
//      data := Pointer(PByte(nodeList) + lenNode);
//      if vtrPregledPat.GetFirstSelected <> nodeList then
//      begin
//        //if CanSelectNodeFromSearchGrid then
//        begin
//          vtrPregledPat.Selected[nodeList] := True;
//          Application.ProcessMessages;
//          grdSearch.Tag := word(vvPregled);
//         // CanSelectNodeFromSearchGrid := False;
//        end;
//        //vtrPregledPat.RepaintNode(nodeList);
//        //vtrPreglediChange_Patients(vtrPregledPat, nodeList);
//        InternalChangeWorkPage(tsFMXForm);
//        tsFMXForm.Tag := data.DataPos;
//        tsNZIS.Tag := integer(nodeList);
//
//
//        //GenerateNzisXml(nodeList);
//
//        ShowPregledFMX(dataPat, data, nodeList); //  показване на динамичната форма
//        Application.ProcessMessages;
//        //FmxProfForm.scldlyt1.Repaint;
//        //vtrPregledPat.Selected[nodeList] := True;
//      end
//      else
//      begin
//        //vtrPreglediChange_Patients(vtrPregledPat, nodeList);
//      end;
//
//      //buflink := AspectsLinkPatPregFile.Buf;
////      linkPos := 100;
////      pCardinalData := pointer(PByte(buflink));
////      FPosLinkData := pCardinalData^;
////      while linkpos < FPosLinkData do
////      begin
////        RunNode := pointer(PByte(bufLink) + linkpos);
////        data := pointer(PByte(RunNode) + lenNode);
////        if data.DataPos = dataList.DataPos then
////        begin
////          if vtrPregledPat.GetFirstSelected <> runNode then
////          begin
////            vtrPregledPat.Selected[runNode] := True;
////          end
////          else
////          begin
////            vtrPreglediChange_Patients(vtrPregledPat, runNode);
////          end;
////          FmxProfForm.WindowState := wsMaximized;
////          //fmxCntrDyn.ChangeActiveForm(FmxProfForm);
////            Break;
////        end;
////        Inc(linkPos, LenData);
////      end;
//    end;
//  end;



end;

procedure TfrmSuperHip.GrdSearhKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  runNode, nodeList, nodePat: PVirtualNode;
  dataPat, data: PAspRec;
  selRow: Integer;
begin
  Exit;
  if grdSearch.Selected.Row < 0 then
  begin
    Exit;
  end
  else
  begin
    SelRow := grdSearch.Selected.Row;
  end;
  if Adb_dm.CollPregled.lastBottom = - 1 then
  begin
    nodeList := Adb_dm.CollPregled.ListDataPos[SelRow];
  end
  else
  begin
    nodeList := Adb_dm.CollPregled.ListDataPos[SelRow + Adb_dm.CollPregled.offsetTop];
  end;
  nodePat := nodeList.Parent;
  dataPat := Pointer(PByte(nodePat) + lenNode);
  data := Pointer(PByte(nodeList) + lenNode);
  if vtrPregledPat.GetFirstSelected <> nodeList then
  begin
    //vtrPregledPat.Selected[nodeList] := True;
    //grdSearch.Tag := word(vvPregled);
    //
    //vtrPregledPat.RepaintNode(nodeList);
    //vtrPreglediChange_Patients(vtrPregledPat, nodeList);
    //InternalChangeWorkPage(tsFMXForm);
//    tsFMXForm.Tag := data.DataPos;
//    tsNZIS.Tag := integer(nodeList);


    //GenerateNzisXml(nodeList);

    //ShowPregledFMX(dataPat, data, nodeList); //  показване на динамичната форма
    //vtrPregledPat.Selected[nodeList] := True;
  end
  else
  begin
    //vtrPreglediChange_Patients(vtrPregledPat, nodeList);
  end;
end;

procedure TfrmSuperHip.InitAdb;
begin
  Adb_DM := TADBDataModule.Create;
  Adb_DM.FDM := Fdm;
  Adb_DM.OnClearColl := Adb_DMOnClearColl;
end;

//procedure TfrmSuperHip.InitColl;
//begin
//  CollPatGR := TRealPatientNewColl.Create(TRealPatientNewItem);
//
//  CollDoctor := TRealDoctorColl.Create(TRealDoctorItem);
//  CollOtherDoctor := TRealOtherDoctorColl.Create(TRealOtherDoctorItem);
//  ListDoctorForFDB := TList<TDoctorItem>.create;
//  ListPregledLinkForInsert := TList<PVirtualNode>.create;
//
//  CollUnfav := TRealUnfavColl.Create(TRealUnfavItem);
//  CollUnfav.OnCurrentYearChange := OnChangeYear;
//  CollMkb := TRealMkbColl.Create(TMkbItem);
//  CollPregled := TRealPregledNewColl.Create(TRealPregledNewItem);
//  CollPregled.OnKeyUpGridSearch := GrdSearhKeyUp;
//  ListPregledForFDB := TList<TPregledNewItem>.Create;
//  CollPatient := TRealPatientNewColl.Create(TRealPatientNewItem);
//
//  ListPatientForFDB := TList<TPatientNewItem>.Create;
//  CollPatPis := TRealPatientNZOKColl.Create(TRealPatientNZOKItem);
//  AcollpatFromDoctor := TRealPatientNewColl.Create(TRealPatientNewItem);
//  ACollPatFDB := TRealPatientNewColl.Create(TRealPatientNewItem);
//  ACollNovozapisani := TRealPatientNewColl.Create(TRealPatientNewItem);
//
//  CollDiag := TRealDiagnosisColl.Create(TRealDiagnosisItem);
//  CollMDN := TRealMDNColl.Create(TRealMDNItem);
//  CollPregledVtor := Tlist<TRealPregledNewItem>.Create;
//  CollPregledPrim := Tlist<TRealPregledNewItem>.Create;
//  CollAnalsNew := TAnalsNewColl.Create(TAnalsNewItem);
//  CollPractica := TPracticaColl.Create(TPracticaItem);
//  CollEbl := TRealExam_boln_listColl.Create(TRealExam_boln_listItem);
//  CollExamAnal := TRealExamAnalysisColl.Create(TRealExamAnalysisItem);
//  CollExamImun := TRealExamImmunizationColl.Create(TRealExamImmunizationItem);
//  CollProceduresNomen := TRealProceduresColl.Create(TRealProceduresItem);
//  CollProceduresPreg := TRealProceduresColl.Create(TRealProceduresItem);
//  CollCardProf := TRealKARTA_PROFILAKTIKA2017Coll.Create(TRealKARTA_PROFILAKTIKA2017Item);
//  CollMedNapr := TRealBLANKA_MED_NAPRColl.Create(TRealBLANKA_MED_NAPRItem);
//  CollMedNapr3A := TRealBLANKA_MED_NAPR_3AColl.Create(TRealBLANKA_MED_NAPR_3AItem);
//  CollMedNaprHosp := TRealHOSPITALIZATIONColl.Create(TRealHOSPITALIZATIONItem);
//  CollMedNaprLkk := TRealEXAM_LKKColl.Create(TRealEXAM_LKKItem);
//  CollIncMdn := TRealINC_MDNColl.Create(TRealINC_MDNItem);
//  CollIncMN := TRealINC_NAPRColl.Create(TRealINC_NAPRItem);
//
//  CollNzisToken := TNzisTokenColl.Create(TNzisTokenItem);
//  CollCertificates := TCertificatesColl.Create(TCertificatesItem);
//
//  CollNZIS_PLANNED_TYPE := TRealNZIS_PLANNED_TYPEColl.Create(TRealNZIS_PLANNED_TYPEItem);
//  CollNZIS_QUESTIONNAIRE_RESPONSE := TRealNZIS_QUESTIONNAIRE_RESPONSEColl.Create(TRealNZIS_QUESTIONNAIRE_RESPONSEItem);
//  CollNZIS_QUESTIONNAIRE_ANSWER := TRealNZIS_QUESTIONNAIRE_ANSWERColl.Create(TRealNZIS_QUESTIONNAIRE_ANSWERItem);
//  CollNZIS_ANSWER_VALUE := TRealNZIS_ANSWER_VALUEColl.Create(TRealNZIS_ANSWER_VALUEItem);
//  CollNZIS_DIAGNOSTIC_REPORT := TRealNZIS_DIAGNOSTIC_REPORTColl.Create(TRealNZIS_DIAGNOSTIC_REPORTItem);
//  CollNzis_RESULT_DIAGNOSTIC_REPORT := TRealNZIS_RESULT_DIAGNOSTIC_REPORTColl.Create(TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem);
//
//  CL132Coll := TRealCL132Coll.Create(TRealCL132Item);
//  CL050Coll := TCL050Coll.Create(TCL050Item);
//  CL006Coll := TRealCL006Coll.Create(TRealCL006Item);
//  CL022Coll := TRealCL022Coll.Create(TRealCL022Item);
//  CL024Coll := TRealCL024Coll.Create(TRealCL024Item);
//  CL037Coll := TRealCL037Coll.Create(TRealCL037Item);
//  CL038Coll := TRealCL038Coll.Create(TRealCL038Item);
//  CL088Coll := TRealCL088Coll.Create(TRealCL088Item);
//  CL134Coll := TRealCL134Coll.Create(TRealCL134Item);
//  CL139Coll := TRealCL139Coll.Create(TRealCL139Item);
//  CL142Coll := TRealCL142Coll.Create(TRealCL142Item);
//  CL144Coll := TRealCL144Coll.Create(TRealCL144Item);
//  PR001Coll := TRealPR001Coll.Create(TRealPR001Item);
//  NomenNzisColl := TNomenNzisColl.Create(TNomenNzisItem);
//
//  //LSNomenNzisNames := TStringList.Create;
//  ListNomenNzisNames := TList<TNomenNzisRec>.Create;
//  lstPatGraph := TList<TRealPatientNewItem>.Create;
//
//  //ListNodes  := TList<PAspRec>.Create;
//  PatientTemp := TRealPatientNewItem.Create(nil);
//  PregledTemp := TPregledNewItem.Create(nil);
//  preg1 := TPregledNewItem.Create(nil);
//  preg2 := TPregledNewItem.Create(nil);
//  DiagTemp  := TDiagnosisItem.Create(nil);
//  MDNTemp := TMDNItem.Create(nil);
//  MNTemp := TBLANKA_MED_NAPRItem.Create(nil);
//  ExamAnalTemp := TExamAnalysisItem.Create(nil);
//  DoctorTemp := TDoctorItem.Create(nil);
//  AnalTemp:= TAnalsNewItem.Create(nil);
//  Cl022temp := TCL022Item.Create(nil);
//  Cl132temp := TRealCL132Item.Create(nil);
//  PR001Temp := TRealPR001Item.Create(nil);
//  CL088Temp := TRealCl088Item.Create(nil);
//  ProcTemp := TRealProceduresItem.Create(nil);
//  NZIS_PLANNED_TYPETemp := TRealNZIS_PLANNED_TYPEItem.Create(nil);
//  NZIS_QUESTIONNAIRE_RESPONSETemp := TRealNZIS_QUESTIONNAIRE_RESPONSEItem.Create(nil);
//  NZIS_QUESTIONNAIRE_ANSWERTemp := TRealNZIS_QUESTIONNAIRE_ANSWERItem.Create(nil);
//  NZIS_ANSWER_VALUETemp := TRealNZIS_ANSWER_VALUEItem.Create(nil);
//  NZIS_DIAGNOSTIC_REPORTTemp := TRealNZIS_DIAGNOSTIC_REPORTItem.Create(nil);
//  NZIS_Result_DIAGNOSTIC_REPORTTemp := TRealNZIS_Result_DIAGNOSTIC_REPORTItem.Create(nil);
//
//  LoadLinkOptions;
//  LoadLinkFilter;
//  //TFilterTreeLoader.LoadLinkFilters('LinkFilters.lnk', vtrSearch, AspectsFilterLinkFile);
//end;

procedure TfrmSuperHip.initDB;
begin
  Stopwatch := TStopwatch.StartNew;
  mmoTest.Lines.BeginUpdate;
  if Fdm = nil then
  begin
    Fdm := TDUNzis.Create(nil);
  end;
  mmoTest.Lines.Add('FDbName =' + FDbName);
  if FDbName = '' then
    exit;
  Fdm.InitDb(FDbName);
  if (Fdm.FGuidDB.Count > 0) then
  begin
    FindADB(Fdm.FGuidDB);
  end;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.lines.add(Format('nnnnn: %f', [Elapsed.TotalMilliseconds]));
  if Adb_DM.AdbMain = nil then  // не е намерено адб отговарящо на гдб-то. трябва да се импортира.
  begin
    mmoTest.Lines.Add('не е намерено адб отговарящо на гдб-то. трябва да се импортира');
    RolPnlDoktorOPL.Enabled := False;
    RolPnlDoktorOPL.Repaint;
  end
  else  // намерено е адб отговарящо на гдб-то. Може да се отвори и зареди
  begin
    mmoTest.Lines.Add('намерено е адб отговарящо на гдб-то. Може да се отвори и зареди');
    if AspectsNomFile = nil then
      OpenBufNomenNzis(paramstr(2) + 'NzisNomen.adb');
    OpenADB(Adb_DM.AdbMain);
    OpenCmd(Adb_DM.AdbMain);
    FindLNK(Adb_DM.AdbMain.GUID);
    if AspectsLinkPatPregFile <> nil then
      OpenLinkPatPreg(AspectsLinkPatPregFile);
     // AspectsLinkPatPregFile.OpenLinkFile;
    StartHistoryThread(FDbName);
    StartCertThread;
    if chkAspectDistr.Checked then
    begin
      StartAspectPerformerThread;
    end;

  end;
  mmoTest.Lines.EndUpdate;
end;

procedure TfrmSuperHip.InitExpression;
begin

end;

procedure TfrmSuperHip.InitFMXDyn;
begin

   //Exit;
   FmxProfForm := TfrmProfFormFMX.Create(nil);
   FmxProfForm.OnAddNewMdn := AddMdnInPregled;
   FmxProfForm.OnAddNewAnal := AddAnalInMdn;
   FmxProfForm.OnDeleteNewMdn := DeleteMdnFromPregled;
   FmxProfForm.OnDeleteNewAnal := DeleteAnalFromMdn;
   FmxProfForm.OnDeleteNewDiag := DeleteDiag;
   FmxProfForm.OnchangeColl := ChangeColl;
   FmxProfForm.OnChoicerAnal := ChoiceAnal;
   FmxProfForm.OnChoicerMkb := ChoiceMKB;
   FmxProfForm.OnSelectMkb := SelectMKB;
   FmxProfForm.OnSowHint := OnFmxHint;
   FmxProfForm.OnOpenPregled := OnOpenPregled1;
   FmxProfForm.OnClosePregled := OnClosePregled1;
   FmxProfForm.OnEditPregled := OnEditPregled1;
   FmxProfForm.OnOfLinePregled := OnOfLinePregled;
   FmxProfForm.OnGetPlanedTypeL009 := OnGetPlanedTypeL009_1;
   FmxProfForm.OnReShowProfForm := ReShowProfForm;
   FmxProfForm.OnAddNewMn := AddMnInPregled;
   //FmxProfForm.cbbDiagClinicStatus.OnMouseEnter := vtrPregledPatMouseLeave;


   FmxProfForm.Adb_dm := Adb_DM;
   FmxProfForm.NasMesto := FNasMesto;
   FmxProfForm.profGR := profGR;
   FmxProfForm.mmotest := mmotest;
   FmxProfForm.fmxCntrDyn := fmxCntrDyn;
   FmxProfForm.VtrGrapf := vtrGraph;
   FmxProfForm.VtrPregLink := vtrPregledPat;
   FmxProfForm.TmpVtr := tmpVtr;
   tmpVtr.FmxProfForm := FmxProfForm;

end;

procedure TfrmSuperHip.InitGlobalValues;
begin
  gAppDir := ExtractFilePath(Application.ExeName);
  gADB_Dir := gAppDir + '\ADB_DataBase';
  gHipLinkFileName := gADB_Dir + '\PerfLink.lnk';
  gHipAdbFileName := gADB_Dir + '\Performer.adb';


end;



procedure TfrmSuperHip.InitHttpNzis;
begin
  
  httpNZIS := TElHTTPSClient.Create(nil);

  httpNZIS.Name := 'httpNZIS';
  httpNZIS.SocketTimeout := 10000;
  httpNZIS.LocalPort := 0;
  httpNZIS.IncomingSpeedLimit := 0;
  httpNZIS.OutgoingSpeedLimit := 0;
  httpNZIS.SocksAuthentication := saNoAuthentication;
  httpNZIS.WebTunnelPort := 3128;
  httpNZIS.OnCertificateNeededEx := httpNZISCertificateNeededEx;
  httpNZIS.OnCertificateValidate := httpNZISCertificateValidate;
  httpNZIS.Versions := [sbTLS1, sbTLS11, sbTLS12];
  httpNZIS.UseExtendedMasterSecret := False;
  httpNZIS.SSLOptions := [ssloAutoAddServerNameExtension];
  httpNZIS.UseSSLSessionResumption := False;
  httpNZIS.ForceResumeIfDestinationChanges := False;
  httpNZIS.RenegotiationAttackPreventionMode := rapmAuto;
  httpNZIS.AutoValidateCertificates := False;
  httpNZIS.SSLEnabled := False;
  httpNZIS.RequestCompressionLevel := 0;
  httpNZIS.RequestCompressionGZip := False;
  httpNZIS.KeepAlivePolicy := kapStandardDefined;
  httpNZIS.HTTPVersion := hvHTTP11;
  httpNZIS.UseNTLMAuth := False;
  httpNZIS.UseDigestAuth := False;
  httpNZIS.PersistentAuthHeader := True;
  httpNZIS.ForceNTLMAuth := False;
  httpNZIS.Use100Continue := False;
  httpNZIS.HTTPProxyPort := 3128;
  httpNZIS.HTTPProxyAuthentication := wtaNoAuthentication;
  httpNZIS.UseHTTPProxy := False;
  httpNZIS.IgnoreUnknownTransferEncodings := False;
  httpNZIS.AllowHashSignInURL := False;
  //.OnData := httpNZISDataToken;
  //httpNZIS.OnPreparedHeaders := httpNZISPreparedHeaders;
  httpNZIS.SuppressRedirectionContent := False;
  //httpNZIS.DNS.Servers.Add('8.8.8.8');

  httpNZIS.OnPreparedHeaders := httpNZISPreparedHeaders;
  httpNZIS.OnData := OnDataNzis;

  WinCertStorage := TElWinCertStorage.Create(nil);
  WinCertStorage.SystemStores.Text := 'MY';
  //ShowMessage(httpNZIS.RuntimeLicense);

  CertStorage := TsbxCertificateStorage.Create(nil);

  WinCertStorage.RuntimeLicense  := '5342444641444E585246323032313132303443344D393232353000000000000000000000000000005A5036484E353744000038554650524E4839314636410000';

  httpNZIS.RuntimeLicense  := '5342444641444E585246323032313132303443344D393232353000000000000000000000000000005A5036484E353744000038554650524E4839314636410000';
  CertStorage.RuntimeLicense := '5342444641444E585246323032313132303443344D393232353000000000000000000000000000005A5036484E353744000038554650524E4839314636410000';
end;

procedure TfrmSuperHip.InitVTRs;
var
  data: PAspRec;
begin

  vtrMinaliPregledi.DoubleBuffered := True;
  vtrMinaliPregledi.NodeDataSize := SizeOf(TAspRec);
  vtrPregledi.NodeDataSize := SizeOf(TNodeRec);
  vtrPregledi.DoubleBuffered := True;
  vtrSpisyci.NodeDataSize := SizeOf(TNodeRec);
  vtrRole.NodeDataSize := SizeOf(TNodeRec);
  vtrNomenNzis.NodeDataSize := SizeOf(TAspRec);
  vtrFDB.NodeDataSize := SizeOf(TAspRec);
  vtrGraph.NodeDataSize := SizeOf(TAspRec);
  vtrRecentDB.NodeDataSize := SizeOf(TAspRec);
  vtrProfReg.NodeDataSize := SizeOf(TAspRec);


  vRootRole := vtrRole.AddChild(nil, nil);
  data := vtrRole.GetNodeData(vRootRole);
  data.index := -1;
  data.vid := vvRole;


  vRootNomenNzis := vtrNomenNzis.AddChild(nil, nil);
  data := vtrNomenNzis.GetNodeData(vRootNomenNzis);
  data.vid := vvNomenNzis;
  data.index := -1;

  vRootNzisBiznes := vtrNomenNzis.AddChild(nil, nil);
  data := vtrNomenNzis.GetNodeData(vRootNzisBiznes);
  data.vid := vvNzisBiznes;
  data.index := -1;

  vRootGraph := vtrGraph.AddChild(nil, nil);
  data := vtrGraph.GetNodeData(vRootGraph);
  data.vid := vvNone;
  data.index := 0;

  vRootRecentDB := vtrRecentDB.AddChild(nil, nil);
  data := vtrRecentDB.GetNodeData(vRootRecentDB);
  data.vid := vvNone;
  data.index := -1;
  option.LoadVtrRecentDB;
end;

procedure TfrmSuperHip.InternalChangeTreePage(Sheet: TTabSheet);
begin
  pgcTree.ActivePage := Sheet;
  pgcTreeChange(nil);
end;

procedure TfrmSuperHip.InternalChangeWorkPage(Sheet: TTabSheet);
begin
  pgcWork.ActivePage := Sheet;
  pgcWorkChange(nil);
end;

//procedure TfrmSuperHip.IterateFilterPatField(Sender: TBaseVirtualTree; Node: PVirtualNode; AData: Pointer; var Abort: Boolean);
//var
//  dynControl: TBaseControl;
//  data, dataPat: PAspRec;
//  pat: TPatientItem;
//  preg: TPregledItem;
//  tstr: TString;
//begin
//  dynControl := TBaseControl(AData);
//  data := vtrPregledi.GetNodeData(node);
//
//  case data.vid of
//    vvPatient://pacienti
//    begin
//      pat := CollPatient.Items[data.index];
//      tstr := tstring.create;
//      case dynControl.ColIndex of
//        1: tstr.str := pat.FName;
//        2: tstr.str := pat.EGN;// egn
//      end;
//      FilterStringsHave.Add(tstr);
//    end;
//    //2: // pregled
////    begin
////      if dynControl.TableType <> 2 then
////        Exit;
////      dataPat := Sender.GetNodeData(node.Parent);
////      pat := CollPatient.Items[dataPat.index];
////      preg := pat.FPregledi[data.index];
////      tstr := tstring.create;
////      case dynControl.ColIndex of
////        3: tstr.str := preg.NRN;
////        //2: tstr.str := pat.EGN;// egn
////      end;
////      FilterStringsHave.Add(tstr);
////    end;
//  end;
//
//end;

//procedure TfrmSuperHip.IterateFilterPregled(Sender: TBaseVirtualTree; Node: PVirtualNode; AData: Pointer; var Abort: Boolean);
//var
//  data, dataPat: PAspRec;
//  fileName: string;
//  pat: TPatientItem;
//  i, startI: Integer;
//begin
//  if node = nil then
//    Exit;
//
//  data := Sender.GetNodeData(node);
//
//  case data.vid of
//    vvPatient:// pacient
//    begin
//      pat := CollPatient.Items[data.index];
//      //if pat.FPregledi.Count > listFilterCount.Count then
////      begin
////        startI := listFilterCount.Count;
////        //for i := startI to pat.FPregledi.Count do
//////          listFilterCount(0);
////      end;
//      //listFilterCount.FPregledi.Count] := listFilterCount.FPregledi.Count] + 1;
//      //maxCountPregledInPat := Max(maxCountPregledInPat, pat.FPregledi.Count);
////      SetLength(listFilter, maxCountPregledInPat);
//      vtrPregledi.IsFiltered[node] := (pat.FPregledi.Count <> FFilterCountPregled) and (FFilterCountPregled <> - 1);
//
//    end;
//    vvPregled, vvMedNapr:
//    begin
//      vtrPregledi.IsFiltered[node] := vtrPregledi.IsFiltered[node.Parent];
//    end;
//
//  end;
//end;

//procedure TfrmSuperHip.IterateFilterPregledField(Sender: TBaseVirtualTree; Node: PVirtualNode; AData: Pointer; var Abort: Boolean);
//var
//  dynControl: TBaseControl;
//  data, dataPat: PAspRec;
//  pat: TPatientItem;
//  preg: TPregledItem;
//  tstr: TString;
//begin
//  dynControl := TBaseControl(AData);
//  data := vtrPregledi.GetNodeData(node);
//  case data.vid of
//    vvPregled: // pregled
//    begin
//      dataPat := Sender.GetNodeData(node.Parent);
//      pat := CollPatient.Items[dataPat.index];
//      preg := pat.FPregledi[data.index];
//      tstr := tstring.create;
//      case dynControl.ColIndex of
//        3: tstr.str := IntToStr(preg.AmbListNo);
//        4: tstr.str := DateToStr(preg.StartDate);
//      end;
//      FilterStringsHave.Add(tstr);
//    end;
//  end;
//
//end;

procedure TfrmSuperHip.IterateFilterGraph(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
var
  Adata, dataPat, dataPeriod: PAspRec;
  pat: TRealPatientNewItem;
  GraphDay: Integer;
begin
  if Node.Parent = nil then  Exit;

  Adata := Sender.GetNodeData(node);
  case Adata.vid of
    vvPatient://, vvNone:
    begin
      vtrGraph.IsFiltered[node] := True;
    end;
    vvNone:
    begin
      if Adata.index < 0 then
      begin
        vtrGraph.IsFiltered[node] := True;
      end;
    end;
    vvCl132:
    begin
      dataPat := vtrGraph.GetNodeData(node.Parent.Parent);
      pat := Adb_dm.lstPatGraph[dataPat.index];
      dataPeriod := vtrGraph.GetNodeData(node.Parent);
      case dataPeriod.index of
        -2: //текущи
        begin
          GraphDay := StrToInt(edtGraphDay.Text);
          vtrGraph.IsFiltered[node] := GraphDay  < DaysBetween(pat.lstGraph[Adata.index].endDate, UserDate) ;
          if not vtrGraph.IsFiltered[node] then
          begin
            vtrGraph.IsFiltered[node.Parent] := False;
            vtrGraph.IsFiltered[node.Parent.Parent] := False;
          end;
        end;

      end;

    end;
  end;
end;

procedure TfrmSuperHip.IterateFilterOnlyCloning(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
var
  Adata, DataParent: PAspRec;
  APat: TRealPatientNewItem;
  APreg: TRealPregledNewItem;
  PregledDate: TDate;
begin
  Adata := Sender.GetNodeData(node);
  case Adata.vid of
    vvPatient:
    begin
      APat := Adb_dm.ACollPatFDB.Items[Adata.index];
      Sender.IsFiltered[Node] := (APat.FClonings.Count = 0);
    end;
  end;

end;

procedure TfrmSuperHip.IterateRemontPat(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
var
  Adata: PAspRec;
  pat: TRealPatientNewItem;
  ibSql: TIBSQL;
  patID: Integer;
begin
  ibsql :=  Fdm.ibsqlCommand;
  Adata := Sender.GetNodeData(Node);
  case Adata.vid of
    vvPatient:
    begin
      pat := Adb_dm.ACollPatFDB.Items[adata.index];
      patId := pat.getIntMap(Adb_DM.AdbMain.buf, Adb_dm.CollPatient.posData, word(PatientNew_ID));
      ibsql.Close;
      ibsql.SQL.Text :=
          'update pacient pa' + #13#10 +
          'set' + #13#10 +
          'pa.date_otpisvane = :date_otpisvane,' + #13#10 +
          'pa.pat_kind = 2' + #13#10 +
          'where pa.id = :patID';
      ibsql.ParamByName('patID').AsInteger := patId;
      ibsql.ParamByName('date_otpisvane').AsDate := pat.LastPregled.getDateMap(Adb_DM.AdbMain.buf, Adb_dm.CollPatient.posData, word(PregledNew_START_DATE)) + 1;
      ibsql.ExecQuery;
    end;
  end;

end;

procedure TfrmSuperHip.IterateRemoveFilter(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
begin
  Sender.IsFiltered[Node] := false;
end;

procedure TfrmSuperHip.IterateSendedNzisNomen(Sender: TBaseVirtualTree; Node: PVirtualNode; AData: Pointer; var Abort: Boolean);
begin
  Application.ProcessMessages;
  BtnSendToNzisNomen(node);
end;

procedure TfrmSuperHip.IterateSendedNzisXmlToCL(Sender: TBaseVirtualTree; Node: PVirtualNode; AData: Pointer; var Abort: Boolean);
begin
  Application.ProcessMessages;
  BtnXMLtoCL000(node);
end;

procedure TfrmSuperHip.IterateTempCollapsed(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
var
  AData: PAspRec;
begin
  AData := Sender.GetNodeData(node);
  if (AData.vid = PAspRec(Data).vid) then
  begin
    Sender.Expanded[Node] := false;
  end;
end;

procedure TfrmSuperHip.IterateTempExpand(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
var
  AData: PAspRec;
begin
  AData := Sender.GetNodeData(node);
  if (AData.vid = PAspRec(Data).vid) then
  begin
    Sender.Expanded[Node] := True;
  end;
end;

procedure TfrmSuperHip.IterateTestEmpty(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
begin

end;

procedure TfrmSuperHip.lblDescrDblClick(Sender: TObject);
begin
  //frRTF.
  frRTF.Print('test');
end;

procedure TfrmSuperHip.lblHintClick(Sender: TObject);
begin
  ShowMessage(System.GetUILanguages(0));
end;

procedure TfrmSuperHip.LinkpatClick(Sender: TObject);
begin
  //thrSearch.CollPatForSearch.Buf := AspectsHipFile.Buf;
 // thrSearch.CollPatForSearch.posData := AspectsHipFile.FPosData;
  grdSearch.Tag := word(vvPatient);
  //thrSearch.CollPat.ShowLinksGrid(grdSearch);
end;

procedure TfrmSuperHip.LinkPregClick(Sender: TObject);
begin
  //thrSearch.collPregForSearch.Buf := AspectsHipFile.Buf;
//  thrSearch.collPregForSearch.posData := AspectsHipFile.FPosData;
//  grdSearch.Tag := word(vvPregled);
//  thrSearch.collPregForSearch.ShowLinksGrid(grdSearch);
end;

procedure TfrmSuperHip.LoadADB;
var
  btnPregledSpec : TRoleButton;
begin
  //RolPnlDoctorSpecStartRole(nil);
  //btnPregledSpec  := spltvw1.BtnFromName('Прегледи');
//  btnPregledSpec.MaxValue := CollPatient.Count;
//
//
//  PreglediClick(btnPregledSpec);
end;

procedure TfrmSuperHip.LoadDbOnCNT(sender: TObject; collType, cnt: Integer);
begin
  PostMessage(Self.Handle, WM_CNT_LOAD_DB, cnt, collType);
end;

procedure TfrmSuperHip.LoadDbOnProgres(sender: TObject; collType, progres: Integer);
begin
  PostMessage(Self.Handle, WM_PROGRES_LOAD_DB, progres, collType);
end;

procedure TfrmSuperHip.LoadFromNzisNewNomen(nomenId: integer);
var
  nzisThr: TNzisThread;
begin
  nzisThr := TNzisThread.Create(true);
  nzisThr.FreeOnTerminate := True;
  nzisThr.IsTestNZIS := False;
  nzisThr.NomenID := Format('CL%.3d', [nomenId]);
  nzisThr.OnSended := NzisOnSended;
  nzisThr.HndSuperHip := Self.Handle;
  nzisThr.Node := nil;
  nzisThr.MsgType := TNzisMsgType.C001;

  nzisThr.StreamData :=  Adb_DM.ListNomenNzisNames[nomenId].xmlStream;
  nzisThr.Resume;
end;

procedure TfrmSuperHip.LoadLinkFilter;
var
  fileLinkFilterName: string;
  Fstream: TFileStream;
  vFilterRoot: PVirtualNode;
  LinkPos: Cardinal;
  pCardinalData: PCardinal;
begin
  if AspectsFilterLinkFile <> nil then
  begin
    vtrSearch.InternalDisconnectNode(vtrSearch.RootNode.FirstChild, false);
    AspectsFilterLinkFile.Free;
    AspectsFilterLinkFile := nil;
  end;

  fileLinkFilterName := 'LinkFilters.lnk';

  if FileExists(fileLinkFilterName) then
  begin
    AspectsFilterLinkFile := TMappedLinkFile.Create(fileLinkFilterName, false, TGUID.Empty);
    AspectsFilterLinkFile.FVTR := vtrSearch;
  end
  else
  begin
    Fstream := TFileStream.Create(fileLinkFilterName,fmCreate);
    Fstream.Size := 27000000;
    Fstream.Free;
    AspectsFilterLinkFile := TMappedLinkFile.Create(fileLinkFilterName, true, TGUID.Empty);
    AspectsFilterLinkFile.FVTR := vtrSearch;
    linkpos := 100;
    AspectsFilterLinkFile.AddNewNode(vvRootFilter, 0, vtrSearch.RootNode, amAddChildLast, vFilterRoot, linkPos);
    pCardinalData := pointer(PByte(AspectsFilterLinkFile.Buf) + 4);
    pCardinalData^ := Cardinal(AspectsFilterLinkFile.Buf);

    pCardinalData := pointer(PByte(AspectsFilterLinkFile.Buf) + 8);
    pCardinalData^ := Cardinal(vtrSearch.RootNode);

    vtrSearch.EndUpdate;
    vtrSearch.UpdateScrollBars(true);
    vtrSearch.InvalidateToBottom(vtrSearch.RootNode);

    vtrSearch.InternalDisconnectNode(vtrSearch.RootNode.FirstChild, false);
    AspectsFilterLinkFile.Free;
    AspectsFilterLinkFile := nil;

    AspectsFilterLinkFile := TMappedLinkFile.Create(fileLinkFilterName, false, TGUID.Empty);
    AspectsFilterLinkFile.FVTR := vtrSearch;
  end;

  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('MapLink за %f',[Elapsed.TotalMilliseconds]));


  Stopwatch := TStopwatch.StartNew;
  AspectsFilterLinkFile.OpenLinkFile;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('ЗарежданеLinkfilters %d за %f',[vtrSearch.RootNode.TotalCount,  Elapsed.TotalMilliseconds]));

end;

procedure TfrmSuperHip.LoadLinkOptions;
var
  fileLinkOptName: string;
  Fstream: TFileStream;
  vOptRoot: PVirtualNode;
  LinkPos: Cardinal;
  pCardinalData: PCardinal;
begin
  if AspectsOptionsLinkFile <> nil then
  begin
    vtrLinkOptions.InternalDisconnectNode(vtrLinkOptions.RootNode.FirstChild, false);
    AspectsOptionsLinkFile.Free;
    AspectsOptionsLinkFile := nil;
  end;

  fileLinkOptName := 'LinkOptions.lnk';

  if FileExists(fileLinkOptName) then
  begin
    AspectsOptionsLinkFile := TMappedLinkFile.Create(fileLinkOptName, false, TGUID.Empty);
    AspectsOptionsLinkFile.FVTR := vtrLinkOptions;
  end
  else
  begin
    Fstream := TFileStream.Create(fileLinkOptName,fmCreate);
    Fstream.Size := 7000000;
    Fstream.Free;
    AspectsOptionsLinkFile := TMappedLinkFile.Create(fileLinkOptName, true, TGUID.Empty);
    AspectsOptionsLinkFile.FVTR := vtrLinkOptions;
    linkpos := 100;
    AspectsOptionsLinkFile.AddNewNode(vvRootOptions, 0, vtrLinkOptions.RootNode, amAddChildLast, vOptRoot, linkPos);
    pCardinalData := pointer(PByte(AspectsOptionsLinkFile.Buf) + 4);
    pCardinalData^ := Cardinal(AspectsOptionsLinkFile.Buf);

    pCardinalData := pointer(PByte(AspectsOptionsLinkFile.Buf) + 8);
    pCardinalData^ := Cardinal(vtrLinkOptions.RootNode);

    vtrLinkOptions.EndUpdate;
    vtrLinkOptions.UpdateScrollBars(true);
    vtrLinkOptions.InvalidateToBottom(vtrLinkOptions.RootNode);

    vtrLinkOptions.InternalDisconnectNode(vtrLinkOptions.RootNode.FirstChild, false);
    AspectsOptionsLinkFile.Free;
    AspectsOptionsLinkFile := nil;

    AspectsOptionsLinkFile := TMappedLinkFile.Create(fileLinkOptName, false, TGUID.Empty);
    AspectsOptionsLinkFile.FVTR := vtrLinkOptions;
  end;

  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('MapLink за %f',[Elapsed.TotalMilliseconds]));


  Stopwatch := TStopwatch.StartNew;
  AspectsOptionsLinkFile.OpenLinkFile;
  Adb_dm.CollPregled.linkOptions := AspectsOptionsLinkFile;
  Adb_dm.CollPatient.linkOptions := AspectsOptionsLinkFile;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('ЗарежданеLinkOptions %d за %f',[vtrLinkOptions.RootNode.TotalCount,  Elapsed.TotalMilliseconds]));

end;

procedure TfrmSuperHip.LoadTempVtrMSG;
var
  msgID: string;
  i, j, CurrentI: Integer;
  pyrvi, wtori: Integer;
  vPat, vReq, vResp: PVirtualNode;
  data: PAspRec;
  msg: TNzisReqRespItem;
begin
  vtrTemp.BeginUpdate;
  vtrTemp.Clear;

  vPatImportNzis := vtrTemp.AddChild(nil, nil);
    data := vtrTemp.GetNodeData(vPatImportNzis);
    data.vid := vvPatientNewRoot;
    data.index := -1;
    vImportNzis := vtrTemp.AddChild(nil, nil);
    data := vtrTemp.GetNodeData(vImportNzis);
    data.vid := vvNone;
    data.index := -1;

    vImportNzisPregled := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisPregled);
    data.vid := vvPregled;
    data.index := -1;
    vImportNzisNapr := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisNapr);
    data.vid := vvMDN;
    data.index := -1;
    vImportNzisRec := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisRec);
    data.vid := vvRecepta;
    data.index := -1;
    vImportNzisImun := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisImun);
    data.vid := vvExamImun;
    data.index := -1;
    vImportNzisHosp := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisHosp);
    data.vid := vvHosp;
    data.index := -1;
    vImportNzisObshti := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisObshti);
    data.vid := vvNomenNzis;
    data.index := -1;

    Adb_dm.AmsgColl.SortByMessageId;
    msgID := '';
    pyrvi := 0;
    wtori := 1;
    for i := 0 to Adb_dm.AmsgColl.Count - 1 do
    begin
      if msgID = Adb_dm.AmsgColl.Items[i].PRecord.messageId then
      begin
        Inc(wtori);
        dec(pyrvi);
        msg := Adb_dm.AmsgColl.Items[i];

        case byte(msg.PRecord.Logical) of
          1:
          begin
            if msg.Pat = nil then
            begin
              vReq := vtrTemp.AddChild(vImportNzisPregled, nil);
            end
            else
            begin
              vReq := vtrTemp.AddChild(vPatImportNzis, nil);
              //Adb_DM.GetPatNodes()
              //for j := 0 to  msg.Pat.FLstMsgImportNzis.Count - 1 do
//              begin
//                v
//              end;
            end;
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
          2:
          begin
            vReq := vtrTemp.AddChild(vImportNzisNapr, nil);
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
          4:
          begin
            vReq := vtrTemp.AddChild(vImportNzisRec, nil);
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
          8:
          begin
            vReq := vtrTemp.AddChild(vImportNzisImun, nil);
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
          16:
          begin
            vReq := vtrTemp.AddChild(vImportNzisHosp, nil);
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
          32:
          begin
            vReq := vtrTemp.AddChild(vImportNzisObshti, nil);
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
        end;
        if Adb_dm.AmsgColl.Items[i].PRecord.msgNom < Adb_dm.AmsgColl.Items[CurrentI].PRecord.msgNom then
        begin
          //SetLength(msgColl.Items[CurrentI].PRecord.REQ, length(msgColl.Items[CurrentI].PRecord.REQ)-2);
          msg.PRecord.RESP := Adb_dm.AmsgColl.Items[CurrentI].PRecord.REQ;
          vReq.Dummy := Adb_dm.AmsgColl.Items[i].PRecord.msgNom;
          Adb_dm.AmsgColl.Items[i].Node := vReq;
          vResp.Dummy := Adb_dm.AmsgColl.Items[CurrentI].PRecord.msgNom;
          data := vtrTemp.GetNodeData(vReq);
          data.index := i;
          data := vtrTemp.GetNodeData(vResp);
          data.index := CurrentI;
        end
        else
        begin
          //SetLength(msgColl.Items[i].PRecord.REQ, length(msgColl.Items[i].PRecord.REQ)-2);
          Adb_dm.AmsgColl.Items[CurrentI].PRecord.RESP := msg.PRecord.REQ;
          vReq.Dummy := Adb_dm.AmsgColl.Items[CurrentI].PRecord.msgNom;
          Adb_dm.AmsgColl.Items[CurrentI].Node := vReq;
          vResp.Dummy := Adb_dm.AmsgColl.Items[i].PRecord.msgNom;
          data := vtrTemp.GetNodeData(vResp);
          data.index := i;
          data := vtrTemp.GetNodeData(vReq);
          data.index := CurrentI;
        end;
      end
      else
      begin
        msgID := Adb_dm.AmsgColl.Items[i].PRecord.messageId;
        CurrentI := i;
        Inc(pyrvi);
        Dec(wtori);
        if pyrvi > 1 then
        begin
          pyrvi := 1;
          mmoTest.Lines.Add(Adb_dm.AmsgColl.Items[i - 1].PRecord.messageId);
        end;
      end;
    end;

  vtrTemp.EndUpdate;
end;

procedure TfrmSuperHip.LoadTempVtrMSG1;
var
  msgID: string;
  i, j, CurrentI: Integer;
  pyrvi, wtori: Integer;
  vReq, vResp, vpat: PVirtualNode;
  data: PAspRec;
  msg: TNzisReqRespItem;
  pat: TRealPatientNewItem;
  patNodes: TPatNodes;
begin
  vtrTemp.NodeDataSize := SizeOf(tAspRec);
  vtrTemp.BeginUpdate;
  vtrTemp.Clear;

    vPatImportNzis := vtrTemp.AddChild(nil, nil);
    data := vtrTemp.GetNodeData(vPatImportNzis);
    data.vid := vvPatientNewRoot;
    data.index := -1;

    vImportNzis := vtrTemp.AddChild(nil, nil);
    data := vtrTemp.GetNodeData(vImportNzis);
    data.vid := vvNone;
    data.index := -1;

    vImportNzisPregled := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisPregled);
    data.vid := vvPregled;
    data.index := -1;
    vImportNzisNapr := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisNapr);
    data.vid := vvMDN;
    data.index := -1;
    vImportNzisRec := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisRec);
    data.vid := vvRecepta;
    data.index := -1;
    vImportNzisImun := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisImun);
    data.vid := vvExamImun;
    data.index := -1;
    vImportNzisHosp := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisHosp);
    data.vid := vvHosp;
    data.index := -1;
    vImportNzisObshti := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisObshti);
    data.vid := vvNomenNzis;
    data.index := -1;

    Adb_dm.AmsgColl.SortByMessageId;
    msgID := '';
    pyrvi := 0;
    wtori := 1;
    for i := 0 to Adb_dm.AmsgColl.CollPat.Count - 1 do
    begin
      pat := Adb_dm.AmsgColl.CollPat.Items[i];
      vpat := vtrTemp.AddChild(vPatImportNzis, nil);
      data := vtrTemp.GetNodeData(vpat);
      data.vid := vvPatient;
      data.index := -1;
      data.DataPos := pat.DataPos;
      patNodes := Adb_DM.GetPatNodes(pat.FNode);

      //for j := 0 to msgColl.CollPat.Items[i].FLstMsgImportNzis.Count - 1 do
//      begin
//       // Adb_DM.GetPatNodes()
//      end;
    end;


    for i := 0 to Adb_dm.AmsgColl.Count - 1 do
    begin
      if msgID = Adb_dm.AmsgColl.Items[i].PRecord.messageId then
      begin
        Inc(wtori);
        dec(pyrvi);
        msg := Adb_dm.AmsgColl.Items[i];

        case byte(msg.PRecord.Logical) of
          1:
          begin
            if msg.Pat = nil then
            begin
              vReq := vtrTemp.AddChild(vImportNzisPregled, nil);
              vResp := vtrTemp.AddChild(vReq, nil);
            end
            else
            begin
               vReq := nil;
              //Caption := 'ddd';
             // Continue;
              //vReq := vtrTemp.AddChild(vPatImportNzis, nil);
            end;
            //vResp := vtrTemp.AddChild(vReq, nil);
          end;
          2:
          begin
            vReq := vtrTemp.AddChild(vImportNzisNapr, nil);
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
          4:
          begin
            vReq := vtrTemp.AddChild(vImportNzisRec, nil);
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
          8:
          begin
            vReq := vtrTemp.AddChild(vImportNzisImun, nil);
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
          16:
          begin
            vReq := vtrTemp.AddChild(vImportNzisHosp, nil);
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
          32:
          begin
            vReq := vtrTemp.AddChild(vImportNzisObshti, nil);
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
        end;
        if vReq <> nil then
        begin
          if Adb_dm.AmsgColl.Items[i].PRecord.msgNom < Adb_dm.AmsgColl.Items[CurrentI].PRecord.msgNom then
          begin
            //SetLength(msgColl.Items[CurrentI].PRecord.REQ, length(msgColl.Items[CurrentI].PRecord.REQ)-2);
            msg.PRecord.RESP := Adb_dm.AmsgColl.Items[CurrentI].PRecord.REQ;
            vReq.Dummy := Adb_dm.AmsgColl.Items[i].PRecord.msgNom;
            Adb_dm.AmsgColl.Items[i].Node := vReq;
            vResp.Dummy := Adb_dm.AmsgColl.Items[CurrentI].PRecord.msgNom;
            data := vtrTemp.GetNodeData(vReq);
            data.index := i;
            data := vtrTemp.GetNodeData(vResp);
            data.index := CurrentI;
          end
          else
          begin
            //SetLength(msgColl.Items[i].PRecord.REQ, length(msgColl.Items[i].PRecord.REQ)-2);
            Adb_dm.AmsgColl.Items[CurrentI].PRecord.RESP := msg.PRecord.REQ;
            vReq.Dummy := Adb_dm.AmsgColl.Items[CurrentI].PRecord.msgNom;
            Adb_dm.AmsgColl.Items[CurrentI].Node := vReq;
            vResp.Dummy := Adb_dm.AmsgColl.Items[i].PRecord.msgNom;
            data := vtrTemp.GetNodeData(vResp);
            data.index := i;
            data := vtrTemp.GetNodeData(vReq);
            data.index := CurrentI;
          end;
        end;
      end
      else
      begin
        msgID := Adb_dm.AmsgColl.Items[i].PRecord.messageId;
        CurrentI := i;
        Inc(pyrvi);
        Dec(wtori);
        if pyrvi > 1 then
        begin
          pyrvi := 1;
          mmoTest.Lines.Add(Adb_dm.AmsgColl.Items[i - 1].PRecord.messageId);
        end;
      end;
    end;

  vtrTemp.EndUpdate;
end;

procedure TfrmSuperHip.LoadTempVtrMSG2;
var
  msgID: string;
  i, j, k, CurrentI: Integer;
  pyrvi, wtori: Integer;
  vReq, vResp, vpat, vMsg, vPreg, vRun: PVirtualNode;
  data, dataRun: PAspRec;
  msg: TNzisReqRespItem;
  pat: TRealPatientNewItem;
  patNodes: TPatNodes;
  Dublikat: Boolean;
begin
  vtrTemp.NodeDataSize := SizeOf(tAspRec);
  vtrTemp.BeginUpdate;
  vtrTemp.Clear;

    vPatImportNzis := vtrTemp.AddChild(nil, nil);
    data := vtrTemp.GetNodeData(vPatImportNzis);
    data.vid := vvPatientNewRoot;
    data.index := -1;

    vImportNzis := vtrTemp.AddChild(nil, nil);
    data := vtrTemp.GetNodeData(vImportNzis);
    data.vid := vvNone;
    data.index := -1;

    vImportNzisPregled := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisPregled);
    data.vid := vvPregledNewRoot;
    data.index := -1;
    vImportNzisNapr := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisNapr);
    data.vid := vvMDN;
    data.index := -1;
    vImportNzisRec := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisRec);
    data.vid := vvRecepta;
    data.index := -1;
    vImportNzisImun := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisImun);
    data.vid := vvExamImun;
    data.index := -1;
    vImportNzisHosp := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisHosp);
    data.vid := vvHosp;
    data.index := -1;
    vImportNzisObshti := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisObshti);
    data.vid := vvNomenNzis;
    data.index := -1;

    Adb_dm.AmsgColl.SortByMessageId;
    msgID := '';
    pyrvi := 0;
    wtori := 1;
    for i := 0 to Adb_dm.AmsgColl.CollPat.Count - 1 do
    begin
      pat := Adb_dm.AmsgColl.CollPat.Items[i];
      if Adb_dm.AmsgColl.CollPat.Items[i].FLstMsgImportNzis.Count > 0 then
      begin
        vpat := vtrTemp.AddChild(vPatImportNzis, nil);
        data := vtrTemp.GetNodeData(vpat);
        data.vid := vvPatient;
        data.index := i;
        data.DataPos := pat.DataPos;
        if pat.FNode <> nil then
        begin
          patNodes := Adb_DM.GetPatNodes(pat.FNode);
        end
        else
        begin
          Caption := 'ddd';
        end;

        for j := 0 to Adb_dm.AmsgColl.CollPat.Items[i].FLstMsgImportNzis.Count - 1 do
        begin
          msg := TNzisReqRespItem(Adb_dm.AmsgColl.CollPat.Items[i].FLstMsgImportNzis[j]);
          if (msg.PRecord.NRN = '25162A02B91A') then
                Caption := 'ddd';
          if msg.Preg = nil then
          begin
            vMsg := vtrTemp.AddChild(vpat, nil);
            data := vtrTemp.GetNodeData(vMsg);
            data.vid := vvNzisMessages;
            data.index := j;
            msg.Node := vMsg;
          end
          else
          begin
            Dublikat := False;
            vRun  := vpat.FirstChild;
            while vRun <> nil do
            begin
              dataRun := vtrTemp.GetNodeData(vRun);
              if (dataRun.DataPos = msg.Preg.DataPos) and (dataRun.DataPos > 0) then
              begin
                if dataRun.vid = vvNzisMessages then
                  Caption := 'ddd';
                Dublikat := True;
                Break;
              end;
              vRun := vRun.NextSibling;// въртя прегледите
            end;

            if Dublikat then
            begin
              vMsg := vtrTemp.AddChild(vrun, nil);
              data := vtrTemp.GetNodeData(vMsg);
              data.vid := vvNzisMessages;
              data.index := j;
              msg.Node := vMsg;
            end
            else
            begin
              vPreg := vtrTemp.AddChild(vpat, nil);
              data := vtrTemp.GetNodeData(vPreg);
              data.vid := vvPregled;
              data.DataPos := msg.Preg.DataPos;
              data.index := -1;

              vMsg := vtrTemp.AddChild(vPreg, nil);
              data := vtrTemp.GetNodeData(vMsg);
              data.vid := vvNzisMessages;
              data.index := j;
              msg.Node := vMsg;
            end;
          end;
        end;
      end
      else
      begin

      end;
    end;


    for i := 0 to Adb_dm.AmsgColl.Count - 1 do
    begin
      msg := Adb_dm.AmsgColl.Items[i];
      if (msg.PRecord.NRN = '25153D04122B') then
                Caption := 'ddd';
      if (msg.Pat = nil) then // and (msgColl.Items[i].PRecord.patEgn <> '') then
      begin
        //mmoTest.Lines.Add(msgColl.Items[i].PRecord.patEgn);

        case byte(msg.PRecord.Logical) of
          1://X
          begin
            vReq := vtrTemp.AddChild(vImportNzisPregled, nil);
            data := vtrTemp.GetNodeData(vReq);
            data.vid := vvNzisMessages;
            data.index := i;
            msg.Node := vReq;
          end;
          2:
          begin
            vReq := vtrTemp.AddChild(vImportNzisNapr, nil);
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
          4:
          begin
            vReq := vtrTemp.AddChild(vImportNzisRec, nil);
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
          8:
          begin
            vReq := vtrTemp.AddChild(vImportNzisImun, nil);
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
          16:
          begin
            vReq := vtrTemp.AddChild(vImportNzisHosp, nil);
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
          32:
          begin
            vReq := vtrTemp.AddChild(vImportNzisObshti, nil);
            vResp := vtrTemp.AddChild(vReq, nil);
          end;
        end;
      end;
    end;


  vtrTemp.FullExpand();
  vtrTemp.EndUpdate;
end;

procedure TfrmSuperHip.LoadTempVtrMSG3;
var
  msgID: string;
  i, j, k, CurrentI: Integer;
  pyrvi, wtori: Integer;
  vReq, vResp, vpat, vMsg, vPreg, vRun: PVirtualNode;
  data, dataRun: PAspRec;
  msg: TNzisReqRespItem;
  pat: TRealPatientNewItem;
  patNodes: TPatNodes;
  Dublikat: Boolean;
begin
  vtrTemp.NodeDataSize := SizeOf(tAspRec);
  vtrTemp.BeginUpdate;
  vtrTemp.Clear;

    vPatImportNzis := vtrTemp.AddChild(nil, nil);
    data := vtrTemp.GetNodeData(vPatImportNzis);
    data.vid := vvPatientNewRoot;
    data.index := -1;

    vImportNzis := vtrTemp.AddChild(nil, nil);
    data := vtrTemp.GetNodeData(vImportNzis);
    data.vid := vvNone;
    data.index := -1;

    vImportNzisPregled := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisPregled);
    data.vid := vvPregledNewRoot;
    data.index := -1;
    vImportNzisNapr := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisNapr);
    data.vid := vvMDN;
    data.index := -1;
    vImportNzisRec := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisRec);
    data.vid := vvRecepta;
    data.index := -1;
    vImportNzisImun := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisImun);
    data.vid := vvExamImun;
    data.index := -1;
    vImportNzisHosp := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisHosp);
    data.vid := vvHosp;
    data.index := -1;
    vImportNzisObshti := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisObshti);
    data.vid := vvNomenNzis;
    data.index := -1;

    //msgColl.SortByMessageId;
    msgID := '';
    pyrvi := 0;
    wtori := 1;
    for i := 0 to Adb_dm.AmsgColl.CollPat.Count - 1 do
    begin
      pat := Adb_dm.AmsgColl.CollPat.Items[i];
      //if pat.DataPos > 0 then
      begin
        vpat := vtrTemp.AddChild(vPatImportNzis, nil);
        data := vtrTemp.GetNodeData(vpat);
        data.vid := vvPatient;
        data.index := i;
        data.DataPos := pat.DataPos;
        for j := 0 to pat.FLstMsgImportNzis.Count - 1 do
        begin
          msg := TNzisReqRespItem(pat.FLstMsgImportNzis[j]);
          vPreg := vtrTemp.AddChild(vpat, nil);
          data := vtrTemp.GetNodeData(vPreg);
          data.vid := vvPregled;
          data.DataPos := 0;//msg.Preg.DataPos;
          data.index := -1;

          vMsg := vtrTemp.AddChild(vPreg, nil);
          data := vtrTemp.GetNodeData(vMsg);
          data.vid := vvNzisMessages;
          data.index := j;
          msg.Node := vMsg;
        end;
      end;


      Continue;
      if Adb_dm.AmsgColl.CollPat.Items[i].FLstMsgImportNzis.Count > 0 then
      begin
        vpat := vtrTemp.AddChild(vPatImportNzis, nil);
        data := vtrTemp.GetNodeData(vpat);
        data.vid := vvPatient;
        data.index := i;
        data.DataPos := pat.DataPos;
        if pat.FNode <> nil then
        begin
          patNodes := Adb_DM.GetPatNodes(pat.FNode);
        end
        else
        begin
          Caption := 'ddd';
        end;

        for j := 0 to Adb_dm.AmsgColl.CollPat.Items[i].FLstMsgImportNzis.Count - 1 do
        begin
          msg := TNzisReqRespItem(Adb_dm.AmsgColl.CollPat.Items[i].FLstMsgImportNzis[j]);
          if (msg.PRecord.NRN = '25162A02B91A') then
                Caption := 'ddd';
          if msg.Preg = nil then
          begin
            vMsg := vtrTemp.AddChild(vpat, nil);
            data := vtrTemp.GetNodeData(vMsg);
            data.vid := vvNzisMessages;
            data.index := j;
            msg.Node := vMsg;
          end
          else
          begin
            Dublikat := False;
            vRun  := vpat.FirstChild;
            while vRun <> nil do
            begin
              dataRun := vtrTemp.GetNodeData(vRun);
              if (dataRun.DataPos = msg.Preg.DataPos) and (dataRun.DataPos > 0) then
              begin
                if dataRun.vid = vvNzisMessages then
                  Caption := 'ddd';
                Dublikat := True;
                Break;
              end;
              vRun := vRun.NextSibling;// въртя прегледите
            end;

            if Dublikat then
            begin
              vMsg := vtrTemp.AddChild(vrun, nil);
              data := vtrTemp.GetNodeData(vMsg);
              data.vid := vvNzisMessages;
              data.index := j;
              msg.Node := vMsg;
            end
            else
            begin
              vPreg := vtrTemp.AddChild(vpat, nil);
              data := vtrTemp.GetNodeData(vPreg);
              data.vid := vvPregled;
              data.DataPos := msg.Preg.DataPos;
              data.index := -1;

              vMsg := vtrTemp.AddChild(vPreg, nil);
              data := vtrTemp.GetNodeData(vMsg);
              data.vid := vvNzisMessages;
              data.index := j;
              msg.Node := vMsg;
            end;
          end;
        end;
      end
      else
      begin

      end;
    end;


    //for i := 0 to msgColl.Count - 1 do
//    begin
//      msg := msgColl.Items[i];
//      if (msg.PRecord.NRN = '25153D04122B') then
//                Caption := 'ddd';
//      if (msg.Pat = nil) then // and (msgColl.Items[i].PRecord.patEgn <> '') then
//      begin
//        //mmoTest.Lines.Add(msgColl.Items[i].PRecord.patEgn);
//
//        case byte(msg.PRecord.Logical) of
//          1://X
//          begin
//            vReq := vtrTemp.AddChild(vImportNzisPregled, nil);
//            data := vtrTemp.GetNodeData(vReq);
//            data.vid := vvNzisMessages;
//            data.index := i;
//            msg.Node := vReq;
//          end;
//          2:
//          begin
//            vReq := vtrTemp.AddChild(vImportNzisNapr, nil);
//            vResp := vtrTemp.AddChild(vReq, nil);
//          end;
//          4:
//          begin
//            vReq := vtrTemp.AddChild(vImportNzisRec, nil);
//            vResp := vtrTemp.AddChild(vReq, nil);
//          end;
//          8:
//          begin
//            vReq := vtrTemp.AddChild(vImportNzisImun, nil);
//            vResp := vtrTemp.AddChild(vReq, nil);
//          end;
//          16:
//          begin
//            vReq := vtrTemp.AddChild(vImportNzisHosp, nil);
//            vResp := vtrTemp.AddChild(vReq, nil);
//          end;
//          32:
//          begin
//            vReq := vtrTemp.AddChild(vImportNzisObshti, nil);
//            vResp := vtrTemp.AddChild(vReq, nil);
//          end;
//        end;
//      end;
//    end;


  //vtrTemp.FullExpand();
  vtrTemp.EndUpdate;
end;

procedure TfrmSuperHip.LoadTempVtrMSG4;
var
  msgID: string;
  i, j, k, m, CurrentI: Integer;
  pyrvi, wtori: Integer;
  vReq, vResp, vpat, vMsg, vPreg, vRun, vMdn, vIncMN, vIncDoc: PVirtualNode;
  data, dataRun: PAspRec;
  msg: TNzisReqRespItem;
  pat: TRealPatientNewItem;
  preg: TRealPregledNewItem;
  IncMN: TRealINC_NAPRItem;
  mdn: TRealMDNItem;
  patNodes: TPatNodes;
  Dublikat: Boolean;
begin
  Stopwatch := TStopwatch.StartNew;
  vtrTemp.NodeDataSize := SizeOf(tAspRec);
  vtrTemp.BeginUpdate;
  vtrTemp.Clear;

    vPatImportNzis := vtrTemp.AddChild(nil, nil);
    data := vtrTemp.GetNodeData(vPatImportNzis);
    data.vid := vvPatientNewRoot;
    data.index := -1;

    vImportNzis := vtrTemp.AddChild(nil, nil);
    data := vtrTemp.GetNodeData(vImportNzis);
    data.vid := vvNone;
    data.index := -1;

    vImportNzisPregled := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisPregled);
    data.vid := vvPregledNewRoot;
    data.index := -1;
    vImportNzisNapr := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisNapr);
    data.vid := vvMDN;
    data.index := -1;
    vImportNzisRec := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisRec);
    data.vid := vvRecepta;
    data.index := -1;
    vImportNzisImun := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisImun);
    data.vid := vvExamImun;
    data.index := -1;
    vImportNzisHosp := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisHosp);
    data.vid := vvHosp;
    data.index := -1;
    vImportNzisObshti := vtrTemp.AddChild(vImportNzis, nil);
    data := vtrTemp.GetNodeData(vImportNzisObshti);
    data.vid := vvNomenNzis;
    data.index := -1;

  for i := 0 to Adb_dm.AmsgColl.CollPat.Count - 1 do
  begin
    pat := Adb_dm.AmsgColl.CollPat.Items[i];
    if pat.FPregledi.Count = 0 then Continue;
    //if pat.FIncMNs.Count = 0 then Continue;

    vpat := vtrTemp.AddChild(vPatImportNzis, nil);
    data := vtrTemp.GetNodeData(vpat);
    data.vid := vvPatient;
    data.DataPos := pat.DataPos;
    data.index := i;
    for j := 0 to pat.FIncMNs.Count - 1 do
    begin
      IncMN := pat.FIncMNs[j];
      if IncMN.NRN = '25244A02FFD2' then
        Caption := 'ddd';
      if IncMN.FPregledi.Count = 0 then Continue;

      vIncMN := vtrTemp.AddChild(vPat, nil);
      data := vtrTemp.GetNodeData(vIncMN);
      data.vid := vvIncMN;
      data.DataPos := IncMN.DataPos;
      data.index := j;

      vIncDoc := vtrTemp.AddChild(vIncMN, nil);
      data := vtrTemp.GetNodeData(vIncDoc);
      data.vid := vvOtherDoctor;
      data.DataPos := IncMN.FIncDoctor.DataPos;
      data.index := IncMN.FIncDoctor.id;

      IncMN.LinkNode := vIncMN;
    end;
    for j := 0 to pat.FPregledi.Count - 1 do
    begin
      preg := pat.FPregledi[j];
      if preg.FLstMsgImportNzis.Count = 0 then Continue;
      if preg.NRN = '252462095FD4' then
        Caption := 'ddd';

      if (preg.FIncMN <> nil) and (preg.FIncMN.LinkNode <> nil) then
      begin
        vPreg := vtrTemp.AddChild(preg.FIncMN.LinkNode, nil);
      end
      else
      begin
        vPreg := vtrTemp.AddChild(vPat, nil);
      end;
      data := vtrTemp.GetNodeData(vPreg);
      data.vid := vvPregled;
      data.DataPos := Preg.DataPos;
      data.index := j;

      for k := 0 to Preg.FLstMsgImportNzis.Count - 1 do
      begin
        msg := Preg.FLstMsgImportNzis[k];
        vMsg := vtrTemp.AddChild(vPreg, nil);
        data := vtrTemp.GetNodeData(vMsg);
        data.vid := vvNzisMessages;
        data.index := k;
        msg.Node := vMsg;
      end;
      for k := 0 to preg.FMdns.Count - 1 do
      begin
        mdn := preg.FMdns[k];
        vMdn := vtrTemp.AddChild(vPreg, nil);
        data := vtrTemp.GetNodeData(vMdn);
        data.vid := vvMDN;
        data.DataPos := mdn.DataPos;
        data.index := k;
        if mdn.DataPos = 0 then
        begin
          Self.Tag := Integer(vMdn);
          Caption := 'ddd';
        end;

        for m := 0 to mdn.FLstMsgImportNzis.Count - 1 do
        begin
          msg := mdn.FLstMsgImportNzis[m];
          vMsg := vtrTemp.AddChild(vMdn, nil);
          data := vtrTemp.GetNodeData(vMsg);
          data.vid := vvNzisMessages;
          data.index := m;
          msg.Node := vMsg;
        end;
      end;

    end;
  end;

  vtrTemp.FullExpand();
  vtrTemp.EndUpdate;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('LoadTempVtrMSG4 за %f ', [Elapsed.TotalMilliseconds]));
end;

procedure TfrmSuperHip.LoadThreadDB(dbName: string);
var
  thrLoadDb: TLoadDBThread;
begin
  FNasMesto.addresColl.Buf := Adb_DM.AdbMain.Buf;
  FNasMesto.addresColl.posData := Adb_DM.AdbMain.FPosData;

  thrLoadDb := TLoadDBThread.Create(True, dbname);
  thrLoadDb.Buf := Adb_DM.AdbMain.Buf;
  thrLoadDb.FNasMesto := FNasMesto;
  //CollDoctor.Buf := AspectsHipFile.Buf;
//  CollDoctor.posData := AspectsHipFile.FPosData;
//  CollOtherDoctor.Buf := AspectsHipFile.Buf;
//  CollOtherDoctor.posData := AspectsHipFile.FPosData;
//  CollMkb.Buf := AspectsHipFile.Buf;
//  CollMkb.posData := AspectsHipFile.FPosData;
//  CollPatient.Buf := AspectsHipFile.Buf;
//  CollPatient.posData := AspectsHipFile.FPosData;
//  CollMDN.Buf := AspectsHipFile.Buf;
//  CollMDN.posData := AspectsHipFile.FPosData;
//  CollPregled.Buf := AspectsHipFile.Buf;
//  CollPregled.posData := AspectsHipFile.FPosData;
//  CollDiag.Buf := AspectsHipFile.Buf;
//  CollDiag.posData := AspectsHipFile.FPosData;
//  CollDiag.cmdFile := streamCmdFile;
//  CollPregled.FCollDiag := CollDiag;
//  Collmdn.FCollDiag := CollDiag;
//  CollUnfav.Buf := AspectsHipFile.Buf;
//  CollUnfav.posData := AspectsHipFile.FPosData;
//  CollPractica.Buf :=  AspectsHipFile.Buf;
//  CollPractica.posData := AspectsHipFile.FPosData;
//  CollEBL.Buf :=  AspectsHipFile.Buf;
//  CollEBL.posData := AspectsHipFile.FPosData;
//  CollExamAnal.Buf :=  AspectsHipFile.Buf;
//  CollExamAnal.posData := AspectsHipFile.FPosData;
//  CollExamImun.Buf :=  AspectsHipFile.Buf;
//  CollExamImun.posData := AspectsHipFile.FPosData;
//  CollProceduresNomen.Buf :=  AspectsHipFile.Buf;
//  CollProceduresNomen.posData := AspectsHipFile.FPosData;
//  CollCardProf.Buf :=  AspectsHipFile.Buf;
//  CollCardProf.posData := AspectsHipFile.FPosData;
//  CollMedNapr.Buf :=  AspectsHipFile.Buf;
//  CollMedNapr.posData := AspectsHipFile.FPosData;
//  CollMedNapr.FCollDiag := CollDiag;
//  CollMedNapr3A.Buf :=  AspectsHipFile.Buf;
//  CollMedNapr3A.posData := AspectsHipFile.FPosData;
//  CollMedNapr3A.FCollDiag := CollDiag;
//  CollMedNaprHosp.Buf :=  AspectsHipFile.Buf;
//  CollMedNaprHosp.posData := AspectsHipFile.FPosData;
//  CollMedNaprHosp.FCollDiag := CollDiag;
//  CollMedNaprLkk.Buf :=  AspectsHipFile.Buf;
//  CollMedNaprLkk.posData := AspectsHipFile.FPosData;
//  CollMedNaprLkk.FCollDiag := CollDiag;
//  CollIncMdn.Buf :=  AspectsHipFile.Buf;
//  CollIncMdn.posData := AspectsHipFile.FPosData;
//  CollIncMdn.FCollDiag := CollDiag;
//  CollIncMN.Buf :=  AspectsHipFile.Buf;
//  CollIncMN.posData := AspectsHipFile.FPosData;
//  CollIncMN.FCollDiag := CollDiag;

  thrLoadDb.FDBHelper := FDBHelper;


  //thrLoadDb.MKBColl := CollMkb;
//  thrLoadDb.PatientColl := CollPatient;
//  thrLoadDb.DoctorColl := CollDoctor;
//  thrLoadDb.PregledNewColl := CollPregled;
//  thrLoadDb.DiagColl := CollDiag;
//  thrLoadDb.UnFavColl := CollUnfav;
//  thrLoadDb.MDNColl := CollMDN;
//  thrLoadDb.PracticaColl := CollPractica;
//  thrLoadDb.EBLColl := CollEBL;
//  thrLoadDb.ExamAnalColl := CollExamAnal;
//  thrLoadDb.ExamImunColl := CollExamImun;
//  thrLoadDb.ProcCollNomen := CollProceduresNomen;
//  thrLoadDb.ProcCollPreg := CollProceduresPreg;
//  thrLoadDb.AdbNomen := AspectsNomFile;
//  thrLoadDb.Cl142Coll := CL142Coll;
//  thrLoadDb.KARTA_PROFILAKTIKA2017Coll := CollCardProf;
//  thrLoadDb.MedNaprColl := CollMedNapr;
//  thrLoadDb.MedNapr3AColl := CollMedNapr3A;
//  thrLoadDb.MedNaprHospColl := CollMedNaprHosp;
//  thrLoadDb.MedNaprLkkColl := CollMedNaprLkk;
//  thrLoadDb.IncMdnColl := CollIncMdn;
//  thrLoadDb.IncMNColl := CollIncMN;
//  thrLoadDb.OtherDoctorColl := CollOtherDoctor;
  thrLoadDb.LinkAnals := AspectsLinkNomenHipAnalFile;

  //thrLoadDb.FCollPregVtor := CollPregledVtor;
  //thrLoadDb.FCollMedNapr := CollMedNapr;
  thrLoadDb.FreeOnTerminate := True;
  thrLoadDb.OnTerminate := TerminateLoadDB;
  thrLoadDb.OnProgres := LoadDbOnProgres;
  thrLoadDb.OnCnt := LoadDbOnCNT;
  thrLoadDb.cmdFile := streamCmdFile;

  thrLoadDb.Guid := Adb_DM.AdbMain.GUID;
  thrLoadDb.Adb_dm := Adb_DM;
  thrLoadDb.Resume;
end;

procedure TfrmSuperHip.LoadVtrDoctor;
var
  vRootDoctor, vRootDeput: PVirtualNode;
  vDoctor: PVirtualNode;
  i: Integer;
  data: PAspRec;
  doc: TRealDoctorItem;
begin
  vtrDoctor.BeginUpdate;
  vtrDoctor.NodeDataSize := SizeOf(tAspRec);
  vRootDoctor := vtrDoctor.AddChild(nil, nil);
  data := vtrDoctor.GetNodeData(vRootDoctor);
  data.DataPos := 0;
  data.index := -1;
  data.vid := vvDoctorRoot;

  for i := 0 to Adb_dm.CollDoctor.Count - 1 do
  begin
    doc := Adb_dm.CollDoctor.Items[i];
    vDoctor := vtrDoctor.AddChild(vRootDoctor, nil);
    data := vtrDoctor.GetNodeData(vDoctor);
    data.DataPos := 0;
    data.index := i;
    data.vid := vvDoctor;
    doc.node := vDoctor;

    vRootDeput := vtrDoctor.AddChild(vDoctor, nil);
    data := vtrDoctor.GetNodeData(vRootDeput);
    data.DataPos := 0;
    data.index := -1;
    data.vid := vvRootDeput;
  end;
  vtrDoctor.FullExpand();
  vtrDoctor.EndUpdate;
end;

procedure TfrmSuperHip.LoadVtrFDB;
var
  i: Integer;
  TablesType: TTablesTypeHip;
  data: PAspRec;
  v: PVirtualNode;
begin
  if vtrFDB.RootNode.ChildCount > 0 then
    Exit;
  vtrFDB.BeginUpdate;

  vTablesRoot := vtrFDB.AddChild(nil, nil);
  data := vtrFDB.GetNodeData(vTablesRoot);
  data.vid := vvTables;
  data.index := -1;
  for TablesType := Low(TTablesTypeHip) to High(TTablesTypeHip) do
  begin
    case TablesType of
      BLANKA_MDN, PACIENT, PREGLED, ICD10CM, DOCTOR, UNFAV, Asp_Diag,
      Asp_PL_NZOK, Asp_EventManyTimes, PRACTICA, EXAM_BOLN_LIST, EXAM_ANALYSIS,
      EXAM_IMMUNIZATION, PROCEDURES, KARTA_PROFILAKTIKA2017, BLANKA_MED_NAPR,
      BLANKA_MED_NAPR_3A, INC_MDN,
      NZIS_PLANNED_TYPE, NZIS_QUESTIONNAIRE_RESPONSE, NZIS_ANSWER_VALUE,
      NZIS_QUESTIONNAIRE_ANSWER, NZIS_DIAGNOSTIC_REPORT, NZIS_RESULT_DIAGNOSTIC_REPORT,
      NzisToken, CERTIFICATES, HOSPITALIZATION, EXAM_LKK, INC_NAPR, Asp_Addres, Asp_OtherDoctor:
      begin
        v := vtrFDB.AddChild(vTablesRoot, nil);
        data := vtrFDB.GetNodeData(v);
        data.vid := vvTables;
        data.index := word(TablesType);
      end;
    end;
    
    //TRttiEnumerationType.GetName(TablesType);
  end;
  vtrFDB.FullExpand();
  vtrFDB.EndUpdate;
end;



//procedure TfrmSuperHip.LoadVtrFilter(FltrList: TList<ComboBoxHip.TFilterValues>; FilterColl: TBaseCollection; bufLinkVTR: Pointer);
//begin
//  frmFilter.Left := 100;// DynWinPanel1.leftlistfilter;
//  frmFilter.Top := 100;//DynWinPanel1.topListFilter;
//  //frmFilter.FltrList := FltrList;
////  frmFilter.FilterColl := FilterColl;
////  frmFilter.vtrBufForFilter := bufLinkVTR;
////  //frmFilter.listNodes := ListNodes;
////  frmFilter.vtrForFilter := vtrPregledPat;
////  frmFilter.vtrFilter.BeginUpdate;
////  frmFilter.vtrFilter.Clear;
////  frmFilter.vtrFilter.RootNodeCount := FltrList.Count;
////  frmFilter.vtrFilter.EndUpdate;
//  frmFilter.Show;
//end;

procedure TfrmSuperHip.LoadVtrMinaliPregledi(node: PVirtualNode; Apat: TRealPatientNewItem);
var
  dataNode, data, dataPregInMN: PAspRec;
  vPregNode, vPreg, run: PVirtualNode;
begin
  vtrMinaliPregledi.BeginUpdate;
  vtrMinaliPregledi.Clear;
  if node.ChildCount = 0 then
  begin
    vtrMinaliPregledi.EndUpdate;
    Exit;
  end;
  vPregNode := node.FirstChild;
  while vPregNode <> nil  do
  begin
    dataNode := pointer(PByte(vPregNode) + lenNode);
    case datanode.vid of
      vvPregled:
      begin
        vPreg := vtrMinaliPregledi.AddChild(nil, nil);
        data := vtrMinaliPregledi.GetNodeData(vPreg);
        data.index := integer(vPregNode);
        data.DataPos := dataNode.DataPos;
        data.vid := vvPregled;
      end;
      vvIncMN:
      begin
        run := vPregNode.FirstChild;
        while run <> nil do
        begin
          dataPregInMN := pointer(PByte(run) + lenNode);
          case dataPregInMN.vid of
            vvPregled:
            begin
              vPreg := vtrMinaliPregledi.AddChild(nil, nil);
              data := vtrMinaliPregledi.GetNodeData(vPreg);
              data.index := integer(run);
              data.DataPos := dataPregInMN.DataPos;
              data.vid := vvPregled;
            end;
          end;
          run := run.NextSibling;
        end;
      end;
    end;
    vPregNode := vPregNode.NextSibling;
  end;
  if {Fdm.IsGP and }(Apat <> nil) then
  begin
    vPreg := vtrMinaliPregledi.AddChild(nil, nil);
    data := vtrMinaliPregledi.GetNodeData(vPreg);
    data.DataPos := 0;
    data.vid := vvCl132;
  end;
  if (not Fdm.IsGP) and (Apat <> nil) then
  begin
    vPreg := vtrMinaliPregledi.AddChild(nil, nil);

    data := vtrMinaliPregledi.GetNodeData(vPreg);
    data.DataPos := 0;
    data.vid := vvIncMN;
  end;

  vtrMinaliPregledi.EndUpdate;
  vtrMinaliPregledi.Sort(vtrMinaliPregledi.RootNode, 0, sdDescending, false);
  vtrMinaliPregledi.FocusedNode := vtrMinaliPregledi.RootNode.FirstChild;
  vtrMinaliPregledi.Selected[vtrMinaliPregledi.RootNode.FirstChild] := True;


  //Elapsed := Stopwatch.Elapsed;
  //mmoTest.Lines.Add('Minali za ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.LoadVtrNomenNzis(NomenNamesFile: string);
var
  data: PAspRec;
  i: Integer;
  v: PVirtualNode;
  str: string;
  NomenID: integer;
  MaxCntNomen: Integer;
begin
  //MaxCntNomen := 150;
//  if vRootNomenNzis.ChildCount > 0  then Exit;
//  vtrNomenNzis.BeginUpdate;
//  //LSNomenNzisNames.LoadFromFile(NomenNamesFile, TEncoding.UTF8);
//  //ListNomenNzisNames.Count := LSNomenNzisNames.Count;
//
//  for i := 0 to MaxCntNomen - 1 do
//  begin
//    ListNomenNzisNames[i] := TNomenNzisRec.Create;
//    //str := LSNomenNzisNames[i];
//    //ListNomenNzisNames[i].ArrStr := str.Split([#9]);
//
//    v := vtrNomenNzis.AddChild(vRootNomenNzis, nil);
//    if Length(ListNomenNzisNames[i].ArrStr) = 5 then
//    begin
//      case ListNomenNzisNames[i].ArrStr[4][1] of
//        'E': v.Dummy := 79;
//        'X': v.Dummy := 80;
//      end;
//      NomenID := StrToInt(Copy(ListNomenNzisNames[i].ArrStr[1], 3, 3));
//      case NomenID of
//        022: ListNomenNzisNames[i].AspColl := CL022Coll;
//        024: ListNomenNzisNames[i].AspColl := CL024Coll;
//        038: ListNomenNzisNames[i].AspColl := CL038Coll;
//        050: ListNomenNzisNames[i].AspColl := CL050Coll;
//        132: ListNomenNzisNames[i].AspColl := CL132Coll;
//        134: ListNomenNzisNames[i].AspColl := CL134Coll;
//      end;
//    end;
//    data := vtrNomenNzis.GetNodeData(v);
//    data.vid := vvNomenNzis;
//    data.index := i;
//    vtrNomenNzis.AddWaitNode(v);
//  end;
//
//  v := vtrNomenNzis.AddChild(vRootNzisBiznes, nil);
//
//  data := vtrNomenNzis.GetNodeData(v);
//  data.vid := vvPR001;
//  data.index := 0;
//  vtrNomenNzis.AddWaitNode(v);
//
//  vtrNomenNzis.FullExpand();
//  vtrNomenNzis.EndUpdate;

end;

procedure TfrmSuperHip.LoadVtrNomenNzis1;
var
  data: PAspRec;
  i: Integer;
  v: PVirtualNode;
  str: string;
  NomenID: integer;
  //nomenNzis: TNomenNzisItem;
begin
  if vRootNomenNzis.ChildCount > 0  then Exit;
  vtrNomenNzis.BeginUpdate;
  Adb_DM.ListNomenNzisNames.Count := Adb_dm.NomenNzisColl.Count;

  for i := 0 to Adb_dm.NomenNzisColl.Count - 1 do
  begin
    Adb_DM.ListNomenNzisNames[i] := TNomenNzisRec.Create;
    Adb_DM.ListNomenNzisNames[i].nomenNzis := Adb_dm.NomenNzisColl.Items[i];

    v := vtrNomenNzis.AddChild(vRootNomenNzis, nil);

    data := vtrNomenNzis.GetNodeData(v);
    data.vid := vvNomenNzis;
    data.index := i;
    vtrNomenNzis.AddWaitNode(v);
  end;

  v := vtrNomenNzis.AddChild(vRootNzisBiznes, nil);

  data := vtrNomenNzis.GetNodeData(v);
  data.vid := vvPR001;
  data.index := 0;
  vtrNomenNzis.AddWaitNode(v);

  vtrNomenNzis.FullExpand();
  vtrNomenNzis.EndUpdate;

end;

procedure TfrmSuperHip.LoadVtrNomenNzis2;
var
  data: PAspRec;
  i: Integer;
  v: PVirtualNode;
  str: string;
  NomenID: integer;
  //nomenNzis: TNomenNzisItem;
  MaxCnt: Integer;
begin
  MaxCnt := 150;
  if vRootNomenNzis.ChildCount > 0  then Exit;
  vtrNomenNzis.BeginUpdate;
  Adb_DM.ListNomenNzisNames.Count := MaxCnt;

  for i := 0 to MaxCnt -1 do
  begin
    Adb_DM.ListNomenNzisNames[i] := TNomenNzisRec.Create;
    Adb_DM.ListNomenNzisNames[i].nomenNzis := TNomenNzisItem(Adb_dm.NomenNzisColl.add);
    New(Adb_DM.ListNomenNzisNames[i].nomenNzis.PRecord);
    Adb_DM.ListNomenNzisNames[i].nomenNzis.PRecord.setProp := [NomenNzis_NomenName, NomenNzis_NomenID];
    Adb_DM.ListNomenNzisNames[i].nomenNzis.PRecord.NomenName := '';
    Adb_DM.ListNomenNzisNames[i].nomenNzis.PRecord.NomenID := Format('CL%.*d', [3, i]) ;;

    v := vtrNomenNzis.AddChild(vRootNomenNzis, nil);
    case i of
      006:
      begin
        if Adb_dm.CL006Coll.Count > 0 then
        begin
          Adb_DM.ListNomenNzisNames[i].AspColl := Adb_dm.CL006Coll;
          v.Dummy := 80;
        end;
      end;
      022:
      begin
        if Adb_dm.CL022Coll.Count > 0 then
        begin
          Adb_DM.ListNomenNzisNames[i].AspColl := Adb_dm.CL022Coll;
          v.Dummy := 80;
        end;
      end;
      024:
      begin
        if Adb_dm.CL024Coll.Count > 0 then
        begin
          Adb_DM.ListNomenNzisNames[i].AspColl := Adb_dm.CL024Coll;
          v.Dummy := 80;
        end;
      end;
      037:
      begin
        if Adb_dm.CL037Coll.Count > 0 then
        begin
          Adb_DM.ListNomenNzisNames[i].AspColl := Adb_dm.CL037Coll;
          v.Dummy := 80;
        end;
      end;
      038:
      begin
        if Adb_dm.CL038Coll.Count > 0 then
        begin
          Adb_DM.ListNomenNzisNames[i].AspColl := Adb_dm.CL038Coll;
          v.Dummy := 80;
        end;
      end;
      050:
      begin
        if Adb_dm.CL050Coll.Count > 0 then
        begin
          Adb_DM.ListNomenNzisNames[i].AspColl := Adb_dm.CL050Coll;
          v.Dummy := 80;
        end;
      end;
      088:
      begin
        if Adb_dm.CL088Coll.Count > 0 then
        begin
          Adb_DM.ListNomenNzisNames[i].AspColl := Adb_dm.CL088Coll;
          v.Dummy := 80;
        end;
      end;
      132:
      begin
        if Adb_dm.CL132Coll.Count > 0 then
        begin
          Adb_DM.ListNomenNzisNames[i].AspColl := Adb_dm.CL132Coll;
          v.Dummy := 80;
        end;
      end;
      134:
      begin
        if Adb_dm.CL134Coll.Count > 0 then
        begin
          Adb_DM.ListNomenNzisNames[i].AspColl := Adb_dm.CL134Coll;
          v.Dummy := 80;
        end;
      end;
      139:
      begin
        if Adb_dm.CL139Coll.Count > 0 then
        begin
          Adb_DM.ListNomenNzisNames[i].AspColl := Adb_dm.CL139Coll;
          v.Dummy := 80;
        end;
      end;
      142:
      begin
        if Adb_dm.CL142Coll.Count > 0 then
        begin
          Adb_DM.ListNomenNzisNames[i].AspColl := Adb_dm.CL142Coll;
          v.Dummy := 80;
        end;
      end;
      144:
      begin
        if Adb_dm.CL144Coll.Count > 0 then
        begin
          Adb_DM.ListNomenNzisNames[i].AspColl := Adb_dm.CL144Coll;
          v.Dummy := 80;
        end;
      end;
    end;



    data := vtrNomenNzis.GetNodeData(v);
    data.vid := vvNomenNzis;
    data.index := i;
    vtrNomenNzis.AddWaitNode(v);
  end;

  v := vtrNomenNzis.AddChild(vRootNzisBiznes, nil);

  data := vtrNomenNzis.GetNodeData(v);
  data.vid := vvPR001;
  data.index := 0;
  vtrNomenNzis.AddWaitNode(v);

  vtrNomenNzis.FullExpand();
  vtrNomenNzis.EndUpdate;

end;

procedure TfrmSuperHip.LoadVtrPregledOnPat;
var
  TreeLink, Run: PVirtualNode;
  linkpos: Cardinal;
  pCardinalData: ^Cardinal;

  i, j, k, m, n: Integer;
  data: PAspRec;
  diag: TRealDiagnosisItem;
  proc: TRealProceduresItem;
  performer, Deput: TRealDoctorItem;
  mdn: TRealMDNItem;
  mn: TRealBLANKA_MED_NAPRItem;
  mn3A: TRealBLANKA_MED_NAPR_3AItem;
  mnHosp: TRealHOSPITALIZATIONItem;
  mnLkk: TRealEXAM_LKKItem;
  immun: TRealExamImmunizationItem;
  profCard: TRealKARTA_PROFILAKTIKA2017Item;
  examAnal: TRealExamAnalysisItem;
  preg: TRealPregledNewItem;
  MDD: TRealINC_MDNItem;
  IncMn: TRealINC_NAPRItem;
  pat: TRealPatientNewItem;
  vPreg, vPat, vMN, vDoc, vPerformer, vDeput, vaddres: PVirtualNode;
  vMdn, vMDD, vMNHosp, vMNLkk, vIncMN: PVirtualNode;
  vOtherDoc: PVirtualNode;
  vtr: TVirtualStringTreeAspect;
  cnt: Integer;
begin
  vtr := vtrPregledPat;
  vtr.BeginUpdate;
  vtr.Clear;


  Stopwatch := TStopwatch.StartNew;
  linkpos := 100;
  Run := vtr.RootNode;

  TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
  data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
  data.index := MAXDWORD;
  data.vid := vvPatientNewRoot;
  data.DataPos := 0;
  TreeLink.Index := 0;
  inc(linkpos, LenData);

  TreeLink.TotalCount := 1;
  TreeLink.TotalHeight := 27;
  TreeLink.NodeHeight := 27;
  TreeLink.States := [vsVisible];
  TreeLink.Align := 50;
  TreeLink.Dummy := i mod 255;

  vtr.InitNode(TreeLink);
  vtr.InternalConnectNode_cmd(TreeLink, vtr.RootNode,
                    vtr, amAddChildLast, streamCmdFile);
  run := TreeLink;

  for I := 0 to Adb_dm.CollPatient.Count - 1 do
  begin
    pat := Adb_dm.CollPatient.Items[i];
    if pat.PatID = 85386 then
        Caption := 'ddd';
    TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
    data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
    data.DataPos := pat.DataPos;
    data.vid := vvPatient;
    data.index := i;
    inc(linkpos, LenData);

    TreeLink.TotalCount := 1;
    TreeLink.TotalHeight := 27;
    TreeLink.NodeHeight := 27;
    TreeLink.States := [vsVisible];
    TreeLink.Align := 50;
    TreeLink.Dummy := i mod 255;
    vtr.InitNode(TreeLink);
    vtr.InternalConnectNode_cmd(TreeLink, run,
                    vtr, amAddChildLast, streamCmdFile);

    vPat := TreeLink;
    if pat.FDoctor <> nil then
    begin
      TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
      data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
      data.DataPos := pat.FDoctor.DataPos;
      data.vid := vvDoctor;
      data.index := -1;
      inc(linkpos, LenData);

      TreeLink.TotalCount := 1;
      TreeLink.TotalHeight := 27;
      TreeLink.NodeHeight := 27;
      TreeLink.States := [vsVisible];
      TreeLink.Align := 50;
      TreeLink.Dummy := 0;
      vtr.InitNode(TreeLink);
      vtr.InternalConnectNode_cmd(TreeLink, vPat, vtr, amAddChildLast, streamCmdFile);
    end;
    if pat.FAdresi.Count > 0 then
    begin
      TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
      data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
      data.DataPos := pat.FAdresi[0].DataPos;
      data.vid := vvAddres;
      data.index := -1;
      inc(linkpos, LenData);

      TreeLink.TotalCount := 1;
      TreeLink.TotalHeight := 27;
      TreeLink.NodeHeight := 27;
      TreeLink.States := [vsVisible];
      TreeLink.Align := 50;
      TreeLink.Dummy := 0;
      vtr.InitNode(TreeLink);
      vtr.InternalConnectNode_cmd(TreeLink, vPat, vtr, amAddChildLast, streamCmdFile);
    end;
    
    for j := 0 to pat.FMDDs.Count - 1 do
    begin
      MDD := TRealINC_MDNItem(pat.FMDDs[j]);
      TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
      data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
      data.DataPos := MDD.DataPos;
      data.vid := vvIncMdn;
      data.index := -1;
      inc(linkpos, LenData);

      TreeLink.TotalCount := 1;
      TreeLink.TotalHeight := 27;
      TreeLink.NodeHeight := 27;
      TreeLink.States := [vsVisible];
      TreeLink.Align := 50;
      //TreeLink.Dummy := j mod 255;
      vtr.InitNode(TreeLink);
      vtr.InternalConnectNode_cmd(TreeLink, vpat,
                      vtr, amAddChildFirst, streamCmdFile);

      vMDD := TreeLink;

    end;
    for j := 0 to pat.FIncMNs.Count - 1 do
    begin
      if pat.FIncMNs[j].NRN = '2418760164D8' then
        Caption := 'ddd';
      IncMn := TRealINC_NAPRItem(pat.FIncMNs[j]);
      TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
      data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
      data.DataPos := IncMn.DataPos;
      data.vid := vvIncMN;
      data.index := -1;
      inc(linkpos, LenData);

      TreeLink.TotalCount := 1;
      TreeLink.TotalHeight := 27;
      TreeLink.NodeHeight := 27;
      TreeLink.States := [vsVisible];
      TreeLink.Align := 50;
      //TreeLink.Dummy := j mod 255;
      vtr.InitNode(TreeLink);
      vtr.InternalConnectNode_cmd(TreeLink, vpat,
                      vtr, amAddChildFirst, streamCmdFile);

      vIncMN := TreeLink;
      TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
      data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
      data.DataPos := IncMn.FIncDoctor.DataPos;
      data.vid := vvOtherDoctor;
      data.index := -1;
      inc(linkpos, LenData);

      TreeLink.TotalCount := 1;
      TreeLink.TotalHeight := 27;
      TreeLink.NodeHeight := 27;
      TreeLink.States := [vsVisible];
      TreeLink.Align := 50;
      //TreeLink.Dummy := j mod 255;
      vtr.InitNode(TreeLink);
      vtr.InternalConnectNode_cmd(TreeLink, vIncMN,
                      vtr, amAddChildFirst, streamCmdFile);

      IncMn.LinkNode := vIncMN;
      //if IncMn.NRN = '22157700253F' then
//        Caption := pat.PatEGN;
    end;


    for j := 0 to pat.FPregledi.Count - 1 do
    begin
      preg := TRealPregledNewItem(pat.FPregledi[j]);
      if preg.PatID = 85386 then
        Caption := 'ddd';
      TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
      data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
      data.DataPos := preg.DataPos;
      data.vid := vvPregled;
      data.index := -1;
      inc(linkpos, LenData);

      TreeLink.TotalCount := 1;
      TreeLink.TotalHeight := 27;
      TreeLink.NodeHeight := 27;
      TreeLink.States := [vsVisible];
      TreeLink.Align := 50;
      //TreeLink.Dummy := j mod 255;
      vtr.InitNode(TreeLink);
      //vtr.InternalConnectNode_cmd(TreeLink, vpat,
//                        vtr, amAddChildFirst, streamCmdFile);
      if preg.FIncMN = nil then
      begin
        vtr.InternalConnectNode_cmd(TreeLink, vpat,
                        vtr, amAddChildFirst, streamCmdFile);
      end
      else
      begin
        if preg.FIncMN.LinkNode <> nil then
        begin
          vtr.InternalConnectNode_cmd(TreeLink,  preg.FIncMN.LinkNode,
                          vtr, amAddChildLast, streamCmdFile);
        end
        else
        begin
          vtr.InternalConnectNode_cmd(TreeLink, vpat,
                        vtr, amAddChildFirst, streamCmdFile);//zzzzzzzzzzzzzzzzzz  да се отбележи, че не е добре
          //Caption := pat.PatEGN;
        end;
      end;

      vPreg := TreeLink;

      if preg.FDoctor <> nil then
      begin
        performer := preg.FDoctor;
      end
      else
      begin
        performer := preg.FDoctor;
      end;

      if performer <> nil then
      begin
        TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
        data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
        data.DataPos := performer.DataPos;
        data.vid := vvPerformer;
        data.index := -1;
        inc(linkpos, LenData);

        TreeLink.TotalCount := 1;
        TreeLink.TotalHeight := 27;
        TreeLink.NodeHeight := 27;
        TreeLink.States := [vsVisible];
        TreeLink.Align := 50;
        TreeLink.Dummy := 0;
        vtr.InitNode(TreeLink);
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast, streamCmdFile);

        vPerformer := TreeLink;

        if preg.FDeput <> nil then
        begin
          deput := preg.FDeput;
          TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
          data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
          data.DataPos := deput.DataPos;
          data.vid := vvDeput;
          data.index := -1;
          inc(linkpos, LenData);

          TreeLink.TotalCount := 1;
          TreeLink.TotalHeight := 27;
          TreeLink.NodeHeight := 27;
          TreeLink.States := [vsVisible];
          TreeLink.Align := 50;
          TreeLink.Dummy := 0;
          vtr.InitNode(TreeLink);
          vtr.InternalConnectNode_cmd(TreeLink, vPerformer, vtr, amAddChildLast, streamCmdFile);
        end
        else
        begin
          //mmoTest.Lines.Add(IntToStr(preg.PregledID));
        end;
      end;

      for k := 0 to preg.FDiagnosis.Count -1 do
      begin
        diag := preg.FDiagnosis[k];
        TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
        data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
        data.DataPos := diag.DataPos;
        data.vid := vvDiag;
        data.index := -1;
        inc(linkpos, LenData);

        TreeLink.TotalCount := 1;
        TreeLink.TotalHeight := 27;
        TreeLink.NodeHeight := 27;
        TreeLink.States := [vsVisible];
        TreeLink.Align := 50;
        TreeLink.Dummy := k mod 255;
        vtr.InitNode(TreeLink);
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast, streamCmdFile);
      end;

      for k := 0 to preg.FProcedures.Count -1 do
      begin
        proc := preg.FProcedures[k];
        TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
        data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
        data.DataPos := proc.DataPos;
        data.vid := vvProcedures;
        data.index := -1;
        inc(linkpos, LenData);

        TreeLink.TotalCount := 1;
        TreeLink.TotalHeight := 27;
        TreeLink.NodeHeight := 27;
        TreeLink.States := [vsVisible];
        TreeLink.Align := 50;
        vtr.InitNode(TreeLink);
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast, streamCmdFile);
      end;

      for k := 0 to preg.FMdns.Count -1 do
      begin
        mdn := preg.FMdns[k];
        TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
        data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
        data.DataPos := mdn.DataPos;
        data.vid := vvMDN;
        data.index := -1;
        inc(linkpos, LenData);

        TreeLink.TotalCount := 1;
        TreeLink.TotalHeight := 27;
        TreeLink.NodeHeight := 27;
        TreeLink.States := [vsVisible];
        TreeLink.Align := 50;
        //TreeLink.Dummy := k mod 255;
        vtr.InitNode(TreeLink);
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast, streamCmdFile);

        vMdn  := TreeLink;

        for m := 0 to mdn.FDiagnosis.Count -1 do
        begin
          diag := mdn.FDiagnosis[m];
          //if diag.PregDiag <> nil then
//          begin
//            Caption := 'ddd';
//            Continue;// zzzzzzzzzzzzzzzzzz  да се сложи коя диагноза от прегледа е...
//          end;
          mdn.AddNewDiag(m, Adb_dm.CollDiag);
          TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
          data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
          data.DataPos := diag.DataPos;
          data.vid := vvDiag;
          data.index := -1;
          inc(linkpos, LenData);

          TreeLink.TotalCount := 1;
          TreeLink.TotalHeight := 27;
          TreeLink.NodeHeight := 27;
          TreeLink.States := [vsVisible];
          TreeLink.Align := 50;
          vtr.InitNode(TreeLink);
          vtr.InternalConnectNode_cmd(TreeLink, vMDN, vtr, amAddChildLast, streamCmdFile);
        end;

        for m := 0 to mdn.FExamAnals.Count -1 do
        begin
          examAnal := mdn.FExamAnals[m];
          TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
          data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
          data.DataPos := examAnal.DataPos;
          data.vid := vvExamAnal;
          data.index := -1;
          inc(linkpos, LenData);

          TreeLink.TotalCount := 1;
          TreeLink.TotalHeight := 27;
          TreeLink.NodeHeight := 27;
          TreeLink.States := [vsVisible];
          TreeLink.Align := 50;
          vtr.InitNode(TreeLink);
          vtr.InternalConnectNode_cmd(TreeLink, vMDN, vtr, amAddChildLast, streamCmdFile);
        end;
      end;
      for k := 0 to preg.FMNs.Count -1 do
      begin
        mn := preg.FMNs[k];
        TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
        data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
        data.DataPos := mn.DataPos;
        data.vid := vvMedNapr;
        data.index := -1;
        inc(linkpos, LenData);

        TreeLink.TotalCount := 1;
        TreeLink.TotalHeight := 27;
        TreeLink.NodeHeight := 27;
        TreeLink.States := [vsVisible];
        TreeLink.Align := 50;
        TreeLink.Dummy := 0;
        vtr.InitNode(TreeLink);
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast, streamCmdFile);

        vMn  := TreeLink;
        for m := 0 to mn.FDiagnosis2.Count -1 do
        begin
          diag := mn.FDiagnosis2[m];
          TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
          data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
          data.DataPos := diag.DataPos;
          data.vid := vvDiag;
          data.index := -1;
          inc(linkpos, LenData);

          TreeLink.TotalCount := 1;
          TreeLink.TotalHeight := 27;
          TreeLink.NodeHeight := 27;
          TreeLink.States := [vsVisible];
          TreeLink.Align := 50;
          vtr.InitNode(TreeLink);
          vtr.InternalConnectNode_cmd(TreeLink, vMn, vtr, amAddChildLast, streamCmdFile);
        end;
      end;

      for k := 0 to preg.FMNs3A.Count -1 do
      begin
        mn3A := preg.FMNs3A[k];
        TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
        data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
        data.DataPos := mn3A.DataPos;
        data.vid := vvMedNapr3A;
        data.index := -1;
        inc(linkpos, LenData);

        TreeLink.TotalCount := 1;
        TreeLink.TotalHeight := 27;
        TreeLink.NodeHeight := 27;
        TreeLink.States := [vsVisible];
        TreeLink.Align := 50;
        TreeLink.Dummy := 0;
        vtr.InitNode(TreeLink);
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast, streamCmdFile);

        vMn  := TreeLink;
        for m := 0 to mn3A.FDiagnosis2.Count -1 do
        begin
          diag := mn3A.FDiagnosis2[m];
          TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
          data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
          data.DataPos := diag.DataPos;
          data.vid := vvDiag;
          data.index := -1;
          inc(linkpos, LenData);

          TreeLink.TotalCount := 1;
          TreeLink.TotalHeight := 27;
          TreeLink.NodeHeight := 27;
          TreeLink.States := [vsVisible];
          TreeLink.Align := 50;
          vtr.InitNode(TreeLink);
          vtr.InternalConnectNode_cmd(TreeLink, vMn, vtr, amAddChildLast, streamCmdFile);
        end;
      end;

      for k := 0 to preg.FMNsHosp.Count -1 do
      begin
        mnHosp := preg.FMNsHosp[k];
        TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
        data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
        data.DataPos := mnHosp.DataPos;
        data.vid := vvMedNaprHosp;
        data.index := -1;
        inc(linkpos, LenData);

        TreeLink.TotalCount := 1;
        TreeLink.TotalHeight := 27;
        TreeLink.NodeHeight := 27;
        TreeLink.States := [vsVisible];
        TreeLink.Align := 50;
        TreeLink.Dummy := 0;
        vtr.InitNode(TreeLink);
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast, streamCmdFile);

        vMNHosp  := TreeLink;
        for m := 0 to mnHosp.FDiagnosis2.Count -1 do
        begin
          diag := mnHosp.FDiagnosis2[m];
          TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
          data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
          data.DataPos := diag.DataPos;
          data.vid := vvDiag;
          data.index := -1;
          inc(linkpos, LenData);

          TreeLink.TotalCount := 1;
          TreeLink.TotalHeight := 27;
          TreeLink.NodeHeight := 27;
          TreeLink.States := [vsVisible];
          TreeLink.Align := 50;
          vtr.InitNode(TreeLink);
          vtr.InternalConnectNode_cmd(TreeLink, vMNHosp, vtr, amAddChildLast, streamCmdFile);
        end;
      end;

      for k := 0 to preg.FMNsLKK.Count -1 do
      begin
        mnLkk := preg.FMNsLKK[k];
        TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
        data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
        data.DataPos := mnLkk.DataPos;
        data.vid := vvMedNaprLkk;
        data.index := -1;
        inc(linkpos, LenData);

        TreeLink.TotalCount := 1;
        TreeLink.TotalHeight := 27;
        TreeLink.NodeHeight := 27;
        TreeLink.States := [vsVisible];
        TreeLink.Align := 50;
        TreeLink.Dummy := 0;
        vtr.InitNode(TreeLink);
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast, streamCmdFile);

        vMNLkk  := TreeLink;
        for m := 0 to mnLkk.FDiagnosis2.Count -1 do
        begin
          diag := mnLkk.FDiagnosis2[m];
          TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
          data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
          data.DataPos := diag.DataPos;
          data.vid := vvDiag;
          data.index := -1;
          inc(linkpos, LenData);

          TreeLink.TotalCount := 1;
          TreeLink.TotalHeight := 27;
          TreeLink.NodeHeight := 27;
          TreeLink.States := [vsVisible];
          TreeLink.Align := 50;
          vtr.InitNode(TreeLink);
          vtr.InternalConnectNode_cmd(TreeLink, vMNLkk, vtr, amAddChildLast, streamCmdFile);
        end;
      end;

      for k := 0 to preg.FImmuns.Count -1 do
      begin
        immun := preg.FImmuns[k];
        TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
        data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
        data.DataPos := immun.DataPos;
        data.vid := vvExamImun;
        data.index := -1;
        inc(linkpos, LenData);

        TreeLink.TotalCount := 1;
        TreeLink.TotalHeight := 27;
        TreeLink.NodeHeight := 27;
        TreeLink.States := [vsVisible];
        TreeLink.Align := 50;
        TreeLink.Dummy := 0;
        vtr.InitNode(TreeLink);
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast, streamCmdFile);
      end;
      for k := 0 to preg.FProfCards.Count -1 do
      begin
        profCard := preg.FProfCards[k];
        TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
        data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
        data.DataPos := profCard.DataPos;
        data.vid := vvProfCard;
        data.index := -1;
        inc(linkpos, LenData);

        TreeLink.TotalCount := 1;
        TreeLink.TotalHeight := 27;
        TreeLink.NodeHeight := 27;
        TreeLink.States := [vsVisible];
        TreeLink.Align := 50;
        TreeLink.Dummy := 0;
        vtr.InitNode(TreeLink);
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast, streamCmdFile);
      end;
    end;
  end;

  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  pCardinalData^ := linkpos;

  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf) + 4);
  pCardinalData^ := Cardinal(AspectsLinkPatPregFile.Buf);

  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf) + 8);
  pCardinalData^ := Cardinal(vtr.RootNode);

  vtr.EndUpdate;
  vtr.UpdateScrollBars(true);
  vtr.InvalidateToBottom(vtr.RootNode);
  vtr.Expanded[run] := True;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('ЗаpisLink %d за %f',[vtr.RootNode.TotalCount,  Elapsed.TotalMilliseconds]));
end;



procedure TfrmSuperHip.LoadVtrProfReg;
var
  linkPos: cardinal;
  pCardinalData: PCardinal;
  FPosLinkData: Cardinal;
  RunNode, vPat: PVirtualNode;
  buflink: Pointer;
  data, dataPat: PAspRec;
begin
  vtrProfReg.BeginUpdate;
  buflink := AspectsLinkPatPregFile.Buf;
  linkPos := 100;
  pCardinalData := pointer(PByte(buflink));
  FPosLinkData := pCardinalData^;
  while linkpos < FPosLinkData do
  begin
    RunNode := pointer(PByte(bufLink) + linkpos);
    data := pointer(PByte(RunNode) + lenNode);
    if data.vid = vvPatient then
    begin
      vPat := vtrProfReg.AddChild(nil, nil);
      dataPat := vtrProfReg.GetNodeData(vPat);
      dataPat.DataPos := data.DataPos;
      dataPat.vid := data.vid;
      dataPat.index := data.index;
    end;
    Inc(linkPos, LenData);
  end;
  vtrProfReg.EndUpdate;

end;

procedure TfrmSuperHip.LoadVtrProfReg1;
var
  i, iVid: Integer;
  linkPos: Cardinal;
  pCardinalData: ^Cardinal;
  FPosLinkData: Cardinal;
  FPosDataADB: Cardinal;
  data: PAspRec;

  node, patNode, pregNode, mkbNode, vPat, vPreg, vDiag: PVirtualNode;
  AdataPat, AdataPreg, AdataDiag: PAspRec;
  dataPat, dataPreg, dataDiag: PAspRec;//: PAspRec;
  tempPat: TPatientNewItem;
  temppreg: TRealPregledNewItem;
  tempDoctor: TDoctorItem;
  tempDiag: TRealDiagnosisItem;
  egn, anamn, uin, diag, mkb: string;
  buflink, BufADB: Pointer;
  logPreg: TLogicalData40;
  PregIsProf: Boolean;
begin
  vtrProfReg.BeginUpdate;
  buflink := AspectsLinkPatPregFile.Buf;
  BufADB := Adb_DM.AdbMain.Buf;
  linkPos := 100;
  pCardinalData := pointer(PByte(bufLink));
  FPosLinkData := pCardinalData^;
  pCardinalData := pointer(PByte(BufADB) + 8);
  FPosDataADB := pCardinalData^;
  node := pointer(PByte(bufLink) + linkpos);
  data := pointer(PByte(node) + lenNode);
  tempPat := TPatientNewItem.Create(nil);
  temppreg := TRealPregledNewItem.Create(nil);
  tempDoctor := TDoctorItem.Create(nil);

  //collPregForSearch.ListDataPos.Clear;

  patNode := node.FirstChild;
  while patNode <> nil do // loop pat
  begin
    AdataPat := pointer(PByte(patNode) + lenNode);
    tempPat.DataPos := AdataPat.DataPos;
    egn := tempPat.getAnsiStringMap(BufADB, FPosDataADB, word(PatientNew_EGN));
    if true then
    begin
      vPat := vtrProfReg.AddChild(nil, nil);
      dataPat := vtrProfReg.GetNodeData(vPat);
      dataPat.DataPos := AdataPat.DataPos;
      dataPat.vid := AdataPat.vid;
      dataPat.index := AdataPat.index;

      pregNode := patNode.FirstChild;
      while pregNode <> nil do  // loop child
      begin
        AdataPreg := pointer(PByte(pregNode) + lenNode);
        case AdataPreg.vid of
          vvPregled:   // ако е преглед
          begin
            PregIsProf := False;
            temppreg.FDiagnosis.Clear;
            temppreg.DataPos := AdataPreg.DataPos;
            logPreg := (temppreg.getLogical40Map(BufADB, FPosDataADB, word(PatientNew_Logical)));
            if True then// IS_PREVENTIVE in TlogicalPregledNewSet(logPreg) then
            begin
              mkbNode := pregNode.FirstChild;
              while mkbNode <> nil do // loop diag
              begin
                AdataDiag := pointer(PByte(mkbNode) + lenNode);
                case AdataDiag.vid of
                  vvDiag:
                  begin
                    if true then
                    begin
                      tempDiag := TRealDiagnosisItem.Create(nil);
                      tempDiag.DataPos := AdataDiag.DataPos;
                      mkb := tempDiag.getAnsiStringMap(Adb_dm.CollDiag.Buf, Adb_dm.CollDiag.posData, word(Diagnosis_code_CL011));
                      if 'Z00.0Z00.1Z00.2Z00.3Z10.8Z23.2Z23.8Z24.6Z27.4Z27.8'.Contains(mkb) and mkb.Contains('.') then
                      begin
                        PregIsProf := True;
                        temppreg.FDiagnosis.Add(tempDiag);
                        Break;
                      end;

                    end;
                  end;
                end;
                mkbNode := mkbNode.NextSibling;
              end;
            end;
            if PregIsProf then
            begin
              vPreg := vtrProfReg.AddChild(vPat, nil);
              dataPreg := vtrProfReg.GetNodeData(vPreg);
              dataPreg.DataPos := AdataPreg.DataPos;
              dataPreg.vid := AdataPreg.vid;
              dataPreg.index := AdataPreg.index;

              for i := 0 to temppreg.FDiagnosis.Count-1 do
              begin
                vDiag := vtrProfReg.AddChild(vPreg, nil);
                dataDiag := vtrProfReg.GetNodeData(vDiag);
                dataDiag.DataPos := temppreg.FDiagnosis[i].DataPos;
                dataDiag.vid := vvDiag;
                dataDiag.index := -1;
              end;
            end;
          end;
        end;
        pregNode := pregNode.NextSibling;
      end;
    end;
    patNode := patNode.NextSibling;
  end;
  vtrProfReg.FullExpand();
  vtrProfReg.EndUpdate;
end;

procedure TfrmSuperHip.LoadVtrSearch;
var
  vPat, vPreg: PVirtualNode;
  data: PAspRec;
begin
  //vtrSearch.NodeDataSize := SizeOf(tasprec);
  //vtrSearch.BeginUpdate;
  Adb_dm.CollPatient.ListForFinder.Clear;

  //vPat := vtrSearch.AddChild(nil, nil);
  //data := vtrSearch.GetNodeData(vpat);
  //data.index := CollPatient.AddItemForSearch;// шаблон за търсене.
  //data.DataPos := 0;
//  data.vid := vvPatient;
//
//  vPreg := vtrSearch.AddChild(vpat, nil);
//  data := vtrSearch.GetNodeData(vPreg);
//  data.index := CollPregled.AddItemForSearch;// шаблон за търсене.
//  data.DataPos := 0;
//  data.vid := vvPregled;
//
//
//  vtrSearch.EndUpdate;
end;

procedure TfrmSuperHip.LoadVtrSpisyciNeblUsl;
var
  i: Integer;
  data: PAspRec;
  vDoc: PVirtualNode;

begin
  vtrSpisyci.Clear;
  vtrSpisyci.BeginUpdate;

  for i := 0 to Adb_dm.CollDoctor.Count - 1 do
  begin
    vDoc := vtrSpisyci.AddChild(nil, nil);
    data := vtrSpisyci.GetNodeData(vDoc);
    data.index := i;
    data.vid := vvDoctor;
    Adb_dm.CollDoctor.Items[i].Node := vDoc;
  end;
  vtrSpisyci.EndUpdate;
end;



procedure TfrmSuperHip.MenuItem1Click(Sender: TObject);
begin
  btnX006Click(nil);
end;

procedure TfrmSuperHip.MenuTitleDBClick(Sender: TObject);
begin
  LoadVtrFDB;
end;

procedure TfrmSuperHip.MenuTitleLoadDBClick(Sender: TObject);
begin
  SubButonImportFDBClick(Sender);
  FmxTitleBar.p1.IsOpen := False;
  pgcTree.ActivePage := tsTreeDBFB;
  vtrFDB.SetFocus;
end;

procedure TfrmSuperHip.MenuTitleProfGrafClick(Sender: TObject);
var
  i: Integer;
  //MyThreadPool: TThreadPool;
  MinWorkerThreads: integer;
  MaxWorkerThreads: integer;

  pat: TRealPatientNewItem;
  dat: TDate;
  log: TlogicalPatientNewSet;
  dataGraph: PAspRec;
  node: PVirtualNode;
begin
  FmxTitleBar.p1.IsOpen := False;
  FmxTitleBar.p2.IsOpen := False;
  pgcTree.ActivePage := tsGraph;
  vtrGraph.SetFocus;
  if profGR = nil then
  begin
    //LoadVtrNomenNzis1;
//    OpenBufNomenNzis('c:\temp\NzisNomen.adb');
    OpenBufNomenNzis(ParamStr(2) + 'NzisNomen.adb');
    LoadVtrNomenNzis1();
    profGR := TProfGraph.create;

    profGR := TProfGraph.create;

    profGR.BufNomen := AspectsNomFile.Buf;
    //profGR.BufADB := AspectsHipFile.Buf;
    //profGR.posDataADB := AspectsHipFile.FPosData;
    profGR.vtrGraph := vtrGraph;
    profGR.Adb_DM := Adb_DM;
  end;
  profGR.VisibleMinali := False;
  profGR.VisibleBudeshti := False;

  vtrGraph.BeginUpdate;
  vtrGraph.Clear;
  vRootGraph := vtrGraph.AddChild(nil, nil);
    dataGraph := vtrGraph.GetNodeData(vRootGraph);
    dataGraph.vid := vvNone;
    dataGraph.index := 0;
  Adb_dm.ACollPatGR.Clear;
  Adb_dm.CollPatient.FillListNodes(AspectsLinkPatPregFile, vvPatient);
  vtrGraph.OnCompareNodes := nil;
  //vtrGraph.OnGetText := nil;
  vtrGraph.OnGetImageIndexEx := nil;
  Stopwatch := TStopwatch.StartNew;
  for i := 0 to Adb_dm.CollPatient.ListNodes.Count - 1 do
  begin
    //node := pointer(PByte(CollPatient.ListNodes[i]) - lenNode);
    pat := TRealPatientNewItem(Adb_dm.ACollPatGR.Add);
    //pat := TRealPatientNewItem.Create(nil);
    pat.DataPos := Adb_dm.CollPatient.ListNodes[i].DataPos;
    pat.FNode := pointer(PByte(Adb_dm.CollPatient.ListNodes[i]) - lenNode);
    //pat := CollPatient.Items[i];
    dat := Adb_dm.CollPatient.getDateMap(Adb_dm.CollPatient.ListNodes[i].DataPos, word(PatientNew_BIRTH_DATE));
    log := TlogicalPatientNewSet(Adb_dm.CollPatient.getLogical40Map(Adb_dm.CollPatient.ListNodes[i].DataPos, word(PatientNew_Logical)));
    profGR.SexMale := (TLogicalPatientNew.SEX_TYPE_M in log) ;
    profGR.CurrDate := dat;
    profGR.GeneratePeriod(pat);

    if i < 4100 then
    begin
      profGR.LoadVtrGraph1(pat, i);
    end;
    //FreeAndNil(pat);
  end;
  Elapsed := Stopwatch.Elapsed;
  vtrGraph.EndUpdate;
  //vtrGraph.Clear;
  //CollPatGR.Clear;

  mmoTest.lines.add(Format('%d nodes за  проф: %f', [vtrGraph.TotalCount, Elapsed.TotalMilliseconds]));
end;

procedure TfrmSuperHip.miListAnalysisClick(Sender: TObject);
begin
  if vtrNewAnal.RootNodeCount = 0 then
  begin
    HipNomenAnalsClick(nil);
  end;
  //ChoiceAnal(sender);
  tmpVtr.ChoiceAnal(sender);
  FmxTitleBar.p1.IsOpen := False;
  pgcTree.ActivePage := tsTempVTR;
  vtrTemp.SetFocus;
end;

procedure TfrmSuperHip.miListDoctorClick(Sender: TObject);
begin
  ChoiceDoctor(sender);
  FmxTitleBar.p1.IsOpen := False;
  pgcTree.ActivePage := tsTempVTR;
  vtrTemp.SetFocus;
end;

procedure TfrmSuperHip.miListICDClick(Sender: TObject);
begin
  ChoiceMKB(sender);
  FmxTitleBar.p1.IsOpen := False;
  pgcTree.ActivePage := tsTempVTR;
  vtrTemp.SetFocus;
end;

procedure TfrmSuperHip.miListMedicineClick(Sender: TObject);
begin

end;

procedure TfrmSuperHip.miMainExaminationClick(Sender: TObject);
begin
  FmxTitleBar.p1.IsOpen := False;
  pgcTree.ActivePage := tsTreePat;

  //vtrPregledi.SetFocus;
end;

procedure TfrmSuperHip.MinimizeApp(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TfrmSuperHip.mniDeletePerm1Click(Sender: TObject);
var
  node: PVirtualNode;
begin
  node := PVirtualNode(pmActionPregRev.tag);
  vtrPregledPat.InternalDisconnectNode(node, false);
  Include(node.States, vsdeleting);
  vtrPregledPat.Repaint;
end;

procedure TfrmSuperHip.mniDeletePermClick(Sender: TObject);
var
  node: PVirtualNode;
begin
  node := PVirtualNode(pmActionPreg.tag);
  vtrPregledPat.InternalDisconnectNode(node, false);
  Include(node.States, vsdeleting);
  vtrPregledPat.Repaint;
end;

//procedure TfrmSuperHip.mmo1HeightChange(sender: TSizeGripMemo; NewHeight: Integer);
//var
//  delta: Integer;
//  dynBox: TDynGroupBox;
//  dynMemo: TDynMemo;
//  i: Integer;
//  r: TRect;
//begin
//  Exit;
//  delta := NewHeight - sender.Height;
//  if delta = 0 then  Exit;
//  dynMemo := TDynMemo(sender.FDynMemo);
//
//  for i := 3 downto 3 do
//  begin
//    dynBox := TDynGroupBox(DynWinPanel1.ListGroups[i].FDynGroupBox);
//    dynBox.FRect.Offset(0, Round(delta / DynWinPanel1.Scale));
//    dynBox.CalcChild;
//    dynBox.MoveChild(0, delta);
//
//
//  end;
//  //DynWinPanel1.ListGroups[0].CanMove := False;
//  dynBox := TDynGroupBox(DynWinPanel1.ListGroups[0].FDynGroupBox);
//  //dynBox.FRect.Bottom := dynMemo.FRect.Bottom +20;
//  //DynWinPanel1.ListGroups[0].DynToControl(dynBox.FRect.Left, dynBox.FRect.Top);
//  dynBox.FRect.Bottom := dynMemo.FRect.Bottom;
//  //r := DynWinPanel1.ListGroups[0].BoundsRect;
//  //r.Bottom := dynMemo.FRect.Bottom  := r;
//  //DynWinPanel1.ListGroups[0].CanMove := True;
//
//  //DynWinPanel1.ListGroups[1].CanMove := False;
//  dynBox := TDynGroupBox(DynWinPanel1.ListGroups[1].FDynGroupBox);
//  dynBox.FRect.Bottom := dynMemo.FRect.Bottom +10;
//  //DynWinPanel1.ListGroups[0].Height  := DynWinPanel1.ListGroups[0].Height + delta;
//  //DynWinPanel1.ListGroups[1].CanMove := True;
//  //DynWinPanel1.ListGroups[1].Height  := DynWinPanel1.ListGroups[1].Height + delta;
//  //sender.Height := NewHeight;
//
//
//  DynWinPanel1.Refresh;
//  //ShowDynPregled(vtrPregledPat.GetFirstSelected(), vtrPregledPat.GetFirstSelected().Parent, [NewHeight]);
//end;

procedure TfrmSuperHip.mniAgeClick(Sender: TObject);
begin
  FSortPat := spAge;
  vtrPregledPat.Sort(vtrPregledPat.RootNode.FirstChild, 0, sdAscending, false);
end;

procedure TfrmSuperHip.mniAnalsClick(Sender: TObject);
begin
  pnlRoleView.Roles.ActivePanel := RolPnlNomen;
  RolPnlNomen.FillIcon(pnlRoleView);

  NzisNomenClick(pnlRoleView.Roles.Items[3].MainButtons.Items[0]);
  //pnlRoleView.Roles.Items[3].MainButtons.Items[0].Description
  //pnlRoleView.Roles.Items[3].MainButtons.Items[0].Click;
  HipNomenAnalsClick(nil);
end;

procedure TfrmSuperHip.mniClearFilterClick(Sender: TObject);
var
  node: PVirtualNode;
begin
  Exit;
  vtrTemp.BeginUpdate;
  node := vtrTemp.GetFirst();
  if node = nil then Exit;
 // vtrTemp.FullCollapse(node);
  vtrTemp.IterateSubtree(node, IterateRemoveFilter, nil);
  vtrTemp.EndUpdate;
end;

procedure TfrmSuperHip.mniCollapseSelectClick(Sender: TObject);
var
  node: PVirtualNode;
begin
  node := vtrTemp.GetFirstSelected();
  if node = nil then Exit;
  vtrTemp.FullCollapse(node);
end;

procedure TfrmSuperHip.mniDataDoctorsClick(Sender: TObject);
begin
  if vtrDoctor.TotalCount < 1 then
    LoadVtrDoctor;
  pgcTree.ActivePage := tsVTRDoctors;
end;

procedure TfrmSuperHip.mniDbTablesClick(Sender: TObject);
begin
  FmxTitleBar.p1.IsOpen := False;
  pgcTree.ActivePage := tsTreeDBFB;
  vtrFDB.SetFocus;
end;

procedure TfrmSuperHip.mniExpandSelectClick(Sender: TObject);
var
  node: PVirtualNode;
begin
  node := vtrTemp.GetFirstSelected();
  if node = nil then Exit;
  vtrTemp.FullExpand(node);
end;

procedure TfrmSuperHip.mniFindDeletedNodesClick(Sender: TObject);
var
  Run, ParentNode: PVirtualNode;
  linkpos, FPosLinkData: Cardinal;
  pCardinaldata: PCardinal;
begin
  ParentNode := PVirtualNode(pmActionPreg.tag);
  linkPos := 100;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  FPosLinkData := pCardinalData^;

  while linkPos <= FPosLinkData do
  begin
    run := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
    if (run.Parent = ParentNode) and (vsDeleting in Run.States) then
    begin
      mmoTest.Lines.add(IntToStr(Integer(run)));
    end;
    Inc(linkPos, LenData);
  end;

end;

procedure TfrmSuperHip.mniJurnalNzisClick(Sender: TObject);
begin
  tmpVtr. ChoiceNzisHist(sender);
  FmxTitleBar.p1.IsOpen := False;
  pgcTree.ActivePage := tsTempVTR;
  vtrTemp.SetFocus;
end;

procedure TfrmSuperHip.mnimemotest1Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to grdSearch.Columns.Count - 1 do
  begin
    mmoTest.Lines.Add(Format('%d', [grdSearch.Columns[i].Id]));// := grdSearch.Columns[i].Index;
  end;
end;

procedure TfrmSuperHip.mniMkb10Click(Sender: TObject);
begin
  ChoiceMKB(nil);
end;

procedure TfrmSuperHip.mniN1Click(Sender: TObject);
var
  node: PVirtualNode;
  data: PAspRec;
  preg: TRealPregledNewItem;
begin
  node := PVirtualNode(pmActionPreg.tag);
  data := pointer(PByte(node) + lenNode);
  Adb_dm.CollPregled.SetIntMap(data.DataPos, word(PregledNew_AMB_LISTN), 88);
  Adb_dm.ListPregledLinkForInsert.Add(node);
  CheckCollForSave;
end;

procedure TfrmSuperHip.mniNasMestoClick(Sender: TObject);
var
  i, j, k: Integer;
  OblColl: TRealOblastColl;
  obshtColl: TRealObshtinaColl;
  nasMestoColl: TRealNasMestoColl;
  vRootNasMesta, vObl, vObsht, vNasMesto: PVirtualNode;

  obl: TRealOblastItem;
  obsht: TRealObshtinaItem;
  nasMesto: TRealNasMestoItem;
begin
  Stopwatch := TStopwatch.StartNew;
  FmxTitleBar.p1.IsOpen := False;
  FNasMesto.LoadVtrSelf;
  //if True then

  //OblColl := TRealOblastColl.Create(TRealOblastItem);
//  OblColl.LoadFromFile('cdsOblast.csv');
//  obshtColl := TRealObshtinaColl.Create(TRealObshtinaItem);
//  obshtColl.LoadFromFile('cdsObshtina.csv');
//  nasMestoColl := TRealNasMestoColl.Create(TRealNasMestoItem);
//  nasMestoColl.LoadFromFile('cdsNas_mqsto.csv');
//
//  nasMestoColl.FillNasMestoInObshtina(obshtColl, OblColl);
//  vtrTemp.BeginUpdate;
//  vRootNasMesta := vtrTemp.AddChild(nil, nil);
//  for i := 0 to OblColl.Count - 1 do
//  begin
//    obl := OblColl.Items[i];
//    vObl := vtrTemp.AddChild(vRootNasMesta, nil);
//    for j := 0 to obl.Obshtini.Count - 1 do
//    begin
//      obsht := obl.Obshtini[j];
//      vObsht := vtrTemp.AddChild(vObl, nil);
//      for k := 0 to obsht.NasMesta.Count - 1 do
//      begin
//        nasMesto := obsht.NasMesta[k];
//        vNasMesto := vtrTemp.AddChild(vObsht, nil);
//      end;
//    end;
//  end;
//  vtrTemp.FullExpand();
//  vtrTemp.EndUpdate;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'mniNasMestoClick ' + FloatToStr(Elapsed.TotalMilliseconds));

  pgcTree.ActivePage := tsNasMesta;
end;

procedure TfrmSuperHip.mniNomenNzisClick(Sender: TObject);
begin
  pnlRoleView.Roles.ActivePanel := RolPnlNomen;
  RolPnlNomen.FillIcon(pnlRoleView);
  //pnlRoleView.Roles.Items[3].MainButtons.Items[1].FButton.Click;
  NzisNomenClick(pnlRoleView.Roles.Items[3].MainButtons.Items[1]);
end;

procedure TfrmSuperHip.mniNzisNomenClick(Sender: TObject);
begin
  pgcTree.ActivePage := tsNomenNzis;
  //OpenBufNomenNzis('NzisNomen.adb');
  if vRootNzisBiznes.ChildCount = 0 then
  begin

  end
  else
  begin
    //vtrNomenNzis.DeleteChildren(vRootNzisBiznes);
  end;
  LoadVtrNomenNzis2;
  vtrNomenNzis.SetFocus;
end;

procedure TfrmSuperHip.mniOnlyCloningClick(Sender: TObject);
var
  node: PVirtualNode;
begin
  Exit;
  vtrTemp.BeginUpdate;
  node := vtrTemp.GetFirst();
  if node = nil then Exit;
 // vtrTemp.FullCollapse(node);
  vtrTemp.IterateSubtree(node, IterateFilterOnlyCloning, nil);
  vtrTemp.EndUpdate;
end;

procedure TfrmSuperHip.mniPatientSearchViewClick(Sender: TObject);
begin
  grdSearch.Tag := Cardinal(Adb_dm.CollPatient);
  //thrSearch.CollPat.ShowLinksGrid(grdSearch);
end;

procedure TfrmSuperHip.mniPregledSearchViewClick(Sender: TObject);
var
  i: Integer;
begin
  grdSearch.Tag := Cardinal(Adb_dm.CollPregled);
  //thrSearch.collPreg.ShowLinksGrid(grdSearch);
end;

procedure TfrmSuperHip.mniRemontCloningsClick(Sender: TObject);
begin
  RemontCloning;
end;

procedure TfrmSuperHip.mniRemontPatClick(Sender: TObject);
begin
  RemontPat;
end;

procedure TfrmSuperHip.mniSetingsClick(Sender: TObject);
begin
  FmxTitleBar.p1.IsOpen := False;
  pgcTree.ActivePage := tsLinkOptions;
  vtrLinkOptions.SetFocus;
end;

procedure TfrmSuperHip.mniSortEGNClick(Sender: TObject);
begin
  FSortPat := spEgn;
  vtrPregledPat.Sort(vtrPregledPat.RootNode.FirstChild, 0, sdAscending, false);
end;

procedure TfrmSuperHip.mniSortStartPregClick(Sender: TObject);
begin
  FSortPat := spStartPreg;
  vtrPregledPat.Sort(vtrPregledPat.RootNode.FirstChild, 0, sdAscending, false);
end;

procedure TfrmSuperHip.MouseTitleDblClick(Sender: TObject; var txt: string);
begin
  Self.WindowState := wsMaximized;
  txt := '2';
end;

procedure TfrmSuperHip.MouseTitleDown(Sender: TObject);
begin
  ReleaseCapture;
  Perform(WM_NCLBUTTONDOWN, HTCAPTION, 0);
  //SendMessage(self.Handle, WM_SYSCOMMAND, 61458, 0) ;
end;

procedure TfrmSuperHip.OfLinePregX013(pregNode: PVirtualNode);
var
  nzisThr: TNzisThread;
  data: PAspRec;
begin
  if (edtToken.Text = '') or (Now > TokenToTime) then
  begin
    btnTokenClick(nil);
  end;

  //Adb_DM.CollPrac := CollPractica;
//  Adb_DM.CollDoc := CollDoctor;

  nzisThr := TNzisThread.Create(false, Adb_DM);
  nzisThr.FreeOnTerminate := True;
  nzisThr.IsTestNZIS := true;

  nzisThr.OnSended := NzisOnSended;
  nzisThr.HndSuperHip := Self.Handle;
  nzisThr.Node := pregNode;
  nzisThr.MsgType := TNzisMsgType.X013;
  nzisThr.token := edtToken.Text;
  nzisThr.CurrentCert := CertForThread;
  nzisThr.Resume;
end;

procedure TfrmSuperHip.OnActivateFMX(sender: TObject);
begin
 // if vtrPregledPat.MouseInClient then
   // vtrPregledPat.SetFocus;
end;

procedure TfrmSuperHip.OnAddNewNodeFilter(NewNode, adbNode: PVirtualNode);
var
  coll: TBaseCollection;
  AspAdb: PAspRec;
  aspNewNode: PAspRecFilter;

  CollType: TCollectionsType;
  PCollType: ^TCollectionsType;
  i: integer;
  linkPos: Cardinal;
  run: PVirtualNode;
begin
  AspAdb := Pointer(PByte(adbNode) + lenNode);
  if AspAdb.DataPos = 0 then Exit;

  NewNode.CheckType := ctCheckBox;
  NewNode.CheckState := csUncheckedNormal;

  PCollType := Pointer(PByte(Adb_DM.AdbMain.Buf) + AspAdb.DataPos - 4);
  CollType := TCollectionsType(PCollType^);
  coll := GetCollectionByType(Word(CollType));
  for i := 0 to  coll.FieldCount - 1 do
  begin
    AspectsFilterLinkFile.AddNewNode(vvFieldFilter, 0, NewNode , amAddChildlast, run, linkPos);
    aspNewNode := Pointer(PByte(NewNode) + lenNode);
    aspNewNode.CollType := (CollType);
    run.Dummy := i;
    run.CheckType := ctCheckBox;
    run.CheckState := csCheckedNormal;
    // тук добавяме операторите
    AddOperatorNodes(run, coll, i);
  end;

end;

procedure TfrmSuperHip.OnApplicationHint(Sender: TObject);
begin
  //
end;

procedure TfrmSuperHip.ChangeColl(sender: TObject);
begin
  vtrPregledPat.Repaint;
  CheckCollForSave;
end;

procedure TfrmSuperHip.OnChangeYear(sender: TObject);
begin
  lblYear.Caption := inttostr(Adb_dm.CollUnfav.CurrentYear);
  if vtrSpisyci.Header.Columns.Count > 0 then
  begin
    vtrSpisyci.Header.Columns[0].Text := format('Лекари' + #13#10 + 'За %d г. по месеци', [Adb_dm.collunfav.CurrentYear]);
    vtrSpisyci.Repaint;
  end;
end;

procedure TfrmSuperHip.OnClosePregled(Sender: TObject);
var
  preg: TRealPregledNewItem;
begin
  if edtCertNom.Text = '' then
  begin
    try
      try
        FillCertInDoctors;
        if Adb_dm.CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          edtCertNom.Text := BuildHexString(Adb_dm.CollDoctor.Items[0].Cert.SerialNumber);
          Adb_dm.CollDoctor.Items[0].Cert.Clone(CertForThread);
          Adb_dm.CollDoctor.Items[0].Cert.Clone(CurrentCert);
          if edtToken.Text = '' then
          begin
            httpNZIS.OnData := httpNZISDataToken;
            httpNZIS.Close;
            httpNZIS.Get('https://auth.his.bg/token');
            ReadToken(ResultNzisToken.Text);
          end;
          if edtToken.Text <> '' then
          begin
            preg := TRealPregledNewItem(Sender);
            //FmxProfForm.animNrnStatus.Enabled := true;
            ClosePregX003(preg.FNode);
          end;
        end
        else // Не е намерен подпис за доктора
        begin
          // zzzzzzzzzzzzz
        end;
      except
        Exit;
      end;
    finally
      //FmxProfForm.animNrnStatus.Enabled := False;
//      FmxProfForm.linStatusNRN.Opacity := 1;
//      FmxProfForm.edtAmbList.Repaint;
    end;
  end
  else
  begin
    try
      try
        if Adb_dm.CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          if CurrentCert = nil then
            CurrentCert := TelX509Certificate.Create(self);
          Adb_dm.CollDoctor.Items[0].Cert.Clone(CertForThread);
          Adb_dm.CollDoctor.Items[0].Cert.Clone(CurrentCert);
        end
        else
        begin
          edtCertNom.Text := '';
          Exit;
        end;
        if edtToken.Text = '' then
        begin
          httpNZIS.OnData := httpNZISDataToken;
          httpNZIS.Close;
          httpNZIS.Get('https://auth.his.bg/token');
          ReadToken(ResultNzisToken.Text);
        end;
        if edtToken.Text <> '' then
        begin
          preg := TRealPregledNewItem(Sender);
          //FmxProfForm.animNrnStatus.Enabled := true;
          ClosePregX003(preg.FNode);
        end;
      except
        Exit;
      end;
    finally
      //FmxProfForm.animNrnStatus.Enabled := False;
//      FmxProfForm.linStatusNRN.Opacity := 1;
//      FmxProfForm.edtAmbList.Repaint;
    end;
  end;
end;

procedure TfrmSuperHip.OnClosePregled1(Sender: TObject);
var
  preg: TRealPregledNewItem;
begin
  preg := TRealPregledNewItem(Sender);
  ClosePregX003(preg.FNode);
end;

procedure TfrmSuperHip.Panel2MouseEnter(Sender: TObject);
begin
  //panel2.Color := $00FCF3E9; //$00F9EDAC;
end;

procedure TfrmSuperHip.Panel2MouseLeave(Sender: TObject);
begin
  //panel2.Color := clBtnFace;
end;

procedure TfrmSuperHip.RolPnlAdminStartRole(Sender: TObject);
begin
  pnlRoleView.Roles.ActivePanel := RolPnlAdmin;
  RolPnlAdmin.FillIcon(pnlRoleView);
end;

procedure TfrmSuperHip.pnlTreeResize(Sender: TObject);
begin
  //pnlRoleView.Top := 50;
//  pnlRoleView.Height := pnlTree.Height-50;
end;

procedure TfrmSuperHip.prepareHeaders(Sender: TObject; Headers: TStringList);
begin
  Headers.Add('Content-Type: application/xml');
end;

procedure TfrmSuperHip.rgTipoveClick(Sender: TObject);
begin
  case rgTipove.ItemIndex of
    0:
    begin
      rgNzisMessage.Enabled := True;
      rgImun.Enabled := false;
    end;
    1:
    begin
      rgNzisMessage.Enabled := false;
      rgImun.Enabled := true;
    end;
  end;
end;

procedure TfrmSuperHip.rlbtn1Click(Sender: TObject);
begin
  //Label1.Visible := True;
//  lbl4.Visible := True;
//  RoleButton1.Visible := True;
//  rlbtnNzisNomen.Visible := True;
//  pgcTree.ActivePage := tsNomen;
//  pgcWork.ActivePage := nil;
end;

procedure TfrmSuperHip.rlbtn3Click(Sender: TObject);
begin
 // pgcTree.ActivePage := tsTreePregledi;
//  pgcWork.ActivePage := nil;
//  Label1.Visible := False;
//  lbl4.Visible := False;
//  RoleButton1.Visible := False;
//  rlbtnNzisNomen.Visible := False;
end;

procedure TfrmSuperHip.rlbtnSubPreg_PatClick(Sender: TObject);
begin

  //LoadVtrPregledOnPat;
end;

procedure TfrmSuperHip.rlbtnSubPreg_PregClick(Sender: TObject);
begin
  //LoadVtrPregled;
end;

procedure TfrmSuperHip.rlbtnNzisNomenClick(Sender: TObject);
var
  i: Integer;
begin
  //pgcRole.ActivePage := tsRoleSelect;
//  pgcTree.ActivePage := tsTreeRole;
//
//  pgcWork.ActivePage := nil;
//
//  FRoleManger.DrawRoleSheet;
//  scrlbxRole.SetFocus;
//  rlbtn1.Down := False;
//  rlbtn3.Down := False;
//
//  Label1.Visible := False;
//  lbl4.Visible := False;
//  RoleButton1.Visible := False;
//  rlbtnNzisNomen.Visible := False;

end;

procedure TfrmSuperHip.RoleBarBtnRoleClick(Sender: TObject);
begin
  pgcTree.ActivePage := tsTreeRole;
  pgcRole.ActivePage := tsFmxRoleSelect;
  InternalChangeWorkPage(nil);
end;

procedure TfrmSuperHip.RoleBarOnProgres(Sender: TObject; var progres: integer);
begin
  fmxCntrRoleBar.Width := progres;
end;

procedure TfrmSuperHip.RolPnl1Click(Sender: TObject);
begin
  //RolPnl1.LoadImage('D:\iconPng\rentgen.png');
end;

procedure TfrmSuperHip.RolPnlDoctorSpecStartRole(Sender: TObject);
begin
  RolPnlDoctorSpec.FillIcon(pnlRoleView);
  pnlRoleView.Roles.ActivePanel := RolPnlDoctorSpec;
end;

procedure TfrmSuperHip.RolPnlDoktorOPLStartRole(Sender: TObject);
begin
  RolPnlDoktorOPL.FillIcon(pnlRoleView);
  pnlRoleView.Roles.ActivePanel := RolPnlDoktorOPL;
  LoadVtrFDB;

end;


procedure TfrmSuperHip.RolPnlNomenStartRole(Sender: TObject);
begin
  RolPnlNomen.FillIcon(pnlRoleView);
  pnlRoleView.Roles.ActivePanel := RolPnlNomen;
end;

procedure TfrmSuperHip.RunInIncMN(IncMn: TRealINC_NAPRItem; isNew: Boolean);
var
  RunNodeInIncMN: PVirtualNode;
  IncMnNode: PVirtualNode;
  dataIncMN, dataInIncMn: PAspRec;
  IncMnNrn, PregledNRN: string;
  preg: TRealPregledNewItem;
  patNode: PVirtualNode;
begin
  IncMnNode := IncMn.FNode;
  RunNodeInIncMN := IncMnNode.FirstChild;
  while RunNodeInIncMN <> nil do
  begin
    dataInIncMn := Pointer(PByte(RunNodeInIncMN)+ lenNode);
    case dataInIncMn.vid of
      vvPregled:
      begin
        preg := TRealPregledNewItem(Adb_dm.CollPregled.Add);
        preg.DataPos := dataInIncMn.DataPos;
        preg.FNode := RunNodeInIncMN;
        //preg.Fpatient := patient;
        //patient.FPregledi.Add(preg);

        if Adb_dm.CollPregled.getIntMap(dataInIncMn.DataPos, word(PregledNew_ID)) = 0 then
        begin
          FDBHelper.SavePregledFDB(preg, Fdm.ibsqlCommand);
          dataIncMN := Pointer(PByte(IncMnNode)+ lenNode);

          PregledNRN := Adb_dm.CollPregled.getAnsiStringMap(dataInIncMn.DataPos, Word(PregledNew_NRN_LRN));
          IncMnNrn := Adb_dm.CollIncMN.getAnsiStringMap(dataIncMN.DataPos, Word(INC_NAPR_NRN));
          if isNew then
          begin
            //mmoTest.Lines.Add(format('нов преглед: %s  в нов пациент: %s ', [PregledNRN, patEgn] ));
          end
          else
          begin
            //mmoTest.Lines.Add(format('нов преглед: %s  в стар пациент: %s ', [PregledNRN, patEgn] ));
          end;
          RunInPregled(preg, true);
        end;
      end;
    end;
    RunNodeInIncMN := RunNodeInIncMN.NextSibling;
  end;
end;

procedure TfrmSuperHip.RunInPat(patient: TRealPatientNewItem; isNew: Boolean);
var
  RunNodeInPat, patNode: PVirtualNode;
  dataPat, dataInPat: PAspRec;
  patEgn, IncMNNRN, PregledNRN: string;
  incMN: TRealINC_NAPRItem;
  preg: TRealPregledNewItem;
begin
  patNode := patient.FNode;
  RunNodeInPat := patNode.FirstChild;
  while RunNodeInPat <> nil do
  begin
    dataInPat := Pointer(PByte(RunNodeInPat)+ lenNode);
    case dataInPat.vid of
      vvIncMN:
      begin
        incMN := TRealINC_NAPRItem(Adb_dm.CollIncMN.Add);
        incMN.FNode := RunNodeInPat;
        incMN.FPatient := patient;
        patient.FIncMNs.Add(incMn);
        if Adb_dm.CollIncMN.getIntMap(dataInPat.DataPos, word(INC_NAPR_ID)) = 0 then
        begin
          dataPat := Pointer(PByte(patNode)+ lenNode);

          IncMNNRN := Adb_dm.CollIncMN.getAnsiStringMap(dataInPat.DataPos, Word(INC_NAPR_NRN));
          patEgn := Adb_dm.CollPatient.getAnsiStringMap(dataPat.DataPos, Word(PatientNew_EGN));
          if isNew then
          begin
            //mmoTest.Lines.Add(format('ново вх. напр.: %s  в нов пациент: %s ', [IncMNNRN, patEgn] ));
          end
          else
          begin
            //mmoTest.Lines.Add(format('ново вх. напр.: %s  в стар пациент: %s ', [IncMNNRN, patEgn] ));
          end;
          RunInIncMN(incMN, true);
        end
        else
        begin
          RunInIncMN(incMN, false);
        end;
      end;
      vvPregled:
      begin
        preg := TRealPregledNewItem(Adb_dm.CollPregled.Add);
        preg.DataPos := dataInPat.DataPos;
        preg.FNode := RunNodeInPat;
        preg.Fpatient := patient;
        patient.FPregledi.Add(preg);
        if Adb_dm.CollPregled.getIntMap(dataInPat.DataPos, word(PregledNew_ID)) = 0 then
        begin
          FDBHelper.SavePregledFDB(preg, Fdm.ibsqlCommand);
          dataPat := Pointer(PByte(patNode)+ lenNode);

          PregledNRN := Adb_dm.CollPregled.getAnsiStringMap(dataInPat.DataPos, Word(PregledNew_NRN_LRN));
          patEgn := Adb_dm.CollPatient.getAnsiStringMap(dataPat.DataPos, Word(PatientNew_EGN));
          if isNew then
          begin
            //mmoTest.Lines.Add(format('нов преглед: %s  в нов пациент: %s ', [PregledNRN, patEgn] ));
          end
          else
          begin
            //mmoTest.Lines.Add(format('нов преглед: %s  в стар пациент: %s ', [PregledNRN, patEgn] ));
          end;
          RunInPregled(preg, true);
        end
        else
        begin
          RunInPregled(preg, false);
        end;

      end;
    end;
    RunNodeInPat := RunNodeInPat.NextSibling;
  end;
end;

procedure TfrmSuperHip.RunInPregled(Preg: TRealPregledNewItem; isNew: Boolean);
var
  RunNodeInPregled: PVirtualNode;
  PregNode: PVirtualNode;
  dataMDN, dataInPreg, dataPreg: PAspRec;
  MdnNrn, PregledNRN: string;
  mdn: TRealMDNItem;
  k: integer;
  anal: TRealExamAnalysisItem;
begin
  PregNode := preg.FNode;
  RunNodeInPregled := PregNode.FirstChild;
  while RunNodeInPregled <> nil do
  begin
    dataInPreg := Pointer(PByte(RunNodeInPregled)+ lenNode);
    dataPreg := Pointer(PByte(PregNode)+ lenNode);
    case dataInPreg.vid of
      vvmdn:
      begin
        mdn := TRealMDNItem(Adb_dm.CollMDN.add);
        mdn.FNode := RunNodeInPregled;
        mdn.DataPos :=dataInPreg.DataPos;
        mdn.PregledID := Adb_dm.CollPregled.getIntMap(dataPreg.DataPos, Word(PregledNew_ID));;
        mdn.FPregled := preg;
        preg.FMdns.Add(mdn);
        if Adb_dm.CollMDN.getIntMap(dataInPreg.DataPos, word(MDN_ID)) = 0 then
        begin
          dataMDN := Pointer(PByte(mdn.FNode)+ lenNode);

          PregledNRN := Adb_dm.CollPregled.getAnsiStringMap(dataInPreg.DataPos, Word(PregledNew_NRN_LRN));
          MdnNrn := Adb_dm.CollMDN.getAnsiStringMap(dataMDN.DataPos, Word(MDN_NRN));
          FDBHelper.SaveMdn(mdn, Fdm.ibsqlCommand);
          for k :=  mdn.FExamAnals.Count - 1 downto 0 do
          begin
            anal := mdn.FExamAnals[k];
            anal.FMdn := mdn;
            FDBHelper.SaveExamAnals(anal, Fdm.ibsqlCommand);
            //mdn.FExamAnals.Delete(k);
          end;
          if isNew then
          begin
            //mmoTest.Lines.Add(format('нов преглед: %s  в нов пациент: %s ', [PregledNRN, patEgn] ));
          end
          else
          begin
            //mmoTest.Lines.Add(format('нов преглед: %s  в стар пациент: %s ', [PregledNRN, patEgn] ));
          end;
        end;
      end;
    end;
    RunNodeInPregled := RunNodeInPregled.NextSibling;
  end;
end;

//procedure TfrmSuperHip.ScaleDyn(sender: TObject);
//begin
//  fmxCntrDyn.Width := Max(Round(FmxFormDyn.scldlyt1.Width), scrlbx1.Width);
//  fmxCntrDyn.Height := Max(Round(FmxFormDyn.scldlyt1.Height), scrlbx1.Height);
//  FmxFormDyn.lytButtons.Position.x := scrlbx1.Width - FmxFormDyn.lytButtons.Width -
//         30 + scrlbx1.HorzScrollBar.Position;
//  scrlbx1.VertScrollBar.Range := Round(FmxFormDyn.scldlyt1.Height);
//  scrlbx1.HorzScrollBar.Range := Round(FmxFormDyn.scldlyt1.Width);
//  FmxFormDyn.lytButtons.Position.Y := scrlbx1.top + 10 + scrlbx1.VertScrollBar.Position;
//
//
//  //Caption := 'ssss' +  FloatToStr(FmxFormDyn.Layout1.Position.x);
//end;

procedure TfrmSuperHip.scrlbx1Resize(Sender: TObject);
begin
  //
end;

procedure TfrmSuperHip.scrlbxRoleClick(Sender: TObject);
begin
  scrlbxRole.SetFocus;
end;

procedure TfrmSuperHip.scrlbxRoleMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  aPos: SmallInt;
begin
  aPos:= scrlbxRole.VertScrollBar.Position - WheelDelta div 5;
  aPos:= System.Math.Max(aPos, 0);
  aPos:= System.Math.Min(aPos, scrlbxRole.VertScrollBar.Range);
  scrlbxRole.VertScrollBar.Position := aPos;
  Handled := True;
end;

procedure TfrmSuperHip.SearchTest;
var
  run, node: PVirtualNode;
  dataRun, data: PAspRec;
  target: PAnsiChar;
  targetLen: Word;
  p: PAnsiChar;
  len: Word;
  i: Integer;
begin
  target := '111111111111111';
  targetLen := Length('111111111111111');

  Stopwatch := TStopwatch.StartNew;
  node := vtrSearch.GetFirstSelected();
  data := Pointer(PByte(node)+ lenNode);
  for i := 0 to AspectsLinkPatPregFile.JoinResult[Data.index].AdbList.Count - 1 do
  begin
    run := AspectsLinkPatPregFile.JoinResult[Data.index].AdbList[i];
    dataRun := Pointer(PByte(run)+ lenNode);

    // вземаме PAnsiChar и length директно от ADB буфера
    p := Adb_DM.CollPregled.getPAnsiStringMap(
            dataRun.DataPos,
            Word(PregledNew_NRN_LRN),
            len);

    // ако няма стойност
    if p = nil then
      Continue;

    // ако дължината не съвпада — няма смисъл да сравняваме
    if len <> targetLen then
      Continue;

    // директно memory сравнение — НАЙ-БЪРЗОТО ВЪЗМОЖНО
    if CompareMem(p, target, len) then
      break;
  end;

  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add('loop-fast ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.SearchTesStartsWith_CI;
var
  target: AnsiString;
  targetLen: Word;
  up: array[AnsiChar] of AnsiChar;

  p: PAnsiChar;
  len: Word;
  i, j: Integer;

  data, dataRun: PAspRec;
  run, node: PVirtualNode;
begin
  // target
  target := '24';
  targetLen := Length(target);

  // build ascii uppercase table
  for i := 0 to 255 do
    up[AnsiChar(i)] := AnsiChar(UpperCase(Char(i))[1]);

  Stopwatch := TStopwatch.StartNew;

  node := vtrSearch.GetFirstSelected();
  data := Pointer(PByte(node) + lenNode);

  for i := 0 to AspectsLinkPatPregFile.JoinResult[data.index].AdbList.Count - 1 do
  begin
    run := AspectsLinkPatPregFile.JoinResult[data.index].AdbList[i];
    dataRun := Pointer(PByte(run) + lenNode);

    p := Adb_DM.CollPregled.getPAnsiStringMap(
           dataRun.DataPos,
           Word(PregledNew_NRN_LRN),
           len
        );

    if (p = nil) or (len < targetLen) then
      Continue;

    // manual case-insensitive compare
    for j := 0 to targetLen - 1 do
      if up[p[j]] <> up[PAnsiChar(target)[j]] then
      begin      
        Adb_DM.CollPregled.ListDataPos.Add(run);
      end;        

    if j = targetLen then
    begin    
      Adb_DM.CollPregled.ListDataPos.Add(run);
    end;      
  end;

  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add('loop-startswith-ci ' + FloatToStr(Elapsed.TotalMilliseconds));
end;


procedure TfrmSuperHip.SearchTesStartsWith;
var
  target: AnsiString;
  targetLen: Word;
  p, p2: PAnsiChar;
  len: Word;
  i: Integer;
  data, dataRun: PAspRec;
  run, node: PVirtualNode;

begin
  target := '2607';
  targetLen := Length(target);
  p2 := PAnsiChar(target);

  Stopwatch := TStopwatch.StartNew;
  node := vtrSearch.GetFirstSelected();
  data := Pointer(PByte(node) + lenNode);

  for i := 0 to AspectsLinkPatPregFile.JoinResult[data.index].AdbList.Count - 1 do
  begin
    run := AspectsLinkPatPregFile.JoinResult[data.index].AdbList[i];
    dataRun := Pointer(PByte(run) + lenNode);

    p := Adb_DM.CollPregled.getPAnsiStringMap(
           dataRun.DataPos,
           Word(PregledNew_NRN_LRN),
           len
        );

    if (p = nil) or (len < targetLen) then
      Continue;

    if CompareMem(p, p2, targetLen) then
      Break;
  end;

  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add('loop-startswith ' + FloatToStr(Elapsed.TotalMilliseconds));
end;


procedure TfrmSuperHip.SearchTesBMH_contain;
var
  target: AnsiString;
  targetLen: Word;
  patBuf: PAnsiChar;

  badChar: array[0..255] of Integer;

  p: PAnsiChar;
  len: Word;

  i: Integer;
  data, dataRun: PAspRec;
  run, node: PVirtualNode;

begin
  // user pattern
  target := '№234';   // може да е подниз, не пълен NRN
  targetLen := Length(target);
  patBuf := PAnsiChar(target);

  // build BMH bad-char table ONCE
  BuildBMHTable(patBuf, targetLen, badChar);

  // start timing
  Stopwatch := TStopwatch.StartNew;

  node := vtrSearch.GetFirstSelected();
  data := Pointer(PByte(node) + lenNode);

  for i := 0 to AspectsLinkPatPregFile.JoinResult[data.index].AdbList.Count - 1 do
  begin
    run := AspectsLinkPatPregFile.JoinResult[data.index].AdbList[i];
    dataRun := Pointer(PByte(run) + lenNode);

    // get pointer to string in the ADB buffer
    p := Adb_DM.CollPregled.getPAnsiStringMap(
            dataRun.DataPos,
            Word(PregledNew_NRN_LRN),
            len
         );

    if (p = nil) or (len < targetLen) then
      Continue;

    if ContainsBMHFast(
          p, len,
          patBuf, targetLen,
          cmCaseInsensitive,
          badChar
       ) then
      Break;
  end;

  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add('loop-BMH-contains ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.SearchTesCRC_equ;
function CRC32(const data: PAnsiChar; len: Integer): Cardinal;
var
  i: Integer;
  c: Cardinal;
begin
  c := $FFFFFFFF;
  for i := 0 to len - 1 do
    c := CRC32_TABLE[(c xor Ord(data[i])) and $FF] xor (c shr 8);
  Result := not c;
end;

var
  target: AnsiString;
  targetLen: Word;
  targetCRC, crc: Cardinal;
  p: PAnsiChar;
  len: Word;
  i: Integer;
  data, dataRun: PAspRec;
  run, node: PVirtualNode;
  
begin
  target := '24075307A67D';
  targetLen := Length(target);
  targetCRC := CRC32(PAnsiChar(target), targetLen);

  Stopwatch := TStopwatch.StartNew;
  node := vtrSearch.GetFirstSelected();
  data := Pointer(PByte(node)+ lenNode);

  for i := 0 to  AspectsLinkPatPregFile.JoinResult[Data.index].AdbList.Count - 1 do
  begin
    run := AspectsLinkPatPregFile.JoinResult[Data.index].AdbList[i];
    dataRun := Pointer(PByte(run) + lenNode);

    p := Adb_DM.CollPregled.getPAnsiStringMap(dataRun.DataPos, Word(PregledNew_NRN_LRN), len);
    if (p = nil) or (len <> targetLen) then
      Continue;

    crc := CRC32(p, len);
    if crc <> targetCRC then
      Continue;

    if CompareMem(p, PAnsiChar(target), len) then
      Break;
  end;

  mmotest.Lines.Add('loop-CRC-fast ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.SelectDoctor(sender: TObject);
begin

end;

procedure TfrmSuperHip.SelectFileOrFolderInExplorer(const sFilename: string);
begin
  ShellExecute(Application.Handle, 'open', 'explorer.exe',
    PChar(Format('/select,"%s"', [sFilename])), nil, SW_NORMAL);
end;

procedure TfrmSuperHip.SelectMKB(sender: TObject);
var
  diag: TRealDiagnosisItem;
begin
  if TVtrVid(vtrTemp.Tag) <> vvDiag then
  begin
    ChoiceMKB(FmxProfForm.Pregled);

  end;
  diag := TRealDiagnosisItem(sender);
  vtrTemp.Selected[diag.MkbNode] := True;
end;

//procedure TfrmSuperHip.SetPatientTemp(const Value: TRealPatientNewItem);
//begin
//  FPatientTemp := Value;
//end;

procedure TfrmSuperHip.SetSearchTextSpisyci(const Value: string);
begin
  FSearchTextSpisyci := Value;
  vtrSpisyci.Repaint;
end;



procedure TfrmSuperHip.SetStyle;
var
  Style: LongInt;
begin
  Style := GetWindowLong(Handle, GWL_STYLE);
   Style := (Style or WS_THICKFRAME or WS_SYSMENU or WS_MINIMIZEBOX or WS_MAXIMIZEBOX)
           and not WS_CAPTION;
  SetWindowLong(Handle, GWL_STYLE, Style);

  // Приложи промените
  SetWindowPos(Handle, 0, 0, 0, 0, 0,
    SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_FRAMECHANGED);
end;

procedure TfrmSuperHip.ShowHint;
begin

end;

procedure TfrmSuperHip.ShowOptionsFMX;
//FmxOptionsFrm: TfrmOptionsForm;
begin
  if FmxOptionsFrm = nil then
  begin
    FmxOptionsFrm := TfrmOptionsForm.Create(nil);
    FmxOptionsFrm.OptionTree := vtrLinkOptions;
    FmxOptionsFrm.BufOptions := AspectsOptionsLinkFile.Buf;
    FmxOptionsFrm.FillListOptionObject;

  end
  else
  begin
    //FmxOptionsFrm.FillTokens;
  end;

  InternalChangeWorkPage(tsFMXForm);


  fmxCntrDyn.ChangeActiveForm(FmxOptionsFrm);
  FmxOptionsFrm.WindowState := wsMaximized;
end;

procedure TfrmSuperHip.ShowPregledFMX(dataPat,dataPreg: PAspRec; linkPreg:PVirtualNode );
var
  edt: TEdit;
  run, runAnal : PVirtualNode;
  dataRun, dataAnal, dataFMXPreg: PAspRec;
  diag: TRealDiagnosisItem;
  performer: TRealDoctorItem;
  mdn: TRealMDNItem;
  mn: TRealBLANKA_MED_NAPRItem;
  immun: TRealExamImmunizationItem;
  anal: TRealExamAnalysisItem;
  i, lastVacantPreg: Integer;
  PosInNomen: integer;
  vScrol: FMX.StdCtrls.TScrollBar;

  nodePlan: PVirtualNode;
  dataPlan: PAspRec;
  cl132Key, cl136Key: string;
  prNomen: string;
  cl132pos, pr001Pos: Cardinal;
  revis: TRevision;

  p: PCardinal;
  ofset: Cardinal;
  dataPatRevision: PAspRec;
  //oldPreg: TRealPregledNewItem;
  TempDiags: TList<TRealDiagnosisItem>;
  TempMns: TList<TRealBLANKA_MED_NAPRItem>;
begin

  if AspectsNomFile = nil then
    OpenBufNomenNzis(paramstr(2) + 'NzisNomen.adb');
  FmxProfForm.AspNomenBuf := AspectsNomFile.Buf;
  FmxProfForm.AspNomenPosData := AspectsNomFile.FPosData;

  Stopwatch := TStopwatch.StartNew;
  //FmxProfForm.scldlyt1.BeginUpdate;
  FmxProfForm.ClearListsPreg;
  TempDiags := TList<TRealDiagnosisItem>.Create;
  TempMns := TList<TRealBLANKA_MED_NAPRItem>.Create;
  //oldPreg := nil;
  FmxProfForm.linkPreg := linkPreg;



  //FmxProfForm.AspNomenHipBuf := AspectsNomHipFile.Buf;
//  FmxProfForm.AspNomenHipPosData := AspectsNomHipFile.FPosData;

  dataRun := pointer(PByte(linkPreg) + lenNode);
  mmoTest.Lines.Add(format('Fill dataPreg = %d', [dataPreg.DataPos]));

  run := linkPreg.Parent.FirstChild; //  събирам останалите прегледи на пациента
  FmxProfForm.OtherPregleds.Clear;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvPregled:
      begin
        if run = linkPreg  then
        begin
          run:= run.NextSibling;
          Continue;
        end;
        FmxProfForm.OtherPregleds.Add(run);
      end;
    end;

    run:= run.NextSibling;
  end;

  run := linkPreg.FirstChild; // ще се обикалят всички неща по прегледа
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvPerformer:
      begin
        FmxProfForm.Doctor.DataPos := dataRun.DataPos;
      end;
      vvDiag:
      begin
        if FmxProfForm.Pregled.CanDeleteDiag then
        begin
          diag := TRealDiagnosisItem.Create(nil);
          diag.DataPos := dataRun.DataPos;
          diag.Node := run;
          //FmxProfForm.Pregled.FDiagnosis.Add(diag);
          TempDiags.Add(diag);
        end
        else
        begin

        end;
      end;
      vvMDN:
      begin
        mdn := Adb_dm.CollMDN.GetItemsFromDataPos(dataRun.DataPos);
        if mdn = nil then
        begin
          mdn := TRealMdnItem.Create(nil);
          mdn.DataPos := dataRun.DataPos;
          mmoTest.Lines.Add(format('Fill mdn.DataPos = %d', [mdn.DataPos]));
          mdn.LinkNode := run;
        end;
        FmxProfForm.Pregled.FMdns.Add(mdn);


        runAnal := run.FirstChild;
        while runAnal <> nil do
        begin
          dataAnal := pointer(PByte(runAnal) + lenNode);
          case dataAnal.vid of
            vvExamAnal:
            begin
              anal := Adb_dm.CollExamAnal.GetItemsFromDataPos(dataAnal.DataPos);
              if anal = nil then
              begin
                anal := TRealExamAnalysisItem.Create(nil);
                anal.DataPos := dataAnal.DataPos;
                mmoTest.Lines.Add(format('Fill anal.DataPos = %d', [anal.DataPos]));
                PosInNomen := anal.getIntMap(Adb_DM.AdbMain.Buf, Adb_DM.AdbMain.FPosData, word(ExamAnalysis_PosDataNomen));
                anal.LinkNode := runAnal;
              end;
              mdn.FExamAnals.Add(anal);
            end;
          end;
          runAnal := runAnal.NextSibling;
        end;
      end;
      vvNZIS_PLANNED_TYPE:
      begin
        nodePlan := run;
        dataPlan := Pointer(PByte(nodePlan) + lenNode);
        cl132Key := Adb_dm.CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
        prNomen := Adb_dm.CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
        cl132pos := Adb_dm.CollNZIS_PLANNED_TYPE.getCardMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_DataPos));
        cl136Key := Adb_dm.CL132Coll.getAnsiStringMap(cl132pos, word(CL132_CL136_Mapping));
        if (cl136Key = '2') and (nodePlan.CheckState = csCheckedNormal) then
        begin
          mdn := Adb_dm.CollMDN.GetItemsFromDataPos(dataRun.DataPos);
          if mdn = nil then
          begin
            mdn := TRealMdnItem.Create(nil);
            mdn.DataPos := dataRun.DataPos;
            mmoTest.Lines.Add(format('Fill mdn.DataPos = %d', [mdn.DataPos]));
            mdn.LinkNode := run;
          end;
          FmxProfForm.Pregled.FMdns.Add(mdn);


          runAnal := run.FirstChild;
          while runAnal <> nil do
          begin
            dataAnal := pointer(PByte(runAnal) + lenNode);
            case dataAnal.vid of
              vvExamAnal:
              begin
                anal := Adb_dm.CollExamAnal.GetItemsFromDataPos(dataAnal.DataPos);
                if anal = nil then
                begin
                  anal := TRealExamAnalysisItem.Create(nil);
                  anal.DataPos := dataAnal.DataPos;
                  mmoTest.Lines.Add(format('Fill anal.DataPos = %d', [anal.DataPos]));
                  PosInNomen := anal.getIntMap(Adb_DM.AdbMain.Buf, Adb_DM.AdbMain.FPosData, word(ExamAnalysis_PosDataNomen));
                  anal.LinkNode := runAnal;
                end;
                mdn.FExamAnals.Add(anal);
              end;
              vvMedNapr:
              begin
                mn := Adb_dm.CollMedNapr.GetItemsFromDataPos(dataAnal.DataPos);
                if mn = nil then
                begin
                  mn := TRealBLANKA_MED_NAPRItem.Create(nil);
                  mn.DataPos := dataAnal.DataPos;
                  mn.LinkNode := run;
                end;
                //FmxProfForm.Pregled.FMNs.Add(mn);
                TempMns.Add(mn);
                //if oldPreg <> nil then
//                begin
//                  mn.FPregled := oldPreg;
//                end
//                else
//                begin
//                  mn.FPregled := FmxProfForm.Pregled;
//                end;
              end;
            end;
            runAnal := runAnal.NextSibling;
          end;
        end
        else
        begin
          nodePlan := run;
          dataPlan := Pointer(PByte(nodePlan) + lenNode);
          cl132Key := Adb_dm.CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
          prNomen := Adb_dm.CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
          cl132pos := Adb_dm.CollNZIS_PLANNED_TYPE.getCardMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_DataPos));
          cl136Key := Adb_dm.CL132Coll.getAnsiStringMap(cl132pos, word(CL132_CL136_Mapping));
          runAnal := run.FirstChild;
          while runAnal <> nil do
          begin
            dataAnal := pointer(PByte(runAnal) + lenNode);
            case dataAnal.vid of
             // vvExamAnal:
//              begin
//                anal := CollExamAnal.GetItemsFromDataPos(dataAnal.DataPos);
//                if anal = nil then
//                begin
//                  anal := TRealExamAnalysisItem.Create(nil);
//                  anal.DataPos := dataAnal.DataPos;
//                  mmoTest.Lines.Add(format('Fill anal.DataPos = %d', [anal.DataPos]));
//                  PosInNomen := anal.getIntMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, word(ExamAnalysis_PosDataNomen));
//                  anal.LinkNode := runAnal;
//                end;
//                mdn.FExamAnals.Add(anal);
//              end;
              vvMedNapr:
              begin
                mn := Adb_dm.CollMedNapr.GetItemsFromDataPos(dataAnal.DataPos);
                if mn = nil then
                begin
                  mn := TRealBLANKA_MED_NAPRItem.Create(nil);
                  mn.DataPos := dataAnal.DataPos;
                  mn.LinkNode := run;
                end;
                //FmxProfForm.Pregled.FMNs.Add(mn);
                TempMns.Add(mn);
                //if oldPreg <> nil then
//                begin
//                  mn.FPregled := oldPreg;
//                end
//                else
//                begin
//                  mn.FPregled := FmxProfForm.Pregled;
//                end;
              end;
            end;
            runAnal := runAnal.NextSibling;
          end;
        end;

      end;
      vvMedNapr:
      begin
        mn := Adb_dm.CollMedNapr.GetItemsFromDataPos(dataRun.DataPos);
        if mn = nil then
        begin
          mn := TRealBLANKA_MED_NAPRItem.Create(nil);
          mn.DataPos := dataRun.DataPos;
          //mmoTest.Lines.Add(format('Fill mdn.DataPos = %d', [mdn.DataPos]));
          mn.LinkNode := run;
        end;
        //FmxProfForm.Pregled.FMNs.Add(mn);
        TempMns.Add(mn);
        //if oldPreg <> nil then
//        begin
//          mn.FPregled := oldPreg;
//        end
//        else
//        begin
//          mn.FPregled := FmxProfForm.Pregled;
//        end;
      end;
      vvExamImun:
      begin
        immun := Adb_dm.CollExamImun.GetItemsFromDataPos(dataRun.DataPos);
        if immun = nil then
        begin
          immun := TRealExamImmunizationItem.Create(nil);
          immun.DataPos := dataRun.DataPos;
          //mmoTest.Lines.Add(format('Fill mdn.DataPos = %d', [mdn.DataPos]));
          immun.LinkNode := run;
        end;
        FmxProfForm.Pregled.FImmuns.Add(immun);
        immun.FPregled := FmxProfForm.Pregled;
      end;
      //vvPatientRevision:
//      begin
//        revis := TRevision.Create;
//        revis.CollType := ctPatientNew;
//        revis.node := run;
//        revis.propIndex := run.Dummy;
//        dataPatRevision := Pointer(PByte(run) + lenNode);
//        ofset := dataPatRevision.index;
//        case run.Dummy of
//          word(PatientNew_FNAME):
//          begin
//            FmxProfForm.patNameF := CollPatient.getAnsiStringMapOfset(ofset, word(PatientNew_FNAME));
//          end;
//        end;
//        //pat.Revisions.Add(revis);
//      end;
    end;

    run := run.NextSibling;
  end;
  fmxCntrDyn.ChangeActiveForm(FmxProfForm);

  FmxProfForm.AspAdbBuf := Adb_DM.AdbMain.Buf;
  FmxProfForm.AspAdbPosData := Adb_DM.AdbMain.FPosData;
  FmxProfForm.Patient.DataPos := dataPat.DataPos;
  if FmxProfForm.Pregled.FNode = nil then // не е избиран и редактиран до сега
  begin
    FmxProfForm.Pregled.DataPos := dataPreg.DataPos;
    FmxProfForm.Pregled.FNode := linkPreg;
    dataPreg.index := 0;
  end
  else
  begin
    if FmxProfForm.Pregled.PRecord <> nil then // Редактиран е и трябва да се добави нов във колекцията
    begin
      FmxProfForm.RemoveLastVacantindexPreg;
      if dataPreg.index < 0 then  // само че да не е ползван и незаписан преди
      begin
        lastVacantPreg := FmxProfForm.FindVacantIndexPreg();
        if lastVacantPreg = -1 then
        begin
          //oldPreg := FmxProfForm.Pregled;
          FmxProfForm.Pregled := TRealPregledNewItem(Adb_dm.CollPregled.Add);
          dataPreg.index := Adb_dm.CollPregled.Count - 1;
          ////  трябва да се вземат нещата от стария (попълненият) преглед
//          FmxProfForm.Pregled.FMNs.AddRange(oldPreg.FMNs);
//          FmxProfForm.Pregled.FDiagnosis.AddRange(oldPreg.FDiagnosis);
        end
        else
        begin
          FmxProfForm.Pregled := Adb_dm.CollPregled.Items[lastVacantPreg];

          dataPreg.index := lastVacantPreg;

        end;

        FmxProfForm.Pregled.FNode := linkPreg;
        FmxProfForm.Pregled.DataPos := dataPreg.DataPos;
      end
      else
      begin
       // oldPreg := FmxProfForm.Pregled;
        FmxProfForm.Pregled := Adb_dm.CollPregled.Items[dataPreg.index];
        FmxProfForm.Pregled.FNode := linkPreg;
        //dataPreg.index := dataPreg.index; // не трябва да се сменява
        FmxProfForm.Pregled.DataPos := dataPreg.DataPos;
        ////  трябва да се вземат нещата от стария (попълненият) преглед
//        FmxProfForm.Pregled.FMNs.AddRange(oldPreg.FMNs);
//        FmxProfForm.Pregled.FDiagnosis.AddRange(oldPreg.FDiagnosis);
      end;
    end
    else
    begin
      dataFMXPreg := pointer(PByte(FmxProfForm.Pregled.FNode) + lenNode); // който е за редактиране
      if dataPreg.index = - 1 then
      begin
        if FmxProfForm.FindVacantIndexPreg() = -1 then
        begin// тука трябва да се записват някъде минусираните
          FmxProfForm.AddVacantindexPreg(dataFMXPreg.index);
        end;
        dataPreg.index := dataFMXPreg.index;// заменям стария индекс със новия
        dataFMXPreg.index := -1;// стария го минусирам :) за да се знае, че не е ползван
        if dataPreg.index = -1 then
        begin
          Caption := 'errrr';
          Exit;
        end;
      end
      else
      begin
        //Caption := 'errrr'; // zzzz
//        Exit;
      end;


      FmxProfForm.Pregled := Adb_dm.CollPregled.Items[dataPreg.index]; //взимам  прегледа и му слагам новите неща
      FmxProfForm.Pregled.FNode := linkPreg;
      FmxProfForm.Pregled.DataPos := dataPreg.DataPos;

    end;
  end;

  FmxProfForm.ClearBlanka;
  FmxProfForm.Pregled.FDiagnosis.AddRange(TempDiags);
  FmxProfForm.Pregled.FMNs.AddRange(TempMns);
  for i := 0 to FmxProfForm.Pregled.FMNs.Count - 1 do
    FmxProfForm.Pregled.FMNs[i].FPregled := FmxProfForm.Pregled;
  TempDiags.Free;
  TempMns.Free;


  FmxProfForm.FillProfActivityPreg(linkPreg);
  FmxProfForm.FillRightLYT(dataPreg);
  FmxProfForm.rctNzisBTN.Repaint;
  FmxProfForm.InitSetings;

  Elapsed := Stopwatch.Elapsed;
  //FmxProfForm.scldlyt1.endupdate;
  mmoTest.Lines.Add( 'DYN ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.ShowTokensFMX;
begin  // FmxTokensForm: TfrmFmxTokens
  if FmxTokensForm = nil then
  begin
    FmxTokensForm := TfrmFmxTokens.Create(nil);
    FmxTokensForm.Option := Option;
    FmxTokensForm.thrCert := thrCert;
    FmxTokensForm.collDoctor := Adb_dm.CollDoctor;
    FmxTokensForm.FillTokens;
    //FmxTokensForm.OnShow := OnShowFindFprm;
  end
  else
  begin
    FmxTokensForm.FillTokens;
  end;

  InternalChangeWorkPage(tsFMXForm);


  fmxCntrDyn.ChangeActiveForm(FmxTokensForm);
  FmxTokensForm.WindowState := wsMaximized;
end;

procedure TfrmSuperHip.SignDocumentHipNzis(DokumentType: TDokumentSignType; posdata: cardinal);
var
  HashStr: string;
  i: Integer;

  DocInfo: string;
  PatFulName, CMName: string;
  PatFName, PatLName, CMFName, CMLName, PatPid: string;
  PatPidType, pat_ID: Integer;

  FromDateCert, ToDateCert: TDate;
  CertNom: string;
  NzisStatus: THipPregledStatus;
  NzisLabStatus: THipMdnLabStatus;
  WindowList: TTaskWindowList;
begin
  //FSignType := stMastSignSend;
  HashStr := '';
  //if du = nil then
//    InitDB(edit1.Text);
//  du.ibsqlCommand.Close;

  case DokumentType of

    dtAmbListNzis:
    begin
      //du.ibsqlCommand.Close;
//      du.ibsqlCommand.SQL.Text := format(
//          'select' + #13#10 +
//
//          'pr.start_date,' + #13#10 +
//          'pr.start_time,' + #13#10 +
//          'pr.main_diag_mkb,' + #13#10 +
//          'pa.egn,' + #13#10 +
//          'pr.nrn,' + #13#10 +
//          'pa.fname,' + #13#10 +   //5
//          'pa.Lname,' + #13#10 +
//          'pa.pid_type,' + #13#10 +
//          'cm.egn,' + #13#10 +
//          'cm.fname,' + #13#10 +
//          'cm.Lname,' + #13#10 +   //10
//          'cm.is_egn,' + #13#10 +
//          'pr.doctor_id ,' + #13#10 +
//          'c.cert_id,' + #13#10 +
//          'c.valid_from_date,' + #13#10 +
//          'c.valid_to_date,' + #13#10 +  //15
//          'pr.nzis_status,' + #13#10 +
//          'pa.BIRTH_DATE,' + #13#10 +
//          'pa.ID' + #13#10 +
//
//
//          'from pregled pr' + #13#10 +
//          'inner join pacient pa on pa.id = pr.pacient_id' + #13#10 +
//          'left join choice_maker cm on cm.pacient_id = pa.id' + #13#10 +
//          'left join certificates c on c.doctor_id = pr.doctor_id' + #13#10 +
//
//          'where pr.id = %d', [id]);
//      du.ibsqlCommand.ExecQuery;
      DocInfo := 'Амб. лист НРН: ' + 'testtttttt'; //zzzzzzzzzzzzzzzzzzzzzzz
      CMName := 'cmname'; //zzzzzzzzzzzzzzzzzzzzzzzzzzz
      //pat_ID := du.ibsqlCommand.Fields[18].AsInteger;

      //if frmChoiceSigner = nil then
//      begin
//        frmChoiceSigner := TfrmlSignerChoice.Create(Application);
//      end
//      else
//      begin
//        frmChoiceSigner.clear;
//      end;
//      frmChoiceSigner.PregledID := ID;
//      frmChoiceSigner.DoctorID := du.ibsqlCommand.Fields[12].AsInteger;
//      frmChoiceSigner.BringToFront;
//      FromDateCert := du.ibsqlCommand.Fields[14].AsDate;
//      ToDateCert := du.ibsqlCommand.Fields[15].AsDate;
//      if (Date <= ToDateCert) and (Date >= FromDateCert) then
//        CertNom :=  du.ibsqlCommand.Fields[13].AsString
//      else
//        CertNom := '';
//      NzisStatus := THipPregledStatus(du.ibsqlCommand.Fields[16].AsInteger);
//
//      if CalcAge(du.ibsqlCommand.Fields[0].AsDate, du.ibsqlCommand.Fields[17].AsDate) < 18 then
//      begin
//        frmChoiceSigner.PatientFname := du.ibsqlCommand.Fields[5].AsString;
//        frmChoiceSigner.PatientLName := du.ibsqlCommand.Fields[6].AsString;
//        frmChoiceSigner.PatientPid := du.ibsqlCommand.Fields[3].AsString;
//        frmChoiceSigner.PatientPidType := du.ibsqlCommand.Fields[7].AsString;
//        frmChoiceSigner.ChoiceMakerFName := du.ibsqlCommand.Fields[9].AsString;
//        frmChoiceSigner.ChoiceMakerLName := du.ibsqlCommand.Fields[10].AsString;
//        frmChoiceSigner.ChoiceMakerPid := du.ibsqlCommand.Fields[8].AsString;
//        frmChoiceSigner.ChoiceMakerPidType := du.ibsqlCommand.Fields[11].AsString;
//
//
//        if frmChoiceSigner.chkChoiceMaker.Visible then
//        begin
//          frmChoiceSigner.chkChoiceMaker.Checked := True;
//          frmChoiceSigner.chkChoiceMakerClick(nil);
//        end;
//        frmChoiceSigner.IsChoice := False;
//
//        FillPrevSigner(pat_id);
//
//        if frmChoiceSigner.ShowModal <> mrOk then
//        begin
//          SendMessage(AmbListHandle, WM_CANCEL_USER, 0, 0);
//          exit;
//        end;
//      end
//      else
//      begin
//        frmChoiceSigner.SignerFName := du.ibsqlCommand.Fields[5].AsString;
//        frmChoiceSigner.SignerLName := du.ibsqlCommand.Fields[6].AsString;
//        case du.ibsqlCommand.Fields[7].AsString[1] of
//          'E': frmChoiceSigner.SignerPidType := 1;
//          'L': frmChoiceSigner.SignerPidType := 2;
//          'S': frmChoiceSigner.SignerPidType := 3;
//          'F': frmChoiceSigner.SignerPidType := 4;
//        end;
//        frmChoiceSigner.SignerPid := du.ibsqlCommand.Fields[3].AsString;
//      end;



      //SignX000All(id, frmChoiceSigner.DoctorID, CertNom, NzisStatus);

    end;

    dtMDNNzis:
    begin
      //du.ibsqlCommand.Close;
//      du.ibsqlCommand.SQL.Text := format(
//          'select' + #13#10 +
//          'imdn.date_probovzemane,' + #13#10 + //0
//          'pa.egn,' + #13#10 +
//          'imdn.nrn,' + #13#10 +
//          'pa.fname,' + #13#10 +
//          'pa.Lname,' + #13#10 +
//          'pa.pid_type,' + #13#10 +
//          'cm.egn,' + #13#10 +
//          'cm.fname,' + #13#10 +
//          'cm.Lname,' + #13#10 +
//          'cm.is_egn,' + #13#10 +
//          'imdn.account_id ,' + #13#10 + //10
//          'c.cert_id,' + #13#10 +
//          'c.valid_from_date,' + #13#10 +
//          'c.valid_to_date,' + #13#10 +
//          'imdn.nzis_status,' + #13#10 +
//          'pa.BIRTH_DATE,' + #13#10 + //15
//          'pa.ID,' + #13#10 +
//          'acnt.doctor_ID' + #13#10 +
//
//          '' + #13#10 +
//          '' + #13#10 +
//          'from inc_mdn imdn' + #13#10 +
//          'inner join pacient pa on pa.id = imdn.pacient_id' + #13#10 +
//          'left join choice_maker cm on cm.pacient_id = pa.id' + #13#10 +
//          'left join account acnt on acnt.id = imdn.account_id' + #13#10 +
//          'left join certificates c on c.doctor_id = acnt.doctor_id' + #13#10 +
//          '' + #13#10 +
//          'where imdn.id = %d', [id]);
//      du.ibsqlCommand.ExecQuery;
//      DocInfo := 'МДН НРН: ' + du.ibsqlCommand.Fields[2].AsString;
//      CMName := du.ibsqlCommand.Fields[6].AsString;
//      pat_ID := du.ibsqlCommand.Fields[16].AsInteger;
//      if frmChoiceSigner = nil then
//      begin
//        frmChoiceSigner := TfrmlSignerChoice.Create(nil);
//      end
//      else
//      begin
//        frmChoiceSigner.clear;
//      end;
//      frmChoiceSigner.IncMdnID := ID;
//      frmChoiceSigner.DoctorID := du.ibsqlCommand.Fields[17].AsInteger;
//      frmChoiceSigner.BringToFront;
//      FromDateCert := du.ibsqlCommand.Fields[12].AsDate;
//      ToDateCert := du.ibsqlCommand.Fields[13].AsDate;
//      if (Date <= ToDateCert) and (Date >= FromDateCert) then
//        CertNom :=  du.ibsqlCommand.Fields[11].AsString
//      else
//        CertNom := '';
//      NzisLabStatus := THipMdnLabStatus(du.ibsqlCommand.Fields[14].AsInteger);
//      if CalcAge(du.ibsqlCommand.Fields[0].AsDate, du.ibsqlCommand.Fields[15].AsDate) < 18 then
//      begin
//        frmChoiceSigner.PatientFname := du.ibsqlCommand.Fields[3].AsString;
//        frmChoiceSigner.PatientLName := du.ibsqlCommand.Fields[4].AsString;
//        frmChoiceSigner.PatientPid := du.ibsqlCommand.Fields[1].AsString;
//        frmChoiceSigner.PatientPidType := du.ibsqlCommand.Fields[5].AsString;
//        frmChoiceSigner.ChoiceMakerFName := du.ibsqlCommand.Fields[7].AsString;
//        frmChoiceSigner.ChoiceMakerLName := du.ibsqlCommand.Fields[8].AsString;
//        frmChoiceSigner.ChoiceMakerPid := du.ibsqlCommand.Fields[6].AsString;
//        frmChoiceSigner.ChoiceMakerPidType := du.ibsqlCommand.Fields[9].AsString;
//
//
//        if frmChoiceSigner.chkChoiceMaker.Visible then
//        begin
//          frmChoiceSigner.chkChoiceMaker.Checked := True;
//          frmChoiceSigner.chkChoiceMakerClick(nil);
//        end;
//        frmChoiceSigner.IsChoice := False;
//        FillPrevSigner(pat_id);
//
//        if frmChoiceSigner.ShowModal <> mrOk then
//        begin
//          SendMessage(IncMdnHandle, WM_CANCEL_USER, 0, 0);
//          exit;
//        end;
//      end
//      else
//      begin
//        frmChoiceSigner.SignerFName := du.ibsqlCommand.Fields[3].AsString;
//        frmChoiceSigner.SignerLName := du.ibsqlCommand.Fields[4].AsString;
//        case du.ibsqlCommand.Fields[5].AsString[1] of
//          'E': frmChoiceSigner.SignerPidType := 1;
//          'L': frmChoiceSigner.SignerPidType := 2;
//          'S': frmChoiceSigner.SignerPidType := 3;
//          'F': frmChoiceSigner.SignerPidType := 4;
//        end;
//        frmChoiceSigner.SignerPid := du.ibsqlCommand.Fields[1].AsString;
//      end;
//
//
//      SignR000All(id, frmChoiceSigner.DoctorID, CertNom, NzisLabStatus);

    end;
  end;


end;

procedure TfrmSuperHip.SignX000All(pregledId, senderID: Integer; CertNom: string; NzisStatus: THipPregledStatus);
//var
//  thrdSender: TSenderThread;
begin
//  thrdSender := TSenderThread.Create(true);
//  thrdSender.FreeOnTerminate := true;
//  thrdSender.SenderHandle := self.Handle;
//  thrdSender.SenderID := senderID;
//  thrdSender.OnD6Terminate := TerminateNzisX000;
//  if not string(Edit1.Text).StartsWith('#') then
//  begin
//    thrdSender.DBName := Edit1.Text;
//    thrdSender.IsTest := true;// zzzzzzzzzzzz
//  end
//  else
//  begin
//    thrdSender.DBName := string(Edit1.Text).Remove(0, 1);
//    thrdSender.IsTest := true;
//  end;
//
//  thrdSender.CertNom := CertNom;
//  thrdSender.witMessage := False;
//  thrdSender.PregledID := pregledId;
//  case NzisStatus of
//    hpsOpen: thrdSender.ActionType := atSignX003;
//    hpsClosed: thrdSender.ActionType := atSignX009;
//    hpsNone, hpsCancel: thrdSender.ActionType := atSignX013;
//  end;
//
//  thrdSender.AmbListHandle := 0;//;//AmbListHandle;
//  thrdSender.Resume;
end;

procedure TfrmSuperHip.sizeMove(var msg: TWMSize);
begin
  inherited;
  //if (msg.SizeType = SIZE_MAXIMIZED)then
//  begin
//    Self.Height := Screen.WorkAreaHeight;
//  end;
end;

procedure TfrmSuperHip.SortListCollType(list: TList<word>);
procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : word;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while list[I] < list[P] do Inc(I);
        while list[J] > list[P] do Dec(J);
        if I <= J then begin
          Save := list[I];
          list[I] := list[J];
          list[J] := Save;
          if P = I then
            P := J
          else if P = J then
            P := I;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then QuickSort(L, J);
      L := I;
    until I >= R;
  end;
begin
  if (list.count >1 ) then
  begin
    QuickSort(0,list.count-1);
  end;
end;

procedure TfrmSuperHip.SortListString(list: TList<TString>);

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TString;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while list[I].str < list[P].str do Inc(I);
        while list[J].str > list[P].str do Dec(J);
        //while AnsiCompareStr(list[I].str ,list[P].str) > 0 do Inc(I);
//        while AnsiCompareStr(list[J].str , list[P].str) < 0 do Dec(J);
        if I <= J then begin
          Save := list[I];
          list[I] := list[J];
          list[J] := Save;
          if P = I then
            P := J
          else if P = J then
            P := I;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then QuickSort(L, J);
      L := I;
    until I >= R;
  end;
begin
  if (list.count >1 ) then
  begin
    QuickSort(0,list.count-1);
  end;
end;

procedure TfrmSuperHip.spl1Moved(Sender: TObject);
begin
  vtrTemp.UpdateVerticalScrollBar(true);
end;

procedure TfrmSuperHip.splSearchGridMoved(Sender: TObject);
begin
   if pnlGridSearch.Visible then
   begin
     btnPull.Top := pnlGridSearch.Top - 7 - btnPull.Height;
     if pnlGridSearch.height > 1 then
       btnPull.ImageIndex := 80
     else
       btnPull.ImageIndex := 79
   end
   else if pnlNzisMessages.Visible then
   begin
     btnPull.Top := pnlNzisMessages.Top - 7 - btnPull.Height;
     if pnlNzisMessages.height > 1 then
       btnPull.ImageIndex := 80
     else
       btnPull.ImageIndex := 79
   end;
   tlb1.Realign;

end;

procedure TfrmSuperHip.pgcTreeChange(Sender: TObject);
var
  histNav: THistoryNav;
begin
  if ListHistoryNav.Count = 0 then
  begin
    histNav := THistoryNav.Create;
    histNav.Vtr := histNav.FindVTR(pgcTree.ActivePage);
    ListHistoryNav.Add(histNav);
  end
  else
  begin
    if True then //    ListHistoryNav.Last.WorkSheet <> nil then
    begin
      histNav := THistoryNav.Create;
      histNav.Vtr := histNav.FindVTR(pgcTree.ActivePage);
      ListHistoryNav.Add(histNav);
    end
    else
    begin
      ListHistoryNav.Last.Vtr := ListHistoryNav.Last.FindVTR(pgcTree.ActivePage);
    end;
  end;
end;

procedure TfrmSuperHip.pgcWorkChange(Sender: TObject);
begin
  if pgcWork.ActivePage = tsFMXForm then
  begin
    pnlGridSearch.Visible := True;
    pnlNzisMessages.Visible := False;
    splSearchGrid.Visible := True;
    splSearchGrid.Top := 10;
    btnPull.Visible := True;
    btnPull.Top := pnlGridSearch.Top - 7 - btnPull.Height;
    Exit;
  end;
  if pgcWork.ActivePage = tsMinaliPregledi then
  begin
    pnlGridSearch.Visible := True;
    pnlNzisMessages.Visible := False;
    splSearchGrid.Visible := True;
    splSearchGrid.Top := 10;
    btnPull.Visible := True;
    btnPull.Top := pnlGridSearch.Top - 7 - btnPull.Height;
    Exit;
  end;
  if pgcWork.ActivePage = tsNZIS then
  begin
    pnlGridSearch.Visible := false;
    pnlNzisMessages.Visible := true;
    splSearchGrid.Visible := true;
    splSearchGrid.Top := 10;
    btnPull.Visible := True;
    btnPull.Top := pnlNzisMessages.Top - 7 - btnPull.Height;
    Exit;
  end;
  pnlGridSearch.Visible := false;
  pnlNzisMessages.Visible := false;
  splSearchGrid.Visible := false;
  btnPull.Visible := False;
  //splSearchGrid.Top := 10;

end;

procedure TfrmSuperHip.pgcWorkResize(Sender: TObject);
begin
  //
end;

procedure TfrmSuperHip.pnlGraphClick(Sender: TObject);
begin
  vtrGraph.UpdateVerticalScrollBar(true);
  vtrGraph.Clear;
end;

procedure TfrmSuperHip.pnlGridSearchMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  //
end;

procedure TfrmSuperHip.pnlRoleBarResize(Sender: TObject);
begin
  fmxCntrRoleBar.Top := pnlRoleBar.Top;
  fmxCntrRoleBar.Height := pnlRoleBar.Height;
end;

procedure TfrmSuperHip.pnlRoleViewClick(Sender: TObject);
begin
  vtrPregledPat.BeginUpdate;
  vtrPregledPat.EndUpdate;
  vtrPregledPat.ValidateNode(vtrPregledPat.RootNode.FirstChild.FirstChild,True);
end;

procedure TfrmSuperHip.pnlRoleViewMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  //Caption := IntToStr(x);
end;

procedure TfrmSuperHip.pnlRoleViewRoleButtonClick(Sender: TObject);
begin
  pgcTree.ActivePage := tsTreeRole;
  pgcRole.ActivePage := tsRoleSelect;
  InternalChangeWorkPage(nil);
  //pgcWork.ActivePage := nil;
  if ActiveMainButton <> nil then
    ActiveMainButton.Down := False;
  if ActiveSubButton <> nil then
    ActiveSubButton := nil;
  pnlRoleView.Clear(true);
end;


procedure TfrmSuperHip.OptionsClick(Sender: TObject);
begin
  //
end;

procedure TfrmSuperHip.HipNomenAnalsClick(Sender: TObject);
begin
  pnlRoleView.ForceClose;
  OpenBufNomenNzis(paramstr(2) + 'NzisNomen.adb');
  OpenBufNomenHip(paramstr(2) + 'HipNomen.adb');
  OpenLinkNomenHipAnals;
  pnlTree.Width := 580;
  pgcTree.ActivePage := tsNomenAnal;
end;

procedure TfrmSuperHip.HoverChange(Sender: TObject);
begin
  //
end;

procedure TfrmSuperHip.httpNZISCertificateNeededEx(Sender: TObject;
  var Certificate: TElX509Certificate);
begin
  if Certificate <> CurrentCert then
  begin
    Certificate := CurrentCert;
    CurrentCert := nil;
  end ;

end;

procedure TfrmSuperHip.httpNZISCertificateValidate(Sender: TObject;
  X509Certificate: TElX509Certificate; var Validity: TSBCertificateValidity;
  var Reason: TSBCertificateValidityReason);
begin
   Validity := TSBCertificateValidity.cvOk;
end;

procedure TfrmSuperHip.httpNZISDataSender(Sender: TObject; Buffer: Pointer; Size: Integer);
begin
  streamRes.Write(Buffer, Size);
end;

procedure TfrmSuperHip.httpNZISDataToken(Sender: TObject; Buffer: Pointer; Size: Integer);
var
  stream: TMemoryStream;
begin
  stream := TMemoryStream.Create;
  stream.Write(Buffer, Size);
  stream.Position := 0;
  if ResultNzisToken = nil then
    ResultNzisToken := TStringList.Create;
  ResultNzisToken.LoadFromStream(stream,TEncoding.UTF8);
  stream.Free;
end;

procedure TfrmSuperHip.httpNZISPreparedHeaders(Sender: TObject;
  Headers: TElStringList);
begin
  if Token <> '' then
  begin
    Headers.Add('Authorization: Bearer ' +  Token);
  end;
  Headers.Add('Content-Type: application/xml');
end;



procedure TfrmSuperHip.imgOptionNoteClick(Sender: TObject);
begin
  TGIFImage(imgOptionNote.Picture.Graphic).Animate  := True;
end;

procedure TfrmSuperHip.ProfGraphClick(Sender: TObject);
var
  runPat, runPreg, runDiag: PVirtualNode;
  runDataPat, runDataPreg, runDataDiag, dataGraph: PAspRec;
  i: Integer;
  pat: TRealPatientNewItem;
  preg: TRealPregledNewItem;
  diag: TRealDiagnosisItem;
  dat: TDate;
  egn: string;
  log: TlogicalPatientNewSet;
  btnProf: TRoleButton;
  mkb: string;
  PregIsProf: Boolean;
begin
  pnlRoleView.ForceClose;
  vtrGraph.UpdateVerticalScrollBar(true);
  vtrGraph.Clear;
  vRootGraph := vtrGraph.AddChild(nil, nil);
  dataGraph := vtrGraph.GetNodeData(vRootGraph);
  dataGraph.vid := vvNone;
  dataGraph.index := 0;
  profGR.LoadVtrGraph(FmxProfForm.Patient, 0);
  vtrGraph.Expanded[vRootGraph] := True;
  pgcTree.ActivePage := tsGraph;
  Exit;
  //if profGR = nil then
//  begin
//
//    OpenBufNomenNzis('NzisNomen.adb');
//    LoadVtrNomenNzis1();
//    profGR := TProfGraph.create;
//
//    profGR.CL022Coll := CL022Coll;
//    profGR.CL038Coll := CL038Coll;
//    profGR.CL050Coll := CL050Coll;
//    profGR.CL132Coll := CL132Coll;
//    profGR.CL134Coll := CL134Coll;
//    profGR.CL139Coll := CL139Coll;
//    profGR.CL142Coll := CL142Coll;
//    profGR.CL088Coll := CL088Coll;
//    profGR.PR001Coll := PR001Coll;
//    profGR.BufNomen := AspectsNomFile.Buf;
//    profGR.BufADB := AspectsHipFile.Buf;
//    profGR.posDataADB := AspectsHipFile.FPosData;
//    profGR.vtrGraph := vtrGraph;
//  end
//  else
//  begin
//    pnlTree.Width := 580;
//    pgcTree.ActivePage := tsGraph;
//    //edtGraphDayChange(nil);
//   // Exit;
//
//
//  end;
//  Stopwatch := TStopwatch.StartNew;
//
//  //runPat := vtrPregledPat.RootNode.FirstChild.FirstChild;
//  btnProf := pnlRoleView.BtnFromName('Профилактика');
//  if btnProf <> nil then
//  begin
//    btnProf.MaxValue := vtrPregledPat.RootNode.FirstChild.ChildCount;
//  end;
//  GetPatProf(pat);
//  profGR.LoadVtrGraph(CurrentPatient, i);
//  Elapsed := Stopwatch.Elapsed;
//  mmoTest.lines.add(Format('проф: %f', [Elapsed.TotalMilliseconds]));
//  vtrGraph.Expanded[vRootGraph] := True;
//  vtrGraph.EndUpdate;
//  pnlTree.Width := 580;
//  pgcTree.ActivePage := tsGraph;
  //edtGraphDayChange(nil);
end;


procedure TfrmSuperHip.ReadToken(str: string);
var
  Pos1, pos2, len: Integer;
  NzisToken: TNzisTokenItem;
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  Bearer: string;

begin

  
  if Str <> '' then
  begin
    len := Length('<nhis:accessToken value="');
    Pos1 := Pos('<nhis:accessToken value="', Str) + len;
    if Pos1 > len then
    begin
      pos2 := Pos('"', Str, Pos1);
      token := Copy(Str, Pos1, pos2 - pos1);
      edtToken.Text := token;
    end
    else
    begin
      ShowMessage(str);
      Exit;
    end;
    len := Length('<nhis:expiresOn value="');
    Pos1 := Pos('<nhis:expiresOn value="', Str) + len;
    if Pos1 > len then
    begin
      pos2 := Pos('"', Str, Pos1);
      TokenToTime := ISO8601ToDate(Copy(Str, Pos1, pos2 - pos1), False);
      edtTokenTo.Text := DateTimeToString(TokenToTime);
    end;
  end;
  //NzisToken.PRecord.CertID := BuildHexString(CertStorage.Certificates[0].SerialNumber);
  NzisToken := TNzisTokenItem(Adb_dm.CollNzisToken.Add);
  New(NzisToken.PRecord);
  NzisToken.PRecord.Bearer := Bearer.PadRight(100, ' ');
  NzisToken.PRecord.ToDatTime := TokenToTime;
      NzisToken.PRecord.fromDatTime := now;
  NzisToken.PRecord.setProp := [NzisToken_Bearer, NzisToken_fromDatTime, NzisToken_ToDatTime, NzisToken_CertID];
  NzisToken.InsertNzisToken;
  Dispose(NzisToken.PRecord);
  NzisToken.PRecord := nil;
end;

procedure TfrmSuperHip.RefreshEvent(sender: TObject);
begin
  vtrPregledPat.Repaint;
  if FmxProfForm = nil then
    Exit;   // zzzzzzzzzzzzzzzzzzzz samo ako e toq pregled
  //FmxProfForm.scrlbx1.Repaint;
  //FmxFormDyn.edtAmbNumber.InternalGet;
//  FmxFormDyn.edtNRN.InternalGet;
end;

procedure TfrmSuperHip.RemontCl142;
var
  i, j: Integer;
  cl142, TempItem: TCL142Item;
  nhifCode: string;
  ArrNhifCode: TArray<string>;
  datPos: Cardinal;
  pCardinalData: ^Cardinal;
  len: Word;
begin
  for i := 0 to Adb_dm.Cl142Coll.Count - 1 do
  begin
    cl142 := Adb_dm.Cl142Coll.Items[i];
    nhifCode := cl142.getAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_nhif_code));
    if (nhifCode.Contains(';')) or (nhifCode.Contains(',')) then
    begin
      ArrNhifCode := nhifCode.Split([';', ',']);
      for j := 0 to Length(ArrNhifCode) - 1 do
      begin
        if j = 0 then
        begin
          New(cl142.PRecord);
          cl142.PRecord.setProp := [CL142_nhif_code];
          cl142.PRecord.nhif_code := ArrNhifCode[j];
          datPos := AspectsNomFile.FPosData + AspectsNomFile.FLenData;
          cl142.SaveCL142(datPos);
          pCardinalData := pointer(PByte(AspectsNomFile.Buf) + 12);
          pCardinalData^  := datPos - self.AspectsNomFile.FPosData;
        end
        else
        begin
          TempItem := TCL142Item(Adb_dm.Cl142Coll.Add);
          New(TempItem.PRecord);
          datPos := Adb_dm.Cl142Coll.posData;
          TempItem.PRecord.setProp := [CL142_Key, CL142_Description];
          TempItem.PRecord.Key := cl142.getAnsiStringMap(Adb_dm.Cl142Coll.Buf, datPos, word(CL142_Key));
          TempItem.PRecord.Description := cl142.getAnsiStringMap(Adb_dm.Cl142Coll.Buf, datPos, word(CL142_Description));

          if cl142.getPAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_DescriptionEn), len) <> nil then
          begin
            TempItem.PRecord.DescriptionEn := cl142.getAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_DescriptionEn));
            include(TempItem.PRecord.setProp, CL142_DescriptionEn);
          end;
          if cl142.getPAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_achi_block), len) <> nil then
          begin
            TempItem.PRecord.achi_block := cl142.getAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_achi_block));
            include(TempItem.PRecord.setProp, CL142_achi_block);
          end;
          if cl142.getPAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_achi_chapter), len) <> nil then
          begin
            TempItem.PRecord.achi_chapter := cl142.getAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_achi_chapter));
            include(TempItem.PRecord.setProp, CL142_achi_chapter);
          end;
          if cl142.getPAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_achi_code), len) <> nil then
          begin
            TempItem.PRecord.achi_code := cl142.getAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_achi_code));
            include(TempItem.PRecord.setProp, CL142_achi_code);
          end;
          if cl142.getPAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_nhif_code), len) <> nil then
          begin
            TempItem.PRecord.nhif_code := ArrNhifCode[j];
            include(TempItem.PRecord.setProp, CL142_nhif_code);
          end;
          if cl142.getPAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_cl048), len) <> nil then
          begin
            TempItem.PRecord.cl048 := cl142.getAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_cl048));
            include(TempItem.PRecord.setProp, CL142_cl048);
          end;
          if cl142.getPAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_cl006), len) <> nil then
          begin
            TempItem.PRecord.cl006 := cl142.getAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_cl006));
            include(TempItem.PRecord.setProp, CL142_cl006);
          end;
          if cl142.getPAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_highly), len) <> nil then
          begin
            TempItem.PRecord.highly := cl142.getAnsiStringMap(Adb_dm.Cl142Coll.Buf, Adb_dm.Cl142Coll.posData, word(CL142_highly));
            include(TempItem.PRecord.setProp, CL142_highly);
          end;


          TempItem.InsertCL142;
          Dispose(TempItem.PRecord);
          TempItem.PRecord := nil;
        end;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.RemontCloning;
var
  i, j, k: Integer;
  pat, clon: TRealPatientNewItem;
  patId, clonId: Integer;
  ibsql: TIBSQL;
  cnt: Integer;
begin
  cnt := 0;
  ibsql := Fdm.ibsqlCommand;
  for i := 0 to Adb_dm.ACollPatFDB.Count - 1 do
  begin
    pat := Adb_dm.ACollPatFDB.Items[i];

    if pat.FClonings.Count = 0 then Continue;
    for j := 0 to pat.FClonings.Count - 1 do
    begin
      inc(cnt);
      clon := pat.FClonings[j];
      clonId := clon.getIntMap(Adb_DM.AdbMain.buf, Adb_dm.CollPatient.posData, word(PatientNew_ID));
      //for k := 0 to clon.FPregledi.Count - 1 do
      begin
        patId := pat.getIntMap(Adb_DM.AdbMain.buf, Adb_dm.CollPatient.posData, word(PatientNew_ID));

        ibsql.Close;
        ibsql.SQL.Text :=
           'update pregled pr' + #13#10 +
           'set pr.pacient_id = :patID' + #13#10 +
           'where pr.pacient_id = :clonID';
        ibsql.ParamByName('patID').AsInteger := patId;
        ibsql.ParamByName('clonId').AsInteger := clonId;
        ibsql.ExecQuery;
      end;

        ibsql.Close;
        ibsql.SQL.Text :=
          'update IMUN_CALENDAR ic' + #13#10 +
          'set ic.pacient_id = :patId' + #13#10 +
          'where ic.pacient_id = :clonID';
        ibsql.ParamByName('patID').AsInteger := patId;
        ibsql.ParamByName('clonId').AsInteger := clonId;
        ibsql.ExecQuery;

      ibsql.Close;
      ibsql.SQL.Text :=
      'delete from pacient where pacient.id = :clonId';
      ibsql.ParamByName('clonId').AsInteger := clonId;
      ibsql.ExecQuery;

      ibsql.Close;
      ibsql.SQL.Text :=
      'delete from IMUN_CALENDAR where pacient_id = :clonId';
      ibsql.ParamByName('clonId').AsInteger := clonId;
      ibsql.ExecQuery;
    end;
  end;
  ibsql.Transaction.CommitRetaining;
  ShowMessage(IntToStr(cnt));
end;

procedure TfrmSuperHip.RemontPat;
var
  vPat: PVirtualNode;
  data: PAspRec;
begin
  vtrTemp.IterateSubtree(vHipZapisani, IterateRemontPat, nil);
  Fdm.ibsqlCommand.Transaction.CommitRetaining;
 // vPat := vHipZapisani.FirstChild
end;

procedure TfrmSuperHip.RemoveDiag(vPreg: PVirtualNode; diagDataPos: cardinal);
var
  RunNode: PVirtualNode;
  data, dataPat, dataPreg: PAspRec;
  tempViewportPosition: TPointF;
  i: integer;
begin
  RunNode := vPreg.FirstChild;
  while RunNode <> nil do
  begin
    data := Pointer(PByte(RunNode) + lenNode);
    if data.vid = vvDiag then
    begin
      if diagDataPos = Data.DataPos then
      begin
        AspectsLinkPatPregFile.MarkDeletedNode(RunNode);
        dataPreg := Pointer(PByte(vPreg) + lenNode);
        dataPat :=  Pointer(PByte(vPreg.Parent) + lenNode);
        tempViewportPosition := FmxProfForm.scrlbx1.ViewportPosition;
        ShowPregledFMX(dataPat, dataPreg, vPreg);
        FmxProfForm.scrlbx1.ViewportPosition := tempViewportPosition;
        Break;
      end;
    end;
    RunNode := RunNode.NextSibling;
  end;
end;



procedure TfrmSuperHip.RemoveDublPat;
var
  i, j: Integer;
  pat1, pat2: TRealPatientNewItem;
  msg: TNzisReqRespItem;
begin
  Adb_dm.AmsgColl.CollPat.SortByPatEGN;
  for i := Adb_dm.AmsgColl.CollPat.Count - 1 downto 1 do
  begin
    pat1 := Adb_dm.AmsgColl.CollPat.Items[i];
    pat2 := Adb_dm.AmsgColl.CollPat.Items[i-1];
    if pat1.PatEGN = pat2.PatEGN then
    begin
      for j := 0 to pat1.FLstMsgImportNzis.Count - 1 do
      begin
        msg := TNzisReqRespItem(pat1.FLstMsgImportNzis[j]);
        pat2.FLstMsgImportNzis.Add(msg);
      end;
      Adb_dm.AmsgColl.CollPat.Delete(i);
    end;
  end;
end;

procedure TfrmSuperHip.RemoveFreePatient;
var
  i: Integer;
begin
  for i := Adb_dm.AmsgColl.CollPat.Count - 1 downto 0 do
  begin
    if Adb_dm.AmsgColl.CollPat.Items[i].FLstMsgImportNzis.Count = 0 then
      Adb_dm.AmsgColl.CollPat.Delete(i);
  end;

end;

procedure TfrmSuperHip.RemoveDiag(vPreg: PVirtualNode;
  diag: TRealDiagnosisItem);
var
  RunNode: PVirtualNode;
  data, dataPat, dataPreg: PAspRec;
  tempViewportPosition: TPointF;
begin
  RunNode := vPreg.FirstChild;
  while RunNode <> nil do
  begin
    data := Pointer(PByte(RunNode) + lenNode);
    if data.vid = vvDiag then
    begin
      if diag.DataPos = Data.DataPos then
      begin
        AspectsLinkPatPregFile.MarkDeletedNode(RunNode);
        dataPreg := Pointer(PByte(vPreg) + lenNode);
        dataPat :=  Pointer(PByte(vPreg.Parent) + lenNode);
        tempViewportPosition := FmxProfForm.scrlbx1.ViewportPosition;
        ShowPregledFMX(dataPat, dataPreg, vPreg);
        FmxProfForm.scrlbx1.ViewportPosition := tempViewportPosition;
        Break;
      end;
    end;
    RunNode := RunNode.NextSibling;
  end;
end;

procedure TfrmSuperHip.ReShowProfForm(dataPat, dataPreg: PAspRec;
  linkPreg: PVirtualNode);
begin
  ShowPregledFMX(dataPat, dataPreg, linkPreg);
end;

procedure TfrmSuperHip.RestoreApp(Sender: TObject; var txt: string);
begin
 // Exit;
  if Self.WindowState = wsMaximized then
  begin
    postmessage(handle,WM_SYSCOMMAND,SC_RESTORE,0);
    txt := '1';
  end
  else
  begin
    //postmessage(handle,WM_SYSCOMMAND,SC_MAXIMIZE,0);
    Self.WindowState := wsMaximized;
    //Self.BorderStyle := bsSizeable;
    txt := '2';
    //Self.BorderStyle := bsNone;
    //SetStyle;
  end;
end;

procedure TfrmSuperHip.PreglediClick(Sender: TObject);
begin
  pgcTree.ActivePage := tsTreePat;
  ActiveMainButton := TRoleButton(Sender);
  ActiveSubButton := nil;
end;

procedure TfrmSuperHip.ImportPL_NZOK(Sender: TObject);
var
  PLFile: TStringList;
  i, j: Integer;
  str: string;
  arrStr: TArray<string>;

  p: PInt;
  TempItem: TRealPatientNZOKItem;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  uin: string;

  pat: TRealPatientNewItem;
  egn: string;
begin
  Adb_dm.CollPatPis.Buf := nil;
  Adb_dm.CollPatPis.posData := 0;
  pnlRoleView.ForceClose;

  Stopwatch := TStopwatch.StartNew;
  if not dlgOpenPL.Execute then Exit;
  Adb_dm.CollPatPis.Clear;
  Adb_dm.CollPatPis.Uin := '';

  PLFile := TStringList.Create;
  //PLFile.LoadFromFile('D:\down3108\Downloads\PL_Jord\pl.csv');
  //PLFile.LoadFromFile('D:\JordankaPL\pl.csv');
  //PLFile.LoadFromFile('D:\down3108\Downloads\PL_Todorka\pl.csv');
  PLFile.LoadFromFile(dlgOpenPL.FileName);
  for i := 1 to PLFile.Count - 1 do
  begin
    str := PLFile[i];
    arrStr := str.Split([',']);
    if arrStr[6] = '1100000095' then Continue;
    TempItem := TRealPatientNZOKItem(Adb_dm.CollPatPis.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    if arrStr[0] <> '' then
    begin
       TempItem.PRecord.RZOK := arrStr[0];
       Include(TempItem.PRecord.setProp, PatientNZOK_RZOK);
    end;
    if arrStr[1] <> '' then
    begin
       TempItem.PRecord.EGN := arrStr[1];
       Include(TempItem.PRecord.setProp, PatientNZOK_EGN);
    end;
    if arrStr[2] <> '' then
    begin
       TempItem.PRecord.LNC := arrStr[2];
       Include(TempItem.PRecord.setProp, PatientNZOK_LNC);
       if arrStr[1] = '' then
       begin
         TempItem.PRecord.EGN := arrStr[1];
         Include(TempItem.PRecord.setProp, PatientNZOK_EGN);
       end;
    end;
    if arrStr[3] <> '' then
    begin
       TempItem.PRecord.SNN := arrStr[3];
       Include(TempItem.PRecord.setProp, PatientNZOK_SNN);
       if arrStr[1] = '' then
       begin
         TempItem.PRecord.EGN := arrStr[1];
         Include(TempItem.PRecord.setProp, PatientNZOK_EGN);
       end;
    end;
    if arrStr[4] <> '' then
    begin
       TempItem.PRecord.EZOK := arrStr[4];
       Include(TempItem.PRecord.setProp, PatientNZOK_EZOK);
    end;
    if arrStr[5] <> '' then
    begin
       TempItem.PRecord.SPOGODBA := arrStr[5];
       Include(TempItem.PRecord.setProp, PatientNZOK_SPOGODBA);
    end;
    if arrStr[6] <> '' then
    begin
       TempItem.PRecord.UIN := arrStr[6];
       Include(TempItem.PRecord.setProp, PatientNZOK_UIN);
    end;
    if arrStr[7] <> '' then
    begin
       TempItem.PRecord.RCZ_NUMBER := arrStr[7];
       Include(TempItem.PRecord.setProp, PatientNZOK_RCZ_NUMBER);
    end;
    if arrStr[8] <> '' then
    begin
       TempItem.PRecord.FROM_DATE := arrStr[8];
       Include(TempItem.PRecord.setProp, PatientNZOK_FROM_DATE);
    end;
    if arrStr[9] <> '' then
    begin
       TempItem.PRecord.TO_DATE := arrStr[9];
       Include(TempItem.PRecord.setProp, PatientNZOK_TO_DATE);
    end;
    if arrStr[10] <> '' then
    begin
       TempItem.PRecord.REG_TYPE := arrStr[10];
       Include(TempItem.PRecord.setProp, PatientNZOK_REG_TYPE);
    end;
    if arrStr[11] <> '' then
    begin
       TempItem.PRecord.REASON_OTP := arrStr[11];
       Include(TempItem.PRecord.setProp, PatientNZOK_REASON_OTP);
    end;
    if arrStr[12] <> '' then
    begin
       TempItem.PRecord.CHOICE_TYPE := arrStr[12];
       Include(TempItem.PRecord.setProp, PatientNZOK_CHOICE_TYPE);
    end;
    if arrStr[12] <> '' then
    begin
       TempItem.PRecord.NAME_ZOL := arrStr[12];
       Include(TempItem.PRecord.setProp, PatientNZOK_NAME_ZOL);
    end;
    if arrStr[13] <> '' then
    begin
       TempItem.PRecord.NAME_OPL := arrStr[13];
       Include(TempItem.PRecord.setProp, PatientNZOK_NAME_OPL);
    end;

    TempItem.PatEGN := arrStr[1];

  end;
  if TempItem <> nil then
  begin
    uin := arrStr[6];
    Adb_dm.CollPatPis.Uin := uin;
  end;
  //pgcWork.ActivePage := tsGrid;
  InternalChangeWorkPage(tsGrid);
  Adb_dm.CollPatPis.ShowGrid(grdNom);

  Adb_dm.AcollpatFromDoctor.Buf := Adb_DM.AdbMain.Buf;
  ADB_DM.ACollPatFDB.Buf := Adb_DM.AdbMain.Buf;
  Adb_dm.AcollpatFromDoctor.posData := Adb_DM.AdbMain.FPosData;
  ADB_DM.ACollPatFDB.posData := Adb_DM.AdbMain.FPosData;
  Adb_dm.AcollpatFromDoctor.Clear;
  ADB_DM.ACollPatFDB.Clear;
  FillListPL_NZOKFromDB('0500000430', Adb_dm.AcollpatFromDoctor); // попълва се за  определен УИН
  FillListPL_ADB(ADB_DM.ACollPatFDB);

  vtrFDB.Repaint;
  ADB_DM.ACollPatFDB.IndexValue(PatientNew_EGN);
  ADB_DM.ACollPatFDB.SortByIndexAnsiString;
  pat := ADB_DM.ACollPatFDB.Items[0];
  egn := pat.IndexAnsiStr1;
  i := 1;
  while i < ADB_DM.ACollPatFDB.Count do
  begin
    if egn = ADB_DM.ACollPatFDB.Items[i].IndexAnsiStr1 then
    begin
      pat.FClonings.Add(ADB_DM.ACollPatFDB.Items[i]);
      mmoTest.Lines.Add(egn);
      inc(i);
    end
    else
    begin
      pat := ADB_DM.ACollPatFDB.Items[i];
      egn := pat.IndexAnsiStr1;
      inc(i);
    end;
  end;


  FillPatListPisInPatDB(uin, ADB_DM.ACollPatFDB);


//  pgcWork.ActivePage := tsGrid;
//  CollPatPis.ShowGrid(grdNom);
//  grdNom.Repaint;

end;

procedure TfrmSuperHip.ImportPR001(TempColl: TPR001Coll);
var
  p: PInt;
  TempItem: TPR001Item;
  i, j, k, m: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  isKeyFind: Boolean;
begin
  TempItem := TPR001Item(TempColl.Add);

  Stopwatch := TStopwatch.StartNew;
  isKeyFind := False;

  for j := 1 to xlsHipp.xls[1].LastRow do
  begin
    if (xlsHipp.xls[1].AsString[0, j - 1] = 'CL132') or isKeyFind then
    begin
      isKeyFind := True;
      begin
        New(TempItem.PRecord);
        TempItem.PRecord.CL132 := xlsHipp.xls[1].AsString[0, j].Replace('М', 'M');
        TempItem.PRecord.Nomenclature := xlsHipp.xls[1].AsString[1, j] ;
        TempItem.PRecord.Activity_ID := xlsHipp.xls[1].AsString[2, j] ;
        TempItem.PRecord.Description := xlsHipp.xls[1].AsString[3, j]  ;
        TempItem.PRecord.Notes := xlsHipp.xls[1].AsString[5, j] ;
        TempItem.PRecord.Rules := xlsHipp.xls[1].AsString[6, j] ;
        TempItem.PRecord.Specialty_CL006 := xlsHipp.xls[1].AsString[7, j] ;
        TempItem.PRecord.Valid_Until := xlsHipp.xls[1].AsString[8, j] ;
        TempItem.PRecord.setProp :=
            [ PR001_CL132
            , PR001_Nomenclature
            , PR001_Activity_ID
            , PR001_Description
            , PR001_Notes
            , PR001_Rules
            , PR001_Specialty_CL006
            , PR001_Valid_Until
            ];
        TempItem.InsertPR001;
        TempColl.streamComm.Len := TempColl.streamComm.Size;
        TempColl.cmdFile.CopyFrom(TempColl.streamComm, 0);
        Dispose(TempItem.PRecord);
        TempItem.PRecord := nil;
      end;
    end
    else
      Continue
  end;


  pCardinalData := pointer(PByte(AspectsNomFile));
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add('insert PR001 ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.SubButonImportFDBClick(Sender: TObject);
var
  fileStr: TFileStream;
  fileNameNew, LnkFilename: string;
  AGuid: TGUID;
  AdbDir: string;
begin
  //pnlRoleView.Width := pnlRoleView.CompactWidth;
//
//  while pnlRoleView.Opened do
//  begin
//    pnlRoleView.Refresh;
//    Application.ProcessMessages;
//  end;

  pnlRoleView.ForceClose;
  if FDbName = '' then exit;

  if Adb_DM.AdbMain <> nil then
  begin
    UnmapViewOfFile(Adb_DM.AdbMain.Buf);
  end;


  AGuid := TGuid.NewGuid;
  AdbDir := ParamStr(2);
  fileNameNew := AdbDir + 'AspHip' + AGuid.ToString + '.adb';
  fileStr := TFileStream.Create(fileNameNew, fmCreate);
  fileStr.Size := 1000000000;//00;
  fileStr.Free;

  Adb_DM.AdbMain := TMappedFile.Create(fileNameNew, true, AGuid);
  Adb_DM.AdbMain := Adb_DM.AdbMain;
  streamCmdFile := TFileCmdStream.Create(fileNameNew.Replace('.adb', '.cmd'), fmCreate);
  streamCmdFile.Size := 100;
  streamCmdFile.Guid := AGuid;
  streamCmdFile.Position := streamCmdFile.Size;

  //LnkFilename := AspectsHipFile.FileName.Replace('.adb', '.lnk');
//  DeleteFile(LnkFilename);
//  fileStr := TFileStream.Create(LnkFilename, fmCreate);
//  fileStr.Size := 600000000;
//  fileStr.Free;
//
//  AspectsLinkPatPregFile := TMappedLinkFile.Create(LnkFilename, true, AspectsHipFile.GUID);
  if AspectsNomFile = nil then
    OpenBufNomenNzis(paramstr(2) + 'NzisNomen.adb');
  OpenLinkNomenHipAnals;

  //CollPractica.Clear;
//  CollPatient.Clear;
//  CollPregled.Clear;
//  CollDoctor.Clear;
//  CollUnfav.Clear;
//  CollDiag.Clear;
//  CollMDN.Clear;
//  CollMedNapr.Clear;
//  CollMedNapr3A.Clear;
//  CollIncMdn.Clear;
//  CollMkb.Clear;
//  CollExamAnal.Clear;
//  CollProceduresNomen.Clear;
//  CollCardProf.Clear;



  LoadThreadDB(FDbName);

end;

procedure TfrmSuperHip.ActiveControlChanged(Sender: TObject);
begin
  //Caption := ActiveControl.ClassType.ClassName;
  //Caption := ' смяна ' + FormatDateTime('hh:mm:ss', Now );
  EnumChildWindows(GetDesktopWindow, @EnumChildren, 0);
end;

procedure TfrmSuperHip.Adb_DMOnClearColl(Sender: TObject);
begin
  vtrGraph.DeleteChildren(vRootGraph);
  if thrHistPerf <> nil then
    thrHistPerf.stop := true;
  //initDB();
  vtrFDB.Repaint;
end;

procedure TfrmSuperHip.AddAnalInMdn(sender: tobject; var MdnLink,
  AnalLink: PVirtualNode; var TempItem: TRealExamAnalysisItem);
var
  p: PInt;
  i, k: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;

  TreeLink, Run, nodeMdn: PVirtualNode;
  linkpos: Cardinal;
  data: PAspRec;

begin
  // намиране на mdn, към който ще се добави мдн;
  nodeMdn := MdnLink;
  //създаване на mdn с добавяне в колекцията
  TempItem := TRealExamAnalysisItem(ADB_DM.CollExamAnal.Add);
  New(TempItem.PRecord);
  TempItem.PRecord.setProp := [];
  //FDBHelper.InsertAdbMdnField(TempItem);

  TempItem.InsertExamAnalysis;



  Dispose(TempItem.PRecord);
  TempItem.PRecord := nil;

  pCardinalData := pointer(Adb_DM.AdbMain.Buf);
  FPosMetaData := pCardinalData^;
  ADB_DM.CollPregled.IncCntInADB;
  Elapsed := Stopwatch.Elapsed;
  /////////////////////////////////////////////
  vtrPregledPat.BeginUpdate;
  try
    try
      pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
      linkpos := pCardinalData^;

      TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
      data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
      data.index := -1;
      data.vid := vvExamAnal;
      data.DataPos := TempItem.DataPos;
      TreeLink.Index := 0;
      inc(linkpos, LenData);

      TreeLink.TotalCount := 1;
      TreeLink.TotalHeight := 27;
      TreeLink.NodeHeight := 27;
      TreeLink.States := [vsVisible];
      TreeLink.Align := 50;
      TreeLink.Dummy := 222;

      vtrPregledPat.InitNode(TreeLink);
      vtrPregledPat.InternalConnectNode_cmd(TreeLink, nodeMdn,
                        vtrPregledPat, amAddChildLast);

      AnalLink := TreeLink;
      pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
      pCardinalData^ := linkpos;
    except

      exit;
    end;
  finally
    vtrPregledPat.EndUpdate;
  end;
end;

procedure TfrmSuperHip.AddCl(cl: string);
var
  tempItem: TNomenNzisItem;
  nomenRec: TNomenNzisRec;
  v: PVirtualNode;
  data: PAspRec;
  i: Integer;
begin
  TempItem := TNomenNzisItem(ADB_DM.NomenNzisColl.Add);
  New(TempItem.PRecord);
  TempItem.PRecord.setProp := [NomenNzis_NomenName, NomenNzis_NomenID];
  TempItem.PRecord.NomenName := '';
  TempItem.PRecord.NomenID := cl;
  TempItem.InsertNomenNzis;
  Dispose(TempItem.PRecord);
  TempItem.PRecord := nil;

  vtrNomenNzis.BeginUpdate;

  //ListNomenNzisNames[i] := TNomenNzisRec.Create;
  nomenRec := TNomenNzisRec.Create;
  i :=  Adb_DM.ListNomenNzisNames.Add(nomenRec);
  nomenRec.nomenNzis := tempItem;
  //ListNomenNzisNames[i].nomenNzis := NomenNzisColl.Items[i];

  v := vtrNomenNzis.AddChild(vRootNomenNzis, nil);

  data := vtrNomenNzis.GetNodeData(v);
  data.vid := vvNomenNzis;
  data.index := i;
  vtrNomenNzis.AddWaitNode(v);
  vtrNomenNzis.EndUpdate;
end;

procedure TfrmSuperHip.AddMdnInPregled(sender: tobject; var PregledLink, MdnLink: PVirtualNode; var TempItem: TRealMDNItem);
var
  p: PInt;
  i, k: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;

  TreeLink, Run, nodePreg: PVirtualNode;
  linkpos: Cardinal;
  data: PAspRec;
  diag: TRealDiagnosisItem;

  //vMdn: PVirtualNode;

begin
  // намиране на прегледа, към който ще се добави мдн;
  nodePreg := PregledLink;
  //създаване на mdn с добавяне в колекцията
  TempItem := TRealMDNItem(ADB_DM.CollMDN.Add);
  New(TempItem.PRecord);
  TempItem.PRecord.setProp := [];
  FDBHelper.InsertAdbMdnField(TempItem); // otdeleno

  TempItem.InsertMDN;

  //CollPregled.streamComm.Len := CollPregled.streamComm.Size;
  //streamCmdFile.CopyFrom(CollPregled.streamComm, 0);


  Dispose(TempItem.PRecord);
  TempItem.PRecord := nil;

  pCardinalData := pointer(Adb_DM.AdbMain.Buf);
  FPosMetaData := pCardinalData^;
  ADB_DM.CollPregled.IncCntInADB;
  Elapsed := Stopwatch.Elapsed;
  /////////////////////////////////////////////
  vtrPregledPat.BeginUpdate;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  linkpos := pCardinalData^;

  TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
  data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
  data.index := -1;
  data.vid := vvMDN;
  data.DataPos := TempItem.DataPos;
  TreeLink.Index := 0;
  inc(linkpos, LenData);

  TreeLink.TotalCount := 1;
  TreeLink.TotalHeight := 27;
  TreeLink.NodeHeight := 27;
  TreeLink.States := [vsVisible];
  TreeLink.Align := 50;
  TreeLink.Dummy := 222;

  vtrPregledPat.InitNode(TreeLink);
  vtrPregledPat.InternalConnectNode_cmd(TreeLink, nodePreg,
                    vtrPregledPat, amAddChildLast);

  MdnLink := TreeLink;
  vtrPregledPat.TreeStates := vtrPregledPat.TreeStates - [tsChangePending];
  vtrPregledPat.EndUpdate;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  pCardinalData^ := linkpos;
end;

procedure TfrmSuperHip.AddMnInPregled(sender: tobject; var PregledLink,
  MnLink: PVirtualNode; var TempItem: TRealBLANKA_MED_NAPRItem);
var
  p: PInt;
  i, k: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;

  TreeLink, Run, nodePreg: PVirtualNode;
  linkpos: Cardinal;
  data: PAspRec;
  diag: TRealDiagnosisItem;

  //vMdn: PVirtualNode;

begin
  // намиране на прегледа, към който ще се добави мн;
  nodePreg := PregledLink;
  //създаване на mn с добавяне в колекцията
  TempItem := TRealBLANKA_MED_NAPRItem(ADB_DM.CollMedNapr.Add);
  New(TempItem.PRecord);
  TempItem.PRecord.setProp := [];
  FDBHelper.InsertAdbMnField(TempItem); // otdeleno

  TempItem.InsertBLANKA_MED_NAPR;

  Dispose(TempItem.PRecord);
  TempItem.PRecord := nil;

  pCardinalData := pointer(Adb_DM.AdbMain.Buf);
  FPosMetaData := pCardinalData^;
  ADB_DM.CollPregled.IncCntInADB;
  Elapsed := Stopwatch.Elapsed;
  /////////////////////////////////////////////
  vtrPregledPat.BeginUpdate;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  linkpos := pCardinalData^;

  TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
  data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
  data.index := -1;
  data.vid := vvMedNapr;
  data.DataPos := TempItem.DataPos;
  TreeLink.Index := 0;
  inc(linkpos, LenData);

  TreeLink.TotalCount := 1;
  TreeLink.TotalHeight := 27;
  TreeLink.NodeHeight := 27;
  TreeLink.States := [vsVisible];
  TreeLink.Align := 50;
  TreeLink.Dummy := 222;

  vtrPregledPat.InitNode(TreeLink);
  vtrPregledPat.InternalConnectNode_cmd(TreeLink, nodePreg,
                    vtrPregledPat, amAddChildLast);

  MnLink := TreeLink;
  vtrPregledPat.TreeStates := vtrPregledPat.TreeStates - [tsChangePending];
  vtrPregledPat.EndUpdate;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  pCardinalData^ := linkpos;
end;

procedure TfrmSuperHip.AddNewDiag(vPreg: PVirtualNode; cl011, cl011Add: string;
  rank: integer; DataPosMkb: cardinal);
var
  diag: TRealDiagnosisItem;
  vDiag, vPrevDiag, run: PVirtualNode;
  linkpos: Cardinal;
  i, indexMkb: Integer;
  dataRun: PAspRec;
begin
  vPrevDiag := nil;
  if rank > 0 then
  begin
    run := vPreg.FirstChild;
    while run <> nil do
    begin
      dataRun := Pointer(PByte(run) + lenNode);
      case dataRun.vid of
        vvDiag:
        begin
          if ADB_DM.CollDiag.getWordMap(dataRun.DataPos, word(Diagnosis_rank)) = (rank - 1) then
          begin
            vPrevDiag := run;
            Break;
          end;
        end;
      end;
      run := run.NextSibling;
    end;
  end;
  diag := TRealDiagnosisItem(ADB_DM.CollDiag.Add);// добавяне на диагноза в колекцията
  New(diag.PRecord);
  diag.PRecord.setProp := [Diagnosis_code_CL011, Diagnosis_rank, Diagnosis_MkbPos];
  diag.PRecord.code_CL011 := cl011;
  diag.PRecord.rank := rank;
  diag.PRecord.MkbPos := DataPosMkb;
  if DataPosMkb = 100 then
  begin
    if tmpVtr.FindMkbDataPosFromCode(cl011, indexMkb) then
      diag.PRecord.MkbPos := ADB_DM.CollMkb.Items[indexMkb].DataPos;
    //for i := 0 to CollMkb.Count - 1 do
//    begin
//      if CollMkb.getAnsiStringMap( CollMkb.Items[i].DataPos, word(Diagnosis_code_CL011)) = cl011 then
//      begin
//        diag.PRecord.MkbPos := CollMkb.Items[i].DataPos;
//        Break;
//      end;
//    end;
  end;

  if cl011Add <> '' then
  begin
    Include(diag.PRecord.setProp, Diagnosis_additionalCode_CL011);
    diag.PRecord.additionalCode_CL011 := cl011Add;
  end;

  diag.InsertDiagnosis;
  ADB_DM.CollDiag.streamComm.Len := ADB_DM.CollDiag.streamComm.Size;
  streamCmdFile.CopyFrom(ADB_DM.CollDiag.streamComm, 0);
  Dispose(diag.PRecord);
  diag.PRecord := nil;

  if vPrevDiag = nil then
  begin
    AspectsLinkPatPregFile.AddNewNode(vvDiag, diag.DataPos, vPreg, amAddChildLast, vDiag, linkpos);
  end
  else
  begin
    AspectsLinkPatPregFile.AddNewNode(vvDiag, diag.DataPos, vPrevDiag, amInsertAfter, vDiag, linkpos);
  end;
end;

procedure TfrmSuperHip.AddNewMdn;
var
  i: Integer;
  msg: TNzisReqRespItem;
  CurrentNrn: string;
  currentMdn: TRealMDNItem;
begin
  ADB_DM.AmsgColl.SortListByNRN(LstRMDN);
  CurrentNrn := '';
  for i := 0 to LstRMDN.Count - 1 do
  begin
    msg := LstRMDN[i];
    if msg.Mdn = nil then
    begin
       if CurrentNrn <> LstRMDN[i].PRecord.NRN then
       begin
         currentMdn := TRealMDNItem(ADB_DM.AmsgColl.CollMdn.Add);
         CurrentNrn := LstRMDN[i].PRecord.NRN;
         currentMdn.FLstMsgImportNzis.Add(msg);
         currentMdn.NRN := CurrentNrn;
         currentMdn.PregledNRN := LstRMDN[i].PRecord.BaseOn;
         LstRMDN[i].Mdn := currentMdn;
       end
       else
       begin
         currentMdn.FLstMsgImportNzis.Add(msg);
       end;
    end;
  end;
end;

procedure TfrmSuperHip.AddNewPatXXX;
var
  i: Integer;
  msg: TNzisReqRespItem;
  preg: TRealPregledNewItem;
  pat: TRealPatientNewItem;
  CurrentEgn: string;
  currentPat: TRealPatientNewItem;
begin
  ADB_DM.AmsgColl.CollPreg.SortByPatEGN;
  CurrentEgn := 'aaaaaaaaaaaaaaaaaaaa';
  currentPat := nil;
  for i := 0 to ADB_DM.AmsgColl.CollPreg.Count - 1 do
  begin
    preg := ADB_DM.AmsgColl.CollPreg.Items[i];
    if preg.PatEgn = '' then
      Continue;
    if preg.FLstMsgImportNzis.Count = 0 then Continue;
    if preg.Fpatient = nil then
    begin
      if CurrentEgn <> preg.PatEgn then
      begin
        pat := TRealPatientNewItem(ADB_DM.AmsgColl.CollPat.Add);
        preg.Fpatient := pat;
        if preg.NRN = '252462095FD4' then
        Caption := 'ddd';
        pat.FPregledi.Add(preg);
        pat.PatEGN := preg.PatEgn;
        CurrentEgn := preg.PatEgn;
        currentPat := pat;
      end
      else
      begin
        preg.Fpatient := currentPat;
        if preg.NRN = '252462095FD4' then
          Caption := 'ddd';
        currentPat.FPregledi.Add(preg);
      end;
    end;
  end;
end;

procedure TfrmSuperHip.AddNewPlan(vPreg: PVirtualNode; var gr: TGraphPeriod132; var TreeLinkPlan: PVirtualNode);
var
  NZIS_PLANNED_TYPE: TRealNZIS_PLANNED_TYPEItem;
  pCardinalData: PCardinal;
  FPosMetaData, linkPos: Cardinal;
  planStatus: TPlanedStatusSet;
begin
  NZIS_PLANNED_TYPE := TRealNZIS_PLANNED_TYPEItem(ADB_DM.CollNZIS_PLANNED_TYPE.Add);
  New(NZIS_PLANNED_TYPE.PRecord);
  NZIS_PLANNED_TYPE.PRecord.setProp :=
     [NZIS_PLANNED_TYPE_CL132_KEY, NZIS_PLANNED_TYPE_ID, NZIS_PLANNED_TYPE_PREGLED_ID,
     NZIS_PLANNED_TYPE_StartDate, NZIS_PLANNED_TYPE_EndDate, NZIS_PLANNED_TYPE_CL132_DataPos, NZIS_PLANNED_TYPE_NumberRep];
  NZIS_PLANNED_TYPE.PRecord.ID := 0;
  NZIS_PLANNED_TYPE.PRecord.PREGLED_ID := 0;
  NZIS_PLANNED_TYPE.PRecord.CL132_KEY := gr.Cl132.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(CL132_Key));
  NZIS_PLANNED_TYPE.PRecord.StartDate := gr.startDate;
  if RL090Prev.Contains('|' + NZIS_PLANNED_TYPE.PRecord.CL132_KEY + '|') then
  begin
    NZIS_PLANNED_TYPE.PRecord.EndDate := IncMonth(gr.startDate, 4 );
  end
  else
  begin
    NZIS_PLANNED_TYPE.PRecord.EndDate := gr.endDate;
  end;
  NZIS_PLANNED_TYPE.PRecord.CL132_DataPos := gr.Cl132.DataPos;
  NZIS_PLANNED_TYPE.PRecord.NumberRep := gr.repNumber;


  NZIS_PLANNED_TYPE.InsertNZIS_PLANNED_TYPE; // добавям новия план

  ADB_DM.CollNZIS_PLANNED_TYPE.streamComm.Len := ADB_DM.CollNZIS_PLANNED_TYPE.streamComm.Size;
  streamCmdFile.CopyFrom(ADB_DM.CollNZIS_PLANNED_TYPE.streamComm, 0);
  Dispose(NZIS_PLANNED_TYPE.PRecord);
  NZIS_PLANNED_TYPE.PRecord := nil;

  pCardinalData := pointer(Adb_DM.AdbMain.Buf);
  FPosMetaData := pCardinalData^;
  ADB_DM.CollNZIS_PLANNED_TYPE.IncCntInADB;
  AspectsLinkPatPregFile.AddNewNode(vvNZIS_PLANNED_TYPE, NZIS_PLANNED_TYPE.DataPos, vPreg, amAddChildLast, TreeLinkPlan, linkpos);

  TreeLinkPlan.CheckType := ctCheckBox;
  TreeLinkPlan.CheckState := csCheckedNormal;
  planStatus := [TPlanedStatus.psNew];
  TreeLinkPlan.Dummy := Byte(planStatus);// току що създаден план. Не е проверяван и не е показван
end;

procedure TfrmSuperHip.AddNewPreg;
var
  i: Integer;
  msg: TNzisReqRespItem;
  CurrentNrn: string;
  currentPreg: TRealPregledNewItem;
begin
  ADB_DM.AmsgColl.SortListByNRN(LstXXXX);
  CurrentNrn := '';
  for i := 0 to LstXXXX.Count - 1 do
  begin
    msg := LstXXXX[i];
    if msg.Preg = nil then
    begin
       if CurrentNrn <> LstXXXX[i].PRecord.NRN then
       begin
         currentPreg := TRealPregledNewItem(ADB_DM.AmsgColl.CollPreg.Add);
         CurrentNrn := LstXXXX[i].PRecord.NRN;
         currentPreg.FLstMsgImportNzis.Add(msg);
         currentPreg.NRN := CurrentNrn;
         if msg.PRecord.msgNom in[3, 13] then
         begin
           currentPreg.COPIED_FROM_NRN := msg.PRecord.BaseOn;
         end;
         LstXXXX[i].Preg := currentPreg;
         if msg.PRecord.msgNom in [1, 13] then
         begin
           currentPreg.PatEgn := msg.PRecord.patEgn;
         end;


       end
       else
       begin
         currentPreg.FLstMsgImportNzis.Add(msg);
         if msg.PRecord.msgNom in [1, 13] then
         begin
           currentPreg.PatEgn := msg.PRecord.patEgn;
         end;
         if msg.PRecord.msgNom in[3, 13] then
         begin
           currentPreg.COPIED_FROM_NRN := msg.PRecord.BaseOn;
         end;
       end;
    end;
  end;
end;

procedure TfrmSuperHip.AddNewPregled;
var
  p: PInt;
  TempItem, preg: TRealPregledNewItem;
  Plan: TRealNZIS_PLANNED_TYPEItem;
  examAnal: TRealExamAnalysisItem;
  MedNapr: TRealBLANKA_MED_NAPRItem;
  i, j, k: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData, cl22Pos: Cardinal;

  TreeLink, Run, nodePat: PVirtualNode;
  vPreg, vCl132, vPr001, vCL088, vPerf, vDeput, vDiag: PVirtualNode;
  linkpos: Cardinal;
  data, dataPa, dataPerformer: PAspRec;
  gr: TGraphPeriod132;
  Rule88, ACL144_key, Cl132Key, note, Field_cl133, cl028Key, test, PR001ActivityID: string;
  pr001: TRealPR001Item;
  Cl144: TRealCl144Item;
  Cl142: TRealCl142Item;
  cl134: TRealCl134Item;
  NZIS_PLANNED_TYPE: TRealNZIS_PLANNED_TYPEItem;
  NZIS_QUESTIONNAIRE_RESPONSE: TRealNZIS_QUESTIONNAIRE_RESPONSEItem;
  NZIS_QUESTIONNAIRE_ANSWER: TRealNZIS_QUESTIONNAIRE_ANSWERItem;
  NZIS_NZIS_ANSWER_VALUE: TRealNZIS_ANSWER_VALUEItem;
  NZIS_DIAGNOSTIC_REPORT: TRealNZIS_DIAGNOSTIC_REPORTItem;
  NZIS_RESULT_DIAGNOSTIC_REPORT: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
  mkb, mkb_s: string;
  ArrPR001ActivityID: TArray<string>;
begin
  // намиране на пациента, на който ще се прави новия преглед;
  nodePat := PVirtualNode(vtrMinaliPregledi.Tag);
  dataPa := Pointer(PByte(nodePat) + lenNode);
  mmoTest.Lines.Add(ADB_DM.CollPatient.getAnsiStringMap(dataPa.DataPos, Word(PatientNZOK_EGN)));
  //създаване на прегледа с добавяне в колекцията
  TempItem := TRealPregledNewItem(ADB_DM.CollPregled.Add);
  TempItem.Fpatient := FmxProfForm.Patient;
  if TempItem.Fpatient.CurrentGraphIndex < 0 then exit;
  if TempItem.Fpatient.lstGraph.Count = 0 then
  begin
    Exit;/////zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
  end;
  if TempItem.Fpatient.CurrentGraphIndex > TempItem.Fpatient.lstGraph.Count - 1 then  Exit;



  try
    gr := TempItem.Fpatient.lstGraph[TempItem.Fpatient.CurrentGraphIndex];
    TempItem.StartDate := Floor(gr.endDate);// Тука трябва да е последния ден от срока за профилактиката
    TempItem.StartTime := 0;
  except
    Caption := 'ddd';
  end;
  New(TempItem.PRecord);
  TempItem.PRecord.setProp := [];
  FDBHelper.InsertAdbPregledField(TempItem); // otdeleno

  TempItem.InsertPregledNew;

  ADB_DM.CollPregled.streamComm.Len := ADB_DM.CollPregled.streamComm.Size;
  streamCmdFile.CopyFrom(ADB_DM.CollPregled.streamComm, 0);


  Dispose(TempItem.PRecord);
  TempItem.PRecord := nil;

  pCardinalData := pointer(Adb_DM.AdbMain.Buf);
  FPosMetaData := pCardinalData^;
  ADB_DM.CollPregled.IncCntInADB;
  Elapsed := Stopwatch.Elapsed;
  /////////////////////////////////////////////
  vtrPregledPat.BeginUpdate;
  AspectsLinkPatPregFile.AddNewNode(vvPregled, TempItem.DataPos, nodePat, amAddChildFirst, TreeLink, linkpos);
  vPreg := TreeLink;

  // zzzzzzzzzzzzzzzzzzzzzzzzzzzzz AutoNzis  тука слагам 2-рия доктор замества 1-вия
  AspectsLinkPatPregFile.AddNewNode(vvPerformer, ADB_DM.CollDoctor.Items[0].DataPos, vPreg, amAddChildLast, vPerf, linkpos);
  AspectsLinkPatPregFile.AddNewNode(vvDeput, ADB_DM.CollDoctor.Items[1].DataPos, vPerf, amAddChildLast, vDeput, linkpos);
  mkb_s := '';
  ADB_DM.ListPregledLinkForInsert.Add(vPreg);
  for i := 0 to TempItem.Fpatient.ListCurrentProf.Count - 1 do
  begin
    gr := TempItem.Fpatient.ListCurrentProf[i];
    begin
      if gr.Cl132.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(CL132_CL136_Mapping)) = '1' then
      begin
        mkb := gr.Cl132.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(CL132_CL011_Mapping));
        if not mkb_s.Contains(mkb) then
        begin
          AddNewDiag(vPreg, mkb, '', 0, 100);
          mkb_s := mkb_s + mkb;
        end;
      end;
      Cl132Key := gr.Cl132.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(CL132_Key));
      for j := 0 to TempItem.Fpatient.FPregledi.Count - 1 do
      begin
        preg := TempItem.Fpatient.FPregledi[j];
        for k := 0 to preg.ListNZIS_PLANNED_TYPEs.Count - 1 do
        begin
          Plan := preg.ListNZIS_PLANNED_TYPEs[k];
          //
          if ADB_DM.CollNZIS_PLANNED_TYPE.getAnsiStringMap(Plan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY)) = Cl132Key then
          begin
            if (Plan.Node.CheckType = ctCheckBox) and (Plan.Node.CheckState = csUncheckedNormal)  then
              vtrPregledPat.InternalDisconnectNode(plan.Node, False);
          end;
        end;
      end;
      AddNewPlan(vPreg, gr, TreeLink);



      vCl132 := TreeLink;

      for j := 0 to gr.Cl132.FListPr001.Count - 1 do
      begin
        pr001 := gr.Cl132.FListPr001[j];
        if pr001.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(PR001_Nomenclature)) = 'CL133'  then
        begin
          NZIS_QUESTIONNAIRE_RESPONSE := TRealNZIS_QUESTIONNAIRE_RESPONSEItem(ADB_DM.CollNZIS_QUESTIONNAIRE_RESPONSE.Add);
          New(NZIS_QUESTIONNAIRE_RESPONSE.PRecord);
          NZIS_QUESTIONNAIRE_RESPONSE.PRecord.setProp :=
             [NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE,
              NZIS_QUESTIONNAIRE_RESPONSE_ID,
              NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID,
              NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY];
          NZIS_QUESTIONNAIRE_RESPONSE.PRecord.ID := 0;
          NZIS_QUESTIONNAIRE_RESPONSE.PRecord.PLANNED_TYPE_ID := 0;
          NZIS_QUESTIONNAIRE_RESPONSE.PRecord.CL133_QUEST_RESPONSE_CODE :=
             pr001.getWordMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(PR001_Activity_ID));
          NZIS_QUESTIONNAIRE_RESPONSE.PRecord.PR001_KEY :=
             pr001.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(PR001_Nomenclature)) + '|' +
             pr001.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(PR001_Activity_ID));
          NZIS_QUESTIONNAIRE_RESPONSE.InsertNZIS_QUESTIONNAIRE_RESPONSE;

          ADB_DM.CollNZIS_QUESTIONNAIRE_RESPONSE.streamComm.Len := ADB_DM.CollNZIS_QUESTIONNAIRE_RESPONSE.streamComm.Size;
          streamCmdFile.CopyFrom(ADB_DM.CollNZIS_QUESTIONNAIRE_RESPONSE.streamComm, 0);
          Dispose(NZIS_QUESTIONNAIRE_RESPONSE.PRecord);
          NZIS_QUESTIONNAIRE_RESPONSE.PRecord := nil;

          pCardinalData := pointer(Adb_DM.AdbMain.Buf);
          FPosMetaData := pCardinalData^;
          ADB_DM.CollNZIS_QUESTIONNAIRE_RESPONSE.IncCntInADB;
          AspectsLinkPatPregFile.AddNewNode(vvNZIS_QUESTIONNAIRE_RESPONSE, NZIS_QUESTIONNAIRE_RESPONSE.DataPos, vCl132, amAddChildLast, TreeLink, linkpos);
          if True then
          begin

          end;

        end
        else
        if pr001.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(PR001_Nomenclature)) = 'CL022'  then
        begin
          ArrPR001ActivityID := string(ADB_DM.PR001Coll.getAnsiStringMap(pr001.DataPos, Word(PR001_Activity_ID))).Split([';']);
          for k := 0 to Length(ArrPR001ActivityID) - 1 do
          begin
            PR001ActivityID := ArrPR001ActivityID[k];
            cl22Pos := ADB_DM.CL022Coll.GetDataPosFromKey(PR001ActivityID);

            examAnal := TRealExamAnalysisItem(ADB_DM.CollExamAnal.Add);
            New(examAnal.PRecord);
            examAnal.PRecord.setProp :=
               [
                ExamAnalysis_ID,
                ExamAnalysis_NZIS_CODE_CL22,
                ExamAnalysis_PosDataNomen
                ];
            examAnal.PRecord.ID := 0;
            examAnal.PRecord.NZIS_CODE_CL22 := ADB_DM.CL022Coll.getAnsiStringMap(cl22Pos, word(CL022_nhif_code));
            examAnal.PRecord.PosDataNomen := cl22Pos;


            examAnal.InsertExamAnalysis;

            ADB_DM.CollExamAnal.streamComm.Len := ADB_DM.CollExamAnal.streamComm.Size;
            streamCmdFile.CopyFrom(ADB_DM.CollExamAnal.streamComm, 0);
            Dispose(examAnal.PRecord);
            examAnal.PRecord := nil;

            pCardinalData := pointer(Adb_DM.AdbMain.Buf);
            FPosMetaData := pCardinalData^;
            ADB_DM.CollExamAnal.IncCntInADB;
            AspectsLinkPatPregFile.AddNewNode(vvExamAnal, examAnal.DataPos, vCl132, amAddChildLast, TreeLink, linkpos);
          end;

        end
        else
        if pr001.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(PR001_Nomenclature)) = 'CL014'  then
        begin
          if  pr001.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(PR001_Activity_ID)) = 'R2' then
          begin
            MedNapr := TRealBLANKA_MED_NAPRItem(ADB_DM.CollMedNapr.Add);
            New(MedNapr.PRecord);
            MedNapr.PRecord.setProp :=
               [BLANKA_MED_NAPR_ID ,
                BLANKA_MED_NAPR_SPECIALITY_ID
                ];
            MedNapr.PRecord.ID := 0;
            MedNapr.PRecord.SPECIALITY_ID := 0;////
            //MedNapr.PRecord.PosDataNomen := cl22Pos;


            MedNapr.InsertBLANKA_MED_NAPR;
            AspectsLinkPatPregFile.AddNewNode(vvMedNapr, MedNapr.DataPos, vCl132, amAddChildLast, TreeLink, linkpos);
          end;

        end
        else
        begin
          if pr001.CL142 <> nil then
          begin
            NZIS_DIAGNOSTIC_REPORT := TRealNZIS_DIAGNOSTIC_REPORTItem(ADB_DM.CollNZIS_DIAGNOSTIC_REPORT.Add);
            New(NZIS_DIAGNOSTIC_REPORT.PRecord);
            NZIS_DIAGNOSTIC_REPORT.PRecord.setProp :=
               [NZIS_DIAGNOSTIC_REPORT_CL083_STATUS,
                NZIS_DIAGNOSTIC_REPORT_CL142_CODE,
                NZIS_DIAGNOSTIC_REPORT_ID,
                NZIS_DIAGNOSTIC_REPORT_PREGLED_ID,
                NZIS_DIAGNOSTIC_REPORT_NOMEN_POS];
            NZIS_DIAGNOSTIC_REPORT.PRecord.ID := 0;
            NZIS_DIAGNOSTIC_REPORT.PRecord.PREGLED_ID := 0;
            NZIS_DIAGNOSTIC_REPORT.PRecord.CL083_STATUS := 10;// registriran
            NZIS_DIAGNOSTIC_REPORT.PRecord.CL142_CODE :=
               pr001.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(PR001_Activity_ID));
            NZIS_DIAGNOSTIC_REPORT.PRecord.NOMEN_POS := pr001.CL142.DataPos;
            NZIS_DIAGNOSTIC_REPORT.InsertNZIS_DIAGNOSTIC_REPORT;

            ADB_DM.CollNZIS_DIAGNOSTIC_REPORT.streamComm.Len := ADB_DM.CollNZIS_DIAGNOSTIC_REPORT.streamComm.Size;
            streamCmdFile.CopyFrom(ADB_DM.CollNZIS_DIAGNOSTIC_REPORT.streamComm, 0);
            Dispose(NZIS_DIAGNOSTIC_REPORT.PRecord);
            NZIS_DIAGNOSTIC_REPORT.PRecord := nil;

            pCardinalData := pointer(Adb_DM.AdbMain.Buf);
            FPosMetaData := pCardinalData^;
            ADB_DM.CollNZIS_DIAGNOSTIC_REPORT.IncCntInADB;
            AspectsLinkPatPregFile.AddNewNode(vvNZIS_DIAGNOSTIC_REPORT, NZIS_DIAGNOSTIC_REPORT.DataPos, vCl132, amAddChildLast, TreeLink, linkpos);
          end;
        end;
        vPr001 := TreeLink;
        if pr001.CL142 <> nil  then
        begin
          Rule88 := pr001.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(PR001_Notes));

          if pr001.CL142.FListCL144.Count > 1 then // дейности
          begin
            for k := 0 to pr001.CL142.FListCL144.Count - 1 do
            begin
              Cl144 := pr001.CL142.FListCL144[k];
              if Trim(Rule88) <> '' then
              begin
                ACL144_key := Cl144.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL144_Key));
                if Pos(ACL144_key, Rule88) = 0 then Continue;
              end;
              /////////AspectsLinkPatPregFile.AddNewNode(vvCL144, Cl144.DataPos, vPr001, amAddChildLast, TreeLink, linkpos);
              //NZIS_RESULT_DIAGNOSTIC_REPORT
              NZIS_RESULT_DIAGNOSTIC_REPORT := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(ADB_DM.CollNZIS_RESULT_DIAGNOSTIC_REPORT.Add);
              New(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord);
              NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.setProp :=  [
                 NZIS_RESULT_DIAGNOSTIC_REPORT_ID,
                 NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE,
                 NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID,
                 NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE,
                 NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS
                 ];
              NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.ID := 0;
              NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.DIAGNOSTIC_REPORT_ID := 0;
              NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.CL144_CODE := Cl144.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL144_Key));
              NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.CL028_VALUE_SCALE := StrToInt(Cl144.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL144_cl028)));
              NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.NOMEN_POS := Cl144.DataPos;

              NZIS_RESULT_DIAGNOSTIC_REPORT.InsertNZIS_RESULT_DIAGNOSTIC_REPORT;

              ADB_DM.CollNZIS_RESULT_DIAGNOSTIC_REPORT.streamComm.Len := ADB_DM.CollNZIS_RESULT_DIAGNOSTIC_REPORT.streamComm.Size;
              streamCmdFile.CopyFrom(ADB_DM.CollNZIS_RESULT_DIAGNOSTIC_REPORT.streamComm, 0);
              Dispose(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord);
              NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord := nil;

              pCardinalData := pointer(Adb_DM.AdbMain.Buf);
              FPosMetaData := pCardinalData^;
              ADB_DM.CollNZIS_RESULT_DIAGNOSTIC_REPORT.IncCntInADB;
              AspectsLinkPatPregFile.AddNewNode(vvNZIS_RESULT_DIAGNOSTIC_REPORT, NZIS_RESULT_DIAGNOSTIC_REPORT.DataPos, vPr001, amAddChildLast, TreeLink, linkpos);
            end;
          end;
        end;

        for k := 0 to gr.Cl132.FListPr001[j].LstCl134.Count - 1 do  // отговори
        begin
          cl134 := gr.Cl132.FListPr001[j].LstCl134[k];
          note := cl134.getAnsiStringMap(AspectsNomFile.buf, ADB_DM.CL132Coll.posData, word(CL134_Note));
          Field_cl133 := cl134.getAnsiStringMap(AspectsNomFile.buf, ADB_DM.CL132Coll.posData, word(CL134_CL133));
          cl028Key := cl134.getAnsiStringMap(AspectsNomFile.buf, ADB_DM.CL132Coll.posData, word(CL134_CL028));
          if (note <> '') and (Field_cl133[1] in ['5', '6']) then
          begin
            test := gr.Cl132.getAnsiStringMap(AspectsNomFile.buf, ADB_DM.CL132Coll.posData, word(CL132_Key)) +
                     cl134.getAnsiStringMap(AspectsNomFile.buf, ADB_DM.CL132Coll.posData, word(CL134_Note));
          end
          else
          begin
            test := '';
          end;

          begin
            NZIS_QUESTIONNAIRE_ANSWER := TRealNZIS_QUESTIONNAIRE_ANSWERItem(ADB_DM.CollNZIS_QUESTIONNAIRE_ANSWER.Add);
            New(NZIS_QUESTIONNAIRE_ANSWER.PRecord);
            NZIS_QUESTIONNAIRE_ANSWER.PRecord.setProp :=
               [NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE,
                NZIS_QUESTIONNAIRE_ANSWER_ID,
                NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID,
                NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS];
            NZIS_QUESTIONNAIRE_ANSWER.PRecord.ID := 0;
            NZIS_QUESTIONNAIRE_ANSWER.PRecord.QUESTIONNAIRE_RESPONSE_ID := 0;
            NZIS_QUESTIONNAIRE_ANSWER.PRecord.CL134_QUESTION_CODE := cl134.getAnsiStringMap(AspectsNomFile.buf, ADB_DM.CL132Coll.posData, word(CL134_Key));;
            NZIS_QUESTIONNAIRE_ANSWER.PRecord.NOMEN_POS := cl134.DataPos;
               //pr001.getWordMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(PR001_Activity_ID));

            NZIS_QUESTIONNAIRE_ANSWER.InsertNZIS_QUESTIONNAIRE_ANSWER;

            ADB_DM.CollNZIS_QUESTIONNAIRE_ANSWER.streamComm.Len := ADB_DM.CollNZIS_QUESTIONNAIRE_ANSWER.streamComm.Size;
            streamCmdFile.CopyFrom(ADB_DM.CollNZIS_QUESTIONNAIRE_ANSWER.streamComm, 0);
            Dispose(NZIS_QUESTIONNAIRE_ANSWER.PRecord);
            NZIS_QUESTIONNAIRE_ANSWER.PRecord := nil;

            pCardinalData := pointer(Adb_DM.AdbMain.Buf);
            FPosMetaData := pCardinalData^;
            ADB_DM.CollNZIS_QUESTIONNAIRE_ANSWER.IncCntInADB;
            AspectsLinkPatPregFile.AddNewNode(vvNZIS_QUESTIONNAIRE_ANSWER, NZIS_QUESTIONNAIRE_ANSWER.DataPos, vPr001, amAddChildLast, TreeLink, linkpos);
            //case cl028Key[1] of
//              '1':// едиторчета
//              begin
//                AspectsLinkPatPregFile.AddNewNode(vvNZIS_ANSWER_VALUE, 0, TreeLink, amAddChildLast, TreeLink, linkpos);
//              end;
//            end;
          end;
        end;
      end;
    end;
  end;

  vtrPregledPat.EndUpdate;
  vtrPregledPat.Selected[vpreg] := True;
  vtrPregledPat.FocusedNode := vpreg;
  ReShowProfForm(dataPa, Pointer(PByte(vpreg) + lenNode),vpreg);
  if chkAutamatNzis.Checked then
  begin
    data := Pointer(PByte(vpreg) + lenNode);
    ADB_DM.CollPregled.SetWordMap(data.DataPos, word(PregledNew_NZIS_STATUS),3);
    TempItem.FNode := vpreg;
    OnOpenPregled1(TempItem);
  end;
  TempItem.FNode := vpreg;
  if chkAutamatL009.Checked then
  begin
    OnGetPlanedTypeL009_1(TempItem);
  end;
end;

procedure TfrmSuperHip.AddNzisImport;
var
  List: TStringList;
  i, j: Integer;
  cnt: Integer;
  startX, endX, signX: Integer;
  Arrstr: TArray<string>;
  p1, p2, pEnd: Integer;

  XNom1, XNom2: Byte;

  msg: TNzisReqRespItem;

  lstMsgType: TStringList;
  fileName: string;

begin
  Stopwatch := TStopwatch.StartNew;
  //if dlgOpenNZIS.Execute then  // openDlg
  begin
    if ADB_DM.AmsgColl = nil then
    begin
      ADB_DM.AmsgColl := TNzisReqRespColl.Create(TNzisReqRespItem);
    end
    else
    begin
      ADB_DM.AmsgColl.Clear;
    end;
    List := TStringList.Create;
    lstMsgType := TStringList.Create;
    //fileName := 'C:\Users\Administrator1\Downloads\За възстановяване на данни по предоставен xml от НЗИС\За възстановяване на данни по предоставен xml от НЗИС\attachments-katerinanikolova66mailbg-inbox-29131\Приложение 1\';
    //fileName := fileName + '1900000356org.txt';
    fileName := 'D:\HaknatFerdow\0200000824.txt';
    //fileName := dlgOpenNZIS.FileName;
    List.LoadFromFile(fileName);

    Elapsed := Stopwatch.Elapsed;
    mmoTest.Lines.Add(Format('зареждане на файла: %f', [Elapsed.TotalMilliseconds]));

    Stopwatch := TStopwatch.StartNew;
    Arrstr := List.Text.Split(['<?','?>']);
    List.Free;
    Elapsed := Stopwatch.Elapsed;
    mmoTest.Lines.Add(Format('разделяне на файла на съобщения за %f ', [Elapsed.TotalMilliseconds]));


    Stopwatch := TStopwatch.StartNew;
    for i := 1 to Length(Arrstr)- 1 do
    begin

      if (i mod 300) = 0 then
      begin
        FmxRoleBar.rctProgres.Width := FmxRoleBar.rctButton.Width * (i/Length(Arrstr));
        FmxRoleBar.rctProgres.EndUpdate;
        Application.ProcessMessages;
      end;
      p1 := Pos('<nhis:messageType value="', Arrstr[i]) + 25 ;
      if p1 = 25 then
        Continue;
      p2 := Pos('<nhis:messageId value="', Arrstr[i]) + 23 ;
      lstMsgType.Add(Copy(arrstr[i],p1 , 4));
      XNom1 := StrToInt(Copy(arrstr[i],p1 + 1, 3));
      msg := TNzisReqRespItem(ADB_DM.AmsgColl.Add);
      pEnd := Pos('</nhis:message>', Arrstr[i]) + 15 ;
      SetLength(Arrstr[i], pEnd);
      New(msg.PRecord);
      msg.PRecord.setProp := [NzisReqResp_REQ, NzisReqResp_messageId, NzisReqResp_msgNom, NzisReqResp_Logical];
      msg.PRecord.REQ := Arrstr[i];
      msg.PRecord.messageId := Copy(arrstr[i],p2, 36);
      msg.PRecord.msgNom := XNom1;
      case arrstr[i][p1] of
        'X':
        begin
          msg.PRecord.Logical := [Is_X];
        end;
        'R': msg.PRecord.Logical := [Is_R];
        'P': msg.PRecord.Logical := [Is_P];
        'I': msg.PRecord.Logical := [Is_I];
        'H': msg.PRecord.Logical := [Is_H];
        'C': msg.PRecord.Logical := [Is_C];
      end;
    end;
    lstMsgType.Free;
    Elapsed := Stopwatch.Elapsed;
    mmoTest.Lines.Add(Format('запис на съобщенията в колекцията за %f ', [Elapsed.TotalMilliseconds]));
    mmoTest.Lines.Add('msgColl ' + IntToStr(ADB_DM.AmsgColl.Count));
  end;
end;

procedure TfrmSuperHip.AddOperatorNodes(FieldNode: PVirtualNode;
  Coll: TBaseCollection; PropIndex: Integer);
var
  ops: TConditionTypeSet;
  op: TConditionType;
  run: PVirtualNode;
  linkPos: Cardinal;
begin
  ops := Coll.GetAllowedOperators(PropIndex);

  for op := Low(TConditionType) to High(TConditionType) do
    if op in ops then
    begin
      AspectsFilterLinkFile.AddNewNode(vvOperator, 0, FieldNode,
        amAddChildLast, run, linkPos, Ord(op));
      run.CheckType := ctCheckBox;
      run.CheckState := csUncheckedNormal;
    end;
end;


//procedure TfrmSuperHip.AddNewPregledOld;
//var
//  p: PInt;
//  TempItem: TRealPregledNewItem;
//  i, j, k: Integer;
//  pCardinalData: ^Cardinal;
//  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
//
//  TreeLink, Run, nodePat: PVirtualNode;
//  vPreg, vCl132, vPr001, vCL088: PVirtualNode;
//  linkpos: Cardinal;
//  data: PAspRec;
//  gr: TGraphPeriod132;
//  Rule88, ACL088_key, Cl132Key, note, Field_cl133, test: string;
//  pr001: TRealPR001Item;
//  Cl088: TRealCl088Item;
//  cl134: TRealCl134Item;
//begin
//  // намиране на пациента, на който ще се прави новия преглед;
//  nodePat := PVirtualNode(vtrMinaliPregledi.Tag);
//  //създаване на прегледа с добавяне в колекцията
//  TempItem := TRealPregledNewItem(CollPregled.Add);
//  TempItem.Fpatient := FmxProfForm.Patient;
//  gr := TempItem.Fpatient.lstGraph[TempItem.Fpatient.CurrentGraphIndex];
//  TempItem.StartDate := Floor(gr.endDate);// Тука трябва да е последния ден от срока за профилактиката
//  New(TempItem.PRecord);
//  TempItem.PRecord.setProp := [];
//  //CollPregled.streamComm :=
//  FDBHelper.InsertAdbPregledField(TempItem); // otdeleno
//
//  TempItem.InsertPregledNew;
//
//  CollPregled.streamComm.Len := CollPregled.streamComm.Size;
//  streamCmdFile.CopyFrom(CollPregled.streamComm, 0);
//
//
//  Dispose(TempItem.PRecord);
//  TempItem.PRecord := nil;
//
//  pCardinalData := pointer(AspectsHipFile.Buf);
//  FPosMetaData := pCardinalData^;
//  CollPregled.IncCntInADB;
//  Elapsed := Stopwatch.Elapsed;
//  /////////////////////////////////////////////
//  vtrPregledPat.BeginUpdate;
//  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
//  linkpos := pCardinalData^;
//
//  TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
//  data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
//  data.index := -1;
//  data.vid := vvPregled;
//  data.DataPos := TempItem.DataPos;
//  TreeLink.Index := 0;
//  inc(linkpos, LenData);
//
//  TreeLink.TotalCount := 1;
//  TreeLink.TotalHeight := 27;
//  TreeLink.NodeHeight := 27;
//  TreeLink.States := [vsVisible];
//  TreeLink.Align := 50;
//  TreeLink.Dummy := 222;
//
//  vtrPregledPat.InitNode(TreeLink);
//  vtrPregledPat.InternalConnectNode_cmd(TreeLink, nodePat,
//                    vtrPregledPat, amAddChildLast);
//  vPreg := TreeLink;
//  ListPregledLinkForInsert.Add(vPreg);
//  for i := 0 to TempItem.Fpatient.ListCurrentProf.Count - 1 do
//  begin
//    gr := TempItem.Fpatient.ListCurrentProf[i];
//    begin
//      TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
//      data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
//      data.index := -1;
//      data.vid := vvCl132;
//      data.DataPos := gr.Cl132.DataPos;
//      TreeLink.Index := 0;
//      inc(linkpos, LenData);
//
//      TreeLink.TotalCount := 1;
//      TreeLink.TotalHeight := 27;
//      TreeLink.NodeHeight := 27;
//      TreeLink.States := [vsVisible];
//      TreeLink.Align := 50;
//      TreeLink.Dummy := 223;
//
//      vtrPregledPat.InitNode(TreeLink);
//      vtrPregledPat.InternalConnectNode_cmd(TreeLink, vPreg,
//                        vtrPregledPat, amAddChildLast);
//      vCl132 := TreeLink;
//      for j := 0 to gr.Cl132.FListPr001.Count - 1 do
//      begin
//        //vPr001 := vtrGraph.AddChild(vCl132, nil);
//        pr001 := gr.Cl132.FListPr001[j];
//        TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
//        data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
//        data.index := -1;
//        data.vid := vvPr001;
//        data.DataPos := pr001.DataPos;
//        TreeLink.Index := 0;
//        inc(linkpos, LenData);
//
//        TreeLink.TotalCount := 1;
//        TreeLink.TotalHeight := 27;
//        TreeLink.NodeHeight := 27;
//        TreeLink.States := [vsVisible];
//        TreeLink.Align := 50;
//        TreeLink.Dummy := 224;
//        vtrPregledPat.InitNode(TreeLink);
//        vtrPregledPat.InternalConnectNode_cmd(TreeLink, vCl132,
//                        vtrPregledPat, amAddChildLast);
//
//        vPr001 := TreeLink;
//        if pr001.CL142 <> nil  then
//        begin
//          Rule88 := pr001.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(PR001_Rules));
//
//          if pr001.CL142.FListCL088.Count > 1 then
//          begin
//            for k := 0 to pr001.CL142.FListCL088.Count - 1 do
//            begin
//              Cl088 := pr001.CL142.FListCL088[k];
//              if Trim(Rule88) <> '' then
//              begin
//                ACL088_key := cl088.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL088_key));
//                if Pos(ACL088_key, Rule88) = 0 then Continue;
//              end;
//
//              TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
//              data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
//              data.index := -1;
//              data.vid := vvCL088;
//              data.DataPos := Cl088.DataPos;
//              TreeLink.Index := 0;
//              inc(linkpos, LenData);
//
//              TreeLink.TotalCount := 1;
//              TreeLink.TotalHeight := 27;
//              TreeLink.NodeHeight := 27;
//              TreeLink.States := [vsVisible];
//              TreeLink.Align := 50;
//              TreeLink.Dummy := 225;
//              vtrPregledPat.InitNode(TreeLink);
//              vtrPregledPat.InternalConnectNode_cmd(TreeLink, vPr001,
//                              vtrPregledPat, amAddChildLast);
//            end;
//          end;
//        end;
//
//        for k := 0 to gr.Cl132.FListPr001[j].LstCl134.Count - 1 do
//        begin
//          cl134 := gr.Cl132.FListPr001[j].LstCl134[k];
//          note := cl134.getAnsiStringMap(AspectsNomFile.buf, CL132Coll.posData, word(CL134_Note));
//          Field_cl133 := cl134.getAnsiStringMap(AspectsNomFile.buf, CL132Coll.posData, word(CL134_CL133));
//          if (note <> '') and (Field_cl133[1] in ['5', '6']) then
//          begin
//            test := gr.Cl132.getAnsiStringMap(AspectsNomFile.buf, CL132Coll.posData, word(CL132_Key)) +
//                     cl134.getAnsiStringMap(AspectsNomFile.buf, CL132Coll.posData, word(CL134_Note));
//          end
//          else
//          begin
//            test := '';
//          end;
//
//          begin
//            TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
//            data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
//            data.index := -1;
//            data.vid := vvCl134;
//            data.DataPos := cl134.DataPos;
//            TreeLink.Index := 0;
//            inc(linkpos, LenData);
//
//            TreeLink.TotalCount := 1;
//            TreeLink.TotalHeight := 27;
//            TreeLink.NodeHeight := 27;
//            TreeLink.States := [vsVisible];
//            TreeLink.Align := 50;
//            TreeLink.Dummy := 226;
//            vtrPregledPat.InitNode(TreeLink);
//            vtrPregledPat.InternalConnectNode_cmd(TreeLink, vPr001,
//                            vtrPregledPat, amAddChildLast);
//          end;
//        end;
//      end;
//    end;
//
//  end;
//
//
//  vtrPregledPat.EndUpdate;
//  vtrPregledPat.Selected[vpreg] := True;
//  vtrPregledPat.FocusedNode := vpreg;
//  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
//  pCardinalData^ := linkpos;
//end;

procedure TfrmSuperHip.AddToListNodes(data: PAspRec);
begin
  Exit;
  case data.vid of
    vvPregled: ADB_DM.CollPregled.ListNodes.Add(data);
    vvPatient: ADB_DM.CollPatient.ListNodes.Add(data);
    vvDoctor: ADB_DM.CollDoctor.ListNodes.Add(data);
    vvMDN: ADB_DM.CollMDN.ListNodes.Add(data);
  end;
end;

procedure TfrmSuperHip.AddX005Pregled(preg: TRealPregledNewItem);
var
  p: PInt;
  i, k: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;

  TreeLink, Run, nodePat: PVirtualNode;
  linkpos: Cardinal;
  data: PAspRec;
  diag: TRealDiagnosisItem;

begin
  // намиране на пациента, на който ще се прави новия преглед;
  nodePat := PVirtualNode(vtrMinaliPregledi.Tag);
  ////създаване на прегледа с добавяне в колекцията
//  TempItem := TRealPregledNewItem(CollPregled.Add);
//  TempItem.StartDate := Date;// Тука трябва да е последния ден от срока за профилактиката
//  New(TempItem.PRecord);
//  TempItem.PRecord.setProp := [];
//  FDBHelper.InsertAdbPregledField(TempItem); // otdeleno

  preg.InsertPregledNew;

  //CollPregled.streamComm.Len := CollPregled.streamComm.Size;
  //streamCmdFile.CopyFrom(CollPregled.streamComm, 0);


  Dispose(preg.PRecord);
  preg.PRecord := nil;

  pCardinalData := pointer(Adb_DM.AdbMain.Buf);
  FPosMetaData := pCardinalData^;
  ADB_DM.CollPregled.IncCntInADB;
  Elapsed := Stopwatch.Elapsed;
  /////////////////////////////////////////////
  vtrPregledPat.BeginUpdate;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  linkpos := pCardinalData^;

  TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
  data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
  data.index := -1;
  data.vid := vvPregled;
  data.DataPos := preg.DataPos;
  TreeLink.Index := 0;
  inc(linkpos, LenData);

  TreeLink.TotalCount := 1;
  TreeLink.TotalHeight := 27;
  TreeLink.NodeHeight := 27;
  TreeLink.States := [vsVisible];
  TreeLink.Align := 50;
  TreeLink.Dummy := 222;

  vtrPregledPat.InitNode(TreeLink);
  vtrPregledPat.InternalConnectNode_cmd(TreeLink, nodePat,
                    vtrPregledPat, amAddChildLast);

  vpreg := TreeLink;
  ADB_DM.ListPregledLinkForInsert.Add(vpreg);

  for k := 0 to preg.FDiagnosis.Count -1 do
  begin
    diag := preg.FDiagnosis[k];
    TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
    data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
    data.DataPos := diag.DataPos;
    data.vid := vvDiag;
    data.index := -1;
    inc(linkpos, LenData);

    TreeLink.TotalCount := 1;
    TreeLink.TotalHeight := 27;
    TreeLink.NodeHeight := 27;
    TreeLink.States := [vsVisible];
    TreeLink.Align := 50;
    TreeLink.Dummy := k mod 255;
    vtrPregledPat.InitNode(TreeLink);
    vtrPregledPat.InternalConnectNode_cmd(TreeLink, vpreg, vtrPregledPat, amAddChildLast);
  end;

  /////////////////////////////////////////////////
  vtrPregledPat.EndUpdate;
  vtrPregledPat.Selected[TreeLink] := True;
  vtrPregledPat.FocusedNode := TreeLink;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  pCardinalData^ := linkpos;
end;

procedure TfrmSuperHip.AdminFDBClick(Sender: TObject);
begin
  pgcTree.ActivePage := tsTreeDBFB;
  ActiveMainButton := TRoleButton(Sender);
  ActiveSubButton := nil;
  LoadVtrFDB;
end;

procedure TfrmSuperHip.appEvntsMainException(Sender: TObject; E: Exception);
var
  copyDataStruct: TCopyDataStruct;
  HWNDHip: THandle;
  str: AnsiString;
begin
  mmoTest.Clear;
  mmoTest.Lines.Add(DateTimeToStr(Now));
  mmoTest.Lines.Add(e.Message);
  // Log unhandled exception stack info to ExceptionLogMemo
  JclLastExceptStackListToStrings(mmoTest.Lines, False, true, True,
    False);

end;

function TfrmSuperHip.appEvntsMainHelp(Command: Word; Data: NativeInt;
  var CallHelp: Boolean): Boolean;
begin
  CallHelp := False;
  if vtrHelpHip.TotalCount = 0 then
  begin
    unzipRTFHelp('HelpRTF.zip');
  end;
end;

procedure TfrmSuperHip.appEvntsMainMessage(var Msg: tagMSG;
  var Handled: Boolean);
var
  MouseDelta: SmallInt;
  p: TPoint;
  ACol: TColumn;
  exTopLine: Integer;
begin
  if Msg.Message = WM_MOUSEWHEEL then
  begin
    if pgcTree.ActivePage = tsTreePat then
    begin
      if vtrPregledPat.MouseInClient then
      begin
        SendMessage(vtrPregledPat.handle, CM_MOUSEWHEEL, Msg.WParam, Msg.LParam);
        Handled := true;
      end;
    end;
    if grdSearch.MouseInClient then
    begin
      MouseDelta := Smallint( HiWord( Msg.wParam ) );
      if MouseDelta < 0 then
      begin
        SendMessage(grdSearch.handle, WM_VSCROLL, 1, 0);
        SendMessage(grdSearch.handle, WM_VSCROLL, 8, 0);
      end
      else
      begin
        SendMessage(grdSearch.handle, WM_VSCROLL, 0, 0);
        SendMessage(grdSearch.handle, WM_VSCROLL, 8, 0);
      end;
      Handled := True;
    end;
    if syndtNzisReq.MouseInClient then
    begin 
      MouseDelta := Smallint( HiWord( Msg.wParam ) );
      if MouseDelta < 0 then
      begin
        SendMessage(syndtNzisReq.handle, WM_VSCROLL, 1, 0);
        SendMessage(syndtNzisReq.handle, WM_VSCROLL, 8, 0);
        if (GetKeyState(VK_CONTROL) < 0) then
        begin
          exTopLine := syndtNzisReq.TopLine;
          syndtNzisReq.Font.Size := syndtNzisReq.Font.Size - 1;
          syndtNzisReq.TopLine := exTopLine;
        end;
      end
      else
      begin
        SendMessage(syndtNzisReq.handle, WM_VSCROLL, 0, 0);
        SendMessage(syndtNzisReq.handle, WM_VSCROLL, 8, 0);
        if (GetKeyState(VK_CONTROL) < 0) then
        begin
          exTopLine := syndtNzisReq.TopLine;
          syndtNzisReq.Font.Size := syndtNzisReq.Font.Size + 1;
          syndtNzisReq.TopLine := exTopLine;
        end;
      end;

      Handled := True;
    end;
    if syndtNzisResp.MouseInClient then
    begin
      MouseDelta := Smallint( HiWord( Msg.wParam ) );
      if MouseDelta < 0 then
      begin
        SendMessage(syndtNzisResp.handle, WM_VSCROLL, 1, 0);
        SendMessage(syndtNzisResp.handle, WM_VSCROLL, 8, 0);
        if (GetKeyState(VK_CONTROL) < 0) then
        begin
          exTopLine := syndtNzisResp.TopLine;
          syndtNzisResp.Font.Size := syndtNzisResp.Font.Size - 1;
          syndtNzisResp.TopLine := exTopLine;
        end;
      end
      else
      begin
        SendMessage(syndtNzisResp.handle, WM_VSCROLL, 0, 0);
        SendMessage(syndtNzisResp.handle, WM_VSCROLL, 8, 0);
        if (GetKeyState(VK_CONTROL) < 0) then
        begin
          exTopLine := syndtNzisResp.TopLine;
          syndtNzisResp.Font.Size := syndtNzisResp.Font.Size + 1;
          syndtNzisResp.TopLine := exTopLine;
        end;
      end;

      Handled := True;
    end;

  end
  else
  if Msg.Message = WM_KEYDOWN then
  begin
    p := fmxCntrRoleBar.ScreenToClient(Mouse.CursorPos);
    if PtInRect(fmxCntrRoleBar.ClientRect, p)  then
    begin
      if fmxCntrRoleBar.Width > FmxRoleBar.WidthBarClosed then
      begin
        FmxRoleBar.lytRoleBarMouseLeave(nil);
        mmoTest.Lines.Add('kontrol');
      end
      else
      begin
        FmxRoleBar.lytPadingMouseEnter(nil);
      end;
      Handled := false;
    end;
  end
  else
  if Msg.Message = WM_RBUTTONUP then
  begin
    p := grdSearch.ScreenToClient(Mouse.CursorPos);
    if PtInRect(grdSearch.ClientRect, p) then
    begin
      ACol := grdSearch.Header.Columns.FindAt(p.X, 1000);
      ACol.Header.Format.Brush.Color := clRed;
      ACol.Header.Format.Brush.Visible := True;
      ACol.Header.ParentFormat := False;
      pmGrdSearch.Popup(Mouse.CursorPos.X, Mouse.CursorPos.y);

      //ACol.Header.pa

      Handled := True;
    end
    else
      Handled := False;
  end
  else
  if Msg.Message = WM_RBUTTONDOWN then
  begin
    p := grdSearch.ScreenToClient(Mouse.CursorPos);
    if PtInRect(grdSearch.ClientRect, p) then
      Handled := True
    else
      Handled := False;
  end
  else
  if Msg.Message = WM_MOUSEMOVE then
  begin
    if (thrSearch <> nil) and thrSearch.IsSorting then
    begin
      p := grdSearch.ScreenToClient(Mouse.CursorPos);
      if PtInRect(grdSearch.ClientRect, p) then
        Handled := True
      else

    end
    else
    begin
      Handled := False;
    end;
  end
  //else
//  if Msg.Message = WM_MOUSEACTIVATE then
//  begin
//    if grdSearch.MouseInClient then // and (not grdSearch.Focused) then
//      Handled := True
//    else
//      Handled := False;
//  end;

end;

procedure TfrmSuperHip.appEvntsMainShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if (Msg.CharCode = Ord('F')) and (GetKeyState(VK_CONTROL) < 0) then
  begin
    StartFinder;
    Exit;
  end;
  if (Msg.CharCode = Ord('S')) and (GetKeyState(VK_CONTROL) < 0) then
  begin
    StartInserter;
    Exit;
  end;
  if (Msg.CharCode = VK_F1) and (GetKeyState(VK_CONTROL) < 0) then
  begin
    if hntMain.ShowingHint then
    begin
      hntMain.HideHint;
      pgcWork.ActivePage := tsRTF;
    end
    else
    begin
      SendMessage(Handle, WM_SYSCOMMAND, SC_CONTEXTHELP, 0);
    end;
    Exit;
  end;

end;

procedure TfrmSuperHip.appEvntsMainShowHint(var HintStr: string;
  var CanShow: Boolean; var HintInfo: THintInfo);
begin
  //
end;

procedure TfrmSuperHip.NzisNomenClick(Sender: TObject);
begin

  pgcTree.ActivePage := tsNomenNzis;
  ActiveMainButton := TRoleButton(Sender);
  ActiveSubButton := nil;
  //OpenBufNomenNzis('NzisNomen.adb');
  if vRootNzisBiznes.ChildCount = 0 then
  begin

  end
  else
  begin
    //vtrNomenNzis.DeleteChildren(vRootNzisBiznes);
  end;
  LoadVtrNomenNzis2;
end;

procedure TfrmSuperHip.NzisOnSended(Sender: TObject);
var
  thr: TNzisThread;
begin
  thr := TNzisThread(Sender);
  if thr.node <> nil then
    postMessage(Self.Handle, WM_SENDED_NZIS, Integer(thr.node), 0)
  else
  begin

  end;
end;

procedure TfrmSuperHip.SubButtonNomenExcelClick(Sender: TObject);
begin
  if TRoleButton(Sender).Down then
  begin
    //pgcWork.ActivePage := tsExcel;
    InternalChangeWorkPage(tsExcel);
    ActiveSubButton := TRoleButton(Sender);
    OpenExcels;
  end
  else
  begin
    InternalChangeWorkPage(nil);
    //pgcWork.ActivePage := nil;// zzzzzzzzzzzzzz  може да покаже на главния бутон
    ActiveSubButton := nil;
  end;
end;

procedure TfrmSuperHip.SubButtonNomenXMLClick(Sender: TObject);
begin
  pnlRoleView.ForceClose;
  if TRoleButton(Sender).Down then
  begin
    //pgcWork.ActivePage := tsGrid;
    InternalChangeWorkPage(tsGrid);
    ActiveSubButton := TRoleButton(Sender);
  end
  else
  begin
    InternalChangeWorkPage(nil);
    //pgcWork.ActivePage := nil;// zzzzzzzzzzzzzz  може да покаже на главния бутон
    ActiveSubButton := nil;
  end;
end;

procedure TfrmSuperHip.syndtNzisReqMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //ReleaseCapture;
  //SendMessage(self.Handle, WM_SYSCOMMAND, 61458, 0) ;
  //SetCapture( syndtNzisReq.Handle );
  //syndtNzisReq.MouseCapture:= true;  // WinApi: SetCapture( Handle )
end;

procedure TfrmSuperHip.syndtNzisReqMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //ReleaseCapture;
end;


procedure TfrmSuperHip.StartAspectPerformerThread;
begin
  thrAspPerf := TAspectPerformerThread.Create(true);
  thrAspPerf.FreeOnTerminate := True;
  thrAspPerf.FCmdADB := streamCmdFile;
  thrAspPerf.FCmdNzisNomen := streamCmdFileNomenNzis;
  thrAspPerf.AspectsNomFile := AspectsNomFile;
  thrAspPerf.Resume;
end;

procedure TfrmSuperHip.StartCertThread;
begin
  if option.LibTokenDll = '' then Exit;
  if not FileExists(option.LibTokenDll) then Exit;

  usb := TComponentUSB.Create(self);
  usb.OnUSBArrival := DoUSBArrival;
  usb.OnUSBRemove := DoUSBRemove;
  thrCert := TCertThread.Create(true);
  thrCert.StorageFilename := option.LibTokenDll;
  thrCert.CollDoctor := ADB_DM.CollDoctor;
  thrCert.CollCert := ADB_DM.CollCertificates;
  thrCert.FreeOnTerminate := True;
  thrCert.OnStorageUpdate := CertStorageUpdate;
  thrCert.Resume;
  tmpVtr.thrCert := thrCert;
end;

procedure TfrmSuperHip.StartFinder;
var
  i: Integer;
  str: string;
  len: Word;
  //FV: TFilterValues;

  linkPos: Cardinal;
  pCardinalData: ^Cardinal;
  FPosLinkData: Cardinal;
  node: PVirtualNode;
  data: PAspRec;
  PAnsBuf, PAnsFind: PAnsiChar;
  ss: TPregledNewItem.TPropertyIndex;
begin
  InternalChangeTreePage(tsVtrSearch);
  Exit;

  if FmxFinderFrm = nil then
  begin
    FmxFinderFrm := TfrmFinder.Create(nil);
    ADB_DM.CollPatient.AddItemForSearch;
    ADB_DM.CollPregled.AddItemForSearch;
    FmxFinderFrm.CollPatient := ADB_DM.CollPatient;
    FmxFinderFrm.CollPregled := ADB_DM.CollPregled;

    FmxFinderFrm.ArrCondition := ADB_DM.CollPregled.ListForFinder.Items[0].ArrCondition;
    FmxFinderFrm.AddExpanderPat1(0, nil);
    FmxFinderFrm.AddExpanderPreg1(0, nil);
    FmxFinderFrm.RecalcBlanka;

    FmxFinderFrm.OnShow := OnShowFindFprm;
  end;
  //if vtrSearch.RootNodeCount < 1 then
//    LoadVtrSearch;
//  CollPatient.ListForFinder.Clear;

  InternalChangeWorkPage(tsFMXForm);


  fmxCntrDyn.ChangeActiveForm(FmxFinderFrm);
  FmxFinderFrm.WindowState := wsMaximized;
  //FmxFinderFrm.Height := 10000;
  if not Assigned(thrSearch) then
  begin

    //CollPregled.IndexValue(PregledNew_ANAMN); // за забързване на търсенето (предизвиква операционната система да кешира ...)
    //CollPregled.Clear;

    //CollPregled.ArrPropSearch := [PregledNew_AMB_LISTN, PregledNew_NRN, PregledNew_ANAMN];

    thrSearch := TSearchThread.Create(true);
    FmxFinderFrm.thrSearch := thrSearch;
    thrSearch.CollForFind := ADB_DM.CollPregled;

    thrSearch.vtr := vtrPregledPat;
    thrSearch.bufLink := AspectsLinkPatPregFile.Buf;
    //thrSearch.BufADB := Adb_DM.AdbMain;
    pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
    FPosLinkData := pCardinalData^;
    //thrSearch.FPosData := FPosLinkData;
    //thrSearch.BufADB := AspectsHipFile.Buf;


    thrSearch.grdSearch := grdSearch;
    thrSearch.OnShowGrid := OnShowGridSearch;
    grdSearch.Tag := cardinal(ADB_DM.CollPregled);



    thrSearch.CntPregInPat := -1;
    if vtrSearch.GetFirstSelected() <> nil then
    begin
      thrSearch.AdbRoot := vtrPregledPat.RootNode.FirstChild;
      thrSearch.FilterRoot := vtrSearch.GetFirstSelected();
    end
    else
    begin
      InternalChangeTreePage(tsVtrSearch);
      Exit;
    end;
    thrSearch.Resume;
    thrSearch.Start;

  end
  else
  begin
    if vtrSearch.GetFirstSelected() <> nil then
    begin
      thrSearch.AdbRoot := vtrPregledPat.RootNode.FirstChild;
      thrSearch.FilterRoot := vtrSearch.GetFirstSelected();
    end
    else
    begin

      InternalChangeTreePage(tsVtrSearch);
      Exit;
    end;
    thrSearch.Start;
  end;
  FmxFinderFrm.IsFinding := True;
  //btnPull.Top := pnlGridSearch.Top - 7 - btnPull.Height;
  if pnlGridSearch.height = 1 then
    pnlGridSearch.height := 150;
 //pgcWork.ActivePage := tsFMXForm;
   tlb1.Realign;

end;

procedure TfrmSuperHip.StartHistoryThread(dbName: string);
//var

begin
  //Exit;
  thrHistPerf := THistoryThread.Create(True, FdbName);
  thrHistPerf.FCollPatient.NasMesto := FNasMesto;
  thrHistPerf.FreeOnTerminate := True;
  thrHistPerf.Buf := Adb_DM.AdbMain.Buf;
  thrHistPerf.BufLink := AspectsLinkPatPregFile.Buf;
  thrHistPerf.DataPos := Adb_DM.AdbMain.FPosData;
  thrHistPerf.FCollUnfav := ADB_DM.CollUnfav;
  thrHistPerf.FCollPregled := ADB_DM.CollPregled;
  thrHistPerf.FCollDoctor := ADB_DM.CollDoctor;
  //thrHistPerf.FCollPatient := CollPatient;
  thrHistPerf.FCollDiag := ADB_DM.CollDiag;
  thrHistPerf.GUID := Adb_DM.AdbMain.GUID;
  thrHistPerf.FVTR := vtrPregledPat;
  thrHistPerf.OnEventAlert := RefreshEvent;
  thrHistPerf.OnDeleteEvent := DeleteEvent;

  thrHistPerf.OnIndexedPregled := OnIndexedPregled;
  thrHistPerf.cmdFile := streamCmdFile;
  thrHistPerf.FDBHelper := FDBHelper;
  //thrHistDb.OnTerminate := TerminateLoadDB;
  thrHistPerf.Resume;
end;

procedure TfrmSuperHip.StartInserter;
var
  i, j, k: Integer;
  dataPreg, dataPat, dataRun, dataAnal, dataDoctor: PAspRec;
  Run, RunMdn, runAnal, runPat, runDoctor: PVirtualNode;
  linkPos: Cardinal;
  preg: TRealPregledNewItem;
  pat: TRealPatientNewItem;
  diag: TRealDiagnosisItem;
  mdn: TRealMDNItem;
  anal: TRealExamAnalysisItem;
  doctor: TRealDoctorItem;
  PosInNomen: Cardinal;
  cl22Code: string;

  
begin
  StartSaver;
  if chkAutamatNzis.Checked then
  begin
    FmxProfForm.rctNzisBTNClick(nil);
  end;

  Exit;
  pat := TRealPatientNewItem.Create(nil);
  doctor := TRealDoctorItem.Create(nil);
  for i := ADB_DM.ListPregledLinkForInsert.Count - 1 downto 0 do
  begin
    Run := ADB_DM.ListPregledLinkForInsert[i]; //прегледа
    runPat := Run.Parent;
    runDoctor := runPat.FirstChild;
    while runDoctor <> nil do
    begin
      dataDoctor := pointer(PByte(runDoctor) + lenNode);
      case dataDoctor.vid of
        vvDoctor:
        begin
          doctor.DataPos := dataDoctor.DataPos;
          Break;
        end;
      end;
      runDoctor := runDoctor.NextSibling;
    end;
    //vtrPregledPat.Selected[Run] := True;
    //vtrPregledPat.FocusedNode := Run;
    dataPreg := pointer(PByte(Run) + lenNode);
    //mmoTest.Lines.Add(format('dataPreg.DataPos = %d', [dataPreg.DataPos]));
    preg := ADB_DM.CollPregled.GetItemsFromDataPos(dataPreg.DataPos);// трябва да е тука някъде;
    if preg = nil then //  може да е останал не записан стар
    begin
     // preg := TRealPregledNewItem.Create(nil);
      preg := TRealPregledNewItem(ADB_DM.CollPregled.Add);
      preg.DataPos := dataPreg.DataPos;
      dataPreg.index :=ADB_DM. CollPregled.Count - 1;
    end;
    preg.PregledID := preg.getIntMap(Adb_DM.AdbMain.Buf, ADB_DM.CollPatient.posData, word(PregledNew_ID));
    if preg.PregledID <> 0 then Exit;//  има го в базата

    dataPat := pointer(PByte(RunPat) + lenNode); // пациента

    pat.DataPos := dataPat.DataPos;
    preg.Fpatient := pat;
    preg.FDoctor := doctor;
    RunMdn := Run.FirstChild;// ще търся какво има в прегледа (диагнози, мдн-та...)
    while RunMdn <> nil do
    begin
      dataRun :=  pointer(PByte(RunMdn) + lenNode); // нещата в прегледа
      case dataRun.vid of
        vvDiag:
        begin
          //diag := TRealDiagnosisItem.Create(nil);   // нещо си ги има zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
//          diag.DataPos := dataRun.DataPos;
//          preg.FDiagnosis.Add(diag);
        end;
        vvMDN:
        begin
          mdn := TRealMDNItem.Create(nil);
          mdn.DataPos := dataRun.DataPos;
          mmoTest.Lines.Add(format('mdn.DataPos = %d', [mdn.DataPos]));
          mdn.FPregled := preg;
          preg.FMdns.Add(mdn);
          runAnal := RunMdn.FirstChild; // изследванията в мдн-то
          while runAnal <> nil do
          begin
            dataAnal := pointer(PByte(runAnal) + lenNode);
            case dataAnal.vid of
              vvExamAnal:
              begin
                anal := TRealExamAnalysisItem.Create(nil);
                anal.DataPos := dataAnal.DataPos;
                mmoTest.Lines.Add(format('anal.DataPos = %d', [anal.DataPos]));
                cl22Code := Anal.getAnsiStringMap(Adb_DM.AdbMain.Buf, Adb_DM.AdbMain.FPosData, word(ExamAnalysis_NZIS_CODE_CL22));
                PosInNomen := Anal.getCardMap(Adb_DM.AdbMain.Buf, Adb_DM.AdbMain.FPosData, word(ExamAnalysis_PosDataNomen));
                mdn.FExamAnals.Add(anal);
              end;
            end;
            runAnal := runAnal.NextSibling;
          end;
        end;
        //vvNZIS_PLANNED_TYPE:
//        begin
//          nodePlan := RunMdn;
//          dataPlan := Pointer(PByte(nodePlan) + lenNode);
//          cl132Key := CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
//          cl132pos := CollNZIS_PLANNED_TYPE.getCardMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_DataPos));
//          cl136Key := CL132Coll.getAnsiStringMap(cl132pos, word(CL132_CL136_Mapping));
//          if cl136Key <> '2' then Continue;
//
//          mdn := TRealMDNItem.Create(nil);
//          mdn.DataPos := dataRun.DataPos;
//          mmoTest.Lines.Add(format('mdn.DataPos = %d', [mdn.DataPos]));
//          mdn.FPregled := preg;
//          preg.FMdns.Add(mdn);
//          runAnal := RunMdn.FirstChild; // изследванията в мдн-то
//          while runAnal <> nil do
//          begin
//            dataAnal := pointer(PByte(runAnal) + lenNode);
//            case dataAnal.vid of
//              vvExamAnal:
//              begin
//                anal := TRealExamAnalysisItem.Create(nil);
//                anal.DataPos := dataAnal.DataPos;
//                mmoTest.Lines.Add(format('anal.DataPos = %d', [anal.DataPos]));
//                cl22Code := Anal.getAnsiStringMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, word(ExamAnalysis_NZIS_CODE_CL22));
//                PosInNomen := Anal.getCardMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, word(ExamAnalysis_PosDataNomen));
//                mdn.FExamAnals.Add(anal);
//              end;
//            end;
//            runAnal := runAnal.NextSibling;
//          end;
//        end;
      end;
      RunMdn := RunMdn.NextSibling;
    end;
    try
      FDBHelper.SavePregledFDB(preg, Fdm.ibsqlCommand);
      ADB_DM.ListPregledLinkForInsert.Delete(i);
      for j := preg.FMdns.Count - 1 downto 0  do
      begin
        mdn := preg.FMdns[j];
        mdn.PregledID := preg.PregledID;
        mdn.FPregled := preg;
        FDBHelper.SaveMdn(mdn, Fdm.ibsqlCommand);
        for k :=  mdn.FExamAnals.Count - 1 downto 0 do
        begin
          anal := mdn.FExamAnals[k];
          anal.FMdn := mdn;
          FDBHelper.SaveExamAnals(anal, Fdm.ibsqlCommand);
          mdn.FExamAnals.Delete(k);
        end;
        preg.FMdns.Delete(j);
      end;
    finally

    end;
  end;
  FreeAndNil(pat);
end;

procedure TfrmSuperHip.StartSaver;
var
  i, j: Integer;
  doc: TRealDoctorItem;
  cl132: TRealCl132Item;
  mdn: TRealMDNItem;
  cert: TCertificatesItem;
  anal: TRealExamAnalysisItem;
  pat: TRealPatientNewItem;
  answVal: TRealNZIS_ANSWER_VALUEItem;
  resVal: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  cnt: Integer;

  p: PCardinal;
  ofset: Cardinal;
  dataPatRevision: PAspRec;
begin
  ADB_DM.CollDoctor.UpdateDoctors;
  ADB_DM.CollPregled.UpdatePregledi;
  ADB_DM.CollMkb.UpdateMkb;
  ADB_DM.CL132Coll.UpdateCL132;
  ADB_DM.CollNZIS_ANSWER_VALUE.UpdateNZIS_ANSWER_VALUEs;
  ADB_DM.CollNzis_RESULT_DIAGNOSTIC_REPORT.UpdateRESULT_DIAGNOSTIC_REPORT;

  cnt := 0;
  pCardinalData := pointer(PByte(Adb_DM.AdbMain.Buf) + 12);
  dataPosition := pCardinalData^ + self.Adb_DM.AdbMain.FPosData;
  //cert
  for i := 0 to ADB_DM.CollCertificates.Count - 1 do
  begin
    cert := ADB_DM.CollCertificates.Items[i];
    if cert.PRecord <> nil then
    begin
      cert.SaveCertificates(dataPosition);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Adb_DM.AdbMain.Buf) + 12);
    pCardinalData^  := dataPosition - Adb_DM.AdbMain.FPosData;
  end;

  cnt := 0;
  pCardinalData := pointer(PByte(Adb_DM.AdbMain.Buf) + 12);
  dataPosition := pCardinalData^ + Adb_DM.AdbMain.FPosData;
  //мдн
  for i := 0 to ADB_DM.CollMDN.Count - 1 do
  begin
    mdn := ADB_DM.CollMDN.Items[i];
    if mdn.PRecord <> nil then
    begin
      mdn.SaveMDN(dataPosition);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Adb_DM.AdbMain.Buf) + 12);
    pCardinalData^  := dataPosition - Adb_DM.AdbMain.FPosData;
  end;

  pCardinalData := pointer(PByte(Adb_DM.AdbMain.Buf) + 12);
  dataPosition := pCardinalData^ + Adb_DM.AdbMain.FPosData;
  //Изследвания
  for i := 0 to ADB_DM.CollExamAnal.Count - 1 do
  begin
    anal := ADB_DM.CollExamAnal.Items[i];
    if anal.PRecord <> nil then
    begin
      if anal.DataPos > 0 then
      begin
        anal.SaveExamAnalysis(dataPosition);
      end
      else
      begin
        anal.InsertExamAnalysis;
        Dispose(anal.PRecord);
        anal.PRecord := nil;
      end;
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Adb_DM.AdbMain.Buf) + 12);
    pCardinalData^  := dataPosition - Adb_DM.AdbMain.FPosData;
  end;

  pCardinalData := pointer(PByte(Adb_DM.AdbMain.Buf) + 12);
  dataPosition := pCardinalData^ + Adb_DM.AdbMain.FPosData;

  //пациенти
  for i := 0 to ADB_DM.CollPatient.Count - 1 do
  begin
    pat := ADB_DM.CollPatient.Items[i];
    if pat.PRecord <> nil then
    begin
      if pat.DataPos > 0 then
      begin
        pat.SavePatientNew(dataPosition);
        //for j := 0 to pat.Revisions.Count - 1 do
//        begin
//          p := pointer(PByte(CollPatient.buf) + (pat.DataPos  + 4*word(PatientNew_FNAME)));
//          ofset := p^ + CollPatient.posData;
//          dataPatRevision := Pointer(PByte(pat.Revisions[j].node) + lenNode);
//          dataPatRevision.index := ofset;
//        end;
//        pat.Revisions.Clear;
      end
      else
      begin
        pat.InsertPatientNew;
        Dispose(pat.PRecord);
        pat.PRecord := nil;
      end;
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(Adb_DM.AdbMain.Buf) + 12);
    pCardinalData^  := dataPosition - Adb_DM.AdbMain.FPosData;
  end;

  btnSaveAll.Enabled := False;
end;

procedure TfrmSuperHip.StatePatLogChange(Sender: TObject);
var
  pat: TPatientNewItem;
begin
  Stopwatch := TStopwatch.StartNew;
  pat := ADB_DM.CollPatient.ListForFinder[0];
  //if (not chk.IsNull) and (chk.IsChecked) then
//  begin
//    Include(pat.PRecord.Logical, TLogicalPatientNew(chk.IndexLog));
//  end
//  else
//  begin
//    Exclude(pat.PRecord.Logical, TLogicalPatientNew(chk.IndexLog));
//  end;
  Caption := pat.Logical40ToStr(TLogicalData40(pat.PRecord.Logical));
  if pat.PRecord.Logical <> [] then
  begin
    include(ADB_DM.CollPatient.PRecordSearch.setProp, TPatientNewItem.TPropertyIndex.PatientNew_Logical);
  end
  else
  begin
    Exclude(ADB_DM.CollPatient.PRecordSearch.setProp, TPatientNewItem.TPropertyIndex.PatientNew_Logical);
  end;
  ADB_DM.CollPatient.OnSetTextSearchLog(pat.PRecord.Logical);
  thrSearch.start;

end;

procedure TfrmSuperHip.TerminateLoadDB(Sender: TObject);
begin
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('зареждане от ДБ: %f', [Elapsed.TotalMilliseconds]));
  PostMessage(Self.Handle, WM_AFTER_LOAD_DB, 0, 0);

end;

procedure TfrmSuperHip.TerminateNzisX000(Sender: TObject);
//var
  //thrdSender: TSenderThread;
begin
  //thrdSender := TSenderThread(Sender);
  //SendMessage(AmbListHandle, WM_CANCEL_USER, 1, 0); //zzzzzzzzz
end;

procedure TfrmSuperHip.DumpAdbPathIndex;
var
  Keys: TArray<UInt64>;
  i, j: Integer;
  Key: UInt64;
  Bucket: TList<PVirtualNode>;
  Data: PAspRec;
begin
  mmoTest.Lines.BeginUpdate;
  try
    Keys := AspectsLinkPatPregFile.PathIndex.Keys.ToArray;

    mmoTest.Lines.Add('--- Dump PathIndex ---');
    for i := 0 to High(Keys) do
    begin
      Key := Keys[i];
      if AspectsLinkPatPregFile.PathIndex.TryGetValue(Key, Bucket) then
      begin
        mmoTest.Lines.Add(Format('Sig %d -> %d nodes', [Key, Bucket.Count]));
        if mmoTest.Lines.Count > 10000 then  Exit;

        for j := 0 to Bucket.Count - 1 do
        begin
          Data := PAspRec(PByte(Bucket[j]) + Lennode);
          if True then
          if j > 500 then  Continue;

          mmoTest.Lines.Add(
            Format('   [%d] node=%p vid=%s index=%d',
              [ j,
                Bucket[j],
                GetEnumName(TypeInfo(TVtrVid), Ord(Data.vid)),
                Bucket[j].Index
              ]
            )
          );
        end;
      end;
    end;
  finally
    mmoTest.Lines.EndUpdate;
  end;
end;


procedure TfrmSuperHip.TestMagicIndex;
var
  FilterMagicIndex: TFilterMagicIndex;
  res:  TList<PVirtualNode>;
  i: Integer;
  aBucket: TList<PVirtualNode>;
   key: UInt64;
begin
  Stopwatch := TStopwatch.StartNew;
  AspectsLinkPatPregFile.BuildPathIndex;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format(' BuildPathIndex  %d за %f',[AspectsLinkPatPregFile.PathIndex.count,  Elapsed.TotalMilliseconds]));
  //DumpAdbPathIndex;

  Stopwatch := TStopwatch.StartNew;
  AspectsFilterLinkFile.BuildPathIndex;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format(' BuildPathIndex  %d за %f',[AspectsFilterLinkFile.PathIndex.count,  Elapsed.TotalMilliseconds]));

  for key in AspectsLinkPatPregFile.PathIndex.Keys do
    mmoTest.Lines.Add(Format('ADB KEY = %d', [key]));

  for key in AspectsFilterLinkFile.PathIndex.Keys do
    mmoTest.Lines.Add(Format('FILTER KEY = %d', [key]));


end;


procedure TfrmSuperHip.TestMagicIndex1;
var
  key: UInt64;
begin
  LoadLinkFilter;

  Stopwatch := TStopwatch.StartNew;
  AspectsLinkPatPregFile.BuildPathIndex;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format(' BuildPathIndex  %d за %f',[AspectsLinkPatPregFile.PathIndex.count,  Elapsed.TotalMilliseconds]));
  //DumpAdbPathIndex;

  Stopwatch := TStopwatch.StartNew;
  AspectsFilterLinkFile.BuildPathIndex;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format(' BuildPathIndex  %d за %f',[AspectsFilterLinkFile.PathIndex.count,  Elapsed.TotalMilliseconds]));

  for key in AspectsLinkPatPregFile.PathIndex.Keys do
    mmoTest.Lines.Add(Format('ADB KEY = %d', [key]));

  for key in AspectsFilterLinkFile.PathIndex.Keys do
    mmoTest.Lines.Add(Format('FILTER KEY = %d', [key]));

  AspectsLinkPatPregFile.FFilterLink := AspectsFilterLinkFile;
  AspectsLinkPatPregFile.JoinWith(AspectsFilterLinkFile);
end;


procedure TfrmSuperHip.mniImportNzisClick(Sender: TObject);
var
  fileName: string;
begin
  if dlgOpenNZIS.Execute then
  begin
    fileName := dlgOpenNZIS.FileName;
    FmxTitleBar.p1.IsOpen := False;
    ImpNzis := TNzisImport.create;
    impNzis.VtrImport := vtrTemp;
    impNzis.mmoTest := mmoTest;
    impNzis.FmxRoleBar := FmxRoleBar;
    impNzis.AspectsHipFile := Adb_DM.AdbMain;
    impNzis.AspectsLinkPatPregFile := AspectsLinkPatPregFile;
    impNzis.CollOtherDoctor := ADB_DM.CollOtherDoctor;
    impNzis.syndtNzisReq := syndtNzisReq;
    impNzis.syndtNzisResp := syndtNzisResp;
    impNzis.FmxImportNzisFrm := FmxImportNzisFrm;
    impNzis.fmxCntrDyn := fmxCntrDyn;
    impNzis.tsFMXForm := tsFMXForm;
    impNzis.ProcChangeWorkTS := InternalChangeWorkPage;
    impNzis.ProcAddNewPat := Adb_DM.AddNewImportNzisPat;
    impNzis.NasMesto := FNasMesto;
    impNzis.CollPractica := ADB_DM.CollPractica;
    impNzis.CollDoctor := ADB_DM.CollDoctor;
    impNzis.Adb_DM := Adb_DM;
    Adb_DM.CollMkb := ADB_DM.CollMkb;

    ImpNzis.ImportNzis(fileName);
    ImpNzis.LoopPat;

    pgcTree.ActivePage := tsTempVTR;
    pnlNzisMessages.Visible := True;
    pnlNzisMessages.Height := pnlWork.Height - 30;
    pnlTree.Width := 580;
  end;


  //Exit;
//  nzisXml := TNzisXMLHelper.Create;
//  vtrTemp.DefaultNodeHeight := 30;
//  vtrTemp.Header.AutoSizeIndex := 1;
//  vtrTemp.Header.Columns.Items[0].Width := 240;
//  vtrTemp.Header.AutoSizeIndex := 0;
//
//  vtrTemp.Header.Columns.Items[0].Tag := Integer(vvNzisMessages);
//
//
//  FmxTitleBar.p1.IsOpen := False;
//
//  AddNzisImport; // попълва колекцията от msg
//  FillRespInReq;// намира и сдвоява двойките
//  FillADBInMsgColl; // не са само пациентите, а и другите работи. Попълват се колекциите от каквото има в базата
//  FillIncDoctor;
//
//  LoopXml;// определя кое съобщение какво е и му попълва нещата. Попълва списъка със всички нрн-та за прегледи, направления....
//  Delete99; // премахване на двойките със грешка в отговора
//
//
//  FillMsgXXXInPregled;// след това нещо, може да са останали в лстХХХХ такива съобщения, които нямат НРН в базата
//  FillMsgRIncMNInIncMN;// LstRIncMN- списък със всички евентуални входящи направления
//  AddNewPreg;// търсим новите съобщения и попълваме с нови прегледи
//
//
//
//  FillPregInPat;// след това нещо, може да са останали прегледи на пациенти, които ги няма в базата
//  //FillIncMnInPatImport;// след това нещо, може да са останали прегледи на пациенти, които ги няма в базата
//  AddNewPatXXX;// търсим новите
//  // като имам всички прегледи сега трябва да намеря кои входящи направления са взети от лекаря. Трябва да е по басе-то
//  FillPregledInIncMN;
//
//  FillMsgRMdnInMdn; // попълва старите, които са в базата
//  AddNewMdn;
//  FillReferalMdnInPreg; // мдн-тата в прегледите
//
//
//  LoadTempVtrMSG4;
//
//  pgcTree.ActivePage := tsTempVTR;
//  pnlNzisMessages.Visible := True;
//  pnlNzisMessages.Height := pnlWork.Height - 30;
//  pnlTree.Width := 580;


end;



procedure TfrmSuperHip.TitleSetingsClick(Sender: TObject);
begin
  pgcTree.ActivePage := tsLinkOptions;
  ShowOptionsFMX;
end;

procedure TfrmSuperHip.tlbActionsClick(Sender: TObject);
begin
  //CheckCollForSave;
end;

procedure TfrmSuperHip.tmr1Timer(Sender: TObject);
begin
  Exit;
  if not Self.Visible then Exit;

  tmr1.Enabled := False;
  FmxTitleBar.ActivateTitleBar(Self.Handle = GetForegroundWindow);
end;

procedure TfrmSuperHip.tmrHipTimer(Sender: TObject);
begin
  tmrHip.Enabled := False;
  if (HipHandle <> 0)  then
  begin
    if not (PostMessage(HipHandle, WM_Super_Check, 0, 0)) then
    begin
      Close;
      Exit;
    end;
  end;
  tmrHip.Enabled := true;
end;

procedure TfrmSuperHip.ToolButton5Click(Sender: TObject);
var
  pcardinaldata: PCardinal;
  dataposition: Cardinal;
  mn: TRealBLANKA_MED_NAPRItem;
begin

  mn := FmxProfForm.Pregled.FMNs[0];
  mn.Collection := ADB_DM.CollMedNapr;
  pCardinalData := pointer(PByte(Adb_DM.AdbMain.Buf) + 12);
  dataPosition := pCardinalData^ + Adb_DM.AdbMain.FPosData;
  New(mn.PRecord);
  mn.PRecord.setProp := [BLANKA_MED_NAPR_SpecDataPos];
  mn.PRecord.SpecDataPos := 444;
  mn.SaveBLANKA_MED_NAPR(dataPosition);
  pCardinalData := pointer(PByte(Adb_DM.AdbMain.Buf) + 12);
  pCardinalData^  := dataPosition - Adb_DM.AdbMain.FPosData;
end;

procedure TfrmSuperHip.treeviewGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TSuperNodeCL009);
end;

procedure TfrmSuperHip.tsFMXFormMouseEnter(Sender: TObject);
begin
  //
end;

procedure TfrmSuperHip.tsFMXFormResize(Sender: TObject);
begin
  //Exit;
  splSearchGridMoved(nil);
  //fmxCntrDyn.Repaint;
end;

procedure TfrmSuperHip.tsHtmlShow(Sender: TObject);
begin

  //if GlobalWebView2Loader.InitializationError then
//    showmessage(GlobalWebView2Loader.ErrorMessage)
//   else
//    if GlobalWebView2Loader.Initialized then
//      WVBrowser1.CreateBrowser(WVWindowParent1.Handle);
     //else
      //Timer1.Enabled := True;

  //WVBrowser1.NavigateToString(
//        '<html>' + #13#10 +
//        '<head><title>401 Authorization Required</title></head>' + #13#10 +
//        '<body>' + #13#10 +
//        '<center><h1>401 Authorization Required</h1></center>' + #13#10 +
//        '<hr><center>openresty</center>' + #13#10 +
//        '</body>' + #13#10 +
//        '</html>');
end;

procedure TfrmSuperHip.tsRoleDescrShow(Sender: TObject);
begin
  if vtrHelpHip.TotalCount = 0 then
  begin
    unzipRTFHelp('HelpRTF.zip');
  end;
end;

procedure TfrmSuperHip.tsTreePatShow(Sender: TObject);
begin
  if vtrPregledPat.TotalCount > 0 then
    vtrPregledPat.ValidateNode(vtrPregledPat.RootNode.FirstChild.FirstChild,True);
end;

procedure TfrmSuperHip.tsVideoHide(Sender: TObject);
begin
  MPHip.controls.stop;
  //MPHip.set
end;

procedure TfrmSuperHip.tsVideoShow(Sender: TObject);
begin
  MPHip.URL := 'https://download.kontrax.bg/temp/Biser/Hippocrates360_OcB7PJMaWK.mp4';
 // MPHip.URL := 'https://download.kontrax.bg/hippocrates/download/video/e-Pregled_S.mp4';
  MPHip.controls.play;
end;

procedure TfrmSuperHip.unzipRTFHelp(zipFile: string);
var

  i: integer;
begin
  Stopwatch := TStopwatch.StartNew;
  try
    try
      DownloadedStream := TFileStream.Create(zipFile, fmOpenRead);
      AZipHelpFile.Open(DownloadedStream, zmRead);
      vtrHelpHip.BeginUpdate;
      for i := 0 to AZipHelpFile.FileCount - 1 do
      begin
        vtrHelpHip.AddChild(nil, nil);
      end;
    finally
      vtrHelpHip.FullExpand();
      vtrHelpHip.EndUpdate;
      //DownloadedStream.Free;
    end;
  finally
  end;
  Elapsed := Stopwatch.Elapsed;
  //Caption := Format('rtf: %f', [Elapsed.TotalMilliseconds]);
end;

procedure TfrmSuperHip.UpdateCertificates(certNom: string);
var
  i, j: Integer;
  Cert: TElX509Certificate;
  Buf: ByteArray;
  s, str: string;
  strArr: TArray<string>;
  WinCertStorage: TElWinCertStorage;
begin
  WinCertStorage := TElWinCertStorage.Create(nil);
  WinCertStorage.SystemStores.Text := 'MY';
  for i := 0 to WinCertStorage.Count - 1 do
  begin
    Cert := WinCertStorage.Certificates[i];
    // Serial Number
    Buf := Cert.SerialNumber;
    str := BeautifyBinaryString(BinaryToString(@Buf[0], Length(Buf)), ' ');
    strArr := str.Split([' ']);
    str := '';
    for j := Length(strArr)- 1 downto 0 do
    begin
      str := str + strArr[j];
    end;
    if str = certNom then
    begin
      FCertificate := TElX509Certificate(cert);
      Exit;
    end;
  end;
end;

procedure TfrmSuperHip.UpdateRoot(const root: ISuperObject; Cl000Coll: TCL000EntryCollection);
var
  countNode: Integer;
  counterProces: Integer;
  c: Char;
  i: Integer;
  dataEntry: PSuperNodeCL009;



  procedure ProcessNode(parent: PVirtualNode; const node: ISuperObject; const text: string; id: Integer = -1);
  var
    p: PVirtualNode;
    data: PSuperNodeCL009;
    i: Integer;
    iter: TSuperObjectIter;

  begin
    p := treeview.AddChild(parent);
    data := treeview.GetNodeData(p);
    data.name := text;
    data.obj := node;
    data.index := id;


    include(p.States, vsInitialized);
    case ObjectGetType(node) of
      stObject:
        begin
          include(p.States, vsExpanded);
          if ObjectFindFirst(node, iter) then
          repeat
            ProcessNode(p, iter.val, iter.key, -1);
          until not ObjectFindNext(iter);
          ObjectFindClose(iter);
        end;
      stArray:
        begin
          include(p.States, vsExpanded);
          for i := 0 to node.AsArray.Length - 1 do
          begin
            ProcessNode(p, node.AsArray[i], inttostr(i), i);
          end;
        end;
    end;
  end;

begin
  CurrentID := -1;
  treeview.BeginUpdate;
  try

    treeview.Clear;
    Stopwatch := TStopwatch.StartNew;

    ProcessNode(nil, root, 'root');
    Elapsed := Stopwatch.Elapsed;
    //Memo.Lines.Add(Format('попълнени са в първичната структура %d възела, за %f ms ' ,[treeview.TotalCount, Elapsed.TotalMilliseconds]));
    currentType := cvNone;
    currentIndex := -1;
    Cl000Coll.Clear;
    Cl000Coll.currentType := cvNone;
    Cl000Coll.TV := treeview;
    Stopwatch := TStopwatch.StartNew;
    treeview.IterateSubtree(nil, Cl000Coll.GetNodeXML, nil);
//    btnGetManesClick(nil);
    Elapsed := Stopwatch.Elapsed;
    //Memo.Lines.Add(Format('Обработени са  %d реда, за %f ms ' ,[Cl000Coll.Count, Elapsed.TotalMilliseconds]));
  finally
    treeview.EndUpdate;
  end;
end;

procedure TfrmSuperHip.UpdateUnfav;
var
  i, j: integer;
  doc: TRealDoctorItem;
  unfav: TUnfavItem;
  mnt, yr: word;
begin
  for i := 0 to ADB_DM.CollDoctor.Count - 1 do
  begin
    doc := ADB_DM.CollDoctor.Items[i];
    for j := 0 to doc.FListUnfav.Count - 1 do
    begin
      mnt := (j mod 12) ;
      if mnt = 0 then mnt := 12;
      if (j mod 12) = 0 then
      begin
        yr := (j div 12) + 2023;
      end
      else
      begin
        yr := (j div 12) + 2024;
      end;
      if doc.FListUnfav[j] = nil then
      begin
        if doc.FListUnfavDB[j] = nil then Continue;
        doc.FListUnfavDB[j] := nil;
        fdm.ibsqlCommandUdost.Close;
        fdm.ibsqlCommandUdost.SQL.Text :=
            'delete from unfav  u' + #13#10 +
            'where u.doctor_id_prac = :doctor_id_prac' + #13#10 +
            'and u.year_unfav = :year_unfav' + #13#10 +
            'and u.month_unfav = :month_unfav';
        fdm.ibsqlCommandUdost.ParamByName('doctor_id_prac').AsInteger := doc.DoctorID;
        fdm.ibsqlCommandUdost.ParamByName('year_unfav').AsInteger := yr;
        fdm.ibsqlCommandUdost.ParamByName('month_unfav').AsInteger := mnt;

        fdm.ibsqlCommandUdost.ExecQuery;

        ADB_DM.CollUnfav.DeleteAUnfav(doc.DoctorID, mnt, yr);
      end
      else
      begin
        if doc.FListUnfavDB[j] <> nil then Continue;
        doc.FListUnfavDB[j] := doc.FListUnfav[j];
        fdm.ibsqlCommandUdost.Close;
        fdm.ibsqlCommandUdost.SQL.Text :=
            'UPDATE OR INSERT INTO UNFAV (DOCTOR_ID_PRAC, YEAR_UNFAV, MONTH_UNFAV)' + #13#10 +
            'VALUES (:DOCTOR_ID_PRAC, :YEAR_UNFAV, :MONTH_UNFAV)' + #13#10 +
            'matching (DOCTOR_ID_PRAC, YEAR_UNFAV, MONTH_UNFAV)';


        fdm.ibsqlCommandUdost.ParamByName('doctor_id_prac').AsInteger := doc.DoctorID;
        fdm.ibsqlCommandUdost.ParamByName('year_unfav').AsInteger := yr;
        fdm.ibsqlCommandUdost.ParamByName('month_unfav').AsInteger := mnt;
        fdm.ibsqlCommandUdost.ExecQuery;

        ADB_DM.CollUnfav.InsertAUnfav(doc.DoctorID, mnt, yr);
      end;
    end;
  end;
  fdm.ibsqlCommandUdost.Transaction.CommitRetaining;
end;

procedure TfrmSuperHip.URLClick(Sender: TObject; const URL: string;
  Button: TMouseButton);
begin
//
end;

procedure TfrmSuperHip.vtrSearchButtonClick(sender: TVirtualStringTreeAspect;
  node: PVirtualNode; const numButton: Integer);
var
  data: PAspRec;
  FilterTreeGenerator: TFilterTreeGenerator2;
  FilterRootNode: PVirtualNode;
begin
  if node = nil then  Exit;
  data := pointer(PByte(node) + lenNode);
  case data.vid of
    vvFieldFilter:
    begin
      case numButton of
        0:
        begin
          CreateFieldGroup(node);
        end;
      end;
    end;
    vvRootFilter:
    begin
      case numButton of
        0:
        begin
          Stopwatch := TStopwatch.StartNew;
          try
            FilterTreeGenerator := TFilterTreeGenerator2.Create(vtrPregledPat, vtrSearch, AspectsFilterLinkFile);
            FilterTreeGenerator.OnAddNewNodeFilter := OnAddNewNodeFilter;
            try
              //FilterRootNode := FilterTreeGenerator.CreateFilterItem('testow');
              FilterTreeGenerator.BuildFilterTree;//(vtrPregledPat.RootNode.FirstChild, FilterRootNode);
              vtrSearch.Repaint;
            except
              FreeAndNil(FilterTreeGenerator);
              Exit;
            end;
          finally
            Elapsed := Stopwatch.Elapsed;
            mmoTest.Lines.Add( 'BuildFilterTree ' + FloatToStr(Elapsed.TotalMilliseconds));
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrSearchChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  data: PAspRec;
begin
  if Node = nil then  Exit;

  data := vtrSearch.GetNodeData(node);
  case data.vid of
    vvPatient:
    begin
      FmxFinderFrm.ArrCondition := ADB_DM.CollPatient.ListForFinder.Items[0].ArrCondition;
      FmxFinderFrm.AddExpanderPat1(0, nil);

    end;
    vvPregled:
    begin
      FmxFinderFrm.ArrCondition := ADB_DM.CollPregled.ListForFinder.Items[0].ArrCondition;
      FmxFinderFrm.AddExpanderPreg(0, nil);

    end;
  end;

end;

procedure TfrmSuperHip.vtrSearchDrawButton(sender: TVirtualStringTreeAspect;
  node: PVirtualNode; var ButonVisible: Boolean; const numButton: Integer;
  var imageIndex: Integer);
var
  data, dataParent: PAspRec;
begin
  if node = nil then  Exit;
  data := pointer(PByte(node) + lenNode);
  case data.vid of
    vvRootFilter:
    begin
      case numButton of
        0:
        begin
          ButonVisible := True;
          imageIndex := 55;
        end;
      end;
    end;
    vvFieldFilter:
    begin
      dataParent := pointer(PByte(node.Parent) + lenNode);
      if dataParent.vid <> vvFieldOrGroup then
      begin
        case numButton of
          0:
          begin
            ButonVisible := True;
            imageIndex := 111;
          end;
        end;
      end
      else
      begin
        case numButton of
          0:
          begin
            ButonVisible := True;
            imageIndex := 55;
          end;
          1:
          begin
            ButonVisible := True;
            imageIndex := 47;
          end;
        end;
      end;
    end;
  end;

end;

procedure TfrmSuperHip.vtrSearchGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  data, dataParent: PAspRecFilter;
  coll: TBaseCollection;
  key: UInt64;
  lst: TList<PVirtualNode>;
begin
  data := Pointer(PByte(Node) + lenNode);
  case Column of

    0:
    begin
      case data.vid of
        vvObjectGroup:
        begin
          CellText := 'Участват още...';
        end;
        vvFieldOrGroup:
        begin
          dataParent := Pointer(PByte(Node.Parent) + lenNode);
          coll := GetCollectionByType(Word(dataParent.CollType));
          if coll  <> nil then
            CellText := 'Група: ' + coll.DisplayName(node.Dummy);
        end;
        vvFieldFilter:
        begin
          dataParent := Pointer(PByte(Node.Parent) + lenNode);
          if dataParent.vid = vvFieldOrGroup then
            dataParent := Pointer(PByte(Node.Parent.parent) + lenNode);
          coll := Adb_DM.lstColl[Ord(dataParent.CollType)]; //GetCollectionByType(Word(dataParent.CollType));
          if coll  <> nil then
            CellText := coll.DisplayName(node.Dummy);
        end;
        vvOperator:
          CellText := ConditionToStr(TConditionType(Node.Dummy));
      else
        CellText := CeltextFilterObjectFromVid(Word(data.vid));
      end;

    end;
    1:
    begin
      CellText := TRttiEnumerationType.GetName(data.vid) + ' index = ' + inttostr(Data.index);

    end;
    2:
    begin
        if Data.index > -1 then
        begin
          CellText := TRttiEnumerationType.GetName(data.CollType) + ' br. = ' +
             inttostr(AspectsLinkPatPregFile.JoinResult[Data.index].AdbList.Count);
        end;
    end;
  end;

end;


procedure TfrmSuperHip.vtrSearchShowHintButton(sender: TVirtualStringTreeAspect;
  node: PVirtualNode; const numButton: Integer; r: TRect);
var
  Data: PAspRec;
begin
  Exit;
  if node = nil then
    Exit;
  if sender.IsDisabled[node] then
    Exit;
  data := Pointer(PByte(Node) + lenNode);
  case Data.vid of
    vvRootFilter:
    begin
      case numButton of
        0: hntMain.Description := 'Нов филтър';
      else
        Exit;
      end;
    end;

  end;
  hntMain.Delay := 500;
  hntMain.HideAfter := 3000;
  hntMain.ShowHint(r);
end;

procedure TfrmSuperHip.vtrSincPLGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
   TextType: TVSTTextType; var CellText: string);
var
  data, DataParent, dataPat: PAspRec;
  APat, ACloning: TRealPatientNewItem;
  APreg: TRealPregledNewItem;
  PregledDate: TDate;
begin
  data := Sender.GetNodeData(node);
  case data.vid of
    vvPatientNewRoot:
    begin
      case Column of
        0:
        begin
          case data.index of
            -1: CellText := 'Има го и в двете';
            -2: CellText := 'Има го само в НЗОК';
            -3: CellText := 'Има го само в ХИП';
            -4: CellText := 'Новозаписани';
            -5: CellText := 'Отписани';
            -6: CellText := 'Записани (за отписване)';
          end;
        end;
        1:
        begin
          case data.index of
            -1, -2, -4, -5, -6:
            begin
              CellText := IntToStr(node.ChildCount);
            end;
          end;

        end;


      end;
    end;
    vvCloning:
    begin
      case Column of
        0:
        begin
          CellText := 'cloning';
        end;
      end;
    end;
    vvPregled:
    begin
      DataParent := Sender.GetNodeData(node.Parent);
      case Column of
        0:
        begin
          if DataParent.vid = vvPatient then
          begin
            APat :=  ADB_DM.ACollPatFDB.Items[DataParent.index];
            APreg :=  APat.FPregledi[data.index];
            CellText := 'Pregled patID' + IntToStr(APat.getIntMap(Adb_DM.AdbMain.Buf, ADB_DM.CollPatient.posData, word(PatientNew_ID)));
          end
          else if DataParent.vid = vvCloning then
          begin
            dataPat := Sender.GetNodeData(node.Parent.parent);
            APat :=  ADB_DM.ACollPatFDB.Items[dataPat.index];
            ACloning := APat.FClonings[DataParent.index];
            APreg :=  ACloning.FPregledi[data.index];
            CellText := 'Pregled clonID ' + IntToStr(ACloning.getIntMap(Adb_DM.AdbMain.Buf, ADB_DM.CollPatient.posData, word(PatientNew_ID)));
          end;
        end;
        1:
        begin
         // APreg.DataPos := data.DataPos;
          if DataParent.vid = vvPatient then
          begin
            APat :=  ADB_DM.ACollPatFDB.Items[DataParent.index];
            APreg :=  APat.FPregledi[data.index];
          end
          else if DataParent.vid = vvCloning then
          begin
            dataPat := Sender.GetNodeData(node.Parent.parent);
            APat :=  ADB_DM.ACollPatFDB.Items[dataPat.index];
            ACloning := APat.FClonings[DataParent.index];
            APreg :=  ACloning.FPregledi[data.index];
          end;

          PregledDate := APreg.getDateMap(Adb_DM.AdbMain.Buf, ADB_DM.CollPatient.posData, word(PregledNew_START_DATE));
          CellText := DateTimeToStr(PregledDate);
        end;
      end;
    end;
    vvPatient:
    begin
      case Column of
        0:
        begin
          DataParent := Sender.GetNodeData(node.Parent);
          case DataParent.index of
            -1:
            begin
              CellText := 'ЕГН ' + ADB_DM.CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN));
            end;
            -2:
            begin
              if ADB_DM.CollPatPis.Items[data.index].PatEGN <> '' then
              begin
                CellText := 'ЕГН ' + ADB_DM.CollPatPis.Items[data.index].PatEGN;
              end
              else  if ADB_DM.CollPatPis.Items[data.index].PRecord.LNC <> '' then
              begin
                CellText := 'ЛНЧ ' + ADB_DM.CollPatPis.Items[data.index].PRecord.LNC;
              end
              else  if ADB_DM.CollPatPis.Items[data.index].PRecord.SNN <> '' then
              begin
                CellText := 'SNN ' + ADB_DM.CollPatPis.Items[data.index].PRecord.SNN;
              end;
            end;
            -3, -4, -5, -6:
            begin
              CellText := 'ЕГН ' + ADB_DM.CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN));
            end;
          end;
        end;
        1:
        begin
          DataParent := Sender.GetNodeData(node.Parent);
          case DataParent.index of
            -5: //otpisani
            begin
              CellText := DateToStr(ADB_DM.ACollPatFDB.Items[data.index].DATE_OTPISVANE);
            end;
            -6: //zapisani
            begin
              CellText := DateToStr(ADB_DM.ACollPatFDB.Items[data.index].DATE_ZAPISVANE);
            end;
          end;
        end;
        2:
        begin
          DataParent := Sender.GetNodeData(node.Parent);
          APat := ADB_DM.ACollPatFDB.Items[data.index];
          case DataParent.index of
            -5, -6, -1: //otpisani i zapisani
            begin
              if APat.FPregledi.Count > 0 then
              begin
                CellText := DateToStr(APat.LastPregled.getDateMap(Adb_DM.AdbMain.Buf, ADB_DM.CollPatient.posData, word(PregledNew_START_DATE)));
              end;

              //if APat.FClonings.Count > 0 then
//              begin
//                CellText := ACollPatFDB.Items[data.index].getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_EGN));
//              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrSpisyciAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);

var
  i: integer;
  r: trect;
  data: PNodeRec;
  doctor: TRealDoctorItem;
  indexUnfav: word;
  AColMonth:  Integer;
begin
  if node = nil then exit;
  //Exit;
  data := Sender.GetNodeData(node);
  doctor := ADB_DM.CollDoctor.Items[data.index];
  if Column > 1 then
  begin
    AColMonth := Column - 1;
    r := CellRect;
    r.Inflate(-8, -8);
    indexUnfav := (ADB_DM.CollUnfav.CurrentYear - 2024) * 12 + AColMonth;
    if ADB_DM.CollUnfav.CurrentYear = 2033 then
      ADB_DM.CollUnfav.CurrentYear := 2033;
    if doctor.FListUnfav[indexUnfav] <> nil then
    begin
      if doctor.FListUnfavDB[indexUnfav] = nil then
      begin
        TargetCanvas.Brush.Color := $008C8CFF;
        TargetCanvas.FillRect(CellRect);
      end;
      DrawFrameControl(TargetCanvas.Handle, r, DFC_BUTTON, DFCS_CHECKED);
    end
    else
    begin
      if doctor.FListUnfavDB[indexUnfav] <> nil then
      begin
        TargetCanvas.Brush.Color := $008C8CFF;
        TargetCanvas.FillRect(CellRect);
      end;
      DrawFrameControl(TargetCanvas.Handle, r, DFC_BUTTON, DFCS_INACTIVE);
    end;
  end;
end;

procedure TfrmSuperHip.vtrSpisyciCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  doc1, doc2: TRealDoctorItem;
  data1, data2: PNodeRec;
begin
  if Column <> 0 then Exit;
  data1 := Sender.GetNodeData(Node1);
  data2 := Sender.GetNodeData(Node2);
  doc1 := ADB_DM.CollDoctor.items[data1.index];
  doc2 := ADB_DM.CollDoctor.items[data2.index];
  if doc1.FullName > doc2.FullName then
     Result := 1
  else
  if doc1.FullName < doc2.FullName then
    Result := -1
  else
    Result := 0;
end;

procedure TfrmSuperHip.vtrSpisyciDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string;
  const CellRect: TRect; var DefaultDraw: Boolean);
var
  p: Integer;
  strPred, strSled: string;
  r: TRect;
  FilterText: string;
  DrawFormatPred: cardinal;
  DrawFormatSled: cardinal;
begin
  //Exit;
  DrawFormatPred := DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE or DT_LEFT ;
  DrawFormatSled := DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE or DT_LEFT or DT_END_ELLIPSIS;
  FilterText := FSearchTextSpisyci;
  if AnsiUpperCase(Text).Contains(AnsiUpperCase(FilterText)) then
  begin
    p := AnsiUpperCase(Text).IndexOf((AnsiUpperCase(FilterText)));
    FilterText := Copy(Text, p + 1, length(FSearchTextSpisyci));
    SetBkMode(TargetCanvas.Handle,TRANSPARENT);
    strPred := Copy(Text, 1, p);
    strSled := copy(Text, p+length(FilterText) + 1, length(Text) + 1 -   (p+length(FilterText)));
    TargetCanvas.TextWidth(strPred);
    r := CellRect;
    SetTextColor(TargetCanvas.Handle, clBlack);
    SetBkMode(TargetCanvas.Handle, TRANSPARENT);
    Winapi.Windows.DrawText(TargetCanvas.Handle, PWideChar(Text), Length(Text), r, DrawFormatPred);

    SetTextColor(TargetCanvas.Handle, $00A00000);
    SetBkColor(TargetCanvas.Handle, $007DCFFB);
    SetBkMode(TargetCanvas.Handle, OPAQUE);

    r.Left := r.Left + TargetCanvas.TextWidth(strPred);
    r.Width := TargetCanvas.TextWidth(FilterText);
    Winapi.Windows.DrawText(TargetCanvas.Handle, PWideChar(FilterText), Length(FilterText), r, DrawFormatPred);



    SetTextColor(TargetCanvas.Handle, clBlack);
    SetBkMode(TargetCanvas.Handle, TRANSPARENT);
    r.Offset(r.Width, 0);
    r.Width := TargetCanvas.TextWidth(strSled);

    Winapi.Windows.DrawText(TargetCanvas.Handle, PWideChar(strSled), Length(strSled), r, DrawFormatSled);



    DefaultDraw:= False;
  end;
end;

procedure TfrmSuperHip.vtrSpisyciGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  data: PAspRec;
  doctor: TRealDoctorItem;
begin
  data := Sender.GetNodeData(node);
  case data.vid of
    vvDoctor: //доктор
    begin
      doctor := ADB_DM.CollDoctor.Items[data.index];
      case Column of
        0: CellText := doctor.fullName; //doctor.FName + ' ' + doctor.SName + ' ' + doctor.LName;
        //1: CellText := doctor.specHip;
      end;
    end;

  end;
end;

procedure TfrmSuperHip.vtrSpisyciInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
   Node.States := node.States + [vsMultiline] + [vsHeightMeasured];
end;

procedure TfrmSuperHip.vtrSpisyciMouseEnter(Sender: TObject);
begin
  vtrSpisyci.SetFocus;
end;

procedure TfrmSuperHip.vtrSpisyciNodeClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
var
  data: PNodeRec;
  doctor: TRealDoctorItem;
  indexUnfav: word;
begin
  data := Sender.GetNodeData(HitInfo.HitNode);
  doctor := ADB_DM.CollDoctor.Items[data.index];
  if HitInfo.HitColumn > 1 then
  begin
    indexUnfav := (ADB_DM.CollUnfav.CurrentYear - 2024) * 12 + HitInfo.HitColumn - 1;
    if doctor.FListUnfav[indexUnfav] <> nil then
    begin
      doctor.FListUnfav[indexUnfav] := nil;
    end
    else
    begin
      doctor.FListUnfav[indexUnfav] := TRealUnfavItem.Create(nil);
    end;
    sender.RepaintNode(HitInfo.HitNode);
  end;
  CheckForUpdate;
end;

procedure TfrmSuperHip.vtrTempAfterPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas);
begin
  //
end;

procedure TfrmSuperHip.vtrTempBeforePaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas);
begin
  //
end;

procedure TfrmSuperHip.vtrTempButtonClick(sender: TVirtualStringTreeHipp; node: PVirtualNode; const numButton: Integer);
var
  data, dataZapisan: PAspRec;
  ls: TStringList;
  lsEgn: TStringList;
  xmldoc: IXMLDocument;
  pl: FILE_SUBM_PL.IXMLPracticeType;
  patNovozapisan, patZapisan: TRealPatientNewItem;
  patPL: IXMLPatientType;
  i: Integer;
  ListNodes: TList<PVirtualNode>;

  nodeZapisan: PVirtualNode;

  RunNode: PVirtualNode;
begin
  //Exit;
  data := vtrTemp.GetNodeData(node);


  case data.vid of
    vvPatientNewRoot:
    begin
      case data.index of
        -6:
        begin
          case numButton of
            0:
            begin
              if dlgOpenXML_PL.Execute then
              begin
                xmldoc := TXMLDocument.Create(nil);
                xmldoc.LoadFromFile(dlgOpenXML_PL.FileName);
                ListNodes := tlist<PVirtualNode>.Create;
                pl := FILE_SUBM_PL.GetPractice(xmldoc);
                for i := 0 to pl.Doctor.DoctorsPatient.Count - 1 do
                begin
                  patPL := pl.Doctor.DoctorsPatient.Items[i].Patient;

                  patNovozapisan := TRealPatientNewItem(ADB_DM.ACollNovozapisani.Add);
                  patNovozapisan.DataPos := 0;
                  New(patNovozapisan.PRecord);
                  patNovozapisan.PRecord.setProp := [PatientNew_EGN];
                  patNovozapisan.PRecord.EGN := patPL.IDENTITY.PID;

                  nodeZapisan := vHipZapisani.FirstChild;
                  while nodeZapisan <> nil do
                  begin

                    dataZapisan := sender.GetNodeData(nodeZapisan);
                    if ADB_DM.CollPatient.getAnsiStringMap(dataZapisan.DataPos, word(PatientNew_EGN)) = patNovozapisan.PRecord.EGN then
                    begin
                      ListNodes.Add(nodeZapisan);
                    end;
                    nodeZapisan := nodeZapisan.NextSibling;
                  end;
                end;
                for i := 0 to ListNodes.Count - 1 do
                  sender.MoveTo(ListNodes[i], vHipNovi, amAddChildFirst, false);
                ListNodes.Free;
              end;
            end;
            1:
            begin
              RemontPat;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrTempChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  data, dataPat, dataPreg, dataMdn, dataParent, dataRun: PAspRec;
  msg: TNzisReqRespItem;
  vReq, vResp, run: PVirtualNode;
  pat: TRealPatientNewItem;
  preg: TRealPregledNewItem;
  mdn: TRealMDNItem;
  incMn: TRealINC_NAPRItem;
begin
  //if node = nil then Exit;
//
//  data := vtrTemp.GetNodeData(node);
//
//  case data.vid of
//    vvPregled:
//    begin
//      Stopwatch := TStopwatch.StartNew;
//      InternalChangeWorkPage(tsFMXForm);
//      if FmxImportNzisFrm = nil then
//      begin
//        FmxImportNzisFrm := TfrmImportNzis.Create(nil);
//      end;
//      dataParent := vtrTemp.GetNodeData(node.parent);
//      case dataParent.vid of
//        vvPatient: dataPat := vtrTemp.GetNodeData(node.parent);
//        vvIncMN: dataPat := vtrTemp.GetNodeData(node.parent.parent);
//      end;
//
//      dataPreg := vtrTemp.GetNodeData(node);
//      pat := msgColl.CollPat.Items[dataPat.index];
//
//      preg := pat.FPregledi[dataPreg.index];
//      run := Node.FirstChild;
//      while run <> nil do
//      begin
//        dataRun := vtrTemp.GetNodeData(run);
//        case dataRun.vid of
//          vvNzisMessages:
//          begin
//            msg := TNzisReqRespItem(preg.FLstMsgImportNzis[dataRun.index]);
//            case msg.PRecord.msgNom of
//              1:
//              begin
//                nzisxml.FillX001InPat(msg, pat);
//                Break;
//              end;
//            end;
//          end;
//        end;
//        run := run.NextSibling;
//      end;
//      if pat.DataPos = 0 then
//      begin
//        //pat.PRecord.FNAME := pat.NoteProf
//      end;
//      FmxImportNzisFrm.Pregled := preg;
//      fmxCntrDyn.ChangeActiveForm(FmxImportNzisFrm);
//      Elapsed := Stopwatch.Elapsed;
//      mmoTest.Lines.Add( 'FmxImportNzisFrm ' + FloatToStr(Elapsed.TotalMilliseconds));
//    end;
//    vvIncMN:
//    begin
//      dataPat := vtrTemp.GetNodeData(node.parent);
//      pat := msgColl.CollPat.Items[dataPat.index];
//      incMn := pat.FIncMNs[data.index];
//      msg := TNzisReqRespItem(incMn.msg);
//      syndtNzisReq.Lines.Text := msg.PRecord.REQ;
//      syndtNzisResp.Lines.Text := msg.PRecord.RESP;
//    end;
//    vvNzisMessages:
//    begin
//      dataParent := vtrTemp.GetNodeData(node.parent);
//      case dataParent.vid of
//        vvPregled:
//        begin
//          dataPat := vtrTemp.GetNodeData(node.Parent.parent);
//          if dataPat.vid = vvIncMN then
//            dataPat := vtrTemp.GetNodeData(node.Parent.parent.parent);
//          dataPreg := vtrTemp.GetNodeData(node.Parent);
//          pat := msgColl.CollPat.Items[dataPat.index];
//          preg := pat.FPregledi[dataPreg.index];
//          msg := TNzisReqRespItem(preg.FLstMsgImportNzis[data.index]);
//          syndtNzisReq.Lines.Text := msg.PRecord.REQ;
//          syndtNzisResp.Lines.Text := msg.PRecord.RESP;
//        end;
//        vvmdn:
//        begin
//          dataPat := vtrTemp.GetNodeData(node.Parent.parent.parent);
//          if dataPat.vid = vvIncMN then
//            dataPat := vtrTemp.GetNodeData(node.Parent.parent.parent.parent);
//          dataPreg := vtrTemp.GetNodeData(node.Parent.parent);
//          dataMdn := vtrTemp.GetNodeData(node.Parent);
//          pat := msgColl.CollPat.Items[dataPat.index];
//          preg := pat.FPregledi[dataPreg.index];
//          mdn := preg.FMdns[dataMdn.index];
//          msg := TNzisReqRespItem(mdn.FLstMsgImportNzis[data.index]);
//          syndtNzisReq.Lines.Text := msg.PRecord.REQ;
//          syndtNzisResp.Lines.Text := msg.PRecord.RESP;
//        end;
//      end;
//
//    end;
//  end;
end;


procedure TfrmSuperHip.vtrTempChangeSelectMKB(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  data, dataPreg, dataPat: PAspRec;
  tempViewportPosition: TPointF;
begin
  Exit;
  data := vtrTemp.GetNodeData(node);
  case data.vid of
    vvMKB:
    begin
      Caption := ADB_DM.CollMkb.getAnsiStringMap(data.DataPos, word(Mkb_CODE));
      AddNewDiag(FmxProfForm.Pregled.FNode, Caption, '', FmxProfForm.Pregled.FDiagnosis.Count, Data.DataPos);
      dataPat := Pointer(PByte(FmxProfForm.Pregled.FNode.Parent) + lenNode);
      dataPreg := Pointer(PByte(FmxProfForm.Pregled.FNode) + lenNode);
      tempViewportPosition := FmxProfForm.scrlbx1.ViewportPosition;
      ShowPregledFMX(dataPat, dataPreg, FmxProfForm.Pregled.FNode);
      FmxProfForm.scrlbx1.ViewportPosition := tempViewportPosition;
    end;
  end;
end;

procedure TfrmSuperHip.vtrTempChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  data, dataPreg, dataPat: PAspRec;
  tempViewportPosition: TPointF;
  i: integer;
begin
  Exit;
  data := vtrTemp.GetNodeData(node);
  case data.vid of
    vvMKB:
    begin
      if (csCheckedNormal = Node.CheckState) then
      begin
        FmxProfForm.Pregled.CanDeleteDiag := False;
        Caption := ADB_DM.CollMkb.getAnsiStringMap(data.DataPos, word(Mkb_CODE));
        AddNewDiag(FmxProfForm.Pregled.FNode, Caption, '', FmxProfForm.Pregled.FDiagnosis.Count, Data.DataPos);
        FmxProfForm.Pregled.FDiagnosis.Add(ADB_DM.CollDiag.Items[ADB_DM.CollDiag.Count - 1]);
        dataPat := Pointer(PByte(FmxProfForm.Pregled.FNode.Parent) + lenNode);
        dataPreg := Pointer(PByte(FmxProfForm.Pregled.FNode) + lenNode);
        tempViewportPosition := FmxProfForm.scrlbx1.ViewportPosition;
        ShowPregledFMX(dataPat, dataPreg, FmxProfForm.Pregled.FNode);
        FmxProfForm.scrlbx1.ViewportPosition := tempViewportPosition;
        data.index := FmxProfForm.Pregled.FDiagnosis[FmxProfForm.Pregled.FDiagnosis.Count - 1].DataPos;
        FmxProfForm.Pregled.FDiagnosis[FmxProfForm.Pregled.FDiagnosis.Count - 1].MkbNode := Node;
        FmxProfForm.Pregled.CanDeleteDiag := true;
      end
      else
      begin
        Caption := ADB_DM.CollMkb.getAnsiStringMap(data.DataPos, word(Mkb_CODE));
        FmxProfForm.Pregled.CanDeleteDiag := False;
        for i := 0 to FmxProfForm.Pregled.FDiagnosis.Count - 1 do
        begin
          if FmxProfForm.Pregled.FDiagnosis[i].MkbNode = node then
          begin

            ADB_DM.CollPregled.streamComm.Size := 0;
            ADB_DM.CollPregled.streamComm.OpType := toDeleteNode;
            ADB_DM.CollPregled.streamComm.Size := 12 + 4;
            ADB_DM.CollPregled.streamComm.Ver := 0;
            ADB_DM.CollPregled.streamComm.Vid := ctLink;
            ADB_DM.CollPregled.streamComm.DataPos := Cardinal(FmxProfForm.Pregled.FDiagnosis[i].Node);
            ADB_DM.CollPregled.streamComm.Propertys := [];
            ADB_DM.CollPregled.streamComm.Len := ADB_DM.CollPregled.streamComm.Size;
            streamCmdFile.CopyFrom(ADB_DM.CollPregled.streamComm, 0);
            FmxProfForm.Pregled.FDiagnosis.Delete(i);
            Break;
          end;
        end;

        RemoveDiag(FmxProfForm.Pregled.FNode, cardinal(Data.index));

        dataPat := Pointer(PByte(FmxProfForm.Pregled.FNode.Parent) + lenNode);
        dataPreg := Pointer(PByte(FmxProfForm.Pregled.FNode) + lenNode);
        tempViewportPosition := FmxProfForm.scrlbx1.ViewportPosition;
        ShowPregledFMX(dataPat, dataPreg, FmxProfForm.Pregled.FNode);
        FmxProfForm.scrlbx1.ViewportPosition := tempViewportPosition;
        FmxProfForm.Pregled.CanDeleteDiag := true;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrTempCollapsed(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  data, dataAction: PAspRec;
  RunNode: PVirtualNode;
begin
  Exit;//zzzzzzzzzzzztemp
  if (GetKeyState(VK_CONTROL) >= 0) then Exit;
  dataAction := Sender.GetNodeData(node);
  vtrTemp.OnCollapsed := nil;
  vtrTemp.OnMeasureItem := nil;
  Sender.BeginUpdate;
  vtrTemp.IterateSubtree(vNomenMKB, IterateTempcollapsed, dataAction);
  Sender.EndUpdate;
  vtrTemp.OnCollapsed := vtrTempCollapsed;
  vtrTemp.OnMeasureItem := vtrTempMeasureItem1;
end;

procedure TfrmSuperHip.vtrTempColumnClick(Sender: TBaseVirtualTree;
  Column: TColumnIndex; Shift: TShiftState);
var
  Node: PVirtualNode;
  data: PAspRec;
  i: Integer;
  RText: TRect;
  Nodetext: string;
  p: TPoint;
  ArrStr: TArray<string>;
begin
  //Exit;
  Node := Sender.GetFirstSelected();
  if node = nil then Exit;
  data := Sender.GetNodeData(node);
  for i := 0 to Sender.Header.Columns.Count - 1 do
  begin
    sender.Header.Columns[i].ImageIndex := -1;
  end;
  sender.GetTextInfo(node, Column, sender.Font, RText, Nodetext);

  sender.Header.Columns[Column].ImageIndex := 29;
  edtFilterTemp.Clear;
  FinderRecMKB.vid := data.vid;
  FinderRecMKB.IsFinded := False;
  FinderRecMKB.node := sender.GetFirstSelected;
  FinderRecMKB.strSearch  := '';
  FinderRecMKB.LastFindedStr  := '';
  FinderRecMKB.ACol  := Column;

  sender.Header.Columns[0].Text := 'Диагнози';
  sender.Header.Columns[1].Text := 'Детайли';
  case Column of
    0:
    begin
      case data.vid of
        vvMKB:
        begin
          sender.Header.Columns[Column].Text := 'МКБ';
          sender.Header.Columns[Column].Tag := 0;
        end;

      else
        sender.Header.Columns[Column].Text := '....';
      end;
    end;
    1:
    begin
      case data.vid of
        vvMKB:
        begin
          sender.Header.Columns[Column].Text := 'Име на диагнозата';
          sender.Header.Columns[Column].Tag := 0;
        end;
      else
        sender.Header.Columns[Column].Text := '....';
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrTempColumnClick1(Sender: TBaseVirtualTree;
  Column: TColumnIndex; Shift: TShiftState);
var
  RText: TRect;
  Nodetext: string;
  node: PVirtualNode;
begin
  Node := Sender.GetFirstSelected();
  if node = nil then Exit;
  vtrTemp.GetTextInfo(node, Column, vtrTemp.Font, RText, Nodetext);
end;

procedure TfrmSuperHip.vtrTempColumnResize(Sender: TVTHeader;
  Column: TColumnIndex);
begin
  //vtrTemp.TopNode := vtrTempTopNode;
end;

procedure TfrmSuperHip.vtrTempCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  data1, data2: PAspRec;
  date1, date2: TDate;
begin
  Exit;
  if Column > 0 then  Exit;
  if node1.ChildCount = 0 then  Exit;

  Result :=  node1.FirstChild.Dummy - node2.FirstChild.Dummy;
end;

procedure TfrmSuperHip.vtrTempDrawButton(sender: TVirtualStringTreeHipp; node: PVirtualNode; var ButonVisible: Boolean; const numButton: Integer;
  var imageIndex: Integer);
var
  data: PAspRec;
begin
 // Exit;
  data := vtrTemp.GetNodeData(node);
  case data.vid of
    vvPatientNewRoot:
    begin
      case data.index of
        -6:
        begin
          case numButton of
            0:
            begin
              imageIndex := 97;
              ButonVisible := True;
            end;
            1:
            begin
              imageIndex := 72;
              ButonVisible := True;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrTempDrawText(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
var
  rText, r: TRect;
  i, p: Integer;
  wb: TWordBreakF;
  FilterText, strPred, strSled: string;
begin
  Exit;
  //if Column <> 1 then
//  begin
//    DefaultDraw := true;
//    Exit;
//  end;
  rText := CellRect;

  //Exit;
  wb := TWordBreakF.create(TargetCanvas);
  wb.Inls.Text := Text;

  //mmText := TStringList.Create;
  //SMemo := TStringList.Create;
  rText := CellRect;
  //h:= rText.Height;
  wb.maxwidth := rText.Width;

  //mmText.Text := Text;
  //WordBreakF.WrapMemo(TargetCanvas, mmText, SMemo, w, h);
  //rText.Width:= w ;
  //rText.Height:= 13;
  DefaultDraw := False;
  FilterText := edtFilterTemp.Text;// 'система';
  p := AnsiUpperCase(wb.Inls.Text).IndexOf((AnsiUpperCase(FilterText)));
  if p > -1 then
  begin
    wb.StartFilter := p;
    wb.EndFilter := p + Length(FilterText);
    wb.WrapMemo;
    for i := 0 to wb.ls.Count - 1 do
    begin
      if i = wb.ls.Count - 1 then
      begin
        Winapi.Windows.DrawTextW(TargetCanvas.Handle, PWideChar(wb.ls[i]), Length(wb.ls[i])- 1, rText, TA_LEFT);
      end
      else
      begin
        Winapi.Windows.DrawTextW(TargetCanvas.Handle, PWideChar(wb.ls[i]), Length(wb.ls[i] ), rText, TA_LEFT);
      end;

      if AnsiUpperCase(wb.ls[i]).Contains( AnsiUpperCase(FilterText)) then
      begin
        p := AnsiUpperCase(wb.ls[i]).IndexOf((AnsiUpperCase(FilterText)));
        //FilterText := Copy(wb.ls[i], p + 1, length(FinderRec.strSearch));
        strPred := Copy(wb.ls[i], 1, p);
        strSled := copy(wb.ls[i], p+length(FilterText) + 1, length(wb.ls[i]) + 1 -   (p+length(FilterText)));

        SetTextColor(TargetCanvas.Handle, $00A00000);
        SetBkColor(TargetCanvas.Handle, $007DCFFB);
        SetBkMode(TargetCanvas.Handle, OPAQUE);
        r := rText;
        r.Left := r.Left + TargetCanvas.TextWidth(strPred);
        r.Width := TargetCanvas.TextWidth(FilterText);
        Winapi.Windows.DrawText(TargetCanvas.Handle, PWideChar(FilterText), Length(FilterText), r, TA_LEFT);
        SetTextColor(TargetCanvas.Handle, clBlack);
        SetBkMode(TargetCanvas.Handle, TRANSPARENT);
      end;
      if Integer(wb.ls.Objects[i]) <> 0 then
      begin
        p := length(wb.ls[i]) + Integer(wb.ls.Objects[i]);

        if Integer(wb.ls.Objects[i]) < 0 then
        begin
          strPred := Copy(wb.ls[i], 1, p - 1);
          strSled := copy(wb.ls[i], length(wb.ls[i]) + Integer(wb.ls.Objects[i]), - Integer(wb.ls.Objects[i]));
        end
        else
        begin
          strPred := '';
          strSled := copy(wb.ls[i], 1,  Integer(wb.ls.Objects[i]));
          if strSled.StartsWith('н') then
            strPred := '';
        end;

        SetTextColor(TargetCanvas.Handle, $00A00000);
        SetBkColor(TargetCanvas.Handle, $007DCFFB);
        SetBkMode(TargetCanvas.Handle, OPAQUE);
        r := rText;
        r.Left := r.Left + TargetCanvas.TextWidth(strPred);
        r.Width := TargetCanvas.TextWidth(strSled);
        Winapi.Windows.DrawText(TargetCanvas.Handle, PWideChar(strSled), Length(strSled), r, TA_LEFT);
        SetTextColor(TargetCanvas.Handle, clBlack);
        SetBkMode(TargetCanvas.Handle, TRANSPARENT);
      end;
      rText.Offset(0, 13);
    end;

  end
  else
  begin
    wb.WrapMemo;
    Winapi.Windows.DrawTextW(TargetCanvas.Handle, PWideChar(wb.ls.Text), Length(wb.ls.Text) - 3, rText, TA_LEFT);//43024);
  end;
  wb.Destroy;
end;

procedure TfrmSuperHip.vtrTempExpanded(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  data, dataAction: PAspRec;
  RunNode: PVirtualNode;
begin
  Exit;//zzzzzzzzzzzztemp
  if (GetKeyState(VK_CONTROL) >= 0) then Exit;
  dataAction := Sender.GetNodeData(node);
  //if dataAction.vid = vvPatientRoot then  Exit;

  vtrTemp.OnExpanded := nil;
  //vtrTemp.OnMeasureItem := nil;
  Sender.BeginUpdate;
  vtrTemp.IterateSubtree(vNomenMKB, IterateTempExpand, dataAction);
  Sender.EndUpdate;
  vtrTemp.OnExpanded := vtrTempExpanded;
  vtrTemp.OnMeasureItem := vtrTempMeasureItem1;
end;

procedure TfrmSuperHip.vtrTempGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex;
  var ImageList: TCustomImageList);
var
  data: PAspRec;
begin
  if Kind <> TVTImageKind.ikState then
    Exit;
  case Column of
    0:
    begin
      data := Sender.GetNodeData(node);
      case data.vid of
        vvMKB:
        begin
          if Node.ChildCount > 0 then
          begin
            ImageIndex := 103;
          end;
        end;
        vvPatientNewRoot:
        begin
          ImageIndex := 24;
        end;
        vvMDN:
        begin
          if data.DataPos > 0 then
          begin
            ImageIndex := 82;
          end
          else
          begin
            ImageIndex := 109;
          end;
        end;
        vvOtherDoctor:
        begin
          if data.DataPos > 0 then
          begin
            ImageIndex := 17;
          end
          else
          begin
            ImageIndex := 110;
          end;
        end;
        vvIncMN:
        begin
          if data.DataPos > 0 then
          begin
            ImageIndex := 96;
          end
          else
          begin
            ImageIndex := 108;
          end;
        end;
        vvPregled:
        begin
          if data.DataPos > 0 then
          begin
            ImageIndex := 58;
          end
          else
          begin
            ImageIndex := 106;
          end;
        end;
        vvPatient:
        begin
          if data.DataPos > 0 then
          begin
            ImageIndex := 3;
          end
          else
          begin
            ImageIndex := 107;
          end;
        end;
        vvNzisMessages:
        begin
          ImageIndex := 78;
        end;
      end;
    end;
  end;

end;

procedure TfrmSuperHip.vtrTempGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data, dataPat, dataPreg, dataMdn, DataParent, dataIncMN: PAspRec;
  msg: TNzisReqRespItem;
  patLogical: TlogicalPatientNewSet;
  pat: TRealPatientNewItem;
  preg: TRealPregledNewItem;
  incMN: TRealINC_NAPRItem;
  mdn: TRealMDNItem;
begin
  data := vtrTemp.GetNodeData(node);
  case Column of
    0:
    begin
      if data.index = -1 then
      begin
        case data.vid of
          vvPregledNewRoot: CellText := 'Прегледи';
          vvMDN: CellText := 'Направления';
          vvRecepta: CellText := 'Рецепти';
          vvExamImun: CellText := 'Имунизации';
          vvHosp: CellText := 'Хоспитализации';
          vvNomenNzis: CellText := 'Общи';
          vvPatientNewRoot: CellText := 'Пациенти от импорта';
          vvPatient:
          begin
            CellText := 'ЕГН ' + ADB_DM.CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN));
          end;
          vvPregled:
          begin
            //preg := msgColl.CollPreg.Items[data.index];
            if Data.DataPos > 0 then
            begin
              CellText := ADB_DM.CollPregled.getAnsiStringMap(Data.DataPos, word(PregledNew_NRN_LRN));
            end
            else
            begin
              CellText := 'Нов преглед';
            end;
          end;
        end;
      end
      else
      begin
        case data.vid of
          vvMdn:
          begin
            dataPat := vtrTemp.GetNodeData(node.parent.parent);

            if dataPat.vid = vvPatient then
            begin
              dataPreg := vtrTemp.GetNodeData(node.parent);
              dataMdn := vtrTemp.GetNodeData(node);
              pat := ADB_DM.AmsgColl.CollPat.Items[dataPat.index];
              preg := pat.FPregledi[dataPreg.index];
              mdn := preg.FMdns[dataMdn.index];
              if Data.DataPos > 0 then
              begin
                CellText := ADB_DM.CollMDN.getAnsiStringMap(Data.DataPos, word(MDN_NRN));
              end
              else
              begin
                CellText := 'Ново МДН ' + mdn.NRN;
              end;
            end
            else
            begin
              dataPat := vtrTemp.GetNodeData(node.parent.parent.parent);
              dataPreg := vtrTemp.GetNodeData(node.parent);
              dataMdn := vtrTemp.GetNodeData(node);
              pat := ADB_DM.AmsgColl.CollPat.Items[dataPat.index];
              preg := pat.FPregledi[dataPreg.index];
              mdn := preg.FMdns[dataMdn.index];
              if Data.DataPos > 0 then
              begin
                CellText := ADB_DM.CollMDN.getAnsiStringMap(Data.DataPos, word(MDN_NRN));
              end
              else
              begin
                CellText := 'Ново МДН ' + mdn.NRN;
              end;
            end;
          end;
          vvPregled:
          begin
            dataPat := vtrTemp.GetNodeData(node.parent);
            if dataPat = nil then Exit;

            if dataPat.vid = vvPatient then
            begin
              pat := ADB_DM.AmsgColl.CollPat.Items[dataPat.index];
              preg := pat.FPregledi[data.index];
              if Data.DataPos > 0 then
              begin
                CellText := ADB_DM.CollPregled.getAnsiStringMap(Data.DataPos, word(PregledNew_NRN_LRN));
              end
              else
              begin
                CellText := 'Нов преглед ' + preg.NRN;
              end;
            end
            else
            begin
              dataPat := vtrTemp.GetNodeData(node.parent.parent);
              pat := ADB_DM.AmsgColl.CollPat.Items[dataPat.index];
              dataIncMN := vtrTemp.GetNodeData(node.parent);
              incMN := pat.FIncMNs[dataIncMN.index];
              preg := pat.FPregledi[data.index];
              if Data.DataPos > 0 then
              begin
                CellText := ADB_DM.CollPregled.getAnsiStringMap(Data.DataPos, word(PregledNew_NRN_LRN));
              end
              else
              begin
                CellText := 'Нов преглед ' + preg.NRN;
              end;
            end;
          end;
          vvOtherDoctor:
          begin
            if data.DataPos > 0 then
            begin
              CellText := ADB_DM.CollOtherDoctor.getAnsiStringMap(Data.DataPos, word(OtherDoctor_UIN));
            end
            else
            begin
              CellText := ADB_DM.AmsgColl.CollIncDoc.items[data.index].PRecord.UIN;
            end;
          end;
          vvIncMN:
          begin
            dataPat := vtrTemp.GetNodeData(node.parent);
            pat := ADB_DM.AmsgColl.CollPat.Items[dataPat.index];
            incMN := pat.FIncMNs[data.index];
            if Data.DataPos > 0 then
            begin
              CellText := ADB_DM.CollIncMN.getAnsiStringMap(Data.DataPos, word(INC_NAPR_NRN));
            end
            else
            begin
              CellText := 'Нова Консулт.  ' + incMN.NRN;
            end;
          end;
          vvPatient:
          begin
            pat := ADB_DM.AmsgColl.CollPat.Items[data.index];
            if Data.DataPos > 0 then
            begin
              CellText := ADB_DM.CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_EGN));
            end
            else
            begin
              CellText := 'Нов ' + pat.PatEGN;
            end;
          end;

          vvNzisMessages:
          begin
            DataParent := vtrTemp.GetNodeData(node.parent);
            case DataParent.vid of
              vvpregled:
              begin
                dataPat := vtrTemp.GetNodeData(node.parent.parent);
                if dataPat = nil then Exit;

                if dataPat.vid = vvPatient then
                begin
                  pat := ADB_DM.AmsgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[DataParent.index];
                  msg := TNzisReqRespItem(preg.FLstMsgImportNzis[data.index]);
                  CellText := Format('X%.3d', [msg.PRecord.msgNom]);
                end
                else
                begin
                  dataPat := vtrTemp.GetNodeData(node.parent.parent.parent);
                  pat := ADB_DM.AmsgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[DataParent.index];
                  msg := TNzisReqRespItem(preg.FLstMsgImportNzis[data.index]);
                  CellText := Format('X%.3d', [msg.PRecord.msgNom]);
                end;
              end;
              vvMdn:
              begin
                dataPat := vtrTemp.GetNodeData(node.parent.parent.parent);
                if dataPat.vid = vvPatient then
                begin

                  dataPreg := vtrTemp.GetNodeData(node.parent.Parent);
                  dataMdn := vtrTemp.GetNodeData(node.parent);
                  pat := ADB_DM.AmsgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[dataPreg.index];
                  mdn := preg.FMdns[dataMdn.index];
                  msg := TNzisReqRespItem(mdn.FLstMsgImportNzis[data.index]);
                  CellText := Format('R%.3d', [msg.PRecord.msgNom]);
                end
                else
                begin
                  dataPat := vtrTemp.GetNodeData(node.parent.parent.parent.parent);
                  dataPreg := vtrTemp.GetNodeData(node.parent.Parent);
                  dataMdn := vtrTemp.GetNodeData(node.parent);
                  pat := ADB_DM.AmsgColl.CollPat.Items[dataPat.index];
                  preg := pat.FPregledi[dataPreg.index];
                  mdn := preg.FMdns[dataMdn.index];
                  msg := TNzisReqRespItem(mdn.FLstMsgImportNzis[data.index]);
                  CellText := Format('R%.3d', [msg.PRecord.msgNom]);
                end;
              end;

            else
              begin
                Caption := 'ddd';
              end;

            end;


          end;
        end;

      end;
    end;
    1:
    begin
      case data.vid of
        vvPatient:
        begin

          if Data.DataPos > 0 then
          begin
            CellText := ADB_DM.CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_FNAME));
            CellText := CellText + ' ' + ADB_DM.CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_SNAME));
            CellText := CellText + ' ' + ADB_DM.CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_LNAME));
            CellText := CellText + ' ID: ' + IntToStr(ADB_DM.CollPatient.getIntMap(Data.DataPos, word(PatientNew_ID)));
          end
          else
          begin
            CellText := 'XML';
          end;
        end;
      else
        begin
          CellText := IntToStr(node.ChildCount);
        end;
      end;

    end;
    2:
    begin
      case data.vid of
        vvOrders:
        begin
          dataPat := vtrTemp.GetNodeData(node.parent);
          case dataPat.vid of
            vvPatient:
            begin
              pat := ADB_DM.AmsgColl.CollPat.Items[dataPat.index];
              msg := TNzisReqRespItem(pat.FLstMsgImportNzis[data.index]);
            end;
            vvPregledNewRoot:
            begin
              msg := ADB_DM.AmsgColl.items[data.index];
            end;
            vvpregled:
            begin
              //dataPat := vtrTemp.GetNodeData(node.parent.parent);
//              pat := msgColl.CollPat.Items[dataPat.index];
//              msg := TNzisReqRespItem(pat.FLstMsgImportNzis[data.index]);
            end;
          end;
          //CellText := msg.PRecord.NRN;
        end;

      else
        begin
          CellText := TRttiEnumerationType.GetName(TVtrVid(Integer(data.vid)));
          CellText := CellText + ': ' + IntToStr(node.Dummy);
        end;
      end;

    end;
  end;
end;

procedure TfrmSuperHip.vtrTempGetText1(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data, dataPat: PAspRec;
  msg: TNzisReqRespItem;
  patLogical: TlogicalPatientNewSet;
  pat: TRealPatientNewItem;
  preg: TRealPregledNewItem;
begin
  data := vtrTemp.GetNodeData(node);
  case Column of
    0:
    begin
      if data.index = -1 then
      begin
        case data.vid of
          vvPregledNewRoot: CellText := 'Прегледи';
          vvMDN: CellText := 'Направления';
          vvRecepta: CellText := 'Рецепти';
          vvExamImun: CellText := 'Имунизации';
          vvHosp: CellText := 'Хоспитализации';
          vvNomenNzis: CellText := 'Общи';
          vvPatientNewRoot: CellText := 'Пациенти от импорта';
          vvPatient:
          begin
            CellText := 'ЕГН ' + ADB_DM.CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN));
          end;
          vvPregled:
          begin
            //preg := msgColl.CollPreg.Items[data.index];
            if Data.DataPos > 0 then
            begin
              CellText := ADB_DM.CollPregled.getAnsiStringMap(Data.DataPos, word(PregledNew_NRN_LRN));
            end
            else
            begin
              CellText := 'Нов преглед';
            end;
          end;
        end;
      end
      else
      begin
        case data.vid of
          vvPatient:
          begin
            pat := ADB_DM.AmsgColl.CollPat.Items[data.index];
            if Data.DataPos > 0 then
            begin
              //CellText := CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_EGN));
            end
            else
            begin
              CellText := 'Нов ' + pat.PatEGN;
            end;
          end;

          vvNzisMessages:
          begin
            dataPat := vtrTemp.GetNodeData(node.parent);
            case dataPat.vid of
              vvPatient:
              begin
                pat := ADB_DM.AmsgColl.CollPat.Items[dataPat.index];

                msg := TNzisReqRespItem(pat.FLstMsgImportNzis[data.index]);
                case byte(msg.PRecord.Logical) of
                  1: CellText := Format('X%.3d', [msg.PRecord.msgNom]);
                  2: CellText := Format('R%.3d', [node.Dummy]);
                  4: CellText := Format('P%.3d', [node.Dummy]);
                  8: CellText := Format('I%.3d', [node.Dummy]);
                  16: CellText := Format('H%.3d', [node.Dummy]);
                  32: CellText := Format('C%.3d', [node.Dummy]);
                end;
              end;
              vvPregledNewRoot:
              begin
                msg := ADB_DM.AmsgColl.items[data.index];
                case byte(msg.PRecord.Logical) of
                  1: CellText := Format('X%.3d', [msg.PRecord.msgNom]);
                  2: CellText := Format('R%.3d', [node.Dummy]);
                  4: CellText := Format('P%.3d', [node.Dummy]);
                  8: CellText := Format('I%.3d', [node.Dummy]);
                  16: CellText := Format('H%.3d', [node.Dummy]);
                  32: CellText := Format('C%.3d', [node.Dummy]);
                end;
              end;
              vvpregled:
              begin
                //dataPat := vtrTemp.GetNodeData(node.parent.parent);
                pat := ADB_DM.AmsgColl.CollPat.Items[dataPat.index];

                msg := TNzisReqRespItem(pat.FLstMsgImportNzis[data.index]);
                case byte(msg.PRecord.Logical) of
                  1: CellText := Format('X%.3d', [msg.PRecord.msgNom]);
                  2: CellText := Format('R%.3d', [node.Dummy]);
                  4: CellText := Format('P%.3d', [node.Dummy]);
                  8: CellText := Format('I%.3d', [node.Dummy]);
                  16: CellText := Format('H%.3d', [node.Dummy]);
                  32: CellText := Format('C%.3d', [node.Dummy]);
                end;
              end

            else
              begin
                Caption := 'ddd';
              end;

            end;


          end;
        end;

      end;
    end;
    1:
    begin
      case data.vid of
        vvPatient:
        begin

          if Data.DataPos > 0 then
          begin
            CellText := ADB_DM.CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_FNAME));
            CellText := CellText + ' ' + ADB_DM.CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_SNAME));
            CellText := CellText + ' ' + ADB_DM.CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_LNAME));
          end
          else
          begin

          end;
        end;
      else
        begin
          CellText := IntToStr(node.ChildCount);
        end;
      end;

    end;
    2:
    begin
      case data.vid of
        vvNzisMessages:
        begin
          dataPat := vtrTemp.GetNodeData(node.parent);
          case dataPat.vid of
            vvPatient:
            begin
              pat := ADB_DM.AmsgColl.CollPat.Items[dataPat.index];
              msg := TNzisReqRespItem(pat.FLstMsgImportNzis[data.index]);
            end;
            vvPregledNewRoot:
            begin
              msg := ADB_DM.AmsgColl.items[data.index];
            end;
            vvpregled:
            begin
              dataPat := vtrTemp.GetNodeData(node.parent.parent);
              pat := ADB_DM.AmsgColl.CollPat.Items[dataPat.index];
              msg := TNzisReqRespItem(pat.FLstMsgImportNzis[data.index]);
            end;
          end;
          CellText := msg.PRecord.NRN;
        end;

      else
        begin
          CellText := IntToStr(node.ChildCount);
        end;
      end;

    end;
  end;
end;

procedure TfrmSuperHip.vtrTempKeyAction(Sender: TBaseVirtualTree;
  var CharCode: Word; var Shift: TShiftState; var DoDefault: Boolean);
var
  node: PVirtualNode;
begin
  if CharCode = VK_BACK then
    CharCode := 0;
  if CharCode = VK_ESCAPE then
  begin
    edtFilterTemp.Text := '';
    FinderRecMKB.strSearch := '';
  end;
  if CharCode = VK_RETURN then
  begin
    CharCode := 0;// да ходи на следващо попадение

    if KeyCNT then
    begin
      if (GetKeyState(VK_CONTROL) < 0) then
      begin
        if FinderRecMKB.IsFinded then
        begin
          KeyCNT := False;
          FindNodevtrTemp(dfForward, FinderRecMKB.ACol);
          KeyCNT := True;
        end;
      end;
      if (GetKeyState(VK_SHIFT) < 0) then
      begin
        if FinderRecMKB.IsFinded then
        begin
          KeyCNT := False;
          FindNodevtrTemp(dfBackward, FinderRecMKB.ACol);
          KeyCNT := True;
        end;
      end;
    end;

  end;
end;

procedure TfrmSuperHip.vtrTempKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [#10, #13] then
  begin
    Key := #0;
    Exit;
  end;
  if vtrTemp.Header.Columns[FinderRecMKB.acol].Tag < 0 then
  begin
    Exit;
  end;
  edtFilterTemp.Perform(WM_CHAR, Ord(key), 0);

  Key := #0;
end;

procedure TfrmSuperHip.vtrTempMeasureItem(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
begin
  if vtrTemp.MultiLine[Node] then
  begin
    TargetCanvas.Font := Sender.Font;
    NodeHeight := vtrTemp.ComputeNodeHeight(TargetCanvas, Node, 0) + 10;
  end;
end;

procedure TfrmSuperHip.vtrTempMeasureItem1(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
var
  h0, h1: integer;
  data: PAspRec;
  txt: string;
  textW, row: Integer;
begin
  inherited;
  data := Sender.GetNodeData(node);
  txt := vtrTemp.Text[node, 1];
  textW:= TargetCanvas.TextWidth(txt)  ;

  NodeHeight := ((textW div (vtrTemp.Header.Columns[1].Width - 10)) + 2) * 13 ;
end;

procedure TfrmSuperHip.vtrDoctorButtonClick(sender: TVirtualStringTreeHipp; node: PVirtualNode; const numButton: Integer);
var
  data: PAspRec;
begin
  data := vtrDoctor.GetNodeData(node);
  case data.vid of
    vvDoctorRoot:
    begin
      case numButton of
        0:
        begin
          FillCertInDoctors;
          if ADB_DM.CollDoctor.Items[0].Cert <> nil then
          begin
            edtCertNom.Text := BuildHexString(ADB_DM.CollDoctor.Items[0].Cert.SerialNumber);
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrDoctorDrawButton(sender: TVirtualStringTreeHipp; node: PVirtualNode;
      var ButonVisible: Boolean; const numButton: Integer;
  var imageIndex: Integer);
var
  data: PAspRec;
begin
  data := vtrDoctor.GetNodeData(node);
  case data.vid of
    vvDoctorRoot:
    begin
      case numButton of
        0:
        begin
          ButonVisible := True;
          imageIndex := 31;
        end;
      end;
    end;
  end;

end;

procedure TfrmSuperHip.vtrDoctorGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  data: PAspRec;
  doc: TRealDoctorItem;
  buf: Pointer;
  posdata: Cardinal;
begin
  buf := Adb_DM.AdbMain.Buf;
  posdata := Adb_DM.AdbMain.FPosData;
  data := vtrDoctor.GetNodeData(node);
  case data.vid of
    vvDoctorRoot:
    begin
      case Column of
        0: CellText := 'Лекари';
      end;
    end;
    vvDoctor:
    begin
      doc := ADB_DM.CollDoctor.Items[data.index];
      case Column of
        0:
        begin
          CellText :=
          doc.getAnsiStringMap(buf, posdata, word(Doctor_FNAME)) + ' ' +
          doc.getAnsiStringMap(buf, posdata, word(Doctor_SNAME)) + ' ' +
          doc.getAnsiStringMap(buf, posdata, word(Doctor_LNAME));
        end;
        1:
        begin
          CellText :=
          'ЕГН ' + doc.getAnsiStringMap(buf, posdata, word(Doctor_EGN)) + #13#10 +
          'УИН ' + doc.getAnsiStringMap(buf, posdata, word(Doctor_UIN));
        end;
      end;
    end;
    vvRootDeput:
    begin
      case Column of
        0:
        begin
          CellText := 'Заместници'
        end;
      end;
    end;
    vvCert:
    begin
      case Column of
        0:
        begin
          CellText := 'Сертификат'
        end;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrDoctorKeyAction(Sender: TBaseVirtualTree;
  var CharCode: Word; var Shift: TShiftState; var DoDefault: Boolean);
begin
  if (CharCode = Ord('C')) and (GetKeyState(VK_CONTROL) < 0) then
  begin
    DoDefault := False;;
    Exit;
  end;
end;

procedure TfrmSuperHip.vtrDoctorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) then //CTRL key down
  begin
    if Key = (VkKeyScan('C')) then //"+" (plus) key down
    begin
      Key := 0; //so no FHeader.AutoFitColumns from TBaseVirtualTree.WMKeyDown
      if (vtrDoctor.Font.Size < 16) then
      begin
        vtrDoctor.Font.Size := 1 + vtrDoctor.Font.Size;
        vtrDoctor.IterateSubtree(
          nil,
          procedure (Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean)
          begin
            Sender.NodeHeight[Node] := 1 + Sender.NodeHeight[Node];
          end,
          nil);
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrDoctorNodeCopied(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  //
end;

procedure TfrmSuperHip.vtrDoctorNodeCopying(Sender: TBaseVirtualTree; Node,
  Target: PVirtualNode; var Allowed: Boolean);
begin
  //
end;

procedure TfrmSuperHip.vtrFDBButtonClick(sender: TVirtualStringTreeHipp; node: PVirtualNode; const numButton: Integer);
var
  data: PAspRec;
begin
  if node = nil then  Exit;
  data := sender.GetNodeData(node);
  if data.index < 0 then
  begin
    case numButton of
      0:
      begin
        //pgcWork.ActivePage := tsTest;
        InternalChangeWorkPage(tsTest);
        CalcStatusDB;
      end;
    end;
  end
  else
  begin
    case TTablesTypeHip(data.index) of
      Asp_PL_NZOK:
      case numButton of
        0:
        begin
          ImportPL_NZOK(nil);
        end;

      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrFDBChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  data: PAspRec;
begin
  if node = nil then
  begin
    node := sender.GetFirstSelected();
  end;
  grdNom.Tag := 0;
  if node = nil then exit;


  data := vtrFDB.GetNodeData(node);
  if data.index = -1 then
  begin
    //pgcWork.ActivePage := tseTst;
    InternalChangeWorkPage(tsTest);
    CalcStatusDB;
    exit;
  end;
  case TTablesTypeHip(data.index) of
    EXAM_BOLN_LIST:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      ADB_DM.Collebl.FillListNodes(AspectsLinkPatPregFile, vvEbl);
      ADB_DM.Collebl.ShowListNodesGrid(grdNom);
      //grdNom.Tag := Integer(@CollEbl);
    end;
    EXAM_ANALYSIS:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollExamAnal.FillListNodes(AspectsLinkPatPregFile, vvExamAnal);
      ADB_DM.CollExamAnal.ShowListNodesGrid(grdNom);
    end;
    EXAM_IMMUNIZATION:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollExamImun.FillListNodes(AspectsLinkPatPregFile, vvExamImun);
      ADB_DM.CollExamImun.ShowListNodesGrid(grdNom);
    end;
    KARTA_PROFILAKTIKA2017:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollCardProf.FillListNodes(AspectsLinkPatPregFile, vvProfCard);
      ADB_DM.CollCardProf.ShowListNodesGrid(grdNom);
    end;

    BLANKA_MDN:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollMDN.FillListNodes(AspectsLinkPatPregFile, vvMDN);

      ADB_DM.CollMDN.ShowListNodesGrid(grdNom);
    end;
    DOCTOR:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollDoctor.ShowGrid(grdNom);
    end;
    nzistoken:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollNzisToken.ShowGrid(grdNom);
    end;
    CERTIFICATES:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollCertificates.ShowGrid(grdNom);
    end;
    ICD10CM:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollMkb.FillListNodes(AspectsLinkPatPregFile, vvMKB);
      ADB_DM.CollMkb.ShowGrid(grdNom);
    end;
    PACIENT:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollPatient.FillListNodes(AspectsLinkPatPregFile, vvPatient);
      ADB_DM.CollPatient.ShowListNodesGrid(grdNom);
    end;
    PREGLED:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollPregled.FillListNodes(AspectsLinkPatPregFile, vvPregled);
      ADB_DM.CollPregled.ShowListNodesGrid(grdNom);
    end;
    PRACTICA:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollPractica.ShowGrid(grdNom);
    end;
    UNFAV:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollUnfav.ShowGrid(grdNom);
      if ADB_DM.CollUnfav.Count > 0 then
      begin
        thrHistPerf.Ticker :=TGridTicker.Create(grdNom.Grid.Current);
      end;
    end;
    Asp_Diag:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollDiag.FillListNodes(AspectsLinkPatPregFile, vvDiag);
      ADB_DM.CollDiag.ShowListNodesGrid(grdNom);
    end;
    Asp_PL_NZOK:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollPatPis.ShowGrid(grdNom);
    end;
    Asp_EventManyTimes:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      //CollEventsManyTimes.FillListNodes(AspectsLinkPatPregFile, vvEvnt);
//      CollEventsManyTimes.ShowListNodesGrid(grdNom);
    end;
    BLANKA_MED_NAPR:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollMedNapr.FillListNodes(AspectsLinkPatPregFile, vvMedNapr);
      ADB_DM.CollMedNapr.ShowListNodesGrid(grdNom);
    end;
    BLANKA_MED_NAPR_3A:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollMedNapr3A.FillListNodes(AspectsLinkPatPregFile, vvMedNapr3A);
      ADB_DM.CollMedNapr3A.ShowListNodesGrid(grdNom);
    end;
    HOSPITALIZATION:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollMedNaprHosp.FillListNodes(AspectsLinkPatPregFile, vvMedNaprHosp);
      ADB_DM.CollMedNaprHosp.ShowListNodesGrid(grdNom);
    end;
    EXAM_LKK:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollMedNaprLkk.FillListNodes(AspectsLinkPatPregFile, vvMedNaprLkk);
      ADB_DM.CollMedNaprLkk.ShowListNodesGrid(grdNom);
    end;
    INC_MDN:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollIncMdn.FillListNodes(AspectsLinkPatPregFile, vvIncMdn);
      ADB_DM.CollIncMdn.ShowListNodesGrid(grdNom);
    end;
    INC_NAPR:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollIncMN.FillListNodes(AspectsLinkPatPregFile, vvIncMN);
      ADB_DM.CollIncMN.ShowListNodesGrid(grdNom);
    end;
    NZIS_PLANNED_TYPE:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollNZIS_PLANNED_TYPE.FillListNodes(AspectsLinkPatPregFile, vvNZIS_PLANNED_TYPE);
      ADB_DM.CollNZIS_PLANNED_TYPE.ShowListNodesGrid(grdNom);
    end;
    NZIS_QUESTIONNAIRE_RESPONSE:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollNZIS_QUESTIONNAIRE_RESPONSE.FillListNodes(AspectsLinkPatPregFile, vvNZIS_QUESTIONNAIRE_RESPONSE);
      ADB_DM.CollNZIS_QUESTIONNAIRE_RESPONSE.ShowListNodesGrid(grdNom);
    end;
    NZIS_QUESTIONNAIRE_ANSWER:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollNZIS_QUESTIONNAIRE_ANSWER.FillListNodes(AspectsLinkPatPregFile, vvNZIS_QUESTIONNAIRE_ANSWER);
      ADB_DM.CollNZIS_QUESTIONNAIRE_ANSWER.ShowListNodesGrid(grdNom);
    end;
    NZIS_DIAGNOSTIC_REPORT:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollNZIS_DIAGNOSTIC_REPORT.FillListNodes(AspectsLinkPatPregFile, vvNZIS_DIAGNOSTIC_REPORT);
      ADB_DM.CollNZIS_DIAGNOSTIC_REPORT.ShowListNodesGrid(grdNom);
    end;
    NZIS_RESULT_DIAGNOSTIC_REPORT:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollNzis_RESULT_DIAGNOSTIC_REPORT.FillListNodes(AspectsLinkPatPregFile, vvNzis_RESULT_DIAGNOSTIC_REPORT);
      ADB_DM.CollNzis_RESULT_DIAGNOSTIC_REPORT.ShowListNodesGrid(grdNom);
    end;
    NZIS_ANSWER_VALUE:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollNZIS_ANSWER_VALUE.FillListNodes(AspectsLinkPatPregFile, vvNZIS_ANSWER_VALUE);
      ADB_DM.CollNZIS_ANSWER_VALUE.ShowListNodesGrid(grdNom);
    end;
    Asp_Addres:
    begin
      //InternalChangeWorkPage(tsGrid);
//      CollNZIS_ANSWER_VALUE.FillListNodes(AspectsLinkPatPregFile, vvNZIS_ANSWER_VALUE);
//      CollNZIS_ANSWER_VALUE.ShowListNodesGrid(grdNom);
    end;
    Asp_OtherDoctor:
    begin
      InternalChangeWorkPage(tsGrid);
      ADB_DM.CollOtherDoctor.ShowGrid(grdNom);
    end

  else
    //pgcWork.ActivePage := nil;
    InternalChangeWorkPage(nil);
  end;
end;

procedure TfrmSuperHip.vtrFDBDrawButton(sender: TVirtualStringTreeHipp; node: PVirtualNode; var ButonVisible: Boolean;
       const numButton: Integer;  var imageIndex: Integer);
var
  data: PAspRec;
  preg: TPregledNewItem;
  pat: TPatientNewItem;
  FieldText: string;
begin
  if node = nil then  Exit;
  data := sender.GetNodeData(node);
  if data.index < 0 then
  begin
    case numButton of
      0:
      begin
        imageIndex := 28;
        ButonVisible := True;
      end;

    end;
  end
  else
  begin
    case TTablesTypeHip(data.index) of
      Asp_PL_NZOK:
      case numButton of
        0:
        begin
          imageIndex := 30;
          ButonVisible := True;
        end;

      end;
    end;
  end;

end;

procedure TfrmSuperHip.vtrFDBGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  data: PAspRec;
begin
  if Node = nil then exit;

  data := vtrFDB.GetNodeData(node);

  case Column of
    0:
    begin
      if data.index  < 0 then
      begin
        CellText := 'Таблици';
      end
      else
      begin
        CellText := TRttiEnumerationType.GetName(TTablesTypeHip(data.index));
      end;
    end;
    1:
    begin
      if  data.index  < 0 then
      begin
        //
      end
      else
      begin
        if Adb_DM.AdbMain <> nil then
        begin
          case TTablesTypeHip(data.index) of
            PRACTICA: CellText := IntToStr(ADB_DM.CollPractica.CntInADB);
            PREGLED: CellText := IntToStr(ADB_DM.CollPregled.CntInADB);
            DOCTOR: CellText := IntToStr(ADB_DM.CollDoctor.CntInADB);
            ICD10CM: CellText := IntToStr(ADB_DM.CollMkb.CntInADB);
            PACIENT: CellText := IntToStr(ADB_DM.CollPatient.CntInADB);
            BLANKA_MDN: CellText := IntToStr(ADB_DM.collMdn.CntInADB);
            UNFAV: CellText := IntToStr(ADB_DM.CollUnfav.CntInADB);
            Asp_Diag: CellText := IntToStr(ADB_DM.CollDiag.CntInADB);
            Asp_PL_NZOK: CellText := IntToStr(ADB_DM.CollPatPis.Count);
           //Asp_EventManyTimes: CellText := IntToStr(CollEventsManyTimes.CntInADB);
            EXAM_BOLN_LIST: CellText := IntToStr(ADB_DM.CollEbl.CntInADB);
            EXAM_ANALYSIS: CellText := IntToStr(ADB_DM.CollExamAnal.CntInADB);
            EXAM_IMMUNIZATION: CellText := IntToStr(ADB_DM.CollExamImun.CntInADB);
            PROCEDURES: CellText := IntToStr(ADB_DM.ProceduresNomenColl.CntInADB);
            KARTA_PROFILAKTIKA2017: CellText := IntToStr(ADB_DM.CollCardProf.CntInADB);
            BLANKA_MED_NAPR: CellText := IntToStr(ADB_DM.CollMedNapr.CntInADB);
            BLANKA_MED_NAPR_3A: CellText := IntToStr(ADB_DM.CollMedNapr3A.CntInADB);
            HOSPITALIZATION: CellText := IntToStr(ADB_DM.CollMedNaprHosp.CntInADB);
            EXAM_LKK: CellText := IntToStr(ADB_DM.CollMedNaprLkk.CntInADB);
            INC_MDN: CellText := IntToStr(ADB_DM.CollIncMdn.CntInADB);
            INC_NAPR: CellText := IntToStr(ADB_DM.CollIncMN.CntInADB);
            NZIS_PLANNED_TYPE: CellText := IntToStr(ADB_DM.CollNZIS_PLANNED_TYPE.CntInADB);
            NZIS_QUESTIONNAIRE_RESPONSE: CellText := IntToStr(ADB_DM.CollNZIS_QUESTIONNAIRE_RESPONSE.CntInADB);
            NZIS_QUESTIONNAIRE_ANSWER: CellText := IntToStr(ADB_DM.CollNZIS_QUESTIONNAIRE_ANSWER.CntInADB);
            NZIS_DIAGNOSTIC_REPORT: CellText := IntToStr(ADB_DM.CollNZIS_DIAGNOSTIC_REPORT.CntInADB);
            NZIS_RESULT_DIAGNOSTIC_REPORT: CellText := IntToStr(ADB_DM.CollNzis_RESULT_DIAGNOSTIC_REPORT.CntInADB);
            NZIS_ANSWER_VALUE: CellText := IntToStr(ADB_DM.CollNZIS_ANSWER_VALUE.CntInADB);
            NzisToken: CellText := IntToStr(ADB_DM.CollNzisToken.count);
            Certificates: CellText := IntToStr(ADB_DM.CollCertificates.count);
            Asp_Addres: CellText := IntToStr(FNasMesto.addresColl.CntInADB);
            Asp_OtherDoctor: CellText := IntToStr(ADB_DM.CollOtherDoctor.CntInADB);
          end;
        end
        else
        begin
          case TTablesTypeHip(data.index) of
            Asp_PL_NZOK:
            begin
              if ADB_DM.CollPatPis.Count > 0 then
              begin
                CellText := Format('УИН: %s   %d', [ADB_DM.CollPatPis.uin, ADB_DM.CollPatPis.Count]);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrGraphChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  data, dataCL132, dataPr001, dataCl134, dataPeriod, dataPat: PAspRec;
  cl132: TRealCL132Item;
  cl134: TCL134Item;
  pr001: TRealPR001Item;
  pat: TRealPatientNewItem;
  i: integer;
  preg: TRealPregledNewItem;
  cl136Key, cl132Key: string;

  nodePat: PVirtualNode;
begin
  Exit;
  if node = nil then Exit;
  data := vtrGraph.GetNodeData(node);
  case data.vid of
    vvCl132:// може да е преглед, мдн, ваксина
    begin
      cl132 := FmxProfForm.Patient.lstGraph[data.index].Cl132;
      cl136Key := cl132.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, word(CL132_CL136_Mapping));
      cl132Key := cl132.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, word(CL132_Key));
      case cl136Key[1] of
        '1':
        begin // ако няма преглед, значи трябва да го заплануваме
          if cl132.FPregled <> nil then
          begin
            FmxProfForm.Pregled.DataPos := TRealPregledNewItem(cl132.FPregled).DataPos;
          end
          else
          begin

          end;
        end;
        '2': ;
        '3': ;
        '4': ;
      end;
      begin
        if AspectsNomHipFile = nil then
          OpenBufNomenHip(paramstr(2) + 'HipNomen.adb');
//        if AspectsNomFile = nil then
//          OpenBufNomenNzis('NzisNomen.adb');
        InternalChangeWorkPage(tsFMXForm);
        fmxCntrDyn.ChangeActiveForm(FmxProfForm);
        FmxProfForm.AspNomenBuf := AspectsNomFile.Buf;
        FmxProfForm.AspNomenPosData := AspectsNomFile.FPosData;
        FmxProfForm.AspNomenHipBuf := AspectsNomHipFile.Buf;
        FmxProfForm.AspNomenHipPosData := AspectsNomHipFile.FPosData;
        FmxProfForm.AspAdbBuf := Adb_DM.AdbMain.Buf;
        FmxProfForm.AspAdbPosData := Adb_DM.AdbMain.FPosData;
      end;


    end;

    vvPatient:
    begin
      nodePat := FindPatientByDataPos(data.DataPos);
      vtrMinaliPregledi.Tag := Cardinal(nodePat);
      LoadVtrMinaliPregledi(nodePat);
     // pgcWork.ActivePage := tsMinaliPregledi;
      InternalChangeWorkPage(tsMinaliPregledi);
    end;

  end;
end;

procedure TfrmSuperHip.vtrGraphCompareNodes(Sender: TBaseVirtualTree;
   Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  cl132_1, cl132_2: TRealCl132Item;
  data1, data2: PNodeRec;
  //pat: TRealPatientNewItem;
begin
  if Column <> 0 then Exit;
  data1 := Sender.GetNodeData(Node1);
  data2 := Sender.GetNodeData(Node2);

  //dataPat := vtrGraph.GetNodeData(Node1.Parent.parent);
  //pat := lstPatGraph[dataPat.index];
  cl132_1 := FmxProfForm.Patient.lstGraph[data1.index].Cl132;
  cl132_2 := FmxProfForm.Patient.lstGraph[data2.index].Cl132;

  if FmxProfForm.Patient.lstGraph[data1.index].endDate > FmxProfForm.Patient.lstGraph[data2.index].endDate then
     Result := 1
  else
  if FmxProfForm.Patient.lstGraph[data1.index].endDate < FmxProfForm.Patient.lstGraph[data2.index].endDate then
    Result := -1
  else
    Result := StrToInt(cl132_1.cl136) - StrToInt(cl132_2.cl136);
   
end;

procedure TfrmSuperHip.vtrGraphGetImageIndexEx(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean;
  var ImageIndex: TImageIndex; var ImageList: TCustomImageList);
var
  Data: PAspRec;
  ///pat: TRealPatientNewItem;
  cl132: TRealCl132Item;
  cl136Key, cl132Key: string;

begin
  if Kind <> TVTImageKind.ikState then
    Exit;
  Data := Sender.GetNodeData(Node);
  case Column of
    0:
    begin
      case Data.vid of
        vvcl132:
        begin
          //dataPat := vtrGraph.GetNodeData(node.Parent.parent);
          //pat := lstPatGraph[dataPat.index];
          cl132 := FmxProfForm.Patient.lstGraph[data.index].Cl132;
          cl136Key := cl132.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, word(CL132_CL136_Mapping));
          cl132Key := cl132.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, word(CL132_Key));
          case cl136Key[1] of
            '1':
            begin
              if NzisPregNotPreg.Contains('|' + cl132Key + '|') then
              begin
                ImageIndex := 78;
              end
              else
              begin
                ImageIndex := 12;
              end;
            end;
            '2': ImageIndex := 27;
            '3': ImageIndex := 63;
            '4': ImageIndex := 98;
          end;
        end;
      end; //case
    end; //0
    1:
    begin
      case Data.vid of
        vvcl132:
        begin
          //dataPat := vtrGraph.GetNodeData(node.Parent.parent);
          //pat := lstPatGraph[dataPat.index];
          cl132 := FmxProfForm.Patient.lstGraph[data.index].Cl132;
          cl136Key := cl132.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, word(CL132_CL136_Mapping));
          cl132Key := cl132.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, word(CL132_Key));
          case cl136Key[1] of
            '1':
            begin
              if not NzisPregNotPreg.Contains('|' + cl132Key + '|') then
              begin
                //if TRealPregledNewItem(cl132.FPregled).StartDate
                if cl132.FPregled <> nil then
                begin
                  ImageIndex := 6;
                end;
              end;

            end;

          end;
        end;
      end; //case
    end; //0
  end;
end;

procedure TfrmSuperHip.vtrGraphGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data, dataCL132, dataPr001, dataCl134, dataPeriod, dataPat: PAspRec;
  cl132: TRealCL132Item;
  cl134: TCL134Item;
  pr001: TRealPR001Item;
  CL142: TRealCl142Item;
  CL088: TRealCL088Item;
  preg: TRealPregledNewItem;
  pat: TRealPatientNewItem;
  i: integer;
  cl132_CL136: string;
  strtDate: TDate;
begin
  if node = nil then Exit;

  data := vtrGraph.GetNodeData(node);
  case Column of
    0:
    begin
      case data.index of
        -1: CellText := 'минали';
        -2: CellText := 'текущи';
        -3: CellText := 'бъдещи';

      else
        case data.vid of
          vvNone:
          begin
            CellText := 'Графици';
          end;
          vvCl132:
          begin
            dataPat := vtrGraph.GetNodeData(node.Parent.Parent);
            pat := ADB_DM.ACollPatGR.Items[dataPat.index];
            cl132 := pat.lstGraph[data.index].Cl132;
            CellText := cl132.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.CL132Coll.posData, word(CL132_Key));
            CellText := CellText + '  ' + Cl132.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.CL132Coll.posData, word(CL132_Display_Value_BG));
          end;
          vvPr001:
          begin
            if node.Parent.parent.parent = nil then
            begin
              CellText := 'errrrr';
              exit;
            end;
            dataCL132 := vtrGraph.GetNodeData(node.Parent);
            dataPat := vtrGraph.GetNodeData(node.Parent.Parent.parent);
            pat := ADB_DM.ACollPatGR.Items[dataPat.index];
            cl132 := pat.lstGraph[dataCL132.index].Cl132;
            pr001 := cl132.FListPr001[data.index];
            CellText := pr001.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(PR001_Description));
            if (pr001.CL142 <> nil)  and (pr001.CL142.FListCL088.Count =1) then
            begin
              cl088 := pr001.CL142.FListCL088[0];
              CellText  := CellText + ' cl088 ' + CL088.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL088_cl028));
            end;
          end;
          vvCL088:
          begin
            dataPr001 := vtrGraph.GetNodeData(node.Parent);
            dataCL132 := vtrGraph.GetNodeData(node.Parent.Parent);
            dataPat := vtrGraph.GetNodeData(node.Parent.Parent.parent.parent);
            pat := ADB_DM.ACollPatGR.Items[dataPat.index];
            cl132 := pat.lstGraph[dataCL132.index].Cl132;
            pr001 := cl132.FListPr001[dataPr001.index];
            CL142 := pr001.CL142;
            cl088 := CL142.FListCL088[data.index];
            CellText := cl088.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL088_Description));
          end;
          vvCl134:
          begin
            dataCL132 := vtrGraph.GetNodeData(node.Parent.Parent);
            dataPr001 := vtrGraph.GetNodeData(node.Parent);
            dataPat := vtrGraph.GetNodeData(node.Parent.Parent.parent.parent);
            pat := ADB_DM.ACollPatGR.Items[dataPat.index];
            cl132 := pat.lstGraph[dataCL132.index].Cl132;
            pr001 := cl132.FListPr001[dataPr001.index];
            cl134 := pr001.LstCl134[data.index];
            CellText := cl134.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL134_Description));
          end;
          vvPatient:
          begin
            pat := ADB_DM.ACollPatGR.Items[data.index];
            CellText := pat.getAnsiStringMap(Adb_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(PatientNew_FNAME));
            CellText := CellText + ' ' + pat.getAnsiStringMap(Adb_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(PatientNew_SNAME));
            CellText := CellText + ' ' + pat.getAnsiStringMap(Adb_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(PatientNew_LNAME));
          end;
        end;
      end;
    end;
    1:
    begin
      case data.index of
        -1: ;//CellText := 'минали';
        -2: //CellText := 'текущи';
        begin
          if data.DataPos <> MaxInt then
          begin
            dataPat := vtrGraph.GetNodeData(node.Parent);
            pat := ADB_DM.ACollPatGR.Items[dataPat.index];
            cl132 := pat.lstGraph[data.DataPos].Cl132;
            CellText := cl132.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.CL132Coll.posData, word(CL132_Key));
            CellText := CellText + '  ' + Cl132.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.CL132Coll.posData, word(CL132_Display_Value_BG));
          end;
        end;
        -3: ;//CellText := 'бъдещи';

      else
        case data.vid of
          vvnone:
          begin
            CellText := 'Брой пациенти: ' + inttostr(node.ChildCount);
          end;
          vvPatient:
          begin
            dataPat := vtrGraph.GetNodeData(node);
            pat := ADB_DM.ACollPatGR.Items[dataPat.index];
            CellText := 'ЕГН ' + pat.getAnsiStringMap(Adb_DM.AdbMain.Buf, ADB_DM.CollPatient.posData, word(PatientNew_EGN));
          end;
          vvCl132:
          begin
            dataPat := vtrGraph.GetNodeData(node.Parent.Parent);
            pat := ADB_DM.ACollPatGR.Items[dataPat.index];
            CellText := DateToStr(pat.lstGraph[data.index].startDate) + ' - ' + DateToStr(pat.lstGraph[data.index].endDate);
            cl132 := pat.lstGraph[data.index].Cl132;
            cl132_CL136 := cl132.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL132_CL136_Mapping));
            case cl132_CL136[1] of
              '1':
              begin
                if cl132.FPregled <> nil then
                begin
                  strtDate := TRealPregledNewItem(cl132.FPregled).getDateMap(Adb_DM.AdbMain.Buf, Adb_DM.AdbMain.FPosData, word(PregledNew_START_DATE));
                  CellText := DateToStr(strtDate) + #13#10 + CellText;
                end;
              end;
            else
              begin
                pr001 := cl132.FListPr001[0];
                CellText := CellText + #13#10 + pr001.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(PR001_Specialty_CL006));//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz ne e since a rule
              end;
            end;
          end;
          vvPr001:
          begin
            if node.Parent.parent.parent = nil then
            begin
              CellText := 'errrrr';
              exit;
            end;
            dataCL132 := vtrGraph.GetNodeData(node.Parent);
            dataPat := vtrGraph.GetNodeData(node.Parent.Parent.parent);
            pat := ADB_DM.ACollPatGR.Items[dataPat.index];
            cl132 := pat.lstGraph[dataCL132.index].Cl132;
            pr001 := cl132.FListPr001[data.index];
            CellText := pr001.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(PR001_Activity_ID));

            if pr001.CL142 <> nil then
            begin
              CellText := CellText + #13#10 + pr001.CL142.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL142_nhif_code));
            end;
            if pr001.FExamAnal <> nil then
            begin
              strtDate := TRealExamAnalysisItem(pr001.FExamAnal).getDateMap(Adb_DM.AdbMain.Buf, Adb_DM.AdbMain.FPosData, word(ExamAnalysis_DATA));
              CellText := DateToStr(strtDate) + #13#10 + CellText;
            end;
          end;
          vvCL088:
          begin
            dataPr001 := vtrGraph.GetNodeData(node.Parent);
            dataCL132 := vtrGraph.GetNodeData(node.Parent.Parent);
            dataPat := vtrGraph.GetNodeData(node.Parent.Parent.parent.parent);
            pat := ADB_DM.ACollPatGR.Items[dataPat.index];
            cl132 := pat.lstGraph[dataCL132.index].Cl132;
            pr001 := cl132.FListPr001[dataPr001.index];
            CL142 := pr001.CL142;
            cl088 := CL142.FListCL088[data.index];
            CellText := cl088.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL088_Description));
          end;
          vvCl134:
          begin
            dataCL132 := vtrGraph.GetNodeData(node.Parent.Parent);
            dataPr001 := vtrGraph.GetNodeData(node.Parent);
            dataPat := vtrGraph.GetNodeData(node.Parent.Parent.parent.parent);
            pat := ADB_DM.ACollPatGR.Items[dataPat.index];
            cl132 := pat.lstGraph[dataCL132.index].Cl132;
            pr001 := cl132.FListPr001[dataPr001.index];
            cl134 := pr001.LstCl134[data.index];
            case cl134.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL134_CL028))[1] of
              '1': CellText := 'Количествено представяне';
              '2': CellText := 'Категоризация по номенклатура';
              '3': CellText := 'Описателен метод';
              '4': CellText := 'Конкретна дата';
              '5': CellText := 'Положително или отрицателно';
            end;
          end;
        end;
      end;
    end;
    2:
    begin
      //CellText := TRttiEnumerationType.GetName(Data.vid);
      case data.vid of
        vvPatient:
        begin
          dataPat := vtrGraph.GetNodeData(node);
          pat := ADB_DM.ACollPatGR.Items[dataPat.index];
          CellText := 'има общо: ' + IntToStr(pat.FPregledi.Count) + ' прегледа';
        end;
        vvCL088:
        begin
          dataPat := vtrGraph.GetNodeData(node.Parent.Parent.parent.parent);
          pat := ADB_DM.ACollPatGR.Items[dataPat.index];
          dataPr001 := vtrGraph.GetNodeData(node.Parent);
          dataCL132 := vtrGraph.GetNodeData(node.Parent.Parent);
          cl132 := pat.lstGraph[dataCL132.index].Cl132;
          pr001 := cl132.FListPr001[dataPr001.index];
          CL142 := pr001.CL142;
          cl088 := CL142.FListCL088[data.index];
          CellText := cl088.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL088_cl028));
        end;
        vvPr001:
        begin
          if node.Parent.parent.parent = nil then
            begin
              CellText := 'errrrr';
              exit;
            end;
          dataCL132 := vtrGraph.GetNodeData(node.Parent);
          dataPat := vtrGraph.GetNodeData(node.Parent.Parent.parent);
          pat := ADB_DM.ACollPatGR.Items[dataPat.index];
          cl132 := pat.lstGraph[dataCL132.index].Cl132;
          pr001 := cl132.FListPr001[data.index];
          begin
            case pr001.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(PR001_Nomenclature))[5] of
              '2': CellText := 'Изследвания';
              '0': CellText := 'Дейност по профилактика';
              '3': CellText := 'Въпроси';
              '8': CellText := 'Имунизации';
            end;
          end;
        end;
        vvCl132:
        begin
          dataPeriod := vtrGraph.GetNodeData(node.Parent);
          dataPat := vtrGraph.GetNodeData(node.Parent.Parent);
          pat := ADB_DM.ACollPatGR.Items[dataPat.index];
          case dataPeriod.index of
            -1: //минали
            begin
              CellText := '++' + inttostr(DaysBetween(pat.lstGraph[data.index].endDate, UserDate));
            end;
            -2: //текущи
            begin
              cl132 := pat.lstGraph[data.index].Cl132;

              CellText := '+' + inttostr(DaysBetween(pat.lstGraph[data.index].endDate, UserDate));
            end;
            -3: //бъдещи
            begin
              CellText := '-' + inttostr(DaysBetween(pat.lstGraph[data.index].startDate, UserDate));
            end;
          end;

        end;
      end;
    end;
  end;

end;

procedure TfrmSuperHip.vtrGraphGetText1(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  data, dataCL132, dataPr001, dataCl134, dataPeriod: PAspRec;
  cl132: TRealCL132Item;
  cl134: TCL134Item;
  pr001: TRealPR001Item;
  CL142: TRealCl142Item;
  CL088: TRealCL088Item;
  //pat: TRealPatientNewItem;
  preg: TRealPregledNewItem;
  i: integer;
  cl132_CL136: string;
  strtDate: TDate;
begin
  if node = nil then Exit;
  if FmxProfForm = nil then exit;

  data := vtrGraph.GetNodeData(node);
  case Column of
    0:
    begin
      case data.index of
        -1: CellText := 'минали';
        -2: CellText := 'текущи';
        -3: CellText := 'бъдещи';

      else
        case data.vid of
          vvNone:
          begin
            CellText := 'Графици';
          end;
          vvCl132:
          begin
            //dataPat := vtrGraph.GetNodeData(node.Parent.parent);
            //pat := lstPatGraph[dataPat.index];
            cl132 := FmxProfForm.Patient.lstGraph[data.index].Cl132;
            CellText := cl132.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.CL132Coll.posData, word(CL132_Key));
            CellText := CellText + '  ' + Cl132.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.CL132Coll.posData, word(CL132_Display_Value_BG));
          end;
          vvPr001:
          begin
            if node.Parent.parent.parent = nil then
            begin
              CellText := 'errrrr';
              exit;
            end;
            //dataPat := vtrGraph.GetNodeData(node.Parent.parent.parent);

            //pat := lstPatGraph[dataPat.index];
            dataCL132 := vtrGraph.GetNodeData(node.Parent);
            cl132 := FmxProfForm.Patient.lstGraph[dataCL132.index].Cl132;
            pr001 := cl132.FListPr001[data.index];
            CellText := pr001.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(PR001_Description));
            if (pr001.CL142 <> nil)  and (pr001.CL142.FListCL088.Count =1) then
            begin
              cl088 := pr001.CL142.FListCL088[0];
              CellText  := CellText + ' cl088 ' + CL088.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL088_cl028));
            end;
            //else  if pr001.CL133 <> TCL133.CL133_none  then
//            begin
//              CellText :=CellText + ' cl133 ' +  TRttiEnumerationType.GetName(pr001.CL133);
//            end
//            else  if (pr001.CL142 <> nil)  then
//            begin
//              if pr001.CL142.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL142_Key)) = '65-360' then
//                Caption := '';
//              CellText :=CellText + ' cl142 ' +  pr001.CL142.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL142_Key));
//            end;
          end;
          vvCL088:
          begin
            dataPr001 := vtrGraph.GetNodeData(node.Parent);
            //dataPat := vtrGraph.GetNodeData(node.Parent.Parent.Parent.Parent);
            //pat := lstPatGraph[dataPat.index];
            dataCL132 := vtrGraph.GetNodeData(node.Parent.Parent);
            cl132 := FmxProfForm.Patient.lstGraph[dataCL132.index].Cl132;
            pr001 := cl132.FListPr001[dataPr001.index];
            CL142 := pr001.CL142;
            cl088 := CL142.FListCL088[data.index];
            CellText := cl088.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL088_Description));
          end;
          vvCl134:
          begin
            //dataPat := vtrGraph.GetNodeData(node.Parent.Parent.Parent.Parent);
            //pat := lstPatGraph[dataPat.index];
            dataCL132 := vtrGraph.GetNodeData(node.Parent.Parent);
            dataPr001 := vtrGraph.GetNodeData(node.Parent);
            cl132 := FmxProfForm.Patient.lstGraph[dataCL132.index].Cl132;
            pr001 := cl132.FListPr001[dataPr001.index];
            cl134 := pr001.LstCl134[data.index];
            CellText := cl134.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL134_Description));
          end;
          vvPatient:
          begin
            //pat := lstPatGraph[data.index];
            CellText := FmxProfForm.Patient.getAnsiStringMap(Adb_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(PatientNew_FNAME));
            CellText := CellText + ' ' + FmxProfForm.Patient.getAnsiStringMap(Adb_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(PatientNew_SNAME));
            CellText := CellText + ' ' + FmxProfForm.Patient.getAnsiStringMap(Adb_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(PatientNew_LNAME));
          end;
        end;
      end;
    end;
    1:
    begin
      case data.index of
        -1: ;//CellText := 'минали';
        -2: //CellText := 'текущи';
        begin
          if data.DataPos <> MaxInt then
          begin
            cl132 := FmxProfForm.Patient.lstGraph[data.DataPos].Cl132;
            CellText := cl132.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.CL132Coll.posData, word(CL132_Key));
            CellText := CellText + '  ' + Cl132.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.CL132Coll.posData, word(CL132_Display_Value_BG));
          end;
        end;
        -3: ;//CellText := 'бъдещи';

      else
        case data.vid of
          vvPatient:
          begin
            //pat := lstPatGraph[data.index];
            CellText := 'ЕГН ' + FmxProfForm.Patient.getAnsiStringMap(Adb_DM.AdbMain.Buf, ADB_DM.CollPatient.posData, word(PatientNew_EGN));
          end;
          vvCl132:
          begin
            //dataPat := vtrGraph.GetNodeData(node.Parent.parent);
            //pat := lstPatGraph[dataPat.index];
            CellText := DateToStr(FmxProfForm.Patient.lstGraph[data.index].startDate) + ' - ' + DateToStr(FmxProfForm.Patient.lstGraph[data.index].endDate);
            cl132 := FmxProfForm.Patient.lstGraph[data.index].Cl132;
            cl132_CL136 := cl132.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL132_CL136_Mapping));
            //if cl132_CL136 = '1' then
            case cl132_CL136[1] of
              '1':
              begin
                if cl132.FPregled <> nil then
                begin
                  strtDate := TRealPregledNewItem(cl132.FPregled).getDateMap(Adb_DM.AdbMain.Buf, Adb_DM.AdbMain.FPosData, word(PregledNew_START_DATE));
                  CellText := DateToStr(strtDate) + #13#10 + CellText;
                end;
              end;
              //'2':
//              begin
//                if cl132.FExamAnal <> nil then
//                begin
//                  strtDate := TRealExamAnalysisItem(cl132.FExamAnal).getDateMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, word(ExamAnalysis_DATA));
//                  CellText := DateToStr(strtDate) + #13#10 + CellText;
//                end;
//              end;
            else
              begin
                pr001 := cl132.FListPr001[0];
                CellText := CellText + #13#10 + pr001.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(PR001_Specialty_CL006));//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz ne e since a rule
              end;
            end;
          end;
          vvPr001:
          begin
            if node.Parent.parent.parent = nil then
            begin
              CellText := 'errrrr';
              exit;
            end;
            //dataPat := vtrGraph.GetNodeData(node.Parent.Parent.Parent);
            //pat := lstPatGraph[dataPat.index];
            dataCL132 := vtrGraph.GetNodeData(node.Parent);
            cl132 := FmxProfForm.Patient.lstGraph[dataCL132.index].Cl132;
            pr001 := cl132.FListPr001[data.index];
            //if pr001.FExamAnal <> nil then
//              Exit;
            CellText := pr001.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(PR001_Activity_ID));

            if pr001.CL142 <> nil then
            begin
              CellText := CellText + #13#10 + pr001.CL142.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL142_nhif_code));
            end;
            if pr001.FExamAnal <> nil then
            begin
              strtDate := TRealExamAnalysisItem(pr001.FExamAnal).getDateMap(Adb_DM.AdbMain.Buf, Adb_DM.AdbMain.FPosData, word(ExamAnalysis_DATA));
              CellText := DateToStr(strtDate) + #13#10 + CellText;
            end;
          end;
          vvCL088:
          begin
            dataPr001 := vtrGraph.GetNodeData(node.Parent);
            //dataPat := vtrGraph.GetNodeData(node.Parent.Parent.Parent.Parent);
            //pat := lstPatGraph[dataPat.index];
            dataCL132 := vtrGraph.GetNodeData(node.Parent.Parent);
            cl132 := FmxProfForm.Patient.lstGraph[dataCL132.index].Cl132;
            pr001 := cl132.FListPr001[dataPr001.index];
            CL142 := pr001.CL142;
            cl088 := CL142.FListCL088[data.index];
            CellText := cl088.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL088_Description));
          end;
          vvCl134:
          begin
            //dataPat := vtrGraph.GetNodeData(node.Parent.Parent.Parent.Parent);
            //pat := lstPatGraph[dataPat.index];
            dataCL132 := vtrGraph.GetNodeData(node.Parent.Parent);
            dataPr001 := vtrGraph.GetNodeData(node.Parent);
            cl132 := FmxProfForm.Patient.lstGraph[dataCL132.index].Cl132;
            pr001 := cl132.FListPr001[dataPr001.index];
            cl134 := pr001.LstCl134[data.index];
            case cl134.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL134_CL028))[1] of
              '1': CellText := 'Количествено представяне';
              '2': CellText := 'Категоризация по номенклатура';
              '3': CellText := 'Описателен метод';
              '4': CellText := 'Конкретна дата';
              '5': CellText := 'Положително или отрицателно';
            end;
          end;
        end;
      end;
    end;
    2:
    begin
      case data.vid of
        vvPatient:
        begin
          //pat := lstPatGraph[data.index];
          CellText := 'има общо: ' + IntToStr(FmxProfForm.Patient.FPregledi.Count) + ' прегледа';
        end;
        vvCL088:
        begin
          dataPr001 := vtrGraph.GetNodeData(node.Parent);
          //dataPat := vtrGraph.GetNodeData(node.Parent.Parent.Parent.Parent);
          //pat := lstPatGraph[dataPat.index];
          dataCL132 := vtrGraph.GetNodeData(node.Parent.Parent);
          cl132 := FmxProfForm.Patient.lstGraph[dataCL132.index].Cl132;
          pr001 := cl132.FListPr001[dataPr001.index];
          CL142 := pr001.CL142;
          cl088 := CL142.FListCL088[data.index];
          CellText := cl088.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL088_cl028));
        end;
        vvPr001:
        begin
          if node.Parent.parent.parent = nil then
            begin
              CellText := 'errrrr';
              exit;
            end;
          //dataPat := vtrGraph.GetNodeData(node.Parent.parent.Parent);
          //pat := lstPatGraph[dataPat.index];
          dataCL132 := vtrGraph.GetNodeData(node.Parent);
          cl132 := FmxProfForm.Patient.lstGraph[dataCL132.index].Cl132;
          pr001 := cl132.FListPr001[data.index];
          //if pr001.CL050 <> nil then
          begin
            //CellText := pr001.getAnsiStringMap(bufNom, PR001Coll.posData, word(PR001_Nomenclature));
            case pr001.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(PR001_Nomenclature))[5] of
              '2': CellText := 'Изследвания';
              '0': CellText := 'Дейност по профилактика';
              '3': CellText := 'Въпроси';
              '8': CellText := 'Имунизации';
            end;
          end;
        end;
        vvCl132:
        begin
          //dataPat := vtrGraph.GetNodeData(node.Parent.Parent);
          //pat := lstPatGraph[dataPat.index];
          dataPeriod := vtrGraph.GetNodeData(node.Parent);
          case dataPeriod.index of
            -1: //минали
            begin
              CellText := '++' + inttostr(DaysBetween(FmxProfForm.Patient.lstGraph[data.index].endDate, UserDate));
            end;
            -2: //текущи
            begin
              cl132 := FmxProfForm.Patient.lstGraph[data.index].Cl132;
              //if cl132.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, word(CL132_CL136_Mapping)) = '1' then
//              begin
//                //for i := 0 to CurrentPatient.FPregledi.Count - 1 do
////                begin
////                  preg := CurrentPatient.FPregledi[i];
////                  preg.StartDate := preg.getDateMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, word(PregledNew_START_DATE));
////                  if (CurrentPatient.lstGraph[data.index].startDate <= preg.StartDate) and
////                     (CurrentPatient.lstGraph[data.index].endDate >= preg.StartDate)  then
////                  begin
////                    if TRealCl132Item(preg.Cl132) = CurrentPatient.lstGraph[data.index].Cl132 then
////                    begin
////                      CellText := 'ima preg';
////                      exit;
////                    end;
////                  end;
////                end;
//              end;
              CellText := '+' + inttostr(DaysBetween(FmxProfForm.Patient.lstGraph[data.index].endDate, UserDate));
            end;
            -3: //бъдещи
            begin
              CellText := '-' + inttostr(DaysBetween(FmxProfForm.Patient.lstGraph[data.index].startDate, UserDate));
            end;
          end;

        end;
      end;
    end;
  end;

end;

procedure TfrmSuperHip.vtrGraphInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  Node.States := node.States + [vsMultiline] + [vsHeightMeasured];
end;

procedure TfrmSuperHip.vtrGraphNodeClick(Sender: TBaseVirtualTree; const HitInfo: THitInfo);
begin
  //
end;

procedure TfrmSuperHip.vtrHelpHipChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  DecompressionStream: TStream;
  LocalHeader: TZipHeader;
begin
  //pgcWork.ActivePage := tsRTF;
  InternalChangeWorkPage(tsRTF);
  //DecompressionStream := nil;
  AZipHelpFile.Read(node.Index, DecompressionStream, LocalHeader);
  if frRTF = nil then
  begin
    frRTF := frxRichEdit.TRxRichEdit.Create(Self);
    frRTF.Parent := tsRTF;
    frRTF.Align := alClient;
    btnIn.Parent := frRTF;
    frRTF.OnURLClick := URLClick;
  end;

  DecompressionStream.Position := 0;
  frRTF.Lines.LoadFromStream(DecompressionStream);
  //FreeAndNil(DecompressionStream);
end;

procedure TfrmSuperHip.vtrHelpHipGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);

begin
  CellText := AZipHelpFile.FileName[node.Index];

end;

procedure TfrmSuperHip.vtrLinkOptionsChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  data: PAspRec;
begin
  exit;
  if Node = nil then
    Node := vtrLinkOptions.GetFirstSelected();
  if Node = nil then Exit;
  FmxOptionsFrm.OptionNode := Node;

  ShowOptionsFMX;
  //data := Pointer(PByte(Node) + lenNode);
//  case data.vid of
//    vvPregledRoot:
//    begin
//      ShowOptionsFMX;
//    end;
//  end;
end;

procedure TfrmSuperHip.vtrLinkOptionsChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
var
  CollRoot: PVirtualNode;
  Coll: TBaseCollection;
  propIndex: Word;
  colIndex: Integer;
  data: PAspRec;
begin
  Stopwatch := TStopwatch.StartNew;
  data := Pointer(PByte(Node) + lenNode);
  case data.vid of
    vvFieldSearchGridOption:
    begin
      CollRoot := Node.Parent.Parent;
      Coll := GetCollectionFromRoot(CollRoot);
      Coll.ApplyVisibilityFromTree(CollRoot);
      propIndex := node.index + 1;
      colIndex := node.Dummy;
      if NewState = csCheckedNormal then
      begin
        grdSearch.Columns[propIndex].Visible := true;
      end
      else
      begin
        grdSearch.Columns[propIndex].Visible := false;
      end;
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( 'check ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.vtrLinkOptionsDragAllowed(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
   Allowed := True;
end;

procedure TfrmSuperHip.vtrLinkOptionsDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  SrcRoot: PVirtualNode;
  Coll: TBaseCollection;
  pSource, pTarget: PVirtualNode;
  attMode: TVTNodeAttachMode;
begin
  SrcRoot := GetRootForNode(Sender.FocusedNode);
  if SrcRoot = nil then Exit;

  // точната колекция
  Coll := GetCollectionFromRoot(SrcRoot);
  if Coll = nil then Exit;

  pSource := TVirtualStringTree(Source).FocusedNode;
  pTarget := Sender.DropTargetNode;

  case Mode of
    dmNowhere: attMode := amNoWhere;
    dmAbove: attMode := amInsertBefore;
    dmOnNode, dmBelow: attMode := amInsertAfter;
  end;

  Sender.MoveTo(pSource, pTarget, attMode, False);

  // обнови масива за колонките
  Coll.UpdateOrderArrayFromTree(SrcRoot);


  // рефреш на грида, само ако работи с тази колекция
  if grdSearch.Tag = Integer(Coll) then
  begin
    Coll.OrderFieldsSearch1(grdSearch);
  end;

  Effect := DROPEFFECT_MOVE;
end;


procedure TfrmSuperHip.vtrLinkOptionsDragDropFMX(Sender: TObject;
  var IsDropted: Boolean);
var
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  TreeLink, TargetNode: PVirtualNode;
  AttachMode: TVTNodeAttachMode;
begin
  if DragObj <> nil then
  begin
    //vtrPregledPat.Selected[vtrPregledPat.DropTargetNode] := True;
    case DragObj.DropMode of
      dmNowhere: AttachMode := amAddChildLast;
      dmAbove: AttachMode := amInsertBefore;
      dmBelow: AttachMode := amInsertAfter;
      dmOnNode: AttachMode := amAddChildLast;
    end;
    TargetNode := vtrLinkOptions.DropTargetNode;
    if TargetNode = nil then
    begin
      TargetNode := vtrLinkOptions.RootNode.FirstChild;
    end;
    //caption := TRttiEnumerationType.GetName(DragObj.DropMode);

    Stopwatch := TStopwatch.StartNew;
    vtrLinkOptions.BeginUpdate;

    AspectsOptionsLinkFile.AddNewNode(TVtrVid(DragObj.VtrType), 0, TargetNode, AttachMode, TreeLink, linkPos);

    vtrLinkOptions.EndUpdate;
    //vtrPregledPat.UpdateScrollBars(true);
    //vtrPregledPat.InvalidateToBottom(vtrPregledPat.RootNode);

    Elapsed := Stopwatch.Elapsed;
    mmoTest.Lines.Add( 'newLinkNode ' + FloatToStr(Elapsed.TotalMilliseconds));
    vtrLinkOptions.DropTargetNode := nil;
    IsDropted := True;
    DragObj := nil;
  end
  else
    IsDropted := False;
end;

procedure TfrmSuperHip.vtrLinkOptionsDragOver(Sender: TBaseVirtualTree;
  Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
  Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
var
  SrcNode, TgtNode: PVirtualNode;
begin
  SrcNode := Sender.FocusedNode;
  TgtNode := Sender.DropTargetNode;

  if (SrcNode = nil) or (TgtNode = nil) and (SrcNode = TgtNode) then Exit;

  // само в рамките на една и съща колекция
  if GetRootForNode(SrcNode) <> GetRootForNode(TgtNode) then Exit;

  // Допускане на drop
  Accept := True;
end;

procedure TfrmSuperHip.vtrLinkOptionsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data, dataParent: PAspRec;
begin
  data := Pointer(PByte(Node) + lenNode);
  case Column of
    0:
    begin
      case data.vid of
        vvOblast:
        begin
          CellText := FNasMesto.OblColl.getAnsiStringMap(Data.DataPos, word(Oblast_OblastName))
           + ' ' + IntToStr(FNasMesto.OblColl.getwordMap(Data.DataPos, word(Oblast_OblastID)))
        end;
        vvObshtina:
        begin
          CellText := FNasMesto.obshtColl.getAnsiStringMap(Data.DataPos, word(Obshtina_ObshtinaName));
          CellText := CellText + ' ' + IntToStr(FNasMesto.obshtColl.getWordMap(Data.DataPos, word(Obshtina_RZOKR)));
        end;
        vvNasMesto:
        begin
          CellText := FNasMesto.nasMestoColl.getAnsiStringMap(Data.DataPos, word(NasMesto_NasMestoName));
          CellText := CellText + ' ' + FNasMesto.obshtColl.getAnsiStringMap(Data.DataPos, word(NasMesto_RCZR));
        end;
        vvPregled:
        begin
          //if CollPregled <> nil then

          //CellText := CollPregled.getAnsiStringMap(data.DataPos, word(PregledNew_TERAPY));
        end;
        vvFieldSearchGridOption:
        begin
          dataParent := Pointer(PByte(Node.Parent.parent) + lenNode);
          case dataParent.vid of
            vvPregledNewRoot: CellText := ADB_DM.CollPregled.DisplayName(node.Dummy - 1);
            vvPatientNewRoot: CellText := ADB_DM.CollPatient.DisplayName(node.Dummy - 1);
          end;

        end
      else
        begin
          CellText := IntToStr(Cardinal(Pointer(PByte(Node) - PByte(AspectsOptionsLinkFile.Buf))));
        end;
      end;
    end;
    1:
    begin
      case data.vid of
        vvFieldSearchGridOption: CellText := format('PropIndex = %d  ;  ColIndex = %d', [node.Dummy, Node.Index + 1]); //IntToStr(node.Index);
      end;
    end;
    2:
    begin
      CellText := TRttiEnumerationType.GetName(Data.vid);
    end;
  end;
end;

procedure TfrmSuperHip.vtrMinaliPreglediAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);
var
  r1, r2: TRect;
begin
  Exit;
  if Column = 1 then
  begin
    r1 := vtrMinaliPregledi.GetDisplayRect(Node, Column, False, false);
    r2 := vtrMinaliPregledi.GetDisplayRect(Node, 0, False, false);
    r1.Left := r2.Left;
    TargetCanvas.Ellipse(r1);
  end;
end;

procedure TfrmSuperHip.vtrMinaliPreglediBeforeAutoFitColumn(Sender: TVTHeader;
  Column: TColumnIndex; var SmartAutoFitType: TSmartAutoFitType;
  var Allowed: Boolean);
begin
  if Column = 0 then
    Allowed := False;
end;

procedure TfrmSuperHip.vtrMinaliPreglediColumnClick(Sender: TBaseVirtualTree; Column: TColumnIndex; Shift: TShiftState);
begin
  Caption := IntToStr(Column);
end;

procedure TfrmSuperHip.vtrMinaliPreglediCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  data1, data2: PAspRec;
  date1, date2: TDate;
begin
  data1 := vtrMinaliPregledi.GetNodeData(node1);
  if data1.DataPos = 0 then
  begin
    Result := 1;
    Exit;
  end;
  data2 := vtrMinaliPregledi.GetNodeData(node2);
  if data2.DataPos = 0 then
  begin
    Result := -1;
    Exit;
  end;

  preg1.DataPos := data1.DataPos;
  preg2.DataPos := data2.DataPos;
  date1 := preg1.getDateMap(Adb_DM.AdbMain.Buf, Adb_DM.AdbMain.FPosData, word(PregledNew_START_DATE));
  date2 := preg2.getDateMap(Adb_DM.AdbMain.Buf, Adb_DM.AdbMain.FPosData, word(PregledNew_START_DATE));
  Result := floor(date1) - floor(date2);
end;

procedure TfrmSuperHip.vtrMinaliPreglediDrawButton(sender: TVirtualStringTreeHipp; node: PVirtualNode; var ButonVisible: Boolean; const numButton: Integer;
  var imageIndex: Integer);
begin
  //ButonVisible := True;
end;

procedure TfrmSuperHip.vtrMinaliPreglediGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data, dataPat, dataDiag: PAspRec;
  cl132: TRealCl132Item;
  gr: TGraphPeriod132;
  i: integer;
  vPreg, vDiag: PVirtualNode;
  mkb: string;
  logicalPregled: TlogicalPregledNewSet;

  //pat: TPatientItem;
  //preg: TPregledItem;
begin
  data := Sender.GetNodeData(node);
  //dataPat := Sender.GetNodeData(PVirtualNode(Sender.tag));
  //pat := CollPatient.Items[dataPat.index];
  case data.vid of
    vvCl132:
    begin
      case Column of
        0:
        begin
          CellText := IntToStr(FmxProfForm.Patient.lstGraph.Count);
          if FmxProfForm.Patient.lstGraph.Count = 0 then Exit;
          if FmxProfForm.Patient.CurrentGraphIndex < 0 then Exit;
          if FmxProfForm.Patient.CurrentGraphIndex > FmxProfForm.Patient.lstGraph.Count - 1 then  Exit;

          CellText := FmxProfForm.Patient.lstGraph[FmxProfForm.Patient.CurrentGraphIndex].Cl132.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.CL132Coll.posData, word(CL132_Key));
          CellText := CellText + '   ' + 'има да се правят толкова неща';
          //for i := 0 to FmxProfForm.Patient.lstGraph.Count - 1 do
//          begin
//            gr := FmxProfForm.Patient.lstGraph[i];
//            if (Date <= gr.endDate) and (Date >= gr.startDate) then  // текущи
//            begin
//              if FmxProfForm.Patient.lstGraph[i].Cl132.getAnsiStringMap(AspectsNomFile.Buf, CL132Coll.posData, word(CL132_CL136_Mapping)) = '1' then
//              begin
//                CellText := FmxProfForm.Patient.lstGraph[i].Cl132.getAnsiStringMap(AspectsNomFile.Buf, CL132Coll.posData, word(CL132_Key));
//                CellText := CellText + '   ' + 'има да се правят толкова неща';
//                Exit;
//              end;
//            end;
//          end;


        end;
        //1: CellText := IntToStr(PregledTemp.getIntMap(AspectsHipFile.Buf, CollPregled.posData, word(PregledNew_AMB_LISTN)));
        //2: CellText := PregledTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(PregledNew_AMB_LISTN));
        //3: CellText := PregledTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(PregledNew_NRN));
        //4: CellText := preg.MedNaprStr;
      end;
    end;
    vvPregled: //pregled
    begin
      case Column of

        0: CellText := DateTimeToStr(ADB_DM.CollPregled.getDateMap(data.DataPos, word(PregledNew_START_DATE)));
        1: CellText := IntToStr(ADB_DM.CollPregled.getIntMap(data.DataPos, word(PregledNew_AMB_LISTN)));
        2:
        begin
          vPreg := Pvirtualnode(data.index);
          vDiag := vPreg.FirstChild;
          while vDiag <> nil do
          begin
            dataDiag := pointer(PByte(vDiag) + lenNode);
            if dataDiag.vid = vvDiag then
            begin
              mkb := Adb_DM.CollDiag.getAnsiStringMap(data.DataPos, word(Diagnosis_code_CL011));
              CellText := CellText + ',' + mkb;
            end;
            vDiag := vDiag.NextSibling;
          end;
        end;
        3: CellText := ADB_DM.CollPregled.getAnsiStringMap(data.DataPos, word(PregledNew_NRN_LRN));
        //4: CellText := preg.MedNaprStr;
        5:
        begin
          logicalPregled := TlogicalPregledNewSet(ADB_DM.CollPregled.getLogical40Map(data.DataPos, word(PregledNew_Logical)));
          if TLogicalPregledNew.IS_PRIMARY in logicalPregled then
          begin
            CellText := 'Първичен';
          end
          else
          begin
            CellText := 'Вторичен';
          end;
        end;
      end;
    end;
  end;
end;

//procedure TfrmSuperHip.vtrMinaliPreglediCompareNodes(Sender: TBaseVirtualTree;
//   Node1, Node2: PVirtualNode;
//   Column: TColumnIndex; var Result: Integer);
//var
//  pat: TPatientItem;
//  preg1, preg2: TPregledItem;
//  data1, data2, dataPat: PNodeRec;
//begin
//  if Column <> 0 then Exit;
//  dataPat := Sender.GetNodeData(PVirtualNode(Sender.tag));
//  pat := CollPatient.Items[dataPat.index];
//  data1 := Sender.GetNodeData(Node1);
//  data2 := Sender.GetNodeData(Node2);
//  preg1 := pat.FPregledi[data1.index];
//  preg2 := pat.FPregledi[data2.index];
//  if preg1.StartDate > preg2.StartDate then
//     Result := 1
//  else
//  if preg1.StartDate < preg2.StartDate then
//    Result := -1
//  else
//    Result := 0;
// //Result := CompareValue(preg1.StartDate, preg2.StartDate);
//
//  // Floor(preg1.StartDate) - Floor(preg2.StartDate);
//end;

//procedure TfrmSuperHip.vtrMinaliPreglediGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
//  var CellText: string);
//var
//  data, dataPat: PAspRec;
//  pat: TPatientItem;
//  preg: TPregledItem;
//begin
//  data := Sender.GetNodeData(node);
//  dataPat := Sender.GetNodeData(PVirtualNode(Sender.tag));
//  pat := CollPatient.Items[dataPat.index];
//  case data.vid of
//    vvPregled: //pregled
//    begin
//      preg := pat.FPregledi[data.index];
//      case Column of
//        0: CellText := DateTimeToStr(preg.StartDate);
//        1: CellText := IntToStr(preg.AmbListNo);
//        2: CellText := preg.DiagnosisStr;
//        3: CellText := preg.NRN;
//        4: CellText := preg.MedNaprStr;
//      end;
//    end;
//  end;
//end;

procedure TfrmSuperHip.vtrNewAnalGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  data: PAspRec;
  posCl22: cardinal;//AspectsNomHipFile.Buf
begin
  if Sender = vtrNewAnal then
    data := pointer(PByte(Node) + lenNode)
  else
    data := Sender.GetNodeData(node);
  case data.vid of
    vvAnal, vvAnalPackage:
    begin
      case Column of
        0:
        begin
          //AnalTemp.DataPos := data.DataPos;
          CellText := ADB_DM.CollAnalsNew.getAnsiStringMap(data.DataPos, word(AnalsNew_AnalName));
        end;
        1:
        begin
          AnalTemp.DataPos := data.DataPos;
          posCl22 := AnalTemp.getcardMap(ADB_DM.CollAnalsNew.Buf, ADB_DM.CollAnalsNew.posData, word(AnalsNew_CL022_pos));
          if posCl22 > 0 then
          begin
            //Cl022temp.DataPos := posCl22;
            CellText := ADB_DM.CL022Coll.getAnsiStringMap(posCl22, word(CL022_Key));
            CellText := CellText + ' / ' + ADB_DM.CL022Coll.getAnsiStringMap(posCl22, word(CL022_nhif_code))
          end;
        end;
      end;

    end;
  end;

end;

procedure TfrmSuperHip.vtrNewAnalInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  Node.States := node.States + [vsMultiline] + [vsHeightMeasured];
end;

procedure TfrmSuperHip.vtrNewAnalMeasureItem(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
begin
  if vtrNewAnal.MultiLine[Node] then
  begin
    TargetCanvas.Font := Sender.Font;
    NodeHeight := vtrNewAnal.ComputeNodeHeight(TargetCanvas, Node, 0) + 10;
  end;
end;

procedure TfrmSuperHip.vtrNewAnalSaveNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Stream: TStream);
var
  data: PAspRec;
begin
  data := Pointer(PByte(Node) + lenNode);
  Stream.Write(data^, sizeof(TAspRec));
end;

procedure TfrmSuperHip.vtrNomenNzisButtonClick(sender: TVirtualStringTreeHipp; node: PVirtualNode;
  const numButton: Integer);
var
  IsTestNZIS: Boolean;
  data: PAspRec;

begin
  if ActiveSubButton = nil then
  begin
    AddCl('CL1000');
  end
  else
  if ActiveSubButton.Description = 'Ексел' then
  begin
    ImportPR001(ADB_DM.PR001Coll);
  end
  else
  if ActiveSubButton.Description = 'XML' then
  begin
    data := vtrNomenNzis.GetNodeData(node);

    case data.vid of
      vvNomenNzis:
      case numButton of
        0:
        begin
          try
            if data.index < 0 then
            begin
              ActiveSubButton.MinValue := 0;
              ActiveSubButton.Position := 0;
              ActiveSubButton.MaxValue := vRootNomenNzis.ChildCount;

              vtrNomenNzis.IterateSubtree(vRootNomenNzis, IterateSendedNzisNomen, nil);
            end
            else
            begin
              BtnSendToNzisNomen(node);
            end;
          finally

          end;
        end;
        1:
        begin
          if data.index < 0 then
          begin
            vtrNomenNzis.IterateSubtree(vRootNomenNzis, IterateSendedNzisNomen, nil);
          end
          else
          begin
            BtnXMLtoCL000(node);
          end;
        end;
        2:
        begin
          begin
            BtnSendToNzisNomenUpdate(node);
            //BtnXMLtoCL000ForUpdate(node);
          end;
        end;
      end;

    end;


  end;
end;

procedure TfrmSuperHip.vtrNomenNzisChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  data: PAspRec;
  oXml: IXMLDocument;
begin
  if node = nil then
  begin
    Node := vtrNomenNzis.GetFirstSelected();
  end;
  if Node = nil then
    Exit;
  Data := Sender.GetNodeData(Node);
  case Data.vid of
    vvNomenNzis:
    begin
      case Node.Dummy of
        0:
        begin
          //pgcWork.ActivePage := nil;
          InternalChangeWorkPage(nil);
        end;
        77:
        begin
          //pgcWork.ActivePage := tsXML;
          InternalChangeWorkPage(tsXML);
           Adb_DM.ListNomenNzisNames[data.index].xmlStream.Position := 0;
          //oXml := TXMLDocument.Create(self);
          try
            //oXml.LoadFromStream(ListNomenNzisNames[data.index].xmlStream);
//            oXml.Encoding := 'UTF-8';
//            oXml.XML.Text := Xml.XMLDoc.FormatXMLData(oXml.XML.Text);
//            ListNomenNzisNames[data.index].xmlStream.Size := 0;
//            oXml.SaveToStream(ListNomenNzisNames[data.index].xmlStream);
//            ListNomenNzisNames[data.index].xmlStream.Position := 0;
            syndtXML.Lines.LoadFromStream( Adb_DM.ListNomenNzisNames[data.index].xmlStream, TEncoding.UTF8);
          finally
            //if oXml.Active then
//            begin
//              oXml.ChildNodes.Clear;
//              oXml.Active := False;
//            end;
//            oxml := nil;
          end;
        end;
        78:
        begin
          //pgcWork.ActivePage := tsGrid;
          InternalChangeWorkPage(tsGrid);
           Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.ShowGrid(grdNom);
          mmotest.Lines.Assign(Adb_DM.ListNomenNzisNames[data.index].Cl000Coll.FieldsNames);
        end;
        79, 80:
        begin
          grdNom.ReadOnly := False;
          InternalChangeWorkPage(tsGrid);
          Adb_DM.ListNomenNzisNames[data.index].AspColl.ShowGrid(grdNom);
        end;
      end;

    end;
    vvPR001:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      DataVPregledi := data;
      //ShowDynPR001;
      ADB_DM.PR001Coll.ShowGrid(grdNom);
    end;
    vvNomenNzisUpdate:
    begin
      case Node.Dummy of
        0:
        begin
          //pgcWork.ActivePage := nil;
          InternalChangeWorkPage(nil);
        end;
        80:
        begin
          //pgcWork.ActivePage := tsXML;
          InternalChangeWorkPage(tsXML);
          Adb_DM.ListNomenNzisNames[data.index].xmlStream.Position := 0;
          //oXml := TXMLDocument.Create(self);
          try
            //oXml.LoadFromStream(ListNomenNzisNames[data.index].xmlStream);
//            oXml.Encoding := 'UTF-8';
//            oXml.XML.Text := Xml.XMLDoc.FormatXMLData(oXml.XML.Text);
//            ListNomenNzisNames[data.index].xmlStream.Size := 0;
//            oXml.SaveToStream(ListNomenNzisNames[data.index].xmlStream);
//            ListNomenNzisNames[data.index].xmlStream.Position := 0;
            syndtXML.Lines.LoadFromStream(Adb_DM.ListNomenNzisNames[data.index].xmlStream, TEncoding.UTF8);
          finally
            //if oXml.Active then
//            begin
//              oXml.ChildNodes.Clear;
//              oXml.Active := False;
//            end;
//            oxml := nil;
          end;
        end;
        //78:
//        begin
//          //pgcWork.ActivePage := tsGrid;
//          InternalChangeWorkPage(tsGrid);
//          ListNomenNzisNames[data.index].Cl000Coll.ShowGrid(grdNom);
//          mmotest.Lines.Assign(ListNomenNzisNames[data.index].Cl000Coll.FieldsNames);
//        end;
        //79, 81:
//        begin
//          grdNom.ReadOnly := False;
//          InternalChangeWorkPage(tsGrid);
//          ListNomenNzisNames[data.index].AspColl.ShowGrid(grdNom);
//        end;
      end;

    end;
  end; //case
end;

procedure TfrmSuperHip.vtrNomenNzisColumnClick(Sender: TBaseVirtualTree; Column: TColumnIndex; Shift: TShiftState);
begin
  //
end;

procedure TfrmSuperHip.vtrNomenNzisDrawButton(sender: TVirtualStringTreeHipp; node: PVirtualNode;
  var ButonVisible: Boolean; const numButton: Integer;  var imageIndex: Integer);
var
  data: PAspRec;
begin
  //if numButton > 0 then Exit;
  data := sender.GetNodeData(node);

  if ActiveSubButton = nil then
  begin
    case numButton of
      0:
      begin
        ButonVisible := True;
        imageIndex := 0;
      end;
    end;
  end
  else
  if ActiveSubButton.Description = 'Ексел' then
  begin
    ButonVisible := True;
    imageIndex := 57;
  end
  else
  if ActiveSubButton.Description = 'XML' then
  begin
    case numButton of
      0:
      begin

        case node.Dummy of
          0:
          begin
            ButonVisible := True;
            imageIndex := 86;
          end;
          77:
          begin
          end;
          78:
          begin
          end;
        end;
      end;
      1:
      begin
        if data.index < 0 then
        begin
          ButonVisible := True;
          imageIndex := 58;
        end;
        case node.Dummy of
          77:
          begin
            ButonVisible := True;
            imageIndex := 58;
          end;
          78:
          begin
            ButonVisible := True;
            imageIndex := 20;
          end;
        end;
      end;
      2:
      begin
        case node.Dummy of
          80:
          begin
            ButonVisible := True;
            imageIndex := 31;
          end;
        end;
      end;
    end;
    
  end;

end;

procedure TfrmSuperHip.vtrNomenNzisEdited(Sender: TBaseVirtualTree; Node: PVirtualNode;
    Column: TColumnIndex);
var
  Data: PAspRec;
  TempItem: TNomenNzisItem;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  dataPosition: Cardinal;
begin
  Data :=  Sender.GetNodeData(Node);
  case data.vid of
    vvNomenNzis:
    begin
      pCardinalData := pointer(PByte(AspectsNomFile.Buf) + 8);
      FPosData := pCardinalData^;
      pCardinalData := pointer(PByte(AspectsNomFile.Buf) + 12);
      FLenData := pCardinalData^;
      dataPosition :=  FPosData + FLenData;
      //for i := 0 to NomenNzisColl.Count - 1 do
//      begin
//        pregled := PregledNewColl.Items[i];
//        if pregled.PRecord <> nil then
//        begin
//          pregled.SavePregledNew(dataPosition);
//          inc(cnt);
//        end;
//
//      end;
      TempItem := ADB_DM.NomenNzisColl.items[data.index];
      New(TempItem.PRecord);
      TempItem.PRecord.setProp := [NomenNzis_NomenName, NomenNzis_NomenID];
      TempItem.PRecord.NomenName := '';
      TempItem.PRecord.NomenID := 'CL143';
      TempItem.SaveNomenNzis(dataPosition);

      pCardinalData := pointer(PByte(AspectsNomFile.Buf) + 12);
      pCardinalData^  := dataPosition - FPosData;
    end;
  end;
end;

procedure TfrmSuperHip.vtrNomenNzisGetImageIndexEx(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean;
  var ImageIndex: TImageIndex; var ImageList: TCustomImageList);
var
  Data: PAspRec;
begin
  if Kind <> TVTImageKind.ikState then
    Exit;
  Data := Sender.GetNodeData(Node);
  case Column of
    0:
    begin
      case Data.vid of
        vvNomenNzis:
        begin
          case node.Dummy of
            77: ImageIndex := 0;
            78: ImageIndex := 58;
            79: ImageIndex := 57;
            80: ImageIndex := 19;
          end;
        end;
      end; //case
    end; //0
  end;
end;

procedure TfrmSuperHip.vtrNomenNzisGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  data, dataParent: PAspRec;
  str: string;
begin
  data := vtrNomenNzis.GetNodeData(node);
  case data.vid of
    vvNomenNzis:
    begin
      case Column of
        0:
        begin
          if data.index < 0 then
          begin
            CellText := 'НЗИС номенклатури CL...';
            Exit;
          end;
         // CellText := Format('CL%.*d', [3, data.index]) ;
          if ADB_DM.NomenNzisColl.items[data.index].PRecord = nil then
          begin
            CellText := ADB_DM.NomenNzisColl.items[data.index].getAnsiStringMap(ADB_DM.NomenNzisColl.Buf, ADB_DM.NomenNzisColl.posData, word(NomenNzis_NomenID));
          end
          else
          begin
            CellText := ADB_DM.NomenNzisColl.items[data.index].PRecord.NomenID;
          end;
        end;
        1:
        begin
          if data.index < 0 then
          begin
            CellText := IntToStr( Adb_DM.ListNomenNzisNames.Count);
            Exit;
          end;

          //CellText := ListNomenNzisNames[data.index].ArrStr[0];
        end;
      end;


    end;
    vvNone: // NomenNzis_NomenID
    begin
      CellText := ADB_DM.NomenNzisColl.items[data.index].getAnsiStringMap(ADB_DM.NomenNzisColl.Buf, ADB_DM.NomenNzisColl.posData, word(NomenNzis_NomenID));
    end;
    vvNzisBiznes:
    begin
      case Column of
        0:
        begin
          if data.index < 0 then
          begin
            CellText := 'НЗИС Бизнес правила';
            Exit;
          end;

        end;
        1:
        begin
          if data.index < 0 then
          begin
            CellText := IntToStr(node.ChildCount);
            Exit;
          end;

        end;
      end;


    end;
    vvPR001:
    begin
      case Column of
        0:
        begin
          CellText := 'PR001';
        end;

      end;


    end;
    vvNomenNzisUpdate:
    begin
      dataParent := vtrNomenNzis.GetNodeData(Node.Parent);
      if ADB_DM.NomenNzisColl.items[dataParent.index].PRecord = nil then
      begin
        CellText := ADB_DM.NomenNzisColl.items[dataParent.index].getAnsiStringMap(ADB_DM.NomenNzisColl.Buf, ADB_DM.NomenNzisColl.posData, word(NomenNzis_NomenID));
      end
      else
      begin
        CellText := ADB_DM.NomenNzisColl.items[dataParent.index].PRecord.NomenID;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrNomenNzisInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  Node.States := node.States + [vsMultiline] + [vsHeightMeasured];
end;

procedure TfrmSuperHip.vtrNomenNzisNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
   Column: TColumnIndex; NewText: string);
var
  Data: PAspRec;
  TempItem: TNomenNzisItem;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  dataPosition: Cardinal;
begin
  Data :=  Sender.GetNodeData(Node);
  case data.vid of
    vvNomenNzis:
    begin
      //pCardinalData := pointer(PByte(AspectsNomFile.Buf) + 8);
//      FPosData := pCardinalData^;
//      pCardinalData := pointer(PByte(AspectsNomFile.Buf) + 12);
//      FLenData := pCardinalData^;
//      dataPosition :=  FPosData + FLenData;

      TempItem := ADB_DM.NomenNzisColl.items[data.index];
      New(TempItem.PRecord);
      TempItem.PRecord.setProp := [NomenNzis_NomenName, NomenNzis_NomenID];
      TempItem.PRecord.NomenName := '';
      TempItem.PRecord.NomenID := NewText;
     // TempItem.SaveNomenNzis(dataPosition);

      //pCardinalData := pointer(PByte(AspectsNomFile.Buf) + 12);
//      pCardinalData^  := dataPosition - FPosData;
    end;
  end;
end;

procedure TfrmSuperHip.vtrOptionsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  if Node = nil then  Exit;

  PostMessage(Self.Handle, WM_STARTEDITING, WPARAM(Node), 0);
end;

procedure TfrmSuperHip.vtrOptionsCreateEditor(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
begin
  EditLink := TOptionEditLink.Create;
end;

procedure TfrmSuperHip.vtrOptionsEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  Data: POptionData;

begin
  with Sender do
  begin
    Data := GetNodeData(Node);
    Allowed := (Sender.NodeParent[Node] <> nil) and (Column = 1) and (Data.ValueType <> vetNone);
  end;
end;

procedure TfrmSuperHip.vtrOptionsFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: POptionData;

begin
  Data := Sender.GetNodeData(Node);
  Finalize(Data^);
end;

procedure TfrmSuperHip.vtrOptionsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  data: POptionData;
begin
  data := Sender.GetNodeData(node);
  case data.vid of
    vvOptionRoot:
    begin
      CellText := 'Настройки';
    end;
    vvOptionDB:
    begin
      CellText := 'Бази данни';
    end;
    vvOptionGrids:
    begin
      CellText := 'Таблични изгледи';
    end;
    vvOptionGridSearch:
    begin
      if data.index < 0 then
      begin
        CellText := 'Изглед при търсене';
      end
      else
      begin
        CellText := TRttiEnumerationType.GetName(TTablesTypeHip(data.index));
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrOptionsGetText1(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  data: POptionData;
begin
  data := Sender.GetNodeData(node);
  case data.ValueType of
    vetNone:
    begin
      case Column of
        0:
        begin
          CellText := 'не се редактира';
        end;
        1:
        begin
          CellText := data.Value;
        end;
      end;
    end;
    vetString:
    begin
      case Column of
        0:
        begin
          CellText := 'някакъв стринг';
        end;
        1:
        begin
          CellText := data.Value;
        end;
      end;
    end;
    vetPickString:
    begin
      case Column of
        0:
        begin
          CellText := 'комбо от стрингове';
        end;
        1:
        begin
          CellText := data.Value;
        end;
      end;
    end;
    vetNumber:
    begin
      case Column of
        0:
        begin
          CellText := 'число';
        end;
        1:
        begin
          CellText := data.Value;
        end;
      end;
    end;

    vetPickNumber:
    begin
      case Column of
        0:
        begin
          CellText := 'комбо от числа';
        end;
        1:
        begin
          CellText := data.Value;
        end;
      end;
    end;
    vetMemo:
    begin
      case Column of
        0:
        begin
          CellText := 'Мемо';
        end;
        1:
        begin
          CellText := data.Value;
        end;
      end;
    end;
    vetDate:
    begin
      case Column of
        0:
        begin
          CellText := 'дата';
        end;
        1:
        begin
          CellText := data.Value;
        end;
      end;
    end;
    vetCheck:
    begin
      case Column of
        0:
        begin
          CellText := 'чекче';
        end;
        1:
        begin
          CellText := data.Value;
        end;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrPreglediChange_Patients(Sender: TBaseVirtualTree; ANode: PVirtualNode);
var
  Node: PVirtualNode;
  data, dataPat: PAspRec;
  //pat: TRealPatientNewItem;
  delta: Single;
  TL_leyaut, BR_memo: Single;
  vRun: PVirtualNode;
  i: Integer;
  CL132: TRealCl132Item;
  XmlStream: TXmlStream;
  pat: TRealPatientNewItem;
  posHist: Cardinal;
  P: ^Cardinal;
  PLen: ^Word;
  pDataHist: PCardinal;
  ofset: Cardinal;
  logDat: TLogicalData24;
begin
  FmxProfForm.Focused := nil;
  if ANode = nil then
  begin
    Node := vtrPregledPat.GetFirstSelected();
  end
  else
  begin
    Node := ANode;
  end;
  if Node = nil then
  begin
    Exit;
  end;
  data := pointer(PByte(node) + lenNode);
  case data.vid of
    vvDoctor:
    begin
      InternalChangeWorkPage(nil);
    end;

    vvPatient: // pacient
    begin
      Stopwatch := TStopwatch.StartNew;
      vtrMinaliPregledi.Tag := Cardinal(Node);
      //Adb_DM.AdbMain := AspectsHipFile;
      Adb_DM.AdbLink := AspectsLinkPatPregFile;
      XmlStream := TXmlStream.Create;
      //if Fdm.IsGP then
      begin
        //Adb_DM.CollDoc := CollDoctor;
        Adb_DM.FillXmlStreamL009(XmlStream, node);
        edtUrl.Text := Adb_DM.GetURLFromMsgType(L009, true);
        XmlStream.Position := 0;
        syndtNzisReq.Lines.LoadFromStream(XmlStream);

        FmxProfForm.Patient.DataPos := data.DataPos;
        FmxProfForm.Patient.lstGraph.Clear;
        FmxProfForm.Patient.FPregledi.Clear;
        FmxProfForm.Patient.FNode := Node;
        GetCurrentPatProf1(FmxProfForm.Patient);
      end;

      LoadVtrMinaliPregledi(node, FmxProfForm.Patient);
      if chkLockNzisMess.Checked then
      begin
        InternalChangeWorkPage(tsNZIS);
      end
      else
      begin
        InternalChangeWorkPage(tsMinaliPregledi);
      end;

      Elapsed := Stopwatch.Elapsed;
      mmoTest.Lines.Add('Minali za ' + FloatToStr(Elapsed.TotalMilliseconds));
    end;

    vvPregled: //pregled  FMX
    begin
      if not Sender.Focused then  Exit;

      dataPat := pointer(PByte(node.Parent) + lenNode);
      if chkLockNzisMess.Checked then
      begin
        InternalChangeWorkPage(tsNZIS);
      end
      else
      begin
        InternalChangeWorkPage(tsFMXForm);
      end;


      Stopwatch := TStopwatch.StartNew;

      tsFMXForm.Tag := data.DataPos;
      tsNZIS.Tag := integer(Node);


      GenerateNzisXml(node);

      ShowPregledFMX(dataPat, data, node); //  показване на динамичната форма

      //Elapsed := Stopwatch.Elapsed;
      //Caption := FloatToStr(Elapsed.TotalMilliseconds);
      if Self.Tag <> 1 then
      begin
        Self.Tag := 1;
        //vtrPreglediChange_Patients(Sender, Node);
        //Edit1.SetFocus;

      end;
    end;
    vvMDN:
    begin
      //Stopwatch := TStopwatch.StartNew;
//
//      //pgcWork.ActivePage := tsFMXForm;
//      InternalChangeWorkPage(tsFMXForm);
//      fmxCntrDyn.ChangeActiveForm(FmxTest);
//      Elapsed := Stopwatch.Elapsed;
//      Caption := FloatToStr(Elapsed.TotalMilliseconds);

    end;
    vvNZIS_QUESTIONNAIRE_ANSWER:
    begin
      syndtNzisReq.CaretY := data.index;
      syndtNzisReq.ActiveLineColor := clLime;
      FmxProfForm.VibroControl(node);
    end;
    vvNZIS_RESULT_DIAGNOSTIC_REPORT:
    begin
      FmxProfForm.VibroControl(node);
    end;
  end;
  //if Button2.Tag = 0 then
//  begin
//    Button2Click(nil);
//    //vtrPregledPat.ValidateNode(vtrPregledPat.RootNode.FirstChild.FirstChild,True);
//    Button2.Tag := 1;
//  end;


end;

procedure TfrmSuperHip.vtrPreglediChange_Pregledi(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  data: PAspRec;
  pat: TRealPatientNewItem;
begin
  if Node = nil then  Exit;

  data := pointer(PByte(node) + lenNode);
  case data.vid of
   // vvPatient: // pacient
//    begin
//      pat := CollPatient.Items[data.index];
//      vtrMinaliPregledi.Tag := Cardinal(Node);
//      LoadVtrMinaliPregledi(pat, data.index);
//      pgcWork.ActivePage := tsMinaliPregledi;
//    end;
    vvPregled: //pregled
    begin
      //ShowDynPregled(Node.Parent, node, [36]);
      //btn1Click(nil);
    end;
  end;



end;

procedure TfrmSuperHip.vtrPreglediGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
begin
  //case DataVPregledi.vid of
//    vvPatientRoot: vtrPreglediGetText_Patients(Sender, Node, Column, TextType, CellText);
//    vvPregledRoot: vtrPreglediGetText_Pregledi(Sender, Node, Column, TextType, CellText);
//  end;
end;

//procedure TfrmSuperHip.vtrPreglediGetText_Patients(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
//var
//  data, dataPat, dataPreg: PAspRec;
//  pat: TPatientItem;
//  preg: TPregledItem;
//  MN: TMedNaprItem;
//begin
//  //Exit;
//  if Node = nil then Exit;
//  data := Sender.GetNodeData(node);
//  case data.vid of
//    vvPatientRoot:
//    begin
//      case Column of
//        0: CellText := 'Прегледи по пациенти';
//        1: CellText := format('%d бр.',[vPregledi.ChildCount]) ;
//      end;
//    end;
//    vvPatient://pacienti
//    begin
//      pat := CollPatient.Items[data.index];
//      case Column of
//        0: CellText := pat.FName + ' ' + pat.SName + ' ' + pat.LName;
//        1: CellText := pat.EGN;
//      end;
//    end;
//    vvPregled: //pregledi
//    begin
//      dataPat := Sender.GetNodeData(node.Parent);
//      pat := CollPatient.Items[dataPat.index];
//      preg := pat.FPregledi[data.index];
//      case Column of
//        0: CellText := IntToStr(preg.AmbListNo);
//      end;
//    end;
//    vvMedNapr: //medNapr
//    begin
//      dataPat := Sender.GetNodeData(node.Parent.Parent);
//      pat := CollPatient.Items[dataPat.index];
//      dataPreg := Sender.GetNodeData(node.Parent);
//      preg := pat.FPregledi[dataPreg.index];
//
//      MN := preg.FMedNaprs[data.index];
//      case Column of
//        0: CellText := IntToStr(MN.number);
//      end;
//    end;
//  end;
//end;

//procedure TfrmSuperHip.vtrPreglediGetText_Pregledi(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
//  var CellText: string);
//var
//  data, dataPat, dataPreg: PAspRec;
//  pat: TPatientItem;
//  preg: TPregledItem;
//  MN: TMedNaprItem;
//begin
//  if Node = nil then Exit;
//  data := Sender.GetNodeData(node);
//  case data.vid of
//    vvPregledRoot:
//    begin
//      case Column of
//        0: CellText := 'Прегледи';
//        1: CellText := format('%d бр.',[vPregledi.ChildCount]) ;
//      end;
//    end;
//    vvPregled: //pregledi
//    begin
//      preg := CollPregled.Items[data.index];
//      case Column of
//        0: CellText := IntToStr(preg.AmbListNo);
//      end;
//    end;
//    vvMedNapr: //medNapr
//    begin
//      dataPreg := Sender.GetNodeData(node.Parent);
//      preg := CollPregled.Items[dataPreg.index];
//
//      MN := preg.FMedNaprs[data.index];
//      case Column of
//        0: CellText := IntToStr(MN.number);
//      end;
//    end;
//  end;
//end;

procedure TfrmSuperHip.vtrPreglediHotChange(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode);
begin
  //btn1Click(nil);
end;

procedure TfrmSuperHip.vtrPreglediInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  Node.States := node.States + [vsMultiline] + [vsHeightMeasured];
end;

procedure TfrmSuperHip.vtrPregledPatAdvancedHeaderDraw(Sender: TVTHeader;
    var PaintInfo: THeaderPaintInfo; const Elements: THeaderPaintElements);
var
  txt: string;
begin
  txt := PaintInfo.Column.Text;
  case PaintInfo.Column.Index of
    1, 2, 3:
    begin
      PaintInfo.TargetCanvas.Font.Color := clred;
      PaintInfo.TargetCanvas.TextRect(PaintInfo.TextRectangle, txt);
      PaintInfo.TargetCanvas.Font.Color := clblue;
    end;
    0:
    begin
      PaintInfo.TargetCanvas.Font.Color := clred;
      PaintInfo.TargetCanvas.TextRect(PaintInfo.TextRectangle, txt);
      PaintInfo.TargetCanvas.Font.Color := clblue;
    end;
  end;
  //if PaintInfo.Column.Index >2 then
//    Exit;
//  PaintInfo.TargetCanvas.Font.Color := clred;
//  txt := 'ddddd';
//  PaintInfo.TargetCanvas.TextRect(PaintInfo.TextRectangle, txt);
end;

procedure TfrmSuperHip.vtrPregledPatCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  data, dataAction: PAspRec;
  linkPos, FPosLinkData: Cardinal;
  pCardinalData: PCardinal;
  bufLink: Pointer;
  RunNode: PVirtualNode;

begin
  if not Sender.Focused  then Exit;
  if (GetKeyState(VK_CONTROL) >= 0) then Exit;

  bufLink := AspectsLinkPatPregFile.Buf;
  dataAction := pointer(PByte(node) + lenNode);
  if dataAction.vid = vvPatientNewRoot then Exit;
  vtrPregledPat.OnCollapsed := nil;
  vtrPregledPat.BeginUpdate;


 // case dataAction.vid of
    //vvPregled:
    begin
      linkPos := 100;
      pCardinalData := pointer(PByte(bufLink));
      FPosLinkData := pCardinalData^;
      while linkpos < FPosLinkData do
      begin
        RunNode := pointer(PByte(bufLink) + linkpos);
        data := pointer(PByte(RunNode) + lenNode);
        if data.vid = dataAction.vid then
        begin
          vtrPregledPat.Expanded[RunNode] := false;
        end;
        Inc(linkPos, LenData);
      end;
    end;
 // end;

  vtrPregledPat.EndUpdate;
  vtrPregledPat.OnCollapsed := vtrPregledPatCollapsed;
  vtrPregledPat.ValidateNode(vtrPregledPat.RootNode.FirstChild.FirstChild,True);
end;

procedure TfrmSuperHip.vtrPregledPatColumnClick(Sender: TBaseVirtualTree; Column: TColumnIndex;
       Shift: TShiftState);
var
  Node: PVirtualNode;
  data: PAspRec;
  i: Integer;
  RText: TRect;
  Nodetext: string;
  p: TPoint;
  ArrStr: TArray<string>;
begin
  Node := Sender.GetFirstSelected();
  if node = nil then Exit;
  data := pointer(PByte(Node) + lenNode);
  for i := 0 to Sender.Header.Columns.Count - 1 do
  begin
    vtrPregledPat.Header.Columns[i].ImageIndex := -1;
  end;
  vtrPregledPat.GetTextInfo(node, Column, vtrPregledPat.Font, RText, Nodetext);
  //vtrPregledPat.gette

  vtrPregledPat.Header.Columns[Column].ImageIndex := 29;
  edtSearhTree.Clear;
  FinderRec.vid := data.vid;
  FinderRec.IsFinded := False;
  FinderRec.node := vtrPregledPat.GetFirstSelected;
  FinderRec.strSearch  := '';
  FinderRec.LastFindedStr  := '';
  FinderRec.ACol  := Column;
  vtrPregledPat.Header.Columns[0].Text := '....';
  vtrPregledPat.Header.Columns[1].Text := 'Детайли';
  case Column of
    0:
    begin
      case data.vid of
        vvPatient:
        begin
          vtrPregledPat.Header.Columns[Column].Text := 'ЕГН на пациент';
          vtrPregledPat.Header.Columns[Column].Tag := 4;
        end;
        vvDoctor: vtrPregledPat.Header.Columns[Column].Text := 'УИН ';
        vvPerformer: vtrPregledPat.Header.Columns[Column].Text := 'УИН ';

      else
        vtrPregledPat.Header.Columns[Column].Text := '....';
      end;


    end;
    1:
    begin
      case data.vid of
        vvPatient:
        begin
          ArrStr := Nodetext.Split([' ']);
          Canvas.Font.Assign(vtrPregledPat.Font);

          p := Sender.ScreenToClient(Mouse.CursorPos);
          //vtrPregledPat.Header.Columns[Column].Text := Format('%d   %d', [p.X, p.y]);
          vtrPregledPat.Header.Columns[Column].Text := Format('%d   %d', [-RText.Left + p.x, RText.Top- p.y]);
          if (p.x - RText.Left) < (Canvas.TextWidth(ArrStr[0])) then
          begin
            vtrPregledPat.Header.Columns[Column].Text := 'Име на пациента';
            vtrPregledPat.Header.Columns[Column].Tag := 0;
          end
          else
          if (p.x - RText.Left) < (Canvas.TextWidth(ArrStr[0]+ ' ' + ArrStr[1])) then
          begin
            vtrPregledPat.Header.Columns[Column].Text := 'Презиме на пациента';
            vtrPregledPat.Header.Columns[Column].Tag := 1;
          end
          else
          if (p.x - RText.Left) < (Canvas.TextWidth(ArrStr[0]+ ' ' + ArrStr[1]+ ' ' + ArrStr[2])) then
          begin
            vtrPregledPat.Header.Columns[Column].Text := 'Фамилия на пациента';
            vtrPregledPat.Header.Columns[Column].Tag := 2;
          end
          else
          if (p.x - RText.Left) < (Canvas.TextWidth(ArrStr[0]+ ' ' + ArrStr[1]+ ' ' + ArrStr[2]+ ' ' + ArrStr[3]+ ' ' + ArrStr[4])) then
          begin
            vtrPregledPat.Header.Columns[Column].Text := 'Възраст на пациента';
            vtrPregledPat.Header.Columns[Column].Tag := 3;
          end
          else
          begin
            vtrPregledPat.Header.Columns[Column].Text := 'Детайли';
            vtrPregledPat.Header.Columns[Column].Tag := -1;
          end
        end;
        vvDoctor: vtrPregledPat.Header.Columns[Column].Text := 'УИН ';
        vvPerformer: vtrPregledPat.Header.Columns[Column].Text := 'УИН ';
        vvPregled:
        begin
          vtrPregledPat.Header.Columns[Column].Text := 'НРН ';
          vtrPregledPat.Header.Columns[Column].Tag := 4;
        end;
      else
        vtrPregledPat.Header.Columns[Column].Text := '....';
      end;


    end;
  end;
end;

procedure TfrmSuperHip.vtrPregledPatCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  data1, data2: PAspRec;
  egn1, egn2: string;
  BIRTH_DATE1, BIRTH_DATE2: tdate;
  startDate1, startDate2: TDateTime;
begin
  data1 := pointer(PByte(node1) + lenNode);
  data2 := pointer(PByte(node2) + lenNode);

  case FSortPat of
    spEgn:
    begin
      if data1.vid <> vvPatient then
      begin
        Exit;
      end;
      egn1 := ADB_DM.CollPatient.getAnsiStringMap(data1.DataPos, word(PatientNew_EGN));
      egn2 := ADB_DM.CollPatient.getAnsiStringMap(data2.DataPos, word(PatientNew_EGN));
      Result := CompareStr(egn2, egn1);
    end;
    spAge:
    begin
      if data1.vid <> vvPatient then
      begin
        Exit;
      end;
      BIRTH_DATE1 := ADB_DM.CollPatient.getDateMap(data1.DataPos, word(PatientNew_BIRTH_DATE));
      BIRTH_DATE2 := ADB_DM.CollPatient.getDateMap(data2.DataPos, word(PatientNew_BIRTH_DATE));
      Result := CompareDate(BIRTH_DATE2, BIRTH_DATE1);
    end;
    spStartPreg:
    begin
      if data1.vid <> vvPregled then
      begin
        Exit;
      end;
      startDate1 := ADB_DM.CollPregled.getDateMap(data1.DataPos, word(PregledNew_START_DATE));
      startDate2 := ADB_DM.CollPregled.getDateMap(data2.DataPos, word(PregledNew_START_DATE));
      Result := CompareDate(startDate1, startDate2);
    end;
  end;

end;

procedure TfrmSuperHip.vtrPregledPatDragOver(Sender: TBaseVirtualTree;
  Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
  Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TfrmSuperHip.vtrPregledPatDrawButton(sender: TVirtualStringTreeAspect; node: PVirtualNode; var ButonVisible: Boolean; const numButton: Integer;
  var imageIndex: Integer);
var
  data: PAspRec;
begin
  if node = nil then  Exit;
  //data := pointer(PByte(node) + lenNode);
//  case data.vid of
//    vvPregled:
//    begin
//      case numButton of
//        0:
//        begin
//          ButonVisible := True;
//          imageIndex := 31;
//        end;
//      end;
//    end;
//  end;

end;

procedure TfrmSuperHip.vtrPregledPatDrawText(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
var
  rText, r: TRect;
  i, p: Integer;
  wb: TWordBreakF;
  FilterText, strPred, strSled, strFltr: string;
begin
  //if Column <> 1 then
//  begin
//    DefaultDraw := true;
//    Exit;
//  end;
  rText := CellRect;

  //Exit;
  wb := TWordBreakF.create(TargetCanvas);
  wb.Inls.Text := Text;

  //mmText := TStringList.Create;
  //SMemo := TStringList.Create;
  rText := CellRect;
  //h:= rText.Height;
  wb.maxwidth := rText.Width;

  //mmText.Text := Text;
  //WordBreakF.WrapMemo(TargetCanvas, mmText, SMemo, w, h);
  //rText.Width:= w ;
  //rText.Height:= 13;
  DefaultDraw := False;
  FilterText := edtSearhTree.Text;// 'система';
  p := AnsiUpperCase(wb.Inls.Text).IndexOf((AnsiUpperCase(FilterText)));
  if p > -1 then
  begin
    wb.StartFilter := p;
    wb.EndFilter := p + Length(FilterText);
    wb.WrapMemo;
    for i := 0 to wb.ls.Count - 1 do
    begin
      if i = wb.ls.Count - 1 then
      begin
        Winapi.Windows.DrawTextW(TargetCanvas.Handle, PWideChar(wb.ls[i]), Length(wb.ls[i])- 1, rText, TA_LEFT);
      end
      else
      begin
        Winapi.Windows.DrawTextW(TargetCanvas.Handle, PWideChar(wb.ls[i]), Length(wb.ls[i] ), rText, TA_LEFT);
      end;

      if AnsiUpperCase(wb.ls[i]).Contains( AnsiUpperCase(FilterText)) then
      begin
        p := AnsiUpperCase(wb.ls[i]).IndexOf((AnsiUpperCase(FilterText)));
        //FilterText := Copy(wb.ls[i], p + 1, length(FinderRec.strSearch));
        strPred := Copy(wb.ls[i], 1, p);
        strFltr := copy(wb.ls[i], p + 1, length(FilterText));
        strSled := copy(wb.ls[i], p+length(FilterText) + 1, length(wb.ls[i]) + 1 -   (p+length(FilterText)));

        SetTextColor(TargetCanvas.Handle, $00A00000);
        SetBkColor(TargetCanvas.Handle, $007DCFFB);
        SetBkMode(TargetCanvas.Handle, OPAQUE);
        r := rText;
        r.Left := r.Left + TargetCanvas.TextWidth(strPred);
        r.Width := TargetCanvas.TextWidth(strFltr);
        Winapi.Windows.DrawText(TargetCanvas.Handle, PWideChar(strFltr), Length(strFltr), r, TA_LEFT);
        SetTextColor(TargetCanvas.Handle, clBlack);
        SetBkMode(TargetCanvas.Handle, TRANSPARENT);
      end;
      if Integer(wb.ls.Objects[i]) <> 0 then
      begin
        p := length(wb.ls[i]) + Integer(wb.ls.Objects[i]);

        if Integer(wb.ls.Objects[i]) < 0 then
        begin
          strPred := Copy(wb.ls[i], 1, p - 1);
          strSled := copy(wb.ls[i], length(wb.ls[i]) + Integer(wb.ls.Objects[i]), - Integer(wb.ls.Objects[i]));
        end
        else
        begin
          strPred := '';
          strSled := copy(wb.ls[i], 1,  Integer(wb.ls.Objects[i]));
          if strSled.StartsWith('н') then
            strPred := '';
        end;

        SetTextColor(TargetCanvas.Handle, $00A00000);
        SetBkColor(TargetCanvas.Handle, $007DCFFB);
        SetBkMode(TargetCanvas.Handle, OPAQUE);
        r := rText;
        r.Left := r.Left + TargetCanvas.TextWidth(strPred);
        r.Width := TargetCanvas.TextWidth(strSled);
        Winapi.Windows.DrawText(TargetCanvas.Handle, PWideChar(strSled), Length(strSled), r, TA_LEFT);
        SetTextColor(TargetCanvas.Handle, clBlack);
        SetBkMode(TargetCanvas.Handle, TRANSPARENT);
      end;
      rText.Offset(0, 13);
    end;

  end
  else
  begin
    wb.WrapMemo;
    Winapi.Windows.DrawTextW(TargetCanvas.Handle, PWideChar(wb.ls.Text), Length(wb.ls.Text) - 3, rText, TA_LEFT);//43024);
  end;
  wb.Destroy;
end;

procedure TfrmSuperHip.vtrPregledPatDrawText1(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; const Text: string;
  const CellRect: TRect; var DefaultDraw: Boolean);
var
  p: Integer;
  strPred, strSled, textForSearch, FilterText: string;
  r: TRect;
  DrawFormatPred: cardinal;
  DrawFormatSled: cardinal;
begin
  if FinderRec.strSearch = '' then  exit;
  if not(vsSelected in Node.States) then Exit;
  if FinderRec.ACol <> Column then  Exit;


  DrawFormatPred := DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE or DT_LEFT ;
  DrawFormatSled := DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE or DT_LEFT or DT_END_ELLIPSIS;
  textForSearch := Text;
  GetTextToDraw(Node, Column, textForSearch, strPred, strSled, FilterText);
  if textForSearch <> '' then
  begin
    SetBkMode(TargetCanvas.Handle,TRANSPARENT);
    TargetCanvas.TextWidth(strPred);
    r := CellRect;
    SetTextColor(TargetCanvas.Handle, clBlack);
    SetBkMode(TargetCanvas.Handle, TRANSPARENT);
    Winapi.Windows.DrawText(TargetCanvas.Handle, PWideChar(Text), Length(Text), r, DrawFormatPred);

    SetTextColor(TargetCanvas.Handle, $00A00000);
    SetBkColor(TargetCanvas.Handle, $007DCFFB);
    SetBkMode(TargetCanvas.Handle, OPAQUE);

    r.Left := r.Left + TargetCanvas.TextWidth(strPred);
    r.Width := TargetCanvas.TextWidth(FilterText);
    Winapi.Windows.DrawText(TargetCanvas.Handle, PWideChar(FilterText), Length(FilterText), r, DrawFormatPred);

    SetTextColor(TargetCanvas.Handle, clBlack);
    SetBkMode(TargetCanvas.Handle, TRANSPARENT);
    r.Offset(r.Width, 0);
    r.Width := TargetCanvas.TextWidth(strSled);

    Winapi.Windows.DrawText(TargetCanvas.Handle, PWideChar(strSled), Length(strSled), r, DrawFormatSled);
    DefaultDraw:= False;
  end
  else
    DefaultDraw:= True;
end;

procedure TfrmSuperHip.vtrPregledPatExpanded(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  data, dataAction: PAspRec;
  linkPos, FPosLinkData: Cardinal;
  pCardinalData: PCardinal;
  bufLink: Pointer;
  RunNode: PVirtualNode;
begin
  if not Sender.Focused  then Exit;

  if (GetKeyState(VK_CONTROL) >= 0) then Exit;
  bufLink := AspectsLinkPatPregFile.Buf;
  dataAction := pointer(PByte(node) + lenNode);
  if dataAction.vid = vvPatientNewRoot then  Exit;

  vtrPregledPat.OnExpanded := nil;
  vtrPregledPat.BeginUpdate;
  //case data.vid of
    //vvPregled:
    begin
      linkPos := 100;
      pCardinalData := pointer(PByte(bufLink));
      FPosLinkData := pCardinalData^;
      while linkpos < FPosLinkData do
      begin
        RunNode := pointer(PByte(bufLink) + linkpos);
        data := pointer(PByte(RunNode) + lenNode);
        if data.vid = dataAction.vid then
        begin
          vtrPregledPat.Expanded[RunNode] := True;
        end;
        Inc(linkPos, LenData);
      end;
    end;
  //end;

  vtrPregledPat.EndUpdate;
  vtrPregledPat.OnExpanded := vtrPregledPatExpanded;
  vtrPregledPat.ValidateNode(vtrPregledPat.RootNode.FirstChild.FirstChild,True);
end;

procedure TfrmSuperHip.vtrPregledPatGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex;
  var ImageList: TCustomImageList);
var
  Data: PAspRec;
  cl132Key, cl136Key: string;
  cl132pos: Cardinal;
  planStatus: TPlanedStatusSet;
  planStat: TPlanedStatus;
  nzisStatus: Word;
  i: Integer;
begin
  if Kind <> TVTImageKind.ikState then
    Exit;
  Data := Pointer(PByte(Node) + lenNode);
  case Column of
    0:
    begin
      case Data.vid of
        vvNZIS_PLANNED_TYPE:
        begin
          cl132Key := ADB_DM.CollNZIS_PLANNED_TYPE.getAnsiStringMap(data.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
          cl132pos := ADB_DM.CollNZIS_PLANNED_TYPE.getCardMap(data.DataPos, word(NZIS_PLANNED_TYPE_CL132_DataPos));
          cl136Key := ADB_DM.CL132Coll.getAnsiStringMap(cl132pos, word(CL132_CL136_Mapping));
          case cl136Key[1] of
            '1':
            begin
              if profGR = nil then
                Exit;
              if NzisPregNotPreg.Contains('|' + cl132Key + '|') then
              begin
                ImageIndex := 78;
              end
              else
              if NzisConsult.Contains('|' + cl132Key + '|') then
              begin
                ImageIndex := 36;
              end
              else
              begin
                ImageIndex := 98;
              end;
            end;
            '2':
            begin
              ImageIndex := 27;
            end;
            '3', '4':
            begin
              ImageIndex := 63;
            end;
          end;
          
        end;
        vvPatient:
        begin
          ImageIndex := 3;
        end;
        vvPregled:
        begin
          ImageIndex := 58;
        end;
        vvIncMN:
        begin
          ImageIndex := 108;
        end;
        vvOtherDoctor:
        begin
          ImageIndex := 17;
        end;
      end; //case
    end; //0

    1:
    begin
      case Data.vid of
        vvNZIS_PLANNED_TYPE:
        begin
          cl132Key := ADB_DM.CollNZIS_PLANNED_TYPE.getAnsiStringMap(data.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
          cl132pos := ADB_DM.CollNZIS_PLANNED_TYPE.getCardMap(data.DataPos, word(NZIS_PLANNED_TYPE_CL132_DataPos));
          cl136Key := ADB_DM.CL132Coll.getAnsiStringMap(cl132pos, word(CL132_CL136_Mapping));
          planStatus := TPlanedStatusSet(Node.Dummy);
          for planStat in  planStatus do
          begin
            case planStat of
              TPlanedStatus.psNzisPending: ImageIndex := 99;
              TPlanedStatus.psNzisPartiallyCompleted: ImageIndex := 100;
              TPlanedStatus.psNzisCompleted: ImageIndex := 101;
            end;
          end;
        end;
        vvPregled:
        begin
          nzisStatus := ADB_DM.CollPregled.getWordMap(data.DataPos, word(PregledNew_NZIS_STATUS));
          ImageIndex := nzisStatus;
        end;
        vvDoctor, vvPerformer, vvDeput:
        begin
          if thrCert = nil then  Exit;

          for i := 0 to thrCert.LstPlugCardDoctor.Count - 1 do
          begin
            if Data.DataPos = thrCert.LstPlugCardDoctor[i] then
            begin
              ImageIndex := 102;
              Break;
            end;
          end;
        end;
      end; //case
    end; //1
    2:
    begin
      case Data.vid of
        vvPregled:
        begin
          if (Node.NextSibling <> nil) and (not(Sender.IsVisible[Node.NextSibling])) then
            ImageIndex := 99;
        end;
      end; //case
    end; //2
  end;
end;

procedure TfrmSuperHip.vtrPregledPatGetPopupMenu(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; const P: TPoint;
  var AskParent: Boolean; var PopupMenu: TPopupMenu);
var
  data: PAspRec;
begin
   data := pointer(PByte(node) + lenNode);
   case data.vid of
     vvPatient:
     begin
       vtrPregledPat.Selected[Node] := True;
       PopupMenu := pmActionPat;
     end;
     vvPregled:
     begin
       vtrPregledPat.Selected[Node] := True;
       PopupMenu := pmActionPreg;
       pmActionPreg.Tag := Integer(Node);
     end;
     vvPatientRevision:
     begin
       vtrPregledPat.Selected[Node] := True;
       PopupMenu := pmActionPregRev;
       pmActionPregRev.Tag := Integer(Node);
     end
   else
     AskParent := False;
     PopupMenu := nil;
   end;
end;

procedure TfrmSuperHip.vtrPregledPatGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var //perf
  data, dataPat, dataEvn, dataParent: PAspRec;
  NodePat: PVirtualNode;
  preg: TPregledNewItem;
  pat: TPatientNewItem;
  log32: TLogicalData32;
  dateEvn, datePreg, dateBrd, startDate, endDate, dateMDD, dateIncNapr: TDate;
  rzokEvn, rzokREvn, nasMestoEvn: string;
  FieldText: string;
  PatAge: Integer;
  PatAgeDoub: Double;
  patLogical: TlogicalPatientNewSet;
  PatAgeStr: string;
  evntNode: PVirtualNode;
  evntCnt: Integer;
  nomenPos: Cardinal;
  vid: integer;
  decValue: Double;

  anal: TRealExamAnalysisItem;
  p: PCardinal;
  ofset: Cardinal;
  nasMestoPos: Cardinal;
begin
  if node = nil then  Exit;
  if Adb_DM.AdbMain = nil then Exit;
  if Adb_DM.AdbMain.Buf = nil then  Exit;
  if AspectsLinkPatPregFile = nil then Exit;


  //Exit;

  if Sender = vtrPregledPat then
  begin
    data := pointer(PByte(node) + lenNode);
  end
  else
  begin
    data := Sender.GetNodeData(node);
  end;
  case Column of
    0:
    begin
      case data.vid of
        vvProcedures:
        begin
          CellText := 'процедураaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ' ;
        end;
        vvPerformer:
        begin
          CellText := 'изпълнител ' ;
        end;
        vvDeput:
        begin
          CellText := 'zamestnik ' ;
        end;
        vvPatientNewRoot:
          CellText := 'Пациенти ' ;
        vvPatient:
        begin
         // if data.index <> -1 then
//          begin
//            pat := CollPatient.Items[Data.index];
//            CellText := 'ЕГН ' + pat.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_EGN));
//          end
//          else
          begin
            //pat := TPatientItem(PatientColl.Add);
            //pat.DataPos := Data.DataPos;
            patLogical := TlogicalPatientNewSet(ADB_DM.CollPatient.getLogical40Map(data.DataPos, word(PatientNew_Logical)));
            if PID_TYPE_B in patLogical then
              CellText := 'Бебе ' + ADB_DM.CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN))
            else
            if PID_TYPE_E in patLogical then
              CellText := 'ЕГН ' + ADB_DM.CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN))
            else
            if PID_TYPE_L in patLogical then
              CellText := 'ЛНЧ ' + ADB_DM.CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN))
            else
            if PID_TYPE_S in patLogical then
              CellText := 'ССН ' + ADB_DM.CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN))
            else
            if PID_TYPE_F in patLogical then
              CellText := 'Ч ' + ADB_DM.CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN))
            else
          end;
        end;
        vvIncMdn:
        begin
          NodePat := Node.Parent;
          DataPat := pointer(PByte(nodePat) + lenNode);
          dateBrd := ADB_DM.CollPatient.getDateMap(DataPat.DataPos, word(PatientNew_BIRTH_DATE));
          dateMDD := ADB_DM.CollIncMdn.getDateMap(Data.DataPos, word(INC_MDN_DATE_EXECUTION));
          PatAge := TRealPatientNewItem.CalcAge(dateMDD, dateBrd);
          CellText := 'МДД ' + ADB_DM.CollIncMdn.getAnsiStringMap(Data.DataPos, word(INC_MDN_NRN));
          CellText := CellText + '  ' + IntToStr(PatAge) + ' год.';
        end;
        vvIncMN:
        begin
          NodePat := Node.Parent;
          DataPat := pointer(PByte(nodePat) + lenNode);
          dateBrd := ADB_DM.CollPatient.getDateMap(DataPat.DataPos, word(PatientNew_BIRTH_DATE));
          dateIncNapr := ADB_DM.CollIncMN.getDateMap(Data.DataPos, word(INC_NAPR_ISSUE_DATE));
          PatAge := TRealPatientNewItem.CalcAge(dateIncNapr, dateBrd);
          CellText := 'Консулт. ' + ADB_DM.CollIncMN.getAnsiStringMap(Data.DataPos, word(INC_NAPR_NRN));
          CellText := CellText + '  ' + IntToStr(PatAge) + ' год.';
        end;

        vvOtherDoctor:
        begin
          CellText := 'Изпр. ' + ADB_DM.CollOtherDoctor.getAnsiStringMap(Data.DataPos, word(OtherDoctor_UIN));
        end;
        vvPregled:
        begin
          //if data.index <> -1 then
//          begin
//            //preg := PregledCollFilter.Items[Data.index];
//            CollPregled.GetFieldText(Sender, word(PregledNew_AMB_LISTN), data.index, FieldText);
//            CellText := 'АЛ№ ' + FieldText;
//            if FieldText = '0' then
//              CellText := 'АЛ№ ' + FieldText;
//            //CellText := 'АЛ№ ' + inttostr(preg.FilterAMB_LISTN);
//          end
//          else
          begin
            if Data.DataPos <> 0 then
            begin
              dataParent :=  pointer(PByte(Node.Parent) + lenNode);
              case dataParent.vid of
                vvPatient:
                begin
                  NodePat := Node.Parent;
                end;
                vvIncMN:
                begin
                  NodePat := Node.Parent.parent;
                end;
              end;

              if Sender = vtrPregledPat then
              begin
                DataPat := pointer(PByte(nodePat) + lenNode);
              end
              else
              begin
                DataPat := Sender.GetNodeData(nodePat);
              end;
              dateBrd := ADB_DM.CollPatient.getDateMap(DataPat.DataPos, word(PatientNew_BIRTH_DATE));

              datePreg := ADB_DM.CollPregled.getDateMap(Data.DataPos, word(PregledNew_START_DATE));
              PatAge := TRealPatientNewItem.CalcAge(datePreg, dateBrd);
              CellText := 'АЛ№ ' + IntToStr(ADB_DM.CollPregled.getIntMap(Data.DataPos, word(PregledNew_AMB_LISTN)));
              CellText := CellText + '  ' + IntToStr(PatAge) + ' год.';
            end
            else
            begin
              CellText := 'АЛ№ НОВ';
            end;
          end;
        end;
        vvCl132:
        begin
          CL132Temp.DataPos := data.DataPos;
          CellText := CL132Temp.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.CL132Coll.posData, word(CL132_Key));
          CellText := CellText + '  ' + CL132Temp.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.CL132Coll.posData, word(CL132_Display_Value_BG));
        end;
        vvNZIS_PLANNED_TYPE:
        begin
          CellText := ADB_DM.CollNZIS_PLANNED_TYPE.getAnsiStringMap( data.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
          //CellText := CellText + '  ' + CollNZIS_PLANNED_TYPE.getAnsiStringMap( data.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
        end;
        vvPr001:
        begin
          if node.Parent.parent.parent = nil then
          begin
            CellText := 'errrrr';
            exit;
          end;
          PR001Temp.DataPos := data.DataPos;
          CellText := PR001Temp.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(PR001_Description));
        end;
        vvNZIS_QUESTIONNAIRE_RESPONSE:
        begin
          if node.Parent.parent.parent = nil then
          begin
            CellText := 'errrrr';
            exit;
          end;
          //NZIS_QUESTIONNAIRE_RESPONSETemp.DataPos := data.DataPos;
          CellText := ADB_DM.CollNZIS_QUESTIONNAIRE_RESPONSE.getAnsiStringMap(data.DataPos, word(NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY));
        end;
        vvNZIS_QUESTIONNAIRE_ANSWER:
        begin
          if node.Parent.parent.parent = nil then
          begin
            CellText := 'errrrr';
            exit;
          end;
          NZIS_QUESTIONNAIRE_ANSWERTemp.DataPos := data.DataPos;
          CellText := NZIS_QUESTIONNAIRE_ANSWERTemp.getAnsiStringMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE));
        end;
        vvNZIS_ANSWER_VALUE:
        begin
          if node.Parent.parent.parent.parent = nil then
          begin
            CellText := 'errrrr';
            exit;
          end;
          if data.index < 0 then
          begin
            if data.DataPos = 0 then
            begin
              CellText := 'errrrr';
              exit;
            end;
            NZIS_ANSWER_VALUETemp.DataPos := data.DataPos;
            case NZIS_ANSWER_VALUETemp.getWordMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_ANSWER_VALUE_CL028)) of
              1:
              begin
               CellText := Double.ToString(NZIS_ANSWER_VALUETemp.getDoubleMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_QUANTITY)));
              end;
              2: CellText := NZIS_ANSWER_VALUETemp.getAnsiStringMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_CODE));
              3: CellText := 'Текст-записан';
              4: CellText := 'Дата-записана';
            end;
          end
          else
          begin
            if ADB_DM.CollNZIS_ANSWER_VALUE.Items[data.index].PRecord <> nil then
            begin
              case ADB_DM.CollNZIS_ANSWER_VALUE.Items[data.index].getWordMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_ANSWER_VALUE_CL028)) of
                1: CellText := Double.ToString(ADB_DM.CollNZIS_ANSWER_VALUE.Items[data.index].PRecord.ANSWER_QUANTITY);
                2: CellText := ADB_DM.CollNZIS_ANSWER_VALUE.Items[data.index].PRecord.ANSWER_CODE;
                3: CellText := 'Текст-НЕзаписан';
                4: CellText := 'Дата-НЕзаписан';
              end;
            end
            else
            begin
              NZIS_ANSWER_VALUETemp.DataPos := ADB_DM.CollNZIS_ANSWER_VALUE.Items[data.index].DataPos;
              case NZIS_ANSWER_VALUETemp.getWordMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_ANSWER_VALUE_CL028)) of
                1: CellText := Double.ToString(NZIS_ANSWER_VALUETemp.getDoubleMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_QUANTITY)));
                2: CellText := NZIS_ANSWER_VALUETemp.getAnsiStringMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_CODE));
                3: CellText := 'Текст-ЗА записване';
                4: CellText := 'Дата-ЗА записване';
              end;
            end;
          end;
        end;

        vvNZIS_DIAGNOSTIC_REPORT:
        begin
          if node.Parent.parent.parent = nil then
          begin
            CellText := 'errrrr';
            exit;
          end;
          NZIS_DIAGNOSTIC_REPORTTemp.DataPos := data.DataPos;
          CellText := 'CL142|' + NZIS_DIAGNOSTIC_REPORTTemp.getAnsiStringMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_DIAGNOSTIC_REPORT_CL142_CODE));
        end;
        vvNZIS_RESULT_DIAGNOSTIC_REPORT:
        begin
          if node.Parent.parent.parent.Parent = nil then
          begin
            CellText := 'errrrr';
            exit;
          end;
          if data.DataPos = 53969904 then
          begin
            CellText := 'test';
          end;
          NZIS_Result_DIAGNOSTIC_REPORTTemp.DataPos := data.DataPos;
          case NZIS_Result_DIAGNOSTIC_REPORTTemp.getwordMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
            1: CellText := Double.ToString( NZIS_Result_DIAGNOSTIC_REPORTTemp.getDoubleMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY)));
            2: CellText := NZIS_Result_DIAGNOSTIC_REPORTTemp.getAnsiStringMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE));
            3: CellText := NZIS_Result_DIAGNOSTIC_REPORTTemp.getAnsiStringMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING));
          end;
        end;
        vvCL088:
        begin
          CL088Temp.DataPos := data.DataPos;
          CellText := CL088Temp.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.PR001Coll.posData, word(CL088_Description));
        end;
        vvdiag:
        begin
          FieldText := Adb_DM.CollDiag.getAnsiStringMap(data.DataPos, word(Diagnosis_additionalCode_CL011));
          CellText := 'MKB ' + Adb_DM.CollDiag.getAnsiStringMap(data.DataPos, word(Diagnosis_code_CL011)) + FieldText;
        end;
        vvMDN:
        begin
          MDNTemp.DataPos := Data.DataPos;
          CellText := 'МДН ' + inttostr(MDNTemp.getIntMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(MDN_NUMBER)));
        end;
        vvMedNapr:
        begin
          MNTemp.DataPos := Data.DataPos;
          CellText := 'МН ' + inttostr(MNTemp.getIntMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(BLANKA_MED_NAPR_NUMBER)));
        end;
        vvMedNaprLkk:
        begin
          CellText := 'МН_ЛКК ' +  ADB_DM.CollMedNaprLkk.getAnsiStringMap(Data.DataPos, word(EXAM_LKK_NRN));
        end;
        vvMedNaprHosp:
        begin
          CellText := 'МН_Hosp ' +  ADB_DM.CollMedNaprHosp.getAnsiStringMap(Data.DataPos, word(HOSPITALIZATION_NRN));
        end;
        vvProfCard:
        begin
          CellText := 'Проф. карта ' + IntToStr(ADB_DM.CollCardProf.getIntMap(Data.DataPos, Word(KARTA_PROFILAKTIKA2017_NOMER)));
        end;
        vvExamAnal:
        begin
          anal := ADB_DM.CollExamAnal.GetItemsFromDataPos(Data.DataPos);
          if (anal <> nil) and (anal.PRecord <> nil) then
          begin
            CellText := 'Изсл. ' + anal.PRecord.NZIS_CODE_CL22;
          end
          else
          begin
            ExamAnalTemp.DataPos := Data.DataPos;
            CellText := 'Изсл. ' + ExamAnalTemp.getAnsiStringMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(ExamAnalysis_NZIS_CODE_CL22));
          end;
        end;
        vvDoctor:
        begin
          CellText := 'Лекар ' + Adb_DM.CollDoctor.getAnsiStringMap( Data.DataPos, word(Doctor_UIN));
        end;
        vvPatientRevision:
        begin
          CellText := 'Промяна на Пациента';

        end;
        vvAddres:
        begin
          CellText := 'Адрес: ' + FNasMesto.addresColl.GetFullAddres(data.DataPos);
        end;
      end;
    end;
    1:
    begin
      case data.vid of
        vvProcedures:
        begin
          ProcTemp.DataPos := Data.DataPos;
          if data.DataPos = 0 then
          begin
            CellText :=  'потребителско';
            Exit;
          end;
          CellText := ProcTemp.getAnsiStringMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(Procedures_CODE));
        end;
        vvPerformer:
        begin
          CellText := Adb_DM.CollDoctor.getAnsiStringMap( Data.DataPos, word(Doctor_SNAME));
        end;
        vvDeput:
        begin
          CellText := Adb_DM.CollDoctor.getAnsiStringMap( Data.DataPos, word(Doctor_SNAME));
        end;
        vvPatientNewRoot:
          CellText := IntToStr(ADB_DM.CollPatient.CntInADB) ;
        vvPatient:
        begin
          dateBrd := ADB_DM.CollPatient.getDateMap(Data.DataPos, word(PatientNew_BIRTH_DATE));
          PatAge := TRealPatientNewItem.CalcAge(UserDate, dateBrd);
          case PatAge of
            0:
            begin
              PatAgeDoub := TRealPatientNewItem.CalcAgeDouble(UserDate, dateBrd);
              PatAgeStr := IntToStr(Floor(PatAgeDoub * 12)) + ' мес.';
            end;
          else
            PatAgeStr := IntToStr(PatAge) + ' год.';
          end;
          CellText := ADB_DM.CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_FNAME));
          CellText := CellText + ' ' + ADB_DM.CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_SNAME));
          CellText := CellText + ' ' + ADB_DM.CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_LNAME))
                      + ' ' + PatAgeStr;
        end;
        vvPregled:
        begin
          //p := pointer(PByte(CollPregled.buf) + (Data.DataPos  + 4*word(PregledNew_ID)));
          //ofset := p^ + CollPatient.posData;
          CellText := 'НРН ' + ADB_DM.CollPregled.getAnsiStringMap(Data.DataPos, word(PregledNew_NRN_LRN))  + ' от ' + DateToStr(ADB_DM.CollPregled.getDateMap(Data.DataPos, word(PregledNew_START_DATE)));
        end;
        
        vvNZIS_PLANNED_TYPE:
        begin
          startDate := ADB_DM.CollNZIS_PLANNED_TYPE.getDateMap( data.DataPos, word(NZIS_PLANNED_TYPE_StartDate));
          endDate := ADB_DM.CollNZIS_PLANNED_TYPE.getDateMap( data.DataPos, word(NZIS_PLANNED_TYPE_EndDate));
          CellText := DateToStr(startDate) + ' - ' + DateToStr(endDate);
        end;
        vvNZIS_QUESTIONNAIRE_ANSWER:
        begin
          if node.Parent.parent.parent = nil then
          begin
            CellText := 'errrrr';
            exit;
          end;
          NZIS_QUESTIONNAIRE_ANSWERTemp.DataPos := data.DataPos;
          nomenPos := NZIS_QUESTIONNAIRE_ANSWERTemp.getCardMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS));
          CellText := ADB_DM.CL134Coll.getAnsiStringMap(nomenPos, Word(CL134_Description));
          CellText := CellText + '  ' + data.index.ToString;
        end;
        vvNZIS_ANSWER_VALUE:
        begin
          if node.Parent.parent.parent.parent = nil then
          begin
            CellText := 'errrrr';
            exit;
          end;
          if data.index < 0 then
          begin
            if data.DataPos = 0 then
            begin
              CellText := 'errrrr';
              exit;
            end;
            NZIS_ANSWER_VALUETemp.DataPos := data.DataPos;
            case NZIS_ANSWER_VALUETemp.getWordMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_ANSWER_VALUE_CL028)) of
              2:
              begin
                nomenPos := NZIS_ANSWER_VALUETemp.getCardMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_ANSWER_VALUE_NOMEN_POS));
                CellText := ADB_DM.CL139Coll.getAnsiStringMap(nomenPos, word(CL139_Description));
              end;
              3:
              begin
                CellText := NZIS_ANSWER_VALUETemp.getAnsiStringMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_TEXT));
              end;
              4:
              begin
                CellText := DateToStr(NZIS_ANSWER_VALUETemp.getDateMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_DATE)));
              end;
            end;
          end
          else
          begin
            NZIS_ANSWER_VALUETemp.DataPos := ADB_DM.CollNZIS_ANSWER_VALUE.Items[data.index].DataPos;
            case NZIS_ANSWER_VALUETemp.getWordMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_ANSWER_VALUE_CL028)) of
              2:
              begin
                if  ADB_DM.CollNZIS_ANSWER_VALUE.Items[data.index].PRecord <> nil then
                begin
                  nomenPos := ADB_DM.CollNZIS_ANSWER_VALUE.Items[data.index].PRecord.NOMEN_POS;
                end
                else
                begin
                  nomenPos := ADB_DM.CollNZIS_ANSWER_VALUE.Items[data.index].getCardMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_ANSWER_VALUE_NOMEN_POS));
                end;
                CellText := ADB_DM.CL139Coll.getAnsiStringMap(nomenPos, word(CL139_Description));
              end;
              3:
              begin
                if ADB_DM.CollNZIS_ANSWER_VALUE.Items[data.index].PRecord <> nil then
                begin
                  CellText := ADB_DM.CollNZIS_ANSWER_VALUE.Items[data.index].PRecord.ANSWER_TEXT;
                end
                else
                begin
                  CellText := NZIS_ANSWER_VALUETemp.getAnsiStringMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_TEXT));
                end;
              end;
              4:
              begin
                if ADB_DM.CollNZIS_ANSWER_VALUE.Items[data.index].PRecord <> nil then
                begin
                  CellText := DateToStr(ADB_DM.CollNZIS_ANSWER_VALUE.Items[data.index].PRecord.ANSWER_DATE);
                end
                else
                begin
                  CellText := DateToStr(NZIS_ANSWER_VALUETemp.getDateMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_DATE)));
                end;
              end;
            end;
          end;

        end;
        vvNZIS_DIAGNOSTIC_REPORT:
        begin
          if node.Parent.parent.parent = nil then
          begin
            CellText := 'errrrr';
            exit;
          end;
          NZIS_DIAGNOSTIC_REPORTTemp.DataPos := data.DataPos;
          nomenPos := NZIS_DIAGNOSTIC_REPORTTemp.getCardMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_DIAGNOSTIC_REPORT_NOMEN_POS));

          CellText := ADB_DM.CL142Coll.getAnsiStringMap(nomenPos, Word(CL142_Description));
        end;
        vvNZIS_RESULT_DIAGNOSTIC_REPORT:
        begin
          if node.Parent.parent.parent.Parent = nil then
          begin
            CellText := 'errrrr';
            exit;
          end;
          NZIS_Result_DIAGNOSTIC_REPORTTemp.DataPos := data.DataPos;
          nomenPos := NZIS_Result_DIAGNOSTIC_REPORTTemp.getCardMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
          CellText := ADB_DM.CL144Coll.getAnsiStringMap(nomenPos, Word(CL144_Description));
        end;
        vvDiag:
        begin
          FieldText := Adb_DM.CollDiag.getAnsiStringMap(data.DataPos, word(Diagnosis_additionalCode_CL011));
          if FieldText <> '' then
          begin
            CellText := FieldText;
          end;
        end;
        vvMDN:
        begin
          MDNTemp.DataPos := Data.DataPos;
          CellText := 'НРН ' + (MDNTemp.getAnsiStringMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(MDN_NRN)));
        end;
        vvMedNapr:
        begin
          MNTemp.DataPos := Data.DataPos;
          CellText := 'НРН ' + (MNTemp.getAnsiStringMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(BLANKA_MED_NAPR_NRN)));
        end;

        vvExamAnal:
        begin
          ExamAnalTemp.DataPos := Data.DataPos;
          CellText := ExamAnalTemp.getAnsiStringMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(ExamAnalysis_NZIS_DESCRIPTION_CL22));
        end;


        vvPatientRevision:
        begin
          CellText := IntToStr(data.index);
        end;

        vvAddres:
        begin
          nasMestoPos := FNasMesto.addresColl.getCardMap(data.DataPos, word(Addres_LinkPos));
          CellText := 'EKATTE: ' + FNasMesto.nasMestoColl.getAnsiStringMap(nasMestoPos, word(NasMesto_EKATTE));
        end;

        vvIncMN:
        begin

          CellText := 'NRN ' + ADB_DM.CollIncMdn.getAnsiStringMap(Data.DataPos, word(INC_NAPR_NRN));
        end;
      end;
    end;
    2:
    begin
      case data.vid of
        vvPerformer:
        begin
          CellText := IntToStr(data.index);
        end;
        vvDeput:
        begin
          CellText := IntToStr(data.index);
        end;
        vvDoctor:
        begin
          CellText := IntToStr(data.index);
        end;
        vvPatient:
        begin
          CellText := IntToStr(data.DataPos);
        end;
        vvmdn:
        begin
          CellText := IntToStr(data.DataPos);
        end;
      else
        begin
          vid := Integer(data.vid);
          CellText := TRttiEnumerationType.GetName(TVtrVid(vid));
          CellText := CellText + ': ' + IntToStr(node.Dummy);
        end;
      end;
    end;
  end;
end;


procedure TfrmSuperHip.vtrPregledPatHeaderDrawQueryElements(Sender: TVTHeader;
  var PaintInfo: THeaderPaintInfo; var Elements: THeaderPaintElements);
begin
  Elements := [hpeText];
end;

procedure TfrmSuperHip.vtrPregledPatKeyAction(Sender: TBaseVirtualTree; var CharCode: Word; var Shift: TShiftState; var DoDefault: Boolean);
var
  node: PVirtualNode;
//TempIsFinded: boolean;
begin
  if CharCode = VK_BACK then
    CharCode := 0;
  if CharCode = VK_ESCAPE then
  begin
    edtSearhTree.Text := '';
    FinderRec.strSearch := '';
  end;
  if CharCode = VK_RETURN then
  begin
    CharCode := 0;// да ходи на следващо попадение

    if KeyCNT then
    begin
      if (GetKeyState(VK_CONTROL) < 0) then
      begin
        if FinderRec.IsFinded then
        begin
          KeyCNT := False;
          FindNodevtrPreg(dfForward, FinderRec.ACol);
          KeyCNT := True;
        end;
      end;
      if (GetKeyState(VK_SHIFT) < 0) then
      begin
        if FinderRec.IsFinded then
        begin
          KeyCNT := False;
          FindNodevtrPreg(dfBackward, FinderRec.ACol);
          KeyCNT := True;
        end;
      end;
    end;

  end;
end;

procedure TfrmSuperHip.vtrPregledPatKeyPress(Sender: TObject; var Key: Char);
begin
  //if ((GetKeyState(VK_CONTROL) < 0) and (Key = #$7F)) then
//  begin
//    Key := #0;
//    Exit;
//  end;
//  if ((GetKeyState(VK_SHIFT) < 0) and (Key = #$7F)) then

  //begin
//    Key := #0;
//    Exit;
//  end;
  if Key in [#10, #13] then
  begin
    Key := #0;
    Exit;
  end;
  if vtrPregledPat.Header.Columns[FinderRec.acol].Tag < 0 then
  begin
    Exit;
  end;
  edtSearhTree.Perform(WM_CHAR, Ord(key), 0);

  //vtrPregledPat.IncrementalSearch
  Key := #0;
end;

procedure TfrmSuperHip.vtrPregledPatMouseLeave(Sender: TObject);
begin
  ActiveControl := fmxCntrDyn;
end;

procedure TfrmSuperHip.vtrPregledPatNodeCopied(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  //
end;

procedure TfrmSuperHip.vtrPregledPatNodeCopying(Sender: TBaseVirtualTree; Node,
  Target: PVirtualNode; var Allowed: Boolean);
var
  data, dataTarget: PAspRec;
begin
  data := Pointer(PByte(Node) + lenNode);
  dataTarget := Pointer(PByte(target) + lenNode);//vtrTemp.GetNodeData(target);
  //dataTarget.index := data.index;
//  dataTarget.vid := data.vid;
//  dataTarget.DataPos := data.DataPos;
end;

procedure TfrmSuperHip.vtrPregledPatSaveNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Stream: TStream);
var
  data: PAspRec;
begin
  data := Pointer(PByte(Node) + lenNode);
  Stream.Write(data^, sizeof(TAspRec));
end;

procedure TfrmSuperHip.vtrProfRegGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  data, patData: PAspRec;
  preg: TPregledNewItem;
  pat: TPatientNewItem;
  log32: TLogicalData32;
  dateEvn, brdDate, prgDate: TDate;
  rzokEvn, rzokREvn, nasMestoEvn: string;
  FieldText: string;
begin
  if node = nil then  Exit;
  //Exit;

  data := vtrProfReg.GetNodeData(Node);
  case Column of
    0:
    begin
      case data.vid of
        vvPerformer:
        begin
          CellText := 'изпълнител ' ;
        end;
        vvDeput:
        begin
          CellText := 'zamestnik ' ;
        end;
        vvPatientNewRoot:
          CellText := 'Пациенти ' ;
        vvPatient:
        begin
          if data.index <> -1 then
          begin
            pat := ADB_DM.CollPatient.Items[Data.index];
            CellText := 'ЕГН ' + pat.getAnsiStringMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPatient.posData, word(PatientNew_EGN));
          end
          else
          begin
            CellText := 'ЕГН ' + ADB_DM.CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN));
          end;
        end;
        vvPregled:
        begin
          if data.index <> -1 then
          begin
            //preg := PregledCollFilter.Items[Data.index];
            ADB_DM.CollPregled.GetFieldText(Sender, word(PregledNew_AMB_LISTN), data.index, FieldText);
            CellText := 'АЛ№ ' + FieldText;
            if FieldText = '0' then
              CellText := 'АЛ№ ' + FieldText;
            //CellText := 'АЛ№ ' + inttostr(preg.FilterAMB_LISTN);
          end
          else
          begin
            if Data.DataPos <> 0 then
            begin
              patData := vtrProfReg.GetNodeData(Node.parent);
              CellText := 'АЛ№ ' + IntToStr(ADB_DM.CollPregled.getIntMap(Data.DataPos, word(PregledNew_AMB_LISTN)));
              brdDate := ADB_DM.CollPatient.getDateMap( patData.DataPos, word(PatientNew_BIRTH_DATE));
              prgDate := ADB_DM.CollPregled.getDateMap(Data.DataPos, word(PregledNew_START_DATE));
              CellText := CellText + '  ' + inttostr(YearsBetween(brdDate, prgDate));
            end
            else
            begin
              CellText := 'АЛ№ НОВ';
            end;
          end;
        end;
        vvDiag:
        begin
          if data.index <> -1 then
          begin
            //preg := PregledCollFilter.Items[Data.index];
            //PregledNewColl.GetFieldText(Sender, word(PregledNew_AMB_LISTN), data.index, FieldText);
//            CellText := 'АЛ№ ' + FieldText;
//            if FieldText = '0' then
//              CellText := 'АЛ№ ' + FieldText;
            //CellText := 'АЛ№ ' + inttostr(preg.FilterAMB_LISTN);
          end
          else
          begin
            FieldText := (Adb_DM.CollDiag.getAnsiStringMap(data.DataPos, word(Diagnosis_additionalCode_CL011)));
            CellText := 'MKB ' + (Adb_DM.CollDiag.getAnsiStringMap(data.DataPos, word(Diagnosis_code_CL011))) + FieldText;
            //if CellText = 'АЛ№ 0' then
//               CellText := 'АЛ№ 0';

          end;
        end;
        vvMDN:
        begin
          MDNTemp.DataPos := Data.DataPos;
          CellText := 'МДН ' + inttostr(MDNTemp.getIntMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(MDN_NUMBER)));
        end;
        vvDoctor:
        begin
          CellText := 'Лекар ' + Adb_DM.CollDoctor.getAnsiStringMap( Data.DataPos, word(Doctor_UIN));
        end;
      end;
    end;
    1:
    begin
      case data.vid of
        vvPerformer:
        begin
          CellText := 'Лекар ' + Adb_DM.CollDoctor.getAnsiStringMap( Data.DataPos, word(Doctor_SNAME));
        end;
        vvDeput:
        begin
          CellText := 'Лекар ' + Adb_DM.CollDoctor.getAnsiStringMap( Data.DataPos, word(Doctor_SNAME));
        end;
        vvPatient:
        begin
          CellText := ADB_DM.CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_FNAME));
          CellText := CellText + ' ' + ADB_DM.CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_SNAME));
          CellText := CellText + ' ' + ADB_DM.CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_LNAME));
        end;
        vvPregled:
        begin
          CellText := 'от ' + DateToStr(ADB_DM.CollPregled.getDateMap(Data.DataPos, word(PregledNew_START_DATE)));
        end;
        vvDiag:
        begin
          FieldText := (Adb_DM.CollDiag.getAnsiStringMap(data.DataPos, word(Diagnosis_additionalCode_CL011)));
          if FieldText <> '' then
          begin
            CellText := FieldText;
          end;
        end;
        vvMDN:
        begin
          MDNTemp.DataPos := Data.DataPos;
          CellText := 'НРН ' + (MDNTemp.getAnsiStringMap(ADB_DM.AdbMain.Buf, ADB_DM.CollPregled.posData, word(MDN_NRN)));
        end;
        
      end;
    end;
    2:
    begin
      case data.vid of
        vvPerformer:
        begin
          CellText := IntToStr(data.index);
        end;
        vvDeput:
        begin
          CellText := IntToStr(data.index);
        end;
        vvDoctor:
        begin
          CellText := IntToStr(data.index);
        end;

      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrRecentDBButtonClick(sender: TVirtualStringTreeHipp; node: PVirtualNode; const numButton: Integer);
var
  data: PAspRec;
  dbPath: string;
begin
  data := sender.GetNodeData(node);
  if node = vRootRecentDB then
  begin
    case numButton of
      0:
      begin
        OpenDB(-1);
      end;
    end;
  end
  else
  begin
    case numButton of
      0:
      begin
        dbPath := Option.dblist[data.index];
        SelectFileOrFolderInExplorer(dbPath);
      end;
      1:
      begin
        dbPath := Option.dblist[data.index];
        SubButonImportFDBClick(Sender);
        pgcTree.ActivePage := tsTreeDBFB;
        vtrFDB.SetFocus;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrRecentDBChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  data: PAspRec;

  nnn: Boolean;
begin
  nnn := False;
  if Node = nil then Exit;
  data := vtrRecentDB.GetNodeData(node);
  if data.index >= 0 then
  begin
    if Assigned(streamCmdFile) then
    begin
      streamCmdFile.free;
      streamCmdFile := nil;
    end;
    if FmxProfForm <> nil then
      FmxProfForm.ClearBlanka;
    OpenDB(data.index);
    if vtrPregledPat.RootNode.ChildCount > 0 then
    begin
      pnlRoleView.ActivePanel := RolPnlDoctorSpec;
      ActiveMainButton := pnlRoleView.BtnFromName('Прегледи');
      ActiveMainButton.Click;
      ActiveMainButton.Down := True;
      vtrPregledPat.BeginUpdate;
      vtrPregledPat.EndUpdate;
      vtrPregledPat.ValidateNode(vtrPregledPat.RootNode.FirstChild.FirstChild,True);
    end;
  end;
end;

procedure TfrmSuperHip.vtrRecentDBDrawButton(sender: TVirtualStringTreeHipp; node: PVirtualNode;
        var ButonVisible: Boolean; const numButton: Integer; var imageIndex: Integer);
var
  data: PAspRec;
  dbPath: string;
begin
  data := sender.GetNodeData(node);
  if node= vRootRecentDB then
  begin
    case numButton of
      0:
      begin
        ButonVisible := True;
        imageIndex := 55;
      end;
    end;
  end
  else
  begin
    case numButton of
      0:
      begin
        ButonVisible := True;
        imageIndex := 30;
      end;
      1:
      begin
        ButonVisible := True;
        imageIndex := 104;
      end;
    end;
    //dbPath := Option.dblist[data.index];
    //SelectFileOrFolderInExplorer(dbPath);
  end;

end;

procedure TfrmSuperHip.vtrRecentDBGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  data: PAspRec;
begin
  data := vtrRecentDB.GetNodeData(node);
  if data.index < 0 then
  begin
    case Column of
      0:
      begin
        CellText := 'Избирани файлове'
      end;
    end;
  end
  else
  begin
    case Column of
      0:
      begin
        CellText := Option.dblist[data.index];
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrRecentDBKeyPress(Sender: TObject; var Key: Char);
begin
  //

end;

procedure TfrmSuperHip.vtrRecentDBMeasureTextHeight(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const Text: string; var Extent: Integer);
begin
  //
end;

procedure TfrmSuperHip.vtrRoleGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  data: PAspRec;
begin
  data := vtrRole.GetNodeData(node);
  case data.vid of
    vvRole:
    begin
      case Column of
        0:
        begin
          if data.index < 0 then
          begin
            CellText := 'Потребителски роли';
          end
          else
          begin

          end;
        end;
        1:
        begin
          if data.index < 0 then
          begin
            CellText := Format('', []);
          end
          else
          begin

          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vTrTestGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
begin
  CellText := Format('Level %d, Index %d', [Sender.GetNodeLevel(Node), Node.Index]);
end;

procedure TfrmSuperHip.WmAfterLoadDB(var Msg: TMessage);
var
  LnkFilename: string;
  fileStr: TFileStream;
  node: PVirtualNode;
  Aguid: TGUID;
begin

  Stopwatch := TStopwatch.StartNew;

  if AspectsLinkPatPregFile <> nil then
  begin
    node := pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);
    vtrPregledPat.InternalDisconnectNode(node, false);
    UnmapViewOfFile(AspectsLinkPatPregFile.Buf);
  end;

  mmoTest.Lines.Add(Format('Addresi: %d', [FNasMesto.addresColl.Count]));
  FNasMesto.FillLinkNasMestoInAddres;
  //FNasMesto.FindMach;//NasMesto;
  FillPatInDoctor;
  FillPregledInPat;
  FillIncMdnInPat;
  ADB_DM.CollIncMN.FillNzisSpec(ADB_DM.CL006Coll);
  FillIncMNInPat;
  FillOtherDocInIncMN;
  FillIncMNInPRegNrn;
  FillIncMNInPRegNomer;
  if Fdm = nil then
  begin
    Fdm := TDUNzis.Create(nil);
    if FDbName = '' then
    exit;
    Fdm.InitDb(FDbName);
  end;


  if not Fdm.IsGP then
  begin
    FillOwnerDoctorInPrgled;
  end;
  FillDoctorInPregled;

  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('прегледи в пациенти: %f', [Elapsed.TotalMilliseconds]));


  Stopwatch := TStopwatch.StartNew;
  //FillSpecNzisInMedNapr;
//  FillMedNaprInPregled;
//  Elapsed := Stopwatch.Elapsed;
//  mmoTest.Lines.Add(Format('мед. напр. в прегледи: %f', [Elapsed.TotalMilliseconds]));

  Stopwatch := TStopwatch.StartNew;
  ADB_DM.CollExamAnal.FillAnalInExamAnal(ADB_DM.CL022Coll);
  FillExamAnalInMDN;
  FillMDN_inPregled;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('МДН в прегледи: %f', [Elapsed.TotalMilliseconds]));

  Stopwatch := TStopwatch.StartNew;
  ADB_DM.CollMedNapr.FillSpecNzisInMedNapr(ADB_DM.CL006Coll);
  FillMedNaprInPregled;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('мед. напр. в прегледи: %f', [Elapsed.TotalMilliseconds]));

  Stopwatch := TStopwatch.StartNew;
  ADB_DM.CollMedNapr3A.FillSpecNzisInMedNapr3A(ADB_DM.CL006Coll);
  FillMedNapr3AInPregled;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('мед. напр. 3A в прегледи: %f', [Elapsed.TotalMilliseconds]));

  Stopwatch := TStopwatch.StartNew;
 // CollMedNaprHosp.FillSpecNzisInMedNapr3A(CL006Coll);
  FillMedNaprHospInPregled;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('мед. напр. hosp в прегледи: %f', [Elapsed.TotalMilliseconds]));

  Stopwatch := TStopwatch.StartNew;
 // CollMedNaprHosp.FillSpecNzisInMedNapr3A(CL006Coll);
  FillMedNaprLkkInPregled;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('мед. напр. LKK в прегледи: %f', [Elapsed.TotalMilliseconds]));

  Stopwatch := TStopwatch.StartNew;
  FillImunInPregled;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('имунизации. в прегледи: %f', [Elapsed.TotalMilliseconds]));

  Stopwatch := TStopwatch.StartNew;
  FillPrfCard_inPregled;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('проф. карти в прегледи: %f', [Elapsed.TotalMilliseconds]));


  Stopwatch := TStopwatch.StartNew;
  LnkFilename := ADB_DM.AdbMain.FileName.Replace('.adb', '.lnk');
  DeleteFile(LnkFilename);
  fileStr := TFileStream.Create(LnkFilename, fmCreate);
  fileStr.Size := 500000000;
  fileStr.Free;
  Aguid := ADB_DM.AdbMain.GUID;
  //CollDoctor.ShowGrid(grdNom);
  if Assigned(ADB_DM.AdbMain) then
  begin
    UnmapViewOfFile(ADB_DM.AdbMain.Buf);
    //FreeAndNil(ADB_DM.AdbMain);
  end;
  AspectsLinkPatPregFile := TMappedLinkFile.Create(LnkFilename, true, Aguid);// AspectsHipFile.GUID);

  LoadVtrPregledOnPat;
  //LoadVtrPregled;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('дърво с прегледи: %f', [Elapsed.TotalMilliseconds]));


  LoadADB;
  vtrFDB.Repaint;
  CalcStatusDB;
  WmAfterShow(Msg);
end;

procedure TfrmSuperHip.WmAfterShow(var Msg: TMessage);
begin
  Stopwatch := TStopwatch.StartNew;
  pnlRoleView.clear(False);
  //pnlTreeResize(nil);
  if Assigned(streamCmdFile) then
  begin
    streamCmdFile.free;
    streamCmdFile := nil;
  end;
  if option.dblist.Count = 1 then
  begin
    if ParamStr(3) = '' then
    begin
      OpenDB(0);
    end
    else
    begin
      OpenDB(-1);
    end;
    if vtrPregledPat.RootNode.ChildCount > 0 then
    begin
      pnlRoleView.ActivePanel := RolPnlDoctorSpec;
      ActiveMainButton := pnlRoleView.BtnFromName('Прегледи');
      ActiveMainButton.Click;
      ActiveMainButton.Down := True;
      vtrPregledPat.BeginUpdate;
      vtrPregledPat.EndUpdate;
      vtrPregledPat.ValidateNode(vtrPregledPat.RootNode.FirstChild.FirstChild,True);
      pgcWork.ActivePage := nil;
    end
    else
    begin
      pnlRoleView.ActivePanel := RolPnlAdmin;
      ActiveMainButton := pnlRoleView.BtnFromName('База данни(DB)');
      ActiveMainButton.Click;
      pnlGridSearch.height := 1;
      splSearchGridMoved(nil);
    end;
    pgcWork.ActivePage := tsFMXForm;
  end
  else
  begin
    pnlRoleView.ActivePanel := RolPnlAdmin;
    ActiveMainButton := pnlRoleView.BtnFromName('База данни(DB)');
    ActiveMainButton.Click;
    pnlGridSearch.height := 1;
    splSearchGridMoved(nil);
    pgcWork.ActivePage := tsTest;
  end;
                          
  //pgcTree.ActivePage := tsTreeRole;
//  pgcRole.ActivePage := tsRoleSelect;
//  pnlRoleView.ActivePanel := RolPnlDoctorSpec;
//  ActiveMainButton := pnlRoleView.BtnFromName('Прегледи');
//  ActiveMainButton.Click;
//  grdSearch.height := 1;
//  splSearchGridMoved(nil);
//  pnlTreeResize(nil);

  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('WmAfterShow  за %f',[ Elapsed.TotalMilliseconds]));
  Self.BorderStyle := bsNone;
  SetStyle;
  Visible := True;
end;

procedure TfrmSuperHip.WMCertStorage(var Msg: TMessage);
begin
  if pgcTree.ActivePage = tsTreePat then
    vtrPregledPat.Repaint;
  if (pgcTree.ActivePage = tsTempVTR) and (vtrTemp.Header.Columns.Items[0].Tag = Integer(vvDoctor) ) then
    vtrTemp.Repaint;
  if (FmxTokensForm <> nil) and (fmxCntrDyn.FireMonkeyForm = FmxTokensForm) then
   FmxTokensForm.FillTokens;
end;

procedure TfrmSuperHip.WmCntLoadDB(var Msg: TMessage);
begin
  //rlbtn1.MaxValue := Msg.WParam;
  mmoTest.Lines.Add(inttostr(Msg.WParam));
 // case
//    //tcolt(MSG.LParam
//  end;
end;

procedure TfrmSuperHip.WmGetMinMaxInfo(var Msg: TMessage);
var
  WorkArea: TRect;
  Info: PMinMaxInfo;
begin
  Info := PMinMaxInfo(Msg.LParam);

  // Взимаме работната област (без taskbar)
  SystemParametersInfo(SPI_GETWORKAREA, 0, @WorkArea, 0);

  Info^.ptMaxPosition.X := WorkArea.Left;
  Info^.ptMaxPosition.Y := WorkArea.Top;
  Info^.ptMaxSize.X := WorkArea.Right - WorkArea.Left;
  Info^.ptMaxSize.Y := WorkArea.Bottom - WorkArea.Top;

  Msg.Result := 0;
end;

procedure TfrmSuperHip.WMHelp(var Msg: TWMHelp);
begin
  if hntMain.ShowingHint then
    Exit;
  inherited;
  if fmxCntrDyn.FireMonkeyFormHandle = msg.HelpInfo.hItemHandle then
  begin
    if fmxCntrDyn.FireMonkeyForm = FmxProfForm then
    begin
      FmxProfForm.WmHelp(msg.HelpInfo.MousePos);
    end;
  end
  else
  if fmxCntrTitleBar.FireMonkeyFormHandle = msg.HelpInfo.hItemHandle then
  begin
    FmxTitleBar.WmHelp(msg.HelpInfo.MousePos);
  end
  else
  if FmxTitleBar.p1.IsOpen then
  begin
    FmxTitleBar.WmHelp(msg.HelpInfo.MousePos);
  end
end;

procedure TfrmSuperHip.WMHipDeactivate(var Msg: TMessage);
var
  patID, PregID: Integer;
begin
  if FmxProfForm = nil then Exit;
  patID := FmxProfForm.Patient.getIntMap(ADB_DM.AdbMain.buf, ADB_DM.CollPatient.posData, word(PatientNew_ID));
  pregID := FmxProfForm.Pregled.getIntMap(ADB_DM.AdbMain.buf, ADB_DM.CollPregled.posData, word(PregledNew_ID));
  PostMessage(HipHandle, WM_Hip_Deactivate, patID, pregID);
end;

procedure TfrmSuperHip.WMHipScrollPatient(var Msg: TMessage);
var
  run: PVirtualNode;
  runPreg, runCl132: PVirtualNode;
  PlanedPreg: TPregledPlanedInfo;

  data, dataPreg, dataCL132: PAspRec;
  FindedCl132: Boolean;
  cl132:string;
  copyDataStruct: TCopyDataStruct;
begin
  run := vtrPregledPat.RootNode.FirstChild.FirstChild;
  while run <> nil do
  begin
    data := pointer(PByte(run) + lenNode);
    if ADB_DM.CollPatient.getIntMap(data.DataPos, word(PatientNew_ID)) = Msg.WParam then
    begin
      if data.DataPos <> FmxProfForm.Patient.DataPos then
      begin
        vtrPregledPat.Selected[run] := True;
        vtrPregledPat.FocusedNode := run;
      end;
      runPreg := run.FirstChild;
      while runPreg <> nil do
      begin
        dataPreg := pointer(PByte(runPreg) + lenNode);
        case dataPreg.vid of
          vvPregled:
          begin
            FindedCl132 := False;// свалям флага за намерено цл132
            cl132 := '';
            runCl132 := runPreg.FirstChild;
            while runCl132 <> nil do
            begin
              dataCL132 := pointer(PByte(runCl132) + lenNode);
              case dataCL132.vid of
                vvCl132:
                begin
                  CL132Temp.DataPos := dataCL132.DataPos;
                  if not FindedCl132 then
                  begin
                    FindedCl132 := true;// вдигам флага за намерено цл132 в тоя преглед
                    PlanedPreg.PregledID :=
                         ADB_DM.CollPregled.getIntMap(dataPreg.DataPos, word(PregledNew_ID));
                    PlanedPreg.IsDone := True;
                  end;
                  PlanedPreg.Cl132 :=
                       cl132 + CL132Temp.getAnsiStringMap(AspectsNomFile.Buf, ADB_DM.CL132Coll.posData, word(CL132_Key)) + '; ';
                end;
              end;
              runCl132 := runCl132.NextSibling;
            end;
          end;
        end;
        if PlanedPreg.Cl132 <> '' then
        begin
          copyDataStruct.dwData := Integer(1); // planedPregInfo
          copyDataStruct.cbData := SizeOf(PlanedPreg);
          copyDataStruct.lpData := @PlanedPreg;
          SendMessage(HipHandle, wm_CopyData, 0, Integer(@copyDataStruct));
        end;
        runPreg := runPreg.NextSibling;
      end;
      Exit;
    end;
    run := run.NextSibling;
  end;
end;

procedure TfrmSuperHip.WMMove(var Msg: TWMMove);
begin
  //DynWinPanel1.Perform(WM_MOVE, 0, 0);
end;

procedure TfrmSuperHip.WMNCACTIVATE(var M: TWMNCACTIVATE);
begin
  inherited;
  //tmr1.Tag := Integer(M.Active);

  tmr1.Enabled := True;
  //FmxTitleBar.ActivateTitleBar(M.Active);
end;

procedure TfrmSuperHip.WMNCHitTest(var Msg: TWMNCHitTest);
var
  ScreenPt: TPoint;
  Sizegrip: Integer;
begin
  inherited;
  //syndtNzisReq.Text := IntToStr(Msg.YPos);
  Sizegrip:= 8;
  ScreenPt := ScreenToClient(Point(Msg.Xpos, Msg.Ypos));
  if (ScreenPt.x >= Width - Sizegrip) and (ScreenPt.y >= Height - Sizegrip) then
  begin
    Msg.Result := HTBOTTOMRIGHT;
  end
  else
  if (ScreenPt.x >= Width - Sizegrip) then
  begin
    Msg.Result := HTRIGHT;
  end
  else
  if (ScreenPt.y >= Height - Sizegrip) then
  begin
    Msg.Result := HTBOTTOM;
  end
  else
  if (ScreenPt.y < Sizegrip) then
  begin
    Msg.Result := HTTOP;
  end;
end;

procedure TfrmSuperHip.WMNzisSetNrn(var Msg: TMessage);
var
  node: PVirtualNode;
  data: PAspRec;
  status: Word;
begin
  node := PVirtualNode(Msg.WParam);
  data := Pointer(PByte(node) + lenNode);

  if tsFMXForm.Tag = data.DataPos then
  begin
    FmxProfForm.animNrnStatus.Enabled := False;
    FmxProfForm.animNrnStatus.Stop;
    FmxProfForm.linStatusNRN.Opacity := 1;
    FmxProfForm.edtAmbList.Repaint;
  end;
  case data.vid of
    vvPregled:
    begin
      status := ADB_DM.CollPregled.getWordMap(data.DataPos, word(PregledNew_NZIS_STATUS));
    end;
  end;
  if (Msg.LParam = 0) and (status = 5) then //ok
  begin
    //if edtToken.Text <> '' then
    begin

      //FmxProfForm.animNrnStatus.Enabled := true;
      if chkAutamatNzis.Checked then
      begin
        ADB_DM.CollPregled.SetWordMap(data.DataPos, word(PregledNew_NZIS_STATUS),6);
        closePregX003(node);
      end;
    end;
  end;
  //if (Msg.LParam = 0) and (status = 10) then //ok
//  begin
//    if edtToken.Text <> '' then
//    begin
//      CollPregled.SetWordMap(data.DataPos, word(PregledNew_NZIS_STATUS),6);
//      FmxProfForm.animNrnStatus.Enabled := true;
//      closePregX003(node);
//    end;
//  end;

end;

procedure TfrmSuperHip.WMNzisSetPlaned(var Msg: TMessage);
begin
  TestPlaned := True;
  try
    vtrPregledPat.Repaint;
  except

  end;
end;

procedure TfrmSuperHip.WmProgresLoadDB(var Msg: TMessage);
var
  RunNode: PVirtualNode;
  data: PAspRec;
begin
  RunNode := vTablesRoot.firstChild;
  while RunNode <> nil do
  begin
    data := vtrFDB.GetNodeData(RunNode);
    if data.index = MSG.LPARAM then
    begin
      vtrFDB.RepaintNode(RunNode);
      Break;
    end;
    RunNode := RunNode.NextSibling;
  end;
  
  //case TTablesTypeHip(MSG.LParam) of
//    PACIENT:
//    begin
//      //vtrFDB.getnode
//    end;
//  end;

end;

procedure TfrmSuperHip.WmSendedNzis(var Msg: TMessage);
var
  v: PVirtualNode;
  data: PAspRec;
begin
//  if (ActiveSubButton <> nil) and (ActiveSubButton.MaxValue > 0) then
//  begin
//    ActiveSubButton.Position := ActiveSubButton.Position + 1;
//    ActiveSubButton.Hint := IntToStr(ActiveSubButton.Position);
//    ActiveSubButton.ShowHint := false;
//    ActiveSubButton.ShowHint := True;
//    ActiveSubButton.Repaint;
//    if ActiveSubButton.Position >= ActiveSubButton.MaxValue then
//    begin
//      ActiveSubButton.Position := 0;
//      ActiveSubButton.Hint := '';
//      ActiveSubButton.ShowHint := false;
//      ActiveSubButton.Repaint;
//    end;

//  end;
  v := Pointer(msg.WParam);
  if v <> nil then
  begin
    vtrNomenNzis.UpdateWaitNode(v, false, false);
    v.Dummy := 77;
    data := vtrNomenNzis.GetNodeData(v);
    case data.vid of
      vvNomenNzisUpdate:
      begin
        BtnXMLtoCL000ForUpdate(v);
        FillCl088Update;
        mmoTest.Lines.Add('CL088Coll.FCL088New.Count= ' + IntToStr(ADB_DM.CL088Coll.FCL088New.Count));
      end;
    end;
  end
  else
  begin
    syndtXML.Lines.LoadFromStream( Adb_DM.ListNomenNzisNames[msg.LParam].xmlStream, TEncoding.UTF8);
  end;
end;

procedure TfrmSuperHip.WMSetPatID(var Msg: TMessage);
begin  //zzzzzz mainSeder
  //frmlMainSender.DU.ibsqlCommandUdost.Close;
//  frmlMainSender.DU.ibsqlCommandUdost.SQL.Text :=
//    'select * from pacient pa where pa.id = :id';
//  frmlMainSender.DU.ibsqlCommandUdost.ParamByName('id').AsInteger := Msg.WParam;
//  frmlMainSender.DU.ibsqlCommandUdost.Close;
end;

procedure TfrmSuperHip.WMShowGrid(var Msg: TMessage);
var
  i: Integer;
begin
  TBaseCollection(grdSearch.Tag).ShowLinksGrid(grdSearch);
  FmxFinderFrm.IsFinding := false;
  tlb1.Visible := False;
  tlb1.Visible := True;
end;

procedure TfrmSuperHip.WMStartEditing(var Message: TMessage);


var
  Node: PVirtualNode;

begin
  Node := Pointer(Message.WParam);
  vtrOptions.EditNode(Node, 1);
end;

procedure TfrmSuperHip.WMSuperResize(var Msg: TMessage);
begin
  //Self.SetBounds(0, 0, Msg.WParam, Msg.LParam);
end;

procedure TfrmSuperHip.WM_NCCALCSIZE(var Msg: TMessage);
begin
  // Когато прозорецът е максимизиран, махни системните рамки (просвета)
  if Msg.WParam <> 0 then
  begin
    if WindowState = wsMaximized then
    begin
      // Зануляваме всички отстъпи – така формата заема целия WorkArea
      Msg.Result := 0;
      Exit;
    end;
  end;
  inherited;
end;

procedure TfrmSuperHip.WVBrowser1AfterCreated(Sender: TObject);
begin
  //WVWindowParent1.UpdateSize;
//  //Caption := 'MiniBrowser';
//
//  // We need to a filter to enable the TWVBrowser.OnWebResourceRequested event
//  WVBrowser1.AddWebResourceRequestedFilterWithRequestSourceKinds('*', COREWEBVIEW2_WEB_RESOURCE_CONTEXT_IMAGE, COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS_ALL);
//  WVBrowser1.AddWebResourceRequestedFilterWithRequestSourceKinds('*', COREWEBVIEW2_WEB_RESOURCE_CONTEXT_MEDIA, COREWEBVIEW2_WEB_RESOURCE_REQUEST_SOURCE_KINDS_ALL);
//
//  WVBrowser1.CoreWebView2PrintSettings.HeaderTitle := 'Tituloooooo';
//  WVBrowser1.CoreWebView2PrintSettings.ShouldPrintHeaderAndFooter := True;
end;



{ TScrollBox }

//procedure TScrollBox.WMHScroll(var Message: TWMHScroll);
//begin
//   inherited;
//   if Assigned(FOnScrollHorz) then  FOnScrollHorz(Self);
//
//end;
//
//procedure TScrollBox.WMVScroll(var Message: TWMVScroll);
//begin
//  inherited;
//   if Assigned(FOnScrollVert) then  FOnScrollVert(Self);
//end;

{ TExHint }

constructor TExHint.Create(AOwner: TComponent);
begin
  inherited;

end;

{ TMyProvider }

function TfrmSuperHip.GetADBBuffer: Pointer;
begin
  Result := ADB_DM.AdbMain.Buf;
end;

function TfrmSuperHip.GetCollectionByType(ACollType: Word): TBaseCollection;
begin
  Result := nil;
  case TCollectionsType(ACollType) of

    ctPractica:
      Result := ADB_DM.CollPractica;

    ctPregledNew:
      Result := ADB_DM.CollPregled;

    ctPatientNew:
      Result := ADB_DM.CollPatient;

    ctPatientNZOK:
      Result := ADB_DM.CollPatPis;

    ctDiagnosis:
      Result := ADB_DM.CollDiag;

    ctDiagnosisDel:
      Result := ADB_DM.CollDiag;   // del → същата структура, само че за изтрити записи

    ctMDN:
      Result := ADB_DM.CollMDN;

    ctDoctor:
      Result := ADB_DM.CollDoctor;

    ctOtherDoctor:
      Result := ADB_DM.CollOtherDoctor;

    ctUnfav:
      Result := ADB_DM.CollUnfav;

    ctUnfavDel:
      Result := ADB_DM.CollUnfav;

    ctMkb:
      Result := ADB_DM.CollMkb;

    ctExam_boln_list:
      Result := ADB_DM.CollEbl;

    ctExamAnalysis:
      Result := ADB_DM.CollExamAnal;

    ctExamImmunization:
      Result := ADB_DM.CollExamImun;

    ctProcedures:
      Result := ADB_DM.ProceduresNomenColl;

    ctKARTA_PROFILAKTIKA2017:
      Result := ADB_DM.CollCardProf;

    ctBLANKA_MED_NAPR:
      Result := ADB_DM.CollMedNapr;

    ctBLANKA_MED_NAPR_3A:
      Result := ADB_DM.CollMedNapr3A;

    ctHOSPITALIZATION:
      Result := ADB_DM.CollMedNaprHosp;

    ctEXAM_LKK:
      Result := ADB_DM.CollMedNaprLkk;

    ctINC_MDN:
      Result := ADB_DM.CollIncMdn;

    ctINC_NAPR:
      Result := ADB_DM.CollIncMN;

    ctNZIS_PLANNED_TYPE:
      Result := ADB_DM.CollNZIS_PLANNED_TYPE;

    ctNZIS_QUESTIONNAIRE_RESPONSE:
      Result := ADB_DM.CollNZIS_QUESTIONNAIRE_RESPONSE;

    ctNZIS_QUESTIONNAIRE_ANSWER:
      Result := ADB_DM.CollNZIS_QUESTIONNAIRE_ANSWER;

    ctNZIS_DIAGNOSTIC_REPORT:
      Result := ADB_DM.CollNZIS_DIAGNOSTIC_REPORT;

    ctNZIS_RESULT_DIAGNOSTIC_REPORT:
      Result := ADB_DM.CollNZIS_RESULT_DIAGNOSTIC_REPORT;

    ctNZIS_ANSWER_VALUE:
      Result := ADB_DM.CollNZIS_ANSWER_VALUE;

    ctNzisToken:
      Result := ADB_DM.CollNzisToken;

    ctCertificates:
      Result := ADB_DM.CollCertificates;

    ctAddres:
      Result := FNasMesto.addresColl;

  else
    //raise Exception.Create('Unknown collection type: ' +
//      TRttiEnumerationType.GetName(TCollectionsType(ACollType)));
  end;
end;


initialization
  // Enable raw mode (default mode uses stack frames which aren't always generated by the compiler)
  Include(JclStackTrackingOptions, stRawMode);
  // Disable stack tracking in dynamically loaded modules (it makes stack tracking code a bit faster)
  Include(JclStackTrackingOptions, stStaticModuleList);

  // Initialize Exception tracking
  JclStartExceptionTracking;

  //GlobalWebView2Loader                := TWVLoader.Create(nil);
//  GlobalWebView2Loader.UserDataFolder := ExtractFileDir(Application.ExeName) + '\CustomCache';
//  GlobalWebView2Loader.RemoteDebuggingPort := 9999;
//  GlobalWebView2Loader.RemoteAllowOrigins := '*';

  // Set GlobalWebView2Loader.BrowserExecPath if you don't want to use the evergreen version of WebView Runtime
  //GlobalWebView2Loader.BrowserExecPath := 'c:\WVRuntime';

  // Uncomment these lines to enable the debug log in 'CustomCache\EBWebView\chrome_debug.log'
  //GlobalWebView2Loader.DebugLog       := TWV2DebugLog.dlEnabled;
  //GlobalWebView2Loader.DebugLogLevel  := TWV2DebugLogLevel.dllInfo;

  //GlobalWebView2Loader.AreBrowserExtensionsEnabled := True;
//  GlobalWebView2Loader.StartWebView2;
finalization

  // Uninitialize Exception tracking
  JclStopExceptionTracking;

end.
