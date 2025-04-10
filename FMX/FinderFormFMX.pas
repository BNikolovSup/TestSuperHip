unit FinderFormFMX;
          //dyn
interface

uses
   Aspects.Types, Aspects.Collections, Table.PregledNew, Table.PatientNew, VirtualTrees,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Generics.Collections, SearchThread,

  RealObj.RealHipp,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.ListBox,
  FMX.ScrollBox, FMX.Memo, FMX.Objects, FMX.Edit, FMX.Presentation.Messages

  , WalkFunctions, FMX.Ani;



type

  TEditCotLabel = class
    edt: TEdit;
    captTxt: TText;
    cot1: TRectangle;
    cot2: TRectangle;
    cot3: TRectangle;
    cot4: TRectangle;
    cot5: TRectangle;
    menu: TRectangle;
    field: Word;
  end;

  TExpanerTableLabel = class
    Expander: TExpander;
    Lyt: TLayout;
    LytIn: TLayout;
    CollectionsType: TCollectionsType;
    lstEditFind: TList<TEditCotLabel>;
    constructor create;
    destructor destroy; override;
  end;


  TfrmFinder = class(TForm)
    scrlbx1: TScrollBox;
    scldlyt1: TScaledLayout;
    btn1: TButton;
    brshCOT_starting: TBrushObject;
    lstCOT: TListBox;
    lstCotEqual: TListBoxItem;
    lstCotNotEqual: TListBoxItem;
    lstCotBigger: TListBoxItem;
    lstCotSmaller: TListBoxItem;
    lstCotBiggerEqual: TListBoxItem;
    lstCotSmallerEqual: TListBoxItem;
    lstCotIsNull: TListBoxItem;
    lstCotAny: TListBoxItem;
    lstCotContain: TListBoxItem;
    lstCotNotContain: TListBoxItem;
    lstCotStarting: TListBoxItem;
    lstCotEnding: TListBoxItem;
    lstCotNotStarting: TListBoxItem;
    lstCotNotEnding: TListBoxItem;
    lstCotNotIsNull: TListBoxItem;
    lstCotNotSmallerEqual: TListBoxItem;
    lstCotNotBiggerEqual: TListBoxItem;
    lstCotNotSmaller: TListBoxItem;
    lstCotNotBigger: TListBoxItem;
    brsCot_contain: TBrushObject;
    brsCot_Equal: TBrushObject;
    brsCot_bigger: TBrushObject;
    brsCotEnding: TBrushObject;
    brsCot_Smaller: TBrushObject;
    brsCot_BigEq: TBrushObject;
    brsCot_smalEq: TBrushObject;
    scldlyt2: TScaledLayout;
    brsEmpty: TBrushObject;
    brsNotEmpty: TBrushObject;
    brsCot_all: TBrushObject;
    brsCOT_Sens: TBrushObject;
    brsCotOptions: TBrushObject;
    txt1: TText;
    brshbjctCOT_contain: TBrushObject;
    edtForCloning: TEdit;
    rctMenu: TRectangle;
    lytPatient: TLayout;
    xpdrPatient: TExpander;
    lytEGN: TLayout;
    txtEGN: TText;
    edtEGN: TEdit;
    lytPatName: TLayout;
    txtPatName: TText;
    edtPatName: TEdit;
    lytExpIn: TLayout;
    stylbk1: TStyleBook;
    rctCot1: TRectangle;
    rctCot2: TRectangle;
    rctCot3: TRectangle;
    rctCot4: TRectangle;
    rctCot5: TRectangle;
    animPlanedTypeIcon: TFloatAnimation;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation3: TFloatAnimation;
    FloatAnimation4: TFloatAnimation;
    FloatAnimation5: TFloatAnimation;
    rctBlanka: TRectangle;
    rctNzisBTN: TRectangle;
    FloatAnimation17: TFloatAnimation;
    FloatAnimation19: TFloatAnimation;
    FloatAnimation18: TFloatAnimation;
    Rectangle2: TRectangle;
    FloatAnimation6: TFloatAnimation;
    FloatAnimation7: TFloatAnimation;
    FloatAnimation8: TFloatAnimation;
    rct2: TRectangle;
    anim1: TFloatAnimation;
    anim2: TFloatAnimation;
    anim3: TFloatAnimation;
    pdyn1: TPopup;

    procedure FormShow(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure FormMouseWheel1(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure btn1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure FormCreate(Sender: TObject);
    procedure lstCotAnyClick(Sender: TObject);
    procedure edtForCloningCotOptionClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure xpdrPatientResize(Sender: TObject);
    procedure edtForCloningValidating(Sender: TObject; var Text: string);
    procedure rctCot1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure scrlbx1CalcContentBounds(Sender: TObject;
      var ContentBounds: TRectF);
    //procedure edtForCloningChangeCOP(Sender: TObject);
  private
    FScaleDyn: Single;
    FIsFinding: Boolean;
    idxEditsCot: Integer;
    procedure SetScaleDyn(const Value: Single);
    procedure OnSetTextSearchEDT(Vid: TVtrVid; Text: string; field: Word; Condition: TConditionSet);
  public

    expanderPatLyt: TLayout;
    expanderPregLyt: TLayout;
    ArrCondition: TArray<TConditionSet>;
    CollPatient: TRealPatientNewColl;
    CollPregled: TRealPregledNewColl;
    lstExpanedrTable: TList<TExpanerTableLabel>;
    lstEditCot: TList<TEditCotLabel>;
    thrSearch: TSearchThread;
    procedure AddExpanderPat(idxListExpander: Integer; RunNode: PVirtualNode);
    procedure AddExpanderPat1(idxListExpander: Integer; RunNode: PVirtualNode);
    procedure AddEditCot(idxEditCot: Integer; lyt: TLayout; field: word);
    procedure AddExpanderPreg(idxListExpander: Integer; RunNode: PVirtualNode);
    property scaleDyn: Single read FScaleDyn write SetScaleDyn;
    property IsFinding: Boolean read FIsFinding write FIsFinding;

  end;

  TStyleSuggestEditProxy = class(TPresentationProxy)
  protected
    function CreateReceiver: TObject; override;
  end;

var
  frmFinder: TfrmFinder;

implementation

//uses
  //CalcPregled;

{$R *.fmx}



{ TForm9 }

procedure TfrmFinder.AddEditCot(idxEditCot: Integer; lyt: TLayout; field: word);
var
  TempEditCot: TEdit;
  TempEditLabel: TEditCotLabel;
begin
  if idxEditCot > (lstEditCot.Count - 1) then
  begin
    TempEditCot := TEdit(edtForCloning.Clone(nil));
    TempEditLabel := TEditCotLabel.Create;
    TempEditLabel.edt := TempEditCot;
    TempEditLabel.field := field;
    TempEditCot.TagObject := TempEditLabel;
    lstEditCot.Add(TempEditLabel);
  end
  else
  begin
    TempEditLabel := lstEditCot[idxEditCot];
    TempEditCot := TempEditLabel.edt;
  end;

  //ArctCot1 := WalkChildrenRectStyle(edt, 'Cot1');
 // ArctCot1.OnMouseUp  := rctCot1MouseUp;
  TempEditCot.Position.y := 0;
  TempEditCot.Align  := TAlignLayout.Top;
  TempEditCot.Visible := True;
  TempEditCot.TextPrompt := CollPatient.DisplayName(field);
  TempEditCot.OnValidating := edtForCloningValidating;
  TempEditCot.Parent := lyt;
end;

procedure TfrmFinder.AddExpanderPat(idxListExpander: Integer; RunNode: PVirtualNode);
var
  TempExpndrLyt, TempExpIn: TLayout;   ///TExpanerTableLabel;
  TempExpander: TExpander;
  i: integer;
  act: TAsectTypeKind;
  edt: TEdit;
  ArctCot1: TRectangle;
  h: Single;
begin
  if (lstExpanedrTable.Count - 1) < idxListExpander then
  begin
    TempExpndrLyt := TLayout(self.lytPatient.Clone(self));
    TempExpndrLyt.Align := TAlignLayout.Top;
    TempExpndrLyt.Visible := True;
    TempExpander := WalkChildrenExpander(TempExpndrLyt);
    TempExpIn := WalkChildrenLyt(TempExpander);

    //TempExpndrLyt.Width := flwlytVizitFor.Width ;
    TempExpander.Text := 'test';
    TempExpndrLyt.Tag := nativeint(RunNode);
   // LstExpanders.Add(TempExpndrLyt);
    //TempExpndrLyt := LstExpanders[idxListExpander];
    TempExpndrLyt.Position.Point := PointF(TempExpndrLyt.Position.Point.X, 0);
    TempExpndrLyt.Parent := Self.scldlyt1;
    //TempExpndrLyt.OnResize := Expander1Resize;
  end
  else
  begin
//    TempExpndrLyt := LstExpanders[idxListExpander];
//    TempExpndrLyt.Position.Point := PointF(TempExpndrLyt.Position.Point.X, 0);
//    TempExpndrLyt.Height := 61;
//    TempExpndrLyt.Parent := flwlytVizitFor;
//    TempExpndrLyt.Width := flwlytVizitFor.Width ;
//    TempExpndrLyt.Text := pr001Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Description));
//    TempExpndrLyt.Tag := nativeInt(RunNode);
//    TempExpndrLyt.OnResize := Expander1Resize;
//
  end;

  for i := 0 to CollPatient.FieldCount - 1 do
  begin
    act := CollPatient.PropType(i);
    case act of
      actAnsiString:
      begin
        edt := TEdit(self.edtForCloning.Clone(self));
        ArctCot1 := WalkChildrenRectStyle(edt, 'Cot1');
        ArctCot1.OnMouseUp  := rctCot1MouseUp;
        edt.Position.y := 0;
        edt.Align  := TAlignLayout.Top;
        edt.Parent := TempExpIn;
        edt.Visible := True;
        edt.TextPrompt := CollPatient.DisplayName(i);
        edt.OnValidating := edtForCloningValidating;
        //edt.Field := i;// филд от пациент
//          edt.VidTable := vvPatient; // пациент
//          CollPatient.ListForFDB[0].ArrCondition[edt.Field] := [cotNotContain];
//          edt.Condition := CollPatient.ListForFDB[0].ArrCondition[edt.Field];
//          TCustomEditModelDyn(edt.model).FEditDyn := edt;
          //edt.OnSetTextSearchEDT := OnSetTextSearchEDT;
//          edt.LblText := CollPatient.DisplayName(i);
//          edt.OnCotOptionClick := FmxFinderFrm.edtForCloningCotOptionClick;
//          edt.OnChangeCOP := edtChangeCOP;
      end;
      //actTDate:
//        begin
//          datEdit := TDateEditDyn(FmxTest.dtedtBirth.Clone(FmxFinderFrm.expanderPat));
//          datEdit.Parent := FmxFinderFrm.expanderPat;
//          datEdit.Visible := True;
//          datEdit.Position.y := 10000;
//          datEdit.Align  := TAlignLayout.Top;
//          datEdit.Field := i;
//          datEdit.VidTable := vvPatient;
//          datEdit.OnSetTextSearchDEDT := OnSetTextSearchDTEDT;
//        end;
    end;
    //CollPatient.ListEditDyn.Add(edt);
  end;
  TempExpIn.RecalcSize;
  h := InnerChildrenRect(TempExpIn).Height / FScaleDyn ;
  TempExpndrLyt.Height := h + 75;
  if h = 0 then
  begin

    TempExpander.Height := 55;
  end
  else
  begin
    TempExpander.Height := h+ 35;
  end;
  scldlyt1.Repaint;
end;

procedure TfrmFinder.AddExpanderPat1(idxListExpander: Integer;
  RunNode: PVirtualNode);
var
  TempExpndrLyt, TempExpIn: TLayout;   ///TExpanerTableLabel;
  TempExpander: TExpander;
  i: integer;
  act: TAsectTypeKind;
  edt: TEdit;
  ArctCot1: TRectangle;
  h: Single;
begin
  if (lstExpanedrTable.Count - 1) < idxListExpander then
  begin
    TempExpndrLyt := TLayout(self.lytPatient.Clone(self));
    TempExpndrLyt.Align := TAlignLayout.Top;
    TempExpndrLyt.Visible := True;
    TempExpander := WalkChildrenExpander(TempExpndrLyt);
    TempExpIn := WalkChildrenLyt(TempExpander);
    TempExpander.Text := 'test';
    TempExpndrLyt.Tag := nativeint(RunNode);
    TempExpndrLyt.Position.Point := PointF(TempExpndrLyt.Position.Point.X, 0);
    TempExpndrLyt.Parent := Self.scldlyt1;
  end
  else
  begin

  end;

  for i := 0 to CollPatient.FieldCount - 1 do
  begin
    act := CollPatient.PropType(i);
    case act of
      actAnsiString:
      begin
        AddEditCot(idxEditsCot, TempExpIn, i);
        inc(idxEditsCot)
      end;
      actTDate:
      begin

      end;
    end;
  end;
  TempExpIn.RecalcSize;
  h := InnerChildrenRect(TempExpIn).Height / FScaleDyn ;
  TempExpndrLyt.Height := h + 75;
  if h = 0 then
  begin

    TempExpander.Height := 55;
  end
  else
  begin
    TempExpander.Height := h+ 35;
  end;
  scldlyt1.Repaint;
end;

procedure TfrmFinder.AddExpanderPreg(idxListExpander: Integer;
  RunNode: PVirtualNode);
var
  TempExpndrLyt, TempExpIn: TLayout;   ///TExpanerTableLabel;
  TempExpander: TExpander;
  i: integer;
  act: TAsectTypeKind;
  edt: TEdit;
  ArctCot1: TRectangle;
  h: Single;
begin
  if (lstExpanedrTable.Count - 1) < idxListExpander then
  begin
    TempExpndrLyt := TLayout(self.lytPatient.Clone(self));
    TempExpndrLyt.Align := TAlignLayout.Top;
    TempExpndrLyt.Visible := True;
    TempExpander := WalkChildrenExpander(TempExpndrLyt);
    TempExpIn := WalkChildrenLyt(TempExpander);

    //TempExpndrLyt.Width := flwlytVizitFor.Width ;
    TempExpander.Text := 'test';
    TempExpndrLyt.Tag := nativeint(RunNode);
   // LstExpanders.Add(TempExpndrLyt);
    //TempExpndrLyt := LstExpanders[idxListExpander];
    TempExpndrLyt.Position.Point := PointF(TempExpndrLyt.Position.Point.X, 10000);
    TempExpndrLyt.Parent := Self.scldlyt1;
    //TempExpndrLyt.OnResize := Expander1Resize;
  end
  else
  begin
//    TempExpndrLyt := LstExpanders[idxListExpander];
//    TempExpndrLyt.Position.Point := PointF(TempExpndrLyt.Position.Point.X, 0);
//    TempExpndrLyt.Height := 61;
//    TempExpndrLyt.Parent := flwlytVizitFor;
//    TempExpndrLyt.Width := flwlytVizitFor.Width ;
//    TempExpndrLyt.Text := pr001Temp.getAnsiStringMap(FAspNomenBuf, FAspNomenPosData, word(PR001_Description));
//    TempExpndrLyt.Tag := nativeInt(RunNode);
//    TempExpndrLyt.OnResize := Expander1Resize;
//
  end;

  for i := 0 to CollPregled.FieldCount - 1 do
  begin
    act := CollPregled.PropType(i);
    case act of
      actAnsiString:
      begin
        edt := TEdit(self.edtForCloning.Clone(self));
        ArctCot1 := WalkChildrenRectStyle(edt, 'Cot1');
        ArctCot1.OnMouseUp  := rctCot1MouseUp;
        edt.Position.y := 0;
        edt.Align  := TAlignLayout.Top;
        edt.Parent := TempExpIn;
        edt.Visible := True;
        edt.TextPrompt := CollPregled.DisplayName(i);
        edt.OnValidating := edtForCloningValidating;
        //edt.Field := i;// филд от пациент
//          edt.VidTable := vvPatient; // пациент
//          CollPatient.ListForFDB[0].ArrCondition[edt.Field] := [cotNotContain];
//          edt.Condition := CollPatient.ListForFDB[0].ArrCondition[edt.Field];
//          TCustomEditModelDyn(edt.model).FEditDyn := edt;
          //edt.OnSetTextSearchEDT := OnSetTextSearchEDT;
//          edt.LblText := CollPatient.DisplayName(i);
//          edt.OnCotOptionClick := FmxFinderFrm.edtForCloningCotOptionClick;
//          edt.OnChangeCOP := edtChangeCOP;
      end;
      //actTDate:
//        begin
//          datEdit := TDateEditDyn(FmxTest.dtedtBirth.Clone(FmxFinderFrm.expanderPat));
//          datEdit.Parent := FmxFinderFrm.expanderPat;
//          datEdit.Visible := True;
//          datEdit.Position.y := 10000;
//          datEdit.Align  := TAlignLayout.Top;
//          datEdit.Field := i;
//          datEdit.VidTable := vvPatient;
//          datEdit.OnSetTextSearchDEDT := OnSetTextSearchDTEDT;
//        end;
    end;
    //CollPatient.ListEditDyn.Add(edt);
  end;
  TempExpIn.RecalcSize;
  h := InnerChildrenRect(TempExpIn).Height / FScaleDyn ;
  TempExpndrLyt.Height := h + 75;
  if h = 0 then
  begin

    TempExpander.Height := 55;
  end
  else
  begin
    TempExpander.Height := h+ 35;
  end;
  scldlyt1.Repaint;
end;

procedure TfrmFinder.btn1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if Button = TMouseButton.mbRight then
  begin
    pdyn1.PlacementTarget := TControl(Sender);
    if pdyn1.IsOpen then
    begin
      pdyn1.IsOpen := False;
    end;
    pdyn1.Popup();
  end;
end;

//procedure TfrmFinder.edtForCloningChangeCOP(Sender: TObject);
//var
//  eddt: TEditDyn;
//begin
//  edt := TEditDyn(Sender);
//  Self.ArrCondition[edt.Field] := edt.Condition;
//end;

procedure TfrmFinder.edtForCloningCotOptionClick(Sender: TObject);
var
  edt: TEdit;
begin
  edt := TEdit(Sender);

  //edt.Condition := self.ArrCondition[edt.Field];
  pdyn1.PlacementTarget := TControl(Sender);
  if pdyn1.IsOpen then
  begin
    pdyn1.IsOpen := False;
  end;
  pdyn1.Popup();

 // edt.PresentationProxy.SendMessage(PM_DROP_DOWN);
  //pdyn1.PreferedDisplayIndex <TDateTime>
end;

procedure TfrmFinder.edtForCloningValidating(Sender: TObject; var Text: string);
var
  TempEditCot: TEdit;
  TempEditLabel: TEditCotLabel;
begin
  TempEditCot := TEdit(Sender);
  TempEditLabel := TEditCotLabel(TempEditCot.TagObject);

  OnSetTextSearchEDT(vvPatient, Text, TempEditLabel.field, [TConditionType.cotContain]);
end;

procedure TfrmFinder.FormCreate(Sender: TObject);
begin
  FScaleDyn := 1;
  pdyn1.BoundsRect := lstCOT.BoundsRect;
  scldlyt2.Parent := pdyn1;
  scldlyt2.Align := TAlignLayout.Client;
  edtForCloning.Visible := False;
  lstExpanedrTable := TList<TExpanerTableLabel>.Create;
  lstEditCot := TList<TEditCotLabel>.Create;
  lytPatient.Visible := False;
end;

procedure TfrmFinder.FormDestroy(Sender: TObject);
begin
  FreeAndNil(lstExpanedrTable);
  FreeAndNil(lstEditCot);
end;

procedure TfrmFinder.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
var
  tempH: Single;
  delta: Integer;

begin
  if ssCtrl in Shift then
  begin
    tempH := scldlyt1.Height;
    if WheelDelta> 0 then
    begin
      tempH  := scldlyt1.Height * 1.1;
      scaleDyn := tempH / scldlyt1.OriginalHeight;
      scldlyt1.Width := scldlyt1.Width * 1.1;
      scldlyt1.Height := scldlyt1.Height * 1.1;
    end
    else
    begin
      tempH  := scldlyt1.Height / 1.1;
      scaleDyn := tempH / scldlyt1.OriginalHeight;
      scldlyt1.Width := scldlyt1.Width / 1.1;
      scldlyt1.Height := scldlyt1.Height / 1.1;
    end;
    Handled := True;
  end
  else
  begin
    if WheelDelta> 0 then
    begin
      scldlyt1.Position.Point :=  PointF(scldlyt1.Position.Point.x, scldlyt1.Position.Point.y + 20);
    end
    else
    begin
      scldlyt1.Position.Point :=  PointF(scldlyt1.Position.Point.x, scldlyt1.Position.Point.y - 20);
    end;
    Handled := True;

  end;

end;

procedure TfrmFinder.FormMouseWheel1(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; var Handled: Boolean);
var
  tempH: Single;
  delta: Integer;
  vScrol: TScrollBar;
begin
  if ssCtrl in Shift then
  begin
    tempH := scldlyt1.Height;
    if WheelDelta> 0 then
    begin
      tempH  := scldlyt1.Height * 1.1;
      scaleDyn := tempH / scldlyt1.OriginalHeight;
      scldlyt1.Width := scldlyt1.Width * 1.1;
      scldlyt1.Height := scldlyt1.Height * 1.1;
    end
    else
    begin
      tempH  := scldlyt1.Height / 1.1;
      scaleDyn := tempH / scldlyt1.OriginalHeight;
      scldlyt1.Width := scldlyt1.Width / 1.1;
      scldlyt1.Height := scldlyt1.Height / 1.1;
    end;
    Handled := True;
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
    //btn1.Text := Self.ActiveControl.ClassName;
  end;
end;

procedure TfrmFinder.FormShow(Sender: TObject);
begin
  //AddExpander;
end;

procedure TfrmFinder.lstCotAnyClick(Sender: TObject);
begin
  pdyn1.IsOpen := False;
end;

procedure TfrmFinder.OnSetTextSearchEDT(Vid: TVtrVid; Text: string; field: Word;
  Condition: TConditionSet);
begin
  case Vid of
    vvPatient:
    begin
      CollPatient.OnSetTextSearchEDT(Text, field, Condition);
      CollPatient.ListForFinder[0].ArrCondition[field] := Condition;
      thrSearch.start;
    end;
  end;
end;

procedure TfrmFinder.rctCot1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  rct: TRectangle;
  anim : TFloatAnimation;

begin
  rct := TRectangle(Sender);
  anim := WalkChildrenAnim(rct);

  if anim.StartValue = 1 then
  begin
    rct.StrokeThickness := 2;
    rct.Stroke.Color := TAlphaColorRec.Blue;
    rct.Opacity := 1;
    anim.StartValue := 2;
    anim.StopValue := 1;

  end
  else
  begin
    rct.StrokeThickness := 1;
    rct.Stroke.Color := $FFBD7D7D;
    rct.Opacity := 0.4;
    anim.StartValue := 1;
    anim.StopValue := 2;
  end;
end;

procedure TfrmFinder.scrlbx1CalcContentBounds(Sender: TObject;
  var ContentBounds: TRectF);
begin
  ContentBounds := scldlyt1.BoundsRect;
end;

procedure TfrmFinder.SetScaleDyn(const Value: Single);
begin
  FScaleDyn := Value;
end;

procedure TfrmFinder.xpdrPatientResize(Sender: TObject);
var
  h: Single;
  TempExpIn: TExpander;
begin
  //h := InnerChildrenRect(TempExpIn).Height/FScaleDyn ;
//  TempExpander.Height := h + 35;
//  if h = 0 then
//  begin
//    TempExpander.Height := 55;
//  end
//  else
//  begin
//    TempExpander.Height := h+ 35;
//  end;
end;

{ TStyleSuggestEditProxy }

function TStyleSuggestEditProxy.CreateReceiver: TObject;
begin
  Result := TEdit.Create(nil);
end;

{ TExpanerTableLabel }

constructor TExpanerTableLabel.create;
begin
  inherited;
  lstEditFind := TList<TEditCotLabel>.create;
end;

destructor TExpanerTableLabel.destroy;
begin
  FreeAndNil(lstEditFind);
  inherited;
end;

initialization
end.
