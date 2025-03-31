unit DynWinPanel;
// if assigned  release 30   Tbrushv  pse  paint   mmoInplace.color  drawtext
//doublebu  DrawText  TList<TBaseControl        aspectDB  tab
interface



uses
  GR32, GR32_Resamplers, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms,
  Vcl.ExtCtrls, Vcl.Buttons,
  System.Generics.Collections, Vcl.StdCtrls, Winapi.Messages, Vcl.Graphics,
  Winapi.Windows, System.Math, System.Diagnostics, System.TimeSpan,
  Vcl.Dialogs, system.Types, Vcl.Themes, SizeGripMemo, DBCheckBoxResize,
  VirtualTrees, Winapi.CommCtrl, DynEditData, DynButtonData, DynLabelData,
  DynGroup, DynTabSet, DynDateTimePicker, ComboBoxHip,
  VirtualStringTreeAspect, Aspects.Types,

  Vcl.Imaging.GIFImg, Vcl.Imaging.pngimage ;


  const
  WM_Repaint_Wait = WM_USER + 10;

type
  TDynWinPanel = class;
  TDynGroupBox = class;
  TBaseControl = class;

  TFieldType = (ftAmbListNom, ftMainMkb, ftMainMkbAdd, ftDopMKB, ftDopMKBAdd);
  TDrawGroupButton = procedure(sender: TDynWinPanel; gb: TDynGroupBox;
           var ButonVisible: boolean; const numButton: integer; var imageIndex: Integer) of object;
  TGroupButtonClick = procedure(sender: TDynWinPanel; gb: TDynGroupBox;
           const numButton: integer) of object;

  TFilterButtonClick = procedure(sender: TDynWinPanel; ctrl: TBaseControl;
           FltrList: TFilterList) of object;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]


  TEditDyn = class(TEdit)

  end;



  TBaseControl = class(TObject)
  private
    FColIndex: Word;
    FIsMoved: Boolean;
    FParentGroup: TDynGroupBox;
    FPDataAspect: PAspRec;
    FDataAspect: TAspRec;
    procedure SetColIndex(const Value: Word);
    function GetName: string;virtual;
    procedure SetParentGroup(const Value: TDynGroupBox);
    procedure SetPDataAspect(const Value: PAspRec);
    //procedure SetIsMoved(const Value: Boolean);
  public
    FDynPanel: TDynWinPanel;
    GapBootom: Integer;
    FRect: TRect;
    FListChilds: TList<TBaseControl>;
    FListForMove: TList<TBaseControl>;
    FListBootoms: TList<Integer>;
    FieldType: TDynFieldType;
    TableType: TTablesTypeHip;
    RowIndex: Word;
    RectLabel: TRect;


  constructor create; dynamic;
  destructor destroy; override;

  procedure CalcForMove;dynamic;
  procedure MoveForMove(Offset: Integer);dynamic;

  property ColIndex: Word read FColIndex write SetColIndex;
  property Name: string read GetName;
  property PDataAspect: PAspRec read FPDataAspect write SetPDataAspect;
  property DataAspect: TAspRec read FDataAspect write FDataAspect;
  property ParentGroup: TDynGroupBox read FParentGroup write SetParentGroup;
  //property IsMoved: Boolean read FIsMoved write SetIsMoved;

  end;

  TDynButton = class(TBaseControl)
  public

    FCaption: string;
    IsDown: Boolean;
    btnInplace: TDynButtonData;
    constructor create; override;
  end;

  TDynEdit = class(TBaseControl)
  private
    FText: string;
    FPostFirst: Word;
    FCHARFROMPOS: LRESULT;
    //function GetText: string;
    //procedure SetText(const Value: string);
    //procedure SetedtInplace(const Value: TEdit);
    function GetName: string; override;
  public
    edtInplace: TDynEditData;
    //FText: string;
    constructor create; override;
    destructor destroy; override;
    property PostFirst: Word read FPostFirst write FPostFirst;
    property CHARFROMPOS: LRESULT read FCHARFROMPOS write FCHARFROMPOS;
    property Text: string read FText write FText;
  end;

  TDynDatTime = class(TBaseControl)
  public
    DatTimInplace: TDynDateTimePicker;
    constructor create; override;
    destructor destroy; override;
  end;


  TDynLabel = class(TBaseControl)
  private
    FText: string;
    function GetText: string;
    procedure SetText(const Value: string);
  public
    lblInplace: TDynLabelData;
    constructor create; override;
    property Text: string read GetText write SetText;

  end;

  TDynGroupBox = class(TBaseControl)
  private
    FText: string;
    //FDeltaBottom: Integer;
    function GetText: string;
    procedure SetText(const Value: string);
    function GetName: string; override;
  public
    grpInplace: TDynGroup;
    FListGroup: TList<TDynGroupBox>;
    FListIndex: TList<Integer>;

    constructor create; override;
    destructor destroy; override;
    procedure CalcChild;
    function CopyChilds(Offset: integer): TDynGroupBox;
    procedure MoveChild(deltaX, deltaY: Integer);

    procedure CalcGroupBox;
    procedure StretchGroupBoxHeight(newH, offset: Integer);

    procedure MoveForMove(Offset: Integer);override;


    property Text: string read GetText write SetText;
    //property DeltaBottom: Integer read FDeltaBottom write FDeltaBottom;


  end;

  TDynTabControl = class(TDynGroupBox)
  private
    FRealHeight: Integer;
  public
    TabInplace: TDynTabSet;
    property RealHeight: Integer read FRealHeight write FRealHeight;
  end;

  TDynCheckBox = class(TBaseControl)
  private
    FText: string;

    function GetText: string;
    procedure SetText(const Value: string);
  public
    chkInplace: TDbCheckBoxResizeWin;
    constructor create; override;
    property Text: string read GetText write SetText;


  end;


  //TDynSynMemo = class(TBaseControl)
//  private
//    FText: string;
//    function GetText: string;
//    procedure SetText(const Value: string);
//    //procedure CalcForMove(deltaY: Integer);
//  public
//    mmoInplace: TDynSynEdit;
//    FListGroup: TList<TDynGroupBox>;
//    FListIndex: TList<Integer>;
//    constructor create; override;
//    destructor destroy; override;
//    property Text: string read GetText write SetText;
//
//    procedure CalcGroupBox;
//    //procedure StretchGroupBox(deltaY: Integer);
//    procedure StretchGroupBoxHeight(newH: Integer);
//
//    procedure MoveForMove(Offset: Integer);override;
//  end;

  TDynMemo = class(TBaseControl)
  private
    FText: string;
    function GetText: string;
    procedure SetText(const Value: string);
    function GetName: string; override;
  public
    mmoInplace: TSizeGripMemo;
    FListGroup: TList<TDynGroupBox>;
    FListIndex: TList<Integer>;
    constructor create; override;
    destructor destroy; override;
    property Text: string read GetText write SetText;

    procedure CalcGroupBox;
    procedure StretchGroupBoxHeight(newH: Integer);

    procedure MoveForMove(Offset: Integer);override;
    property Name: string read GetName;
  end;


  

  TDPGetTextEvent = procedure(Sender: TDynWinPanel; ctrl: TBaseControl; var FieldText: string) of object;
  TDPSetTextEvent = procedure(Sender: TDynWinPanel; ctrl: TBaseControl; FieldText: string) of object;

  TDPGetDateTimeEvent = procedure(Sender: TDynWinPanel; ctrl: TBaseControl; var FieldDateTime: TDateTime) of object;
  TDPSetDatetimeEvent = procedure(Sender: TDynWinPanel; ctrl: TBaseControl; FieldDateTime: TDateTime) of object;

  TDynSpec = class(TSpeedButton)
  private
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST ;

  public
    procedure Assign(Source: TPersistent); override;
  end;


  THotNumButton = record
    Group: TDynGroupBox;
    NumButton: Integer;
    r: TRect;
  end;

  THotFilterButton = record
    ctrl: TBaseControl;
    r: TRect;
  end;

  TDynWinPanel = class(TWinControl)
  private

    FTimerWaithThread: TWaitTrhread;
    FStartingHandle: THandle;
    gifWait: TGIFImage;
    FTick: byte;
    FVScrollPos: Integer;


    FVScrollStep: Integer;
    FIsScrolling: Boolean;
    FVScrollPage: Integer;
    //FPanelsControl: TPanelControlCollection;
    FScale: extended;
    FMousePosScale: TPoint;
    FHeaderClicked: boolean;
    FButtonClicked: Boolean;
    FOnMouseMove: TMouseMoveEvent;
    FHScrollStep: Integer;
    FHScrollPage: Integer;
    FHScrollPos: Integer;

    FLeaveCombo: Boolean;
    FOnGetText: TDPGetTextEvent;
    FOnSetText: TDPSetTextEvent;
    FNode: PVirtualNode;
    FCanValidateInsert: Boolean;
    FCanMemoResize: Boolean;
    Fbtn1: TDynSpec;
    FCanRepaint: Boolean;
    FFieldNames: TStrings;
    FVTR: TVirtualStringTreeAspect;
    FImageWait: TPicture;
    FRunTimeCode: TStringList;
    FColorBkLabel: TColor;
    IsOut: Boolean;
    FOnDrawGroupButton: TDrawGroupButton;
    //NumButtonPush: array [0..3] of Boolean;
    FHotNumButton: THotNumButton;
    FHotFilterButton: THotFilterButton;
    FOnGroupButtonClick: TGroupButtonClick;
    FOnSetDateTime: TDPSetDatetimeEvent;
    FOnGetDateTime: TDPGetDateTimeEvent;
    FCalculatedMemo: TSizeGripMemo;
    FFilterMode: Boolean;
    FOnFilterButtonClick: TFilterButtonClick;


    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonUP(var Message: TWMLButtonUP); message WM_LBUTTONUP;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMMove(var Msg: TWMMove); message WM_MOVE;
    procedure WMKeyDown(var Msg: TWMKeyDown); message WM_KEYDOWN;
    procedure WMKeyUp(var Msg: TWMKeyUp); message WM_KEYUP;
    procedure CNKeyDown(var Msg: TWMKeyDown); message CN_KEYDOWN;
    procedure WMRepaintWait(var Msg: TMessage); message WM_Repaint_Wait;
    procedure WMKillFocus(var msg: TWMKillFocus); message WM_KILLFOCUS;


    //procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMNotify(var Message: TWMNotify); message WM_NOTIFY;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure CreateWnd; override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WndProc(var Message: TMessage); override;

    procedure DoDynWheel( msg: TWMMouseWheel);
    procedure OnWaitTimer(Sender: TObject);
    procedure OnTerminateWait(Sender: TObject);
    procedure RepaintWait;

    procedure SetScale(const Value: extended);
    procedure OnLeaveList(Sender: TObject);

    procedure DrawButtons(ACanvas: TCanvas);
    procedure DrawEdits(ACanvas: TCanvas);
    procedure DrawGroupBoxs(ACanvas: TCanvas);
    //procedure DrawSynMemos(ACanvas: TCanvas);
    procedure DrawMemos(ACanvas: TCanvas);
    procedure DrawResizedetMemos(ACanvas: TCanvas; mmo: TDynMemo);
    procedure DrawLabels(ACanvas: TCanvas);
    procedure DrawTabControls(ACanvas: TCanvas);
    procedure DrawDatTims(ACanvas: TCanvas);


    procedure DrawGroupButton(TargetCanvas: TCanvas; gr: TDynGroupBox; r: Trect);
    procedure DrawFilterButton(TargetCanvas: TCanvas; DynCtrl: TBaseControl; rFilter: Trect);
    procedure DrawGroupTabs(TargetCanvas: TCanvas; gr: TDynGroupBox; r: Trect);




    procedure RepaintLabel(ACanvas: TCanvas; lbl: TDynLabel);
    procedure DrawChecks(ACanvas: TCanvas);
    //procedure MmoonResize(Sender: TObject);
    procedure ResizeControl(sender: TObject);
    procedure SetNode(const Value: PVirtualNode);
    procedure SetCanDrawInDesignMode(const Value: boolean);
    procedure Setbtn1(const Value: TDynSpec);
    procedure SetFieldNames(const Value: TStrings);
    function GetField(const Name: string): string;
    procedure SetField(const Name, Value: string);
    procedure SetHScrollPos(const Value: Integer);
    procedure SetVScrollPos(const Value: Integer);
    procedure SetImageWait(const Value: TPicture);
    procedure SetRunTimeCode(const Value: TStringList);
    procedure SetFilterMode(const Value: Boolean);



  protected
    rangeVert: Integer;
    rangeHorz: Integer;
    MaxWidth: Integer;




    procedure CreateParams(var Params: TCreateParams); override;
    function MouseActivate(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer; HitTest: Integer): TMouseActivate; override;
    procedure Resize; override;
    function CalcGroupHeight: Extended;
    function CalcGroupWidth(recalcElement: Boolean = false): Extended;
    procedure KeyPress(var Key: Char); override;
    procedure ValidateInsert(AComponent: TComponent); override;
    //procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
//    function GetChildOwner: TComponent; override;
    procedure ControlChange(msg: TCMControlChange);
    procedure AddControl(msg: TCMControlChange);
    procedure Loaded; override;

    procedure btn1Click(Sender: TObject);
    procedure UpdateObjectInspector;

  public
    leftListFilter: Integer;
    topListFilter: Integer;
    WListFilter: Integer;
    HListFilter: Integer;
    //BinMemos: TPanel;
    lstvtr1: TListVTR;
    ListMemos: TList<TSizeGripMemo>;
    ListGroups: TList<TDynGroup>;
    ListEdits: TList<TDynEditData>;
    ListLabels: TList<TDynLabelData>;
    ListDates: TList<TDynDateTimePicker>;
    listChecks: TList<TDbCheckBoxResizeWin>;



    FCanvas: TControlCanvas;
    FSelectedEdit: TDynEdit;
    FFocusedEdit: TDynEdit;
    //FFocusedSynMemo: TDynSynMemo;
    FSelectedDatTim: TDynDatTime;
    FFocusedDatTim: TDynDatTime;
    FSelectedChk: TDynCheckBox;
    FFocusedChk: TDynCheckBox;
    FFocusedMemo: TDynMemo;
    FResizedetMemo: TDynMemo;


    FSelectedCapLab: TBaseControl;
    FSelectedButton: TDynButton;
    //FSelectedSynMemo: TDynSynMemo;
    FSelectedMemo: TDynMemo;


    FButtons: TList<TDynButton>;
    FEdits: TList<TDynEdit>;
    FDatTims: TList<TDynDatTime>;
    //FSynMemos: TList<TDynSynMemo>;
    FMemos: TList<TDynMemo>;
    FLabels: TList<TDynLabel>;
    FChecks: TList<TDynCheckBox>;
    FGroupBoxs: TList<TDynGroupBox>;
    FTabControls: TList<TDynTabControl>;
    FlistHotNumButtons: TList<THotNumButton>;
    FlistHotFilterButtons: TList<THotFilterButton>;
    constructor Create(AOwner: TComponent); override;
    destructor destroy; override;
    procedure ShowFilterList;
    procedure HideFilterList(FocusedControl: TObject);
    procedure DrawSpeedButton( btn: TSpeedButton; r: Trect);
    procedure MouseWheelHandler(var Message: TMessage); override;
    procedure UpdateScroll;
    function BtnFromPoint(p: TPoint; scale: extended): TDynButton;
    function EdtFromPoint(p: TPoint; scale: extended): TDynEdit;
    function datTimFromPoint(p: TPoint; scale: extended): TDynDatTime;
    function ChkFromPoint(p: TPoint; scale: extended): TDynCheckBox;
    function DynCapLabFromPoint(p: TPoint; scale: extended): TBaseControl;
    function NumButtonFromPoint(p: TPoint; scale: extended): THotNumButton;
    function FilterButtonFromPoint(p: TPoint; scale: extended): THotFilterButton;
    //function SynMmoFromPoint(p: TPoint; scale: extended): TDynSynMemo;
    function MmoFromPoint(p: TPoint; scale: extended): TDynMemo;
    function AddDynEdt(edit: TDynEditData): TDynEdit;
    procedure AddRunTimeDynEdit(ALeft, ATop, ARight, ABottom, Atag, fH: Integer; labCap: string);

    function AddRunTimeDynEditRelative(grp: TDynGroup; ALeft, ATop, ARight,
          ABottom, Atag, fH: Integer; labCap: string): TDynEditData;
    function AddRunTimeDynGrpRelative(grp: TDynGroup; ALeft, ATop, ARight,
          ABottom, Atag, fH: Integer; labCap: string): TDynGroup;
    function AddRunTimeDynMemoRelative(grp: TDynGroup; ALeft, ATop, ARight,
        ABottom, Atag, fH: Integer; labCap: string): TSizeGripMemo;
    function AddRunTimeDynDateRelative(grp: TDynGroup; ALeft, ATop, ARight,
        ABottom, Atag, fH: Integer; labCap: string): TDynDateTimePicker;
    function AddRunTimeDynLabelRelative(grp: TDynGroup; ALeft, ATop, ARight,
        ABottom, Atag, fH: Integer; labCap: string): TDynLabelData;
    function AddRunTimeDynCheckRelative(grp: TDynGroup; ALeft, ATop, ARight,
        ABottom, Atag, fH: Integer; labCap: string): TDbCheckBoxResizeWin;




    function AddRunTimeDynGroup(ALeft, ATop, ARight, ABottom,
         Atag, fH: Integer; labCap: string): TDynGroup;
    //procedure AddRunTimeDynMemo(ALeft, ATop, ARight, ABottom, Atag, fH: Integer; labCap: string);
    function GenerateRunTimeCodeDynEdit(DynEdit: TDynEdit): string;

    function GenerateRTCDynEditRelative(Grp: TDynGroupBox; DynEdit: TDynEdit): string;
    function GenerateRTCDynGrpRelative(Grp, Grp1: TDynGroupBox): string;
    function GenerateRTCDynMemoRelative(Grp: TDynGroupBox; DynMemo: TDynMemo): string;
    function GenerateRTCDynDateRelative(Grp: TDynGroupBox; DyndDatPic: TDynDatTime): string;
    function GenerateRTCDynLabelRelative(Grp: TDynGroupBox; DyndLabel: TDynLabel): string;
    function GenerateRTCDynCheckRelative(Grp: TDynGroupBox; DyndCheck: TDynCheckBox): string;


    function GenerateRunTimeCodeDynGroup(DynGrp: TDynGroupBox): string;
    function GenerateRunTimeCodeDynMemo(DynMmo: TDynMemo): string;

    function AddDynLabel(Lab: TDynLabelData): TDynLabel;
    function AddDynGroupBox(gb: TDynGroup): TDynGroupBox;
    //function AddDynSynMemo(Memo: TDynSynEdit): TDynSynMemo;
    function AddDynMemo(Memo: TSizeGripMemo): TDynMemo;
    function AddDynCheckBox(Check: TDbCheckBoxResizeWin): TDynCheckBox;
    function AddDynButtonData(btn: TDynButtonData): TDynButton;
    function AddDynTabSet(ts: TDynTabSet): TDynTabControl;
    function AddDynDatTimePck(DatTimPck: TDynDateTimePicker): TDynDatTime;

    function CalcMinRight: Integer;
    function CalcMinLeft: Integer;
    procedure GenerateRunTimeCode;

    procedure Clear;
    //procedure ClearDependList;
    procedure Redraw;
    procedure MemoToBin(mmo: TSizeGripMemo; InBin: Boolean);

    procedure AddMemos;
    procedure AddGroups;
    procedure RemoveGroups;
    procedure AddEdits;
    procedure AddLabels;
    procedure AddDates;
    procedure AddChecks;

    procedure NestedGroup(mmo: TSizeGripMemo);
    procedure MoveGroup(dx, dy: Integer; grp: TDynGroupBox);

    property Node: PVirtualNode read FNode write SetNode;
    property CanValidateInsert: Boolean read FCanValidateInsert write FCanValidateInsert;
    property CanMemoResize: Boolean read FCanMemoResize write FCanMemoResize;
    property CanRepaint: Boolean read FCanRepaint write FCanRepaint;
    property FieldVal[const Name: string]: string read GetField write SetField;
    property CalculatedMemo: TSizeGripMemo read FCalculatedMemo write FCalculatedMemo;

    

  published
    property btn1: TDynSpec read Fbtn1 write Setbtn1;
    property VTR: TVirtualStringTreeAspect read FVTR write FVTR;
    //property ScrBarV: TDynScrollBar read FScrBarV write SetScrBarV;
    property Scale: extended read FScale write SetScale;
    property VScrollStep: Integer read FVScrollStep write FVScrollStep;
    property VScrollPage: Integer read FVScrollPage write FVScrollPage;
    property VScrollPos: Integer read FVScrollPos write SetVScrollPos;
    property HScrollStep: Integer read FHScrollStep write FHScrollStep;
    property HScrollPage: Integer read FHScrollPage write FHScrollPage;
    property HScrollPos: Integer read FHScrollPos write SetHScrollPos;
    property Align;
    property Anchors;
    property ImageWait: TPicture read FImageWait write SetImageWait;
    property RunTimeCode: TStringList read FRunTimeCode write SetRunTimeCode;
    property ColorBkLabel: TColor read FColorBkLabel write FColorBkLabel;
    property FilterMode: Boolean read FFilterMode write SetFilterMode;
    


    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnGetText: TDPGetTextEvent read FOnGetText write FOnGetText;
    property OnSetText: TDPSetTextEvent read FOnSetText write FOnSetText;
    property OnGetDateTime: TDPGetDateTimeEvent read FOnGetDateTime write FOnGetDateTime;
    property OnSetDateTime: TDPSetDatetimeEvent read FOnSetDateTime write FOnSetDateTime;
    property OnDrawGroupButton: TDrawGroupButton read FOnDrawGroupButton  write FOnDrawGroupButton;
    property OnGroupButtonClick: TGroupButtonClick read FOnGroupButtonClick write FOnGroupButtonClick;
    property OnFilterButtonClick: TFilterButtonClick read FOnFilterButtonClick write FOnFilterButtonClick;
  end;



procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('Biser', [TDynWinPanel]);
end;

{ TDynPanel }

procedure TDynWinPanel.AddChecks;
var
  i: Integer;
  chk: TDbCheckBoxResizeWin;
begin
  for i := 0 to 20 do
  begin
    chk := TDbCheckBoxResizeWin.Create(self);
    chk.Parent := self;
    chk.Visible := False;
    listChecks.Add(chk);
  end;
end;

procedure TDynWinPanel.AddControl(msg: TCMControlChange);
var
  cntr: TControl;
  i: Integer;
  edit: TDynEditData;
  edt: TDynEdit;
  //SynMemo: TDynSynEdit;
  //mmoSn: TDynSynMemo;

  Memo: TSizeGripMemo;
  mmo: TDynMemo;


  Check: TDbCheckBoxResizeWin;
  chk: TDynCheckBox;
  Lab: TDynLabelData;
  lbl: TDynLabel;
  Group: TDynGroup;
  grp: TDynGroupBox;
  Button: TDynButtonData;
  btn: TDynButton;
  TabSet: TDynTabSet;
  tc: TDynTabControl;
  DatTimPick: TDynDateTimePicker;
  dt: TDynDatTime;
begin
  inherited;
  Exit;
  if  ((csDesigning in ComponentState)) then     //not msg.Inserting and
  begin
    Exit;
  end;
  cntr := msg.Control;
  if cntr is TDynEditData then
  begin
    edit := TDynEditData(cntr);
    if not msg.Inserting then
    begin
      //for i := FEdits.Count - 1 downto 0 do
//      begin
//        if edit = FEdits[i].edtInplace then
//        begin
//          FEdits.Delete(i);
//          btn1.Caption := 'del';
//        end;
//      end;
    end
    else
    begin
      Edit := TDynEditData(cntr);
      AddDynEdt(edit);

    end;
  end;
  //if cntr is TDynSynEdit then
//  begin
//    SynMemo := TDynSynEdit(cntr);
//    if not msg.Inserting then
//    begin
//      for i := FSynMemos.Count - 1 downto 0 do
//      begin
//        if SynMemo = FSynMemos[i].mmoInplace then
//        begin
//          FSynMemos.Delete(i);
//          btn1.Caption := 'del';
//        end;
//      end;
//    end
//    else
//    begin
//      SynMemo := TDynSynEdit(cntr);
//      AddDynSynMemo(SynMemo);
//      Exit;
//    end;
//  end;

  if cntr is TSizeGripMemo then
  begin
    Memo := TSizeGripMemo(cntr);
    if not msg.Inserting then
    begin
      for i := FMemos.Count - 1 downto 0 do
      begin
        if Memo = FMemos[i].mmoInplace then
        begin
          FMemos.Delete(i);
          btn1.Caption := 'del';
        end;
      end;
    end
    else
    begin
      Memo := TSizeGripMemo(cntr);
      AddDynMemo(Memo);
      Exit;
    end;
  end;

  if cntr is TDbCheckBoxResizeWin then
  begin
    Check := TDbCheckBoxResizeWin(cntr);
    if not msg.Inserting then
    begin
      for i := FChecks.Count - 1 downto 0 do
      begin
        if Check = FChecks[i].chkInplace then
        begin
          FChecks.Delete(i);
          btn1.Caption := 'del';
        end;
      end;
    end
    else
    begin
      Check := TDbCheckBoxResizeWin(cntr);
      AddDynCheckBox(Check);
      //btn1.Caption := 'ins';
      Exit;
    end;
  end;
  if cntr is TDynLabelData then
  begin
    Lab := TDynLabelData(cntr);
    if not msg.Inserting then
    begin
      for i := FLabels.Count - 1 downto 0 do
      begin
        if Lab = FLabels[i].lblInplace then
        begin
          FLabels.Delete(i);
          btn1.Caption := 'del';
        end;
      end;
    end
    else
    begin
      AddDynLabel(Lab);
      //btn1.Caption := 'ins';
      Exit;
    end;
  end;
  if cntr is TDynGroup then
  begin
    Group := TDynGroup(cntr);
    if not msg.Inserting then
    begin
      for i := FGroupBoxs.Count - 1 downto 0 do
      begin
        if Group = FGroupBoxs[i].grpInplace then
        begin
          FGroupBoxs.Delete(i);
          btn1.Caption := 'del';
        end;
      end;
    end
    else
    begin
      //AddDynGroupBox(Group);
      inherited;
      Exit;
    end;
  end;
  if cntr is TDynButtonData then
  begin
    Button := TDynButtonData(cntr);
    if not msg.Inserting then
    begin
      for i := FButtons.Count - 1 downto 0 do
      begin
        if Button = FButtons[i].btnInplace then
        begin
          FButtons.Delete(i);
          btn1.Caption := 'del';
        end;
      end;
    end
    else
    begin
      AddDynButtonData(Button);
      Exit;
    end;
  end;
  if cntr is TDynTabSet then
  begin
    TabSet := TDynTabSet(cntr);
    if not msg.Inserting then
    begin
      for i := FTabControls.Count - 1 downto 0 do
      begin
        if TabSet = FTabControls[i].TabInplace then
        begin
          FTabControls.Delete(i);
          btn1.Caption := 'del';
        end;
      end;
    end
    else
    begin
      AddDynTabSet(TabSet);
      Exit;
    end;
  end;
  if cntr is TDynDateTimePicker then
  begin
    DatTimPick := TDynDateTimePicker(cntr);
    if not msg.Inserting then
    begin
      for i := FDatTims.Count - 1 downto 0 do
      begin
        if DatTimPick = FDatTims[i].DatTimInplace then
        begin
          FDatTims.Delete(i);
          btn1.Caption := 'del';
        end;
      end;
    end
    else
    begin
      AddDynDatTimePck(DatTimPick);
      Exit;
    end;
  end;
end;

procedure TDynWinPanel.AddDates;
var
  i: Integer;
  dt: TDynDateTimePicker;
begin
  for i := 0 to 20 do
  begin
    dt := TDynDateTimePicker.Create(self);
    dt.Parent := self;//.BinMemos;
    dt.Visible := False;
    ListDates.Add(dt);
  end;
end;

function TDynWinPanel.AddDynButtonData(btn: TDynButtonData): TDynButton;
begin
  btn.DoubleBuffered := true;
  Result := TDynButton.Create;
  Result.btnInplace := btn;
  Result.FDynPanel := Self;
  Result.FCaption := 'dddddd';
  Result.IsDown := True;
  FButtons.Add(Result);
  btn.Visible := true;

  Result.FRect := btn.BoundsDynRect;
  Result.ColIndex := btn.tag;
  //Result.FFontHeight := Round(Edit.DynFontHeight);
  btn.FDynButton := Result;
end;

function TDynWinPanel.AddDynCheckBox(Check: TDbCheckBoxResizeWin): TDynCheckBox;
begin
  Check.DoubleBuffered := false;
  //Check.OnChange := OnChangeEdit;
  Result := TDynCheckBox.Create;
  Result.chkInplace := Check;
  Result.FDynPanel := Self;
  //Check.AutoSize := False;
  FChecks.Add(Result);
  Check.Visible := False;

  Result.FRect := Check.BoundsDynRect;
  Result.ColIndex := Check.tag;
  //Result.FFontHeight := Round(Edit.DynFontHeight);
  Check.FDynCheck := Result;
end;

function TDynWinPanel.AddDynDatTimePck(DatTimPck: TDynDateTimePicker): TDynDatTime;
begin
  DatTimPck.DoubleBuffered := true;
  Result := TDynDatTime.Create;
  Result.DatTimInplace := DatTimPck;
  Result.FDynPanel := Self;
  FDatTims.Add(Result);
  DatTimPck.Visible := False;

  Result.FRect := DatTimPck.BoundsDynRect;
  DatTimPck.FDynDatTim := Result;
end;

function TDynWinPanel.AddDynEdt(edit: TDynEditData): TDynEdit;
begin
  Edit.DoubleBuffered := false;
  Result := TDynEdit.Create;
  Result.edtInplace := Edit;
  Result.FDynPanel := Self;
  Edit.AutoSize := False;
  FEdits.Add(Result);
  Edit.Visible := False;

  Result.FRect := Edit.BoundsDynRect;
  //Result.ColIndex := Edit.tag;
  //Result.FFontHeight := Round(Edit.DynFontHeight);
  edit.FDynEdit := Result;
end;

function TDynWinPanel.AddDynGroupBox(gb: TDynGroup): TDynGroupBox;
begin
  Result := TDynGroupBox.Create;
  Result.grpInplace := gb;
  Result.FDynPanel := Self;
  FGroupBoxs.Add(Result);
  gb.Visible := False;
  Result.FRect := gb.BoundsDynRect;
  Result.ColIndex := gb.tag;
  gb.FDynGroupBox := Result;

end;

function TDynWinPanel.AddDynLabel(Lab: TDynLabelData): TDynLabel;
begin
  //Lab.DoubleBuffered := false;
  //Lab.OnChange := OnChangeEdit;
  Result := TDynLabel.Create;
  Result.lblInplace := Lab;
  Result.FDynPanel := Self;
  Lab.AutoSize := False;
  FLabels.Add(Result);
  if (csDesigning in ComponentState) then
  begin
    lab.Visible := true;
  end
  else
  begin
    lab.Visible := false;
  end;
  Lab.Transparent := False;

  Result.FRect := Lab.BoundsDynRect;
  Result.ColIndex := Lab.tag;
  //Result.FFontHeight := Round(Edit.DynFontHeight);
  Lab.FDynLabel := Result;
end;

function TDynWinPanel.AddDynMemo(Memo: TSizeGripMemo): TDynMemo;
begin
  Memo.DoubleBuffered := true;
  Memo.BringToFront;
  //Edit.OnChange := OnChangeEdit;
  Result := TDynMemo.Create;
  Result.mmoInplace := Memo;
  Result.FDynPanel := Self;
  //Memo.AutoSize := False;
  FMemos.Add(Result);
  //Memo.Visible := true;
  Memo.DynVisible := true;

  Result.FRect := Memo.BoundsDynRect;
  Result.ColIndex := Memo.tag;
  //Result.FFontHeight := Round(Edit.DynFontHeight);
  Memo.FDynMemo := Result;
end;

//function TDynWinPanel.AddDynSynMemo(Memo: TDynSynEdit): TDynSynMemo;
//begin
//  Memo.DoubleBuffered := true;
//  //Edit.OnChange := OnChangeEdit;
//  Result := TDynSynMemo.Create;
//  Result.mmoInplace := Memo;
//  Result.FDynPanel := Self;
//  //Memo.AutoSize := False;
//  FSynMemos.Add(Result);
//  Memo.Visible := false;
//
//  Result.FRect := Memo.BoundsDynRect;
//  Result.ColIndex := Memo.tag;
//  //Result.FFontHeight := Round(Edit.DynFontHeight);
//  Memo.FDynMemo := Result;
//end;

function TDynWinPanel.AddDynTabSet(ts: TDynTabSet): TDynTabControl;
begin
  ts.DoubleBuffered := true;
  //ts.BringToFront;
  Result := TDynTabControl.Create;
  Result.TabInplace := ts;
  Result.FDynPanel := Self;
  FTabControls.Add(Result);
  ts.Visible := true;

  Result.FRect := ts.BoundsDynRect;
  Result.ColIndex := ts.tag;
  ts.FDynTabControl := Result;
end;

procedure TDynWinPanel.AddEdits;
var
  i: Integer;
  edt: TDynEditData;
begin
  for i := 0 to 40 do
  begin
    edt := TDynEditData.Create(self);
    edt.Parent := self;
    edt.Visible := False;
    ListEdits.Add(edt);
  end;
end;

procedure TDynWinPanel.AddGroups;
var
  i: Integer;
  grp: TDynGroup;
begin
  for i := 0 to 20 do
  begin
    grp := TDynGroup.Create(self);
    //AddDynGroupBox(grp);
    grp.Parent := self;
    grp.Visible := False;
    ListGroups.Add(grp);
  end;
end;

procedure TDynWinPanel.AddLabels;
var
  i: Integer;
  lbl: TDynLabelData;
begin
  for i := 0 to 20 do
  begin
    lbl := TDynLabelData.Create(self);
    lbl.Parent := self;
    lbl.Visible := False;
    ListLabels.Add(lbl);
  end;
end;

procedure TDynWinPanel.AddMemos;
var
  i: Integer;
  mmo: TSizeGripMemo;
begin
  for i := 0 to 20 do
  begin
    mmo := TSizeGripMemo.Create(self);
    mmo.Parent := self;//.BinMemos;
    ListMemos.Add(mmo);
  end;
end;

function TDynWinPanel.AddRunTimeDynCheckRelative(grp: TDynGroup; ALeft, ATop, ARight, ABottom,
     Atag, fH: Integer; labCap: string): TDbCheckBoxResizeWin;
var
  Chk: TDbCheckBoxResizeWin;
  dChk: TDynCheckBox;
  dGrp: TDynGroupBox;
begin
  Chk := listChecks[FChecks.Count];
  Chk.Visible := False;
  //Chk.Parent  := self;
  AddDynCheckBox(Chk);
  dChk := TDynCheckBox(Chk.FDynCheck);
  dGrp := TDynGroupBox(grp.FDynGroupBox);

  dChk.FRect.Left := ALeft + dGrp.FRect.Left;
  dChk.FRect.Right := ARight + dGrp.FRect.Left;
  dChk.FRect.Bottom := ABottom + dGrp.FRect.Top;
  dChk.FRect.Top := ATop + dGrp.FRect.Top;
  dChk.chkInplace.DynLeft := ALeft + dGrp.FRect.Left;
  dChk.chkInplace.DynRight := ARight + dGrp.FRect.Left;
  dChk.chkInplace.DynBottom := ABottom + dGrp.FRect.top;
  dChk.chkInplace.DynTop := ATop + dGrp.FRect.Top;
  dChk.chkInplace.Tag := Atag;
  dChk.FColIndex := Atag;
  //dChk.chkInplace.labelCaption := labCap;
  //dChk.chkInplace.DynFontHeight := fH;

  Result := Chk;
end;

function TDynWinPanel.AddRunTimeDynDateRelative(grp: TDynGroup; ALeft, ATop, ARight, ABottom,
     Atag, fH: Integer; labCap: string): TDynDateTimePicker;
var
  dtPic: TDynDateTimePicker;
  dt: TDynDatTime;
  dGrp: TDynGroupBox;
begin
  dtPic := ListDates[FDatTims.Count];
  dtPic.Visible := False;
  //dtPic.Parent  := self;
  AddDynDatTimePck(dtPic);
  dt := TDynDatTime(dtPic.FDynDatTim);
  dGrp := TDynGroupBox(grp.FDynGroupBox);

  dt.FRect.Left := ALeft + dGrp.FRect.Left;
  dt.FRect.Right := ARight + dGrp.FRect.Left;
  dt.FRect.Bottom := ABottom + dGrp.FRect.Top;
  dt.FRect.Top := ATop + dGrp.FRect.Top;
  dt.DatTimInplace.DynLeft := ALeft + dGrp.FRect.Left;
  dt.DatTimInplace.DynRight := ARight + dGrp.FRect.Left;
  dt.DatTimInplace.DynBottom := ABottom + dGrp.FRect.top;
  dt.DatTimInplace.DynTop := ATop + dGrp.FRect.Top;
  dt.DatTimInplace.Tag := Atag;
  dt.FColIndex := Atag;
  dt.DatTimInplace.labelCaption := labCap;
 // dt.DatTimInplace.DynFontHeight := fH;

  Result := dtPic;
end;

procedure TDynWinPanel.AddRunTimeDynEdit(ALeft, ATop, ARight, ABottom, Atag, fH: Integer; labCap: string);
var
  edt: TDynEditData;
begin
  edt := TDynEditData.Create(self);
  edt.Visible := False;
  edt.Parent  := self;
  TDynEdit(edt.FDynEdit).FRect.Left := ALeft;
  TDynEdit(edt.FDynEdit).FRect.Right := ARight;
  TDynEdit(edt.FDynEdit).FRect.Bottom := ABottom;
  TDynEdit(edt.FDynEdit).FRect.Top := ATop;
  TDynEdit(edt.FDynEdit).edtInplace.DynLeft := ALeft;
  TDynEdit(edt.FDynEdit).edtInplace.DynRight := ARight;
  TDynEdit(edt.FDynEdit).edtInplace.DynBottom := ABottom;
  TDynEdit(edt.FDynEdit).edtInplace.DynTop := ATop;
  TDynEdit(edt.FDynEdit).edtInplace.Tag := Atag;
  TDynEdit(edt.FDynEdit).FColIndex := Atag;
  TDynEdit(edt.FDynEdit).edtInplace.labelCaption := labCap;
  TDynEdit(edt.FDynEdit).edtInplace.DynFontHeight := fH;
end;



function TDynWinPanel.AddRunTimeDynEditRelative(grp: TDynGroup; ALeft, ATop, ARight,
             ABottom, Atag, fH: Integer; labCap: string): TDynEditData;
var
  edt: TDynEditData;
  dEdt: TDynEdit;
  dGrp: TDynGroupBox;
begin
  edt := ListEdits[FEdits.Count];
  edt.Visible := False;
  AddDynEdt(edt);
  dEdt := TDynEdit(edt.FDynEdit);
  dGrp := TDynGroupBox(grp.FDynGroupBox);

  dEdt.FRect.Left := ALeft + dGrp.FRect.Left;
  dEdt.FRect.Right := ARight + dGrp.FRect.Left;
  dEdt.FRect.Bottom := ABottom + dGrp.FRect.Top;
  dEdt.FRect.Top := ATop + dGrp.FRect.Top;
  dEdt.edtInplace.DynLeft := ALeft + dGrp.FRect.Left;
  dEdt.edtInplace.DynRight := ARight + dGrp.FRect.Left;
  dEdt.edtInplace.DynBottom := ABottom + dGrp.FRect.top;
  dEdt.edtInplace.DynTop := ATop + dGrp.FRect.Top;
  dEdt.edtInplace.Tag := Atag;
  dEdt.FColIndex := Atag;
  dEdt.edtInplace.labelCaption := labCap;
  dEdt.edtInplace.DynFontHeight := fH;

  Result := edt;
end;

function TDynWinPanel.AddRunTimeDynGroup(ALeft, ATop, ARight, ABottom,
                                         Atag, fH: Integer; labCap: string): TDynGroup;
begin
  Result := ListGroups[FGroupBoxs.Count];
  Result.CanMove := False;
  //Result.BoundsRect := Rect(round(ALeft * Scale), round(ATop * Scale), round(ARight * Scale), round(ABottom * Scale));
  //Result.DynLeft := ALeft;
  if Result.FDynGroupBox = nil then
    AddDynGroupBox(Result);
  TDynGroupBox(Result.FDynGroupBox).FRect.Left := ALeft;
  TDynGroupBox(Result.FDynGroupBox).FRect.Top := ATop;// + Result.DY;
  TDynGroupBox(Result.FDynGroupBox).FRect.Right := ARight;
  TDynGroupBox(Result.FDynGroupBox).FRect.Bottom := ABottom;// + Result.DH + Result.DY;

  TDynGroupBox(Result.FDynGroupBox).grpInplace.DynLeft := ALeft;
  TDynGroupBox(Result.FDynGroupBox).grpInplace.DynRight := ARight;
  TDynGroupBox(Result.FDynGroupBox).grpInplace.DynBottom := TDynGroupBox(Result.FDynGroupBox).FRect.Bottom;
  TDynGroupBox(Result.FDynGroupBox).grpInplace.DynTop := TDynGroupBox(Result.FDynGroupBox).FRect.Top;
  TDynGroupBox(Result.FDynGroupBox).grpInplace.Tag := Atag;
  TDynGroupBox(Result.FDynGroupBox).FColIndex := Atag;
  TDynGroupBox(Result.FDynGroupBox).grpInplace.labelCaption := labCap;
  TDynGroupBox(Result.FDynGroupBox).grpInplace.DynFontHeight := fH;
  Result.CanMove := True;
end;

function TDynWinPanel.AddRunTimeDynGrpRelative(grp: TDynGroup; ALeft, ATop, ARight, ABottom, Atag, fH: Integer; labCap: string): TDynGroup;
var
  //group: TDynGroup;
  dGrp, dGrp1 : TDynGroupBox;
begin
  dGrp := TDynGroupBox(grp.FDynGroupBox);
  Result := ListGroups[FGroupBoxs.Count];
  Result.CanMove := False;
  Result.BoundsRect := Rect(round((ALeft + grp.DynLeft) * Scale),
                            round((ATop + dGrp.FRect.Top) * Scale) ,
                            round((ARight+ dGrp.FRect.Left) * Scale),
                            round((ABottom + dGrp.FRect.Top) * Scale));
  //Result.BoundsRect := Rect(ALeft + dGrp.FRect.Left, ATop + dGrp.FRect.Top, ARight+ dGrp.FRect.Left, ABottom +dGrp.FRect.Top);
  if Result.FDynGroupBox = nil then
    AddDynGroupBox(Result);
  dGrp1 := TDynGroupBox(Result.FDynGroupBox);


  dGrp1.FRect.Left := ALeft + dGrp.FRect.Left;
  dGrp1.FRect.Right := ARight + dGrp.FRect.Left;
  dGrp1.FRect.Bottom := ABottom + dGrp.FRect.Top;
  dGrp1.FRect.Top := ATop + dGrp.FRect.Top;
  dGrp1.grpInplace.DynLeft := ALeft + dGrp.FRect.Left;
  dGrp1.grpInplace.DynRight := ARight + dGrp.FRect.Left;
  dGrp1.grpInplace.DynBottom := dGrp1.FRect.Bottom;
  dGrp1.grpInplace.DynTop := ATop + dGrp.FRect.Top;
  dGrp1.grpInplace.Tag := Atag;
  dGrp1.FColIndex := Atag;
  dGrp1.grpInplace.labelCaption := labCap;
  dGrp1.grpInplace.DynFontHeight := fH;
  Result.CanMove := True;
end;

function TDynWinPanel.AddRunTimeDynLabelRelative(grp: TDynGroup; ALeft, ATop, ARight, ABottom,
     Atag, fH: Integer; labCap: string): TDynLabelData;
var
  lbl: TDynLabelData;
  dlbl: TDynLabel;
  dGrp: TDynGroupBox;
begin
  lbl := ListLabels[FLabels.Count];
  lbl.Visible := False;
 // lbl.Parent  := self;
  AddDynLabel(lbl);
  dlbl := TDynLabel(lbl.FDynLabel);
  dGrp := TDynGroupBox(grp.FDynGroupBox);

  dlbl.FRect.Left := ALeft + dGrp.FRect.Left;
  dlbl.FRect.Right := ARight + dGrp.FRect.Left;
  dlbl.FRect.Bottom := ABottom + dGrp.FRect.Top;
  dlbl.FRect.Top := ATop + dGrp.FRect.Top;
  dlbl.lblInplace.DynLeft := ALeft + dGrp.FRect.Left;
  dlbl.lblInplace.DynRight := ARight + dGrp.FRect.Left;
  dlbl.lblInplace.DynBottom := ABottom + dGrp.FRect.top;
  dlbl.lblInplace.DynTop := ATop + dGrp.FRect.Top;
  dlbl.lblInplace.Tag := Atag;
  dlbl.FColIndex := Atag;
  dlbl.lblInplace.Caption := labCap;
  dlbl.lblInplace.DynFontHeight := fH;

  Result := lbl;
end;

//procedure TDynWinPanel.AddRunTimeDynMemo(ALeft, ATop, ARight, ABottom, Atag, fH: Integer; labCap: string);
//var
//  mmo: TDynSynEdit;
//begin
//  mmo := TDynSynEdit.Create(self);
//  //mmo.Visible := False;
//  mmo.Parent  := self;
//    TDynSynMemo(mmo.FDynMemo).FRect.Left := ALeft;
//  TDynSynMemo(mmo.FDynMemo).FRect.Right := ARight;
//  TDynSynMemo(mmo.FDynMemo).FRect.Bottom := ABottom;
//  TDynSynMemo(mmo.FDynMemo).FRect.Top := ATop;
//  TDynSynMemo(mmo.FDynMemo).mmoInplace.DynLeft := ALeft;
//  TDynSynMemo(mmo.FDynMemo).mmoInplace.DynRight := ARight;
//  TDynSynMemo(mmo.FDynMemo).mmoInplace.DynBottom := ABottom;
//  TDynSynMemo(mmo.FDynMemo).mmoInplace.DynTop := ATop;
//  TDynSynMemo(mmo.FDynMemo).mmoInplace.Tag := Atag;
//  TDynSynMemo(mmo.FDynMemo).FColIndex := Atag;
//  TDynSynMemo(mmo.FDynMemo).mmoInplace.labelCaption := labCap;
//  TDynSynMemo(mmo.FDynMemo).mmoInplace.DynFontHeight := fH;
//end;

function TDynWinPanel.AddRunTimeDynMemoRelative(grp: TDynGroup; ALeft, ATop, ARight,
                           ABottom, Atag, fH: Integer; labCap: string): TSizeGripMemo;
var
  mmo:TSizeGripMemo;
  dMmo: TDynMemo;
  dGrp: TDynGroupBox;
begin
  mmo := ListMemos[FMemos.Count];
  //mmo.BoundsRect := Rect(ALeft, ATop, ARight, ABottom);
  if mmo.FDynMemo = nil then
    AddDynMemo(mmo);
  dMmo := TDynMemo(mmo.FDynMemo);
  dGrp := TDynGroupBox(grp.FDynGroupBox);

  dMmo.FRect.Left := ALeft + dGrp.FRect.Left;
  dMmo.FRect.Right := ARight + dGrp.FRect.Left;
  dMmo.FRect.Bottom := ABottom + dGrp.FRect.Top;
  dMmo.FRect.Top := ATop + dGrp.FRect.Top;
  dMmo.mmoInplace.DynLeft := ALeft + dGrp.FRect.Left;
  dMmo.mmoInplace.DynRight := ARight + dGrp.FRect.Left;
  dMmo.mmoInplace.DynBottom := dMmo.FRect.Bottom;
  dMmo.mmoInplace.DynTop := ATop + dGrp.FRect.Top;
  dMmo.mmoInplace.Tag := Atag;
  dMmo.FColIndex := Atag;
  dMmo.mmoInplace.labelCaption := labCap;
  //dMmo.mmoInplace.DynFontHeight := fH;
  Result := mmo;
end;

procedure TDynWinPanel.btn1Click(Sender: TObject);
var
  hnd: THandle;
begin
  GenerateRunTimeCode;
  //Exit;
//  btn1.Caption := '';
//  FGroupBoxs[0].CalcChild;
//  ShowMessage(IntToStr(FGroupBoxs[0].FListChilds.Count));
//  //btn1.Caption := IntToStr(FGroupBoxs[0].FListChilds.Count);
//  Exit;
//  //FEdits[0].edtInplace.Left := 200;
//  Exit;
//  //hnd := FindWindow('TPropertyInspector', nil);
//  hnd := FindWindow('TAppBuilder', nil);
//  hnd := FindWindowEx(hnd, 0, 'TEditorDockPanel', nil);
//  hnd := FindWindowEx(hnd, 0, 'TEditWindow', nil);
//  hnd := FindWindowEx(hnd, 0, 'TEditorDockPanel', nil);
//  hnd := FindWindowEx(hnd, 0, 'TPropertyInspector', nil);
//  hnd := FindWindowEx(hnd, 0, 'TPanel', nil);
//  hnd := FindWindowEx(hnd, 0, 'TInspListBox', nil);
//  btn1.Caption := IntToStr(hnd);
//  //ShowMessage(intToStr(hnd));
//  //UpdateWindow(hnd);
//  SendMessage(hnd, WM_LBUTTONDOWN, 3, 200);

end;

function TDynWinPanel.BtnFromPoint(p: TPoint; scale: extended): TDynButton;
var
  i: Integer;
  btn: TDynButton;
  xR, yR: extended;
  x, y: Integer;
begin
  Result := nil;
    xR := p.x + HScrollPos/ Scale;
    yR := p.Y + FVScrollPos / FScale;
    x:= Round(xR);
    y := Round(yR);
  for i:= 0 to FButtons.Count - 1 do
  begin
    btn := FButtons.Items[i];

    if (yR > btn.FRect.Top) and (yR < (btn.FRect.Top + btn.FRect.Height)) and
       (xr > btn.FRect.left) and (xr < (btn.FRect.left + btn.FRect.Width)* 1) then
    begin
      Result := btn;
      Exit;
    end;
  end;
end;

function TDynWinPanel.CalcGroupHeight: Extended;
var
  i, pos: Integer;
begin
  pos := GetScrollPos(Handle, SB_VERT);
  Result := -pos;
  Result := Result +  (10200)* scale;
end;

function TDynWinPanel.CalcGroupWidth(recalcElement: Boolean): Extended;
var
  pos: Integer;
begin
  pos := GetScrollPos(Handle, SB_HORZ);
  Result := - pos;
  Result := Result +  (2200)* scale;
end;

function TDynWinPanel.CalcMinLeft: Integer;
var
  i: Integer;
  edt: TDynEdit;
begin
  Result := 2200;
  for i := 0 to FEdits.Count - 1 do
  begin
    edt := FEdits[i];
    Result := min(edt.FRect.Left, Result);
  end;
end;

function TDynWinPanel.CalcMinRight: Integer;
var
  i: Integer;
  edt: TDynEdit;
begin
  Result := 0;
  for i := 0 to FEdits.Count - 1 do
  begin
    edt := FEdits[i];
    Result := Max(edt.FRect.Right, Result);
  end;
end;

function TDynWinPanel.ChkFromPoint(p: TPoint; scale: extended): TDynCheckBox;
var
  i: Integer;
  chk: TDynCheckBox;
  xR, yR: extended;
  x, y: Integer;
begin
  Result := nil;
    xR := p.x + HScrollPos/ FScale;
    yR := p.Y + VScrollPos / FScale;
    x:= Round(xR);
    y := Round(yR);
  for i:= 0 to FChecks.Count - 1 do
  begin
    chk := FChecks.Items[i];

    if (yR > chk.FRect.Top) and (yR < (chk.FRect.Top + chk.FRect.Height)) and
       (xr > chk.FRect.left) and (xr < (chk.FRect.left + chk.FRect.Width)* 1) then
    begin
      Result := chk;
      Exit;
    end;
  end;
end;

procedure TDynWinPanel.Clear;
var
  i: Integer;

begin
  for i := FLabels.Count - 1 downto 0 do
  begin
    FreeAndNil(FLabels[i].lblInplace.FDynLabel);
  end;
  for i := FEdits.Count - 1 downto 0 do
  begin
    FreeAndNil(FEdits[i].edtInplace.FDynEdit);
  end;
  //for i := FSynMemos.Count - 1 downto 0 do
//  begin
//    FreeAndNil(FSynMemos[i].mmoInplace);
//  end;
  for i := FGroupBoxs.Count - 1 downto 0 do
  begin
    FreeAndNil(FGroupBoxs[i].grpInplace.FDynGroupBox);
    //FGroupBoxs[i].grpInplace.FDynGroupBox := nil;
  end;

  for i := FMemos.Count - 1 downto 0 do
  begin
    //FreeAndNil(FMemos[i].mmoInplace);
    MemoToBin(FMemos[i].mmoInplace, true);
    FMemos[i].mmoInplace.FDynMemo := nil;
  end;


  //for i := FDatTims.Count - 1 downto 0 do
//  begin
//    FreeAndNil(FDatTims[i].DatTimInplace);
//  end;
//  for i := FChecks.Count - 1 downto 0 do
//  begin
//    FreeAndNil(FChecks[i].chkInplace);
//  end;
//  for i := FLabels.Count - 1 downto 0 do
//  begin
//    FreeAndNil(FLabels[i].lblInplace);
//  end;



  FGroupBoxs.Clear;
  FEdits.Clear;
  //FSynMemos.Clear;
  FChecks.Clear;
  FLabels.Clear;
  FDatTims.Clear;
  FMemos.Clear;

  FSelectedEdit := nil;
  FSelectedDatTim := nil;
  //FSelectedSynMemo := nil;
  FSelectedChk := nil;
  FSelectedDatTim := nil;
  FSelectedMemo := nil;

  //Repaint;
end;

//procedure TDynWinPanel.ClearDependList;
//var
//  i: Integer;
//begin
//  for i := 0 to FMemos.Count - 1 do
//  begin
//    FMemos[i].FListBootoms.Clear;
//    FMemos[i].FListForMove.Clear;
//    FMemos[i].FListGroup.Clear;
//    FMemos[i].FListIndex.Clear;
//  end;
//  for i := 0 to FGroupBoxs.Count - 1 do
//  begin
//    FGroupBoxs[i].FListBootoms.Clear;
//    FGroupBoxs[i].FListForMove.Clear;
//    FGroupBoxs[i].FListChilds.Clear;
//    FGroupBoxs[i].FListGroup.Clear;
//    FGroupBoxs[i].FListIndex.Clear;
//  end;

//end;

procedure TDynWinPanel.CMEnter(var Message: TCMEnter);
begin
  inherited;
end;

procedure TDynWinPanel.CMMouseLeave(var Message: TMessage);
begin
  inherited;
end;

procedure TDynWinPanel.CNKeyDown(var Msg: TWMKeyDown);
begin
  case MSG.CharCode of
    38:
    begin
      if FVScrollPos > 0 then
      begin
        if FVScrollPos - FVScrollStep >= 0 then
        begin
          FVScrollPos := FVScrollPos - FVScrollStep;
        end
        else
        begin
          FVScrollPos := 0;
        end;
        UpdateScroll;
        Repaint;
      end;
    end;
    40:
    begin
      if FVScrollPos < rangeVert then
      begin
        if FVScrollPos + FVScrollStep <= rangeVert then
        begin
          FVScrollPos := FVScrollPos + FVScrollStep;
        end
        else
        begin
          FVScrollPos := rangeVert;
        end;
        UpdateScroll;
        Repaint;
      end;
    end;
  end;
end;

procedure TDynWinPanel.ControlChange(msg: TCMControlChange);
var
  cntr: TControl;
  i: Integer;
  edit: TDynEditData;
  edt: TDynEdit;
  //SynMemo: TDynSynEdit;
 // mmoSn: TDynSynMemo;
  Memo: TSizeGripMemo;
  mmo: TDynMemo;

  Check: TDbCheckBoxResizeWin;
  chk: TDynCheckBox;
  Lab: TDynLabelData;
  lbl: TDynLabel;
  Group: TDynGroup;
  grp: TDynGroupBox;
  Button: TDynButtonData;
  btn: TDynButton;
  TabSet: TDynTabSet;
  tc: TDynTabControl;
  DatTimPick: TDynDateTimePicker;
  dt: TDynDatTime;

begin

  cntr := msg.Control;

  if cntr is TDynEditData then
  begin
    edit := TDynEditData(cntr);
    if not msg.Inserting then
    begin
      for i := FEdits.Count - 1 downto 0 do
      begin
        if edit = FEdits[i].edtInplace then
        begin
          FEdits.Delete(i);
          btn1.Caption := 'del';
        end;
      end;
    end
    else
    begin
      Edit := TDynEditData(cntr);
      AddDynEdt(Edit);
      btn1.Caption := 'ins';
    end;
  end;
  //if cntr is TDynSynEdit then
//  begin
//    SynMemo := TDynSynEdit(cntr);
//    if not msg.Inserting then
//    begin
//      for i := FSynMemos.Count - 1 downto 0 do
//      begin
//        if SynMemo = FSynMemos[i].mmoInplace then
//        begin
//          FSynMemos.Delete(i);
//          btn1.Caption := 'del';
//        end;
//      end;
//    end
//    else
//    begin
//      SynMemo := TDynSynEdit(cntr);
//      AddDynSynMemo(SynMemo);
//      btn1.Caption := 'ins';
//    end;
//  end;

  if cntr is TSizeGripMemo then
  begin
    Memo := TSizeGripMemo(cntr);
    if not msg.Inserting then
    begin
      for i := FMemos.Count - 1 downto 0 do
      begin
        if Memo = FMemos[i].mmoInplace then
        begin
          FMemos.Delete(i);
          btn1.Caption := 'del';
        end;
      end;
    end
    else
    begin
      Memo := TSizeGripMemo(cntr);
      AddDynMemo(Memo);
      btn1.Caption := 'ins';
    end;
  end;

  if cntr is TDbCheckBoxResizeWin then
  begin

    Check := TDbCheckBoxResizeWin(cntr);
    if not msg.Inserting then
    begin
      for i := FChecks.Count - 1 downto 0 do
      begin
        if Check = FChecks[i].chkInplace then
        begin
          FChecks.Delete(i);
          btn1.Caption := 'del';
        end;
      end;
    end
    else
    begin
      Check := TDbCheckBoxResizeWin(cntr);
      AddDynCheckBox(Check);
      btn1.Caption := 'ins';
    end;
  end;

  if cntr is TDynLabelData then
  begin

    Lab := TDynLabelData(cntr);
    if not msg.Inserting then
    begin
      for i := FLabels.Count - 1 downto 0 do
      begin
        if Lab = FLabels[i].lblInplace then
        begin
          FLabels.Delete(i);
          btn1.Caption := 'del';
        end;
      end;
    end
    else
    begin
      AddDynLabel(Lab);
      btn1.Caption := 'ins';
    end;
  end;

  if cntr is TDynGroup then
  begin
    Group := TDynGroup(cntr);
    if not msg.Inserting then
    begin
      for i := FGroupBoxs.Count - 1 downto 0 do
      begin
        if Group = FGroupBoxs[i].grpInplace then
        begin
          FGroupBoxs.Delete(i);
          btn1.Caption := 'del';
        end;
      end;
    end
    else
    begin
      AddDynGroupBox(Group);
      btn1.Caption := 'ins';
      Exit;
    end;
  end;

  if cntr is TDynButtonData then
  begin
    Button := TDynButtonData(cntr);
    if not msg.Inserting then
    begin
      for i := FButtons.Count - 1 downto 0 do
      begin
        if Button = FButtons[i].btnInplace then
        begin
          FButtons.Delete(i);
          btn1.Caption := 'del';
        end;
      end;
    end
    else
    begin
      AddDynButtonData(Button);
      btn1.Caption := 'ins';
      Exit;
    end;
  end;

  if cntr is TDynTabSet then
  begin
    TabSet := TDynTabSet(cntr);
    if not msg.Inserting then
    begin
      for i := FTabControls.Count - 1 downto 0 do
      begin
        if TabSet = FTabControls[i].TabInplace then
        begin
          FTabControls.Delete(i);
          btn1.Caption := 'del';
        end;
      end;
    end
    else
    begin
      AddDynTabSet(TabSet);
      btn1.Caption := 'ins';
      Exit;
    end;
  end;

  if cntr is TDynDateTimePicker then
  begin
    DatTimPick := TDynDateTimePicker(cntr);
    if not msg.Inserting then
    begin
      for i := FDatTims.Count - 1 downto 0 do
      begin
        if DatTimPick = FDatTims[i].DatTimInplace then
        begin
          FDatTims.Delete(i);
          btn1.Caption := 'del';
        end;
      end;
    end
    else
    begin
      AddDynDatTimePck(DatTimPick);
      btn1.Caption := 'ins';
      Exit;
    end;
  end;

end;

constructor TDynWinPanel.Create(AOwner: TComponent);
var
  mEvnt: TTrackMouseEvent;
  i: Integer;
begin
  inherited;
  //DisableAlign;
  FSelectedEdit := nil;
  FSelectedDatTim := nil;
  FSelectedChk := nil;
  FFocusedEdit := nil;
  FFocusedDatTim := nil;
  FFocusedChk := nil;
  FSelectedButton := nil;
  FSelectedCapLab := nil;
  FHotNumButton.Group := nil;
  FSelectedMemo := nil;
  FFocusedMemo := nil;

  if (csDesigning in ComponentState) then
  begin
    Fbtn1 := TDynSpec.Create(Self);

    Fbtn1.Name := 'btn1';
    Fbtn1.Parent := self;
    Fbtn1.Left := 8;
    Fbtn1.Top := 8;
    Fbtn1.Width := 240;
    Fbtn1.Height := 40;
    Fbtn1.AllowAllUp := True;
    Fbtn1.GroupIndex := 1;
    btn1.OnClick := btn1Click;

    //FScrBarV := TDynScrollBar.Create(self);
//    FScrBarV.Kind := sbVertical;
//    FScrBarV.Parent := Self;
//    FScrBarV.Align := alRight;
//    FScrBarV.Max := 1000;
//    FScrBarV.Position := 100;
  end;

  lstvtr1 := TListVTR.Create(Self);


  //lstvtr1.Name := 'lstvtr1';
  lstvtr1.Parent := Self;
  lstvtr1.Left := -112;
  lstvtr1.Top := -9600;
  lstvtr1.Width := 0;
  lstvtr1.Height := 0;
  lstvtr1.ItemIndex := 0;
  lstvtr1.Visible := False;

  //BinMemos := TPanel.Create(self);
//  BinMemos.Name := 'BinMemos';
//  BinMemos.Parent := Self;
//  BinMemos.SetBounds(0,-100, 50, 50);

  ControlStyle := ControlStyle + [csAcceptsControls];
  DoubleBuffered := false;
  FLeaveCombo := false;
  FButtons := TList<TDynButton>.Create;
  FEdits := tlist<TDynEdit>.Create;
  FDatTims := TList<TDynDatTime>.Create;
  //FSynMemos := Tlist<TDynSynMemo>.Create;
  FMemos := Tlist<TDynMemo>.Create;
  FLabels := Tlist<TDynLabel>.Create;
  FChecks := Tlist<TDynCheckBox>.Create;
  FGroupBoxs := TList<TDynGroupBox>.Create;
  FTabControls := TList<TDynTabControl>.Create;

  FlistHotNumButtons := TList<THotNumButton>.Create;
  FlistHotFilterButtons := tlist<THotFilterButton>.Create;

  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  FCanValidateInsert := True;
  FCanMemoResize := false;

  FVScrollStep := 80;
  FVScrollPage := 200;
  FIsScrolling := False;
  FVScrollPos := 0;
  FHScrollPos := 0;
  FScale := 1;
  MaxWidth := 0;
  FHScrollStep := 80;
  FHScrollPage := 200;
  FCanRepaint := True;
  FImageWait := TPicture.Create;

  if not (csDesigning in ComponentState) then
  begin
    FTimerWaithThread := TWaitTrhread.Create(true);
    FTimerWaithThread.Delay := 41;
    FTimerWaithThread.FreeOnTerminate := false;
    FTimerWaithThread.OnWaitTimer := OnWaitTimer;
    FTimerWaithThread.OnTerminate := OnTerminateWait;

    FTimerWaithThread.Resume;
    FTick := 0;
  end;
  FRunTimeCode := TStringList.Create;
  FFilterMode := False;
  WListFilter := 300;
  HListFilter := 200;

end;

procedure TDynWinPanel.CreateParams(var Params: TCreateParams);
begin
  inherited;
  params.Style := Params.Style or WS_VSCROLL;
end;

procedure TDynWinPanel.CreateWindowHandle(const Params: TCreateParams);
var
  i: Integer;
  comp: TComponent;
begin
  inherited;
  FStartingHandle := Self.Handle;

end;

procedure TDynWinPanel.CreateWnd;
var
  i: Integer;
  ctr: TControl;
begin
 inherited;
  if not (csDesigning in ComponentState)  then
  begin
    ListMemos := Tlist<TSizeGripMemo>.Create;
    ListGroups := TList<TDynGroup>.Create;
    ListEdits := TList<TDynEditData>.Create;
    ListLabels := TList<TDynLabelData>.Create;
    ListDates := TList<TDynDateTimePicker>.Create;
    listChecks := TList<TDbCheckBoxResizeWin>.Create;
    AddMemos;
    AddGroups;
    AddEdits;
    AddLabels;
    AddDates;
    AddChecks;

    Winapi.Windows.SetParent(lstvtr1.Handle, 0);
    CallWindowProc(DefWndProc, lstvtr1.Handle, WM_SETFOCUS, 0, 0);
    //FDatTims.Clear;
//    FGroupBoxs.Clear;
//    FMemos.Clear;
//    FEdits.Clear;
//    FChecks.Clear;
//    FLabels.Clear;

  end;

end;

function TDynWinPanel.datTimFromPoint(p: TPoint; scale: extended): TDynDatTime;
var
  i: Integer;
  DatTim: TDynDatTime;
  xR, yR: extended;
  x, y: Integer;
begin
  Result := nil;
    xR := p.x + HScrollPos/ FScale;
    yR := p.Y + VScrollPos / FScale;
    x:= Round(xR);
    y := Round(yR);
  for i:= 0 to FDatTims.Count - 1 do
  begin
    DatTim := FDatTims.Items[i];

    if (yR > DatTim.FRect.Top) and (yR < (DatTim.FRect.Top + DatTim.FRect.Height)) and
       (xr > DatTim.FRect.left) and (xr < (DatTim.FRect.left + DatTim.FRect.Width)* 1) then
    begin
      Result := DatTim;
      Exit;
    end;
  end;
end;

destructor TDynWinPanel.destroy;
var
  i: Integer;
begin
  if not(csDesigning in ComponentState) then
  begin
    FTimerWaithThread.Terminate;
    FreeAndNil(FTimerWaithThread);
    //Self.Clear;
    RemoveGroups;
    ListGroups.Clear;
  end;
  FreeAndNil(FButtons);
  FreeAndNil(FEdits);
  FreeAndNil(FDatTims);
  //FreeAndNil(FSynMemos);
  FreeAndNil(FMemos);
  FreeAndNil(Flabels);
  FreeAndNil(FChecks);
  FGroupBoxs.Clear;
  FreeAndNil(FGroupBoxs);
  FreeAndNil(FTabControls);
  FreeAndNil(FlistHotNumButtons);
  FreeAndNil(FlistHotFilterButtons);



  gifWait.Free;
  FreeAndNil(FImageWait);

  FCanvas.Free;
  FRunTimeCode.Free;

  FreeAndNil(ListMemos);
  FreeAndNil(ListGroups);
  FreeAndNil(ListEdits);
  FreeAndNil(ListLabels);
  FreeAndNil(ListDates);
  FreeAndNil(listChecks);
  //lstvtr1.Destroy;
  FreeAndNil(lstvtr1);
  inherited;
end;



procedure TDynWinPanel.DoDynWheel(msg: TWMMouseWheel);
var
  oldPos, i: Integer;
  oldScale: extended;
  p: TPoint;
  //deltaPos: Integer;
begin
  //for i := 0 to FMemos.Count - 1 do
    //FMemos[i].mmoInplace.Visible := False;
  FResizedetMemo := nil;
  if (FSelectedMemo <> nil) or (FFocusedMemo <> nil) then
  begin
    if (FSelectedMemo <> nil) then
    begin
      FSelectedMemo.mmoInplace.DynVisible := False;
    end;
    FSelectedMemo := nil;
    FFocusedMemo := nil;
  end;
  p := ScreenToClient(Point(msg.XPos, msg.YPos));
  //if (p.x > Width) or (p.x < 0) then Exit;
  if GetKeyState(VK_CONTROL) < 0  then
  begin
    FMousePosScale.X := msg.XPos;
    FMousePosScale.Y := msg.YPos;
    FMousePosScale := ScreenToClient(FMousePosScale);
    oldScale := FScale;
    if msg.WheelDelta < 0 then
    begin

        Scale := FScale*(FCanvas.Font.Height/(FCanvas.Font.Height + 1));
    end
    else
    begin
      if (FCanvas.Font.Height + 1) < - 2 then
        Scale := FScale*(FCanvas.Font.Height/(FCanvas.Font.Height - 1));
    end;
  end
  else
  if GetKeyState(VK_SHIFT) < 0  then
  begin
    if (csDesigning in ComponentState) then
    begin
      if msg.WheelDelta < 0 then
      begin
        FHScrollPos := FHScrollPos + FHScrollStep;
      end
      else
      begin
        FHScrollPos := FHScrollPos - FHScrollStep;
      end;
      UpdateScroll;

    end
    else
    begin
      if msg.WheelDelta < 0 then
      begin
        oldPos := SetScrollPos(Handle, SB_HORZ, FHScrollPos + FHScrollStep, True);
        //btn1.Caption := IntToStr(FHScrollStep);
      end
      else
      begin
        oldPos := SetScrollPos(Handle, SB_HORZ, FHScrollPos - FHScrollStep, True);
        //btn1.Caption := IntToStr(FHScrollStep);
      end;
    end;
  end
  else
  begin
    if msg.WheelDelta < 0 then
    begin
      oldPos := SetScrollPos(Handle, SB_VERT, FVScrollPos + FVScrollStep, True);
    end
    else
    begin
      oldPos := SetScrollPos(Handle, SB_VERT, FVScrollPos - FVScrollStep, True);
    end;

  end;
  CalcGroupHeight;
  CalcGroupWidth;
  FVScrollPos := GetScrollPos(Handle, SB_VERT);
  FHScrollPos := GetScrollPos(Handle, SB_HORZ);
  //deltaPos := oldPos - FVScrollPos;
  Redraw;
end;

procedure TDynWinPanel.DrawButtons(ACanvas: TCanvas);
var
  i: Integer;
  r, rFill: TRect;
  Details: TThemedElementDetails;
  btn: TDynButton;
  str: string;
  txt: string;
begin
  for i := 0 to FButtons.Count - 1 do
  begin
    btn := FButtons[i];
    if btn.btnInplace = nil then
      Continue;
   // ACanvas.Font.Height := Round(edt.FFontHeight * scale);

    begin

      r.Left := Round(btn.FRect.Left * scale) - FHScrollPos;
      r.Top := Round(btn.FRect.Top  * scale  - FVScrollPos);
      r.Width := Round(btn.FRect.Width * scale);
      r.Height := Round(btn.FRect.Height * scale);

      if btn.btnInplace.Visible then
      begin
        btn.btnInplace.CanMove := False;
        btn.btnInplace.SetBounds(r.Left, r.Top, r.Width, r.Height);
        btn.btnInplace.Scale := Scale;
        btn.btnInplace.CanMove := true;
      end;
      if not (csDesigning in ComponentState) then
      begin
        if r.Bottom < 0 then Continue;
        if r.Top > Height then Continue;
      end;

      btn.btnInplace.CanMove := False;
      btn.btnInplace.SetBounds(r.Left, r.Top, r.Width, r.Height);
      btn.btnInplace.Scale := Scale;
      btn.btnInplace.CanMove := true;

      if (csDesigning in ComponentState) then
      begin
        txt := btn.btnInplace.labelCaption;
      end
      else
        txt := '';
      if Assigned(FOnGetText) then
        FOnGetText(Self, btn, txt);
      //if edt.edtInplace.Text <> txt then
//      begin
        btn.btnInplace.CanEdit := False;
        //btn.btnInplace.caption := txt;
        btn.btnInplace.CanEdit := true;
//      end;
      if not(csDesigning in ComponentState) and (ACanvas<> nil)  then
      begin
        //btn.btnInplace.PaintTo(ACanvas, r.Left, r.Top);
        r.Top := r.top - Round(10* Scale);
        r.Left := r.Left + 0;
        r.Width := ACanvas.TextWidth(btn.btnInplace.labelCaption) + Round(4* Scale);
        r.Height := Round(11* Scale);
        //edt.RectLabel := r;
        ACanvas.Brush.Color := ColorBkLabel;
        ACanvas.Font.Height := Round(8* Scale);
        DrawText(ACanvas.Handle, PChar(btn.btnInplace.labelCaption), -1, r, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
      end;
    end;
  end;
end;

procedure TDynWinPanel.DrawChecks(ACanvas: TCanvas);
var
  i: Integer;
  r: TRect;
  chk: TDynCheckBox;
  txt: string;
begin
  for i := 0 to FChecks.Count - 1 do
  begin
    chk := FChecks[i];
    begin
      r.Left := Round(chk.FRect.Left * scale) - FHScrollPos;
      r.Top := Round(chk.FRect.Top  * scale  - FVScrollPos);
      r.Width := Round(chk.FRect.Width * scale);
      r.Height := Round(chk.FRect.Height * scale);
      if chk.chkInplace.Visible then
      begin
        chk.chkInplace.CanMove := False;
        chk.chkInplace.SetBounds(r.Left, r.Top, r.Width, r.Height);
        chk.chkInplace.Scale := Scale;
        chk.chkInplace.CanMove := true;
      end;
      if not (csDesigning in ComponentState) then
      begin
        if r.Bottom < 0 then Continue;
        if r.Top > Height then Continue;
      end;

      chk.chkInplace.CanMove := False;
      chk.chkInplace.SetBounds(r.Left, r.Top, r.Width, r.Height);
      chk.chkInplace.Scale := Scale;
      chk.chkInplace.CanMove := true;


      txt := '';
      if Assigned(FOnGetText) then
        FOnGetText(Self, chk, txt);
      if txt <> '' then
      begin
        chk.chkInplace.Checked := txt = chk.chkInplace.ValueChecked;
      end;
      if ACanvas <> nil then
      begin
        chk.chkInplace.Repaint;
        chk.chkInplace.PaintTo(ACanvas, r.Left, r.Top);
      end;
    end;
  end;
end;

procedure TDynWinPanel.DrawDatTims(ACanvas: TCanvas);
var
  i: Integer;
  r, rFill: TRect;
  DatTim: TDynDatTime;
  str: string;
  dt: TDateTime;
begin
  for i := 0 to FDatTims.Count - 1 do
  begin
    DatTim := FDatTims[i];
    if DatTim.DatTimInplace = nil then
      Continue;

    begin

      r.Left := Round(DatTim.FRect.Left * scale) - FHScrollPos;
      r.Top := Round(DatTim.FRect.Top  * scale  - FVScrollPos);
      r.Width := Round(DatTim.FRect.Width * scale);
      r.Height := Round(DatTim.FRect.Height * scale);

      if DatTim.DatTimInplace.Visible then
      begin
        DatTim.DatTimInplace.CanMove := False;
        DatTim.DatTimInplace.Scale := Scale;
        DatTim.DatTimInplace.CanMove := true;
        DatTim.DatTimInplace.SetBounds(r.Left, r.Top, r.Width, r.Height);


      end;
      if not (csDesigning in ComponentState) then
      begin
        if r.Bottom < 0 then Continue;
        if r.Top > Height then Continue;
      end;

      DatTim.DatTimInplace.CanMove := False;
      DatTim.DatTimInplace.Scale := Scale;
      DatTim.DatTimInplace.CanMove := true;
      DatTim.DatTimInplace.SetBounds(r.Left, r.Top, r.Width, r.Height);

      //DatTim.DatTimInplace.CanMove := true;


        dt := now;
      if Assigned(FOnGetDateTime) then
        FOnGetDateTime(Self, DatTim, dt);
      DatTim.DatTimInplace.CanEdit := False;
      DatTim.DatTimInplace.DateTime := dt;
      DatTim.DatTimInplace.CanEdit := true;
      if not(csDesigning in ComponentState) and (ACanvas<> nil)  then
      begin
        DatTim.DatTimInplace.PaintTo(ACanvas, r.Left, r.Top);
        r.Top := r.top - Round(10* Scale);
        r.Left := r.Left + 0;
        r.Width := ACanvas.TextWidth(DatTim.DatTimInplace.labelCaption) + Round(4* Scale);
        r.Height := Round(11* Scale);
        ACanvas.Brush.Color := ColorBkLabel;
        ACanvas.Font.Height := Round(8* Scale);
        DrawText(ACanvas.Handle, PChar(DatTim.DatTimInplace.labelCaption), -1, r, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
      end;
    end;
  end;
end;

procedure TDynWinPanel.DrawEdits(ACanvas: TCanvas);
var
  i: Integer;
  r, rFill, rFilter: TRect;
  Details: TThemedElementDetails;
  edt: TDynEdit;
  str: string;
  txt: string;
begin
  for i := 0 to FEdits.Count - 1 do
  begin
    edt := FEdits[i];
    if edt.edtInplace = nil then
      Continue;
   // ACanvas.Font.Height := Round(edt.FFontHeight * scale);

    begin

      if FFilterMode then
      begin
        r.Left := Round(edt.FRect.Left * scale) - FHScrollPos;
        r.Top := Round(edt.FRect.Top  * scale  - FVScrollPos);
        r.Width := Round((edt.FRect.Width - 12) * scale);
        r.Height := Round(edt.FRect.Height * scale);
        rFilter.Left := r.Right;
        rFilter.Top := r.Top;
        rFilter.Width := round(12*scale);
        rFilter.Height := rFilter.Width;

      end
      else
      begin
        r.Left := Round(edt.FRect.Left * scale) - FHScrollPos;
        r.Top := Round(edt.FRect.Top  * scale  - FVScrollPos);
        r.Width := Round(edt.FRect.Width * scale);
        r.Height := Round(edt.FRect.Height * scale);
      end;

      if edt.edtInplace.Visible then
      begin
        edt.edtInplace.CanMove := False;
        edt.edtInplace.SetBounds(r.Left, r.Top, r.Width, r.Height);
        edt.edtInplace.Scale := Scale;
        edt.edtInplace.CanMove := true;
      end;
      if not (csDesigning in ComponentState) then
      begin
        if r.Bottom < 0 then Continue;
        if r.Top > Height then Continue;
      end;

      edt.edtInplace.CanMove := False;
      edt.edtInplace.SetBounds(r.Left, r.Top, r.Width, r.Height);
      edt.edtInplace.Scale := Scale;
      edt.edtInplace.CanMove := true;

      if (csDesigning in ComponentState) then
      begin
        txt := edt.edtInplace.labelCaption;
      end
      else
        txt := '';
      if Assigned(FOnGetText) then
        FOnGetText(Self, edt, txt);
      //if edt.edtInplace.Text <> txt then
//      begin
        edt.edtInplace.CanEdit := False;
        edt.edtInplace.Text := txt;
        edt.edtInplace.CanEdit := true;
//      end;
      if not(csDesigning in ComponentState) and (ACanvas<> nil)  then
      begin
        edt.edtInplace.PaintTo(ACanvas, r.Left, r.Top);
        r.Top := r.top - Round(10* Scale);
        r.Left := r.Left + 0;
        r.Width := ACanvas.TextWidth(edt.edtInplace.labelCaption) + Round(4* Scale);
        r.Height := Round(11* Scale);
        //edt.RectLabel := r;
        ACanvas.Brush.Color := ColorBkLabel;
        ACanvas.Font.Height := Round(8* Scale);
        DrawText(ACanvas.Handle, PChar(edt.edtInplace.labelCaption), -1, r, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
        if FilterMode then
        begin
          DrawFilterButton(ACanvas, edt, rFilter);
        end;

      end;
    end;
  end;
end;

procedure TDynWinPanel.DrawFilterButton(TargetCanvas: TCanvas; DynCtrl: TBaseControl; rFilter: Trect);
var
  offset: Integer;
  hb: THotFilterButton;
begin
  hb.ctrl := DynCtrl;
  hb.r := rFilter;
  FlistHotFilterButtons.Add(hb);

  if (FHotFilterButton.ctrl = DynCtrl) then
  begin
    DrawFrameControl(TargetCanvas.Handle, rFilter, DFC_BUTTON, DFCS_BUTTONPUSH or DFCS_PUSHED);
    offset := 3;
  end
  else
  begin
    DrawFrameControl(TargetCanvas.Handle, rFilter, DFC_BUTTON, DFCS_BUTTONPUSH);
    offset := 2;
  end;
end;

procedure TDynWinPanel.DrawGroupBoxs(ACanvas: TCanvas);
var
  i: Integer;
  r, rFill, rButton, rTabs: TRect;

  Details: TThemedElementDetails;
  grp: TDynGroupBox;
  str: string;
  txt: string;
begin
  FlistHotNumButtons.Clear;
  for i := 0 to FGroupBoxs.Count - 1 do
  begin
    grp := FGroupBoxs[i];
    if grp.grpInplace = nil then
      Continue;
   // ACanvas.Font.Height := Round(edt.FFontHeight * scale);

    begin

      r.Left := Round(grp.FRect.Left * scale) - FHScrollPos;
      r.Top := Round(grp.FRect.Top  * scale  - FVScrollPos);
      r.Width := Round(grp.FRect.Width * scale);
      r.Height := Round(grp.FRect.Height * scale);

      if grp.grpInplace.Visible then
      begin
        grp.grpInplace.CanMove := False;
        grp.grpInplace.SetBounds(r.Left, r.Top, r.Width, r.Height);
        grp.grpInplace.Scale := Scale;
        grp.grpInplace.CanMove := true;
      end;
      if not (csDesigning in ComponentState) then
      begin
        if r.Bottom < 0 then Continue;
        if r.Top > Height then Continue;
      end;

     // grp.grpInplace.CanMove := False;
      grp.grpInplace.SetBounds(r.Left, r.Top, r.Width, r.Height);
      grp.grpInplace.Scale := Scale;
      //grp.grpInplace.CanMove := true;

      txt := grp.grpInplace.labelCaption;
      if Assigned(FOnGetText) then
        FOnGetText(Self, grp, txt);
      //if grp.grpInplace.Text <> txt then
//      begin
//        grp.grpInplace.Text := txt;
//      end;
      if not(csDesigning in ComponentState) and (ACanvas<> nil)  then
      begin
        ACanvas.Pen.Style := psDot;
        ACanvas.Pen.Mode := pmCopy;
        ACanvas.Pen.Color := $006C1500;////$00F49237;
        ACanvas.Brush.Style := bsClear;
        ACanvas.Rectangle(r);

        rButton.Top := r.Bottom - Round(14* Scale);
        rButton.Left := Round(r.Right - 2 - 12* 4 * Scale);
        rButton.Width := round(12 * 4 * Scale);
        rButton.Height := Round(12* Scale);

        rTabs.Top := r.Top + 1;// + Round(2* Scale);
        rTabs.Left := r.Left + 10;
        rTabs.Height := Round(15* Scale);
        rTabs.Width := r.Width div 5;


        r.Top := r.top - Round(10* Scale);
        r.Left := r.Left + 0;
        //r.Right := Round(r.Left +40 * Scale);
        r.Height := Round(11* Scale);
        ACanvas.Brush.Color := ColorBkLabel;//$00FAA5C5;
        ACanvas.Font.Height := Round(8* Scale);
        DrawText(ACanvas.Handle, PChar(grp.grpInplace.labelCaption), -1, r, DT_LEFT or DT_VCENTER or DT_SINGLELINE);

        //DrawFrameControl(ACanvas.Handle,rButton , DFC_BUTTON, DFCS_BUTTONPUSH or DFCS_PUSHED);
        //DrawFrameControl(ACanvas.Handle,rButton, DFC_BUTTON, DFCS_BUTTONPUSH);
        DrawGroupButton(ACanvas, grp, rButton);
        DrawGroupTabs(ACanvas, grp, rTabs);

      end;
    end;
  end;
end;

procedure TDynWinPanel.DrawGroupButton(TargetCanvas: TCanvas; gr: TDynGroupBox; r: Trect);
var
  imgButton: Vcl.Graphics.TBitmap;
  offset, i, imageIndex: Integer;
  ButtonVisible: Boolean;
  rDraw: TRect;
  hb: THotNumButton;
begin
  //if IsOut then  Exit;
  for i := 0 to 3 do
  begin
    imageIndex := 0;
    ButtonVisible := False;
    if Assigned(FOnDrawGroupButton) then
    begin
      FOnDrawGroupButton(Self, gr, ButtonVisible, i, imageIndex);
    end;
    if not ButtonVisible then Continue;

    rDraw.Left := r.Left + Round(12 * scale) * i;
    rDraw.Top := r.Top;
    rDraw.Width := Round(12 * scale);
    rDraw.Height := Round(12 * scale);
    hb.Group := gr;
    hb.NumButton := i;
    hb.r := rDraw;
    FlistHotNumButtons.Add(hb);

    if (FHotNumButton.Group = gr) and (FHotNumButton.NumButton = i) then
    begin
      DrawFrameControl(TargetCanvas.Handle,rDraw, DFC_BUTTON, DFCS_BUTTONPUSH or DFCS_PUSHED);
      offset := 3;
    end
    else
    begin
      DrawFrameControl(TargetCanvas.Handle,rDraw, DFC_BUTTON, DFCS_BUTTONPUSH);
      offset := 2;
    end;

    imgButton := Vcl.Graphics.TBitmap.Create;
    //StateImages.GetBitmap(imageIndex, imgButton);
    //TargetCanvas.Draw(rDraw.left + offset,rDraw.Top + offset, imgButton);
    imgButton.Free;
  end;
end;

procedure TDynWinPanel.DrawGroupTabs(TargetCanvas: TCanvas; gr: TDynGroupBox; r: Trect);
var
  Group: TDynGroup;
  Details: TThemedElementDetails;
  i: Integer;
  minW: Integer;
  str: string;
begin
  Group := gr.grpInplace;
  minW := TargetCanvas.TextWidth('X...');

  for i := 0 to Group.Tabs.Count - 1 do
  begin
    if i = Group.TabIndex then
    begin
      Details := StyleServices.GetElementDetails(tbPushButtonPressed);
    end
    else
    begin
      Details := StyleServices.GetElementDetails(tbPushButtonNormal);
    end;
    str := Group.Tabs[i];
    r.Width := TargetCanvas.TextWidth(str) + 10;
    StyleServices.DrawElement(TargetCanvas.Handle, Details, r);
    SetBkMode(TargetCanvas.Handle,TRANSPARENT);
    SetTextColor(TargetCanvas.Handle, clBlack);
    DrawText(TargetCanvas.Handle, PChar(str), -1, r, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
    r.Offset(r.Width, 0);
  end;
  Exit;
  if  true then //btn.IsDown then
  begin
     Details := StyleServices.GetElementDetails(tbPushButtonPressed);
  end
  else
  begin
    Details := StyleServices.GetElementDetails(tbPushButtonNormal);
  end;
  StyleServices.DrawElement(TargetCanvas.Handle, Details, r);
  SetBkMode(TargetCanvas.Handle,TRANSPARENT);
  SetTextColor(TargetCanvas.Handle, clBlack);

  DrawText(TargetCanvas.Handle, PChar('Очни болести'), -1, r, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
  r.Offset(r.Width, 0);
  if  true then //btn.IsDown then
  begin
     Details := StyleServices.GetElementDetails(tbsTabSelected);
  end
  else
  begin
    Details := StyleServices.GetElementDetails(tbsTabSelected);
  end;
  StyleServices.DrawElement(TargetCanvas.Handle, Details, r);
  DrawText(TargetCanvas.Handle, PChar('Нервни болести'), -1, r, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
end;

procedure TDynWinPanel.DrawLabels(ACanvas: TCanvas);
var
  i: Integer;
  lbl: TDynLabel;
begin
  for i := 0 to FLabels.Count - 1 do
  begin
    lbl := FLabels[i];
    RepaintLabel(ACanvas, lbl);
  end;
end;

procedure TDynWinPanel.DrawMemos(ACanvas: TCanvas);
var
  i: Integer;
  r, rFill: TRect;
  Details: TThemedElementDetails;
  mmo: TDynMemo;
  str, txt: string;

  SI_V, SI_H: TScrollInfo;
  HH: Integer;
  RR, VertScrollRect, VertUpButtonRect, VertDownButtonRect, VertSliderRect: TRect;
begin
 // Exit;
  for i := 0 to FMemos.Count - 1 do
  begin
    mmo := FMemos[i];
    if mmo = FResizedetMemo then
    begin
      DrawResizedetMemos(ACanvas, mmo);
      Continue;
    end;
    if (mmo = FFocusedMemo) then
      Continue;
    //if (mmo.mmoInplace = CalculatedMemo) then
//      Continue;
    //ACanvas.Font.Height := Round(mmo.FFontHeight * scale);
    r.Left := Round(mmo.FRect.Left * scale) - FHScrollPos;
    r.Top := Round(mmo.FRect.Top  * scale  - FVScrollPos);
    r.Width := Round(mmo.FRect.Width * scale);
    r.Height := Round(mmo.FRect.Height * scale);
    begin
      if mmo.mmoInplace.Visible  then
      begin
        mmo.mmoInplace.CanMove := False;
        mmo.mmoInplace.SetBounds(r.Left, r.Top, r.Width , r.Height);
        mmo.mmoInplace.Scale := Scale;
        mmo.mmoInplace.CanMove := true;
      end;
      if not (csDesigning in ComponentState) then
      begin
        if r.Bottom < 0 then Continue;
        if r.Top > Height then Continue;
      end
      else
      begin
        mmo.mmoInplace.CanMove := False;
        mmo.mmoInplace.SetBounds(r.Left, r.Top, r.Width , r.Height);
        mmo.mmoInplace.Scale := Scale;
        mmo.mmoInplace.CanMove := true;
      end;






      if not(csDesigning in ComponentState) and (ACanvas<> nil)  then
      begin
        if Screen.ActiveControl <> mmo.mmoInplace then
        begin
          txt := '';
          if Assigned(FOnGetText) then
          begin
            FOnGetText(Self, mmo, txt);
            mmo.mmoInplace.Lines.Text := txt;
            //mmo.mmoInplace.CanMove := False;
            //mmo.mmoInplace.AdjustHeight(False);
            //HH := mmo.mmoInplace.AdjustHeight(false);
//            r.Height := HH;
//            mmo.FRect.Height := Round(HH/scale);
            mmo.mmoInplace.CanMove := true;

          end;
        end;
        ACanvas.Brush.Color := mmo.mmoInplace.Color;
        ACanvas.FillRect(r);
        mmo.mmoInplace.PaintTo(ACanvas, r.Left, r.Top);
        VertScrollRect := System.Classes.Rect(r.Right - GetSystemMetrics(SM_CXVSCROLL)- 1,
                        r.Top + 1, r.Right - 1  , r.Bottom - 1);// - GetSystemMetrics(SM_CXHSCROLL));
        VertDownButtonRect := VertScrollRect;
        VertDownButtonRect.top := VertDownButtonRect.Bottom - GetSystemMetrics(SM_CYVTHUMB);
        VertUpButtonRect := VertScrollRect;
        VertUpButtonRect.Bottom := VertUpButtonRect.Top + GetSystemMetrics(SM_CYVTHUMB);

//
        FillChar(SI_V, SizeOf(SI_V), #0);
        SI_V.cbSize := SizeOf(SI_V);
        SI_V.fMask := SIF_POS;
        GetScrollInfo(mmo.mmoInplace.Handle, SB_VERT, SI_V);
//
//        FillChar(SI_H, SizeOf(SI_H), #0);
//        SI_H.cbSize := SizeOf(SI_H);
//        SI_H.fMask := SIF_ALL;
//        GetScrollInfo(mmo.mmoInplace.Handle, SB_HORZ, SI_H);

        Rr := VertScrollRect;
        Rr.Top := VertUpButtonRect.Bottom;
        Rr.Bottom := VertDownButtonRect.Top;
        if (Rr.Height > 0) and (Rr.Width > 0) then
        begin
          Details := StyleServices.GetElementDetails(tsUpperTrackVertNormal);
          StyleServices.DrawElement(ACanvas.Handle, Details, Rr);
        end;

        Details := StyleServices.GetElementDetails(tsArrowBtnUpDisabled);
        StyleServices.DrawElement(ACanvas.Handle, Details, VertUpButtonRect);

        Details := StyleServices.GetElementDetails(tsArrowBtnDownDisabled);
        StyleServices.DrawElement(ACanvas.Handle, Details, VertDownButtonRect);

        //Details := StyleServices.GetElementDetails(tsThumbBtnVertNormal);
        //StyleServices.DrawElement(ACanvas.Handle, Details, GetVertSliderRect);


        r.Top := r.top - Round(10* Scale);
        r.Left := r.Left + 0;
        //r.Right := Round(r.Left +40 * Scale);
        r.Height := Round(11* Scale);
        ACanvas.Brush.Color := ColorBkLabel;
        ACanvas.Font.Height := Round(8* Scale);
        DrawText(ACanvas.Handle, PChar(mmo.mmoInplace.labelCaption), -1, r, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
      end;

    end;
  end;
end;

procedure TDynWinPanel.DrawResizedetMemos(ACanvas: TCanvas; mmo: TDynMemo);
var
  i: Integer;
  r, rFill: TRect;
  Details: TThemedElementDetails;
  str, txt: string;

  SI_V, SI_H: TScrollInfo;
  HH: Integer;
  RR, VertScrollRect, VertUpButtonRect, VertDownButtonRect, VertSliderRect: TRect;
begin
    //if (mmo = FFocusedMemo) or (mmo = FResizedetMemo) then
//      Continue;
    r.Left := Round(mmo.FRect.Left * scale) - FHScrollPos;
    r.Top := Round(mmo.FRect.Top  * scale  - FVScrollPos);
    r.Width := Round(mmo.FRect.Width * scale);
    r.Height := Round(mmo.FRect.Height * scale);
    r.Top := r.top - Round(10* Scale);
    r.Left := r.Left + 0;
    //r.Right := Round(r.Left +40 * Scale);
    r.Height := Round(11* Scale);
    ACanvas.Brush.Color := ColorBkLabel;
    ACanvas.Font.Height := Round(8* Scale);
    DrawText(ACanvas.Handle, PChar(mmo.mmoInplace.labelCaption), -1, r, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
end;

//procedure TDynWinPanel.DrawSynMemos(ACanvas: TCanvas);
//var
//  i: Integer;
//  r, rFill: TRect;
//  Details: TThemedElementDetails;
//  mmo: TDynSynMemo;
//  str, txt: string;
//
//  SI_V, SI_H: TScrollInfo;
//  HH: Integer;
//  RR, VertScrollRect, VertUpButtonRect, VertDownButtonRect, VertSliderRect: TRect;
//begin
//  for i := 0 to FSynMemos.Count - 1 do
//  begin
//    mmo := FSynMemos[i];
//    //ACanvas.Font.Height := Round(mmo.FFontHeight * scale);
//    r.Left := Round(mmo.FRect.Left * scale) - FHScrollPos;
//    r.Top := Round(mmo.FRect.Top  * scale  - FVScrollPos);
//    r.Width := Round(mmo.FRect.Width * scale);
//    r.Height := Round(mmo.FRect.Height * scale);
//    begin
//      if mmo.mmoInplace.Visible  then
//      begin
//        mmo.mmoInplace.CanMove := False;
//        mmo.mmoInplace.SetBounds(r.Left, r.Top, r.Width , r.Height);
//        mmo.mmoInplace.Scale := Scale;
//        mmo.mmoInplace.CanMove := true;
//      end;
//      if not (csDesigning in ComponentState) then
//      begin
//        if r.Bottom < 0 then Continue;
//        if r.Top > Height then Continue;
//      end
//      else
//      begin
//        mmo.mmoInplace.CanMove := False;
//        mmo.mmoInplace.SetBounds(r.Left, r.Top, r.Width , r.Height);
//        mmo.mmoInplace.Scale := Scale;
//        mmo.mmoInplace.CanMove := true;
//      end;
//
//
//
//
//
//
//      if not(csDesigning in ComponentState) and (ACanvas<> nil)  then
//      begin
//        if Screen.ActiveControl <> mmo.mmoInplace then
//        begin
//          txt := '';
//          if Assigned(FOnGetText) then
//          begin
//            FOnGetText(Self, mmo, txt);
//            mmo.mmoInplace.Lines.Text := txt;
//            //mmo.mmoInplace.CanMove := False;
////            //mmo.mmoInplace.AdjustHeight(False);
//            //HH := mmo.mmoInplace.AdjustHeight(false);
////            r.Height := HH;
////            mmo.FRect.Height := Round(HH/scale);
//            mmo.mmoInplace.CanMove := true;
//          end;
//        end;
//        VertScrollRect := System.Classes.Rect(r.Right - GetSystemMetrics(SM_CXVSCROLL)- 1,
//                        r.Top + 1, r.Right - 1  , r.Bottom - 1);// - GetSystemMetrics(SM_CXHSCROLL));
//      VertDownButtonRect := VertScrollRect;
//      VertDownButtonRect.top := VertDownButtonRect.Bottom - GetSystemMetrics(SM_CYVTHUMB);
//      VertUpButtonRect := VertScrollRect;
//      VertUpButtonRect.Bottom := VertUpButtonRect.Top + GetSystemMetrics(SM_CYVTHUMB);
//
//        mmo.mmoInplace.CanMove := False;
//        mmo.mmoInplace.SetBounds(r.Left, r.Top, r.Width , r.Height);
//        mmo.mmoInplace.Scale := Scale;
//        mmo.mmoInplace.CanMove := true;
//
//        mmo.mmoInplace.PaintTo(ACanvas, r.Left, r.Top);
//
//        FillChar(SI_V, SizeOf(SI_V), #0);
//        SI_V.cbSize := SizeOf(SI_V);
//        SI_V.fMask := SIF_POS;
//        GetScrollInfo(mmo.mmoInplace.Handle, SB_VERT, SI_V);
//
//        FillChar(SI_H, SizeOf(SI_H), #0);
//        SI_H.cbSize := SizeOf(SI_H);
//        SI_H.fMask := SIF_ALL;
//        GetScrollInfo(mmo.mmoInplace.Handle, SB_HORZ, SI_H);
//        Rr := VertScrollRect;
//        Rr.Top := VertUpButtonRect.Bottom;
//        Rr.Bottom := VertDownButtonRect.Top;
//        if (Rr.Height > 0) and (Rr.Width > 0) then
//        begin
//          Details := StyleServices.GetElementDetails(tsUpperTrackVertNormal);
//          StyleServices.DrawElement(ACanvas.Handle, Details, Rr);
//        end;
//
//        Details := StyleServices.GetElementDetails(tsArrowBtnUpDisabled);
//        StyleServices.DrawElement(ACanvas.Handle, Details, VertUpButtonRect);
//
//        Details := StyleServices.GetElementDetails(tsArrowBtnDownDisabled);
//        StyleServices.DrawElement(ACanvas.Handle, Details, VertDownButtonRect);
//
//        //Details := StyleServices.GetElementDetails(tsThumbBtnVertNormal);
//        //StyleServices.DrawElement(ACanvas.Handle, Details, GetVertSliderRect);
//
//
//        r.Top := r.top - Round(10* Scale);
//        r.Left := r.Left + 0;
//        //r.Right := Round(r.Left +40 * Scale);
//        r.Height := Round(11* Scale);
//        ACanvas.Brush.Color := ColorBkLabel;
//        ACanvas.Font.Height := Round(8* Scale);
//        DrawText(ACanvas.Handle, PChar(mmo.mmoInplace.labelCaption), -1, r, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
//      end;
//
//    end;
//  end;
//end;

procedure TDynWinPanel.DrawSpeedButton( btn: TSpeedButton; r: Trect);
begin
  fcanvas.CopyRect(btn.BoundsRect, TDynSpec(btn).Canvas, btn.ClientRect);
end;

procedure TDynWinPanel.DrawTabControls(ACanvas: TCanvas);
var
  i: Integer;
  r, rFill: TRect;
  tc: TDynTabControl;
  str: string;
  txt: string;
  rt: Integer;
begin
  for i := 0 to FTabControls.Count - 1 do
  begin
    tc := FTabControls[i];
    if tc.TabInplace = nil then
      Continue;
   // ACanvas.Font.Height := Round(edt.FFontHeight * scale);

    begin

      r.Left := Round(tc.FRect.Left * scale) - FHScrollPos;
      r.Top := Round(tc.FRect.Top  * scale  - FVScrollPos);
      r.Width := Round(tc.FRect.Width * scale);
      r.Height := Round(tc.FRect.Height * scale);
      tc.RealHeight := Round(tc.TabInplace.RealHeight * Scale);

      if tc.TabInplace.Visible then
      begin
        tc.TabInplace.CanMove := False;
        tc.TabInplace.SetBounds(r.Left, r.Top, r.Width, r.Height);
        tc.TabInplace.Scale := Scale;
        tc.TabInplace.CanMove := true;
      end;
      if not (csDesigning in ComponentState) then
      begin
        if r.Bottom  + tc.RealHeight < 0 then Continue;
        if r.Top > Height then Continue;
      end;

      tc.TabInplace.CanMove := False;
      tc.TabInplace.SetBounds(r.Left, r.Top, r.Width, r.Height);
      tc.TabInplace.Scale := Scale;
      tc.TabInplace.CanMove := true;
      r.Height := r.Height + tc.RealHeight;
      r.Inflate(1, 0);
      if (csDesigning in ComponentState) then
      begin
        txt := tc.TabInplace.labelCaption;
      end
      else
        txt := '';
      if Assigned(FOnGetText) then
        FOnGetText(Self, tc, txt);
      if not(csDesigning in ComponentState) and (ACanvas<> nil)  then
      begin
        ACanvas.Pen.Style := psDot;
        ACanvas.Pen.Mode := pmCopy;
        ACanvas.Pen.Color := $006C1500;////$00F49237;
        ACanvas.Brush.Style := bsClear;
        ACanvas.Rectangle(r);
        //tc.TabInplace.PaintTo(ACanvas, r.Left, r.Top);
        r.Top := r.top - Round(10* Scale);
        r.Left := r.Left + 0;
        r.Width := ACanvas.TextWidth(tc.TabInplace.labelCaption) + Round(4* Scale);
        r.Height := Round(11* Scale);
        //edt.RectLabel := r;
        ACanvas.Brush.Color := ColorBkLabel;
        ACanvas.Font.Height := Round(8* Scale);
        DrawText(ACanvas.Handle, PChar(tc.TabInplace.labelCaption), -1, r, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
      end;
    end;
  end;
end;

function TDynWinPanel.DynCapLabFromPoint(p: TPoint; scale: extended): TBaseControl;
var
  i: Integer;
  dyn: TBaseControl;
  xR, yR: extended;
  x, y: Integer;
begin
  Result := nil;
    xR := p.x + HScrollPos/ FScale;
    yR := p.Y + VScrollPos / FScale;
    x:= Round(xR);
    y := Round(yR);
  for i:= 0 to FEdits.Count - 1 do
  begin
    dyn := FEdits.Items[i];

    if (yR > dyn.FRect.Top - 10) and (yR < (dyn.FRect.Top - 10 + 11)) and
       (xr > dyn.FRect.left) and (xr < (dyn.FRect.left + dyn.FRect.Width)* 1) then
    begin
      Result := dyn;
      Exit;
    end;
  end;
  //for i:= 0 to FSynMemos.Count - 1 do
//  begin
//    dyn := FSynMemos.Items[i];
//
//    if (yR > dyn.FRect.Top - 10) and (yR < (dyn.FRect.Top - 10 + 11)) and
//       (xr > dyn.FRect.left) and (xr < (dyn.FRect.left + dyn.FRect.Width)* 1) then
//    begin
//      Result := dyn;
//      Exit;
//    end;
//  end;
  for i:= 0 to FGroupBoxs.Count - 1 do
  begin
    dyn := FGroupBoxs.Items[i];

    if (yR > dyn.FRect.Top - 10) and (yR < (dyn.FRect.Top - 10 + 11)) and
       (xr > dyn.FRect.left) and (xr < (dyn.FRect.left + dyn.FRect.Width)* 1) then
    begin
      Result := dyn;
      Exit;
    end;
  end;
end;

function TDynWinPanel.EdtFromPoint(p: TPoint; scale: extended): TDynEdit;
var
  i: Integer;
  edt: TDynEdit;
  xR, yR: extended;
  x, y: Integer;
begin
  Result := nil;
    xR := p.x + HScrollPos/ FScale;
    yR := p.Y + VScrollPos / FScale;
    x:= Round(xR);
    y := Round(yR);
  for i:= 0 to FEdits.Count - 1 do
  begin
    edt := FEdits.Items[i];

    if (yR > edt.FRect.Top) and (yR < (edt.FRect.Top + edt.FRect.Height)) and
       (xr > edt.FRect.left) and (xr < (edt.FRect.left + edt.FRect.Width)* 1) then
    begin
      Result := edt;
      Exit;
    end;
  end;
end;

function TDynWinPanel.FilterButtonFromPoint(p: TPoint; scale: extended): THotFilterButton;
var
  i: Integer;
  hb: THotFilterButton;
begin
  Result.ctrl := nil;
  for i := 0 to FlistHotFilterButtons.Count - 1 do
  begin
    hb := FlistHotFilterButtons[i];
    if hb.r.Contains(p) then
    begin
      Result := hb;
      Exit;
    end;
  end;
end;

function TDynWinPanel.GenerateRTCDynCheckRelative(Grp: TDynGroupBox; DyndCheck: TDynCheckBox): string;
var
  Check: TDbCheckBoxResizeWin;
  Group: TDynGroup;
  relLeft, relTop, relRight, relBottom: Integer;
begin
  Check := TDbCheckBoxResizeWin(DyndCheck.chkInplace);
  Group := TDynGroup(Grp.grpInplace);
  relLeft := Check.DynLeft - Group.DynLeft;
  relTop := Check.DynTop - Group.DynTop;
  relRight := Check.DynRight - Group.DynLeft;
  relBottom := Check.DynBottom - Group.DynTop;

  Result := Format('chk := %s.AddRunTimeDynCheckRelative(%s, %d, %d, %d, %d, %d, %d, ''%s'');',
            [self.Name, 'NewGroup', relLeft, relTop, relRight,
             relBottom, Check.Tag, Check.DynFontHeight, '']);
end;

function TDynWinPanel.GenerateRTCDynDateRelative(Grp: TDynGroupBox; DyndDatPic: TDynDatTime): string;
var
  DatPic: TDynDateTimePicker;
  Group: TDynGroup;
  relLeft, relTop, relRight, relBottom: Integer;
begin
  DatPic := TDynDateTimePicker(DyndDatPic.DatTimInplace);
  Group := TDynGroup(Grp.grpInplace);
  relLeft := DatPic.DynLeft - Group.DynLeft;
  relTop := DatPic.DynTop - Group.DynTop;
  relRight := DatPic.DynRight - Group.DynLeft;
  relBottom := DatPic.DynBottom - Group.DynTop;

  Result := Format('dt := %s.AddRunTimeDynDateRelative(%s, %d, %d, %d, %d, %d, %d, ''%s'');',
            [self.Name, 'NewGroup', relLeft, relTop, relRight,
             relBottom, DatPic.Tag, DatPic.DynFontHeight, DatPic.labelCaption]);
end;

function TDynWinPanel.GenerateRTCDynEditRelative(Grp: TDynGroupBox; DynEdit: TDynEdit): string;
var
  Edit: TDynEditData;
  Group: TDynGroup;
  relLeft, relTop, relRight, relBottom: Integer;
begin
  Edit := TDynEditData(DynEdit.edtInplace);
  Group := TDynGroup(Grp.grpInplace);
  relLeft := Edit.DynLeft - Group.DynLeft;
  relTop := Edit.DynTop - Group.DynTop;
  relRight := Edit.DynRight - Group.DynLeft;
  relBottom := Edit.DynBottom - Group.DynTop;

  Result := Format('edt := %s.AddRunTimeDynEditRelative(%s, %d, %d, %d, %d, %d, %d, ''%s'');',
            [self.Name, 'NewGroup', relLeft, relTop, relRight,
             relBottom, edit.Tag, edit.DynFontHeight, edit.labelCaption]);
end;

function TDynWinPanel.GenerateRTCDynGrpRelative(Grp, Grp1: TDynGroupBox): string;
var
  Group, Group1: TDynGroup;
  relLeft, relTop, relRight, relBottom: Integer;
begin
  Group1 := TDynGroup(Grp1.grpInplace);
  Group := TDynGroup(Grp.grpInplace);
  relLeft := Group1.DynLeft - Group.DynLeft;
  relTop := Group1.DynTop - Group.DynTop;
  relRight := Group1.DynRight - Group.DynLeft;
  relBottom := Group1.DynBottom - Group.DynTop;

  Result := Format('grp := %s.AddRunTimeDynGrpRelative(%s, %d, %d, %d, %d, %d, %d, ''%s'');',
            [self.Name, 'NewGroup', relLeft, relTop, relRight,
             relBottom, Group1.Tag, Group1.DynFontHeight, Group1.labelCaption]);
end;

function TDynWinPanel.GenerateRTCDynLabelRelative(Grp: TDynGroupBox; DyndLabel: TDynLabel): string;
var
  Lab: TDynLabelData;
  Group: TDynGroup;
  relLeft, relTop, relRight, relBottom: Integer;
begin
  Lab := TDynLabelData(DyndLabel.lblInplace);
  Group := TDynGroup(Grp.grpInplace);
  relLeft := Lab.DynLeft - Group.DynLeft;
  relTop := Lab.DynTop - Group.DynTop;
  relRight := Lab.DynRight - Group.DynLeft;
  relBottom := Lab.DynBottom - Group.DynTop;

  Result := Format('lbl := %s.AddRunTimeDynLabelRelative(%s, %d, %d, %d, %d, %d, %d, ''%s'');',
            [self.Name, 'NewGroup', relLeft, relTop, relRight,
             relBottom, Lab.Tag, Lab.DynFontHeight, Lab.Caption]);
end;

function TDynWinPanel.GenerateRTCDynMemoRelative(Grp: TDynGroupBox; DynMemo: TDynMemo): string;
var
  Memo: TSizeGripMemo;
  Group: TDynGroup;
  relLeft, relTop, relRight, relBottom: Integer;
begin
  Memo := TSizeGripMemo(DynMemo.mmoInplace);
  Group := TDynGroup(Grp.grpInplace);
  relLeft := Memo.DynLeft - Group.DynLeft;
  relTop := Memo.DynTop - Group.DynTop;
  relRight := Memo.DynRight - Group.DynLeft;
  relBottom := Memo.DynBottom - Group.DynTop;

  Result := Format('mmo := %s.AddRunTimeDynMemoRelative(%s, %d, %d, %d, %d, %d, %d, ''%s'');',
            [self.Name, 'NewGroup', relLeft, relTop, relRight,
             relBottom, Memo.Tag, Memo.DynFontHeight, Memo.labelCaption]);
end;

procedure TDynWinPanel.GenerateRunTimeCode;
var
  i: Integer;
begin
  FRunTimeCode.Clear;
  for i := 0 to FEdits.Count - 1 do
  begin
    FRunTimeCode.Add(GenerateRunTimeCodeDynEdit(FEdits[i]));
  end;
  for i := 0 to FGroupBoxs.Count - 1 do
  begin
    FRunTimeCode.Add(GenerateRunTimeCodeDynGroup(FGroupBoxs[i]));
  end;
  //for i := 0 to FMemos.Count - 1 do
//  begin
//    FRunTimeCode.Add(GenerateRunTimeCodeDynMemo(FSynMemos[i]));
//  end;
end;

function TDynWinPanel.GenerateRunTimeCodeDynEdit(DynEdit: TDynEdit): string;
var
  Edit: TDynEditData;
  grp: TDynGroup;
begin
  Edit := TDynEditData(DynEdit.edtInplace);

  if Edit.FDynEdit <> nil then
  begin
    TDynEdit(Edit.FDynEdit).ParentGroup := nil;
    FGroupBoxs.Items[0].CalcChild;
    grp := TDynEdit(Edit.FDynEdit).FParentGroup.grpInplace;
    Result := Format('%s.AddRunTimeDynEditRelative(%d, %d, %d, %d, %d, %d, ''%s'');',
              [self.Name, edit.DynLeft - grp.DynLeft, edit.DynTop - grp.DynTop,
              edit.DynRight - grp.DynLeft , edit.DynBottom - grp.DynTop,
              edit.Tag, edit.DynFontHeight, edit.labelCaption]);
  end
  else
  begin

  end;
end;

function TDynWinPanel.GenerateRunTimeCodeDynGroup(DynGrp: TDynGroupBox): string;
var
  Group: TDynGroup;
begin
  Group := TDynGroup(DynGrp.grpInplace);
  Result := Format('NewGroup := %s.AddRunTimeDynGroup(%d, %d, %d, %d, %d, %d, ''%s'');',
            [self.Name, Group.DynLeft, Group.DynTop, Group.DynRight,
            Group.DynBottom, Group.Tag, Group.DynFontHeight, Group.labelCaption]);
end;



function TDynWinPanel.GenerateRunTimeCodeDynMemo(DynMmo: TDynMemo): string;
var
  Memo: TSizeGripMemo;
begin
  Memo := TSizeGripMemo(DynMmo.mmoInplace);
  Result := Format('%s.AddRunTimeDynMemo(%d, %d, %d, %d, %d, %d, ''%s'');',
            [self.Name, Memo.DynLeft, Memo.DynTop, Memo.DynRight,
            Memo.DynBottom, Memo.Tag, Memo.DynFontHeight, Memo.labelCaption]);
end;

//function TDynWinPanel.GetChildOwner: TComponent;
//begin
//  Result := Self;
//end;

//procedure TDynWinPanel.GetChildren(Proc: TGetChildProc; Root: TComponent);
//var
//  I: Integer;
//  OwnedComponent: TComponent;
//begin
//  inherited GetChildren(Proc, Root);
//  for I := 0 to ComponentCount - 1 do
//    Proc(Components[I]);
//end;

function TDynWinPanel.GetField(const Name: string): string;
begin
  Result := FFieldNames[FFieldNames.IndexOf(Name)];
end;

procedure TDynWinPanel.HideFilterList(FocusedControl: TObject);
var
  winCtrl: TWinControl;
begin
  if FocusedControl = nil then
  begin
    lstvtr1.Visible := False;
    Exit;
  end;
  if FocusedControl is TWinControl then
  begin
    winCtrl := TWinControl(FocusedControl);
    if winCtrl.Parent = self then
    begin
      Exit;
    end;
    if winCtrl = self then
    begin
      Exit;
    end;
  end;
  lstvtr1.Visible := False;
end;

procedure TDynWinPanel.KeyPress(var Key: Char);
begin
  inherited;

end;

procedure TDynWinPanel.Loaded;
begin
  inherited;
  NestedGroup(nil);
  //NestedGroup(nil);
end;

//function TDynWinPanel.SynMmoFromPoint(p: TPoint; scale: extended): TDynSynMemo;
//var
//  i: Integer;
//  mmo: TDynSynMemo;
//  xR, yR: extended;
//  x, y: Integer;
//begin
//  Result := nil;
//    xR := p.x + HScrollPos/ FScale;
//    yR := p.Y + VScrollPos / FScale;
//    x:= Round(xR);
//    y := Round(yR);
//  for i:= 0 to FSynMemos.Count - 1 do
//  begin
//    mmo := FSynMemos.Items[i];
//
//    if (yR > mmo.FRect.Top) and (yR < (mmo.FRect.Top + mmo.FRect.Height)) and
//       (xr > mmo.FRect.left) and (xr < (mmo.FRect.left + mmo.FRect.Width)* 1) then
//    begin
//      Result := mmo;
//      Exit;
//    end;
//  end;
//end;

procedure TDynWinPanel.MemoToBin(mmo: TSizeGripMemo; InBin: Boolean);
begin
  if InBin then
  begin
    Winapi.Windows.SetParent(mmo.Handle, Application.Handle);
    //mmo.Color := clRed;

  end
  else
  begin
    Winapi.Windows.SetParent(mmo.Handle, self.Handle);
     //mmo.Color := clGreen;
  end;
end;

function TDynWinPanel.MmoFromPoint(p: TPoint; scale: extended): TDynMemo;
var
  i: Integer;
  mmo: TDynMemo;
  xR, yR: extended;
  x, y: Integer;
begin
  Result := nil;
    xR := p.x + HScrollPos/ FScale;
    yR := p.Y + VScrollPos / FScale;
    x:= Round(xR);
    y := Round(yR);
  for i:= 0 to FMemos.Count - 1 do
  begin
    mmo := FMemos.Items[i];

    if (yR > mmo.FRect.Top) and (yR < (mmo.FRect.Top + mmo.FRect.Height)) and
       (xr > mmo.FRect.left) and (xr < (mmo.FRect.left + mmo.FRect.Width)* 1) then
    begin
      Result := mmo;
      Exit;
    end;
  end;
end;

//procedure TDynWinPanel.MmoonResize(Sender: TObject);
//var
//  mmo: TDynSynMemo;
//  i, j: Integer;
//  exH, exH1: Integer;
//begin
//  if GetKeyState(VK_CONTROL) < 0  then Exit;
//  if not CanMemoResize then  Exit;
//
//  for i := 0 to FSynMemos.Count - 1 do
//  begin
//    if FSynMemos[i].mmoInplace = TDynSynEdit(Sender) then
//    begin
//      FSynMemos[i].FRect.Left := Round((FSynMemos[i].mmoInplace.BoundsRect.Left + FHScrollPos) / scale);
//      FSynMemos[i].FRect.top := Round((FSynMemos[i].mmoInplace.BoundsRect.top + FVScrollPos) / scale);
//      FSynMemos[i].FRect.Width := Round((FSynMemos[i].mmoInplace.BoundsRect.Width) / scale);
//      exH := FSynMemos[i].FRect.Height;
//
//      FSynMemos[i].FRect.Height := Round((FSynMemos[i].mmoInplace.BoundsRect.Height) / scale);
//      for j := 0 to FLabels.Count - 1 do
//      begin
//        if FLabels[j].FRect.Top > FSynMemos[i].FRect.Top + exH then
//        begin
//          OffsetRect(FLabels[j].FRect, 0, FSynMemos[i].FRect.Height - exH);
//          RepaintLabel(nil, FLabels[j]);
//        end;
//      end;
//      for j := 0 to FSynMemos.Count - 1 do
//      begin
//        if FSynMemos[j].FRect.Top > FSynMemos[i].FRect.Top + exH then
//        begin
//          OffsetRect(FSynMemos[j].FRect, 0, FSynMemos[i].FRect.Height - exH);
//          //RepaintLabel(nil, FLabels[j]);
//        end;
//      end;
//
//      //DrawLabels(nil);
//    end;
//  end;
//
//end;

function TDynWinPanel.MouseActivate(Button: TMouseButton; Shift: TShiftState; X, Y, HitTest: Integer): TMouseActivate;
begin
  inherited;
end;

procedure TDynWinPanel.MouseWheelHandler(var Message: TMessage);
begin
  Message.Result  := 1;
  //inherited;
  // := Perform(CM_MOUSEWHEEL, Message.WParam, Message.LParam);
  //inherited MouseWheelHandler(Message);
end;

procedure TDynWinPanel.MoveGroup(dx, dy: Integer; grp: TDynGroupBox);
var
  i: Integer;
begin
  grp.FRect.Offset(dx, dy);
  for i := 0 to grp.FListChilds.Count - 1 do
    grp.FListChilds[i].FRect.Offset(dx, dy);
end;

procedure TDynWinPanel.NestedGroup(mmo: TSizeGripMemo);
var
  i, j: Integer;
  gr, grTemp: TDynGroupBox;

begin
  for i := 0 to FGroupBoxs.Count - 1 do
  begin

    gr := FGroupBoxs[i];
    FRunTimeCode.Add( 'start ' +  gr.grpInplace.Name);
    gr.CalcGroupBox;
    for j  := 0 to gr.FListGroup.Count - 1 do
    begin
      grTemp := gr.FListGroup[j];
      FRunTimeCode.Add( '    grupi ' +  grTemp.grpInplace.Name);
    end;
    gr.CalcChild;

    for j  := 0 to gr.FListChilds.Count - 1 do
    begin
      //grTemp := gr.FListGroup[j];
      FRunTimeCode.Add( '    child ' +  gr.FListChilds[j].name);
    end;
    gr.CalcForMove();

    for j  := 0 to gr.FListForMove.Count - 1 do
    begin
      //grTemp := gr.FListGroup[j];
      FRunTimeCode.Add( '    formove ' +  gr.FListForMove[j].name);
    end;

    FRunTimeCode.Add( 'end ' +  gr.grpInplace.Name);

    for j := 0 to FMemos.Count - 1 do
    begin
      if FMemos[j].ParentGroup <> nil then
      begin
        FRunTimeCode.Add( '    ParentGroup ' + FMemos[j].Name + '-------' + FMemos[j].ParentGroup.name);
      end
      else
      begin
        FRunTimeCode.Add( '    ParentGroup ' + FMemos[j].Name + '-------' );
      end;
    end;

  end;
end;

function TDynWinPanel.NumButtonFromPoint(p: TPoint; scale: extended): THotNumButton;
var
  i: Integer;
  hb: THotNumButton;
begin
  Result.Group := nil;
  for i := 0 to FlistHotNumButtons.Count - 1 do
  begin
    hb := FlistHotNumButtons[i];
    if hb.r.Contains(p) then
    begin
      Result := hb;
      Exit;
    end;
  end;
end;



procedure TDynWinPanel.OnLeaveList(Sender: TObject);
begin

end;

procedure TDynWinPanel.OnTerminateWait(Sender: TObject);
begin

end;

procedure TDynWinPanel.OnWaitTimer(Sender: TObject);
begin
  exit;
  if (csDesigning in ComponentState) then Exit;
  if not Assigned(FImageWait) then Exit;
  if FImageWait.Graphic = nil then Exit;
  if gifWait = nil then
  begin
    gifWait := TGIFImage.Create;
    gifWait.Assign(TGIFImage(FImageWait.Graphic));
    gifWait.Transparent := false;
    gifWait.Animate := False;
  end;
  inc(FTick);
  if FTick > (gifWait.Images.Count - 1) then
    FTick := 0;
  RepaintWait;
end;

procedure TDynWinPanel.Redraw;
begin
  if not (csDesigning in ComponentState) then
  begin
    Repaint;
    //CanRepaint := False;
//    if FMemos.Count > 0 then
//    begin
//      FMemos[0].mmoInplace.AdjustHeight(true);
//    end;
//    CanRepaint  := True;
  end
  else
  begin
    FlistHotFilterButtons.Clear;
    DrawTabControls(nil);
    DrawMemos(nil);
    DrawEdits(nil);

    //DrawSynMemos(nil);
    DrawChecks(nil);
    DrawLabels(nil);

    DrawDatTims(nil);
    DrawGroupBoxs(nil);
    //UpdateObjectInspector;
  end;
end;

procedure TDynWinPanel.RemoveGroups;
var
  i: Integer;
  grp: TDynGroup;
  ctrl: TControl;
begin
  for i := Self.ControlCount - 1 to 0 do
  begin
    ctrl := Self.Controls[i];
    if ctrl is TDynGroup then
      Self.RemoveControl(ctrl);
  end;
end;

procedure TDynWinPanel.RepaintLabel(ACanvas: TCanvas; lbl: TDynLabel);
var
  r: TRect;
  txt: string;
begin

      r.Left := Round(lbl.FRect.Left * scale) - FHScrollPos;
      r.Top := Round(lbl.FRect.Top  * scale  - FVScrollPos);
      r.Width := Round(lbl.FRect.Width * scale);
      r.Height := Round(lbl.FRect.Height * scale);

      if (r.left = 0) then Exit;


      if lbl.lblInplace.Visible then
      begin
        lbl.lblInplace.CanMove := False;
        lbl.lblInplace.Scale := Scale;
        lbl.lblInplace.SetBounds(r.Left, r.Top, r.Width, r.Height);
        lbl.lblInplace.CanMove := true;
      end;
      if not (csDesigning in ComponentState) then
      begin
        if r.Bottom < 0 then exit;
        if r.Top > Height then exit;
      end;
      lbl.lblInplace.CanMove := False;
      lbl.lblInplace.Scale := Scale;
      lbl.lblInplace.SetBounds(r.Left, r.Top, r.Width, r.Height);
      lbl.lblInplace.CanMove := true;



      txt := lbl.lblInplace.Caption;
      if Assigned(FOnGetText) then
        FOnGetText(Self, lbl, txt);
      if not(csDesigning in ComponentState) and (ACanvas<> nil)  then
      begin
        ACanvas.Font.Assign(lbl.lblInplace.Font);
        SetBkMode(ACanvas.Handle,TRANSPARENT);
        SetTextColor(ACanvas.Handle, clBlack);
        DrawText(ACanvas.Handle, PChar(txt), -1, r, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
        r.Top := r.top - Round(10* Scale);
        r.Left := r.Left + 0;
        r.Right := Round(r.Left +40 * Scale);
        r.Height := Round(11* Scale);
        ACanvas.Brush.Color := $00FAA5C5;
        ACanvas.Font.Height := Round(8* Scale);

        DrawText(ACanvas.Handle, PChar(lbl.lblInplace.labelCaption), -1, r, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
      end;
end;

procedure TDynWinPanel.RepaintWait;
var
  r: TRect;
begin
  if FStartingHandle = 0 then  Exit;
  //if True then  Exit;

  try
    postMessage(FStartingHandle, WM_Repaint_Wait, 0, 0);
  except
  end;

end;

procedure TDynWinPanel.Resize;
var
  posV, PosH: Integer;
  PList, Ppanel: TPoint;
begin
  inherited;
  posV := GetScrollPos(Handle, SB_VERT);
  posH := GetScrollPos(Handle, SB_HORZ);
  rangeVert := posV + Round(CalcGroupHeight)  - Height + 30; //zzzz 30 е хоризонталния скрол
  rangeHorz := posH + Round(CalcGroupWidth)  - Width + 30; //zzzz 30 е vert скрол
  if rangeHorz  < 0 then
    rangeHorz := 1;
  UpdateScroll;
  if lstvtr1 <> nil then
  begin
    PList := lstvtr1.ClientToScreen(Point(0, 0));
    Ppanel := ClientToScreen(Point(leftListFilter, topListFilter));
    lstvtr1.Top := Ppanel.Y;
    lstvtr1.Left := Ppanel.X;
    // List.Visible := False;
  end;
end;



procedure TDynWinPanel.ResizeControl(sender: TObject);
var
  i: Integer;
  Edit: TEdit;
begin
  inherited;
end;

procedure TDynWinPanel.Setbtn1(const Value: TDynSpec);
begin
  Fbtn1.Assign(Value);
end;

procedure TDynWinPanel.SetCanDrawInDesignMode(const Value: boolean);
var
  i: Integer;
  edt: TDynEdit;
begin
  for i := 0 to FEdits.Count - 1 do
  begin
    edt := FEdits[i];
    edt.FRect.Left := Round(FEdits[i].edtInplace.BoundsRect.Left/Scale);
    edt.FRect.top := Round(FEdits[i].edtInplace.BoundsRect.top/Scale);
    edt.FRect.Width := Round(FEdits[i].edtInplace.BoundsRect.Width/Scale);
    edt.FRect.Height := Round(FEdits[i].edtInplace.BoundsRect.Height/Scale);
    //edt.FFontHeight := FEdits[i].edtInplace.Font.Height;
  end;
  //FCanDrawInDesignMode := Value;
end;

procedure TDynWinPanel.SetField(const Name, Value: string);
begin
  //
end;

procedure TDynWinPanel.SetFieldNames(const Value: TStrings);
begin
  FFieldNames.Assign(Value);
  btn1.Caption := IntToStr(Value.Count);

end;

procedure TDynWinPanel.SetFilterMode(const Value: Boolean);
begin
  FFilterMode := Value;
end;

procedure TDynWinPanel.SetHScrollPos(const Value: Integer);
begin
  FHScrollPos := Value;
  UpdateScroll;
end;

procedure TDynWinPanel.SetImageWait(const Value: TPicture);
begin
  FImageWait.Assign(Value);
end;

procedure TDynWinPanel.SetNode(const Value: PVirtualNode);
begin
  FNode := Value;
  //Repaint;
end;

procedure TDynWinPanel.SetRunTimeCode(const Value: TStringList);
begin
  FRunTimeCode.Assign(Value);
end;

procedure TDynWinPanel.SetScale(const Value: extended);
var
  TM: TextMetric;
  DC: HDC;
  SaveFont: HFont;
  hFnt : hFont;
  lf : tLogfont;
  oldH: Integer;
  cf: TWMChooseFont_GetLogFont;
  oldPosY, posY, oldPosX, posX: Integer;
  yAbs, xAbs, yMouse, xMouse: Extended;
  saveH: Integer;
begin
  //if FScale <> Value then
  begin
    yMouse := FMousePosScale.Y;
    xMouse := FMousePosScale.X;
    posY := GetScrollPos(Handle, SB_VERT);
    posX := GetScrollPos(Handle, SB_HORZ);
    yAbs := yMouse/FScale + posY/Fscale;
    xAbs := xMouse/Fscale + posX/Fscale;
    FScale := Value;
    if FScale <= 0.05 then
      FScale := 0.05;
    GetObject(Font.Handle, sizeof(lf), @lf);
    saveH := lf.lfHeight;
    lf.lfHeight := round(lf.lfHeight * FScale);
    //lf.lfHeight := round(9 * value);
   //FScale := lf.lfHeight/ saveH;
    hFnt := CreateFontIndirect(lf);
    FCanvas.Font.Handle := hFnt;
    rangeVert := posY + Round(CalcGroupHeight)  - Height + 30; //zzzz 30 е хоризонталния скрол
    rangeHorz := posX + Round(CalcGroupWidth)  - Width + 30; //zzzz 30 е vert скрол
    if rangeHorz  < 0 then
      rangeHorz := 1;
    FVScrollPos := Round((yAbs * FScale - (yMouse)));
    FHScrollPos := Round((xAbs * FScale - (xMouse)));
    UpdateScroll;
    if not (csDesigning in ComponentState) then
    begin
      Repaint;
    end
    else
    begin
      DrawEdits(nil);
      DrawLabels(nil);
      //DrawSynMemos(nil);
      DrawChecks(nil);
    end;
  end;
end;

//procedure TDynWinPanel.SetScrBarV(const Value: TDynScrollBar);
//begin
//  FScrBarV.Assign(Value);
//end;

procedure TDynWinPanel.SetVScrollPos(const Value: Integer);
begin
  FVScrollPos := Value;
  UpdateScroll;
end;

procedure TDynWinPanel.ShowFilterList;
var
  CP, SP: TPoint;
begin
  //Winapi.Windows.SetParent(lstvtr1.Handle, 0);
//  CallWindowProc(DefWndProc, lstvtr1.Handle, WM_SETFOCUS, 0, 0);
  CP.X := leftListFilter;
  CP.Y := topListFilter;
  SP := ClientToScreen(CP);
  //if SP.Y + lstvtr1.Height > Screen.Height then
//  begin
//    CP.X := -3;
//    CP.Y := 30;
//  end;
  //SP := ClientToScreen(CP);
  lstvtr1.SetPos(SP.X, SP.Y);
  lstvtr1.Width := WListFilter;
  lstvtr1.Height := HListFilter;
  Self.SetFocus;
  //List.FillFilterList;
  lstvtr1.Visible := true;
  lstvtr1.ItemIndex := 0;
  //lstvtr1.SetBounds(100, 100, 200, 200);
//  lstvtr1.Visible := True;
end;

procedure TDynWinPanel.UpdateObjectInspector;
var
  hnd: THandle;
begin
  SendMessage(Self.Handle, WM_LBUTTONDOWN, 3, 3);
  SendMessage(Self.Handle, WM_LBUTTONUP, 3, 3);
  Exit;
  hnd := FindWindow('TAppBuilder', nil);
  hnd := FindWindowEx(hnd, 0, 'TEditorDockPanel', nil);
  hnd := FindWindowEx(hnd, 0, 'TEditWindow', nil);
  hnd := FindWindowEx(hnd, 0, 'TEditorDockPanel', nil);
  hnd := FindWindowEx(hnd, 0, 'TPropertyInspector', nil);
  hnd := FindWindowEx(hnd, 0, 'TPanel', nil);
  hnd := FindWindowEx(hnd, 0, 'TInspListBox', nil);
  //btn1.Caption := IntToStr(hnd);
  //ShowMessage(intToStr(hnd));
  SendMessage(hnd, WM_LBUTTONDOWN, 3, 200);
  SendMessage(hnd, WM_LBUTTONUP, 3, 200);

end;

procedure TDynWinPanel.UpdateScroll;
var
  si: TScrollInfo;
begin
  if rangeVert > 0 then
  begin
    //ShowScrollBar(Handle, SB_VERT, True);
    si.cbSize := SizeOf(TScrollInfo);
    si.fMask := SIF_ALL;
    si.nMin := 0;
    si.nMax := rangeVert;
    si.nPage := Height div 2;
    si.nMax := rangeVert + si.nPage;
    if FVScrollPos > rangeVert then
      FVScrollPos := rangeVert;
    si.nPos := FVScrollPos;
    si.nTrackPos := FVScrollPos;
    SetScrollInfo(Handle, SB_VERT, si, True);
  end
  else
  begin
    //ShowScrollBar(Handle, SB_VERT, false);
  end;

  if rangeHorz > 0 then
  begin
    //ShowScrollBar(Handle, SB_HORZ, True);
    si.cbSize := SizeOf(TScrollInfo);
    si.fMask := SIF_ALL;
    si.nMin := 0;
    si.nMax := rangeHorz;
    si.nPage := Width div 2;
    si.nMax := rangeHorz + si.nPage;
    if FHScrollPos > rangeHorz then
      FHScrollPos := rangeHorz;
    si.nPos := FHScrollPos;
    si.nTrackPos := FHScrollPos;
    SetScrollInfo(Handle, SB_HORZ, si, True);
  end
  else
  begin
    //ShowScrollBar(Handle, SB_HORZ, false);
  end;
  //if (csDesigning in ComponentState) then
//  begin
//    UpdateObjectInspector;
//  end;
end;

procedure TDynWinPanel.ValidateInsert(AComponent: TComponent);
begin
  inherited ValidateInsert(AComponent);

end;

procedure TDynWinPanel.WMActivate(var Message: TWMActivate);
begin
  inherited;
end;

procedure TDynWinPanel.WMEraseBkgnd(var Message: TWmEraseBkgnd);
var
  R: TRect;
  Size: TSize;
begin
  if (csDesigning in ComponentState) then
  begin
    inherited;
    
  end
  else
  begin
    Message.Result := 1;
  end;
end;

procedure TDynWinPanel.WMHScroll(var Message: TWMHScroll);
var
  oldPos: Integer;
  si: TScrollInfo;
begin
  oldPos := FHScrollPos;

  case Message.ScrollCode of
    0:begin
        oldPos := SetScrollPos(Handle, SB_HORZ, FHScrollPos - FHScrollStep, True);
        FHScrollPos := GetScrollPos(Handle, SB_HORZ);
        FIsScrolling := (FHScrollPos <> oldPos);
      end;
    2:begin
        oldPos := SetScrollPos(Handle, SB_HORZ, FHScrollPos - FHScrollPage, True);
        FHScrollPos := GetScrollPos(Handle, SB_HORZ);
        FIsScrolling := (FHScrollPos <> oldPos);
      end;
    1:begin
        oldPos := SetScrollPos(Handle, SB_HORZ, FHScrollPos + FHScrollStep, True);
        FHScrollPos := GetScrollPos(Handle, SB_HORZ);
        FIsScrolling := (FHScrollPos <> oldPos);
      end;
    3:begin
        oldPos := SetScrollPos(Handle, SB_HORZ, FHScrollPos + FHScrollPage, True);
        FHScrollPos := GetScrollPos(Handle, SB_HORZ);
        FIsScrolling := (FHScrollPos <> oldPos);
      end;
    4, 5:begin
        SI.cbSize := Sizeof(SI);
        SI.fMask := SIF_ALL;
        GetScrollInfo(Handle, SB_HORZ, si);
        oldPos := SetScrollPos(Handle, SB_HORZ, si.nTrackPos, True);
        FHScrollPos := GetScrollPos(Handle, SB_HORZ);
        FIsScrolling := (FHScrollPos <> oldPos);
      end;
    8:begin

      end;
  end;

  if FIsScrolling then
  begin
    //btn1.Caption := 'fgfgf';
    HideFilterList(nil);
    CalcGroupWidth;
    Repaint;
  end;



end;

procedure TDynWinPanel.WMKeyDown(var Msg: TWMKeyDown);
begin

end;

procedure TDynWinPanel.WMKeyUp(var Msg: TWMKeyUp);
begin
  if Cursor = crHandPoint then
  begin
    Cursor := crArrow;
    FSelectedCapLab := nil;
  end;
end;

procedure TDynWinPanel.WMKillFocus(var msg: TWMKillFocus);
begin
  HideFilterList(FindControl(msg.FocusedWnd));
  inherited;

  WListFilter := lstvtr1.Width;
  HListFilter := lstvtr1.Height;
end;

procedure TDynWinPanel.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  WMLButtonDown(message);
end;

procedure TDynWinPanel.WMLButtonDown(var Message: TWMLButtonDown);
var
  btn: TDynButton;
  edt: TDynEdit;
  x, y, i: Integer;
  r: TRect;
  p: TPoint;
  hbGroup: THotNumButton;
  hbFilter: THotFilterButton;
begin
  try
    p := Point(Message.XPos, Message.YPos);
    x := Round(Message.XPos / Scale);
    y := Round(Message.YPos / Scale);


    
    SetFocus;
    if FSelectedCapLab <> nil then
    begin
      ShowMessage('link');
      FSelectedCapLab := nil;
      SetFocus;
      Cursor := crArrow;
    end;
    hbGroup := NumButtonFromPoint(p, scale);
    if hbGroup.Group <> nil then
    begin
      FHotNumButton := hbGroup;
      Redraw;
    end;

    hbFilter := FilterButtonFromPoint(p, scale);
    if hbFilter.ctrl <> nil then
    begin
      FHotFilterButton := hbFilter;
      Redraw;
    end;
  finally
    inherited;
    //Message.Result := 1;
    //if Assigned(FOnMouseMove) then
//      FOnMouseMove(Self, [], x, y );
  end;
end;

procedure TDynWinPanel.WMLButtonUP(var Message: TWMLButtonUP);
var
  x, y, i: Integer;
  p: TPoint;
  hbGroup: THotNumButton;
  hbFilter: THotFilterButton;
begin
  inherited;
  p := Point(Message.XPos, Message.YPos);
  x := Round(Message.XPos / Scale);
  y := Round(Message.YPos / Scale);
  hbGroup := NumButtonFromPoint(p, scale);
  if hbGroup.Group <> nil then
  begin
    if Assigned(FOnGroupButtonClick) then
    begin
      FOnGroupButtonClick(Self, hbGroup.Group, hbGroup.NumButton);
    end;
    FHotNumButton.Group := nil;
    Redraw;
  end;

  hbFilter := FilterButtonFromPoint(p, scale);
  if hbFilter.ctrl <> nil then
  begin
    x := round(hbFilter.ctrl.FRect.Left * Scale) - FHScrollPos;
    y := round(hbFilter.ctrl.FRect.Bottom * Scale) - FVScrollPos;
    //ShowFilterList(x, y, WListFilter, HListFilter);
    leftListFilter := x;
    topListFilter := y;
    if Assigned(FOnFilterButtonClick) then
    begin
      FOnFilterButtonClick(Self, hbFilter.ctrl, lstvtr1.FFilterList);
    end;
    FHotFilterButton.ctrl := nil;
    Redraw;
  end;
end;

procedure TDynWinPanel.WMMouseMove(var Message: TWMMouseMove);
var
  btn: TDynButton;
  edt: TDynEdit;
  mmo: TDynMemo;
  datTim: TDynDatTime;
  dyn: TBaseControl;
  chk: TDynCheckBox;
  //mmo: TDynMemo;
  x, y, i: Integer;
  r: TRect;
  p: TPoint;
  hbGroup: THotNumButton;
  hbFilter: THotFilterButton;
begin
  try
    p := Point(Message.XPos, Message.YPos);
    x := Round(Message.XPos / Scale);
    y := Round(Message.YPos / Scale);


    datTim := DatTimFromPoint(Point(x, y), scale);
    if datTim <> nil then
    begin
      if FSelectedDatTim <> datTim then
      begin
        if FSelectedDatTim <> nil then
        begin
          FCanRepaint := False;
          FSelectedDatTim.DatTimInplace.Visible := False;
          FCanRepaint := true;
        end;
        FCanRepaint := False;
        datTim.DatTimInplace.Visible := True;
        FCanRepaint := True;
        FSelectedDatTim := datTim;
      end;
    end
    else // някъде из панела съм
    begin
      if FSelectedDatTim <> nil then
      begin
        FCanRepaint := False;
        if (FFocusedDatTim = nil) then
        begin
          FSelectedDatTim.DatTimInplace.Visible := False;
        end;
        FCanRepaint := True;

        FSelectedDatTim := nil;
      end;
    end;

    chk := ChkFromPoint(Point(x, y), scale);
    if chk <> nil then
    begin
      if FSelectedChk <> chk then
      begin
        if FSelectedChk <> nil then
        begin
          FCanRepaint := False;
          FSelectedChk.chkInplace.Visible := False;
          FCanRepaint := true;
        end;
        FCanRepaint := False;
        chk.chkInplace.Visible := True;
        FCanRepaint := True;
        FSelectedChk := chk;
      end;
    end
    else // някъде из панела съм
    begin
      if FSelectedChk <> nil then
      begin
        FCanRepaint := False;
        if (FFocusedChk = nil) then
        begin
          FSelectedChk.chkInplace.Visible := False;
        end;
        FCanRepaint := True;

        FSelectedChk := nil;
      end;
    end;

    edt := EdtFromPoint(Point(x, y), scale);
    if edt <> nil then
    begin
      if FSelectedEdit <> edt then
      begin
        if FSelectedEdit <> nil then
        begin
          FCanRepaint := False;
          FSelectedEdit.edtInplace.Visible := False;
          FCanRepaint := true;
        end;
        FCanRepaint := False;
        edt.edtInplace.Visible := True;
        FCanRepaint := True;
        FSelectedEdit := edt;
      end;
    end
    else // някъде из панела съм
    begin
      if FSelectedEdit <> nil then
      begin
        FCanRepaint := False;
        if (FFocusedEdit = nil) then
        begin
          FSelectedEdit.edtInplace.Visible := False;
        end;
        FCanRepaint := True;

        FSelectedEdit := nil;
      end;
    end;

    mmo := MmoFromPoint(Point(x, y), scale);
    if mmo <> nil then
    begin
      if FSelectedMemo <> mmo then
      begin
        if FSelectedMemo <> nil then
        begin
          FCanRepaint := False;
          FSelectedMemo.mmoInplace.DynVisible := False;
          FCanRepaint := true;
        end;
        FCanRepaint := False;
        mmo.mmoInplace.DynVisible := True;
        FCanRepaint := True;
        FSelectedMemo := mmo;
      end;
    end
    else // някъде из панела съм
    begin
      if FSelectedMemo <> nil then
      begin
        FCanRepaint := False;
        if (FSelectedMemo = nil) then
        begin
          FSelectedMemo.mmoInplace.DynVisible := False;
        end;
        FCanRepaint := True;

        FSelectedMemo := nil;
      end;
    end;

    //SynMmo := SynMmoFromPoint(Point(x, y), scale);
//    if SynMmo <> nil then
//    begin
//      if FSelectedSynMemo <> SynMmo then
//      begin
//        if FSelectedSynMemo <> nil then
//        begin
//          FCanRepaint := False;
//          FSelectedSynMemo.mmoInplace.Visible := False;
//          FCanRepaint := true;
//        end;
//        FCanRepaint := False;
//        SynMmo.mmoInplace.Visible := True;
//        FCanRepaint := True;
//        FSelectedSynMemo := SynMmo;
//      end;
//    end
//    else // някъде из панела съм
//    begin
//      if FSelectedSynMemo <> nil then
//      begin
//        FCanRepaint := False;
//        if (FFocusedSynMemo = nil) then
//        begin
//          FSelectedSynMemo.mmoInplace.Visible := False;
//        end;
//        FCanRepaint := True;
//
//        FSelectedSynMemo := nil;
//      end;
//    end;


    if FHotNumButton.Group <> nil then //  има натиснат групов бутон
    begin
      hbGroup := NumButtonFromPoint(p, scale);
      if (hbGroup.Group <> FHotNumButton.Group) or
         (hbGroup.NumButton <> FHotNumButton.NumButton)  then // има натиснат бутон и мишката е извън него
      begin
        FHotNumButton.Group := nil;
        Redraw;
      end;
    end;

    if FHotFilterButton.ctrl <> nil then //  има натиснат филтър бутон
    begin
      hbFilter := FilterButtonFromPoint(p, scale);
      if (hbFilter.ctrl <> FHotFilterButton.ctrl) then // има натиснат бутон и мишката е извън него
      begin
        FHotFilterButton.ctrl := nil;
        Redraw;
      end;
    end;

    if GetKeyState(VK_CONTROL) < 0  then
    begin
      FSelectedCapLab := DynCapLabFromPoint(Point(x, y), scale);
      if FSelectedCapLab <> nil then
      begin
        Cursor := crHandPoint;
      end
      else
      begin
        Cursor := crDefault;
      end;

    end;

  finally
    inherited;
    if Assigned(FOnMouseMove) then
      FOnMouseMove(Self, [], x, y );
  end;
end;

procedure TDynWinPanel.WMMouseWheel(var Message: TWMMouseWheel);
var
  oldPos, i: Integer;
  oldScale: extended;
  p: TPoint;
  deltaPos: Integer;
begin
  if not(csDesigning in ComponentState) then
  begin
    //inherited;
    DoDynWheel(Message);
    HideFilterList(nil);
    //Message.Result := 0;
  end;
end;

procedure TDynWinPanel.WMMove(var Msg: TWMMove);
begin
  Resize;
end;

procedure TDynWinPanel.WMNotify(var Message: TWMNotify);
begin
  inherited;
end;

procedure TDynWinPanel.WMPaint(var Message: TWMPaint);
var
  i, j: Integer;
  Buffer: Vcl.Graphics.TBitmap;


  r: TRect;
  scale: Extended;
  absL: Integer;
  txtColl: PWideChar;


  Details: TThemedElementDetails;
  DrawRect: System.Types.TRect;
begin
  inherited;
  if message.DC <> 0 then
  begin
    message.Result := 0;
  end;
  if not CanRepaint then Exit;

  if (csDesigning in ComponentState) then
  begin
    //FCanvas.Brush.Color := clWhite;
    //FCanvas.Brush.Style := bsSolid;
    //FCanvas.FillRect(Rect(0,0,Width, Height));
    Exit;
  end;
  FCanMemoResize := False;
  Buffer := Vcl.Graphics.TBitmap.Create;
  try
    Buffer.Width:=Width;
    Buffer.Height:=Height;
    Buffer.Canvas.Font.Assign(FCanvas.font);
    Buffer.Canvas.Brush.Color := $00E4E1DC;
    if not(csDesigning in ComponentState) then
    begin
      Buffer.Canvas.FillRect(Rect(0, 0, Width, height));
    end;


    scale := FScale;
    absL := FHScrollPos;
    if not(csDesigning in ComponentState) then
    begin
      FlistHotFilterButtons.Clear;

      DrawTabControls(Buffer.Canvas);
      DrawButtons(Buffer.Canvas);
      DrawMemos(Buffer.Canvas);
      DrawEdits(Buffer.Canvas);
      //DrawSynMemos(Buffer.Canvas);

      DrawChecks(Buffer.Canvas);
      DrawLabels(Buffer.Canvas);

      DrawDatTims(Buffer.Canvas);
      DrawGroupBoxs(Buffer.Canvas);

      //Buffer.Canvas.CopyRect(Rect(0,0, 100, 50), btn1.Canvas, Rect(0, 0, 100, 50));
    end
    else
    begin
      DrawTabControls(nil);
      DrawButtons(nil);
      DrawEdits(nil);
      //DrawSynMemos(nil);
      DrawMemos(nil);
      DrawChecks(nil);
      DrawLabels(nil);

      DrawDatTims(nil);
      DrawGroupBoxs(nil);

    end;

    if not(csDesigning in ComponentState) then
    begin
      FCanvas.Draw(0,0,Buffer);
    end;


  finally
    Buffer.free;
    DrawLabels(nil);
    FCanMemoResize := true;
  end;
end;

procedure TDynWinPanel.WMRepaintWait(var Msg: TMessage);
var
  r: TRect;
  png: TPngImage;
  bmp: Vcl.Graphics.TBitmap;
  bmp32: TBitmap32;
begin
  if gifWait = nil then Exit;

  r.Left := 0;
  r.Top := 0;
  r.Width := 63;// gifWait.Width;
  r.Height := 63;// gifWait.Height;
  //FEdits[0].edtInplace.Text := 'dddd';

  bmp := Vcl.Graphics.TBitmap.create;
  bmp.SetSize(63, 63);
  bmp.Canvas.Brush.Color := $00E4E1DC;
  bmp.Canvas.FillRect(r);
  gifWait.Images.Frames[FTick].Draw(bmp.Canvas, r, true, false);

  bmp32 := TBitmap32.Create;
  bmp32.Width := 63;
  bmp32.Height := 63;
  TKernelResampler(bmp32.Resampler).Kernel := TCubicKernel.Create;

  bmp32.Assign(bmp);
  bmp.Free;
  r.Left := 110;// round(110 * scale);
  r.Top := 110;// Round(110 * scale);
  r.Width := Round(20* scale);
  r.Height :=Round(20* scale);
  bmp32.DrawTo(FCanvas.Handle, r, bmp32.BoundsRect);
  TKernelResampler(bmp32.Resampler).Kernel.Free;
  bmp32.Free;
end;

procedure TDynWinPanel.WMVScroll(var Message: TWMVScroll);
var
  oldPos: Integer;
  si: TScrollInfo;
begin
  oldPos := FVScrollPos;

  case Message.ScrollCode of
    0:begin
        oldPos := SetScrollPos(Handle, SB_VERT, FVScrollPos - FVScrollStep, True);
        FVScrollPos := GetScrollPos(Handle, SB_VERT);
        FIsScrolling := (FVScrollPos <> oldPos);
      end;
    2:begin
        oldPos := SetScrollPos(Handle, SB_VERT, FVScrollPos - FVScrollPage, True);
        FVScrollPos := GetScrollPos(Handle, SB_VERT);
        FIsScrolling := (FVScrollPos <> oldPos);
      end;
    1:begin
        oldPos := SetScrollPos(Handle, SB_VERT, FVScrollPos + FVScrollStep, True);
        FVScrollPos := GetScrollPos(Handle, SB_VERT);
        FIsScrolling := (FVScrollPos <> oldPos);
      end;
    3:begin
        oldPos := SetScrollPos(Handle, SB_VERT, FVScrollPos + FVScrollPage, True);
        FVScrollPos := GetScrollPos(Handle, SB_VERT);
        FIsScrolling := (FVScrollPos <> oldPos);
      end;
    4, 5:begin
        SI.cbSize := Sizeof(SI);
        SI.fMask := SIF_ALL;
        GetScrollInfo(Handle, SB_VERT, si);
        oldPos := SetScrollPos(Handle, SB_VERT, si.nTrackPos, True);
        FVScrollPos := GetScrollPos(Handle, SB_VERT);
        FIsScrolling := (FVScrollPos <> oldPos);
      end;
    8:begin

      end;
  end;

  if FIsScrolling then
  begin
    HideFilterList(nil);
    CalcGroupHeight;
    Repaint;
  end;



end;

procedure TDynWinPanel.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
end;

procedure TDynWinPanel.WndProc(var Message: TMessage);
begin
  if (csDesigning in ComponentState) then
  begin
    if Message.Msg = CM_MOUSEWHEEL then
    begin
      DoDynWheel(TWMMouseWheel(Message));
      Message.Result := 1;
      Exit;
    end;

    if Message.Msg = CN_VSCROLL  then
    begin
      Exit;
    end;
    if Message.Msg = CN_HSCROLL  then
    begin
      Exit;
    end;

    if Message.Msg = cm_ControlChange  then
    begin
      inherited;
      // btn1.Caption := 'insCK1';
      ControlChange(TCMControlChange(Message));

      Exit;
    end;
    inherited;
  end
  else
  begin
    if Message.Msg = cm_ControlChange  then
    begin
      inherited;
      AddControl(TCMControlChange(Message));
      Exit;
    end;
    inherited;
  end;

end;

{ TDynButton }

constructor TDynButton.create;
begin
  inherited;
  IsDown := False;
  btnInplace := nil;
end;

{ TDynEdit }

constructor TDynEdit.create;
begin
  inherited;
  FColIndex := 0;
  FCHARFROMPOS := 0;
  edtInplace := nil;
end;

destructor TDynEdit.destroy;
begin
  //FreeAndNil(edtInplace);

  inherited;
end;

function TDynEdit.GetName: string;
begin
  Result := edtInplace.Name;
end;

//function TDynEdit.GetText: string;
//begin
// // if Assigned(FDynPanel.FOnGetText) then
////    FDynPanel.FOnGetText(FDynPanel, Self, FText);
////  Result := FText;
//end;

//procedure TDynEdit.SetedtInplace(const Value: TEdit);
//begin
//  FedtInplace.Assign(Value);
//end;

//procedure TDynEdit.SetText(const Value: string);
//begin
//  FText := Value;
//end;

{ TDynMemo }

//procedure TDynSynMemo.CalcGroupBox;
//var
//  i: Integer;
//  gb: TDynGroupBox;
//  tc: TDynTabControl;
//  edt: TDynEdit;
//  r: TRect;
//begin
//  if FDynPanel = nil then Exit;
//  if (csDesigning in FDynPanel.ComponentState) then Exit;
//
//  if FListGroup.Count > 0 then Exit;
//  for i := 0 to FDynPanel.FGroupBoxs.Count - 1 do
//  begin
//    gb := FDynPanel.FGroupBoxs[i];
//    if gb.FRect.Contains(Self.FRect) then
//    begin
//      FListGroup.Add(gb);
//      FListIndex.Add(gb.FRect.Bottom - FRect.Bottom);
//    end;
//  end;

  //for i := 0 to FDynPanel.FTabControls.Count - 1 do
//  begin
//    tc := FDynPanel.FTabControls[i];
//    r := tc.FRect;
//    r.Height := r.Height + tc.RealHeight;
//    if r.Contains(Self.FRect) then
//    begin
//      FListGroup.Add(tc);
//      FListIndex.Add(tc.FRect.Bottom - FRect.Bottom);
//      tc.IsMoved := False;
//      //gb.DeltaBottom := gb.FRect.Bottom - FRect.Bottom;
//    end;
//  end;

  //for i := 0 to FDynPanel.FSynMemos.Count - 1 do
//  begin
//    if FDynPanel.FSynMemos[i] = self then
//      Continue;
//    FDynPanel.FSynMemos[i].FListGroup.Clear;
//    FDynPanel.FSynMemos[i].FListIndex.Clear;
//  end;

  //for i := 0 to FDynPanel.FEdits.Count - 1 do
//  begin
//    edt := FDynPanel.FEdits[i];
//  end;
//end;

//constructor TDynSynMemo.create;
//begin
//  inherited;
//  //if FDynPanel = nil then Exit;
//  //if not (csDesigning in FDynPanel.ComponentState) then
//  begin
//    FListGroup := TList<TDynGroupBox>.Create;
//    FListIndex := Tlist<Integer>.Create;
//  end;
//end;
//
//destructor TDynSynMemo.destroy;
//begin
//  FreeAndNil(FListGroup);
//  FreeAndNil(FListIndex);
//  inherited;
//end;
//
//function TDynSynMemo.GetText: string;
//begin
//  if Assigned(FDynPanel.FOnGetText) then
//    FDynPanel.FOnGetText(FDynPanel, Self, FText);
//  Result := FText;
//end;
//
//procedure TDynSynMemo.MoveForMove(Offset: Integer);
//var
//  i: Integer;
//  OldH: Integer;
//  dy: Integer;
//begin
//  if FDynPanel = nil then Exit;
//  if (csDesigning in FDynPanel.ComponentState) then
//    Exit;
//  for i := 0 to FListForMove.Count - 1 do
//  begin
//    OldH := FListForMove[i].FRect.Height;
//    dy := FRect.Bottom + FListBootoms[i];
//    if FListForMove[i] is TDynGroupBox then
//    begin
//      TDynGroupBox(FListForMove[i]).MoveChild(0, dy - FListForMove[i].FRect.top);
//    end;
//    FListForMove[i].FRect.Offset(0, dy - FListForMove[i].FRect.top);
//    //FListForMove[i].FRect.top := dy;
//    //FListForMove[i].FRect.Height := OldH;
//
//  end;
//
//end;
//
//procedure TDynSynMemo.SetText(const Value: string);
//begin
//  FText := Value;
//end;

//procedure TDynSynMemo.StretchGroupBox(deltaY: Integer);
//var
//  i: Integer;
//begin
//  if FDynPanel = nil then Exit;
//  if (csDesigning in FDynPanel.ComponentState) then  Exit;
//
//  for i := 0 to FListGroup.Count - 1 do
//  begin
//    FListGroup[i].CalcForMove(0);
//    FListGroup[i].MoveForMove(Round(deltaY));
//    FListGroup[i].FRect.Height := FListGroup[i].FRect.Height + Round(deltaY);
//  end;
//end;

//procedure TDynSynMemo.StretchGroupBoxHeight(newH: Integer);
//var
//  i: Integer;
//  deltaY: Integer;
//  OldH: Integer;
//  hh: Integer;
//begin
//  if FDynPanel = nil then Exit;
//  if (csDesigning in FDynPanel.ComponentState) then
//    Exit;
//  for i := 0 to FListGroup.Count - 1 do
//  begin
//    OldH := FListGroup[i].FRect.Bottom;
//    FRect.Height := round(newH / FDynPanel.Scale);
//    if FListGroup[i] is TDynTabControl then
//    begin
//      TDynTabControl(FListGroup[i]).RealHeight :=
//          TDynTabControl(FListGroup[i]).RealHeight + FListIndex[i];
//    end
//    else
//    begin
//      FListGroup[i].FRect.Bottom := FRect.Bottom + FListIndex[i];
//    end;
//    deltaY := FListGroup[i].FRect.Bottom - OldH;
//  end;
//
//end;

{ TDynMemo }

procedure TDynMemo.CalcGroupBox;
var
  i: Integer;
  gb: TDynGroupBox;
  tc: TDynTabControl;
  edt: TDynEdit;
  r: TRect;
begin
  if FDynPanel = nil then Exit;
  if (csDesigning in FDynPanel.ComponentState) then Exit;

  if FListGroup.Count > 0 then Exit;
  for i := 0 to FDynPanel.FGroupBoxs.Count - 1 do
  begin
    gb := FDynPanel.FGroupBoxs[i];
    if gb.FRect.Contains(Self.FRect) then
    begin
      FListGroup.Add(gb);
      FListIndex.Add(gb.FRect.Bottom - FRect.Bottom);
    end;
  end;

  for i := 0 to FDynPanel.FMemos.Count - 1 do
  begin
    if FDynPanel.FMemos[i] = self then
      Continue;
    FDynPanel.FMemos[i].FListGroup.Clear;
    FDynPanel.FMemos[i].FListIndex.Clear;
  end;


end;

constructor TDynMemo.create;
begin
  inherited;
  begin
    FListGroup := TList<TDynGroupBox>.Create;
    FListIndex := Tlist<Integer>.Create;
  end;
end;

destructor TDynMemo.destroy;
begin
  FreeAndNil(FListGroup);
  FreeAndNil(FListIndex);
  inherited;
end;

function TDynMemo.GetName: string;
begin
  Result := mmoInplace.Name;
end;

function TDynMemo.GetText: string;
begin
  if Assigned(FDynPanel.FOnGetText) then
    FDynPanel.FOnGetText(FDynPanel, Self, FText);
  Result := FText;
end;

procedure TDynMemo.MoveForMove(Offset: Integer);
var
  i: Integer;
  OldH: Integer;
  dy: Integer;
begin
  if FDynPanel = nil then Exit;
  if (csDesigning in FDynPanel.ComponentState) then
    Exit;
  for i := 0 to FListForMove.Count - 1 do
  begin
    OldH := FListForMove[i].FRect.Height;
    dy := FRect.Bottom + FListBootoms[i];
    if FListForMove[i] is TDynGroupBox then
    begin
      TDynGroupBox(FListForMove[i]).MoveChild(0, dy - FListForMove[i].FRect.top);
    end;
    FListForMove[i].FRect.Offset(0, dy - FListForMove[i].FRect.top);
  end;
end;


procedure TDynMemo.SetText(const Value: string);
begin
  FText := Value;
end;

procedure TDynMemo.StretchGroupBoxHeight(newH: Integer);
var
  i: Integer;
  deltaY: Integer;
  OldH: Integer;
  hh, gap, oldGap, gap1, oldGap1: Integer;
  parGroup: TDynGroupBox;


begin
  if FDynPanel = nil then Exit;
  if (csDesigning in FDynPanel.ComponentState) then
    Exit;
  if ParentGroup = nil then Exit;

  ParentGroup.FRect.Bottom := FRect.Bottom + self.GapBootom;

  for i := 0 to ParentGroup.FListForMove.Count - 1 do
  begin
    if ParentGroup.FListForMove[i] is TDynGroupBox then
    begin
      gap := (-ParentGroup.FListForMove[i].FRect.Top + ParentGroup.FRect.Bottom);
      oldGap := ParentGroup.FListBootoms[i];
      deltaY := gap + oldGap;
//      if deltaY <> 0 then
        FDynPanel.MoveGroup(0, deltaY, TDynGroupBox(ParentGroup.FListForMove[i]));
    end
    else
    begin
      gap := (-ParentGroup.FListForMove[i].FRect.Top + ParentGroup.FRect.Bottom);
      oldGap := ParentGroup.FListBootoms[i];
      deltaY := gap + oldGap;
//      if deltaY <> 0 then
        ParentGroup.FListForMove[i].FRect.Offset(0, deltaY);
    end;
  end;

  parGroup := ParentGroup.ParentGroup;
  gap := ParentGroup.GapBootom + self.GapBootom;
  while parGroup <> nil do
  begin
    for i := 0 to parGroup.FListForMove.Count - 1 do
    begin
      if parGroup.FListForMove[i] is TDynGroupBox then // ако е група
      begin
        gap1 := (-parGroup.FListForMove[i].FRect.Top + parGroup.FRect.Bottom);
        oldGap1 := parGroup.FListBootoms[i];
        deltaY := gap1 + oldGap1;
  //      if deltaY <> 0 then
          FDynPanel.MoveGroup(0, deltaY, TDynGroupBox(parGroup.FListForMove[i]));
      end
      else
      begin
        gap1 := (-parGroup.FListForMove[i].FRect.Top + parGroup.FRect.Bottom);
        oldGap1 := parGroup.FListBootoms[i];
        deltaY := gap1 + oldGap1;
        //if deltaY <> 0 then
          parGroup.FListForMove[i].FRect.Offset(0, deltaY);
      end;
    end;
    parGroup.FRect.Bottom := FRect.Bottom + gap;
    gap := gap + parGroup.GapBootom;
    parGroup := parGroup.ParentGroup;
  end;




  //for i := 0 to FListGroup.Count - 1 do
//  begin
//    OldH := FListGroup[i].FRect.Bottom;
//    FRect.Height := round(newH / FDynPanel.Scale);
//    if FListGroup[i] is TDynTabControl then
//    begin
//      TDynTabControl(FListGroup[i]).RealHeight :=
//          TDynTabControl(FListGroup[i]).RealHeight + FListIndex[i];
//    end
//    else
//    begin
//      FListGroup[i].FRect.Bottom := FRect.Bottom + FListIndex[i];
//    end;
//    deltaY := FListGroup[i].FRect.Bottom - OldH;
//  end;

end;

{ TDynLabel }

constructor TDynLabel.create;
begin
  inherited;
  lblInplace := nil;
end;

function TDynLabel.GetText: string;
begin
  if Assigned(FDynPanel.FOnGetText) then
    FDynPanel.FOnGetText(FDynPanel, Self, FText);
  Result := FText;
end;

procedure TDynLabel.SetText(const Value: string);
begin
  FText := Value;
end;

{ TDynCheckBox }

constructor TDynCheckBox.create;
begin
  inherited;
end;

function TDynCheckBox.GetText: string;
begin
  if Assigned(FDynPanel.FOnGetText) then
    FDynPanel.FOnGetText(FDynPanel, Self, FText);
  Result := FText;
end;

procedure TDynCheckBox.SetText(const Value: string);
begin
  FText := Value;
end;



{ TDynSpec }

procedure TDynSpec.Assign(Source: TPersistent);
begin
  if Source is TSpeedButton then
  begin
    Visible := TSpeedButton(Source).Visible;
    Left := TSpeedButton(Source).left;
    top := TSpeedButton(Source).top;
    Width := TSpeedButton(Source).Width;
    height := TSpeedButton(Source).height;

    Exit;
  end;
end;

procedure TDynSpec.CMDesignHitTest(var Message: TCMDesignHitTest);
var
  HitIndex: Integer;
  HitTestInfo: TTCHitTestInfo;
begin
  inherited;
  HitTestInfo.pt := SmallPointToPoint(Message.Pos);
  //HitIndex := SendStructMessage(Handle, TCM_HITTEST, 0, HitTestInfo);
  caption := IntToStr(HitTestInfo.pt.x);
  //if (HitIndex >= 0) and (HitIndex <> TabIndex) then
    Message.Result := 1;
end;

{ TDynGroupBox }

procedure TDynGroupBox.CalcChild;
var
  i, j: Integer;
  edt: TDynEdit;
  //Synmmo: TDynSynMemo;
  mmo: TDynMemo;
  chk: TDynCheckBox;
  lbl: TDynLabel;
  gb: TDynGroupBox ;
  Group: TDynGroup;
  dt:TDynDatTime;
  cntGr: Integer;
  isIn: Boolean;
begin
  if FDynPanel = nil then Exit;
  //if (csDesigning in  FDynPanel.ComponentState) then Exit;
  if FListChilds = nil then Exit;

  FListChilds.Clear;
  if Self.grpInplace.Name = 'DynGroup8' then
    Self.grpInplace.Name := 'DynGroup8';
  // първо се намират групичките
  for i := 0 to FDynPanel.FGroupBoxs.Count - 1 do
  begin
    gb := FDynPanel.FGroupBoxs[i];
    if gb = self then
      Continue;
    if Self.FRect.Contains(gb.FRect) then
    begin
      FListChilds.Add(gb);
    end;
  end;
  cntGr := FListChilds.Count - 1;// брой на групичките

  for i := 0 to FDynPanel.FEdits.Count - 1 do
  begin
    edt := FDynPanel.FEdits[i];
    if Self.FRect.Contains(edt.FRect) then
    begin
      isIn := true;
      for j := 0 to cntGr do
      begin
        if FListChilds[j].FRect.Contains(edt.FRect) then
        begin
          isIn := False;
          Break;
        end;
      end;
      if isIn then
      begin
        FListChilds.Add(edt);
        edt.ParentGroup := Self;
        edt.GapBootom := Self.FRect.Bottom - edt.FRect.Bottom;
      end;
    end;
  end;

  for i := 0 to FDynPanel.FDatTims.Count - 1 do
  begin
    dt := FDynPanel.FDatTims[i];
    if Self.FRect.Contains(dt.FRect) then
    begin
      isIn := true;
      for j := 0 to cntGr do
      begin
        if FListChilds[j].FRect.Contains(dt.FRect) then
        begin
          isIn := False;
          Break;
        end;
      end;
      if isIn then
      begin
        FListChilds.Add(dt);
        dt.ParentGroup := Self;
        dt.GapBootom := Self.FRect.Bottom - dt.FRect.Bottom;
      end;
    end;
  end;

  for i := 0 to FDynPanel.FChecks.Count - 1 do
  begin
    chk := FDynPanel.FChecks[i];
    if Self.FRect.Contains(chk.FRect) then
    begin
      isIn := true;
      for j := 0 to cntGr do
      begin
        if FListChilds[j].FRect.Contains(chk.FRect) then
        begin
          isIn := False;
          Break;
        end;
      end;
      if isIn then
      begin
        FListChilds.Add(chk);
        chk.ParentGroup := Self;
        chk.GapBootom := Self.FRect.Bottom - chk.FRect.Bottom;
      end;
    end;
  end;

  for i := 0 to FDynPanel.FLabels.Count - 1 do
  begin
    lbl := FDynPanel.FLabels[i];
    if Self.FRect.Contains(lbl.FRect) then
    begin
      isIn := true;
      for j := 0 to cntGr do
      begin
        if FListChilds[j].FRect.Contains(lbl.FRect) then
        begin
          isIn := False;
          Break;
        end;
      end;
      if isIn then
      begin
        FListChilds.Add(lbl);
        lbl.ParentGroup := Self;
        lbl.GapBootom := Self.FRect.Bottom - lbl.FRect.Bottom;
      end;
    end;
  end;

  for i := 0 to FDynPanel.FMemos.Count - 1 do
  begin
    mmo := FDynPanel.FMemos[i];
    if Self.FRect.Contains(mmo.FRect) then
    begin
      isIn := true;
      for j := 0 to cntGr do
      begin
        if FListChilds[j].FRect.Contains(mmo.FRect) then
        begin
          isIn := False;
          Break;
        end;
      end;
      if isIn then
      begin
        FListChilds.Add(mmo);
        mmo.ParentGroup := Self;
        mmo.GapBootom := Self.FRect.Bottom - mmo.FRect.Bottom;
      end;
    end;
  end;


end;


procedure TDynGroupBox.CalcGroupBox;
var
  i: Integer;
  gb: TDynGroupBox;
  minDelta: Integer;
begin
  if FDynPanel = nil then Exit;
  if (csDesigning in FDynPanel.ComponentState) then Exit;

  //if FListGroup.Count > 0 then Exit;
  FListGroup.Clear;
  FListIndex.Clear;

  minDelta := MaxInt;
  ParentGroup := nil;

  for i := 0 to FDynPanel.FGroupBoxs.Count - 1 do
  begin
    gb := FDynPanel.FGroupBoxs[i];

    if gb.FRect.Contains(Self.FRect) and (gb <> self) then
    begin
      FListGroup.Add(gb);
      FListIndex.Add(gb.FRect.Bottom - FRect.Bottom);
      minDelta := Min(minDelta,  FListIndex[FListIndex.Count - 1]);
    end;
  end;

  for i := 0 to FListIndex.Count - 1 do
  begin
    if minDelta = FListIndex[i] then
    begin
      Self.ParentGroup := FListGroup[i];
      Self.GapBootom := FListIndex[i];
      Exit;
    end;
  end;
  //for i := 0 to FDynPanel.FGroupBoxs.Count - 1 do
//  begin
//    if FDynPanel.FGroupBoxs[i] = self then
//      Continue;
//    FDynPanel.FGroupBoxs[i].FListGroup.Clear;
//    FDynPanel.FGroupBoxs[i].FListIndex.Clear;
//  end;
end;

function TDynGroupBox.CopyChilds(Offset: integer): TDynGroupBox;
var
  group, GroupNew: TDynGroup;
  r: TRect;
  i: Integer;
  dyn: TBaseControl;
  edt: TDynEdit;
  Edit: TDynEditData;
  gp: TDynGroupBox;
  Memo: TSizeGripMemo;
  mmo: TDynMemo;
  ChkBox: TDbCheckBoxResizeWin;
  chk: TDynCheckBox;
begin
  if FDynPanel = nil then Exit;
  if (csDesigning in  FDynPanel.ComponentState) then Exit;
  group := TDynGroup.Create(Self.FDynPanel);
  group.Parent := Self.FDynPanel;
  r := Self.grpInplace.BoundsRect;
  r.Offset(0, Self.grpInplace.Height + offset);
  group.BoundsRect := r;
  Result := TDynGroupBox(group.FDynGroupBox);
  result.ColIndex := Self.ColIndex;

  for i := 0 to FListChilds.Count - 1 do
  begin
    dyn := FListChilds[i];
    if dyn is TDynEdit then
    begin
      edt := TDynEdit(FListChilds[i]);
      Edit := TDynEditData.Create(Self.FDynPanel);
      r := edt.edtInplace.BoundsRect;
      r.Offset(0, Self.grpInplace.Height + offset);
      Edit.BoundsRect := r;
      Edit.Parent := Self.FDynPanel;
      Edit.ControlToDyn(Edit.Left, Edit.Top);
      Continue;
    end;
    if dyn is TDynCheckBox then
    begin
      chk := TDynCheckBox(FListChilds[i]);
      ChkBox := TDbCheckBoxResizeWin.Create(Self.FDynPanel);
      r := chk.chkInplace.BoundsRect;
      r.Offset(0, Self.grpInplace.Height + offset);
      ChkBox.BoundsRect := r;
      ChkBox.Parent := Self.FDynPanel;
      ChkBox.ControlToDyn(ChkBox.Left, ChkBox.Top);
      Continue;
    end;
    if dyn is TDynMemo then
    begin
      mmo := TDynMemo(FListChilds[i]);
      Memo := TSizeGripMemo.Create(Self.FDynPanel);
      Memo.labelCaption :=  mmo.mmoInplace.labelCaption;
      r := mmo.mmoInplace.BoundsRect;
      r.Offset(0, Self.grpInplace.Height + Offset);
      Memo.Parent := Self.FDynPanel;//.BinMemos;
      FDynPanel.AddDynMemo(Memo);
      Memo.BoundsRect := r;

      Memo.ControlToDyn(Memo.Left, Memo.Top);
      Continue;
    end;
    if dyn is TDynGroupBox then
    begin
      gp := TDynGroupBox(FListChilds[i]);
      GroupNew := TDynGroup.Create(Self.FDynPanel);
      r := gp.grpInplace.BoundsRect;
      r.Offset(0, Self.grpInplace.Height + offset);
      GroupNew.BoundsRect := r;
      GroupNew.Parent := Self.FDynPanel;
      GroupNew.ControlToDyn(GroupNew.Left, GroupNew.Top);
      Continue;
    end;
  end;
end;

constructor TDynGroupBox.create;
begin
  inherited;
  grpInplace := nil;
  FListGroup := TList<TDynGroupBox>.Create;
  FListIndex := TList<Integer>.Create;

end;

destructor TDynGroupBox.destroy;
begin
  FreeAndNil(FListGroup);
  FreeAndNil(FListIndex);
  inherited;
end;

function TDynGroupBox.GetName: string;
begin
  Result := grpInplace.Name;
end;

function TDynGroupBox.GetText: string;
begin
   if Assigned(FDynPanel.FOnGetText) then
    FDynPanel.FOnGetText(FDynPanel, Self, FText);
  Result := FText;
end;

procedure TDynGroupBox.MoveChild(deltaX, deltaY: Integer);
var
  i: Integer;
  bctrl: TBaseControl;
begin
  if FDynPanel = nil then Exit;
  if (csDesigning in  FDynPanel.ComponentState) then Exit;

  for i := 0 to FListChilds.Count - 1 do
  begin
    FListChilds[i].FRect.Offset(Round(deltaX),
                                Round(deltaY));
  end;
end;



procedure TDynGroupBox.MoveForMove(Offset: Integer);
var
  i: Integer;
  OldH: Integer;
  dy: Integer;
begin
  if FDynPanel = nil then Exit;
  if (csDesigning in FDynPanel.ComponentState) then
    Exit;
  for i := 0 to FListForMove.Count - 1 do
  begin
    OldH := FListForMove[i].FRect.Height;
    dy := FRect.Bottom + FListBootoms[i];
    if FListForMove[i] is TDynGroupBox then
    begin
      TDynGroupBox(FListForMove[i]).MoveChild(0, dy - FListForMove[i].FRect.top);
    end;
    FListForMove[i].FRect.Offset(0, dy - FListForMove[i].FRect.top + offset);
    //FListForMove[i].FRect.top := dy;
    //FListForMove[i].FRect.Height := OldH;
  end;
  //for i := 0 to FListChilds.Count - 1 do
//  begin
//    OldH := FListChilds[i].FRect.Height;
//    dy := FRect.Bottom + FListIndex[i];
//    FListChilds[i].FRect.Offset(0, dy - FListChilds[i].FRect.top);
//    //FListForMove[i].FRect.top := dy;
//    //FListForMove[i].FRect.Height := OldH;
//  end;

end;


procedure TDynGroupBox.SetText(const Value: string);
begin
  FText := Value;
end;

procedure TDynGroupBox.StretchGroupBoxHeight(newH, offset: Integer);
var
  i: Integer;
  deltaY: Integer;
  OldH: Integer;
  hh, gap, oldGap, gap1, oldGap1: Integer;
  parGroup: TDynGroupBox;


begin
  if FDynPanel = nil then Exit;
  if (csDesigning in FDynPanel.ComponentState) then
    Exit;
  if ParentGroup = nil then Exit;

  ParentGroup.FRect.Bottom := FRect.Bottom + self.GapBootom;

  for i := 0 to ParentGroup.FListForMove.Count - 1 do
  begin
    if ParentGroup.FListForMove[i] is TDynGroupBox then
    begin
      gap := (-ParentGroup.FListForMove[i].FRect.Top + ParentGroup.FRect.Bottom);
      oldGap := ParentGroup.FListBootoms[i];
      deltaY := gap + oldGap;
//      if deltaY <> 0 then
        FDynPanel.MoveGroup(0, deltaY, TDynGroupBox(ParentGroup.FListForMove[i]));
    end
    else
    begin
      gap := (-ParentGroup.FListForMove[i].FRect.Top + ParentGroup.FRect.Bottom);
      oldGap := ParentGroup.FListBootoms[i];
      deltaY := gap + oldGap;
//      if deltaY <> 0 then
        ParentGroup.FListForMove[i].FRect.Offset(0, deltaY);
    end;
  end;

  parGroup := ParentGroup.ParentGroup;
  gap := ParentGroup.GapBootom + self.GapBootom;
  while parGroup <> nil do
  begin
    for i := 0 to parGroup.FListForMove.Count - 1 do
    begin
      if parGroup.FListForMove[i] is TDynGroupBox then // ако е група
      begin
        gap1 := (-parGroup.FListForMove[i].FRect.Top + parGroup.FRect.Bottom);
        oldGap1 := parGroup.FListBootoms[i];
        deltaY := gap1 + oldGap1;
  //      if deltaY <> 0 then
          FDynPanel.MoveGroup(0, deltaY, TDynGroupBox(parGroup.FListForMove[i]));
      end
      else
      begin
        gap1 := (-parGroup.FListForMove[i].FRect.Top + parGroup.FRect.Bottom);
        oldGap1 := parGroup.FListBootoms[i];
        deltaY := gap1 + oldGap1;
        //if deltaY <> 0 then
          parGroup.FListForMove[i].FRect.Offset(0, deltaY);
      end;
    end;
    parGroup.FRect.Bottom := FRect.Bottom + gap;
    gap := gap + parGroup.GapBootom;
    parGroup := parGroup.ParentGroup;
  end;

  //if FDynPanel = nil then Exit;
//  if (csDesigning in FDynPanel.ComponentState) then
//    Exit;
//  for i := 0 to FListGroup.Count - 1 do
//  begin
//    OldH := FListGroup[i].FRect.Bottom;
//    FRect.Height := round((newH + offset) / FDynPanel.Scale);
//    FListGroup[i].FRect.Bottom := FRect.Bottom + FListIndex[i] + offset;
//    deltaY := FListGroup[i].FRect.Bottom - OldH;
//  end;

end;

{ TBaseControl }

procedure TBaseControl.CalcForMove;
var
  i, j: Integer;
  edt: TDynEdit;
  dt: TDynDatTime;
  //SynMmo: TDynSynMemo;
  mmo: TDynMemo;
  chk: TDynCheckBox;
  lbl: TDynLabel;
  gb: TDynGroupBox;
  tc: TDynTabControl;
begin
  if FDynPanel = nil then Exit;
  if (csDesigning in  FDynPanel.ComponentState) then Exit;

  if FListForMove = nil then
    Exit;

  //if (FListForMove.Count > 0) then Exit;
  FListForMove.Clear;
  FListBootoms.Clear;

  for i := 0 to FDynPanel.FEdits.Count - 1 do
  begin
    edt := FDynPanel.FEdits[i];

    if edt.FRect.Right <= Self.FRect.Left then Continue;
    if edt.FRect.Left >= Self.FRect.Right then Continue;
    if edt.FRect.Bottom <= Self.FRect.Bottom then Continue;
    if Self.ParentGroup = edt.ParentGroup then // може да мести само от своята група
    begin
      FListForMove.Add(edt);
      FListBootoms.Add(edt.FRect.top - FRect.Bottom);
    end
    else
      Continue;
  end;

  for i := 0 to FDynPanel.FDatTims.Count - 1 do
  begin
    dt := FDynPanel.FDatTims[i];

    if dt.FRect.Right <= Self.FRect.Left then Continue;
    if dt.FRect.Left >= Self.FRect.Right then Continue;
    if dt.FRect.Bottom <= Self.FRect.Bottom then Continue;
    if Self.ParentGroup = dt.ParentGroup then // може да мести само от своята група
    begin
      FListForMove.Add(dt);
      FListBootoms.Add(dt.FRect.top - FRect.Bottom);
    end
    else
      Continue;
  end;

  for i := 0 to FDynPanel.FChecks.Count - 1 do
  begin
    chk := FDynPanel.FChecks[i];

    if chk.FRect.Right <= Self.FRect.Left then Continue;
    if chk.FRect.Left >= Self.FRect.Right then Continue;
    if chk.FRect.Bottom <= Self.FRect.Bottom then Continue;
    if Self.ParentGroup = chk.ParentGroup then // може да мести само от своята група
    begin
      FListForMove.Add(chk);
      FListBootoms.Add(chk.FRect.top - FRect.Bottom);
    end
    else
      Continue;
  end;

  for i := 0 to FDynPanel.FLabels.Count - 1 do
  begin
    lbl := FDynPanel.FLabels[i];

    if lbl.FRect.Right <= Self.FRect.Left then Continue;
    if lbl.FRect.Left >= Self.FRect.Right then Continue;
    if lbl.FRect.Bottom <= Self.FRect.Bottom then Continue;
    if Self.ParentGroup = lbl.ParentGroup then // може да мести само от своята група
    begin
      FListForMove.Add(lbl);
      FListBootoms.Add(lbl.FRect.top - FRect.Bottom);
    end
    else
      Continue;
  end;

  for i := 0 to FDynPanel.FGroupBoxs.Count - 1 do
  begin
    gb := FDynPanel.FGroupBoxs[i];
    if gb = self then Continue;


    if gb.FRect.Right <= Self.FRect.Left then Continue;
    if gb.FRect.Left >= Self.FRect.Right then Continue;
    if gb.FRect.Bottom <= Self.FRect.Bottom then Continue;
    //if gb.FRect.top > Self.FRect.Bottom then Continue;
    if gb.FRect.Contains(Self.FRect) then Continue;

    if (Self.ParentGroup = gb.ParentGroup) then // може да мести само от своята група
    begin
      FListForMove.Add(gb);
      FListBootoms.Add(gb.FRect.top - FRect.Bottom);
      //gb.CalcChild;
    end
    else
      Continue;
  end;



  for i := 0 to FDynPanel.FMemos.Count - 1 do
  begin
    mmo := FDynPanel.FMemos[i];

    if mmo.FRect.Right <= Self.FRect.Left then Continue;
    if mmo.FRect.Left >= Self.FRect.Right then Continue;
    if mmo.FRect.Bottom <= Self.FRect.Bottom then Continue;
    if Self.ParentGroup = mmo.ParentGroup then // може да мести само от своята група
    begin
      FListForMove.Add(mmo);
      FListBootoms.Add(mmo.FRect.top - FRect.Bottom);
    end
    else
    begin
      Continue;
    end;
  end;
end;

constructor TBaseControl.create;
begin
  FIsMoved := False;
  FParentGroup := nil;
  //if FDynPanel = nil then Exit;
  //if (csDesigning in  FDynPanel.ComponentState) then Exit;

  FListChilds := TList<TBaseControl>.Create;
  FListForMove := TList<TBaseControl>.Create;
  FListBootoms := TList<Integer>.Create;
end;

destructor TBaseControl.destroy;
begin
  FreeAndNil(FListChilds);
  FreeAndNil(FListForMove);
  FreeAndNil(FListBootoms);
  inherited;
end;

function TBaseControl.GetName: string;
begin
  //
end;

procedure TBaseControl.MoveForMove(Offset: Integer);
var
  i: Integer;
  bctrl: TBaseControl;
begin
  if FDynPanel = nil then Exit;
  if (csDesigning in  FDynPanel.ComponentState) then Exit;

  for i := 0 to FListForMove.Count - 1 do
  begin
    FListForMove[i].FRect.Offset(0,Round(Offset));
  end;
end;

procedure TBaseControl.SetColIndex(const Value: Word);
begin
  FColIndex := Value;
end;

procedure TBaseControl.SetParentGroup(const Value: TDynGroupBox);
begin
  FParentGroup := Value;
end;

procedure TBaseControl.SetPDataAspect(const Value: PAspRec);
begin
  FPDataAspect := Value;
end;

//procedure TBaseControl.SetIsMoved(const Value: Boolean);
//begin
//  FIsMoved := Value;
//  if Self.ColIndex = 77 then
//  begin
//    Self.ColIndex := 77;
//  end;
//end;

{ TDynDatTime }

constructor TDynDatTime.create;
begin
  inherited;
  DatTimInplace := nil;
end;

destructor TDynDatTime.destroy;
begin

  inherited;
end;

end.

