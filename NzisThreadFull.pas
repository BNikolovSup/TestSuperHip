unit NzisThreadFull;

interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  system.Diagnostics, system.TimeSpan, Aspects.Types, Aspects.Collections, Vcl.Dialogs,
  Vcl.Forms, Vcl.ExtCtrls, Winapi.Windows, Vcl.Graphics, Vcl.ComCtrls, system.Math, system.DateUtils,
  System.Generics.Collections, DM, Winapi.ActiveX, system.Variants, VirtualTrees,
  ADB_DataUnit, RealObj.RealHipp, CertHelper,
  Table.PregledNew, Table.NzisToken, Table.Doctor,
  //Nzis
  Xml.XMLDoc,
  msgX002, X004, X006, X010, X014,
  //sbx
  SBXMLSec, SBXMLSig, SBXMLEnc,
  SBXMLCore, SBTypes, SBXMLDefs, SBX509,   SBXMLUtils, SBWinCertStorage, SBUtils,
  SBBaseClasses, SBSocketClient, SBSocket, sbxcore,
  SBSimpleSSL, SBHTTPSClient, SBPKCS11Base, SBCustomCertStorage, SBConstants,
  SBPKCS11CertStorage, SBCertValidator, SBSSLCommon,SBLists,
  SBXMLAdESIntf, SBStrUtils, SBSSLConstants, SBHTTPSConstants
  ;

type
  TErrCodeNzis = (ecnNone, ecnKepUnknown);

  TOnError = procedure(sender: TObject; errCode: TErrCodeNzis) of object;

TNzisThread = class(TThread)
  private
    FIsTestNZIS: Boolean;
    FNomenID: string;
    FOnSended: TNotifyEvent;
    FNode: PVirtualNode;
    IsOwnStream: Boolean;
    FStreamData: TMemoryStream;
    FHndSuperHip: THandle;
    FMsgType: TNzisMsgType;
    FGuId: TGUID;
    FToken: string;
    FCurrentCert: TelX509Certificate;
    FIsPKCS11: Boolean;
    FOnError: TOnError;
    procedure SetNomenID(const Value: string);
  protected
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;


    //hipSB: TSBX_HIP;
    httpNZIS: TElHTTPSClient;
    InXmlStream: TStringStream;


    Dm_adb: TADBDataModule;
    XMLStreamC001: TStringStream;
    XmlStream: TXmlStream;
    procedure Execute; override;
    procedure DoTerminate; override;
    procedure ReadToken();
    //procedure prepareHeaders(Sender: TObject; Headers: TStringList);
    procedure OnDataNzis(Sender: TObject; Buffer: Pointer; Size: Integer);
    procedure httpNZISCertificateNeededEx(Sender: TObject;
      var Certificate: TElX509Certificate);
  procedure httpNZISCertificateValidate(Sender: TObject;
      X509Certificate: TElX509Certificate; var Validity: TSBCertificateValidity;
      var Reason: TSBCertificateValidityReason);
  procedure httpNZISPreparedHeaders(Sender: TObject; Headers: TElStringList);virtual;

  procedure SignNzis;
  procedure FormatText(Sender: TObject; var Text: XMLString;
            TextType: TElXMLTextType; Level: Integer; const Path: XMLString);
  procedure PostNrnToPreg(streamX002: TStream);
  procedure PostNrnToPregOprawia(streamX006: TStream);
  procedure PostCloseStatusToPreg(streamX004: TStream);
  procedure PostEditStatusToPreg(streamX010: TStream);
  procedure PostOfLineStatusToPreg(streamX014: TStream);
  procedure FillCertInDoctors;
  procedure InitCertToken;
  procedure CheckStreamDataType;
public
    indexInListSended: Integer;
    constructor Create(CreateSuspended: Boolean; dm: TADBDataModule = nil);
    destructor Destroy; override;

    property IsTestNZIS: Boolean read FIsTestNZIS write FIsTestNZIS;
    property NomenID: string read FNomenID write FNomenID;
    property OnSended: TNotifyEvent read FOnSended write FOnSended;
    property Node: PVirtualNode read FNode write Fnode;
    property StreamData: TMemoryStream read FStreamData write FStreamData;
    property HndSuperHip: THandle read FHndSuperHip write FHndSuperHip;
    property MsgType: TNzisMsgType read FMsgType write FMsgType;
    property GuId: TGUID read FGuId write FGuId;
    property token: string read FToken write FToken;
    property CurrentCert: TelX509Certificate read FCurrentCert write FCurrentCert;
    property IsPKCS11: Boolean read FIsPKCS11 write FIsPKCS11;
    property OnError: TOnError read FOnError write FOnError;

  end;

implementation

{ TNzisThread }

procedure TNzisThread.SignNzis;
var
  Signer : TElXMLSigner;
  SignatureNode, NzisSign : TElXMLDOMNode;
  Ref : TElXMLReference;
  refNum: Integer;
  X509KeyData: TElXMLKeyInfoX509Data;
  stream: TStringStream;
  FXMLDocument: TElXMLDOMDocument;
  ls: TStringList;
begin
  InXmlStream.Clear;
  SignatureNode := nil;
  Signer := TElXMLSigner.Create(nil);
  FXMLDocument := TElXMLDOMDocument.Create;
  Self.XmlStream.Position := 0;

  ls:= TStringList.Create;
  ls.LoadFromStream(self.XmlStream, TEncoding.UTF8);
  stream := TStringStream.Create(ls.Text, TEncoding.UTF8);


  try
    Signer.References.Clear;
    stream.Position := 0;
    FXMLDocument.LoadFromStream(stream, 'utf-8', true);
    Signer.SignatureType := xstEnveloped;
    Signer.CanonicalizationMethod := xcmCanon;
    Signer.SignatureMethodType := xmtSig;
    Signer.SignatureMethod := xsmRSA_SHA256;
    Signer.MACMethod := xmmHMAC_SHA1;

    SignatureNode := FXMLDocument.FindNode('nhis:message', true);


    refNum := Signer.References.Add();
    Signer.References[refNum].DigestMethod := xdmSHA256;
    Signer.References[refNum].URINode := SignatureNode;
    Signer.References[refNum].URI := '';
    //UpdateCertificates(edtCertNom.Text);

    X509KeyData := TElXMLKeyInfoX509Data.Create(False);
    X509KeyData.IncludeKeyValue := true;
    X509KeyData.IncludeDataParams := [xkidX509Certificate];
    X509KeyData.Certificate := CurrentCert;

    Signer.KeyData := X509KeyData;
    Signer.OnFormatText := FormatText;
    Signer.References[0].TransformChain.AddEnvelopedSignatureTransform;
    Signer.UpdateReferencesDigest;
    Signer.GenerateSignature;
    Signer.Signature.SignaturePrefix := '';
    try
      Signer.Save(SignatureNode);
    except
      Exit;
    end;

    InXmlStream.Position := 0;
    //mmoInXml.Text := FXMLDocument.InnerXML;
    FXMLDocument.SaveToStream(InXmlStream);
    InXmlStream.Position := 0;
    //mmoTest.Lines.LoadFromStream(InXmlStream);
    //InXmlStream.Position := 0;
    //ResultNzisSsiger.LoadFromStream(InXmlStream);

  finally
    if Signer.KeyData <> nil then
      Signer.KeyData.Free;

    FreeAndNil(Signer);
  end;
end;

procedure TNzisThread.CheckStreamDataType;
var
  ls: TStringList;
begin
  FStreamData.Position := 0;
  ls := TStringList.Create;
  ls.LoadFromStream(FStreamData);
  ls.Free;

end;

constructor TNzisThread.Create(CreateSuspended: Boolean; dm: TADBDataModule);
begin
  inherited Create(CreateSuspended);
  XMLStream := TXmlStream.Create('', TEncoding.UTF8);
  IsPKCS11 := False;
  if dm = nil then
  begin
    Dm_adb := TADBDataModule.Create;
  end
  else
  begin
    Dm_adb := dm;
  end;
  indexInListSended := -1;
end;

destructor TNzisThread.Destroy;
begin
  FreeAndNil(InXmlStream);
  FreeAndNil(XmlStream);
  if IsOwnStream then
    FreeAndNil(FStreamData);
  inherited;
end;

procedure TNzisThread.DoTerminate;
begin
  inherited;

end;

procedure TNzisThread.Execute;
var
  comInitStatus: THandle;
  url: string;
  PregledNodes: TPregledNodes;
begin
  comInitStatus := S_FALSE;
  try
    comInitStatus := CoInitializeEx(nil, COINIT_MULTITHREADED);

    inherited;
   // Sleep(10000);
    try
      InXmlStream := TStringStream.Create;
      if FStreamData = nil then
      begin
        FStreamData := TMemoryStream.Create;
        IsOwnStream := True;
      end
      else
        IsOwnStream := False;

      httpNZIS := TElHTTPSClient.Create(nil);

      httpNZIS.Name := 'httpNZIS';
      httpNZIS.SocketTimeout := 60000;
      httpNZIS.LocalPort := 0;
      httpNZIS.IncomingSpeedLimit := 0;
      httpNZIS.OutgoingSpeedLimit := 0;
      httpNZIS.SocksAuthentication := saNoAuthentication;
      httpNZIS.WebTunnelPort := 3128;
      httpNZIS.OnCertificateNeededEx := httpNZISCertificateNeededEx;
      httpNZIS.OnCertificateValidate := httpNZISCertificateValidate;
      httpNZIS.Versions := [sbTLS1, sbTLS11, sbTLS12];
      httpNZIS.UseExtendedMasterSecret := False;
      httpNZIS.SSLOptions := [ssloAutoAddServerNameExtension];
      httpNZIS.UseSSLSessionResumption := False;
      httpNZIS.ForceResumeIfDestinationChanges := False;
      httpNZIS.RenegotiationAttackPreventionMode := rapmAuto;
      httpNZIS.AutoValidateCertificates := False;
      httpNZIS.SSLEnabled := False;
      httpNZIS.RequestCompressionLevel := 0;
      httpNZIS.RequestCompressionGZip := False;
      httpNZIS.KeepAlivePolicy := kapStandardDefined;
      httpNZIS.HTTPVersion := hvHTTP11;
      httpNZIS.UseNTLMAuth := False;
      httpNZIS.UseDigestAuth := False;
      httpNZIS.PersistentAuthHeader := True;
      httpNZIS.ForceNTLMAuth := False;
      httpNZIS.Use100Continue := False;
      httpNZIS.HTTPProxyPort := 3128;
      httpNZIS.HTTPProxyAuthentication := wtaNoAuthentication;
      httpNZIS.UseHTTPProxy := False;
      httpNZIS.IgnoreUnknownTransferEncodings := False;
      httpNZIS.AllowHashSignInURL := False;
      httpNZIS.OnPreparedHeaders := httpNZISPreparedHeaders;
      httpNZIS.SuppressRedirectionContent := False;
      //httpNZIS.DNS.Servers.Add('8.8.8.8');

      httpNZIS.OnData := OnDataNzis;
      //httpNZIS.onre
      httpNZIS.RuntimeLicense  := '5342444641444E585246323032313132303443344D393232353000000000000000000000000000005A5036484E353744000038554650524E4839314636410000';
      FGuId := TGuid.NewGuid;
      case FMsgType of
        NNNN: //token
        begin
          httpNZIS.Close();
          httpNZIS.Get('https://auth.his.bg/token');
          ReadToken();
        end;
        C001:
        begin
          httpNZIS.Close();
          url := Dm_adb.GetURLFromMsgType(FMsgType, true);

          Dm_adb.FillXmlStreamC001(self.XmlStream, FNomenID);
          httpNZIS.Post(url, self.XmlStream, false);
          FStreamData.Position := 0;
          if FNode <> nil then
            FNode.Dummy := 77;
          PostMessage(FHndSuperHip, WM_USER + 500, nativeint(FNode), StrToInt(Copy(FNomenID, 3, 3)));
          Sleep(1);
        end;
        L009:
        begin
          httpNZIS.Close();
          url := Dm_adb.GetURLFromMsgType(FMsgType, true);
          Dm_adb.FillXmlStreamL009Preg(Self.XmlStream, Node, indexInListSended, PregledNodes);// преглед

          InitCertToken;
          FStreamData.Size := 0;
          SignNzis;
          httpNZIS.Post(url, InXmlStream, false);
          FStreamData.Position := 0;
          Dm_adb.ReadXmlL010PregTest(FStreamData, PregledNodes);
          PostMessage(FHndSuperHip, WM_USER + 502, nativeint(FNode), 0);

          Dm_adb.FormatingXML(FStreamData);
          FStreamData.Position := 0;
          Dm_adb.LstNodeSended[indexInListSended].XmlResp.LoadFromStream(FStreamData, TEncoding.UTF8);
        end;

        X001:
        begin
          //Sleep(3000);
          httpNZIS.Close();
          url := Dm_adb.GetURLFromMsgType(FMsgType, FIsTestNZIS);
          Dm_adb.strGuid := Copy(FGuId.ToString, 1, 36);
          Dm_adb.FillXmlStreamX001(Self.XmlStream, Node, indexInListSended);

          InitCertToken;
          FStreamData.Size := 0;
          SignNzis;
          httpNZIS.Post(url, InXmlStream, false);
          PostNrnToPreg(FStreamData);

          //FStreamData.Position := 0;
          Dm_adb.FormatingXML(FStreamData);
          FStreamData.Position := 0;
          Dm_adb.LstNodeSended[indexInListSended].XmlResp.LoadFromStream(FStreamData, TEncoding.UTF8);

        end;

        X003:
        begin
          httpNZIS.Close();
          url := Dm_adb.GetURLFromMsgType(FMsgType, FIsTestNZIS);
          Dm_adb.strGuid := Copy(FGuId.ToString, 1, 36);
          Dm_adb.FillXmlStreamX003(Self.XmlStream, Node, indexInListSended);

          InitCertToken;
          FStreamData.Size := 0;
          SignNzis;
          httpNZIS.Post(url, InXmlStream, false);
          FStreamData.Position := 0;
          PostCloseStatusToPreg(FStreamData);

          Dm_adb.FormatingXML(FStreamData);
          FStreamData.Position := 0;
          Dm_adb.LstNodeSended[indexInListSended].XmlResp.LoadFromStream(FStreamData, TEncoding.UTF8);
        end;
        X009:
        begin
          httpNZIS.Close();
          url := Dm_adb.GetURLFromMsgType(FMsgType, FIsTestNZIS);
          Dm_adb.strGuid := Copy(FGuId.ToString, 1, 36);

          Dm_adb.FillXmlStreamX009(Self.XmlStream, Node, indexInListSended);
          InitCertToken;
          FStreamData.Size := 0;

          SignNzis;
          httpNZIS.Post(url, InXmlStream, false);
          CheckStreamDataType;
          FStreamData.Position := 0;
          //Sleep(10000);
          PostEditStatusToPreg(FStreamData);
          Dm_adb.FormatingXML(FStreamData);
          FStreamData.Position := 0;
          Dm_adb.LstNodeSended[indexInListSended].XmlResp.LoadFromStream(FStreamData, TEncoding.UTF8);
        end;
        X013:
        begin
          //Sleep(10000);
          httpNZIS.Close();
          url := Dm_adb.GetURLFromMsgType(FMsgType, FIsTestNZIS);
          Dm_adb.strGuid := Copy(FGuId.ToString, 1, 36);

          Dm_adb.FillXmlStreamX013(Self.XmlStream, Node);

          SignNzis;
          httpNZIS.Post(url, InXmlStream, false);
          FStreamData.Position := 0;
          //Sleep(10000);
          PostOfLineStatusToPreg(FStreamData);
        end;
      end;
      Sleep(20);
    except
      //Self.Execute;

      Exit;
    end;
  finally
    case comInitStatus of
      S_OK, S_FALSE: CoUninitialize;
    end;
  end;
end;

procedure TNzisThread.FillCertInDoctors;
var
  WinStorage : TElWinCertStorage;
  Cert: TElX509Certificate;
  CntCert, i, j : integer;
  StrTemp, docEgn, certEgn : String;
  WithEgn: Boolean;
  doc: TRealDoctorItem;
  buf: Pointer;
  posdata: Cardinal;
  data: PAspRec;
begin
  WinStorage := TElWinCertStorage.Create(nil);
 // buf := AspectsHipFile.Buf;
 // posdata := AspectsHipFile.FPosData;

  WinStorage.SystemStores.Add('MY');
  CntCert := 0;
  try
    while CntCert < WinStorage.Count do
    begin
      try
        try
          if (WinStorage.Certificates[CntCert].ValidFrom < now) and (WinStorage.Certificates[CntCert].ValidTo > now)  then
          begin
            WithEgn := false;
            for i := 0 to WinStorage.Certificates[CntCert].SubjectRDN.Count - 1 do
            begin
              Cert := WinStorage.Certificates[CntCert];
              StrTemp := StringOfBytes(cert.SubjectRDN.Values[i]);
              if StrTemp.StartsWith('PNOBG-') then
              begin
                certEgn := Copy(StrTemp, 7, 10);
                for j := 0 to Dm_adb.CollDoctor.Count - 1 do
                begin
                  doc := Dm_adb.CollDoctor.Items[j];
                  docEgn := Dm_adb.CollDoctor.getAnsiStringMap(doc.DataPos, word(Doctor_EGN));
                  if docEgn = certEgn then
                  begin
                    doc.Cert := TElX509Certificate.Create(nil);
                    Cert.Clone(doc.Cert);
                    //v := vtrDoctor.AddChild(doc.node, nil);
//                    data := vtrDoctor.GetNodeData(v);
//                    data.DataPos := 0;
//                    data.index := 0;
//                    data.vid := vvCert;
//                    vtrDoctor.Expanded[doc.node] := True;
                  end;
                end;
                WithEgn := True;
                //Break;
              end;
            end;
          end;
        finally
          Inc(CntCert);
        end;
        Application.ProcessMessages;
      except
        on E : Exception do  Application.ShowException(E);
      end;
    end;
  finally

  end;
  WinStorage.Free;
end;

procedure TNzisThread.FormatText(Sender: TObject; var Text: XMLString;
  TextType: TElXMLTextType; Level: Integer; const Path: XMLString);
var
  s: XMLString;
  i: Integer;
begin
  if (TextType = ttBase64) and (Length(Text) > 64) then
  begin
    s := #10;
    while Length(Text) > 0 do
    begin
      s := s + Copy(Text, 1, 64) + #10;
      Delete(Text, 1, 64);
    end;

    for i := 0 to Level - 3 do
      s := s + #9;

    Text := s;
  end;
end;

procedure TNzisThread.httpNZISCertificateNeededEx(Sender: TObject;
  var Certificate: TElX509Certificate);
begin
  if Certificate <> CurrentCert then
  begin
    Certificate := CurrentCert;
    CurrentCert := nil;
  end ;
end;

procedure TNzisThread.httpNZISCertificateValidate(Sender: TObject;
  X509Certificate: TElX509Certificate; var Validity: TSBCertificateValidity;
  var Reason: TSBCertificateValidityReason);
begin
  Validity := TSBCertificateValidity.cvOk;
end;

procedure TNzisThread.httpNZISPreparedHeaders(Sender: TObject;
  Headers: TElStringList);
begin
  if FToken <> '' then
  begin
    Headers.Add('Authorization: Bearer ' +  Token);
  end;
  Headers.Add('Content-Type: application/xml');
end;

procedure TNzisThread.InitCertToken;
var
  i: Integer;
  TokenCertId: string;
  EndDateTime: TDateTime;
begin
  FStreamData.Size := 0;
  CurrentCert := TelX509Certificate.Create(nil);
  if TRealDoctorItem(Self.XmlStream.performer).Cert <> nil then
  begin
    TRealDoctorItem(Self.XmlStream.performer).Cert.Clone(CurrentCert);
  end
  else
  begin
    FillCertInDoctors;
    TRealDoctorItem(Self.XmlStream.performer).Cert.Clone(CurrentCert);
  end;
  if CurrentCert = nil then
  begin
    if Assigned(FOnError) then
      FOnError(Self, ecnKepUnknown);
    //ShowMessage('Проверете подписа');
    Exit;
  end
  else
  begin
    FStreamData.Size := 0;

    for  i := 0 to Dm_adb.CollNzisToken.Count - 1 do
    begin
      TokenCertId := Trim(Dm_adb.CollNzisToken.getAnsiStringMap(Dm_adb.CollNzisToken.Items[i].DataPos, word(NzisToken_CertID)));
      if TokenCertId = BuildHexString(CurrentCert.SerialNumber) then
      begin
        EndDateTime := Dm_adb.CollNzisToken.getDateMap(Dm_adb.CollNzisToken.Items[i].DataPos, word(NzisToken_ToDatTime));
        if (EndDateTime - Now) < (1/24/12) then //5 min
          Continue;
        FToken := Trim(Dm_adb.CollNzisToken.getAnsiStringMap(Dm_adb.CollNzisToken.Items[i].DataPos, word(NzisToken_Bearer)));
        Exit;
      end;

    end;
  end;

  httpNZIS.Close();
  httpNZIS.Get('https://auth.his.bg/token'); // zzzzzzzzzzzzzz трябва да направя тука нещо да гръмне и да прекрати действието
  CurrentCert := TelX509Certificate.Create(nil);
  TRealDoctorItem(Self.XmlStream.performer).Cert.Clone(CurrentCert);
  ReadToken();
end;

procedure TNzisThread.OnDataNzis(Sender: TObject; Buffer: Pointer; Size: Integer);
begin
  FStreamData.Write(Buffer, Size);
end;

procedure TNzisThread.PostCloseStatusToPreg(streamX004: TStream);
var
  data: PAspRec;
  NRN, lrn: AnsiString;
  NzisStatus: word;
  AX004: X004.IXMLMessageType;
  xmlDoc: TXMLDocument;
begin
  xmlDoc := TXMLDocument.Create(nil);

  streamX004.Position := 0;
  xmlDoc.XML.LoadFromStream(streamX004, tencoding.UTF8);
  AX004 := X004.Getmessage(xmlDoc);
  if AX004.Header.MessageType.Value = 'X004' then
  begin
    NRN := AX004.Contents.NrnExamination.Value;
    NzisStatus := AX004.Contents.Status.Value;

    data := Pointer(PByte(FNode) + lenNode);
    Dm_adb.CollPregled.SetwordMap(data.DataPos, Word(PregledNew_NZIS_STATUS), 6); //затворен
    //lrn := Copy(PregColl.GetAnsiStringMap(data.DataPos, Word(PregledNew_NRN)), 13, 36);
    //PregColl.SetAnsiStringMap(data.DataPos, Word(PregledNew_NRN), NRN + lrn);
    PostMessage(FHndSuperHip, WM_USER + 501, nativeint(FNode), 0);//  нула значи ОК

  end
  else
  begin
    data := Pointer(PByte(FNode) + lenNode);
    Dm_adb.CollPregled.SetwordMap(data.DataPos, Word(PregledNew_NZIS_STATUS), 9); //грешка
    ShowMessage((AX004.Contents.XML));
    //lrn := Copy(PregColl.GetAnsiStringMap(data.DataPos, Word(PregledNew_NRN)), 13, 36);
    //PregColl.SetAnsiStringMap(data.DataPos, Word(PregledNew_NRN), NRN + lrn);
    PostMessage(FHndSuperHip, WM_USER + 501, nativeint(FNode), 2);//  1 - грешка при затваряне
  end;


end;

procedure TNzisThread.PostEditStatusToPreg(streamX010: TStream);
var
  data: PAspRec;
  NRN, lrn: AnsiString;
  NzisStatus: word;
  AX010: X010.IXMLMessageType;
  xmlDoc: TXMLDocument;
begin
  xmlDoc := TXMLDocument.Create(nil);

  streamX010.Position := 0;
  xmlDoc.XML.LoadFromStream(streamX010, tencoding.UTF8);
  AX010 := X010.Getmessage(xmlDoc);
  if AX010.Header.MessageType.Value = 'X010' then
  begin
    NRN := AX010.Contents.NrnExamination.Value;
    NzisStatus := AX010.Contents.Status.Value;

    data := Pointer(PByte(FNode) + lenNode);
    Dm_adb.CollPregled.SetwordMap(data.DataPos, Word(PregledNew_NZIS_STATUS), 10); //редактиран
    PostMessage(FHndSuperHip, WM_USER + 501, nativeint(FNode), 0);//  нула значи ОК
  end
  else
  begin
    data := Pointer(PByte(FNode) + lenNode);
    Dm_adb.CollPregled.SetwordMap(data.DataPos, Word(PregledNew_NZIS_STATUS), 11); //грешка
    ShowMessage((AX010.Contents.XML));
    PostMessage(FHndSuperHip, WM_USER + 501, nativeint(FNode), 3);//  1 - грешка при редактиране
  end;
end;

procedure TNzisThread.PostNrnToPreg(streamX002: TStream);
var
  data: PAspRec;
  NRN, lrn: AnsiString;
  NzisStatus: word;
  AX002: msgX002.IXMLMessageType;
  xmlDoc: TXMLDocument;
  str, url: string;
begin
  xmlDoc := TXMLDocument.Create(nil);

  streamX002.Position := 0;
  xmlDoc.XML.LoadFromStream(streamX002, tencoding.UTF8);
  AX002 := msgX002.Getmessage(xmlDoc);
  if AX002.Header.MessageType.Value = 'X002' then
  begin
    NRN := AX002.Contents.NrnExamination.Value;
    NzisStatus := AX002.Contents.Status.Value;

    data := Pointer(PByte(FNode) + lenNode);
    Dm_adb.CollPregled.SetwordMap(data.DataPos, Word(PregledNew_NZIS_STATUS), 5); //otworen
    lrn := Copy(Dm_adb.CollPregled.GetAnsiStringMap(data.DataPos, Word(PregledNew_NRN_LRN)), 13, 36);
    Dm_adb.CollPregled.SetAnsiStringMap(data.DataPos, Word(PregledNew_NRN_LRN), NRN + lrn);
    PostMessage(FHndSuperHip, WM_USER + 501, nativeint(FNode), 0);//  нула значи ОК

  end
  else
  begin
    data := Pointer(PByte(FNode) + lenNode);
    Dm_adb.CollPregled.SetwordMap(data.DataPos, Word(PregledNew_NZIS_STATUS), 4); //грешка



    if AX002.Contents.XML.Contains('Вече има подаден преглед с този номер') then // оправия
    begin
      url := Dm_adb.GetURLFromMsgType(X005, FIsTestNZIS);
      Dm_adb.FillXmlStreamX005(Self.XmlStream, Node);//, indexInListSended);
      SignNzis;
      FStreamData.Size := 0;
      httpNZIS.Close();
      httpNZIS.Post(url, InXmlStream, false);
      PostNrnToPregOprawia(FStreamData);
      exit;
    end;
    ShowMessage((AX002.Contents.XML));
    PostMessage(FHndSuperHip, WM_USER + 501, nativeint(FNode), 1);//  1 - грешка при отваряне
  end;


end;

procedure TNzisThread.PostNrnToPregOprawia(streamX006: TStream);
var
  data: PAspRec;
  NRN, lrn: AnsiString;
  NzisStatus: word;
  AX006: X006.IXMLMessageType;
  xmlDoc: TXMLDocument;
  str, url: string;
begin
  xmlDoc := TXMLDocument.Create(nil);

  streamX006.Position := 0;
  xmlDoc.XML.LoadFromStream(streamX006, tencoding.UTF8);
  AX006 := X006.Getmessage(xmlDoc);
  if AX006.Header.MessageType.Value = 'X006' then
  begin
    NRN := AX006.Contents.Results[0].Examination.NrnExamination.Value;
    NzisStatus := StrToInt(AX006.Contents.Results[0].Examination.Status.Value);
    case NzisStatus of
      1: NzisStatus := 5;
      2: NzisStatus := 6;
      3: NzisStatus := 7;
    end;

    data := Pointer(PByte(FNode) + lenNode);
    Dm_adb.CollPregled.SetwordMap(data.DataPos, Word(PregledNew_NZIS_STATUS), NzisStatus);
    lrn := Copy(Dm_adb.CollPregled.GetAnsiStringMap(data.DataPos, Word(PregledNew_NRN_LRN)), 13, 36);
    Dm_adb.CollPregled.SetAnsiStringMap(data.DataPos, Word(PregledNew_NRN_LRN), NRN + lrn);
    PostMessage(FHndSuperHip, WM_USER + 501, nativeint(FNode), 0);//  нула значи ОК

  end
  else
  begin
    data := Pointer(PByte(FNode) + lenNode);
    Dm_adb.CollPregled.SetwordMap(data.DataPos, Word(PregledNew_NZIS_STATUS), 4); //грешка
    ShowMessage((AX006.Contents.XML));
    PostMessage(FHndSuperHip, WM_USER + 501, nativeint(FNode), 1);//  1 - грешка при отваряне
  end;


end;

procedure TNzisThread.PostOfLineStatusToPreg(streamX014: TStream);
var
  data: PAspRec;
  NRN, lrn: AnsiString;
  NzisStatus: word;
  AX014: X014.IXMLMessageType;
  xmlDoc: TXMLDocument;
begin
  xmlDoc := TXMLDocument.Create(nil);

  streamX014.Position := 0;
  xmlDoc.XML.LoadFromStream(streamX014, tencoding.UTF8);
  AX014 := X014.Getmessage(xmlDoc);
  if AX014.Header.MessageType.Value = 'X014' then
  begin
    NRN := AX014.Contents.NrnExamination.Value;
    NzisStatus := AX014.Contents.Status.Value;

    data := Pointer(PByte(FNode) + lenNode);
    Dm_adb.CollPregled.SetwordMap(data.DataPos, Word(PregledNew_NZIS_STATUS), 14); //затворен  с готов преглед
    lrn := Copy(Dm_adb.CollPregled.GetAnsiStringMap(data.DataPos, Word(PregledNew_NRN_LRN)), 13, 36);
    Dm_adb.CollPregled.SetAnsiStringMap(data.DataPos, Word(PregledNew_NRN_LRN), NRN + lrn);
    PostMessage(FHndSuperHip, WM_USER + 501, nativeint(FNode), 0);//  нула значи ОК

  end
  else
  begin
    data := Pointer(PByte(FNode) + lenNode);
    Dm_adb.CollPregled.SetwordMap(data.DataPos, Word(PregledNew_NZIS_STATUS), 15); //грешка при готов преглед
    ShowMessage((AX014.Contents.XML));
    lrn := Copy(Dm_adb.CollPregled.GetAnsiStringMap(data.DataPos, Word(PregledNew_NRN_LRN)), 13, 36);
    Dm_adb.CollPregled.SetAnsiStringMap(data.DataPos, Word(PregledNew_NRN_LRN), NRN + lrn);
    PostMessage(FHndSuperHip, WM_USER + 501, nativeint(FNode), 2);//  1 - грешка при затваряне
  end;


end;

procedure TNzisThread.ReadToken();
var
  Pos1, pos2, len, i: Integer;
  NzisToken: TNzisTokenItem;
  dataPosition: Cardinal;
  pCardinalData: PCardinal;
  TokenToTime, EndDateTime: TDateTime;
  ls: TStringList;
  str, TokenCertId: string;

begin
  FStreamData.Position := 0;
  ls := TStringList.Create;
  ls.LoadFromStream(FStreamData, TEncoding.UTF8);
  str := ls.Text;
  if Str <> '' then
  begin
    len := Length('<nhis:accessToken value="');
    Pos1 := Pos('<nhis:accessToken value="', Str) + len;
    if Pos1 > len then
    begin
      pos2 := Pos('"', Str, Pos1);
      FToken := Copy(Str, Pos1, pos2 - pos1);
    end
    else
    begin
      ShowMessage(str);
      Exit;
    end;
    len := Length('<nhis:expiresOn value="');
    Pos1 := Pos('<nhis:expiresOn value="', Str) + len;
    if Pos1 > len then
    begin
      pos2 := Pos('"', Str, Pos1);
      TokenToTime := ISO8601ToDate(Copy(Str, Pos1, pos2 - pos1), False);
    end;
  end;

  for  i := 0 to Dm_adb.CollNzisToken.Count - 1 do
  begin
    TokenCertId := Trim(Dm_adb.CollNzisToken.getAnsiStringMap(Dm_adb.CollNzisToken.Items[i].DataPos, word(NzisToken_CertID)));
    if TokenCertId = BuildHexString(CurrentCert.SerialNumber) then
    begin
      EndDateTime := Dm_adb.CollNzisToken.getDateMap(Dm_adb.CollNzisToken.Items[i].DataPos, word(NzisToken_ToDatTime));
      if (EndDateTime - Now) < (1/24/12) then //5 min
        Continue;
      Dm_adb.CollNzisToken.SetAnsiStringMap(Dm_adb.CollNzisToken.Items[i].DataPos, word(NzisToken_Bearer), FToken.PadRight(100, ' '));
      Dm_adb.CollNzisToken.SetDateMap(Dm_adb.CollNzisToken.Items[i].DataPos, word(NzisToken_fromDatTime), now);
      Dm_adb.CollNzisToken.SetDateMap(Dm_adb.CollNzisToken.Items[i].DataPos, word(NzisToken_ToDatTime), TokenToTime);
      Exit;
    end;
  end;

  NzisToken := TNzisTokenItem(Dm_adb.CollNzisToken.Add);
  New(NzisToken.PRecord);
  NzisToken.PRecord.Bearer := FToken.PadRight(100, ' ');
  NzisToken.PRecord.ToDatTime := TokenToTime;
  NzisToken.PRecord.fromDatTime := now;
  NzisToken.PRecord.CertID := BuildHexString(CurrentCert.SerialNumber).PadRight(50, ' ');
  NzisToken.PRecord.setProp := [NzisToken_Bearer, NzisToken_fromDatTime, NzisToken_ToDatTime, NzisToken_CertID];
  NzisToken.InsertNzisToken;
  Dispose(NzisToken.PRecord);
  NzisToken.PRecord := nil;
end;

//procedure TNzisThread.prepareHeaders(Sender: TObject; Headers: TStringList);
//begin
//  Headers.Add('Content-Type: application/xml');
//end;

procedure TNzisThread.SetNomenID(const Value: string);
begin
  FNomenID := Value;
end;

end.
