unit SuperHipp;  //clone .ini'  SetParent  wel  .rtt lnk  1200  last  mark   img32
interface

  uses
  Parnassus.FMXContainer, Parnassus.FMXContainerReg, MainRttiExpl,
  FMX.Forms, FMX.Edit, FMX.StdCtrls, ProfForm, FmxWelcomeScreen,
  RolePanels, OptionsForm,
  Tokens, WalkFunctions, TitleBar, RoleBar, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus,
  Vcl.Menus, Vcl.AppEvnts, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  Winapi.ActiveX,
  Vcl.Controls, Vcl.Dialogs, SynEditHighlighter, SynHighlighterXML, RoleButton,
  Vcl.ComCtrls, Vcl.StdCtrls, SynEdit, VCLTee.Control, VCLTee.Grid,
  Vcl.OleCtrls, WMPLib_TLB, Vcl.ToolWin, Vcl.WinXCtrls, Vcl.Forms,
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


  GR32_Image, PDFium.Frame,

  system.DateUtils,
  NzisThreadFull, System.IOUtils,

  Aspects.Types, SuperObject, superxmlparser,

  Table.Role, Vcl.Imaging.pngimage,
  Nzis.Nomen.baseCL000,
  XBookComponent2, XLSBook2,
  Xc12Utils5, XLSUtils5, XLSCellMMU5, XLSNames5, XLSFormattedObj5,
  Xc12DataStyleSheet5,
  XLSSheetData5, XBookUtils2, XBookPrint2, XLSExportCSV5,
  Table.Cl132, table.PR001, table.CL050, table.cl134, table.cl142,
  Table.Cl088, Table.CL139, Table.CL144, table.Cl037,
  table.CL022, Table.Cl038, table.CL024, Table.NomenNzis,
  table.cl006, table.nzistoken,
  Table.BLANKA_MED_NAPR,
  table.doctor, table.unfav,
  Table.Mkb, Table.PregledNew, Table.PatientNew, Table.PatientNZOK,
  Table.Diagnosis, Table.MDN, Table.EventsManyTimes,
  Table.AnalsNew, Table.practica, Table.ExamAnalysis, table.ExamImmunization,
  table.Procedures, Table.NZIS_PLANNED_TYPE, Table.NZIS_QUESTIONNAIRE_RESPONSE,
  Table.NZIS_QUESTIONNAIRE_ANSWER, Table.NZIS_ANSWER_VALUE,
  Table.NZIS_DIAGNOSTIC_REPORT, Table.NZIS_RESULT_DIAGNOSTIC_REPORT,
  Table.Certificates,

  RealObj.NzisNomen, Aspects.Collections, RealObj.RealHipp,

  FinderFormFMX,
  FMX.Types, System.Bindings.Expression,
  System.Bindings.ExpressionDefaults,

  DbHelper, ADB_DataUnit,
   System.TypInfo,DlgSuperCert23,
 //import Nzis
   X006, X002,
 //sbx
  SBXMLSec, SBXMLSig, SBXMLEnc, SBxCertificateStorage, sbxtypes,
  SBXMLCore, SBTypes, SBXMLDefs, SBX509,   SBXMLUtils, SBWinCertStorage, SBUtils,
  SBBaseClasses, SBSocketClient, SBSocket, sbxcore,
  SBSimpleSSL, SBHTTPSClient, SBPKCS11Base, SBCustomCertStorage, SBConstants,
  SBPKCS11CertStorage, SBCertValidator, SBSSLCommon,SBLists,
  SBXMLAdESIntf, SBStrUtils, SBSSLConstants, SBHTTPSConstants, CertHelper,
  Vcl.DBCtrls, System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls

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

  TNomenNzisRec = class
  public
    Cl000Coll: TCL000EntryCollection;
    xmlStream: TMemoryStream;
    AspColl: TBaseCollection;
    nomenNzis: TNomenNzisItem;
    constructor Create;
    destructor Destroy;  override;
  end;

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
    hntLek: TBalloonHint;
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
    vtrSearch: TVirtualStringTreeHipp;
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
    pnlTest: TPanel;
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
    MainMenu1: TMainMenu;
    mniwww1: TMenuItem;
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
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
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
    procedure btnHelpClick(Sender: TObject);
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
    procedure vtrGraphGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrGraphInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure ProfGraphClick(Sender: TObject);
    procedure edtGraphDayChange(Sender: TObject);
    procedure vtrGraphChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure Button2Click(Sender: TObject);
    procedure HipNomenAnalsClick(Sender: TObject);
    procedure vtrNewAnalGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtrMkbGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
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
    procedure vtrPregledPatDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string;
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
    procedure vtrTempLoadNode(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Stream: TStream);
    procedure vtrNewAnalSaveNode(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Stream: TStream);
    procedure vtrTempMeasureItem(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
    procedure vtrTempInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure mniAnalsClick(Sender: TObject);
    procedure mniMkb10Click(Sender: TObject);
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
    procedure vtrTempColumnClick(Sender: TBaseVirtualTree; Column: TColumnIndex;
      Shift: TShiftState);
    procedure vtrTempGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: TImageIndex;
      var ImageList: TCustomImageList);
    procedure vtrTempMeasureTextWidth(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      const Text: string; var Extent: Integer);
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
   procedure InitColl;
   procedure FreeColl;
   procedure FreeFMXDin;
   procedure ClearColl;
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

    DiagTemp: TDiagnosisItem;
    MDNTemp: TMDNItem;
    ExamAnalTemp: TExamAnalysisItem;
    DoctorTemp: TDoctorItem;
    EvnTemp: TEventsManyTimesItem;
    AnalTemp: TAnalsNewItem;
    Cl022temp: TCL022Item;
    CL132Temp: TRealCl132Item;
    PR001Temp: TRealPR001Item;
    CL088Temp: TRealCl088Item;
    ProcTemp: TRealProceduresItem;
    FPatientTemp: TRealPatientNewItem;
    NZIS_PLANNED_TYPETemp: TRealNZIS_PLANNED_TYPEItem;
    NZIS_QUESTIONNAIRE_RESPONSETemp: TRealNZIS_QUESTIONNAIRE_RESPONSEItem;
    NZIS_QUESTIONNAIRE_ANSWERTemp: TRealNZIS_QUESTIONNAIRE_ANSWERItem;
    NZIS_ANSWER_VALUETemp: TRealNZIS_ANSWER_VALUEItem;
    NZIS_DIAGNOSTIC_REPORTTemp: TRealNZIS_DIAGNOSTIC_REPORTItem;
    NZIS_Result_DIAGNOSTIC_REPORTTemp: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
    procedure SetPatientTemp(const Value: TRealPatientNewItem);
    property PatientTemp: TRealPatientNewItem read FPatientTemp write SetPatientTemp;


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
    procedure FillEventsInPat;
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
    FmxTokensForm: TfrmFmxTokens;
    FmxTitleBar: TfrmTitlebar;
    FmxRoleBar: TfrmRolebar;
    FmxRolePanel: TfrmRolePanels;
    FmxOptionsFrm: TfrmOptionsForm;


  protected // TempVtr
    procedure vtrSincPLGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
        TextType: TVSTTextType; var CellText: string);
  private
    FTestPlaned: Boolean; //sign
    procedure UpdateCertificates(certNom: string);
    procedure FormatText(Sender: TObject; var Text: XMLString;
            TextType: TElXMLTextType; Level: Integer; const Path: XMLString);
    property TestPlaned: Boolean read FTestPlaned write FTestPlaned;
  public
    scale: Double;
    HipHandle: THandle;
    CollPregled: TRealPregledNewColl;
    CollPractica: TPracticaColl;

    ListPregledForFDB: TList<TPregledNewItem>;
    CollDoctor: TRealDoctorColl;
    ListDoctorForFDB: TList<TDoctorItem>;
    ListPregledLinkForInsert: TList<PVirtualNode>;
    CollUnfav: TRealUnfavColl;
    CollPregledVtor: TList<TRealPregledNewItem>;
    CollPregledPrim: TList<TRealPregledNewItem>;
    CollPatient: TRealPatientNewColl;
    CollPregForSearch: TRealPregledNewColl;
    ListPatientForFDB: TList<TPatientNewItem>;
    CollPatPis: TRealPatientNZOKColl;
    AcollpatFromDoctor: TRealPatientNewColl;
    ACollPatFDB: TRealPatientNewColl;
    ACollNovozapisani: TRealPatientNewColl;
    CollDiag: TRealDiagnosisColl;
    CollMDN: TRealMDNColl;
    CollEventsManyTimes: TRealEventsManyTimesColl;
    CollEbl: TRealExam_boln_listColl;
    CollExamAnal: TRealExamAnalysisColl;
    CollExamImun: TRealExamImmunizationColl;
    CollProceduresNomen: TRealProceduresColl;
    CollProceduresPreg: TRealProceduresColl;
    CollCardProf: TRealKARTA_PROFILAKTIKA2017Coll;
    CollMedNapr: TRealBLANKA_MED_NAPRColl;
    CollNZIS_PLANNED_TYPE: TRealNZIS_PLANNED_TYPEColl;
    CollNZIS_QUESTIONNAIRE_RESPONSE: TRealNZIS_QUESTIONNAIRE_RESPONSEColl;
    CollNZIS_QUESTIONNAIRE_ANSWER: TRealNZIS_QUESTIONNAIRE_ANSWERColl;
    CollNZIS_ANSWER_VALUE: TRealNZIS_ANSWER_VALUEColl;
    CollNZIS_DIAGNOSTIC_REPORT: TRealNZIS_DIAGNOSTIC_REPORTColl;
    CollNzis_RESULT_DIAGNOSTIC_REPORT: TRealNZIS_RESULT_DIAGNOSTIC_REPORTColl;

    CollNzisToken: TNzisTokenColl;
    CollCertificates: TCertificatesColl;

    CollMkb: TMkbColl;
    AZipHelpFile: TZipFile;
    DownloadedStream: TStream;
    ListNomenNzisNames: TList<TNomenNzisRec>;
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
    AspectsHipFile : TMappedFile;
    AspectsLinkPatPregFile : TMappedLinkFile;
    AspectsLinkNomenHipAnalFile : TMappedFile;
    AspectsOptionsLinkFile: TMappedLinkFile;


    AnalsNewColl: TAnalsNewColl;
    CL006Coll: TRealCL006Coll;
    CL022Coll: TRealCL022Coll;
    CL024Coll: TRealCL024Coll;
    CL037Coll: TRealCL037Coll;
    CL038Coll: TRealCL038Coll;
    CL050Coll: TCL050Coll;
    CL088Coll: TRealCL088Coll;
    CL132Coll: TRealCL132Coll;
    CL134Coll: TRealCL134Coll;
    CL139Coll: TRealCL139Coll;
    CL142Coll: TRealCL142Coll;
    CL144Coll: TRealCl144Coll;

    PR001Coll: TRealPR001Coll;
    NomenNzisColl: TNomenNzisColl;
    profGR: TProfGraph;
    lstPatGraph: TList<TRealPatientNewItem>;
    streamCmdFile: TFileCmdStream;
    streamCmdFileNomenNzis: TFileCmdStream;
    FDBHelper: TDbHelper;
    Adb_DM: TADBDataModule;
    ResultNzisToken: TStringList;
    token: string;
    TokenToTime: TDateTime;
    InXmlStream: TStringStream;
    FCertificate: TElX509Certificate;
    streamRes: TMemoryStream;
    FinderRec: TFinderRec;
    KeyCNT: boolean;
    EditorGrid: TWinControl;
    DragObj: TDropFmxObject;
    CanSelectNodeFromSearchGrid: Boolean;

    procedure LoadThreadDB(dbName: string);
    procedure StartHistoryThread(dbName: string);
    procedure StartCertThread();
    procedure StartAspectPerformerThread();

    procedure FillMedNaprInPregled;
    procedure FillSpecNzisInMedNapr;
    procedure FillImunInPregled;
    procedure FillMDN_inPregled;
    procedure FillPrfCard_inPregled;
    procedure LoadVtrMinaliPregledi(node: PVirtualNode; Apat: TRealPatientNewItem = nil);
    procedure LoadVtrSpisyciNeblUsl;
    procedure SortListString(list: TList<TString>);
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
    procedure LoadVtrDoctor;
    procedure FillCertInDoctors;
    function FindCertFromSerNumber(serNom: TArray<System.Byte>): TElX509Certificate;
    procedure GetPatProf(var pat: TRealPatientNewItem);
    procedure GetCurrentPatProf(pat: TRealPatientNewItem);
    procedure GetCurrentPatProf1(pat: TRealPatientNewItem);
    procedure FillOldPlanesInCurrentPlan;
    function FindNodevtrPreg(DirectionFind: TDirectionFinder; ACol: TColumnIndex): boolean;
    //function FindNodevtr(DirectionFind: TDirectionFinder; vtr: TVirtualStringTree): boolean;
    procedure AddNewPregled;
    procedure AddNewDiag(vPreg: PVirtualNode; cl011, cl011Add: string; rank: integer; DataPosMkb: cardinal);
    procedure RemoveDiag(vPreg: PVirtualNode; diag: TRealDiagnosisItem); overload;
    procedure RemoveDiag(vPreg: PVirtualNode; diagDataPos: cardinal); overload;
    procedure AddNewPlan(vPreg: PVirtualNode; var gr: TGraphPeriod132; var TreeLinkPlan: PVirtualNode);
    procedure AddNewPregledOld;
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
    procedure TitleSetingsClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);

    procedure RoleBarOnProgres(Sender: TObject; var progres: integer);
    procedure RoleBarBtnRoleClick(Sender: TObject);


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
  node, nodePat: PVirtualNode;
  data: PAspRec;
begin
  Stopwatch := TStopwatch.StartNew;
  linkPos := 100;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  FPosLinkData := pCardinalData^;
  while linkPos < FPosLinkData do
  begin
    node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
    data := Pointer(PByte(node)+ lenNode);
    if data.vid = vvDoctor then
    begin
      if data.DataPos <> 123456 then
      begin
        nodePat := node.Parent;
        //

      end;
    end;
    inc(linkPos, LenData);
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'patlist ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.btn12Click(Sender: TObject);
begin
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
begin
  //Application.CreateForm(TFrmRTTIExplLite, FrmRTTIExplLite);
  //FrmRTTIExplLite.Show;
  FmxProfForm.ChangePositionScroll(0, 2000);
end;

procedure TfrmSuperHip.btnNzisProfClick(Sender: TObject);
begin
  AddNewPregled;

  CheckCollForSave;
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
begin
  fmxCntrDyn.ChangeActiveForm(FmxProfForm);
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
  BindExpr.Compile([TBindingAssociation.Create(collpatient, 'patient')]);
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
  CollPregled.IndexValue(PregledNew_ANAMN); // за забързване на търсенето (предизвиква операционната система да кешира ...)
  CollPregled.Clear;

  CollPregled.ArrPropSearch := [PregledNew_AMB_LISTN, PregledNew_NRN, PregledNew_ANAMN];
  //CollPatient.ArrPropSearch := [PatientNew_ID, PatientNew_EGN, PatientNew_BIRTH_DATE, PatientNew_FNAME];

  thrSearch := TSearchThread.Create(true);
  thrSearch.CollForFind := CollPregled;
  thrSearch.CollPat := CollPatient;
  thrSearch.collPreg := CollPregled;
  thrSearch.CollExamImun := CollExamImun;
  //thrSearch.collPatForSearch := CollPatient.CollForSearch;
  //thrSearch.collPregForSearch := CollPregForSearch;

  thrSearch.vtr := vtrPregledPat;
  thrSearch.bufLink := AspectsLinkPatPregFile.Buf;
  thrSearch.BufADB := AspectsHipFile;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  FPosLinkData := pCardinalData^;
  thrSearch.FPosData := FPosLinkData;
  thrSearch.BufADB := AspectsHipFile.Buf;


  thrSearch.grdSearch := grdSearch;
  thrSearch.OnShowGrid := OnShowGridSearch;
  grdSearch.Tag := word(vvPatient);

  thrSearch.Resume;
  //Panel1.Visible := False;
  Exit;
  //AspectsLinkPatPregFile.Buf
  //CollPregled
  //PregledNew_ANAMN


  Stopwatch := TStopwatch.StartNew;
  CollPregled.ListDataPos.Clear;
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
  if CollPregled.ListDataPos.Count > 0 then
  begin
    CollPregled.ShowLinksGrid(grdSearch);
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

procedure TfrmSuperHip.btnHelpClick(Sender: TObject);
begin
  SendMessage(Handle, WM_SYSCOMMAND, SC_CONTEXTHELP, 0);
  //Application.WM_HELP
  //pgcRole.ActivePage := tsRoleDescr;
end;

procedure TfrmSuperHip.btnHistNavClick(Sender: TObject);
var
  i: Integer;
  histnav: THistoryNav;
  vpreg: PVirtualNode;
  datapreg, datapat: PAspRec;

begin
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
  for i := 0 to CollMkb.Count - 1 do
  begin
    mkb := CollMkb.getAnsiStringMap(CollMkb.Items[i].DataPos, Word(Mkb_CODE));
    if mkb.StartsWith('M43.98') then
      Break;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.lines.add(Format('mkb: %f', [Elapsed.TotalMilliseconds]));

  //TempFindedItem.DataPos := CollPregled.ListNodes[grdNom.Selected.Row].DataPos;
  //data := pointer(PByte(runNode) + lenNode);
  if false then
  begin
    data := CollPregled.ListNodes[grdNom.Selected.Row];
    node := Pointer(PByte(data) - lenNode);
    vtrPregledPat.Selected[node] := True;
    vtrPregledPat.FocusedNode := node;
  end;
end;

procedure TfrmSuperHip.btnInClick(Sender: TObject);
begin
  //btnIn.Parent :=

end;

procedure TfrmSuperHip.btnManagerClick(Sender: TObject);
begin
  pgcTree.ActivePage := tsTreeRole;
  pgcRole.ActivePage := tsRoleManager;
end;

procedure TfrmSuperHip.btnNextClick(Sender: TObject);
begin
  if CollUnfav.CurrentYear < 2032 then
  begin
    CollUnfav.CurrentYear := CollUnfav.CurrentYear + 1;
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
  if CollUnfav.CurrentYear > 2024 then
  begin
    CollUnfav.CurrentYear := CollUnfav.CurrentYear - 1;
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
  Adb_DM.CollPrac := CollPractica;
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
//  CL024Coll.UpdateCL024;
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
  if NomenNzisColl.items[data.index].PRecord = nil then
  begin
    nzisThr.NomenID := NomenNzisColl.items[data.index].getAnsiStringMap(NomenNzisColl.Buf, NomenNzisColl.posData, word(NomenNzis_NomenID));
  end
  else
  begin
    nzisThr.NomenID := NomenNzisColl.items[data.index].PRecord.NomenID;
  end;
  nzisThr.OnSended := NzisOnSended;
  nzisThr.HndSuperHip := Self.Handle;
  nzisThr.Node := node;
  nzisThr.MsgType := TNzisMsgType.C001;
  nzisThr.StreamData := ListNomenNzisNames[data.index].xmlStream;
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
  if NomenNzisColl.items[data.index].PRecord = nil then
  begin
    nzisThr.NomenID := NomenNzisColl.items[data.index].getAnsiStringMap(NomenNzisColl.Buf, NomenNzisColl.posData, word(NomenNzis_NomenID));
  end
  else
  begin
    nzisThr.NomenID := NomenNzisColl.items[data.index].PRecord.NomenID;
  end;
  nzisThr.OnSended := NzisOnSended;
  nzisThr.HndSuperHip := Self.Handle;
  nzisThr.Node := vUpdateNom;
  nzisThr.MsgType := TNzisMsgType.C001;
  nzisThr.StreamData := ListNomenNzisNames[data.index].xmlStream;
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
  CollUnfav.CurrentYear := CurrentYear;
  //Exit;
  //initDB;

  //AddDoctor;

  //AddUnfav;
  CollDoctor.ClearUnfav;
  CollUnfav.ClearReal;
  FillUnfavInDoctor;
  //CollDoctor.ClearUnfav;
  for i := 0 to 13 do
  begin
    ACol := vtrSpisyci.Header.Columns.Add;
    ACol.Text := format('%2.2d', [i - 1]);
    case  i  of
      0:
      begin
        ACol.Text := format('Лекари' + #13#10 + 'За %d г. по месеци', [collunfav.CurrentYear]);

        //ACol.Width := CollDoctor.MaxWidth(vtrSpisyci.Canvas) + vtrSpisyci.Indent + 10;
        ACol.Options := [coAllowClick,coEnabled,coParentBidiMode,coParentColor, coFixed,
                         coResizable,coShowDropMark,coVisible,coAllowFocus,coUseCaptionAlignment, coWrapCaption];
      end;
      1:
      begin
        ACol.Text := format('Специалност', [collunfav.CurrentYear]);

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
  vtrSpisyci.Header.Columns[0].Width := CollDoctor.MaxWidth(vtrSpisyci.Canvas) + r.Left + 20; //vtrSpisyci.GetMaxColumnWidth(0, true);
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
  LoadFromNzisNewNomen(22);
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
  PatientTemp.DataPos := dataPat.DataPos;
  patEgn := PatientTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_EGN));
  fileName := Format('%s\X006\%s.xml', [GetCurrentDir, patEgn]);
  if not FileExists(fileName) then Exit;

  AX006 := X006.Loadmessage(filename);

  for i := 0 to AX006.Contents.Results.Count - 1 do
  begin
    resExam := AX006.Contents.Results[i];
    if resExam.Performer.Pmi.Value <> AX006.Header.RecipientId.Value then
      Continue;
    exam := resExam.Examination;

    preg := TRealPregledNewItem(CollPregled.Add);
    New(preg.PRecord);
    preg.PRecord.setProp := [PregledNew_NRN];
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

    diag := TRealDiagnosisItem(CollDiag.Add);
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
      diag := TRealDiagnosisItem(CollDiag.Add);
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
    Include(preg.PRecord.setProp, PregledNew_NRN);

    AddX005Pregled(preg);
    CheckCollForSave;
  end;
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

      FRoot := XMLParseStream(ListNomenNzisNames[data.index].xmlStream, true, nil, OnProcess);
      UpdateRoot(FRoot, ListNomenNzisNames[data.index].Cl000Coll);

      FRoot._Release;

      ListNomenNzisNames[data.index].Cl000Coll.GetColNames;
      mmoTest.Lines.Assign( ListNomenNzisNames[data.index].Cl000Coll.FieldsNames);
      ListNomenNzisNames[data.index].Cl000Coll.ShowGrid(grdNom);
      node.Dummy := 78;
      vtrNomenNzis.RepaintNode(node);
    end;
    78:
    begin
      idnom := data.index;
      case idNom of
        6:  ListNomenNzisNames[data.index].Cl000Coll.ImportCl006(CL006Coll);
        22: ListNomenNzisNames[data.index].Cl000Coll.ImportCl022(CL022Coll);
        24: ListNomenNzisNames[data.index].Cl000Coll.ImportCl024(CL024Coll);
        37: ListNomenNzisNames[data.index].Cl000Coll.ImportCl037(CL037Coll);
        38: ListNomenNzisNames[data.index].Cl000Coll.ImportCl038(CL038Coll);
        88: ListNomenNzisNames[data.index].Cl000Coll.ImportCl088(CL088Coll);
        132: ListNomenNzisNames[data.index].Cl000Coll.ImportCl132(CL132Coll);
        134: ListNomenNzisNames[data.index].Cl000Coll.ImportCl134(CL134Coll);
        139:ListNomenNzisNames[data.index].Cl000Coll.ImportCl139(CL139Coll);
        142:ListNomenNzisNames[data.index].Cl000Coll.ImportCl142(CL142Coll);
        144:ListNomenNzisNames[data.index].Cl000Coll.ImportCl144(CL144Coll);

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

      FRoot := XMLParseStream(ListNomenNzisNames[data.index].xmlStream, true, nil, OnProcess);
      UpdateRoot(FRoot, ListNomenNzisNames[data.index].Cl000Coll);

      FRoot._Release;

      ListNomenNzisNames[data.index].Cl000Coll.GetColNames;
      mmoTest.Lines.Assign( ListNomenNzisNames[data.index].Cl000Coll.FieldsNames);
      ListNomenNzisNames[data.index].Cl000Coll.ShowGrid(grdNom);
      node.Dummy := 78;
      vtrNomenNzis.RepaintNode(node);
    end;
    80:
    begin
      data := vtrNomenNzis.GetNodeData(node);
      FRoot := XMLParseStream(ListNomenNzisNames[data.index].xmlStream, true, nil, OnProcess);
      UpdateRoot(FRoot, ListNomenNzisNames[data.index].Cl000Coll);

      FRoot._Release;

      ListNomenNzisNames[data.index].Cl000Coll.GetColNames;
      mmoTest.Lines.Assign( ListNomenNzisNames[data.index].Cl000Coll.FieldsNames);
      idnom := data.index;
      case idNom of
        24: ListNomenNzisNames[data.index].Cl000Coll.ImportCl024(CL024Coll);
        38: ListNomenNzisNames[data.index].Cl000Coll.ImportCl038(CL038Coll);
        88: ListNomenNzisNames[data.index].Cl000Coll.ImportCl088Local(CL088Coll);
        132: ListNomenNzisNames[data.index].Cl000Coll.ImportCl132(CL132Coll);
        134: ListNomenNzisNames[data.index].Cl000Coll.ImportCl134(CL134Coll);
        139:ListNomenNzisNames[data.index].Cl000Coll.ImportCl139(CL139Coll);
        142:ListNomenNzisNames[data.index].Cl000Coll.ImportCl142(CL142Coll);
        144:ListNomenNzisNames[data.index].Cl000Coll.ImportCl144(CL144Coll);

      end;
      caption := '';
      //ListNomenNzisNames[data.index].ArrStr[1];
//      ListNomenNzisNames[data.index].Cl000Coll;
    end;

    77:
    begin
      data := vtrNomenNzis.GetNodeData(node);
      FRoot := XMLParseStream(ListNomenNzisNames[data.index].xmlStream, true, nil, OnProcess);
      UpdateRoot(FRoot, ListNomenNzisNames[data.index].Cl000Coll);

      FRoot._Release;

      ListNomenNzisNames[data.index].Cl000Coll.GetColNames;
      mmoTest.Lines.Assign( ListNomenNzisNames[data.index].Cl000Coll.FieldsNames);
      idnom := data.index;
      case idNom of
        24: ListNomenNzisNames[data.index].Cl000Coll.ImportCl024(CL024Coll);
        38: ListNomenNzisNames[data.index].Cl000Coll.ImportCl038(CL038Coll);
        88: ListNomenNzisNames[data.index].Cl000Coll.ImportCl088Local(CL088Coll);
        132: ListNomenNzisNames[data.index].Cl000Coll.ImportCl132(CL132Coll);
        134: ListNomenNzisNames[data.index].Cl000Coll.ImportCl134(CL134Coll);
        139:ListNomenNzisNames[data.index].Cl000Coll.ImportCl139(CL139Coll);
        142:ListNomenNzisNames[data.index].Cl000Coll.ImportCl142(CL142Coll);
        144:ListNomenNzisNames[data.index].Cl000Coll.ImportCl144(CL144Coll);

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
begin
  if profGR = nil then
  begin
    LoadVtrNomenNzis1;
    OpenBufNomenNzis('c:\temp\NzisNomen.adb');
    profGR := TProfGraph.create;

    profGR.CL006Coll := CL006Coll;
    profGR.CL022Coll := CL022Coll;
    profGR.CL037Coll := CL037Coll;
    profGR.CL038Coll := CL038Coll;
    profGR.CL050Coll := CL050Coll;
    profGR.CL132Coll := CL132Coll;
    profGR.CL134Coll := CL134Coll;
    profGR.PR001Coll := PR001Coll;
    profGR.BufNomen := AspectsNomFile.Buf;
    profGR.collPat := CollPatient;
    profGR.vtrGraph := vtrGraph;
  end;
  Stopwatch := TStopwatch.StartNew;
  for i := 0 to CollPatient.Count - 1 do
  begin
    pat := CollPatient.Items[i];
    dat := pat.getDateMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_BIRTH_DATE));
    log := TlogicalPatientNewSet(pat.getLogical32Map(CollPatient.Buf, CollPatient.posData, word(PatientNew_Logical)));
    profGR.SexMale := (TLogicalPatientNew.SEX_TYPE_M in log) ;
    profGR.CurrDate := dat;
    //profGR.GeneratePeriod(i);

    //profGR.LoadVtrGraph(i);

  end;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.lines.add(Format('проф: %f', [Elapsed.TotalMilliseconds]));
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
      Fdm.InsertDiag(Data.DataPos, dataPreg.DataPos, CollDiag, CollPregled);
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
    doc := CollDoctor.Items[data.index];
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
  if AspectsHipFile = nil then exit;

  lblGuidDb.caption := 'GUID: ' + AspectsHipFile.GUID.ToString;
  lblSizeCMD.Caption := 'Размер на файла: ' + inttostr(AspectsHipFile.Size);
  k := pnlStatusDB.Width / AspectsHipFile.Size;
  pnlMetaDataDB.Left := Round(AspectsHipFile.FposMetaData * k);
  pnlMetaDataDB.Width := Round(AspectsHipFile.GetLenMetaData * k);
  pnlMetaDataDB.Caption := IntToStr(Round(AspectsHipFile.GetLenMetaData/1024/1024));
  pnlDataDB.Left := Round(AspectsHipFile.FPosData * k);
  pnlDataDB.Width := Round(AspectsHipFile.GetLenData * k);
  pnlDataDB.Caption := IntToStr(Round(AspectsHipFile.GetLenData/1024/1024));

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
  for i := 0 to CollDoctor.Count - 1 do
  begin
    doc := CollDoctor.Items[i];
    if doc.PRecord <> nil then
    begin
      inc(cnt);
    end;
  end;

  for i := 0 to CL132Coll.Count - 1 do
  begin
    cl132 := CL132Coll.Items[i];
    if cl132.PRecord <> nil then
    begin
      inc(cnt);
    end;
  end;

  for i := 0 to CollMDN.Count - 1 do
  begin
    mdn := CollMDN.Items[i];
    if mdn.PRecord <> nil then
    begin
      inc(cnt);
    end;
  end;

  for i := 0 to CollExamAnal.Count - 1 do
  begin
    anal := CollExamAnal.Items[i];
    if anal.PRecord <> nil then
    begin
      inc(cnt);
    end;
  end;

  btnSaveAll.Enabled := (cnt > 0) or (ListPregledLinkForInsert.Count > 0);
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add('CheckCollForSave  ' + FloatToStr(Elapsed.TotalMilliseconds));
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
  for i := 0 to CollDoctor.Count - 1 do
  begin
    doc := CollDoctor.Items[i];
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

function TfrmSuperHip.CheckTokenFromCert: Boolean;
var
  idCert: string;
  i: Integer;
  NzisToken: TNzisTokenItem;
begin
  Result := False;
  idCert := BuildHexString(CertForThread.SerialNumber);
  for i := 0 to CollNzisToken.Count - 1 do
  begin
    NzisToken := CollNzisToken.Items[i];
    if Now > NzisToken.getDateMap(CollNzisToken.Buf, CollNzisToken.posData, word(NzisToken_ToDatTime)) then
      Continue;
    Result := True;
    edtToken.Text := NzisToken.getAnsiStringMap(CollNzisToken.Buf, CollNzisToken.posData, word(NzisToken_Bearer));
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

procedure TfrmSuperHip.ChoiceMKB(sender: TObject);
var
  LStream : TResourceStream;
  i, j, k, m: integer;
  startMkbGroup, endMkbGroup, startMkbSubGroup, endMkbSubGroup: string;
  vGroup, vSubGroup, vMkb, vDiagPat, vDiagPreg: PVirtualNode;
  data, dataMkb: PAspRec;
  preg: TRealPregledNewItem;
  patNode: PVirtualNode;
  PatNodes: TPatNodes;
  mkbCode: string;
  diag: TRealDiagnosisItem;
begin
  Stopwatch := TStopwatch.StartNew;
  if sender is TRealDiagnosisItem then // има избрано мкб
  begin

  end;
  if sender is TList<TMnDiag> then  // няма избрано мкб
  begin
    //Stopwatch := TStopwatch.StartNew;
//    //vtrTemp.BeginUpdate;
//    vtrTemp.Clear;
//    //vtrTemp.NodeDataSize := sizeof(TAspRec);
//    vtrTemp.RootNodeCount := 4;
//    //vtrTemp.EndUpdate;
//    Elapsed := Stopwatch.Elapsed;
//    pgcTree.ActivePage := tsTempVTR;
//    mmotest.Lines.Add( 'ChoiceMKBAAAA ' + FloatToStr(Elapsed.TotalMilliseconds));
//    Exit;
  end;

  if sender is TRealPregledNewItem then //  натиснато е от прегледа. трябва да се покажат всички диагнози на пациента
  begin
    Stopwatch := TStopwatch.StartNew;
    preg := TRealPregledNewItem(sender);
    patNode := preg.FNode.Parent;
    PatNodes := Adb_DM.GetPatNodes(patNode);
    patNodes.CollDiag := CollDiag;
    patNodes.SortDiag(true);

    Elapsed := Stopwatch.Elapsed;
    mkbCode := '';
    for i := 0 to PatNodes.diags.Count - 1 do
    begin
      data := Pointer(PByte(PatNodes.diags[i]) + lenNode);
      if CollDiag.getAnsiStringMap(data.DataPos, word(Diagnosis_code_CL011)) <> mkbCode then
      begin
        mkbCode := CollDiag.getAnsiStringMap(data.DataPos, word(Diagnosis_code_CL011));
        mmotest.Lines.Add(mkbCode);
      end;
    end;
    mmotest.Lines.Add( 'PatNodes.diags.Count ' + inttostr(PatNodes.diags.Count));
    mmotest.Lines.Add( 'GetPatNodes ' + FloatToStr(Elapsed.TotalMilliseconds));
    //Exit;
  end;

  vtrTemp.BeginUpdate;
  vtrTemp.Clear;
  vtrTemp.OnChange := vtrTempChangeSelectMKB;
  vtrTemp.NodeDataSize := sizeof(TAspRec);
  if not CollMkb.IsSortedMKB then
  begin
    CollMkb.IndexValue(Mkb_CODE);
    CollMkb.SortByIndexValue(Mkb_CODE);
    CollMkb.IsSortedMKB := True;
  end;
  if CollMkb.MkbGroups.Count = 0 then
  begin
    LStream := TResourceStream.Create(HInstance, 'Resource_GroupMkb', RT_RCDATA);
    try
      CollMkb.MkbGroups.LoadFromStream(LStream, TEncoding.UTF8);
      //mmoTest.Lines.Add(CollMkb.MkbGroups[17].Split([#9])[2]);
    finally
      LStream.free;
    end;
  end;
  if CollMkb.MkbSubGroups.Count = 0 then
  begin
    LStream := TResourceStream.Create(HInstance, 'Resource_SubGroupMkb', RT_RCDATA);
    try
      CollMkb.MkbSubGroups.LoadFromStream(LStream, TEncoding.UTF8);
      //mmoTest.Lines.Add(CollMkb.MkbSubGroups[3].Split([#9])[2]);
    finally
      LStream.free;
    end;
  end;
  j := 0;
  endMkbSubGroup := '';
  k := 0;
  vDiagPat := vtrTemp.AddChild(nil, nil);
  data := vtrTemp.GetNodeData(vDiagPat);
  data.vid := vvPatient;
  data.index := -1;

  vDiagPreg := vtrTemp.AddChild(nil, nil);
  data := vtrTemp.GetNodeData(vDiagPreg);
  data.vid := vvPregled;
  data.index := -1;


  vNomenMKB := vtrTemp.AddChild(nil, nil);
  data := vtrTemp.GetNodeData(vNomenMKB);
  data.vid := vvNomenMkb;
  data.index := -1;
  for i := 0 to CollMkb.MkbGroups.Count - 1 do
  begin
    startMkbGroup := CollMkb.MkbGroups[i].Split([#9])[1];
    endMkbGroup := Copy(startMkbGroup, 6, 3) + '.99';
    startMkbGroup := Copy(startMkbGroup, 2, 3);
    vGroup := vtrTemp.AddChild(vNomenMKB, nil);
    data := vtrTemp.GetNodeData(vGroup);
    data.vid := vvMKBGroup;
    data.index := i;

    while (j < CollMkb.MkbSubGroups.Count) and
          (endMkbSubGroup <= endMkbGroup) do
    begin
      startMkbSubGroup := CollMkb.MkbSubGroups[j].Split([#9])[2];
      endMkbSubGroup := Copy(startMkbSubGroup, 5, 3) + '.99';
      startMkbSubGroup := Copy(startMkbSubGroup, 1, 3);
      if (endMkbSubGroup > endMkbGroup) then
        Break;
      vSubGroup := vtrTemp.AddChild(vGroup, nil);
      data := vtrTemp.GetNodeData(vSubGroup);
      data.vid := vvMKBSubGroup;
      data.index := j;
      Inc(j);

      while (k < CollMkb.Count) and (CollMkb.getAnsiStringMap(CollMkb.Items[k].DataPos, Word(Mkb_CODE)) <= endMkbSubGroup) do
      begin
        vMkb := vtrTemp.AddChild(vSubGroup, nil);
        vMkb.CheckType := ctCheckBox;
        vMkb.CheckState := csUncheckedNormal;
        data := vtrTemp.GetNodeData(vMkb);
        data.vid := vvMKB;
        data.DataPos := CollMkb.Items[k].DataPos;
        for m := 0 to preg.FDiagnosis.Count - 1 do
        begin
          diag := preg.FDiagnosis[m];
          if CollDiag.getCardMap(diag.DataPos, word(Diagnosis_MkbPos)) = data.DataPos then
          begin
            vMkb.CheckState := csCheckedNormal;
            diag.MkbNode := vMkb;
            dataMkb := vtrTemp.GetNodeData(vMkb);
            data.index := diag.DataPos;

            vMkb := vtrTemp.AddChild(vDiagPreg, nil);
            vMkb.CheckType := ctCheckBox;
            vMkb.CheckState := csUncheckedNormal;
            data := vtrTemp.GetNodeData(vMkb);
            data.vid := vvMKB;
            data.DataPos := CollMkb.Items[k].DataPos;
          end;
        end;
        inc(k);
      end;
    end;
  end;


  //CopyNodesFromAspectToTempVtr(vtrNewAnal, vtrNewAnal.RootNode.FirstChild);
  vtrTemp.OnGetText := vtrMkbGetText;
  vtrTemp.Expanded[vNomenMKB] := True;
  vtrTemp.EndUpdate;
  Elapsed := Stopwatch.Elapsed;
  pgcTree.ActivePage := tsTempVTR;
  //pnlGraph.Parent := nil;

  mmotest.Lines.Add( 'ChoiceMKB ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.ckb1Enter(Sender: TObject);
begin
  //
end;

procedure TfrmSuperHip.ClearColl;
begin
  CollDoctor.clear;
  ListDoctorForFDB.Clear;
  CollUnfav.clear;
  CollUnfav.clear;
  CollMkb.clear;
  CollPregled.clear;
  ListPregledForFDB.Clear;
  CollPatient.clear;
  ListPatientForFDB.Clear;
  CollPatPis.clear;
  CollDiag.clear;
  CollMDN.clear;
  CollEventsManyTimes.clear;

  CollDoctor.CntInADB := 0;
  CollUnfav.CntInADB := 0;
  CollUnfav.CntInADB := 0;
  CollMkb.CntInADB := 0;
  CollPregled.CntInADB := 0;
  CollPatient.CntInADB := 0;
  CollPatPis.CntInADB := 0;
  CollDiag.CntInADB := 0;
  CollMDN.CntInADB := 0;
  CollEventsManyTimes.CntInADB := 0;


  //CollPregledVtor := Tlist<TRealPregledNewItem>.Create;
//  CollPregledPrim := Tlist<TRealPregledNewItem>.Create;
//  AnalsNewColl := TAnalsNewColl.Create(TAnalsNewItem);
end;

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
  nzisThr.PregColl := CollPregled;
  nzisThr.CollNzisToken := CollNzisToken;
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

procedure TfrmSuperHip.CopyNodesFromAspectToTempVtr(
  vtrAspect: TVirtualStringTreeAspect; nodeAspect: PVirtualNode);
begin
  vtrAspect.CopyTo(nodeAspect, vtrTemp, amInsertAfter, False);
end;

procedure TfrmSuperHip.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style  or WS_THICKFRAME;
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
  RemoveDiag(PregledLink, TempItem);
end;

procedure TfrmSuperHip.DeleteEvent(sender: TObject);
var
  pregLink: PVirtualNode;
  PWordData: PWord;
  data: PAspRec;

begin
  pregLink := CollPregled.GetNodeFromID(AspectsLinkPatPregFile.Buf, vvPregled, Word(PregledNew_ID), TRealPregledNewItem(sender).PregledID);
  if pregLink = nil then Exit;

  vtrPregledPat.InternalDisconnectNode(pregLink, false);
  vtrPregledPat.Repaint;
  Include(pregLink.States, vsDeleting);

  CollPregled.streamComm.Size := 0;
  CollPregled.streamComm.OpType := toDeleteNode;
  CollPregled.streamComm.Size := 10 + 4;
  CollPregled.streamComm.Ver := 0;
  CollPregled.streamComm.Vid := ctLink;
  CollPregled.streamComm.DataPos := Cardinal(pregLink);
  CollPregled.streamComm.Propertys := [];
  CollPregled.streamComm.Len := CollPregled.streamComm.Size;
  streamCmdFile.CopyFrom(CollPregled.streamComm, 0);
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
  nzisThr.PregColl := CollPregled;
  nzisThr.CollNzisToken := CollNzisToken;
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
  thrSearch.RunItem.ClassForFind := TPregledNewItem;
  thrSearch.RunItem.RuningType := vvPregled;
  thrSearch.RunItem.CollForRuning := CollPregled;
  thrSearch.CollForFind := CollPregled;
  thrSearch.RunItem.childVid := vvNone;
  thrSearch.RunItem.parentVid := vvNone;

  CollPregled.PRecordSearch.setProp := [PregledNew_ANAMN];//, PregledNew_ANAMN];//, PregledNew_AMB_LISTN];
  CollPregled.PRecordSearch.ANAMN := edtFilter.Text;
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
  CollPregled.FindedRes.DataPos := 0;
  CollPregled.FindedRes.PropIndex := word(PregledNew_ANAMN);
  CollPregled.IndexValue(TPregledNewItem.TPropertyIndex(CollPregled.FindedRes.PropIndex));
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'enterFind ' + FloatToStr(Elapsed.TotalMilliseconds));
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
end;

procedure TfrmSuperHip.FillAnalInExamAnal;
var
  iCl022, iExamAnal, nextCl022: integer;
  examAnal: TRealExamAnalysisItem;
  datPos: Cardinal;
  pCardinalData: PCardinal;
begin
  CollExamAnal.SortByCl022;
  CL022Coll.IndexValue(CL022_Key);
  CL022Coll.SortByIndexAnsiString;
  Stopwatch := TStopwatch.StartNew;
  iCl022 := 0;
  iExamAnal := 0;
  while (iCl022 < CL022Coll.Count) and (iExamAnal < CollExamAnal.Count) do
  begin
    if CollExamAnal.Items[iExamAnal].Cl022 = '08-001' then
    begin
      CollExamAnal.Items[iExamAnal].Cl022 := '08-001'
    end;
    if CL022Coll.Items[iCl022].IndexAnsiStr1 = '08-001' then
    begin
      CL022Coll.Items[iCl022].IndexAnsiStr1 := '08-001'
    end;

    if CL022Coll.Items[iCl022].IndexAnsiStr1 = CollExamAnal.Items[iExamAnal].Cl022 then
    begin
      examAnal := CollExamAnal.Items[iExamAnal];
      New(examAnal.PRecord);
      examAnal.PRecord.setProp := [ExamAnalysis_PosDataNomen];
      examAnal.PRecord.PosDataNomen := CL022Coll.Items[iCl022].FDataPos;

      datPos := AspectsHipFile.FPosData + AspectsHipFile.GetLenData;
      examAnal.SaveExamAnalysis(datPos);
      pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
      pCardinalData^  := datPos - self.AspectsHipFile.FPosData;

      inc(iExamAnal);
      nextCl022 := iCl022 + 1;
      while (nextCl022 < CL022Coll.Count) and (CL022Coll.Items[iCl022].IndexAnsiStr1 = CL022Coll.Items[nextCl022].IndexAnsiStr1) do
      begin
        inc(iCl022);
        nextCl022 := iCl022 + 1;
      end;
    end
    else if CL022Coll.Items[iCl022].IndexAnsiStr1 > CollExamAnal.Items[iExamAnal].Cl022 then
    begin
      inc(iExamAnal);
    end
    else if CL022Coll.Items[iCl022].IndexAnsiStr1 < CollExamAnal.Items[iExamAnal].Cl022 then
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
  buf := AspectsHipFile.Buf;
  posdata := AspectsHipFile.FPosData;

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
                for j := 0 to CollDoctor.Count - 1 do
                begin
                  doc := CollDoctor.Items[j];
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

  CL088Coll.IndexValue(CL088_Key);
  CL088Coll.SortByIndexAnsiString;
  CL088Coll.FCL088New.SortByKeyRec;

  while (iCl0088 < CL088Coll.Count) and (iCl088UP < CL088Coll.FCL088New.Count) do
  begin
    if CL088Coll.Items[iCl0088].IndexAnsiStr1 = CL088Coll.FCL088New.Items[iCl088UP].PRecord.Key then
    begin
      CL088Coll.Items[iCl0088].FItemUp := CL088Coll.FCL088New.Items[iCl088UP];
      CL088Coll.FCL088New.Items[iCl088UP].FItemUp := CL088Coll.Items[iCl0088];
      inc(iCl088UP);
      inc(iCl0088);
    end
    else if CL022Coll.Items[iCl0088].IndexAnsiStr1 > CL088Coll.FCL088New.Items[iCl088UP].PRecord.Key then
    begin
      inc(iCl088UP);
    end
    else if CL022Coll.Items[iCl0088].IndexAnsiStr1 < CL088Coll.FCL088New.Items[iCl088UP].PRecord.Key then
    begin
      inc(iCl0088);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillCL088Coll.FCL088New ' + FloatToStr(Elapsed.TotalMilliseconds));
end;


procedure TfrmSuperHip.FillDoctorInPregled;
var
  iDoc, iPreg: integer;
  preg: TRealPregledNewItem;
begin
  CollPregled.SortByDoctorID;
  CollDoctor.SortByDoctorID;

  Stopwatch := TStopwatch.StartNew;
  iDoc := 0;
  iPreg := 0;
  while (iDoc < CollDoctor.Count) and (iPreg < CollPregled.Count) do
  begin
    if CollDoctor.Items[iDoc].DoctorId = CollPregled.Items[iPreg].DoctorId then
    begin
      preg := CollPregled.Items[iPreg];
      if Fdm.IsGP then
      begin
        if (preg.IS_ZAMESTVASHT) or (preg.IS_NAET) then
        begin
          CollPregled.Items[ipreg].FDoctor := preg.Fpatient.FDoctor;
          CollPregled.Items[ipreg].FDeput := CollDoctor.Items[iDoc];
        end
        else
        begin
          CollPregled.Items[ipreg].FDoctor := CollDoctor.Items[iDoc];
        end;
      end
      else
      begin
        if (preg.IS_ZAMESTVASHT) or (preg.IS_NAET) then
        begin
          CollPregled.Items[ipreg].FDoctor := preg.FOwnerDoctor;
          CollPregled.Items[ipreg].FDeput := CollDoctor.Items[iDoc];
        end
        else
        begin
          CollPregled.Items[ipreg].FDoctor := CollDoctor.Items[iDoc];
        end;
      end;

      inc(iPreg);
    end
    else if CollDoctor.Items[iDoc].DoctorId > CollPregled.Items[iPreg].DoctorId then
    begin
      begin
        inc(iPreg);

      end;
    end
    else if CollDoctor.Items[iDoc].DoctorId < CollPregled.Items[iPreg].DoctorId then
    begin
      inc(iDoc);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillPat ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillEventsInPat;
var
  ievn, iPac: integer;
begin
  CollEventsManyTimes.SortByPatID;
  CollPatient.SortByPatId;
  Stopwatch := TStopwatch.StartNew;
  ievn := 0;
  iPac := 0;
  while ievn < CollEventsManyTimes.Count do
  begin
    if CollEventsManyTimes.Items[ievn].PatID = CollPatient.Items[iPac].PatID then
    begin
      CollPatient.Items[iPac].FEventsPat.Add(CollEventsManyTimes.Items[ievn]);
      inc(ievn);
    end
    else if CollEventsManyTimes.Items[ievn].PatID > CollPatient.Items[iPac].PatID then
    begin
      begin
        inc(iPac);

      end;
    end
    else if CollEventsManyTimes.Items[ievn].PatID < CollPatient.Items[iPac].PatID then
    begin
      inc(ievn);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmotest.Lines.Add( 'fillEVN ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TfrmSuperHip.FillExamAnalInMDN;
var
  iExamAnal, iMdn: integer;
begin
  CollExamAnal.SortByMdnID;
  CollMDN.SortById;
  Stopwatch := TStopwatch.StartNew;
  iExamAnal := 0;
  iMdn := 0;
  while (iExamAnal < CollExamAnal.Count) and (iMdn < CollMDN.Count) do
  begin
    if CollExamAnal.Items[iExamAnal].MdnId = CollMDN.Items[iMdn].MdnId then
    begin
      CollMDN.Items[iMdn].FExamAnals.Add(CollExamAnal.Items[iExamAnal]);
      inc(iExamAnal);
    end
    else if CollExamAnal.Items[iExamAnal].MdnId > CollMDN.Items[iMdn].MdnId then
    begin
      inc(iMdn);
    end
    else if CollExamAnal.Items[iExamAnal].MdnId < CollMDN.Items[iMdn].MdnId then
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
  CollPregled.SortByPregledID;
  CollExamImun.SortByPregID;
  iImn := 0;
  iPr := 0;
  while iImn < CollExamImun.Count do
  begin
    if CollExamImun.Items[iImn].PregledID = collPregled.Items[iPr].PregledID then
    begin
      collPregled.Items[iPr].FImmuns.Add(CollExamImun.Items[iImn]);
      //CollMedNapr.Items[imn].FPregled := collPregled.Items[iPr];
      inc(iImn);
    end
    else if CollExamImun.Items[iImn].PregledID > collPregled.Items[iPr].PregledID then
    begin
      begin
        inc(iPr);

      end;
    end
    else if CollExamImun.Items[iImn].PregledID < collPregled.Items[iPr].PregledID then
    begin
      inc(iImn);
    end;
  end;
  //Elapsed := Stopwatch.Elapsed;
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
  evn: TRealEventsManyTimesItem;
  AUin: string;
  log32: TlogicalEventsManyTimesSet;
  ADateOtp, ADateZap, lastDatePreg, tempdate: TDate;
  isBreak: Boolean;
  Pregledi: TList<TrealPregledNewItem>;
  preg, lastPreg: TRealPregledNewItem;
begin
  linkpos := 100;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  FPosLinkData := pCardinalData^;
  pCardinalData := pointer(PByte(AspectsHipFile.buf) + 8);
  FPosDataADB := pCardinalData^;
  node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
  data := pointer(PByte(node) + lenNode);


  evn := TRealEventsManyTimesItem.Create(nil);
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
              Doc := TRealDoctorItem.Create(nil);

              lastDatePreg := 0;
              doc.DataPos := dataChild.DataPos;
              AUin := Doc.getAnsiStringMap(AspectsHipFile.buf, CollDoctor.posData, word(Doctor_UIN));
              if AUin <> '1100000095' then
              begin
                isBreak := True;
                break;
              end;
            end;
            vvPregled:
            begin
              preg := TRealPregledNewItem.Create(nil);
              preg.DataPos := dataChild.DataPos;
              tempdate := preg.getDateMap(AspectsHipFile.buf, CollDoctor.posData, word(PregledNew_START_DATE));
              lastDatePreg := Max(tempdate, lastDatePreg);
              if lastDatePreg = tempdate then
                lastPreg := preg;
              Pregledi.Add(preg);
            end;
            vvEvnt:
            begin
              evn.DataPos := dataChild.DataPos;
              log32 := TlogicalEventsManyTimesSet(evn.getLogical32Map(AspectsHipFile.buf,
                  CollDoctor.posData, word(EventsManyTimes_Logical)));
              if DATE_OTPISVANE in log32 then
              begin
                ADateOtp := evn.getDateMap(AspectsHipFile.buf, CollDoctor.posData, word(EventsManyTimes_valTDate));
                //Break;
              end;
              if DATE_ZAPISVANE in log32 then
              begin
                ADateZap := evn.getDateMap(AspectsHipFile.buf, CollDoctor.posData, word(EventsManyTimes_valTDate));
                //Break;
              end;
            end;
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
  evn: TRealEventsManyTimesItem;
  AUin: string;
  log32: TlogicalEventsManyTimesSet;
  ADateOtp, ADateZap: TDate;
  isBreak: Boolean;
begin
  collPat.FUin := uin;
  linkpos := 100;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  FPosLinkData := pCardinalData^;
  pCardinalData := pointer(PByte(AspectsHipFile.buf) + 8);
  FPosDataADB := pCardinalData^;
  node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
  data := pointer(PByte(node) + lenNode);
  Doc := TDoctorItem.Create(nil);
  evn := TRealEventsManyTimesItem.Create(nil);
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
              doc.DataPos := dataChild.DataPos;
              AUin := Doc.getAnsiStringMap(AspectsHipFile.buf, CollDoctor.posData, word(Doctor_UIN));
              if AUin <> uin then
              begin
                isBreak := True;
                Break;
              end;
            end;
            vvEvnt:
            begin
              evn.DataPos := dataChild.DataPos;
              log32 := TlogicalEventsManyTimesSet(evn.getLogical32Map(AspectsHipFile.buf,
                  CollDoctor.posData, word(EventsManyTimes_Logical)));
              if DATE_OTPISVANE in log32 then
              begin
                ADateOtp := evn.getDateMap(AspectsHipFile.buf, CollDoctor.posData, word(EventsManyTimes_valTDate));
                //Break;
              end;
              if DATE_ZAPISVANE in log32 then
              begin
                ADateZap := evn.getDateMap(AspectsHipFile.buf, CollDoctor.posData, word(EventsManyTimes_valTDate));
                //Break;
              end;
            end;
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
  CollPregled.SortByPregledID;
  CollMDN.SortByPregledId;
  imdn := 0;
  iPreg := 0;
  // понеже няма как да има mdn без preg, очаква се първо да свършат mdn-тата или едновременно
  // затова въртим всичко до изчерпване на mdn-тата
  while imdn < CollMDN.Count do
  begin
    if CollMDN.Items[imdn].PregledID = CollPregled.Items[iPreg].PregledID then
    begin
      CollPregled.Items[iPreg].FMdns.Add(CollMDN.Items[imdn]);
      preg := CollPregled.Items[iPreg];
      mdn := CollMDN.Items[imdn];
      diagMdn := mdn.FDiagnosis[0];
      for i := 0 to preg.FDiagnosis.Count - 1 do
      begin
        diagPreg := preg.FDiagnosis[i];
        if (diagMdn.MainMkb = diagPreg.MainMkb) and (diagMdn.AddMkb = diagPreg.AddMkb) then
        begin
          mdn.FDiagnosis.Clear;
          Break;
        end;
      end;
      inc(imdn);
    end
    else if CollMDN.Items[imdn].PregledID > CollPregled.Items[iPreg].PregledID then
    begin
      begin
        inc(iPreg);

      end;
    end
    else if CollMDN.Items[imdn].PregledID < CollPregled.Items[iPreg].PregledID then
    begin
      inc(imdn);
    end;
  end;
end;

procedure TfrmSuperHip.FillMedNaprInPregled;
var
  imn, iPr: integer;
begin
  CollPregled.SortByPregledID;
  CollMedNapr.SortByPregID;
  imn := 0;
  iPr := 0;
  while imn < CollMedNapr.Count do
  begin
    if CollMedNapr.Items[imn].PregledID = collPregled.Items[iPr].PregledID then
    begin
      collPregled.Items[iPr].FMNs.Add(CollMedNapr.Items[imn]);
      CollMedNapr.Items[imn].FPregled := collPregled.Items[iPr];
      inc(imn);
    end
    else if CollMedNapr.Items[imn].PregledID > collPregled.Items[iPr].PregledID then
    begin
      begin
        inc(iPr);

      end;
    end
    else if CollMedNapr.Items[imn].PregledID < collPregled.Items[iPr].PregledID then
    begin
      inc(imn);
    end;
  end;
  //Elapsed := Stopwatch.Elapsed;
end;

procedure TfrmSuperHip.FillOldPlanesInCurrentPlan;
begin

end;

procedure TfrmSuperHip.FillOwnerDoctorInPrgled;
var
  iDoc, iPreg: integer;
  preg: TRealPregledNewItem;
begin
  CollPregled.SortByOwnerDoctorID;
  CollDoctor.SortByDoctorID;
  Stopwatch := TStopwatch.StartNew;
  iDoc := 0;
  iPreg := 0;
  while (iDoc < CollDoctor.Count) and (iPreg < CollPregled.Count) do
  begin
    if CollDoctor.Items[iDoc].DoctorId = CollPregled.Items[iPreg].OWNER_DOCTOR_ID then
    begin
      preg := CollPregled.Items[iPreg];
      CollPregled.Items[ipreg].FOwnerDoctor := CollDoctor.Items[iDoc];

      inc(iPreg);
    end
    else if CollDoctor.Items[iDoc].DoctorId > CollPregled.Items[iPreg].OWNER_DOCTOR_ID then
    begin
      begin
        inc(iPreg);

      end;
    end
    else if CollDoctor.Items[iDoc].DoctorId < CollPregled.Items[iPreg].OWNER_DOCTOR_ID then
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
  CollPatient.SortByDoctorID;
  CollDoctor.SortByDoctorID;
  Stopwatch := TStopwatch.StartNew;
  iPat := 0;
  iDoc := 0;
  // понеже няма как да има ambs без пациент, очаква се първо да свършат ambs-тата или едновременно
  // затова въртим всичко до изчерпване на ambs-тата
  while iPat < CollPatient.Count do
  begin
    if CollPatient.Items[iPat].DoctorId = CollDoctor.Items[iDoc].DoctorId then
    begin
      CollPatient.Items[iPat].FDoctor := CollDoctor.Items[iDoc];
      //pregledColl.Items[iamb].FPatient := PatientColl.Items[iPac];
      inc(iPat);
    end
    else if CollPatient.Items[iPat].DoctorId > CollDoctor.Items[iDoc].DoctorId then
    begin
      begin
        inc(iDoc);

      end;
    end
    else if CollPatient.Items[iPat].DoctorId < CollDoctor.Items[iDoc].DoctorId then
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
  data.vid := vvPatientRoot;
  data.index := - 1;

  vNZOK := vtrTemp.AddChild(vRemontPL, nil);
  data := vtrTemp.GetNodeData(vNZOK);
  data.vid := vvPatientRoot;
  data.index := - 2;

  vHIP := vtrTemp.AddChild(vRemontPL, nil);
  data := vtrTemp.GetNodeData(vHIP);
  data.vid := vvPatientRoot;
  data.index := - 3;

  vHipNovi := vtrTemp.AddChild(vHIP, nil);
  data := vtrTemp.GetNodeData(vHipNovi);
  data.vid := vvPatientRoot;
  data.index := - 4;

  vHipOtpisani := vtrTemp.AddChild(vHIP, nil);
  data := vtrTemp.GetNodeData(vHipOtpisani);
  data.vid := vvPatientRoot;
  data.index := - 5;

  vHipZapisani := vtrTemp.AddChild(vHIP, nil);
  data := vtrTemp.GetNodeData(vHipZapisani);
  data.vid := vvPatientRoot;
  data.index := - 6;

  //CollPatPis.IndexValue(TPatientNZOKItem.TPropertyIndex.PatientNZOK_EGN);
  //CollPatPis.SortByIndexValue(TPatientNZOKItem.TPropertyIndex.PatientNZOK_EGN);
  //CollPatPis.ShowGrid(grdNom);
  CollPatPis.SortByPatEGN;
  Acolpat.Buf := CollPatient.Buf;
  Acolpat.posData := CollPatient.posData;
  Acolpat.IndexValue(TPatientNewItem.TPropertyIndex.PatientNew_EGN);
  Acolpat.SortByIndexValue(TPatientNewItem.TPropertyIndex.PatientNew_EGN);

  Stopwatch := TStopwatch.StartNew;
  iPacNzok := 0;
  iPacHip := 0;
  pat := nil;
  while (iPacNzok < CollPatPis.Count) and (iPacHip < Acolpat.Count) do
  begin
    if Acolpat.Items[iPacHip].FDoctor.getAnsiStringMap(AspectsHipFile.buf, CollDoctor.posData, word(Doctor_UIN)) <> uin then
    begin
      inc(iPacHip);
      Continue;
    end;

    //btnImpotPL.Position := iPacHip;

    if CollPatPis.Items[iPacNzok].PatEGN = Acolpat.Items[iPacHip].IndexAnsiStr1 then
    begin
      pat := Acolpat.Items[iPacHip];
      pat.FPatNzok := (CollPatPis.Items[iPacNzok]);

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
    else if CollPatPis.Items[iPacNzok].PatEGN > Acolpat.Items[iPacHip].IndexAnsiStr1 then
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
    else if CollPatPis.Items[iPacNzok].PatEGN < Acolpat.Items[iPacHip].IndexAnsiStr1 then
    begin

      if Assigned(pat) and (not pat.IsAdded) then
      begin
        v := vtrTemp.AddChild(vNZOK, nil);
        data := vtrTemp.GetNodeData(v);
        data.vid := vvPatient;
        data.index := iPacNzok;
        data.DataPos := CollPatPis.Items[iPacNzok].DataPos;
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

procedure TfrmSuperHip.FillPregledInPat;
var
  iamb, iPac: integer;
begin
  CollPregled.SortByPatID_StartDate;
  CollPatient.SortByPatId;
  Stopwatch := TStopwatch.StartNew;
  iamb := 0;
  iPac := 0;
  // понеже няма как да има ambs без пациент, очаква се първо да свършат ambs-тата или едновременно
  // затова въртим всичко до изчерпване на ambs-тата
  while iamb < CollPregled.Count do
  begin
    if CollPregled.Items[iamb].PatID = CollPatient.Items[iPac].PatID then
    begin
      CollPatient.Items[iPac].FPregledi.Add(CollPregled.Items[iamb]);
      CollPregled.Items[iamb].FPatient := CollPatient.Items[iPac];
      inc(iamb);
    end
    else if CollPregled.Items[iamb].PatID > CollPatient.Items[iPac].PatID then
    begin
      begin
        inc(iPac);

      end;
    end
    else if CollPregled.Items[iamb].PatID < CollPatient.Items[iPac].PatID then
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
  CollPregled.SortByPregledID;
  CollCardProf.SortByPregID;
  iCard := 0;
  iPreg := 0;
  // понеже няма как да има карта без preg, очаква се първо да свършат картите или едновременно
  // затова въртим всичко до изчерпване на картите
  while iCard < CollCardProf.Count do
  begin
    if CollCardProf.Items[iCard].PregledID = CollPregled.Items[iPreg].PregledID then
    begin
      CollPregled.Items[iPreg].FProfCards.Add(CollCardProf.Items[iCard]);
      inc(iCard);
    end
    else if CollCardProf.Items[iCard].PregledID > CollPregled.Items[iPreg].PregledID then
    begin
      begin
        inc(iPreg);
      end;
    end
    else if CollCardProf.Items[iCard].PregledID < CollPregled.Items[iPreg].PregledID then
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

procedure TfrmSuperHip.FillSecInPrim(pat: TRealPatientNewItem);
var
  i: Integer;
  preg: TRealPregledNewItem;
  log: TlogicalPregledNewSet;
begin
  for i := 0 to pat.FPregledi.Count - 1 do
  begin
    preg  := pat.FPregledi[i];
    log := TlogicalPregledNewSet(preg.getLogical40Map(CollPregled.Buf, CollPregled.posData, word(PregledNew_Logical)));
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
  CL006Coll.IndexValue(CL006_Key);
  CL006Coll.SortByIndexAnsiString;
  CollMedNapr.SortBySpecNzis;
  icl006 := 0;
  imn := 0;
  pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
  dataPosition := pCardinalData^ + self.AspectsHipFile.FPosData;
  while (icl006 < CL006Coll.Count) and (imn < CollMedNapr.Count) do
  begin
    if CL006Coll.Items[icl006].IndexAnsiStr1 = CollMedNapr.Items[imn].SpecNzis then
    begin
      New(CollMedNapr.Items[imn].PRecord);

      CollMedNapr.Items[imn].PRecord.setProp := [BLANKA_MED_NAPR_SpecDataPos];
      CollMedNapr.Items[imn].PRecord.SpecDataPos := CL006Coll.Items[icl006].DataPos;
      CollMedNapr.Items[imn].SaveBLANKA_MED_NAPR(dataPosition);

      inc(imn);
    end
    else if CL006Coll.Items[icl006].IndexAnsiStr1 > CollMedNapr.Items[imn].SpecNzis then
    begin
      begin
        inc(imn);

      end;
    end
    else if CL006Coll.Items[icl006].IndexAnsiStr1 < CollMedNapr.Items[imn].SpecNzis then
    begin
      inc(icl006);
    end;
  end;
  pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
  pCardinalData^  := dataPosition - self.AspectsHipFile.FPosData;
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
  CollDoctor.IndexValue(Doctor_ID);
  CollDoctor.SortByIndexValue(Doctor_ID);
  CollUnfav.IndexValue(Unfav_DOCTOR_ID_PRAC);
  CollUnfav.SortByIndexValue(Unfav_DOCTOR_ID_PRAC);
  iun := 0;
  iDoc := 0;
  while iun < CollUnfav.Count do
  begin
    if CollUnfav.Items[iun].DoctorID = CollDoctor.Items[iDoc].DoctorID then
    begin
      unfav := CollUnfav.Items[iun];
      indexUnfav := (unfav.Year - 2024) * 12 + Unfav.Month;
      CollDoctor.Items[iDoc].FListUnfav[indexUnfav] := unfav;
      CollDoctor.Items[iDoc].FListUnfavDB[indexUnfav] := unfav;
      inc(iun);
    end
    else if CollUnfav.Items[iun].DoctorID > CollDoctor.Items[iDoc].DoctorID then
    begin
      begin
        inc(iDoc);

      end;
    end
    else if CollUnfav.Items[iun].DoctorID < CollDoctor.Items[iDoc].DoctorID then
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
    AspectsHipFile := TMappedFile.Create(S, false, TGUID.Empty);
    if AspectsHipFile.Buf <> nil then
    begin
      pCardinalData := pointer(PByte(AspectsHipFile.Buf));
      FPosMetaData := pCardinalData^;
      pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 4);
      FLenMetaData := pCardinalData^;
      pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 8);
      FPosData := pCardinalData^;
      pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
      FLenData := pCardinalData^;
      Pg := pointer(PByte(AspectsHipFile.Buf) + 16 );
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
      AspectsHipFile.Free;
      AspectsHipFile := nil;
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
  buf: Pointer;
  posdata: Cardinal;
  data: PAspRec;
  isEqu: Boolean;
begin
  Result := nil;
  WinStorage := TElWinCertStorage.Create(nil);
  buf := AspectsHipFile.Buf;

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
    doc := CollDoctor.Items[data.index];
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
        if CollPregled.getIntMap(data.DataPos, word(PregledNew_ID)) = 0 then
        begin
          ListPregledLinkForInsert.Add(RunNode);
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
  BufADB := AspectsHipFile.Buf;
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
    FmxTitleBar.OnSetingsClick := TitleSetingsClick;
    FmxTitleBar.OnHelpClick := HelpClick;
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

procedure TfrmSuperHip.FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  //fmxCntrRoleBar.Top := pnlTree.Top;// + 50;
//  fmxCntrRoleBar.Height := pnlTree.Height-60;
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
  if (Sender <> nil) and (Hint <> '') then
  begin
    hntLek.Title := Hint;
    hntLek.Description := 'Lorem Ipsum is simply dummy text of the' + #13#10 + 'printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled i';
    hntLek.ShowHint(r);
  end
  else
  begin
    hntLek.HideHint;
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
        if CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          edtCertNom.Text := BuildHexString(CollDoctor.Items[0].Cert.SerialNumber);
          CollDoctor.Items[0].Cert.Clone(CertForThread);
          CollDoctor.Items[0].Cert.Clone(CurrentCert);
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
        if CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          if CurrentCert = nil then
            CurrentCert := TelX509Certificate.Create(self);
          CollDoctor.Items[0].Cert.Clone(CertForThread);
          CollDoctor.Items[0].Cert.Clone(CurrentCert);
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
        if CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          edtCertNom.Text := BuildHexString(CollDoctor.Items[0].Cert.SerialNumber);
          CollDoctor.Items[0].Cert.Clone(CertForThread);
          CollDoctor.Items[0].Cert.Clone(CurrentCert);
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
        if CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          if CurrentCert = nil then
            CurrentCert := TelX509Certificate.Create(self);
          CollDoctor.Items[0].Cert.Clone(CertForThread);
          CollDoctor.Items[0].Cert.Clone(CurrentCert);
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
        if CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          edtCertNom.Text := BuildHexString(CollDoctor.Items[0].Cert.SerialNumber);
          CollDoctor.Items[0].Cert.Clone(CertForThread);
          CollDoctor.Items[0].Cert.Clone(CurrentCert);
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
        if CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          if CurrentCert = nil then
            CurrentCert := TelX509Certificate.Create(self);
          CollDoctor.Items[0].Cert.Clone(CertForThread);
          CollDoctor.Items[0].Cert.Clone(CurrentCert);
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
  Stopwatch := TStopwatch.StartNew;
  case Vid of
    vvPatient:
    begin
      CollPatient.OnSetTextSearchEDT(Text, field, Condition);
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
      CollPregForSearch.PRecordSearch.ANAMN  :=  AnsiUpperCase(Text);
      thrSearch.start;
    end;
  end;
end;

procedure TfrmSuperHip.OnShowFindFprm(Sender: TObject);
var
  i: Integer;
  act: TAsectTypeKind;
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
          CollPractica.OpenAdbFull(aspPos);
        end;
        ctPregledNew:
        begin
          Inc(aspPos, (CollPregled.FieldCount) * 4);
          CollPregled.IncCntInADB;
        end;
        ctPatientNew:
        begin
          Inc(aspPos, (CollPatient.FieldCount) * 4);
          CollPatient.IncCntInADB;
        end;
        ctPatientNZOK:
        begin
          Inc(aspPos, (CollPatPis.FieldCount) * 4);
          CollPatPis.IncCntInADB;
        end;
        ctDiagnosis:
        begin
          Inc(aspPos, (CollDiag.FieldCount) * 4);
          CollDiag.IncCntInADB;
        end;
        ctDiagnosisDel:
        begin
          Inc(aspPos, (CollDiag.FieldCount) * 4);
        end;
        ctMDN:
        begin
          Inc(aspPos, (CollMDN.FieldCount) * 4);
          CollMDN.IncCntInADB;
        end;
        ctDoctor:
        begin
          CollDoctor.OpenAdbFull(aspPos);
        end;
        ctUnfav:
        begin
          Inc(aspPos, (CollUnfav.FieldCount) * 4);
          CollUnfav.IncCntInADB;
        end;
        ctUnfavDel:
        begin
          Inc(aspPos, (CollUnfav.FieldCount) * 4);
        end;
        ctMkb:
        begin
          CollMkb.OpenAdbFull(aspPos);
        end;
        ctEventsManyTimes:
        begin
          Inc(aspPos, (CollEventsManyTimes.FieldCount) * 4);
          CollEventsManyTimes.IncCntInADB;
        end;
        ctExam_boln_list:
        begin
          Inc(aspPos, (CollEbl.FieldCount) * 4);
          CollEbl.IncCntInADB;
        end;
        ctExamAnalysis:
        begin
          Inc(aspPos, (CollExamAnal.FieldCount) * 4);
          CollExamAnal.IncCntInADB;
        end;
        ctExamImmunization:
        begin
          Inc(aspPos, (CollExamImun.FieldCount) * 4);
          CollExamImun.IncCntInADB;
        end;
        ctProcedures:
        begin
          Inc(aspPos, (CollProceduresNomen.FieldCount) * 4);
          CollProceduresNomen.IncCntInADB;
        end;
        ctKARTA_PROFILAKTIKA2017:
        begin
          Inc(aspPos, (CollCardProf.FieldCount) * 4);
          CollCardProf.IncCntInADB;
        end;
        ctBLANKA_MED_NAPR:
        begin
          Inc(aspPos, (CollMedNapr.FieldCount) * 4);
          CollMedNapr.IncCntInADB;
        end;
        ctNZIS_PLANNED_TYPE:
        begin
          Inc(aspPos, (CollNZIS_PLANNED_TYPE.FieldCount) * 4);
          CollNZIS_PLANNED_TYPE.IncCntInADB;
        end;
        ctNZIS_QUESTIONNAIRE_RESPONSE:
        begin
          Inc(aspPos, (CollNZIS_QUESTIONNAIRE_RESPONSE.FieldCount) * 4);
          CollNZIS_QUESTIONNAIRE_RESPONSE.IncCntInADB;
        end;
        ctNZIS_QUESTIONNAIRE_ANSWER:
        begin
          Inc(aspPos, (CollNZIS_QUESTIONNAIRE_ANSWER.FieldCount) * 4);
          CollNZIS_QUESTIONNAIRE_ANSWER.IncCntInADB;
        end;
        ctNZIS_DIAGNOSTIC_REPORT:
        begin
          Inc(aspPos, (CollNZIS_DIAGNOSTIC_REPORT.FieldCount) * 4);
          CollNZIS_DIAGNOSTIC_REPORT.IncCntInADB;
        end;
        ctNZIS_RESULT_DIAGNOSTIC_REPORT:
        begin
          Inc(aspPos, (CollNZIS_RESULT_DIAGNOSTIC_REPORT.FieldCount) * 4);
          CollNZIS_RESULT_DIAGNOSTIC_REPORT.IncCntInADB;
        end;
        ctNZIS_ANSWER_VALUE:
        begin
          Inc(aspPos, (CollNZIS_ANSWER_VALUE.FieldCount) * 4);
          CollNZIS_ANSWER_VALUE.IncCntInADB;
        end;
        ctNzisToken:
        begin
          CollNzisToken.OpenAdbFull(aspPos);
        end;
        ctCertificates:
        begin
          CollCertificates.OpenAdbFull(aspPos);
        end;
      end;
    end;
  end;


  Elapsed := Stopwatch.Elapsed;
  CollPatient.Buf :=  ADB.Buf;
  CollPatient.posData := ADB.FPosData;
  CollPatPis.Buf :=  ADB.Buf;
  CollPatPis.posData := ADB.FPosData;
  CollPregled.Buf :=  ADB.Buf;
  CollPregled.posData := ADB.FPosData;
  CollDiag.Buf :=  ADB.Buf;
  CollDiag.posData := ADB.FPosData;
  CollMDN.Buf :=  ADB.Buf;
  CollMDN.posData := ADB.FPosData;
  CollDoctor.Buf :=  ADB.Buf;
  CollDoctor.posData := ADB.FPosData;
  CollUnfav.Buf :=  ADB.Buf;
  CollUnfav.posData := ADB.FPosData;
  CollMkb.Buf :=  ADB.Buf;
  CollMkb.posData := ADB.FPosData;
  CollEventsManyTimes.Buf :=  ADB.Buf;
  CollEventsManyTimes.posData := ADB.FPosData;
  CollPractica.Buf :=  ADB.Buf;
  CollPractica.posData := ADB.FPosData;
  CollEbl.Buf :=  ADB.Buf;
  CollEbl.posData := ADB.FPosData;
  CollExamAnal.Buf :=  ADB.Buf;
  CollExamAnal.posData := ADB.FPosData;
  CollExamImun.Buf :=  ADB.Buf;
  CollExamImun.posData := ADB.FPosData;
  CollProceduresNomen.Buf :=  ADB.Buf;
  CollProceduresNomen.posData := ADB.FPosData;
  CollCardProf.Buf :=  ADB.Buf;
  CollCardProf.posData := ADB.FPosData;
  CollMedNapr.Buf :=  ADB.Buf;
  CollMedNapr.posData := ADB.FPosData;
  CollNZIS_PLANNED_TYPE.Buf :=  ADB.Buf;
  CollNZIS_PLANNED_TYPE.posData := ADB.FPosData;
  CollNZIS_QUESTIONNAIRE_RESPONSE.Buf :=  ADB.Buf;
  CollNZIS_QUESTIONNAIRE_RESPONSE.posData := ADB.FPosData;
  CollNZIS_QUESTIONNAIRE_ANSWER.Buf :=  ADB.Buf;
  CollNZIS_QUESTIONNAIRE_ANSWER.posData := ADB.FPosData;
  CollNZIS_DIAGNOSTIC_REPORT.Buf :=  ADB.Buf;
  CollNZIS_DIAGNOSTIC_REPORT.posData := ADB.FPosData;
  CollNzis_RESULT_DIAGNOSTIC_REPORT.Buf :=  ADB.Buf;
  CollNzis_RESULT_DIAGNOSTIC_REPORT.posData := ADB.FPosData;
  CollNZIS_ANSWER_VALUE.Buf :=  ADB.Buf;
  CollNZIS_ANSWER_VALUE.posData := ADB.FPosData;
  CollNzisToken.Buf := ADB.Buf;
  CollNzisToken.posData := ADB.FPosData;
  CollCertificates.Buf := ADB.Buf;
  CollCertificates.posData := ADB.FPosData;

  


  mmoTest.Lines.Add( Format('Зареждане за %f',[Elapsed.TotalMilliseconds]));
  mmoTest.Lines.endUpdate;

  CalcStatusDB;
  FDbHelper.CollPreg := CollPregled;
  FDbHelper.collCl022 := CL022Coll;
  FDBHelper.CollEbl := CollEbl;
  FDBHelper.CollDiag := CollDiag;
  FDBHelper.AdbHip := ADB;

  FDBHelper.AdbLink := AspectsLinkPatPregFile;
  Adb_DM.AdbHip := ADB;
  Adb_DM.AdbLink := AspectsLinkPatPregFile;
  Adb_DM.CollDoc := CollDoctor;
  Adb_DM.CollPrac := CollPractica;
  Adb_DM.CollCert := CollCertificates;
  Adb_DM.CollPreg := CollPregled;
  Adb_DM.CollDiag := CollDiag;
  Adb_DM.CollNZIS_PLANNED_TYPE := CollNZIS_PLANNED_TYPE;
  Adb_DM.CollNZIS_QUESTIONNAIRE_RESPONSE := CollNZIS_QUESTIONNAIRE_RESPONSE;
  Adb_DM.CollNZIS_QUESTIONNAIRE_ANSWER := CollNZIS_QUESTIONNAIRE_ANSWER;
  Adb_DM.CollNZIS_ANSWER_VALUEColl := CollNZIS_ANSWER_VALUE;

  Adb_DM.collNZIS_DIAGNOSTIC_REPORT := CollNZIS_DIAGNOSTIC_REPORT;
  Adb_DM.collNZIS_RESULT_DIAGNOSTIC_REPORT := CollNzis_RESULT_DIAGNOSTIC_REPORT;

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
    AnalsNewColl.Buf := AspectsNomHipFile.Buf;
    AnalsNewColl.posData := AspectsNomHipFile.FPosData;


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
            anal := TAnalsNewItem(AnalsNewColl.Add);
            anal.DataPos := aspPos;
            Inc(aspPos, (AnalsNewColl.FieldCount) * 4);
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
            Cl132 := TCL132Item(CL132Coll.Add);
            Cl132.DataPos := aspPos;
            Inc(aspPos, (CL132Coll.FieldCount) * 4);
          end;
          ctCL050:
          begin
            Cl050 := TCL050Item(CL050Coll.Add);
            Cl050.DataPos := aspPos;
            Inc(aspPos, (CL050Coll.FieldCount) * 4);
          end;
          ctCL006:
          begin
            Cl006 := TCL006Item(CL006Coll.Add);
            Cl006.DataPos := aspPos;
            Inc(aspPos, (CL006Coll.FieldCount) * 4);
          end;
          ctCL022:
          begin
            Cl022 := TCL022Item(CL022Coll.Add);
            Cl022.DataPos := aspPos;
            Inc(aspPos, (CL022Coll.FieldCount) * 4);
          end;
          ctCL024:
          begin
            Cl024 := TCL024Item(CL024Coll.Add);
            Cl024.DataPos := aspPos;
            Inc(aspPos, (CL024Coll.FieldCount) * 4);
          end;
          ctCL037:
          begin
            Cl037 := TCL037Item(CL037Coll.Add);
            Cl037.DataPos := aspPos;
            Inc(aspPos, (CL037Coll.FieldCount) * 4);
          end;
          ctCL038:
          begin
            Cl038 := TCL038Item(CL038Coll.Add);
            Cl038.DataPos := aspPos;
            Inc(aspPos, (CL038Coll.FieldCount) * 4);
          end;
          ctCL088:
          begin
            Cl088 := TCL088Item(CL088Coll.Add);
            Cl088.DataPos := aspPos;
            Inc(aspPos, (CL088Coll.FieldCount) * 4);
          end;


          ctCL134:
          begin
            Cl134 := TCl134Item(Cl134Coll.Add);
            Cl134.DataPos := aspPos;
            Inc(aspPos, (Cl134Coll.FieldCount) * 4);
          end;
          ctCL139:
          begin
            Cl139 := TCl139Item(Cl139Coll.Add);
            Cl139.DataPos := aspPos;
            Inc(aspPos, (Cl139Coll.FieldCount) * 4);
          end;
          ctCL142:
          begin
            Cl142 := TCl142Item(Cl142Coll.Add);
            Cl142.DataPos := aspPos;
            Inc(aspPos, (Cl142Coll.FieldCount) * 4);
          end;
          ctCL144:
          begin
            Cl144 := TRealCl144Item(Cl144Coll.Add);
            Cl144.DataPos := aspPos;
            Inc(aspPos, (Cl144Coll.FieldCount) * 4);
          end;

          ctPR001:
          begin
            PR001 := TPR001Item(PR001Coll.Add);
            PR001.DataPos := aspPos;
            Inc(aspPos, (PR001Coll.FieldCount) * 4);
          end;

          ctNomenNzis:
          begin
            //NomenNzis := TNomenNzisItem(NomenNzisColl.Add);
            //NomenNzis.DataPos := aspPos;
            Inc(aspPos, (NomenNzisColl.FieldCount) * 4);
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



  CL132Coll.Buf := AspectsNomFile.Buf;
  CL132Coll.posData := AspectsNomFile.FPosData;

  PR001Coll.Buf := AspectsNomFile.Buf;
  PR001Coll.posData := AspectsNomFile.FPosData;

  CL050Coll.Buf := AspectsNomFile.Buf;
  CL050Coll.posData := AspectsNomFile.FPosData;
  Cl134Coll.Buf := AspectsNomFile.Buf;
  Cl134Coll.posData := AspectsNomFile.FPosData;
  Cl139Coll.Buf := AspectsNomFile.Buf;
  Cl139Coll.posData := AspectsNomFile.FPosData;
  Cl139Coll.IndexValue(CL139_cl138);
  Cl139Coll.SortByIndexAnsiString;
  CL006Coll.Buf := AspectsNomFile.Buf;
  CL006Coll.posData := AspectsNomFile.FPosData;
  CL022Coll.Buf := AspectsNomFile.Buf;
  CL022Coll.posData := AspectsNomFile.FPosData;
  CL024Coll.Buf := AspectsNomFile.Buf;
  CL024Coll.posData := AspectsNomFile.FPosData;
  CL037Coll.Buf := AspectsNomFile.Buf;
  CL037Coll.posData := AspectsNomFile.FPosData;
  CL038Coll.Buf := AspectsNomFile.Buf;
  CL038Coll.posData := AspectsNomFile.FPosData;
  CL088Coll.Buf := AspectsNomFile.Buf;
  CL088Coll.posData := AspectsNomFile.FPosData;
  CL142Coll.Buf := AspectsNomFile.Buf;
  CL142Coll.posData := AspectsNomFile.FPosData;
  CL144Coll.Buf := AspectsNomFile.Buf;
  CL144Coll.posData := AspectsNomFile.FPosData;

  NomenNzisColl.Buf := AspectsNomFile.Buf;
  NomenNzisColl.posData := AspectsNomFile.FPosData;
  FDBHelper.AdbNomenNzis := AspectsNomFile;

  Adb_DM.collCl139 := CL139Coll;
  Adb_DM.collCl144 := CL144Coll;
  OpenCmdNomenNzis(AspectsNomFile);

  Elapsed := Stopwatch.Elapsed;
  mmoTest.lines.add(Format('зареждане от Nom: %f', [Elapsed.TotalMilliseconds]));
end;

procedure TfrmSuperHip.OpenCmd(ADB: TMappedFile);
var
  fileName: string;
begin

  fileName := ADB.FileName.Replace('.adb', '.cmd');

  if TFile.Exists (fileName) then
  begin
    streamCmdFile := TFileCMDStream.Create(fileName, fmOpenReadWrite + fmShareDenyNone);
    FDBHelper.cmdFile := streamCmdFile;
    CollNZIS_ANSWER_VALUE.cmdFile := streamCmdFile;
    CollNzis_RESULT_DIAGNOSTIC_REPORT.cmdFile := streamCmdFile;
    CollNZIS_DIAGNOSTIC_REPORT.cmdFile := streamCmdFile;
  end
  else
  begin
    streamCmdFile := TFileCmdStream.Create(fileName, fmCreate);
    streamCmdFile.Size := 100;
  end;
  streamCmdFile.Position := streamCmdFile.Size;
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
  CL006Coll.cmdFile := streamCmdFileNomenNzis;
  CL022Coll.cmdFile := streamCmdFileNomenNzis;
  CL024Coll.cmdFile := streamCmdFileNomenNzis;
  CL037Coll.cmdFile := streamCmdFileNomenNzis;
  CL038Coll.cmdFile := streamCmdFileNomenNzis;
  CL050Coll.cmdFile := streamCmdFileNomenNzis;
  CL088Coll.cmdFile := streamCmdFileNomenNzis;
  CL132Coll.cmdFile := streamCmdFileNomenNzis;
  CL134Coll.cmdFile := streamCmdFileNomenNzis;
  CL139Coll.cmdFile := streamCmdFileNomenNzis;
  CL142Coll.cmdFile := streamCmdFileNomenNzis;
  CL144Coll.cmdFile := streamCmdFileNomenNzis;
  PR001Coll.cmdFile := streamCmdFileNomenNzis;
end;

procedure TfrmSuperHip.OpenDB(index: integer);
var
  nodeLink: PVirtualNode;
begin
  if Assigned(AspectsHipFile) then
    begin
      UnmapViewOfFile(AspectsHipFile.Buf);
      FreeAndNil(AspectsHipFile);

    end;
    if AspectsLinkPatPregFile <> nil then
    begin
      vtrPregledPat.BeginUpdate;
      nodeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);
      vtrPregledPat.InternalDisconnectNode(nodeLink, false);
      UnmapViewOfFile(AspectsLinkPatPregFile.Buf);
      FreeAndNil(AspectsLinkPatPregFile);
      vtrPregledPat.Selected[vtrPregledPat.GetFirstSelected()] := False;
      vtrPregledPat.CanClear := True;
      vtrPregledPat.AddChild(nil, nil);
      //vtrPregledPat.Clear;

      vtrPregledPat.CanClear := false;
      vtrPregledPat.Repaint;
      vtrPregledPat.endUpdate;
    end;
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
    ClearColl;
    if FmxProfForm = nil then
      InitFMXDyn;
    FmxProfForm.PatientColl := CollPatient;
    FmxProfForm.DoctorColl := CollDoctor;
    FmxProfForm.PregledColl := CollPregled;
    FmxProfForm.MKBColl := CollMkb;
    FmxProfForm.MdnColl := CollMdn;
    FmxProfForm.ExamAnalColl := CollExamAnal;
    FmxProfForm.AnswValuesColl := CollNZIS_ANSWER_VALUE;
    FmxProfForm.ResDiagRepColl := CollNzis_RESULT_DIAGNOSTIC_REPORT;
    FmxProfForm.PlanedTypeColl := CollNZIS_PLANNED_TYPE;


    //if Assigned(streamCmdFile) then
//    begin
//      streamCmdFile.Free;
//    end;
    vtrGraph.DeleteChildren(vRootGraph);
    lstPatGraph.Clear;
    if thrHistPerf <> nil then
      thrHistPerf.stop := true;
    //if not nnn then
    begin
      initDB();
      vtrFDB.Repaint;
    end;
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
  nzisThr.PregColl := CollPregled;
  nzisThr.CollNzisToken := CollNzisToken;
  nzisThr.CollDoctor := CollDoctor;
  nzisThr.Resume;
end;

procedure TfrmSuperHip.FormCreate(Sender: TObject);
begin
  //Exit;
  edt1.Parent := grdSearch;
  edt1.SetBounds(0,0,1, 1);

  vtrPregledPat.TakeFocus := False;
  grdSearch.Header.Hover.OnChange := HoverChange;
  grdSearch.Header.Selected.OnChange := HoverChange;
  grdSearch.Header.Columns.OnMoved := ColMoved;

  FinderRec.LastFindedStr := '';
  //mmoTest.Lines.Add(IntToStr(mmMain.Handle));
  pnlTest.Parent := vtrMinaliPregledi;
  pnlTest.Align := alTop;
  pnlTest.Height := vtrMinaliPregledi.DefaultNodeHeight - 2;
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
  InitColl;
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
  //Screen.HintFont.Size := 20;
end;

procedure TfrmSuperHip.FormDestroy(Sender: TObject);
var
  i: Integer;
  nomen: TNomenNzisRec;
begin
  FreeAndNil(ListHistoryNav);
  FreeColl;
  FreeAndNil(listFilterCount);
  //FreeAndNil(LSNomenNzisNames);
  for i := 0 to ListNomenNzisNames.Count - 1 do
  begin
    nomen := ListNomenNzisNames[i];
    FreeAndNil(nomen);
  end;
  FreeAndNil(ListNomenNzisNames);
  FreeAndNil(lstPatGraph);
  //FreeAndNil(FilterList);
  FreeAndNil(FilterStringsHave);
  FreeAndNil(FilterStringsNotHave);
  

  FreeAndNil(AZipHelpFile);
  DownloadedStream.Free;
  if AspectsHipFile <> nil then
    AspectsHipFile.Free;
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
  Self.Menu := nil;
  PostMessage(Self.Handle, WM_AFTER_SHOW, 0, 0);
end;


procedure TfrmSuperHip.FreeColl;
begin
  FreeAndNil(CollDoctor);
  FreeAndNil(CollUnfav);
  FreeAndNil(CollMkb);
  FreeAndNil(CollPregled);
  FreeAndNil(ListPregledForFDB);
  FreeAndNil(ListPregledLinkForInsert);
  FreeAndNil(CollPatient);
  //FreeAndNil(CollPatForSearch);
  FreeAndNil(CollPregForSearch);
  FreeAndNil(AcollpatFromDoctor);
  FreeAndNil(ACollPatFDB);
  FreeAndNil(ACollNovozapisani);
  FreeAndNil(ListPatientForFDB);
  FreeAndNil(CollPatPis);
  FreeAndNil(CollDiag);
  FreeAndNil(CollMDN);
  FreeAndNil(CollEventsManyTimes);
  FreeAndNil(CollPregledVtor);
  FreeAndNil(CollPregledPrim);
  FreeAndNil(AnalsNewColl);
  FreeAndNil(CollPractica);
  FreeAndNil(CollEbl);
  FreeAndNil(CollExamAnal);
  FreeAndNil(CollExamImun);
  FreeAndNil(CollProceduresNomen);
  FreeAndNil(CollProceduresPreg);
  FreeAndNil(CollCardProf);
  FreeAndNil(CollMedNapr);
  FreeAndNil(CollNZIS_PLANNED_TYPE);
  FreeAndNil(CollNZIS_QUESTIONNAIRE_RESPONSE);
  FreeAndNil(CollNZIS_QUESTIONNAIRE_ANSWER);
  FreeAndNil(CollNZIS_ANSWER_VALUE);
  FreeAndNil(CollNZIS_DIAGNOSTIC_REPORT);
  FreeAndNil(CollNzis_RESULT_DIAGNOSTIC_REPORT);
  FreeAndNil(CollNzisToken);
  FreeAndNil(CollCertificates);

  FreeAndNil(CL132Coll);
  FreeAndNil(CL050Coll);
  FreeAndNil(CL006Coll);
  FreeAndNil(CL022Coll);
  FreeAndNil(CL024Coll);
  FreeAndNil(CL037Coll);
  FreeAndNil(CL038Coll);
  FreeAndNil(CL088Coll);
  FreeAndNil(CL134Coll);
  FreeAndNil(CL139Coll);
  FreeAndNil(CL142Coll);
  FreeAndNil(CL144Coll);
  FreeAndNil(PR001Coll);
  FreeAndNil(NomenNzisColl);

  FreeAndNil(FPatientTemp);
  FreeAndNil(PregledTemp);
  FreeAndNil(DiagTemp);
  FreeAndNil(MDNTemp);
  FreeAndNil(ExamAnalTemp);
  FreeAndNil(DoctorTemp);
  FreeAndNil(EvnTemp);
  FreeAndNil(AnalTemp);
  FreeAndNil(Cl022temp);
  FreeAndNil(Cl132temp);
  FreeAndNil(PR001Temp);
  FreeAndNil(CL088Temp);
  FreeAndNil(ProcTemp);
  FreeAndNil(NZIS_PLANNED_TYPETemp);
  FreeAndNil(NZIS_QUESTIONNAIRE_RESPONSETemp);
  FreeAndNil(NZIS_QUESTIONNAIRE_ANSWERTemp);
  FreeAndNil(NZIS_DIAGNOSTIC_REPORTTemp);
  FreeAndNil(NZIS_Result_DIAGNOSTIC_REPORTTemp);

  //FreeAndNil(CurrentPatient);
end;

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
    profGR.CL006Coll := CL006Coll;
    profGR.CL022Coll := CL022Coll;
    profGR.CL037Coll := CL037Coll;
    profGR.CL038Coll := CL038Coll;
    profGR.CL050Coll := CL050Coll;
    profGR.CL132Coll := CL132Coll;
    profGR.CL134Coll := CL134Coll;
    profGR.CL142Coll := CL142Coll;
    profGR.CL144Coll := CL144Coll;
    profGR.CL088Coll := CL088Coll;
    profGR.PR001Coll := PR001Coll;
    profGR.BufNomen := AspectsNomFile.Buf;
    profGR.BufADB := AspectsHipFile.Buf;
    profGR.posDataADB := AspectsHipFile.FPosData;
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
    egn := CollPatient.getAnsiStringMap(runDataPat.DataPos, word(PatientNew_EGN));
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
            mkb := diag.getAnsiStringMap(CollDiag.Buf, CollDiag.posData, word(Diagnosis_code_CL011));
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
    dat := pat.getDateMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_BIRTH_DATE));
    log := TlogicalPatientNewSet(pat.getLogical32Map(CollPatient.Buf, CollPatient.posData, word(PatientNew_Logical)));
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
    pnlTest.Caption := pat.NoteProf;
    btnNzisProf.Enabled  := (pat.NoteProf <> 'Няма неизвършени дейности по профилактиката.');
    pnlTest.Repaint;
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
    profGR.CL006Coll := CL006Coll;
    profGR.CL022Coll := CL022Coll;
    profGR.CL037Coll := CL037Coll;
    profGR.CL038Coll := CL038Coll;
    profGR.CL050Coll := CL050Coll;
    profGR.CL132Coll := CL132Coll;
    profGR.CL134Coll := CL134Coll;
    profGR.CL142Coll := CL142Coll;
    profGR.CL144Coll := CL144Coll;
    profGR.CL088Coll := CL088Coll;
    profGR.PR001Coll := PR001Coll;
    profGR.BufNomen := AspectsNomFile.Buf;
    profGR.BufADB := AspectsHipFile.Buf;
    profGR.posDataADB := AspectsHipFile.FPosData;
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
          mkb := diag.getAnsiStringMap(CollDiag.Buf, CollDiag.posData, word(Diagnosis_code_CL011));
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


  dat := pat.getDateMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_BIRTH_DATE));
  log := TlogicalPatientNewSet(pat.getLogical32Map(CollPatient.Buf, CollPatient.posData, word(PatientNew_Logical)));
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
  profGR.LoadVtrGraph(pat, i);

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
              CL132Key := CollNZIS_PLANNED_TYPE.getAnsiStringMap(runDataPregledNodes.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
              if (CollNZIS_PLANNED_TYPE.getDateMap(runDataPregledNodes.DataPos, word(NZIS_PLANNED_TYPE_StartDate))<=
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

  pnlTest.Caption := pat.NoteProf;
  btnNzisProf.Enabled  := (pat.NoteProf <> 'Няма неизвършени дейности по профилактиката.');
  pnlTest.Repaint;

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
  lstPatGraph.Clear;
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
        mkb := diag.getAnsiStringMap(CollDiag.Buf, CollDiag.posData, word(Diagnosis_code_CL011));
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

    lstPatGraph.Clear;
    i := lstPatGraph.Add(pat);
    //pat.DataPos := runDataPat.DataPos;
    dat := pat.getDateMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_BIRTH_DATE));
    log := TlogicalPatientNewSet(pat.getLogical32Map(CollPatient.Buf, CollPatient.posData, word(PatientNew_Logical)));
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
  nzisThr.PregColl := CollPregled;
  nzisThr.CollNzisToken := CollNzisToken;
  nzisThr.Resume;
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
        oldStatus := CollPregled.GetWordMap(preg.DataPos, word(PregledNew_NZIS_STATUS));
        case oldStatus of
          3: //
          begin
            CollPregled.SetWordMap(preg.DataPos, word(PregledNew_NZIS_STATUS), 16);// провален отваряне
            FmxProfForm.CheckKep := false;
          end;
          13: //
          begin
            CollPregled.SetWordMap(preg.DataPos, word(PregledNew_NZIS_STATUS), 15);// провален готов
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
  nzisThr.PregColl := nil;
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
begin
  //TempFindedItem.DataPos := CollPregled.ListNodes[grdNom.Selected.Row].DataPos;
  //data := pointer(PByte(runNode) + lenNode);
  if false then
  begin
    data := CollPregled.ListNodes[grdNom.Selected.Row];
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

  if not hntLek.ShowingHint then
  begin
    hntLek.Title := 'ddd';
    hntLek.Description := 'desk';
    hntLek.HideAfter := 5000;
    hntLek.ShowHint(grdSearch.ClientToScreen(Point(x, y)));
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
  dataList, data, tagData, dataPat: PAspRec;
  runNode, nodeList, nodePat: PVirtualNode;
  bufLink: Pointer;
  linkPos, FPosLinkData: Cardinal;
  pCardinalData: PCardinal;
  SelRow: Integer;
begin

  Stopwatch := TStopwatch.StartNew;
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
  case TVtrVid(grdSearch.Tag) of
    vvPatient:
    begin
      if (CollPatient.ListDataPos.count - 1) < SelRow then
      Exit;
      nodeList := CollPatient.ListDataPos[SelRow];

      //begin
//        runNode := vtrPregledPat.RootNode.FirstChild.FirstChild;
//        while runNode <> nil  do
//        begin
//          data := pointer(PByte(runNode) + lenNode);
//          if data.DataPos = dataList.DataPos then
//          begin
//            vtrPregledPat.Selected[runNode] := True;
//            Break;
//          end;
//          runNode := runNode.NextSibling;
//        end;
//        ProfGraphClick(nil);
//        vtrGraph.Repaint;
//      end;
    end;
    vvPregled:
    begin
      if (CollPregled.ListDataPos.count - 1) < SelRow then
      Exit;
      if CollPregled.lastBottom = - 1 then
      begin
        nodeList := CollPregled.ListDataPos[SelRow];
      end
      else
      begin
        nodeList := CollPregled.ListDataPos[SelRow + CollPregled.offsetTop];
      end;
      nodePat := nodeList.Parent;
      dataPat := Pointer(PByte(nodePat) + lenNode);
      data := Pointer(PByte(nodeList) + lenNode);
      if vtrPregledPat.GetFirstSelected <> nodeList then
      begin
        //if CanSelectNodeFromSearchGrid then
        begin
          vtrPregledPat.Selected[nodeList] := True;
          Application.ProcessMessages;
          grdSearch.Tag := word(vvPregled);
         // CanSelectNodeFromSearchGrid := False;
        end;
        //vtrPregledPat.RepaintNode(nodeList);
        //vtrPreglediChange_Patients(vtrPregledPat, nodeList);
        InternalChangeWorkPage(tsFMXForm);
        tsFMXForm.Tag := data.DataPos;
        tsNZIS.Tag := integer(nodeList);


        //GenerateNzisXml(nodeList);

        ShowPregledFMX(dataPat, data, nodeList); //  показване на динамичната форма
        Application.ProcessMessages;
        //FmxProfForm.scldlyt1.Repaint;
        //vtrPregledPat.Selected[nodeList] := True;
      end
      else
      begin
        //vtrPreglediChange_Patients(vtrPregledPat, nodeList);
      end;

      //buflink := AspectsLinkPatPregFile.Buf;
//      linkPos := 100;
//      pCardinalData := pointer(PByte(buflink));
//      FPosLinkData := pCardinalData^;
//      while linkpos < FPosLinkData do
//      begin
//        RunNode := pointer(PByte(bufLink) + linkpos);
//        data := pointer(PByte(RunNode) + lenNode);
//        if data.DataPos = dataList.DataPos then
//        begin
//          if vtrPregledPat.GetFirstSelected <> runNode then
//          begin
//            vtrPregledPat.Selected[runNode] := True;
//          end
//          else
//          begin
//            vtrPreglediChange_Patients(vtrPregledPat, runNode);
//          end;
//          FmxProfForm.WindowState := wsMaximized;
//          //fmxCntrDyn.ChangeActiveForm(FmxProfForm);
//            Break;
//        end;
//        Inc(linkPos, LenData);
//      end;
    end;
  end;

  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('grdSearchSelect за %f',[ Elapsed.TotalMilliseconds]));

end;

procedure TfrmSuperHip.GrdSearhKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  runNode, nodeList, nodePat: PVirtualNode;
  dataPat, data: PAspRec;
  selRow: Integer;
begin
  if grdSearch.Selected.Row < 0 then
  begin
    Exit;
  end
  else
  begin
    SelRow := grdSearch.Selected.Row;
  end;
  if CollPregled.lastBottom = - 1 then
  begin
    nodeList := CollPregled.ListDataPos[SelRow];
  end
  else
  begin
    nodeList := CollPregled.ListDataPos[SelRow + CollPregled.offsetTop];
  end;
  nodePat := nodeList.Parent;
  dataPat := Pointer(PByte(nodePat) + lenNode);
  data := Pointer(PByte(nodeList) + lenNode);
  if vtrPregledPat.GetFirstSelected <> nodeList then
  begin
    vtrPregledPat.Selected[nodeList] := True;
    grdSearch.Tag := word(vvPregled);
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
  //Adb_DM.CollDoc := CollDoctor;

end;

procedure TfrmSuperHip.InitColl;
begin

  CollDoctor := TRealDoctorColl.Create(TRealDoctorItem);
  ListDoctorForFDB := TList<TDoctorItem>.create;
  ListPregledLinkForInsert := TList<PVirtualNode>.create;

  CollUnfav := TRealUnfavColl.Create(TRealUnfavItem);
  CollUnfav.OnCurrentYearChange := OnChangeYear;
  CollMkb := TMkbColl.Create(TMkbItem);
  CollPregled := TRealPregledNewColl.Create(TRealPregledNewItem);
  CollPregled.OnKeyUpGridSearch := GrdSearhKeyUp;
  ListPregledForFDB := TList<TPregledNewItem>.Create;
  CollPatient := TRealPatientNewColl.Create(TRealPatientNewItem);
 // CollPatForSearch := TRealPatientNewColl.Create(TRealPatientNewItem);
  //CollPatForSearch.ArrPropSearch := [PatientNew_ID, PatientNew_EGN, PatientNew_BIRTH_DATE, PatientNew_FNAME];
  CollPregForSearch := TRealPregledNewColl.Create(TRealPregledNewItem);
  CollPregForSearch.ArrPropSearch := [PregledNew_AMB_LISTN, PregledNew_NRN, PregledNew_ANAMN];

  ListPatientForFDB := TList<TPatientNewItem>.Create;
  CollPatPis := TRealPatientNZOKColl.Create(TRealPatientNZOKItem);
  AcollpatFromDoctor := TRealPatientNewColl.Create(TRealPatientNewItem);
  ACollPatFDB := TRealPatientNewColl.Create(TRealPatientNewItem);
  ACollNovozapisani := TRealPatientNewColl.Create(TRealPatientNewItem);

  CollDiag := TRealDiagnosisColl.Create(TRealDiagnosisItem);
  CollMDN := TRealMDNColl.Create(TRealMDNItem);
  CollEventsManyTimes := TRealEventsManyTimesColl.Create(TRealEventsManyTimesItem);
  CollPregledVtor := Tlist<TRealPregledNewItem>.Create;
  CollPregledPrim := Tlist<TRealPregledNewItem>.Create;
  AnalsNewColl := TAnalsNewColl.Create(TAnalsNewItem);
  CollPractica := TPracticaColl.Create(TPracticaItem);
  CollEbl := TRealExam_boln_listColl.Create(TRealExam_boln_listItem);
  CollExamAnal := TRealExamAnalysisColl.Create(TRealExamAnalysisItem);
  CollExamImun := TRealExamImmunizationColl.Create(TRealExamImmunizationItem);
  CollProceduresNomen := TRealProceduresColl.Create(TRealProceduresItem);
  CollProceduresPreg := TRealProceduresColl.Create(TRealProceduresItem);
  CollCardProf := TRealKARTA_PROFILAKTIKA2017Coll.Create(TRealKARTA_PROFILAKTIKA2017Item);
  CollMedNapr := TRealBLANKA_MED_NAPRColl.Create(TRealBLANKA_MED_NAPRItem);
  CollNzisToken := TNzisTokenColl.Create(TNzisTokenItem);
  CollCertificates := TCertificatesColl.Create(TCertificatesItem);

  CollNZIS_PLANNED_TYPE := TRealNZIS_PLANNED_TYPEColl.Create(TRealNZIS_PLANNED_TYPEItem);
  CollNZIS_QUESTIONNAIRE_RESPONSE := TRealNZIS_QUESTIONNAIRE_RESPONSEColl.Create(TRealNZIS_QUESTIONNAIRE_RESPONSEItem);
  CollNZIS_QUESTIONNAIRE_ANSWER := TRealNZIS_QUESTIONNAIRE_ANSWERColl.Create(TRealNZIS_QUESTIONNAIRE_ANSWERItem);
  CollNZIS_ANSWER_VALUE := TRealNZIS_ANSWER_VALUEColl.Create(TRealNZIS_ANSWER_VALUEItem);
  CollNZIS_DIAGNOSTIC_REPORT := TRealNZIS_DIAGNOSTIC_REPORTColl.Create(TRealNZIS_DIAGNOSTIC_REPORTItem);
  CollNzis_RESULT_DIAGNOSTIC_REPORT := TRealNZIS_RESULT_DIAGNOSTIC_REPORTColl.Create(TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem);

  CL132Coll := TRealCL132Coll.Create(TRealCL132Item);
  CL050Coll := TCL050Coll.Create(TCL050Item);
  CL006Coll := TRealCL006Coll.Create(TRealCL006Item);
  CL022Coll := TRealCL022Coll.Create(TRealCL022Item);
  CL024Coll := TRealCL024Coll.Create(TRealCL024Item);
  CL037Coll := TRealCL037Coll.Create(TRealCL037Item);
  CL038Coll := TRealCL038Coll.Create(TRealCL038Item);
  CL088Coll := TRealCL088Coll.Create(TRealCL088Item);
  CL134Coll := TRealCL134Coll.Create(TRealCL134Item);
  CL139Coll := TRealCL139Coll.Create(TRealCL139Item);
  CL142Coll := TRealCL142Coll.Create(TRealCL142Item);
  CL144Coll := TRealCL144Coll.Create(TRealCL144Item);
  PR001Coll := TRealPR001Coll.Create(TRealPR001Item);
  NomenNzisColl := TNomenNzisColl.Create(TNomenNzisItem);

  //LSNomenNzisNames := TStringList.Create;
  ListNomenNzisNames := TList<TNomenNzisRec>.Create;
  lstPatGraph := TList<TRealPatientNewItem>.Create;

  //ListNodes  := TList<PAspRec>.Create;
  PatientTemp := TRealPatientNewItem.Create(nil);
  PregledTemp := TPregledNewItem.Create(nil);
  preg1 := TPregledNewItem.Create(nil);
  preg2 := TPregledNewItem.Create(nil);
  DiagTemp  := TDiagnosisItem.Create(nil);
  MDNTemp := TMDNItem.Create(nil);
  ExamAnalTemp := TExamAnalysisItem.Create(nil);
  DoctorTemp := TDoctorItem.Create(nil);
  EvnTemp := TEventsManyTimesItem.Create(nil);
  AnalTemp:= TAnalsNewItem.Create(nil);
  Cl022temp := TCL022Item.Create(nil);
  Cl132temp := TRealCL132Item.Create(nil);
  PR001Temp := TRealPR001Item.Create(nil);
  CL088Temp := TRealCl088Item.Create(nil);
  ProcTemp := TRealProceduresItem.Create(nil);
  NZIS_PLANNED_TYPETemp := TRealNZIS_PLANNED_TYPEItem.Create(nil);
  NZIS_QUESTIONNAIRE_RESPONSETemp := TRealNZIS_QUESTIONNAIRE_RESPONSEItem.Create(nil);
  NZIS_QUESTIONNAIRE_ANSWERTemp := TRealNZIS_QUESTIONNAIRE_ANSWERItem.Create(nil);
  NZIS_ANSWER_VALUETemp := TRealNZIS_ANSWER_VALUEItem.Create(nil);
  NZIS_DIAGNOSTIC_REPORTTemp := TRealNZIS_DIAGNOSTIC_REPORTItem.Create(nil);
  NZIS_Result_DIAGNOSTIC_REPORTTemp := TRealNZIS_Result_DIAGNOSTIC_REPORTItem.Create(nil);

  LoadLinkOptions;
end;

procedure TfrmSuperHip.initDB;
begin
  Stopwatch := TStopwatch.StartNew;
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
  if AspectsHipFile = nil then  // не е намерено адб отговарящо на гдб-то. трябва да се импортира.
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
    OpenADB(AspectsHipFile);
    OpenCmd(AspectsHipFile);
    FindLNK(AspectsHipFile.GUID);
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


   FmxProfForm.Adb_dm := Adb_DM;
   FmxProfForm.profGR := profGR;
   FmxProfForm.mmotest := mmotest;
   FmxProfForm.VtrGrapf := vtrGraph;
   FmxProfForm.VtrPregLink := vtrPregledPat;
   FmxProfForm.Cl139Coll := CL139Coll;
   FmxProfForm.Cl132Coll := CL132Coll;
   FmxProfForm.Cl006Coll := CL006Coll;
   FmxProfForm.Cl142Coll := CL142Coll;
   FmxProfForm.Cl144Coll := CL144Coll;
   FmxProfForm.Cl134Coll := CL134Coll;
   FmxProfForm.Cl088Coll := CL088Coll;
   FmxProfForm.Pr001Coll := PR001Coll;

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
      pat := lstPatGraph[dataPat.index];
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
      APat := ACollPatFDB.Items[Adata.index];
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
      pat := ACollPatFDB.Items[adata.index];
      patId := pat.getIntMap(AspectsHipFile.buf, CollPatient.posData, word(PatientNew_ID));
      ibsql.Close;
      ibsql.SQL.Text :=
          'update pacient pa' + #13#10 +
          'set' + #13#10 +
          'pa.date_otpisvane = :date_otpisvane,' + #13#10 +
          'pa.pat_kind = 2' + #13#10 +
          'where pa.id = :patID';
      ibsql.ParamByName('patID').AsInteger := patId;
      ibsql.ParamByName('date_otpisvane').AsDate := pat.LastPregled.getDateMap(AspectsHipFile.buf, CollPatient.posData, word(PregledNew_START_DATE)) + 1;
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
  thrSearch.CollPat.ShowLinksGrid(grdSearch);
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

  nzisThr.StreamData := ListNomenNzisNames[nomenId].xmlStream;
  nzisThr.Resume;
end;

procedure TfrmSuperHip.LoadLinkOptions;
var
  fileLinkOptName: string;
begin
  if AspectsOptionsLinkFile <> nil then
  begin
    vtrLinkOptions.InternalDisconnectNode(vtrLinkOptions.RootNode.FirstChild, false);
    AspectsOptionsLinkFile.Free;
    AspectsOptionsLinkFile := nil;
  end;

  fileLinkOptName := 'LinkOptions.lnk';

  AspectsOptionsLinkFile := TMappedLinkFile.Create(fileLinkOptName, false, TGUID.Empty);

  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('MapLink за %f',[Elapsed.TotalMilliseconds]));


  AspectsOptionsLinkFile.FVTR := vtrLinkOptions;
  Stopwatch := TStopwatch.StartNew;
  AspectsOptionsLinkFile.OpenLinkFile;
  CollPregled.linkOptions := AspectsOptionsLinkFile;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('ЗарежданеLinkOptions %d за %f',[vtrLinkOptions.RootNode.TotalCount,  Elapsed.TotalMilliseconds]));

end;

procedure TfrmSuperHip.LoadThreadDB(dbName: string);
var
  thrLoadDb: TLoadDBThread;
begin
  thrLoadDb := TLoadDBThread.Create(True, dbname);
  thrLoadDb.Buf := AspectsHipFile.Buf;
  CollDoctor.Buf := AspectsHipFile.Buf;
  CollDoctor.posData := AspectsHipFile.FPosData;
  CollMkb.Buf := AspectsHipFile.Buf;
  CollMkb.posData := AspectsHipFile.FPosData;
  CollPatient.Buf := AspectsHipFile.Buf;
  CollPatient.posData := AspectsHipFile.FPosData;
  CollMDN.Buf := AspectsHipFile.Buf;
  CollMDN.posData := AspectsHipFile.FPosData;
  CollPregled.Buf := AspectsHipFile.Buf;
  CollPregled.posData := AspectsHipFile.FPosData;
  CollDiag.Buf := AspectsHipFile.Buf;
  CollDiag.posData := AspectsHipFile.FPosData;
  CollPregled.FCollDiag := CollDiag;
  Collmdn.FCollDiag := CollDiag;
  CollUnfav.Buf := AspectsHipFile.Buf;
  CollUnfav.posData := AspectsHipFile.FPosData;
  CollEventsManyTimes.Buf := AspectsHipFile.Buf;
  CollEventsManyTimes.posData := AspectsHipFile.FPosData;
  CollPractica.Buf :=  AspectsHipFile.Buf;
  CollPractica.posData := AspectsHipFile.FPosData;
  CollEBL.Buf :=  AspectsHipFile.Buf;
  CollEBL.posData := AspectsHipFile.FPosData;
  CollExamAnal.Buf :=  AspectsHipFile.Buf;
  CollExamAnal.posData := AspectsHipFile.FPosData;
  CollExamImun.Buf :=  AspectsHipFile.Buf;
  CollExamImun.posData := AspectsHipFile.FPosData;
  CollProceduresNomen.Buf :=  AspectsHipFile.Buf;
  CollProceduresNomen.posData := AspectsHipFile.FPosData;
  CollCardProf.Buf :=  AspectsHipFile.Buf;
  CollCardProf.posData := AspectsHipFile.FPosData;
  CollMedNapr.Buf :=  AspectsHipFile.Buf;
  CollMedNapr.posData := AspectsHipFile.FPosData;
  CollMedNapr.FCollDiag := CollDiag;

  thrLoadDb.FDBHelper := FDBHelper;

  thrLoadDb.MKBColl := CollMkb;
  thrLoadDb.PatientColl := CollPatient;
  thrLoadDb.DoctorColl := CollDoctor;
  thrLoadDb.PregledNewColl := CollPregled;
  thrLoadDb.DiagColl := CollDiag;
  thrLoadDb.UnFavColl := CollUnfav;
  thrLoadDb.MDNColl := CollMDN;
  thrLoadDb.PracticaColl := CollPractica;
  thrLoadDb.EBLColl := CollEBL;
  thrLoadDb.ExamAnalColl := CollExamAnal;
  thrLoadDb.ExamImunColl := CollExamImun;
  thrLoadDb.ProcCollNomen := CollProceduresNomen;
  thrLoadDb.ProcCollPreg := CollProceduresPreg;
  thrLoadDb.AdbNomen := AspectsNomFile;
  thrLoadDb.Cl142Coll := CL142Coll;
  thrLoadDb.KARTA_PROFILAKTIKA2017Coll := CollCardProf;
  thrLoadDb.MedNaprColl := CollMedNapr;
  thrLoadDb.EventsManyTimesColl := CollEventsManyTimes;
  thrLoadDb.LinkAnals := AspectsLinkNomenHipAnalFile;

  //thrLoadDb.FCollPregVtor := CollPregledVtor;
  //thrLoadDb.FCollMedNapr := CollMedNapr;
  thrLoadDb.FreeOnTerminate := True;
  thrLoadDb.OnTerminate := TerminateLoadDB;
  thrLoadDb.OnProgres := LoadDbOnProgres;
  thrLoadDb.OnCnt := LoadDbOnCNT;
  thrLoadDb.cmdFile := streamCmdFile;

  thrLoadDb.Guid := AspectsHipFile.GUID;
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

  for i := 0 to CollDoctor.Count - 1 do
  begin
    doc := CollDoctor.Items[i];
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
      NZIS_PLANNED_TYPE, NZIS_QUESTIONNAIRE_RESPONSE, NZIS_ANSWER_VALUE,
      NZIS_QUESTIONNAIRE_ANSWER, NZIS_DIAGNOSTIC_REPORT, NZIS_RESULT_DIAGNOSTIC_REPORT,
      NzisToken, CERTIFICATES:
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
  dataNode, data: PAspRec;
  vPregNode, vPreg: PVirtualNode;
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
    if datanode.vid <> vvPregled then
    begin
      vPregNode := vPregNode.NextSibling;
      Continue;
    end;
    vPreg := vtrMinaliPregledi.AddChild(nil, nil);
    data := vtrMinaliPregledi.GetNodeData(vPreg);
    data.index := integer(vPregNode);
    data.DataPos := dataNode.DataPos;
    data.vid := vvPregled;
    vPregNode := vPregNode.NextSibling;
  end;
  if Fdm.IsGP and (Apat <> nil) then
  begin
    vPreg := vtrMinaliPregledi.AddChild(nil, nil);
    data := vtrMinaliPregledi.GetNodeData(vPreg);
    data.DataPos := 0;
    data.vid := vvCl132;
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
  ListNomenNzisNames.Count := NomenNzisColl.Count;

  for i := 0 to NomenNzisColl.Count - 1 do
  begin
    ListNomenNzisNames[i] := TNomenNzisRec.Create;
    ListNomenNzisNames[i].nomenNzis := NomenNzisColl.Items[i];

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
  ListNomenNzisNames.Count := MaxCnt;

  for i := 0 to MaxCnt -1 do
  begin
    ListNomenNzisNames[i] := TNomenNzisRec.Create;
    ListNomenNzisNames[i].nomenNzis := TNomenNzisItem(NomenNzisColl.add);
    New(ListNomenNzisNames[i].nomenNzis.PRecord);
    ListNomenNzisNames[i].nomenNzis.PRecord.setProp := [NomenNzis_NomenName, NomenNzis_NomenID];
    ListNomenNzisNames[i].nomenNzis.PRecord.NomenName := '';
    ListNomenNzisNames[i].nomenNzis.PRecord.NomenID := Format('CL%.*d', [3, i]) ;;

    v := vtrNomenNzis.AddChild(vRootNomenNzis, nil);
    case i of
      006:
      begin
        if CL006Coll.Count > 0 then
        begin
          ListNomenNzisNames[i].AspColl := CL006Coll;
          v.Dummy := 80;
        end;
      end;
      022:
      begin
        if CL022Coll.Count > 0 then
        begin
          ListNomenNzisNames[i].AspColl := CL022Coll;
          v.Dummy := 80;
        end;
      end;
      024:
      begin
        if CL024Coll.Count > 0 then
        begin
          ListNomenNzisNames[i].AspColl := CL024Coll;
          v.Dummy := 80;
        end;
      end;
      037:
      begin
        if CL037Coll.Count > 0 then
        begin
          ListNomenNzisNames[i].AspColl := CL037Coll;
          v.Dummy := 80;
        end;
      end;
      038:
      begin
        if CL038Coll.Count > 0 then
        begin
          ListNomenNzisNames[i].AspColl := CL038Coll;
          v.Dummy := 80;
        end;
      end;
      050:
      begin
        if CL050Coll.Count > 0 then
        begin
          ListNomenNzisNames[i].AspColl := CL050Coll;
          v.Dummy := 80;
        end;
      end;
      088:
      begin
        if CL088Coll.Count > 0 then
        begin
          ListNomenNzisNames[i].AspColl := CL088Coll;
          v.Dummy := 80;
        end;
      end;
      132:
      begin
        if CL132Coll.Count > 0 then
        begin
          ListNomenNzisNames[i].AspColl := CL132Coll;
          v.Dummy := 80;
        end;
      end;
      134:
      begin
        if CL134Coll.Count > 0 then
        begin
          ListNomenNzisNames[i].AspColl := CL134Coll;
          v.Dummy := 80;
        end;
      end;
      139:
      begin
        if CL139Coll.Count > 0 then
        begin
          ListNomenNzisNames[i].AspColl := CL139Coll;
          v.Dummy := 80;
        end;
      end;
      142:
      begin
        if CL142Coll.Count > 0 then
        begin
          ListNomenNzisNames[i].AspColl := CL142Coll;
          v.Dummy := 80;
        end;
      end;
      144:
      begin
        if CL144Coll.Count > 0 then
        begin
          ListNomenNzisNames[i].AspColl := CL144Coll;
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
  immun: TRealExamImmunizationItem;
  profCard: TRealKARTA_PROFILAKTIKA2017Item;
  examAnal: TRealExamAnalysisItem;
  preg: TRealPregledNewItem;
  pat: TRealPatientNewItem;
  evnPat: TEventsManyTimesItem;
  vPreg, vPat, vMN, vDoc, vPerformer, vDeput, vEvnt, vMdn: PVirtualNode;
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
  data.vid := vvPatientRoot;
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
                    vtr, amAddChildLast);
  run := TreeLink;

  for I := 0 to CollPatient.Count - 1 do
  begin
    pat := CollPatient.Items[i];
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
                    vtr, amAddChildLast);

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
      vtr.InternalConnectNode_cmd(TreeLink, vPat, vtr, amAddChildLast);
    end;

    if pat.FEventsPat.Count > 0 then
    begin
      for j := 0 to pat.FEventsPat.Count - 1 do
      begin
        evnPat := pat.FEventsPat[j];
        TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
        data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
        data.DataPos := evnPat.DataPos;
        data.vid := vvEvnt;
        data.index := -1;
        inc(linkpos, LenData);

        TreeLink.TotalCount := 1;
        TreeLink.TotalHeight := 27;
        TreeLink.NodeHeight := 27;
        TreeLink.States := [vsVisible];
        TreeLink.Align := 50;
        //vtr.InitNode(TreeLink);
        //if vEvnt <> nil then
//        begin
//          TreeLink.Parent := vEvnt;
//        end;
        //vEvnt := TreeLink;


        vtr.InternalConnectNode_cmd(TreeLink, vpat,
                        vtr, amAddChildLast);

      end;

      //TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
//      data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
//      data.DataPos := Cardinal(vEvnt);
//      data.vid := vvEvntList;
//      data.index := -1;
//      inc(linkpos, LenData);
//
//      TreeLink.TotalCount := 1;
//      TreeLink.TotalHeight := 27;
//      TreeLink.NodeHeight := 27;
//      TreeLink.States := [vsVisible];
//      TreeLink.Align := 50;
//      vtr.InitNode(TreeLink);
//      vtr.InternalConnectNode_cmd(TreeLink, vpat,
//                      vtr, amAddChildLast);
    end;



    for j := 0 to pat.FPregledi.Count - 1 do
    begin
      preg := TRealPregledNewItem(pat.FPregledi[j]);
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
      TreeLink.Dummy := j mod 255;
      vtr.InitNode(TreeLink);
      vtr.InternalConnectNode_cmd(TreeLink, vpat,
                      vtr, amAddChildFirst);

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
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast);

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
          vtr.InternalConnectNode_cmd(TreeLink, vPerformer, vtr, amAddChildLast);
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
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast);
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
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast);
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
        TreeLink.Dummy := k mod 255;
        vtr.InitNode(TreeLink);
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast);

        vMdn  := TreeLink;

        for m := 0 to mdn.FDiagnosis.Count -1 do
        begin
          diag := mdn.FDiagnosis[m];
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
          vtr.InternalConnectNode_cmd(TreeLink, vMDN, vtr, amAddChildLast);
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
          vtr.InternalConnectNode_cmd(TreeLink, vMDN, vtr, amAddChildLast);
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
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast);

        vMn  := TreeLink;
        for m := 0 to mn.FDiagnosis.Count -1 do
        begin
          diag := mn.FDiagnosis[m];
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
          vtr.InternalConnectNode_cmd(TreeLink, vMn, vtr, amAddChildLast);
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
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast);
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
        vtr.InternalConnectNode_cmd(TreeLink, vpreg, vtr, amAddChildLast);
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
  BufADB := AspectsHipFile.Buf;
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

  collPregForSearch.ListDataPos.Clear;

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
                      mkb := tempDiag.getAnsiStringMap(CollDiag.Buf, CollDiag.posData, word(Diagnosis_code_CL011));
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
  CollPatient.ListForFinder.Clear;

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

  for i := 0 to CollDoctor.Count - 1 do
  begin
    vDoc := vtrSpisyci.AddChild(nil, nil);
    data := vtrSpisyci.GetNodeData(vDoc);
    data.index := i;
    data.vid := vvDoctor;
    CollDoctor.Items[i].Node := vDoc;
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
  CollPregled.SetIntMap(data.DataPos, word(PregledNew_AMB_LISTN), 88);
  ListPregledLinkForInsert.Add(node);
  CheckCollForSave;
end;

procedure TfrmSuperHip.mniNomenNzisClick(Sender: TObject);
begin
  pnlRoleView.Roles.ActivePanel := RolPnlNomen;
  RolPnlNomen.FillIcon(pnlRoleView);
  //pnlRoleView.Roles.Items[3].MainButtons.Items[1].FButton.Click;
  NzisNomenClick(pnlRoleView.Roles.Items[3].MainButtons.Items[1]);
end;

procedure TfrmSuperHip.mniOnlyCloningClick(Sender: TObject);
var
  node: PVirtualNode;
begin
  vtrTemp.BeginUpdate;
  node := vtrTemp.GetFirst();
  if node = nil then Exit;
 // vtrTemp.FullCollapse(node);
  vtrTemp.IterateSubtree(node, IterateFilterOnlyCloning, nil);
  vtrTemp.EndUpdate;
end;

procedure TfrmSuperHip.mniPatientSearchViewClick(Sender: TObject);
begin
  grdSearch.Tag := word(vvPatient);
  thrSearch.CollPat.ShowLinksGrid(grdSearch);
end;

procedure TfrmSuperHip.mniPregledSearchViewClick(Sender: TObject);
var
  i: Integer;
begin
  grdSearch.Tag := word(vvPregled);

  thrSearch.collPreg.ShowLinksGrid(grdSearch);
  Stopwatch := TStopwatch.StartNew;
  for i := 0 to 200 do// CollPregled.ListDataPos.count - 1 do
  begin
    grdSearch.Selected.Row := i;
    Application.ProcessMessages;
  end;
  Elapsed := Stopwatch.Elapsed;
  //FmxProfForm.scldlyt1.endupdate;
  mmoTest.Lines.Add( '2000 br. za ' + FloatToStr(Elapsed.TotalMilliseconds));

end;

procedure TfrmSuperHip.mniRemontCloningsClick(Sender: TObject);
begin
  RemontCloning;
end;

procedure TfrmSuperHip.mniRemontPatClick(Sender: TObject);
begin
  RemontPat;
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
  SendMessage(self.Handle, WM_SYSCOMMAND, 61458, 0) ;
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
  nzisThr.PregColl := CollPregled;
  nzisThr.CollNzisToken := CollNzisToken;
  nzisThr.Resume;
end;

procedure TfrmSuperHip.OnActivateFMX(sender: TObject);
begin
 // if vtrPregledPat.MouseInClient then
   // vtrPregledPat.SetFocus;
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
  lblYear.Caption := inttostr(CollUnfav.CurrentYear);
  if vtrSpisyci.Header.Columns.Count > 0 then
  begin
    vtrSpisyci.Header.Columns[0].Text := format('Лекари' + #13#10 + 'За %d г. по месеци', [collunfav.CurrentYear]);
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
        if CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          edtCertNom.Text := BuildHexString(CollDoctor.Items[0].Cert.SerialNumber);
          CollDoctor.Items[0].Cert.Clone(CertForThread);
          CollDoctor.Items[0].Cert.Clone(CurrentCert);
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
        if CollDoctor.Items[0].Cert <> nil then // намерен е подпис за доктора
        begin
          if CurrentCert = nil then
            CurrentCert := TelX509Certificate.Create(self);
          CollDoctor.Items[0].Cert.Clone(CertForThread);
          CollDoctor.Items[0].Cert.Clone(CurrentCert);
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

procedure TfrmSuperHip.SelectMKB(sender: TObject);
var
  diag: TRealDiagnosisItem;
begin
  diag := TRealDiagnosisItem(sender);
  vtrTemp.Selected[diag.MkbNode] := True;
end;

procedure TfrmSuperHip.SetPatientTemp(const Value: TRealPatientNewItem);
begin
  FPatientTemp := Value;
end;

procedure TfrmSuperHip.SetSearchTextSpisyci(const Value: string);
begin
  FSearchTextSpisyci := Value;
  vtrSpisyci.Repaint;
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
begin
  Stopwatch := TStopwatch.StartNew;
  //FmxProfForm.scldlyt1.BeginUpdate;
  FmxProfForm.ClearListsPreg;
  FmxProfForm.linkPreg := linkPreg;
  if AspectsNomFile = nil then
    OpenBufNomenNzis(paramstr(2) + 'NzisNomen.adb');
  FmxProfForm.AspNomenBuf := AspectsNomFile.Buf;
  FmxProfForm.AspNomenPosData := AspectsNomFile.FPosData;


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
        if FmxProfForm.Pregled.CanDeleteDiag = true then
        begin
          diag := TRealDiagnosisItem.Create(nil);
          diag.DataPos := dataRun.DataPos;
          diag.Node := run;
          FmxProfForm.Pregled.FDiagnosis.Add(diag);
        end
        else
        begin

        end;
      end;
      vvMDN:
      begin
        mdn := CollMDN.GetItemsFromDataPos(dataRun.DataPos);
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
              anal := CollExamAnal.GetItemsFromDataPos(dataAnal.DataPos);
              if anal = nil then
              begin
                anal := TRealExamAnalysisItem.Create(nil);
                anal.DataPos := dataAnal.DataPos;
                mmoTest.Lines.Add(format('Fill anal.DataPos = %d', [anal.DataPos]));
                PosInNomen := anal.getIntMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, word(ExamAnalysis_PosDataNomen));
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
        cl132Key := CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
        prNomen := CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
        cl132pos := CollNZIS_PLANNED_TYPE.getCardMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_DataPos));
        cl136Key := CL132Coll.getAnsiStringMap(cl132pos, word(CL132_CL136_Mapping));
        if (cl136Key = '2') and (nodePlan.CheckState = csCheckedNormal) then
        begin
          mdn := CollMDN.GetItemsFromDataPos(dataRun.DataPos);
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
                anal := CollExamAnal.GetItemsFromDataPos(dataAnal.DataPos);
                if anal = nil then
                begin
                  anal := TRealExamAnalysisItem.Create(nil);
                  anal.DataPos := dataAnal.DataPos;
                  mmoTest.Lines.Add(format('Fill anal.DataPos = %d', [anal.DataPos]));
                  PosInNomen := anal.getIntMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, word(ExamAnalysis_PosDataNomen));
                  anal.LinkNode := runAnal;
                end;
                mdn.FExamAnals.Add(anal);
              end;
              vvMedNapr:
              begin
                mn := CollMedNapr.GetItemsFromDataPos(dataAnal.DataPos);
                if mn = nil then
                begin
                  mn := TRealBLANKA_MED_NAPRItem.Create(nil);
                  mn.DataPos := dataAnal.DataPos;
                  mn.LinkNode := run;
                end;
                FmxProfForm.Pregled.FMNs.Add(mn);
                mn.FPregled := FmxProfForm.Pregled;
              end;
            end;
            runAnal := runAnal.NextSibling;
          end;
        end
        else
        begin
          nodePlan := run;
          dataPlan := Pointer(PByte(nodePlan) + lenNode);
          cl132Key := CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
          prNomen := CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
          cl132pos := CollNZIS_PLANNED_TYPE.getCardMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_DataPos));
          cl136Key := CL132Coll.getAnsiStringMap(cl132pos, word(CL132_CL136_Mapping));
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
                mn := CollMedNapr.GetItemsFromDataPos(dataAnal.DataPos);
                if mn = nil then
                begin
                  mn := TRealBLANKA_MED_NAPRItem.Create(nil);
                  mn.DataPos := dataAnal.DataPos;
                  mn.LinkNode := run;
                end;
                FmxProfForm.Pregled.FMNs.Add(mn);
                mn.FPregled := FmxProfForm.Pregled;
              end;
            end;
            runAnal := runAnal.NextSibling;
          end;
        end;

      end;
      vvMedNapr:
      begin
        mn := CollMedNapr.GetItemsFromDataPos(dataRun.DataPos);
        if mn = nil then
        begin
          mn := TRealBLANKA_MED_NAPRItem.Create(nil);
          mn.DataPos := dataRun.DataPos;
          //mmoTest.Lines.Add(format('Fill mdn.DataPos = %d', [mdn.DataPos]));
          mn.LinkNode := run;
        end;
        FmxProfForm.Pregled.FMNs.Add(mn);
        mn.FPregled := FmxProfForm.Pregled;
      end;
      vvExamImun:
      begin
        immun := CollExamImun.GetItemsFromDataPos(dataRun.DataPos);
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
      vvPatientRevision:
      begin
        revis := TRevision.Create;
        revis.CollType := ctPatientNew;
        revis.node := run;
        revis.propIndex := run.Dummy;
        dataPatRevision := Pointer(PByte(run) + lenNode);
        ofset := dataPatRevision.index;
        case run.Dummy of
          word(PatientNew_FNAME):
          begin
            FmxProfForm.patNameF := CollPatient.getAnsiStringMapOfset(ofset, word(PatientNew_FNAME));
          end;
        end;
        //pat.Revisions.Add(revis);
      end;
    end;

    run := run.NextSibling;
  end;
  fmxCntrDyn.ChangeActiveForm(FmxProfForm);

  FmxProfForm.AspAdbBuf := AspectsHipFile.Buf;
  FmxProfForm.AspAdbPosData := AspectsHipFile.FPosData;
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
          FmxProfForm.Pregled := TRealPregledNewItem(CollPregled.Add);
          dataPreg.index := CollPregled.Count - 1;
        end
        else
        begin
          FmxProfForm.Pregled := CollPregled.Items[lastVacantPreg];

          dataPreg.index := lastVacantPreg;

        end;
        FmxProfForm.Pregled.FNode := linkPreg;
        FmxProfForm.Pregled.DataPos := dataPreg.DataPos;
      end
      else
      begin
        FmxProfForm.Pregled := CollPregled.Items[dataPreg.index];
        FmxProfForm.Pregled.FNode := linkPreg;
        //dataPreg.index := dataPreg.index; // не трябва да се сменява
        FmxProfForm.Pregled.DataPos := dataPreg.DataPos;
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
        //Exit;
      end;


      FmxProfForm.Pregled := CollPregled.Items[dataPreg.index]; //взимам  прегледа и му слагам новите неща
      FmxProfForm.Pregled.FNode := linkPreg;
      FmxProfForm.Pregled.DataPos := dataPreg.DataPos;
    end;
  end;

  FmxProfForm.ClearBlanka;


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
    FmxTokensForm.collDoctor := CollDoctor;
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
  //DynWinPanel1.Perform(WM_MOVE, 0, 0);
  //Self.VertScrollBar.Range := vtrPregledi.Height;
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
  NzisToken := TNzisTokenItem(CollNzisToken.Add);
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
  for i := 0 to Cl142Coll.Count - 1 do
  begin
    cl142 := Cl142Coll.Items[i];
    nhifCode := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_nhif_code));
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
          TempItem := TCL142Item(Cl142Coll.Add);
          New(TempItem.PRecord);
          datPos := Cl142Coll.posData;
          TempItem.PRecord.setProp := [CL142_Key, CL142_Description];
          TempItem.PRecord.Key := cl142.getAnsiStringMap(Cl142Coll.Buf, datPos, word(CL142_Key));
          TempItem.PRecord.Description := cl142.getAnsiStringMap(Cl142Coll.Buf, datPos, word(CL142_Description));

          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_DescriptionEn), len) <> nil then
          begin
            TempItem.PRecord.DescriptionEn := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_DescriptionEn));
            include(TempItem.PRecord.setProp, CL142_DescriptionEn);
          end;
          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_achi_block), len) <> nil then
          begin
            TempItem.PRecord.achi_block := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_achi_block));
            include(TempItem.PRecord.setProp, CL142_achi_block);
          end;
          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_achi_chapter), len) <> nil then
          begin
            TempItem.PRecord.achi_chapter := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_achi_chapter));
            include(TempItem.PRecord.setProp, CL142_achi_chapter);
          end;
          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_achi_code), len) <> nil then
          begin
            TempItem.PRecord.achi_code := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_achi_code));
            include(TempItem.PRecord.setProp, CL142_achi_code);
          end;
          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_nhif_code), len) <> nil then
          begin
            TempItem.PRecord.nhif_code := ArrNhifCode[j];
            include(TempItem.PRecord.setProp, CL142_nhif_code);
          end;
          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_cl048), len) <> nil then
          begin
            TempItem.PRecord.cl048 := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_cl048));
            include(TempItem.PRecord.setProp, CL142_cl048);
          end;
          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_cl006), len) <> nil then
          begin
            TempItem.PRecord.cl006 := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_cl006));
            include(TempItem.PRecord.setProp, CL142_cl006);
          end;
          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_highly), len) <> nil then
          begin
            TempItem.PRecord.highly := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_highly));
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
  for i := 0 to ACollPatFDB.Count - 1 do
  begin
    pat := ACollPatFDB.Items[i];

    if pat.FClonings.Count = 0 then Continue;
    for j := 0 to pat.FClonings.Count - 1 do
    begin
      inc(cnt);
      clon := pat.FClonings[j];
      clonId := clon.getIntMap(AspectsHipFile.buf, CollPatient.posData, word(PatientNew_ID));
      //for k := 0 to clon.FPregledi.Count - 1 do
      begin
        patId := pat.getIntMap(AspectsHipFile.buf, CollPatient.posData, word(PatientNew_ID));

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
  if Self.WindowState = wsMaximized then
  begin
    postmessage(handle,WM_SYSCOMMAND,SC_RESTORE,0);
    txt := '1';
  end
  else
  begin
    //postmessage(handle,WM_SYSCOMMAND,SC_MAXIMIZE,0);
    Self.WindowState := wsMaximized;
    Self.BorderStyle := bsSizeable;
    txt := '2';
    Self.BorderStyle := bsNone;
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
  CollPatPis.Buf := nil;
  CollPatPis.posData := 0;
  pnlRoleView.ForceClose;

  Stopwatch := TStopwatch.StartNew;
  if not dlgOpenPL.Execute then Exit;
  CollPatPis.Clear;
  CollPatPis.Uin := '';

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
    TempItem := TRealPatientNZOKItem(CollPatPis.Add);
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
    CollPatPis.Uin := uin;
  end;
  //pgcWork.ActivePage := tsGrid;
  InternalChangeWorkPage(tsGrid);
  CollPatPis.ShowGrid(grdNom);

  AcollpatFromDoctor.Buf := AspectsHipFile.Buf;
  ACollPatFDB.Buf := AspectsHipFile.Buf;
  AcollpatFromDoctor.posData := AspectsHipFile.FPosData;
  ACollPatFDB.posData := AspectsHipFile.FPosData;
  AcollpatFromDoctor.Clear;
  ACollPatFDB.Clear;
  FillListPL_NZOKFromDB('1100000095', AcollpatFromDoctor); // попълва се за  определен УИН
  FillListPL_ADB(ACollPatFDB);

  vtrFDB.Repaint;
  ACollPatFDB.IndexValue(PatientNew_EGN);
  ACollPatFDB.SortByIndexAnsiString;
  pat := ACollPatFDB.Items[0];
  egn := pat.IndexAnsiStr1;
  i := 1;
  while i < ACollPatFDB.Count do
  begin
    if egn = ACollPatFDB.Items[i].IndexAnsiStr1 then
    begin
      pat.FClonings.Add(ACollPatFDB.Items[i]);
      mmoTest.Lines.Add(egn);
      inc(i);
    end
    else
    begin
      pat := ACollPatFDB.Items[i];
      egn := pat.IndexAnsiStr1;
      inc(i);
    end;
  end;


  FillPatListPisInPatDB(uin, ACollPatFDB);


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

  if AspectsHipFile <> nil then
  begin
    UnmapViewOfFile(AspectsHipFile.Buf);
  end;
  if AspectsNomFile = nil then
    OpenBufNomenNzis(paramstr(2) + 'NzisNomen.adb');

  AGuid := TGuid.NewGuid;
  AdbDir := ParamStr(2);
  fileNameNew := AdbDir + 'AspHip' + AGuid.ToString + '.adb';
  fileStr := TFileStream.Create(fileNameNew, fmCreate);
  fileStr.Size := 1000000000;//00;
  fileStr.Free;

  AspectsHipFile := TMappedFile.Create(fileNameNew, true, AGuid);
  streamCmdFile := TFileCmdStream.Create(fileNameNew.Replace('.adb', '.cmd'), fmCreate);
  streamCmdFile.Size := 100;
  streamCmdFile.Position := streamCmdFile.Size;

  //LnkFilename := AspectsHipFile.FileName.Replace('.adb', '.lnk');
//  DeleteFile(LnkFilename);
//  fileStr := TFileStream.Create(LnkFilename, fmCreate);
//  fileStr.Size := 600000000;
//  fileStr.Free;
//
//  AspectsLinkPatPregFile := TMappedLinkFile.Create(LnkFilename, true, AspectsHipFile.GUID);

  OpenLinkNomenHipAnals;

  CollPatient.Clear;
  CollPregled.Clear;
  CollDoctor.Clear;
  CollUnfav.Clear;
  CollDiag.Clear;
  CollMDN.Clear;
  CollMedNapr.Clear;
  CollEventsManyTimes.Clear;
  CollMkb.Clear;
  CollExamAnal.Clear;
  CollProceduresNomen.Clear;
  CollCardProf.Clear;



  LoadThreadDB(FDbName);

end;

procedure TfrmSuperHip.ActiveControlChanged(Sender: TObject);
begin
  //Caption := ActiveControl.ClassType.ClassName;
  //Caption := ' смяна ' + FormatDateTime('hh:mm:ss', Now );
  EnumChildWindows(GetDesktopWindow, @EnumChildren, 0);
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
  TempItem := TRealExamAnalysisItem(CollExamAnal.Add);
  New(TempItem.PRecord);
  TempItem.PRecord.setProp := [];
  //FDBHelper.InsertAdbMdnField(TempItem);

  TempItem.InsertExamAnalysis;



  Dispose(TempItem.PRecord);
  TempItem.PRecord := nil;

  pCardinalData := pointer(AspectsHipFile.Buf);
  FPosMetaData := pCardinalData^;
  CollPregled.IncCntInADB;
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
  TempItem := TNomenNzisItem(NomenNzisColl.Add);
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
  i := ListNomenNzisNames.Add(nomenRec);
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
  TempItem := TRealMDNItem(CollMDN.Add);
  New(TempItem.PRecord);
  TempItem.PRecord.setProp := [];
  FDBHelper.InsertAdbMdnField(TempItem); // otdeleno

  TempItem.InsertMDN;

  //CollPregled.streamComm.Len := CollPregled.streamComm.Size;
  //streamCmdFile.CopyFrom(CollPregled.streamComm, 0);


  Dispose(TempItem.PRecord);
  TempItem.PRecord := nil;

  pCardinalData := pointer(AspectsHipFile.Buf);
  FPosMetaData := pCardinalData^;
  CollPregled.IncCntInADB;
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
  TempItem := TRealBLANKA_MED_NAPRItem(CollMedNapr.Add);
  New(TempItem.PRecord);
  TempItem.PRecord.setProp := [];
  FDBHelper.InsertAdbMnField(TempItem); // otdeleno

  TempItem.InsertBLANKA_MED_NAPR;

  Dispose(TempItem.PRecord);
  TempItem.PRecord := nil;

  pCardinalData := pointer(AspectsHipFile.Buf);
  FPosMetaData := pCardinalData^;
  CollPregled.IncCntInADB;
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
  vDiag: PVirtualNode;
  linkpos: Cardinal;
begin
  diag := TRealDiagnosisItem(CollDiag.Add);// добавяне на диагноза в колекцията
  New(diag.PRecord);
  diag.PRecord.setProp := [Diagnosis_code_CL011, Diagnosis_rank, Diagnosis_MkbPos];
  diag.PRecord.code_CL011 := cl011;
  diag.PRecord.rank := rank;
  diag.PRecord.MkbPos := DataPosMkb;
  if cl011Add <> '' then
  begin
    Include(diag.PRecord.setProp, Diagnosis_additionalCode_CL011);
    diag.PRecord.additionalCode_CL011 := cl011Add;
  end;

  diag.InsertDiagnosis;
  CollDiag.streamComm.Len := CollDiag.streamComm.Size;
  streamCmdFile.CopyFrom(CollDiag.streamComm, 0);
  Dispose(diag.PRecord);
  diag.PRecord := nil;

  AspectsLinkPatPregFile.AddNewNode(vvDiag, diag.DataPos, vPreg, amAddChildLast, vDiag, linkpos);
end;

procedure TfrmSuperHip.AddNewPlan(vPreg: PVirtualNode; var gr: TGraphPeriod132; var TreeLinkPlan: PVirtualNode);
var
  NZIS_PLANNED_TYPE: TRealNZIS_PLANNED_TYPEItem;
  pCardinalData: PCardinal;
  FPosMetaData, linkPos: Cardinal;
  planStatus: TPlanedStatusSet;
begin
  NZIS_PLANNED_TYPE := TRealNZIS_PLANNED_TYPEItem(CollNZIS_PLANNED_TYPE.Add);
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

  CollNZIS_PLANNED_TYPE.streamComm.Len := CollNZIS_PLANNED_TYPE.streamComm.Size;
  streamCmdFile.CopyFrom(CollNZIS_PLANNED_TYPE.streamComm, 0);
  Dispose(NZIS_PLANNED_TYPE.PRecord);
  NZIS_PLANNED_TYPE.PRecord := nil;

  pCardinalData := pointer(AspectsHipFile.Buf);
  FPosMetaData := pCardinalData^;
  CollNZIS_PLANNED_TYPE.IncCntInADB;
  AspectsLinkPatPregFile.AddNewNode(vvNZIS_PLANNED_TYPE, NZIS_PLANNED_TYPE.DataPos, vPreg, amAddChildLast, TreeLinkPlan, linkpos);

  TreeLinkPlan.CheckType := ctCheckBox;
  TreeLinkPlan.CheckState := csCheckedNormal;
  planStatus := [TPlanedStatus.psNew];
  TreeLinkPlan.Dummy := Byte(planStatus);// току що създаден план. Не е проверяван и не е показван
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
  mmoTest.Lines.Add(CollPatient.getAnsiStringMap(dataPa.DataPos, Word(PatientNZOK_EGN)));
  //създаване на прегледа с добавяне в колекцията
  TempItem := TRealPregledNewItem(CollPregled.Add);
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
    Caption := 'd';
  end;
  New(TempItem.PRecord);
  TempItem.PRecord.setProp := [];
  FDBHelper.InsertAdbPregledField(TempItem); // otdeleno

  TempItem.InsertPregledNew;

  CollPregled.streamComm.Len := CollPregled.streamComm.Size;
  streamCmdFile.CopyFrom(CollPregled.streamComm, 0);


  Dispose(TempItem.PRecord);
  TempItem.PRecord := nil;

  pCardinalData := pointer(AspectsHipFile.Buf);
  FPosMetaData := pCardinalData^;
  CollPregled.IncCntInADB;
  Elapsed := Stopwatch.Elapsed;
  /////////////////////////////////////////////
  vtrPregledPat.BeginUpdate;
  AspectsLinkPatPregFile.AddNewNode(vvPregled, TempItem.DataPos, nodePat, amAddChildFirst, TreeLink, linkpos);
  vPreg := TreeLink;

  // zzzzzzzzzzzzzzzzzzzzzzzzzzzzz AutoNzis  тука слагам 2-рия доктор замества 1-вия
  AspectsLinkPatPregFile.AddNewNode(vvPerformer, CollDoctor.Items[0].DataPos, vPreg, amAddChildLast, vPerf, linkpos);
  AspectsLinkPatPregFile.AddNewNode(vvDeput, CollDoctor.Items[1].DataPos, vPerf, amAddChildLast, vDeput, linkpos);
  mkb_s := '';
  ListPregledLinkForInsert.Add(vPreg);
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
          if CollNZIS_PLANNED_TYPE.getAnsiStringMap(Plan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY)) = Cl132Key then
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
          NZIS_QUESTIONNAIRE_RESPONSE := TRealNZIS_QUESTIONNAIRE_RESPONSEItem(CollNZIS_QUESTIONNAIRE_RESPONSE.Add);
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

          CollNZIS_QUESTIONNAIRE_RESPONSE.streamComm.Len := CollNZIS_QUESTIONNAIRE_RESPONSE.streamComm.Size;
          streamCmdFile.CopyFrom(CollNZIS_QUESTIONNAIRE_RESPONSE.streamComm, 0);
          Dispose(NZIS_QUESTIONNAIRE_RESPONSE.PRecord);
          NZIS_QUESTIONNAIRE_RESPONSE.PRecord := nil;

          pCardinalData := pointer(AspectsHipFile.Buf);
          FPosMetaData := pCardinalData^;
          CollNZIS_QUESTIONNAIRE_RESPONSE.IncCntInADB;
          AspectsLinkPatPregFile.AddNewNode(vvNZIS_QUESTIONNAIRE_RESPONSE, NZIS_QUESTIONNAIRE_RESPONSE.DataPos, vCl132, amAddChildLast, TreeLink, linkpos);
          if True then
          begin

          end;

        end
        else
        if pr001.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(PR001_Nomenclature)) = 'CL022'  then
        begin
          ArrPR001ActivityID := string(PR001Coll.getAnsiStringMap(pr001.DataPos, Word(PR001_Activity_ID))).Split([';']);
          for k := 0 to Length(ArrPR001ActivityID) - 1 do
          begin
            PR001ActivityID := ArrPR001ActivityID[k];
            cl22Pos := CL022Coll.GetDataPosFromKey(PR001ActivityID);

            examAnal := TRealExamAnalysisItem(CollExamAnal.Add);
            New(examAnal.PRecord);
            examAnal.PRecord.setProp :=
               [ExamAnalysis_ANALYSIS_ID,
                ExamAnalysis_ID,
                ExamAnalysis_NZIS_CODE_CL22,
                ExamAnalysis_PosDataNomen
                ];
            examAnal.PRecord.ANALYSIS_ID := 0;
            examAnal.PRecord.ID := 0;
            examAnal.PRecord.NZIS_CODE_CL22 := CL022Coll.getAnsiStringMap(cl22Pos, word(CL022_nhif_code));
            examAnal.PRecord.PosDataNomen := cl22Pos;


            examAnal.InsertExamAnalysis;

            CollExamAnal.streamComm.Len := CollExamAnal.streamComm.Size;
            streamCmdFile.CopyFrom(CollExamAnal.streamComm, 0);
            Dispose(examAnal.PRecord);
            examAnal.PRecord := nil;

            pCardinalData := pointer(AspectsHipFile.Buf);
            FPosMetaData := pCardinalData^;
            CollExamAnal.IncCntInADB;
            AspectsLinkPatPregFile.AddNewNode(vvExamAnal, examAnal.DataPos, vCl132, amAddChildLast, TreeLink, linkpos);
          end;

        end
        else
        if pr001.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(PR001_Nomenclature)) = 'CL014'  then
        begin
          if  pr001.getAnsiStringMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(PR001_Activity_ID)) = 'R2' then
          begin
            MedNapr := TRealBLANKA_MED_NAPRItem(CollMedNapr.Add);
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
            NZIS_DIAGNOSTIC_REPORT := TRealNZIS_DIAGNOSTIC_REPORTItem(CollNZIS_DIAGNOSTIC_REPORT.Add);
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

            CollNZIS_DIAGNOSTIC_REPORT.streamComm.Len := CollNZIS_DIAGNOSTIC_REPORT.streamComm.Size;
            streamCmdFile.CopyFrom(CollNZIS_DIAGNOSTIC_REPORT.streamComm, 0);
            Dispose(NZIS_DIAGNOSTIC_REPORT.PRecord);
            NZIS_DIAGNOSTIC_REPORT.PRecord := nil;

            pCardinalData := pointer(AspectsHipFile.Buf);
            FPosMetaData := pCardinalData^;
            CollNZIS_DIAGNOSTIC_REPORT.IncCntInADB;
            AspectsLinkPatPregFile.AddNewNode(vvNZIS_DIAGNOSTIC_REPORT, NZIS_DIAGNOSTIC_REPORT.DataPos, vCl132, amAddChildLast, TreeLink, linkpos);
          end;
        end;
        vPr001 := TreeLink;
        if pr001.CL142 <> nil  then
        begin
          Rule88 := pr001.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(PR001_Notes));

          if pr001.CL142.FListCL144.Count > 1 then // дейности
          begin
            for k := 0 to pr001.CL142.FListCL144.Count - 1 do
            begin
              Cl144 := pr001.CL142.FListCL144[k];
              if Trim(Rule88) <> '' then
              begin
                ACL144_key := Cl144.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL144_Key));
                if Pos(ACL144_key, Rule88) = 0 then Continue;
              end;
              /////////AspectsLinkPatPregFile.AddNewNode(vvCL144, Cl144.DataPos, vPr001, amAddChildLast, TreeLink, linkpos);
              //NZIS_RESULT_DIAGNOSTIC_REPORT
              NZIS_RESULT_DIAGNOSTIC_REPORT := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(CollNZIS_RESULT_DIAGNOSTIC_REPORT.Add);
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
              NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.CL144_CODE := Cl144.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL144_Key));
              NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.CL028_VALUE_SCALE := StrToInt(Cl144.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL144_cl028)));
              NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.NOMEN_POS := Cl144.DataPos;

              NZIS_RESULT_DIAGNOSTIC_REPORT.InsertNZIS_RESULT_DIAGNOSTIC_REPORT;

              CollNZIS_RESULT_DIAGNOSTIC_REPORT.streamComm.Len := CollNZIS_RESULT_DIAGNOSTIC_REPORT.streamComm.Size;
              streamCmdFile.CopyFrom(CollNZIS_RESULT_DIAGNOSTIC_REPORT.streamComm, 0);
              Dispose(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord);
              NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord := nil;

              pCardinalData := pointer(AspectsHipFile.Buf);
              FPosMetaData := pCardinalData^;
              CollNZIS_RESULT_DIAGNOSTIC_REPORT.IncCntInADB;
              AspectsLinkPatPregFile.AddNewNode(vvNZIS_RESULT_DIAGNOSTIC_REPORT, NZIS_RESULT_DIAGNOSTIC_REPORT.DataPos, vPr001, amAddChildLast, TreeLink, linkpos);
            end;
          end;
        end;

        for k := 0 to gr.Cl132.FListPr001[j].LstCl134.Count - 1 do  // отговори
        begin
          cl134 := gr.Cl132.FListPr001[j].LstCl134[k];
          note := cl134.getAnsiStringMap(AspectsNomFile.buf, CL132Coll.posData, word(CL134_Note));
          Field_cl133 := cl134.getAnsiStringMap(AspectsNomFile.buf, CL132Coll.posData, word(CL134_CL133));
          cl028Key := cl134.getAnsiStringMap(AspectsNomFile.buf, CL132Coll.posData, word(CL134_CL028));
          if (note <> '') and (Field_cl133[1] in ['5', '6']) then
          begin
            test := gr.Cl132.getAnsiStringMap(AspectsNomFile.buf, CL132Coll.posData, word(CL132_Key)) +
                     cl134.getAnsiStringMap(AspectsNomFile.buf, CL132Coll.posData, word(CL134_Note));
          end
          else
          begin
            test := '';
          end;

          begin
            NZIS_QUESTIONNAIRE_ANSWER := TRealNZIS_QUESTIONNAIRE_ANSWERItem(CollNZIS_QUESTIONNAIRE_ANSWER.Add);
            New(NZIS_QUESTIONNAIRE_ANSWER.PRecord);
            NZIS_QUESTIONNAIRE_ANSWER.PRecord.setProp :=
               [NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE,
                NZIS_QUESTIONNAIRE_ANSWER_ID,
                NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID,
                NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS];
            NZIS_QUESTIONNAIRE_ANSWER.PRecord.ID := 0;
            NZIS_QUESTIONNAIRE_ANSWER.PRecord.QUESTIONNAIRE_RESPONSE_ID := 0;
            NZIS_QUESTIONNAIRE_ANSWER.PRecord.CL134_QUESTION_CODE := cl134.getAnsiStringMap(AspectsNomFile.buf, CL132Coll.posData, word(CL134_Key));;
            NZIS_QUESTIONNAIRE_ANSWER.PRecord.NOMEN_POS := cl134.DataPos;
               //pr001.getWordMap(AspectsNomFile.Buf, AspectsNomFile.FPosData, Word(PR001_Activity_ID));

            NZIS_QUESTIONNAIRE_ANSWER.InsertNZIS_QUESTIONNAIRE_ANSWER;

            CollNZIS_QUESTIONNAIRE_ANSWER.streamComm.Len := CollNZIS_QUESTIONNAIRE_ANSWER.streamComm.Size;
            streamCmdFile.CopyFrom(CollNZIS_QUESTIONNAIRE_ANSWER.streamComm, 0);
            Dispose(NZIS_QUESTIONNAIRE_ANSWER.PRecord);
            NZIS_QUESTIONNAIRE_ANSWER.PRecord := nil;

            pCardinalData := pointer(AspectsHipFile.Buf);
            FPosMetaData := pCardinalData^;
            CollNZIS_QUESTIONNAIRE_ANSWER.IncCntInADB;
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
    CollPregled.SetWordMap(data.DataPos, word(PregledNew_NZIS_STATUS),3);
    TempItem.FNode := vpreg;
    OnOpenPregled1(TempItem);
  end;
  TempItem.FNode := vpreg;
  if chkAutamatL009.Checked then
  begin
    OnGetPlanedTypeL009_1(TempItem);
  end;
end;

procedure TfrmSuperHip.AddNewPregledOld;
var
  p: PInt;
  TempItem: TRealPregledNewItem;
  i, j, k: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;

  TreeLink, Run, nodePat: PVirtualNode;
  vPreg, vCl132, vPr001, vCL088: PVirtualNode;
  linkpos: Cardinal;
  data: PAspRec;
  gr: TGraphPeriod132;
  Rule88, ACL088_key, Cl132Key, note, Field_cl133, test: string;
  pr001: TRealPR001Item;
  Cl088: TRealCl088Item;
  cl134: TRealCl134Item;
begin
  // намиране на пациента, на който ще се прави новия преглед;
  nodePat := PVirtualNode(vtrMinaliPregledi.Tag);
  //създаване на прегледа с добавяне в колекцията
  TempItem := TRealPregledNewItem(CollPregled.Add);
  TempItem.Fpatient := FmxProfForm.Patient;
  gr := TempItem.Fpatient.lstGraph[TempItem.Fpatient.CurrentGraphIndex];
  TempItem.StartDate := Floor(gr.endDate);// Тука трябва да е последния ден от срока за профилактиката
  New(TempItem.PRecord);
  TempItem.PRecord.setProp := [];
  //CollPregled.streamComm :=
  FDBHelper.InsertAdbPregledField(TempItem); // otdeleno

  TempItem.InsertPregledNew;

  CollPregled.streamComm.Len := CollPregled.streamComm.Size;
  streamCmdFile.CopyFrom(CollPregled.streamComm, 0);


  Dispose(TempItem.PRecord);
  TempItem.PRecord := nil;

  pCardinalData := pointer(AspectsHipFile.Buf);
  FPosMetaData := pCardinalData^;
  CollPregled.IncCntInADB;
  Elapsed := Stopwatch.Elapsed;
  /////////////////////////////////////////////
  vtrPregledPat.BeginUpdate;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  linkpos := pCardinalData^;

  TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
  data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
  data.index := -1;
  data.vid := vvPregled;
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
  vtrPregledPat.InternalConnectNode_cmd(TreeLink, nodePat,
                    vtrPregledPat, amAddChildLast);
  vPreg := TreeLink;
  ListPregledLinkForInsert.Add(vPreg);
  for i := 0 to TempItem.Fpatient.ListCurrentProf.Count - 1 do
  begin
    gr := TempItem.Fpatient.ListCurrentProf[i];
    begin
      TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
      data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
      data.index := -1;
      data.vid := vvCl132;
      data.DataPos := gr.Cl132.DataPos;
      TreeLink.Index := 0;
      inc(linkpos, LenData);

      TreeLink.TotalCount := 1;
      TreeLink.TotalHeight := 27;
      TreeLink.NodeHeight := 27;
      TreeLink.States := [vsVisible];
      TreeLink.Align := 50;
      TreeLink.Dummy := 223;

      vtrPregledPat.InitNode(TreeLink);
      vtrPregledPat.InternalConnectNode_cmd(TreeLink, vPreg,
                        vtrPregledPat, amAddChildLast);
      vCl132 := TreeLink;
      for j := 0 to gr.Cl132.FListPr001.Count - 1 do
      begin
        //vPr001 := vtrGraph.AddChild(vCl132, nil);
        pr001 := gr.Cl132.FListPr001[j];
        TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
        data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
        data.index := -1;
        data.vid := vvPr001;
        data.DataPos := pr001.DataPos;
        TreeLink.Index := 0;
        inc(linkpos, LenData);

        TreeLink.TotalCount := 1;
        TreeLink.TotalHeight := 27;
        TreeLink.NodeHeight := 27;
        TreeLink.States := [vsVisible];
        TreeLink.Align := 50;
        TreeLink.Dummy := 224;
        vtrPregledPat.InitNode(TreeLink);
        vtrPregledPat.InternalConnectNode_cmd(TreeLink, vCl132,
                        vtrPregledPat, amAddChildLast);

        vPr001 := TreeLink;
        if pr001.CL142 <> nil  then
        begin
          Rule88 := pr001.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(PR001_Rules));

          if pr001.CL142.FListCL088.Count > 1 then
          begin
            for k := 0 to pr001.CL142.FListCL088.Count - 1 do
            begin
              Cl088 := pr001.CL142.FListCL088[k];
              if Trim(Rule88) <> '' then
              begin
                ACL088_key := cl088.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL088_key));
                if Pos(ACL088_key, Rule88) = 0 then Continue;
              end;

              TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
              data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
              data.index := -1;
              data.vid := vvCL088;
              data.DataPos := Cl088.DataPos;
              TreeLink.Index := 0;
              inc(linkpos, LenData);

              TreeLink.TotalCount := 1;
              TreeLink.TotalHeight := 27;
              TreeLink.NodeHeight := 27;
              TreeLink.States := [vsVisible];
              TreeLink.Align := 50;
              TreeLink.Dummy := 225;
              vtrPregledPat.InitNode(TreeLink);
              vtrPregledPat.InternalConnectNode_cmd(TreeLink, vPr001,
                              vtrPregledPat, amAddChildLast);
            end;
          end;
        end;

        for k := 0 to gr.Cl132.FListPr001[j].LstCl134.Count - 1 do
        begin
          cl134 := gr.Cl132.FListPr001[j].LstCl134[k];
          note := cl134.getAnsiStringMap(AspectsNomFile.buf, CL132Coll.posData, word(CL134_Note));
          Field_cl133 := cl134.getAnsiStringMap(AspectsNomFile.buf, CL132Coll.posData, word(CL134_CL133));
          if (note <> '') and (Field_cl133[1] in ['5', '6']) then
          begin
            test := gr.Cl132.getAnsiStringMap(AspectsNomFile.buf, CL132Coll.posData, word(CL132_Key)) +
                     cl134.getAnsiStringMap(AspectsNomFile.buf, CL132Coll.posData, word(CL134_Note));
          end
          else
          begin
            test := '';
          end;

          begin
            TreeLink := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
            data := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos + lenNode);
            data.index := -1;
            data.vid := vvCl134;
            data.DataPos := cl134.DataPos;
            TreeLink.Index := 0;
            inc(linkpos, LenData);

            TreeLink.TotalCount := 1;
            TreeLink.TotalHeight := 27;
            TreeLink.NodeHeight := 27;
            TreeLink.States := [vsVisible];
            TreeLink.Align := 50;
            TreeLink.Dummy := 226;
            vtrPregledPat.InitNode(TreeLink);
            vtrPregledPat.InternalConnectNode_cmd(TreeLink, vPr001,
                            vtrPregledPat, amAddChildLast);
          end;
        end;
      end;
    end;

  end;


  vtrPregledPat.EndUpdate;
  vtrPregledPat.Selected[vpreg] := True;
  vtrPregledPat.FocusedNode := vpreg;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  pCardinalData^ := linkpos;
end;

procedure TfrmSuperHip.AddToListNodes(data: PAspRec);
begin
  Exit;
  case data.vid of
    vvPregled: CollPregled.ListNodes.Add(data);
    vvPatient: CollPatient.ListNodes.Add(data);
    vvDoctor: CollDoctor.ListNodes.Add(data);
    vvMDN: CollMDN.ListNodes.Add(data);
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

  pCardinalData := pointer(AspectsHipFile.Buf);
  FPosMetaData := pCardinalData^;
  CollPregled.IncCntInADB;
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
  ListPregledLinkForInsert.Add(vpreg);

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
      end
      else
      begin
        SendMessage(syndtNzisReq.handle, WM_VSCROLL, 0, 0);
        SendMessage(syndtNzisReq.handle, WM_VSCROLL, 8, 0);
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
    SendMessage(Handle, WM_SYSCOMMAND, SC_CONTEXTHELP, 0);
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
  ReleaseCapture;
  SendMessage(self.Handle, WM_SYSCOMMAND, 61458, 0) ;
  //SetCapture( syndtNzisReq.Handle );
  //syndtNzisReq.MouseCapture:= true;  // WinApi: SetCapture( Handle )
end;

procedure TfrmSuperHip.syndtNzisReqMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
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
  thrCert.CollDoctor := CollDoctor;
  thrCert.CollCert := CollCertificates;
  thrCert.FreeOnTerminate := True;
  thrCert.OnStorageUpdate := CertStorageUpdate;
  thrCert.Resume;
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
  if FmxFinderFrm = nil then
  begin
    FmxFinderFrm := TfrmFinder.Create(nil);
    CollPatient.AddItemForSearch;
    CollPregled.AddItemForSearch;
    FmxFinderFrm.CollPatient := CollPatient;
    FmxFinderFrm.CollPregled := CollPregled;

    FmxFinderFrm.ArrCondition := CollPregled.ListForFDB.Items[0].ArrCondition;
    FmxFinderFrm.AddExpanderPat1(0, nil);
    FmxFinderFrm.AddExpanderPreg(0, nil);
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
    thrSearch.CollForFind := CollPregled;
    thrSearch.CollPat := CollPatient;
    thrSearch.collPreg := CollPregled;
    thrSearch.CollExamImun := CollExamImun;
    //thrSearch.collPregForSearch := CollPregForSearch;

    thrSearch.vtr := vtrPregledPat;
    thrSearch.bufLink := AspectsLinkPatPregFile.Buf;
    thrSearch.BufADB := AspectsHipFile;
    pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
    FPosLinkData := pCardinalData^;
    thrSearch.FPosData := FPosLinkData;
    thrSearch.BufADB := AspectsHipFile.Buf;


    thrSearch.grdSearch := grdSearch;
    thrSearch.OnShowGrid := OnShowGridSearch;
    grdSearch.Tag := word(vvPregled);

    thrSearch.CntPregInPat := -1;
    thrSearch.Resume;
    thrSearch.Start;

  end
  else
  begin
    thrSearch.Start;
  end;
  FmxFinderFrm.IsFinding := True;
  //btnPull.Top := pnlGridSearch.Top - 7 - btnPull.Height;
  if pnlGridSearch.height = 1 then
    pnlGridSearch.height := 150;
 //pgcWork.ActivePage := tsFMXForm;


end;

procedure TfrmSuperHip.StartHistoryThread(dbName: string);
//var

begin
  //Exit;
  thrHistPerf := THistoryThread.Create(True, FdbName);
  thrHistPerf.FreeOnTerminate := True;
  thrHistPerf.Buf := AspectsHipFile.Buf;
  thrHistPerf.BufLink := AspectsLinkPatPregFile.Buf;
  thrHistPerf.DataPos := AspectsHipFile.FPosData;
  thrHistPerf.FCollUnfav := CollUnfav;
  thrHistPerf.FCollPregled := CollPregled;
  thrHistPerf.FCollPatient := CollPatient;
  thrHistPerf.FCollDiag := CollDiag;
  thrHistPerf.GUID := AspectsHipFile.GUID;
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
  for i := ListPregledLinkForInsert.Count - 1 downto 0 do
  begin
    Run := ListPregledLinkForInsert[i]; //прегледа
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
    preg := CollPregled.GetItemsFromDataPos(dataPreg.DataPos);// трябва да е тука някъде;
    if preg = nil then //  може да е останал не записан стар
    begin
     // preg := TRealPregledNewItem.Create(nil);
      preg := TRealPregledNewItem(CollPregled.Add);
      preg.DataPos := dataPreg.DataPos;
      dataPreg.index := CollPregled.Count - 1;
    end;
    preg.PregledID := preg.getIntMap(AspectsHipFile.Buf, CollPatient.posData, word(PregledNew_ID));
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
                cl22Code := Anal.getAnsiStringMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, word(ExamAnalysis_NZIS_CODE_CL22));
                PosInNomen := Anal.getCardMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, word(ExamAnalysis_PosDataNomen));
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
      ListPregledLinkForInsert.Delete(i);
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
  CollDoctor.UpdateDoctors;
  CL132Coll.UpdateCL132;
  CollNZIS_ANSWER_VALUE.UpdateNZIS_ANSWER_VALUEs;
  CollNzis_RESULT_DIAGNOSTIC_REPORT.UpdateRESULT_DIAGNOSTIC_REPORT;

  cnt := 0;
  pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
  dataPosition := pCardinalData^ + self.AspectsHipFile.FPosData;
  //cert
  for i := 0 to CollCertificates.Count - 1 do
  begin
    cert := CollCertificates.Items[i];
    if cert.PRecord <> nil then
    begin
      cert.SaveCertificates(dataPosition);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
    pCardinalData^  := dataPosition - self.AspectsHipFile.FPosData;
  end;

  cnt := 0;
  pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
  dataPosition := pCardinalData^ + self.AspectsHipFile.FPosData;
  //мдн
  for i := 0 to CollMDN.Count - 1 do
  begin
    mdn := CollMDN.Items[i];
    if mdn.PRecord <> nil then
    begin
      mdn.SaveMDN(dataPosition);
      inc(cnt);
    end;
  end;
  if cnt > 0 then
  begin
    pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
    pCardinalData^  := dataPosition - self.AspectsHipFile.FPosData;
  end;

  pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
  dataPosition := pCardinalData^ + self.AspectsHipFile.FPosData;
  //Изследвания
  for i := 0 to CollExamAnal.Count - 1 do
  begin
    anal := CollExamAnal.Items[i];
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
    pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
    pCardinalData^  := dataPosition - self.AspectsHipFile.FPosData;
  end;

  pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
  dataPosition := pCardinalData^ + self.AspectsHipFile.FPosData;

  //пациенти
  for i := 0 to CollPatient.Count - 1 do
  begin
    pat := CollPatient.Items[i];
    if pat.PRecord <> nil then
    begin
      if pat.DataPos > 0 then
      begin
        pat.SavePatientNew(dataPosition);
        for j := 0 to pat.Revisions.Count - 1 do
        begin
          p := pointer(PByte(CollPatient.buf) + (pat.DataPos  + 4*word(PatientNew_FNAME)));
          ofset := p^ + CollPatient.posData;
          dataPatRevision := Pointer(PByte(pat.Revisions[j].node) + lenNode);
          dataPatRevision.index := ofset;
        end;
        pat.Revisions.Clear;
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
    pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
    pCardinalData^  := dataPosition - self.AspectsHipFile.FPosData;
  end;

  btnSaveAll.Enabled := False;
end;

procedure TfrmSuperHip.StatePatLogChange(Sender: TObject);
var
  pat: TPatientNewItem;
begin
  Stopwatch := TStopwatch.StartNew;
  pat := CollPatient.ListForFinder[0];
  //if (not chk.IsNull) and (chk.IsChecked) then
//  begin
//    Include(pat.PRecord.Logical, TLogicalPatientNew(chk.IndexLog));
//  end
//  else
//  begin
//    Exclude(pat.PRecord.Logical, TLogicalPatientNew(chk.IndexLog));
//  end;
  Caption := pat.Logical32ToStr(TLogicalData32(pat.PRecord.Logical));
  if pat.PRecord.Logical <> [] then
  begin
    include(CollPatient.PRecordSearch.setProp, TPatientNewItem.TPropertyIndex.PatientNew_Logical);
  end
  else
  begin
    Exclude(CollPatient.PRecordSearch.setProp, TPatientNewItem.TPropertyIndex.PatientNew_Logical);
  end;
  CollPatient.OnSetTextSearchLog(pat.PRecord.Logical);
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
  mn.Collection := CollMedNapr;
  pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
  dataPosition := pCardinalData^ + self.AspectsHipFile.FPosData;
  New(mn.PRecord);
  mn.PRecord.setProp := [BLANKA_MED_NAPR_SpecDataPos];
  mn.PRecord.SpecDataPos := 444;
  mn.SaveBLANKA_MED_NAPR(dataPosition);
  pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
  pCardinalData^  := dataPosition - self.AspectsHipFile.FPosData;
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
  splSearchGridMoved(nil);
  fmxCntrDyn.Repaint;
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
  for i := 0 to CollDoctor.Count - 1 do
  begin
    doc := CollDoctor.Items[i];
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

        CollUnfav.DeleteAUnfav(doc.DoctorID, mnt, yr);
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

        CollUnfav.InsertAUnfav(doc.DoctorID, mnt, yr);
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

procedure TfrmSuperHip.vtrSearchChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  data: PAspRec;
begin
  if Node = nil then  Exit;

  data := vtrSearch.GetNodeData(node);
  case data.vid of
    vvPatient:
    begin
      FmxFinderFrm.ArrCondition := CollPatient.ListForFinder.Items[0].ArrCondition;
      FmxFinderFrm.AddExpanderPat1(0, nil);

    end;
    vvPregled:
    begin
      FmxFinderFrm.ArrCondition := CollPregled.ListForFDB.Items[0].ArrCondition;
      FmxFinderFrm.AddExpanderPreg(0, nil);

    end;
  end;

end;

procedure TfrmSuperHip.vtrSearchGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  data: PAspRec;
begin
  data := vtrSearch.GetNodeData(node);
  case data.vid of
    vvPatient:
    begin
      case Column of
        0: CellText := 'Пациент';
      end;
    end;
  end;
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
    vvPatientRoot:
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
            APat :=  ACollPatFDB.Items[DataParent.index];
            APreg :=  APat.FPregledi[data.index];
            CellText := 'Pregled patID' + IntToStr(APat.getIntMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_ID)));
          end
          else if DataParent.vid = vvCloning then
          begin
            dataPat := Sender.GetNodeData(node.Parent.parent);
            APat :=  ACollPatFDB.Items[dataPat.index];
            ACloning := APat.FClonings[DataParent.index];
            APreg :=  ACloning.FPregledi[data.index];
            CellText := 'Pregled clonID ' + IntToStr(ACloning.getIntMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_ID)));
          end;
        end;
        1:
        begin
         // APreg.DataPos := data.DataPos;
          if DataParent.vid = vvPatient then
          begin
            APat :=  ACollPatFDB.Items[DataParent.index];
            APreg :=  APat.FPregledi[data.index];
          end
          else if DataParent.vid = vvCloning then
          begin
            dataPat := Sender.GetNodeData(node.Parent.parent);
            APat :=  ACollPatFDB.Items[dataPat.index];
            ACloning := APat.FClonings[DataParent.index];
            APreg :=  ACloning.FPregledi[data.index];
          end;

          PregledDate := APreg.getDateMap(AspectsHipFile.Buf, CollPatient.posData, word(PregledNew_START_DATE));
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
              CellText := 'ЕГН ' + CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN));
            end;
            -2:
            begin
              if CollPatPis.Items[data.index].PatEGN <> '' then
              begin
                CellText := 'ЕГН ' + CollPatPis.Items[data.index].PatEGN;
              end
              else  if CollPatPis.Items[data.index].PRecord.LNC <> '' then
              begin
                CellText := 'ЛНЧ ' + CollPatPis.Items[data.index].PRecord.LNC;
              end
              else  if CollPatPis.Items[data.index].PRecord.SNN <> '' then
              begin
                CellText := 'SNN ' + CollPatPis.Items[data.index].PRecord.SNN;
              end;
            end;
            -3, -4, -5, -6:
            begin
              CellText := 'ЕГН ' + CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN));
            end;
          end;
        end;
        1:
        begin
          DataParent := Sender.GetNodeData(node.Parent);
          case DataParent.index of
            -5: //otpisani
            begin
              CellText := DateToStr(ACollPatFDB.Items[data.index].DATE_OTPISVANE);
            end;
            -6: //zapisani
            begin
              CellText := DateToStr(ACollPatFDB.Items[data.index].DATE_ZAPISVANE);
            end;
          end;
        end;
        2:
        begin
          DataParent := Sender.GetNodeData(node.Parent);
          APat := ACollPatFDB.Items[data.index];
          case DataParent.index of
            -5, -6, -1: //otpisani i zapisani
            begin
              if APat.FPregledi.Count > 0 then
              begin
                CellText := DateToStr(APat.LastPregled.getDateMap(AspectsHipFile.Buf, CollPatient.posData, word(PregledNew_START_DATE)));
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
  doctor := CollDoctor.Items[data.index];
  if Column > 1 then
  begin
    AColMonth := Column - 1;
    r := CellRect;
    r.Inflate(-8, -8);
    indexUnfav := (CollUnfav.CurrentYear - 2024) * 12 + AColMonth;
    if CollUnfav.CurrentYear = 2033 then
      CollUnfav.CurrentYear := 2033;
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
  doc1 := CollDoctor.items[data1.index];
  doc2 := CollDoctor.items[data2.index];
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
      doctor := CollDoctor.Items[data.index];
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
  doctor := CollDoctor.Items[data.index];
  if HitInfo.HitColumn > 1 then
  begin
    indexUnfav := (CollUnfav.CurrentYear - 2024) * 12 + HitInfo.HitColumn - 1;
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
  data := vtrTemp.GetNodeData(node);


  case data.vid of
    vvPatientRoot:
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

                  patNovozapisan := TRealPatientNewItem(ACollNovozapisani.Add);
                  patNovozapisan.DataPos := 0;
                  New(patNovozapisan.PRecord);
                  patNovozapisan.PRecord.setProp := [PatientNew_EGN];
                  patNovozapisan.PRecord.EGN := patPL.IDENTITY.PID;

                  nodeZapisan := vHipZapisani.FirstChild;
                  while nodeZapisan <> nil do
                  begin

                    dataZapisan := sender.GetNodeData(nodeZapisan);
                    PatientTemp.DataPos := dataZapisan.DataPos;
                    if CollPatient.getAnsiStringMap(dataZapisan.DataPos, word(PatientNew_EGN)) = patNovozapisan.PRecord.EGN then
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
  data: PAspRec;
begin
  if Node = nil then
    Node := vtrTemp.GetFirstSelected();
  if Node = nil then Exit;

  data := vtrTemp.GetNodeData(node);
  if Node.Parent = vNZOK then
  begin
    try
      if data.index >= 0 then
      begin
        grdNom.Selected.Change(grdNom.Columns[1], data.index);
      end
      else
      begin

      end;
    except

    end;
  end;
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
      Caption := CollMkb.getAnsiStringMap(data.DataPos, word(Mkb_CODE));
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
  data := vtrTemp.GetNodeData(node);
  case data.vid of
    vvMKB:
    begin
      if (csCheckedNormal = Node.CheckState) then
      begin
        Caption := CollMkb.getAnsiStringMap(data.DataPos, word(Mkb_CODE));
        AddNewDiag(FmxProfForm.Pregled.FNode, Caption, '', FmxProfForm.Pregled.FDiagnosis.Count, Data.DataPos);
        dataPat := Pointer(PByte(FmxProfForm.Pregled.FNode.Parent) + lenNode);
        dataPreg := Pointer(PByte(FmxProfForm.Pregled.FNode) + lenNode);
        tempViewportPosition := FmxProfForm.scrlbx1.ViewportPosition;
        ShowPregledFMX(dataPat, dataPreg, FmxProfForm.Pregled.FNode);
        FmxProfForm.scrlbx1.ViewportPosition := tempViewportPosition;
        data.index := FmxProfForm.Pregled.FDiagnosis[FmxProfForm.Pregled.FDiagnosis.Count - 1].DataPos;
      end
      else
      begin
        Caption := CollMkb.getAnsiStringMap(data.DataPos, word(Mkb_CODE));
        FmxProfForm.Pregled.CanDeleteDiag := False;
        for i := 0 to FmxProfForm.Pregled.FDiagnosis.Count - 1 do
        begin
          if FmxProfForm.Pregled.FDiagnosis[i].MkbNode = node then
          begin
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
  if (GetKeyState(VK_CONTROL) >= 0) then Exit;
  dataAction := Sender.GetNodeData(node);
  vtrTemp.OnCollapsed := nil;
  vtrTemp.OnMeasureItem := nil;
  Sender.BeginUpdate;
  vtrTemp.IterateSubtree(vNomenMKB, IterateTempcollapsed, dataAction);
  Sender.EndUpdate;
  vtrTemp.OnCollapsed := vtrTempCollapsed;
  vtrTemp.OnMeasureItem := vtrTempMeasureItem;
end;

procedure TfrmSuperHip.vtrTempColumnClick(Sender: TBaseVirtualTree;
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

procedure TfrmSuperHip.vtrTempDrawButton(sender: TVirtualStringTreeHipp; node: PVirtualNode; var ButonVisible: Boolean; const numButton: Integer;
  var imageIndex: Integer);
var
  data: PAspRec;
begin
  data := vtrTemp.GetNodeData(node);
  case data.vid of
    vvPatientRoot:
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
  r: TRect;
begin
  r := CellRect;
  Winapi.Windows.DrawTextW(TargetCanvas.Handle, PWideChar(Text), Length(Text), r, 43024);
  DefaultDraw := False;
end;

procedure TfrmSuperHip.vtrTempExpanded(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  data, dataAction: PAspRec;
  RunNode: PVirtualNode;
begin
  if (GetKeyState(VK_CONTROL) >= 0) then Exit;
  dataAction := Sender.GetNodeData(node);
  //if dataAction.vid = vvPatientRoot then  Exit;

  vtrTemp.OnExpanded := nil;
  vtrTemp.OnMeasureItem := nil;
  Sender.BeginUpdate;
  vtrTemp.IterateSubtree(vNomenMKB, IterateTempExpand, dataAction);
  Sender.EndUpdate;
  vtrTemp.OnExpanded := vtrTempExpanded;
  vtrTemp.OnMeasureItem := vtrTempMeasureItem;
end;

procedure TfrmSuperHip.vtrTempGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex;
  var ImageList: TCustomImageList);
begin
  if Kind <> TVTImageKind.ikState then
    Exit;
  ImageIndex := 78;
end;

procedure TfrmSuperHip.vtrTempInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  Node.States := node.States + [vsMultiline];
end;

procedure TfrmSuperHip.vtrTempLoadNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Stream: TStream);
var
  data: PAspRec;
begin
  data := Sender.GetNodeData(node);
  Stream.read(data^, sizeof(TAspRec));
end;

procedure TfrmSuperHip.vtrTempMeasureItem(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
var
  h0, h1: integer;
begin
  inherited;
  //Exit;
  if Sender.MultiLine[Node] then
  begin
    TargetCanvas.Font := Sender.Font;
    h0 := vtrTemp.ComputeNodeHeight(TargetCanvas, Node, 0);
    h1 := vtrTemp.ComputeNodeHeight(TargetCanvas, Node, 1);
    NodeHeight := System.Math.Max(h0, h1) + 10;
  end;
end;

procedure TfrmSuperHip.vtrTempMeasureTextWidth(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const Text: string; var Extent: Integer);
begin
  //
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
          if CollDoctor.Items[0].Cert <> nil then
          begin
            edtCertNom.Text := BuildHexString(CollDoctor.Items[0].Cert.SerialNumber);
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
  buf := AspectsHipFile.Buf;
  posdata := AspectsHipFile.FPosData;
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
      doc := CollDoctor.Items[data.index];
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
      Collebl.FillListNodes(AspectsLinkPatPregFile, vvEbl);
      CollEbl.ShowListNodesGrid(grdNom);
      //grdNom.Tag := Integer(@CollEbl);
    end;
    EXAM_ANALYSIS:
    begin
      InternalChangeWorkPage(tsGrid);
      CollExamAnal.FillListNodes(AspectsLinkPatPregFile, vvExamAnal);
      CollExamAnal.ShowListNodesGrid(grdNom);
    end;
    EXAM_IMMUNIZATION:
    begin
      InternalChangeWorkPage(tsGrid);
      CollExamImun.FillListNodes(AspectsLinkPatPregFile, vvExamImun);
      CollExamImun.ShowListNodesGrid(grdNom);
    end;
    KARTA_PROFILAKTIKA2017:
    begin
      InternalChangeWorkPage(tsGrid);
      CollCardProf.FillListNodes(AspectsLinkPatPregFile, vvProfCard);
      CollCardProf.ShowListNodesGrid(grdNom);
    end;

    BLANKA_MDN:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      CollMDN.FillListNodes(AspectsLinkPatPregFile, vvMDN);
      CollMDN.ShowListNodesGrid(grdNom);
    end;
    DOCTOR:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      CollDoctor.ShowGrid(grdNom);
    end;
    nzistoken:
    begin
      InternalChangeWorkPage(tsGrid);
      CollNzisToken.ShowGrid(grdNom);
    end;
    CERTIFICATES:
    begin
      InternalChangeWorkPage(tsGrid);
      CollCertificates.ShowGrid(grdNom);
    end;
    ICD10CM:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      CollMkb.FillListNodes(AspectsLinkPatPregFile, vvMKB);
      CollMkb.ShowGrid(grdNom);
    end;
    PACIENT:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      CollPatient.FillListNodes(AspectsLinkPatPregFile, vvPatient);
      CollPatient.ShowListNodesGrid(grdNom);
    end;
    PREGLED:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      CollPregled.FillListNodes(AspectsLinkPatPregFile, vvPregled);
      CollPregled.ShowListNodesGrid(grdNom);
    end;
    PRACTICA:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      CollPractica.ShowGrid(grdNom);
    end;
    UNFAV:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      CollUnfav.ShowGrid(grdNom);
      if CollUnfav.Count > 0 then
      begin
        thrHistPerf.Ticker :=TGridTicker.Create(grdNom.Grid.Current);
      end;
    end;
    Asp_Diag:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      CollDiag.FillListNodes(AspectsLinkPatPregFile, vvDiag);
      CollDiag.ShowListNodesGrid(grdNom);
    end;
    Asp_PL_NZOK:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      CollPatPis.ShowGrid(grdNom);
    end;
    Asp_EventManyTimes:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      CollEventsManyTimes.FillListNodes(AspectsLinkPatPregFile, vvEvnt);
      CollEventsManyTimes.ShowListNodesGrid(grdNom);
    end;
    BLANKA_MED_NAPR:
    begin
      InternalChangeWorkPage(tsGrid);
      CollMedNapr.FillListNodes(AspectsLinkPatPregFile, vvMedNapr);
      CollMedNapr.ShowListNodesGrid(grdNom);
    end;
    NZIS_PLANNED_TYPE:
    begin
      InternalChangeWorkPage(tsGrid);
      CollNZIS_PLANNED_TYPE.FillListNodes(AspectsLinkPatPregFile, vvNZIS_PLANNED_TYPE);
      CollNZIS_PLANNED_TYPE.ShowListNodesGrid(grdNom);
    end;
    NZIS_QUESTIONNAIRE_RESPONSE:
    begin
      InternalChangeWorkPage(tsGrid);
      CollNZIS_QUESTIONNAIRE_RESPONSE.FillListNodes(AspectsLinkPatPregFile, vvNZIS_QUESTIONNAIRE_RESPONSE);
      CollNZIS_QUESTIONNAIRE_RESPONSE.ShowListNodesGrid(grdNom);
    end;
    NZIS_QUESTIONNAIRE_ANSWER:
    begin
      InternalChangeWorkPage(tsGrid);
      CollNZIS_QUESTIONNAIRE_ANSWER.FillListNodes(AspectsLinkPatPregFile, vvNZIS_QUESTIONNAIRE_ANSWER);
      CollNZIS_QUESTIONNAIRE_ANSWER.ShowListNodesGrid(grdNom);
    end;
    NZIS_DIAGNOSTIC_REPORT:
    begin
      InternalChangeWorkPage(tsGrid);
      CollNZIS_DIAGNOSTIC_REPORT.FillListNodes(AspectsLinkPatPregFile, vvNZIS_DIAGNOSTIC_REPORT);
      CollNZIS_DIAGNOSTIC_REPORT.ShowListNodesGrid(grdNom);
    end;
    NZIS_RESULT_DIAGNOSTIC_REPORT:
    begin
      InternalChangeWorkPage(tsGrid);
      CollNzis_RESULT_DIAGNOSTIC_REPORT.FillListNodes(AspectsLinkPatPregFile, vvNzis_RESULT_DIAGNOSTIC_REPORT);
      CollNzis_RESULT_DIAGNOSTIC_REPORT.ShowListNodesGrid(grdNom);
    end;
    NZIS_ANSWER_VALUE:
    begin
      InternalChangeWorkPage(tsGrid);
      CollNZIS_ANSWER_VALUE.FillListNodes(AspectsLinkPatPregFile, vvNZIS_ANSWER_VALUE);
      CollNZIS_ANSWER_VALUE.ShowListNodesGrid(grdNom);
    end;
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
        if AspectsHipFile <> nil then
        begin
          case TTablesTypeHip(data.index) of
            PRACTICA: CellText := IntToStr(CollPractica.CntInADB);
            PREGLED: CellText := IntToStr(CollPregled.CntInADB);
            DOCTOR: CellText := IntToStr(CollDoctor.CntInADB);
            ICD10CM: CellText := IntToStr(CollMkb.CntInADB);
            PACIENT: CellText := IntToStr(CollPatient.CntInADB);
            BLANKA_MDN: CellText := IntToStr(collMdn.CntInADB);
            UNFAV: CellText := IntToStr(CollUnfav.CntInADB);
            Asp_Diag: CellText := IntToStr(CollDiag.CntInADB);
            Asp_PL_NZOK: CellText := IntToStr(CollPatPis.Count);
            Asp_EventManyTimes: CellText := IntToStr(CollEventsManyTimes.CntInADB);
            EXAM_BOLN_LIST: CellText := IntToStr(CollEbl.CntInADB);
            EXAM_ANALYSIS: CellText := IntToStr(CollExamAnal.CntInADB);
            EXAM_IMMUNIZATION: CellText := IntToStr(CollExamImun.CntInADB);
            PROCEDURES: CellText := IntToStr(CollProceduresNomen.CntInADB);
            KARTA_PROFILAKTIKA2017: CellText := IntToStr(CollCardProf.CntInADB);
            BLANKA_MED_NAPR: CellText := IntToStr(CollMedNapr.CntInADB);
            NZIS_PLANNED_TYPE: CellText := IntToStr(CollNZIS_PLANNED_TYPE.CntInADB);
            NZIS_QUESTIONNAIRE_RESPONSE: CellText := IntToStr(CollNZIS_QUESTIONNAIRE_RESPONSE.CntInADB);
            NZIS_QUESTIONNAIRE_ANSWER: CellText := IntToStr(CollNZIS_QUESTIONNAIRE_ANSWER.CntInADB);
            NZIS_DIAGNOSTIC_REPORT: CellText := IntToStr(CollNZIS_DIAGNOSTIC_REPORT.CntInADB);
            NZIS_RESULT_DIAGNOSTIC_REPORT: CellText := IntToStr(CollNzis_RESULT_DIAGNOSTIC_REPORT.CntInADB);
            NZIS_ANSWER_VALUE: CellText := IntToStr(CollNZIS_ANSWER_VALUE.CntInADB);
            NzisToken: CellText := IntToStr(CollNzisToken.count);
            Certificates: CellText := IntToStr(CollCertificates.count);
          end;
        end
        else
        begin
          case TTablesTypeHip(data.index) of
            Asp_PL_NZOK:
            begin
              if CollPatPis.Count > 0 then
              begin
                CellText := Format('УИН: %s   %d', [CollPatPis.uin, CollPatPis.Count]);
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
        FmxProfForm.AspAdbBuf := AspectsHipFile.Buf;
        FmxProfForm.AspAdbPosData := AspectsHipFile.FPosData;
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

procedure TfrmSuperHip.vtrGraphGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
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
            CellText := cl132.getAnsiStringMap(AspectsNomFile.Buf, CL132Coll.posData, word(CL132_Key));
            CellText := CellText + '  ' + Cl132.getAnsiStringMap(AspectsNomFile.Buf, CL132Coll.posData, word(CL132_Display_Value_BG));
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
            CellText := pr001.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(PR001_Description));
            if (pr001.CL142 <> nil)  and (pr001.CL142.FListCL088.Count =1) then
            begin
              cl088 := pr001.CL142.FListCL088[0];
              CellText  := CellText + ' cl088 ' + CL088.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL088_cl028));
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
            CellText := cl088.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL088_Description));
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
            CellText := cl134.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL134_Description));
          end;
          vvPatient:
          begin
            //pat := lstPatGraph[data.index];
            CellText := FmxProfForm.Patient.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(PatientNew_FNAME));
            CellText := CellText + ' ' + FmxProfForm.Patient.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(PatientNew_SNAME));
            CellText := CellText + ' ' + FmxProfForm.Patient.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(PatientNew_LNAME));
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
            CellText := cl132.getAnsiStringMap(AspectsNomFile.Buf, CL132Coll.posData, word(CL132_Key));
            CellText := CellText + '  ' + Cl132.getAnsiStringMap(AspectsNomFile.Buf, CL132Coll.posData, word(CL132_Display_Value_BG));
          end;
        end;
        -3: ;//CellText := 'бъдещи';

      else
        case data.vid of
          vvPatient:
          begin
            //pat := lstPatGraph[data.index];
            CellText := 'ЕГН ' + FmxProfForm.Patient.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_EGN));
          end;
          vvCl132:
          begin
            //dataPat := vtrGraph.GetNodeData(node.Parent.parent);
            //pat := lstPatGraph[dataPat.index];
            CellText := DateToStr(FmxProfForm.Patient.lstGraph[data.index].startDate) + ' - ' + DateToStr(FmxProfForm.Patient.lstGraph[data.index].endDate);
            cl132 := FmxProfForm.Patient.lstGraph[data.index].Cl132;
            cl132_CL136 := cl132.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL132_CL136_Mapping));
            //if cl132_CL136 = '1' then
            case cl132_CL136[1] of
              '1':
              begin
                if cl132.FPregled <> nil then
                begin
                  strtDate := TRealPregledNewItem(cl132.FPregled).getDateMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, word(PregledNew_START_DATE));
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
                CellText := CellText + #13#10 + pr001.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(PR001_Specialty_CL006));//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz ne e since a rule
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
            CellText := pr001.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(PR001_Activity_ID));

            if pr001.CL142 <> nil then
            begin
              CellText := CellText + #13#10 + pr001.CL142.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL142_nhif_code));
            end;
            if pr001.FExamAnal <> nil then
            begin
              strtDate := TRealExamAnalysisItem(pr001.FExamAnal).getDateMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, word(ExamAnalysis_DATA));
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
            CellText := cl088.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL088_Description));
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
            case cl134.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL134_CL028))[1] of
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
          CellText := cl088.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL088_cl028));
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
            case pr001.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(PR001_Nomenclature))[5] of
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

procedure TfrmSuperHip.vtrLinkOptionsDragAllowed(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
   Allowed := True;
end;

procedure TfrmSuperHip.vtrLinkOptionsDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  pSource, pTarget: PVirtualNode;
  attMode: TVTNodeAttachMode;
begin
  pSource := vtrLinkOptions.GetFirstSelected;
  pTarget := Sender.DropTargetNode;

  case Mode of
    dmNowhere: attMode := amNoWhere;
    dmAbove: attMode := amInsertBefore;
    dmBelow: attMode := amInsertAfter;
    dmOnNode: attMode := amAddChildLast;
  end;

  vtrLinkOptions.MoveTo(pSource, pTarget, attMode, False);
  //vtrPregledPat.MoveTo(vPrevNode, vNode, amInsertAfter, false);
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
begin
  //if DragObj <> nil then
//  begin
//    DragObj.DropMode := Mode;
//  end
//  else
//    Caption := vtrLinkOptions.Text[vtrLinkOptions.GetFirstSelected, 0];
  Accept := True;
end;

procedure TfrmSuperHip.vtrLinkOptionsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data: PAspRec;
begin
  data := Pointer(PByte(Node) + lenNode);
  case Column of
    0:
    begin
      case data.vid of
        vvPregled:
        begin
          //if CollPregled <> nil then

          //CellText := CollPregled.getAnsiStringMap(data.DataPos, word(PregledNew_TERAPY));
        end;
        vvFieldSearchGridOption:
        begin
          CellText := CollPregled.DisplayName(node.Dummy);
        end
      else
        begin
          CellText := IntToStr(Cardinal(Pointer(PByte(Node) - PByte(AspectsOptionsLinkFile.Buf))));
        end;
      end;
    end;
    1:
    begin
      CellText := IntToStr(Data.index);
      //CellText := format('index = %d  ;  rank = %d', [node.Dummy, Node.Index]); //IntToStr(node.Index);
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
  date1 := preg1.getDateMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, word(PregledNew_START_DATE));
  date2 := preg2.getDateMap(AspectsHipFile.Buf, AspectsHipFile.FPosData, word(PregledNew_START_DATE));
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

          CellText := FmxProfForm.Patient.lstGraph[FmxProfForm.Patient.CurrentGraphIndex].Cl132.getAnsiStringMap(AspectsNomFile.Buf, CL132Coll.posData, word(CL132_Key));
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

        0: CellText := DateTimeToStr(CollPregled.getDateMap(data.DataPos, word(PregledNew_START_DATE)));
        1: CellText := IntToStr(CollPregled.getIntMap(data.DataPos, word(PregledNew_AMB_LISTN)));
        2:
        begin
          vPreg := Pvirtualnode(data.index);
          vDiag := vPreg.FirstChild;
          while vDiag <> nil do
          begin
            dataDiag := pointer(PByte(vDiag) + lenNode);
            if dataDiag.vid = vvDiag then
            begin
              DiagTemp.DataPos := dataDiag.DataPos;
              mkb := DiagTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(Diagnosis_code_CL011));
              CellText := CellText + ',' + mkb;
            end;
            vDiag := vDiag.NextSibling;
          end;
        end;
        3: CellText := CollPregled.getAnsiStringMap(data.DataPos, word(PregledNew_NRN));
        //4: CellText := preg.MedNaprStr;
      end;
    end;
  end;
end;

procedure TfrmSuperHip.vtrMkbGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data: PAspRec;
  posCl22: cardinal;//AspectsNomHipFile.Buf
begin
  data := Sender.GetNodeData(node);
  case data.vid of
    vvPatient:
    begin
      case Column of
        0:
        begin
          CellText := 'Диагнози на пациента';
        end;
        1:
        begin

        end;
      end;
    end;
    vvPregled:
    begin
      case Column of
        0:
        begin
          CellText := 'Диагнози в текущия преглед';
        end;
        1:
        begin

        end;
      end;
    end;
    vvNomenMkb:
    begin
      case Column of
        0:
        begin
          CellText := 'МКБ - Номенклатура';
        end;
        1:
        begin

        end;
      end;
    end;
    vvMKBGroup:
    begin
      case Column of
        0:
        begin
          CellText := CollMkb.MkbGroups[Data.index].Split([#9])[1];
        end;
        1:
        begin

        end;
      end;

    end;
    vvMKBSubGroup:
    begin
      case Column of
        0:
        begin
          CellText := CollMkb.MkbSubGroups[Data.index].Split([#9])[2];
        end;
        1:
        begin

        end;
      end;

    end;
    vvMKB:
    begin
      case Column of
        0:
        begin
          CellText := CollMkb.getAnsiStringMap(data.DataPos, word(Mkb_CODE));
        end;
        1:
        begin
          CellText := CollMkb.getAnsiStringMap(data.DataPos, word(Mkb_NAME));
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
          CellText := AnalsNewColl.getAnsiStringMap(data.DataPos, word(AnalsNew_AnalName));
        end;
        1:
        begin
          AnalTemp.DataPos := data.DataPos;
          posCl22 := AnalTemp.getcardMap(AnalsNewColl.Buf, AnalsNewColl.posData, word(AnalsNew_CL022_pos));
          if posCl22 > 0 then
          begin
            //Cl022temp.DataPos := posCl22;
            CellText := CL022Coll.getAnsiStringMap(posCl22, word(CL022_Key));
            CellText := CellText + ' / ' + CL022Coll.getAnsiStringMap(posCl22, word(CL022_nhif_code))
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
  if Sender.MultiLine[Node] then
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
    ImportPR001(PR001Coll);
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
          ListNomenNzisNames[data.index].xmlStream.Position := 0;
          //oXml := TXMLDocument.Create(self);
          try
            //oXml.LoadFromStream(ListNomenNzisNames[data.index].xmlStream);
//            oXml.Encoding := 'UTF-8';
//            oXml.XML.Text := Xml.XMLDoc.FormatXMLData(oXml.XML.Text);
//            ListNomenNzisNames[data.index].xmlStream.Size := 0;
//            oXml.SaveToStream(ListNomenNzisNames[data.index].xmlStream);
//            ListNomenNzisNames[data.index].xmlStream.Position := 0;
            syndtXML.Lines.LoadFromStream(ListNomenNzisNames[data.index].xmlStream, TEncoding.UTF8);
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
          ListNomenNzisNames[data.index].Cl000Coll.ShowGrid(grdNom);
          mmotest.Lines.Assign(ListNomenNzisNames[data.index].Cl000Coll.FieldsNames);
        end;
        79, 80:
        begin
          grdNom.ReadOnly := False;
          InternalChangeWorkPage(tsGrid);
          ListNomenNzisNames[data.index].AspColl.ShowGrid(grdNom);
        end;
      end;

    end;
    vvPR001:
    begin
      //pgcWork.ActivePage := tsGrid;
      InternalChangeWorkPage(tsGrid);
      DataVPregledi := data;
      //ShowDynPR001;
      PR001Coll.ShowGrid(grdNom);
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
          ListNomenNzisNames[data.index].xmlStream.Position := 0;
          //oXml := TXMLDocument.Create(self);
          try
            //oXml.LoadFromStream(ListNomenNzisNames[data.index].xmlStream);
//            oXml.Encoding := 'UTF-8';
//            oXml.XML.Text := Xml.XMLDoc.FormatXMLData(oXml.XML.Text);
//            ListNomenNzisNames[data.index].xmlStream.Size := 0;
//            oXml.SaveToStream(ListNomenNzisNames[data.index].xmlStream);
//            ListNomenNzisNames[data.index].xmlStream.Position := 0;
            syndtXML.Lines.LoadFromStream(ListNomenNzisNames[data.index].xmlStream, TEncoding.UTF8);
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
      TempItem := NomenNzisColl.items[data.index];
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
          if NomenNzisColl.items[data.index].PRecord = nil then
          begin
            CellText := NomenNzisColl.items[data.index].getAnsiStringMap(NomenNzisColl.Buf, NomenNzisColl.posData, word(NomenNzis_NomenID));
          end
          else
          begin
            CellText := NomenNzisColl.items[data.index].PRecord.NomenID;
          end;
        end;
        1:
        begin
          if data.index < 0 then
          begin
            CellText := IntToStr(ListNomenNzisNames.Count);
            Exit;
          end;

          //CellText := ListNomenNzisNames[data.index].ArrStr[0];
        end;
      end;


    end;
    vvNone: // NomenNzis_NomenID
    begin
      CellText := NomenNzisColl.items[data.index].getAnsiStringMap(NomenNzisColl.Buf, NomenNzisColl.posData, word(NomenNzis_NomenID));
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
      if NomenNzisColl.items[dataParent.index].PRecord = nil then
      begin
        CellText := NomenNzisColl.items[dataParent.index].getAnsiStringMap(NomenNzisColl.Buf, NomenNzisColl.posData, word(NomenNzis_NomenID));
      end
      else
      begin
        CellText := NomenNzisColl.items[dataParent.index].PRecord.NomenID;
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

      TempItem := NomenNzisColl.items[data.index];
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
      Adb_DM.AdbHip := AspectsHipFile;
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
  if (GetKeyState(VK_CONTROL) >= 0) then Exit;

  bufLink := AspectsLinkPatPregFile.Buf;
  dataAction := pointer(PByte(node) + lenNode);
  if dataAction.vid = vvPatientRoot then Exit;
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
      egn1 := CollPatient.getAnsiStringMap(data1.DataPos, word(PatientNew_EGN));
      egn2 := CollPatient.getAnsiStringMap(data2.DataPos, word(PatientNew_EGN));
      Result := CompareStr(egn2, egn1);
    end;
    spAge:
    begin
      if data1.vid <> vvPatient then
      begin
        Exit;
      end;
      BIRTH_DATE1 := CollPatient.getDateMap(data1.DataPos, word(PatientNew_BIRTH_DATE));
      BIRTH_DATE2 := CollPatient.getDateMap(data2.DataPos, word(PatientNew_BIRTH_DATE));
      Result := CompareDate(BIRTH_DATE2, BIRTH_DATE1);
    end;
    spStartPreg:
    begin
      if data1.vid <> vvPregled then
      begin
        Exit;
      end;
      startDate1 := CollPregled.getDateMap(data1.DataPos, word(PregledNew_START_DATE));
      startDate2 := CollPregled.getDateMap(data2.DataPos, word(PregledNew_START_DATE));
      Result := CompareDate(startDate1, startDate2);
    end;
  end;

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

procedure TfrmSuperHip.vtrPregledPatDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
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
  if (GetKeyState(VK_CONTROL) >= 0) then Exit;
  bufLink := AspectsLinkPatPregFile.Buf;
  dataAction := pointer(PByte(node) + lenNode);
  if dataAction.vid = vvPatientRoot then  Exit;

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
          cl132Key := CollNZIS_PLANNED_TYPE.getAnsiStringMap(data.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
          cl132pos := CollNZIS_PLANNED_TYPE.getCardMap(data.DataPos, word(NZIS_PLANNED_TYPE_CL132_DataPos));
          cl136Key := CL132Coll.getAnsiStringMap(cl132pos, word(CL132_CL136_Mapping));
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
      end; //case
    end; //0

    1:
    begin
      case Data.vid of
        vvNZIS_PLANNED_TYPE:
        begin
          cl132Key := CollNZIS_PLANNED_TYPE.getAnsiStringMap(data.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
          cl132pos := CollNZIS_PLANNED_TYPE.getCardMap(data.DataPos, word(NZIS_PLANNED_TYPE_CL132_DataPos));
          cl136Key := CL132Coll.getAnsiStringMap(cl132pos, word(CL132_CL136_Mapping));
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
          nzisStatus := CollPregled.getWordMap(data.DataPos, word(PregledNew_NZIS_STATUS));
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
var
  data, dataPat, dataEvn: PAspRec;
  NodePat: PVirtualNode;
  preg: TPregledNewItem;
  pat: TPatientNewItem;
  log32: TLogicalData32;
  logEvnt: TlogicalEventsManyTimesSet;
  Aevnt: TLogicalEventsManyTimes;
  dateEvn, datePreg, dateBrd, startDate, endDate: TDate;
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
begin
  if node = nil then  Exit;
  if AspectsHipFile = nil then Exit;
  if AspectsHipFile.Buf = nil then  Exit;
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
        vvPatientRoot:
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
            patLogical := TlogicalPatientNewSet(CollPatient.getLogical32Map(data.DataPos, word(PatientNew_Logical)));
            if PID_TYPE_B in patLogical then
              CellText := 'Бебе ' + CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN))
            else
            if PID_TYPE_E in patLogical then
              CellText := 'ЕГН ' + CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN))
            else
            if PID_TYPE_L in patLogical then
              CellText := 'ЛНЧ ' + CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN))
            else
            if PID_TYPE_S in patLogical then
              CellText := 'ССН ' + CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN))
            else
            if PID_TYPE_F in patLogical then
              CellText := 'Ч ' + CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN))
            else
          end;
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
              NodePat := Node.Parent;
              if Sender = vtrPregledPat then
              begin
                DataPat := pointer(PByte(nodePat) + lenNode);
              end
              else
              begin
                DataPat := Sender.GetNodeData(nodePat);
              end;
              dateBrd := CollPatient.getDateMap(DataPat.DataPos, word(PatientNew_BIRTH_DATE));

              datePreg := CollPregled.getDateMap(Data.DataPos, word(PregledNew_START_DATE));
              PatAge := PatientTemp.CalcAge(datePreg, dateBrd);
              CellText := 'АЛ№ ' + IntToStr(CollPregled.getIntMap(Data.DataPos, word(PregledNew_AMB_LISTN)));
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
          CellText := CL132Temp.getAnsiStringMap(AspectsNomFile.Buf, CL132Coll.posData, word(CL132_Key));
          CellText := CellText + '  ' + CL132Temp.getAnsiStringMap(AspectsNomFile.Buf, CL132Coll.posData, word(CL132_Display_Value_BG));
        end;
        vvNZIS_PLANNED_TYPE:
        begin
          CellText := CollNZIS_PLANNED_TYPE.getAnsiStringMap( data.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
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
          CellText := PR001Temp.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(PR001_Description));
        end;
        vvNZIS_QUESTIONNAIRE_RESPONSE:
        begin
          if node.Parent.parent.parent = nil then
          begin
            CellText := 'errrrr';
            exit;
          end;
          //NZIS_QUESTIONNAIRE_RESPONSETemp.DataPos := data.DataPos;
          CellText := CollNZIS_QUESTIONNAIRE_RESPONSE.getAnsiStringMap(data.DataPos, word(NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY));
        end;
        vvNZIS_QUESTIONNAIRE_ANSWER:
        begin
          if node.Parent.parent.parent = nil then
          begin
            CellText := 'errrrr';
            exit;
          end;
          NZIS_QUESTIONNAIRE_ANSWERTemp.DataPos := data.DataPos;
          CellText := NZIS_QUESTIONNAIRE_ANSWERTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE));
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
            case NZIS_ANSWER_VALUETemp.getWordMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_ANSWER_VALUE_CL028)) of
              1:
              begin
               CellText := Double.ToString(NZIS_ANSWER_VALUETemp.getDoubleMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_QUANTITY)));
              end;
              2: CellText := NZIS_ANSWER_VALUETemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_CODE));
              3: CellText := 'Текст-записан';
              4: CellText := 'Дата-записана';
            end;
          end
          else
          begin
            if CollNZIS_ANSWER_VALUE.Items[data.index].PRecord <> nil then
            begin
              case CollNZIS_ANSWER_VALUE.Items[data.index].getWordMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_ANSWER_VALUE_CL028)) of
                1: CellText := Double.ToString(CollNZIS_ANSWER_VALUE.Items[data.index].PRecord.ANSWER_QUANTITY);
                2: CellText := CollNZIS_ANSWER_VALUE.Items[data.index].PRecord.ANSWER_CODE;
                3: CellText := 'Текст-НЕзаписан';
                4: CellText := 'Дата-НЕзаписан';
              end;
            end
            else
            begin
              NZIS_ANSWER_VALUETemp.DataPos := CollNZIS_ANSWER_VALUE.Items[data.index].DataPos;
              case NZIS_ANSWER_VALUETemp.getWordMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_ANSWER_VALUE_CL028)) of
                1: CellText := Double.ToString(NZIS_ANSWER_VALUETemp.getDoubleMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_QUANTITY)));
                2: CellText := NZIS_ANSWER_VALUETemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_CODE));
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
          CellText := 'CL142|' + NZIS_DIAGNOSTIC_REPORTTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_DIAGNOSTIC_REPORT_CL142_CODE));
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
          case NZIS_Result_DIAGNOSTIC_REPORTTemp.getwordMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
            1: CellText := Double.ToString( NZIS_Result_DIAGNOSTIC_REPORTTemp.getDoubleMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY)));
            2: CellText := NZIS_Result_DIAGNOSTIC_REPORTTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE));
            3: CellText := NZIS_Result_DIAGNOSTIC_REPORTTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING));
          end;
        end;
        vvCL088:
        begin
          CL088Temp.DataPos := data.DataPos;
          CellText := CL088Temp.getAnsiStringMap(AspectsNomFile.Buf, PR001Coll.posData, word(CL088_Description));
        end;
        vvdiag:
        begin
          DiagTemp.DataPos := Data.DataPos;
          FieldText := (DiagTemp.getAnsiStringMap(AspectsHipFile.Buf, CollDiag.posData, word(Diagnosis_additionalCode_CL011)));
          CellText := 'MKB ' + (DiagTemp.getAnsiStringMap(AspectsHipFile.Buf, CollDiag.posData, word(Diagnosis_code_CL011))) + FieldText;
        end;
        vvMDN:
        begin
          MDNTemp.DataPos := Data.DataPos;
          CellText := 'МДН ' + inttostr(MDNTemp.getIntMap(AspectsHipFile.Buf, CollPregled.posData, word(MDN_NUMBER)));
        end;
        vvExamAnal:
        begin
          anal := CollExamAnal.GetItemsFromDataPos(Data.DataPos);
          if (anal <> nil) and (anal.PRecord <> nil) then
          begin
            CellText := 'Изсл. ' + anal.PRecord.NZIS_CODE_CL22;
          end
          else
          begin
            ExamAnalTemp.DataPos := Data.DataPos;
            CellText := 'Изсл. ' + ExamAnalTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(ExamAnalysis_NZIS_CODE_CL22));
          end;
        end;
        vvDoctor:
        begin
          DoctorTemp.DataPos := Data.DataPos;
          CellText := 'Лекар ' + DoctorTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(Doctor_UIN));
        end;
        vvEvnt:
        begin
          EvnTemp.DataPos := Data.DataPos;
          log32 := EvnTemp.getLogical32Map(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_Logical));
          CellText := 'Събитие ' + EvnTemp.Logical32ToStr(log32);
        end;
        vvPatientRevision:
        begin
          CellText := 'Промяна на Пациента';

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
          CellText := ProcTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(Procedures_CODE));
        end;
        vvPerformer:
        begin
          DoctorTemp.DataPos := Data.DataPos;
          CellText := DoctorTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(Doctor_SNAME));
        end;
        vvDeput:
        begin
          DoctorTemp.DataPos := Data.DataPos;
          CellText := DoctorTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(Doctor_SNAME));
        end;
        vvPatientRoot:
          CellText := IntToStr(CollPatient.CntInADB) ;
        vvPatient:
        begin
          dateBrd := CollPatient.getDateMap(Data.DataPos, word(PatientNew_BIRTH_DATE));
          PatAge := PatientTemp.CalcAge(UserDate, dateBrd);
          case PatAge of
            0:
            begin
              PatAgeDoub := PatientTemp.CalcAgeDouble(UserDate, dateBrd);
              PatAgeStr := IntToStr(Floor(PatAgeDoub * 12)) + ' мес.';
            end;
          else
            PatAgeStr := IntToStr(PatAge) + ' год.';
          end;
          CellText := CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_FNAME));
          CellText := CellText + ' ' + CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_SNAME));
          CellText := CellText + ' ' + CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_LNAME))
                      + #13#10 + ' ' + PatAgeStr;
        end;
        vvPregled:
        begin
          //p := pointer(PByte(CollPregled.buf) + (Data.DataPos  + 4*word(PregledNew_ID)));
          //ofset := p^ + CollPatient.posData;
          CellText := 'НРН ' + CollPregled.getAnsiStringMap(Data.DataPos, word(PregledNew_NRN))  + ' от ' + DateToStr(CollPregled.getDateMap(Data.DataPos, word(PregledNew_START_DATE)));
        end;
        vvNZIS_PLANNED_TYPE:
        begin
          startDate := CollNZIS_PLANNED_TYPE.getDateMap( data.DataPos, word(NZIS_PLANNED_TYPE_StartDate));
          endDate := CollNZIS_PLANNED_TYPE.getDateMap( data.DataPos, word(NZIS_PLANNED_TYPE_EndDate));
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
          nomenPos := NZIS_QUESTIONNAIRE_ANSWERTemp.getCardMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS));
          CellText := CL134Coll.getAnsiStringMap(nomenPos, Word(CL134_Description));
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
            case NZIS_ANSWER_VALUETemp.getWordMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_ANSWER_VALUE_CL028)) of
              2:
              begin
                nomenPos := NZIS_ANSWER_VALUETemp.getCardMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_ANSWER_VALUE_NOMEN_POS));
                CellText := CL139Coll.getAnsiStringMap(nomenPos, word(CL139_Description));
              end;
              3:
              begin
                CellText := NZIS_ANSWER_VALUETemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_TEXT));
              end;
              4:
              begin
                CellText := DateToStr(NZIS_ANSWER_VALUETemp.getDateMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_DATE)));
              end;
            end;
          end
          else
          begin
            NZIS_ANSWER_VALUETemp.DataPos := CollNZIS_ANSWER_VALUE.Items[data.index].DataPos;
            case NZIS_ANSWER_VALUETemp.getWordMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_ANSWER_VALUE_CL028)) of
              2:
              begin
                if  CollNZIS_ANSWER_VALUE.Items[data.index].PRecord <> nil then
                begin
                  nomenPos := CollNZIS_ANSWER_VALUE.Items[data.index].PRecord.NOMEN_POS;
                end
                else
                begin
                  nomenPos := CollNZIS_ANSWER_VALUE.Items[data.index].getCardMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_ANSWER_VALUE_NOMEN_POS));
                end;
                CellText := CL139Coll.getAnsiStringMap(nomenPos, word(CL139_Description));
              end;
              3:
              begin
                if CollNZIS_ANSWER_VALUE.Items[data.index].PRecord <> nil then
                begin
                  CellText := CollNZIS_ANSWER_VALUE.Items[data.index].PRecord.ANSWER_TEXT;
                end
                else
                begin
                  CellText := NZIS_ANSWER_VALUETemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_TEXT));
                end;
              end;
              4:
              begin
                if CollNZIS_ANSWER_VALUE.Items[data.index].PRecord <> nil then
                begin
                  CellText := DateToStr(CollNZIS_ANSWER_VALUE.Items[data.index].PRecord.ANSWER_DATE);
                end
                else
                begin
                  CellText := DateToStr(NZIS_ANSWER_VALUETemp.getDateMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_ANSWER_VALUE_ANSWER_DATE)));
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
          nomenPos := NZIS_DIAGNOSTIC_REPORTTemp.getCardMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_DIAGNOSTIC_REPORT_NOMEN_POS));

          CellText := CL142Coll.getAnsiStringMap(nomenPos, Word(CL142_Description));
        end;
        vvNZIS_RESULT_DIAGNOSTIC_REPORT:
        begin
          if node.Parent.parent.parent.Parent = nil then
          begin
            CellText := 'errrrr';
            exit;
          end;
          NZIS_Result_DIAGNOSTIC_REPORTTemp.DataPos := data.DataPos;
          nomenPos := NZIS_Result_DIAGNOSTIC_REPORTTemp.getCardMap(AspectsHipFile.Buf, CollPregled.posData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
          CellText := CL144Coll.getAnsiStringMap(nomenPos, Word(CL144_Description));
        end;
        vvDiag:
        begin
          DiagTemp.DataPos := Data.DataPos;
          FieldText := (DiagTemp.getAnsiStringMap(AspectsHipFile.Buf, CollDiag.posData, word(Diagnosis_additionalCode_CL011)));
          if FieldText <> '' then
          begin
            CellText := FieldText;
          end;
        end;
        vvMDN:
        begin
          MDNTemp.DataPos := Data.DataPos;
          CellText := 'НРН ' + (MDNTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(MDN_NRN)));
        end;
        vvExamAnal:
        begin
          ExamAnalTemp.DataPos := Data.DataPos;
          CellText := ExamAnalTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(ExamAnalysis_NZIS_DESCRIPTION_CL22));
        end;
        vvEvntList:
        begin
          evntCnt := 0;
          evntNode := pvirtualNode(Data.DataPos);
          while evntNode <> nil do
          begin
            inc(evntCnt);
            evntNode := evntNode.Parent;

          end;
          CellText := IntToStr(evntCnt);
          Exit;
          dataEvn := pointer(PByte(evntNode) + lenNode);
          EvnTemp.DataPos := dataEvn.DataPos;
          logEvnt := TlogicalEventsManyTimesSet(EvnTemp.getLogical24Map(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_Logical)));
          for Aevnt in logEvnt do
          begin
            case Aevnt of
              DATE_ZAPISVANE:
              begin
                dateEvn := EvnTemp.getDateMap(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_valTDate));
                CellText := CellText + 'зап. ' + DateToStr(dateEvn);

              end;
              DATE_OTPISVANE:
              begin
                CellText := CellText + 'отп.'
              end;
              DATE_HEALTH_INSURANCE_CHECK:
              begin
                CellText := CellText + 'осиг.'
              end;
              DATA_HEALTH_INSURANCE:
              begin
                CellText := CellText + 'осиг. xml'
              end;
              RZOK:
              begin
                rzokEvn := EvnTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_valAnsiString));
                CellText := CellText + 'rzok: ' + rzokEvn
              end;
              RZOKR:
              begin
                rzokREvn := EvnTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_valAnsiString));
                CellText := CellText + 'rzokR: ' + rzokREvn
              end;

            end;
          end;

        end;
        vvEvnt:
        begin
          EvnTemp.DataPos := Data.DataPos;

          logEvnt := TlogicalEventsManyTimesSet(EvnTemp.getLogical24Map(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_Logical)));
          for Aevnt in logEvnt do
          begin
            case Aevnt of
              DATE_ZAPISVANE:
              begin
                dateEvn := EvnTemp.getDateMap(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_valTDate));
                CellText := CellText + 'зап. ' + DateToStr(dateEvn);

              end;
              DATE_OTPISVANE:
              begin
                CellText := CellText + 'отп.'
              end;
              DATE_HEALTH_INSURANCE_CHECK:
              begin
                CellText := CellText + 'осиг.'
              end;
              DATA_HEALTH_INSURANCE:
              begin
                CellText := CellText + 'осиг. xml'
              end;
              RZOK:
              begin
                rzokEvn := EvnTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_valAnsiString));
                CellText := CellText + 'rzok: ' + rzokEvn
              end;
              RZOKR:
              begin
                rzokREvn := EvnTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_valAnsiString));
                CellText := CellText + 'rzokR: ' + rzokREvn
              end;
              NAS_MQSTO:
              begin
                nasMestoEvn := EvnTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_valAnsiString));
                CellText := CellText + 'нас. място: ' + nasMestoEvn
              end;
            end;
          end;

          //CellText := 'Събитие ' + EvnTemp.Logical32ToStr(log32);
        end;
        vvPatientRevision:
        begin
          CellText := IntToStr(data.index);
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
        vvEvntList:
        begin
          evntNode := pvirtualNode(Data.DataPos);
          while evntNode <> nil do
          begin
            if Sender = vtrPregledPat then
            begin
              dataEvn := pointer(PByte(evntNode) + lenNode);
            end
            else
            begin
              dataEvn := Sender.GetNodeData(evntNode);
            end;
            EvnTemp.DataPos := dataEvn.DataPos;
            logEvnt := TlogicalEventsManyTimesSet(EvnTemp.getLogical24Map(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_Logical)));
            if TlogicalEventsManyTimes.NAS_MQSTO in logEvnt then
            begin
              CellText := CollEventsManyTimes.getAnsiStringMap(dataEvn.DataPos, word(EventsManyTimes_valAnsiString));
            end;
            evntNode := evntNode.Parent;
          end;
        end
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
  logEvnt: TlogicalEventsManyTimesSet;
  Aevnt: TLogicalEventsManyTimes;
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
        vvPatientRoot:
          CellText := 'Пациенти ' ;
        vvPatient:
        begin
          if data.index <> -1 then
          begin
            pat := CollPatient.Items[Data.index];
            CellText := 'ЕГН ' + pat.getAnsiStringMap(AspectsHipFile.Buf, CollPatient.posData, word(PatientNew_EGN));
          end
          else
          begin
            CellText := 'ЕГН ' + CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_EGN));
          end;
        end;
        vvPregled:
        begin
          if data.index <> -1 then
          begin
            //preg := PregledCollFilter.Items[Data.index];
            CollPregled.GetFieldText(Sender, word(PregledNew_AMB_LISTN), data.index, FieldText);
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
              CellText := 'АЛ№ ' + IntToStr(CollPregled.getIntMap(Data.DataPos, word(PregledNew_AMB_LISTN)));
              brdDate := CollPatient.getDateMap( patData.DataPos, word(PatientNew_BIRTH_DATE));
              prgDate := CollPregled.getDateMap(Data.DataPos, word(PregledNew_START_DATE));
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
            DiagTemp.DataPos := Data.DataPos;
            FieldText := (DiagTemp.getAnsiStringMap(AspectsHipFile.Buf, CollDiag.posData, word(Diagnosis_additionalCode_CL011)));
            CellText := 'MKB ' + (DiagTemp.getAnsiStringMap(AspectsHipFile.Buf, CollDiag.posData, word(Diagnosis_code_CL011))) + FieldText;
            //if CellText = 'АЛ№ 0' then
//               CellText := 'АЛ№ 0';

          end;
        end;
        vvMDN:
        begin
          MDNTemp.DataPos := Data.DataPos;
          CellText := 'МДН ' + inttostr(MDNTemp.getIntMap(AspectsHipFile.Buf, CollPregled.posData, word(MDN_NUMBER)));
        end;
        vvDoctor:
        begin
          DoctorTemp.DataPos := Data.DataPos;
          CellText := 'Лекар ' + DoctorTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(Doctor_UIN));
        end;
        vvEvnt:
        begin
          EvnTemp.DataPos := Data.DataPos;
          log32 := EvnTemp.getLogical32Map(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_Logical));
          CellText := 'Събитие ' + EvnTemp.Logical32ToStr(log32);
        end;
      end;
    end;
    1:
    begin
      case data.vid of
        vvPerformer:
        begin
          DoctorTemp.DataPos := Data.DataPos;
          CellText := DoctorTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(Doctor_SNAME));
        end;
        vvDeput:
        begin
          DoctorTemp.DataPos := Data.DataPos;
          CellText := DoctorTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(Doctor_SNAME));
        end;
        vvPatient:
        begin
          CellText := CollPatient.getAnsiStringMap(data.DataPos, word(PatientNew_FNAME));
          CellText := CellText + ' ' + CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_SNAME));
          CellText := CellText + ' ' + CollPatient.getAnsiStringMap(Data.DataPos, word(PatientNew_LNAME));
        end;
        vvPregled:
        begin
          CellText := 'от ' + DateToStr(CollPregled.getDateMap(Data.DataPos, word(PregledNew_START_DATE)));
        end;
        vvDiag:
        begin
          DiagTemp.DataPos := Data.DataPos;
          FieldText := (DiagTemp.getAnsiStringMap(AspectsHipFile.Buf, CollDiag.posData, word(Diagnosis_additionalCode_CL011)));
          if FieldText <> '' then
          begin
            CellText := FieldText;
          end;
        end;
        vvMDN:
        begin
          MDNTemp.DataPos := Data.DataPos;
          CellText := 'НРН ' + (MDNTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(MDN_NRN)));
        end;
        vvEvnt:
        begin
          EvnTemp.DataPos := Data.DataPos;

          logEvnt := TlogicalEventsManyTimesSet(EvnTemp.getLogical24Map(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_Logical)));
          for Aevnt in logEvnt do
          begin
            case Aevnt of
              DATE_ZAPISVANE:
              begin
                dateEvn := EvnTemp.getDateMap(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_valTDate));
                CellText := CellText + 'зап. ' + DateToStr(dateEvn);

              end;
              DATE_OTPISVANE:
              begin
                CellText := CellText + 'отп.'
              end;
              DATE_HEALTH_INSURANCE_CHECK:
              begin
                CellText := CellText + 'осиг.'
              end;
              DATA_HEALTH_INSURANCE:
              begin
                CellText := CellText + 'осиг. xml'
              end;
              RZOK:
              begin
                rzokEvn := EvnTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_valAnsiString));
                CellText := CellText + 'rzok: ' + rzokEvn
              end;
              RZOKR:
              begin
                rzokREvn := EvnTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_valAnsiString));
                CellText := CellText + 'rzokR: ' + rzokREvn
              end;
              NAS_MQSTO:
              begin
                nasMestoEvn := EvnTemp.getAnsiStringMap(AspectsHipFile.Buf, CollPregled.posData, word(EventsManyTimes_valAnsiString));
                CellText := CellText + 'нас. място: ' + nasMestoEvn
              end;
            end;
          end;

          //CellText := 'Събитие ' + EvnTemp.Logical32ToStr(log32);
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
begin
  if node = vRootRecentDB then
  begin
    case numButton of
      0:
      begin
        OpenDB(-1);
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
begin
  if node= vRootRecentDB then
  begin
    case numButton of
      0:
      begin
        ButonVisible := True;
        imageIndex := 55;
      end;
    end;
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
begin
  Stopwatch := TStopwatch.StartNew;

  if AspectsLinkPatPregFile <> nil then
  begin
    node := pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);
    vtrPregledPat.InternalDisconnectNode(node, false);
    UnmapViewOfFile(AspectsLinkPatPregFile.Buf);
  end;


  FillPatInDoctor;
  FillPregledInPat;
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
  FillAnalInExamAnal;
  FillExamAnalInMDN;
  FillMDN_inPregled;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('МДН в прегледи: %f', [Elapsed.TotalMilliseconds]));

  Stopwatch := TStopwatch.StartNew;
  FillSpecNzisInMedNapr;
  FillMedNaprInPregled;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('мед. напр. в прегледи: %f', [Elapsed.TotalMilliseconds]));

  Stopwatch := TStopwatch.StartNew;
  FillImunInPregled;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('имунизации. в прегледи: %f', [Elapsed.TotalMilliseconds]));

  Stopwatch := TStopwatch.StartNew;
  FillPrfCard_inPregled;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add(Format('проф. карти в прегледи: %f', [Elapsed.TotalMilliseconds]));


  Stopwatch := TStopwatch.StartNew;
  LnkFilename := AspectsHipFile.FileName.Replace('.adb', '.lnk');
  DeleteFile(LnkFilename);
  fileStr := TFileStream.Create(LnkFilename, fmCreate);
  fileStr.Size := 400000000;
  fileStr.Free;
  //CollDoctor.ShowGrid(grdNom);

  AspectsLinkPatPregFile := TMappedLinkFile.Create(LnkFilename, true, AspectsHipFile.GUID);

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
end;

procedure TfrmSuperHip.WMCertStorage(var Msg: TMessage);
begin
  vtrPregledPat.Repaint;
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

procedure TfrmSuperHip.WMHelp(var Msg: TWMHelp);
begin
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
  patID := FmxProfForm.Patient.getIntMap(AspectsHipFile.buf, CollPatient.posData, word(PatientNew_ID));
  pregID := FmxProfForm.Pregled.getIntMap(AspectsHipFile.buf, CollPregled.posData, word(PregledNew_ID));
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
    if CollPatient.getIntMap(data.DataPos, word(PatientNew_ID)) = Msg.WParam then
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
                         CollPregled.getIntMap(dataPreg.DataPos, word(PregledNew_ID));
                    PlanedPreg.IsDone := True;
                  end;
                  PlanedPreg.Cl132 :=
                       cl132 + CL132Temp.getAnsiStringMap(AspectsNomFile.Buf, CL132Coll.posData, word(CL132_Key)) + '; ';
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
      status := CollPregled.getWordMap(data.DataPos, word(PregledNew_NZIS_STATUS));
    end;
  end;
  if (Msg.LParam = 0) and (status = 5) then //ok
  begin
    //if edtToken.Text <> '' then
    begin

      //FmxProfForm.animNrnStatus.Enabled := true;
      if chkAutamatNzis.Checked then
      begin
        CollPregled.SetWordMap(data.DataPos, word(PregledNew_NZIS_STATUS),6);
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
        mmoTest.Lines.Add('CL088Coll.FCL088New.Count= ' + IntToStr(CL088Coll.FCL088New.Count));
      end;
    end;
  end
  else
  begin
    syndtXML.Lines.LoadFromStream(ListNomenNzisNames[msg.LParam].xmlStream, TEncoding.UTF8);
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
  //thrSearch.collPatForSearch.Buf := AspectsHipFile.Buf;
//  thrSearch.collPatForSearch.posData := AspectsHipFile.FPosData;
//  thrSearch.collPatForSearch.ShowLinksGrid(grdSearch);
  //thrSearch.collPregForSearch.Buf := AspectsHipFile.Buf;
  //thrSearch.collPregForSearch.posData := AspectsHipFile.FPosData;
  //CollPregled.lastBottom := 20;
  //Stopwatch := TStopwatch.StartNew;
//  for i := 0 to 20 do
//    CollPregled.SortListDataPos;
//  Elapsed := Stopwatch.Elapsed;
//  mmotest.Lines.Add(format( 'sortSearch %d за %f ', [CollPregled.ListDataPos.Count, Elapsed.TotalMilliseconds]));

  case TVtrVid(grdSearch.Tag) of
    vvPatient: thrSearch.CollPat.ShowLinksGrid(grdSearch);
    vvPregled: thrSearch.collPreg.ShowLinksGrid(grdSearch);
  end;
  FmxFinderFrm.IsFinding := false;
  //grdSearch.SetFocus;
  //grdSearch.Selected.Row := -1;
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
  Self.SetBounds(0, 0, Msg.WParam, Msg.LParam);
end;

{ TNomenNzisRec }

constructor TNomenNzisRec.Create;
begin
  inherited Create;
  Cl000Coll := TCL000EntryCollection.Create(nil);
  xmlStream := TMemoryStream.Create;
end;

destructor TNomenNzisRec.Destroy;
begin
  FreeAndNil(Cl000Coll);
  FreeAndNil(xmlStream);
  inherited;
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

initialization
  // Enable raw mode (default mode uses stack frames which aren't always generated by the compiler)
  Include(JclStackTrackingOptions, stRawMode);
  // Disable stack tracking in dynamically loaded modules (it makes stack tracking code a bit faster)
  Include(JclStackTrackingOptions, stStaticModuleList);

  // Initialize Exception tracking
  JclStartExceptionTracking;

finalization

  // Uninitialize Exception tracking
  JclStopExceptionTracking;

end.
