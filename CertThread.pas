unit CertThread;
     // coll<
interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  system.Diagnostics, system.TimeSpan, IBX.IBSQL, Aspects.Types,
  Vcl.Forms, Vcl.ExtCtrls, Winapi.Windows, Vcl.Graphics, Vcl.ComCtrls, system.Math,
  System.Generics.Collections, DM, Winapi.ActiveX, system.Variants, VirtualTrees,
  SBxTypes, SBxCertificateStorage, SBX509, SBWinCertStorage,  SBUtils,
  DBCollection.Patient, DBCollection.Pregled, DBCollection.Diagnosis, DBCollection.MedNapr,
  VCLTee.Grid, Tee.Grid.Ticker, Aspects.Collections,
  RealObj.RealHipp, VirtualStringTreeAspect, Table.Unfav, Table.PregledNew, Table.PatientNew,
  Table.Doctor, Table.Certificates, ADB_DataUnit,

  DbHelper, CertHelper
  ;

type


  PDevBroadcastHdr  = ^DEV_BROADCAST_HDR;
  DEV_BROADCAST_HDR = packed record
    dbch_size: DWORD;
    dbch_devicetype: DWORD;
    dbch_reserved: DWORD;
  end;

  PDevBroadcastDeviceInterface  = ^DEV_BROADCAST_DEVICEINTERFACE;
  DEV_BROADCAST_DEVICEINTERFACE = record
    dbcc_size: DWORD;
    dbcc_devicetype: DWORD;
    dbcc_reserved: DWORD;
    dbcc_classguid: TGUID;
    dbcc_name: short;
  end;

const
  GUID_DEVINTERFACE_USB_DEVICE: TGUID = '{A5DCBF10-6530-11D2-901F-00C04FB951ED}';
  DBT_DEVICEARRIVAL          = $8000;          // system detected a new device
  DBT_DEVICEREMOVECOMPLETE   = $8004;          // device is gone
  DBT_DEVTYP_DEVICEINTERFACE = $00000005;      // device interface class

type

  TComponentUSB = class(TComponent)
  private
    FWindowHandle: HWND;
    FOnUSBArrival: TNotifyEvent;
    FOnUSBRemove: TNotifyEvent;
    procedure WndProc(var Msg: TMessage);
    function USBRegister: Boolean;
  protected
    procedure WMDeviceChange(var Msg: TMessage); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property OnUSBArrival: TNotifyEvent read FOnUSBArrival write FOnUSBArrival;
    property OnUSBRemove: TNotifyEvent read FOnUSBRemove write FOnUSBRemove;
  end;

TCertThread = class(TThread)
  private
    FBuf: Pointer;
    FDataPos: Cardinal;
    FBufLink: Pointer;

    CertStorage: TsbxCertificateStorage;
    FOnStorageUpdate: TNotifyEvent;
    FStorageFilename: string;
  protected
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;

    procedure Execute; override;
    procedure DoTerminate; override;

    procedure DoOpenStorage;
    procedure CloseStorage(Save: boolean);
    function FindCertFromPeriod(startDatetime, endDateTime: TDateTime): TElX509Certificate;
    function FindCertFromSerNumber(serNom: TArray<System.Byte>): TElX509Certificate;
  public
    Adb_dm: TADBDataModule;
    LstPlugCardDoctor: TList<Cardinal>;
    IsFirst: Boolean;
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;

    property Buf: Pointer read FBuf write FBuf;
    property BufLink: Pointer read FBufLink write FBufLink;
    property DataPos: Cardinal read FDataPos write FDataPos;
    property OnStorageUpdate: TNotifyEvent read FOnStorageUpdate  write FOnStorageUpdate;
    property StorageFilename: string read FStorageFilename write FStorageFilename;
  end;

implementation


{ TCertThread }

procedure TCertThread.CloseStorage(Save: boolean);
begin
  if CertStorage.Opened then
    CertStorage.Close(Save);

  //lvCerts.Items.Clear;
  //cbSlots.Items.Clear;

 // SetupButtons;
end;

constructor TCertThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  LstPlugCardDoctor := TList<Cardinal>.create;
  CertStorage := TsbxCertificateStorage.Create(nil);
  CertStorage.RuntimeLicense := '5342444641444E585246323032313132303443344D393232353000000000000000000000000000005A5036484E353744000038554650524E4839314636410000';
end;

destructor TCertThread.Destroy;
begin
  //FreeAndNil(usb);
  FreeAndNil(CertStorage);
  FreeAndNil(LstPlugCardDoctor);
  inherited;
end;

procedure TCertThread.DoOpenStorage;
var

  SlotCount, i, j, k, m: Integer;
  TokenPresent: Boolean;
  satrtTime, endTime: TDateTime;
  LstToken: TList<Integer>;
  egn: string;
  ArrRdn: TArray<string>;
  Cert: TRealCertificatesItem;
  fs: TFormatSettings;

begin
  CloseStorage(false);
  LstToken := TList<Integer>.Create;
  try

    CertStorage.Open('pkcs11:///' + FStorageFilename + '?slot=-1');

    SlotCount := StrToIntDef(CertStorage.Config('PKCS11SlotCount'), 0);
    for i := 0 to SlotCount - 1 do
    begin
      if Uppercase(CertStorage.Config('PKCS11SlotTokenPresent[' + IntToStr(i) + ']')) = 'TRUE' then
      begin
        TokenPresent := true;
        LstToken.Add(i);
      end
      else
        TokenPresent := false;

    end;

    for k := 0 to Adb_dm.CollDoctor.Count - 1 do
    begin
      Adb_dm.CollDoctor.Items[k].TokenIsPlug := False;
    end;
    LstPlugCardDoctor.Clear;

    for i := 0 to LstToken.Count - 1 do // обикаля вмъкнатите токени
    begin
      CloseStorage(false);
      CertStorage.Open ( Format('pkcs11:///%s?slot=%d&readonly=1&login=0', [FStorageFilename, LstToken[i]]));
      if CertStorage.Certificates.Count = 0 then
        Continue;
      CertStorage.Certificates[0].SerialNumber;
      CertStorage.Certificates[0].SubjectRDN;
      ArrRdn := CertStorage.Certificates[0].SubjectRDN.Split(['/']);

      for j := 0 to Length(ArrRdn) - 1 do
      begin
        if ArrRdn[j].StartsWith('SN=PNOBG-') then
        begin
          egn := Copy(ArrRdn[j], 10, 100);// намира егн-то на подписа (доктор или какъвто и да е)
          for k := 0 to Adb_dm.CollDoctor.Count - 1 do
          begin
            if (Adb_dm.CollDoctor.getAnsiStringMap(Adb_dm.CollDoctor.Items[k].DataPos, word(Doctor_EGN)) = egn)  then
            begin
              Adb_dm.CollDoctor.Items[k].SlotTokenSerial := CertStorage.Config('PKCS11SlotTokenSerial[' + IntToStr(LstToken[i]) + ']' );;
              Adb_dm.CollDoctor.Items[k].TokenIsPlug := True;
              Adb_dm.CollDoctor.Items[k].Cert := FindCertFromSerNumber(CertStorage.Certificates[0].SerialNumber);
              Adb_dm.CollDoctor.Items[k].SlotNom := LstToken[i];
              Adb_dm.CollDoctor.Items[k].CertPlug := CertStorage.Certificates[0];
              Cert := nil;
              for m := 0 to Adb_dm.CollCertificates.Count - 1 do
              begin
                if Trim(Adb_dm.CollCertificates.getAnsiStringMap(Adb_dm.CollCertificates.Items[m].DataPos, word(Certificates_CERT_ID))) =
                              BuildHexString1(CertStorage.Certificates.item[0].SerialNumber) then
                begin
                  fs.DateSeparator := '-';
                  fs.TimeSeparator := ':';
                  fs.ShortDateFormat := 'YYYY-MM-DD';
                  fs.LongTimeFormat := 'hh:nn:ss';

                  satrtTime := StrToDateTime(CertStorage.Certificates[0].ValidFrom, fs);
                  endTime := StrToDateTime(CertStorage.Certificates[0].ValidTo, fs);
                  Adb_dm.CollCertificates.SetIntMap(Adb_dm.CollCertificates.Items[m].DataPos, word(Certificates_SlotNom), LstToken[i]);
                  Adb_dm.CollCertificates.SetAnsiStringMap(Adb_dm.CollCertificates.Items[m].DataPos, word(Certificates_SLOT_ID), Adb_dm.CollDoctor.Items[k].SlotTokenSerial.PadRight(100, ' '));
                  Adb_dm.CollCertificates.SetDateMap(Adb_dm.CollCertificates.Items[m].DataPos, word(Certificates_VALID_FROM_DATE), satrtTime);
                  Adb_dm.CollCertificates.SetDateMap(Adb_dm.CollCertificates.Items[m].DataPos, word(Certificates_VALID_TO_DATE), endTime);

                  Cert := Adb_dm.CollCertificates.Items[m];
                  Break;
                end;
              end;
              if Cert = nil then
              begin
                fs.DateSeparator := '-';
                fs.TimeSeparator := ':';
                fs.ShortDateFormat := 'YYYY-MM-DD';
                fs.LongTimeFormat := 'hh:nn:ss';

                satrtTime := StrToDateTime(CertStorage.Certificates[0].ValidFrom, fs);
                endTime := StrToDateTime(CertStorage.Certificates[0].ValidTo, fs);
                Cert := TRealCertificatesItem(Adb_dm.CollCertificates.Add);
                New(Cert.PRecord);
                Cert.PRecord.setProp := [Certificates_SLOT_ID, Certificates_CERT_ID, Certificates_VALID_FROM_DATE,
                                         Certificates_VALID_TO_DATE, Certificates_SlotNom, Certificates_Pin];
                Cert.PRecord.CERT_ID := BuildHexString1(CertStorage.Certificates[0].SerialNumber).PadRight(100, ' ');;
                Cert.PRecord.SLOT_ID := Adb_dm.CollDoctor.Items[k].SlotTokenSerial.PadRight(100, ' ');
                Cert.PRecord.VALID_FROM_DATE :=  satrtTime;
                Cert.PRecord.VALID_TO_DATE :=  endTime;
                Cert.PRecord.SlotNom :=  LstToken[i];
                Cert.PRecord.Pin :=  ''.PadRight(20, ' ');

                Cert.InsertCertificates;
                Dispose(Cert.PRecord);
                Cert.PRecord := nil;
              end
              else
              begin
                Cert.CertPlug := CertStorage.Certificates[0];

              end;

              LstPlugCardDoctor.Add(Adb_dm.CollDoctor.Items[k].DataPos);
            end;
          end;

          Break;
        end;
      end;
    end;
    if Assigned(FOnStorageUpdate) then
      FOnStorageUpdate(Self);

  except
    on E : Exception do
    begin
      CloseStorage(false);
      //MessageDlg('Error opening storage: ' + StorageFilename + #13#10 + E.Message,  mtError, [mbOk], 0);
      Exit;
    end;
  end;
  LstToken.Free;
end;

procedure TCertThread.DoTerminate;
begin
  inherited;

end;

procedure TCertThread.Execute;
var
  comInitStatus: THandle;
  b: Boolean;

begin
  ReturnValue := 0;
  IsFirst := True;
  comInitStatus := S_FALSE;
  try
    comInitStatus := CoInitializeEx(nil, COINIT_MULTITHREADED);
    inherited;
    while  not Terminated do
    begin
      if IsFirst then
      begin
        IsFirst := False;
        DoOpenStorage;
      end;
      Sleep(50);
    end;
  finally
    case comInitStatus of
      S_OK, S_FALSE: CoUninitialize;
    end;
  end;
end;

function TCertThread.FindCertFromPeriod(startDatetime,
  endDateTime: TDateTime): TElX509Certificate;
var
  WinStorage : TElWinCertStorage;
  Cert: TElX509Certificate;
  CntCert, i, j : integer;
  StrTemp, docEgn, certEgn : String;
  WithEgn: Boolean;
  doc: TRealDoctorItem;
  posdata: Cardinal;
  data: PAspRec;
  isEqu: Boolean;
begin
  Result := nil;
  WinStorage := TElWinCertStorage.Create(nil);
  WinStorage.RuntimeLicense  := '5342444641444E585246323032313132303443344D393232353000000000000000000000000000005A5036484E353744000038554650524E4839314636410000';
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
            if abs(Cert.ValidFrom - startDatetime) > 1/24/60/60 then Continue;
            if abs(Cert.ValidTo - endDateTime) > 1/24/60/60 then Continue;

            cert.Clone(Result);
            cert.Clone(Result);
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

function TCertThread.FindCertFromSerNumber(
  serNom: TArray<System.Byte>): TElX509Certificate;
var
  WinStorage : TElWinCertStorage;
  Cert: TElX509Certificate;
  CntCert, i, j : integer;
  StrTemp, docEgn, certEgn : String;
  WithEgn: Boolean;
  doc: TRealDoctorItem;
  posdata: Cardinal;
  data: PAspRec;
  isEqu: Boolean;
begin
  Result := nil;
  WinStorage := TElWinCertStorage.Create(nil);

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
             Result := TElX509Certificate.Create(nil);
             cert.Clone(result);
            Break;
          end;
        finally
          Inc(CntCert);
        end;
      except
        on E : Exception do  Application.ShowException(E);
      end;
    end;
  finally

  end;
  WinStorage.Free;
end;

{ TComponentUSB }

constructor TComponentUSB.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWindowHandle := AllocateHWnd(WndProc);
  USBRegister;
end;

destructor TComponentUSB.Destroy;
begin
  DeallocateHWnd(FWindowHandle);
  inherited Destroy;
end;

procedure TComponentUSB.WndProc(var Msg: TMessage);
begin
  if (Msg.Msg = WM_DEVICECHANGE) then
  begin
    try
      WMDeviceChange(Msg);
    except
      Application.HandleException(Self);
    end;
  end
  else
    Msg.Result := DefWindowProc(FWindowHandle, Msg.Msg, Msg.wParam, Msg.lParam);
end;

procedure TComponentUSB.WMDeviceChange(var Msg: TMessage);
var
  devType: Integer;
  Datos: PDevBroadcastHdr;
begin
  if (Msg.wParam = DBT_DEVICEARRIVAL) or (Msg.wParam = DBT_DEVICEREMOVECOMPLETE) then
  begin
    Msg.result := 1;
    Application.ProcessMessages;
    Datos := PDevBroadcastHdr(Msg.lParam);
    devType := Datos^.dbch_devicetype;
    if devType = DBT_DEVTYP_DEVICEINTERFACE then
    begin // USB Device
      if Msg.wParam = DBT_DEVICEARRIVAL then
      begin
        if Assigned(FOnUSBArrival) then
          FOnUSBArrival(Self);
      end
      else
      begin
        if Assigned(FOnUSBRemove) then
          FOnUSBRemove(Self);
      end;
    end;
  end;
end;

function TComponentUSB.USBRegister: Boolean;
var
  dbi: DEV_BROADCAST_DEVICEINTERFACE;
  Size: Integer;
  r: Pointer;
begin
  Result := False;
  Size := SizeOf(DEV_BROADCAST_DEVICEINTERFACE);
  ZeroMemory(@dbi, Size);
  dbi.dbcc_size := Size;
  dbi.dbcc_devicetype := DBT_DEVTYP_DEVICEINTERFACE;
  dbi.dbcc_reserved := 0;
  dbi.dbcc_classguid  := GUID_DEVINTERFACE_USB_DEVICE;
  dbi.dbcc_name := 0;

  r := RegisterDeviceNotification(FWindowHandle, @dbi,
    DEVICE_NOTIFY_WINDOW_HANDLE
    );
  if Assigned(r) then Result := True;
end;

end.

