unit Tokens;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, System.Math,
  Options, CertThread, System.Generics.Collections, WalkFunctions, RealObj.RealHipp,
  Table.Doctor;

type
  TTokensLabel = class
    RctToken: TRectangle;
    RctColorToken: TRectangle;
    txtKey, txtCapt, txtPeriod: TText;
    btnIcon: TRectangle;

    public
    //constructor create;
    //destructor destroy; override;
  end;

  TfrmFmxTokens = class(TForm)
    lytTokens: TLayout;
    expndrTokens: TExpander;
    lytTokensHeader: TLayout;
    Layout4: TLayout;
    rctBtnLib: TRectangle;
    FloatAnimation21: TFloatAnimation;
    FloatAnimation22: TFloatAnimation;
    lytToken: TLayout;
    rctBKTokensItem: TRectangle;
    rctColorToken: TRectangle;
    lytTokensItem: TLayout;
    rctIconTokens: TRectangle;
    animTokensIcon: TFloatAnimation;
    lytDumTokens: TLayout;
    txtTokensKey: TText;
    txtTokensCapt: TText;
    txtTokensDates: TText;
    lytLeft: TLayout;
    stylbk1: TStyleBook;
    edtLibFileName: TEdit;
    scrlbxToken: TScrollBox;
    scldlytTokens: TScaledLayout;
    rctBlanka: TRectangle;
    dlgOpenLib: TOpenDialog;
    procedure scrlbxTokenCalcContentBounds(Sender: TObject;
      var ContentBounds: TRectF);
    procedure scrlbxTokenMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
    procedure rctBtnLibMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure edtLibFileNamePainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edtLibFileNameChangeTracking(Sender: TObject);
    procedure edtLibFileNameValidating(Sender: TObject; var Text: string);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    FScaleDyn: Single;
    LstTokens: TList<TTokensLabel>;
    idxTokens: Integer;
    procedure SetScaleDyn(const Value: Single);
    procedure AddTokenRect(idxTokenRect: Integer; docDataPos: Cardinal);
    procedure  RecalcBlanka;


  public
    Option: TOptions;
    thrCert: TCertThread;
    collDoctor: TRealDoctorColl;
    procedure FillTokens;
    procedure ClearBlanka;
    property scaleDyn: Single read FScaleDyn write SetScaleDyn;
  end;

var
  frmFmxTokens: TfrmFmxTokens;

implementation

{$R *.fmx}

procedure TfrmFmxTokens.AddTokenRect(idxTokenRect: Integer; docDataPos: Cardinal);
var
  TempTokenRect: TRectangle;
  TempTokenLabel: TTokensLabel;
  startDate: string;
  endDate: string;
  Delta: Integer;
  arrStr: TArray<string>;
  repNumber: Integer;
  i: Integer;
  doctor: TRealDoctorItem;
begin
  if (LstTokens.Count - 1) < idxTokens then
  begin
    TempTokenLabel := TTokensLabel.create;
    TempTokenRect := TRectangle(rctBKTokensItem.Clone(self));
    TempTokenRect.TagObject := TempTokenLabel;
    TempTokenLabel.RctToken := TempTokenRect;

    LstTokens.Add(TempTokenLabel);
    TempTokenLabel.txtKey := WalkChildrenTextStyle(TempTokenRect, 'txtKey');
    TempTokenLabel.txtCapt := WalkChildrenTextStyle(TempTokenRect, 'txtCapt');
    TempTokenLabel.txtPeriod := WalkChildrenTextStyle(TempTokenRect, 'txtPeriod');
    TempTokenLabel.btnIcon := WalkChildrenRectStyle(TempTokenRect, 'btnIcon');
    TempTokenLabel.RctColorToken := WalkChildrenRectStyle(TempTokenRect, 'ColorToken');
  end
  else
  begin
    TempTokenLabel := LstTokens[idxTokenRect];
    TempTokenRect := TempTokenLabel.RctToken;
  end;
  TempTokenRect.Position.Point := PointF(TempTokenRect.Position.Point.X, 10000);
  TempTokenRect.Parent := lytToken;

  TempTokenRect.Visible := True;
  for i := 0 to collDoctor.Count - 1 do
  begin
    doctor := collDoctor.Items[i];
    if doctor.DataPos = docDataPos then
    begin
      TempTokenLabel.txtCapt.Text := collDoctor.getAnsiStringMap(docDataPos, word(Doctor_FNAME)) + ' ' +
                                     collDoctor.getAnsiStringMap(docDataPos, word(Doctor_SNAME)) + ' ' +
                                     collDoctor.getAnsiStringMap(docDataPos, word(Doctor_LNAME));

      startDate := DateToStr(doctor.Cert.ValidFrom);
      endDate := DateToStr(doctor.Cert.ValidTo);
      Delta := Floor(doctor.Cert.ValidTo - Floor(Date));
      TempTokenLabel.txtPeriod.Text := Format('%s - %s (Остават %d дни до края ...)',[startDate, endDate, delta]);
      Break;
    end;
  end;
end;

procedure TfrmFmxTokens.ClearBlanka;
var
  i: Integer;
begin
  for i := 0 to LstTokens.Count - 1 do
  begin
    LstTokens[i].RctToken.Parent := nil;
  end;
  idxTokens := 0;
end;

procedure TfrmFmxTokens.edtLibFileNameChangeTracking(Sender: TObject);
begin
  //
end;

procedure TfrmFmxTokens.edtLibFileNamePainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  if edtLibFileName.IsFocused then Exit;

  edtLibFileName.Text := Option.LibTokenDll;
end;

procedure TfrmFmxTokens.edtLibFileNameValidating(Sender: TObject;
  var Text: string);
begin
  if FileExists(text) then
  begin
    Option.LibTokenDll := text;
    edtLibFileName.TextSettings.FontColor := TAlphaColorRec.Black;
  end
  else
  begin
    edtLibFileName.TextSettings.FontColor := TAlphaColorRec.red;
  end;
end;

procedure TfrmFmxTokens.FillTokens;
var
  i: integer;
begin
  ClearBlanka;
  for i := 0 to thrCert.LstPlugCardDoctor.Count - 1 do
  begin
    AddTokenRect(idxTokens, thrCert.LstPlugCardDoctor[i]);
    inc(idxTokens);
  end;
  RecalcBlanka;
end;

procedure TfrmFmxTokens.FormCreate(Sender: TObject);
begin
  rctBKTokensItem.Visible := False;
  LstTokens := TList<TTokensLabel>.create;
  FScaleDyn := 1;
end;

procedure TfrmFmxTokens.FormDestroy(Sender: TObject);
begin
  FreeAndNil(LstTokens);
end;

procedure TfrmFmxTokens.rctBtnLibMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if dlgOpenLib.Execute then
  begin
    Option.LibTokenDll := dlgOpenLib.FileName;
    edtLibFileName.Text := Option.LibTokenDll;
  end;
end;

procedure TfrmFmxTokens.RecalcBlanka;
var
  p2, p3: TPointF;
  lytLeftHeight, TotalH: Single;
begin
  lytToken.RecalcSize;
  expndrTokens.Height := InnerChildrenRect(lytToken).Height/FScaleDyn + 40 ;
  lytToken.Height := expndrTokens.Height;

  p2 := expndrTokens.LocalToAbsolute(PointF(0,expndrTokens.Size.Height + scrlbxToken.ViewportPosition.y/FScaleDyn));
  //p3 := lytEndRight.LocalToAbsolute(PointF(0,lytEndRight.Size.Height + scrlbx1.ViewportPosition.y/FScaleDyn));
  TotalH := (p2.Y ) / FScaleDyn + 10;
  lytTokens.Height := TotalH;
  scldlytTokens.OriginalHeight :=TotalH;
  scldlytTokens.Height := scldlytTokens.OriginalHeight * FScaleDyn;


end;

procedure TfrmFmxTokens.scrlbxTokenCalcContentBounds(Sender: TObject;
  var ContentBounds: TRectF);
begin
  ContentBounds := scldlytTokens.BoundsRect;
end;

procedure TfrmFmxTokens.scrlbxTokenMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
var
  tempH: Single;
  delta: Integer;
  vScrol: TScrollBar;
begin
  if ssCtrl in Shift then
  begin
    tempH := scldlytTokens.Height;
    if WheelDelta> 0 then
    begin
      tempH  := scldlytTokens.Height * 1.1;
      scaleDyn := tempH / scldlytTokens.OriginalHeight;
      scldlytTokens.Width := scldlytTokens.Width * 1.1;
      scldlytTokens.Height := scldlytTokens.Height * 1.1;
    end
    else
    begin
      tempH  := scldlytTokens.Height / 1.1;
      scaleDyn := tempH / scldlytTokens.OriginalHeight;
      scldlytTokens.Width := scldlytTokens.Width / 1.1;
      scldlytTokens.Height := scldlytTokens.Height / 1.1;
    end;
    Handled := True;
  end
  else
  begin
    scrlbxToken.FindStyleResource<TScrollBar>('vscrollbar', vScrol);

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

procedure TfrmFmxTokens.SetScaleDyn(const Value: Single);
begin
  FScaleDyn := Value;
end;

end.
