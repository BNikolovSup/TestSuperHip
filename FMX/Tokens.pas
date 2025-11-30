unit Tokens;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, System.Math,
  Options, CertThread, System.Generics.Collections, WalkFunctions, RealObj.RealHipp,
  Table.Doctor, FMX.ScrollBox, FMX.Memo, sbxcertificatestorage, sbxtypes, CertHelper,
  SBX509, SBxMessageEncryptor, sbxmessagedecryptor, ADB_DataUnit;

type
  TTokensLabel = class
    RctToken: TRectangle;
    RctColorToken: TRectangle;
    txtKey, txtCapt, txtPeriod: TText;
    btnIcon: TRectangle;
    MemoPasword: TMemo;
    cert: TsbxCertificate;

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
    edtLibFileName: TEdit;
    scrlbxToken: TScrollBox;
    scldlytTokens: TScaledLayout;
    rctBlanka: TRectangle;
    dlgOpenLib: TOpenDialog;
    stylbk1: TStyleBook;
    mmoPaswordAspecti: TMemo;
    Rectangle1: TRectangle;
    FloatAnimation1: TFloatAnimation;
    brshEncrypt: TBrushObject;
    brshDecrypt: TBrushObject;
    Rectangle2: TRectangle;
    FloatAnimation2: TFloatAnimation;
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
    procedure expndrTokensResize(Sender: TObject);
    procedure mmoPaswordAspectiChangeTracking(Sender: TObject);
    procedure rctIconTokensMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Rectangle1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);

  private
    FScaleDyn: Single;
    LstTokens: TList<TTokensLabel>;
    idxTokens: Integer;
    procedure SetScaleDyn(const Value: Single);
    procedure AddTokenRect(idxTokenRect: Integer; docDataPos: Cardinal);
    procedure  RecalcBlanka;
    procedure DoPasswordNeeded(Sender: TObject; const NeededFor: String; var Password: String; var Cancel: Boolean);

  public
    Option: TOptions;
    thrCert: TCertThread;
    Adb_dm: TADBDataModule;
    //collDoctor: TRealDoctorColl;
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
  i, j: Integer;
  doctor: TRealDoctorItem;


  CertStorage: TsbxCertificateStorage;
  SlotCount, m: Integer;
  TokenPresent: Boolean;
  fs: TFormatSettings;
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
    TempTokenLabel.btnIcon.OnMouseUp := rctIconTokensMouseUp;
    TempTokenLabel.RctColorToken := WalkChildrenRectStyle(TempTokenRect, 'ColorToken');
    TempTokenLabel.MemoPasword := WalkChildrenMemo(TempTokenRect);
    TempTokenLabel.MemoPasword.OnChangeTracking := mmoPaswordAspectiChangeTracking;
  end
  else
  begin
    TempTokenLabel := LstTokens[idxTokenRect];
    TempTokenRect := TempTokenLabel.RctToken;
  end;
  TempTokenRect.Position.Point := PointF(TempTokenRect.Position.Point.X, 10000);
  TempTokenRect.Parent := lytToken;

  TempTokenRect.Visible := True;
  for i := 0 to Adb_dm.collDoctor.Count - 1 do
  begin
    doctor := Adb_dm.collDoctor.Items[i];
    if doctor.DataPos = docDataPos then
    begin
      TempTokenLabel.txtCapt.Text := Adb_dm.collDoctor.getAnsiStringMap(docDataPos, word(Doctor_FNAME)) + ' ' +
                                     Adb_dm.collDoctor.getAnsiStringMap(docDataPos, word(Doctor_SNAME)) + ' ' +
                                     Adb_dm.collDoctor.getAnsiStringMap(docDataPos, word(Doctor_LNAME));

      startDate := DateToStr(doctor.Cert.ValidFrom);
      endDate := DateToStr(doctor.Cert.ValidTo);
      Delta := Floor(doctor.Cert.ValidTo - Floor(Date));
      TempTokenLabel.txtPeriod.Text := Format('%s - %s (Остават %d дни до края ...)',[startDate, endDate, delta]);
      TempTokenLabel.cert := doctor.CertPlug;
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

procedure TfrmFmxTokens.DoPasswordNeeded(Sender: TObject;
  const NeededFor: String; var Password: String; var Cancel: Boolean);
begin
  ShowMessage('daj parola');
  Password := '1604';
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

procedure TfrmFmxTokens.expndrTokensResize(Sender: TObject);
begin
  if expndrTokens.IsUpdating then  Exit;
  RecalcBlanka;
  //if expndrTokens.IsExpanded then
//  begin
//    lytTokens.Height := expndrTokens.Height + expndrTokens.Margins.Top;
//    RecalcBlanka;
//  end
//  else
//  begin
//    expndrTokens.Height := lytTokens.Height + 5 + 5;
//    //xpdrVisitFor.Height := 75;
//    lytTokens.Height := expndrTokens.Height + expndrTokens.Margins.Top;
//    RecalcBlanka;
//
//  end;
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

procedure TfrmFmxTokens.mmoPaswordAspectiChangeTracking(Sender: TObject);
var
  tempRct: TRectangle;
begin
  TMemo(sender).Height := TMemo(sender).ContentBounds.Height + 5;
  tempRct := TRectangle(TMemo(sender).Parent);
  tempRct.Height := TMemo(sender).Position.Y + TMemo(sender).Height + 5;
  RecalcBlanka;
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

procedure TfrmFmxTokens.rctIconTokensMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  TempTokenRect: TRectangle;
  TempTokenLabel: TTokensLabel;
  InputStream, OutputStream: TStringStream;
  FMessageEncryptor: TsbxMessageEncryptor;
  FMessageDecryptor: TsbxMessageDecryptor;
  CertStorage: TsbxCertificateStorage;
begin
  CertStorage := TsbxCertificateStorage.Create(nil);
  CertStorage.OnPasswordNeeded := DoPasswordNeeded;
  CertStorage.RuntimeLicense := '5342444641444E585246323032313132303443344D393232353000000000000000000000000000005A5036484E353744000038554650524E4839314636410000';
  CertStorage.Open ( 'pkcs11://@/C:\Windows\System32\eTPKCS11.dll?slot=1&readonly=0');
  TempTokenRect := TRectangle(TRectangle(Sender).parent.Parent);
  TempTokenLabel := TTokensLabel(TempTokenRect.TagObject);

  FMessageEncryptor := TsbxMessageEncryptor.Create(self);
  FMessageEncryptor.RuntimeLicense := '5342444641444E585246323032313132303443344D393232353000000000000000000000000000005A5036484E353744000038554650524E4839314636410000';
  FMessageDecryptor := TsbxMessageDecryptor.Create(self);
  FMessageDecryptor.RuntimeLicense := '5342444641444E585246323032313132303443344D393232353000000000000000000000000000005A5036484E353744000038554650524E4839314636410000';

  //InputStream := TStringStream.Create('Parola');
//  InputStream.Position := 0;
//  OutputStream := TStringStream.Create;
//  FMessageEncryptor.EncryptionCertificate := TempTokenLabel.cert;
//  FMessageEncryptor.EncryptionAlgorithm := 'AES128';
//  FMessageEncryptor.InputStream := InputStream;
//  FMessageEncryptor.OutputStream := OutputStream;
//  FMessageEncryptor.Encrypt;
//  OutputStream.Position := 0;
//  OutputStream.SaveToFile('d:\Parola');


    InputStream := TStringStream.Create;//(TempTokenLabel.MemoPasword.Text);
    InputStream.LoadFromFile('d:\Parola');
    InputStream.Position := 0;
    OutputStream := TStringStream.Create;
    FMessageDecryptor.Certificates := CertStorage.Certificates;
    FMessageDecryptor.InputStream := InputStream;
    FMessageDecryptor.OutputStream := OutputStream;
    FMessageDecryptor.Decrypt;
    OutputStream.Position := 0;
    OutputStream.SaveToFile('d:\ParolaDecrypt');

  FreeAndNil(FMessageEncryptor);
  FreeAndNil(FMessageDecryptor);
end;

procedure TfrmFmxTokens.RecalcBlanka;
var
  p2, p3: TPointF;
  lytLeftHeight, TotalH: Single;
begin
  lytToken.RecalcSize;
  if expndrTokens.IsExpanded then
  begin
    expndrTokens.Height := InnerChildrenRect(lytToken).Height/FScaleDyn + 40 ;
  end
  else
  begin
    expndrTokens.Height := 40;
  end;
  lytToken.Height := expndrTokens.Height;

  p2 := expndrTokens.LocalToAbsolute(PointF(0,expndrTokens.Size.Height + scrlbxToken.ViewportPosition.y/FScaleDyn));
  //p3 := lytEndRight.LocalToAbsolute(PointF(0,lytEndRight.Size.Height + scrlbx1.ViewportPosition.y/FScaleDyn));
  TotalH := (p2.Y ) / FScaleDyn + 10;
  lytTokens.Height := TotalH;
  scldlytTokens.OriginalHeight :=TotalH;
  scldlytTokens.Height := scldlytTokens.OriginalHeight * FScaleDyn;


end;

procedure TfrmFmxTokens.Rectangle1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  TRectangle(Sender).Fill.Assign(brshDecrypt.Brush);
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
