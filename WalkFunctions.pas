unit WalkFunctions;

interface
  uses
    System.SysUtils, system.Types,
    FMX.Types, FMX.StdCtrls, FMX.Layouts, FMX.Objects, FMX.Memo, FMX.DateTimeCtrls,
    FMX.Edit, FMX.Ani, RealObj.RealHipp, Aspects.Types, VirtualTrees,
    System.Generics.Collections, FMX.ListBox, FMX.Controls, FMX.Menus
     ;

 type

 TValueType = (tvNone, tvInteger, tvBoolean, tvDate, tvDateTime, tvTime, tvFloat, tvstring, tvBinar);
 TOptionObject = class(TFmxObject)
  private
    FDataPos: Cardinal;
    FTagString: string;
    FValueType: TValueType;
    FNameInIni: string;
    FSectionIni: string;
  public

    property DataPos: Cardinal read FDataPos write FDataPos;
    property TagString: string read FTagString write FTagString;
    property ValueType: TValueType read FValueType write FValueType;
    property SectionIni: string read FSectionIni write FSectionIni;
    property NameInIni: string read FNameInIni write FNameInIni;
  end;

  TOptionIntObject = class(TOptionObject)
  private
    FDefaultValue: integer;

  public
    property DefaultValue: integer read FDefaultValue write FDefaultValue;
  end;

  TComboBox = class(FMX.ListBox.TComboBox)
  private
    FPopupCustom: TPopup;
    procedure SetPopupCustom(const Value: TPopup);
  protected
    canDown: Boolean;
    procedure DropDown; override;
  property PopupCustom: TPopup read FPopupCustom write SetPopupCustom;
  end;


  TDiagLabel = class
    DiagRect: TRectangle;
    //diag: TRealDiagnosisItem;
    asp: PAspRec;
    node: PVirtualNode;
    MkbNode: PVirtualNode;
    edtMain: TEdit;
    edtAdd: TEdit;
    mmoDiag: TMemo;
    DelDiag: TRectangle;
    SelectMain: TRectangle;
    SelectAdd: TRectangle;
    txtMain: TText;
    txtAdd: TText;
    VerifStatus: TComboBox;
    ClinicStatus: TRectangle;
    iconVerifStatus: TRectangle;
    iconClinicStatus: TRectangle;
    canValidate: Boolean;
    ClinicStatusTXT: TText;
    constructor Create;
  end;

  TMdnAnals = class
    edtAnal: TEdit;
    Anal: TRealExamAnalysisItem;
    LinkAnal: PVirtualNode;
  end;

  TMdnsLabel = class
    MdnsLyt: TLayout;

    GridLayoutAnals: TGridLayout;
    EdtNrn: TEdit;
    btnDel: TRectangle;
    mdn: TRealMDNItem;
    LstAnals: TList<TMdnAnals>;
    LinkMdn: PVirtualNode;
    anim: TFloatAnimation;
    EdtMainMkb: TEdit;
  public
    constructor create;
    destructor destroy; override;
  end;

  TMnDiag = class
    edtMkb: TEdit;
    btnDropDownMKB: TRectangle;
    edtMkbAdd: TEdit;
    MKB: TRealDiagnosisItem;
    LinkMkb: PVirtualNode;
  end;

  TMnsLabel = class
    MnsLyt: TLayout;

    GridLayoutMkb: TLayout;
    EdtNrn: TEdit;
    edtSpec: TEdit;
    edtSpecName: TText;
    btnDel: TRectangle;
    mn: TRealBLANKA_MED_NAPRItem;
    LstMkbs: TList<TMnDiag>;
    LinkMn: PVirtualNode;
    anim: TFloatAnimation;
  public
    constructor create;
    destructor destroy; override;
  end;

  TImmunsLabel = class
    ImmunsLyt: TLayout;

    EdtNrn: TEdit;
    edtVacineCode: TEdit;
    btnDel: TRectangle;
    imun: TRealExamImmunizationItem;
    Mkb: TMnDiag;
    LinkImun: PVirtualNode;
    anim: TFloatAnimation;
  public
    constructor create;
    destructor destroy; override;
  end;

  TAspectScheduleEvent = class
    Root: TLayout;        // клонира се
    Body: TRectangle;    // визуалният блок
    Caption: TText;      // пациент / текст
    ResizeTopGrip: TRectangle;
    ResizeBottomGrip: TRectangle;
    ResizeTopLyt: TLayout;
    ResizeBottomLyt: TLayout;

    TypeEvent: Integer;
    StartTime: TTime;
    EndTime: TTime;

    DataPos: Cardinal;   // по-късно
    constructor Create;
  end;

  //function WalkChildrenASP(Parent: TFmxObject; Visit: TProc<TFmxObject>): TAspectRecObject;
  function WalkChildrenFLYT(Parent: TFmxObject): TFlowLayout;
  function WalkChildrenFLYTStyle(Parent: TFmxObject; styleName: string): TFlowLayout;
  function WalkChildrenCheck(Parent: TFmxObject): TCheckBox;
  function WalkChildrenRect(Parent: TFmxObject): TRectangle;
  function WalkChildrenLine(Parent: TFmxObject): TLine;
  function WalkChildrenCirc(Parent: TFmxObject): TCircle;
  function WalkChildrenRectStyle(Parent: TFmxObject; styleName: string): TRectangle;
  function WalkChildrenMemo(Parent: TFmxObject): TMemo;
  function WalkChildrenDate(Parent: TFmxObject): TDateEdit;
  function WalkChildrenEdit(Parent: TFmxObject): TEdit;
  function WalkChildrenAnim(Parent: TFmxObject): TFloatAnimation;
  procedure WalkChildrenEdtDiag(Parent: TFmxObject; diagLabel: TDiagLabel);
  procedure WalkChildrenEdtMdn(Parent: TFmxObject; MdnLabel: TMdnsLabel);
  procedure WalkChildrenEdtMn(Parent: TFmxObject; MnLabel: TMnsLabel);
  procedure WalkChildrenEdtImun(Parent: TFmxObject; ImunLabel: TImmunsLabel);
  function WalkChildrenCombo(Parent: TFmxObject): TComboBox;
  function WalkChildrenComboStyle(Parent: TFmxObject; styleName: string): TComboBox;
  function WalkChildrenText(Parent: TFmxObject): TText;
  function WalkChildrenTextStyle(Parent: TFmxObject; styleName: string): TText;
  function WalkChildrenExpander(Parent: TFmxObject): Texpander;
  function WalkChildrenLyt(Parent: TFmxObject): TLayout;
  function WalkChildrenLytStyle(Parent: TFmxObject; styleName: string): TLayout;
  function WalkChildrenGridStyle(Parent: TFmxObject; styleName: string): TGridLayout;

  function WalkChildrenOptionObject(Parent: TFmxObject;var LstOfObject: TList<TOptionObject>; buf: pointer): TOptionObject;
  //function WalkChildrenMenu(Parent: TFmxObject): TmenuItem;

  function InnerChildrenRect(control: TControl): TRectF;

implementation


function WalkChildrenOptionObject(Parent: TFmxObject;var LstOfObject: TList<TOptionObject>; buf: pointer): TOptionObject;
var
  i: Integer;
  Child: TFmxObject;
  data: PAspRec;
  node: PVirtualNode;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TOptionObject) then
    begin
      Result := TOptionObject(Child);
      node := Pointer(PByte(buf) + Result.DataPos);
      data := Pointer(PByte(node) + lenNode);
      data.index := LstOfObject.Add(Result);
    end
    else
    begin
      Result := WalkChildrenOptionObject(Child, LstOfObject, buf);
      //if Result <> nil then
//        LstOfObject.Add(Result);
    end;
  end;
end;

function WalkChildrenAnim(Parent: TFmxObject): TFloatAnimation;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TFloatAnimation) then
    begin
      Result := TFloatAnimation(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenAnim(Child);
      if Result <> nil then
        Exit;
    end;
  end;
end;

//function WalkChildrenASP(Parent: TFmxObject; Visit: TProc<TFmxObject>): TAspectRecObject;
//var
//  i: Integer;
//  Child: TFmxObject;
//begin
//  Result := nil;
//  for i := 0 to Parent.ChildrenCount-1 do
//  begin
//    Child := Parent.Children[i];
//   // Visit(Child);
//    if Child is TAspectRecObject then
//    begin
//      Result := TAspectRecObject(Child);
//      Exit;
//    end
//    else
//    begin
//      WalkChildrenASP(Child, Visit);
//    end;
//  end;
//end;

function WalkChildrenCheck(Parent: TFmxObject): TCheckBox;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TCheckBox) then
    begin
      Result := TCheckBox(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenCheck(Child);
      if Result <> nil then
        Exit;
    end;
  end;
end;

function WalkChildrenCirc(Parent: TFmxObject): TCircle;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TCircle) then
    begin
      Result := TCircle(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenCirc(Child);
      if Result <> nil then
        Exit;
    end;
  end;
end;

function WalkChildrenCombo(Parent: TFmxObject): TComboBox;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if Child.ClassName = 'TComboBox' then
    begin
      Result := TComboBox(Child);
      Exit;
    end
    else
    begin
      //Memo1.Lines.Add(Child.ClassName);
      if Result = nil then
      begin
        Result := WalkChildrenCombo(Child);
      end;
    end;
  end;
end;

function WalkChildrenComboStyle(Parent: TFmxObject; styleName: string): TComboBox;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child.ClassName = 'TComboBox') and (Child.StyleName = styleName) then
    begin
      Result := TComboBox(Child);
      Exit;
    end
    else
    begin
      //Memo1.Lines.Add(Child.ClassName);
      if Result = nil then
      begin
        Result := WalkChildrenComboStyle(Child, styleName);
      end;
    end;
  end;
end;

function WalkChildrenDate(Parent: TFmxObject): TDateEdit;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TDateEdit) then
    begin
      Result := TDateEdit(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenDate(Child);
      if Result <> nil then
        Exit;
    end;
  end;
end;

function WalkChildrenEdit(Parent: TFmxObject): TEdit;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TEdit) then
    begin
      Result := TEdit(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenEdit(Child);
      if Result <> nil then
        Exit;
    end;
  end;
end;

procedure WalkChildrenEdtDiag(Parent: TFmxObject;
  diagLabel: TDiagLabel);
var
  i: Integer;
  Child: TFmxObject;
  M, A: Boolean;
begin
  M := False;
  A := False;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TEdit) then
    begin
      case TEdit(Child).align of
        TAlignLayout.MostTop:
        begin
          diagLabel.edtMain := TEdit(Child);
          M := True;
        end;
         TAlignLayout.Top:
        begin
          diagLabel.edtAdd := TEdit(Child);
          A:= True;
        end;
      end;
      if M and A then // ако стане, да са в различни родители, трябва да се прехвърлят като параметри
        Exit;
    end
    else
    begin
      WalkChildrenEdtDiag(Child, diagLabel);
    end;
  end;
end;

procedure WalkChildrenEdtMdn(Parent: TFmxObject;
  MdnLabel: TMdnsLabel);
var
  i: Integer;
  Child: TFmxObject;
  AnalLabel: TMdnAnals;
begin
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TGridLayout) then
    begin
      MdnLabel.GridLayoutAnals := TGridLayout(Child);
      MdnLabel.LstAnals.Clear;
      WalkChildrenEdtMdn(Child, MdnLabel);
    end
    else
    if (Child is TRectangle) and (Child.StyleName = 'btnDel') then
    begin
      MdnLabel.btnDel := TRectangle(Child);
      WalkChildrenEdtMdn(Child, MdnLabel);
    end
    else
    if (Child is TFloatAnimation) then
    begin
      MdnLabel.anim := TFloatAnimation(Child);
    end
    else
    if (Child is Tedit) and (Parent is TGridLayout) then
    begin
      AnalLabel := TMdnAnals.Create;
      AnalLabel.edtAnal := Tedit(Child);
      MdnLabel.LstAnals.Add(AnalLabel);
    end
    else
    if (Child is Tedit) and (Child.StyleName = 'edtNRN')then
    begin
      MdnLabel.EdtNrn := TEdit(Child);
      WalkChildrenEdtMdn(Child, MdnLabel);
    end
    else
    if (Child is Tedit) and (Child.StyleName = 'edtMainMkb') then
    begin
      MdnLabel.EdtMainMkb := Tedit(Child);
      WalkChildrenEdtMdn(Child, MdnLabel);
    end
    else
    begin
      WalkChildrenEdtMdn(Child, MdnLabel);
    end;
  end;
end;

procedure WalkChildrenEdtMn(Parent: TFmxObject;
  MnLabel: TMnsLabel);
var
  i: Integer;
  Child: TFmxObject;
  MkblLabel: TMnDiag;
begin
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TLayout) then
    begin
      MnLabel.GridLayoutMkb := TLayout(Child);
      MnLabel.LstMkbs.Clear;
      WalkChildrenEdtMn(Child, MnLabel);
    end
    else
    if (Child is TRectangle) and (Child.StyleName = 'btnDel' ) then
    begin
      MnLabel.btnDel := TRectangle(Child);
      WalkChildrenEdtMn(Child, MnLabel);
    end
    else
    if (Child is TFloatAnimation) then
    begin
      MnLabel.anim := TFloatAnimation(Child);
    end
    else
    if (Child is Tedit) and (Parent is TText) and (Child.StyleName = 'diagMain' ) then
    begin
      MkblLabel := TMnDiag.Create;
      MkblLabel.edtMkb := Tedit(Child);
      MkblLabel.btnDropDownMKB := WalkChildrenRect(MkblLabel.edtMkb);
      MnLabel.LstMkbs.Add(MkblLabel);
    end
    else
    if (Child is Tedit) and (Child.StyleName = 'edtNrn' )then
    begin
      MnLabel.EdtNrn := TEdit(Child);
      WalkChildrenEdtMn(Child, MnLabel);
    end
    else
    if (Child is Tedit) and (Child.StyleName = 'edtSpec' ) then
    begin
      MnLabel.edtSpec := Tedit(Child);
      WalkChildrenEdtMn(Child, MnLabel);
    end
    else
    if (Child is TText) and (Child.StyleName = 'edtSpecName' ) then
    begin
      MnLabel.edtSpecName := TText(Child);
      WalkChildrenEdtMn(Child, MnLabel);
    end
    else
    begin
      WalkChildrenEdtMn(Child, MnLabel);
    end;
  end;
end;

procedure WalkChildrenEdtImun(Parent: TFmxObject; ImunLabel: TImmunsLabel);
var
  i: Integer;
  Child: TFmxObject;
  MkblLabel: TMnDiag;
begin
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];

    if (Child is TRectangle) then
    begin
      ImunLabel.btnDel := TRectangle(Child);
      WalkChildrenEdtImun(Child, ImunLabel);
    end
    else
    if (Child is TFloatAnimation) then
    begin
      ImunLabel.anim := TFloatAnimation(Child);
    end
    else
    if (Child is Tedit) and (Child.StyleName = 'diagMain' ) then
    begin
      ImunLabel.Mkb := TMnDiag.Create;
      ImunLabel.Mkb.edtMkb := Tedit(Child);
    end
    else
    if (Child is Tedit) and (Child.StyleName = 'edtNrn' )then
    begin
      ImunLabel.EdtNrn := TEdit(Child);
      WalkChildrenEdtImun(Child, ImunLabel);
    end
    else
    if (Child is Tedit) and (Child.StyleName = 'edtVacineCode' ) then
    begin
      ImunLabel.edtVacineCode := Tedit(Child);
      WalkChildrenEdtImun(Child, ImunLabel);
    end
    else
    begin
      WalkChildrenEdtImun(Child, ImunLabel);
    end;
  end;
end;

function WalkChildrenFLYT(Parent: TFmxObject): TFlowLayout;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TFlowLayout) then
    begin
      Result := TFlowLayout(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenFLYT(Child);
      if Result <> nil then
        Exit;
    end;
  end;
end;

function WalkChildrenFLYTStyle(Parent: TFmxObject; styleName: string): TFlowLayout;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TFlowLayout) and (Child.StyleName = styleName) then
    begin
      Result := TFlowLayout(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenFLYTStyle(Child, styleName);
      if Result <> nil then
        Exit;
    end;
  end;
end;

function WalkChildrenLine(Parent: TFmxObject): TLine;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TLine) then
    begin
      Result := TLine(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenLine(Child);
      if Result <> nil then
        Exit;
    end;
  end;
end;

function WalkChildrenMemo(Parent: TFmxObject): TMemo;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TMemo) then
    begin
      Result := TMemo(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenMemo(Child);
      if Result <> nil then
        Exit;
    end;
  end;
end;

function WalkChildrenRect(Parent: TFmxObject): TRectangle;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TRectangle) then
    begin
      Result := TRectangle(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenRect(Child);
      if Result <> nil then
        Exit;
    end;
  end;
end;

function WalkChildrenRectStyle(Parent: TFmxObject;
  styleName: string): TRectangle;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TRectangle) and (Child.StyleName = styleName) then
    begin
      Result := TRectangle(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenRectStyle(Child, styleName);
      if Result <> nil then
        Exit;
    end;
  end;
end;

function WalkChildrenText(Parent: TFmxObject): TText;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TText) then
    begin
      Result := TText(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenText(Child);
      if Result <> nil then
        Exit;
    end;
  end;
end;

function WalkChildrenTextStyle(Parent: TFmxObject;
  styleName: string): TText;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TText) and (Child.StyleName = styleName) then
    begin
      Result := TText(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenTextStyle(Child, styleName);
      if Result <> nil then
        Exit;
    end;
  end;
end;

function WalkChildrenExpander(Parent: TFmxObject): Texpander;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is Texpander) then
    begin
      Result := Texpander(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenExpander(Child);
      if Result <> nil then
        Exit;
    end;
  end;
end;

function WalkChildrenLyt(Parent: TFmxObject): TLayout;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TLayout) then
    begin
      Result := TLayout(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenLyt(Child);
      if Result <> nil then
        Exit;
    end;
  end;
end;

function WalkChildrenLytStyle(Parent: TFmxObject; styleName: string): TLayout;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TLayout) and (Child.StyleName = styleName) then
    begin
      Result := TLayout(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenLytStyle(Child, styleName);
      if Result <> nil then
        Exit;
    end;
  end;
end;

function WalkChildrenGridStyle(Parent: TFmxObject; styleName: string): TGridLayout;
var
  i: Integer;
  Child: TFmxObject;
begin
  Result := nil;
  for i := 0 to Parent.ChildrenCount-1 do
  begin
    Child := Parent.Children[i];
    if (Child is TGridLayout) and (Child.StyleName = styleName) then
    begin
      Result := TGridLayout(Child);
      Exit;
    end
    else
    begin
      Result := WalkChildrenGridStyle(Child, styleName);
      if Result <> nil then
        Exit;
    end;
  end;
end;


function InnerChildrenRect(control: TControl): TRectF;
var
  i: Integer;
begin
  Result := TRectF.Empty;
  if control.ControlsCount = 0 then Exit;
  Result := Control.Controls[0].ChildrenRect;

  for i := 1 to control.ControlsCount - 1 do
  begin
    if control.Controls[i].StyleName = 'NoCalc' then Continue;
    Result := TRectF.Union(Result, control.Controls[i].ChildrenRect);
  end;
end;

{ TMdnsLabel }

constructor TMdnsLabel.create;
begin
  inherited;
  LstAnals := TList<TMdnAnals>.Create;
  btnDel := nil;
  EdtNrn := nil;
  LinkMdn := nil;
  EdtMainMkb := nil;
end;

destructor TMdnsLabel.destroy;
begin
  FreeAndNil(LstAnals);
  inherited;
end;

{ TMnsLabel }

constructor TMnsLabel.create;
begin
  LstMkbs := TList<TMnDiag>.Create;
  btnDel := nil;
  EdtNrn := nil;
  LinkMn := nil;
end;

destructor TMnsLabel.destroy;
begin
  FreeAndNil(LstMkbs);
  inherited;
end;

{ TComboBox }

procedure TComboBox.DropDown;
begin
  //p1.Popup;
  Exit;
  if canDown then
    inherited;
  //if not Popup.IsOpen then

end;

procedure TComboBox.SetPopupCustom(const Value: TPopup);
begin
  FPopupCustom := Value;
 // ListBox.Parent := FPopupCustom;
end;

{ TImmunsLabel }

constructor TImmunsLabel.create;
begin
  btnDel := nil;
  EdtNrn := nil;
  LinkImun := nil;
end;

destructor TImmunsLabel.destroy;
begin

  inherited;
end;

{ TDiagLabel }

constructor TDiagLabel.Create;
begin
  node := nil;
  canValidate := True;
end;

{ TAspectScheduleEvent }

constructor TAspectScheduleEvent.Create;
begin
  DataPos := 0;
end;

end.
