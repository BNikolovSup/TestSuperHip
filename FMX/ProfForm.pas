unit ProfForm;
//answerval

interface
uses
    Vcl.Forms,
   Winapi.Windows, JclDebug, Vcl.StdCtrls, System.DateUtils, Parnassus.FMXContainer,
   Aspects.Types, Aspects.Collections, Table.PregledNew, Table.PatientNew, Table.CL132,
   Table.PR001, Table.CL088, Table.CL139, Table.CL134, Table.Diagnosis, Table.ExamAnalysis,
   Table.MDN, Table.CL022, Table.CL142, Table.CL144, Table.NZIS_PLANNED_TYPE, Table.NZIS_QUESTIONNAIRE_RESPONSE,
   Table.NZIS_DIAGNOSTIC_REPORT, Table.NZIS_RESULT_DIAGNOSTIC_REPORT,
   Table.NZIS_QUESTIONNAIRE_ANSWER, Table.NZIS_ANSWER_VALUE, Table.Doctor,
   Table.Mkb, Table.Addres, Table.NasMesto, Table.Oblast, Table.Obshtina,
   Table.BLANKA_MED_NAPR, Table.ExamImmunization, table.cl006, Table.INC_NAPR,
   Table.OtherDoctor,

   rtti, VirtualTrees, VirtualStringTreeHipp, VirtualStringTreeAspect,
   RealObj.RealHipp, RealObj.NzisNomen, ProfGraph, ADB_DataUnit, RealNasMesto,


  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, FMX.TextLayout,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.ListBox, FMX.Layouts, FMX.Ani, FMX.Objects, FMX.Styles.Objects,
  system.Diagnostics, system.TimeSpan, System.Actions, FMX.ActnList,
  System.ImageList, FMX.ImgList, FMX.Menus, FMX.ScrollBox, FMX.Memo,
  System.Generics.Collections, system.Math, FMX.Effects,
  FMX.Filter.Effects, FMX.DateTimeCtrls, FMX.Calendar,
  FMX.ComboEdit, FMX.Platform

  , WalkFunctions;

type


  TActionMdnInPregled = (ADD, Del);
  TActionEventMdnInPregled = procedure (sender: TObject; var PregledLink, MdnLink: PVirtualNode; var TempItem: TRealMDNItem) of object;
  TActionEventMnInPregled = procedure (sender: TObject; var PregledLink, MnLink: PVirtualNode; var TempItem: TRealBLANKA_MED_NAPRItem) of object;
  TActionEventImunInPregled = procedure (sender: TObject; var PregledLink, MnLink: PVirtualNode; var TempItem: TRealExamImmunizationItem) of object;
  TActionEventDiagInPregled = procedure (sender: TObject; var PregledLink, DiagLink: PVirtualNode; var TempItem: TRealDiagnosisItem) of object;

  TActionEventAnalInMdn = procedure(sender: tobject; var MdnLink, AnalLink: PVirtualNode; var TempItem: TRealExamAnalysisItem) of object;
  TEventShowHint = procedure(seneder: TObject; hint: string; R: TRect) of object;
  TReShowPregledFMX = procedure(dataPat,dataPreg: PAspRec; linkPreg:PVirtualNode ) of object;
  //TEventSelecMkb = procedure(
  TPopupAll = class(TPopup)

  end;

  TComboMultiLabel = class
    chk: TCheckBox;
    node: PVirtualNode;
    Flyt: TFlowLayout;
    canValidate: Boolean;
    rctNull: TRectangle;
    MultiBtns: TList<TSpeedButton>;
    rctBtn: TRectangle;
    SourceAnsw: TSourceAnsw;
    rctSourceAnsw: TRectangle;

    constructor Create;
    destructor destroy; override;
    function GetNodeValueFromText(str: string; answValColl: TNZIS_ANSWER_VALUEColl): PVirtualNode;
    function GetValuePosNomFromText(str: string): cardinal;
  end;

  TComboOneLabel = class
    chk: TCheckBox;
    cmb: TComboBox;
    node: PVirtualNode;
    nodeValue: PVirtualNode;
    canValidate: Boolean;
    rctNull: TRectangle;
    txt: TText;
    LineSaver: TLine;
    SourceAnsw: TSourceAnsw;
    rctSourceAnsw: TRectangle;

    constructor Create;
    //destructor destroy; override;
    //function GetNodeValueFromText(str: string; answValColl: TNZIS_ANSWER_VALUEColl): PVirtualNode;
    //function GetValuePosNomFromText(str: string): cardinal;
  end;
  

  TComboLabel = class
    //cmb: TComboBox;
    chk: TCheckBox;
    node: PVirtualNode;
    nodeValue: PVirtualNode;
    IsMulti: Boolean;
    Flyt: TFlowLayout;
    canValidate: Boolean;
    MultiBtns: TList<TSpeedButton>;
    txt: TText;
    SourceAnsw: TSourceAnsw;
    rctSourceAnsw: TRectangle;

    constructor Create;
    destructor destroy; override;
    function GetNodeValueFromText(str: string; answValColl: TNZIS_ANSWER_VALUEColl): PVirtualNode;
    function GetValuePosNomFromText(str: string): cardinal;
  end;

  TMemoLabel = class
    chk: TCheckBox;
    memo: TMemo;
    rctNull: TRectangle;
    asp: PAspRec;
    field: Word;
    node: PVirtualNode;
    nodeValue: PVirtualNode;
    canValidate: Boolean;
    SourceAnsw: TSourceAnsw;
    rctSourceAnsw: TRectangle;
    lineSaver: TLine;
    constructor Create;
  end;

  TLayoutCheck = class
    txt: TText;
    rctNull: TRectangle;
    node: PVirtualNode;
    canValidate: Boolean;
    SourceAnsw: TSourceAnsw;
    rctSourceAnsw: TRectangle;
  end;

  TEditLabel = class
    chk: TCheckBox;
    edt: TEdit;
    rctNull: TRectangle;
    node: PVirtualNode;
    nodeValue: PVirtualNode;
    canValidate: Boolean;
    textUnit: TText;
    SourceAnsw: TSourceAnsw;
    rctSourceAnsw: TRectangle;
    constructor Create;
  end;

  TEditADB = record
    edt: TEdit;
    node: PVirtualNode;
    asp: PAspRec;
  end;

  TDateEditLabel = class
    DatEdt: TDateEdit;
    lbl: TText;
    chk: TCheckBox;
    rctNull: TRectangle;
    node: PVirtualNode;
    nodeValue: PVirtualNode;
    canValidate: Boolean;
    btnCalendar: TRectangle;
    edtDat: TEdit;
    SourceAnsw: TSourceAnsw;
    rctSourceAnsw: TRectangle;
  end;



  TPlanedTypeLabel = class
    RctPlan: TRectangle;
    RctColorPlan: TRectangle;
    PostDataLink: Cardinal;
    txtKey, txtCapt, txtPeriod: TText;
    btnIcon: TRectangle;
    nodePlan: PVirtualNode;

    public
    constructor create;
    destructor destroy; override;
  end;

  

  TWinCursorService = class(TInterfacedObject, IFMXCursorService)
  private
    class var FPreviousPlatformService: IFMXCursorService;
    class var FWinCursorService: TWinCursorService;
    class var FCursorOverride: TCursor;
    class procedure SetCursorOverride(const Value: TCursor); static;
  public
    class property CursorOverride: TCursor read FCursorOverride write SetCursorOverride;

    class constructor Create;
    procedure SetCursor(const ACursor: TCursor);
    function GetCursor: TCursor;
  end;

  TControlProt = class(TControl)

  end;



  TfrmProfFormFMX = class(TForm)
    scrlbx1: TScrollBox;
    scldlyt1: TScaledLayout;
    lytTop: TLayout;
    slctnpnt1: TSelectionPoint;
    rct1: TRectangle;
    btn1: TButton;
    stylbk1: TStyleBook;
    slctnpnt2: TSelectionPoint;
    lytbottom: TLayout;
    lytLeft: TLayout;
    slctnpnt3: TSelectionPoint;
    cbb1: TComboBox;
    p1: TPopup;
    lstItemNomen: TListBoxItem;
    rctBlanka: TRectangle;
    xpdrPatient: TExpander;
    lblAddres: TLabel;
    xpdrDoctor: TExpander;
    xpdrVisitFor: TExpander;
    flwlytVizitFor: TFlowLayout;
    txtAmbList: TText;
    btnTest: TButton;
    flwlytMulti: TFlowLayout;
    rct2: TRectangle;
    anim1: TFloatAnimation;
    anim2: TFloatAnimation;
    anim3: TFloatAnimation;
    Rectangle2: TRectangle;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation3: TFloatAnimation;
    lyt2: TLayout;
    txtDocuments: TText;
    expndrMdns: TExpander;
    Rectangle3: TRectangle;
    FloatAnimation5: TFloatAnimation;
    FloatAnimation10: TFloatAnimation;
    lyt1: TLayout;
    lytMdnExp: TLayout;
    p2: TPopup;
    lbMdnType: TListBox;
    shdwfct2: TShadowEffect;
    lst3: TListBoxItem;
    lst4: TListBoxItem;
    lst5: TListBoxItem;
    lst6: TListBoxItem;
    lst7: TListBoxItem;
    lst8: TListBoxItem;
    lst9: TListBoxItem;
    lst10: TListBoxItem;
    lbPorpuse: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    ListBoxItem7: TListBoxItem;
    ListBoxItem8: TListBoxItem;
    ShadowEffect1: TShadowEffect;
    p3: TPopup;
    lst11: TListBoxItem;
    lst12: TListBoxItem;
    expndrMNs: TExpander;
    lytAddMn: TLayout;
    rctBtnAddMN: TRectangle;
    FloatAnimation12: TFloatAnimation;
    lytExpMN: TLayout;
    lytMN: TLayout;
    lytMNLeft: TLayout;
    edtMN: TEdit;
    Rectangle6: TRectangle;
    txtSpec: TText;
    rctMN: TRectangle;
    edtAmbList: TEdit;
    rctBackGround: TRectangle;
    lytExpDoctor: TLayout;
    lytPatient: TLayout;
    txtEGN: TText;
    lytEGN: TLayout;
    edtEGN: TEdit;
    lytPatName: TLayout;
    txtPatName: TText;
    edtPatName: TEdit;
    lytDoctorName: TLayout;
    txtDoctorName: TText;
    edtDoctorName: TEdit;
    txtDoctorUin: TText;
    edtDoctorUin: TEdit;
    lytDoctorUin: TLayout;
    txtEndOfLeft: TText;
    linStatusNRN: TLine;
    animNrnStatus: TFloatAnimation;
    lytVisitFor: TLayout;
    lytVisitForHeader: TLayout;
    rctNzisBTN: TRectangle;
    txtNzisStatus: TText;
    rctBtnNzisErr: TRectangle;
    FloatAnimation20: TFloatAnimation;
    pmNzisAction: TPopupMenu;
    mniX013: TMenuItem;
    mniAnulPreg: TMenuItem;
    brshPregled: TBrushObject;
    lbSourceAnsw: TListBox;
    lstSourceAnswOther: TListBoxItem;
    lstSourceAnswPat: TListBoxItem;
    lstSourceAnswDoktor: TListBoxItem;
    lstSourceAnswNotApplay: TListBoxItem;
    lstSourceAnswerNot: TListBoxItem;
    ShadowEffect2: TShadowEffect;
    rctAnswPat: TRectangle;
    rctAnswOther: TRectangle;
    rctAnswDoctor: TRectangle;
    rctAnswNotApplay: TRectangle;
    rctAnswNot: TRectangle;
    pSourceAnsw: TPopup;
    animAnswPat: TFloatAnimation;
    animAnswOther: TFloatAnimation;
    animAnswDoctor: TFloatAnimation;
    Layout9: TLayout;
    Rectangle16: TRectangle;
    FloatAnimation23: TFloatAnimation;
    FloatAnimation24: TFloatAnimation;
    FloatAnimation25: TFloatAnimation;
    rctTest: TRectangle;
    Layout4: TLayout;
    Rectangle15: TRectangle;
    FloatAnimation21: TFloatAnimation;
    FloatAnimation22: TFloatAnimation;
    txt5: TText;
    lytPlanedTypeItem: TLayout;
    rctIconPlanedType: TRectangle;
    txtPlanedTypeCapt: TText;
    txtPlanedTypeDates: TText;
    animPlanedTypeIcon: TFloatAnimation;
    rctBKPlanetTypeItem: TRectangle;
    lytPlanedType: TLayout;
    txtPlanedTypeKey: TText;
    lytDumPlanedType: TLayout;
    rctColorPlan: TRectangle;
    brshAnal: TBrushObject;
    brshKonsult: TBrushObject;
    brshImun: TBrushObject;
    brshNotPregled: TBrushObject;
    FloatAnimation13: TFloatAnimation;
    expndrImun: TExpander;
    Layout5: TLayout;
    rctBtnAddImun: TRectangle;
    FloatAnimation14: TFloatAnimation;
    lytExpImun: TLayout;
    lytImun: TLayout;
    Rectangle18: TRectangle;
    Layout12: TLayout;
    Edit7: TEdit;
    Rectangle19: TRectangle;
    FloatAnimation26: TFloatAnimation;
    Edit8: TEdit;
    Text4: TText;
    GridLayout3: TLayout;
    Text1: TText;
    Edit1: TEdit;
    Edit2: TEdit;
    Text2: TText;
    Edit3: TEdit;
    Text3: TText;
    Edit6: TEdit;
    DateEdit1: TDateEdit;
    Rectangle20: TRectangle;
    FloatAnimation27: TFloatAnimation;
    txt6: TText;
    txtImunName: TText;
    Text5: TText;
    DateEdit2: TDateEdit;
    Rectangle21: TRectangle;
    FloatAnimation28: TFloatAnimation;
    mmoMNReason: TMemo;
    txtMNReason: TText;
    lytMNReason: TLayout;
    txtTxtTypeMN: TText;
    FloatAnimation29: TFloatAnimation;
    lytCaptMN: TLayout;
    Text6: TText;
    lytFrameMN: TLayout;
    edtTypeMN: TEdit;
    Rectangle5: TRectangle;
    FloatAnimation30: TFloatAnimation;
    Edit4: TEdit;
    Rectangle22: TRectangle;
    FloatAnimation31: TFloatAnimation;
    edtSpec: TEdit;
    mmoAddres: TMemo;
    PopupMenu1: TPopupMenu;
    Layout2: TLayout;
    Text7: TText;
    Edit5: TEdit;
    Rectangle17: TRectangle;
    FloatAnimation32: TFloatAnimation;
    Edit9: TEdit;
    Rectangle23: TRectangle;
    FloatAnimation33: TFloatAnimation;
    lytFrameMDN: TLayout;
    Rectangle24: TRectangle;
    FloatAnimation34: TFloatAnimation;
    Rectangle25: TRectangle;
    FloatAnimation35: TFloatAnimation;
    rctSelector: TRectangle;
    animNzisButton: TFloatAnimation;
    animBtnNzisStroke: TFloatAnimation;
    rctTokenPlug: TRectangle;
    FloatAnimation17: TFloatAnimation;
    btnTestHist: TButton;
    mniL009: TMenuItem;
    lytFrameImun: TLayout;
    GridLayout2: TLayout;
    txt2: TText;
    edtMN1: TEdit;
    edtMN2: TEdit;
    txt3: TText;
    edtMn3: TEdit;
    edtMn4: TEdit;
    txt4: TText;
    edtMn5: TEdit;
    edtMN6: TEdit;
    Rectangle26: TRectangle;
    FloatAnimation18: TFloatAnimation;
    Rectangle27: TRectangle;
    FloatAnimation19: TFloatAnimation;
    Rectangle28: TRectangle;
    FloatAnimation36: TFloatAnimation;
    Rectangle29: TRectangle;
    FloatAnimation37: TFloatAnimation;
    Rectangle30: TRectangle;
    FloatAnimation38: TFloatAnimation;
    Rectangle31: TRectangle;
    FloatAnimation39: TFloatAnimation;
    ActionList1: TActionList;
    lytRight: TFlowLayout;
    xpdrDiagn: TExpander;
    Memo1: TMemo;
    lytEndRight: TLayout;
    lytDiagFrame: TLayout;
    lytDiag: TFlowLayout;
    rctMainDiaglabel: TRectangle;
    txtMainDiag: TText;
    rctDiag: TRectangle;
    lytMKB: TLayout;
    edtMainDiag: TEdit;
    rctMkb: TRectangle;
    FloatAnimation41: TFloatAnimation;
    edtAddDiag: TEdit;
    rctMkbAdd: TRectangle;
    FloatAnimation40: TFloatAnimation;
    mmoDiag: TMemo;
    rctAddDiaglabel: TRectangle;
    txtAddDiagLabel: TText;
    Button1: TButton;
    Button2: TButton;
    Rectangle34: TRectangle;
    FloatAnimation42: TFloatAnimation;
    lytDelDiag: TLayout;
    lytNzisStatus: TLayout;
    lytDiagDateFirst: TLayout;
    CheckBox1: TCheckBox;
    Rectangle35: TRectangle;
    DateEdit3: TDateEdit;
    Rectangle36: TRectangle;
    FloatAnimation43: TFloatAnimation;
    Edit10: TEdit;
    Line4: TLine;
    lytDiagClinicStatus: TLayout;
    CheckBox2: TCheckBox;
    Rectangle37: TRectangle;
    Line5: TLine;
    lytDiagVerifStatus: TLayout;
    CheckBox3: TCheckBox;
    Rectangle38: TRectangle;
    Line6: TLine;
    cbbDiagVerifStatus: TComboBox;
    Text9: TText;
    rctBkDiag: TRectangle;
    pDiagVerifStatus: TPopup;
    txtTest: TText;
    txtMkb: TText;
    rctBlankaTransparent: TRectangle;
    txtMkbAdd: TText;
    rctDiagclinicStatusChoice1: TRectangle;
    anim5: TFloatAnimation;
    cbbDiagClinicStatus: TRectangle;
    Text8: TText;
    rctDiagclinicStatusChoice: TRectangle;
    FloatAnimation44: TFloatAnimation;
    clrnmtn1: TColorAnimation;
    clrnmtn2: TColorAnimation;
    Rectangle32: TRectangle;
    rct3: TRectangle;
    txtRczR: TText;
    lytIncMN: TLayout;
    dtdtStartDateTime: TDateEdit;
    Rectangle33: TRectangle;
    FloatAnimation45: TFloatAnimation;
    Rectangle39: TRectangle;
    Layout3: TLayout;
    Text10: TText;
    txtSpecMN: TText;
    txtIsPrimary: TText;
    txtNaprType: TText;
    edtNrnInkNapr: TEdit;
    txtNrnIncNapr: TText;
    edtDateIncNapr: TEdit;
    Text11: TText;
    edtAmbListIncNapr: TEdit;
    Text12: TText;
    Edit11: TEdit;
    Text13: TText;
    Edit12: TEdit;
    Text14: TText;
    Edit13: TEdit;
    Text15: TText;
    Edit14: TEdit;
    Text16: TText;
    Rectangle43: TRectangle;
    FloatAnimation49: TFloatAnimation;
    procedure scrlbx1MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure scrlbx1Resize(Sender: TObject);
    procedure slctnpnt1Track(Sender: TObject; var X, Y: Single);
    procedure FormCreate(Sender: TObject);
    procedure xpdrPatientExpanded(Sender: TObject);
    procedure slctnpnt2Track(Sender: TObject; var X, Y: Single);
    procedure btn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    //procedure slctnpnt3Track(Sender: TObject; var X, Y: Single);
    procedure mmoAddresChangeTracking(Sender: TObject);
    procedure mmoAddresChangeTracking1(Sender: TObject);
    procedure txtAddDiagLabelResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Expander1Resize(Sender: TObject);
    procedure cbb1Change(Sender: TObject);
    procedure cbb1PregledChange(Sender: TObject);
    //procedure cbb1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure cbb1PregMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure BtnMultiMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure cbbOnePregMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure cbbDiagStatusMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure lbComboOneKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure p1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure cbb1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure lbComboOneKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    //procedure cbb1PregApplyStyleLookup(Sender: TObject);
    //procedure chk1ApplyStyleLookup(Sender: TObject);
    procedure flwlyt2Resize(Sender: TObject);
    procedure mmoCL132ChangeTracking(Sender: TObject);
    procedure mmoCL132ChangeTrackingSup(Sender: TObject);
    procedure mmoPregChangeTracking(Sender: TObject);
    procedure mmoPregChangeTrackingSup(Sender: TObject);
    procedure mmo1ChangeTracking(Sender: TObject);
    //procedure mmoCL132KeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure lstItemNomenClick(Sender: TObject);
    procedure lbComboOneChange(Sender: TObject);
    procedure lstOneChange(Sender: TObject);
   // procedure lst1Click(Sender: TObject);
    procedure lstOneClick(Sender: TObject);
    procedure xpdrVisitForResize(Sender: TObject);
    procedure rctBlankaDblClick(Sender: TObject);
    procedure lbComboOneMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure lbComboOneMouseLeave(Sender: TObject);
    procedure scrlbx1ViewportPositionChange(Sender: TObject;
      const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: Boolean);
    procedure scldlyt1Resize(Sender: TObject);
    procedure scrlbx1CalcContentBounds(Sender: TObject;
      var ContentBounds: TRectF);
    procedure cbb1Resize(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure rctBtnSaveLstClickSup(Sender: TObject);
    procedure rctBtnCancelLstClick(Sender: TObject);

    procedure DateArrowClick(Sender: TObject);
    procedure edtCl132Paint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edtCl132PaintSup(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edtADBPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edtADBCalcPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure ComboADBPorpusePaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure ComboADBMdnTypePaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure ComboTestPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edtCl132Validate(Sender: TObject; var Text: string);
    procedure scrlbx1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rctBlankaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rctBlankaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure txtAmbListPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);

    procedure dtdtStartDatePainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure txtAmbListResize(Sender: TObject);
    procedure mmoPregPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure mmoPregPaintingSup(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure mmoPregCl132Painting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure mmoPregCl132PaintingSup(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure xpdrDiagnResize1(Sender: TObject);
    procedure mmoPregValidate(Sender: TObject; var Text: string);
    procedure mmoPregValidateSup(Sender: TObject; var Text: string);
    procedure mmoPregADBValidateSup(Sender: TObject; var Text: string);
    procedure rctDiagPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure lytMdnExpResize(Sender: TObject);
    procedure Rectangle3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure expndrMdnsResize(Sender: TObject);
    procedure RemoveMdnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure RemoveMnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FloatAnimation11Finish(Sender: TObject);
    procedure edtMdnChangeTracking(Sender: TObject);
    procedure edtAnalCodeChangeTracking(Sender: TObject);
    procedure InnerEdtAnalCodeChangeTracking(Sender: TEdit);
    procedure edtMdn1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edt1Popup(Sender: TObject);
    procedure cbb2Popup(Sender: TObject);
    procedure cbbVisitForMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure cbbMdnForMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure lbMdnTypeChange(Sender: TObject);
    procedure lst3Click(Sender: TObject);
    procedure lbPorpuseChange(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure edtCl132ChangeTracking(Sender: TObject);
    procedure edtIzslChangeTracking(Sender: TObject);
    procedure edtAmbListPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    //procedure chk1Change(Sender: TObject);
    //procedure chk1StateChange(Sender: TObject);
    procedure chk1StateChangeSup(Sender: TObject);
    procedure edtCl132Validating(Sender: TObject; var Text: string);
    procedure edtCl132ValidatingSup(Sender: TObject; var Text: string);
    procedure dtdtCl132Painting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure dtdtCl132PaintingSup(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure p1Popup(Sender: TObject);
    procedure p1ClosePopup(Sender: TObject);
    //procedure cbb1Paint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure crcMultiClick(Sender: TObject);
    procedure crcMultiClickLyt(Sender: TObject);
    procedure dtdtCl132CheckChanged(Sender: TObject);
    procedure dtdtCl132CheckChangedSup(Sender: TObject);
    //procedure chk1Painting(Sender: TObject; Canvas: TCanvas;
      //const ARect: TRectF);
    procedure chk1PaintingSup(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure dtdtCl132MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Memo1Resize(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
    procedure lytRightResize(Sender: TObject);
    procedure lytLeftPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure lytbottomPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure rctBackGroundClick(Sender: TObject);
    procedure chkMemoDynMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Rectangle7MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure edtDateRawValidating(Sender: TObject; var Text: string);
    procedure mmoDynEnter(Sender: TObject);
    procedure edtDateRawPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure lytMultiComboResize(Sender: TObject);
    procedure scrlbx1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure lytLeftMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure fltnmtn1Finish(Sender: TObject);
    procedure crcDeleteClick(Sender: TObject);
    procedure LineSaverPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure rctNzisBTNPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure rctNzisBTNClick(Sender: TObject);
    procedure txtNzisStatusPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure rctBtnNzisErrClick(Sender: TObject);
    procedure animNrnStatusFinish(Sender: TObject);
    procedure pmNzisActionPopup(Sender: TObject);
    procedure mniX013Click(Sender: TObject);
    procedure rctAnswMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure lbSourceAnswChange(Sender: TObject);
    procedure lstSourceAnswItemClick(Sender: TObject);
    procedure rctAnswPatClick(Sender: TObject);
    procedure rctAnswOtherClick(Sender: TObject);
    procedure rctAnswDoctorClick(Sender: TObject);
    procedure Rectangle16Click(Sender: TObject);
    procedure xpdrVisitForClick(Sender: TObject);
    procedure xpdrVisitForPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure Rectangle15Click(Sender: TObject);
    procedure Rectangle2Click(Sender: TObject);
    procedure lytPlanedTypePainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure rctIconPlanedTypeClick(Sender: TObject);
    procedure Rectangle20MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure expndrMNsResize(Sender: TObject);
    procedure lytMNResize(Sender: TObject);
    procedure rctBtnAddMNMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rctBtnAddImunMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure expndrImunResize(Sender: TObject);
    procedure animNzisButtonFinish(Sender: TObject);
    procedure rctNzisBTNPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure animBtnNzisStrokeFinish(Sender: TObject);
    procedure rctNzisBTNMouseEnter(Sender: TObject);
    procedure rctNzisBTNMouseLeave(Sender: TObject);
    procedure edtDoctorUinPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edtPatNamePainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edtDoctorNamePainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edtPatNameValidating(Sender: TObject; var Text: string);
    procedure btnTestHistClick(Sender: TObject);
    procedure edtEGNPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure mniL009Click(Sender: TObject);
    procedure expndrMdnsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure lytFrameMDNMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure edtMN1Enter(Sender: TObject);
    procedure edtMN1Exit(Sender: TObject);
    procedure edtMN1ChangeTracking(Sender: TObject);
    procedure edtMN1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure BtnDropDownMN_MKBClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure dtdtStartDateChange(Sender: TObject);
    procedure dtdtStartDateClosePicker(Sender: TObject);
    procedure xpdrDiagnResize(Sender: TObject);
    procedure Rectangle34MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure SelectDiagMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rctMkbAddClick(Sender: TObject);
    procedure rctMkbPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edtMainDiagValidating(Sender: TObject; var Text: string);
    procedure rctDiagMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rctDiagDragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure txtMainDiagDragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure txtMainDiagDragEnter(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);
    procedure txtMainDiagDragDrop(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);
    procedure xpdrDiagnDragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure rctDiagMouseEnter(Sender: TObject);
    procedure linSaverClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure rctBlankaTransparentMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Single);
    procedure rctBlankaTransparentMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rctBlankaTransparentMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure edtMainDiagEnter(Sender: TObject);
    procedure edtMainDiagExit(Sender: TObject);
    procedure mmoDiagMouseEnter(Sender: TObject);
    procedure rctMkbMouseEnter(Sender: TObject);
    procedure cbbDiagVerifStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure TextClinicStatusPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure mmoAddresPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure txtRczRPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure lblAddresPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edtEGNValidating(Sender: TObject; var Text: string);
    procedure Text10Painting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure txtIsPrimaryPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure xpdrDoctorPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure xpdrDoctorClick(Sender: TObject);
    procedure txtNaprTypePainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edtNrnInkNaprPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edtDateIncNaprPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edtAmbListIncNaprPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure Edit11Painting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure Edit12Painting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure Edit13Painting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure Edit14Painting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure txtMkbMdnPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);

    

    //procedure btn1Click(Sender: TObject);
//    procedure btn2Click(Sender: TObject);
//    procedure btn3Click(Sender: TObject);
//    procedure btn4Click(Sender: TObject);
//    procedure slctnpnt1Track(Sender: TObject; var X, Y: Single);
//    procedure scrlbx1ViewportPositionChange(Sender: TObject; const OldViewportPosition, NewViewportPosition: TPointF; const ContentSizeChanged: Boolean);
  private
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    FScaleDyn: Single;
    IsFirstActivate: boolean;
    KeyLocal: HKL;
    ExPointHand: TPointF;
    pAll: TPopup;

    LstExpanders: TList<TExpander>;
    LstExpandersInVisitFor: TList<TExpander>;
    LstMemosLYT: TList<TLayout>;
    LstMemos: TList<TMemo>;
    LstEditsLyt: TList<TLayout>;
    LstEdits: TList<TEdit>;
    LstDateEditsLyt: TList<TLayout>;
    LstDateEdits: TList<TDateEditLabel>;

    LstCombos: TList<TComboBox>;
    LstMultiCombosLYT: TList<TLayout>;
    LstOneCombosLYT: TList<TLayout>;
    LstItemsLst: TList<TListBoxItem>;
    LstChecksSup: TList<TCheckBox>;

    LstMdns: TList<TLayout>;
    LstMns: TList<TLayout>;
    LstImuns: TList<TLayout>;
    LstPlaneds: TList<TPlanedTypeLabel>;

    LstEditsADB: TList<TEditADB>;

    FPatient: TRealPatientNewItem;
    FAspNomenBuf: Pointer;
    FAspNomenPosData: Cardinal;
    FAspNomenHipBuf: Pointer;
    FAspNomenHipPosData: Cardinal;

    FVtrGrapf: TVirtualStringTreeHipp;

    txtCalcMemo: TTextLayout;
    txtCalcEdit: TTextLayout;
    FCl134Coll: TCL134Coll;
    //FExHeightBlanka: Single;
    FAspAdbBuf: Pointer;
    FAspAdbPosData: Cardinal;
    FDoctor: TRealDoctorItem;
    FPregled: TRealPregledNewItem;
    FMaxRightLytHeight: Single;
    FOnAddNewMdn: TActionEventMdnInPregled;
    FlinkPreg: PVirtualNode;
    FOnDeleteNewMdn: TActionEventMdnInPregled;
    FPatientColl: TRealPatientNewColl;
    FPregledColl: TRealPregledNewColl;
    FMdnColl: TRealMDNColl;
    FExamAnalColl: TRealExamAnalysisColl;
    FOnchangeColl: TNotifyEvent;
    FOnAddNewAnal: TActionEventAnalInMdn;
    FOnDeleteNewAnal: TActionEventAnalInMdn;
    FOnChoicerAnal: TNotifyEvent;
    FOnSowHint: TEventShowHint;
    FVtrPregLink: TVirtualStringTreeAspect;
    pr001Temp: TRealPR001Item;
    respTemp: TRealNZIS_QUESTIONNAIRE_RESPONSEItem;
    answTemp: TRealNZIS_QUESTIONNAIRE_ANSWERItem;
    answValTemp: TRealNZIS_ANSWER_VALUEItem;
    DIAGNOSTIC_REPTemp: TRealNZIS_DIAGNOSTIC_REPORTItem;
    RESULT_DIAGNOSTIC_REPTemp: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
    cl088Temp: TRealCl088Item;
    cl134Temp: TRealCl134Item;
    cl139Temp: TRealCL139Item;
    cl144Temp: TRealCl144Item;
    cl142Temp: TRealCl142Item;
    FCl142Coll: TCL142Coll;
    FCl088Coll: TCL088Coll;
    FCl139Coll: TRealCL139Coll;
    Fpr001Coll: TPR001Coll;

    idxListExpander, idxListMemo, idxListCombo, idxListCheck, idxListEdit, idxListitemsBox, idxListDateEdit: Integer;
    idxListMemoLyt, idxListCheckSup, idxListDateEditSup, idxListEditSup, idxListComboMultiSup,
    idxListComboOneSup, idxPlanedType, idxMNs, idxImuns, idxDiags: Integer;

    PatEgnSetProp: TParamSetProp;
    PatNameSetProp: TParamSetProp;
    PerformerUinSetProp: TParamSetProp;
    PerformerNameSetProp: TParamSetProp;

    FCl132Coll: TCL132Coll;
    FIsVtrPregled: Boolean;
    FAspLink: TMappedLinkFile;
    ListVacantPregIndex: TList<Integer>;
    FIssetings: Boolean;
    FCl144Coll: TCL144Coll;
    FOnFillCertInDoctors: TNotifyEvent;
    FOnOpenPregled: TNotifyEvent;
    FOnClosePregled: TNotifyEvent;
    FOnEditPregled: TNotifyEvent;
    FOnOfLinePregled: TNotifyEvent;
    FOnGetPlanedTypeL009: TNotifyEvent;

    FCheckKepCounter: Integer;
    FCheckKep: boolean;
    FSourceAnswerDefault: TSourceAnsw;
    FPlanedTypeColl: TRealNZIS_PLANNED_TYPEColl;
    patNodes: TPatNodes;
    pregNodes: TPregledNodes;
    FAdb_dm: TADBDataModule;
    ListPlaneds: TList<TRealNZIS_PLANNED_TYPEItem>;
    FprofGR: TProfGraph;
    FOnAddNewMn: TActionEventMnInPregled;
    FOnDeleteNewMn: TActionEventMnInPregled;
    FOnAddNewImun: TActionEventImunInPregled;
    FOnDeleteNewImun: TActionEventImunInPregled;
    FOnReShowProfForm: TReShowPregledFMX;
    FCL006Coll: TRealCL006Coll;
    FDoctorColl: TRealDoctorColl;
    FOtherPregleds: TList<PVirtualNode>;
    FOnChoicerMkb: TNotifyEvent;

    FDiagColl: TRealDiagnosisColl;
    FOnDeleteNewDiag: TActionEventDiagInPregled;
    FMkbColl: TMkbColl;
    FOnSelectMkb: TNotifyEvent;
    FTmpVtr: Tobject;
    FNasMesto: TRealNasMestoAspects;
    FIncNaprColl: TRealINC_NAPRColl;
    FCollOtherDoctor: TRealOtherDoctorColl;




    procedure CreateTempItem;
    procedure PositionPopup;
    procedure InitProps;
    procedure InitHelpTags;

    procedure FreeTempItem;
    procedure SetScaleDyn(const Value: Single);
    procedure SetPatientColl(const Value: TRealPatientNewColl);
    procedure SetPregledColl(const Value: TRealPregledNewColl);
    procedure SetPregled(const Value: TRealPregledNewItem);
    procedure SetCheckKepCounter(const Value: Integer);
    procedure SetCheckKep(const Value: boolean);
    procedure SetSourceAnswerDefault(const Value: TSourceAnsw);
    procedure SetAdb_dm(const Value: TADBDataModule);


  public
    //expanderPat: TExpanderDyn;
    //expanderPreg: TExpanderDyn;
    expanderGraph: TExpander;
    cbbVisitFor: TComboBox;
    cbbMdnFor: TComboBox;
    mmoTest: Vcl.StdCtrls.TMemo;
    fmxCntrDyn: TFireMonkeyContainer;
    patNameF, patNameS, patNameL, patEgn: string;
    LstDiags: TList<TRectangle>;

    procedure RepaintEdtEGN;
    procedure RepaintDoctorUIN;
    procedure InitSetings;
    procedure DoTabHandlingXE();
    procedure DragOver(const Data: TDragObject; const Point: TPointF; var Operation: TDragOperation); override;

    procedure ClearBlanka;
    procedure FillProfActivityPreg(Anode: Pointer);
    procedure FillPlanedPreg(PlanNode: Pointer);
    procedure RemovePlanedPreg(PlanNode: Pointer);
    procedure FillRightLYT(dataPreg: PAspRec);
    procedure AddExpanderPreg(idxListExpander: Integer; RunNode: PVirtualNode);
    procedure AddMemoSup(ExpndrLayout: TFlowLayout; pr001: TRealPR001Item; idxListMemosLyt: Integer; RunNodeCL132: PVirtualNode; capt: string);
    procedure AddMemoLYTSup(Layout: TFlowLayout; asp: PAspRec; idxListMemosLyt: Integer; field: word; capt: string);
    procedure AddExpanderMDNs(Layout: TFlowLayout);
    procedure AddExpanderMNs(Layout: TFlowLayout);
    procedure AddExpanderImuns(Layout: TFlowLayout);
    procedure DeleteExpanderMDNs(Layout: TLayout; mdnLabel: TMdnsLabel);
    procedure FillExpanderMDNs1(Layout: TLayout; idxListMdns: integer; mdn: TRealMDNItem);
    procedure FillExpanderMNs1(Layout: TLayout; idxListMns: integer; mn: TRealBLANKA_MED_NAPRItem);
    procedure FillExpanderImmun(Layout: TLayout; idxListImun: integer; Imun: TRealExamImmunizationItem);
    procedure AddDiag(Layout: TFlowLayout; asp: PAspRec; idxListDiags: integer; diag: TRealDiagnosisItem);
    procedure AddDiagInPregled(mkb: string);
    //procedure AddCombo(Expndr: TExpander; idxListCombo: Integer; RunNode: PVirtualNode; capt: string; IsMulti: boolean) overload;
    //procedure AddCombo(ExpndrLayout: TFlowLayout; idxListCombo: Integer; RunNode: PVirtualNode; capt: string; IsMulti: boolean);
    //procedure AddComboPreg(ExpndrLayout: TFlowLayout; idxListCombo: Integer; RunNode: PVirtualNode; capt: string; IsMulti: boolean);
    procedure AddComboPregMultiLYT(ExpndrLayout: TFlowLayout; idxListCombo: Integer; RunNode: PVirtualNode; capt: string; IsMulti: boolean);
    procedure AddComboPregLYT(ExpndrLayout: TFlowLayout; idxListCombo: Integer; RunNode: PVirtualNode; capt: string; IsMulti: boolean);

    //procedure AddCheck(ExpndrLayout: TFlowLayout; idxListCheck: Integer; RunNode: PVirtualNode; capt: string);
    procedure AddCheckSup(ExpndrLayout: TFlowLayout; idxListCheck: Integer; RunNode: PVirtualNode; capt: string);
    procedure AddItemLst(idxListItemLst: Integer; RunNode: PVirtualNode; str: string; var AbsHeight: Single);
    procedure AddEditPregSup(ExpndrLayout: TFlowLayout; pr001: TRealPR001Item; idxListEdits: Integer; RunNodeCL132: PVirtualNode; capt: string);
    procedure RemoveEditPregSup(RunNodeCL132: PVirtualNode);
    procedure RemoveMemoPregSup(RunNodeCL132: PVirtualNode);
    procedure AddPlanedRect(idxPlanedRect: Integer; nodePlan: PVirtualNode; PosDataPlan, posDataCL132: Cardinal);

    procedure AddDateEdtSup(ExpndrLayout: TFlowLayout; idxListDateEdits: Integer; RunNodeCL132: PVirtualNode; capt: string);

    procedure AddEditADB(TempEdit: TEdit; idxListEdits: Integer);


    procedure RecalcBlankaRect;
    procedure RecalcBlankaRect1;
    procedure SetExpanderVisitForHeight;
    procedure ClearListsPreg;
    procedure AddBtnMultiLyt(ComboLabel: TComboMultiLabel; capt: string; Flyt: TFlowLayout);
    procedure CalcComboMulti;
    procedure OnApplicationHint(Sender: TObject);
    procedure AddVacantindexPreg(index: Integer);
    function FindVacantIndexPreg(): integer;
    procedure RemoveLastVacantindexPreg;
    procedure AutoFillControl;
    procedure MarkSourceAnsw(TargetSourceAnsw: TSourceAnsw; TargetRect: TRectangle);
    procedure appEvntsMainException(Sender: TObject; E: Exception);
    procedure ChangePositionScroll(x, y: single);
    procedure VibroControl(node: PVirtualNode);
    procedure WmHelp(mousePos: TPoint);
    procedure ZoomToWidth(W: single);


  property scaleDyn: Single read FScaleDyn write SetScaleDyn;
  property Patient: TRealPatientNewItem read FPatient write FPatient;
  property Pregled: TRealPregledNewItem read FPregled write SetPregled;
  property OtherPregleds: TList<PVirtualNode> read FOtherPregleds write FOtherPregleds;
  property linkPreg: PVirtualNode read FlinkPreg write FlinkPreg;
  property Doctor: TRealDoctorItem read FDoctor write FDoctor;
  property AspNomenBuf: Pointer read FAspNomenBuf write FAspNomenBuf;
  property AspNomenPosData: Cardinal read FAspNomenPosData write FAspNomenPosData;
  property AspNomenHipBuf: Pointer read FAspNomenHipBuf write FAspNomenHipBuf;
  property AspNomenHipPosData: Cardinal read FAspNomenHipPosData write FAspNomenHipPosData;
  property AspAdbBuf: Pointer read FAspAdbBuf write FAspAdbBuf;
  property AspAdbPosData: Cardinal read FAspAdbPosData write FAspAdbPosData;
  property VtrGrapf: TVirtualStringTreeHipp read FVtrGrapf write FVtrGrapf;
  property VtrPregLink: TVirtualStringTreeAspect read FVtrPregLink write FVtrPregLink;
  property Adb_dm: TADBDataModule read FAdb_dm write SetAdb_dm;
  property profGR: TProfGraph read FprofGR write FprofGR;
  //property CL006Coll: TRealCL006Coll read FCL006Coll write FCL006Coll;
//  property Cl132Coll: TCL132Coll read FCl132Coll write FCl132Coll;
//  property Cl139Coll: TRealCL139Coll read FCl139Coll write FCl139Coll;
//  property Cl134Coll: TCL134Coll read FCl134Coll write FCl134Coll;
//  property Cl142Coll: TCL142Coll read FCl142Coll write FCl142Coll;
//  property Cl144Coll: TCL144Coll read FCl144Coll write FCl144Coll;
//  property Cl088Coll: TCL088Coll read FCl088Coll write FCl088Coll;
//  property Pr001Coll: TPR001Coll read FPr001Coll write FPr001Coll;

  property NasMesto: TRealNasMestoAspects read FNasMesto write FNasMesto;
  //property ExHeightBlanka: Single read FExHeightBlanka write FExHeightBlanka;
  property MaxRightLytHeight: Single read FMaxRightLytHeight write FMaxRightLytHeight;
  property IsVtrPregled: Boolean read FIsVtrPregled write FIsVtrPregled;
  property AspLink: TMappedLinkFile read FAspLink write FAspLink;
  property OnAddNewMdn: TActionEventMdnInPregled read FOnAddNewMdn write FOnAddNewMdn;
  property OnAddNewAnal: TActionEventAnalInMdn read FOnAddNewAnal write FOnAddNewAnal;
  property OnDeleteNewMdn: TActionEventMdnInPregled read FOnDeleteNewMdn write FOnDeleteNewMdn;
  property OnDeleteNewAnal: TActionEventAnalInMdn read FOnDeleteNewAnal write FOnDeleteNewAnal;
  property OnAddNewMn: TActionEventMnInPregled read FOnAddNewMn write FOnAddNewMn;
  property OnDeleteNewMn: TActionEventMnInPregled read FOnDeleteNewMn write FOnDeleteNewMn;
  property OnAddNewImun: TActionEventImunInPregled read FOnAddNewImun write FOnAddNewImun;
  property OnDeleteNewImun: TActionEventImunInPregled read FOnDeleteNewImun write FOnDeleteNewImun;
  property OnDeleteNewDiag: TActionEventDiagInPregled read FOnDeleteNewDiag write FOnDeleteNewDiag;



  property OnchangeColl: TNotifyEvent read FOnchangeColl write FOnchangeColl;
  property OnChoicerAnal: TNotifyEvent read FOnChoicerAnal write FOnChoicerAnal;
  property OnChoicerMkb: TNotifyEvent read FOnChoicerMkb write FOnChoicerMkb;
  property OnSelectMkb: TNotifyEvent read FOnSelectMkb write FOnSelectMkb;
  property OnSowHint: TEventShowHint read FOnSowHint write FOnSowHint;
  property OnFillCertInDoctors: TNotifyEvent read FOnFillCertInDoctors write FOnFillCertInDoctors;
  property OnOpenPregled: TNotifyEvent read FOnOpenPregled write FOnOpenPregled;
  property OnClosePregled: TNotifyEvent read FOnClosePregled write FOnClosePregled;
  property OnEditPregled: TNotifyEvent read FOnEditPregled write FOnEditPregled;
  property OnOfLinePregled: TNotifyEvent read FOnOfLinePregled write FOnOfLinePregled;
  property OnGetPlanedTypeL009: TNotifyEvent read FOnGetPlanedTypeL009 write FOnGetPlanedTypeL009;
  property IsSetings: Boolean read FIssetings write FIssetings;
  property CheckKepCounter: Integer read FCheckKepCounter write SetCheckKepCounter;
  property CheckKep: boolean read FCheckKep write SetCheckKep;
  property SourceAnswerDefault: TSourceAnsw read FSourceAnswerDefault write SetSourceAnswerDefault;
  property OnReShowProfForm: TReShowPregledFMX read FOnReShowProfForm write FOnReShowProfForm;
  property TmpVtr: TObject read FTmpVtr write FTmpVtr;


  end;

  const
  HANDFLAT: TCursor = 5;
  HANDGRAB: TCursor = 6;

//var
  //PatientColl
  //frmProfFormFMX: TfrmProfFormFMX;

implementation

{$R *.fmx}

uses
  TempVtrHelper, FmxControls;

procedure TfrmProfFormFMX.AddBtnMultiLyt(ComboLabel: TComboMultiLabel;
  capt: string; Flyt: TFlowLayout);
var
  TempBtnMulti: TSpeedButton; //circle1style
  crc: TCircle;
begin
  TempBtnMulti := TSpeedButton(frmFmxControls.btnMulti.Clone(self));
  ComboLabel.MultiBtns.Add(TempBtnMulti);
  TempBtnMulti.Visible := True;
  txtCalcEdit.MaxSize := PointF(100000, 19);
  txtCalcEdit.Font.Assign(TempBtnMulti.TextSettings.Font);
  txtCalcEdit.Text := capt;
  TempBtnMulti.Trimming := TTextTrimming.Character;
  if Flyt <> flwlytMulti then
  begin
    TempBtnMulti.Width :=  min(txtCalcEdit.TextWidth + 42, Flyt.Width-10);
    TempBtnMulti.Parent := Flyt;
  end
  else
  begin
    TempBtnMulti.Width :=  min(txtCalcEdit.TextWidth + 42, Flyt.Width-10);
    TempBtnMulti.Parent := flwlytMulti;
  end;
  TempBtnMulti.Text := capt;
  crc := WalkChildrenCirc(TempBtnMulti);
  crc.OnClick := crcDeleteClick;
  //if TempBtnMulti.FindStyleResource<TCircle>('circle1style', crc) then
//    crc.OnClick := crcMultiClick;
//  TempBtnMulti.OnApplyStyleLookup := btnMultiApplyStyleLookup;

end;



procedure TfrmProfFormFMX.AddCheckSup(ExpndrLayout: TFlowLayout;
  idxListCheck: Integer; RunNode: PVirtualNode; capt: string);
var
  TempCheckLYT: TLayoutCheck;
  TempCheck: TCheckBox;
  flwlyt: TFlowLayout;
  txt: TText;
begin
  flwlyt := ExpndrLayout;
  if (LstChecksSup.Count - 1) < idxListCheckSup then
  begin
    TempCheck := TCheckBox(frmFmxControls.chkMemoDynOne.Clone(self));
    TempCheckLYT := TLayoutCheck.Create;
    TempCheckLYT.node := RunNode;
    TempCheckLYT.rctNull := WalkChildrenRect(TempCheck);
    TempCheckLYT.rctSourceAnsw := WalkChildrenRectStyle(TempCheck, 'AnswRect');
    TempCheckLYT.rctSourceAnsw.TagObject := TempCheckLYT;
    TempCheckLYT.rctSourceAnsw.OnMouseDown := rctAnswMouseDown;
    TempCheckLYT.rctSourceAnsw.Visible := True;
    TempCheckLYT.SourceAnsw := TSourceAnsw(RunNode.Dummy);

    //TempCheckLYT.rctNull.Width := 22;
    TempCheck.Visible := True;
    //TempCheck.Font.Size := 16;
//    TempCheck.Height := 25;
    //TempCheck.Scale.X := 25/19;
    //TempCheck.Scale.y := 25/19;
    TempCheck.Width := flwlyt.Width - 30; //- flwlyt.Padding.Left - flwlyt.Padding.Right- 20;//zzzzzzzzzzzz
    TempCheck.Tag := nativeint(RunNode);
    TempCheck.TagString := capt;
    LstChecksSup.Add(TempCheck);
    TempCheck.Position.Point := PointF(TempCheck.Position.Point.X, 0);
    TempCheck.Parent := flwlyt;
    TempCheck.TagObject := TempCheckLYT;
    TempCheck.text := capt;
    TempCheck.TextSettings.Trimming := TTextTrimming.Character;
    TempCheckLYT.canValidate := True;
    TempCheckLYT.canValidate := False;
    TempCheck.IsChecked := RunNode.CheckState = csCheckedNormal;
    TempCheckLYT.rctNull.Visible := RunNode.CheckType <> ctCheckBox;
    TempCheckLYT.canValidate := true;
    TempCheck.OnChange := chk1StateChangeSup;
    TempCheck.OnPainting := chk1PaintingSup;
    TempCheck.OnMouseDown := chkMemoDynMouseUp;
    TempCheckLYT.rctSourceAnsw.OnMouseDown := rctAnswMouseDown;
    MarkSourceAnsw(TempCheckLYT.SourceAnsw, TempCheckLYT.rctSourceAnsw);
  end
  else
  begin
    TempCheck := LstChecksSup[idxListCheckSup];
    TempCheckLYT := TLayoutCheck(TempCheck.TagObject);
    TempCheckLYT.node := RunNode;
    TempCheckLYT.SourceAnsw := TSourceAnsw(RunNode.Dummy);

    TempCheck.Position.Point := PointF(TempCheck.Position.Point.X, 0);
    TempCheck.Parent := flwlyt;
    TempCheck.Width := flwlyt.Width - 30;// - flwlyt.Padding.Left - flwlyt.Padding.Right - 20;
    TempCheck.Tag := nativeInt(RunNode);
    TempCheck.text := capt;
    TempCheck.TextSettings.Trimming := TTextTrimming.Character;
    TempCheckLYT.canValidate := False;
    TempCheck.IsChecked := RunNode.CheckState = csCheckedNormal;
    TempCheckLYT.rctNull.Visible := RunNode.CheckType <> ctCheckBox;
    TempCheckLYT.canValidate := true;
    TempCheck.OnChange := chk1StateChangeSup;
    TempCheck.OnPainting := chk1PaintingSup;
    TempCheck.OnMouseDown := chkMemoDynMouseUp;
    MarkSourceAnsw(TempCheckLYT.SourceAnsw, TempCheckLYT.rctSourceAnsw);
  end;
  if idxListCheckSup = 0 then
  begin
    Caption := 'ddd';
  end;
end;





procedure TfrmProfFormFMX.AddComboPregLYT(ExpndrLayout: TFlowLayout;
  idxListCombo: Integer; RunNode: PVirtualNode; capt: string; IsMulti: boolean);
var
  TempComboLYT: TLayout;
  TempComboLabel: TComboOneLabel;
  dataAnswVal, dataRunNode: PAspRec;
  nodeValue: PVirtualNode;
  flwlyt: TFlowLayout;
  str: string;
  i: Integer;
  nomenPos: Cardinal;
begin
  flwlyt := ExpndrLayout;
  if (LstOneCombosLYT.Count - 1) < idxListCombo then
  begin
    TempComboLYT := TLayout(frmFmxControls.lytComboDyn.Clone(self));
    TempComboLabel := TComboOneLabel.Create;

    TempComboLabel.chk := WalkChildrenCheck(TempComboLYT);
    TempComboLabel.rctNull := WalkChildrenRect(TempComboLabel.chk);
    TempComboLabel.rctSourceAnsw := WalkChildrenRectStyle(TempComboLYT, 'AnswRect');
    TempComboLabel.rctSourceAnsw.TagObject := TempComboLabel;
    TempComboLabel.LineSaver := WalkChildrenLine(TempComboLYT);
    TempComboLabel.chk.Text := capt;
    TempComboLabel.chk.Scale.X := 0.7;
    TempComboLabel.chk.Scale.y := 0.7;
    TempComboLabel.cmb := WalkChildrenCombo(TempComboLYT);
    TempComboLabel.txt := WalkChildrenText(TempComboLabel.cmb);
    TempComboLYT.Visible := True;
    TempComboLabel.LineSaver.OnPainting := LineSaverPainting;

    TempComboLYT.Width := flwlyt.Width - flwlyt.Padding.Left - flwlyt.Padding.Right;
    TempComboLabel.node := RunNode;
    TempComboLabel.SourceAnsw := TSourceAnsw(RunNode.Dummy);
    if RunNode.Dummy <> 0 then
      Caption := 'ddd';

    nodeValue := RunNode.FirstChild;
    if nodeValue <> nil then
    begin
      TempComboLabel.chk.IsChecked := true;

      TempComboLabel.rctNull.Visible := false;
      dataRunNode := Pointer(PByte(nodeValue) + lenNode);
      case dataRunNode.vid of
        vvNZIS_ANSWER_VALUE:
        begin
          nomenPos := Adb_DM.CollNZIS_ANSWER_VALUE.getCardMap(dataRunNode.DataPos, word(NZIS_ANSWER_VALUE_NOMEN_POS));
          TempComboLabel.txt.Text := Adb_DM.CL139Coll.getAnsiStringMap(nomenPos, word(CL139_Key)) + '|' +
                 Adb_DM.CL139Coll.getAnsiStringMap(nomenPos, word(CL139_Description));
          TempComboLYT.Margins.Left := 25;
          TempComboLYT.Width := flwlyt.Width - flwlyt.Padding.Left - flwlyt.Padding.Right - 25;
          TempComboLabel.rctSourceAnsw.Visible := True;
          MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);
        end;
        vvNZIS_RESULT_DIAGNOSTIC_REPORT:
        begin
          nomenPos := Adb_DM.CollNzis_RESULT_DIAGNOSTIC_REPORT.getCardMap(dataRunNode.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
          TempComboLabel.txt.Text := Adb_DM.CL144Coll.getAnsiStringMap(nomenPos, word(CL144_Key)) + '|' +
                 Adb_DM.CL144Coll.getAnsiStringMap(nomenPos, word(CL144_Description));
          TempComboLYT.Width := flwlyt.Width - flwlyt.Padding.Left - flwlyt.Padding.Right;
          TempComboLYT.Margins.Left := 5;
          TempComboLabel.rctSourceAnsw.Visible := false;
        end;
      end;

    end
    else
    begin
      dataRunNode := Pointer(PByte(RunNode) + lenNode);
      TempComboLabel.chk.IsChecked := false;
      TempComboLabel.rctNull.Visible := true;
      TempComboLabel.txt.Text := '';
      case dataRunNode.vid of
        vvNZIS_QUESTIONNAIRE_ANSWER:
        begin
          TempComboLYT.Margins.Left := 25;
          TempComboLYT.Width := flwlyt.Width - flwlyt.Padding.Left - flwlyt.Padding.Right - 25;
          TempComboLabel.rctSourceAnsw.Visible := true;
          MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);
        end;
        vvNZIS_RESULT_DIAGNOSTIC_REPORT:
        begin
          TempComboLYT.Width := flwlyt.Width - flwlyt.Padding.Left - flwlyt.Padding.Right;
          TempComboLYT.Margins.Left := 5;
          TempComboLabel.rctSourceAnsw.Visible := false;

        end;
      end;

    end;
    TempComboLabel.rctSourceAnsw.OnMouseDown := rctAnswMouseDown;

    TempComboLabel.chk.Text := capt;
    TempComboLabel.cmb.TagString := capt;
    TempComboLYT.Tag := LstOneCombosLYT.Add(TempComboLYT);
    TempComboLYT.TagObject := TempComboLabel;
    TempComboLYT := LstOneCombosLYT[idxListCombo];
    TempComboLYT.Position.Point := PointF(TempComboLYT.Position.Point.X, 0);
    TempComboLYT.Parent := flwlyt;
    TempComboLabel.cmb.OnMouseDown := cbbOnePregMouseDown;
    //TempComboLYT.OnResize := lytMultiComboResize;

  end
  else
  begin
    TempComboLYT := LstOneCombosLYT[idxListCombo];
    TempComboLabel := TComboOneLabel(TempComboLYT.TagObject);
    TempComboLabel.node := RunNode;

    TempComboLabel.SourceAnsw := TSourceAnsw(RunNode.Dummy);
    if RunNode.Dummy <> 0 then
      Caption := 'ddd';
    //TempComboLabel.rctNull := WalkChildrenRect(TempComboLabel.chk);
    //TempComboLabel.cmb := WalkChildrenCombo(TempComboLYT);
    //TempComboLabel.txt := WalkChildrenText(TempComboLabel.cmb);

    nodeValue := RunNode.FirstChild;
    if nodeValue <> nil then
    begin
      TempComboLabel.chk.IsChecked := true;
      dataRunNode := Pointer(PByte(nodeValue) + lenNode);
      case dataRunNode.vid of
        vvNZIS_ANSWER_VALUE:
        begin
          nomenPos := Adb_DM.CollNZIS_ANSWER_VALUE.getCardMap(dataRunNode.DataPos, word(NZIS_ANSWER_VALUE_NOMEN_POS));
          TempComboLabel.txt.Text := Adb_DM.CL139Coll.getAnsiStringMap(nomenPos, word(CL139_Key)) + '|' +
                 Adb_DM.CL139Coll.getAnsiStringMap(nomenPos, word(CL139_Description));
          TempComboLYT.Width := flwlyt.Width - flwlyt.Padding.Left - flwlyt.Padding.Right - 25;
          TempComboLYT.Margins.Left := 25;
          MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);
        end;
        vvNZIS_RESULT_DIAGNOSTIC_REPORT, vvNZIS_DIAGNOSTIC_REPORT:
        begin
          nomenPos := Adb_DM.CollNzis_RESULT_DIAGNOSTIC_REPORT.getCardMap(dataRunNode.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
          TempComboLabel.txt.Text := Adb_DM.CL144Coll.getAnsiStringMap(nomenPos, word(CL144_Key)) + '|' +
                 Adb_DM.CL144Coll.getAnsiStringMap(nomenPos, word(CL144_Description));
          TempComboLYT.Width := flwlyt.Width - flwlyt.Padding.Left - flwlyt.Padding.Right;
          TempComboLYT.Margins.Left := 5;
        end;
      end;
    end
    else
    begin
      dataRunNode := Pointer(PByte(RunNode) + lenNode);
      case dataRunNode.vid of
        vvNZIS_QUESTIONNAIRE_ANSWER:
        begin
          TempComboLYT.Margins.Left := 25;
          TempComboLYT.Width := flwlyt.Width - flwlyt.Padding.Left - flwlyt.Padding.Right - 25;
          TempComboLabel.rctSourceAnsw.Visible := true;
          MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);
        end;
        vvNZIS_RESULT_DIAGNOSTIC_REPORT:
        begin
          TempComboLYT.Width := flwlyt.Width - flwlyt.Padding.Left - flwlyt.Padding.Right;
          TempComboLYT.Margins.Left := 5;
          TempComboLabel.rctSourceAnsw.Visible := False;
        end;
      end;
      TempComboLabel.chk.IsChecked := false;
      TempComboLabel.rctNull.Visible := true;

      TempComboLabel.txt.text := '';
    end;
    TempComboLabel.chk.Text := capt;
    TempComboLabel.rctSourceAnsw.TagObject := TempComboLabel;
    TempComboLYT.Position.Point := PointF(TempComboLYT.Position.Point.X, 0);
    TempComboLYT.Parent := flwlyt;
    TempComboLYT.Tag := idxListCombo;
    TempComboLabel.cmb.TagString := capt;
    TempComboLabel.cmb.OnMouseDown := cbbOnePregMouseDown;
  end;

end;

procedure TfrmProfFormFMX.AddComboPregMultiLYT(ExpndrLayout: TFlowLayout;
  idxListCombo: Integer; RunNode: PVirtualNode; capt: string; IsMulti: boolean);
var
  TempComboLYT: TLayout;
  TempComboLabel: TComboMultiLabel;
  dataAnswVal, data: PAspRec;
  nodeValue: PVirtualNode;
  flwlyt: TFlowLayout;
  str: string;
  i: Integer;
begin
  flwlyt := ExpndrLayout;
  if (LstMultiCombosLYT.Count - 1) < idxListCombo then
  begin
    TempComboLYT := TLayout(frmFmxControls.lytMultiCombo.Clone(self));
    TempComboLabel := TComboMultiLabel.Create;
    TempComboLabel.chk := WalkChildrenCheck(TempComboLYT);
    TempComboLabel.rctNull := WalkChildrenRect(TempComboLabel.chk);
    TempComboLabel.rctSourceAnsw := WalkChildrenRectStyle(TempComboLYT, 'AnswRect');
    TempComboLabel.rctSourceAnsw.TagObject := TempComboLabel;
    TempComboLabel.chk.Text := capt;
    TempComboLabel.chk.Scale.X := 0.7;
    TempComboLabel.chk.Scale.y := 0.7;
    TempComboLabel.Flyt := WalkChildrenFLYTStyle(TempComboLYT, 'MultiCombo');
    TempComboLabel.rctBtn := WalkChildrenRectStyle(TempComboLYT, 'rctBtnStyle');
    TempComboLabel.rctBtn.TagObject := TempComboLabel;
    TempComboLabel.Flyt.TagObject := TempComboLYT;

    TempComboLYT.Visible := True;


    TempComboLabel.node := RunNode;
    data := Pointer(PByte(RunNode) + lenNode);
    case data.vid of
      vvNZIS_QUESTIONNAIRE_ANSWER:
      begin
        TempComboLYT.Margins.Left := 25;
        TempComboLYT.Width := flwlyt.Width - flwlyt.Padding.Left - flwlyt.Padding.Right - 25;
        TempComboLabel.rctSourceAnsw.Visible := True;
	      
      end;
    end;

    nodeValue := RunNode.FirstChild;
    while nodeValue <> nil do
    begin
      dataAnswVal := Pointer(PByte(nodeValue) + lenNode);
      answValTemp.DataPos := dataAnswVal.DataPos;

      cl139Temp.DataPos := answValTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_NOMEN_POS));
      str := cl139Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Key)) + '|' +
             cl139Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Description));
      AddBtnMultiLyt(TempComboLabel, str, TempComboLabel.Flyt);
      nodeValue := nodeValue.NextSibling;
    end;
    if TempComboLabel.MultiBtns.Count = 0 then
    begin
      TempComboLabel.chk.IsChecked := false;
      TempComboLabel.rctNull.Visible := True;
    end
    else
    begin
      TempComboLabel.chk.IsChecked := true;
      TempComboLabel.rctNull.Visible := false;
    end;
    TempComboLabel.SourceAnsw := TSourceAnsw(RunNode.Dummy);
    MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);

    if RunNode.FirstChild <> nil then
    begin
      TempComboLabel.Flyt.RecalcSize;
      TempComboLYT.Height := Max(InnerChildrenRect(TempComboLabel.Flyt).Height + TempComboLabel.chk.Height, 48); // няма делено на скел-а, защото все още не е дете на скалиращия лейаут
    end
    else
    begin
      TempComboLYT.Height := 50;
    end;
    TempComboLabel.chk.Text := capt;
    TempComboLYT.TagString := capt;
    TempComboLYT.Tag := LstMultiCombosLYT.Add(TempComboLYT);
    TempComboLYT.TagObject := TempComboLabel;
    TempComboLYT := LstMultiCombosLYT[idxListCombo];
    TempComboLYT.Position.Point := PointF(TempComboLYT.Position.Point.X, 0);
    TempComboLYT.Parent := flwlyt;
    TempComboLabel.rctBtn.TagString := capt;
    TempComboLabel.rctBtn.OnMouseDown := BtnMultiMouseDown;
    TempComboLYT.OnResize := lytMultiComboResize;
    TempComboLabel.rctSourceAnsw.Visible := True;
    MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);
    TempComboLabel.rctSourceAnsw.OnMouseDown := rctAnswMouseDown;
  end
  else
  begin
    TempComboLYT := LstMultiCombosLYT[idxListCombo];
    TempComboLabel := TComboMultiLabel(TempComboLYT.TagObject);
    TempComboLabel.chk.Text := capt;
    TempComboLabel.node := RunNode;
    for i := 0 to TempComboLabel.MultiBtns.Count - 1 do
    begin
      TempComboLabel.MultiBtns[i].Parent := nil;
    end;
    TempComboLabel.MultiBtns.Clear;
    nodeValue := RunNode.FirstChild;
    for i := 0 to TempComboLabel.MultiBtns.Count - 1 do
    begin
      TempComboLabel.MultiBtns[i].Parent := nil;
    end;
    while nodeValue <> nil do
    begin
      dataAnswVal := Pointer(PByte(nodeValue) + lenNode);
      answValTemp.DataPos := dataAnswVal.DataPos;

      cl139Temp.DataPos := answValTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_NOMEN_POS));
      str := cl139Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Key)) + '|' +
             cl139Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Description));
      AddBtnMultiLyt(TempComboLabel, str, TempComboLabel.Flyt);
      //AddBtnMultiLyt(TempComboLabel, cl139Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Description)), TempComboLabel.Flyt);
      nodeValue := nodeValue.NextSibling;
    end;
    if TempComboLabel.MultiBtns.Count = 0 then
    begin
      TempComboLabel.chk.IsChecked := false;
      TempComboLabel.rctNull.Visible := True;
    end
    else
    begin
      TempComboLabel.chk.IsChecked := true;
      TempComboLabel.rctNull.Visible := false;
    end;
    TempComboLabel.SourceAnsw := TSourceAnsw(RunNode.Dummy);
    MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);

    if RunNode.FirstChild <> nil then
    begin
      TempComboLabel.Flyt.RecalcSize;
      TempComboLYT.Height := Max(InnerChildrenRect(TempComboLabel.Flyt).Height + TempComboLabel.chk.Height, 48);
    end
    else
    begin
      TempComboLYT.Height := 50;
    end;
    TempComboLabel.rctSourceAnsw.Visible := True;
    TempComboLYT.Position.Point := PointF(TempComboLYT.Position.Point.X, 0);
    TempComboLYT.Parent := flwlyt;
    TempComboLYT.Tag := idxListCombo;

    TempComboLYT.TagString := capt;
    TempComboLabel.rctBtn.TagString := capt;
    TempComboLabel.rctBtn.OnMouseDown := BtnMultiMouseDown;
    TempComboLYT.OnResize := lytMultiComboResize;
    TempComboLabel.rctSourceAnsw.Visible := True;
    MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);
  end;

end;



procedure TfrmProfFormFMX.AddDateEdtSup(ExpndrLayout: TFlowLayout;
  idxListDateEdits: Integer; RunNodeCL132: PVirtualNode; capt: string);
var
  TempDateEditLyt: TLayout;
  TempDateEditLabel: TDateEditLabel;
  data: PAspRec;
begin
  if (LstDateEditsLyt.Count - 1) < idxListDateEdits then
  begin
    TempDateEditLyt := TLayout(frmFmxControls.lytDate.Clone(self));
    TempDateEditLabel := TDateEditLabel.Create;
    TempDateEditLabel.DatEdt := WalkChildrenDate(TempDateEditLyt);
    TempDateEditLabel.edtDat := WalkChildrenEdit(TempDateEditLabel.DatEdt);
    TempDateEditLabel.rctSourceAnsw := WalkChildrenRectStyle(TempDateEditLyt, 'AnswRect');
    TempDateEditLabel.rctSourceAnsw.TagObject := TempDateEditLabel;
    TempDateEditLabel.canValidate := False;
    TempDateEditLabel.edtDat.FontColor := TAlphaColorRec.Black;
    //TempDateEditLabel.edtDat.Text := '';
    TempDateEditLabel.canValidate := true;

    TempDateEditLabel.chk := WalkChildrenCheck(TempDateEditLyt);
    TempDateEditLabel.rctNull := WalkChildrenRect(TempDateEditLabel.chk);
    TempDateEditLabel.chk.Scale.X := 0.7;
    TempDateEditLabel.chk.Scale.y := 0.7;
    TempDateEditLabel.chk.Text := capt;
    TempDateEditLabel.btnCalendar := WalkChildrenRect(TempDateEditLabel.DatEdt);
    TempDateEditLabel.node := RunNodeCL132;
    data := Pointer(PByte(RunNodeCL132) + lenNode);
    case data.vid of
      vvNZIS_QUESTIONNAIRE_ANSWER:
      begin
        TempDateEditLyt.Margins.Left := 25;
        TempDateEditLyt.Width := (ExpndrLayout.Width  - ExpndrLayout.Padding.Left - ExpndrLayout.Padding.Right - 25) ;
        TempDateEditLabel.rctSourceAnsw.Visible := True;
        TempDateEditLabel.SourceAnsw := TSourceAnsw(RunNodeCL132.Dummy);

        if RunNodeCL132.FirstChild <> nil then
        begin
          TempDateEditLabel.chk.IsChecked := True;
          TempDateEditLabel.rctNull.Visible := false;
        end
        else
        begin
          TempDateEditLabel.chk.IsChecked := false;
          TempDateEditLabel.rctNull.Visible := true;
        end;

        MarkSourceAnsw(TempDateEditLabel.SourceAnsw, TempDateEditLabel.rctSourceAnsw);
      end;
      vvNZIS_RESULT_DIAGNOSTIC_REPORT:
      begin
        TempDateEditLyt.Margins.Left := 5;
        TempDateEditLyt.Width := ExpndrLayout.Width  - ExpndrLayout.Padding.Left - ExpndrLayout.Padding.Right ;
      end;
    end;
    TempDateEditLyt.Visible := True;

    TempDateEditLyt.Tag := LstDateEditsLyt.Add(TempDateEditLyt);
    TempDateEditLyt.TagString := capt;
    TempDateEditLyt.TagObject := TempDateEditLabel;
    TempDateEditLyt.Position.Point := PointF(TempDateEditLyt.Position.Point.X, 0);
    TempDateEditLyt.Parent := ExpndrLayout;

    TempDateEditLabel.DatEdt.OnChange := dtdtCl132CheckChangedSup;
    TempDateEditLabel.DatEdt.OnCheckChanged := dtdtCl132CheckChangedSup;
    TempDateEditLabel.DatEdt.OnPainting := dtdtCl132PaintingSup;
    TempDateEditLabel.btnCalendar.OnMouseUp := Rectangle7MouseUp;
    TempDateEditLabel.edtDat.OnValidating := edtDateRawValidating;
    TempDateEditLabel.edtDat.OnPainting := edtDateRawPainting;
    TempDateEditLabel.rctSourceAnsw.OnMouseDown := rctAnswMouseDown;

  end
  else
  begin
    TempDateEditLyt := LstDateEditsLyt[idxListDateEdits];
    TempDateEditLabel := TDateEditLabel(TempDateEditLyt.TagObject);

    TempDateEditLabel.node := RunNodeCL132;
    data := Pointer(PByte(RunNodeCL132) + lenNode);
    case data.vid of
      vvNZIS_QUESTIONNAIRE_ANSWER:
      begin
        TempDateEditLyt.Margins.Left := 25;
        TempDateEditLyt.Width := (ExpndrLayout.Width  - ExpndrLayout.Padding.Left - ExpndrLayout.Padding.Right - 25) ;
        TempDateEditLabel.rctSourceAnsw.Visible := True;
        TempDateEditLabel.SourceAnsw := TSourceAnsw(RunNodeCL132.Dummy);
        if RunNodeCL132.FirstChild <> nil then
        begin
          TempDateEditLabel.chk.IsChecked := True;
          TempDateEditLabel.rctNull.Visible := false;
        end
        else
        begin
          TempDateEditLabel.chk.IsChecked := false;
          TempDateEditLabel.rctNull.Visible := true;
        end;
        MarkSourceAnsw(TempDateEditLabel.SourceAnsw, TempDateEditLabel.rctSourceAnsw);
      end;
      vvNZIS_RESULT_DIAGNOSTIC_REPORT:
      begin
        TempDateEditLyt.Margins.Left := 5;
        TempDateEditLyt.Width := ExpndrLayout.Width  - ExpndrLayout.Padding.Left - ExpndrLayout.Padding.Right ;
      end;
    end;
    TempDateEditLabel.chk.Text := capt;
    TempDateEditLabel.canValidate := False;
    TempDateEditLabel.edtDat.FontColor := TAlphaColorRec.Black;
    TempDateEditLabel.canValidate := true;
    TempDateEditLyt.Position.Point := PointF(TempDateEditLyt.Position.Point.X, 0);
    TempDateEditLyt.Parent := ExpndrLayout;
    TempDateEditLyt.TagString := capt;

    TempDateEditLabel.DatEdt.OnPainting := dtdtCl132PaintingSup;
    TempDateEditLabel.DatEdt.OnChange := dtdtCl132CheckChangedSup;
    TempDateEditLabel.DatEdt.OnCheckChanged := dtdtCl132CheckChangedSup;
    TempDateEditLabel.btnCalendar.OnMouseUp := Rectangle7MouseUp;
  end;
end;

procedure TfrmProfFormFMX.AddDiag(Layout: TFlowLayout; asp: PAspRec; idxListDiags: integer; diag: TRealDiagnosisItem);
var
  TempRect: TRectangle;
  TempDiagLabel: TDiagLabel;
  Lyt: TFlowLayout;
begin
  if Layout = nil then
    Lyt := lytDiag
  else
    Lyt := Layout;
  if (LstDiags.Count - 1) < idxListDiags then
  begin
    TempRect := TRectangle(rctDiag.Clone(self));
    TempRect.Parent := nil;
    TempDiagLabel := TDiagLabel.Create;

    WalkChildrenEdtDiag(TempRect, TempDiagLabel);
    TempDiagLabel.diag := diag;
    if diag <> nil then
    begin
      TempDiagLabel.node := diag.Node;
    end;
    TempDiagLabel.asp := asp;
    //TempDiagLabel.field := field;
    TempDiagLabel.DelDiag := WalkChildrenRectStyle(TempRect, 'DelDiag');
    TempDiagLabel.SelectMain := WalkChildrenRect(TempDiagLabel.edtMain);
    TempDiagLabel.txtMain := WalkChildrenText(TempDiagLabel.SelectMain);
    TempDiagLabel.SelectAdd := WalkChildrenRect(TempDiagLabel.edtAdd);
    TempDiagLabel.mmoDiag := WalkChildrenMemo(TempRect);
    TempDiagLabel.VerifStatus := WalkChildrenComboStyle(TempRect, 'verif');
    TempDiagLabel.ClinicStatus := WalkChildrenRectStyle(TempRect, 'clinic');
    TempDiagLabel.ClinicStatusTXT := WalkChildrenText(TempDiagLabel.ClinicStatus);
    TempDiagLabel.ClinicStatusTXT.OnPaint := TextClinicStatusPainting;

    TempDiagLabel.DelDiag.OnMouseUp := Rectangle34MouseUp;
    TempDiagLabel.SelectMain.OnMouseUp := SelectDiagMainMouseUp;
    TempDiagLabel.SelectMain.OnPainting := rctMkbPainting;
    TempDiagLabel.VerifStatus.OnMouseUp := cbbDiagStatusMouseDown;
    TempDiagLabel.ClinicStatus.OnMouseUp := cbbDiagStatusMouseDown;

    TempRect.Visible := True;
    TempRect.Width := Lyt.Width;//  - Layout.Padding.Left - Layout.Padding.Right ;
    TempRect.Tag := LstDiags.Add(TempRect);
    TempRect.TagObject := TempDiagLabel;
    TempRect.Position.Point := PointF(TempRect.Position.Point.X, 0);
    TempRect.Parent := Lyt;

    //TempRect.OnApplyStyleLookup := mmoPregApplyStyleLookup;
    TempRect.OnPainting := rctDiagPainting;
  end
  else
  begin
    TempRect := LstDiags[idxListDiags];
    TempDiagLabel:= TDiagLabel(LstDiags[idxListDiags].TagObject);
    TempDiagLabel.diag := diag;
    if diag <> nil then
    begin
      TempDiagLabel.node := diag.Node;
    end;
    TempDiagLabel.asp := asp;
    //TempDiagLabel.field := field;
    TempRect.Position.Point := PointF(TempRect.Position.Point.X, 0);
    TempRect.Width := Lyt.Width;
    TempRect.Parent := Lyt;
    TempRect.OnPainting := rctDiagPainting;

  end;
  if idxListDiags = 0 then  //основната диагноза
  begin
    TempRect.SendToBack;
    rctMainDiaglabel.SendToBack;
    TempDiagLabel.SelectMain := WalkChildrenRect(TempDiagLabel.edtMain);
    TempDiagLabel.txtMain := WalkChildrenText(TempDiagLabel.SelectMain);
    TempDiagLabel.SelectAdd := WalkChildrenRect(TempDiagLabel.edtAdd);
    TempDiagLabel.mmoDiag := WalkChildrenMemo(TempRect);
   // TempDiagLabel.DelDiag.OnMouseUp := Rectangle34MouseUp;
    TempDiagLabel.SelectMain.OnMouseUp := SelectDiagMainMouseUp;
    TempDiagLabel.SelectMain.OnPainting := rctMkbPainting;
  end;
  TempRect.OnMouseDown := rctDiagMouseDown;
  TempDiagLabel.edtMain.OnValidating := edtMainDiagValidating;
  TempDiagLabel.edtMain.OnEnter := edtMainDiagEnter;
  TempDiagLabel.edtMain.OnExit := edtMainDiagExit;
end;

procedure TfrmProfFormFMX.AddDiagInPregled(mkb: string);
var
  diag: TRealDiagnosisItem;
begin
  diag := TRealDiagnosisItem(Adb_DM.CollDiag.Add);
  diag.MainMkb := mkb;
  diag.Rank := FPregled.FDiagnosis.Add(diag);



  AddDiag(lytDiag, nil, FPregled.FDiagnosis.Count, nil);
  inc(idxDiags);
  FPregled.FDiagnosis.Add(nil);
  xpdrDiagn.RecalcSize;
  lytDiagFrame.Height := xpdrDiagn.Height + 30;
end;

procedure TfrmProfFormFMX.AddEditADB(TempEdit: TEdit; idxListEdits: Integer);
var
  TempEditAdb: TEditADB;
begin
  if (LstEditsADB.Count - 1) < idxListEdits then
  begin
    TempEditAdb.edt := TempEdit;
    //TempEditLabel.node := RunNodeCL132;
    //TempEdit.Visible := True;
    TempEdit.Tag := LstEditsADB.Add(TempEditAdb);
    //TempEdit.TagString := capt;
    TempEdit := LstEditsADB[idxListEdits].edt;
    //TempEdit.Position.Point := PointF(TempEdit.Position.Point.X, 0);
    //TempEdit.Parent := ExpndrLayout;
    TempEdit.OnPainting := edtADBPaint;
    //TempEdit.OnValidate := edtCl132Validate;
    //TempEdit.OnApplyStyleLookup := edtCl132ApplyStyleLookup;
  end
  else
  begin
    TempEdit := LstEditsADB[idxListEdits].edt;
    TempEditAdb:= LstEditsADB[idxListEdits];
   // TempEditAdb.node := RunNodeCL132;

    TempEdit.OnPainting := edtADBPaint;
    //TempEdit.OnValidate := edtCl132Validate;
//    TempEdit.OnApplyStyleLookup := edtCl132ApplyStyleLookup;
  end;
end;

procedure TfrmProfFormFMX.AddEditPregSup(ExpndrLayout: TFlowLayout;
  pr001: TRealPR001Item; idxListEdits: Integer; RunNodeCL132: PVirtualNode;
  capt: string);
var
  TempEditLYT: TLayout;
  TempEditLabel: TEditLabel;
  NomenPos144: Cardinal;
  dataResDiagRep: PAspRec;
  migach: TFloatAnimation;
begin
  if (LstEditsLyt.Count - 1) < idxListEdits then
  begin
    TempEditLYT := TLayout(frmFmxControls.lytEdit.Clone(self));

    TempEditLabel := TEditLabel.Create;
    TempEditLabel.chk :=  WalkChildrenCheck(TempEditLYT);
    TempEditLabel.rctNull := WalkChildrenRect(TempEditLabel.chk);
    TempEditLabel.edt :=  WalkChildrenEdit(TempEditLYT);
    TempEditLabel.edt.TabOrder := idxListEdits;
    TempEditLabel.rctSourceAnsw := WalkChildrenRectStyle(TempEditLYT, 'AnswRect');
    TempEditLabel.rctSourceAnsw.TagObject := TempEditLabel;
    migach := WalkChildrenAnim(TempEditLabel.edt);
    migach.Enabled := True;
    TempEditLabel.textUnit :=  WalkChildrenTextStyle(TempEditLYT, 'Units');
    TempEditLabel.node := RunNodeCL132;
    dataResDiagRep := pointer(PByte(RunNodeCL132) + lenNode);
    case dataResDiagRep.vid of
      vvNZIS_RESULT_DIAGNOSTIC_REPORT:
      begin
        NomenPos144 := Adb_DM.CollNzis_RESULT_DIAGNOSTIC_REPORT.getCardMap(dataResDiagRep.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
        TempEditLabel.textUnit.Text := FCl144Coll.getAnsiStringMap(NomenPos144, word(CL144_units));
        TempEditLYT.Margins.Left := 5;
        TempEditLYT.Width := ExpndrLayout.Width  - ExpndrLayout.Padding.Left - ExpndrLayout.Padding.Right ;
        TempEditLabel.rctSourceAnsw.Visible := False;
      end;
      vvNZIS_QUESTIONNAIRE_ANSWER:
      begin
        TempEditLabel.textUnit.Text := 'мерна ед.';
        TempEditLYT.Margins.Left := 25;
        TempEditLYT.Width := ExpndrLayout.Width  - ExpndrLayout.Padding.Left - ExpndrLayout.Padding.Right - 20;
        TempEditLabel.rctSourceAnsw.Visible := True;
        TempEditLabel.SourceAnsw := TSourceAnsw(RunNodeCL132.Dummy);
        MarkSourceAnsw(TempEditLabel.SourceAnsw, TempEditLabel.rctSourceAnsw);

      end;
    end;

    TempEditLabel.chk.Scale.X := 0.7;
    TempEditLabel.chk.Scale.y := 0.7;
   // TempEditLabel.chk.FontColor := TAlphaColorRec.Chocolate;
    TempEditLabel.chk.Text := capt;
    TempEditLYT.Visible := True;

    TempEditLYT.Tag := LstEditsLyt.Add(TempEditLYT);
    TempEditLYT.TagString := capt;
    TempEditLYT.TagObject := TempEditLabel;
    TempEditLYT := LstEditsLyt[idxListEdits];
    TempEditLYT.Position.Point := PointF(TempEditLYT.Position.Point.X, 0);
    TempEditLYT.Parent := ExpndrLayout;
    TempEditLabel.edt.OnPaint := edtCl132PaintSup;
    TempEditLabel.edt.OnValidating := edtCl132ValidatingSup;
    TempEditLabel.rctSourceAnsw.OnMouseDown := rctAnswMouseDown;
  end
  else
  begin
    TempEditLYT := LstEditsLyt[idxListEdits];
    TempEditLabel:= TEditLabel(LstEditsLyt[idxListEdits].TagObject);
    TempEditLabel.node := RunNodeCL132;
    dataResDiagRep := pointer(PByte(RunNodeCL132) + lenNode);
    case dataResDiagRep.vid of
      vvNZIS_RESULT_DIAGNOSTIC_REPORT:
      begin
        NomenPos144 := Adb_DM.CollNzis_RESULT_DIAGNOSTIC_REPORT.getCardMap(dataResDiagRep.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
        TempEditLabel.textUnit.Text := FCl144Coll.getAnsiStringMap(NomenPos144, word(CL144_units));
        TempEditLYT.Margins.Left := 5;
        TempEditLYT.Width := ExpndrLayout.Width  - ExpndrLayout.Padding.Left - ExpndrLayout.Padding.Right ;
        TempEditLabel.rctSourceAnsw.Visible := False;
      end;
      vvNZIS_QUESTIONNAIRE_ANSWER:
      begin
        TempEditLabel.textUnit.Text := 'мерна ед.';
        TempEditLYT.Margins.Left := 25;
        TempEditLYT.Width := ExpndrLayout.Width  - ExpndrLayout.Padding.Left - ExpndrLayout.Padding.Right -20;
        TempEditLabel.rctSourceAnsw.Visible := true;
        TempEditLabel.SourceAnsw := TSourceAnsw(RunNodeCL132.Dummy);
        MarkSourceAnsw(TempEditLabel.SourceAnsw, TempEditLabel.rctSourceAnsw);
      end;
    end;
    TempEditLabel.chk.Text := capt;
    TempEditLabel.edt.TabOrder := idxListEdits;
    TempEditLYT.Position.Point := PointF(TempEditLYT.Position.Point.X, 0);
    TempEditLYT.Parent := ExpndrLayout;
    TempEditLYT.TagString := capt;
    TempEditLabel.edt.OnPaint := edtCl132PaintSup;
    TempEditLabel.edt.OnValidating := edtCl132ValidatingSup;
  end;
end;



procedure TfrmProfFormFMX.AddExpanderImuns(Layout: TFlowLayout);
begin
  FillExpanderImmun(lytExpImun, idxImuns, nil);
  Inc(idxImuns);
end;

procedure TfrmProfFormFMX.AddItemLst(idxListItemLst: Integer;
    RunNode: PVirtualNode;str: string; var AbsHeight: Single);
var
  TempLstItem: TListBoxItem;
  data: PAspRec;

begin
  if (LstItemsLst.Count - 1) < idxListItemLst then
  begin
    TempLstItem := TListBoxItem(lstItemNomen.Clone(self));
    TempLstItem.Visible := True;
    //TempLstItem.Width := flwlyt1.Width ;
    TempLstItem.Tag := nativeInt(RunNode);

    LstItemsLst.Add(TempLstItem);
    TempLstItem := LstItemsLst[idxListItemLst];
    TempLstItem.Position.Point := PointF(TempLstItem.Position.Point.X, 0);
    TempLstItem.Parent := frmFmxControls.lbComboOne;
    TempLstItem.Width := frmFmxControls.lbComboOne.Width;
    txtCalcMemo.MaxSize := PointF(frmFmxControls.lbComboOne.Width -22, 100000);
    txtCalcMemo.Text := str;
    TempLstItem.Text := str;
    TempLstItem.Height := txtCalcMemo.Height + 14;

    TempLstItem.OnClick := lstItemNomenClick;
    AbsHeight := AbsHeight + TempLstItem.Height;
    //TempLstItem.OnApplyStyleLookup := lstItemNomenApplyStyleLookup;
  end
  else
  begin
    TempLstItem := LstItemsLst[idxListItemLst];
    TempLstItem.Position.Point := PointF(TempLstItem.Position.Point.X, 0);
    //TempLstItem.Width := flwlyt1.Width ;
    TempLstItem.Parent := frmFmxControls.lbComboOne;
    TempLstItem.Width := frmFmxControls.lbComboOne.Width;
    txtCalcMemo.MaxSize := PointF(frmFmxControls.lbComboOne.Width -22, 100000);
    txtCalcMemo.Text := str;
    TempLstItem.Text := txtCalcMemo.Text;
    TempLstItem.Height := txtCalcMemo.Height + 14;
    AbsHeight := AbsHeight + TempLstItem.Height;
    TempLstItem.Tag := nativeInt(RunNode);
    TempLstItem.OnClick := lstItemNomenClick;

    //TempLstItem.OnApplyStyleLookup := lstItemNomenApplyStyleLookup;
  end;
end;

procedure TfrmProfFormFMX.AddExpanderMDNs(Layout: TFlowLayout);
begin
  FillExpanderMDNs1(lytMdnExp, LstMdns.Count, nil);
end;

procedure TfrmProfFormFMX.AddExpanderMNs(Layout: TFlowLayout);
begin
  FillExpanderMNs1(lytExpMN, idxMNs, nil);
  Inc(idxMNs);
end;

procedure TfrmProfFormFMX.AddExpanderPreg(idxListExpander: Integer;
  RunNode: PVirtualNode);
var
  TempExpndr: TExpander;
  data, dataCl132: PAspRec;
  pr001Key, FindedKey: string;
  i: Integer;
  Lyt: TLayout;
  //PadingLeft: Integer;
begin
  data := pointer(PByte(RunNode) + lenNode);
  case data.vid of
    vvPR001:
    begin
      //datacl132 := pointer(RunNode.Parent);
      //cl132 := FPatient.lstGraph[datacl132.index].Cl132;
      pr001Temp.DataPos := Data.DataPos
    end;
    vvNZIS_QUESTIONNAIRE_RESPONSE:
    begin
      //PadingLeft := 30;
      respTemp.DataPos := Data.DataPos;
      FindedKey := respTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY));
      for i := 0 to Fpr001Coll.Count - 1 do
      begin
        pr001Key := Fpr001Coll.Items[i].getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Nomenclature)) + '|' +
          Fpr001Coll.Items[i].getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Activity_ID));
        if pr001Key = FindedKey then
        begin
          pr001Temp.DataPos := Fpr001Coll.Items[i].DataPos;
          Break;
        end;
      end;
    end;
    vvNZIS_DIAGNOSTIC_REPORT:
    begin
      //PadingLeft := 5;
      DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
      FindedKey := 'CL142|' + DIAGNOSTIC_REPTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_DIAGNOSTIC_REPORT_CL142_CODE));
      for i := 0 to Fpr001Coll.Count - 1 do
      begin
        pr001Key := Fpr001Coll.Items[i].getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Nomenclature)) + '|' +
          Fpr001Coll.Items[i].getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Activity_ID));
        if pr001Key = FindedKey then
        begin
          pr001Temp.DataPos := Fpr001Coll.Items[i].DataPos;
          Break;
        end;
      end;
    end;
  end;
  if (LstExpanders.Count - 1) < idxListExpander then
  begin
    TempExpndr := TExpander(frmFmxControls.expndrCL132.Clone(self));
    //TempExpndr.Padding.Left := PadingLeft;
    TempExpndr.Visible := True;
    TempExpndr.Width := flwlytVizitFor.Width ;
    TempExpndr.Text := pr001Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Description));
    TempExpndr.Tag := nativeint(RunNode);
    LstExpanders.Add(TempExpndr);
    TempExpndr := LstExpanders[idxListExpander];
    TempExpndr.Position.Point := PointF(TempExpndr.Position.Point.X, 0);
    TempExpndr.Parent := flwlytVizitFor;
    TempExpndr.OnResize := Expander1Resize;
    //TempExpndr.OnApplyStyleLookup := expndrCL132ApplyStyleLookup;
    //TempExpndr.NeedStyleLookup;
  end
  else
  begin
    TempExpndr := LstExpanders[idxListExpander];
    //TempExpndr.Padding.Left := PadingLeft;
    //TempExpndr.StyleLookup := 'expndrCL132Style1';
    TempExpndr.Position.Point := PointF(TempExpndr.Position.Point.X, 0);
    TempExpndr.Height := 61;
    TempExpndr.Parent := flwlytVizitFor;
    TempExpndr.Width := flwlytVizitFor.Width ;
    TempExpndr.Text := pr001Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Description));
    TempExpndr.Tag := nativeInt(RunNode);
    TempExpndr.OnResize := Expander1Resize;

    //TempExpndr.OnApplyStyleLookup := expndrCL132ApplyStyleLookup;
  end;
end;

procedure TfrmProfFormFMX.AddMemoLYTSup(Layout: TFlowLayout; asp: PAspRec;
  idxListMemosLyt: Integer; field: word; capt: string);
var
  TempMemoLYT: TLayout;
  TempMemoLabel: TMemoLabel;
  data: PAspRec;

begin
  if (LstMemosLYT.Count - 1) < idxListMemosLyt then
  begin
    TempMemoLYT := TLayout(frmFmxControls.lytMemo.Clone(self));
    TempMemoLabel := TMemoLabel.Create;
    TempMemoLabel.chk := WalkChildrenCheck(TempMemoLYT);
    TempMemoLabel.chk.HitTest := False;
    TempMemoLabel.rctNull := WalkChildrenRect(TempMemoLabel.chk);
    TempMemoLabel.rctSourceAnsw := WalkChildrenRectStyle(TempMemoLYT, 'AnswRect');
    TempMemoLabel.memo := WalkChildrenMemo(TempMemoLYT);
    TempMemoLabel.LineSaver := WalkChildrenLine(TempMemoLYT);
    TempMemoLabel.LineSaver.OnClick := linSaverClick;
    TempMemoLabel.chk.Text := capt;
    TempMemoLabel.chk.Scale.X := 0.7;
    TempMemoLabel.chk.Scale.y := 0.7;
    TempMemoLabel.chk.StyledSettings := [TStyledSetting.Family];
    //TempMemoLabel.chk.FontColor := TAlphaColorRec.red;
    TempMemoLabel.asp := asp;
    TempMemoLYT.Margins.Left := 0;
    TempMemoLabel.rctSourceAnsw.Visible := False;
    TempMemoLabel.field := field;
    TempMemoLabel.node := FPregled.FNode;
    TempMemoLYT.Visible := True;
    TempMemoLYT.Width := Layout.Width  - Layout.Padding.Left - Layout.Padding.Right ;
    TempMemoLYT.Tag := LstMemosLYT.Add(TempMemoLYT);
    //TempMemo.TagString := capt;
    TempMemoLYT.TagObject := TempMemoLabel;
    TempMemoLYT.Position.Point := PointF(TempMemoLYT.Position.Point.X, 0);
    TempMemoLYT.Height := 55;
    TempMemoLYT.Parent := Layout;


    TempMemoLabel.memo.OnPainting := mmoPregPaintingSup;
    TempMemoLabel.memo.OnChangeTracking := mmoPregChangeTrackingSup;
    lytRightResize(TempMemoLabel.memo);
  end
  else
  begin
    TempMemoLYT := LstMemosLYT[idxListMemosLyt];
    TempMemoLYT.Margins.Left := 0;

    TempMemoLabel:= TMemoLabel(LstMemosLYT[idxListMemosLyt].TagObject);
    TempMemoLabel.rctSourceAnsw.Visible := False;
    TempMemoLabel.chk.Text := capt;
    //TempMemoLabel.chk.Scale.X := 0.7;
    //TempMemoLabel.chk.Scale.y := 0.7;
    //TempMemoLabel.chk.FontColor := TAlphaColorRec.Chocolate;
    TempMemoLabel.asp := asp;
    TempMemoLabel.field := field;
    TempMemoLabel.node := FPregled.FNode;
    TempMemoLYT.Position.Point := PointF(TempMemoLYT.Position.Point.X, 0);
    TempMemoLYT.Width := Layout.Width  - Layout.Padding.Left - Layout.Padding.Right ;
    TempMemoLYT.Height := 55;
    TempMemoLYT.Parent := Layout;
    //TempMemoLYT.TagString := capt;
    TempMemoLabel.memo.OnPainting := mmoPregPaintingSup;
    TempMemoLabel.memo.OnChangeTracking := mmoPregChangeTrackingSup;
    lytRightResize(TempMemoLabel.memo);

    //TempMemo.OnApplyStyleLookup := mmoCL132ApplyStyleLookup;
    //TempMemo.OnChangeTracking := mmoCL132ChangeTracking;
  end;

end;

procedure TfrmProfFormFMX.AddMemoSup(ExpndrLayout: TFlowLayout;
  pr001: TRealPR001Item; idxListMemosLyt: Integer; RunNodeCL132: PVirtualNode;
  capt: string);
var
  TempMemoLYT: TLayout;
  TempMemoLabel: TMemoLabel;
  data, dataPr001: PAspRec;
  NodePr001: PVirtualNode;
begin
  NodePr001 := RunNodeCL132.Parent;
  data := Pointer(PByte(NodePr001) + lenNode);
  while data.vid <> vvNZIS_PLANNED_TYPE do
  begin
    NodePr001 := NodePr001.Parent;
    data := Pointer(PByte(NodePr001) + lenNode);
    if data.vid = vvNZIS_PLANNED_TYPE then
    begin
      Break;
    end;
  end;
  capt := capt + '   ' + Adb_DM.CollNZIS_PLANNED_TYPE.getAnsiStringMap(data.DataPos, word(PR001_CL132));
  if (LstMemosLYT.Count - 1) < idxListMemosLyt then
  begin
    TempMemoLYT := TLayout(frmFmxControls.lytMemo.Clone(self));
    TempMemoLabel := TMemoLabel.Create;
    TempMemoLabel.chk := WalkChildrenCheck(TempMemoLYT);
    TempMemoLabel.chk.HitTest := False;
    TempMemoLabel.rctNull := WalkChildrenRect(TempMemoLabel.chk);
    TempMemoLabel.rctSourceAnsw := WalkChildrenRectStyle(TempMemoLYT, 'AnswRect');
    TempMemoLabel.rctSourceAnsw.TagObject := TempMemoLabel;
    TempMemoLabel.memo := WalkChildrenMemo(TempMemoLYT);
    TempMemoLabel.chk.Text := capt;
    TempMemoLabel.chk.Scale.X := 0.7;
    TempMemoLabel.chk.Scale.y := 0.7;
    //TempMemoLabel.chk.FontColor := TAlphaColorRec.Chocolate;
    TempMemoLabel.node := RunNodeCL132;
    data := Pointer(PByte(RunNodeCL132) + lenNode);
    case data.vid of
      vvNZIS_RESULT_DIAGNOSTIC_REPORT, vvNZIS_DIAGNOSTIC_REPORT:
      begin
        TempMemoLYT.Margins.Left := 5;
        TempMemoLYT.Width := ExpndrLayout.Width  - ExpndrLayout.Padding.Left - ExpndrLayout.Padding.Right ;
        TempMemoLabel.rctSourceAnsw.Visible := false;
      end;
      vvNZIS_QUESTIONNAIRE_ANSWER:
      begin
        TempMemoLYT.Margins.Left := 25;
        TempMemoLYT.Width := ExpndrLayout.Width  - ExpndrLayout.Padding.Left - ExpndrLayout.Padding.Right - 25 ;
        TempMemoLabel.rctSourceAnsw.Visible := True;
        TempMemoLabel.SourceAnsw := TSourceAnsw(RunNodeCL132.Dummy);
        MarkSourceAnsw(TempMemoLabel.SourceAnsw, TempMemoLabel.rctSourceAnsw);
      end;
    end;
    TempMemoLYT.Visible := True;

    TempMemoLYT.Tag := LstMemosLYT.Add(TempMemoLYT);
    //TempMemo.TagString := capt;
    TempMemoLYT.TagObject := TempMemoLabel;
    TempMemoLYT.Position.Point := PointF(TempMemoLYT.Position.Point.X, 0);
    TempMemoLYT.Height := 55;
    TempMemoLYT.Parent := ExpndrLayout;
    TempMemoLabel.memo.OnPainting := mmoPregCl132PaintingSup;

    TempMemoLabel.memo.OnChangeTracking := mmoCL132ChangeTrackingSup;
    TempMemoLabel.memo.OnEnter := mmoDynEnter;
    TempMemoLabel.rctSourceAnsw.OnMouseDown := rctAnswMouseDown;
  end
  else
  begin
    TempMemoLYT := LstMemosLYT[idxListMemosLyt];
    TempMemoLabel:= TMemoLabel(LstMemosLYT[idxListMemosLyt].TagObject);
    TempMemoLabel.chk.Text := capt;
    TempMemoLabel.chk.Scale.X := 0.7;
    TempMemoLabel.chk.Scale.y := 0.7;
    //TempMemoLabel.chk.FontColor := TAlphaColorRec.Chocolate;
    TempMemoLabel.node := RunNodeCL132;
    data := Pointer(PByte(RunNodeCL132) + lenNode);
    TempMemoLYT.Position.Point := PointF(TempMemoLYT.Position.Point.X, 0);
    case data.vid of
      vvNZIS_RESULT_DIAGNOSTIC_REPORT, vvNZIS_DIAGNOSTIC_REPORT:
      begin
        TempMemoLYT.Margins.Left := 5;
        TempMemoLYT.Width := ExpndrLayout.Width  - ExpndrLayout.Padding.Left - ExpndrLayout.Padding.Right ;
        TempMemoLabel.rctSourceAnsw.Visible := false;
      end;
      vvNZIS_QUESTIONNAIRE_ANSWER:
      begin
        TempMemoLYT.Margins.Left := 25;
        TempMemoLYT.Width := ExpndrLayout.Width  - ExpndrLayout.Padding.Left - ExpndrLayout.Padding.Right - 25 ;
        TempMemoLabel.rctSourceAnsw.Visible := True;
        TempMemoLabel.SourceAnsw := TSourceAnsw(RunNodeCL132.Dummy);
        MarkSourceAnsw(TempMemoLabel.SourceAnsw, TempMemoLabel.rctSourceAnsw);
      end;
    end;
    TempMemoLYT.Height := 55;
    TempMemoLYT.Parent := ExpndrLayout;
    //TempMemoLYT.TagString := capt;
    TempMemoLabel.memo.OnPainting := mmoPregCl132PaintingSup;
    TempMemoLabel.memo.OnChangeTracking := mmoCL132ChangeTrackingSup;
  end;
end;

procedure TfrmProfFormFMX.AddPlanedRect(idxPlanedRect: Integer; nodePlan: PVirtualNode;
  PosDataPlan, posDataCL132: Cardinal);
var
  TempPlanedRect: TRectangle;
  TempPlanedTypeLabel: TPlanedTypeLabel;
  startDate: string;
  endDate: string;
  Delta: Integer;
  arrStr: TArray<string>;
  repNumber: Integer;
  i: Integer;
begin
  if (LstPlaneds.Count - 1) < idxPlanedType then
  begin
    TempPlanedTypeLabel := TPlanedTypeLabel.create;
    TempPlanedRect := TRectangle(rctBKPlanetTypeItem.Clone(self));
    TempPlanedRect.TagObject := TempPlanedTypeLabel;
    TempPlanedTypeLabel.RctPlan := TempPlanedRect;

    LstPlaneds.Add(TempPlanedTypeLabel);
    TempPlanedTypeLabel.txtKey := WalkChildrenTextStyle(TempPlanedRect, 'txtKey');
    TempPlanedTypeLabel.txtCapt := WalkChildrenTextStyle(TempPlanedRect, 'txtCapt');
    TempPlanedTypeLabel.txtPeriod := WalkChildrenTextStyle(TempPlanedRect, 'txtPeriod');
    TempPlanedTypeLabel.btnIcon := WalkChildrenRectStyle(TempPlanedRect, 'btnIcon');
    TempPlanedTypeLabel.RctColorPlan := WalkChildrenRectStyle(TempPlanedRect, 'ColorPlan');
  end
  else
  begin
    TempPlanedTypeLabel := LstPlaneds[idxPlanedRect];
    TempPlanedRect := TempPlanedTypeLabel.RctPlan;
  end;
  TempPlanedRect.Position.Point := PointF(TempPlanedRect.Position.Point.X, 10000);
  TempPlanedRect.Parent := lytPlanedType;

  TempPlanedRect.Visible := True;
  TempPlanedTypeLabel.PostDataLink := PosDataPlan;
  startDate := DateToStr(Adb_DM.CollNZIS_PLANNED_TYPE.getDateMap(PosDataPlan, word(NZIS_PLANNED_TYPE_StartDate)));
  endDate := DateToStr(Adb_DM.CollNZIS_PLANNED_TYPE.getDateMap(PosDataPlan, word(NZIS_PLANNED_TYPE_EndDate)));
  Delta := Floor(Adb_DM.CollNZIS_PLANNED_TYPE.getDateMap(PosDataPlan, word(NZIS_PLANNED_TYPE_EndDate))) - Floor(UserDate);
  //12.12.2012 - 12.12.2025  (Остават 23 дни до края на плана)

  TempPlanedTypeLabel.txtKey.Text := Adb_DM.CollNZIS_PLANNED_TYPE.getAnsiStringMap(PosDataPlan, word(NZIS_PLANNED_TYPE_CL132_KEY));
  TempPlanedTypeLabel.txtCapt.Text := Adb_DM.Cl132Coll.getAnsiStringMap(posDataCL132, word(CL132_Description));
  repNumber := Adb_DM.CollNZIS_PLANNED_TYPE.getIntMap(PosDataPlan, word(NZIS_PLANNED_TYPE_NumberRep));
  if repNumber > -1 then
  begin
    for i := 0 to Adb_DM.Pr001Coll.Count - 1 do
    begin
      if Adb_DM.Pr001Coll.getAnsiStringMap(Adb_DM.Pr001Coll.Items[i].DataPos, word(PR001_CL132)) = Adb_DM.Cl132Coll.getAnsiStringMap(posDataCL132, word(CL132_Key)) then
      begin
        arrStr := string(Adb_DM.Pr001Coll.getAnsiStringMap(Adb_DM.Pr001Coll.Items[i].DataPos, word(PR001_Activity_ID))).Split([';']);
        repNumber := Min(repNumber, Length(arrStr) - 1);
        TempPlanedTypeLabel.txtCapt.Text := TempPlanedTypeLabel.txtCapt.Text + ' (' + arrStr[repNumber] + ')';
        Break;
      end;
    end;
  end;

  if delta >= 0  then
  begin
    if delta <> 1 then
    begin
      TempPlanedTypeLabel.txtPeriod.Text := Format('%s - %s (Остават %d дни до края на плана)',[startDate, endDate, delta]);
    end
    else
    begin
      TempPlanedTypeLabel.txtPeriod.Text := Format('%s - %s (Остава %d ден до края на плана)',[startDate, endDate, delta]);
    end;
  end
  else
  begin
    if delta <> -1 then
    begin
      TempPlanedTypeLabel.txtPeriod.Text := Format('%s - %s (Минали са %d дни от края на плана)',[startDate, endDate, -delta]);
    end
    else
    begin
      TempPlanedTypeLabel.txtPeriod.Text := Format('%s - %s (Минал е %d ден от края на плана)',[startDate, endDate, -delta]);
    end;
  end;
  case Adb_DM.Cl132Coll.getAnsiStringMap(posDataCL132, word(CL132_CL136_Mapping))[1] of
    '1':
    begin//'|' + cl132Key + '|'
      if NzisPregNotPreg.Contains('|' + Adb_DM.Cl132Coll.getAnsiStringMap(posDataCL132, word(CL132_Key)) + '|') then
      begin
        TempPlanedTypeLabel.btnIcon.Fill.Assign(brshNotPregled.Brush);
      end
      else
      if NzisConsult.Contains('|' + Adb_DM.Cl132Coll.getAnsiStringMap(posDataCL132, word(CL132_Key)) + '|') then
      begin
        TempPlanedTypeLabel.btnIcon.Fill.Assign(brshKonsult.Brush);
      end
      else
      begin
        TempPlanedTypeLabel.btnIcon.Fill.Assign(brshPregled.Brush);
      end;
    end;
    '2': TempPlanedTypeLabel.btnIcon.Fill.Assign(brshAnal.Brush);
    '3', '4': TempPlanedTypeLabel.btnIcon.Fill.Assign(brshImun.Brush);
  end;
  TempPlanedTypeLabel.nodePlan := nodePlan;
  if nodePlan.CheckState <> csUncheckedNormal then
  begin
    TempPlanedRect.Stroke.Thickness := 3;
    TempPlanedTypeLabel.RctColorPlan.Fill.Kind := TBrushKind.Solid;
  end
  else
  begin
    TempPlanedRect.Stroke.Thickness := 1;
    TempPlanedTypeLabel.RctColorPlan.Fill.Kind := TBrushKind.None;
  end;
  TempPlanedTypeLabel.btnIcon.OnClick := rctIconPlanedTypeClick;
end;

procedure TfrmProfFormFMX.AddVacantindexPreg(index: Integer);
begin
  ListVacantPregIndex.Add(index);
end;

procedure TfrmProfFormFMX.animBtnNzisStrokeFinish(Sender: TObject);
begin
  if rctNzisBTN.Stroke.Thickness < 5 then
    rctNzisBTN.Opacity := 1
  else
    rctNzisBTN.Opacity := 0.3;
end;

procedure TfrmProfFormFMX.animNrnStatusFinish(Sender: TObject);
begin
  if not CheckKep then
  begin
    if (CheckKepCounter < 4) then
    begin
      animNrnStatus.Start;
      CheckKepCounter := CheckKepCounter + 1;
    end
    else
    begin
      CheckKep := True;
      CheckKepCounter := 0;
      animNrnStatus.Stop;
    end;
  end
  else
  begin
    animNrnStatus.Start;
  end;
end;

procedure TfrmProfFormFMX.animNzisButtonFinish(Sender: TObject);
begin
  if not CheckKep then
  begin
    if (CheckKepCounter < 4) then
    begin
      animNzisButton.Start;
      CheckKepCounter := CheckKepCounter + 1;
    end
    else
    begin
      CheckKep := True;
      CheckKepCounter := 0;
      animNzisButton.Stop;
    end;
  end
  else
  begin
    animNzisButton.Start;
  end;
end;

procedure TfrmProfFormFMX.appEvntsMainException(Sender: TObject; E: Exception);
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

procedure TfrmProfFormFMX.AutoFillControl;
var
  i: Integer;
  TempCheckLYT: TLayoutCheck;
begin
  for i := 0 to LstChecksSup.Count - 1 do
  begin
    if LstChecksSup[i].Parent = nil then continue ;
    if (Random(100) mod 2) = 0 then
    begin
      TempCheckLYT := TLayoutCheck(LstChecksSup[i].TagObject);
      if TempCheckLYT.rctNull.Visible then
      begin
        TempCheckLYT.rctNull.Visible := false;
        TempCheckLYT.canValidate := False;
         LstChecksSup[i].IsChecked := True;
        TempCheckLYT.canValidate := True;
        VtrPregLink.CheckType[TempCheckLYT.node] := ctCheckBox;
        VtrPregLink.CheckState[TempCheckLYT.node] := csCheckedNormal;
        TempCheckLYT.rctNull.Visible := False;
      end
    end;
  end;

end;

procedure TfrmProfFormFMX.btn1Click(Sender: TObject);
var
  lytLeftHeight, delta: Single;
  lytLeftR: TRectF;
  p1, pAbs: TPointF;
  vScrol: TScrollBar;
  grdLyt: TGridLayout;
begin
  frmFmxControls.lbComboOne.Items[100000].Parse(1);
  btn1.HelpContext := 222;
  //Rectangle13.Fill.Assign(brshbjct1.Brush);
  //lytRightResize(nil);
 // Self.Focused := TDateEditLabel(LstDateEditsLyt[0].TagObject).DatEdt;
  //Self.Focused := TCheckBox(LstChecksSup[0]);
  Exit;
  AddExpanderMDNs(nil);
  //lytMdnExp.EndUpdate;
  //TMdnsLabel(LstMdns[LstMdns.Count - 1].TagObject).MdnsLyt.BeginUpdate;
  //TMdnsLabel(LstMdns[LstMdns.Count - 1].TagObject).MdnsLyt.EndUpdate;
  grdLyt := TMdnsLabel(LstMdns[LstMdns.Count - 1].TagObject).GridLayoutAnals;
  //grdLyt.OnResize := GridLayout1Resize;
  //grdLyt.RecalcSize;
  lytLeft.Width := lytLeft.Width + 100;
  lytLeft.Width := lytLeft.Width - 100;
  //GridLayout1Resize(grdLyt);
  //lytMdnExpResize(nil);
  expndrMdns.Height := InnerChildrenRect(lytMdnExp).Height/FScaleDyn + 50;

end;

procedure TfrmProfFormFMX.BtnMultiMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  idxListItemLst: Integer;
  i, j: Integer;
  cl138Index: string;
  cl139: TCL139Item;
  cl134: TCL134Item;
  str: string;
  AbsH: Single;
  rctBtn: TRectangle;
  node: PVirtualNode;
  data: PAspRec;
  TempComboLabel: TComboMultiLabel;
begin
  rctBtn := TRectangle(Sender);
  TempComboLabel := TComboMultiLabel(rctBtn.TagObject);
  p1.TagObject  := TempComboLabel;
  p1.PlacementTarget := TempComboLabel.Flyt;
  p1.Width := TempComboLabel.Flyt.Width;
  node := TempComboLabel.node;
  data := Pointer(PByte(node) + lenNode);
  AbsH := 5;
  frmFmxControls.lbComboOne.OnChange := nil;
  for idxListItemLst := 0 to LstItemsLst.Count - 1 do
  begin
    LstItemsLst[idxListItemLst].Parent := nil;
  end;
  case data.vid of
    vvCl134, vvNZIS_QUESTIONNAIRE_ANSWER:
    begin
      idxListItemLst := 0;

      for i := 0 to Adb_DM.Cl139Coll.Count - 1 do
      begin
        cl139 := Adb_DM.Cl139Coll.Items[i];
        if not TRectangle(Sender).TagString.StartsWith(cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_cl138))+ '|') then
          Continue;
        str := cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Key)) + '|' +
               cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Description));
        AddItemLst(idxListItemLst, nil, str, AbsH);
        inc(idxListItemLst);
      end;
    end;
    vvCl088, vvNZIS_RESULT_DIAGNOSTIC_REPORT:
    begin
      idxListItemLst := 0;

      for i := 0 to Adb_DM.Cl139Coll.Count - 1 do
      begin
        cl139 := Adb_DM.Cl139Coll.Items[i];
        if not TRectangle(Sender).TagString.StartsWith(cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_cl138)) + '|') then
          Continue;
        str := cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Key)) + '|' +
               cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Description));
        AddItemLst(idxListItemLst, nil, str, AbsH);
        inc(idxListItemLst);
      end;
    end;
    vvPR001:
    begin
      cl138Index := Trim(Copy(TRectangle(Sender).TagString,1, 2));
      idxListItemLst := 0;

      for i := 0 to Adb_DM.Cl139Coll.Count - 1 do
      begin
        cl139 := Adb_DM.Cl139Coll.Items[i];
        if cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_cl138)) <> cl138Index then
          Continue;
        str := cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Key)) + '|' +
               cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Description));
        AddItemLst(idxListItemLst, nil, str, AbsH);
        inc(idxListItemLst);
      end;
    end;
  end;

  frmFmxControls.lbComboOne.Height := AbsH;
  frmFmxControls.lbComboOne.ShowCheckboxes := true;
  frmFmxControls.lbComboOne.OnClick := nil;
  frmFmxControls.rctBtnSaveLst.Visible := True;
  for i := 0 to frmFmxControls.lbComboOne.items.Count - 1 do
    frmFmxControls.lbComboOne.ListItems[i].IsChecked := false;
  for i := 0 to TempComboLabel.MultiBtns.Count - 1 do
  begin
    for j := 0 to frmFmxControls.lbComboOne.items.Count - 1 do
    begin
      if frmFmxControls.lbComboOne.Items[j].Contains(TempComboLabel.MultiBtns[i].Text) then
      begin
        frmFmxControls.lbComboOne.ListItems[j].IsChecked := true;
        Break;
      end;
    end;
  end;
  frmFmxControls.rctBtnCancelLst.Opacity := 0.3;
  frmFmxControls.rctBtnSaveLst.Opacity := 0.3;

  p1.Height := AbsH;
  p1.Popup();
end;

procedure TfrmProfFormFMX.btnTestClick(Sender: TObject);
var
  i: Integer;
  Aflyt: TFlowLayout;
begin
  Aflyt := TFlowLayout(btnTest.TagObject);
  Aflyt.Position.Point := PointF(0, 0);
  //ShowMessage(IntToStr(Tcombobox(Aflyt.Parent.Parent.parent).tag));//Tcombobox(Aflyt.Parent.Parent.parent).tag
  //ShowMessage(IntToStr(AFlyt.ChildrenCount));
  //ShowMessage(IntToStr(LstCombos[strtoint(btnTest.Text)].Flyt.ChildrenCount));
end;

procedure TfrmProfFormFMX.btnTestHistClick(Sender: TObject);
var
  dataPatient, dataPreg: PAspRec;
  P, pPreg: ^Integer;
  PLen: ^Word;
  pData, PData1: PAnsiChar;
  ofset, ofsetPreg, hist: Cardinal;
  PHist: PCardinal;
  listHist: TList<Cardinal>;
  patName: string;
  revs: TList<PVirtualNode>;
begin
  revs := FPregled.RevisionsNodes;
  //Caption := IntToStr(SizeOf(patNodes.patNode^));

  dataPatient := Pointer(PByte(patNodes.patNode) + lenNode);
  dataPreg := Pointer(PByte(FPregled.FNode) + lenNode);

  pPreg := pointer(PByte(Adb_DM.CollPatient.buf) + (dataPreg.DataPos  + 4*word(PregledNew_ID)));
  ofsetPreg := pPreg^ + Adb_DM.CollPatient.posData;

  listHist := TList<Cardinal>.Create;
  p := pointer(PByte(Adb_DM.CollPatient.buf) + (dataPatient.DataPos  + 4*word(PatientNew_SNAME)));
  ofset := p^ + Adb_DM.CollPatient.posData;
  PHist := pointer(PByte(Adb_DM.CollPatient.buf) + ofset - 4);
  while PHist^ <> 0 do
  begin
    ofset := Phist^ + Adb_DM.CollPatient.posData;
    begin
      patName := Adb_DM.CollPatient.getAnsiStringMapOfset(ofset, word(PatientNew_SNAME));
      listHist.Add(ofset)
    end;
    PHist := pointer(PByte(Adb_DM.CollPatient.buf) + ofset - 4); // история на средно име
  end;
  listHist.Free;
  revs.Free;
end;

procedure TfrmProfFormFMX.Button1Click(Sender: TObject);
var
  TempRect: TRectangle;
  TempDiagLabel: TDiagLabel;
begin
  AddDiag(lytDiag, nil, FPregled.FDiagnosis.Count, nil);
  TempRect := LstDiags[idxDiags];
  TempDiagLabel := TDiagLabel(TempRect.TagObject);
  TempDiagLabel.canValidate := False;
  TempDiagLabel.edtMain.Text := '';
  TempDiagLabel.edtAdd.Text := '';
  TempDiagLabel.mmoDiag.Text := '';

  TempDiagLabel.canValidate := true;
  inc(idxDiags);

  FPregled.FDiagnosis.Add(nil);
  xpdrDiagn.RecalcSize;
  lytDiagFrame.Height := xpdrDiagn.Height + 30;
end;

procedure TfrmProfFormFMX.Button2Click(Sender: TObject);
begin
  if Assigned(FOnChoicerMkb) then
    FOnChoicerMkb(FPregled);
end;

procedure TfrmProfFormFMX.CalcComboMulti;
begin

end;

procedure TfrmProfFormFMX.cbb1Change(Sender: TObject);
begin
  TComboBox(sender).Height := TComboBox(sender).ListBox.ItemByIndex(TComboBox(sender).ItemIndex).Height + 5;
end;

procedure TfrmProfFormFMX.cbb1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  //
end;


procedure TfrmProfFormFMX.cbb1PregledChange(Sender: TObject);
begin
  //
end;

procedure TfrmProfFormFMX.cbb1PregMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  idxListItemLst: Integer;
  i, j: Integer;
  cl138Index: string;
  cl139: TCL139Item;
  cl134: TCL134Item;
  str: string;
  AbsH: Single;
  cbb: TComboBox;
  node: PVirtualNode;
  data: PAspRec;
  TempComboLabel: TComboLabel;
begin
  p1.PlacementTarget := TControl(Sender);
  p1.Width := TControl(Sender).Width;

  cbb := TComboBox(Sender);
  TempComboLabel := TComboLabel(cbb.TagObject);
  p1.TagObject  := cbb;
  node := TempComboLabel.node;
  data := Pointer(PByte(node) + lenNode);
  AbsH := 5;
  for idxListItemLst := 0 to LstItemsLst.Count - 1 do
  begin
    LstItemsLst[idxListItemLst].Parent := nil;
  end;
  case data.vid of
    vvCl134, vvNZIS_QUESTIONNAIRE_ANSWER:
    begin
      idxListItemLst := 0;

      for i := 0 to  Adb_DM.Cl139Coll.Count - 1 do
      begin
        cl139 :=  Adb_DM.Cl139Coll.Items[i];
        if not TComboBox(Sender).TagString.StartsWith(cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_cl138))+ '|') then
          Continue;
        str := cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Key)) + '|' +
               cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Description));
        AddItemLst(idxListItemLst, nil, str, AbsH);
        inc(idxListItemLst);
      end;
    end;
    vvCl088, vvNZIS_RESULT_DIAGNOSTIC_REPORT:
    begin
      idxListItemLst := 0;

      for i := 0 to  Adb_DM.Cl139Coll.Count - 1 do
      begin
        cl139 :=  Adb_DM.Cl139Coll.Items[i];
        if not TComboBox(Sender).TagString.StartsWith(cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_cl138)) + '|') then
          Continue;
        str := cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Key)) + '|' +
               cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Description));
        AddItemLst(idxListItemLst, nil, str, AbsH);
        inc(idxListItemLst);
      end;
    end;
    vvPR001:
    begin
      cl138Index := Trim(Copy(TComboBox(Sender).TagString,1, 2));
      idxListItemLst := 0;

      for i := 0 to  Adb_DM.Cl139Coll.Count - 1 do
      begin
        cl139 :=  Adb_DM.Cl139Coll.Items[i];
        if cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_cl138)) <> cl138Index then
          Continue;
        str := cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Key)) + '|' +
               cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Description));
        AddItemLst(idxListItemLst, nil, str, AbsH);
        inc(idxListItemLst);
      end;
    end;
  end;

  frmFmxControls.lbComboOne.Height := AbsH;
  if TempComboLabel.IsMulti then
  begin
    frmFmxControls.lbComboOne.ShowCheckboxes := true;
    frmFmxControls.lbComboOne.OnClick := nil;
    frmFmxControls.rctBtnSaveLst.Visible := True;
    for i := 0 to frmFmxControls.lbComboOne.items.Count - 1 do
      frmFmxControls.lbComboOne.ListItems[i].IsChecked := false;
    for i := 0 to TempComboLabel.MultiBtns.Count - 1 do
    begin
      for j := 0 to frmFmxControls.lbComboOne.items.Count - 1 do
      begin
        if frmFmxControls.lbComboOne.Items[j].Contains(TempComboLabel.MultiBtns[i].Text) then
        begin
          frmFmxControls.lbComboOne.ListItems[j].IsChecked := true;
          Break;
        end;
      end;
    end;
  end
  else
  begin
    frmFmxControls.lbComboOne.ShowCheckboxes := false;
    //lst1.OnClick := lst1Click;
    frmFmxControls.rctBtnSaveLst.Visible := false;
  end;
  frmFmxControls.rctBtnCancelLst.Opacity := 0.3;
  frmFmxControls.rctBtnSaveLst.Opacity := 0.3;
  p1.Height := AbsH;
  p1.Popup();
end;

procedure TfrmProfFormFMX.cbb1Resize(Sender: TObject);
var
  lytLeftHeight, lytRightHeight: Single;
  flwlyt: TFlowLayout;
  xpndr: TExpander;
  cntnt: TContent;
  HExpandHead: Single;
begin
  if TComboBox(Sender).Parent is TFlowLayout then
    flwlyt := TFlowLayout(TComboBox(Sender).Parent)
  else
    Exit;
  flwlyt.RecalcSize;
  flwlyt.Height := InnerChildrenRect(flwlyt).Height / scaleDyn + 15;
  if flwlyt.Parent is TContent then
  begin
    if flwlyt.Parent.Parent is TExpander then
    begin
      xpndr := TExpander(flwlyt.Parent.parent);
      HExpandHead := 55;
    end;
  end
  else
  if flwlyt.Parent is TRectangle then
  begin
    if flwlyt.Parent.Parent.Parent is TExpander then
    begin
      xpndr := TExpander(flwlyt.Parent.parent.Parent);
      HExpandHead := 35
    end;
  end;

  xpndr.Height := (flwlyt.Height  + HExpandHead);
  flwlytVizitFor.RecalcSize;
  flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height / scaleDyn + 15;

  RecalcBlankaRect1;
  SetExpanderVisitForHeight;
end;

procedure TfrmProfFormFMX.cbbVisitForMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if not p3.IsOpen then
  begin
    p3.Popup();
    p3.PlacementTarget := TComboBox(Sender);
  end
  else
  begin
    p3.IsOpen := False;
  end;
end;

procedure TfrmProfFormFMX.ChangePositionScroll(x, y: single);
var
  vScrol: TScrollBar;
begin
   scrlbx1.FindStyleResource<TScrollBar>('vscrollbar', vScrol);
   vScrol.Value := Y;// + scrlbx1.ViewportPosition.y;
end;

procedure TfrmProfFormFMX.cbb2Popup(Sender: TObject);
begin
  //if not TCbb(Sender).Popup.IsOpen then

end;

procedure TfrmProfFormFMX.cbbDiagStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  idxListItemLst: Integer;
  i, j: Integer;
  cl138Index: string;
  cl139: TCL139Item;
  cl134: TCL134Item;
  str: string;
  AbsH: Single;
  cbb: TComboBox;
  node: PVirtualNode;
  data: PAspRec;
  TempDiagLabel: TDiagLabel;
  oldTarget: TControl;
begin
  if TControl(Sender).StyleName = 'clinic' then
  begin
    pAll.BoundsRect := frmFmxControls.lbDiagClinicStatus.BoundsRect;
    frmFmxControls.lbDiagClinicStatus.Parent := pAll;
    frmFmxControls.lbDiagVerifStatus.Parent := nil;
    frmFmxControls.lbDiagClinicStatus.Align := TAlignLayout.Client;
  end
  else
  begin
    pAll.BoundsRect := frmFmxControls.lbDiagVerifStatus.BoundsRect;
    frmFmxControls.lbDiagVerifStatus.Parent := pAll;
    frmFmxControls.lbDiagClinicStatus.Parent := nil;
    frmFmxControls.lbDiagVerifStatus.Align := TAlignLayout.Client;
  end;
  oldTarget := pAll.PlacementTarget;
  pAll.PlacementTarget := TControl(Sender);
  if (pAll.IsOpen) and (oldTarget <> TControl(Sender)) then
  begin
    //TCustomPopupForm(TPopupAll(pAll).PopupForm).ApplyPlacement;
  end
  else
  begin
    if (pAll.IsOpen) then
    begin
      pAll.IsOpen := false;
    end
    else
    begin
      pAll.Popup();
    end;
  end;
end;

procedure TfrmProfFormFMX.cbbMdnForMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if not p2.IsOpen then
  begin
    p2.Popup();
    p2.PlacementTarget := TComboBox(Sender);
  end
  else
  begin
    p2.IsOpen := False;
  end;
end;

procedure TfrmProfFormFMX.cbbOnePregMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  idxListItemLst: Integer;
  i, j: Integer;
  cl138Index: string;
  cl139: TCL139Item;
  cl134: TCL134Item;
  str: string;
  AbsH: Single;
  cbb: TComboBox;
  node: PVirtualNode;
  data: PAspRec;
  TempComboLabel: TComboOneLabel;
begin
  p1.PlacementTarget := TControl(Sender);
  p1.Width := TControl(Sender).Width;

  cbb := TComboBox(Sender);
  TempComboLabel := TComboOneLabel(cbb.Parent.TagObject);
  p1.TagObject  := cbb;
  node := TempComboLabel.node;
  data := Pointer(PByte(node) + lenNode);
  AbsH := 5;
  for idxListItemLst := 0 to LstItemsLst.Count - 1 do
  begin
    LstItemsLst[idxListItemLst].Parent := nil;
  end;
  case data.vid of
    vvCl134, vvNZIS_QUESTIONNAIRE_ANSWER:
    begin
      idxListItemLst := 0;

      for i := 0 to  Adb_DM.Cl139Coll.Count - 1 do
      begin
        cl139 :=  Adb_DM.Cl139Coll.Items[i];
        if not TComboBox(Sender).TagString.StartsWith(cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_cl138))+ '|') then
          Continue;
        str := cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Key)) + '|' +
               cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Description));
        AddItemLst(idxListItemLst, nil, str, AbsH);
        inc(idxListItemLst);
      end;
    end;
    vvCl088, vvNZIS_RESULT_DIAGNOSTIC_REPORT:
    begin
      idxListItemLst := 0;

      for i := 0 to  Adb_DM.Cl139Coll.Count - 1 do
      begin
        cl139 :=  Adb_DM.Cl139Coll.Items[i];
        if not TComboBox(Sender).TagString.StartsWith(cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_cl138)) + '|') then
          Continue;
        str := cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Key)) + '|' +
               cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Description));
        AddItemLst(idxListItemLst, nil, str, AbsH);
        inc(idxListItemLst);
      end;
    end;
    vvPR001:
    begin
      cl138Index := Trim(Copy(TComboBox(Sender).TagString,1, 2));
      idxListItemLst := 0;

      for i := 0 to  Adb_DM.Cl139Coll.Count - 1 do
      begin
        cl139 :=  Adb_DM.Cl139Coll.Items[i];
        if cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_cl138)) <> cl138Index then
          Continue;
        str := cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Key)) + '|' +
               cl139.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL139_Description));
        AddItemLst(idxListItemLst, nil, str, AbsH);
        inc(idxListItemLst);
      end;
    end;
  end;

  frmFmxControls.lbComboOne.Height := AbsH;

  frmFmxControls.lbComboOne.ShowCheckboxes := false;
  frmFmxControls.lbComboOne.OnClick := lstOneClick;
  frmFmxControls.lbComboOne.OnChange := lstOneChange;
  frmFmxControls.rctBtnSaveLst.Visible := false;
  frmFmxControls.rctBtnCancelLst.Opacity := 0.3;
  frmFmxControls.rctBtnSaveLst.Opacity := 0.3;
  p1.Height := AbsH;
  p1.Popup();
end;







procedure TfrmProfFormFMX.chk1PaintingSup(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  chk: TCheckBox;
  TempCheckLYT: TLayoutCheck;
  data: PAspRec;
begin
  Exit;
  chk := TCheckBox(Sender);
  TempCheckLYT := TLayoutCheck(chk.TagObject);
  if FIsVtrPregled then
  begin
    if VtrPregLink.CheckType[TempCheckLYT.node] = ctNone  then
    begin
      TempCheckLYT.rctNull.Visible := True;
    end
    else
    begin
      TempCheckLYT.rctNull.Visible := false;
      if VtrPregLink.CheckState[TempCheckLYT.node] = csCheckedNormal then      //chk.IsChecked
      begin
        chk.IsChecked  := True;
      end
      else
      begin
        chk.IsChecked := False;
      end;
      //VtrPregLink.Selected[TempCheckLYT.node] := True;
    end;
  end;
end;



procedure TfrmProfFormFMX.chk1StateChangeSup(Sender: TObject);
var
  chk: TCheckBox;
  TempCheckLYT: TLayoutCheck;
  data: PAspRec;
begin
  chk := TCheckBox(Sender);
  TempCheckLYT := TLayoutCheck(chk.TagObject);
  if not TempCheckLYT.canValidate then Exit;

  if FIsVtrPregled then
  begin
    if TempCheckLYT.rctNull.Visible then
    begin
      TempCheckLYT.rctNull.Visible := false;
      TempCheckLYT.canValidate := False;
      chk.IsChecked := True;
      TempCheckLYT.canValidate := True;
      VtrPregLink.CheckState[TempCheckLYT.node] := csCheckedNormal;
      VtrPregLink.CheckType[TempCheckLYT.node] := ctCheckBox;

    end
    else
    begin
      VtrPregLink.CheckType[TempCheckLYT.node] := ctCheckBox;
      if chk.IsChecked then
      begin
        VtrPregLink.CheckState[TempCheckLYT.node] := csCheckedNormal;
      end
      else
      begin
        VtrPregLink.CheckState[TempCheckLYT.node] := csUncheckedNormal;
      end;
      //VtrPregLink.Selected[TempCheckLYT.node] := True;
    end;
    MarkSourceAnsw(TempCheckLYT.SourceAnsw, TempCheckLYT.rctSourceAnsw);
  end;
end;

procedure TfrmProfFormFMX.chkMemoDynMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  chk: TCheckBox;
  TempCheckLYT: TLayoutCheck;
  data: PAspRec;
begin
  if Button <> TMouseButton.mbRight then Exit;

  chk := TCheckBox(Sender);
  TempCheckLYT := TLayoutCheck(chk.TagObject);
  if not TempCheckLYT.canValidate then Exit;

  if FIsVtrPregled then
  begin
    TempCheckLYT.rctNull.Visible := true;
    TempCheckLYT.canValidate := False;
    chk.IsChecked := false;
    TempCheckLYT.canValidate := True;
    VtrPregLink.CheckState[TempCheckLYT.node] := csUncheckedNormal;
    VtrPregLink.CheckType[TempCheckLYT.node] := ctNone;
    MarkSourceAnsw(TempCheckLYT.SourceAnsw, TempCheckLYT.rctSourceAnsw);
  end;

end;


procedure TfrmProfFormFMX.ClearBlanka;
var
  i: Integer;
  TempComboLabel: TComboOneLabel;
begin
  if dtdtStartDateTime.IsPickerOpened then
  begin
    dtdtStartDateTime.OnClosePicker := nil;
    dtdtStartDateTime.ClosePicker;
    dtdtStartDateTime.OnClosePicker := dtdtStartDateClosePicker;
  end;
  Self.Focused := nil;
  //rctSelector.Parent := nil;
  for i := 0 to LstExpanders.Count - 1 do
  begin
    LstExpanders[i].Parent := nil;
    LstExpanders[i].IsExpanded := True;

    //LstExpanders[i].ChildrenCount;
  end;
  for i := 0 to LstDiags.Count - 1 do
  begin
    LstDiags[i].Parent := nil;
  end;

  for i := 0 to LstMemosLYT.Count - 1 do
  begin
    LstMemosLYT[i].Parent := nil;
    TMemoLabel(LstMemosLYT[i].TagObject).chk.IsChecked := False;
    TMemoLabel(LstMemosLYT[i].TagObject).rctNull.Visible := true;
    TMemoLabel(LstMemosLYT[i].TagObject).canValidate := False;
    TMemoLabel(LstMemosLYT[i].TagObject).memo.Text := '';
    TMemoLabel(LstMemosLYT[i].TagObject).canValidate := true;
    //LstMemosLYT[i].edt.clear := nil;
  end;
  for i := 0 to LstDateEditsLyt.Count - 1 do
  begin
    LstDateEditsLyt[i].Parent := nil;
    TDateEditLabel(LstDateEditsLyt[i].TagObject).canValidate := False;
    TDateEditLabel(LstDateEditsLyt[i].TagObject).edtDat.Text := '';
    TDateEditLabel(LstDateEditsLyt[i].TagObject).DatEdt.IsChecked := false;
    TDateEditLabel(LstDateEditsLyt[i].TagObject).DatEdt.Date := UserDate;
    TDateEditLabel(LstDateEditsLyt[i].TagObject).canValidate := true;
  end;
  for i := 0 to LstMemos.Count - 1 do
  begin
    LstMemos[i].Parent := nil;
    //TMemoLabel(LstMemos[i]).nodeValue := nil;
  end;
  for i := 0 to LstEdits.Count - 1 do
  begin
    LstEdits[i].Parent := nil;
  end;
  for i := 0 to LstEditsLyt.Count - 1 do
  begin
    LstEditsLyt[i].Parent := nil;
    TEditLabel(LstMemosLYT[i].TagObject).chk.IsChecked := False;
    TEditLabel(LstMemosLYT[i].TagObject).rctNull.Visible := true;
    //TEditLabel(LstMemosLYT[i].TagObject).edt.Text := '';
  end;

  for i := 0 to LstChecksSup.Count - 1 do
  begin
    LstChecksSup[i].Parent := nil;
  end;
  for i := 0 to LstDateEdits.Count - 1 do
  begin
    LstDateEdits[i].DatEdt.Parent := nil;
  end;
  for i := 0 to LstItemsLst.Count - 1 do
  begin
    LstItemsLst[i].IsChecked := False;
    LstItemsLst[i].Parent := nil;
  end;
  for i := 0 to LstCombos.Count - 1 do
  begin
    //if LstCombos[idxListCombo].Flyt <> nil then
//    begin
//      LstCombos[idxListCombo].Flyt.DeleteChildren;
//    end;
    LstCombos[i].Parent := nil;
  end;
  for i := 0 to LstMultiCombosLYT.Count - 1 do
  begin
    LstMultiCombosLYT[i].Parent := nil;
  end;
  for i := 0 to LstOneCombosLYT.Count - 1 do
  begin
    LstOneCombosLYT[i].Parent := nil;
    TempComboLabel := TComboOneLabel(LstOneCombosLYT[i].TagObject);
    TempComboLabel.SourceAnsw := TSourceAnsw.saNone;
    TempComboLabel.chk.IsChecked := false;
  end;
  for i := 0 to LstPlaneds.Count - 1 do
  begin
    LstPlaneds[i].RctPlan.Parent := nil;
  end;


  flwlytVizitFor.RecalcSize;
  flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height + 15;
  lytVisitForHeader.Height := 100;
  SetExpanderVisitForHeight;
  lytMdnExp.Height := 350;

  idxListExpander := 0;
  idxListMemo := 0;
  idxListMemoLyt := 0;
  idxListCombo := 0;
  idxListEdit := 0;
  idxListEditSup := 0;
  idxListCheck := 0;
  idxListCheckSup := 0;
  idxListDateEdit := 0;
  idxListDateEditSup := 0;
  idxListComboMultiSup := 0;
  idxListComboOneSup := 0;
  idxPlanedType := 0;
  idxMNs := 0;
  idxImuns := 0;
  idxDiags := 0;
end;

procedure TfrmProfFormFMX.ClearListsPreg;
var
  i, j: Integer;
  diag: TRealDiagnosisItem;
begin
  if (FPregled.FDiagnosis <> nil) and  (FPregled.CanDeleteDiag) then
  begin
    for i := 0 to FPregled.FDiagnosis.Count - 1 do
    begin
      if FPregled.FDiagnosis[i] = nil then Continue;
      if FPregled.FDiagnosis[i].PRecord <> nil then Continue;
      if FPregled.FDiagnosis[i].MkbNode <> nil then Continue;

      FPregled.FDiagnosis[i].Destroy;
      FPregled.FDiagnosis[i]:= nil;
    end;
    FPregled.FDiagnosis.Clear;
  end;

  if FPregled.FMdns <> nil then
  begin
    for i := 0 to FPregled.FMdns.Count - 1 do
    begin
      if FPregled.FMdns[i].PRecord <> nil then
      begin
        for j := 0 to FPregled.FMdns[i].FExamAnals.Count - 1 do
        begin
          if FPregled.FMdns[i].FExamAnals[j].PRecord <> nil then Continue;
          FPregled.FMdns[i].FExamAnals[j].Destroy;
          FPregled.FMdns[i].FExamAnals[j] := nil;
        end;
        FPregled.FMdns[i].FExamAnals.Clear;
        Continue;
      end;
      FPregled.FMdns[i].Destroy;
      FPregled.FMdns[i]:= nil;
    end;
    FPregled.FMdns.Clear;
  end;

  if FPregled.FMns <> nil then
  begin
    for i := 0 to FPregled.FMns.Count - 1 do
    begin
      if FPregled.FMns[i].PRecord <> nil then
      begin
        Continue;
      end;
      FPregled.FMns[i].Destroy;
      FPregled.FMns[i]:= nil;
    end;
    FPregled.FMns.Clear;
  end;

  if FPregled.FImmuns <> nil then
  begin
    for i := 0 to FPregled.FImmuns.Count - 1 do
    begin
      if FPregled.FImmuns[i].PRecord <> nil then
      begin
        Continue;
      end;
      FPregled.FImmuns[i].Destroy;
      FPregled.FImmuns[i]:= nil;
    end;
    FPregled.FImmuns.Clear;
  end;
end;

procedure TfrmProfFormFMX.ComboADBMdnTypePaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  cbb: TComboBox;
  txt: TText;
  preg: TRealPregledNewItem;
begin
  if p2.IsOpen then Exit;

  cbb := TComboBox(sender);
  if cbb.TagObject is TRealPregledNewItem then
  begin
    preg := TRealPregledNewItem(cbb.TagObject);
    case preg.Porpuse[AspAdbBuf, AspAdbPosData] of
      TLogicalPregledNew.IS_CONSULTATION: lbMdnType.ItemIndex := 0;
      TLogicalPregledNew.IS_PREVENTIVE_Childrens: lbMdnType.ItemIndex := 7;
      TLogicalPregledNew.IS_PREVENTIVE_Maternal: lbMdnType.ItemIndex := 6;
      TLogicalPregledNew.IS_PREVENTIVE_Adults: lbMdnType.ItemIndex := 4;
      TLogicalPregledNew.IS_RISK_GROUP: lbMdnType.ItemIndex := 4;
      TLogicalPregledNew.IS_DISPANSERY: lbMdnType.ItemIndex := 2;
      TLogicalPregledNew.IS_VSD: lbMdnType.ItemIndex := 0;
      TLogicalPregledNew.IS_RECEPTA_HOSPIT: lbMdnType.ItemIndex := 0;
      TLogicalPregledNew.IS_EXPERTIZA: lbMdnType.ItemIndex := 3;
      TLogicalPregledNew.IS_TELK: lbMdnType.ItemIndex := 5;
    end;
    if lbMdnType.ItemIndex > -1 then
    begin
      if cbb.FindStyleResource<TText>('text1style', txt) then
      begin
        try
          txt.Text := lbMdnType.ListItems[lbMdnType.ItemIndex].Text;
        except

        end;
      end;
    end
    else
    begin
      //txt.Text := '';
    end;
  end;
end;

procedure TfrmProfFormFMX.ComboADBPorpusePaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  cbb: TComboBox;
  txt: TText;
  preg: TRealPregledNewItem;
begin
  if p3.IsOpen then Exit;

  cbb := TComboBox(sender);
  if cbb.TagObject is TRealPregledNewItem then
  begin
    preg := TRealPregledNewItem(cbb.TagObject);
    case preg.Porpuse[AspAdbBuf, AspAdbPosData] of
      TLogicalPregledNew.IS_CONSULTATION: lbPorpuse.ItemIndex := 0;
      TLogicalPregledNew.IS_PREVENTIVE_Childrens: lbPorpuse.ItemIndex := 1;
      TLogicalPregledNew.IS_PREVENTIVE_Maternal: lbPorpuse.ItemIndex := 2;
      TLogicalPregledNew.IS_PREVENTIVE_Adults: lbPorpuse.ItemIndex := 3;
      TLogicalPregledNew.IS_RISK_GROUP: lbPorpuse.ItemIndex := 4;
      TLogicalPregledNew.IS_DISPANSERY: lbPorpuse.ItemIndex := 5;
      TLogicalPregledNew.IS_VSD: lbPorpuse.ItemIndex := 6;
      TLogicalPregledNew.IS_RECEPTA_HOSPIT: lbPorpuse.ItemIndex := 7;
      TLogicalPregledNew.IS_EXPERTIZA: lbPorpuse.ItemIndex := 8;
      TLogicalPregledNew.IS_TELK: lbPorpuse.ItemIndex := 9;
    end;
    if lbPorpuse.ItemIndex > -1 then
    begin
      if cbb.FindStyleResource<TText>('text1style', txt) then
      begin
        try
          txt.Text := lbPorpuse.ListItems[lbPorpuse.ItemIndex].Text;
        except

        end;
      end;
    end
    else
    begin
      //txt.Text := '';
    end;
  end;
end;

procedure TfrmProfFormFMX.cbbDiagVerifStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  idxListItemLst: Integer;
  i, j: Integer;
  cl138Index: string;
  cl139: TCL139Item;
  cl134: TCL134Item;
  str: string;
  AbsH: Single;
  cbb: TComboBox;
  node: PVirtualNode;
  data: PAspRec;
  TempDiagLabel: TDiagLabel;
begin
  if frmFmxControls.pDiagVerifStatus.IsOpen then
  begin
     //frmFmxControls.pDiagVerifStatus.IsOpen  := False;
    //TCommonCustomForm(frmFmxControls.pDiagClinicStatus).Close;
    //frmFmxControls.pDiagClinicStatus.PlacementTarget := TControl(Sender);
    //Exit;
  end;
  frmFmxControls.pDiagClinicStatus.PlacementTarget := TControl(Sender);
  frmFmxControls.pDiagClinicStatus.Width := frmFmxControls.lbDiagClinicStatus.Width;
  frmFmxControls.pDiagClinicStatus.Height :=frmFmxControls.lbDiagClinicStatus.Height;
  frmFmxControls.pDiagClinicStatus.Scale.X := FScaleDyn;
  frmFmxControls.pDiagClinicStatus.Scale.Y := FScaleDyn;

  frmFmxControls.pDiagClinicStatus.Popup();
end;

procedure TfrmProfFormFMX.ComboTestPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  cbb: TComboBox;
begin
  cbb := WalkChildrenCombo(TEdit(Sender));
  if cbb <> nil then
    cbb.OnMouseDown := cbbVisitForMouseDown;
end;

procedure TfrmProfFormFMX.crcDeleteClick(Sender: TObject);
var
  i: integer;
  TempComboLYT: TLayout;
  TempComboLabel: TComboMultiLabel;
  TempBtnMulti: TSpeedButton;
  nodeValue: PVirtualNode;
  dataValue, dataCl139: PAspRec;
  //tcircle(Sender).parent.parent.parent.parent.parent.classname
begin
  TempComboLYT := TLayout(tcircle(Sender).parent.parent.parent.parent.parent);///zzzz
  TempComboLabel := TComboMultiLabel(TempComboLYT.TagObject);
  TempBtnMulti := TSpeedButton(tcircle(Sender).parent.parent); //zzzz
  for i := 0 to TempComboLabel.MultiBtns.Count - 1 do
  begin
    if TempBtnMulti = TempComboLabel.MultiBtns[i] then
    begin
      TempBtnMulti.Parent := nil;
      nodeValue := TempComboLabel.GetNodeValueFromText(TempBtnMulti.Text,  Adb_DM.CollNZIS_ANSWER_VALUE);
      FAspLink.MarkDeletedNode(nodeValue);// махам го от дървото
      TempComboLabel.MultiBtns.Delete(i);
      Break;
    end;
  end;
  TempComboLabel.Flyt.RecalcSize;
  if TempComboLabel.MultiBtns.Count = 0 then
  begin
    TempComboLabel.chk.IsChecked := false;
    TempComboLabel.rctNull.Visible := True;
  end
  else
  begin
    TempComboLabel.chk.IsChecked := true;
    TempComboLabel.rctNull.Visible := false;
  end;
  MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);
  TempComboLYT.Height := Max(InnerChildrenRect(TempComboLabel.Flyt).Height/scaleDyn + TempComboLabel.chk.Height, 48);
end;

procedure TfrmProfFormFMX.crcMultiClick(Sender: TObject);
var
  i: integer;
  TempCombo: TComboBox;
  TempComboLabel: TComboLabel;
  TempBtnMulti: TSpeedButton;
  nodeValue: PVirtualNode;
  dataValue, dataCl139: PAspRec;

begin
  TempCombo := TComboBox(tcircle(Sender).parent.parent.parent.parent.parent.parent);///zzzz
  TempComboLabel := TComboLabel(TempCombo.TagObject);
  TempBtnMulti := TSpeedButton(tcircle(Sender).parent.parent.parent.parent); //zzzz
  for i := 0 to TempComboLabel.MultiBtns.Count - 1 do
  begin
    if TempBtnMulti = TempComboLabel.MultiBtns[i] then
    begin
      TempBtnMulti.Parent := nil;
      nodeValue := TempComboLabel.GetNodeValueFromText(TempBtnMulti.Text,  Adb_DM.CollNZIS_ANSWER_VALUE);
      FAspLink.MarkDeletedNode(nodeValue);// махам го от дървото
      TempComboLabel.MultiBtns.Delete(i);
      Break;
    end;
  end;
  TempComboLabel.Flyt.RecalcSize;
  TempCombo.Height := Max(InnerChildrenRect(TempComboLabel.Flyt).Height/scaleDyn + 6, 25);
end;

procedure TfrmProfFormFMX.crcMultiClickLyt(Sender: TObject);
var
  i: integer;
  TempCombo: TComboBox;
  TempComboLabel: TComboLabel;
  TempBtnMulti: TSpeedButton;
  nodeValue: PVirtualNode;
  dataValue, dataCl139: PAspRec;

begin
  TempCombo := TComboBox(tcircle(Sender).parent.parent.parent.parent.parent.parent);///zzzz
  TempComboLabel := TComboLabel(TempCombo.TagObject);
  TempBtnMulti := TSpeedButton(tcircle(Sender).parent.parent.parent.parent); //zzzz
  for i := 0 to TempComboLabel.MultiBtns.Count - 1 do
  begin
    if TempBtnMulti = TempComboLabel.MultiBtns[i] then
    begin
      TempBtnMulti.Parent := nil;
      nodeValue := TempComboLabel.GetNodeValueFromText(TempBtnMulti.Text,  Adb_DM.CollNZIS_ANSWER_VALUE);
      FAspLink.MarkDeletedNode(nodeValue);// махам го от дървото
      TempComboLabel.MultiBtns.Delete(i);
      Break;
    end;
  end;
  TempComboLabel.Flyt.RecalcSize;
  TempCombo.Height := Max(InnerChildrenRect(TempComboLabel.Flyt).Height/scaleDyn + 6, 25);
end;

procedure TfrmProfFormFMX.CreateTempItem;
begin
  pr001Temp := TRealPR001Item.Create(nil);
  cl088Temp := TRealCl088Item.Create(nil);
  cl134Temp := TRealCl134Item.Create(nil);
  cl139Temp := TRealCl139Item.Create(nil);
  cl144Temp := TRealCl144Item.Create(nil);
  respTemp := TRealNZIS_QUESTIONNAIRE_RESPONSEItem.Create(nil);
  answTemp := TRealNZIS_QUESTIONNAIRE_ANSWERItem.Create(nil);
  answValTemp := TRealNZIS_ANSWER_VALUEItem.Create(nil);
  DIAGNOSTIC_REPTemp := TRealNZIS_DIAGNOSTIC_REPORTItem.Create(nil);
  RESULT_DIAGNOSTIC_REPTemp := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem.Create(nil);

  FDoctor := TRealDoctorItem.Create(nil);
  patNodes := nil;
end;

procedure TfrmProfFormFMX.DateArrowClick(Sender: TObject);
var
  btn: TButton;
  ctrl: TFmxObject;
  datEdt: TDateEdit;
begin
  btn := TButton(Sender);
  ctrl := btn.Parent;
  while true  do
  begin
    if (ctrl is TDateEdit)then
    begin
      datEdt := TDateEdit(ctrl);
      Break;
    end;
    ctrl := ctrl.Parent;
  end;

  if datEdt.IsPickerOpened then
    datEdt.ClosePicker
  else
    datEdt.OpenPicker;
end;

procedure TfrmProfFormFMX.DeleteExpanderMDNs(Layout: TLayout; mdnLabel: TMdnsLabel);
var
  AParent: TFmxObject;
begin
  AParent := mdnLabel.MdnsLyt.Parent;
  while AParent <> nil do
  begin
    if AParent = Layout then
    begin
      Break;
    end;
      AParent := AParent.Parent;

  end;
end;

procedure TfrmProfFormFMX.DoTabHandlingXE();
var
  i, c :integer;
  current : TComponent;
  currentNext : integer;
  focus : TStyledControl;
  control : TStyledControl;
  tabOrder: Integer;
begin
  if (Self.GetFocused is TStyledControl) then
  begin
    control := (Self.GetFocused as TStyledControl);
    tabOrder := control.TabOrder;
  end;

  c := Self.ComponentCount - 1;
  currentNext := 9999;
  focus := nil;

  for i := 0 to c do
  begin
      current := Self.Components[i];
      if (current is TStyledControl) then
      begin
          if ((current as TStyledControl).TabOrder < currentNext) and
          ((current as TStyledControl).TabOrder > tabOrder) then
          begin
            currentNext := (current as TStyledControl).TabOrder;
          end;
      end;
  end;

  for i := 0 to c do
  begin
      current := Self.Components[i];
      if (current is TStyledControl) then
      begin
        if (currentNext = (current as TStyledControl).TabOrder) then
        begin
          focus := (current as TStyledControl);
        end;
      end;
  end;

  if focus <> nil then
  begin
    focus.SetFocus;
  end;
end;

procedure TfrmProfFormFMX.DragOver(const Data: TDragObject;
  const Point: TPointF; var Operation: TDragOperation);
var
  NewTarget, FTarget: IControl;
  newpoint, pTarget: TPointF;
begin
  //Operation := TDragOperation.Move;
  if not(data.Source is TRectangle) then Exit;
  Operation := TDragOperation.Move;
  newpoint := PointF(Point.X -Self.Left, Point.y - self.top);
  rctSelector.Position.Point := newpoint;
  pTarget := txtMainDiag.LocalToAbsolute(PointF(0,0));

  //txtTest.Text := (newpoint.X - pTarget.X).ToString();

  //inherited DragOver(Data, newpoint, Operation);
  //NewTarget := FindTarget(Point, Data);
//  if (NewTarget <> FTarget) then
//  begin
//    if FTarget <> nil then
//    begin
//      FTarget.DragLeave;
//      FTarget.RemoveFreeNotify(Self);
//    end;
//    FTarget := NewTarget;
//    if FTarget <> nil then
//    begin
//      FTarget.AddFreeNotify(Self);
//      FTarget.DragEnter(Data, FTarget.ScreenToLocal(Point));
//    end;
//  end;
//  if FTarget <> nil then
//    FTarget.DragOver(Data, FTarget.ScreenToLocal(Point), Operation);
end;

procedure TfrmProfFormFMX.dtdtCl132CheckChanged(Sender: TObject);
var
  TempDatEdit: TDateEdit;
  TempDateEditLabel: TDateEditLabel;
  AnswValue: TRealNZIS_ANSWER_VALUEItem;
  ResDiagRep: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
  data, dataAnswVal, dataResDiagRep: PAspRec;
  linkPos, cl134Pos, cl144Pos: Cardinal;
  cl134Key: string;
  i: Integer;
begin
  TempDatEdit := TDateEdit(Sender);
  TempDateEditLabel := TDateEditLabel(TempDatEdit.TagObject);

  if FIsVtrPregled then
  begin
    data := Pointer(PByte(TempDateEditLabel.node) + lenNode);
    if not TempDatEdit.IsChecked then
    begin
      TempDatEdit.Format := ' ';
      VtrPregLink.BeginUpdate;
      VtrPregLink.CheckType[TempDateEditLabel.node] := ctNone;
      if TempDateEditLabel.node.FirstChild <> nil then
        FAspLink.MarkDeletedNode(TempDateEditLabel.node.FirstChild);
      VtrPregLink.endUpdate;
    end
    else
    begin
      TempDatEdit.Format := 'DD.MM.YYYY';
      VtrPregLink.CheckType[TempDateEditLabel.node] := ctCheckBox;
      VtrPregLink.CheckState[TempDateEditLabel.node] := csCheckedNormal;

      if TempDateEditLabel.node.FirstChild = nil then
      begin
        case data.vid of
          vvNZIS_QUESTIONNAIRE_ANSWER:
          begin
            answTemp.DataPos := Data.DataPos;
            cl134Pos := answTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS));
            cl134Temp.DataPos := cl134Pos;
            answTemp.cl028 := StrToInt(cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL134_CL028)));
            AnswValue := TRealNZIS_ANSWER_VALUEItem(Adb_dm.CollNZIS_ANSWER_VALUE.Add);
            Memo1.Text := IntToStr(Adb_dm.CollNZIS_ANSWER_VALUE.Count) + '(Adb_dm.CollNZIS_ANSWER_VALUE.Add)' ;

            New(AnswValue.PRecord);
            case answTemp.cl028 of
              4: //конкретна дата
              begin
                AnswValue.PRecord.ANSWER_DATE := TempDatEdit.Date;
                AnswValue.PRecord.ID := 0;
                AnswValue.PRecord.QUESTIONNAIRE_ANSWER_ID := 0;
                AnswValue.PRecord.CL028 := 4;

                AnswValue.PRecord.setProp :=
                [NZIS_ANSWER_VALUE_ANSWER_DATE
                , NZIS_ANSWER_VALUE_ID
                , NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID
                , NZIS_ANSWER_VALUE_CL028];

                AnswValue.InsertNZIS_ANSWER_VALUE;
                Dispose(AnswValue.PRecord);
                AnswValue.PRecord := nil;
              end;
            end;
            FAspLink.AddNewNode(vvNZIS_ANSWER_VALUE, AnswValue.DataPos, TempDateEditLabel.node, amAddChildLast, TempDateEditLabel.nodeValue, linkpos);
            dataAnswVal := Pointer(PByte(TempDateEditLabel.node.FirstChild) + lenNode);
            dataAnswVal.index :=  Adb_DM.CollNZIS_ANSWER_VALUE.Count - 1;
          end;
          //vvNZIS_RESULT_DIAGNOSTIC_REPORT:
//          begin
//            ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Add);
//            ResDiagRep.DataPos := Data.DataPos;
//            cl144Pos := ResDiagRep.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
//            cl144Temp.DataPos := cl144Pos;
//            ResDiagRep.cl028 := StrToInt(cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL144_CL028)));
//            New(ResDiagRep.PRecord);
//            case ResDiagRep.cl028 of
//              1: //Количествено представяне
//              begin
//                ResDiagRep.PRecord.VALUE_QUANTITY := string.ToDouble(text);
//                ResDiagRep.PRecord.ID := 0;
//                ResDiagRep.PRecord.DIAGNOSTIC_REPORT_ID := 0;
//                ResDiagRep.PRecord.CL028_VALUE_SCALE := 1;
//
//                ResDiagRep.PRecord.setProp :=
//                [NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY
//                , NZIS_RESULT_DIAGNOSTIC_REPORT_ID
//                , NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID
//                , NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE];
//
//                ResDiagRep.InsertNZIS_RESULT_DIAGNOSTIC_REPORT;
//                Dispose(ResDiagRep.PRecord);
//                ResDiagRep.PRecord := nil;
//              end;
//            end;
//            FAspLink.AddNewNode(vvNZIS_RESULT_DIAGNOSTIC_REPORT, ResDiagRep.DataPos, TempDateEditLabel.node, amAddChildLast, TempDateEditLabel.nodeValue, linkpos);
//            dataResDiagRep := Pointer(PByte(TempDateEditLabel.node.FirstChild) + lenNode);
//            dataResDiagRep.index := FAdb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Count - 1;
//          end;
        end;
      end
      else
      begin
        case data.vid of
          vvNZIS_QUESTIONNAIRE_ANSWER:
          begin
            answTemp.DataPos := Data.DataPos;
            dataAnswVal := Pointer(PByte(TempDateEditLabel.node.FirstChild) + lenNode);
            if dataAnswVal.index >= 0 then
            begin
              AnswValue :=  Adb_DM.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index];
              if AnswValue.PRecord <> nil then
              begin
                case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                  4:
                  begin
                    AnswValue.PRecord.setProp := [];
                    AnswValue.PRecord.ANSWER_DATE := TempDatEdit.Date;
                    Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_DATE);
                  end;
                end;
              end
              else
              begin
                New(AnswValue.PRecord);
                case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                  4:
                  begin
                    AnswValue.PRecord.setProp := [];
                    AnswValue.PRecord.ANSWER_DATE := TempDatEdit.Date;
                    Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_DATE);
                  end;
                end;
              end;
            end
            else
            begin
              AnswValue := TRealNZIS_ANSWER_VALUEItem(Adb_dm.CollNZIS_ANSWER_VALUE.Add);
              Memo1.Text := IntToStr(Adb_dm.CollNZIS_ANSWER_VALUE.Count) + '(Adb_dm.CollNZIS_ANSWER_VALUE.Add)' ;
              AnswValue.DataPos := dataAnswVal.DataPos;
              dataAnswVal.index :=  Adb_DM.CollNZIS_ANSWER_VALUE.Count - 1;
              New(AnswValue.PRecord);
              case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                4:
                begin
                  AnswValue.PRecord.setProp := [];
                  AnswValue.PRecord.ANSWER_DATE := TempDatEdit.Date;
                  Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_DATE);
                end;
              end;
            end;


          end;
          //vvNZIS_RESULT_DIAGNOSTIC_REPORT:
//          begin
//            RESULT_DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
//            dataResDiagRep := Pointer(PByte(TempDateEditLabel.node.FirstChild) + lenNode);
//            if dataResDiagRep.index >= 0 then
//            begin
//              ResDiagRep := FResDiagRepColl.Items[dataResDiagRep.index];
//              if ResDiagRep.PRecord <> nil then
//              begin
//                case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
//                  1:
//                  begin
//                    ResDiagRep.PRecord.setProp := [];
//                    ResDiagRep.PRecord.VALUE_QUANTITY := string.ToDouble(text);
//                    Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY);
//                  end;
//                end;
//              end
//              else
//              begin
//                New(ResDiagRep.PRecord);
//                case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
//                  1:
//                  begin
//                    ResDiagRep.PRecord.setProp := [];
//                    ResDiagRep.PRecord.VALUE_QUANTITY := string.ToDouble(text);
//                    Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY);
//                  end;
//                end;
//              end;
//            end
//            else
//            begin
//              ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(FResDiagRepColl.Add);
//              ResDiagRep.DataPos := dataResDiagRep.DataPos;
//              dataResDiagRep.index := FResDiagRepColl.Count - 1;
//              New(ResDiagRep.PRecord);
//              case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
//                1:
//                begin
//                  ResDiagRep.PRecord.setProp := [];
//                  ResDiagRep.PRecord.VALUE_QUANTITY := string.ToDouble(text);
//                  Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY);
//                end;
//              end;
//            end;
//          end;
        end;
      end;
    end;
   // VtrPregLink.Selected[TempEditLabel.node] := True;
    //FAspLink.FVTR.RepaintNode(TempDateEditLabel.node.FirstChild);
  end;
end;

procedure TfrmProfFormFMX.dtdtCl132CheckChangedSup(Sender: TObject);
var
  TempDatEdit: TDateEdit;
  TempDateEditLabel: TDateEditLabel;
  AnswValue: TRealNZIS_ANSWER_VALUEItem;
  ResDiagRep: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
  data, dataAnswVal, dataResDiagRep: PAspRec;
  linkPos, cl134Pos, cl144Pos: Cardinal;
  cl134Key: string;
  i: Integer;
  fs: TFormatSettings;
begin
  TempDatEdit := TDateEdit(Sender);
  TempDateEditLabel := TDateEditLabel(TempDatEdit.Parent.TagObject);
  if (not TempDateEditLabel.edtDat.IsFocused) and TempDateEditLabel.canValidate then
  begin
    fs := TFormatSettings.Create();
    fs.DateSeparator := '.';
    fs.ShortDateFormat := 'DD.MM.YYYY';
    TempDateEditLabel.edtDat.Text := DateToStr(TempDatEdit.Date, fs );
  end;
  if not TempDateEditLabel.canValidate then
  begin
    if TempDatEdit.IsChecked then
    begin
      TempDateEditLabel.chk.IsChecked := true;
      TempDateEditLabel.rctNull.Visible := false;
    end
    else
    begin
      TempDateEditLabel.chk.IsChecked := false;
      TempDateEditLabel.rctNull.Visible := true;
    end;
    MarkSourceAnsw(TempDateEditLabel.SourceAnsw, TempDateEditLabel.rctSourceAnsw);
    Exit;
  end;


  if FIsVtrPregled then
  begin
    data := Pointer(PByte(TempDateEditLabel.node) + lenNode);
    if not TempDatEdit.IsChecked then
    begin
      TempDatEdit.Format := ' ';
      VtrPregLink.BeginUpdate;
      VtrPregLink.CheckType[TempDateEditLabel.node] := ctNone;
      if TempDateEditLabel.node.FirstChild <> nil then
        FAspLink.MarkDeletedNode(TempDateEditLabel.node.FirstChild);
      VtrPregLink.endUpdate;
    end
    else
    begin
      TempDatEdit.Format := 'DD.MM.YYYY';
      VtrPregLink.CheckType[TempDateEditLabel.node] := ctCheckBox;
      VtrPregLink.CheckState[TempDateEditLabel.node] := csCheckedNormal;

      if TempDateEditLabel.node.FirstChild = nil then
      begin
        case data.vid of
          vvNZIS_QUESTIONNAIRE_ANSWER:
          begin
            answTemp.DataPos := Data.DataPos;
            cl134Pos := answTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS));
            cl134Temp.DataPos := cl134Pos;
            answTemp.cl028 := StrToInt(cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL134_CL028)));
            AnswValue := TRealNZIS_ANSWER_VALUEItem(Adb_dm.CollNZIS_ANSWER_VALUE.Add);
            Memo1.Text := IntToStr(Adb_dm.CollNZIS_ANSWER_VALUE.Count) + '(Adb_dm.CollNZIS_ANSWER_VALUE.Add)' ;
            New(AnswValue.PRecord);
            case answTemp.cl028 of
              4: //конкретна дата
              begin
                AnswValue.PRecord.ANSWER_DATE := TempDatEdit.Date;
                AnswValue.PRecord.ID := 0;
                AnswValue.PRecord.QUESTIONNAIRE_ANSWER_ID := 0;
                AnswValue.PRecord.CL028 := 4;

                AnswValue.PRecord.setProp :=
                [NZIS_ANSWER_VALUE_ANSWER_DATE
                , NZIS_ANSWER_VALUE_ID
                , NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID
                , NZIS_ANSWER_VALUE_CL028];

                AnswValue.InsertNZIS_ANSWER_VALUE;
                Dispose(AnswValue.PRecord);
                AnswValue.PRecord := nil;
              end;
            end;
            FAspLink.AddNewNode(vvNZIS_ANSWER_VALUE, AnswValue.DataPos, TempDateEditLabel.node, amAddChildLast, TempDateEditLabel.nodeValue, linkpos);
            dataAnswVal := Pointer(PByte(TempDateEditLabel.node.FirstChild) + lenNode);
            dataAnswVal.index :=  Adb_DM.CollNZIS_ANSWER_VALUE.Count - 1;
          end;
        end;
      end
      else
      begin
        case data.vid of
          vvNZIS_QUESTIONNAIRE_ANSWER:
          begin
            answTemp.DataPos := Data.DataPos;
            dataAnswVal := Pointer(PByte(TempDateEditLabel.node.FirstChild) + lenNode);
            if dataAnswVal.index >= 0 then
            begin
              AnswValue :=  Adb_DM.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index];
              if AnswValue.PRecord <> nil then
              begin
                case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                  4:
                  begin
                    AnswValue.PRecord.setProp := [];
                    AnswValue.PRecord.ANSWER_DATE := TempDatEdit.Date;
                    Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_DATE);
                  end;
                end;
              end
              else
              begin
                New(AnswValue.PRecord);
                case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                  4:
                  begin
                    AnswValue.PRecord.setProp := [];
                    AnswValue.PRecord.ANSWER_DATE := TempDatEdit.Date;
                    Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_DATE);
                  end;
                end;
              end;
            end
            else
            begin
              AnswValue := TRealNZIS_ANSWER_VALUEItem(Adb_dm.CollNZIS_ANSWER_VALUE.Add);
              Memo1.Text := IntToStr(Adb_dm.CollNZIS_ANSWER_VALUE.Count) + '(Adb_dm.CollNZIS_ANSWER_VALUE.Add)' ;
              AnswValue.DataPos := dataAnswVal.DataPos;
              dataAnswVal.index := Adb_DM.CollNZIS_ANSWER_VALUE.Count - 1;
              New(AnswValue.PRecord);
              case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                4:
                begin
                  AnswValue.PRecord.setProp := [];
                  AnswValue.PRecord.ANSWER_DATE := TempDatEdit.Date;
                  Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_DATE);
                end;
              end;
            end;


          end;
        end;
      end;
    end;
    if TempDatEdit.IsChecked then
    begin
      TempDateEditLabel.chk.IsChecked := true;
      TempDateEditLabel.rctNull.Visible := false;
    end
    else
    begin
      TempDateEditLabel.chk.IsChecked := false;
      TempDateEditLabel.rctNull.Visible := true;
    end;
    MarkSourceAnsw(TempDateEditLabel.SourceAnsw, TempDateEditLabel.rctSourceAnsw);
  end;
end;

procedure TfrmProfFormFMX.dtdtCl132MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  //
end;

procedure TfrmProfFormFMX.dtdtCl132Painting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  TempDateEditLabel: TDateEditLabel;
  TempDateEdit: TDateEdit;
  node: PVirtualNode;
  data, dataAnswVal, dataResDiag: PAspRec;
  vid: TVtrVid;
  str: string;
begin
  if TEdit(Sender).IsFocused then Exit;
  TempDateEdit := TDateEdit(sender);
  TempDateEditLabel := TDateEditLabel(TempDateEdit.TagObject);
  node := TempDateEditLabel.node;
  if FIsVtrPregled then
  begin
    data := pointer(PByte(node) + lenNode);
  end
  else
  begin
    data := VtrGrapf.GetNodeData(node);
  end;
  case data.vid of
    vvNZIS_QUESTIONNAIRE_ANSWER:
    begin
      answTemp.DataPos := Data.DataPos;
      if node.FirstChild <> nil then
      begin
        TempDateEditLabel.canValidate := False;
        TempDateEdit.IsChecked := true;
        TempDateEdit.Format := 'DD.MM.YYYY';
        TempDateEditLabel.canValidate := True;
        dataAnswVal := Pointer(PByte(node.FirstChild) + lenNode);
        if dataAnswVal.index < 0 then
        begin
          answValTemp.DataPos := dataAnswVal.DataPos;
          TempDateEditLabel.canValidate := False;
          TempDateEdit.Date := answValTemp.getDateMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_DATE));
          TempDateEditLabel.canValidate := True;
        end
        else
        begin
          answValTemp.DataPos := Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].DataPos;
          if Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].PRecord = nil then
          begin
            TempDateEditLabel.canValidate := False;
            TempDateEdit.Date := answValTemp.getDateMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_DATE));
            TempDateEditLabel.canValidate := True;
          end
          else
          begin
            case answValTemp.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
              4:
              begin
                TempDateEditLabel.canValidate := False;
                TempDateEdit.Date :=Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].PRecord.ANSWER_DATE;
                TempDateEditLabel.canValidate := True;
              end;
            end;

          end;
        end;
      end
      else
      begin
        TempDateEditLabel.canValidate := False;
        TempDateEdit.IsChecked := false;
        TempDateEdit.Format := ' ';
        TempDateEditLabel.canValidate := True;
      end;
    end;
    vvNZIS_RESULT_DIAGNOSTIC_REPORT:
    begin
      DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
      if node.FirstChild <> nil then
      begin
        TempDateEditLabel.canValidate := False;
        TempDateEdit.IsChecked := true;
        TempDateEdit.Format := 'DD.MM.YYYY';
        TempDateEditLabel.canValidate := True;
        dataResDiag := Pointer(PByte(node.FirstChild) + lenNode);
        if dataResDiag.index < 0 then
        begin
          DIAGNOSTIC_REPTemp.DataPos := dataResDiag.DataPos;
          TempDateEditLabel.canValidate := False;
          TempDateEdit.Date := answValTemp.getDateMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_DATE));
          TempDateEditLabel.canValidate := True;
        end
        else
        begin
          dataResDiag.DataPos := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].DataPos;
          if Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].PRecord = nil then
          begin
            TempDateEditLabel.canValidate := False;
            TempDateEdit.Date := answValTemp.getDateMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_DATE));
            TempDateEditLabel.canValidate := True;
          end
          else
          begin
            case DIAGNOSTIC_REPTemp.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
              4:
              begin
                TempDateEditLabel.canValidate := False;
                TempDateEdit.date := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].PRecord.VALUE_DATE_TIME;
                TempDateEditLabel.canValidate := True;
              end;
            end;

          end;
        end;
      end
      else
      begin
        TempDateEditLabel.canValidate := False;
        TempDateEdit.IsChecked := false;
        TempDateEdit.Format := ' ';
        TempDateEditLabel.canValidate := True;
      end;
    end;
  else
    begin
      Caption := 'ddd';
    end;
  end

end;

procedure TfrmProfFormFMX.dtdtCl132PaintingSup(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  TempDateEditLabel: TDateEditLabel;
  TempDateEditLYT: TLayout;
  node: PVirtualNode;
  data, dataAnswVal, dataResDiag: PAspRec;
  vid: TVtrVid;
  str: string;
begin
  if TDateEdit(Sender).IsFocused then Exit;
  TempDateEditLYT := TLayout(sender);
  TempDateEditLabel := TDateEditLabel(TempDateEditLYT.parent.TagObject);
  node := TempDateEditLabel.node;
  if FIsVtrPregled then
  begin
    data := pointer(PByte(node) + lenNode);
  end
  else
  begin
    data := VtrGrapf.GetNodeData(node);
  end;
  case data.vid of
    vvNZIS_QUESTIONNAIRE_ANSWER:
    begin
      answTemp.DataPos := Data.DataPos;
      if node.FirstChild <> nil then
      begin
        TempDateEditLabel.canValidate := False;
        TempDateEditLabel.DatEdt.IsChecked := true;
        TempDateEditLabel.DatEdt.Format := 'DD.MM.YYYY';
        TempDateEditLabel.canValidate := True;
        dataAnswVal := Pointer(PByte(node.FirstChild) + lenNode);
        if dataAnswVal.index < 0 then
        begin
          answValTemp.DataPos := dataAnswVal.DataPos;
          TempDateEditLabel.canValidate := False;
          TempDateEditLabel.DatEdt.Date := answValTemp.getDateMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_DATE));
          TempDateEditLabel.canValidate := True;
        end
        else
        begin
          answValTemp.DataPos := Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].DataPos;
          if Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].PRecord = nil then
          begin
            TempDateEditLabel.canValidate := False;
            TempDateEditLabel.DatEdt.Date := answValTemp.getDateMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_DATE));
            TempDateEditLabel.canValidate := True;
          end
          else
          begin
            case answValTemp.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
              4:
              begin
                TempDateEditLabel.canValidate := False;
                TempDateEditLabel.DatEdt.Date :=Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].PRecord.ANSWER_DATE;
                TempDateEditLabel.canValidate := True;
              end;
            end;

          end;
        end;
      end
      else
      begin
        TempDateEditLabel.canValidate := False;
        TempDateEditLabel.DatEdt.IsChecked := false;
        TempDateEditLabel.DatEdt.Format := ' ';
        TempDateEditLabel.canValidate := True;
      end;
    end;
    vvNZIS_RESULT_DIAGNOSTIC_REPORT:
    begin
      DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
      if node.FirstChild <> nil then
      begin
        TempDateEditLabel.canValidate := False;
        TempDateEditLabel.DatEdt.IsChecked := true;
        TempDateEditLabel.DatEdt.Format := 'DD.MM.YYYY';
        TempDateEditLabel.canValidate := True;
        dataResDiag := Pointer(PByte(node.FirstChild) + lenNode);
        if dataResDiag.index < 0 then
        begin
          DIAGNOSTIC_REPTemp.DataPos := dataResDiag.DataPos;
          TempDateEditLabel.canValidate := False;
          TempDateEditLabel.DatEdt.Date := answValTemp.getDateMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_DATE));
          TempDateEditLabel.canValidate := True;
        end
        else
        begin
          dataResDiag.DataPos := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].DataPos;
          if Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].PRecord = nil then
          begin
            TempDateEditLabel.canValidate := False;
            TempDateEditLabel.DatEdt.Date := answValTemp.getDateMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_DATE));
            TempDateEditLabel.canValidate := True;
          end
          else
          begin
            case DIAGNOSTIC_REPTemp.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
              4:
              begin
                TempDateEditLabel.canValidate := False;
                TempDateEditLabel.DatEdt.date := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].PRecord.VALUE_DATE_TIME;
                TempDateEditLabel.canValidate := True;
              end;
            end;

          end;
        end;
      end
      else
      begin
        TempDateEditLabel.canValidate := False;
        TempDateEditLabel.DatEdt.IsChecked := false;
        TempDateEditLabel.DatEdt.Format := ' ';
        TempDateEditLabel.canValidate := True;
      end;
    end;
  else
    begin
      Caption := 'ddd';
    end;
  end;
  if TempDateEditLabel.DatEdt.IsChecked then
  begin
    TempDateEditLabel.chk.IsChecked := true;
    TempDateEditLabel.rctNull.Visible := false;
  end
  else
  begin
    TempDateEditLabel.chk.IsChecked := false;
    TempDateEditLabel.rctNull.Visible := true;
  end;
end;

procedure TfrmProfFormFMX.dtdtStartDateChange(Sender: TObject);
var
  dtdt: TDateEdit;
  ambStartDate: TDate;
  ambStartTime: TTime;
  ambStartDateTime: TDateTime;
  fs: TFormatSettings;
begin
  dtdt := TDateEdit(sender);
  if not dtdt.IsFocused then Exit;
  //DD.MM.YYYY hh:nn
  fs := TFormatSettings.Create;
  fs.DateSeparator := '.';
  fs.ShortDateFormat := 'DD.MM.YYYY';
  fs.TimeSeparator := ':';
  fs.ShortTimeFormat := 'hh:mm';
  ambStartDateTime := StrToDateTime(dtdt.Text);
  ambStartDate := Floor(ambStartDateTime);
  ambStartTime := ambStartDateTime - ambStartDate;
  Adb_DM.CollPregled.SetDateMap(FPregled.DataPos, word(PregledNew_START_DATE), ambStartDate);
  Adb_DM.CollPregled.SetDateMap(FPregled.DataPos, word(PregledNew_START_TIME), ambStartTime);
end;

procedure TfrmProfFormFMX.dtdtStartDateClosePicker(Sender: TObject);
var
  dtdt: TDateEdit;
  ambStartDate: TDate;
  ambStartTime: TTime;
  ambStartDateTime: TDateTime;
  fs: TFormatSettings;
begin
  dtdt := TDateEdit(sender);
  fs := TFormatSettings.Create;
  fs.DateSeparator := '.';
  fs.ShortDateFormat := 'DD.MM.YYYY';
  fs.TimeSeparator := ':';
  fs.ShortTimeFormat := 'hh:mm';
  ambStartDateTime := StrToDateTime(dtdt.Text);
  ambStartDate := Floor(ambStartDateTime);
  Adb_DM.CollPregled.SetDateMap(FPregled.DataPos, word(PregledNew_START_DATE), ambStartDate);
end;

procedure TfrmProfFormFMX.dtdtStartDatePainting(Sender: TObject;
  Canvas: TCanvas; const ARect: TRectF);
var
  dtdt: TDateEdit;
  ambStartDate: TDate;
  ambStartTime: TTime;
begin
  dtdt := TDateEdit(sender);
  if dtdt.IsFocused then Exit;

  ambStartDate := FPregled.getDateMap(FAspAdbBuf, FAspAdbPosData, Word(PregledNew_START_DATE));
  ambStartTime := FPregled.getTimeMap(FAspAdbBuf, FAspAdbPosData, Word(PregledNew_START_TIME));

  dtdt.DateTime := ambStartDate + ambStartTime;

end;

procedure TfrmProfFormFMX.Edit11Painting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  edt: TEdit;
  dataRequester: PAspRec;
begin
  if pregNodes.incNaprNode = nil  then Exit;

  edt := TEdit(sender);
  dataRequester := Pointer(PByte(pregNodes.ReqesterNode) + lenNode);
  edt.Text := Adb_DM.CollOtherDoctor.getAnsiStringMap(dataRequester.DataPos, Word(OtherDoctor_NOMER_LZ));
end;

procedure TfrmProfFormFMX.Edit12Painting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  edt: TEdit;
  dataRequester: PAspRec;
begin
  if pregNodes.incNaprNode = nil  then Exit;

  edt := TEdit(sender);
  dataRequester := Pointer(PByte(pregNodes.ReqesterNode) + lenNode);
  edt.Text := Adb_DM.CollOtherDoctor.getAnsiStringMap(dataRequester.DataPos, Word(OtherDoctor_UIN));
end;

procedure TfrmProfFormFMX.Edit13Painting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  edt: TEdit;
  dataRequester: PAspRec;
begin
  if pregNodes.incNaprNode = nil  then Exit;

  edt := TEdit(sender);
  dataRequester := Pointer(PByte(pregNodes.ReqesterNode) + lenNode);
  edt.Text := Adb_DM.CollOtherDoctor.getAnsiStringMap(dataRequester.DataPos, Word(OtherDoctor_NZOK_NOMER));
end;

procedure TfrmProfFormFMX.Edit14Painting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  edt: TEdit;
  dataRequester: PAspRec;
begin
  if pregNodes.incNaprNode = nil  then Exit;

  edt := TEdit(sender);
  dataRequester := Pointer(PByte(pregNodes.ReqesterNode) + lenNode);
  edt.Text := IntToStr(Adb_DM.CollOtherDoctor.getIntMap(dataRequester.DataPos, Word(OtherDoctor_SPECIALITY)));
end;

procedure TfrmProfFormFMX.edtNrnInkNaprPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  edt: TEdit;
  dataInkNapr: PAspRec;
begin
  if pregNodes.incNaprNode = nil  then Exit;

  edt := TEdit(sender);
  dataInkNapr := Pointer(PByte(pregNodes.incNaprNode) + lenNode);
  edt.Text := Adb_DM.CollIncMN.getAnsiStringMap(dataInkNapr.DataPos, Word(INC_NAPR_NRN));
end;

procedure TfrmProfFormFMX.edt1Popup(Sender: TObject);
begin
  //
end;

procedure TfrmProfFormFMX.edtAmbListIncNaprPainting(Sender: TObject;
  Canvas: TCanvas; const ARect: TRectF);
var
  edt: TEdit;
  dataInkNapr: PAspRec;
begin
  if pregNodes.incNaprNode = nil  then Exit;

  edt := TEdit(sender);
  dataInkNapr := Pointer(PByte(pregNodes.incNaprNode) + lenNode);
  edt.Text := Adb_DM.CollIncMN.getAnsiStringMap(dataInkNapr.DataPos, Word(INC_NAPR_AMB_LIST_NRN));
end;

procedure TfrmProfFormFMX.edtAmbListPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  edt: TEdit;
  ambNom: integer;
  ambNRN: string;
  nzisStatus: Word;
  //THipPregledStatus = (hpsNone, hpsValid, hpsNoValid, hpsStartOpen, hpsErr, hpsOpen, hpsClosed, hpsCancel);
begin
  edt := TEdit(sender);
  ambNom := Adb_DM.CollPregled.getIntMap(FPregled.DataPos, Word(PregledNew_AMB_LISTN));
  ambNRN := Copy(FPregled.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, Word(PregledNew_NRN_LRN)), 1, 12);
  if (ambNRN.StartsWith('_')) or (ambNRN.StartsWith(' ')) then
    ambNRN := '                                   ';
  nzisStatus := Adb_DM.CollPregled.getWordMap(FPregled.DataPos, word(PregledNew_NZIS_STATUS));
  animNrnStatus.Tag:= nzisStatus;
  case nzisStatus of
    3:
    begin
      if animNrnStatus.Pause then
      begin
        linStatusNRN.Opacity := 1;
        animNrnStatus.Start;
      end;
      txtNzisStatus.Text := 'отваря се';
      //rctNzisBTN.Stroke.Color := $FFFF9500;
      rctBtnNzisErr.Visible := false;
    end;
    4:
    begin
      animNrnStatus.Stop;
      linStatusNRN.Opacity := 1;
      txtNzisStatus.Text := 'грешка';
      linStatusNRN.Stroke.Color := $FFFA0808;
      rctBtnNzisErr.Visible := True;
    end;
    5:
    begin
      animNrnStatus.Stop;
      linStatusNRN.Opacity := 1;
      txtNzisStatus.Text := 'отворен';
      linStatusNRN.Stroke.Color := $FFFF9500;
      rctBtnNzisErr.Visible := false;
    end;
    6:
    begin
      animNrnStatus.Stop;
      linStatusNRN.Opacity := 1;
      txtNzisStatus.Text := 'затворен';
      linStatusNRN.Stroke.Color := $FF299045;
      rctBtnNzisErr.Visible := false;
    end;
    8:
    begin
      if animNrnStatus.Pause then
      begin
        linStatusNRN.Opacity := 1;
        animNrnStatus.Start;
      end;
      txtNzisStatus.Text := 'затваря се';
      linStatusNRN.Stroke.Color := $FF299045;
      rctBtnNzisErr.Visible := false;
    end;
    9:
    begin
      animNrnStatus.Stop;
      linStatusNRN.Opacity := 1;
      txtNzisStatus.Text := 'грешка';
      linStatusNRN.Stroke.Color := $FFFA0808;
      rctBtnNzisErr.Visible := True;
    end;
    10:
    begin
      animNrnStatus.Stop;
      linStatusNRN.Opacity := 1;
      txtNzisStatus.Text := 'редактиран';
      linStatusNRN.Stroke.Color := $FF454BE3;
      rctBtnNzisErr.Visible := false;
    end;
    11:
    begin
      animNrnStatus.Stop;
      linStatusNRN.Opacity := 1;
      txtNzisStatus.Text := 'грешка';
      linStatusNRN.Stroke.Color := $FFFA0808;
      rctBtnNzisErr.Visible := false;
    end;
    12:
    begin
      if animNrnStatus.Pause then
      begin
        linStatusNRN.Opacity := 1;
        animNrnStatus.Start;
      end;
      txtNzisStatus.Text := 'редактира се';
      linStatusNRN.Stroke.Color := $FF454BE3;
      rctBtnNzisErr.Visible := false;
    end;
    13:
    begin
      if animNrnStatus.Pause then
      begin
        linStatusNRN.Opacity := 1;
        animNrnStatus.Start;
      end;
      if CheckKep then
      begin
        txtNzisStatus.Text := 'Изпраща се готов преглед';
      end
      else
      begin
        txtNzisStatus.Text := 'Проверете КЕП';
      end;
      linStatusNRN.Stroke.Color := $FF454BE3;
      rctBtnNzisErr.Visible := false;
    end;
    14:
    begin
      animNrnStatus.Stop;
      linStatusNRN.Opacity := 1;
      txtNzisStatus.Text := 'Затворен готов преглед';
      linStatusNRN.Stroke.Color := $FF454BE3;
      rctBtnNzisErr.Visible := false;
    end;
    15:
    begin
      if CheckKep then
      begin
        animNrnStatus.Stop;
        linStatusNRN.Opacity := 1;
        txtNzisStatus.Text := 'Опит за готов преглед';
        linStatusNRN.Stroke.Color := $FF454BE3;
        rctBtnNzisErr.Visible := false;
      end;
    end;
    16:
    begin
      if CheckKep then
      begin
        animNrnStatus.Stop;
        linStatusNRN.Opacity := 1;
        txtNzisStatus.Text := 'Опит за отваряне на преглед';
        linStatusNRN.Stroke.Color := $FFFF9500;
        rctBtnNzisErr.Visible := false;
      end;
    end;
  else
    if CheckKep then
    begin
      linStatusNRN.Stroke.Color := TAlphaColorRec.Null;
    end
    else
    begin

    end;
    rctBtnNzisErr.Visible := false;
  end;
  edt.Text := Format('АМБУЛАТОРЕН ЛИСТ  № %d НРН %s', [ambNom, ambNRN]);
  txtCalcEdit.MaxSize := PointF(100000, 30);
  txtCalcEdit.Font.Assign(edt.TextSettings.Font);
  txtCalcEdit.Text := Format('АМБУЛАТОРЕН ЛИСТ  № %d НРН |', [ambNom]);
  linStatusNRN.Margins.Left := txtCalcEdit.TextWidth ;
  txtCalcEdit.Text := ambNRN;
  linStatusNRN.Margins.Right := edt.Width - txtCalcEdit.TextWidth - linStatusNRN.Margins.Left;

end;

procedure TfrmProfFormFMX.edtADBCalcPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  edt: TEdit;
  //ParamSetProp: TParamSetProp;
  paramField: TParamProp;
  ArrStr: TArray<string>;
  PatAge: Integer;
  BIRTH_DATE: TDate;
begin


  edt := tedit(sender);
  //ParamSetProp := TParamSetProp(edt.tag);
  if edt.TagObject is TRealPatientNewItem then
  begin
    case TPatientNewItem.TPropertyIndex(edt.tag) of
      PatientNew_BIRTH_DATE :
      begin
        BIRTH_DATE := TRealPatientNewItem(edt.TagObject).getDateMap(FAspAdbBuf, FAspAdbPosData, word(PatientNew_BIRTH_DATE));
        PatAge := TRealPatientNewItem(edt.TagObject).CalcAge(UserDate, BIRTH_DATE);
        edt.Text := Format('%d год.', [PatAge]);
      end;
    end;
  end;
end;

procedure TfrmProfFormFMX.edtADBPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  edt: TEdit;
  ParamSetProp: TParamSetProp;
  PP: PParamSetProp;
  paramField: TParamProp;
  ArrStr: TArray<string>;
begin
  edt := tedit(sender);
  if edt.IsFocused then
    Exit;
  if edt.TagObject = nil then
  begin
    Caption := 'opasno';
    Exit;
  end;

  PP := PParamSetProp(edt.tag);

  ParamSetProp := pp^;
  for paramField in ParamSetProp do
  begin
    SetLength(ArrStr, length(ArrStr) + 1);
    ArrStr[length(ArrStr) - 1] := TBaseItem(edt.TagObject).getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(paramField));
  end;
  if length(ArrStr) > 1 then
  begin
    edt.Text := edt.Text.Join(' ' , ArrStr);
  end
  else
  begin
    edt.Text := ArrStr[0];
  end;
end;

procedure TfrmProfFormFMX.edtCl132ChangeTracking(Sender: TObject);
var
  TempEdit: TEdit;
  TempEditLabel: TEditLabel;
  data: PAspRec;
  linkPos: Cardinal;
  AnswValue: TRealNZIS_ANSWER_VALUEItem;
  cl134Key: string;
  i: integer;
begin
  TempEdit := TEdit(Sender);
  TempEditLabel := TEditLabel(TempEdit.TagObject);
  if FIsVtrPregled then
  begin
    data := Pointer(PByte(TempEditLabel.node) + lenNode);
    if TempEdit.Text = '' then
    begin
      VtrPregLink.BeginUpdate;
      VtrPregLink.CheckType[TempEditLabel.node] := ctNone;
      if TempEditLabel.node.FirstChild <> nil then
        FAspLink.MarkDeletedNode(TempEditLabel.node.FirstChild);
      VtrPregLink.endUpdate;
    end
    else
    begin
      TempEditLabel.chk.IsChecked := True;
      VtrPregLink.CheckType[TempEditLabel.node] := ctCheckBox;
      VtrPregLink.CheckState[TempEditLabel.node] := csCheckedNormal;
      case data.vid of
        vvNZIS_QUESTIONNAIRE_ANSWER:
        begin

          //
//          answTemp.FAnswerValues[0] := TRealNZIS_ANSWER_VALUEItem.Create(nil);
//          New(answTemp.PRecord);
//          answTemp.PRecord.setProp := [
//                  NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE
//                , NZIS_QUESTIONNAIRE_ANSWER_ID
//                , NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID];

        end;
      end;
      if TempEditLabel.node.FirstChild = nil then
      begin
        FAspLink.AddNewNode(vvNZIS_ANSWER_VALUE, 0, TempEditLabel.node, amAddChildLast, TempEditLabel.nodeValue, linkpos);
      end;
    end;
    //VtrPregLink.Selected[TempEditLabel.node] := True;
  end;
end;


procedure TfrmProfFormFMX.edtCl132Paint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  TempEditLabel: TEditLabel;
  node: PVirtualNode;
  data, dataAnswVal, dataResDiag: PAspRec;
  vid: TVtrVid;
  str: string;
begin
  if TEdit(Sender).IsFocused then Exit;
  TempEditLabel := TEditLabel(TEdit(sender).TagObject);
  node := TempEditLabel.node;
  if FIsVtrPregled then
  begin
    data := pointer(PByte(node) + lenNode);
  end
  else
  begin
    data := VtrGrapf.GetNodeData(node);
  end;
  case data.vid of
    vvCl134: tedit(sender).Text := 'cl134';
    vvCl088: tedit(sender).Text := 'cl088';
    vvNZIS_QUESTIONNAIRE_ANSWER:
    begin
      answTemp.DataPos := Data.DataPos;
      if node.FirstChild <> nil then
      begin
        TempEditLabel.chk.IsChecked := True;
        dataAnswVal := Pointer(PByte(node.FirstChild) + lenNode);
        if dataAnswVal.index < 0 then
        begin
          answValTemp.DataPos := dataAnswVal.DataPos;
          TempEditLabel.canValidate := False;
          tedit(sender).Text := Double.ToString(answValTemp.getDoubleMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_QUANTITY)));
          TempEditLabel.canValidate := True;
        end
        else
        begin
          answValTemp.DataPos := Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].DataPos;
          if Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].PRecord = nil then
          begin
            TempEditLabel.canValidate := False;
            tedit(sender).Text := Double.ToString(answValTemp.getDoubleMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_QUANTITY)));
            TempEditLabel.canValidate := True;
          end
          else
          begin
            case answValTemp.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
              1:
              begin
                TempEditLabel.canValidate := False;
                tedit(sender).Text := Double.ToString(Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].PRecord.ANSWER_QUANTITY);
                TempEditLabel.canValidate := True;
              end;
            end;

          end;
        end;
      end
      else
      begin
        TempEditLabel.canValidate := False;
        tedit(sender).Text := '';
        TempEditLabel.canValidate := True;
      end;
    end;
    vvNZIS_RESULT_DIAGNOSTIC_REPORT:
    begin
      DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
      if node.FirstChild <> nil then
      begin
        TempEditLabel.chk.IsChecked := True;
        dataResDiag := Pointer(PByte(node.FirstChild) + lenNode);
        if dataResDiag.index < 0 then
        begin
          DIAGNOSTIC_REPTemp.DataPos := dataResDiag.DataPos;
          TempEditLabel.canValidate := False;
          tedit(sender).Text := Double.ToString(DIAGNOSTIC_REPTemp.getDoubleMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY)));
          TempEditLabel.canValidate := True;
        end
        else
        begin
          dataResDiag.DataPos := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].DataPos;
          if Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].PRecord = nil then
          begin
            TempEditLabel.canValidate := False;
            tedit(sender).Text := Double.ToString(DIAGNOSTIC_REPTemp.getDoubleMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY)));
            TempEditLabel.canValidate := True;
          end
          else
          begin
            case DIAGNOSTIC_REPTemp.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
              1:
              begin
                TempEditLabel.canValidate := False;
                tedit(sender).Text := Double.ToString(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].PRecord.VALUE_QUANTITY);
                TempEditLabel.canValidate := True;
              end;
            end;

          end;
        end;
      end
      else
      begin
        TempEditLabel.canValidate := False;
        tedit(sender).Text := '';
        TempEditLabel.canValidate := True;
      end;
    end;
  else
    begin
      Caption := 'ddd';
    end;
  end

end;

procedure TfrmProfFormFMX.edtCl132PaintSup(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  TempEditLabel: TEditLabel;
  node: PVirtualNode;
  data, dataAnswVal, dataResDiag: PAspRec;
  vid: TVtrVid;
  str: string;
begin
  if TEdit(Sender).IsFocused then Exit;
  TempEditLabel := TEditLabel(TEdit(sender).Parent.TagObject);
  node := TempEditLabel.node;
  if FIsVtrPregled then
  begin
    data := pointer(PByte(node) + lenNode);
  end
  else
  begin
    data := VtrGrapf.GetNodeData(node);
  end;
  case data.vid of
    vvNZIS_QUESTIONNAIRE_ANSWER:
    begin
      answTemp.DataPos := Data.DataPos;
      if node.FirstChild <> nil then
      begin
        TempEditLabel.chk.IsChecked := True;
        dataAnswVal := Pointer(PByte(node.FirstChild) + lenNode);
        if dataAnswVal.index < 0 then
        begin
          answValTemp.DataPos := dataAnswVal.DataPos;
          TempEditLabel.canValidate := False;
          tedit(sender).Text := Double.ToString(answValTemp.getDoubleMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_QUANTITY)));
          TempEditLabel.canValidate := True;
        end
        else
        begin
          answValTemp.DataPos := Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].DataPos;
          if Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].PRecord = nil then
          begin
            TempEditLabel.canValidate := False;
            tedit(sender).Text := Double.ToString(answValTemp.getDoubleMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_QUANTITY)));
            TempEditLabel.canValidate := True;
          end
          else
          begin
            case answValTemp.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
              1:
              begin
                TempEditLabel.canValidate := False;
                tedit(sender).Text := Double.ToString(Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].PRecord.ANSWER_QUANTITY);
                TempEditLabel.canValidate := True;
              end;
            end;

          end;
        end;
      end
      else
      begin
        TempEditLabel.canValidate := False;
        tedit(sender).Text := '';
        TempEditLabel.canValidate := True;
      end;
    end;
    vvNZIS_RESULT_DIAGNOSTIC_REPORT:
    begin
      DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
      if node.FirstChild <> nil then
      begin
        TempEditLabel.chk.IsChecked := True;
        dataResDiag := Pointer(PByte(node.FirstChild) + lenNode);
        if dataResDiag.index < 0 then
        begin
          DIAGNOSTIC_REPTemp.DataPos := dataResDiag.DataPos;
          TempEditLabel.canValidate := False;
          tedit(sender).Text := Double.ToString(DIAGNOSTIC_REPTemp.getDoubleMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY)));
          TempEditLabel.canValidate := True;
        end
        else
        begin
          dataResDiag.DataPos := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].DataPos;
          if Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].PRecord = nil then
          begin
            TempEditLabel.canValidate := False;
            tedit(sender).Text := Double.ToString(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.getDoubleMap(dataResDiag.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY)));
            TempEditLabel.canValidate := True;
          end
          else
          begin
            case Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.getWordMap(dataResDiag.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
              1:
              begin
                TempEditLabel.canValidate := False;
                tedit(sender).Text := Double.ToString(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].PRecord.VALUE_QUANTITY);
                TempEditLabel.canValidate := True;
              end;
            end;

          end;
        end;
      end
      else
      begin
        TempEditLabel.canValidate := False;
        tedit(sender).Text := '';
        TempEditLabel.canValidate := True;
      end;
    end;
  else
    begin
      Caption := 'ddd';
    end;
  end;
  if tedit(sender).Text <> '' then
  begin
    TempEditLabel.chk.IsChecked := true;
    TempEditLabel.rctNull.Visible := false;
  end
  else
  begin
    TempEditLabel.chk.IsChecked := false;
    TempEditLabel.rctNull.Visible := true;
  end;
  MarkSourceAnsw(TempEditLabel.SourceAnsw, TempEditLabel.rctSourceAnsw);
end;

procedure TfrmProfFormFMX.edtCl132Validate(Sender: TObject; var Text: string);
var
  TempEdit: TEdit;
  TempEditLabel: TEditLabel;
begin
  TempEdit := TEdit(Sender);
  TempEditLabel := TEditLabel(TempEdit.TagObject);
  if FIsVtrPregled then
  begin
    if Text = '' then
    begin
      VtrPregLink.CheckType[TempEditLabel.node] := ctNone;
    end
    else
    begin
      VtrPregLink.CheckType[TempEditLabel.node] := ctCheckBox;
      VtrPregLink.CheckState[TempEditLabel.node] := csCheckedNormal;
    end;
    //VtrPregLink.Selected[TempEditLabel.node] := True;
  end;
end;

procedure TfrmProfFormFMX.edtCl132Validating(Sender: TObject; var Text: string);
var
  TempEdit: TEdit;
  TempEditLabel: TEditLabel;
  AnswValue: TRealNZIS_ANSWER_VALUEItem;
  ResDiagRep: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
  data, dataAnswVal, dataResDiagRep: PAspRec;
  linkPos, cl134Pos, cl144Pos: Cardinal;
  cl134Key: string;
  i: Integer;
begin
  TempEdit := TEdit(Sender);
  TempEditLabel := TEditLabel(TempEdit.TagObject);
  if not TempEditLabel.canValidate then Exit;

  if FIsVtrPregled then
  begin
    data := Pointer(PByte(TempEditLabel.node) + lenNode);
    if Text = '' then
    begin
      VtrPregLink.BeginUpdate;
      VtrPregLink.CheckType[TempEditLabel.node] := ctNone;
      if TempEditLabel.node.FirstChild <> nil then
        FAspLink.MarkDeletedNode(TempEditLabel.node.FirstChild);
      VtrPregLink.endUpdate;
    end
    else
    begin
      TempEditLabel.chk.IsChecked := True;
      VtrPregLink.CheckType[TempEditLabel.node] := ctCheckBox;
      VtrPregLink.CheckState[TempEditLabel.node] := csCheckedNormal;

      if TempEditLabel.node.FirstChild = nil then
      begin
        case data.vid of
          vvNZIS_QUESTIONNAIRE_ANSWER:
          begin
            answTemp.DataPos := Data.DataPos;
            cl134Pos := answTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS));
            cl134Temp.DataPos := cl134Pos;
            answTemp.cl028 := StrToInt(cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL134_CL028)));
            AnswValue := TRealNZIS_ANSWER_VALUEItem(Adb_dm.CollNZIS_ANSWER_VALUE.Add);
            Memo1.Text := IntToStr(Adb_dm.CollNZIS_ANSWER_VALUE.Count) + '(Adb_dm.CollNZIS_ANSWER_VALUE.Add)' ;
            New(AnswValue.PRecord);
            case answTemp.cl028 of
              1: //Количествено представяне
              begin
                AnswValue.PRecord.ANSWER_QUANTITY := string.ToDouble(text);
                AnswValue.PRecord.ID := 0;
                AnswValue.PRecord.QUESTIONNAIRE_ANSWER_ID := 0;
                AnswValue.PRecord.CL028 := 1;

                AnswValue.PRecord.setProp :=
                [NZIS_ANSWER_VALUE_ANSWER_QUANTITY
                , NZIS_ANSWER_VALUE_ID
                , NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID
                , NZIS_ANSWER_VALUE_CL028];

                AnswValue.InsertNZIS_ANSWER_VALUE;
                Dispose(AnswValue.PRecord);
                AnswValue.PRecord := nil;
              end;
            end;
            FAspLink.AddNewNode(vvNZIS_ANSWER_VALUE, AnswValue.DataPos, TempEditLabel.node, amAddChildLast, TempEditLabel.nodeValue, linkpos);
            dataAnswVal := Pointer(PByte(TempEditLabel.node.FirstChild) + lenNode);
            dataAnswVal.index := Adb_DM.CollNZIS_ANSWER_VALUE.Count - 1;
          end;
          vvNZIS_RESULT_DIAGNOSTIC_REPORT:
          begin
            ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Add);
            ResDiagRep.DataPos := Data.DataPos;
            cl144Pos := ResDiagRep.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
            cl144Temp.DataPos := cl144Pos;
            ResDiagRep.cl028 := StrToInt(cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL144_CL028)));
            New(ResDiagRep.PRecord);
            case ResDiagRep.cl028 of
              1: //Количествено представяне
              begin
                ResDiagRep.PRecord.VALUE_QUANTITY := string.ToDouble(text);
                ResDiagRep.PRecord.ID := 0;
                ResDiagRep.PRecord.DIAGNOSTIC_REPORT_ID := 0;
                ResDiagRep.PRecord.CL028_VALUE_SCALE := 1;

                ResDiagRep.PRecord.setProp :=
                [NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY
                , NZIS_RESULT_DIAGNOSTIC_REPORT_ID
                , NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID
                , NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE];

                ResDiagRep.InsertNZIS_RESULT_DIAGNOSTIC_REPORT;
                Dispose(ResDiagRep.PRecord);
                ResDiagRep.PRecord := nil;
              end;
            end;
            FAspLink.AddNewNode(vvNZIS_RESULT_DIAGNOSTIC_REPORT, ResDiagRep.DataPos, TempEditLabel.node, amAddChildLast, TempEditLabel.nodeValue, linkpos);
            dataResDiagRep := Pointer(PByte(TempEditLabel.node.FirstChild) + lenNode);
            dataResDiagRep.index := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Count - 1;
          end;
        end;
      end
      else
      begin
        case data.vid of
          vvNZIS_QUESTIONNAIRE_ANSWER:
          begin
            answTemp.DataPos := Data.DataPos;
            dataAnswVal := Pointer(PByte(TempEditLabel.node.FirstChild) + lenNode);
            if dataAnswVal.index >= 0 then
            begin
              AnswValue := Adb_DM.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index];
              if AnswValue.PRecord <> nil then
              begin
                case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                  1:
                  begin
                    AnswValue.PRecord.setProp := [];
                    AnswValue.PRecord.ANSWER_QUANTITY := string.ToDouble(text);
                    Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_QUANTITY);
                  end;
                end;
              end
              else
              begin
                New(AnswValue.PRecord);
                case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                  1:
                  begin
                    AnswValue.PRecord.setProp := [];
                    AnswValue.PRecord.ANSWER_QUANTITY := string.ToDouble(text);
                    Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_QUANTITY);
                  end;
                end;
              end;
            end
            else
            begin
              AnswValue := TRealNZIS_ANSWER_VALUEItem(Adb_dm.CollNZIS_ANSWER_VALUE.Add);
              Memo1.Text := IntToStr(Adb_dm.CollNZIS_ANSWER_VALUE.Count) + '(Adb_dm.CollNZIS_ANSWER_VALUE.Add)' ;
              AnswValue.DataPos := dataAnswVal.DataPos;
              dataAnswVal.index := Adb_DM.CollNZIS_ANSWER_VALUE.Count - 1;
              New(AnswValue.PRecord);
              case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                1:
                begin
                  AnswValue.PRecord.setProp := [];
                  AnswValue.PRecord.ANSWER_QUANTITY := string.ToDouble(text);
                  Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_QUANTITY);
                end;
              end;
            end;


          end;
          vvNZIS_RESULT_DIAGNOSTIC_REPORT:
          begin
            RESULT_DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
            dataResDiagRep := Pointer(PByte(TempEditLabel.node.FirstChild) + lenNode);
            if dataResDiagRep.index >= 0 then
            begin
              ResDiagRep := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiagRep.index];
              if ResDiagRep.PRecord <> nil then
              begin
                case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                  1:
                  begin
                    ResDiagRep.PRecord.setProp := [];
                    ResDiagRep.PRecord.VALUE_QUANTITY := string.ToDouble(text);
                    Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY);
                  end;
                end;
              end
              else
              begin
                New(ResDiagRep.PRecord);
                case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                  1:
                  begin
                    ResDiagRep.PRecord.setProp := [];
                    ResDiagRep.PRecord.VALUE_QUANTITY := string.ToDouble(text);
                    Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY);
                  end;
                end;
              end;
            end
            else
            begin
              ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Add);
              ResDiagRep.DataPos := dataResDiagRep.DataPos;
              dataResDiagRep.index := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Count - 1;
              New(ResDiagRep.PRecord);
              case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                1:
                begin
                  ResDiagRep.PRecord.setProp := [];
                  ResDiagRep.PRecord.VALUE_QUANTITY := string.ToDouble(text);
                  Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
   // VtrPregLink.Selected[TempEditLabel.node] := True;
    //FAspLink.FVTR.RepaintNode(TempEditLabel.node.FirstChild);
  end;
end;

procedure TfrmProfFormFMX.edtCl132ValidatingSup(Sender: TObject;
  var Text: string);

 var
  TempEditLYT: TLayout;
  TempEditLabel: TEditLabel;
  AnswValue: TRealNZIS_ANSWER_VALUEItem;
  ResDiagRep: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
  data, dataAnswVal, dataResDiagRep: PAspRec;
  linkPos, cl134Pos, cl144Pos: Cardinal;
  cl134Key: string;
  i: Integer;
  ddd: double;
begin
  TempEditLYT := TLayout(TEdit(Sender).Parent);
  TempEditLabel := TEditLabel(TempEditLYT.TagObject);
  if (Text <> '') and ( not TryStrToFloat(Text, ddd)) then
  begin
    Text := TEdit(Sender).Text;
    if  Text = '' then
    begin
      TempEditLabel.rctNull.Visible := True;
      TempEditLabel.chk.IsChecked := false;
    end
    else
    begin
      TempEditLabel.rctNull.Visible := false;
      TempEditLabel.chk.IsChecked := true;
    end;
    MarkSourceAnsw(TempEditLabel.SourceAnsw, TempEditLabel.rctSourceAnsw);
    Exit;
  end;


  if not TempEditLabel.canValidate then Exit;

  if FIsVtrPregled then
  begin
    data := Pointer(PByte(TempEditLabel.node) + lenNode);
    if Text = '' then
    begin
      VtrPregLink.BeginUpdate;
      VtrPregLink.CheckType[TempEditLabel.node] := ctNone;
      if TempEditLabel.node.FirstChild <> nil then
        FAspLink.MarkDeletedNode(TempEditLabel.node.FirstChild);
      VtrPregLink.endUpdate;
      TempEditLabel.chk.IsChecked := false;
      TempEditLabel.rctNull.Visible := true;
    end
    else
    begin
      TempEditLabel.chk.IsChecked := True;
      TempEditLabel.rctNull.Visible := false;
      VtrPregLink.CheckType[TempEditLabel.node] := ctCheckBox;
      VtrPregLink.CheckState[TempEditLabel.node] := csCheckedNormal;

      if TempEditLabel.node.FirstChild = nil then
      begin
        case data.vid of
          vvNZIS_QUESTIONNAIRE_ANSWER:
          begin
            answTemp.DataPos := Data.DataPos;
            cl134Pos := answTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS));
            cl134Temp.DataPos := cl134Pos;
            answTemp.cl028 := StrToInt(cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL134_CL028)));
            AnswValue := TRealNZIS_ANSWER_VALUEItem(Adb_dm.CollNZIS_ANSWER_VALUE.Add);
            Memo1.Text := IntToStr(Adb_dm.CollNZIS_ANSWER_VALUE.Count) + '(Adb_dm.CollNZIS_ANSWER_VALUE.Add)' ;
            New(AnswValue.PRecord);
            case answTemp.cl028 of
              1: //Количествено представяне
              begin
                AnswValue.PRecord.ANSWER_QUANTITY := string.ToDouble(text);
                AnswValue.PRecord.ID := 0;
                AnswValue.PRecord.QUESTIONNAIRE_ANSWER_ID := 0;
                AnswValue.PRecord.CL028 := 1;

                AnswValue.PRecord.setProp :=
                [NZIS_ANSWER_VALUE_ANSWER_QUANTITY
                , NZIS_ANSWER_VALUE_ID
                , NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID
                , NZIS_ANSWER_VALUE_CL028];

                AnswValue.InsertNZIS_ANSWER_VALUE;
                Dispose(AnswValue.PRecord);
                AnswValue.PRecord := nil;
              end;
            end;
            FAspLink.AddNewNode(vvNZIS_ANSWER_VALUE, AnswValue.DataPos, TempEditLabel.node, amAddChildLast, TempEditLabel.nodeValue, linkpos);
            dataAnswVal := Pointer(PByte(TempEditLabel.node.FirstChild) + lenNode);
            dataAnswVal.index := Adb_DM.CollNZIS_ANSWER_VALUE.Count - 1;
          end;
          vvNZIS_RESULT_DIAGNOSTIC_REPORT:
          begin
            ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Add);
            ResDiagRep.DataPos := Data.DataPos;
            cl144Pos := ResDiagRep.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
            cl144Temp.DataPos := cl144Pos;
            ResDiagRep.cl028 := StrToInt(cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL144_CL028)));
            New(ResDiagRep.PRecord);
            case ResDiagRep.cl028 of
              1: //Количествено представяне
              begin
                ResDiagRep.PRecord.VALUE_QUANTITY := string.ToDouble(text);
                ResDiagRep.PRecord.ID := 0;
                ResDiagRep.PRecord.DIAGNOSTIC_REPORT_ID := 0;
                ResDiagRep.PRecord.CL028_VALUE_SCALE := 1;

                ResDiagRep.PRecord.setProp :=
                [NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY
                , NZIS_RESULT_DIAGNOSTIC_REPORT_ID
                , NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID
                , NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE];

                ResDiagRep.InsertNZIS_RESULT_DIAGNOSTIC_REPORT;
                Dispose(ResDiagRep.PRecord);
                ResDiagRep.PRecord := nil;
              end;
            end;
            FAspLink.AddNewNode(vvNZIS_RESULT_DIAGNOSTIC_REPORT, ResDiagRep.DataPos, TempEditLabel.node, amAddChildLast, TempEditLabel.nodeValue, linkpos);
            dataResDiagRep := Pointer(PByte(TempEditLabel.node.FirstChild) + lenNode);
            dataResDiagRep.index := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Count - 1;
          end;
        end;
      end
      else
      begin
        case data.vid of
          vvNZIS_QUESTIONNAIRE_ANSWER:
          begin
            answTemp.DataPos := Data.DataPos;
            dataAnswVal := Pointer(PByte(TempEditLabel.node.FirstChild) + lenNode);
            if dataAnswVal.index >= 0 then
            begin
              AnswValue := Adb_DM.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index];
              if AnswValue.PRecord <> nil then
              begin
                case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                  1:
                  begin
                    AnswValue.PRecord.setProp := [];
                    AnswValue.PRecord.ANSWER_QUANTITY := string.ToDouble(text);
                    Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_QUANTITY);
                  end;
                end;
              end
              else
              begin
                New(AnswValue.PRecord);
                case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                  1:
                  begin
                    AnswValue.PRecord.setProp := [];
                    AnswValue.PRecord.ANSWER_QUANTITY := string.ToDouble(text);
                    Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_QUANTITY);
                  end;
                end;
              end;
            end
            else
            begin
              AnswValue := TRealNZIS_ANSWER_VALUEItem(Adb_dm.CollNZIS_ANSWER_VALUE.Add);
              Memo1.Text := IntToStr(Adb_dm.CollNZIS_ANSWER_VALUE.Count) + '(Adb_dm.CollNZIS_ANSWER_VALUE.Add)' ;
              AnswValue.DataPos := dataAnswVal.DataPos;
              dataAnswVal.index := Adb_DM.CollNZIS_ANSWER_VALUE.Count - 1;
              New(AnswValue.PRecord);
              case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                1:
                begin
                  AnswValue.PRecord.setProp := [];
                  AnswValue.PRecord.ANSWER_QUANTITY := string.ToDouble(text);
                  Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_QUANTITY);
                end;
              end;
            end;


          end;
          vvNZIS_RESULT_DIAGNOSTIC_REPORT:
          begin
            RESULT_DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
            dataResDiagRep := Pointer(PByte(TempEditLabel.node.FirstChild) + lenNode);
            if dataResDiagRep.index >= 0 then
            begin
              ResDiagRep := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiagRep.index];
              if ResDiagRep.PRecord <> nil then
              begin
                case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                  1:
                  begin
                    ResDiagRep.PRecord.setProp := [];
                    ResDiagRep.PRecord.VALUE_QUANTITY := string.ToDouble(text);
                    Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY);
                  end;
                end;
              end
              else
              begin
                New(ResDiagRep.PRecord);
                case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                  1:
                  begin
                    ResDiagRep.PRecord.setProp := [];
                    ResDiagRep.PRecord.VALUE_QUANTITY := string.ToDouble(text);
                    Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY);
                  end;
                end;
              end;
            end
            else
            begin
              ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Add);
              ResDiagRep.DataPos := dataResDiagRep.DataPos;
              dataResDiagRep.index := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Count - 1;
              New(ResDiagRep.PRecord);
              case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                1:
                begin
                  ResDiagRep.PRecord.setProp := [];
                  ResDiagRep.PRecord.VALUE_QUANTITY := string.ToDouble(text);
                  Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
    if  Text = '' then
    begin
      TempEditLabel.rctNull.Visible := True;
      TempEditLabel.chk.IsChecked := false;
    end
    else
    begin
      TempEditLabel.rctNull.Visible := false;
      TempEditLabel.chk.IsChecked := true;
    end;
    MarkSourceAnsw(TempEditLabel.SourceAnsw, TempEditLabel.rctSourceAnsw);
  end;
end;

procedure TfrmProfFormFMX.edtDateIncNaprPainting(Sender: TObject;
  Canvas: TCanvas; const ARect: TRectF);
var
  edt: TEdit;
  dataInkNapr: PAspRec;
begin
  if pregNodes.incNaprNode = nil  then Exit;

  edt := TEdit(sender);
  dataInkNapr := Pointer(PByte(pregNodes.incNaprNode) + lenNode);
  edt.Text := FormatDateTime('DD.MM.YYYY г.', Adb_DM.CollIncMN.getDateMap(dataInkNapr.DataPos, Word(INC_NAPR_ISSUE_DATE)));
end;

procedure TfrmProfFormFMX.edtDateRawPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  edt: TEdit;
  datEdit: TDateEdit;
  fs: TFormatSettings;
begin
  edt := TEdit(Sender);
  if edt.IsFocused then Exit;
  datEdit := TDateEdit(edt.Parent);
  if not datEdit.IsChecked then Exit;

  fs := TFormatSettings.Create();
  fs.DateSeparator := '.';
  fs.ShortDateFormat := 'DD.MM.YYYY';
  edt.Text := DateToStr(datEdit.date, fs);
  edt.FontColor := TAlphaColorRec.Green;
end;

procedure TfrmProfFormFMX.edtDateRawValidating(Sender: TObject;
  var Text: string);
var
  Adate: TDate;
   fs: TFormatSettings;
  edt: TEdit;
  datEdit: TDateEdit;
  data: PAspRec;
  TempDateEditLabel: TDateEditLabel;
begin
  edt := TEdit(Sender);
  if not edt.IsFocused then Exit;
  if Text <> '' then
  begin
    fs := TFormatSettings.Create();
    fs.DateSeparator := '.';
    fs.ShortDateFormat := 'DD.MM.YYYY';
    Adate := StrToDateDef(Text, 0, fs);
    if Adate <> 0 then
    begin
      edt.FontColor := TAlphaColorRec.Green;
      datEdit := TDateEdit(edt.Parent);
      datEdit.Date := Adate;
      if not datEdit.IsChecked then
        datEdit.IsChecked := true
    end
    else
    begin
      edt.FontColor := TAlphaColorRec.Red;
    end;
  end
  else
  begin
    edt.FontColor := TAlphaColorRec.Black;
    TempDateEditLabel := TDateEditLabel(TDateEdit(edt.Parent.parent).TagObject);
    data := Pointer(PByte(TempDateEditLabel.node) + lenNode);
    TempDateEditLabel.canValidate := False;
    TDateEdit(edt.Parent).IsChecked := false;
    TDateEdit(edt.Parent).Format := ' ';
    VtrPregLink.BeginUpdate;
    VtrPregLink.CheckType[TempDateEditLabel.node] := ctNone;
    if TempDateEditLabel.node.FirstChild <> nil then
      FAspLink.MarkDeletedNode(TempDateEditLabel.node.FirstChild);
    VtrPregLink.endUpdate;
    TempDateEditLabel.canValidate := true;
  end;

end;

procedure TfrmProfFormFMX.edtDoctorNamePainting(Sender: TObject;
  Canvas: TCanvas; const ARect: TRectF);
var
  dataDoctor: PAspRec;
begin
  dataDoctor := Pointer(PByte(pregNodes.perfNode) + lenNode);
  edtDoctorName.Text := Adb_DM.CollDoctor.getAnsiStringMap(dataDoctor.DataPos, word(Doctor_FNAME)) +  ' ' +
                     Adb_DM.CollDoctor.getAnsiStringMap(dataDoctor.DataPos, word(Doctor_SNAME)) +  ' ' +
                     Adb_DM.CollDoctor.getAnsiStringMap(dataDoctor.DataPos, word(Doctor_LNAME));
  //if patNodes.docNode <> nil then
//  begin
//    dataDoctor := Pointer(PByte(patNodes.docNode) + lenNode);
//    edtDoctorName.Text := DoctorColl.getAnsiStringMap(dataDoctor.DataPos, word(Doctor_FNAME)) +  ' ' +
//                       DoctorColl.getAnsiStringMap(dataDoctor.DataPos, word(Doctor_SNAME)) +  ' ' +
//                       DoctorColl.getAnsiStringMap(dataDoctor.DataPos, word(Doctor_LNAME));
//  end
//  else
//  begin
//
//  end;
end;

procedure TfrmProfFormFMX.edtDoctorUinPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  dataDoctor: PAspRec;
begin

  dataDoctor := Pointer(PByte(pregNodes.perfNode) + lenNode);
  edtDoctorUin.Text := Adb_DM.CollDoctor.getAnsiStringMap(dataDoctor.DataPos, word(Doctor_UIN));
  //if patNodes.docNode <> nil then
//  begin
//    dataDoctor := Pointer(PByte(patNodes.docNode) + lenNode);
//    edtDoctorUin.Text := DoctorColl.getAnsiStringMap(dataDoctor.DataPos, word(Doctor_UIN));
//  end
//  else
//  begin
//
//  end;
end;

procedure TfrmProfFormFMX.edtEGNPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  dataPatient, dataPreg: PAspRec;
begin
  if edtEGN.IsFocused then Exit;
  dataPatient := Pointer(PByte(patNodes.patNode) + lenNode);
  dataPreg := Pointer(PByte(FPregled.FNode) + lenNode);

  edtEGN.Text := Adb_DM.CollPatient.getAnsiStringMap(dataPatient.DataPos, word(PatientNew_EGN));
end;

procedure TfrmProfFormFMX.edtEGNValidating(Sender: TObject; var Text: string);
var
  dataPatient: PAspRec;

  //treeLink: PVirtualNode;
  //linkpos: Cardinal;

  pat: TRealPatientNewItem;
  patIndex, i, j, k: Integer;
begin
  if not edtEGN.IsFocused then Exit;
  dataPatient := Pointer(PByte(patNodes.patNode) + lenNode);
  patEgn := Adb_DM.CollPatient.getAnsiStringMap(dataPatient.DataPos, word(PatientNew_EGN));

  patIndex := Adb_DM.CollPatient.FindItemFromDataPos(dataPatient.DataPos);
  if patIndex >= 0 then  // има го в колекцията
  begin
    pat := Adb_DM.CollPatient.Items[patIndex];
  end
  else
  begin
    pat := TRealPatientNewItem(Adb_DM.CollPatient.Add);// добавям го в колекцията
    pat.DataPos := dataPatient.DataPos;
  end;

  if pat.PRecord = nil then
  begin
    New(pat.PRecord);
    pat.PRecord.setProp := [];
  end;
  pat.PRecord.EGN := Text;
  Include(pat.PRecord.setProp, PatientNew_EGN);

  if Assigned(FOnchangeColl) then
    FOnchangeColl(pat);
end;

procedure TfrmProfFormFMX.edtIzslChangeTracking(Sender: TObject);
var
  arrStr: TArray<string>;
  i, j: Integer;
  TempMdnsLabel: TMdnsLabel;
  edtAnal: TEdit;
begin
  arrStr := TEdit(sender).Text.Split(['; ']);
  j := LstMdns.Count;
  for i := 0 to Length(arrStr) - 1 do
  begin
    if (i mod 6) = 0 then
    begin
      Rectangle3MouseUp(nil, TMouseButton.mbLeft, [], 0, 0);
      TempMdnsLabel:= TMdnsLabel(LstMdns[j].TagObject);
      edtAnal := TempMdnsLabel.LstAnals[0].edtAnal;
      edtAnal.Text := arrStr[i];
      //edtAnal.SetFocus;
      InnerEdtAnalCodeChangeTracking(edtAnal);
      inc(j);
    end
    else
    begin
      TempMdnsLabel:= TMdnsLabel(LstMdns[j- 1].TagObject);
      edtAnal := TempMdnsLabel.LstAnals[i mod 6].edtAnal;
      edtAnal.Text := arrStr[i];
      //edtAnal.SetFocus;
      InnerEdtAnalCodeChangeTracking(edtAnal);
    end;
  end;

end;

procedure TfrmProfFormFMX.edtAnalCodeChangeTracking(Sender: TObject);
var
  edtAnalCode: TEdit;
  TempLyt: TLayout;
  TempMdnsLabel: TMdnsLabel;
  TempMdnAnal: TMdnAnals;
  anal: TRealExamAnalysisItem;
  oldCode: string;
  indx: Integer;
begin
  if not TEdit(Sender).IsFocused then Exit;
  InnerEdtAnalCodeChangeTracking(TEdit(Sender));
  Exit;
  edtAnalCode := TEdit(Sender);
  TempLyt := TLayout(edtAnalCode.Parent.Parent);
  TempMdnsLabel:= TMdnsLabel(TempLyt.TagObject);
  TempMdnAnal := TMdnAnals(edtAnalCode.TagObject);
  if TempMdnAnal = nil then // ново
  begin
    TempMdnAnal :=  TMdnAnals.Create;
    edtAnalCode.TagObject := TempMdnAnal;
    if Assigned(FOnAddNewAnal) then
      FOnAddNewAnal(TempMdnsLabel.mdn, TempMdnsLabel.LinkMdn, TempMdnAnal.LinkAnal, TempMdnAnal.Anal);
  end;
  if edtAnalCode.Text = '' then // изтривам го
  begin
    if Assigned(FOnDeleteNewAnal) then
    begin
      if TempMdnAnal.Anal.LinkNode <> nil then
      begin
        TempMdnAnal.LinkAnal  := TempMdnAnal.Anal.LinkNode;
      end;
      FOnDeleteNewAnal(TempMdnsLabel.mdn, TempMdnsLabel.LinkMdn, TempMdnAnal.LinkAnal, TempMdnAnal.Anal);
      TempMdnAnal.Anal.Destroy;
      TempMdnAnal.Anal := nil;
      edtAnalCode.TagObject := nil;
      //TempMdnAnal.Destroy;
      //TempMdnAnal := nil;
      Exit;
    end;

  end;
  anal := TempMdnAnal.Anal;
  if anal.DataPos <> 0 then
  begin
    oldCode := anal.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(ExamAnalysis_NZIS_CODE_CL22));
  end
  else
  begin
    oldCode := '';
  end;
  if oldCode <> edtAnalCode.Text then
  begin
    if anal.PRecord = nil then
    begin
      New(anal.PRecord);
      anal.PRecord.setProp := [];
      if anal.Collection = nil then
        anal.Collection := FExamAnalColl;
    end;
    Include(anal.PRecord.setProp, ExamAnalysis_NZIS_CODE_CL22);
    anal.PRecord.NZIS_CODE_CL22 := edtAnalCode.Text;
  end
  else
  begin
    if anal.PRecord <> nil then
    begin
      Exclude(anal.PRecord.setProp, ExamAnalysis_NZIS_CODE_CL22);
      if anal.PRecord.setProp = [] then
      begin
        Dispose(anal.PRecord);
        anal.PRecord := nil;
      end;
    end;
  end;

  if Assigned(FOnchangeColl) then
    FOnchangeColl(anal);
  //if (TempMdnAnal.Anal <> nil) and (TempMdnAnal.Anal.LinkNode <> nil) then
//  begin
//    TempMdnAnal.LinkAnal  := TempMdnAnal.Anal.LinkNode;
//  end;
end;

procedure TfrmProfFormFMX.edtMainDiagEnter(Sender: TObject);
var
  TempDiagLabel: TDiagLabel;
  tempDiagRect: TRectangle;
begin
  LoadKeyBoardLayout('00000409',1);
  tempDiagRect := TRectangle(TFmxObject(Sender).parent.parent);
  TempDiagLabel := TDiagLabel(LstDiags[tempDiagRect.tag].TagObject);
  if Assigned(FOnChoicerMkb) then
    FOnChoicerMkb(FPregled);
end;

procedure TfrmProfFormFMX.edtMainDiagExit(Sender: TObject);
begin
  LoadKeyBoardLayout('00040402',1);
end;

procedure TfrmProfFormFMX.edtMainDiagValidating(Sender: TObject;
  var Text: string);
var
  TempDiagLabel: TDiagLabel;
  tempDiagRect: TRectangle;
  mkbPos: Cardinal;
  IndexMkb: Integer;
begin
  tempDiagRect := TRectangle(TFmxObject(Sender).parent.parent);
  TempDiagLabel := TDiagLabel(LstDiags[tempDiagRect.tag].TagObject);
  if not TempDiagLabel.canValidate then Exit;
  Text := UpperCase(text);


  if  (Assigned(TempDiagLabel.diag)) and (TempDiagLabel.diag.DataPos > 0) then
  begin
    Adb_DM.CollDiag.SetAnsiStringMap(TempDiagLabel.diag.DataPos, word(Diagnosis_code_CL011), Text);
    TempDiagLabel.SelectMain.Fill.Color := $FFFBD3C6;
    //TempDiagLabel.edtMain.Text := TempDiagLabel.diag.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(Diagnosis_code_CL011));
//    TempDiagLabel.edtAdd.Text := TempDiagLabel.diag.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(Diagnosis_additionalCode_CL011));
//   // TempDiagLabel.diag.PData.DataPos
//    if TempDiagLabel.diag <> nil then
//    begin
//      mkbPos := TempDiagLabel.diag.getCardMap(FAspAdbBuf, FAspAdbPosData, word(Diagnosis_MkbPos));
//      if mkbPos > 100 then
//        TempDiagLabel.mmoDiag.Text := MKBColl.getAnsiStringMap(mkbPos, word(Mkb_NAME))
//      else
//        TempDiagLabel.mmoDiag.Text := '100';
//    end;
  end
  else
  begin
    if TTempVtrHelper(FTmpVtr).FindMkbDataPosFromCode(Text, IndexMkb) then
    begin
      TempDiagLabel.SelectMain.Fill.Color := $FFE4F6C8;
    end
    else
    begin
      TempDiagLabel.SelectMain.Fill.Color := $FFFBD3C6;
    end;
  end;

end;

procedure TfrmProfFormFMX.edtMdn1KeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkF12 then
  begin
    if Assigned(FOnChoicerAnal) then
      FOnChoicerAnal(Sender);
  end;
end;

procedure TfrmProfFormFMX.edtMdnChangeTracking(Sender: TObject);
var
  edtNrnMdn: TEdit;
  TempLyt: TLayout;
  TempMdnsLabel: TMdnsLabel;
  mdn, newMdn: TRealMDNItem;
  oldNrn: string;
begin
  if not TEdit(Sender).IsFocused then Exit;
  edtNrnMdn := TEdit(Sender);
  TempLyt := TLayout(edtNrnMdn.Parent.Parent);
  TempMdnsLabel:= TMdnsLabel(TempLyt.TagObject);
  mdn := TempMdnsLabel.mdn;
  oldNrn := mdn.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(MDN_NRN));
  if oldNrn <> edtNrnMdn.Text then
  begin
    if mdn.PRecord = nil then
    begin
      New(mdn.PRecord);
      mdn.PRecord.setProp := [];
      mdn.Collection := Adb_DM.CollMDN;
    end;
    Include(mdn.PRecord.setProp, TMDNItem.TPropertyIndex.MDN_NRN);
    mdn.PRecord.NRN := edtNrnMdn.Text;
  end
  else
  begin
    if mdn.PRecord <> nil then
    begin
      Exclude(mdn.PRecord.setProp, TMDNItem.TPropertyIndex.MDN_NRN);
      if mdn.PRecord.setProp = [] then
      begin
        Dispose(mdn.PRecord);
        mdn.PRecord := nil;
      end;
    end;
  end;
  if Assigned(FOnchangeColl) then
    FOnchangeColl(mdn);
end;

procedure TfrmProfFormFMX.edtMN1ChangeTracking(Sender: TObject);
begin
  TEdit(Sender).text:= AnsiUpperCase(TEdit(Sender).text);
end;

procedure TfrmProfFormFMX.edtMN1Enter(Sender: TObject);

begin
  KeyLocal :=  GetKeyboardLayout(0);
  LoadKeyBoardLayout('00000409',1);
end;

procedure TfrmProfFormFMX.edtMN1Exit(Sender: TObject);
begin
  ActivateKeyboardLayout(KeyLocal,1);
end;

procedure TfrmProfFormFMX.edtMN1KeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
var
  TempLyt: TLayout;
  TempMnsLabel: TMnsLabel;
  TempEdt: TEdit;
  MnDiag: TMnDiag;
begin
  if Key = vkF12 then
  begin
    if Assigned(FOnChoicerMkb) then
    begin
      TempEdt := TEdit(Sender);
      TempLyt := TLayout(TempEdt.Parent.Parent.Parent);
      TempMnsLabel := TMnsLabel(TempLyt.TagObject);
      MnDiag := TMnDiag(TempEdt.TagObject);
      //TempMnsLabel.LstMkbs[i] TempEdt
//      TempMnsLabel.LstMkbs[i].edtMkb.TagObject := TempMnsLabel.LstMkbs[i];
//      TempMnsLabel.LstMkbs[i].edtMkb.OnKeyDown := edtMn1KeyDown;
      if MnDiag <> nil then
        FOnChoicerMkb(MnDiag.MKB)
      else
      begin
        FOnChoicerMkb(TempMnsLabel.LstMkbs);
      end;
    end;
  end;
end;

procedure TfrmProfFormFMX.edtPatNamePainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  dataPatient, dataPreg: PAspRec;

  P, p1, p2: ^Integer;
  PLen: ^Word;
  pData, PData1: PAnsiChar;
  ofset, ofset1, ofset2, hist: Cardinal;
  PHist: PCardinal;

  patIndex: integer;
  pat: TRealPatientNewItem;
  patNameF, patNameS, patNameL: string;
begin
  if edtPatName.IsFocused then Exit;
  dataPatient := Pointer(PByte(patNodes.patNode) + lenNode);
  dataPreg := Pointer(PByte(FPregled.FNode) + lenNode);
  patIndex := FPatientColl.FindItemFromDataPos(dataPatient.DataPos);


  if patIndex >= 0 then  // има го в колекцията
  begin
    pat := ADB_DM.CollPatient.Items[patIndex];
    if (pat.PRecord <> nil) and (PatientNew_FNAME in pat.PRecord.setProp) then
      patNameF := pat.PRecord.FNAME
    else
      patNameF := ADB_DM.CollPatient.getAnsiStringMap(dataPatient.DataPos, word(PatientNew_FNAME));

    if (pat.PRecord <> nil) and (PatientNew_SNAME in pat.PRecord.setProp) then
      patNameS := pat.PRecord.SNAME
    else
      patNameS := ADB_DM.CollPatient.getAnsiStringMap(dataPatient.DataPos, word(PatientNew_SNAME));

    if (pat.PRecord <> nil) and (PatientNew_LNAME in pat.PRecord.setProp) then
      patNameL := pat.PRecord.LNAME
    else
      patNameL := ADB_DM.CollPatient.getAnsiStringMap(dataPatient.DataPos, word(PatientNew_LNAME));
  end
  else
  begin
    patNameF := ADB_DM.CollPatient.getAnsiStringMap(dataPatient.DataPos, word(PatientNew_FNAME));
    patNameS := ADB_DM.CollPatient.getAnsiStringMap(dataPatient.DataPos, word(PatientNew_SNAME));
    patNameL := ADB_DM.CollPatient.getAnsiStringMap(dataPatient.DataPos, word(PatientNew_LNAME));
  end;
  edtPatName.Text := patNameF +  ' ' + patNameS + ' ' + patNameL;
end;

procedure TfrmProfFormFMX.edtPatNameValidating(Sender: TObject;
  var Text: string);
var
  dataPatient: PAspRec;

  //treeLink: PVirtualNode;
  //linkpos: Cardinal;

  ArrStr1, ArrStr: TArray<string>;
  pat: TRealPatientNewItem;
  patIndex, i, j, k: Integer;
begin
  if not edtPatName.IsFocused then Exit;

  while Text.Contains('  ') do
  begin
    text := text.Replace('  ', ' ');
  end;
  ArrStr1 := text.Split([' ']);
  case Length(arrstr1) of
    2:
    begin
      SetLength(ArrStr, 3);
      ArrStr[0] := ArrStr1[0];
      ArrStr[1] := '';
      ArrStr[2] := ArrStr1[1];
    end;
    3:
    begin
      SetLength(ArrStr, 3);
      ArrStr[0] := ArrStr1[0];
      ArrStr[1] := ArrStr1[1];
      ArrStr[2] := ArrStr1[2];
    end;
    4..10:
    begin
      SetLength(ArrStr, 3);
      ArrStr[0] := ArrStr1[0];
      ArrStr[1] := string.Join(' ', ArrStr1, 1, Length(ArrStr1) -2);
      ArrStr[2] := ArrStr1[Length(ArrStr1) -1];
    end;
  else
    Text := edtPatName.Text;
    Exit;
  end;


  dataPatient := Pointer(PByte(patNodes.patNode) + lenNode);
  patNameF := ADB_DM.CollPatient.getAnsiStringMap(dataPatient.DataPos, word(PatientNew_FNAME));
  patNameS := ADB_DM.CollPatient.getAnsiStringMap(dataPatient.DataPos, word(PatientNew_SNAME));
  patNameL := ADB_DM.CollPatient.getAnsiStringMap(dataPatient.DataPos, word(PatientNew_LNAME));

  patIndex := ADB_DM.CollPatient.FindItemFromDataPos(dataPatient.DataPos);
  if patIndex >= 0 then  // има го в колекцията
  begin
    pat := ADB_DM.CollPatient.Items[patIndex];
  end
  else
  begin
    pat := TRealPatientNewItem(ADB_DM.CollPatient.Add);// добавям го в колекцията
    pat.DataPos := dataPatient.DataPos;
  end;

  if pat.PRecord = nil then
  begin
    New(pat.PRecord);
    pat.PRecord.setProp := [];
  end;


  //if ArrStr[0] <> patNameF then
  begin
    pat.PRecord.FNAME := ArrStr[0];
    Include(pat.PRecord.setProp, PatientNew_FNAME);
  end;
  //if ArrStr[1] <> patNameS then
  begin
    pat.PRecord.SNAME := ArrStr[1];
    Include(pat.PRecord.setProp, PatientNew_SNAME);
  end;
  //if ArrStr[2] <> patNameL then
  begin
    pat.PRecord.LNAME := ArrStr[2];
    Include(pat.PRecord.setProp, PatientNew_LNAME);
  end;
  if Assigned(FOnchangeColl) then
    FOnchangeColl(pat);
end;

procedure TfrmProfFormFMX.Expander1Resize(Sender: TObject);
var
  exdr: TExpander;
  i: Integer;
begin
  if (GetKeyState(VK_CONTROL) < 0) then
  begin
    for i := 0 to LstExpanders.Count - 1 do
    begin
      LstExpanders[i].IsExpanded := TExpander(Sender).IsExpanded;
    end;
  end;


  flwlytVizitFor.RecalcSize;
  flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height / scaleDyn + 15;

  lytRightResize(nil);
  SetExpanderVisitForHeight;
end;

procedure TfrmProfFormFMX.expndrImunResize(Sender: TObject);
var
  h: Single;
begin
  if expndrImun.IsExpanded then
  begin
    lytExpImun.RecalcSize;
    h := InnerChildrenRect(lytExpImun).Height/FScaleDyn ;
    lytExpImun.Height := h;
    if h = 0 then
    begin
      expndrImun.Height := 55;
    end
    else
    begin
      if rctBtnAddImun.Tag = 0 then
      begin
        expndrImun.Height := h + lytExpImun.Margins.Top + lytExpImun.Margins.Top;

      end
      else
      begin
        expndrImun.Height := h + lytExpImun.Margins.Top+ lytExpImun.Margins.Top;
      end;
    end;
    lytFrameImun.Height := expndrImun.Height + 30;
    flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height/scaleDyn + 15;
    SetExpanderVisitForHeight;
    RecalcBlankaRect1;
  end
  else
  begin
    expndrImun.Height := 55;
    lytFrameImun.Height := expndrImun.Height + 30;
    flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height/scaleDyn + 15;
    SetExpanderVisitForHeight;
    RecalcBlankaRect1;

  end;
end;

procedure TfrmProfFormFMX.expndrMdnsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if y < 0 then
  begin
    Caption := 'ddd';
  end;
end;

procedure TfrmProfFormFMX.expndrMdnsResize(Sender: TObject);
var
  lytLeftHeight, lytRightHeight, delta, h: Single;
begin
  if expndrMdns.IsExpanded then
  begin
    lytMdnExp.RecalcSize;
    h := InnerChildrenRect(lytMdnExp).Height/FScaleDyn ;
    lytMdnExp.Height := h;
    if h = 0 then
    begin
      expndrMdns.Height := 55;
    end
    else
    begin
      expndrMdns.Height := h + lytMdnExp.Margins.Top + 35;
    end;
    flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height/scaleDyn + 15;
    lytFrameMDN.Height := expndrMdns.Height + 30;
    SetExpanderVisitForHeight;
    RecalcBlankaRect1;
  end
  else
  begin
    expndrMdns.Height := 55;
    flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height/scaleDyn + 15;
    SetExpanderVisitForHeight;
    RecalcBlankaRect1;

  end;
end;


procedure TfrmProfFormFMX.expndrMNsResize(Sender: TObject);
var
  lytLeftHeight, lytRightHeight, h: Single;
begin
  //Exit;
  if expndrMNs.IsExpanded then
  begin
    lytExpMN.RecalcSize;
    h := InnerChildrenRect(lytExpMN).Height/FScaleDyn ;
    lytExpMN.Height := h;
    if h = 0 then
    begin
      expndrMNs.Height := 55;
    end
    else
    begin
      expndrMNs.Height := h + lytExpMN.Margins.Top + lytExpMN.Margins.Top;
    end;
    lytFrameMN.Height := expndrMNs.Height + 30;
    flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height/scaleDyn + 15;
    SetExpanderVisitForHeight;
    RecalcBlankaRect1;
  end
  else
  begin
    expndrMNs.Height := 55;
    flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height/scaleDyn + 15;
    SetExpanderVisitForHeight;
    RecalcBlankaRect1;
  end;
end;

procedure TfrmProfFormFMX.FillExpanderImmun(Layout: TLayout;
  idxListImun: integer; Imun: TRealExamImmunizationItem);
var
  TempLyt: TLayout;
  TempImunLabel: TImmunsLabel;
  i: Integer;
  nrn, nom, ImunCode: string;
  dataPos: Cardinal;
  log: TLogicalData24;
begin
  if (LstImuns.Count - 1) < idxListImun then
  begin
    TempLyt := TLayout(lytImun.Clone(self));
    TempImunLabel := TImmunsLabel.Create;
    TempLyt.Tag := LstImuns.Add(TempLyt);
    TempLyt.TagObject := TempImunLabel;
    WalkChildrenEdtImun(TempLyt, TempImunLabel); // обикаля и събира кое какво е
  end
  else
  begin
    TempLyt := LstImuns[idxListImun];
    TempImunLabel:= TImmunsLabel(LstImuns[idxListImun].TagObject);
  end;
  TempImunLabel.imun := Imun;
  TempLyt.Visible := True;
  TempLyt.align := TAlignLayout.top;

  if Assigned(Imun) then
  begin
    TempImunLabel.LinkImun := Imun.LinkNode;
    if (Imun.PRecord = nil) or (not(ExamImmunization_NRN_IMMUNIZATION in Imun.PRecord.setProp)) then
    begin
      nrn := Imun.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(ExamImmunization_NRN_IMMUNIZATION));
    end
    else
    begin
      nrn := Imun.PRecord.NRN_IMMUNIZATION;
    end;
    nom := '1234';
    TempImunLabel.Mkb.edtMkb.Text := '';
    TempImunLabel.Mkb.edtMkb.TagObject := nil;
    //TempMnsLabel.LstMkbs[i].edtMkb := nil;

    //TempMnsLabel.LstMkbs[i].edtMkb.OnChangeTracking := edtAnalCodeChangeTracking;
    //TempMnsLabel.LstMkbs[i].edtMkb.OnKeyDown := edtMdn1KeyDown;
    ImunCode := inttostr(Imun.getIntMap(FAspAdbBuf, FAspAdbPosData, word(ExamImmunization_VACCINE_ID)));
    TempImunLabel.edtVacineCode.Text := ImunCode;//zzzzzzzzzzzzzzzz  трябва да си е кода на ваксината
    //if mn.FDiagnosis.Count > 0 then
//    begin
//      for i := 0 to mn.FDiagnosis.Count - 1 do
//      begin
//        TempImunLabel.LstMkbs[i].MKB :=  mn.FDiagnosis[i];
//
//        if TempImunLabel.LstMkbs[i].MKB.PRecord = nil then
//        begin
//         // tempCl022 := TCL022Item.Create(nil);
//  //          tempCl022.DataPos := mdn.FExamAnals[i].getIntMap(FAspAdbBuf, FAspAdbPosData, word(ExamAnalysis_PosDataNomen));
//  //          TempMnsLabel.LstAnals[i].edtAnal.Text :=  tempCl022.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL022_NHIF_Code));
//  //          FreeAndNil(tempCl022);
//        end
//        else
//        begin
//          TempImunLabel.LstMkbs[i].edtMkb.Text := TempImunLabel.LstMkbs[i].MKB.PRecord.code_CL011;
//        end;
//
//        if TempImunLabel.LstMkbs[i].edtMkb.Text = '' then
//          TempImunLabel.LstMkbs[i].edtMkb.Text :=  mn.FDiagnosis[i].getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(Diagnosis_code_CL011));
//        TempImunLabel.LstMkbs[i].edtMkb.TagObject := TempImunLabel.LstMkbs[i];
//
//      end;
//    end
//    else
//    begin
//      for i := 0 to mn.FPregled.FDiagnosis.Count - 1 do
//      begin
//        if i > 2 then Break;  // трябва да се провери и бележи кои са избраните мкб-та от прегледа. В думм-ито сигурно
//
//        TempImunLabel.LstMkbs[i].MKB :=  mn.FPregled.FDiagnosis[i];
//
//        if TempImunLabel.LstMkbs[i].MKB.PRecord = nil then
//        begin
//          TempImunLabel.LstMkbs[i].edtMkb.Text :=  mn.FPregled.FDiagnosis[i].getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(Diagnosis_code_CL011));
//        end
//        else
//        begin
//          TempImunLabel.LstMkbs[i].edtMkb.Text := TempImunLabel.LstMkbs[i].MKB.PRecord.code_CL011;
//          TempImunLabel.LstMkbs[i].edtMkbAdd.Text :=  'add';//TempMnsLabel.LstMkbs[i].MKB.PRecord.code_CL011;
//        end;
//
//        //if TempMnsLabel.LstMkbs[i].edtMkb.Text = '' then
//
//        TempImunLabel.LstMkbs[i].edtMkb.TagObject := TempImunLabel.LstMkbs[i];
//
//      end;
//    end;

    //if nrn <> '' then
//    begin
//      log := Imun.getLogical24Map(FAspAdbBuf, FAspAdbPosData, word(BLANKA_MED_NAPR_Logical));
//      LogImun := TLogicalBLANKA_MED_NAPRSet(log);
//      if TLogicalBLANKA_MED_NAPR.NZIS_STATUS_Sended in LogImun then
//      begin
//        TempImunLabel.EdtNrn.FontColor := TAlphaColorRec.Green;
//      end
//      else if TLogicalBLANKA_MED_NAPR.NZIS_STATUS_Cancel in LogImun then
//      begin
//        TempImunLabel.EdtNrn.FontColor := TAlphaColorRec.Red;
//      end
//      else
//        TempImunLabel.EdtNrn.FontColor := TAlphaColorRec.Black;
//      TempImunLabel.EdtNrn.Text := nrn;
//    end
//    else
//    begin
//      TempImunLabel.EdtNrn.Text := nom;
//    end;
  end;



  TempLyt.Position.Point := PointF(TempLyt.Position.Point.X, 10000);
  TempLyt.Parent := Layout;
  TempImunLabel.btnDel.Opacity := 0.3;
  //TempImunLabel.btnDel.OnMouseUp := RemoveMnMouseUp;
  //TempImunLabel.EdtNrn.OnChangeTracking := edtMdnChangeTracking;
end;

procedure TfrmProfFormFMX.FillExpanderMDNs1(Layout: TLayout;
  idxListMdns: integer; mdn: TRealMDNItem);
var
  TempLyt: TLayout;
  TempMdnsLabel: TMdnsLabel;
  i: Integer;
  nrn, nom: string;
  dataPos: Cardinal;
  tempCl022: TCL022Item;
  log: TLogicalData24;
  LogMdn: TlogicalMDNSet;
  expTxt: TText;
begin
  //expTxt := WalkChildrenTextStyle(expndrMdns, 'text');
  //expTxt.Text := 'namerih te';
  if (LstMdns.Count - 1) < idxListMdns then
  begin
    TempLyt := TLayout(frmFmxControls.lytMdn.Clone(self));
    TempMdnsLabel := TMdnsLabel.Create;
    TempLyt.Tag := LstMdns.Add(TempLyt);
    TempLyt.TagObject := TempMdnsLabel;
    //TempMdnsLabel.mdn := mdn;
    WalkChildrenEdtMdn(TempLyt, TempMdnsLabel);
  end
  else
  begin
    TempLyt := LstMdns[idxListMdns];
    TempMdnsLabel:= TMdnsLabel(LstMdns[idxListMdns].TagObject);
    //TempMdnsLabel.mdn := mdn;
  end;
    TempMdnsLabel.mdn := mdn;
    TempLyt.Visible := True;
    TempLyt.align := TAlignLayout.top;

    if Assigned(mdn) then
    begin
      TempMdnsLabel.LinkMdn := mdn.LinkNode;
      if (mdn.PRecord = nil) or (not(MDN_NRN in mdn.PRecord.setProp)) then
      begin
        nrn := mdn.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(MDN_NRN));
      end
      else
      begin
        nrn := mdn.PRecord.nrn;
      end;
      nom := inttostr(mdn.getIntMap(FAspAdbBuf, FAspAdbPosData, word(MDN_NUMBER)));
      for i := 0 to TempMdnsLabel.LstAnals.Count - 1 do
      begin
        TempMdnsLabel.LstAnals[i].Anal := nil;
        TempMdnsLabel.LstAnals[i].edtAnal.Text := '';
        TempMdnsLabel.LstAnals[i].edtAnal.TagObject := nil;
        TempMdnsLabel.LstAnals[i].edtAnal.OnChangeTracking := edtAnalCodeChangeTracking;
        TempMdnsLabel.LstAnals[i].edtAnal.OnKeyDown := edtMdn1KeyDown;
      end;
      for i := 0 to mdn.FExamAnals.Count - 1 do
      begin
        TempMdnsLabel.LstAnals[i].Anal :=  mdn.FExamAnals[i];

        if TempMdnsLabel.LstAnals[i].Anal.PRecord = nil then
        begin
          tempCl022 := TCL022Item.Create(nil);
          tempCl022.DataPos := mdn.FExamAnals[i].getIntMap(FAspAdbBuf, FAspAdbPosData, word(ExamAnalysis_PosDataNomen));
          TempMdnsLabel.LstAnals[i].edtAnal.Text :=  tempCl022.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL022_NHIF_Code));
          FreeAndNil(tempCl022);
        end
        else
        begin
          TempMdnsLabel.LstAnals[i].edtAnal.Text := TempMdnsLabel.LstAnals[i].Anal.PRecord.NZIS_CODE_CL22;
        end;

        if TempMdnsLabel.LstAnals[i].edtAnal.Text = '' then
          TempMdnsLabel.LstAnals[i].edtAnal.Text :=  mdn.FExamAnals[i].getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(ExamAnalysis_NZIS_CODE_CL22));
        TempMdnsLabel.LstAnals[i].edtAnal.TagObject := TempMdnsLabel.LstAnals[i];

      end;
      if nrn <> '' then
      begin
        log := mdn.getLogical24Map(FAspAdbBuf, FAspAdbPosData, word(MDN_Logical));
        LogMdn := TlogicalMDNSet(log);
        if TLogicalMDN.NZIS_STATUS_Sended in LogMdn then
        begin
          TempMdnsLabel.EdtNrn.FontColor := TAlphaColorRec.Green;
        end
        else if TLogicalMDN.NZIS_STATUS_Cancel in LogMdn then
        begin
          TempMdnsLabel.EdtNrn.FontColor := TAlphaColorRec.Red;
        end
        else
          TempMdnsLabel.EdtNrn.FontColor := TAlphaColorRec.Black;
        TempMdnsLabel.EdtNrn.Text := nrn;
      end
      else
      begin
        if nom <> '0' then
        begin
          TempMdnsLabel.EdtNrn.Text := nom;
        end
        else
        begin
          TempMdnsLabel.EdtNrn.Text := '';
        end;
      end;
    end;


    TempLyt.Position.Point := PointF(TempLyt.Position.Point.X, 10000);
    TempLyt.Parent := Layout;
    TempMdnsLabel.btnDel.Opacity := 0.3;
    TempMdnsLabel.btnDel.OnMouseUp := RemoveMdnMouseUp;
    //TempMdnsLabel.btnDel.OnMouseEnter := Rectangle4MouseEnter;
    //TempMdnsLabel.GridLayoutAnals.OnResize := GridLayout1Resize;
    TempMdnsLabel.EdtNrn.OnChangeTracking := edtMdnChangeTracking;
    TempMdnsLabel.EdtMainMkb.OnPainting := txtMkbMdnPainting;

end;

procedure TfrmProfFormFMX.FillExpanderMNs1(Layout: TLayout; idxListMns: integer;
  mn: TRealBLANKA_MED_NAPRItem);
var
  TempLyt: TLayout;
  TempMnsLabel: TMnsLabel;
  i: Integer;
  h: Single;
  nrn, nom, spec: string;
  dataPos, posSpec: Cardinal;
  tempCl022: TCL022Item;
  log: TLogicalData24;
  LogMn: TlogicalBLANKA_MED_NAPRSet;
begin
  if (LstMns.Count - 1) < idxListMns then
  begin
    TempLyt := TLayout(lytMN.Clone(self));
    TempMnsLabel := TMnsLabel.Create;
    TempLyt.Tag := LstMns.Add(TempLyt);
    TempLyt.TagObject := TempMnsLabel;
    WalkChildrenEdtMn(TempLyt, TempMnsLabel); // обикаля и събира кое какво е
  end
  else
  begin
    TempLyt := LstMns[idxListMns];
    TempMnsLabel:= TMnsLabel(LstMns[idxListMns].TagObject);
  end;
  TempMnsLabel.mn := mn;
  TempLyt.Visible := True;
  TempLyt.align := TAlignLayout.top;

  if Assigned(mn) then
  begin
    TempMnsLabel.LinkMn := mn.LinkNode;
    if (mn.PRecord = nil) or (not(BLANKA_MED_NAPR_NRN in mn.PRecord.setProp)) then
    begin
      nrn := mn.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(BLANKA_MED_NAPR_NRN));
    end
    else
    begin
      nrn := mn.PRecord.nrn;
    end;
    nom := inttostr(mn.getIntMap(FAspAdbBuf, FAspAdbPosData, word(BLANKA_MED_NAPR_NUMBER)));
    for i := 0 to TempMnsLabel.LstMkbs.Count - 1 do
    begin
        TempMnsLabel.LstMkbs[i].edtMkb.Text := '';
        TempMnsLabel.LstMkbs[i].edtMkb.TagObject := nil;

        //TempMnsLabel.LstMkbs[i].edtMkb := nil;

        //TempMnsLabel.LstMkbs[i].edtMkb.OnChangeTracking := edtAnalCodeChangeTracking;
        TempMnsLabel.LstMkbs[i].edtMkb.OnKeyDown := edtMn1KeyDown;
        TempMnsLabel.LstMkbs[i].edtMkb.OnEnter := edtMN1Enter;
        TempMnsLabel.LstMkbs[i].edtMkb.OnExit := edtMN1Exit;
        TempMnsLabel.LstMkbs[i].edtMkb.OnChangeTracking := edtMN1ChangeTracking;
        TempMnsLabel.LstMkbs[i].btnDropDownMKB.OnClick := BtnDropDownMN_MKBClick;
        //TempMnsLabel.LstMkbs[i].edtMkbAdd.OnKeyDown := edtMdn1KeyDown;
//        TempMnsLabel.LstMkbs[i].edtMkbAdd.OnEnter := edtMN1Enter;
//        TempMnsLabel.LstMkbs[i].edtMkbAdd.OnExit := edtMN1Exit;
    end;
    posSpec := mn.getCardMap(FAspAdbBuf, FAspAdbPosData, word(BLANKA_MED_NAPR_SpecDataPos));
    spec := Adb_dm.CL006Coll.getAnsiStringMap(posSpec, word(CL006_Key));
    TempMnsLabel.edtSpec.Text := spec;
    TempMnsLabel.edtSpecName.Text := Adb_dm.CL006Coll.getAnsiStringMap(posSpec, word(CL006_nhif_name));;
    if mn.FDiagnosis2.Count > 0 then
    begin
      for i := 0 to mn.FDiagnosis2.Count - 1 do
      begin
        TempMnsLabel.LstMkbs[i].MKB :=  mn.FDiagnosis2[i];

        if TempMnsLabel.LstMkbs[i].MKB.PRecord = nil then
        begin
         // tempCl022 := TCL022Item.Create(nil);
  //          tempCl022.DataPos := mdn.FExamAnals[i].getIntMap(FAspAdbBuf, FAspAdbPosData, word(ExamAnalysis_PosDataNomen));
  //          TempMnsLabel.LstAnals[i].edtAnal.Text :=  tempCl022.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL022_NHIF_Code));
  //          FreeAndNil(tempCl022);
        end
        else
        begin
          TempMnsLabel.LstMkbs[i].edtMkb.Text := TempMnsLabel.LstMkbs[i].MKB.PRecord.code_CL011;
        end;

        if TempMnsLabel.LstMkbs[i].edtMkb.Text = '' then
          TempMnsLabel.LstMkbs[i].edtMkb.Text :=  mn.FDiagnosis2[i].getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(Diagnosis_code_CL011));
        TempMnsLabel.LstMkbs[i].edtMkb.TagObject := TempMnsLabel.LstMkbs[i];

      end;
    end
    else
    begin
      for i := 0 to mn.FPregled.FDiagnosis.Count - 1 do
      begin
        if i > 2 then Break;  // трябва да се провери и бележи кои са избраните мкб-та от прегледа. В думм-ито сигурно

        TempMnsLabel.LstMkbs[i].MKB :=  mn.FPregled.FDiagnosis[i];

        if TempMnsLabel.LstMkbs[i].MKB.PRecord = nil then
        begin
          TempMnsLabel.LstMkbs[i].edtMkb.Text :=  mn.FPregled.FDiagnosis[i].getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(Diagnosis_code_CL011));
        end
        else
        begin
          TempMnsLabel.LstMkbs[i].edtMkb.Text := TempMnsLabel.LstMkbs[i].MKB.PRecord.code_CL011;
          TempMnsLabel.LstMkbs[i].edtMkbAdd.Text :=  'add';//TempMnsLabel.LstMkbs[i].MKB.PRecord.code_CL011;
        end;

        //if TempMnsLabel.LstMkbs[i].edtMkb.Text = '' then

        TempMnsLabel.LstMkbs[i].edtMkb.TagObject := TempMnsLabel.LstMkbs[i];

      end;
    end;

    if nrn <> '' then
    begin
      log := mn.getLogical24Map(FAspAdbBuf, FAspAdbPosData, word(BLANKA_MED_NAPR_Logical));
      LogMn := TLogicalBLANKA_MED_NAPRSet(log);
      if TLogicalBLANKA_MED_NAPR.NZIS_STATUS_Sended in LogMn then
      begin
        TempMnsLabel.EdtNrn.FontColor := TAlphaColorRec.Green;
      end
      else if TLogicalBLANKA_MED_NAPR.NZIS_STATUS_Cancel in LogMn then
      begin
        TempMnsLabel.EdtNrn.FontColor := TAlphaColorRec.Red;
      end
      else
        TempMnsLabel.EdtNrn.FontColor := TAlphaColorRec.Black;
      TempMnsLabel.EdtNrn.Text := nrn;
    end
    else
    begin
      if nom <> '0' then
      begin
        TempMnsLabel.EdtNrn.Text := nom;
      end
      else
      begin
        TempMnsLabel.EdtNrn.Text := '';
      end;
    end;
  end;


  TempLyt.Position.Point := PointF(TempLyt.Position.Point.X, 10000);
  TempLyt.Parent := Layout;

  Layout.RecalcSize;
  h := InnerChildrenRect(Layout).Height/FScaleDyn ;
  Layout.Height := h;
  if h = 0 then
  begin
    expndrMNs.Height := 75;
  end
  else
  begin
    expndrMNs.Height := h + Layout.Margins.Top;// + lytExpMN.Margins.Top;
  end;
  lytFrameMN.Height := expndrMNs.Height + 30;

  TempMnsLabel.btnDel.Opacity := 0.3;
  TempMnsLabel.btnDel.OnMouseUp := RemoveMnMouseUp;
  //TempMnsLabel.GridLayoutMkb.OnResize := GridLayout1Resize;
  TempMnsLabel.EdtNrn.OnChangeTracking := edtMdnChangeTracking;
end;

procedure TfrmProfFormFMX.FillPlanedPreg(PlanNode: Pointer);
var
  RunPlanedType, RunNodeCL132, RunNodePR001: PVirtualNode;
  dataPr001, dataRunPr001: PAspRec;
  cl132Key, strNode, respKey, pr001Key, diagRepKey, captEdit, captCombo: string;
  captMemo, captDateEdt, captChk, cl088Code: string;
  i: Integer;
  cl132: TCL132Item;
  cl134: TRealCl134Item;
  pr001: TRealPR001Item;
  tempFLYT: TFlowLayout;
begin
  cl132:= TCL132Item.Create(nil);
  RunNodeCL132 := PVirtualNode(PlanNode);
  while RunNodeCL132 <> nil do
  begin
    dataPr001 := pointer(PByte(RunNodeCL132) + lenNode);
    pr001 := TRealPR001Item.Create(nil);
    case dataPr001.vid of
      vvPR001:
      begin
        pr001.DataPos := dataPr001.DataPos;
      end;
      vvNZIS_QUESTIONNAIRE_RESPONSE:
      begin
        SourceAnswerDefault := TSourceAnsw(RunNodeCL132.Dummy);
        respTemp.DataPos := dataPr001.DataPos;
        respKey := respTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY));
        for i := 0 to Fpr001Coll.Count - 1 do
        begin
          pr001Key := Fpr001Coll.Items[i].getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Nomenclature)) + '|' +
            Fpr001Coll.Items[i].getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Activity_ID));
          if pr001Key = respKey then
          begin
            pr001.DataPos := Fpr001Coll.Items[i].DataPos;
            Break;
          end;
        end;
      end;
      vvNZIS_DIAGNOSTIC_REPORT:
      begin
        DIAGNOSTIC_REPTemp.DataPos := dataPr001.DataPos;
        diagRepKey := 'CL142|' + DIAGNOSTIC_REPTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_DIAGNOSTIC_REPORT_CL142_CODE));
        for i := 0 to Fpr001Coll.Count - 1 do
        begin
          pr001Key := Fpr001Coll.Items[i].getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Nomenclature)) + '|' +
            Fpr001Coll.Items[i].getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Activity_ID));
          if pr001Key = diagRepKey then
          begin
            pr001.DataPos := Fpr001Coll.Items[i].DataPos;
            Break;
          end;
        end;
      end;
    end;

     //zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
    RunNodePR001 := RunNodeCL132.FirstChild;
    dataRunPr001 :=pointer(PByte(RunNodePR001) + lenNode);

    if (RunNodeCL132.ChildCount > 1) or
         ((RunNodePR001<> nil) and (Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(dataRunPr001.DataPos, Word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE)) ='65-226-09'))then
    begin
      //RunNodePR001 := RunNodeCL132.FirstChild;
      //dataRunPr001 :=pointer(PByte(RunNodePR001) + lenNode);
//      if dataRunPr001.vid = vvNZIS_RESULT_DIAGNOSTIC_REPORT then
//      begin
//        if  ResDiagRepColl.getWordMap(dataRunPr001.DataPos, Word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) = 2 then
//        begin
//          AddExpanderPreg(idxListExpander, RunNodeCL132);
//          tempFLYT := WalkChildrenFLYT(LstExpanders[idxListExpander]);
//          tempFLYT.OnResize := flwlyt2Resize;
//        end;
//      end
//      else
      begin
        AddExpanderPreg(idxListExpander, RunNodeCL132);
        tempFLYT := WalkChildrenFLYT(LstExpanders[idxListExpander]);
        tempFLYT.OnResize := flwlyt2Resize;
      end;

      while RunNodePR001 <> nil do
      begin
        dataRunPr001 :=pointer(PByte(RunNodePR001) + lenNode);
        case dataRunPr001.vid of
          vvNZIS_QUESTIONNAIRE_ANSWER:
          begin
            answTemp.DataPos := dataRunPr001.DataPos;
            cl134Temp.DataPos := answTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS));
            case cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_CL028))[1] of
              '1': //'Количествено представяне';
              begin
                captEdit := cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
                             cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
                AddEditPregSup(tempFLYT, pr001, idxListEdit, RunNodePR001, captEdit);
                inc(idxListEdit);
              end;
              '2': //'Категоризация по номенклатура';
              begin
                if cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Multiple_Choice))= 'TRUE' then
                begin
                  captCombo := cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Answer_Nomenclature)) + '|' +
                               cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
                               cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description)) + ' mnogo';

                  AddComboPregMultiLYT(tempFLYT, idxListComboMultiSup, RunNodePR001, captCombo, true);

                  inc(idxListComboMultiSup);
                end
                else
                begin
                  captCombo := cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Answer_Nomenclature)) + '|' +
                               cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
                               cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));

                  AddComboPregLYT(tempFLYT, idxListComboOneSup, RunNodePR001, captCombo, false);
                  inc(idxListComboOneSup);
                end;
              end;
              '3': //'Описателен метод';
              begin
                captMemo := cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
                             cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
                AddMemoSup(tempFLYT, pr001, idxListMemoLyt, RunNodePR001, captMemo);
                inc(idxListMemoLyt);
              end;
              '4': //'Конкретна дата';
              begin
                captDateEdt := cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
                             cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
                AddDateEdtSup(tempFLYT, idxListDateEditSup, RunNodePR001, captDateEdt);
                inc(idxListDateEditSup);
              end;
              '5': //'Положително или отрицателно';
              begin
                captChk := cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
                             cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));

                AddCheckSup(tempFLYT, idxListCheckSup, RunNodePR001, captChk);
                inc(idxListCheckSup);
              end;
            end;
          end;
          vvCl134:// Въпроси към прегледи при снемане на анамнеза
          begin
            cl134 := TRealCl134Item.Create(nil);
            cl134.DataPos := dataRunPr001.DataPos;
            case cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_CL028))[1] of
              '1': //'Количествено представяне';
              begin
                captEdit := cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
                             cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
                AddEditPregSup(tempFLYT, pr001, idxListEdit, RunNodePR001, captEdit);
                inc(idxListEdit);
              end;
              '2': //'Категоризация по номенклатура';
              begin
                if cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Multiple_Choice))= 'TRUE' then
                begin
                  captCombo := cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Answer_Nomenclature)) + '|' +
                               cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
                               cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description)) + 'mnogo';

                  AddComboPregMultiLYT(tempFLYT, idxListComboMultiSup, RunNodePR001, captCombo, true);
                  inc(idxListComboMultiSup);
                end
                else
                begin
                  captCombo := cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Answer_Nomenclature)) + '|' +
                               cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
                               cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));

                  AddComboPregLYT(tempFLYT, idxListComboOneSup, RunNodePR001, captCombo, false);
                  inc(idxListComboOneSup);
                end;
              end;
              '3': //'Описателен метод';
              begin
                captMemo := cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
                             cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
                AddMemoSup(tempFLYT, pr001, idxListMemoLyt, RunNodePR001, captMemo);
                inc(idxListMemoLyt);
              end;
              '4': //'Конкретна дата';
              begin
                captDateEdt := cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
                             cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
                AddDateEdtSup(tempFLYT, idxListDateEditSup, RunNodePR001, captDateEdt);
                inc(idxListDateEditSup);
              end;
              '5': //'Положително или отрицателно';
              begin
                captChk := cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
                             cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));

                AddCheckSup(tempFLYT, idxListCheckSup, RunNodePR001, captChk);
                inc(idxListCheckSup);
              end;
            end;
          end;
          vvNZIS_RESULT_DIAGNOSTIC_REPORT:
          begin
            RESULT_DIAGNOSTIC_REPTemp.DataPos := dataRunPr001.DataPos;
            cl144Temp.DataPos := RESULT_DIAGNOSTIC_REPTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
            if cl144Temp.DataPos <> 0 then
            begin
              case cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_cl028))[1] of
                '1': //'Количествено представяне';
                begin
                  captEdit :=  cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_cl028)) + '|' +
                               cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_Key)) + '|' +
                               cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_Description));
                  AddEditPregSup(tempFLYT, pr001, idxListEdit, RunNodePR001, captEdit);
                  inc(idxListEdit);
                end;
                '2': //'Категоризация по номенклатура';
                begin
                  captCombo :=   cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_cl028)) + '|' +
                                 cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_Key)) + '|' +
                                 cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_Description));

                  AddComboPregLYT(tempFLYT, idxListComboOneSup, RunNodePR001, captCombo, false);
                  inc(idxListComboOneSup);
                end;
                '3': //'Описателен метод';
                begin
                  captMemo :=  cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_cl028)) + '|' +
                               cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_Key)) + '|' +
                               cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_Description));
                  if Adb_dm.Cl144Coll.getAnsiStringMap(cl144Temp.DataPos, word(CL144_cl028)) <> '2' then
                  begin
                    AddMemoSup(tempFLYT, pr001, idxListMemoLyt, RunNodePR001, captMemo);
                    inc(idxListMemoLyt);
                  end
                  else
                  begin
                    AddMemoSup(flwlytVizitFor, pr001, idxListMemoLyt, RunNodePR001, captMemo);
                    inc(idxListMemoLyt);
                  end;
                end;
                '4': //'Конкретна дата';
                begin

                end;
                '5': //'Положително или отрицателно';
                begin
                  //captChk := cl134.getAnsiStringMap(FAspBuf, FAspPosData, word(CL134_Description));
  //
  //                AddCheckSup(tempFLYT, idxListCheck, RunNodePR001, captChk);
  //                inc(idxListCheck);
                end;
              end;
            end
            else //CL142
            begin
              //dataDiagRep := pointer(PByte(RunNodePR001.Parent) + lenNode);
//              DIAGNOSTIC_REPTemp.DataPos := dataDiagRep.DataPos;
//              cl144Temp.DataPos := DIAGNOSTIC_REPTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_DIAGNOSTIC_REPORT_NOMEN_POS));
//              caption := DIAGNOSTIC_REPTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_DIAGNOSTIC_REPORT_CL142_CODE));
//              captMemo := cl142Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL142_CL028)) + '|' +
//                               cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_Description));
//                  AddMemoSup(tempFLYT, pr001, idxListMemoLyt, RunNodePR001, captMemo);
//                  inc(idxListMemoLyt);
            end;
          end
        else
          begin
            Caption := 'dddd';
          end;
        end;
        RunNodePR001  := RunNodePR001.NextSibling;
      end;
      tempFLYT.EndUpdate;
      tempFLYT.RecalcSize;
      tempFLYT.Height := InnerChildrenRect(tempFLYT).Height/scaleDyn + 15;

      if idxListExpander < LstExpanders.Count then
      begin
        LstExpanders[idxListExpander].Height := tempFLYT.Height  + 55;
        inc(idxListExpander);
      end;
    end
    else // няма дечица,  това са дейностите
    begin
      //if dataPr001.vid = vvNZIS_DIAGNOSTIC_REPORT then
//      begin
//        Caption := pr001.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Nomenclature));
//        RunNodeCL132 := RunNodeCL132.NextSibling;
//        Continue;
//      end;

      Caption := pr001.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Nomenclature));
      if pr001.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Nomenclature)) = 'CL142' then
      begin
        cl088Code := pr001.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Activity_ID));
        for i := 0 to FCl088Coll.Count - 1 do
        begin
          if cl088Code = FCl088Coll.Items[i].getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL088_cl142)) then
          begin
            cl088Temp.DataPos := FCl088Coll.Items[i].DataPos;
            Break;
          end;
        end;

        case cl088Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL088_cl028))[1] of
          'a': //'Количествено представяне';
          begin
            AddEditPregSup(tempFLYT, pr001, idxListEdit, RunNodePR001, 'dddd');
            inc(idxListEdit);
          end;
          '2': // Номенклатура
          begin
            if false then //  ако е възможна множествена селекция (за сега няма такива)
            begin
              AddExpanderPreg(idxListExpander, RunNodeCL132);
              inc(idxListExpander);
            end
            else
            begin
              captCombo := cl088Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL088_Key));// номенклатурата
              captCombo := captCombo + '  ' + cl088Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL088_Description));
              //captCombo := captCombo + '  ' + cl088.CL138[StrToInt(captCombo)-1];
              AddComboPregLYT(flwlytVizitFor, idxListComboOneSup, RunNodeCL132, captCombo, false);
              inc(idxListComboOneSup);
            end;
          end;
          '3':// Описателен метод Cl088 във големия експандер
          begin
            captMemo := cl088Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL088_Key));
            captMemo := captMemo + '  ' + cl088Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL088_Description));
            AddMemoSup(flwlytVizitFor, pr001, idxListMemoLyt, RunNodeCL132, captMemo);
            inc(idxListMemoLyt);
          end;
          '4':;
          '5':;
        end;
      end
      else
      begin

      end;
    end;
    RunNodeCL132 := RunNodeCL132.NextSibling;
  end;
end;



procedure TfrmProfFormFMX.FillProfActivityPreg(Anode: Pointer);
var
  strNode, captCombo, captChk, captMemo, captEdit, captDateEdt: string;
  i, j, k: Integer;
  childrenRect: TRectF;
  lytLeftHeight, lytRightHeight: Single;
  txt: ttext;
  tempFLYT: TFlowLayout;
  run: PVirtualNode;
  nodePreg, RunPlanedType, RunNodeCL132, RunNodePR001, nodeValue: PVirtualNode;
  dataPreg, dataPr001, dataCL132, dataRunPr001, dataAnswVal,
  dataDiagRep, dataPlan, dataParent: PAspRec;
  cl132: TRealCl132Item;
  cl134: TCL134Item;
  cl142: TRealCl142Item;
  pr001: TRealPR001Item;
  cl088Code: string;
  cl132Key, cl134Key: string;
  cl132Pos: Cardinal;
  respKey, pr001Key, diagRepKey, answKey: string;
  plan, AMainProf: TRealNZIS_PLANNED_TYPEItem;
  PrevPregPos: Cardinal;
  PrevPregDate: TDate;
  planStatus: TPlanedStatusSet;
  

  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  imun: TRealExamImmunizationItem;
  logPreg: TlogicalPregledNewSet;
begin
  Stopwatch := TStopwatch.StartNew;
  //scldlyt1.BeginUpdate;
  ListPlaneds.Clear;
  FIsVtrPregled := True;
  cl132 := TRealCl132Item.Create(nil);
  nodePreg := pvirtualnode(Anode);//  това е прегледа
  if patNodes <> nil then
  begin
    FreeAndNil(patNodes);
  end;
  If PregNodes <> nil then
  begin
    FreeAndNil(PregNodes);
  end;
  pregNodes := Adb_dm.GetPregNodes(nodePreg);
  dataParent := pointer(PByte(nodePreg.Parent) + lenNode);
  case dataParent.vid of
    vvPatient:
    begin
      patNodes := Adb_dm.GetPatNodes(nodePreg.Parent);// нещата на пациента
      lytIncMN.Height := 3;
    end;
    vvIncMN:
    begin
      lytIncMN.Height := 150;
      patNodes := Adb_dm.GetPatNodes(nodePreg.Parent.parent);// нещата на пациента
    end;
  end;

  dataPreg := pointer(PByte(nodePreg) + lenNode);
  logPreg := TlogicalPregledNewSet(Adb_dm.CollPregled.getLogical40Map(dataPreg.DataPos, word(PregledNew_Logical)));
  if IS_PRIMARY in logPreg then
  begin
    Caption := 'ddd';
  end
  else
  begin
    Caption := 'ddd';
  end;

  RunPlanedType := nodePreg.FirstChild;
  cl132.DataPos := 0;
  while RunPlanedType <> nil do
  begin
    dataCL132 := pointer(PByte(RunPlanedType) + lenNode);
    case dataCL132.vid of
      vvNZIS_PLANNED_TYPE:
      begin
        if RunPlanedType.CheckType = ctButton then
        begin
          RunPlanedType := RunPlanedType.NextSibling;
          Continue;
        end;
        plan := TRealNZIS_PLANNED_TYPEItem.Create(nil);
        plan.DataPos := dataCL132.DataPos;
        plan.EndDate := Adb_dm.CollNZIS_PLANNED_TYPE.getDateMap(dataCL132.DataPos, Word(NZIS_PLANNED_TYPE_EndDate));
        plan.StartDate := Adb_dm.CollNZIS_PLANNED_TYPE.getDateMap(dataCL132.DataPos, Word(NZIS_PLANNED_TYPE_StartDate));
        plan.CL132Pos := Adb_dm.CollNZIS_PLANNED_TYPE.getCardMap(dataCL132.DataPos, Word(NZIS_PLANNED_TYPE_CL132_DataPos));
        plan.CL132Key := Adb_dm.CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataCL132.DataPos, Word(NZIS_PLANNED_TYPE_CL132_KEY));
        plan.Cl136 := StrToInt(Adb_dm.Cl132Coll.getAnsiStringMap(plan.CL132Pos, word(CL132_CL136_Mapping)));
        plan.Node := RunPlanedType;
        ListPlaneds.Add(plan);
      end;
    end;
    RunPlanedType := RunPlanedType.NextSibling;
  end;
  // трябва да се сортират плановете по крайна дата, позиция в номенклатурата и по вид
  // после да се намери последния проф преглед на пациента, защото има правила за някои планове за време между тях
  // после да се намери главния план-преглед, в който ще се вмъкват евентуално другите неща
  //

  Adb_dm.CollNZIS_PLANNED_TYPE.SortListByEndDate_posData_cl136(ListPlaneds);
  PrevPregPos := patNodes.GetPrevProfPregled(UserDate, Adb_dm.CollPregled, FPregled); // намира последния проф преглед
  if PrevPregPos > 0 then //има
  begin
    PrevPregDate := Adb_dm.CollPregled.getDateMap(PrevPregPos, word(PregledNew_START_DATE)); // и датата му
  end
  else // няма
  begin
    PrevPregDate := 0;
  end;
  AMainProf := nil;
  for i := 0 to ListPlaneds.Count - 1 do
  begin
    plan := ListPlaneds[i];
    if plan.Cl136 <> 1 then  // нещо друго е
    begin //  такъв план не може да бъде главен
      if AMainProf <> nil then
      begin
        planStatus := TPlanedStatusSet(plan.Node.Dummy);
        if (TPlanedStatus.psNew in planStatus) then
        begin
          if plan.EndDate > (AMainProf.EndDate + 5) then //  ако крайната му дата е по-голяма, го отчеквам, за да си го избере доктора
            plan.Node.CheckState := csUncheckedNormal;
        end;
      end;
    end
    else
    if NzisPregNotPreg.Contains('|' + plan.CL132Key + '|') then  // измислен от нзис преглед
    begin //  такъв преглед не може да бъде главен

    end
    else
    if NzisConsult.Contains('|' + plan.CL132Key + '|') then // консултация
    begin //  такъв преглед не може да бъде главен

    end
    else
    if (plan.StartDate <= PrevPregDate) and (plan.EndDate >= PrevPregDate) then  // изпълнен план
    begin //  и тоя не може да е главен

    end
    else
    if RL090.Contains('|' + plan.CL132Key + '|') then  // има правило за 4 месеца м/у прегледите
    begin  // прегледа може да бъде главен ако са минали повече от 120 дни от предишния
      if (UserDate - PrevPregDate) > 120 then  // и понеже са подредени по край на периода
      begin
        if AMainProf = nil then
        begin
          strNode := plan.CL132Key;
          strNode :=  strNode + '  ' + ADB_DM.Cl132Coll.getAnsiStringMap(plan.CL132Pos, word(CL132_Description));
          xpdrVisitFor.Text := strNode;
          AMainProf := plan;
        end
        else
        begin
          plan.Node.CheckType := ctButton;
        end;
      end
      else
      begin
        if AMainProf = nil then
        begin
          strNode := plan.CL132Key;
          strNode :=  strNode + '  ' + ADB_DM.Cl132Coll.getAnsiStringMap(plan.CL132Pos, word(CL132_Description));
          xpdrVisitFor.Text := strNode;
          AMainProf := plan;
        end
        else
        begin
          plan.Node.CheckType := ctButton;
        end;
      end;
    end
    else
    begin
      if AMainProf = nil then
      begin
        strNode := plan.CL132Key;
        strNode :=  strNode + '  ' + ADB_DM.Cl132Coll.getAnsiStringMap(plan.CL132Pos, word(CL132_Description));
        xpdrVisitFor.Text := strNode;
        AMainProf := plan;
      end
      else
      begin
        plan.Node.CheckType := ctButton;
      end;
    end;
  end;
  for i := 0 to ListPlaneds.Count - 1 do
  begin
    planStatus := TPlanedStatusSet(plan.Node.Dummy);
    if not (TPlanedStatus.psNew in planStatus) then Continue;
    if ListPlaneds[i].node.CheckState <> csUncheckedNormal then
    begin
      case ListPlaneds[i].Cl136 of
        1:
        begin
          if NzisConsult.Contains('|' + ADB_DM.CollNZIS_PLANNED_TYPE.getAnsiStringMap(ListPlaneds[i].DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY)) + '|') then
          begin // направление за консултация

          end;
        end;
        2: //  трябва да издаде направление  МДД
        begin
          
        end;
        3: //  трябва да се направи имунизация
        begin
          //ADB_DM.CollNZIS_PLANNED_TYPE.getAnsiStringMap(PosDataPlan, word(NZIS_PLANNED_TYPE_CL132_KEY));
          //ListPlaneds[i].
        end;
      end;
    end;
  end;

  for i := 0 to ListPlaneds.Count - 1 do
  begin
    if ListPlaneds[i].node.CheckType = ctButton then
      Continue;
    planStatus := TPlanedStatusSet(ListPlaneds[i].Node.Dummy);
    Exclude(planStatus, TPlanedStatus.psNew);
    ListPlaneds[i].Node.Dummy := Byte(planStatus);
    if AMainProf = ListPlaneds[i] then //  за главния преглед няма правоъгълниче
    begin
      FillPlanedPreg(ListPlaneds[i].node.FirstChild);// попълва плана
      Continue;
    end;
    dataPlan := pointer(PByte(ListPlaneds[i].node) + lenNode);
    AddPlanedRect(idxPlanedType, ListPlaneds[i].node, dataPlan.DataPos, ListPlaneds[i].CL132Pos);
    inc(idxPlanedType);
    if ListPlaneds[i].node.CheckState <> csUncheckedNormal then
    begin
      case ListPlaneds[i].Cl136 of
        1: FillPlanedPreg(ListPlaneds[i].node.FirstChild);// попълва плана
      end;
    end;
  end;

  lytPlanedType.Height := idxPlanedType * 75 + 5;;
  lytVisitForHeader.Height := lytPlanedType.Height + Layout4.Height + Layout4.Margins.Top;
  flwlytVizitFor.Margins.Top := lytVisitForHeader.Height - 25 + 5;

  if SourceAnswerDefault = TSourceAnsw.saNone then
  begin
    SourceAnswerDefault := TSourceAnsw.saPatient;
  end;
  flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height/scaleDyn + 15;
  SetExpanderVisitForHeight;
  RecalcBlankaRect1;

  Elapsed := Stopwatch.Elapsed;
  btn1.Text := FloatToStr(Elapsed.TotalMilliseconds);
  flwlytVizitFor.Repaint;
  //scldlyt1.endUpdate;
end;

procedure TfrmProfFormFMX.FillRightLYT(dataPreg: PAspRec);
var
  i: Integer;
  tempDiagLabel: TDiagLabel;
  h: Single;
begin
  for i := 1 to LstDiags.Count - 1 do
  begin
    LstDiags[i].Parent := nil;
  end;

  for i := 0 to LstMdns.Count - 1 do
  begin
    LstMdns[i].Parent := nil;
  end;

  for i := 0 to LstMns.Count - 1 do
  begin
    LstMns[i].Parent := nil;
  end;

  for i := 0 to LstImuns.Count - 1 do
  begin
    LstImuns[i].Parent := nil;
  end;

  if Pregled.FDiagnosis.Count > 0 then
  begin
    if LstDiags.Count = 0 then
    begin
      LstDiags.Add(rctDiag);
      tempDiagLabel := TDiagLabel.Create;
      rctDiag.TagObject := tempDiagLabel;
      rctDiag.Tag := 0;
      tempDiagLabel.edtMain := edtMainDiag;
      tempDiagLabel.edtAdd := edtAddDiag;
      tempDiagLabel.mmoDiag := mmoDiag;
      tempDiagLabel.ClinicStatusTXT := Text8;
      tempDiagLabel.ClinicStatus := rctDiagclinicStatusChoice;
    end;

    for i := 0 to Pregled.FDiagnosis.Count - 1 do
    begin
      AddDiag(lytDiag, dataPreg, i, Pregled.FDiagnosis[i]);//zzzzzzzzzzzzzzzzz  трябва нещата да са на диагнозата

      inc(idxDiags);
    end;
  end
  else
  begin
    if LstDiags.Count > 0 then
    begin
      tempDiagLabel := TDiagLabel(LstDiags[0].TagObject);
      tempDiagLabel.diag := nil;
    end;
  end;
  if Pregled.FMdns.Count > 0 then
  begin
    for i := 0 to Pregled.FMdns.Count - 1 do
    begin
      FillExpanderMDNs1(lytMdnExp, i, Pregled.FMdns[i]);
    end;
  end;
  lytMdnExp.RecalcSize;
  h := InnerChildrenRect(lytMdnExp).Height/FScaleDyn ;
  lytMdnExp.Height := h;
  if h = 0 then
  begin
    expndrMdns.Height := 90;
  end
  else
  begin
    expndrMdns.Height := h+ 35;
  end;

  if Pregled.FImmuns.Count > 0 then
  begin
    for i := 0 to Pregled.FImmuns.Count - 1 do
    begin
      FillExpanderImmun(lytExpImun, idxImuns, Pregled.FImmuns[i]);
      inc(idxImuns);
    end;
  end;
  lytExpImun.RecalcSize;
  h := InnerChildrenRect(lytExpImun).Height/FScaleDyn ;
  lytExpImun.Height := h;
  if h = 0 then
  begin
    expndrImun.Height := 55;
  end
  else
  begin
    expndrImun.Height := h+ 35;
  end;

  if Pregled.FMNs.Count > 0 then
  begin
    for i := 0 to Pregled.FMNs.Count - 1 do
    begin
      FillExpanderMNs1(lytExpMN, idxMNs, Pregled.FMNs[i]);
      inc(idxMNs);
    end;
  end;
  lytExpMN.RecalcSize;
  h := InnerChildrenRect(lytExpMN).Height/FScaleDyn ;
  lytExpMN.Height := h;
  if h = 0 then
  begin
    expndrMNs.Height := 75;
  end
  else
  begin
    expndrMNs.Height := h+ 35;
  end;
  lytFrameMN.Height := expndrMNs.Height + 30;

  lytDiag.RecalcSize;
  lytDiag.Height := (InnerChildrenRect(lytDiag).Height )/FScaleDyn + 15;
  xpdrDiagn.Height := lytDiag.Height +50;
  lytDiagFrame.Height := xpdrDiagn.Height + 30;

  AddMemoLYTSup(lytRight, dataPreg, idxListMemoLyt, Word(PregledNew_ANAMN), 'Анамнеза');
  inc(idxListMemoLyt);
  AddMemoLYTSup(lytRight, dataPreg, idxListMemoLyt, Word(PregledNew_SYST), 'Обективно състояние');
  inc(idxListMemoLyt);
  AddMemoLYTSup(lytRight, dataPreg, idxListMemoLyt, Word(PregledNew_IZSL), 'Изследвания');
  inc(idxListMemoLyt);
  AddMemoLYTSup(lytRight, dataPreg, idxListMemoLyt, Word(PregledNew_TERAPY), 'Терапия');
  inc(idxListMemoLyt);
  lytEndRight.BringToFront;
  //lytRight.RecalcSize;
  lytRightResize(nil);

end;

function TfrmProfFormFMX.FindVacantIndexPreg(): integer;
begin
  Result := -1;
  if ListVacantPregIndex.Count = 0 then Exit;
  Result := ListVacantPregIndex.Last;
end;

procedure TfrmProfFormFMX.FloatAnimation11Finish(Sender: TObject);
begin
  //
end;

procedure TfrmProfFormFMX.fltnmtn1Finish(Sender: TObject);
begin
  //
end;

procedure TfrmProfFormFMX.flwlyt2Resize(Sender: TObject);
var
  idxList: Integer;
  flw: TFlowLayout;
begin
  flw := TFlowLayout(Sender);
  for idxList := 0 to LstCombos.Count - 1 do
  begin
    if LstCombos[idxList].Parent = flw then
    begin
      LstCombos[idxList].Width := flw.Width - flw.Padding.Left - flw.Padding.Right;
    end;
  end;

  for idxList := 0 to LstMemos.Count - 1 do
  begin
    if LstMemos[idxList].Parent = flw then
    begin
      LstMemos[idxList].Width := flw.Width - flw.Padding.Left - flw.Padding.Right;
    end;
  end;
  for idxList := 0 to LstEdits.Count - 1 do
  begin
    if LstEdits[idxList].Parent = flw then
    begin
      LstEdits[idxList].Width := flw.Width - flw.Padding.Left - flw.Padding.Right;
    end;
  end;
  for idxList := 0 to LstDateEdits.Count - 1 do
  begin
    if LstDateEdits[idxList].DatEdt.Parent = flw then
    begin
      LstDateEdits[idxList].DatEdt.Width := flw.Width - flw.Padding.Left - flw.Padding.Right;
    end;
  end;
end;

procedure TfrmProfFormFMX.FormActivate(Sender: TObject);
var
  handled: Boolean;
begin
  if IsFirstActivate then
  begin
    //scrlbx1MouseWheel(Pointer(1300), [ssCtrl], 20, handled);
    IsFirstActivate := False;
  end;
end;

procedure TfrmProfFormFMX.FormCreate(Sender: TObject);

begin
  //stylbk1.FileName := System.SysUtils.GetCurrentDir + '\styles\superHip.style';
  //Application.OnHint := btn1Click;

  pAll := TPopup.Create(Self);

  pAll.Name := 'pAll';
  pAll.VerticalOffset := 2.000000000000000000;
  //pAll.OnMouseWheel := scrlbx1MouseWheel;
  //pAll.OnPopup := p1Popup;
  pAll.Parent := scldlyt1;
  

  rctTokenPlug.ShowHint := True;
  Vcl.Forms.Screen.Cursors[HANDFLAT] := LoadCursorFromFile('C:\Program Files (x86)\Embarcadero\Studio\17.0\Images\Cursors\HANDFLAT.CUR');
  Vcl.Forms.Screen.Cursors[HANDGRAB] := LoadCursorFromFile('C:\Program Files (x86)\Embarcadero\Studio\17.0\Images\Cursors\HANDGRAB.CUR');
  rctBlankaTransparent.Cursor := HANDFLAT;


  Self.scldlyt1.Scale.X := 1;
  Self.scldlyt1.Scale.Y := 1;
  Application.OnException := appEvntsMainException;
  FPatient := TRealPatientNewItem.Create(nil);
  FOtherPregleds := TList<PVirtualNode>.Create;
  scaleDyn := 1;
  IsFirstActivate := True;
  cbb1.Visible := False;
  lstItemNomen.Visible := False;
  //cbbMulti.Visible := False;
  lytMN.Visible := False;
  lytMN.Parent := nil;
  lytImun.Visible := False;
  lytImun.Parent := nil;
  Memo1.Visible := False;
  cbbVisitFor := nil;
  rctBackGround.Visible := False;
  rctBKPlanetTypeItem.Visible := False;
  rctBKPlanetTypeItem.Parent := nil;

  LstExpanders := TList<TExpander>.Create;
  LstExpandersInVisitFor := TList<TExpander>.Create;
  LstMemos := TList<TMemo>.Create;
  LstMemosLYT := TList<TLayout>.Create;
  LstEdits := TList<TEdit>.Create;
  LstEditsLyt := TList<TLayout>.Create;
  LstDateEditsLyt := TList<TLayout>.Create;
  LstDateEdits := TList<TDateEditLabel>.Create;
  LstCombos := TList<TComboBox>.Create;
  LstMultiCombosLYT := TList<TLayout>.Create;
  LstOneCombosLYT := TList<TLayout>.create;
  LstItemsLst := TList<TListBoxItem>.Create;
  LstChecksSup := TList<TCheckBox>.create;

  LstDiags := TList<TRectangle>.create;
  LstMdns := Tlist<TLayout>.Create;
  LstMns := Tlist<TLayout>.Create;
  LstImuns := TList<TLayout>.Create;
  LstPlaneds := TList<TPlanedTypeLabel>.Create;


  LstEditsADB := TList<TEditADB>.Create;
  ListVacantPregIndex := TList<integer>.Create;


  p1.BoundsRect := frmFmxControls.lbComboOne.BoundsRect;
  frmFmxControls.lbComboOne.Parent := p1;
  frmFmxControls.lbComboOne.Align := TAlignLayout.Client;

  //lst2.Height := InnerChildrenRect(lst2).Height + 2;
  p2.BoundsRect := lbMdnType.BoundsRect;
  lbMdnType.Parent := p2;
  lbMdnType.Align := TAlignLayout.Client;

  p3.BoundsRect := lbPorpuse.BoundsRect;
  lbPorpuse.Parent := p3;
  lbPorpuse.Align := TAlignLayout.Client;

  pSourceAnsw.BoundsRect := lbSourceAnsw.BoundsRect;
  lbSourceAnsw.Parent := pSourceAnsw;
  lbSourceAnsw.Align := TAlignLayout.Client;


  txtCalcMemo := TTextLayoutManager.DefaultTextLayout.Create;
  txtCalcMemo.HorizontalAlign:= TTextAlign.center;
  txtCalcMemo.VerticalAlign := TTextAlign.center;
  txtCalcMemo.WordWrap := True;

  txtCalcEdit := TTextLayoutManager.DefaultTextLayout.Create;
  txtCalcEdit.HorizontalAlign:= TTextAlign.Leading;
  txtCalcEdit.VerticalAlign := TTextAlign.center;
  txtCalcEdit.WordWrap := false;
  Application.OnHint := OnApplicationHint;
  //Application.OnHint := OnApplicationHint;

  //FPatient := TRealPatientNewItem.Create(nil);

  //FPregled := TRealPregledNewItem.Create(nil);
  CreateTempItem;
  InitProps;
  InitHelpTags;
  FIssetings := False;
  FCheckKep := True;
  FSourceAnswerDefault := TSourceAnsw.saPatient;
  ListPlaneds := TList<TRealNZIS_PLANNED_TYPEItem>.create;
  frmFmxControls.rctBtnSaveLst.OnClick := rctBtnSaveLstClickSup;
  frmFmxControls.rctBtnCancelLst.OnClick := rctBtnCancelLstClick;
end;

procedure TfrmProfFormFMX.FormDestroy(Sender: TObject);
begin
  FreeAndNil(LstExpanders);
  FreeAndNil(LstExpandersInVisitFor);
  FreeAndNil(LstMemos);
  FreeAndNil(LstMemosLYT);
  FreeAndNil(LstEdits);
  FreeAndNil(LstEditsLyt);
  FreeAndNil(LstDateEdits);
  FreeAndNil(LstCombos);
  FreeAndNil(LstMultiCombosLYT);
  FreeAndNil(LstItemsLst);
  FreeAndNil(txtCalcMemo);
  FreeAndNil(txtCalcEdit);
  FreeAndNil(LstChecksSup);
  FreeAndNil(LstDiags);
  FreeAndNil(LstMdns);
  FreeAndNil(LstMns);
  FreeAndNil(LstImuns);
  FreeAndNil(LstDateEditsLyt);
  FreeAndNil(LstOneCombosLYT);
  FreeAndNil(LstPlaneds);
  FreeAndNil(FPatient);
  FreeAndNil(FOtherPregleds);



  FreeAndNil(LstEditsADB);
  FreeTempItem;
  //FreeAndNil(FPatient);
  //FreeAndNil(FPregled);
end;



procedure TfrmProfFormFMX.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if TWinCursorService.CursorOverride > 0 then  Exit;

  if (ssCtrl in Shift) and (ssShift in Shift) then
  begin
    case Key of
      vkC: // Ctrl+Shift+C
        begin
          // Implement your custom action here
          //mmoAddres.Text := ('Ctrl+Shift+C pressed!');
        end;
      vkV: // Ctrl+Shift+V
        begin
          // Implement your custom action here
          //mmoAddres.Text := ('Ctrl+Shift+V pressed!');
        end;
    else
      //mmoAddres.Text := ('Ctrl+Shift');
      rctBlankaTransparent.BringToFront;
      rctBlankaTransparent.HitTest := True;
      TWinCursorService.CursorOverride := HANDFLAT;
    end;
  end;

end;

procedure TfrmProfFormFMX.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  //mmoAddres.Text := ('');
  rctBlankaTransparent.SendToBack;
  rctBlankaTransparent.HitTest := false;
  TWinCursorService.CursorOverride := crDefault;
  //IFMXCursorService
  //rctCursorHand.Visible := False;
end;

procedure TfrmProfFormFMX.FormResize(Sender: TObject);
begin
  ZoomToWidth(self.Width);
end;

procedure TfrmProfFormFMX.FreeTempItem;
begin
  FreeAndNil(pr001Temp);
  FreeAndNil(cl088Temp);
  FreeAndNil(cl134Temp);
  FreeAndNil(cl139Temp);
  FreeAndNil(cl144Temp);
  FreeAndNil(respTemp);
  FreeAndNil(answTemp);
  FreeAndNil(answValTemp);
  FreeAndNil(RESULT_DIAGNOSTIC_REPTemp);
  FreeAndNil(DIAGNOSTIC_REPTemp);
end;

procedure TfrmProfFormFMX.InitHelpTags;
begin
  rctTokenPlug.TagString := 'Бутон за намиране на подпис';
  rctMkb.TagString := 'Бутон за основна диагноза';
  rctMkbAdd.TagString := 'Бутон за свързана диагноза';
end;

procedure TfrmProfFormFMX.InitProps;
var
  PP: PParamSetProp;
begin
  PatEgnSetProp := [];
  Include(PatEgnSetProp, TParamProp(PatientNew_EGN));
  PP := @PatEgnSetProp;
  edtEGN.Tag := Integer(PP);
  //edtEGN.TagObject := FPatient;

  PatNameSetProp := [];
  PerformerUinSetProp := [];
  PerformerNameSetProp := [];
end;

procedure TfrmProfFormFMX.InitSetings;
var
  tempH: Single;
begin
  Exit;
  if not FIssetings then
  begin
    tempH  := scldlyt1.Height * 1.3;
    scaleDyn := tempH / scldlyt1.OriginalHeight;
    scldlyt1.Width := scldlyt1.Width * 1.3;
    scldlyt1.Height := scldlyt1.Height * 1.3;
    FIssetings := True;
  end;
end;



procedure TfrmProfFormFMX.InnerEdtAnalCodeChangeTracking(Sender: TEdit);
var
  edtAnalCode: TEdit;
  TempLyt: TLayout;
  TempMdnsLabel: TMdnsLabel;
  TempMdnAnal: TMdnAnals;
  anal: TRealExamAnalysisItem;
  oldCode: string;
  indx: Integer;
begin
  edtAnalCode := Sender;
  TempLyt := TLayout(edtAnalCode.Parent.Parent);
  TempMdnsLabel:= TMdnsLabel(TempLyt.TagObject);
  TempMdnAnal := TMdnAnals(edtAnalCode.TagObject);
  if TempMdnAnal = nil then // ново
  begin
    TempMdnAnal :=  TMdnAnals.Create;
    edtAnalCode.TagObject := TempMdnAnal;
    if Assigned(FOnAddNewAnal) then
      FOnAddNewAnal(TempMdnsLabel.mdn, TempMdnsLabel.LinkMdn, TempMdnAnal.LinkAnal, TempMdnAnal.Anal);
  end;
  if edtAnalCode.Text = '' then // изтривам го
  begin
    if Assigned(FOnDeleteNewAnal) then
    begin
      if TempMdnAnal.Anal.LinkNode <> nil then
      begin
        TempMdnAnal.LinkAnal  := TempMdnAnal.Anal.LinkNode;
      end;
      FOnDeleteNewAnal(TempMdnsLabel.mdn, TempMdnsLabel.LinkMdn, TempMdnAnal.LinkAnal, TempMdnAnal.Anal);
      TempMdnAnal.Anal.Destroy;
      TempMdnAnal.Anal := nil;
      edtAnalCode.TagObject := nil;
      Exit;
    end;

  end;
  anal := TempMdnAnal.Anal;
  if anal.DataPos <> 0 then
  begin
    oldCode := anal.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(ExamAnalysis_NZIS_CODE_CL22));
  end
  else
  begin
    oldCode := '';
  end;
  if oldCode <> edtAnalCode.Text then
  begin
    if anal.PRecord = nil then
    begin
      New(anal.PRecord);
      anal.PRecord.setProp := [];
      if anal.Collection = nil then
        anal.Collection := FExamAnalColl;
    end;
    Include(anal.PRecord.setProp, ExamAnalysis_NZIS_CODE_CL22);
    anal.PRecord.NZIS_CODE_CL22 := edtAnalCode.Text;
  end
  else
  begin
    if anal.PRecord <> nil then
    begin
      Exclude(anal.PRecord.setProp, ExamAnalysis_NZIS_CODE_CL22);
      if anal.PRecord.setProp = [] then
      begin
        Dispose(anal.PRecord);
        anal.PRecord := nil;
      end;
    end;
  end;

  if Assigned(FOnchangeColl) then
    FOnchangeColl(anal);
end;


procedure TfrmProfFormFMX.lbPorpuseChange(Sender: TObject);
var
  cbb: TComboBox;//text1style
  txt: TText;
begin
  if sender = nil then Exit;
  if p3 = nil then Exit;
  if p3.PlacementTarget = nil then Exit;


  if (p3.PlacementTarget.ClassName = 'TComboBox') then
  begin
    cbb := TComboBox(p3.PlacementTarget);
    if cbb.FindStyleResource<TText>('text1style', txt) then
    begin
      txt.Text := lbPorpuse.ListItems[lbPorpuse.ItemIndex].Text;
      //TListBoxItem(sender).Height := txt.Height;
    end;
  end;

end;

procedure TfrmProfFormFMX.lbSourceAnswChange(Sender: TObject);
begin
  //
end;

procedure TfrmProfFormFMX.LineSaverPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  LYT: TLayout;
  lin: TLine;
  TempComboLabel: TComboOneLabel;
  data, dataQuest: PAspRec;
begin
  lin := TLine(Sender);
  LYT := TLayout(lin.Parent);
  if LYT.TagObject is TComboOneLabel then
  begin
    TempComboLabel := TComboOneLabel(LYT.TagObject);
    data := Pointer(PByte(TempComboLabel.node) + lenNode);
    case data.vid of
      vvNZIS_QUESTIONNAIRE_ANSWER:
      begin
        //dataQuest :=
      end;
    end;

    if TempComboLabel.node.FirstChild <> nil  then
    begin
      lin.Stroke.Color := TAlphaColorRec.Mediumblue;
    end
    else
    begin
      lin.Stroke.Color := TAlphaColorRec.Null;
    end;
  end;
end;

procedure TfrmProfFormFMX.linSaverClick(Sender: TObject);
var
  TempMemoLabel: TMemoLabel;
  TempMemoLYT: TLayout;
begin
  TempMemoLYT := TLayout(TLine(Sender).Parent);
  TempMemoLabel := TMemoLabel(TempMemoLYT.TagObject);
  TempMemoLabel.memo.Caret.Width := 12;
end;

procedure TfrmProfFormFMX.ListBoxItem1Click(Sender: TObject);
begin
  p3.IsOpen := False;
end;

procedure TfrmProfFormFMX.lbComboOneChange(Sender: TObject);
var
  cbb: TComboBox;//text1style
  //TempComboLabel: TComboLabel;
  txt: TText;
begin
  if sender = nil then Exit;

  if (p1.PlacementTarget.ClassName = 'TComboBox') then
  begin
    cbb := TComboBox(p1.PlacementTarget);
    //TempComboLabel := TComboLabel(cbb.TagObject);
    if cbb.FindStyleResource<TText>('text1style', txt) then
    begin
      //TempComboLabel.canValidate := False;
      txt.Text := frmFmxControls.lbComboOne.ListItems[frmFmxControls.lbComboOne.ItemIndex].Text;
      //TempComboLabel.canValidate := true;
      //TListBoxItem(sender).Height := txt.Height;
    end;
  end;

end;

//procedure TfrmProfFormFMX.lst1Click(Sender: TObject);
//var
//  cbb: TComboBox;
//  TempComboLabel: TComboLabel;
//  i: integer;
//  lstItem: TListBoxItem;
//  TempBtnMulti: TSpeedButton;
//  Aflyt: TFlowLayout;
//  TempTxt: TText;
//  ckb: TCheckBoxDyn;
//  data, dataAnswVal, dataResDiagRep: PAspRec;
//  cl134Key: string;
//  AnswValue: TRealNZIS_ANSWER_VALUEItem;
//  ResDiagRep: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
//  linkpos, cl144Pos: Cardinal;
//begin
//  p1.IsOpen := False;
//  cbb := TComboBox(p1.TagObject);
//
//  if FIsVtrPregled then
//  begin
//    TempComboLabel := TComboLabel(cbb.TagObject);
//    data := Pointer(PByte(TempComboLabel.node) + lenNode);
//    TempComboLabel.chk.IsNull := false;
//    TempComboLabel.chk.IsChecked := true;
//    VtrPregLink.CheckType[TempComboLabel.node] := ctCheckBox;
//    VtrPregLink.CheckState[TempComboLabel.node] := csCheckedNormal;
//
//    if TempComboLabel.node.FirstChild = nil then
//    begin
//      case data.vid of
//        vvNZIS_QUESTIONNAIRE_ANSWER:
//        begin
//          answTemp.DataPos := Data.DataPos;
//          cl134Temp.DataPos := answTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS));
//          answTemp.cl028 := StrToInt(cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL134_CL028)));
//          AnswValue := TRealNZIS_ANSWER_VALUEItem(FAdb_dm.CollNZIS_ANSWER_VALUE.Add);
//          Memo1.Text := IntToStr(FAnswValuesColl.Count) + '(FAnswValuesColl.Add)' ;
//          New(AnswValue.PRecord);
//          case answTemp.cl028 of
//            2: //номенклатура
//            begin
//              AnswValue.PRecord.ANSWER_CODE := Copy(lst1.Items[lst1.ItemIndex], 1, 5);// '06.05 | Средно-специално образование
//              AnswValue.PRecord.ID := 0;
//              AnswValue.PRecord.QUESTIONNAIRE_ANSWER_ID := 0;
//              AnswValue.PRecord.CL028 := 2;
//              AnswValue.PRecord.NOMEN_POS := Cl139Coll.GetDataPosFromKey(AnswValue.PRecord.ANSWER_CODE);
//
//              AnswValue.PRecord.setProp :=
//              [NZIS_ANSWER_VALUE_ANSWER_CODE
//              , NZIS_ANSWER_VALUE_ID
//              , NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID
//              , NZIS_ANSWER_VALUE_CL028
//              , NZIS_ANSWER_VALUE_NOMEN_POS];
//
//              AnswValue.InsertNZIS_ANSWER_VALUE;
//              Dispose(AnswValue.PRecord);
//              AnswValue.PRecord := nil;
//            end;
//          end;
//          FAspLink.AddNewNode(vvNZIS_ANSWER_VALUE, AnswValue.DataPos, TempComboLabel.node, amAddChildLast, TempComboLabel.nodeValue, linkpos);
//          dataAnswVal := Pointer(PByte(TempComboLabel.node.FirstChild) + lenNode);
//          dataAnswVal.index := AnswValuesColl.Count - 1;
//          MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);
//        end;
//        vvNZIS_RESULT_DIAGNOSTIC_REPORT:
//        begin
//          ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(FResDiagRepColl.Add);
//          ResDiagRep.DataPos := Data.DataPos;
//          cl144Pos := ResDiagRep.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
//          cl144Temp.DataPos := cl144Pos;
//          ResDiagRep.cl028 := StrToInt(cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL144_CL028)));
//          New(ResDiagRep.PRecord);
//          case ResDiagRep.cl028 of
//            2: //номенклатура
//            begin
//              ResDiagRep.PRecord.VALUE_CODE := Copy(lst1.Items[lst1.ItemIndex], 1, 5);;
//              ResDiagRep.PRecord.ID := 0;
//              ResDiagRep.PRecord.DIAGNOSTIC_REPORT_ID := 0;
//              ResDiagRep.PRecord.CL028_VALUE_SCALE := 2;
//              ResDiagRep.PRecord.NOMEN_POS := Cl139Coll.GetDataPosFromKey(ResDiagRep.PRecord.VALUE_CODE);
//
//              ResDiagRep.PRecord.setProp :=
//              [NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE
//              , NZIS_RESULT_DIAGNOSTIC_REPORT_ID
//              , NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID
//              , NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE
//              , NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS];
//
//              ResDiagRep.InsertNZIS_RESULT_DIAGNOSTIC_REPORT;
//              Dispose(ResDiagRep.PRecord);
//              ResDiagRep.PRecord := nil;
//            end;
//          end;
//          FAspLink.AddNewNode(vvNZIS_RESULT_DIAGNOSTIC_REPORT, ResDiagRep.DataPos, TempComboLabel.node, amAddChildLast, TempComboLabel.nodeValue, linkpos);
//          dataResDiagRep := Pointer(PByte(TempComboLabel.node.FirstChild) + lenNode);
//          dataResDiagRep.index := FResDiagRepColl.Count - 1;
//        end;
//      end;
//    end
//    else
//    begin
//      case data.vid of
//        vvNZIS_QUESTIONNAIRE_ANSWER:
//        begin
//          answTemp.DataPos := Data.DataPos;
//          dataAnswVal := Pointer(PByte(TempComboLabel.node.FirstChild) + lenNode);
//          if dataAnswVal.index >= 0 then
//          begin
//            AnswValue := AnswValuesColl.Items[dataAnswVal.index];
//            if AnswValue.PRecord <> nil then
//            begin
//              case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
//                2:
//                begin
//                  AnswValue.PRecord.setProp := [];
//                  AnswValue.PRecord.ANSWER_CODE := Copy(lst1.Items[lst1.ItemIndex], 1, 5);
//                  Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_CODE);
//                  AnswValue.PRecord.NOMEN_POS := Cl139Coll.GetDataPosFromKey(AnswValue.PRecord.ANSWER_CODE);
//                  Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_NOMEN_POS);
//                end;
//              end;
//            end
//            else
//            begin
//              New(AnswValue.PRecord);
//              case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
//                2:
//                begin
//                  AnswValue.PRecord.setProp := [];
//                  AnswValue.PRecord.ANSWER_CODE := Copy(lst1.Items[lst1.ItemIndex], 1, 5);
//                  Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_CODE);
//                  AnswValue.PRecord.NOMEN_POS := Cl139Coll.GetDataPosFromKey(AnswValue.PRecord.ANSWER_CODE);
//                  Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_NOMEN_POS);
//                end;
//              end;
//            end;
//          end
//          else
//          begin
//            AnswValue := TRealNZIS_ANSWER_VALUEItem(FAnswValuesColl.Add);
//            Memo1.Text := IntToStr(FAnswValuesColl.Count) + '(FAnswValuesColl.Add)' ;
//            AnswValue.DataPos := dataAnswVal.DataPos;
//            dataAnswVal.index := AnswValuesColl.Count - 1;
//            New(AnswValue.PRecord);
//            case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
//              2:
//              begin
//                AnswValue.PRecord.setProp := [];
//                AnswValue.PRecord.ANSWER_CODE := Copy(lst1.Items[lst1.ItemIndex], 1, 5);
//                Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_CODE);
//                AnswValue.PRecord.NOMEN_POS := Cl139Coll.GetDataPosFromKey(AnswValue.PRecord.ANSWER_CODE);
//                Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_NOMEN_POS);
//              end;
//            end;
//          end;
//          MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);
//        end;
//        vvNZIS_RESULT_DIAGNOSTIC_REPORT:
//        begin
//          DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
//          dataResDiagRep := Pointer(PByte(TempComboLabel.node.FirstChild) + lenNode);
//          if dataResDiagRep.index >= 0 then
//          begin
//            ResDiagRep := ResDiagRepColl.Items[dataResDiagRep.index];
//            if ResDiagRep.PRecord <> nil then
//            begin
//              case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
//                2:
//                begin
//                  ResDiagRep.PRecord.setProp := [];
//                  ResDiagRep.PRecord.VALUE_CODE := Copy(lst1.Items[lst1.ItemIndex], 1, 5);
//                  Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE);
//                  ResDiagRep.PRecord.NOMEN_POS := Cl139Coll.GetDataPosFromKey(ResDiagRep.PRecord.VALUE_CODE);
//                  Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS);
//                end;
//              end;
//            end
//            else
//            begin
//              New(ResDiagRep.PRecord);
//              case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
//                2:
//                begin
//                  ResDiagRep.PRecord.setProp := [];
//                  ResDiagRep.PRecord.VALUE_CODE := Copy(lst1.Items[lst1.ItemIndex], 1, 5);
//                  Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE);
//                  ResDiagRep.PRecord.NOMEN_POS := Cl139Coll.GetDataPosFromKey(ResDiagRep.PRecord.VALUE_CODE);
//                  Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS);
//                end;
//              end;
//            end;
//          end
//          else
//          begin
//            ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(ResDiagRepColl.Add);
//            ResDiagRep.DataPos := dataResDiagRep.DataPos;
//            ResDiagRep.index := ResDiagRepColl.Count - 1;
//            New(ResDiagRep.PRecord);
//            case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
//              2:
//              begin
//                ResDiagRep.PRecord.setProp := [];
//                ResDiagRep.PRecord.VALUE_CODE := Copy(lst1.Items[lst1.ItemIndex], 1, 5);
//                Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE);
//                ResDiagRep.PRecord.NOMEN_POS := Cl139Coll.GetDataPosFromKey(ResDiagRep.PRecord.VALUE_CODE);
//                Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS);
//              end;
//            end;
//          end;
//        end;
//      end;
//    end;
//    //VtrPregLink.Selected[TempComboLabel.node] := True;
//    //FAspLink.FVTR.RepaintNode(TempComboLabel.node.FirstChild);
//  end;
//end;

procedure TfrmProfFormFMX.lbComboOneKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  //btn1.Text := DateTimeToStr(now);
end;

procedure TfrmProfFormFMX.lbComboOneKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  //
end;

procedure TfrmProfFormFMX.lbComboOneMouseLeave(Sender: TObject);
var
  cbb: TComboBox;//text1style
  txt: TText;
begin
  frmFmxControls.lbComboOne.ItemIndex := -1;
  if p1.PlacementTarget is TComboBox then
  begin
    cbb := TComboBox(p1.PlacementTarget);
    if cbb.FindStyleResource<TText>('text1style', txt) then
    begin
      txt.Text := '';
      //TListBoxItem(sender).Height := txt.Height;
    end;
  end;
end;

procedure TfrmProfFormFMX.lbComboOneMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
var
  TempItem: TListBoxItem;
begin
  TempItem := TListBox(sender).ItemByPoint(x, y);
  if TempItem <> nil then
  begin
    TListBox(sender).ItemIndex := TempItem.Index;
  end
  else
  begin
    TListBox(sender).ItemIndex := -1;
  end;
end;

procedure TfrmProfFormFMX.lblAddresPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
   data: PAspRec;
   AddresLinkPos: integer;
   nasMest: TRealNasMestoItem;
begin
  if patNodes.addresses.Count > 0 then
  begin
    data := Pointer(pbyte(patNodes.addresses[0]) + lenNode);
    AddresLinkPos := NasMesto.addresColl.getIntMap(data.DataPos, word(Addres_LinkPos));
    nasMest := NasMesto.FindNasMestFromDataPos(AddresLinkPos);
    if nasMest <> nil then
    begin
      lblAddres.Text := NasMesto.OblColl.getAnsiStringMap(nasMest.FObl.DataPos, word(Oblast_OblastName))

      //nasMest.Node := nil;
    end;
    //txtRczR.Text := 'РЗОК №| здр. район ' + NasMesto.nasMestoColl.getAnsiStringMap(AddresLinkPos, word(NasMesto_RCZR));

  end
  else
  begin
    //txtRczR.Text := 'РЗОК №| здр. район 00|00'
  end;

  //FPatient.
end;

procedure TfrmProfFormFMX.lbMdnTypeChange(Sender: TObject);
var
  cbb: TComboBox;//text1style
  edt: TEdit;
  txt: TText;
begin
  if sender = nil then Exit;
  if p2 = nil then Exit;
  if p2.PlacementTarget = nil then Exit;

  if p2.PlacementTarget.ClassName = 'TComboBox' then
  begin
    cbb := TComboBox(p2.PlacementTarget);
    if cbb.FindStyleResource<TText>('text1style', txt) then
    begin
      txt.Text := lbMdnType.ListItems[lbMdnType.ItemIndex].Text;
      //TListBoxItem(sender).Height := txt.Height;
    end;
  end;
end;

procedure TfrmProfFormFMX.lst3Click(Sender: TObject);
begin
  p2.IsOpen := False;
end;

procedure TfrmProfFormFMX.lstItemNomenClick(Sender: TObject);
var
  cbb: TComboBox;
  TempComboLabel: TComboLabel;
begin
  //if TListBoxItem(Sender).parent is TComboBox then
//  begin
//    cbb := TComboBox(TListBoxItem(Sender).parent);
//    TempComboLabel := LstCombos[cbb.Tag];
//    cbb.ItemIndex := TListBoxItem(Sender).Index;
//  end;
  if not frmFmxControls.lbComboOne.ShowCheckboxes then  Exit;
  TListBoxItem(Sender).IsChecked := not TListBoxItem(Sender).IsChecked;
  //cbb := TComboBox(p1.PlacementTarget);
//  TempComboLabel := TComboLabel(cbb.Parent.TagObject);
//  MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);
end;

procedure TfrmProfFormFMX.lstOneChange(Sender: TObject);
var
  cbb: TComboBox;
  TempComboLabel: TComboOneLabel;
  txt: TText;
begin
  if sender = nil then Exit;
  cbb := TComboBox(p1.PlacementTarget);
  TempComboLabel := TComboOneLabel(cbb.Parent.TagObject);
  TempComboLabel.txt.Text := frmFmxControls.lbComboOne.ListItems[frmFmxControls.lbComboOne.ItemIndex].Text;
  //if (p1.PlacementTarget.ClassName = 'TComboBox') then
//  begin
//
//    //TempComboLabel := TComboLabel(cbb.TagObject);
//    if cbb.FindStyleResource<TText>('text1style', txt) then
//    begin
//      //TempComboLabel.canValidate := False;
//      txt.Text := lst1.ListItems[lst1.ItemIndex].Text;
//      //TempComboLabel.canValidate := true;
//      //TListBoxItem(sender).Height := txt.Height;
//    end;
//  end;

end;

procedure TfrmProfFormFMX.lstOneClick(Sender: TObject);
var
  cbb: TComboBox;
  TempComboLabel: TComboOneLabel;
  i: integer;
  lstItem: TListBoxItem;
  Aflyt: TFlowLayout;
  TempTxt: TText;
  data, dataAnswVal, dataResDiagRep: PAspRec;
  cl134Key: string;
  AnswValue: TRealNZIS_ANSWER_VALUEItem;
  ResDiagRep: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
  linkpos, cl144Pos: Cardinal;
begin
  p1.IsOpen := False;
  cbb := TComboBox(p1.TagObject);

  if FIsVtrPregled then
  begin
    TempComboLabel := TComboOneLabel(cbb.Parent.TagObject);
    data := Pointer(PByte(TempComboLabel.node) + lenNode);
    TempComboLabel.rctNull.Visible := false;
    TempComboLabel.chk.IsChecked := true;
    VtrPregLink.CheckType[TempComboLabel.node] := ctCheckBox;
    VtrPregLink.CheckState[TempComboLabel.node] := csCheckedNormal;

    if TempComboLabel.node.FirstChild = nil then
    begin
      case data.vid of
        vvNZIS_QUESTIONNAIRE_ANSWER:
        begin
          answTemp.DataPos := Data.DataPos;
          cl134Temp.DataPos := answTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS));
          answTemp.cl028 := StrToInt(cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL134_CL028)));
          AnswValue := TRealNZIS_ANSWER_VALUEItem(Adb_dm.CollNZIS_ANSWER_VALUE.Add);
          Memo1.Text := IntToStr(Adb_dm.CollNZIS_ANSWER_VALUE.Count) + '(Adb_dm.CollNZIS_ANSWER_VALUE.Add)' ;
          New(AnswValue.PRecord);
          case answTemp.cl028 of
            2: //номенклатура
            begin
              AnswValue.PRecord.ANSWER_CODE := Copy(frmFmxControls.lbComboOne.Items[frmFmxControls.lbComboOne.ItemIndex], 1, 5);// '06.05 | Средно-специално образование
              AnswValue.PRecord.ID := 0;
              AnswValue.PRecord.QUESTIONNAIRE_ANSWER_ID := 0;
              AnswValue.PRecord.CL028 := 2;
              AnswValue.PRecord.NOMEN_POS := Adb_dm.Cl139Coll.GetDataPosFromKey(AnswValue.PRecord.ANSWER_CODE);

              AnswValue.PRecord.setProp :=
              [NZIS_ANSWER_VALUE_ANSWER_CODE
              , NZIS_ANSWER_VALUE_ID
              , NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID
              , NZIS_ANSWER_VALUE_CL028
              , NZIS_ANSWER_VALUE_NOMEN_POS];

              AnswValue.InsertNZIS_ANSWER_VALUE;
              Dispose(AnswValue.PRecord);
              AnswValue.PRecord := nil;
            end;
          end;
          FAspLink.AddNewNode(vvNZIS_ANSWER_VALUE, AnswValue.DataPos, TempComboLabel.node, amAddChildLast, TempComboLabel.nodeValue, linkpos);
          dataAnswVal := Pointer(PByte(TempComboLabel.node.FirstChild) + lenNode);
          dataAnswVal.index := Adb_dm.CollNZIS_ANSWER_VALUE.Count - 1;
          MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);
        end;
        vvNZIS_RESULT_DIAGNOSTIC_REPORT:
        begin
          ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Add);
          ResDiagRep.DataPos := Data.DataPos;
          cl144Pos := ResDiagRep.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
          cl144Temp.DataPos := cl144Pos;
          ResDiagRep.cl028 := StrToInt(cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL144_CL028)));
          New(ResDiagRep.PRecord);
          case ResDiagRep.cl028 of
            2: //номенклатура
            begin
              ResDiagRep.PRecord.VALUE_CODE := Copy(frmFmxControls.lbComboOne.Items[frmFmxControls.lbComboOne.ItemIndex], 1, 5);;
              ResDiagRep.PRecord.ID := 0;
              ResDiagRep.PRecord.DIAGNOSTIC_REPORT_ID := 0;
              ResDiagRep.PRecord.CL028_VALUE_SCALE := 2;
              ResDiagRep.PRecord.NOMEN_POS := Adb_dm.Cl139Coll.GetDataPosFromKey(ResDiagRep.PRecord.VALUE_CODE);

              ResDiagRep.PRecord.setProp :=
              [NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE
              , NZIS_RESULT_DIAGNOSTIC_REPORT_ID
              , NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID
              , NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE
              , NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS];

              ResDiagRep.InsertNZIS_RESULT_DIAGNOSTIC_REPORT;
              Dispose(ResDiagRep.PRecord);
              ResDiagRep.PRecord := nil;
            end;
          end;
          FAspLink.AddNewNode(vvNZIS_RESULT_DIAGNOSTIC_REPORT, ResDiagRep.DataPos, TempComboLabel.node, amAddChildLast, TempComboLabel.nodeValue, linkpos);
          dataResDiagRep := Pointer(PByte(TempComboLabel.node.FirstChild) + lenNode);
          dataResDiagRep.index := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Count - 1;
        end;
      end;
    end
    else
    begin
      case data.vid of
        vvNZIS_QUESTIONNAIRE_ANSWER:
        begin
          answTemp.DataPos := Data.DataPos;
          dataAnswVal := Pointer(PByte(TempComboLabel.node.FirstChild) + lenNode);
          if dataAnswVal.index >= 0 then
          begin
            AnswValue := Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index];
            if AnswValue.PRecord <> nil then
            begin
              case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                2:
                begin
                  AnswValue.PRecord.setProp := [];
                  AnswValue.PRecord.ANSWER_CODE := Copy(frmFmxControls.lbComboOne.Items[frmFmxControls.lbComboOne.ItemIndex], 1, 5);
                  Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_CODE);
                  AnswValue.PRecord.NOMEN_POS := Adb_dm.Cl139Coll.GetDataPosFromKey(AnswValue.PRecord.ANSWER_CODE);
                  Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_NOMEN_POS);
                end;
              end;
            end
            else
            begin
              New(AnswValue.PRecord);
              case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                2:
                begin
                  AnswValue.PRecord.setProp := [];
                  AnswValue.PRecord.ANSWER_CODE := Copy(frmFmxControls.lbComboOne.Items[frmFmxControls.lbComboOne.ItemIndex], 1, 5);
                  Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_CODE);
                  AnswValue.PRecord.NOMEN_POS := Adb_dm.Cl139Coll.GetDataPosFromKey(AnswValue.PRecord.ANSWER_CODE);
                  Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_NOMEN_POS);
                end;
              end;
            end;

          end
          else
          begin
            AnswValue := TRealNZIS_ANSWER_VALUEItem(Adb_dm.CollNZIS_ANSWER_VALUE.Add);
            Memo1.Text := IntToStr(Adb_dm.CollNZIS_ANSWER_VALUE.Count) + '(Adb_dm.CollNZIS_ANSWER_VALUE.Add)' ;
            AnswValue.DataPos := dataAnswVal.DataPos;
            dataAnswVal.index := Adb_dm.CollNZIS_ANSWER_VALUE.Count - 1;
            New(AnswValue.PRecord);
            case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
              2:
              begin
                AnswValue.PRecord.setProp := [];
                AnswValue.PRecord.ANSWER_CODE := Copy(frmFmxControls.lbComboOne.Items[frmFmxControls.lbComboOne.ItemIndex], 1, 5);
                Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_CODE);
                AnswValue.PRecord.NOMEN_POS := Adb_dm.Cl139Coll.GetDataPosFromKey(AnswValue.PRecord.ANSWER_CODE);
                Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_NOMEN_POS);
              end;
            end;
          end;
          MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);
        end;
        vvNZIS_RESULT_DIAGNOSTIC_REPORT:
        begin
          DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
          dataResDiagRep := Pointer(PByte(TempComboLabel.node.FirstChild) + lenNode);
          if dataResDiagRep.index >= 0 then
          begin
            ResDiagRep := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiagRep.index];
            if ResDiagRep.PRecord <> nil then
            begin
              case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                2:
                begin
                  ResDiagRep.PRecord.setProp := [];
                  ResDiagRep.PRecord.VALUE_CODE := Copy(frmFmxControls.lbComboOne.Items[frmFmxControls.lbComboOne.ItemIndex], 1, 5);
                  Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE);
                  ResDiagRep.PRecord.NOMEN_POS := Adb_dm.Cl139Coll.GetDataPosFromKey(ResDiagRep.PRecord.VALUE_CODE);
                  Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS);
                end;
              end;
            end
            else
            begin
              New(ResDiagRep.PRecord);
              case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                2:
                begin
                  ResDiagRep.PRecord.setProp := [];
                  ResDiagRep.PRecord.VALUE_CODE := Copy(frmFmxControls.lbComboOne.Items[frmFmxControls.lbComboOne.ItemIndex], 1, 5);
                  Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE);
                  ResDiagRep.PRecord.NOMEN_POS := Adb_dm.Cl139Coll.GetDataPosFromKey(ResDiagRep.PRecord.VALUE_CODE);
                  Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS);
                end;
              end;
            end;
          end
          else
          begin
            ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Add);
            ResDiagRep.DataPos := dataResDiagRep.DataPos;
            ResDiagRep.index := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Count - 1;
            New(ResDiagRep.PRecord);
            case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
              2:
              begin
                ResDiagRep.PRecord.setProp := [];
                ResDiagRep.PRecord.VALUE_CODE := Copy(frmFmxControls.lbComboOne.Items[frmFmxControls.lbComboOne.ItemIndex], 1, 5);
                Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE);
                ResDiagRep.PRecord.NOMEN_POS := Adb_dm.Cl139Coll.GetDataPosFromKey(ResDiagRep.PRecord.VALUE_CODE);
                Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS);
              end;
            end;
          end;
        end;
      end;
    end;
    //VtrPregLink.Selected[TempComboLabel.node] := True;
    //FAspLink.FVTR.RepaintNode(TempComboLabel.node.FirstChild);
    TempComboLabel.LineSaver.Repaint;
    MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);
  end;
end;

procedure TfrmProfFormFMX.lstSourceAnswItemClick(Sender: TObject);
var
  rct: TRectangle;

  TempComboLabel: TComboOneLabel;
  TempComboMultiLabel: TComboMultiLabel;
  TempEditLabel: TEditLabel;
  TempMemoLabel: TMemoLabel;
  TempCheckLYT: TLayoutCheck;
  TempDateEditLabel: TDateEditLabel;
  SAnsw: TSourceAnsw;
begin
  pSourceAnsw.IsOpen := False;
  rct := TRectangle(pSourceAnsw.PlacementTarget);
  //rct.Fill.Assign(TRectangle(sender).Fill);
  SAnsw :=  TSourceAnsw(TListBoxItem(Sender).Index + 1);
  if rct.TagObject is TComboOneLabel then
  begin
    TempComboLabel := TComboOneLabel(rct.TagObject);
    TempComboLabel.SourceAnsw := SAnsw;
    TempComboLabel.node.Dummy := Byte(SAnsw);
  end;
  if rct.TagObject is TComboMultiLabel then
  begin
    TempComboMultiLabel := TComboMultiLabel(rct.TagObject);
    TempComboMultiLabel.SourceAnsw := SAnsw;
    //TempComboMultiLabel.node.parent.Dummy := Byte(SAnsw);
    TempComboMultiLabel.node.Dummy := Byte(SAnsw);
  end;
  if rct.TagObject is TEditLabel then
  begin
    TempEditLabel := TEditLabel(rct.TagObject);
    TempEditLabel.SourceAnsw := SAnsw;
    //TempEditLabel.node.parent.Dummy := Byte(SAnsw);
    TempEditLabel.node.Dummy := Byte(SAnsw);
  end;
  if rct.TagObject is TMemoLabel then
  begin
    TempMemoLabel := TMemoLabel(rct.TagObject);
    TempMemoLabel.SourceAnsw := SAnsw;
    TempMemoLabel.node.Dummy := Byte(SAnsw);
  end;
  if rct.TagObject is TLayoutCheck then
  begin
    TempCheckLYT := TLayoutCheck(rct.TagObject);
    TempCheckLYT.SourceAnsw := SAnsw;
    TempCheckLYT.node.Dummy := Byte(SAnsw);
  end;
  if rct.TagObject is TDateEditLabel then
  begin
    TempDateEditLabel := TDateEditLabel(rct.TagObject);
    TempDateEditLabel.SourceAnsw := SAnsw;
    //TempDateEditLabel.node.Parent.Dummy := Byte(SAnsw);
    TempDateEditLabel.node.Dummy := Byte(SAnsw);
  end;
  MarkSourceAnsw(SAnsw, rct);
end;

procedure TfrmProfFormFMX.lytbottomPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  //
end;

procedure TfrmProfFormFMX.lytFrameMDNMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  //
end;

procedure TfrmProfFormFMX.lytLeftMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single);
begin
  //txt1.Text := FloatToStr(y);
end;

procedure TfrmProfFormFMX.lytLeftPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  //
end;

procedure TfrmProfFormFMX.lytMdnExpResize(Sender: TObject);
var
  h: Single;
begin
  Exit;
  h := InnerChildrenRect(lytMdnExp).Height/FScaleDyn ;
  lytMdnExp.Height := h;
  expndrMdns.Height := max(h + 55,90);
end;

procedure TfrmProfFormFMX.lytMNResize(Sender: TObject);
begin
  //
end;

procedure TfrmProfFormFMX.lytMultiComboResize(Sender: TObject);
var
  lytLeftHeight, lytRightHeight: Single;
  flwlyt: TFlowLayout;
  xpndr: TExpander;
  cntnt: TContent;
  HExpandHead: Single;
begin
  if TLayout(Sender).Parent is TFlowLayout then
    flwlyt := TFlowLayout(TComboBox(Sender).Parent)
  else
    Exit;
  flwlyt.RecalcSize;
  flwlyt.Height := InnerChildrenRect(flwlyt).Height / scaleDyn + 15;
  if flwlyt.Parent is TContent then
  begin
    if flwlyt.Parent.Parent is TExpander then
    begin
      xpndr := TExpander(flwlyt.Parent.parent);
      HExpandHead := 55;
    end;
  end
  else
  if flwlyt.Parent is TRectangle then
  begin
    if flwlyt.Parent.Parent.Parent is TExpander then
    begin
      xpndr := TExpander(flwlyt.Parent.parent.Parent);
      HExpandHead := 35
    end;
  end;

  xpndr.Height := (flwlyt.Height  + HExpandHead);
  flwlytVizitFor.RecalcSize;
  flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height / scaleDyn + 15;

  lytRightResize(nil);
  SetExpanderVisitForHeight;
end;

procedure TfrmProfFormFMX.lytPlanedTypePainting(Sender: TObject;
  Canvas: TCanvas; const ARect: TRectF);
begin
  //
end;

procedure TfrmProfFormFMX.lytRightResize(Sender: TObject);
var
  p2, p3: TPointF;
  lytLeftHeight, TotalH: Single;
begin
  //lytbottom.Height := 10000;
  //lytLeft.Height := 200;
  //lytLeft.RecalcSize;
//  lytLeftHeight := InnerChildrenRect(lytLeft).Height/FScaleDyn;
//  lytLeft.Height := lytLeftHeight;
  //lytLeftHeight := 6000;
 // p2 := lytLeft.LocalToAbsolute(PointF(0,lytLeftHeight));
  //if scldlyt1.IsUpdating then
    //Exit;
  p2 := txtEndOfLeft.LocalToAbsolute(PointF(0,txtEndOfLeft.Size.Height + scrlbx1.ViewportPosition.y/FScaleDyn));
  p3 := lytEndRight.LocalToAbsolute(PointF(0,lytEndRight.Size.Height + scrlbx1.ViewportPosition.y/FScaleDyn));
  TotalH := Max(p2.Y , p3.y)/ FScaleDyn;
  lytLeft.Height := TotalH - lytLeft.Position.y;
  scldlyt1.OriginalHeight :=TotalH;
  scldlyt1.Height := scldlyt1.OriginalHeight * FScaleDyn;
  lytbottom.Height := lytLeft.Height + 20;


  //lytbottom.Height := TotalH; //- lytTop.Height - rct1.Height ;

  //if rctBackGround.Margins.Bottom = 2 then
//  begin
//    rctBackGround.Margins.Bottom := 1;
//  end
//  else
//  begin
//    rctBackGround.Margins.Bottom := 2;
//  end;

end;

procedure TfrmProfFormFMX.MarkSourceAnsw(TargetSourceAnsw: TSourceAnsw; TargetRect: TRectangle);
var
  TempComboLabel: TComboOneLabel;
  TempMemoLabel: TMemoLabel;
  TempCheckLYT: TLayoutCheck;
  TempDateEditLabel: TDateEditLabel;
  TempComboMultiLabel: TComboMultiLabel;
  TempEditLabel: TEditLabel;

  IsRes: Boolean;
  SourcAnsw: TSourceAnsw;
begin
  //TargetSourceAnsw - каквото е в дървото
  SourcAnsw := TargetSourceAnsw;
  isRes := False;
  if SourcAnsw in [TSourceAnsw.saPatient, TSourceAnsw.saOther, TSourceAnsw.saDoktor] then
  begin
    if TargetRect.TagObject is TComboOneLabel then
    begin
      TempComboLabel := TComboOneLabel(TargetRect.TagObject);
      if not TempComboLabel.chk.IsChecked then
      begin
        case SourceAnswerDefault of
          TSourceAnsw.saPatient: SourcAnsw := TSourceAnsw.saNotAnsw;
          TSourceAnsw.saOther: SourcAnsw := TSourceAnsw.saNotAnsw;
          TSourceAnsw.saDoktor: SourcAnsw := TSourceAnsw.saNotApp;
        end;
      end
      else
      begin
        //SourcAnsw := SourceAnswerDefault;
      end;
    end;
    if TargetRect.TagObject is TMemoLabel then
    begin
      TempMemoLabel := TMemoLabel(TargetRect.TagObject);
      if not TempMemoLabel.chk.IsChecked then
      begin
        case SourceAnswerDefault of
          TSourceAnsw.saPatient: SourcAnsw := TSourceAnsw.saNotAnsw;
          TSourceAnsw.saOther: SourcAnsw := TSourceAnsw.saNotAnsw;
          TSourceAnsw.saDoktor: SourcAnsw := TSourceAnsw.saNotApp;
        end;
      end
      else
      begin
        //SourcAnsw := SourceAnswerDefault;
      end;
    end;
    if TargetRect.TagObject is TLayoutCheck then
    begin
      TempCheckLYT := TLayoutCheck(TargetRect.TagObject);
      if (TempCheckLYT.rctNull.Visible)  then
      begin
        case SourceAnswerDefault of
          TSourceAnsw.saPatient: SourcAnsw := TSourceAnsw.saNotAnsw;
          TSourceAnsw.saOther: SourcAnsw := TSourceAnsw.saNotAnsw;
          TSourceAnsw.saDoktor: SourcAnsw := TSourceAnsw.saNotApp;
        end;
      end
      else
      begin
        //SourcAnsw := SourceAnswerDefault;
      end;
    end;
    if TargetRect.TagObject is TDateEditLabel then
    begin
      TempDateEditLabel := TDateEditLabel(TargetRect.TagObject);
      if not TempDateEditLabel.chk.IsChecked then
      begin
        case SourceAnswerDefault of
          TSourceAnsw.saPatient: SourcAnsw := TSourceAnsw.saNotAnsw;
          TSourceAnsw.saOther: SourcAnsw := TSourceAnsw.saNotAnsw;
          TSourceAnsw.saDoktor: SourcAnsw := TSourceAnsw.saNotApp;
        end;
      end
      else
      begin
        //SourcAnsw := SourceAnswerDefault;
      end;
    end;
    if TargetRect.TagObject is TComboMultiLabel then
    begin
      TempComboMultiLabel := TComboMultiLabel(TargetRect.TagObject);
      if not TempComboMultiLabel.chk.IsChecked then
      begin
        case SourceAnswerDefault of
          TSourceAnsw.saPatient: SourcAnsw := TSourceAnsw.saNotAnsw;
          TSourceAnsw.saOther: SourcAnsw := TSourceAnsw.saNotAnsw;
          TSourceAnsw.saDoktor: SourcAnsw := TSourceAnsw.saNotApp;
        end;
      end
      else
      begin
        //SourcAnsw := SourceAnswerDefault;
      end;
    end;
    if TargetRect.TagObject is TEditLabel then
    begin
      TempEditLabel := TEditLabel(TargetRect.TagObject);
      if not TempEditLabel.chk.IsChecked then
      begin
        case SourceAnswerDefault of
          TSourceAnsw.saPatient: SourcAnsw := TSourceAnsw.saNotAnsw;
          TSourceAnsw.saOther: SourcAnsw := TSourceAnsw.saNotAnsw;
          TSourceAnsw.saDoktor: SourcAnsw := TSourceAnsw.saNotApp;
        end;
      end
      else
      begin
        //SourcAnsw := SourceAnswerDefault;
      end;
    end;
  end
  else
  begin
    if TargetRect.TagObject is TComboOneLabel then
    begin
      TempComboLabel := TComboOneLabel(TargetRect.TagObject);
      isRes := TempComboLabel.chk.IsChecked;
    end;
    if TargetRect.TagObject is TMemoLabel then
    begin
      TempMemoLabel := TMemoLabel(TargetRect.TagObject);
      isRes := TempMemoLabel.chk.IsChecked;
    end;
    if TargetRect.TagObject is TLayoutCheck then
    begin
      TempCheckLYT := TLayoutCheck(TargetRect.TagObject);
      isRes := not TempCheckLYT.rctNull.Visible;
    end;
    if TargetRect.TagObject is TDateEditLabel then
    begin
      TempDateEditLabel := TDateEditLabel(TargetRect.TagObject);
      isRes := TempDateEditLabel.chk.IsChecked;
    end;
    if TargetRect.TagObject is TComboMultiLabel then
    begin
      TempComboMultiLabel := TComboMultiLabel(TargetRect.TagObject);
      isRes := TempComboMultiLabel.chk.IsChecked;
    end;
    if TargetRect.TagObject is TEditLabel then
    begin
      TempEditLabel := TEditLabel(TargetRect.TagObject);
      isRes := TempEditLabel.chk.IsChecked;
    end;
  end;

  case SourcAnsw of
    TSourceAnsw.saNone: // няма локален
    begin
      case SourceAnswerDefault of
        TSourceAnsw.saNone:
        begin
          TargetRect.Fill.Kind := TBrushKind.None;
        end;
        TSourceAnsw.saPatient:
        begin
          if isRes then
          begin
            TargetRect.Fill.Assign(rctAnswPat.Fill);
          end
          else
          begin
            TargetRect.Fill.Assign(rctAnswNot.Fill); // няма локален/ дефолтния е пациент
          end;
        end;
        TSourceAnsw.saOther:
        begin
          if IsRes then
          begin
            TargetRect.Fill.Assign(rctAnswOther.Fill);
          end
          else
          begin
            TargetRect.Fill.Assign(rctAnswNot.Fill); // няма локален/ дефолтния е друг
          end;
        end;
        TSourceAnsw.saDoktor:
        begin
          if IsRes then
          begin
            TargetRect.Fill.Assign(rctAnswDoctor.Fill);
          end
          else
          begin
            TargetRect.Fill.Assign(rctAnswNotApplay.Fill);  // няма локален/ дефолтния е доктора
          end;
        end;
      end;
    end;
    TSourceAnsw.saPatient:
    begin
      TargetRect.Fill.Assign(rctAnswPat.Fill);
    end;
    TSourceAnsw.saOther:
    begin
      TargetRect.Fill.Assign(rctAnswOther.Fill);
    end;
    TSourceAnsw.saDoktor:
    begin
      TargetRect.Fill.Assign(rctAnswDoctor.Fill);
    end;
    TSourceAnsw.saNotApp:
    begin
      TargetRect.Fill.Assign(rctAnswNotApplay.Fill);
    end;
    TSourceAnsw.saNotAnsw:
    begin
      TargetRect.Fill.Assign(rctAnswNot.Fill);
    end;
  end;
end;

procedure TfrmProfFormFMX.Memo1DblClick(Sender: TObject);
var
  p3: TPointF;
begin
  scldlyt1.Repaint;
  p3 := Memo1.LocalToAbsolute(PointF(0,Memo1.Size.Height));
  scldlyt1.OriginalHeight := p3.Y ;
  scldlyt1.Height := (p3.Y) * FScaleDyn;
  rctBlanka.Height := p3.Y;
  rctBlanka.Repaint;
  //btn1.Text := FloatToStr(p3.Y - rctBlanka.Height);
end;

procedure TfrmProfFormFMX.Memo1Resize(Sender: TObject);
begin
  //
end;

procedure TfrmProfFormFMX.mmo1ChangeTracking(Sender: TObject);
begin
  TMemo(Sender).Height := TMemo(Sender).ContentBounds.Height + 5;
end;

procedure TfrmProfFormFMX.mmoAddresChangeTracking(Sender: TObject);
begin
  Exit;
  //if not TMemo(sender).IsFocused then Exit;
  TMemo(sender).Height := TMemo(sender).ContentBounds.Height + 5;
  lytTop.Height := TMemo(sender).Height + lblAddres.Height + 100;
end;

procedure TfrmProfFormFMX.mmoAddresChangeTracking1(Sender: TObject);
var
  h1: Single;
begin
  txtCalcMemo.MaxSize := PointF(TMemo(sender).Width -2, 100000);
  txtCalcMemo.Text := TMemo(sender).Text;
  TMemo(sender).Height := txtCalcMemo.Height + 5;
  //TMemo(sender).Height := TMemo(sender).ContentBounds.Height + 5;
  h1 := TMemo(sender).Position.Y + TMemo(sender).Height +30;
  lytTop.Height := xpdrPatient.Position.Y + h1 +0;
end;

procedure TfrmProfFormFMX.mmoAddresPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
 var
   data: PAspRec;
begin
  if mmoAddres.IsFocused then Exit;

  if patNodes.addresses.Count > 0 then
  begin
    data := Pointer(pbyte(patNodes.addresses[0]) + lenNode);
    if mmoAddres.Text <> FNasMesto.addresColl.GetFullAddres(data.DataPos) then
    begin
      mmoAddres.Text := FNasMesto.addresColl.GetFullAddres(data.DataPos);
    end;
  end
  else
  begin
    if mmoAddres.Text <> '' then
      mmoAddres.Text := '';
  end;

  //FPatient.
end;

procedure TfrmProfFormFMX.mmoCL132ChangeTracking(Sender: TObject);
var
  lytLeftHeight, lytRightHeight: Single;
  flwlyt: TFlowLayout;
  xpndr: TExpander;
  cntnt: TContent;
  HExpandHead: Single;
  //Delta: Single;
  TxtValidate: string;
begin
  txtCalcMemo.MaxSize := PointF(TMemo(Sender).Width - 5, 100000);
  txtCalcMemo.Text := TMemo(Sender).Text;
  TxtValidate := TMemo(Sender).Text;
  try
    mmoPregValidate(Sender, TxtValidate);
  except
    Exit;
  end;

  TMemo(Sender).Height := txtCalcMemo.Height + 5;
  if TMemo(Sender).Parent is TFlowLayout then
    flwlyt := TFlowLayout(TMemo(Sender).Parent);
  flwlyt.RecalcSize;
  flwlyt.Height := InnerChildrenRect(flwlyt).Height / scaleDyn + 15;
  if flwlyt.Parent is TContent then
  begin
    if flwlyt.Parent.Parent is TExpander then
    begin
      xpndr := TExpander(flwlyt.Parent.parent);
      HExpandHead := 55;
    end;
  end
  else
  if flwlyt.Parent is TRectangle then
  begin
    if flwlyt.Parent.Parent.Parent is TExpander then
    begin
      xpndr := TExpander(flwlyt.Parent.parent.Parent);
      HExpandHead := 35
    end;
  end;

  xpndr.Height := (flwlyt.Height  + HExpandHead + 10);
  flwlytVizitFor.RecalcSize;
  flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height / scaleDyn + 15;

  RecalcBlankaRect1;
  SetExpanderVisitForHeight;

  //btn1.Text := FloatToStr(scldlyt1.Position.Y);
end;

procedure TfrmProfFormFMX.mmoCL132ChangeTrackingSup(Sender: TObject);
var
  lytLeftHeight, lytRightHeight: Single;
  flwlyt: TFlowLayout;
  xpndr: TExpander;
  cntnt: TContent;
  HExpandHead: Single;
  //Delta: Single;
  TxtValidate: string;
  vScrol: TScrollBar;
begin
  flwlyt := nil;
  txtCalcMemo.MaxSize := PointF(TMemo(Sender).Width - 5, 100000);
  txtCalcMemo.Text := TMemo(Sender).Lines.Text;
  TxtValidate := TMemo(Sender).Lines.Text;
  try
    mmoPregValidateSup(Sender, TxtValidate);
  except
    Exit;
  end;

  TLayout(TMemo(Sender).parent).Height := txtCalcMemo.Height + 5 + 25;
  if TLayout(Sender).Parent.Parent is TFlowLayout then
    flwlyt := TFlowLayout(TMemo(Sender).Parent.Parent);
  if not Assigned(flwlyt) then Exit;

  flwlyt.RecalcSize;
  flwlyt.Height := InnerChildrenRect(flwlyt).Height / scaleDyn + 15;
  if flwlyt.Parent is TContent then
  begin
    if flwlyt.Parent.Parent is TExpander then
    begin
      xpndr := TExpander(flwlyt.Parent.parent);
      HExpandHead := 55;
    end;
  end
  else
  if flwlyt.Parent is TRectangle then
  begin
    if flwlyt.Parent.Parent.Parent is TExpander then
    begin
      xpndr := TExpander(flwlyt.Parent.parent.Parent);
      HExpandHead := 35
    end;
  end;
  xpndr.Height := (flwlyt.Height  + HExpandHead + 10);
  flwlytVizitFor.RecalcSize;
  flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height / scaleDyn + 15;
  SetExpanderVisitForHeight;
  RecalcBlankaRect1;
  //scrlbx1.FindStyleResource<TScrollBar>('vscrollbar', vScrol);
//  vScrol.Value := vScrol.Value + 20 * scaleDyn;

  //btn1.Text := FloatToStr(scldlyt1.Position.Y);
end;



procedure TfrmProfFormFMX.mmoDiagMouseEnter(Sender: TObject);
var
  r: TRect;
  rf: TRectF;
begin
    rf := mmoDiag.AbsoluteRect;
    rf.TopLeft := Self.ClientToScreen(rf.TopLeft);
    rf.BottomRight := Self.ClientToScreen(rf.BottomRight);
    r.Left := Round(rf.Left);
    r.Right := Round(rf.Right);
    r.Top := Round(rf.Top);
    r.Bottom := Round(rf.Bottom);
  if Assigned(FOnSowHint) then
    FOnSowHint(Sender, 'dddddddd', r);
end;

procedure TfrmProfFormFMX.mmoDynEnter(Sender: TObject);
begin
  TMemo(Sender).Position.Point := PointF(TMemo(Sender).Position.Point.x + 2, TMemo(Sender).Position.Point.y);
  TMemo(Sender).Position.Point := PointF(TMemo(Sender).Position.Point.x - 2, TMemo(Sender).Position.Point.y);
end;

procedure TfrmProfFormFMX.mmoPregValidate(Sender: TObject; var Text: string);
var
  TempMemo: TMemo;
  TempMemoLabel: TMemoLabel;
  AnswValue: TRealNZIS_ANSWER_VALUEItem;
  data, dataAnswVal: PAspRec;
  linkPos, cl134Pos: Cardinal;
  cl134Key: string;
  i: Integer;
  ResDiagRep: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
  dataResDiagRep: PAspRec;
  cl144Pos: Cardinal;
begin
  TempMemo := TMemo(Sender);
  if not TempMemo.IsFocused then Exit;

  TempMemoLabel := TMemoLabel(TempMemo.TagObject);
  if not TempMemoLabel.canValidate then Exit;
  if TempMemoLabel.node = nil then exit;

  if FIsVtrPregled then
  begin
    data := Pointer(PByte(TempMemoLabel.node) + lenNode);
    if Text = '' then
    begin
      VtrPregLink.BeginUpdate;
      if TempMemoLabel.chk <> nil then
      begin
        //TempMemoLabel.chk.IsNull := True;
      end;
      VtrPregLink.CheckType[TempMemoLabel.node] := ctNone;
      if TempMemoLabel.node.FirstChild <> nil then
        FAspLink.MarkDeletedNode(TempMemoLabel.node.FirstChild);
      VtrPregLink.endUpdate;
    end
    else
    begin
      if TempMemoLabel.chk <> nil then
      begin
        //TempMemoLabel.chk.IsNull := false;
        TempMemoLabel.chk.IsChecked := True;
      end;
      VtrPregLink.CheckType[TempMemoLabel.node] := ctCheckBox;
      VtrPregLink.CheckState[TempMemoLabel.node] := csCheckedNormal;

      if TempMemoLabel.node.FirstChild = nil then
      begin
        case data.vid of
          vvNZIS_QUESTIONNAIRE_ANSWER:
          begin
            answTemp.DataPos := Data.DataPos;
            cl134Pos := answTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS));
            cl134Temp.DataPos := cl134Pos;
            answTemp.cl028 := StrToInt(cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL134_CL028)));
            AnswValue := TRealNZIS_ANSWER_VALUEItem(Adb_dm.CollNZIS_ANSWER_VALUE.Add);
            Memo1.Text := IntToStr(Adb_dm.CollNZIS_ANSWER_VALUE.Count) + '(Adb_dm.CollNZIS_ANSWER_VALUE.Add)' ;
            New(AnswValue.PRecord);
            case answTemp.cl028 of
              3: //Количествено представяне
              begin
                AnswValue.PRecord.ANSWER_TEXT := text;
                AnswValue.PRecord.ID := 0;
                AnswValue.PRecord.QUESTIONNAIRE_ANSWER_ID := 0;
                AnswValue.PRecord.CL028 := 3;

                AnswValue.PRecord.setProp :=
                [NZIS_ANSWER_VALUE_ANSWER_TEXT
                , NZIS_ANSWER_VALUE_ID
                , NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID
                , NZIS_ANSWER_VALUE_CL028];

                AnswValue.InsertNZIS_ANSWER_VALUE;
                Dispose(AnswValue.PRecord);
                AnswValue.PRecord := nil;
              end;
            end;
            FAspLink.AddNewNode(vvNZIS_ANSWER_VALUE, AnswValue.DataPos, TempMemoLabel.node, amAddChildLast, TempMemoLabel.nodeValue, linkpos);
            dataAnswVal := Pointer(PByte(TempMemoLabel.node.FirstChild) + lenNode);
            dataAnswVal.index := Adb_dm.CollNZIS_ANSWER_VALUE.Count - 1;
          end;
          vvNZIS_RESULT_DIAGNOSTIC_REPORT:
          begin
            ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Add);
            ResDiagRep.DataPos := Data.DataPos;
            cl144Pos := ResDiagRep.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
            cl144Temp.DataPos := cl144Pos;
            ResDiagRep.cl028 := StrToInt(cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL144_CL028)));
            New(ResDiagRep.PRecord);
            case ResDiagRep.cl028 of
              3: //опис
              begin
                ResDiagRep.PRecord.VALUE_STRING := text;
                ResDiagRep.PRecord.ID := 0;
                ResDiagRep.PRecord.DIAGNOSTIC_REPORT_ID := 0;
                ResDiagRep.PRecord.CL028_VALUE_SCALE := 3;

                ResDiagRep.PRecord.setProp :=
                [NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING
                , NZIS_RESULT_DIAGNOSTIC_REPORT_ID
                , NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID
                , NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE];

                ResDiagRep.InsertNZIS_RESULT_DIAGNOSTIC_REPORT;
                Dispose(ResDiagRep.PRecord);
                ResDiagRep.PRecord := nil;
              end;
            end;
            FAspLink.AddNewNode(vvNZIS_RESULT_DIAGNOSTIC_REPORT, ResDiagRep.DataPos, TempMemoLabel.node, amAddChildLast, TempMemoLabel.nodeValue, linkpos);
            dataResDiagRep := Pointer(PByte(TempMemoLabel.node.FirstChild) + lenNode);
            dataResDiagRep.index := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Count - 1;
          end;
        end;
      end
      else
      begin
        case data.vid of
          vvNZIS_QUESTIONNAIRE_ANSWER:
          begin
            answTemp.DataPos := Data.DataPos;
            dataAnswVal := Pointer(PByte(TempMemoLabel.node.FirstChild) + lenNode);
            if dataAnswVal.index >= 0 then
            begin
              AnswValue := Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index];
              if AnswValue.PRecord <> nil then
              begin
                case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                  3:
                  begin
                    AnswValue.PRecord.setProp := [];
                    AnswValue.PRecord.ANSWER_TEXT := text;
                    Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_TEXT);
                  end;
                end;
              end
              else
              begin
                New(AnswValue.PRecord);
                case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                  3:
                  begin
                    AnswValue.PRecord.setProp := [];
                    AnswValue.PRecord.ANSWER_TEXT := Text;
                    Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_TEXT);
                  end;
                end;
              end;
            end
            else
            begin
              AnswValue := TRealNZIS_ANSWER_VALUEItem(Adb_dm.CollNZIS_ANSWER_VALUE.Add);
              Memo1.Text := IntToStr(Adb_dm.CollNZIS_ANSWER_VALUE.Count) + '(Adb_dm.CollNZIS_ANSWER_VALUE.Add)' ;
              AnswValue.DataPos := dataAnswVal.DataPos;
              dataAnswVal.index := Adb_dm.CollNZIS_ANSWER_VALUE.Count - 1;
              New(AnswValue.PRecord);
              case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                3:
                begin
                  AnswValue.PRecord.setProp := [];
                  AnswValue.PRecord.ANSWER_TEXT := text;
                  Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_TEXT);
                end;
              end;
            end;
          end;
          vvNZIS_RESULT_DIAGNOSTIC_REPORT:
          begin
            RESULT_DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
            dataResDiagRep := Pointer(PByte(TempMemoLabel.node.FirstChild) + lenNode);
            if dataResDiagRep.index >= 0 then
            begin
              ResDiagRep := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiagRep.index];
              if ResDiagRep.PRecord <> nil then
              begin
                case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                  3:
                  begin
                    ResDiagRep.PRecord.setProp := [];
                    ResDiagRep.PRecord.VALUE_STRING := text;
                    Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING);
                  end;
                end;
              end
              else
              begin
                New(ResDiagRep.PRecord);
                case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                  3:
                  begin
                    ResDiagRep.PRecord.setProp := [];
                    ResDiagRep.PRecord.VALUE_STRING := text;
                    Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING);
                  end;
                end;
              end;
            end
            else
            begin
              ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Add);
              ResDiagRep.DataPos := dataResDiagRep.DataPos;
              dataResDiagRep.index := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Count - 1;
              New(ResDiagRep.PRecord);
              case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                3:
                begin
                  ResDiagRep.PRecord.setProp := [];
                  ResDiagRep.PRecord.VALUE_STRING := text;
                  Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
   // VtrPregLink.Selected[TempEditLabel.node] := True;
    //FAspLink.FVTR.RepaintNode(TempMemoLabel.node.FirstChild);
  end;
end;

procedure TfrmProfFormFMX.mmoPregValidateSup(Sender: TObject; var Text: string);
var
  TempMemo: TMemo;
  TempMemoLabel: TMemoLabel;
  AnswValue: TRealNZIS_ANSWER_VALUEItem;
  data, dataAnswVal: PAspRec;
  linkPos, cl134Pos: Cardinal;
  cl134Key: string;
  i: Integer;
  ResDiagRep: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
  diagRep: TRealDiagnosticReportItem;
  dataResDiagRep: PAspRec;
  cl144Pos, cl142Pos: Cardinal;
begin
  TempMemo := TMemo(Sender);
  if not TempMemo.IsFocused then Exit;

  TempMemoLabel := TMemoLabel(TempMemo.Parent.TagObject);
  if not TempMemoLabel.canValidate then Exit;
  if TempMemoLabel.node = nil then exit;

  if FIsVtrPregled then
  begin
    data := Pointer(PByte(TempMemoLabel.node) + lenNode);
    if Text = '' then
    begin
      VtrPregLink.BeginUpdate;
      TempMemoLabel.rctNull.Visible := True;
      TempMemoLabel.chk.IsChecked := false;
      VtrPregLink.CheckType[TempMemoLabel.node] := ctNone;
      if TempMemoLabel.node.FirstChild <> nil then
        FAspLink.MarkDeletedNode(TempMemoLabel.node.FirstChild);
      VtrPregLink.endUpdate;
      MarkSourceAnsw(TempMemoLabel.SourceAnsw, TempMemoLabel.rctSourceAnsw);
    end
    else
    begin
      if TempMemoLabel.chk <> nil then
      begin
        TempMemoLabel.rctNull.Visible := false;
        TempMemoLabel.chk.IsChecked := True;
      end;
      VtrPregLink.CheckType[TempMemoLabel.node] := ctCheckBox;
      VtrPregLink.CheckState[TempMemoLabel.node] := csCheckedNormal;

      if TempMemoLabel.node.FirstChild = nil then
      begin
        case data.vid of
          vvNZIS_QUESTIONNAIRE_ANSWER:
          begin
            answTemp.DataPos := Data.DataPos;
            cl134Pos := answTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS));
            cl134Temp.DataPos := cl134Pos;
            answTemp.cl028 := StrToInt(cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL134_CL028)));
            AnswValue := TRealNZIS_ANSWER_VALUEItem(Adb_dm.CollNZIS_ANSWER_VALUE.Add);
            Memo1.Text := IntToStr(Adb_dm.CollNZIS_ANSWER_VALUE.Count) + '(Adb_dm.CollNZIS_ANSWER_VALUE.Add)' ;
            New(AnswValue.PRecord);
            case answTemp.cl028 of
              3: //opis
              begin
                AnswValue.PRecord.ANSWER_TEXT := text;
                AnswValue.PRecord.ID := 0;
                AnswValue.PRecord.QUESTIONNAIRE_ANSWER_ID := 0;
                AnswValue.PRecord.CL028 := 3;

                AnswValue.PRecord.setProp :=
                [NZIS_ANSWER_VALUE_ANSWER_TEXT
                , NZIS_ANSWER_VALUE_ID
                , NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID
                , NZIS_ANSWER_VALUE_CL028];

                AnswValue.InsertNZIS_ANSWER_VALUE;

                Dispose(AnswValue.PRecord);
                AnswValue.PRecord := nil;
              end;
            end;
            FAspLink.AddNewNode(vvNZIS_ANSWER_VALUE, AnswValue.DataPos, TempMemoLabel.node, amAddChildLast, TempMemoLabel.nodeValue, linkpos);
            dataAnswVal := Pointer(PByte(TempMemoLabel.node.FirstChild) + lenNode);
            dataAnswVal.index := Adb_dm.CollNZIS_ANSWER_VALUE.Count - 1;
            MarkSourceAnsw(TempMemoLabel.SourceAnsw, TempMemoLabel.rctSourceAnsw);
          end;
          vvNZIS_RESULT_DIAGNOSTIC_REPORT:
          begin
            ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Add);
            ResDiagRep.DataPos := Data.DataPos;
            cl144Pos := ResDiagRep.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
            cl144Temp.DataPos := cl144Pos;
            ResDiagRep.cl028 := StrToInt(cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL144_CL028)));
            New(ResDiagRep.PRecord);
            case ResDiagRep.cl028 of
              3: //опис
              begin
                ResDiagRep.PRecord.VALUE_STRING := text;
                ResDiagRep.PRecord.ID := 0;
                ResDiagRep.PRecord.DIAGNOSTIC_REPORT_ID := 0;
                ResDiagRep.PRecord.CL028_VALUE_SCALE := 3;

                ResDiagRep.PRecord.setProp :=
                [NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING
                , NZIS_RESULT_DIAGNOSTIC_REPORT_ID
                , NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID
                , NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE];

                ResDiagRep.InsertNZIS_RESULT_DIAGNOSTIC_REPORT;
                Dispose(ResDiagRep.PRecord);
                ResDiagRep.PRecord := nil;
              end;
            end;
            FAspLink.AddNewNode(vvNZIS_RESULT_DIAGNOSTIC_REPORT, ResDiagRep.DataPos, TempMemoLabel.node, amAddChildLast, TempMemoLabel.nodeValue, linkpos);
            dataResDiagRep := Pointer(PByte(TempMemoLabel.node.FirstChild) + lenNode);
            dataResDiagRep.index := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Count - 1;
          end;
          vvNZIS_DIAGNOSTIC_REPORT:
          begin
            ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Add);
            DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
            cl142Pos := DIAGNOSTIC_REPTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_DIAGNOSTIC_REPORT_NOMEN_POS));
            for i := 0 to Adb_dm.Cl144Coll.Count - 1 do
            begin
              if Adb_dm.Cl144Coll.Items[i].getAnsiStringMap(AspNomenBuf, AspNomenPosData, word(CL144_cl142)) =
                 Adb_dm.Cl142Coll.getAnsiStringMap(cl142Pos, word(CL142_Key)) then
              begin
                cl144Pos := Adb_dm.Cl144Coll.Items[i].DataPos;
                Break;
              end;
            end;

            ResDiagRep.cl028 := 3;// StrToInt(cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, Word(CL144_CL028)));
            New(ResDiagRep.PRecord);
            case ResDiagRep.cl028 of
              3: //опис
              begin
                ResDiagRep.PRecord.VALUE_STRING := text;
                ResDiagRep.PRecord.ID := 0;
                ResDiagRep.PRecord.DIAGNOSTIC_REPORT_ID := 0;
                ResDiagRep.PRecord.CL028_VALUE_SCALE := 3;
                ResDiagRep.PRecord.NOMEN_POS := cl144Pos;

                ResDiagRep.PRecord.setProp :=
                [NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING
                , NZIS_RESULT_DIAGNOSTIC_REPORT_ID
                , NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID
                , NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE
                , NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS];

                ResDiagRep.InsertNZIS_RESULT_DIAGNOSTIC_REPORT;
                Dispose(ResDiagRep.PRecord);
                ResDiagRep.PRecord := nil;
              end;
            end;
            FAspLink.AddNewNode(vvNZIS_RESULT_DIAGNOSTIC_REPORT, ResDiagRep.DataPos, TempMemoLabel.node, amAddChildLast, TempMemoLabel.nodeValue, linkpos);
            dataResDiagRep := Pointer(PByte(TempMemoLabel.node.FirstChild) + lenNode);
            dataResDiagRep.index := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Count - 1;
          end;
        end;
      end
      else  // има детенце
      begin
        case data.vid of
          vvNZIS_QUESTIONNAIRE_ANSWER:
          begin
            answTemp.DataPos := Data.DataPos;
            dataAnswVal := Pointer(PByte(TempMemoLabel.node.FirstChild) + lenNode);
            if dataAnswVal.index >= 0 then
            begin
              AnswValue := Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index];
              if AnswValue.PRecord <> nil then
              begin
                case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                  3:
                  begin
                    AnswValue.PRecord.setProp := [];
                    AnswValue.PRecord.ANSWER_TEXT := text;
                    Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_TEXT);
                  end;
                end;
              end
              else
              begin
                New(AnswValue.PRecord);
                case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                  3:
                  begin
                    AnswValue.PRecord.setProp := [];
                    AnswValue.PRecord.ANSWER_TEXT := Text;
                    Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_TEXT);
                  end;
                end;
              end;
            end
            else
            begin
              AnswValue := TRealNZIS_ANSWER_VALUEItem(Adb_dm.CollNZIS_ANSWER_VALUE.Add);
              Memo1.Text := IntToStr(Adb_dm.CollNZIS_ANSWER_VALUE.Count) + '(Adb_dm.CollNZIS_ANSWER_VALUE.Add)' ;
              AnswValue.DataPos := dataAnswVal.DataPos;
              dataAnswVal.index := Adb_dm.CollNZIS_ANSWER_VALUE.Count - 1;
              New(AnswValue.PRecord);
              case AnswValue.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
                3:
                begin
                  AnswValue.PRecord.setProp := [];
                  AnswValue.PRecord.ANSWER_TEXT := text;
                  Include(AnswValue.PRecord.setProp, NZIS_ANSWER_VALUE_ANSWER_TEXT);
                end;
              end;
            end;
            MarkSourceAnsw(TempMemoLabel.SourceAnsw, TempMemoLabel.rctSourceAnsw);
          end;
          vvNZIS_RESULT_DIAGNOSTIC_REPORT:
          begin
            RESULT_DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
            dataResDiagRep := Pointer(PByte(TempMemoLabel.node.FirstChild) + lenNode);
            if dataResDiagRep.index >= 0 then
            begin
              ResDiagRep := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiagRep.index];
              if ResDiagRep.PRecord <> nil then
              begin
                case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                  3:
                  begin
                    ResDiagRep.PRecord.setProp := [];
                    ResDiagRep.PRecord.VALUE_STRING := text;
                    Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING);
                  end;
                end;
              end
              else
              begin
                New(ResDiagRep.PRecord);
                case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                  3:
                  begin
                    ResDiagRep.PRecord.setProp := [];
                    ResDiagRep.PRecord.VALUE_STRING := text;
                    Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING);
                  end;
                end;
              end;
            end
            else
            begin
              ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Add);
              ResDiagRep.DataPos := dataResDiagRep.DataPos;
              dataResDiagRep.index := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Count - 1;
              New(ResDiagRep.PRecord);
              case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                3:
                begin
                  ResDiagRep.PRecord.setProp := [];
                  ResDiagRep.PRecord.VALUE_STRING := text;
                  Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING);
                end;
              end;
            end;
          end;
          vvNZIS_DIAGNOSTIC_REPORT:
          begin
            DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
            dataResDiagRep := Pointer(PByte(TempMemoLabel.node.FirstChild) + lenNode);
            if dataResDiagRep.index >= 0 then
            begin
              ResDiagRep := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiagRep.index];
              if ResDiagRep.PRecord <> nil then
              begin
                case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                  3:
                  begin
                    ResDiagRep.PRecord.setProp := [];
                    ResDiagRep.PRecord.VALUE_STRING := text;
                    Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING);
                  end;
                end;
              end
              else
              begin
                New(ResDiagRep.PRecord);
                case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                  3:
                  begin
                    ResDiagRep.PRecord.setProp := [];
                    ResDiagRep.PRecord.VALUE_STRING := text;
                    Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING);
                  end;
                end;
              end;
            end
            else
            begin
              ResDiagRep := TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem(Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Add);
              ResDiagRep.DataPos := dataResDiagRep.DataPos;
              dataResDiagRep.index := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Count - 1;
              New(ResDiagRep.PRecord);
              case ResDiagRep.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
                3:
                begin
                  ResDiagRep.PRecord.setProp := [];
                  ResDiagRep.PRecord.VALUE_STRING := text;
                  Include(ResDiagRep.PRecord.setProp, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
   // VtrPregLink.Selected[TempEditLabel.node] := True;
    //FAspLink.FVTR.RepaintNode(TempMemoLabel.node.FirstChild);
  end;
end;

procedure TfrmProfFormFMX.mniL009Click(Sender: TObject);
begin
  if Assigned(FOnGetPlanedTypeL009) then
  begin
    FOnGetPlanedTypeL009(FPregled);
  end;
end;

procedure TfrmProfFormFMX.mniX013Click(Sender: TObject);
var
  data: PAspRec;
begin
  if Assigned(FOnOfLinePregled) then
  begin
    data := Pointer(PByte(linkPreg) + lenNode);
    Adb_dm.CollPregled.SetWordMap(data.DataPos, word(PregledNew_NZIS_STATUS),13);
    FOnOfLinePregled(FPregled);
  end;
end;

procedure TfrmProfFormFMX.OnApplicationHint(Sender: TObject);
var
  ctrl: IControl;
  c: TControl;
  rf: TRectF;
  r: TRect;
begin
  ctrl := ObjectAtPoint(Screen.MousePos);
  if Assigned(ctrl) and  (ctrl.GetObject is TControl) then
  begin
    c := TControl(ctrl.GetObject);
    rf := c.AbsoluteRect;
    rf.TopLeft := Self.ClientToScreen(rf.TopLeft);
    rf.BottomRight := Self.ClientToScreen(rf.BottomRight);
    r.Left := Round(rf.Left);
    r.Right := Round(rf.Right);
    r.Top := Round(rf.Top);
    r.Bottom := Round(rf.Bottom);

    if Assigned(FOnSowHint) then
      if not c.ClassName.StartsWith('tstyled', True) then
      begin
        FOnSowHint(c, c.Hint, r);
      end
      else
      begin
        case c.ClassName[8] of
          'E': // TStyledEdit
          FOnSowHint(c.Parent, TEdit(c.parent).Hint, r);
        end;

      end;
  end
  else
  begin
    if Assigned(FOnSowHint) then
      FOnSowHint(nil, '', r);
  end;


end;

procedure TfrmProfFormFMX.mmoPregPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  mmo: TMemo;
  ParamSetProp: TParamSetProp;
  paramField: TParamProp;
  ArrStr: TArray<string>;
  TempMemoLabel: TMemoLabel;
  str: string;
begin
  mmo := TMemo(sender);
  if mmo.IsFocused then Exit;

  TempMemoLabel:= TMemoLabel(mmo.TagObject);
  str := Pregled.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, TempMemoLabel.field);
  mmo.Lines.Text := str;
end;

procedure TfrmProfFormFMX.mmoPregPaintingSup(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  mmo: TMemo;
  ParamSetProp: TParamSetProp;
  paramField: TParamProp;
  ArrStr: TArray<string>;
  TempMemoLabel: TMemoLabel;
  str: string;
  propPreg: TPregledNewItem.TPropertyIndex;
begin

  mmo := TMemo(sender);
  if mmo.IsFocused then Exit;

  TempMemoLabel:= TMemoLabel(mmo.Parent.TagObject);
  if FPregled.PRecord = nil then
  begin
    str := FPregled.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, TempMemoLabel.field);
  end
  else
  begin
    propPreg := TPregledNewItem.TPropertyIndex(TempMemoLabel.field);
    if propPreg in FPregled.PRecord.setProp then
    begin
      case propPreg of
        PregledNew_ANAMN: str := FPregled.PRecord.ANAMN;
      end;
    end
    else
    begin
      str := FPregled.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, TempMemoLabel.field);
    end;
  end;
  TempMemoLabel.canValidate := False;
  mmo.Text := str;
  if mmo.Text = '' then
  begin
    TempMemoLabel.rctNull.Visible := True;
    TempMemoLabel.chk.IsChecked := false;
  end
  else
  begin
    TempMemoLabel.rctNull.Visible := false;
    TempMemoLabel.chk.IsChecked := true;
  end;
  TempMemoLabel.canValidate := true;
end;

procedure TfrmProfFormFMX.mmoPregADBValidateSup(Sender: TObject;
  var Text: string);
var
  TempMemo: TMemo;
  TempMemoLabel: TMemoLabel;
  AnswValue: TRealNZIS_ANSWER_VALUEItem;
  data, dataAnswVal: PAspRec;
  linkPos, cl134Pos: Cardinal;
  cl134Key: string;
  i: Integer;
  ResDiagRep: TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem;
  dataResDiagRep: PAspRec;
  cl144Pos: Cardinal;
  propPreg: TPregledNewItem.TPropertyIndex;
begin
  TempMemo := TMemo(Sender);
  if not TempMemo.IsFocused then Exit;

  TempMemoLabel := TMemoLabel(TempMemo.Parent.TagObject);
  if not TempMemoLabel.canValidate then Exit;
  if TempMemoLabel.node = nil then exit;

  if FIsVtrPregled then
  begin
    data := Pointer(PByte(TempMemoLabel.node) + lenNode);
    case data.vid of
      vvPregled:
      begin
        if FPregled.PRecord = nil then
        begin
          New(FPregled.PRecord);
          FPregled.PRecord.setProp := [];
        end ;
        propPreg := TPregledNewItem.TPropertyIndex(TempMemoLabel.field);
        Include(FPregled.PRecord.setProp, propPreg);
        case proppreg of
          PregledNew_ANAMN:
          begin
            FPregled.PRecord.ANAMN := Text;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmProfFormFMX.mmoPregChangeTracking(Sender: TObject);
var
  lytLeftHeight, lytRightHeight: Single;
  flwlyt: TFlowLayout;
  xpndr: TExpander;
  cntnt: TContent;
  HExpandHead: Single;
  //Delta: Single;
begin
  if not TMemo(Sender).IsFocused then Exit;
  txtCalcMemo.MaxSize := PointF(TMemo(Sender).Width - 5, 100000);
  txtCalcMemo.Text := TMemo(Sender).Text;
  //Delta := ((txtCalcMemo.Height + 5) - TMemo(Sender).Height);

  TMemo(Sender).Height := txtCalcMemo.TextHeight + 5;
  RecalcBlankaRect1;
end;


procedure TfrmProfFormFMX.mmoPregChangeTrackingSup(Sender: TObject);
var
  lyt: TLayout;
  TxtValidate: string;
begin
  //if not TMemo(Sender).IsFocused then Exit;
  lyt := TLayout(TMemo(Sender).Parent);
  txtCalcMemo.MaxSize := PointF(TMemo(Sender).Width - 5, 100000);
  txtCalcMemo.Text := TMemo(Sender).Text;
  TxtValidate := TMemo(Sender).Text;
  try
    mmoPregADBValidateSup(Sender, TxtValidate);
  except
    Exit;
  end;

  lyt.Height := txtCalcMemo.TextHeight + 5 + 25;
  lytRight.RecalcSize;
  lytRight.Height := InnerChildrenRect(lytRight).Height/FScaleDyn + 20;

  //RecalcBlankaRect1;
end;

procedure TfrmProfFormFMX.mmoPregCl132Painting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  TempMemoLabel: TMemoLabel;
  node: PVirtualNode;
  data, dataAnswVal, dataResDiag: PAspRec;
  vid: TVtrVid;
  str: string;
begin
  if TMemo(Sender).IsFocused then Exit;
  TempMemoLabel := TMemoLabel(TMemo(sender).TagObject);
  node := TempMemoLabel.node;
  if FIsVtrPregled then
  begin
    data := pointer(PByte(node) + lenNode);
  end
  else
  begin
    data := VtrGrapf.GetNodeData(node);
  end;
  case data.vid of
    vvNZIS_QUESTIONNAIRE_ANSWER:
    begin
      answTemp.DataPos := Data.DataPos;
      if node.FirstChild <> nil then
      begin
        //TempMemoLabel.chk.IsNull := False;
        TempMemoLabel.chk.IsChecked := True;
        dataAnswVal := Pointer(PByte(node.FirstChild) + lenNode);
        if dataAnswVal.index < 0 then
        begin
          answValTemp.DataPos := dataAnswVal.DataPos;
          TempMemoLabel.canValidate := False;
          TMemo(sender).Text := answValTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_TEXT));
          TempMemoLabel.canValidate := True;
        end
        else
        begin
          answValTemp.DataPos := Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].DataPos;
          if Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].PRecord = nil then
          begin
            TempMemoLabel.canValidate := False;
            TMemo(sender).Text := answValTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_TEXT));
            TempMemoLabel.canValidate := True;
          end
          else
          begin
            case answValTemp.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
              3:
              begin
                TempMemoLabel.canValidate := False;
                tedit(sender).Text := Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].PRecord.ANSWER_TEXT;
                TempMemoLabel.canValidate := True;
              end;
            end;

          end;
        end;
      end
      else
      begin
        //TempMemoLabel.chk.IsNull := true;
        TempMemoLabel.canValidate := False;
        TMemo(sender).Text := '';
        TempMemoLabel.canValidate := True;
      end;
    end;
    vvNZIS_RESULT_DIAGNOSTIC_REPORT:
    begin
      DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
      if node.FirstChild <> nil then
      begin
        //TempMemoLabel.chk.IsNull := False;
        TempMemoLabel.chk.IsChecked := True;
        dataResDiag := Pointer(PByte(node.FirstChild) + lenNode);
        if dataResDiag.index < 0 then
        begin
          DIAGNOSTIC_REPTemp.DataPos := dataResDiag.DataPos;
          TempMemoLabel.canValidate := False;
          TMemo(sender).Text := DIAGNOSTIC_REPTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING));
          TempMemoLabel.canValidate := True;
        end
        else
        begin
          dataResDiag.DataPos := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].DataPos;
          if Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].PRecord = nil then
          begin
            TempMemoLabel.canValidate := False;
            TMemo(sender).Text := DIAGNOSTIC_REPTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING));
            TempMemoLabel.canValidate := True;
          end
          else
          begin
            case DIAGNOSTIC_REPTemp.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
              3:
              begin
                TempMemoLabel.canValidate := False;
                TMemo(sender).Text := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].PRecord.VALUE_STRING;
                TempMemoLabel.canValidate := True;
              end;
            end;

          end;
        end;
      end
      else
      begin
        //TempMemoLabel.chk.IsNull := true;
        TempMemoLabel.canValidate := False;
        TMemo(sender).Text := '';
        TempMemoLabel.canValidate := True;
      end;
    end;
  else
    begin
      Caption := 'ddd';
    end;
  end

end;

procedure TfrmProfFormFMX.mmoPregCl132PaintingSup(Sender: TObject;
  Canvas: TCanvas; const ARect: TRectF);
var
  TempMemoLabel: TMemoLabel;
  node: PVirtualNode;
  data, dataAnswVal, dataResDiag: PAspRec;
  vid: TVtrVid;
  str: string;
begin
  if TMemo(Sender).IsFocused then Exit;
  TempMemoLabel := TMemoLabel(TMemo(sender).parent.TagObject);
  node := TempMemoLabel.node;
  if FIsVtrPregled then
  begin
    data := pointer(PByte(node) + lenNode);
  end
  else
  begin
    data := VtrGrapf.GetNodeData(node);
  end;
  case data.vid of
    vvNZIS_QUESTIONNAIRE_ANSWER:
    begin
      answTemp.DataPos := Data.DataPos;
      if node.FirstChild <> nil then // ima
      begin
        TempMemoLabel.rctNull.Visible := False;
        TempMemoLabel.chk.IsChecked := True;
        dataAnswVal := Pointer(PByte(node.FirstChild) + lenNode);
        if dataAnswVal.index < 0 then
        begin
          try
            answValTemp.DataPos := dataAnswVal.DataPos;
            //if TMemo(sender).Text <> answValTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_TEXT)) then
            begin
              TempMemoLabel.canValidate := False;
              TMemo(sender).Text := answValTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_TEXT));
              TempMemoLabel.canValidate := True;
            end;
          except
            Caption :=  ';';
          end;
        end
        else
        begin
          answValTemp.DataPos := Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].DataPos;
          if Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].PRecord = nil then
          begin
            TempMemoLabel.canValidate := False;
            TMemo(sender).Text := answValTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_ANSWER_TEXT));
            TempMemoLabel.canValidate := True;
          end
          else
          begin
            case answValTemp.getWordMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_ANSWER_VALUE_CL028)) of
              3:
              begin
                TempMemoLabel.canValidate := False;
                TMemo(sender).Text := Adb_dm.CollNZIS_ANSWER_VALUE.Items[dataAnswVal.index].PRecord.ANSWER_TEXT;
                TempMemoLabel.canValidate := True;
              end;
            end;

          end;
        end;
      end
      else
      begin
        //TempMemoLabel.chk.IsNull := true;
        TempMemoLabel.canValidate := False;
        TMemo(sender).Text := '';
        TempMemoLabel.canValidate := True;
      end;
      MarkSourceAnsw(TempMemoLabel.SourceAnsw, TempMemoLabel.rctSourceAnsw);
    end;
    vvNZIS_DIAGNOSTIC_REPORT:
    begin
      DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
      if node.FirstChild <> nil then
      begin
        TempMemoLabel.rctNull.Visible := False;
        TempMemoLabel.chk.IsChecked := True;
        dataResDiag := Pointer(PByte(node.FirstChild) + lenNode);
        if dataResDiag.index < 0 then
        begin
          DIAGNOSTIC_REPTemp.DataPos := dataResDiag.DataPos;
          TempMemoLabel.canValidate := False;
          TMemo(sender).Text := DIAGNOSTIC_REPTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING));
          TempMemoLabel.canValidate := True;
        end
        else
        begin
          dataResDiag.DataPos := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].DataPos;
          if Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].PRecord = nil then
          begin
            TempMemoLabel.canValidate := False;
            TMemo(sender).Text := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(dataResDiag.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING));
            TempMemoLabel.canValidate := True;
          end
          else
          begin
            case Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.getWordMap(dataResDiag.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
              3:
              begin
                TempMemoLabel.canValidate := False;
                TMemo(sender).Text := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].PRecord.VALUE_STRING;
                TempMemoLabel.canValidate := True;
              end;
            end;

          end;
        end;
      end
      else
      begin
        //TempMemoLabel.chk.IsNull := true;
        TempMemoLabel.canValidate := False;
        TMemo(sender).Text := '';
        TempMemoLabel.canValidate := True;
      end;
    end;
    vvNZIS_RESULT_DIAGNOSTIC_REPORT:
    begin
      RESULT_DIAGNOSTIC_REPTemp.DataPos := Data.DataPos;
      if node.FirstChild <> nil then // записано е в базата
      begin
        TempMemoLabel.rctNull.Visible := False;
        TempMemoLabel.chk.IsChecked := True;
        dataResDiag := Pointer(PByte(node.FirstChild) + lenNode);
        if dataResDiag.index < 0 then
        begin
          RESULT_DIAGNOSTIC_REPTemp.DataPos := dataResDiag.DataPos;
          TempMemoLabel.canValidate := False;
          TMemo(sender).Text := RESULT_DIAGNOSTIC_REPTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING));
          TempMemoLabel.canValidate := True;
        end
        else
        begin
          dataResDiag.DataPos := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].DataPos;
          if Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].PRecord = nil then
          begin
            TempMemoLabel.canValidate := False;
            TMemo(sender).Text := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(dataResDiag.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING));
            TempMemoLabel.canValidate := True;
          end
          else
          begin
            case Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.getWordMap(dataResDiag.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE)) of
              3:
              begin
                TempMemoLabel.canValidate := False;
                TMemo(sender).Text := Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.Items[dataResDiag.index].PRecord.VALUE_STRING;
                TempMemoLabel.canValidate := True;
              end;
            end;

          end;
        end;
      end
      else
      begin
        //TempMemoLabel.chk.IsNull := true;
        TempMemoLabel.canValidate := False;
        TMemo(sender).Text := '';
        TempMemoLabel.canValidate := True;
      end;
    end;
  else
    begin
      Caption := 'ddd';
    end;
  end

end;

procedure TfrmProfFormFMX.p1ClosePopup(Sender: TObject);
var
  cbb: TComboBox;//text1style
  TempComboLabel: TComboOneLabel;
begin
  if sender = nil then Exit;

  if (p1.PlacementTarget.ClassName = 'TComboBox') and (p1.PlacementTarget.StyleName = '') then
  begin
    cbb := TComboBox(p1.PlacementTarget);
    TempComboLabel := TComboOneLabel(cbb.Parent.TagObject);
    TempComboLabel.canValidate := true;
  end;
end;

procedure TfrmProfFormFMX.p1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  //
end;

procedure TfrmProfFormFMX.p1Popup(Sender: TObject);
var
  cbb: TComboBox;//text1style
  TempComboLabel: TComboOneLabel;

  idxListItemLst: Integer;

  str: string;
  AbsH: Single;

begin
  if sender = nil then Exit;

  if (p1.PlacementTarget.ClassName = 'TComboBox') and (p1.PlacementTarget.StyleName = '') then
  begin
    frmFmxControls.rctBtnSaveLst.Visible := true;
    frmFmxControls.rctBtnCancelLst.Visible := true;
    cbb := TComboBox(p1.PlacementTarget);
    TempComboLabel := TComboOneLabel(cbb.parent.TagObject);
    TempComboLabel.canValidate := False;
  end;
  if (p1.PlacementTarget.ClassName = 'TRectangle') then
  begin
    frmFmxControls.rctBtnSaveLst.Visible := false;
    frmFmxControls.rctBtnCancelLst.Visible := false;
    idxListItemLst := 0;
    AbsH := 5;
    str := 'test';
    AddItemLst(idxListItemLst, nil, str, AbsH);
    inc(idxListItemLst);
  end;
end;

procedure TfrmProfFormFMX.pmNzisActionPopup(Sender: TObject);
var
  nzisStatus: Word;
begin
  nzisStatus := Adb_dm.CollPregled.getWordMap(FPregled.DataPos, word(PregledNew_NZIS_STATUS));
  case nzisStatus of
    0, 3, 15:
    begin
      mniAnulPreg.Visible := False;
      mniX013.Visible := True;
    end;
  else
    begin
      mniAnulPreg.Visible := true;
      mniX013.Visible := false;
    end;
  end;
end;

procedure TfrmProfFormFMX.PositionPopup;
begin
  //pAll.Scale.x := scaleDyn;
//  pAll.Scale.y := scaleDyn;
  if pAll.HasPopupForm then
    TCustomPopupForm(TPopupAll(pall).PopupForm).ApplyPlacement
end;

procedure TfrmProfFormFMX.rctAnswDoctorClick(Sender: TObject);
var
  rct: TRectangle;
begin
  pSourceAnsw.IsOpen := False;
  if SourceAnswerDefault <> TSourceAnsw.saDoktor then
  begin
    SourceAnswerDefault := TSourceAnsw.saDoktor;
  end
  else
  begin
    SourceAnswerDefault := TSourceAnsw.saNone;
  end;
end;

procedure TfrmProfFormFMX.rctAnswMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);

begin
  pSourceAnsw.PlacementTarget := TControl(Sender);
  pSourceAnsw.Width := lbSourceAnsw.Width;
  pSourceAnsw.Height :=lbSourceAnsw.Height;
  case SourceAnswerDefault of
    TSourceAnsw.saNone:
    begin
      rctAnswPat.Stroke.Color := $FFBD7D7D;
      rctAnswOther.Stroke.Color := $FFBD7D7D;
      rctAnswDoctor.Stroke.Color := $FFBD7D7D;
      rctAnswPat.Stroke.Thickness := 1;
      rctAnswOther.Stroke.Thickness := 1;
      rctAnswDoctor.Stroke.Thickness := 1;
    end;
    TSourceAnsw.saPatient:
    begin
      rctAnswPat.Stroke.Color := $FF0B45E0;
      rctAnswOther.Stroke.Color := $FFBD7D7D;
      rctAnswDoctor.Stroke.Color := $FFBD7D7D;
      rctAnswPat.Stroke.Thickness := 3;
      rctAnswOther.Stroke.Thickness := 1;
      rctAnswDoctor.Stroke.Thickness := 1;
    end;
    TSourceAnsw.saOther:
    begin
      rctAnswPat.Stroke.Color := $FFBD7D7D;
      rctAnswOther.Stroke.Color := $FF0B45E0;
      rctAnswDoctor.Stroke.Color := $FFBD7D7D;
      rctAnswPat.Stroke.Thickness := 1;
      rctAnswOther.Stroke.Thickness := 3;
      rctAnswDoctor.Stroke.Thickness := 1;
    end;
    TSourceAnsw.saDoktor:
    begin
      rctAnswPat.Stroke.Color := $FFBD7D7D;
      rctAnswOther.Stroke.Color := $FFBD7D7D;
      rctAnswDoctor.Stroke.Color := $FF0B45E0;
      rctAnswPat.Stroke.Thickness := 1;
      rctAnswOther.Stroke.Thickness := 1;
      rctAnswDoctor.Stroke.Thickness := 3;
    end;
    TSourceAnsw.saNotApp: ;
    TSourceAnsw.saNotAnsw: ;
  end;
  pSourceAnsw.Popup();
end;


procedure TfrmProfFormFMX.rctAnswOtherClick(Sender: TObject);
var
  rct: TRectangle;
begin
  pSourceAnsw.IsOpen := False;
  if SourceAnswerDefault <> TSourceAnsw.saOther then
  begin
    SourceAnswerDefault := TSourceAnsw.saOther;
  end
  else
  begin
    SourceAnswerDefault := TSourceAnsw.saNone;
  end;
end;

procedure TfrmProfFormFMX.rctAnswPatClick(Sender: TObject);
begin
  pSourceAnsw.IsOpen := False;
  if SourceAnswerDefault <> TSourceAnsw.saPatient then
  begin
    SourceAnswerDefault := TSourceAnsw.saPatient;
  end
  else
  begin
    SourceAnswerDefault := TSourceAnsw.saNone;
  end;
end;

procedure TfrmProfFormFMX.rctBackGroundClick(Sender: TObject);
begin
  rctBackGround.Margins.Bottom := Random(20);
end;

procedure TfrmProfFormFMX.rctBlankaDblClick(Sender: TObject);
var
  p1, pAbs: TPointF;
  vScrol: TScrollBar;
begin
  //RecalcBlankaRect1;
  //scldlyt1.OriginalHeight := scldlyt1.OriginalHeight + 20;
 // scldlyt1.Height := scldlyt1.Height + 20 * scaleDyn;
end;

procedure TfrmProfFormFMX.rctBlankaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  //rctBlanka.Cursor := crSizeAll;
//  rctBlanka.AutoCapture := True;
end;

procedure TfrmProfFormFMX.rctBlankaMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
var
  vScrol: TScrollBar;
begin
  //scrlbx1.FindStyleResource<TScrollBar>('vscrollbar', vScrol);
  //vScrol.Value := vScrol.Value - 1 * scaleDyn;
  //btn1.Text := FloatToStr(y);
end;

procedure TfrmProfFormFMX.rctBlankaTransparentMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  TWinCursorService.CursorOverride := HANDGRAB;
  ExPointHand := PointF(x, y);
end;

procedure TfrmProfFormFMX.rctBlankaTransparentMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
var
  vScrol, hScrol: TScrollBar;
  deltaY, deltaX: Single;
begin
    if TWinCursorService.FCursorOverride <> HANDGRAB then  Exit;

    scrlbx1.FindStyleResource<TScrollBar>('vscrollbar', vScrol);
    scrlbx1.FindStyleResource<TScrollBar>('hscrollbar', hScrol);
    deltaY := (ExPointHand.Y - y) ;
    deltaX := (ExPointHand.X - x) ;
    vScrol.Value := (DeltaY + scrlbx1.ViewportPosition.y);
    hScrol.Value := (Deltax + scrlbx1.ViewportPosition.x);
end;

procedure TfrmProfFormFMX.rctBlankaTransparentMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  TWinCursorService.CursorOverride := HANDFLAT;
end;

procedure TfrmProfFormFMX.RecalcBlankaRect;
var
  lytLeftHeight, delta, totalH: Single;
  //lytLeftR: TRectF;
  p1, p2: TPointF;
begin
  p1 := pointf(0, lytLeft.Position.Point.y);
  p2 := pointf(0, InnerChildrenRect(lytLeft).Bottom);
  //txt1.Text := FloatToStr(scldlyt1.LocalToAbsolute(PointF(0, 0)).y);
  //txt1.Text := txt1.Text +#13#10 + FloatToStr(lytLeft.LocalToAbsolute(InnerChildrenRect(lytLeft).BottomRight).y);
  if scrlbx1.ViewportPosition.y > 0 then
  begin
    totalH := p1.Distance(p2) + p1.y + scrlbx1.ViewportPosition.y;
  end
  else
  begin
    totalH := p1.Distance(p2) + p1.y + scrlbx1.ViewportPosition.y*2;
  end;
  //delta := (totalH) - FExHeightBlanka;
  if delta > 1 then
  begin
    //scldlyt1.OriginalHeight := totalH  ;
    //scldlyt1.Height := scldlyt1.Height + delta * FScaleDyn;
  end;
end;

procedure TfrmProfFormFMX.RecalcBlankaRect1;
var
  lytLeftHeight, lytRighttHeight, delta, totalH: Single;
  p1, p2, p3: TPointF;
begin
  lytRightResize(nil);
  Exit;
  //scldlyt1.RecalcSize;
  p1 := scldlyt1.LocalToAbsolute(PointF(0, 0));
  p2 := xpdrVisitFor.LocalToAbsolute(PointF(0,xpdrVisitFor.Height));

  lytLeftHeight := InnerChildrenRect(lytLeft).Height/FScaleDyn + 20;
  p2 := lytLeft.LocalToAbsolute(PointF(0,lytLeftHeight));

  lytRight.RecalcSize;
  lytRighttHeight := InnerChildrenRect(lytRight).Height/FScaleDyn + 20;
  //p3 := lytRight.LocalToAbsolute(PointF(0,lytRighttHeight));
  p3 := Memo1.LocalToAbsolute(PointF(0,Memo1.Size.Height));
  //scldlyt1.Height := p3.Y - p1.y ;
  scldlyt1.OriginalHeight := p3.Y - p1.y  ;
  scldlyt1.Height := (p3.Y - p1.y) * FScaleDyn;
  //btn1.Text := FloatToStr(p3.Y);

  Exit;
  p1.X := 0;
  p2.X := 0;
  p3.X := 0;


  if p2.y  > p3.y then
  begin
    totalH := p1.Distance(p3)/ FScaleDyn;
  end
  else
  begin
    totalH := p1.Distance(p3)/ FScaleDyn;
  end;
  delta := (totalH - scldlyt1.OriginalHeight) ;
  begin
    scldlyt1.OriginalHeight := totalH  ;
    scldlyt1.Height := scldlyt1.Height + delta * FScaleDyn;
    //lytbottom.Height := scldlyt1.Height;
  end;

end;

procedure TfrmProfFormFMX.rctNzisBTNClick(Sender: TObject);
var
  data: PAspRec;
  nzisStatus: Word;
begin
  data := Pointer(PByte(linkPreg) + lenNode);
  nzisStatus := Adb_dm.CollPregled.getWordMap(data.DataPos, word(PregledNew_NZIS_STATUS));
  case nzisStatus of
    0, 3, 4, 15, 16: // нищо, опит за отваряне, грешка при отваряне
    begin
      if Assigned(FOnOpenPregled) then
      begin
        Adb_dm.CollPregled.SetWordMap(data.DataPos, word(PregledNew_NZIS_STATUS),3);
        FOnOpenPregled(FPregled);
      end;
    end;
    5, 8, 9: // отворен е , опит за затваряне, грешка при затваряне
    begin
      if Assigned(FOnClosePregled) then
      begin
        Adb_dm.CollPregled.SetWordMap(data.DataPos, word(PregledNew_NZIS_STATUS),8);
        FOnClosePregled(FPregled);
      end;
    end;
    6, 10, 11, 12: // затворен, редактиран, грешка при редактиране, опит за редактиране
    begin
      if Assigned(FOnEditPregled) then
      begin
        Adb_dm.CollPregled.SetWordMap(data.DataPos, word(PregledNew_NZIS_STATUS),12);
        FOnEditPregled(FPregled);
      end;
    end;
  else
    rctNzisBTN.Stroke.Color := TAlphaColorRec.Null;
  end;
  edtAmbList.Repaint;
  rctNzisBTN.Repaint;
end;

procedure TfrmProfFormFMX.rctNzisBTNMouseEnter(Sender: TObject);
begin
  rctNzisBTN.OnPainting := nil;
  animNzisButton.Enabled := False;
end;

procedure TfrmProfFormFMX.rctNzisBTNMouseLeave(Sender: TObject);
begin
  rctNzisBTN.OnPainting := rctNzisBTNPainting;
  animNzisButton.Enabled := true;
end;

procedure TfrmProfFormFMX.rctNzisBTNPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);//linkPreg
var
  data: PAspRec;
  nzisStatus: Word;
begin
  Exit;
  data := Pointer(PByte(linkPreg) + lenNode);
  nzisStatus := Adb_dm.CollPregled.getWordMap(data.DataPos, word(PregledNew_NZIS_STATUS));
  case nzisStatus of
    5: rctNzisBTN.Stroke.Color := $FFDCD295;
    6: rctNzisBTN.Stroke.Color := $FF299045;
    10: rctNzisBTN.Stroke.Color := $FF454BE3;
  else
    rctNzisBTN.Stroke.Color := TAlphaColorRec.Null;
  end;
end;

procedure TfrmProfFormFMX.rctNzisBTNPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  ambNom: integer;
  ambNRN: string;
  nzisStatus: Word;
  //THipPregledStatus = (hpsNone, hpsValid, hpsNoValid, hpsStartOpen, hpsErr, hpsOpen, hpsClosed, hpsCancel);
begin
  nzisStatus := Adb_dm.CollPregled.getWordMap(FPregled.DataPos, word(PregledNew_NZIS_STATUS));
  //animNzisButton.Tag:= nzisStatus;
  case nzisStatus of
    3:
    begin
      if animNzisButton.Pause then
      begin
        rctNzisBTN.Opacity := 0.3;
        animNzisButton.Start;
      end;
      rctNzisBTN.Stroke.Color := $FFFF9500;
    end;
    4:
    begin
      animNzisButton.Stop;
      rctNzisBTN.Opacity := 0.3;
      rctNzisBTN.Stroke.Color := $FFFA0808;
    end;
    5:
    begin
      animNzisButton.Stop;
      rctNzisBTN.Opacity := 0.3;
      rctNzisBTN.Stroke.Color := $FFFF9500;
    end;
    6:
    begin
      animNzisButton.Stop;
      rctNzisBTN.Opacity := 0.3;
      rctNzisBTN.Stroke.Color := $FF299045;
    end;
    8:
    begin
      if animNzisButton.Pause then
      begin
        rctNzisBTN.Opacity := 0.3;
        animNzisButton.Start;
      end;
      rctNzisBTN.Stroke.Color := $FF299045;
    end;
    9:
    begin
      animNzisButton.Stop;
      rctNzisBTN.Opacity := 0.3;
      rctNzisBTN.Stroke.Color := $FFFA0808;
    end;
    10:
    begin
      animNzisButton.Stop;
      rctNzisBTN.Opacity := 0.3;
      rctNzisBTN.Stroke.Color := $FF454BE3;
    end;
    11:
    begin
      animNzisButton.Stop;
      rctNzisBTN.Opacity := 0.3;
      rctNzisBTN.Stroke.Color := $FFFA0808;
    end;
    12:
    begin
      if animNzisButton.Pause then
      begin
        rctNzisBTN.Opacity := 0.3;
        animNzisButton.Start;
      end;
      rctNzisBTN.Stroke.Color := $FF454BE3;
    end;
    13:
    begin
      if animNzisButton.Pause then
      begin
        rctNzisBTN.Opacity := 0.3;
        animNzisButton.Start;
      end;
      rctNzisBTN.Stroke.Color := $FF454BE3;
    end;
    14:
    begin
      animNzisButton.Stop;
      rctNzisBTN.Opacity := 0.3;
      rctNzisBTN.Stroke.Color := $FF454BE3;
    end;
    15:
    begin
      if CheckKep then
      begin
        animNzisButton.Stop;
        rctNzisBTN.Opacity := 0.3;
        rctNzisBTN.Stroke.Color := $FF454BE3;
      end;
    end;
    16:
    begin
      if CheckKep then
      begin
        animNzisButton.Stop;
        rctNzisBTN.Opacity := 0.3;
        rctNzisBTN.Stroke.Color := $FFFF9500;
      end;
    end;
  else
    animNzisButton.Stop;
    rctNzisBTN.Opacity := 0.3;
    if CheckKep then
    begin
      rctNzisBTN.Stroke.Color := TAlphaColorRec.Null;
    end
    else
    begin

    end;
    rctBtnNzisErr.Visible := false;
  end;
end;

procedure TfrmProfFormFMX.Rectangle15Click(Sender: TObject);
var
  NodeForInsert: PVirtualNode;
begin
  NodeForInsert := FVtrPregLink.GetFirstSelected();
  FillPlanedPreg(NodeForInsert);
  RecalcBlankaRect1;
  //
//  AddExpanderPreg(idxListExpander, NodeForInsert);
  VtrPregLink.CheckType[NodeForInsert] := ctCheckBox;
//  inc(idxListExpander);
  //recal
end;

procedure TfrmProfFormFMX.Rectangle16Click(Sender: TObject);
var
  rct: TRectangle;

  TempComboLabel: TComboOneLabel;
  TempComboMultiLabel: TComboMultiLabel;
  TempEditLabel: TEditLabel;
  TempMemoLabel: TMemoLabel;
  TempCheckLYT: TLayoutCheck;
  TempDateEditLabel: TDateEditLabel;
begin
  pSourceAnsw.IsOpen := False;
  rct := TRectangle(pSourceAnsw.PlacementTarget);
  //case FSourceAnswerDefault of
//    TSourceAnsw.saNone:
//    begin
//      rct.Fill.Kind := TBrushKind.None;
//    end;
//    TSourceAnsw.saPatient:
//    begin
//      rct.Fill.Assign(rctAnswNot.Fill);
//    end;
//    TSourceAnsw.saOther:
//    begin
//      rct.Fill.Assign(rctAnswNot.Fill);
//    end;
//    TSourceAnsw.saDoktor:
//    begin
//      rct.Fill.Assign(rctAnswNotApplay.Fill);
//    end;
//  end;
  if rct.TagObject is TComboOneLabel then
  begin
    TempComboLabel := TComboOneLabel(rct.TagObject);
    TempComboLabel.SourceAnsw := TSourceAnsw.saNone;
    MarkSourceAnsw(TempComboLabel.SourceAnsw, rct);
    TempComboLabel.node.Dummy := Byte(TSourceAnsw.saNone);
  end;
  if rct.TagObject is TComboMultiLabel then
  begin
    TempComboMultiLabel := TComboMultiLabel(rct.TagObject);
    TempComboMultiLabel.SourceAnsw := TSourceAnsw.saNone;
    MarkSourceAnsw(TempComboMultiLabel.SourceAnsw, rct);
    TempComboMultiLabel.node.Dummy := Byte(TSourceAnsw.saNone);
  end;
  if rct.TagObject is TEditLabel then
  begin
    TempEditLabel := TEditLabel(rct.TagObject);
    TempEditLabel.SourceAnsw := TSourceAnsw.saNone;
    MarkSourceAnsw(TempEditLabel.SourceAnsw, rct);
    TempEditLabel.node.Dummy := Byte(TSourceAnsw.saNone);
  end;
  if rct.TagObject is TMemoLabel then
  begin
    TempMemoLabel := TMemoLabel(rct.TagObject);
    TempMemoLabel.SourceAnsw := TSourceAnsw.saNone;
    MarkSourceAnsw(TempMemoLabel.SourceAnsw, rct);
    TempMemoLabel.node.Dummy := Byte(TSourceAnsw.saNone);
  end;
  if rct.TagObject is TLayoutCheck then
  begin
    TempCheckLYT := TLayoutCheck(rct.TagObject);
    TempCheckLYT.SourceAnsw := TSourceAnsw.saNone;
    MarkSourceAnsw(TempCheckLYT.SourceAnsw, rct);
    TempCheckLYT.node.Dummy := Byte(TSourceAnsw.saNone);
  end;
  if rct.TagObject is TDateEditLabel then
  begin
    TempDateEditLabel := TDateEditLabel(rct.TagObject);
    TempDateEditLabel.SourceAnsw := TSourceAnsw.saNone;
    MarkSourceAnsw(TempDateEditLabel.SourceAnsw, rct);
    TempDateEditLabel.node.Dummy := Byte(TSourceAnsw.saNone);
  end;

end;

procedure TfrmProfFormFMX.rctBtnAddImunMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  h: Single;
  TempImunLabel: TImmunsLabel;
  i: Integer;
begin
  rctBtnAddImun.Tag := 1;
  AddExpanderImuns(nil);
  TempImunLabel := TImmunsLabel(LstImuns[LstImuns.Count - 1].TagObject);
  expndrImun.RecalcSize;

  flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height/scaleDyn + 15;
  SetExpanderVisitForHeight;
  RecalcBlankaRect1;
  if Assigned(FOnAddNewImun) then
    FOnAddNewImun(self, FlinkPreg, TempImunLabel.LinkImun, TempImunLabel.imun);
  if TempImunLabel.imun <> nil then
  begin
    //for i:= 0 to TempImunLabel.LstMkbs.Count - 1 do
    begin
      //TempMnLabel.LstMkbs[i].edtMkb.OnChangeTracking := edtAnalCodeChangeTracking;
    end;
  end;
  rctBtnAddImun.Tag := 0;
end;

procedure TfrmProfFormFMX.Rectangle20MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  btn: TRectangle;
  ctrl: TFmxObject;
  datEdt: TDateEdit;
begin
  btn := TRectangle(Sender);
  ctrl := btn.Parent;
  while true  do
  begin
    if (ctrl is TDateEdit)then
    begin
      datEdt := TDateEdit(ctrl);
      Break;
    end;
    ctrl := ctrl.Parent;
  end;
  //datEdt.IsChecked := True;

  if datEdt.IsPickerOpened then
    datEdt.ClosePicker
  else
    datEdt.OpenPicker;
end;

procedure TfrmProfFormFMX.BtnDropDownMN_MKBClick(Sender: TObject);
begin
  p1.PlacementTarget := TRectangle(Sender);
  p1.Popup();
end;

procedure TfrmProfFormFMX.Rectangle2Click(Sender: TObject);
var
  vScrol: TScrollBar;
begin
    scrlbx1.FindStyleResource<TScrollBar>('vscrollbar', vScrol);
    vScrol.Value := LstChecksSup[23].LocalToAbsolute(Point(0,0)).Y + scrlbx1.ViewportPosition.y;

    btn1.Text := Single.ToString(LstChecksSup[23].LocalToAbsolute(Point(0,0)).Y);
end;

procedure TfrmProfFormFMX.SelectDiagMainMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  TempRect: TRectangle;
  TempDiagLabel: TDiagLabel;
  nodePreg, nodeDiag: PVirtualNode;
  diag: TRealDiagnosisItem;
begin
    TempRect := TRectangle(TRectangle(sender).Parent.Parent.parent);
    TempDiagLabel := TDiagLabel(TempRect.TagObject);
    if TempDiagLabel.node = nil then // това са добавените празни диагнози
      Exit;
    nodePreg := TempDiagLabel.node.Parent;
    nodeDiag := TempDiagLabel.node;
    diag := FPregled.FDiagnosis[FPregled.FDiagnosis.IndexOf(TempDiagLabel.diag)];

    if Assigned(FOnSelectMkb) then
      FOnSelectMkb(diag);
end;

procedure TfrmProfFormFMX.rctMkbAddClick(Sender: TObject);
var
  TempRect: TRectangle;
  TempDiagLabel: TDiagLabel;
  nodePreg, nodeDiag: PVirtualNode;
  diag: TRealDiagnosisItem;
begin
    //TempRect := TRectangle(TRectangle(sender).Parent.Parent);
//    TempDiagLabel := TDiagLabel(TempRect.TagObject);
//    nodePreg := TempDiagLabel.node.Parent;
//    nodeDiag := TempDiagLabel.node;
    //diag := FPregled.FDiagnosis[FPregled.FDiagnosis.IndexOf(TempDiagLabel.diag)];
  FPregled.FDiagnosis.Exchange(1, 3);

end;

procedure TfrmProfFormFMX.rctMkbMouseEnter(Sender: TObject);
var
  r: TRect;
  rf: TRectF;
begin
    rf := rctMkb.AbsoluteRect;
    rf.TopLeft := Self.ClientToScreen(rf.TopLeft);
    rf.BottomRight := Self.ClientToScreen(rf.BottomRight);
    r.Left := Round(rf.Left);
    r.Right := Round(rf.Right);
    r.Top := Round(rf.Top);
    r.Bottom := Round(rf.Bottom);
  if Assigned(FOnSowHint) then
    FOnSowHint(Sender, 'mkb', r);
end;

procedure TfrmProfFormFMX.rctMkbPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  TempRect: TRectangle;
  TempDiagLabel: TDiagLabel;
  nodePreg, nodeDiag: PVirtualNode;
  diag: TRealDiagnosisItem;
begin
    //TempRect := TRectangle(TRectangle(sender).Parent.Parent.parent);
//    TempDiagLabel := TDiagLabel(TempRect.TagObject);
//    nodePreg := TempDiagLabel.node.Parent;
//    nodeDiag := TempDiagLabel.node;
//    diag := FPregled.FDiagnosis[FPregled.FDiagnosis.IndexOf(TempDiagLabel.diag)];
//    if diag.MkbNode <> nil then
//      TRectangle(sender).StrokeThickness := 7
//    else
//      TRectangle(sender).StrokeThickness := 2;
end;

procedure TfrmProfFormFMX.Rectangle34MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  TempRect: TRectangle;
  TempDiagLabel: TDiagLabel;
  nodePreg, nodeDiag: PVirtualNode;
  diag: TRealDiagnosisItem;
begin
    TempRect := TRectangle(TRectangle(sender).Parent.Parent);
    TempDiagLabel := TDiagLabel(TempRect.TagObject);
    if TempDiagLabel.node <> nil then
    begin
      nodePreg := TempDiagLabel.node.Parent;
      nodeDiag := TempDiagLabel.node;
      diag := FPregled.FDiagnosis[FPregled.FDiagnosis.IndexOf(TempDiagLabel.diag)];
      TTempVtrHelper(TmpVtr).Vtr.CheckState[diag.MkbNode] := csUncheckedNormal;
      if Assigned(FOnDeleteNewDiag) then
        FOnDeleteNewDiag(Self, nodePreg, nodeDiag, diag);
      //FPregled.FDiagnosis.Delete(FPregled.FDiagnosis.IndexOf(TempDiagLabel.diag));
    end
    else
    begin
      TempRect.Parent := nil;
      xpdrDiagn.RecalcSize;
      lytDiagFrame.Height := xpdrDiagn.Height + 30;
    end;
end;

procedure TfrmProfFormFMX.Rectangle3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  lytLeftHeight, delta, h: Single;
  lytLeftR: TRectF;
  p1, pAbs: TPointF;
  vScrol: TScrollBar;
  grdLyt: TGridLayout;
  TempMdnLabel: TMdnsLabel;
  i: Integer;
begin
  AddExpanderMDNs(nil);
  TempMdnLabel := TMdnsLabel(LstMdns[LstMdns.Count - 1].TagObject);
  grdLyt := TempMdnLabel.GridLayoutAnals;
  //grdLyt.OnResize := GridLayout1Resize;
  lytMdnExp.RecalcSize;
  h := InnerChildrenRect(lytMdnExp).Height/FScaleDyn ;
  lytMdnExp.Height := h;
  if h = 0 then
  begin
    expndrMdns.Height := 90;
  end
  else
  begin
    expndrMdns.Height := h+ 35;
  end;
  flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height/scaleDyn + 15;
  SetExpanderVisitForHeight;
  RecalcBlankaRect1;
  if Assigned(FOnAddNewMdn) then
    FOnAddNewMdn(self, FlinkPreg, TempMdnLabel.LinkMdn, TempMdnLabel.mdn);
  if TempMdnLabel.mdn <> nil then
  begin
    for i:= 0 to TempMdnLabel.LstAnals.Count - 1 do
    begin
      TempMdnLabel.LstAnals[i].edtAnal.OnChangeTracking := edtAnalCodeChangeTracking;
    end;
  end;
end;

procedure TfrmProfFormFMX.RemoveMdnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  lytLeftHeight, delta, h: Single;
  lytLeftR: TRectF;
  p1, pAbs: TPointF;
  vScrol: TScrollBar;
  grdLyt: TGridLayout;
  AParent: TFmxObject;
  TempLyt: TLayout;
  TempMdnsLabel: TMdnsLabel;
begin
  TempLyt := TLayout(TRectangle(sender).Parent.Parent.Parent); //mdnLyt
  TempMdnsLabel := TMdnsLabel(LstMdns[TempLyt.Tag].TagObject);
  TempLyt.Parent := nil;
  lytMdnExp.RecalcSize;
  h := InnerChildrenRect(lytMdnExp).Height/FScaleDyn +  lytMdnExp.Margins.Top/ scaleDyn;
  lytMdnExp.Height := h;
  if h < 30 then
  begin
    expndrMdns.Height := 90;
  end
  else
  begin
    expndrMdns.Height := h+ 35;
  end;
  flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height/scaleDyn + 15;
  SetExpanderVisitForHeight;
  RecalcBlankaRect1;
  if Assigned(FOnDeleteNewMdn) then
  begin
    FOnDeleteNewMdn(self, FlinkPreg, TempMdnsLabel.LinkMdn, TempMdnsLabel.mdn);
  end;
end;


procedure TfrmProfFormFMX.rctBtnAddMNMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  h: Single;
  grdLyt: TLayout;
  TempMnLabel: TMnsLabel;
  i: Integer;
begin
  rctBtnAddMN.Tag := 1;
  lytExpMN.Height := 10;
  AddExpanderMNs(nil);
  TempMnLabel := TMnsLabel(LstMns[LstMns.Count - 1].TagObject);
  grdLyt := TempMnLabel.GridLayoutMkb;
  expndrMNs.RecalcSize;

  flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height/scaleDyn + 15;
  SetExpanderVisitForHeight;
  RecalcBlankaRect1;
  if Assigned(FOnAddNewMn) then
    FOnAddNewMn(self, FlinkPreg, TempMnLabel.LinkMn, TempMnLabel.mn);
  if TempMnLabel.mn <> nil then
  begin
    for i:= 0 to TempMnLabel.LstMkbs.Count - 1 do
    begin
      //TempMnLabel.LstMkbs[i].edtMkb.OnChangeTracking := edtAnalCodeChangeTracking;
      TempMnLabel.LstMkbs[i].edtMkb.OnKeyDown := edtMdn1KeyDown;
    end;
  end;
  rctBtnAddMN.Tag := 0;
end;

procedure TfrmProfFormFMX.Rectangle7MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  btn: TRectangle;
  ctrl: TFmxObject;
  datEdt: TDateEdit;
begin
  btn := TRectangle(Sender);
  ctrl := btn.Parent;
  while true  do
  begin
    if (ctrl is TDateEdit)then
    begin
      datEdt := TDateEdit(ctrl);
      Break;
    end;
    ctrl := ctrl.Parent;
  end;
  if not datEdt.IsChecked then
    datEdt.Date := Date;

  datEdt.IsChecked := True;

  if datEdt.IsPickerOpened then
    datEdt.ClosePicker
  else
    datEdt.OpenPicker;
end;


procedure TfrmProfFormFMX.RemoveEditPregSup(RunNodeCL132: PVirtualNode);
var
  i: Integer;
  TempEditLYT: TLayout;
  TempEditLabel: TEditLabel;
  nodeAct: PVirtualNode;
begin
  for i := 0 to LstEditsLyt.Count - 1 do
  begin
    TempEditLYT := LstEditsLyt[i];
    TempEditLabel := TEditLabel(TempEditLYT.TagObject);
    nodeAct := TempEditLabel.node;
    if nodeAct = RunNodeCL132 then
    begin
      TempEditLYT.Parent := nil;
      TempEditLabel.chk.IsChecked := False;
      TempEditLabel.rctNull.Visible := true;
      Exit;
    end;
  end;
end;

procedure TfrmProfFormFMX.RemoveLastVacantindexPreg;
begin
  if ListVacantPregIndex.Count > 0 then
    ListVacantPregIndex.Delete(ListVacantPregIndex.Count - 1);
end;

procedure TfrmProfFormFMX.RemoveMemoPregSup(RunNodeCL132: PVirtualNode);
var
  i: Integer;
  TempMemoLYT: TLayout;
  TempMemoLabel: TMemoLabel;
  nodeAct: PVirtualNode;
begin
  for i := 0 to LstMemosLYT.Count - 1 do
  begin
    TempMemoLYT := LstMemosLYT[i];
    TempMemoLabel := TMemoLabel(TempMemoLYT.TagObject);
    nodeAct := TempMemoLabel.node;
    if nodeAct = RunNodeCL132 then
    begin
      TempMemoLYT.Parent := nil;
      TempMemoLabel.chk.IsChecked := False;
      TempMemoLabel.rctNull.Visible := true;
      Exit;
    end;
  end;
end;

procedure TfrmProfFormFMX.RemoveMnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  h: Single;
  TempLyt: TLayout;
  TempMnsLabel: TMnsLabel;
begin
  TempLyt := TLayout(TRectangle(sender).Parent.Parent.Parent); //mdnLyt
  TempMnsLabel := TMnsLabel(LstMns[TempLyt.Tag].TagObject);
  TempLyt.Parent := nil;
  lytExpMN.RecalcSize;
  h := InnerChildrenRect(lytExpMN).Height/FScaleDyn ;
  lytExpMN.Height := h;
  if h = 0 then
  begin
    expndrMNs.Height := 75;
  end
  else
  begin
    expndrMNs.Height := h + lytExpMN.Margins.Top + lytExpMN.Margins.Top;
  end;
  lytFrameMN.Height := expndrMNs.Height + 30;

  flwlytVizitFor.Height := InnerChildrenRect(flwlytVizitFor).Height/scaleDyn + 15;
  SetExpanderVisitForHeight;
  RecalcBlankaRect1;
  if Assigned(FOnDeleteNewMn) then
  begin
    FOnDeleteNewMn(self, FlinkPreg, TempMnsLabel.LinkMn, TempMnsLabel.mn);
  end;
end;

procedure TfrmProfFormFMX.RemovePlanedPreg(PlanNode: Pointer);
var
  RunPlanedType, RunNodeCL132, RunNodePR001: PVirtualNode;
  dataPr001, dataRunPr001: PAspRec;
  cl132Key, strNode, respKey, pr001Key, diagRepKey, captEdit, captCombo: string;
  captMemo, captDateEdt, captChk, cl088Code: string;
  i: Integer;
  cl132: TCL132Item;
  cl134: TRealCl134Item;
  pr001: TRealPR001Item;
  tempFLYT: TFlowLayout;
begin
  cl132:= TCL132Item.Create(nil);
  RunNodeCL132 := PVirtualNode(PlanNode);
  while RunNodeCL132 <> nil do
  begin
    dataPr001 := pointer(PByte(RunNodeCL132) + lenNode);
    pr001 := TRealPR001Item.Create(nil);
    case dataPr001.vid of
      vvPR001:
      begin
        pr001.DataPos := dataPr001.DataPos;
      end;
      vvNZIS_QUESTIONNAIRE_RESPONSE:
      begin
        SourceAnswerDefault := TSourceAnsw(RunNodeCL132.Dummy);
        respTemp.DataPos := dataPr001.DataPos;
        respKey := respTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY));
        for i := 0 to Fpr001Coll.Count - 1 do
        begin
          pr001Key := Fpr001Coll.Items[i].getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Nomenclature)) + '|' +
            Fpr001Coll.Items[i].getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Activity_ID));
          if pr001Key = respKey then
          begin
            pr001.DataPos := Fpr001Coll.Items[i].DataPos;
            Break;
          end;
        end;
      end;
      vvNZIS_DIAGNOSTIC_REPORT:
      begin
        DIAGNOSTIC_REPTemp.DataPos := dataPr001.DataPos;
        diagRepKey := 'CL142|' + DIAGNOSTIC_REPTemp.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_DIAGNOSTIC_REPORT_CL142_CODE));
        for i := 0 to Fpr001Coll.Count - 1 do
        begin
          pr001Key := Fpr001Coll.Items[i].getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Nomenclature)) + '|' +
            Fpr001Coll.Items[i].getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Activity_ID));
          if pr001Key = diagRepKey then
          begin
            pr001.DataPos := Fpr001Coll.Items[i].DataPos;
            Break;
          end;
        end;
      end;
    end;

     //zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
    RunNodePR001 := RunNodeCL132.FirstChild;
    dataRunPr001 :=pointer(PByte(RunNodePR001) + lenNode);

    if (RunNodeCL132.ChildCount > 1) or
         ((RunNodePR001<> nil) and (Adb_dm.CollNzis_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(dataRunPr001.DataPos, Word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE)) ='65-226-09'))then
    begin
      AddExpanderPreg(idxListExpander, RunNodeCL132);
      tempFLYT := WalkChildrenFLYT(LstExpanders[idxListExpander]);
      tempFLYT.OnResize := flwlyt2Resize;

      while RunNodePR001 <> nil do
      begin
        dataRunPr001 :=pointer(PByte(RunNodePR001) + lenNode);
        case dataRunPr001.vid of
          vvNZIS_QUESTIONNAIRE_ANSWER:
          begin
            answTemp.DataPos := dataRunPr001.DataPos;
            cl134Temp.DataPos := answTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS));
            case cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_CL028))[1] of
              '1': //'Количествено представяне';
              begin
                //captEdit := cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
//                             cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
//                AddEditPregSup(tempFLYT, pr001, idxListEdit, RunNodePR001, captEdit);
//                inc(idxListEdit);
              end;
              '2': //'Категоризация по номенклатура';
              begin
                if cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Multiple_Choice))= 'TRUE' then
                begin
                  //captCombo := cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Answer_Nomenclature)) + '|' +
//                               cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
//                               cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description)) + ' mnogo';
//
//                  AddComboPregMultiLYT(tempFLYT, idxListComboMultiSup, RunNodePR001, captCombo, true);
//
//                  inc(idxListComboMultiSup);
                end
                else
                begin
                  //captCombo := cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Answer_Nomenclature)) + '|' +
//                               cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
//                               cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
//
//                  AddComboPregLYT(tempFLYT, idxListComboOneSup, RunNodePR001, captCombo, false);
//                  inc(idxListComboOneSup);
                end;
              end;
              '3': //'Описателен метод';
              begin
                //captMemo := cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
                             //cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
                //AddMemoSup(tempFLYT, pr001, idxListMemoLyt, RunNodePR001, captMemo);
                //inc(idxListMemoLyt);
                RemoveMemoPregSup(RunNodePR001);
              end;
              '4': //'Конкретна дата';
              begin
                //captDateEdt := cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
//                             cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
//                AddDateEdtSup(tempFLYT, idxListDateEditSup, RunNodePR001, captDateEdt);
//                inc(idxListDateEditSup);
              end;
              '5': //'Положително или отрицателно';
              begin
                //captChk := cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
//                             cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
//
//                AddCheckSup(tempFLYT, idxListCheckSup, RunNodePR001, captChk);
//                inc(idxListCheckSup);
              end;
            end;
          end;
          vvCl134:// Въпроси към прегледи при снемане на анамнеза
          begin
            cl134 := TRealCl134Item.Create(nil);
            cl134.DataPos := dataRunPr001.DataPos;
            case cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_CL028))[1] of
              '1': //'Количествено представяне';
              begin
                //captEdit := cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
//                             cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
//                AddEditPregSup(tempFLYT, pr001, idxListEdit, RunNodePR001, captEdit);
//                inc(idxListEdit);
              end;
              '2': //'Категоризация по номенклатура';
              begin
                if cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Multiple_Choice))= 'TRUE' then
                begin
                  //captCombo := cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Answer_Nomenclature)) + '|' +
//                               cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
//                               cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description)) + 'mnogo';
//
//                  AddComboPregMultiLYT(tempFLYT, idxListComboMultiSup, RunNodePR001, captCombo, true);
//                  inc(idxListComboMultiSup);
                end
                else
                begin
                  //captCombo := cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Answer_Nomenclature)) + '|' +
//                               cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
//                               cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
//
//                  AddComboPregLYT(tempFLYT, idxListComboOneSup, RunNodePR001, captCombo, false);
//                  inc(idxListComboOneSup);
                end;
              end;
              '3': //'Описателен метод';
              begin
                //captMemo := cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
//                             cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
//                AddMemoSup(tempFLYT, pr001, idxListMemoLyt, RunNodePR001, captMemo);
//                inc(idxListMemoLyt);
                RemoveMemoPregSup(RunNodePR001);
              end;
              '4': //'Конкретна дата';
              begin
                //captDateEdt := cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
//                             cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
//                AddDateEdtSup(tempFLYT, idxListDateEditSup, RunNodePR001, captDateEdt);
//                inc(idxListDateEditSup);
              end;
              '5': //'Положително или отрицателно';
              begin
                //captChk := cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Key)) + '|' +
//                             cl134.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_Description));
//
//                AddCheckSup(tempFLYT, idxListCheckSup, RunNodePR001, captChk);
//                inc(idxListCheckSup);
              end;
            end;
          end;
          vvNZIS_RESULT_DIAGNOSTIC_REPORT:
          begin
            RESULT_DIAGNOSTIC_REPTemp.DataPos := dataRunPr001.DataPos;
            cl144Temp.DataPos := RESULT_DIAGNOSTIC_REPTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
            if cl144Temp.DataPos <> 0 then
            begin
              case cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_cl028))[1] of
                '1': //'Количествено представяне';
                begin
                  //captEdit :=  cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_cl028)) + '|' +
//                               cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_Key)) + '|' +
//                               cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_Description));
//                  AddEditPregSup(tempFLYT, pr001, idxListEdit, RunNodePR001, captEdit);
//                  inc(idxListEdit);
                end;
                '2': //'Категоризация по номенклатура';
                begin
                  //captCombo :=   cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_cl028)) + '|' +
  //                                 cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_Key)) + '|' +
  //                                 cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_Description));
  //
  //                  AddComboPregLYT(tempFLYT, idxListComboOneSup, RunNodePR001, captCombo, false);
  //                  inc(idxListComboOneSup);
                end;
                '3': //'Описателен метод';
                begin
                  //captMemo :=  cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_cl028)) + '|' +
  //                               cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_Key)) + '|' +
  //                               cl144Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL144_Description));
  //                  if Cl144Coll.getAnsiStringMap(cl144Temp.DataPos, word(CL144_cl028)) <> '2' then
  //                  begin
  //                    AddMemoSup(tempFLYT, pr001, idxListMemoLyt, RunNodePR001, captMemo);
  //                    inc(idxListMemoLyt);
  //                  end
  //                  else
  //                  begin
  //                    AddMemoSup(flwlytVizitFor, pr001, idxListMemoLyt, RunNodePR001, captMemo);
  //                    inc(idxListMemoLyt);
  //                  end;
                   RemoveMemoPregSup(RunNodePR001);
                end;
                '4': //'Конкретна дата';
                begin

                end;
                '5': //'Положително или отрицателно';
                begin
                  //captChk := cl134.getAnsiStringMap(FAspBuf, FAspPosData, word(CL134_Description));
  //
  //                AddCheckSup(tempFLYT, idxListCheck, RunNodePR001, captChk);
  //                inc(idxListCheck);
                end;
              end;
            end ;

          end;

        end;
        RunNodePR001 := RunNodePR001.NextSibling;
      end;
      tempFLYT.EndUpdate;
      tempFLYT.RecalcSize;
      tempFLYT.Height := InnerChildrenRect(tempFLYT).Height/scaleDyn + 15;

      if idxListExpander < LstExpanders.Count then
      begin
        LstExpanders[idxListExpander].Height := tempFLYT.Height  + 55;
        inc(idxListExpander);
      end;
    end
    else // няма дечица,  това са дейностите
    begin
      Caption := pr001.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Nomenclature));
      if pr001.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Nomenclature)) = 'CL142' then
      begin
        cl088Code := pr001.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Activity_ID));
        for i := 0 to FCl088Coll.Count - 1 do
        begin
          if cl088Code = FCl088Coll.Items[i].getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL088_cl142)) then
          begin
            cl088Temp.DataPos := FCl088Coll.Items[i].DataPos;
            Break;
          end;
        end;

        case cl088Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL088_cl028))[1] of
          'a': //'Количествено представяне';
          begin
            //Addedit(tempFLYT, pr001, idxListEdit, RunNodePR001, 'dddd');
            //inc(idxListEdit);
          end;
          '2': // Номенклатура
          begin
            if false then //  ако е възможна множествена селекция (за сега няма такива)
            begin
              //AddExpanderPreg(idxListExpander, RunNodeCL132);
              //inc(idxListExpander);
            end
            else
            begin
              captCombo := cl088Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL088_Key));// номенклатурата
              captCombo := captCombo + '  ' + cl088Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL088_Description));
              //captCombo := captCombo + '  ' + cl088.CL138[StrToInt(captCombo)-1];
              AddComboPregLYT(flwlytVizitFor, idxListComboOneSup, RunNodeCL132, captCombo, false);
              inc(idxListComboOneSup);
            end;
          end;
          '3':// Описателен метод Cl088 във големия експандер
          begin
            //captMemo := cl088Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL088_Key));
//            captMemo := captMemo + '  ' + cl088Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL088_Description));
//            AddMemoSup(flwlytVizitFor, pr001, idxListMemoLyt, RunNodeCL132, captMemo);
//            inc(idxListMemoLyt);
            RemoveMemoPregSup(RunNodeCL132);
          end;
          '4':;
          '5':;
        end;
      end
      else
      begin

      end;
    end;
    RunNodeCL132 := RunNodeCL132.NextSibling;
  end;
end;

procedure TfrmProfFormFMX.RepaintDoctorUIN;
begin

end;

procedure TfrmProfFormFMX.RepaintEdtEGN;
begin

end;

procedure TfrmProfFormFMX.rctBtnCancelLstClick(Sender: TObject);
var
  cbb: TComboBox;
  TempComboLabel: TComboOneLabel;
  txt: TText;
begin
  p1.IsOpen := False;
  if (p1.PlacementTarget.ClassName = 'TComboBox') then
  begin
    cbb := TComboBox(p1.PlacementTarget);
    TempComboLabel := TComboOneLabel(cbb.Parent.TagObject);
    VtrPregLink.BeginUpdate;
    TempComboLabel.chk.IsChecked := false;
    TempComboLabel.rctNull.Visible := True;
    VtrPregLink.CheckType[TempComboLabel.node] := ctNone;
    if TempComboLabel.node.FirstChild <> nil then
      FAspLink.MarkDeletedNode(TempComboLabel.node.FirstChild);
    VtrPregLink.endUpdate;
    TempComboLabel.txt.Text := '';
    TempComboLabel.LineSaver.Repaint;
    MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);
  end;
end;

procedure TfrmProfFormFMX.rctBtnNzisErrClick(Sender: TObject);
begin
  ShowMessage('ggggggggggggggggggggggg');
end;

procedure TfrmProfFormFMX.rctBtnSaveLstClickSup(Sender: TObject);
var
  TempComboLabel: TComboMultiLabel;
  TempComboLYT: TLayout;
  i, j: integer;
  lstItem: TListBoxItem;
  TempBtnMulti: TSpeedButton;
  Aflyt: TFlowLayout;
  nodeValue: PVirtualNode;
  linkPos: Cardinal;
  AnswValue: TRealNZIS_ANSWER_VALUEItem;
  data: PAspRec;
  cl134Key: string;
begin
  p1.IsOpen := False;
  TempComboLabel := TComboMultiLabel(p1.TagObject);
  data := Pointer(PByte(TempComboLabel.node) + lenNode);
  for i := 0 to frmFmxControls.lbComboOne.Items.Count - 1 do
  begin
    lstItem := frmFmxControls.lbComboOne.ListItems[i];
    if lstItem.IsChecked then  // ако е избрано
    begin
      nodeValue := TempComboLabel.GetNodeValueFromText(lstItem.Text, Adb_dm.CollNZIS_ANSWER_VALUE);
      if nodeValue <> nil then
        Continue;
      AddBtnMultiLyt(TempComboLabel, lstItem.Text, TempComboLabel.Flyt);

      answTemp.DataPos := Data.DataPos;
      cl134Temp.DataPos := answTemp.getCardMap(FAspAdbBuf, FAspAdbPosData, word(NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS));
      answTemp.cl028 := StrToInt(cl134Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(CL134_CL028)));
      AnswValue := TRealNZIS_ANSWER_VALUEItem(Adb_dm.CollNZIS_ANSWER_VALUE.Add);
      Memo1.Text := IntToStr(Adb_dm.CollNZIS_ANSWER_VALUE.Count) + '(Adb_dm.CollNZIS_ANSWER_VALUE.Add)' ;
      New(AnswValue.PRecord);
      case answTemp.cl028 of
        2: //nomenkl
        begin
          AnswValue.PRecord.ANSWER_CODE := Copy(lstItem.Text, 1, 5);;
          AnswValue.PRecord.ID := 0;
          AnswValue.PRecord.QUESTIONNAIRE_ANSWER_ID := 0;
          AnswValue.PRecord.CL028 := 2;
          AnswValue.PRecord.NOMEN_POS := Adb_dm.Cl139Coll.GetDataPosFromKey(AnswValue.PRecord.ANSWER_CODE);

          AnswValue.PRecord.setProp :=
          [NZIS_ANSWER_VALUE_ANSWER_CODE
          , NZIS_ANSWER_VALUE_ID
          , NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID
          , NZIS_ANSWER_VALUE_CL028
          , NZIS_ANSWER_VALUE_NOMEN_POS];

          AnswValue.InsertNZIS_ANSWER_VALUE;

          Dispose(AnswValue.PRecord);
          AnswValue.PRecord := nil;
        end;
      end;
      FAspLink.AddNewNode(vvNZIS_ANSWER_VALUE, AnswValue.DataPos, TempComboLabel.node, amAddChildLast, nodeValue, linkpos);
      TempComboLabel.node.CheckType := ctCheckBox;
      TempComboLabel.node.CheckState := csCheckedNormal;
      //FAspLink.FVTR.RepaintNode(nodeValue);
    end
    else  // ако не е избрано
    begin
      nodeValue := TempComboLabel.GetNodeValueFromText(lstItem.Text, Adb_dm.CollNZIS_ANSWER_VALUE);
      if nodeValue <> nil then // не е избрано, пък го има в дървото. Значи е премахнато
      begin
        FAspLink.MarkDeletedNode(nodeValue);// махам го от дървото
        for j := 0 to TempComboLabel.MultiBtns.Count - 1 do
        begin
          if frmFmxControls.lbComboOne.Items[i].Contains(TempComboLabel.MultiBtns[j].Text) then
          begin
            TempComboLabel.MultiBtns[j].Parent := nil;
            TempComboLabel.MultiBtns.Delete(j);
            Break;
          end;
        end;
      end;
    end;
  end;
  TempComboLabel.Flyt.RecalcSize;
  if TempComboLabel.MultiBtns.Count = 0 then
  begin
    TempComboLabel.chk.IsChecked := false;
    TempComboLabel.rctNull.Visible := True;
  end
  else
  begin
    TempComboLabel.chk.IsChecked := true;
    TempComboLabel.rctNull.Visible := false;
  end;
  MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);

  TempComboLYT := TLayout(TempComboLabel.Flyt.TagObject);
  TempComboLYT.Height := Max(InnerChildrenRect(TempComboLabel.Flyt).Height/scaleDyn + TempComboLabel.chk.Height, 48);
  lytRightResize(nil);
end;

procedure TfrmProfFormFMX.rctDiagDragOver(Sender: TObject;
  const Data: TDragObject; const Point: TPointF; var Operation: TDragOperation);
begin
  //
end;

procedure TfrmProfFormFMX.rctDiagMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  Svc: IFMXDragDropService;
  DragData: TDragObject;
  DragImage: TBitmap;
  obj: TObject;
begin
  if  TPlatformServices.Current.SupportsPlatformService(IFMXDragDropService, Svc) then
  begin
    DragData.Source := TRectangle(Sender);
    DragImage := TRectangle(Sender).MakeScreenshot;
    try
      DragData.Data := DragImage;
      obj := TObject.Create;
      Svc.BeginDragDrop(self, DragData, DragImage);
    finally
      DragImage.Free;
    end;
  end;
end;

procedure TfrmProfFormFMX.rctDiagMouseEnter(Sender: TObject);
begin
  //
end;

procedure TfrmProfFormFMX.rctDiagPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  TempDiagLabel: TDiagLabel;
  tempDiagRect: TRectangle;
  mkbPos: Cardinal;
  mkbNote: string;
  arrstr: TArray<string>;
begin
  if LstDiags.Count = 0 then Exit;

  tempDiagRect := TRectangle(Sender);
  TempDiagLabel := TDiagLabel(LstDiags[tempDiagRect.tag].TagObject);
  TempDiagLabel.canValidate := False;
  //TempDiagLabel.ClinicStatus.Fill.Bitmap.Assign(FmxControls.frmFmxControls.Rectangle10.Fill.Bitmap);

  if  (Assigned(TempDiagLabel.diag)) and (TempDiagLabel.diag.DataPos > 0) then
  begin

    TempDiagLabel.edtMain.Text := TempDiagLabel.diag.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(Diagnosis_code_CL011));
    TempDiagLabel.edtAdd.Text := TempDiagLabel.diag.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, word(Diagnosis_additionalCode_CL011));
    mkbPos := TempDiagLabel.diag.getCardMap(FAspAdbBuf, FAspAdbPosData, word(Diagnosis_MkbPos));
    if mkbPos > 100 then
    begin
      TempDiagLabel.mmoDiag.Text := Adb_dm.CollMkb.getAnsiStringMap(mkbPos, word(Mkb_NAME));
      mkbNote := Adb_dm.CollMkb.getAnsiStringMap(mkbPos, word(Mkb_NOTE));
      if TempDiagLabel.txtMain <> nil then
      begin
        if mkbNote.Contains('*') then
        begin
          caption:= 'ddd';
          TempDiagLabel.txtMain.Text := 'МКБ†';
          TempDiagLabel.SelectAdd.Enabled := True;
          arrstr := mkbNote.Split(['(', ')']);
          //ls := TStringList.Create;
//            for i := 0 to Length(arrstr) - 1 do
//            begin
//              if arrstr[i].EndsWith('*') then
//              begin
//                ls.Add(arrstr[i].Replace('*', ''));
//              end;
//            end;
        end
        else
        begin
          TempDiagLabel.txtMain.Text := 'МКБ';
          TempDiagLabel.SelectAdd.Enabled := False;
        end;
      end;
    end
    else
      TempDiagLabel.mmoDiag.Text := '100';
  end
  else
  begin
    //TempDiagLabel.edtMain.Text := '';
    //TempDiagLabel.edtAdd.Text := '';
  end;
  TempDiagLabel.canValidate := true;
end;

procedure TfrmProfFormFMX.rctIconPlanedTypeClick(Sender: TObject);
var
  rctIcon: TRectangle;
  rctPlane: TRectangle;
  TempPlanedTypeLabel: TPlanedTypeLabel;
  nodePlan: PVirtualNode;
  dataPlan, dataPat, dataPreg: PAspRec;
  cl132Key, cl136Key: string;
  cl132pos: Cardinal;
  linkMdn, linkAnal: PVirtualNode;
  mdn: TRealMDNItem;
  anal: TRealExamAnalysisItem;
  j, k: Integer;
  pCardinalData: PCardinal;
  dataPosition: Cardinal;
begin
  rctIcon := TRectangle(Sender);
  rctPlane := TRectangle(rctIcon.parent.Parent);
  TempPlanedTypeLabel := TPlanedTypeLabel(rctPlane.TagObject);
  nodePlan := TempPlanedTypeLabel.nodePlan;
  dataPlan := Pointer(PByte(nodePlan) + lenNode);
  cl132Key := ADB_DM.CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
  cl132pos := ADB_DM.CollNZIS_PLANNED_TYPE.getCardMap(dataPlan.DataPos, word(NZIS_PLANNED_TYPE_CL132_DataPos));
  cl136Key := ADB_DM.Cl132Coll.getAnsiStringMap(cl132pos, word(CL132_CL136_Mapping));

  if nodePlan.CheckState <> csUncheckedNormal then
  begin
    nodePlan.CheckState := csUncheckedNormal;//премахване

  end
  else
  begin
    nodePlan.CheckState := csCheckedNormal; //добавяне

  end;
  if Assigned(FOnReShowProfForm)  then
  begin
    dataPat := Pointer(PByte(FPregled.FNode.Parent) + lenNode);
    dataPreg := Pointer(PByte(FPregled.FNode) + lenNode);
    if (FPregled.PRecord = nil) and (dataPreg.index > -1) then
    begin
      //Adb_dm.CollPregled.Delete(dataPreg.index);
    end;

    FOnReShowProfForm(dataPat, dataPreg, FPregled.FNode);
  end;

    //ClearBlanka;
//    FillProfActivityPreg(FPregled.FNode);
//    dataPat := Pointer(PByte(FPregled.FNode.Parent) + lenNode);
//    FillRightLYT(dataPat);
end;

procedure TfrmProfFormFMX.scldlyt1Resize(Sender: TObject);
begin
  if scldlyt1.Position.Y <> 0 then
  begin
    Caption := 'dd';
  end;
end;

procedure TfrmProfFormFMX.scrlbx1CalcContentBounds(Sender: TObject;
  var ContentBounds: TRectF);
begin
  ContentBounds := scldlyt1.BoundsRect;
  //ContentBounds := expndrMdns.BoundsRect;
end;

procedure TfrmProfFormFMX.scrlbx1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  scrlbx1.Cursor := crHandPoint;
  //Self.Cursor := crHandPoint;
end;

procedure TfrmProfFormFMX.scrlbx1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single);
begin
  //btn1.Text := FloatToStr(y);
end;

procedure TfrmProfFormFMX.scrlbx1MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
var
  tempH: Single;
  delta: Integer;
  vScrol, hScrol: TScrollBar;
  pf1, pf2, tempPf: TPointF;
  scaleFactor: Single;
begin
  if ssCtrl in Shift then
  begin
    tempH := scldlyt1.Height;
    tempPf := scrlbx1.ViewportPosition;
    pf2 := Screen.MousePos;

    pf2 := self.ScreenToClient(pf2);
    pf2 := scldlyt1.AbsoluteToLocal(pf2);
    pf2.X := pf2.X / scaleDyn;
    pf2.y := pf2.y / scaleDyn;
    if Sender = self then
    begin
      scaleFactor := 1.1;
    end
    else
    begin
      scaleFactor := Integer(Sender)/1000;
    end;
    if WheelDelta> 0 then
    begin
      tempH  := scldlyt1.Height * scaleFactor;
      scaleDyn := tempH / scldlyt1.OriginalHeight;
      scldlyt1.Width := scldlyt1.Width * scaleFactor;
      scldlyt1.Height := scldlyt1.Height * scaleFactor;
    end
    else
    begin
      tempH  := scldlyt1.Height / scaleFactor;
      scaleDyn := tempH / scldlyt1.OriginalHeight;
      scldlyt1.Width := scldlyt1.Width / scaleFactor;
      scldlyt1.Height := scldlyt1.Height / scaleFactor;
    end;
    Handled := True;
    pf1 := Screen.MousePos;

    pf1 := self.ScreenToClient(pf1);
    pf1 := scldlyt1.AbsoluteToLocal(pf1);
    pf1.X := pf1.X / scaleDyn;
    pf1.y := pf1.y / scaleDyn;
    //rctSelector.Parent := scldlyt1;
    //rctSelector.Position.Point := pf1;


    //mmoAddres.Text := pf.X.ToString();
    //scrlbx1.ViewportPosition := PointF(pf.x * scaleDyn, pf.y * scaleDyn);
    if Sender = self then
    begin
      scrlbx1.BeginUpdate;
      scrlbx1.FindStyleResource<TScrollBar>('vscrollbar', vScrol);
      scrlbx1.FindStyleResource<TScrollBar>('hscrollbar', hScrol);
      vScrol.Value := scrlbx1.ViewportPosition.y + (-pf1.y * scaleDyn + pf2.y* scaleDyn);
      hScrol.Value := scrlbx1.ViewportPosition.x + (-pf1.x * scaleDyn + pf2.x* scaleDyn);
     // pf := mmoAddres.AbsoluteToLocal(pf);
      //vScrol.Value := rctSelector.LocalToAbsolute(Pointf(0,0)).y  + scrlbx1.ViewportPosition.y;
      //vScrol.Value := pf.y;// + scrlbx1.ViewportPosition.y;

      //hScrol.Value :=  mmoAddres.LocalToAbsolute(Pointf(pf.x,0)).x - pf.x + scrlbx1.ViewportPosition.x;
      //hScrol.Value := pf.x/ scaleDyn;// + scrlbx1.ViewportPosition.x;

      //txtTest.Text := Format('%f',  [scrlbx1.LocalToAbsolute(pf1).y * scaleDyn]);
      txtTest.Text := Format('%f',  [scaleDyn]);
      //vScrol.Value := scrlbx1.LocalToAbsolute(pf).y;
      //mmoAddres.Text := (tempPf.X - scrlbx1.ViewportPosition.X).ToString();
      scrlbx1.EndUpdate;
    end;
  end
  else
  begin
    scrlbx1.FindStyleResource<TScrollBar>('vscrollbar', vScrol);

    if WheelDelta> 0 then
    begin
      vScrol.Value := vScrol.Value - 20 * scaleDyn;
    end
    else
    begin
      vScrol.Value := vScrol.Value + 20 * scaleDyn;
    end;
    Handled := True;

  end;
  if p2.IsOpen then
    p2.IsOpen := False;
  p2.Scale.x := scaleDyn;
  p2.Scale.y := scaleDyn;

  if dtdtStartDateTime.IsPickerOpened then
    dtdtStartDateTime.ClosePicker;

  PositionPopup;
end;

procedure TfrmProfFormFMX.scrlbx1Resize(Sender: TObject);
begin
  //scldlyt1.OriginalWidth := Self.Width - 50  ;
  //scldlyt1.Width := scldlyt1.OriginalWidth * FScaleDyn;
  slctnpnt2.Position.X := scldlyt1.OriginalWidth;
end;

procedure TfrmProfFormFMX.scrlbx1ViewportPositionChange(Sender: TObject;
  const OldViewportPosition, NewViewportPosition: TPointF;
  const ContentSizeChanged: Boolean);
var
  p1, p0: TPointF;
  vScrol: TScrollBar;
begin
  scrlbx1.FindStyleResource<TScrollBar>('vscrollbar', vScrol);
  //p0 := (Self.ClientRect.TopLeft).MidPoint(Self.ClientRect.BottomRight);
  p1 := vScrol.AbsoluteToLocal(PointF(0, (vScrol.Height) /2/scaleDyn + vScrol.Value/scaleDyn - lytbottom.Position.y/scaleDyn));
  slctnpnt3.Position.Point := PointF(slctnpnt3.Position.X ,p1.y);
  //txt1.Text := Format('%f,   %f',  [NewViewportPosition.y, p1.y]);
  //slctnpnt3.Position := scrlbx1.con
  //txtTest.Text := Format('%f',  [mmoAddres.Position.y * scaleDyn]);
end;



procedure TfrmProfFormFMX.SetAdb_dm(const Value: TADBDataModule);
begin
  FAdb_dm := Value;
  frmFmxControls.Adb_DM := FAdb_dm;
end;

procedure TfrmProfFormFMX.SetCheckKep(const Value: boolean);
begin
  FCheckKep := Value;
  if FCheckKep then
  begin

  end
  else
  begin
    CheckKepCounter := -1;
  end;
end;

procedure TfrmProfFormFMX.SetCheckKepCounter(const Value: Integer);
var
  oldStatus, NewStatus: Word;

begin
  FCheckKepCounter := Value;
  if FCheckKepCounter = -1 then //  проверете подписа
  begin
    if animNrnStatus.Pause then
    begin
      linStatusNRN.Opacity := 1;

    end;
    animNrnStatus.Start;
    inc(FCheckKepCounter);
    txtNzisStatus.Text := 'Проверете КЕП';
    linStatusNRN.Stroke.Color := $FF454BE3;
  end;
end;

procedure TfrmProfFormFMX.SetExpanderVisitForHeight;
begin
  //lyt
  xpdrVisitFor.Height := flwlytVizitFor.Height  + lytVisitForHeader.Height + 5;
end;

procedure TfrmProfFormFMX.SetPatientColl(const Value: TRealPatientNewColl);
begin
  FPatientColl := Value;
  //FPatient := TRealPatientNewItem(FPatientColl.Add);
  //edtEGN.TagObject := FPatient;
end;

procedure TfrmProfFormFMX.SetPregled(const Value: TRealPregledNewItem);
begin
  FPregled := Value;
  Memo1.Text := IntToStr(Adb_dm.CollPregled.Count);
end;

procedure TfrmProfFormFMX.SetPregledColl(const Value: TRealPregledNewColl);
begin
  FPregledColl := Value;
  FPregled := TRealPregledNewItem(FPregledColl.Add);
end;

procedure TfrmProfFormFMX.SetScaleDyn(const Value: Single);
begin
  FScaleDyn := Value;
end;

procedure TfrmProfFormFMX.SetSourceAnswerDefault(const Value: TSourceAnsw);
var
  TempComboLabel: TComboOneLabel;
  TempMemoLabel: TMemoLabel;
  TempCheckLYT: TLayoutCheck;
  TempDateEditLabel: TDateEditLabel;
  TempEditLabel: TEditLabel;
  TempComboMultiLabel: TComboMultiLabel;

  i: Integer;
  runNode, runAnswQuest: PVirtualNode;
  data, dataAnsw: PAspRec;
begin
  FSourceAnswerDefault := Value;
  runNode := FPregled.FNode.FirstChild ;
  while runNode <> nil do
  begin
    data := Pointer(PByte(runNode) + lenNode);
    if data.vid <> vvNZIS_PLANNED_TYPE then  //  не са планове
    begin
      runNode := runNode.NextSibling;
      Continue;
    end;
    runAnswQuest := runNode.FirstChild;
    while runAnswQuest <> nil do
    begin
      dataAnsw := Pointer(PByte(runAnswQuest) + lenNode);
      if dataAnsw.vid <> vvNZIS_QUESTIONNAIRE_RESPONSE then  // не е въпросник
      begin
        runAnswQuest := runAnswQuest.NextSibling;
        Continue;
      end;
      runAnswQuest.Dummy := Byte(FSourceAnswerDefault);
      runAnswQuest := runAnswQuest.NextSibling;
    end;
    runNode := runNode.NextSibling;
  end;

  for i := 0 to LstOneCombosLYT.Count - 1 do
  begin
    TempComboLabel := TComboOneLabel(LstOneCombosLYT[i].TagObject);
    if (TempComboLabel.SourceAnsw = TSourceAnsw.saNone) and (TempComboLabel.rctSourceAnsw.Visible) then
    begin
      MarkSourceAnsw(TempComboLabel.SourceAnsw, TempComboLabel.rctSourceAnsw);
    end;
  end;
  for i := 0 to LstMemosLYT.Count - 1 do
  begin
    TempMemoLabel := TMemoLabel(LstMemosLYT[i].TagObject);
    if (TempMemoLabel.SourceAnsw = TSourceAnsw.saNone) and (TempMemoLabel.rctSourceAnsw.Visible) then
    begin
      MarkSourceAnsw(TempMemoLabel.SourceAnsw, TempMemoLabel.rctSourceAnsw);
    end;
  end;
  for i := 0 to LstChecksSup.Count - 1 do
  begin
    TempCheckLYT := TLayoutCheck(LstChecksSup[i].TagObject);
    if (TempCheckLYT.SourceAnsw = TSourceAnsw.saNone) and (TempCheckLYT.rctSourceAnsw.Visible) then
    begin
      MarkSourceAnsw(TempCheckLYT.SourceAnsw, TempCheckLYT.rctSourceAnsw);
    end;
  end;
  for i := 0 to LstDateEditsLyt.Count - 1 do
  begin
    TempDateEditLabel := TDateEditLabel(LstDateEditsLyt[i].TagObject);
    if (TempDateEditLabel.SourceAnsw = TSourceAnsw.saNone) and (TempDateEditLabel.rctSourceAnsw.Visible) then
    begin
      MarkSourceAnsw(TempDateEditLabel.SourceAnsw, TempDateEditLabel.rctSourceAnsw);
    end;
  end;
  for i := 0 to LstMultiCombosLYT.Count - 1 do
  begin
    TempComboMultiLabel := TComboMultiLabel(LstMultiCombosLYT[i].TagObject);
    if (TempComboMultiLabel.SourceAnsw = TSourceAnsw.saNone) and (TempComboMultiLabel.rctSourceAnsw.Visible) then
    begin
      MarkSourceAnsw(TempComboMultiLabel.SourceAnsw, TempComboMultiLabel.rctSourceAnsw);
    end;
  end;
  for i := 0 to LstEditsLyt.Count - 1 do
  begin
    TempEditLabel := TEditLabel(LstEditsLyt[i].TagObject);
    if (TempEditLabel.SourceAnsw = TSourceAnsw.saNone) and (TempEditLabel.rctSourceAnsw.Visible) then
    begin
      MarkSourceAnsw(TempEditLabel.SourceAnsw, TempEditLabel.rctSourceAnsw);
    end;
  end;
end;

procedure TfrmProfFormFMX.slctnpnt1Track(Sender: TObject; var X, Y: Single);
var
  tempW: Single;
begin
  Exit;
  xpdrPatient.Width := x - xpdrPatient.Margins.Left;
  tempW := xpdrPatient.Margins.Left + xpdrPatient.Width + xpdrPatient.Margins.Right +
           xpdrDoctor.Margins.Left + xpdrDoctor.Width + xpdrDoctor.Margins.Right;
  mmoAddres.Height := max(mmoAddres.ContentBounds.Height + 5, 22);
  lytTop.Height := mmoAddres.Height + lblAddres.Height + 100;

end;

procedure TfrmProfFormFMX.slctnpnt2Track(Sender: TObject; var X, Y: Single);
var
  tempW: Single;
begin
  slctnpnt2.Position.X := x/ FScaleDyn;
  scldlyt1.OriginalWidth := x  ;
  scldlyt1.Width := x * FScaleDyn;
end;

procedure TfrmProfFormFMX.Text10Painting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  txt: TText;
  IncNaprlog: TlogicalINC_NAPRSet;
  dataInkNapr: PAspRec;
begin
  txt := TText(sender);
  dataInkNapr := Pointer(PByte(pregNodes.incNaprNode) + lenNode);
  IncNaprlog := TlogicalINC_NAPRSet(Adb_dm.CollIncMN.getLogical24Map(dataInkNapr.DataPos, Word(INC_NAPR_Logical)));
  if category_R2 in IncNaprlog then
    txt.Text := 'Бланка 3'
  else
  if category_R3 in IncNaprlog then
    txt.Text := 'Бланка 3A'
  else
  if category_R5 in IncNaprlog then
    txt.Text := 'Бланка 6'
  else
end;

procedure TfrmProfFormFMX.TextClinicStatusPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  TempRect: TRectangle;
  TempDiagLabel: TDiagLabel;
  log16: TlogicalDiagnosisSet;
  logstat: TlogicalDiagnosis;
  str: string;
begin
  TempRect := TRectangle(TControl(Sender).Parent.Parent.Parent.Parent);
  TempDiagLabel := TDiagLabel(TempRect.TagObject);
  if TempDiagLabel.diag = nil then
  begin
    TText(Sender).Text := '';
    Exit;
  end;
  log16 := TlogicalDiagnosisSet(Adb_dm.CollDiag.getLogical16Map(TempDiagLabel.diag.DataPos, word(Diagnosis_Logical)));
  if log16 <> [] then
  begin
    logStat := TRealDiagnosisColl.GetClinicStatus(log16);

    case logStat of
      TlogicalDiagnosis(-1): str := 'neznam';
      ClinicalStatus_Active: str := 'Активен';
      ClinicalStatus_Recurrence: str := 'Активен - Повторно проявяване';
      ClinicalStatus_Relapse: str := 'Активен - В рецидив';
      ClinicalStatus_Inactive: str := 'Неактивен';
      ClinicalStatus_Remission: str := 'Неактивен - В ремисия';
      ClinicalStatus_Resolved: str := 'Неактивен - Решен';
    else
      raise Exception.Create('Не може да има повече от един клиничен статус!');
    end;
  end
  else
  begin
    str := 'neznam';
  end;

  TText(Sender).Stretch := (Canvas.TextWidth(str) > (ARect.Width - 5));
  TText(Sender).Text := str;
end;

procedure TfrmProfFormFMX.txtAddDiagLabelResize(Sender: TObject);
begin
  Caption := FloatToStr(txtAddDiagLabel.Height);
end;

procedure TfrmProfFormFMX.txtAmbListPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  txt: TText;
  ambNom: integer;
  amnNRN: string;
begin
  txt := TText(sender);
  ambNom := FPregled.getIntMap(FAspAdbBuf, FAspAdbPosData, Word(PregledNew_AMB_LISTN));
  amnNRN := FPregled.getAnsiStringMap(FAspAdbBuf, FAspAdbPosData, Word(PregledNew_NRN_LRN));

  txt.Text := Format('АМБУЛАТОРЕН ЛИСТ  № %d НРН %s', [ambNom, amnNRN]);
  //dtdtStartDate.Position.Point := PointF(txt.Width + 10, 5);

end;

procedure TfrmProfFormFMX.txtAmbListResize(Sender: TObject);
begin
  //dtdtStartDate.Repaint;
  //dtdtStartDate.Position.Point := PointF(txtAmbList.BoundsRect.Right + 10, 5);
end;

procedure TfrmProfFormFMX.txtIsPrimaryPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  txt: TText;
  Preglog: TlogicalPregledNewSet;
  dataPreg: PAspRec;
  vtorNRN: string;
begin
  txt := TText(sender);

  dataPreg := Pointer(PByte(pregNodes.pregNode) + lenNode);
  Preglog := TlogicalPregledNewSet(Adb_dm.CollPregled.getLogical40Map(dataPreg.DataPos, Word(pregledNew_Logical)));
  if TLogicalPregledNew.IS_PRIMARY in Preglog then
    txt.Text := 'Първичен'
  else
  begin
    vtorNRN := Adb_dm.CollPregled.getAnsiStringMap(dataPreg.DataPos, Word(PregledNew_COPIED_FROM_NRN));
    txt.Text := 'Вторичен: ' + vtorNRN;
  end;
end;

procedure TfrmProfFormFMX.txtMainDiagDragDrop(Sender: TObject;
  const Data: TDragObject; const Point: TPointF);
begin
  //
end;

procedure TfrmProfFormFMX.txtMainDiagDragEnter(Sender: TObject;
  const Data: TDragObject; const Point: TPointF);
begin
  //
end;

procedure TfrmProfFormFMX.txtMainDiagDragOver(Sender: TObject;
  const Data: TDragObject; const Point: TPointF; var Operation: TDragOperation);
begin
  Operation := TDragOperation.Move;
end;

procedure TfrmProfFormFMX.txtMkbMdnPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  TempLyt: TLayout;
  TempMdnsLabel: TMdnsLabel;
  run, runDiag: PVirtualNode;
  dataRun: PAspRec;

begin
  TempLyt := TLayout(TEdit(Sender).Parent.Parent);
  TempMdnsLabel := TMdnsLabel(TempLyt.TagObject);
  runDiag := nil;
  if TempMdnsLabel.LinkMdn = nil then
  begin
    TEdit(Sender).Text := '';
    Exit;
  end;

  run := TempMdnsLabel.LinkMdn.FirstChild;
  while run <> nil do
  begin
    dataRun := Pointer(PByte(run) + lenNode);
    if dataRun.vid = vvDiag then
    begin
      runDiag := run;
      Break;
    end;
    run := run.NextSibling;
  end;
  if runDiag <> nil then
  begin
    TEdit(Sender).Text := Adb_dm.CollDiag.getAnsiStringMap(dataRun.DataPos, word(Diagnosis_code_CL011));
  end
  else
  begin
    TEdit(Sender).Text := IntToStr(TempMdnsLabel.LinkMdn.Dummy);
  end;
end;

procedure TfrmProfFormFMX.txtNaprTypePainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  txt: TText;
  IncNaprlog: TlogicalINC_NAPRSet;
  dataInkNapr: PAspRec;
  intSet: TNaprType;
begin

  if pregNodes.incNaprNode = nil  then Exit;

  txt := TText(sender);
  dataInkNapr := Pointer(PByte(pregNodes.incNaprNode) + lenNode);
  IncNaprlog := TlogicalINC_NAPRSet(Adb_dm.CollIncMN.getLogical24Map(dataInkNapr.DataPos, Word(INC_NAPR_Logical)));
  //intSet := IncNaprColl.GetNaprCode_Quick(IncNaprlog);
  intSet := NativeUInt(NaprGroup * IncNaprLog);
  case intSet of
    TNaprType(NaprMask_Ostro): txt.Text := 'Остро заболяване или състояние извън останалите типове';
    TNaprType(NaprMask_Hron): txt.Text := 'Хронично заболяване, неподлежащо на диспансерно наблюдение';
    TNaprType(NaprMask_Izbor): txt.Text := 'Избор на специалист за диспансерно наблюдение';
    TNaprType(NaprMask_Disp): txt.Text := 'Диспансерно наблюдение';
    TNaprType(NaprMask_Eksp): txt.Text := 'Медицинска експертиза';
    TNaprType(NaprMask_Prof): txt.Text := 'Профилактика нa пълнолетни лица';
    TNaprType(NaprMask_Iskane_Telk): txt.Text := 'По искане на ТЕЛК (НЕЛК)';
    TNaprType(NaprMask_Choice_Mother): txt.Text := 'Избор на специалист за майчино здравеопазване';
    TNaprType(NaprMask_Choice_Child): txt.Text := 'Избор на специалист за детско здравеопазване';
    TNaprType(NaprMask_PreChoice_Mother): txt.Text := 'Преизбор на специалист за майчино здравеопазване';
    TNaprType(NaprMask_PreChoice_Child): txt.Text := 'Преизбор на специалист за детско здравеопазване';
    TNaprType(NaprMask_Podg_Telk): txt.Text := 'Подготовка за ТЕЛК';
    TNaprType(NaprMask_Podg_LKK): txt.Text := 'Подготовка за ЛКК';
  else
    txt.Text := 'Непознат тип';
  end;
end;

procedure TfrmProfFormFMX.txtNzisStatusPainting(Sender: TObject;
  Canvas: TCanvas; const ARect: TRectF);
begin
  txtNzisStatus.TextSettings.FontColor := linStatusNRN.Stroke.Color;

end;



procedure TfrmProfFormFMX.txtRczRPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
 var
   data: PAspRec;
   AddresLinkPos: integer;
begin
  if patNodes.addresses.Count > 0 then
  begin
    data := Pointer(pbyte(patNodes.addresses[0]) + lenNode);
    AddresLinkPos := NasMesto.addresColl.getIntMap(data.DataPos, word(Addres_LinkPos));
    txtRczR.Text := 'РЗОК №| здр. район ' + NasMesto.nasMestoColl.getAnsiStringMap(AddresLinkPos, word(NasMesto_RCZR));

  end
  else
  begin
    txtRczR.Text := 'РЗОК №| здр. район 00|00'
  end;

  //FPatient.
end;

procedure TfrmProfFormFMX.VibroControl(node: PVirtualNode);
var
  i: Integer;
  TempCheckLYT: TLayoutCheck;
  TempCheck: TCheckBox;
  TempMemoLYT: TLayout;
  TempMemoLabel: TMemoLabel;
  TempComboLYT: TLayout;
  TempComboLabel: TComboOneLabel;
  TempComboLYTM: TLayout;
  TempComboLabelM: TComboMultiLabel;
  TempEditLYT: TLayout;
  TempEditLabel: TEditLabel;
  TempDateEditLyt: TLayout;
  TempDateEditLabel: TDateEditLabel;

  vScrol: TScrollBar;
begin
  for I := 0 to LstChecksSup.Count - 1 do
  begin
    TempCheck := LstChecksSup[i];
    if TempCheck.Parent = nil then
      Continue;
    TempCheckLYT := TLayoutCheck(TempCheck.TagObject);
    if TempCheckLYT.node = node then
    begin
      scrlbx1.FindStyleResource<TScrollBar>('vscrollbar', vScrol);
      vScrol.Value := LstChecksSup[i].LocalToAbsolute(Point(0,0)).Y + scrlbx1.ViewportPosition.y;
      rctSelector.Parent := TempCheck;
      rctSelector.Align := TAlignLayout.Client;
      Exit;
    end;
  end;
  for I := 0 to LstMemosLYT.Count - 1 do
  begin
    TempMemoLYT := LstMemosLYT[i];

    if TempMemoLYT.Parent = nil then
      Continue;
    TempMemoLabel:= TMemoLabel(LstMemosLYT[i].TagObject);
    if TempMemoLabel.node = node then
    begin
      scrlbx1.FindStyleResource<TScrollBar>('vscrollbar', vScrol);
      vScrol.Value := TempMemoLabel.chk.LocalToAbsolute(Point(0,0)).Y + scrlbx1.ViewportPosition.y;
      rctSelector.Parent := TempMemoLabel.chk;
      rctSelector.Align := TAlignLayout.Client;
      Exit;
    end;
  end;
  for I := 0 to LstOneCombosLYT.Count - 1 do
  begin
    TempComboLYT := LstOneCombosLYT[i];
    if TempComboLYT.Parent = nil then
      Continue;
    TempComboLabel := TComboOneLabel(TempComboLYT.TagObject);
    if TempComboLabel.node = node then
    begin
      scrlbx1.FindStyleResource<TScrollBar>('vscrollbar', vScrol);
      vScrol.Value := TempComboLabel.chk.LocalToAbsolute(Point(0,0)).Y + scrlbx1.ViewportPosition.y;
      rctSelector.Parent := TempComboLabel.chk;
      rctSelector.Align := TAlignLayout.Client;
      Exit;
    end;
  end;
  for I := 0 to LstMultiCombosLYT.Count - 1 do
  begin
    TempComboLYTM := LstMultiCombosLYT[i];
    if TempComboLYTM.Parent = nil then
      Continue;
    TempComboLabelM := TComboMultiLabel(TempComboLYTM.TagObject);
    if TempComboLabelM.node = node then
    begin
      scrlbx1.FindStyleResource<TScrollBar>('vscrollbar', vScrol);
      vScrol.Value := TempComboLabelM.chk.LocalToAbsolute(Point(0,0)).Y + scrlbx1.ViewportPosition.y;
      rctSelector.Parent := TempComboLabelM.chk;
      rctSelector.Align := TAlignLayout.Client;
      Exit;
    end;
  end;
  for I := 0 to LstEditsLyt.Count - 1 do
  begin
    TempEditLYT := LstEditsLyt[i];
    if TempEditLYT.Parent = nil then
      Continue;
    TempEditLabel := TEditLabel(TempEditLYT.TagObject);
    if TempEditLabel.node = node then
    begin
      scrlbx1.FindStyleResource<TScrollBar>('vscrollbar', vScrol);
      vScrol.Value := TempEditLabel.chk.LocalToAbsolute(Point(0,0)).Y + scrlbx1.ViewportPosition.y;
      rctSelector.Parent := TempEditLabel.chk;
      rctSelector.Align := TAlignLayout.Client;
      Exit;
    end;
  end;
  for I := 0 to LstDateEditsLyt.Count - 1 do
  begin
    TempDateEditLyt := LstDateEditsLyt[i];
    if TempDateEditLyt.Parent = nil then
      Continue;
    TempDateEditLabel := TDateEditLabel(TempDateEditLyt.TagObject);
    if TempDateEditLabel.node = node then
    begin
      scrlbx1.FindStyleResource<TScrollBar>('vscrollbar', vScrol);
      vScrol.Value := TempDateEditLabel.chk.LocalToAbsolute(Point(0,0)).Y + scrlbx1.ViewportPosition.y;
      rctSelector.Parent := TempDateEditLabel.chk;
      rctSelector.Align := TAlignLayout.Client;
      Exit;
    end;
  end;
end;

procedure TfrmProfFormFMX.WmHelp(mousePos: TPoint);
var
  p: TPointF;
  Cntrl: IControl;
  StyledCtrl: TStyledControl;
  li: TListBoxItem;
begin

  if p1.IsOpen then
  begin
    Cntrl := TControlProt(p1).ObjectAtPoint(mousePos);
    if Cntrl.GetObject is TStyledControl then
    begin
      StyledCtrl := TStyledControl(Cntrl.GetObject);
      if StyledCtrl.ClassName.StartsWith('TStyled', true) then
      begin
        ShowMessage(IntToStr(TStyledControl(StyledCtrl.parent).HelpContext));
      end
      else
      begin
        ShowMessage(IntToStr(StyledCtrl.HelpContext));
      end;
    end
    else
    begin
      //TControl(Cntrl.GetObject).GetNamePath
      ShowMessage(Cntrl.GetObject.TagString);
    end;
  end
  else
  begin
    Cntrl := self.ObjectAtPoint(MousePos);
    if Cntrl.GetObject is TStyledControl then
    begin
      StyledCtrl := TStyledControl(Cntrl.GetObject);
      if StyledCtrl.ClassName.StartsWith('TStyled', true) then
      begin
        ShowMessage(IntToStr(TStyledControl(StyledCtrl.parent).HelpContext));
      end
      else
      begin
        ShowMessage(IntToStr(StyledCtrl.HelpContext));
      end;
    end
    else
    begin
      //TControl(Cntrl.GetObject).GetNamePath
      ShowMessage(Cntrl.GetObject.TagString);
    end;
  end;
end;

procedure TfrmProfFormFMX.xpdrDiagnDragOver(Sender: TObject;
  const Data: TDragObject; const Point: TPointF; var Operation: TDragOperation);
begin
  //
end;

procedure TfrmProfFormFMX.xpdrDiagnResize(Sender: TObject);
var
  h: Single;
begin
  if xpdrDiagn.IsExpanded then
  begin
    rctDiag.Width := lytDiag.Width;
    rctAddDiaglabel.Width := lytDiag.Width;
    lytDiag.RecalcSize;
    h := InnerChildrenRect(lytDiag).Height/FScaleDyn ;
    lytDiag.Height := h;
    if idxDiags = 0 then
    begin
      xpdrDiagn.Height := h + 30+10+6 + 20 - 30; //lytDiag.Margins.Top+ lytDiag.Margins.Top;
    end
    else
    begin
      xpdrDiagn.Height := h + 30+10+6 + 20;
    end;
    //if h = 0 then
//    begin
//      xpdrDiagn.Height := 35;
//    end
//    else
//    begin
//      if rctBtnAddImun.Tag = 0 then
//      begin
//
//
//      end
//      else
//      begin
//        xpdrDiagn.Height := h + lytDiag.Margins.Top+ lytDiag.Margins.Top;
//      end;
//    end;
    lytDiagFrame.Height := xpdrDiagn.Height + 30;
    RecalcBlankaRect1;
  end
  else
  begin
    xpdrDiagn.Height := 55;
    lytDiagFrame.Height := xpdrDiagn.Height + 30;
    RecalcBlankaRect1;

  end;
end;

procedure TfrmProfFormFMX.xpdrDiagnResize1(Sender: TObject);
var
  i: Integer;
begin
  if xpdrDiagn.IsExpanded then
  begin
    rctAddDiaglabel.Width := lytDiag.Width  - lytDiag.Padding.Left - lytDiag.Padding.Right ;
    rctDiag.Width := lytDiag.Width  - lytDiag.Padding.Left - lytDiag.Padding.Right ;
    rctMainDiaglabel.Width := lytDiag.Width  - lytDiag.Padding.Left - lytDiag.Padding.Right ;
    for i := 0 to LstDiags.Count - 1 do
    begin
      LstDiags[i].Width := lytDiag.Width  - lytDiag.Padding.Left - lytDiag.Padding.Right ;
    end;

    RecalcBlankaRect1;
  end
  else
  begin
    xpdrDiagn.Height := 55;
    lytDiagFrame.Height := xpdrDiagn.Height + 30;
    RecalcBlankaRect1;
  end;
end;

procedure TfrmProfFormFMX.xpdrDoctorClick(Sender: TObject);
begin
  //
end;

procedure TfrmProfFormFMX.xpdrDoctorPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  //txt: TText;
  Preglog: TlogicalPregledNewSet;
  dataPreg: PAspRec;
begin
  //txt := TText(xpdrDoctor.Text);
  dataPreg := Pointer(PByte(pregNodes.pregNode) + lenNode);
  Preglog := TlogicalPregledNewSet(Adb_dm.CollPregled.getLogical40Map(dataPreg.DataPos, Word(pregledNew_Logical)));
  if TLogicalPregledNew.IS_EXPERTIZA in Preglog then
    xpdrDoctor.Text := 'ЛКК'
  else
    xpdrDoctor.Text := 'Лекар';
end;

procedure TfrmProfFormFMX.xpdrPatientExpanded(Sender: TObject);
var
  h1: Single;
begin
  xpdrDoctor.IsExpanded := xpdrPatient.IsExpanded;
  if xpdrDoctor.IsExpanded then
  begin
    txtCalcMemo.MaxSize := PointF(mmoAddres.Width -2, 100000);
    txtCalcMemo.Text := mmoAddres.Text;
    mmoAddres.Height := txtCalcMemo.Height + 5;
    h1 := mmoAddres.Position.Y + mmoAddres.Height +30;
    lytTop.Height := xpdrPatient.Position.Y + h1 +0;
  end
  else
  begin
    lytTop.Height := xpdrPatient.Position.Y + xpdrPatient.Height +0;
  end;
end;

procedure TfrmProfFormFMX.xpdrVisitForClick(Sender: TObject);
begin
  //
end;

procedure TfrmProfFormFMX.xpdrVisitForPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  flwlytVizitFor.Margins.Top := lytVisitForHeader.Height - 25 + 5;

end;

procedure TfrmProfFormFMX.xpdrVisitForResize(Sender: TObject);
var
  lytLeftHeight, lytRightHeight, delta: Single;
begin
  if xpdrVisitFor.IsUpdating then  Exit;

  if xpdrVisitFor.IsExpanded then
  begin
    lytVisitFor.Height := xpdrVisitFor.Height + xpdrVisitFor.Margins.Top;
    RecalcBlankaRect1;
  end
  else
  begin
    xpdrVisitFor.Height := lytVisitForHeader.Height + 5 + 5;
    //xpdrVisitFor.Height := 75;
    lytVisitFor.Height := xpdrVisitFor.Height + xpdrVisitFor.Margins.Top;
    RecalcBlankaRect1;

  end;
end;



procedure TfrmProfFormFMX.ZoomToWidth(W: single);
var
  handled: Boolean;
begin
  scrlbx1MouseWheel(Pointer(Round(((w-20)/scldlyt1.Width) * 1000)), [ssCtrl], 20, handled);
end;

{ TEditLabel }

constructor TEditLabel.Create;
begin
  nodeValue := nil;
  canValidate := True;
end;

{ TComboLabel }

constructor TComboLabel.Create;
begin
  nodeValue := nil;
  canValidate := True;
  MultiBtns := TList<TSpeedButton>.create;
  txt := nil;
  SourceAnsw := TSourceAnsw.saNone;
end;

destructor TComboLabel.destroy;
begin
  FreeAndNil(MultiBtns);
  inherited;
end;

function TComboLabel.GetNodeValueFromText(str: string; answValColl: TNZIS_ANSWER_VALUEColl): PVirtualNode;
var
  cl139: TCL139Item;
  i: Integer;
  StrKey, valKey: string;
  runValNode: PVirtualNode;
  dataValNode: PAspRec;
  answValTemp: TNZIS_ANSWER_VALUEItem;
begin
  Result := nil;
  if Self.node.ChildCount = 0 then  Exit;
  StrKey := Copy(str, 1, 5);
  answValTemp := TNZIS_ANSWER_VALUEItem.Create(nil);
  try
    runValNode := Self.node.FirstChild;
    while runValNode <> nil do
    begin
      dataValNode := Pointer(PByte(runValNode) + lenNode);
      case dataValNode.vid of
        vvNZIS_ANSWER_VALUE:
        begin
          answValTemp.DataPos := dataValNode.DataPos;
          valKey := answValTemp.getAnsiStringMap(answValColl.Buf, answValColl.posData, word(NZIS_ANSWER_VALUE_ANSWER_CODE));
          if StrKey = valKey then
          begin
            Result := runValNode;
            Exit;
          end;
        end;
      end;
      runValNode := runValNode.NextSibling;
    end;
  finally
    FreeAndNil(answValTemp);
  end;
end;

function TComboLabel.GetValuePosNomFromText(str: string): cardinal;
begin

end;



{ TMemoLabel }

constructor TMemoLabel.Create;
begin
  nodeValue := nil;
  canValidate := True;
  SourceAnsw := TSourceAnsw.saNone;
end;

{ TComboMultiLabel }

constructor TComboMultiLabel.Create;
begin
  inherited;
  MultiBtns := TList<TSpeedButton>.create;
end;

destructor TComboMultiLabel.destroy;
begin
  FreeAndNil(MultiBtns);
  inherited;
end;

function TComboMultiLabel.GetNodeValueFromText(str: string;
  answValColl: TNZIS_ANSWER_VALUEColl): PVirtualNode;
var
  cl139: TCL139Item;
  i: Integer;
  StrKey, valKey: string;
  runValNode: PVirtualNode;
  dataValNode: PAspRec;
  //answValTemp: TNZIS_ANSWER_VALUEItem;
begin
  Result := nil;
  if Self.node.ChildCount = 0 then  Exit;
  StrKey := Copy(str, 1, 5);
  //answValTemp := TNZIS_ANSWER_VALUEItem.Create(nil);
  try
    runValNode := Self.node.FirstChild;
    while runValNode <> nil do
    begin
      dataValNode := Pointer(PByte(runValNode) + lenNode);
      case dataValNode.vid of
        vvNZIS_ANSWER_VALUE:
        begin
          //answValTemp.DataPos := dataValNode.DataPos;
          valKey := answValColl.getAnsiStringMap(dataValNode.DataPos, word(NZIS_ANSWER_VALUE_ANSWER_CODE));
          //answValTemp.getAnsiStringMap(answValColl.Buf, answValColl.posData, word(NZIS_ANSWER_VALUE_ANSWER_CODE));
          if StrKey = valKey then
          begin
            Result := runValNode;
            Exit;
          end;
        end;
      end;
      runValNode := runValNode.NextSibling;
    end;
  finally
    //FreeAndNil(answValTemp);
  end;
end;


function TComboMultiLabel.GetValuePosNomFromText(str: string): cardinal;
begin

end;

{ TComboOneLabel }

constructor TComboOneLabel.Create;
begin
  inherited;
 // SourceAnsw := TSourceAnsw.saNone;
end;

{ TPlanedTypeLabel }

constructor TPlanedTypeLabel.create;
begin
end;

destructor TPlanedTypeLabel.destroy;
begin
  inherited;
end;



{ TWinCursorService }

class constructor TWinCursorService.Create;
begin
  FWinCursorService := TWinCursorService.Create;
  FCursorOverride := crDefault;

  FPreviousPlatformService := TPlatformServices.Current.GetPlatformservice(IFMXCursorService) as IFMXCursorService; // TODO: if not assigned

  TPlatformServices.Current.RemovePlatformService(IFMXCursorService);
  TPlatformServices.Current.AddPlatformService(IFMXCursorService, FWinCursorService);
end;

function TWinCursorService.GetCursor: TCursor;
begin
  result :=  FPreviousPlatformService.GetCursor;
end;

procedure TWinCursorService.SetCursor(const ACursor: TCursor);
begin

  if ACursor <= 0 then
  begin
    Winapi.Windows.SetCursor(Vcl.Forms.Screen.Cursors[ACursor]);

  end
  else
  begin
    Winapi.Windows.SetCursor(Vcl.Forms.Screen.Cursors[FCursorOverride]);
  end;
end;


class procedure TWinCursorService.SetCursorOverride(const Value: TCursor);
begin
  FCursorOverride := Value;
  TWinCursorService.FPreviousPlatformService.SetCursor(FCursorOverride);
end;

initialization

  Include(JclStackTrackingOptions, stRawMode);
  Include(JclStackTrackingOptions, stStaticModuleList);

  JclStartExceptionTracking;
end.
