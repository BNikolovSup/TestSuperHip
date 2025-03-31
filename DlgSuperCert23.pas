unit DlgSuperCert23;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, System.Math,

  SBStrUtils, SBConstants, SBX509, SBX509Ext, SBPKCS12, SBCustomCertStorage, SBWinCertStorage,
  SBRDN, SBMessages, SBTypes, SBUtils, SBAlgorithmIdentifier ;


type
  TfrmCertDlg = class(TForm)
    grdCert: TStringGrid;
    pnlBottom: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnDetail: TBitBtn;
    procedure grdCertDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdCertDblClick(Sender: TObject);
    procedure btnDetailClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    WinStorage : TElWinCertStorage;
    procedure LoadStorage(Storage: TElCustomCertStorage);
    procedure LoadStorageForFindCert(Storage: TElCustomCertStorage; certNom: string);
    function GetCertHipSelectName: string;
    function GetCertHipSelectEGN: string;
    function GetCertHipSelectID: string;
  public
  CellList: TStringList;
  CertHipSelect: TelX509Certificate;

  function GetCertFromID(idCert: string): boolean;

  function GetStringByOID(const S : ByteArray) : string;
  function GetOIDValue(NTS: TElRelativeDistinguishedName; const S: ByteArray; const Delimeter: AnsiString = ' / '): AnsiString;
  function GetCertDisplayName(Cert : TelX509Certificate): string;

  property CertHipSelectName: string read GetCertHipSelectName;
  property CertHipSelectEGN: string read GetCertHipSelectEGN;
  property CertHipSelectID: string read GetCertHipSelectID;
  end;


var
  frmCertDlg: TfrmCertDlg;

implementation

{$R *.dfm}

function TfrmCertDlg.GetCertDisplayName(Cert : TelX509Certificate) : string;
begin
  try
    Result := GetOIDValue(Cert.SubjectRDN, SB_CERT_OID_COMMON_NAME);
    if Result = '' then
      Result := GetOIDValue(Cert.SubjectRDN, SB_CERT_OID_ORGANIZATION);
  except
    Result:='';
  end;
end;



function TfrmCertDlg.GetCertFromID(idCert: string): boolean;
begin
  WinStorage.SystemStores.Add('MY');
  LoadStorageForFindCert(WinStorage, idCert);
end;

function BuildHexString(St : ByteArray) : string;
var i : integer;
begin
  Result:='';
  for I := Length(St) - 1 downto 0 do
    Result := Result + IntToHex(St[i], 2);
end;

function GetCertDisplayEGN(Cert : TelX509Certificate) : string;
var
  i: Integer;
  str: string;
begin
  try
    for i := 0 to Cert.SubjectRDN.Count - 1 do
    begin
      str := StringOfBytes(Cert.SubjectRDN.Values[i]);
      if str.StartsWith('PNOBG-') then
      begin
        Result := Copy(str, 7, length(str) -6);
        Break;
      end;
    end;
  except
    Result:='';
  end;
end;

procedure TfrmCertDlg.btnDetailClick(Sender: TObject);
//var
  //certHip: TElX509Certificate;
begin
  if (CellList.Count- 1 < grdCert.Row) then
  begin
    ShowMessage('Няма избран сертификат!');
    Exit;
  end;

  //certHip := TElX509Certificate(CellList.Objects[grdCert.Row]);
end;

procedure TfrmCertDlg.btnOKClick(Sender: TObject);
begin
  if CellList.Count - 1 < grdCert.Row then Exit;

  CertHipSelect := TElX509Certificate(CellList.Objects[grdCert.Row]);

  ModalResult := mrOk;
end;

procedure TfrmCertDlg.FormActivate(Sender: TObject);
var
  h: Integer;
begin

  WinStorage.SystemStores.Add('MY');

  LoadStorage(WinStorage);
  h := grdCert.DefaultRowHeight * grdCert.RowCount;
  Height :=  System.Math.min(h + pnlBottom.Height + GetSystemMetrics(SM_CYCAPTION) + 23, 424);
  grdCert.Height := h;
  if (GetWindowlong(grdCert.Handle, GWL_STYLE) and WS_VSCROLL) <> 0 then
    grdCert.DefaultColWidth := grdCert.Width - GetSystemMetrics(SM_CYVSCROLL) - 5
  else
    grdCert.DefaultColWidth := grdCert.Width - 4;
end;

procedure TfrmCertDlg.FormCreate(Sender: TObject);
begin
  CellList := TStringList.Create;
  WinStorage := TElWinCertStorage.Create(nil);
end;

procedure TfrmCertDlg.FormDestroy(Sender: TObject);
var
  i: integer;
  certHip: TElX509Certificate;
begin
  WinStorage.Free;
  CellList.Free;
end;



function TfrmCertDlg.GetCertHipSelectID: string;
begin
  if Assigned(CertHipSelect) then
  begin
    Result :=  BuildHexString(CertHipSelect.SerialNumber);
  end
  else
  begin
    Result := '';
  end;
end;

function TfrmCertDlg.GetCertHipSelectEGN: string;
begin
  Result :=  GetCertDisplayEGN(CertHipSelect);
end;

function TfrmCertDlg.GetCertHipSelectName: string;
begin
  Result :=  GetCertDisplayName(CertHipSelect);
end;

function TfrmCertDlg.GetOIDValue(NTS: TElRelativeDistinguishedName; const S: ByteArray; const Delimeter: AnsiString): AnsiString;
var
  i: Integer;
  t: AnsiString;
begin
  Result := '';
  for i := 0 to NTS.Count - 1 do
    if CompareContent(S, NTS.OIDs[i]) then
    begin
      t := AnsiString(StringOfBytes(NTS.Values[i]));
      if t = '' then
        Continue;

      if Result = '' then
      begin
        Result := t;
        if Delimeter = '' then
          Exit;
      end
      else
        Result := Result + Delimeter + t;
    end;
end;

function TfrmCertDlg.GetStringByOID(const S: ByteArray): string;
begin

end;

procedure TfrmCertDlg.grdCertDblClick(Sender: TObject);
var
  p: TPoint;
  aColl, aRow: integer;
begin
  if not btnOK.Enabled then Exit;
  CertHipSelect := TElX509Certificate(CellList.Objects[grdCert.Row]);
  p := grdCert.ScreenToClient(Mouse.CursorPos);
  grdCert.MouseToCell(p.X, p.Y, aColl, aRow);
  if (aRow >=0) and (aColl >= 0) then
    if CellList.Count > 0 then
    begin
      ModalResult := mrOk;
    end
    else
    begin
      ModalResult := mrCancel;
    end;
end;

procedure TfrmCertDlg.grdCertDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  str, SignName, Izdatel, SignId, fromDate, toDate, validen: string;
  pos1: Integer;
  r: TRect;
  cert: TElX509Certificate;
begin
  if CellList.Count -1 < ARow then Exit;

  if (gdSelected in State)  then
  begin
    grdCert.Canvas.Brush.Color := $00EADB95;
    grdCert.Canvas.FillRect(Rect);
  end
  else
  begin
    grdCert.Canvas.Brush.Color := clwhite;
    grdCert.Canvas.FillRect(Rect);
  end;


  cert := TElX509Certificate(CellList.Objects[ARow]);
  str := CellList[ARow];
  if str = '' then Exit;
  //pos1 := Pos(#9, str);
  //SignName := copy(str, 1, pos1 - 1);
  SignName := str;
  fromDate := FormatDateTime('DD.MM.YYYY hh:mm', cert.ValidFrom);
  todate := FormatDateTime('DD.MM.YYYY hh:mm', cert.ValidTo);
  Izdatel := cert.IssuerName.CommonName;

  r:= Rect;

  grdCert.Canvas.Font.Assign(grdCert.Font);
  r.Top := r.Top + 5 ;
  r.Bottom := r.Bottom + 25;
  grdCert.Canvas.TextRect(r, SignName, [tfCenter]);
  grdCert.Canvas.Font.Size := 8;
  grdCert.Canvas.Font.Style := [];

  r.Top := r.Top + 30;
  r.Bottom := r.Bottom + 25;
  grdCert.Canvas.TextRect(r, Izdatel,  [tfCenter]);

  validen := Format('валиден от %s  до %s  ', [fromDate, todate] );
  r.Top := r.Top + 18;
  r.Bottom := r.Bottom + 15;
  grdCert.Canvas.TextRect(r, validen,  [tfCenter]);

end;

procedure TfrmCertDlg.LoadStorage(Storage: TElCustomCertStorage);
var
  C, i : integer;
  S : String;
  Cert : TElX509Certificate;
  WithEgn: Boolean;
begin

  C := 0;
  try
    while C < Storage.Count do
    begin
      try
        //Cert := TElX509Certificate.Create(nil);
        try
          if (Storage.Certificates[C].ValidFrom < now) and (Storage.Certificates[C].ValidTo > now)  then
          begin
            //Cert.Assign(Storage.Certificates[C]);
            WithEgn := false;
            for i := 0 to Storage.Certificates[C].SubjectRDN.Count - 1 do
            begin
              if StringOfBytes(Storage.Certificates[C].SubjectRDN.Values[i]).StartsWith('PNOBG-') then
              begin
                WithEgn := True;
                Break;
              end;
            end;
            if WithEgn then
            begin
              S := GetCertDisplayName(Storage.Certificates[C]);
              CellList.AddObject(S, Storage.Certificates[C]);
            end;
          end;
        finally
          Inc(C);
          //cert.Destroy;
        end;

        Application.ProcessMessages;
      except
        on E : Exception do  Application.ShowException(E);
      end;
    end;
  finally
    grdCert.RowCount :=  CellList.Count;
    btnOK.Enabled := CellList.Count > 0;
  end;
end;

procedure TfrmCertDlg.LoadStorageForFindCert(Storage: TElCustomCertStorage; certNom: string);
var
  C, i : integer;
  S : String;
  WithEgn: Boolean;
begin

  C := 0;
  try
    while C < Storage.Count do
    begin
      try
        //Cert := TElX509Certificate.Create(nil);
        try
          if (Storage.Certificates[C].ValidFrom < now) and (Storage.Certificates[C].ValidTo > now)  then
          begin
            //Cert.Assign(Storage.Certificates[C]);
            WithEgn := false;
            for i := 0 to Storage.Certificates[C].SubjectRDN.Count - 1 do
            begin
              if StringOfBytes(Storage.Certificates[C].SubjectRDN.Values[i]).StartsWith('PNOBG-') then
              begin
                WithEgn := True;
                Break;
              end;
            end;
            if WithEgn then
            begin
              S := GetCertDisplayName(Storage.Certificates[C]);
              if certNom = BuildHexString(Storage.Certificates[C].SerialNumber) then
              begin
                CertHipSelect := Storage.Certificates[C];
                Break;
              end;
            end;
          end;
        finally
          Inc(C);
          //cert.Destroy;
        end;

        Application.ProcessMessages;
      except
        on E : Exception do  Application.ShowException(E);
      end;
    end;
  finally
    //grdCert.RowCount :=  CellList.Count;
    //btnOK.Enabled := CellList.Count > 0;
  end;
end;



end.

