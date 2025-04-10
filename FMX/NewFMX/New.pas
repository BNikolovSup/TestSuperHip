unit New;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, System.Math,
  System.TimeSpan, system.Diagnostics, VirtualTrees,
  Options, System.Generics.Collections, WalkFunctions,
  RealObj.RealHipp, ADB_DataUnit,
  Table.Doctor,
  Table.PatientNew,
  Aspects.Types, Aspects.Collections, FMX.ScrollBox, FMX.Memo;

type

  TItemsLabel = class
    RctItem: TRectangle;
    RctColorItem: TRectangle;
    txtLeft, txtCapt, txtDetails: TText;
    btnIcon: TRectangle;

  public
  //constructor create;
  //destructor destroy; override;
  end;

  TfrmfmxNew = class(TForm)
    lytNewItem: TLayout;
    expndrNew: TExpander;
    lytExpanderHeader: TLayout;
    Layout4: TLayout;
    rctBtnLib: TRectangle;
    FloatAnimation21: TFloatAnimation;
    FloatAnimation22: TFloatAnimation;
    lytInExpander: TLayout;
    rctBKItems: TRectangle;
    rctColorItem: TRectangle;
    lytIcon: TLayout;
    lytLeftText: TLayout;
    txtLeft: TText;
    txtItemsCapt: TText;
    txtDetailsItem: TText;
    lytLeft: TLayout;
    stylbk1: TStyleBook;
    edtLibFileName: TEdit;
    scrlbxNew: TScrollBox;
    scldlytNew: TScaledLayout;
    rctBlanka: TRectangle;
    dlgOpenLib: TOpenDialog;
    lytBtnHeader: TLayout;
    FloatAnimation1: TFloatAnimation;
    rct1: TRectangle;
    slctn1: TSelection;
    slctnpnt1: TSelectionPoint;
    brshPregled: TBrushObject;
    brshImun: TBrushObject;
    brshNotPregled: TBrushObject;
    brshAnal: TBrushObject;
    brshKonsult: TBrushObject;
    txtTest: TText;
    rctIcon: TRectangle;
    animIcon: TFloatAnimation;
    procedure scrlbxNewCalcContentBounds(Sender: TObject;
      var ContentBounds: TRectF);
    procedure scrlbxNewMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rctBtnLibMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rctBtnLibMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure expndrNewResize(Sender: TObject);
    procedure rctBtnLibClick(Sender: TObject);
    procedure slctnpnt1Track(Sender: TObject; var X, Y: Single);
    procedure scldlytNewResize(Sender: TObject);
    procedure edtLibFileNamePainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);

  private
    FScaleDyn: Single;
    LstItems: TList<TItemsLabel>;
    idxItems: Integer;

    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    procedure SetScaleDyn(const Value: Single);


  public
    Adb_DM: TADBDataModule;
    patNodes: TPatNodes;
    collBase: TBaseCollection;
    procedure ClearBlanka;
    procedure FillBlanka;
    procedure AddItem(indexItem: Integer);


    procedure FillPatient(node: PVirtualNode);
    property ScaleDyn: Single read FScaleDyn write SetScaleDyn;

  end;

var
  frmfmxNew: TfrmfmxNew;

implementation

{$R *.fmx}



procedure TfrmfmxNew.AddItem(indexItem: Integer);
var
  TempRect: TRectangle;
  TempItemsLabel: TItemsLabel;
begin
  if indexItem > (LstItems.Count - 1) then
  begin
    TempRect := TRectangle(rctBKItems.Clone(nil));
    TempItemsLabel := TItemsLabel.Create;
    TempItemsLabel.RctItem := TempRect;
    TempRect.TagObject := TempItemsLabel;
    LstItems.Add(TempItemsLabel);
  end
  else
  begin
    TempItemsLabel := LstItems[indexItem];
    TempRect := TempItemsLabel.RctItem;
  end;

  //TempRect.Height := 2*indexItem  + 65;
  //TempRect.Position.Y := 10000;
  TempRect.Parent := lytInExpander;
end;

procedure TfrmfmxNew.ClearBlanka;
var
  i: Integer;
begin
  rctBKItems.Parent := nil;
  for i := 0 to LstItems.Count - 1 do
  begin
    LstItems[i].RctItem.Parent := nil;
   // LstItems[i].RctItem.Position.y := 100000;
  end;

  idxItems := 0;
end;

procedure TfrmfmxNew.edtLibFileNamePainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  dataPat: paspRec;
begin
  if edtLibFileName.IsFocused then Exit;
  if patNodes = nil then Exit;


  dataPat := Pointer(PByte(patNodes.patNode) + lenNode);
  edtLibFileName.Text := collBase.getAnsiStringMap(dataPat.DataPos, Word(PatientNew_FNAME));

end;

procedure TfrmfmxNew.expndrNewResize(Sender: TObject);
var
  h: Single;
begin
  if expndrNew.IsExpanded then
  begin
    if lytInExpander.ChildrenCount > 0 then
    begin
      lytInExpander.Height := 5;
      h := (lytInExpander.Margins.Top) + 25;
      expndrNew.Height := InnerChildrenRect(lytInExpander).Height / FScaleDyn + h + 4;
      lytInExpander.Height := expndrNew.Height;
    end
    else
    begin
      expndrNew.Height := lytExpanderHeader.Height + 10;
    end;
  end
  else
  begin
    expndrNew.Height := lytExpanderHeader.Height;
  end;

end;

procedure TfrmfmxNew.FillBlanka;
var
  i: Integer;
  TempRect: TRectangle;
  TempItemsLabel: TItemsLabel;
begin
  for i := 0 to 400 do
  begin
    AddItem(idxItems);
    inc(idxItems);

   // TempRect := TRectangle(rctBKItems.Clone(nil));
//    TempRect.Height := Random(300) + 65;
//    TempItemsLabel := TItemsLabel.Create;
//    TempItemsLabel.RctItem := TempRect;
//    LstItems.Add(TempItemsLabel);
//    TempRect.Position.Y := 0;
//    TempRect.Parent := lytInExpander;
  end;
end;

procedure TfrmfmxNew.FillPatient(node: PVirtualNode);
var

  i: Integer;
begin
  scldlytNew.BeginUpdate;
  Stopwatch := TStopwatch.StartNew;
  if patNodes <> nil then
    FreeAndNil(patNodes);
  patNodes := Adb_DM.GetPatNodes(node);
  ClearBlanka;
  for i := 0 to patNodes.pregs.Count - 1 do
  begin
    AddItem(idxItems);
    inc(idxItems);
  end;
  scldlytNew.EndUpdate;
  expndrNew.RecalcSize;

  scldlytNew.OriginalHeight := expndrNew.Height + expndrNew.Margins.Top + 10;
  scldlytNew.Height := scldlytNew.OriginalHeight * FScaleDyn;
  lytNewItem.Height := scldlytNew.OriginalHeight;
  Elapsed := Stopwatch.Elapsed;
  txtTest.Text := ( Format('fill %d за %f',[patNodes.pregs.Count, Elapsed.TotalMilliseconds]));
  //scldlytNew.Repaint;
end;

procedure TfrmfmxNew.FormCreate(Sender: TObject);
begin
  FScaleDyn := 1;
  LstItems := TList<TItemsLabel>.Create;
  collBase := TBaseCollection.Create(TBaseItem);
  //ClearBlanka;
end;

procedure TfrmfmxNew.FormDestroy(Sender: TObject);
begin
  FreeAndNil(LstItems);
  FreeAndNil(collBase);
end;

procedure TfrmfmxNew.rctBtnLibClick(Sender: TObject);
begin
  scldlytNew.BeginUpdate;
  Stopwatch := TStopwatch.StartNew;
  ClearBlanka;
  FillBlanka;
  scldlytNew.EndUpdate;
  expndrNew.RecalcSize;

  scldlytNew.OriginalHeight := expndrNew.Height + expndrNew.Margins.Top + 10;
  scldlytNew.Height := scldlytNew.OriginalHeight * FScaleDyn;
  lytNewItem.Height := scldlytNew.OriginalHeight;
  Elapsed := Stopwatch.Elapsed;
  txtTest.Text := ( Format('fill за %f',[Elapsed.TotalMilliseconds]));
end;

procedure TfrmfmxNew.rctBtnLibMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  FloatAnimation22.Inverse := true;
  FloatAnimation1.Inverse := true;
  FloatAnimation22.Start;
  FloatAnimation1.Start;
end;

procedure TfrmfmxNew.rctBtnLibMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  FloatAnimation22.Inverse := false;
  FloatAnimation1.Inverse := false;
  FloatAnimation22.Start;
  FloatAnimation1.Start;
end;

procedure TfrmfmxNew.scldlytNewResize(Sender: TObject);
begin
  if slctnpnt1.IsFocused then Exit;
  slctnpnt1.Position.X := scldlytNew.BoundsRect.Right;

end;

procedure TfrmfmxNew.scrlbxNewCalcContentBounds(Sender: TObject;
  var ContentBounds: TRectF);
begin
  ContentBounds := scldlytNew.BoundsRect;
end;

procedure TfrmfmxNew.scrlbxNewMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
var
  tempH: Single;
  delta: Integer;
  vScrol: TScrollBar;
begin
  if ssCtrl in Shift then
  begin
    tempH := scldlytNew.Height;
    if WheelDelta> 0 then
    begin
      tempH  := scldlytNew.Height * 1.1;
      scaleDyn := tempH / scldlytNew.OriginalHeight;
      scldlytNew.Width := scldlytNew.Width * 1.1;
      scldlytNew.Height := scldlytNew.Height * 1.1;
    end
    else
    begin
      tempH  := scldlytNew.Height / 1.1;
      scaleDyn := tempH / scldlytNew.OriginalHeight;
      scldlytNew.Width := scldlytNew.Width / 1.1;
      scldlytNew.Height := scldlytNew.Height / 1.1;
    end;
    Handled := True;
  end
  else
  begin
    scrlbxNew.FindStyleResource<TScrollBar>('vscrollbar', vScrol);

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

procedure TfrmfmxNew.SetScaleDyn(const Value: Single);
begin
  FScaleDyn := Value;
end;

procedure TfrmfmxNew.slctnpnt1Track(Sender: TObject; var X, Y: Single);
begin
  scldlytNew.BeginUpdate;
  scldlytNew.OriginalWidth := x / FScaleDyn;
  scldlytNew.Width := scldlytNew.OriginalWidth * FScaleDyn;
  scldlytNew.EndUpdate;
end;

end.
