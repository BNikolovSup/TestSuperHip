unit FinderFormFMX;
          //logicallabel
interface

uses
   Aspects.Types, Aspects.Collections, Table.PregledNew, Table.PatientNew, VirtualTrees,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Generics.Collections, SearchThread,

  RealObj.RealHipp, system.Rtti,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.ListBox,
  FMX.ScrollBox, FMX.Memo, FMX.Objects, FMX.Edit, FMX.Presentation.Messages

  , WalkFunctions, FMX.Ani, FMX.DateTimeCtrls;



type

  TCheckLabel = class
    rctCheck: TRectangle;
    CheckState: TCheckBoxState;
    checkBox: TCheckBox;
  end;

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
    VtrVid: TVtrVid;
    Condition: TConditionSet;
    constructor Create;
  end;

  TDateCotLabel = class
    dat: TDateEdit;
    captTxt: TText;
    cot1: TRectangle;
    cot2: TRectangle;
    cot3: TRectangle;
    cot4: TRectangle;
    cot5: TRectangle;
    menu: TRectangle;
    field: Word;
    VtrVid: TVtrVid;
    rctPopup: TRectangle;
    edtDate: TEdit;
  end;

  TExpanerTableLabel = class
    Expander: TExpander;
    Lyt: TLayout;
    LytIn: TLayout;
    CollectionsType: TCollectionsType;
    lstEditFind: TList<TEditCotLabel>;
    lstDateFind: TList<TDateCotLabel>;
    lstChkFind: TList<TCheckLabel>;
    constructor create;
    destructor destroy; override;
  end;


  TfrmFinder = class(TForm)
    scrlbx1: TScrollBox;
    scldlyt1: TScaledLayout;
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
    lytCollection: TLayout;
    expndrCollection: TExpander;
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
    lytBlanka: TLayout;
    BrushObject1: TBrushObject;
    Text1: TText;
    Rectangle1: TRectangle;
    FloatAnimation9: TFloatAnimation;
    Rectangle3: TRectangle;
    FloatAnimation10: TFloatAnimation;
    Rectangle4: TRectangle;
    FloatAnimation11: TFloatAnimation;
    Rectangle5: TRectangle;
    FloatAnimation12: TFloatAnimation;
    Rectangle6: TRectangle;
    FloatAnimation13: TFloatAnimation;
    Rectangle7: TRectangle;
    FloatAnimation14: TFloatAnimation;
    dtdtForCloning: TDateEdit;
    rctDatePickerPopup: TRectangle;
    FloatAnimation15: TFloatAnimation;
    edtDateRaw: TEdit;
    chkForCloning: TCheckBox;
    Rectangle8: TRectangle;
    grdlytLogical: TGridLayout;
    txtLogical: TText;

    procedure FormShow(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure FormMouseWheel1(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure btn1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure FormCreate(Sender: TObject);
    procedure lstCotAnyClick(Sender: TObject);
    procedure edtForCloningCotOptionClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure expndrCollectionResize(Sender: TObject);
    procedure edtForCloningValidating(Sender: TObject; var Text: string);
    procedure rctCot1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure scrlbx1CalcContentBounds(Sender: TObject;
      var ContentBounds: TRectF);
    procedure rctDatePickerPopupMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure edtDateRawPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edtDateRawValidating(Sender: TObject; var Text: string);
    procedure dtdtForCloningChange(Sender: TObject);
    //procedure edtForCloningChangeCOP(Sender: TObject);
  private
    FScaleDyn: Single;
    FIsFinding: Boolean;
    idxEditsCot: Integer;
    idxDatesCot: Integer;
    idxCheckLog: Integer;
    procedure SetScaleDyn(const Value: Single);
    procedure OnSetTextSearchEDT(Vid: TVtrVid; Text: string; field: Word; Condition: TConditionSet);
    procedure OnSetTextSearchDateEdt(Vid: TVtrVid; dat: Tdate; field: Word; Condition: TConditionSet);
    procedure SelectCot(ctrlCot: TControl; cot: TConditionType);
    procedure UnSelectCot(ctrlCot: TControl; cot: TConditionType);
  public

    expanderPatLyt: TLayout;
    expanderPregLyt: TLayout;
    ArrCondition: TArray<TConditionSet>;
    CollPatient: TRealPatientNewColl;
    CollPregled: TRealPregledNewColl;
    lstExpanedrTable: TList<TExpanerTableLabel>;
    lstEditCot: TList<TEditCotLabel>;
    lstCheckLog: TList<TCheckLabel>;
    lstDateEditCot: TList<TDateCotLabel>;
    thrSearch: TSearchThread;
    procedure AddExpanderPat1(idxListExpander: Integer; RunNode: PVirtualNode);
    procedure AddEditCot(idxEditCot: Integer; lyt: TLayout; field: word; VtrVid: TVtrVid);
    procedure AddDateCot(idxDateCot: Integer; lyt: TLayout; field: word; VtrVid: TVtrVid);
    procedure AddCheckLog(idxCheckLog: Integer; lyt: TGridLayout; field: word; VtrVid: TVtrVid; capt: string);
    procedure AddExpanderPreg(idxListExpander: Integer; RunNode: PVirtualNode);
    procedure AddExpanderPreg1(idxListExpander: Integer; RunNode: PVirtualNode);
    procedure RecalcBlanka;
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

procedure TfrmFinder.AddCheckLog(idxCheckLog: Integer; lyt: TGridLayout;
  field: word; VtrVid: TVtrVid; capt: string);
var
  TempCheckLog: TCheckBox;
  TempCheckLabel: TCheckLabel;
begin
  if idxCheckLog > (lstCheckLog.Count - 1) then
  begin
    TempCheckLog := TCheckBox(chkForCloning.Clone(nil));
    TempCheckLabel := TCheckLabel.Create;
    TempCheckLabel.checkBox := TempCheckLog;
    //TempCheckLabel.field := field;
    TempCheckLog.TagObject := TempCheckLabel;


    lstCheckLog.Add(TempCheckLabel);
  end
  else
  begin
    TempCheckLabel := lstCheckLog[idxCheckLog];
    TempCheckLog := TempCheckLabel.checkBox;
  end;

 // TempCheckLabel.VtrVid := VtrVid;
  //TempCheckLog.Position.y := 10000;
  //TempCheckLog.Align  := TAlignLayout.Top;
  TempCheckLog.Visible := True;
  //case VtrVid of
//    vvPatient:
//    begin
//      TempEditLabel.captTxt.Text := CollPatient.DisplayName(field);
//      TempEditCot.TextPrompt := CollPatient.DisplayName(field);
//    end;
//    vvPregled:
//    begin
//      TempEditLabel.captTxt.Text := CollPregled.DisplayName(field);
//      TempEditCot.TextPrompt := CollPregled.DisplayName(field);
//    end;
//  end;

  TempCheckLog.text := capt;
  TempCheckLog.Parent := lyt;
end;

procedure TfrmFinder.AddDateCot(idxDateCot: Integer; lyt: TLayout; field: word;
  VtrVid: TVtrVid);
var
  TempDateCot: TDateEdit;
  TempDateLabel: TDateCotLabel;
begin
  if idxDateCot > (lstDateEditCot.Count - 1) then
  begin
    TempDateCot := TDateEdit(dtdtForCloning.Clone(nil));
    TempDateLabel := TDateCotLabel.Create;
    TempDateLabel.dat := TempDateCot;
    TempDateLabel.field := field;
    TempDateCot.TagObject := TempDateLabel;
    TempDateLabel.captTxt := WalkChildrenText(TempDateCot);
    TempDateLabel.rctPopup := WalkChildrenRectStyle(TempDateCot, 'rctPopup');
    TempDateLabel.cot1 := WalkChildrenRectStyle(TempDateCot, 'Cot1');
    TempDateLabel.cot2 := WalkChildrenRectStyle(TempDateCot, 'Cot2');

    TempDateLabel.edtDate := WalkChildrenEdit(TempDateCot);
    lstDateEditCot.Add(TempDateLabel);
  end
  else
  begin
    TempDateLabel := lstDateEditCot[idxDateCot];
    TempDateCot := TempDateLabel.dat;
  end;

  TempDateLabel.VtrVid := VtrVid;
  TempDateCot.Position.y := 10000;
  TempDateCot.Align  := TAlignLayout.Top;
  TempDateCot.Visible := True;
  case VtrVid of
    vvPatient:
    begin
      TempDateLabel.captTxt.Text := CollPatient.DisplayName(field);
      //TempDateCot.TextPrompt := CollPatient.DisplayName(field);
    end;
    vvPregled:
    begin
      TempDateLabel.captTxt.Text := CollPregled.DisplayName(field);
      //TempDateCot.TextPrompt := CollPregled.DisplayName(field);
    end;
  end;
  TempDateLabel.edtDate.OnPainting := edtDateRawPainting;
  TempDateLabel.edtDate.OnValidating := edtDateRawValidating;
  TempDateLabel.rctPopup.OnMouseUp := rctDatePickerPopupMouseUp;
  TempDateLabel.cot1.OnMouseUp  := rctCot1MouseUp;
  TempDateLabel.cot2.OnMouseUp  := rctCot1MouseUp;
  TempDateCot.OnChange := dtdtForCloningChange;// edtForCloningValidating;
  TempDateCot.Parent := lyt;
end;

procedure TfrmFinder.AddEditCot(idxEditCot: Integer; lyt: TLayout; field: word; VtrVid: TVtrVid);
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
    TempEditLabel.captTxt := WalkChildrenText(TempEditCot);
    TempEditLabel.cot1 := WalkChildrenRectStyle(TempEditCot, 'Cot1');
    TempEditLabel.cot2 := WalkChildrenRectStyle(TempEditCot, 'Cot2');
    TempEditLabel.cot3 := WalkChildrenRectStyle(TempEditCot, 'Cot3');
    TempEditLabel.cot4 := WalkChildrenRectStyle(TempEditCot, 'Cot4');
    TempEditLabel.cot5 := WalkChildrenRectStyle(TempEditCot, 'Cot5');

    lstEditCot.Add(TempEditLabel);
  end
  else
  begin
    TempEditLabel := lstEditCot[idxEditCot];
    TempEditCot := TempEditLabel.edt;
  end;

  //ArctCot1 := WalkChildrenRectStyle(edt, 'Cot1');
 // ArctCot1.OnMouseUp  := rctCot1MouseUp;
  TempEditLabel.VtrVid := VtrVid;
  TempEditCot.Position.y := 10000;
  TempEditCot.Align  := TAlignLayout.Top;
  TempEditCot.Visible := True;
  case VtrVid of
    vvPatient:
    begin
      TempEditLabel.captTxt.Text := CollPatient.DisplayName(field);
      TempEditCot.TextPrompt := CollPatient.DisplayName(field);
    end;
    vvPregled:
    begin
      TempEditLabel.captTxt.Text := CollPregled.DisplayName(field);
      TempEditCot.TextPrompt := CollPregled.DisplayName(field);
    end;
  end;

  TempEditLabel.cot1.OnMouseUp := rctCot1MouseUp;
  TempEditLabel.cot2.OnMouseUp := rctCot1MouseUp;
  TempEditLabel.cot3.OnMouseUp := rctCot1MouseUp;
  TempEditLabel.cot4.OnMouseUp := rctCot1MouseUp;
  TempEditLabel.cot5.OnMouseUp := rctCot1MouseUp;
  TempEditCot.OnValidating := edtForCloningValidating;
  TempEditCot.Parent := lyt;
end;



procedure TfrmFinder.AddExpanderPat1(idxListExpander: Integer;
  RunNode: PVirtualNode);
var
  TempExpndrLyt, TempExpIn: TLayout;   ///TExpanerTableLabel;
  TempGrid: TGridLayout;
  TempExpander: TExpander;
  i: integer;
  act: TAsectTypeKind;
  edt1, edt2: TEdit;
  txt1, txt2: TText;
  ArctCot1: TRectangle;
  h: Single;
  log: TLogicalPatientNew;
begin
  if (lstExpanedrTable.Count - 1) < idxListExpander then
  begin
    TempExpndrLyt := TLayout(self.lytCollection.Clone(self));
    TempExpander := WalkChildrenExpander(TempExpndrLyt);
    txt1:= WalkChildrenTextStyle(TempExpndrLyt, 'FastSelect1');
    txt1.Text := 'ЕГН';
    txt2:= WalkChildrenTextStyle(TempExpndrLyt, 'FastSelect2');
    txt2.Text := 'ИМЕ';
    TempExpander.OnResize := expndrCollectionResize;

    TempExpndrLyt.Align := TAlignLayout.Top;
    TempExpndrLyt.Visible := True;

    TempExpIn := WalkChildrenLyt(TempExpander);
    TempExpander.Text := 'Пациент';
    TempExpndrLyt.Tag := nativeint(RunNode);
    TempExpndrLyt.Position.Point := PointF(TempExpndrLyt.Position.Point.X, 0);

    TempExpndrLyt.Margins.Right := 30;
    TempGrid := WalkChildrenGridStyle(TempExpander, 'grdlytLogical');
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
        AddEditCot(idxEditsCot, TempExpIn, i, vvPatient);
        inc(idxEditsCot)
      end;
      actTDate:
      begin
        AddDateCot(idxDatesCot, TempExpIn, i, vvPatient);
        inc(idxDatesCot)
      end;
      actLogical:
      begin
        for log := Low(TlogicalPatientNew) to High(TlogicalPatientNew) do
        begin
          AddCheckLog(idxCheckLog, TempGrid, 0, vvPatient, TRttiEnumerationType.GetName(log));
          inc(idxCheckLog);
        end;

      end;
    end;
  end;
  TempExpndrLyt.Parent := Self.lytBlanka;
  TempExpander.RecalcSize;

  //scldlyt1.Repaint;
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
    TempExpndrLyt := TLayout(self.lytCollection.Clone(self));
    TempExpndrLyt.Align := TAlignLayout.Top;
    TempExpndrLyt.Visible := True;
    TempExpander := WalkChildrenExpander(TempExpndrLyt);
    TempExpIn := WalkChildrenLyt(TempExpander);

    //TempExpndrLyt.Width := flwlytVizitFor.Width ;
    TempExpander.Text := 'Преглед';
    TempExpndrLyt.Margins.Left := 30;
    TempExpndrLyt.Tag := nativeint(RunNode);
   // LstExpanders.Add(TempExpndrLyt);
    //TempExpndrLyt := LstExpanders[idxListExpander];
    TempExpndrLyt.Position.Point := PointF(TempExpndrLyt.Position.Point.X, 10000);
    TempExpndrLyt.Parent := Self.lytBlanka;
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
    TempExpander.Height := h+ 45;
  end;
  TempExpIn.Height := TempExpander.Height;
  scldlyt1.Repaint;
end;

procedure TfrmFinder.AddExpanderPreg1(idxListExpander: Integer;
  RunNode: PVirtualNode);
var
  TempExpndrLyt, TempExpIn: TLayout;   ///TExpanerTableLabel;
  TempExpander: TExpander;
  i: integer;
  act: TAsectTypeKind;
  edt1, edt2: TEdit;
  txt1, txt2: TText;
  ArctCot1: TRectangle;
  h: Single;
begin
  if (lstExpanedrTable.Count - 1) < idxListExpander then
  begin
    TempExpndrLyt := TLayout(self.lytCollection.Clone(self));
    TempExpander := WalkChildrenExpander(TempExpndrLyt);
    txt1:= WalkChildrenTextStyle(TempExpndrLyt, 'FastSelect1');
    txt1.Text := 'Номер на АЛ';
    txt2:= WalkChildrenTextStyle(TempExpndrLyt, 'FastSelect2');
    txt2.Text := 'НРН';
    TempExpander.OnResize := expndrCollectionResize;

    TempExpndrLyt.Align := TAlignLayout.Top;
    TempExpndrLyt.Visible := True;

    TempExpIn := WalkChildrenLyt(TempExpander);
    TempExpander.Text := 'Преглед';
    TempExpndrLyt.Tag := nativeint(RunNode);
    TempExpndrLyt.Position.Point := PointF(TempExpndrLyt.Position.Point.X, 0);

    TempExpndrLyt.Margins.left := 30;
  end
  else
  begin

  end;

  for i := 0 to CollPregled.FieldCount - 1 do
  begin
    act := CollPregled.PropType(i);
    case act of
      actAnsiString:
      begin
        AddEditCot(idxEditsCot, TempExpIn, i, vvPregled);
        inc(idxEditsCot)
      end;
      actTDate:
      begin
        AddDateCot(idxDatesCot, TempExpIn, i, vvPregled);
        inc(idxDatesCot)
      end;
    end;
  end;
  TempExpndrLyt.Parent := Self.lytBlanka;
  TempExpander.RecalcSize;

  //scldlyt1.Repaint;
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

procedure TfrmFinder.dtdtForCloningChange(Sender: TObject);
var
  TempDateCot: TDateEdit;
  TempDateLabel: TDateCotLabel;
begin
  TempDateCot := TDateEdit(Sender);
  TempDateLabel := TDateCotLabel(TempDateCot.TagObject);
  OnSetTextSearchDateEdt(TempDateLabel.VtrVid, TempDateCot.Date, TempDateLabel.field, [TConditionType.cotContain]);
end;

//procedure TfrmFinder.edtForCloningChangeCOP(Sender: TObject);
//var
//  eddt: TEditDyn;
//begin
//  edt := TEditDyn(Sender);
//  Self.ArrCondition[edt.Field] := edt.Condition;
//end;

procedure TfrmFinder.edtDateRawPainting(Sender: TObject; Canvas: TCanvas;
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

procedure TfrmFinder.edtDateRawValidating(Sender: TObject; var Text: string);
var
  Adate: TDate;
   fs: TFormatSettings;
  edt: TEdit;
  datEdit: TDateEdit;
  data: PAspRec;
  TempDateLabel: TDateCotLabel;
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
    TempDateLabel := TDateCotLabel(TDateEdit(edt.Parent).TagObject);
    TDateEdit(edt.Parent).IsChecked := false;
    TDateEdit(edt.Parent).Format := ' ';
  end;

end;

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
  if TempEditLabel.Condition <> [] then //zzzzzzzzzzzzzz
  begin
    OnSetTextSearchEDT(TempEditLabel.VtrVid, Text, TempEditLabel.field, TempEditLabel.Condition);
  end;
end;

procedure TfrmFinder.FormCreate(Sender: TObject);
begin
  FScaleDyn := 1;
  pdyn1.BoundsRect := lstCOT.BoundsRect;
  scldlyt2.Parent := pdyn1;
  scldlyt2.Align := TAlignLayout.Client;
  edtForCloning.Visible := False;
  dtdtForCloning.Visible := False;
  lstExpanedrTable := TList<TExpanerTableLabel>.Create;
  lstEditCot := TList<TEditCotLabel>.Create;
  lstCheckLog := TList<TCheckLabel>.Create;
  lstDateEditCot := TList<TDateCotLabel>.Create;
  lytCollection.Visible := False;
  idxEditsCot := 0;
  idxDatesCot := 0;
  idxCheckLog := 0;
end;

procedure TfrmFinder.FormDestroy(Sender: TObject);
begin
  FreeAndNil(lstExpanedrTable);
  FreeAndNil(lstEditCot);
  FreeAndNil(lstDateEditCot);
  FreeAndNil(lstCheckLog);
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

procedure TfrmFinder.OnSetTextSearchDateEdt(Vid: TVtrVid; dat: Tdate;
  field: Word; Condition: TConditionSet);
begin
  case Vid of
    vvPatient:
    begin
      CollPatient.OnSetDateSearchEDT(dat, field, Condition);
      CollPatient.ListForFinder[0].ArrCondition[field] := Condition;
      thrSearch.start;
    end;
    vvPregled:
    begin
      CollPregled.OnSetTextSearchDateEdt(dat, field, Condition);
      CollPregled.ListForFinder[0].ArrCondition[field] := Condition;
      thrSearch.start;
    end;
  end;
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
    vvPregled:
    begin
      CollPregled.OnSetTextSearchEDT(Text, field, Condition);
      CollPregled.ListForFinder[0].ArrCondition[field] := Condition;
      thrSearch.start;
    end;
  end;
end;

procedure TfrmFinder.rctCot1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  rct: TRectangle;
  anim : TFloatAnimation;
  ctrlCot: TControl;
begin
  rct := TRectangle(Sender);
  anim := WalkChildrenAnim(rct);
  ctrlCot := TControl(rct.Parent);
  if anim.StartValue = 1 then
  begin
    rct.StrokeThickness := 2;
    rct.Stroke.Color := TAlphaColorRec.Blue;
    rct.Opacity := 1;
    anim.StartValue := 2;
    anim.StopValue := 1;
    SelectCot(ctrlCot, TConditionType(rct.tag));
  end
  else
  begin
    rct.StrokeThickness := 1;
    rct.Stroke.Color := $FFBD7D7D;
    rct.Opacity := 0.4;
    anim.StartValue := 1;
    anim.StopValue := 2;
    UnSelectCot(ctrlCot, TConditionType(rct.tag));
  end;


end;

procedure TfrmFinder.RecalcBlanka;
var
  h: Single;
begin
  lytBlanka.Height := 10;
  h := InnerChildrenRect(lytBlanka).Height / FScaleDyn;
  scldlyt1.OriginalHeight := h + 20;
  scldlyt1.Height := scldlyt1.OriginalHeight * FScaleDyn;
  lytBlanka.Height := scldlyt1.OriginalHeight
//  Elapsed := Stopwatch.Elapsed;
//  txtTest.Text := ( Format('fill за %f',[Elapsed.TotalMilliseconds]));
end;

procedure TfrmFinder.rctDatePickerPopupMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
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

procedure TfrmFinder.scrlbx1CalcContentBounds(Sender: TObject;
  var ContentBounds: TRectF);
begin
  ContentBounds := scldlyt1.BoundsRect;
end;

procedure TfrmFinder.SelectCot(ctrlCot: TControl; cot: TConditionType);
var
  TempEditCot: TEdit;
  TempEditLabel: TEditCotLabel;
begin
  if ctrlCot is TEdit then
  begin
    TempEditCot := TEdit(ctrlCot);
    TempEditLabel := TEditCotLabel(TempEditCot.TagObject);
    Include(TempEditLabel.Condition, cot);
    OnSetTextSearchEDT(TempEditLabel.VtrVid, TempEditCot.Text, TempEditLabel.field, TempEditLabel.Condition);
  end;
end;

procedure TfrmFinder.SetScaleDyn(const Value: Single);
begin
  FScaleDyn := Value;
end;

procedure TfrmFinder.UnSelectCot(ctrlCot: TControl; cot: TConditionType);
var
  TempEditCot: TEdit;
  TempEditLabel: TEditCotLabel;
begin
  if ctrlCot is TEdit then
  begin
    TempEditCot := TEdit(ctrlCot);
    TempEditLabel := TEditCotLabel(TempEditCot.TagObject);
    Exclude(TempEditLabel.Condition, cot);
    OnSetTextSearchEDT(TempEditLabel.VtrVid, TempEditCot.Text, TempEditLabel.field, TempEditLabel.Condition);
  end;
end;

procedure TfrmFinder.expndrCollectionResize(Sender: TObject);
var
  h, hIn, hLogical, hTxt: Single;
  TempExpander: TExpander;
  TempExpIn, TempExpndrLyt: TLayout;
  grdLogical: TGridLayout;
  txtLogical: TText;
begin
  TempExpander := TExpander(Sender);
  TempExpndrLyt := TLayout(TempExpander.Parent);

  TempExpIn := WalkChildrenLytStyle(TempExpander, 'LytIn');
  grdLogical := WalkChildrenGridStyle(TempExpander, 'grdlytLogical');
  txtLogical := WalkChildrenTextStyle(TempExpander, 'txtLogical');

  // --- Височини на отделните секции ---
  if Assigned(TempExpIn) then
    hIn := InnerChildrenRect(TempExpIn).Height / FScaleDyn
  else
    hIn := 0;

  if Assigned(grdLogical) then
    hLogical := InnerChildrenRect(grdLogical).Height / FScaleDyn
  else
    hLogical := 0;

  if Assigned(txtLogical) then
    hTxt := txtLogical.Height + 6
  else
    hTxt := 0;

  // --- Обща височина на вътрешното съдържание ---
  h := hIn + hLogical + hTxt;

  // --- Ако е свит експандера ---
  if not TempExpander.IsExpanded then
  begin
    TempExpander.Height := 55;
    TempExpndrLyt.Height := 75;
  end
  else
  begin
    // --- Разгънат експандер ---
    TempExpander.Height := h + 75;
    TempExpIn.Height := hIn;
    TempExpndrLyt.Height := h + 95;
  end;
  RecalcBlanka;
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

{ TEditCotLabel }

constructor TEditCotLabel.Create;
begin
  inherited;
  Condition := [];
end;

end.
