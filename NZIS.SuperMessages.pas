unit NZIS.SuperMessages;

interface
uses
  System.SysUtils, system.Classes,Winapi.Windows, Winapi.Messages, Vcl.Forms,system.DateUtils, Vcl.Dialogs,
  NzisSuperCollection, NZISSuperAddress, Nzis.Types, NZIS.nomenklatura, NZIS.Functions, R016,
  NZIS.XMLschems, NZIS.SuperRealObjects, R004, X006, NZISH002,
  Xml.XMLIntf, Xml.XMLDoc,
  IBX.IBSQL, XMLViewer, nzisbebeXML;

type
TCopyMessage = (cmDBName, cmFreeMedUpdate, cmRequestMess, cmResponsmess , cmCheckPens, cmUnZip,
                cmPng, cmSignPregXML, cmChoicedSigner, cmSignMDNXML, cmToAmbList= 100);
TRequestMessRec = packed record
    RequestMessLen: word;
    RequestMess: PWideChar;
end;


TNZISMessages = class(TObject)
  private
    FTokenDo: TDateTime;
    FTokenFrom: TDateTime;
    FHandleHip: THandle;
    FIsTest: Boolean;
    FEmdnColl: TMdnCollection;
    FEmnColl: TMnCollection;
    FEmn3AColl: TMn3ACollection;
    FEmn6Coll: TMn6Collection;
    FFromDate: TDate;
    FEgn: string;
    FPidType: TidentifierTypeBaseCL004;
    FEmnHospColl: TMnHospCollection;
    FSender: TPerformerItem;
    FCountGetToken: Integer;
  protected
    FPregledColl: TPregledNzisCollection;
    FIsGP: Boolean;
    FibsqlCommand: TIBSQL;
    FDoctorColl: TPerformerCollection;
    FOblastColl: TOblastCollection;
    FNzisSchem: TNzisSchems;
    FErr: EXMLDOMValidationError;
    FMessType: tmessageType;
    FCertNomText: string;
    FTokenText: string;


  public
    FPerformer: TPerformerItem;
    GenXML: TStringlist;
    ResultNzis: TStringList;

    constructor create;dynamic;
    destructor destroy;override;

    function GetToken(certNom: string): boolean;
    procedure SaveToken;
    procedure UpdateAmbNRN_IncMDN(ambNrn, docUin, MDNnrn: string);
    procedure SendRequestMessage(req, url: string);
    procedure SendResponsMessage(resp, url: string);
    //procedure ReadToken
    procedure SendToNzis(xmlToSend: string; NzisObject: TObject; witMessage: boolean);
    procedure OnR0016Proc(txt: string);
    procedure OnR004Proc(txt: string);
    procedure OnX006Proc(txt: string);
    procedure R016ToMN(R016IN: R016.IXMLResultsType; MN: TMnItem);
    procedure R004ToMDN(R004IN: R004.IXMLResultsType; MDN: TMdnItem);
    procedure OnH011Proc(txt: string);
    procedure OnH001Proc(txt: string);
    property PregledColl: TPregledNzisCollection read FPregledColl write FPregledColl;
    property EmdnColl: TMdnCollection read FEmdnColl write FEmdnColl;
    property EmnColl: TMnCollection read FEmnColl write FEmnColl;
    property Emn3AColl: TMn3ACollection read FEmn3AColl write FEmn3AColl;
    property Emn6Coll: TMn6Collection read FEmn6Coll write FEmn6Coll;
    property EmnHospColl: TMnHospCollection read FEmnHospColl write FEmnHospColl;
    property IsGP: Boolean read FIsGP write FIsGP;
    property ibsqlCommand: TIBSQL read FibsqlCommand write FibsqlCommand;
    property DoctorColl: TPerformerCollection read FDoctorColl write FDoctorColl;
    property OblastColl: TOblastCollection read FOblastColl write FOblastColl;
    property NzisSchem: TNzisSchems read FNzisSchem write FNzisSchem;
    property Err: EXMLDOMValidationError read FErr write FErr;
    property MessType: tmessageType read FMessType write FMessType;
    property CertNomText: string read FCertNomText write FCertNomText;
    property TokenText: string read FTokenText write FTokenText;
    property TokenFrom: TDateTime read FTokenFrom;
    property TokenDo: TDateTime read FTokenDo;
    property HandleHip: THandle read FHandleHip write FHandleHip;
    property IsTest: Boolean read FIsTest write FIsTest;
    property Egn: string read FEgn write FEgn;
    property FromDate: TDate read FFromDate write FFromDate;
    property PidType: TidentifierTypeBaseCL004 read FPidType write FPidType;

    property Sender: TPerformerItem read FSender write FSender;
    property CountGetToken: Integer read FCountGetToken write FCountGetToken;
  end;

implementation

{ TPregledMessages }

constructor TNZISMessages.create;
begin
  inherited;
  GenXML := TStringList.Create;
  ResultNzis := TStringList.Create;
  FPerformer := nil;
  FCountGetToken := 0;

end;

destructor TNZISMessages.destroy;
begin
  FreeAndNil(GenXML);
  FreeAndNil(ResultNzis);
  if FErr <> nil then
    FreeAndNil(FErr);
  inherited;
end;

function TNZISMessages.GetToken(certNom: string): boolean;
var
  tempStr: string;
  str: AnsiString;
  p, p1: PAnsiChar;
  h: THandle;
  TokenNZIS: TGetTokenNZIS;
  Pos1, pos2, len: Integer;
  sert: string;
  token: string;
  Timestr: string;
  dllPath: string;
  ls: TStringList;
  delta: Integer;
  err: Boolean;
begin
  Inc(FCountGetToken);
  err := False;
  Result := True;
  if FileExists(ExtractFilePath(Application.ExeName) + 'NZIS.dll') then
    dllPath := ExtractFilePath(Application.ExeName) + 'NZIS.dll'
  else
    dllPath := ExtractFilePath(Application.ExeName) + 'system\NZIS.dll';
  h := LoadLibrary(PWideChar(dllPath));
  try
    @TokenNZIS := GetProcAddress(h, 'GetTokenNZIS');
    p := TokenNZIS(PAnsiChar(AnsiString(certNom)), IsTest);
    tempStr := string(p);
    if tempStr <> '' then
    begin
      if (pos('challenge', tempStr) > 0) or (pos('400 Bad Request', tempStr) > 0) then  //объркал е подписа
      begin
        postMessage(FHandleHip, WM_ERR_TOKEN, 0, 0);
        err:= True;
        Result := False;
        Exit;
      end;
      if (tempStr = 'ERROR1') then  //otkaz
      begin
        //postMessage(FHandleHip, WM_ERR_TOKEN, 0, 0);
        err:= True;
        Result := False;
        Exit;
      end;

      len := Length('<nhis:tokenType value="');
      Pos1 := Pos('<nhis:tokenType value="', tempStr) + len;
      if Pos1 > len then
      begin
        pos2 := Pos('"', tempStr, Pos1);
        sert := Copy(tempStr, Pos1, pos2 - pos1);
        CertNomText := sert;
      end;
      len := Length('<nhis:accessToken value="');
      Pos1 := Pos('<nhis:accessToken value="', tempStr) + len;
      if Pos1 > len then
      begin
        pos2 := Pos('"', tempStr, Pos1);
        token := Copy(tempStr, Pos1, pos2 - pos1);
        FTokenText := token;
      end;

      pos1 := Pos('<nhis:issuedOn value="', tempStr, pos2) + 22;
      pos2 := Pos('"', tempStr, pos1);
      delta := pos2 - pos1;
      Timestr := Copy(tempStr, pos1, delta);
      if Timestr[delta] <> 'Z' then
        Timestr := Timestr + 'Z';
      FTokenFrom := system.DateUtils.ISO8601ToDate(Timestr, false);

      pos1 := Pos('<nhis:expiresOn value="', tempStr, pos2) + 23;
      pos2 := Pos('"', tempStr, pos1);
      delta := pos2 - pos1;
      Timestr := Copy(tempStr, pos1, delta);
      if Timestr[delta] <> 'Z' then
        Timestr := Timestr + 'Z';
      FTokenDo := system.DateUtils.ISO8601ToDate(Timestr, false);

      //ls := TStringList.Create;
//      ls.Text := tempStr;
//      ls.SaveToFile('token.xml');
//      ls.Free;
    end;
  finally
    if not err then
    begin
      // закоментирано за тест, когато винаги ще взима токен и няма нужда  да го записва
      SaveToken;
    end;
    freeLibrary(h);
  end;

end;

procedure TNZISMessages.OnH001Proc(txt: string);
var
  xmldoc: IXMLDocument;
  messH002: NZISH002.IXMLMessageType;
  fs: TFormatSettings;
  i: Integer;
  Pos1, pos2, len: Integer;
  messStr, NRNStr, specStr, visitTypeStr: string;
  vsdStr: string;

  Hosp: TNzisHospInfo;
  Hosps: TNzisHospsInfo;
  copyDataStruct: TCopyDataStruct;
begin
  len := Length('<nhis:messageType value="');
  Pos1 := Pos('<nhis:messageType value="', txt) + len;
  if Pos1 > len then
  begin
    pos2 := Pos('"', txt, Pos1);
    messStr := Copy(txt, Pos1, pos2 - pos1);
  end;
  if messStr = 'H002' then
  begin

  end
  else // err
  begin
    if (messStr = 'H099') and (Pos('<nhis:type value="E002"/>', txt) > 0) then
    begin
      Hosp.NRN := '';
      Hosp.status := hstNone;
      Hosp.authoredOn := 0;
      Hosp.PatEGN := Self.Egn;
      Hosps.hsp[0] := Hosp;
      Hosps.count := 1;
      copyDataStruct.dwData := Integer(101); // да се познава, какъв е типа на Copy събитието
      copyDataStruct.cbData := SizeOf(Hosps);
      copyDataStruct.lpData := @Hosps;
      SendMessage(HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
      Exit;
    end
    else
    begin
      Exit;
    end;
  end;


  fs.ShortDateFormat := 'YYYY-MM-DD';
  fs.DateSeparator := '-';
  xmldoc := TXMLDocument.Create(nil);
  xmldoc.LoadFromXML(txt);
  messH002 := NZISH002.Getmessage(xmldoc);
  for i := 0 to messH002.Contents.Results.Count - 1 do
  begin
    Hosp.NRN := messH002.Contents.Results[i].Hospitalization.NrnHospitalization.Value;
    Hosp.status := THospStatusType(StrToInt(messH002.Contents.Results[i].Hospitalization.Status.Value));
    Hosp.authoredOn := StrToDate(messH002.Contents.Results[i].Hospitalization.AuthoredOn.Value, fs);
    Hosp.PatEGN := Self.Egn;
    Hosps.hsp[i] := Hosp;
  end;
  Hosps.count := messH002.Contents.Results.Count;
  copyDataStruct.dwData := Integer(101); // да се познава, какъв е типа на Copy събитието
  copyDataStruct.cbData := SizeOf(Hosps);
  copyDataStruct.lpData := @Hosps;
  SendMessage(HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
end;

procedure TNZISMessages.OnH011Proc(txt: string);
var
  xmldoc: IXMLDocument;
  messH012: nzisbebeXML.IXMLMessageType;
  fs: TFormatSettings;
  i: Integer;
  Pos1, pos2, len: Integer;
  messStr, NRNStr, specStr, visitTypeStr: string;
  vsdStr: string;

  bebe: TNzisBebeInfo;
  bebeta: TNzisBebetaInfo;
  copyDataStruct: TCopyDataStruct;
begin
  len := Length('<nhis:messageType value="');
  Pos1 := Pos('<nhis:messageType value="', txt) + len;
  if Pos1 > len then
  begin
    pos2 := Pos('"', txt, Pos1);
    messStr := Copy(txt, Pos1, pos2 - pos1);
  end;
  if messStr = 'H012' then
  begin

  end
  else // err
  begin
    Exit;

  end;


  fs.ShortDateFormat := 'YYYY-MM-DD';
  fs.DateSeparator := '-';
  xmldoc := TXMLDocument.Create(nil);
  xmldoc.LoadFromXML(txt);
  messH012 := nzisbebeXML.Getmessage(xmldoc);
  for i := 0 to messH012.Contents.Birth.Newborn.Count -1 do
  begin
    bebe.FName := messH012.Contents.Birth.Newborn[i].Name.Given.Value;
    bebe.SName := messH012.Contents.Birth.Newborn[i].Name.Middle.Value;
    bebe.LName := messH012.Contents.Birth.Newborn[i].Name.Family.Value;
    bebe.identifierNZIS :=  messH012.Contents.Birth.Newborn[i].Identifier.Value;
    bebeta.bebe[i] := bebe;
  end;
  bebeta.count := messH012.Contents.Birth.Newborn.Count;
  copyDataStruct.dwData := Integer(100); // да се познава, какъв е типа на Copy събитието
  copyDataStruct.cbData := SizeOf(bebeta);
  copyDataStruct.lpData := @bebeta;
  SendMessage(HandleHip, wm_CopyData, 0, Integer(@copyDataStruct));
end;

procedure TNZISMessages.OnR0016Proc(txt: string);
var
  xmldoc: IXMLDocument;
  messR016: R016.IXMLMessageType;
  fs: TFormatSettings;
  i: Integer;
  Pos1, pos2, len: Integer;
  messStr, NRNStr, specStr, visitTypeStr: string;
  vsdStr: string;

  MN: TMnItem;
begin
  len := Length('<nhis:messageType value="');
  Pos1 := Pos('<nhis:messageType value="', txt) + len;
  if Pos1 > len then
  begin
    pos2 := Pos('"', txt, Pos1);
    messStr := Copy(txt, Pos1, pos2 - pos1);
  end;
  if messStr = 'R016' then
  begin
    //len := Length('<nhis:nrnReferral value="');
//    Pos1 := Pos('<nhis:nrnReferral value="', txt) + len;
//    if Pos1 > len then
//    begin
//      pos2 := Pos('"', txt, Pos1);
//      NRNStr := Copy(txt, Pos1, pos2 - pos1);
//      Self.NRN := NRNStr;
//      Self.HipStatus := hmsSended;
//    end;
  end
  else // err
  begin
    Exit;
    //len := Length('<nhis:reason value="');
//    Pos1 := Pos('<nhis:reason value="', txt) + len;
//    if Pos1 > len then
//    begin
//      pos2 := Pos('"', txt, Pos1);
//      Self.FErrReason := Copy(txt, Pos1, pos2 - pos1);
//      Self.HipStatus := hmsErr;
//    end;
  end;
  //if Assigned(TMnCollection(Collection).FOnR016) then
//        TMnCollection(Collection).FOnR016(self, TMnCollection(Collection).FMdnMessage);
//  if Self.HipStatus = hmsErr then
//  begin
//    Exit;
//  end;

  fs.ShortDateFormat := 'YYYY-MM-DD';
  fs.DateSeparator := '-';
  xmldoc := TXMLDocument.Create(nil);
  xmldoc.LoadFromXML(txt);
  messR016 := R016.Getmessage(xmldoc);


  for i := 0 to messR016.Contents.Results.Count - 1 do
  begin
    if not (messR016.Contents.Results.Items[i].Referral.Category.Value[2] in ['1', '2', '3', '5']) then
      Continue;
    MN := TMnItem(FEmnColl.Add);
    //if (messR016.Contents.Results.Items[i].Referral.Category.Value[2] in ('1', '2', '3', '5'))   then
       R016ToMN(messR016.Contents.Results.Items[i], MN);
  end;
  xmldoc := nil;
end;

procedure TNZISMessages.OnR004Proc(txt: string);
var
  xmldoc: IXMLDocument;
  messR004: R004.IXMLMessageType;
  fs: TFormatSettings;
  i: Integer;
  Pos1, pos2, len: Integer;
  messStr, NRNStr, specStr, visitTypeStr: string;
  vsdStr: string;

  MN: TMDnItem;
begin
  len := Length('<nhis:messageType value="');
  Pos1 := Pos('<nhis:messageType value="', txt) + len;
  if Pos1 > len then
  begin
    pos2 := Pos('"', txt, Pos1);
    messStr := Copy(txt, Pos1, pos2 - pos1);
  end;
  if messStr = 'R004' then
  begin
    //len := Length('<nhis:nrnReferral value="');
//    Pos1 := Pos('<nhis:nrnReferral value="', txt) + len;
//    if Pos1 > len then
//    begin
//      pos2 := Pos('"', txt, Pos1);
//      NRNStr := Copy(txt, Pos1, pos2 - pos1);
//      Self.NRN := NRNStr;
//      Self.HipStatus := hmsSended;
//    end;
  end
  else // err
  begin
    Exit;
    //len := Length('<nhis:reason value="');
//    Pos1 := Pos('<nhis:reason value="', txt) + len;
//    if Pos1 > len then
//    begin
//      pos2 := Pos('"', txt, Pos1);
//      Self.FErrReason := Copy(txt, Pos1, pos2 - pos1);
//      Self.HipStatus := hmsErr;
//    end;
  end;
  //if Assigned(TMnCollection(Collection).FOnR016) then
//        TMnCollection(Collection).FOnR016(self, TMnCollection(Collection).FMdnMessage);
//  if Self.HipStatus = hmsErr then
//  begin
//    Exit;
//  end;

  fs.ShortDateFormat := 'YYYY-MM-DD';
  fs.DateSeparator := '-';
  xmldoc := TXMLDocument.Create(nil);
  xmldoc.LoadFromXML(txt);
  messR004 := R004.Getmessage(xmldoc);


  for i := 0 to messR004.Contents.Results.Count - 1 do
  begin
    MN := TMdnItem(FEmdnColl.Add);
    R004ToMDN(messR004.Contents.Results.Items[i], MN);
  end;
  xmldoc := nil;
end;

procedure TNZISMessages.OnX006Proc(txt: string);
var
  xmldoc: IXMLDocument;
  messX006: X006.IXMLMessageType;
  fs: TFormatSettings;
  i: Integer;
  Pos1, pos2, len: Integer;
  messStr, NRNStr, specStr, visitTypeStr: string;
  vsdStr: string;

  amb: TPregledNzisItem;

begin
  len := Length('<nhis:messageType value="');
  Pos1 := Pos('<nhis:messageType value="', txt) + len;
  if Pos1 > len then
  begin
    pos2 := Pos('"', txt, Pos1);
    messStr := Copy(txt, Pos1, pos2 - pos1);
  end;
  if messStr = 'X006' then
  begin

  end
  else // err
  begin
    Exit;

  end;

  fs.ShortDateFormat := 'YYYY-MM-DD';
  fs.DateSeparator := '-';
  xmldoc := TXMLDocument.Create(nil);
  xmldoc.LoadFromXML(txt);
  messX006 := X006.Getmessage(xmldoc);


  for i := 0 to messX006.Contents.Results.Count - 1 do
  begin
    amb := TPregledNzisItem(FPregledColl.Add);
    amb.Performer  := TPerformerItem.Create(nil);
    amb.NrnExamination := TAlphanumericString.Create;
    amb.Performer.Pmi := messX006.Contents.Results[i].Performer.Pmi.Value;
    amb.NrnExamination.Value := messX006.Contents.Results[i].Examination.NrnExamination.Value;
  end;
  xmldoc := nil;
end;

procedure TNZISMessages.R004ToMDN(R004IN: R004.IXMLResultsType; MDN: TMdnItem);
var
  fs: TFormatSettings;
  i: Integer;
  Pos1, pos2, len: Integer;
  messStr, NRNStr, specStr, visitTypeStr: string;
  vsdStr: string;
  anal: TAnalItem;
begin
  fs.ShortDateFormat := 'YYYY-MM-DD';
  fs.DateSeparator := '-';
  MDN.FPatient := TPatientItem.Create(nil);


  MDN.FPatient.identifier.Value := R004IN.Subject.Identifier.Value;
  MDN.FPatient.identifierType.IdentifierTypeBaseCL004 := TidentifierTypeBaseCL004(StrToInt(R004IN.Subject.IdentifierType.Value));
  MDN.FPatient.Name.Given := R004IN.Subject.Name.Given.Value;
  MDN.FPatient.Name.Middle := R004IN.Subject.Name.Middle.Value;
  MDN.FPatient.Name.Family := R004IN.Subject.Name.Family.Value;
  MDN.FPatient.birthDate.Date := StrToDateTime(R004IN.Subject.BirthDate.Value, fs);
  MDN.FPatient.Gender.GenderBase := TGenderBase(StrToInt(R004IN.Subject.Gender.Value));
  MDN.FPatient.Rzok := Copy(R004IN.Referral.RhifAreaNumber.Value, 1, 2);
  MDN.FPatient.RzokR := Copy(R004IN.Referral.RhifAreaNumber.Value, 3, 2);
  MDN.FPatient.Address.City := R004IN.Subject.Address.City.Value;
  MDN.FPatient.Address.County := R004IN.Subject.Address.County.Value;
  MDN.FPatient.Address.Country := R004IN.Subject.Address.Country.Value;


  MDN.NRN := R004IN.Referral.NrnReferral.Value;
  MDN.AmbNrn := R004IN.Referral.BasedOn.Value;
  MDN.ICD_CODE_ADD := R004IN.Referral.Diagnosis[0].AdditionalCode.Value;
  MDN.ICD_CODE := R004IN.Referral.Diagnosis[0].Code.Value;

  MDN.DateMdn := StrToDateTime(R004IN.Referral.AuthoredOn.Value, fs);

  MDN.HipLabStatus := THipMdnLabStatus(StrToInt(R004IN.Referral.Status.Value));
  MDN.MED_DIAG_NAPR_TYPE_ID :=  strtoint(R004IN.Referral.Type_.Value);
  MDN.MED_DIAG_NAPR_TYPE_IDHip := strtoint(R004IN.Referral.Type_.Value);


  //MDN.AmbLstNom :=  R016IN.Referral.BasedOn.Value;
  MDN.FRequester := TPerformerItem.Create(nil);

  MDN.FRequester.Pmi := R004IN.Requester.Pmi.Value;
  MDN.FRequester.PmiDeputy := R004IN.Requester.PmiDeputy.Value;
  MDN.FRequester.FName := R004IN.Requester.Name.Given.Value;
  MDN.FRequester.LName := R004IN.Requester.Name.Family.Value;
  MDN.FRequester.Role := TDeputyRoleBase(StrToInt(R004IN.Requester.Role.Value));
  if strtoint(R004IN.Requester.Qualification.Value) <> 0 then
  begin
    MDN.fRequester.Qualification.Value.Value := R004IN.Requester.Qualification.Value;
  end
  else
  begin
    MDN.fRequester.Qualification.Value.Value := '1043';
  end;
  MDN.fRequester.PracticeNumber := R004IN.Requester.PracticeNumber.Value;

  for i  := 0 to R004IN.Procedure_.Count -1 do
  begin
    anal := TAnalItem.Create(nil);
    anal.NzisCode := R004IN.Procedure_[i].Code.Value;
    MDN.Anals.Add(anal);
  end;
end;

procedure TNZISMessages.R016ToMN(R016IN: R016.IXMLResultsType; MN: TMnItem);
var
  fs: TFormatSettings;
  i: Integer;
  Pos1, pos2, len: Integer;
  messStr, NRNStr, specStr, visitTypeStr: string;
  vsdStr: string;
begin


  fs.ShortDateFormat := 'YYYY-MM-DD';
  fs.DateSeparator := '-';
  MN.FPatient := TPatientItem.Create(nil);


  MN.FPatient.identifier.Value := R016IN.Subject.Identifier.Value;
  MN.FPatient.identifierType.IdentifierTypeBaseCL004 := TidentifierTypeBaseCL004(StrToInt(R016IN.Subject.IdentifierType.Value));
  MN.FPatient.Name.Given := R016IN.Subject.Name.Given.Value;
  MN.FPatient.Name.Middle := R016IN.Subject.Name.Middle.Value;
  MN.FPatient.Name.Family := R016IN.Subject.Name.Family.Value;
  MN.FPatient.birthDate.Date := StrToDateTime(R016IN.Subject.BirthDate.Value, fs);
  MN.FPatient.Gender.GenderBase := TGenderBase(StrToInt(R016IN.Subject.Gender.Value));
  MN.FPatient.Rzok := Copy(R016IN.Referral.RhifAreaNumber.Value, 1, 2);
  MN.FPatient.RzokR := Copy(R016IN.Referral.RhifAreaNumber.Value, 3, 2);
  MN.FPatient.Address.City := R016IN.Subject.Address.City.Value;
  MN.FPatient.Address.County := R016IN.Subject.Address.County.Value;
  MN.FPatient.Address.Country := R016IN.Subject.Address.Country.Value;

  MN.Category := R016IN.Referral.Category.Value;

  MN.NRN := R016IN.Referral.NrnReferral.Value;
  MN.ICD_CODE_ADD := R016IN.Referral.Diagnosis[0].AdditionalCode.Value;
  MN.ICD_CODE := R016IN.Referral.Diagnosis[0].Code.Value;
  if R016IN.Referral.Diagnosis.Count > 1 then
  begin
    MN.ICD_CODE2_ADD := R016IN.Referral.Diagnosis[1].AdditionalCode.Value;
    MN.ICD_CODE2 := R016IN.Referral.Diagnosis[1].Code.Value;
  end;
  if R016IN.Referral.Diagnosis.Count > 2 then
  begin
    MN.ICD_CODE3_ADD := R016IN.Referral.Diagnosis[2].AdditionalCode.Value;
    MN.ICD_CODE3 := R016IN.Referral.Diagnosis[2].Code.Value;
  end;
  if MN.Category <> 'R5' then
  begin
    MN.MED_DIAG_NAPR_TYPE_ID := StrToInt(R016IN.Referral.Type_.Value);
  end
  else
  begin
    len := Length('nhis:examType value="');
    Pos1 := Pos('nhis:examType value="', R016IN.XML) + len;
    if Pos1 > len then
    begin
      pos2 := Pos('"', R016IN.XML, Pos1);
      visitTypeStr := Copy(R016IN.XML, Pos1, pos2 - pos1);
      MN.MED_DIAG_NAPR_TYPE_ID := StrToInt(visitTypeStr);
    end;
  end;
  MN.DateMn := StrToDateTime(R016IN.Referral.AuthoredOn.Value, fs);
  if not((MN.Category = 'R3') or (MN.Category = 'R5')) then
  begin
    MN.ForSpec := R016IN.Referral.Consultation.Qualification.Value;
  end
  else
  begin
    len := Length('nhis:qualification value="');
    Pos1 := Pos('nhis:qualification value="', R016IN.XML) + len;
    if Pos1 > len then
    begin
      pos2 := Pos('"', R016IN.XML, Pos1);
      specStr := Copy(R016IN.XML, Pos1, pos2 - pos1);
      MN.ForSpec := specStr;
    end;
    len := Length('nhis:code value="');
    Pos1 := Pos('nhis:code value="', R016IN.XML, pos1) + len;
    if Pos1 > len then
    begin
      pos2 := Pos('"', R016IN.XML, Pos1);
      vsdStr := Copy(R016IN.XML, Pos1, pos2 - pos1);
      MN.VSD := vsdStr;
    end;
  end;
  MN.HipLabStatus := THipMdnLabStatus(StrToInt(R016IN.Referral.Status.Value));
  if (MN.Category = 'R2') then
  begin
    MN.MED_DIAG_NAPR_TYPE_ID :=  strtoint(R016IN.Referral.Type_.Value);
  end;
  MN.AmbLstNom :=  R016IN.Referral.BasedOn.Value;
  MN.FRequester := TPerformerItem.Create(nil);

  MN.FRequester.Pmi := R016IN.Requester.Pmi.Value;
  MN.FRequester.PmiDeputy := R016IN.Requester.PmiDeputy.Value;
  MN.FRequester.FName := R016IN.Requester.Name.Given.Value;
  MN.FRequester.LName := R016IN.Requester.Name.Family.Value;
  MN.FRequester.Role := TDeputyRoleBase(StrToInt(R016IN.Requester.Role.Value));
  if strtoint(R016IN.Requester.Qualification.Value) <> 0 then
  begin
    MN.fRequester.Qualification.Value.Value := R016IN.Requester.Qualification.Value;
  end
  else
  begin
    MN.fRequester.Qualification.Value.Value := '1043';
  end;
  MN.fRequester.PracticeNumber := R016IN.Requester.PracticeNumber.Value;
  //if MN.Category = 'R2' then
//  begin
//    MN.SARBI_GAZOVA := Format(
//      'Придружаващи заболявания:' + #13#10 +
//      'МКБ ''%s'' ----- ''%s''' + #13#10 +
//      'МКБ ''%s'' ----- ''%s''', [MN.ICD_CODE2, MN.ICD_CODE2_ADD, MN.ICD_CODE3, MN.ICD_CODE3_ADD]);
//  end;
//  if MN.Category = 'R3' then
//  begin
//    MN.SARBI_GAZOVA := Format(
//      'Придружаващи заболявания:' + #13#10 +
//      'МКБ ''%s'' ----- ''%s''' + #13#10 +
//      'МКБ ''%s'' ----- ''%s''' + #13#10 +
//      #13#10 +
//      'ВСД ''%s''',
//
//      [MN.ICD_CODE2, MN.ICD_CODE2_ADD,
//       MN.ICD_CODE3, MN.ICD_CODE3_ADD,
//       MN.VSD]);
//  end;
//  if MN.Category = 'R5' then
//  begin
//    MN.SARBI_GAZOVA := Format(
//      'Придружаващи заболявания:' + #13#10 +
//      'МКБ ''%s'' ----- ''%s''',
//
//      [MN.ICD_CODE2, MN.ICD_CODE2_ADD]);
//  end;
  if mn.Category = 'R5' then
  begin
    for i := 0 to R016IN.Referral.medicalExpertise.Qualification.Count - 1 do
    begin
      case i of
        1:
        begin
          mn.Spec2 := R016IN.Referral.medicalExpertise.Qualification[i].Value;
        end;
        2:
        begin
          mn.Spec3 :=R016IN.Referral.medicalExpertise.Qualification[i].Value;
        end;
        3:
        begin
          mn.Spec4 := R016IN.Referral.medicalExpertise.Qualification[i].Value;
        end;
        4:
        begin
          mn.Spec5 :=R016IN.Referral.medicalExpertise.Qualification[i].Value;
        end;
      end;
    end;
  end;
end;

procedure TNZISMessages.SaveToken;
begin
  ibsqlCommand.Close;
  ibsqlCommand.SQL.Text :=
    'update or insert into nzis_tokens' + #13#10 +
    '(id, doctor_id, from_time, to_time, "VALUE")' + #13#10 +
    'values (gen_id(GEN_NZIS_TOKENS, 1), :doctor_id, :from_time, :to_time, :value)' + #13#10 +
    'matching (doctor_id)';
  if (FPerformer.DeputDoctorID = 0)  then
  begin
    ibsqlCommand.ParamByName('doctor_id').AsInteger := FPerformer.DoctorId;
  end
  else
  begin
    ibsqlCommand.ParamByName('doctor_id').AsInteger := FPerformer.DeputDoctorID;
  end;

  ibsqlCommand.ParamByName('from_time').AsDateTime := TokenFrom;
  ibsqlCommand.ParamByName('to_time').AsDateTime := TokenDo;
  ibsqlCommand.ParamByName('value').AsString := TokenText;
  ibsqlCommand.ExecQuery;
  ibsqlCommand.Transaction.CommitRetaining;
  ibsqlCommand.Close;
end;

procedure TNZISMessages.SendRequestMessage(req, url: string);
var
  ReqMesRec: TRequestMessRec;
  copyDataStruct : TCopyDataStruct;
begin
  ReqMesRec.RequestMess := pChar((GenXML.Text));
  ReqMesRec.RequestMessLen := length((GenXML.Text))* 2;
  copyDataStruct.dwData := Integer(cmRequestMess);
  copyDataStruct.cbData := SizeOf(ReqMesRec);
  copyDataStruct.lpData := @ReqMesRec;


  SendMessage(HandleHip ,WM_COPYDATA, Integer(HandleHip), Integer(@copyDataStruct));
end;


procedure TNZISMessages.SendResponsMessage(resp, url: string);
var
  ReqMesRec: TRequestMessRec;
  copyDataStruct : TCopyDataStruct;
  oXml: IXMLDocument;
  stream: TStringStream;
begin
  try
    try
      oXml := TXMLDocument.Create(nil);
      oXml.LoadFromXML(Xml.XMLDoc.FormatXMLData(resp));
      oXml.Encoding := 'UTF-8';
     // oXml.XML.Text:=xml.xmlDoc.FormatXMLData(oXml.XML.Text);
      stream := TStringStream.Create(url + #13#10, TEncoding.UTF8);
      stream.Position := stream.Size;
      oXml.SaveToStream(stream);
      stream.Position := 0;
      resp := stream.ReadString(stream.Size);
      //syndtXML.Lines.LoadFromStream(stream, TEncoding.UTF8);
    finally
      stream.Free;
      if oXml.Active then
      begin
        oXml.ChildNodes.Clear;
        oXml.Active := False;
      end;
      oxml := nil;
    end;
  except

  end;
  ReqMesRec.RequestMess := pChar((resp));
  ReqMesRec.RequestMessLen := length((resp))* 2;
  copyDataStruct.dwData := Integer(cmResponsmess);
  copyDataStruct.cbData := SizeOf(ReqMesRec);
  copyDataStruct.lpData := @ReqMesRec;


  SendMessage(HandleHip ,WM_COPYDATA, Integer(HandleHip), Integer(@copyDataStruct));
end;

procedure TNZISMessages.SendToNzis(xmlToSend: string; NzisObject: TObject; witMessage: boolean);
var
  tempStr: string;
  str: AnsiString;
  p, p1: PAnsiChar;
  h: THandle;
  SendXmlToNZIS: TSendXmlToNZIS;
  stream: TStringStream;
  oXml: IXMLDocument;
  dllPath: string;

  URLText: string;
  xmlViewer: TfrmlXMLViewer;
begin
  //ShowMessage(ExtractFilePath(Application.ExeName) + 'NZIS.dll');
  if FileExists(ExtractFilePath(Application.ExeName) + 'NZIS.dll') then
    dllPath := ExtractFilePath(Application.ExeName) + 'NZIS.dll'
  else
    dllPath := ExtractFilePath(Application.ExeName) + 'system\NZIS.dll';

    ///dllPath := 'NZIS.dll';////////////////////////////


  URLText:= GetURLFromXML(xmlToSend, FMessType, IsTest);
  h := LoadLibrary(PWideChar(dllPath));
  //Sleep(20000);
  SendRequestMessage('', '');
  if witMessage then
  begin
  try
    xmlViewer := TfrmlXMLViewer.Create(nil);
    XMLViewer.InXml := xmlToSend;
    xmlViewer.Url := URLText;
    xmlViewer.ShowModal;
  except
    ShowMessage(xmlToSend);
    FreeAndNil(xmlViewer);
    Exit;
  end;
    FreeAndNil(xmlViewer);
    //ShowMessage(tempStr);
  end;
  //ShowMessage('заявка: ' + AnsiString(xmlToSend));
  try
    @SendXmlToNZIS := GetProcAddress(h, 'SendXmlToNZIS');
    p := SendXmlToNZIS(PAnsiChar(AnsiString(URLText)),
                       PAnsiChar(AnsiString(TokenText)),
                       PAnsiChar(AnsiString(xmlToSend)),
                       PAnsiChar(AnsiString(CertNomText)),
                       IsTest);
    tempStr := string(p);
    //ShowMessage('отговор: ' +tempStr);

    if tempStr.StartsWith('{}') then
    begin
      tempStr :=
        '<?xml version="1.0" encoding="UTF-8"?>' + #13#10 +
        '<nhis:message xmlns:nhis="https://www.his.bg">' + #13#10 +
        '	<nhis:header>' + #13#10 +
        '		<nhis:sender value="4"/>' + #13#10 +
        '		<nhis:senderId value="NHIS"/>' + #13#10 +
        '		<nhis:recipient value="1"/>' + #13#10 +
        '		<nhis:recipientId value="2222222222"/>' + #13#10 +
        '		<nhis:messageId value="1B007F64-BDD1-4989-80D0-D3D3BF5F6671"/>' + #13#10 +
        '		<nhis:messageType value="C008"/>' + #13#10 +
        '		<nhis:createdOn value="2023-08-09T08:30:52.2389419Z"/>' + #13#10 +
        '	</nhis:header>' + #13#10 +
        '	<nhis:contents>' + #13#10 +
        '		<nhis:nrnExecution value="DIMITROVGRAD"/>' + #13#10 +
        '	</nhis:contents>' + #13#10 +
        '</nhis:message>'
    end;
    self.SendResponsMessage(tempStr, URLText);
    if witMessage then
    begin
    try
      xmlViewer := TfrmlXMLViewer.Create(nil);
      XMLViewer.InXml := tempStr;
      xmlViewer.Url := URLText;
      xmlViewer.ShowModal;
    except
      ShowMessage(tempStr);
      FreeAndNil(xmlViewer);
      Exit;
    end;
      FreeAndNil(xmlViewer);
      //ShowMessage(tempStr);
    end;
    if tempStr = 'ERROR1' then
      Exit;
      try
        oXml := TXMLDocument.Create(nil);
        oXml.LoadFromXML(Xml.XMLDoc.FormatXMLData(tempStr));
        //oXml.LoadFromFile('d:\R010Resp100.xml');
        ResultNzis.Assign(oXml.XML);
        case FMessType of
          X001: TPregledNzisItem(NzisObject).ReceivingX002(ResultNzis.Text);
          X003: TPregledNzisItem(NzisObject).ReceivingX004(ResultNzis.Text);
          X005:
          begin
            if NzisObject <> nil then
            begin
              TPregledNzisItem(NzisObject).ReceivingX006(ResultNzis.Text);
            end
            else
            begin
              OnX006Proc(ResultNzis.Text);
              //TPregledItem(NzisObject).ReceivingX006(ResultNzis.Text);
            end;
          end;
          X007: TPregledNzisItem(NzisObject).ReceivingX008(ResultNzis.Text);
          X009: TPregledNzisItem(NzisObject).ReceivingX010(ResultNzis.Text);
          X011: TPregledNzisItem(NzisObject).ReceivingX012(ResultNzis.Text);
          X013: TPregledNzisItem(NzisObject).ReceivingX014(ResultNzis.Text);
          R001:
          begin
            if NzisObject is TMdnItem then
            begin
               TMdnItem(NzisObject).ReceivingR002(ResultNzis.Text);
            end
            else
            if NzisObject is TMnItem then
            begin
               TMnItem(NzisObject).ReceivingR002(ResultNzis.Text);
            end
            else
            if NzisObject is TMn3AItem then
            begin
               TMn3AItem(NzisObject).ReceivingR002(ResultNzis.Text);
            end
            else
            if NzisObject is TMn6Item then
            begin
               TMn6Item(NzisObject).ReceivingR002(ResultNzis.Text);
            end
            else
            if NzisObject is TMnHospItem then
            begin
               TMnHospItem(NzisObject).ReceivingR002(ResultNzis.Text);
            end
          end;

          R003:
          begin
            if NzisObject <> nil then
            begin
              TMdnItem(NzisObject).ReceivingR004(ResultNzis.Text);
            end
            else
            begin
              OnR004Proc(ResultNzis.Text);
            end;
          end;
          R005:
          begin
            TMdnItem(NzisObject).ReceivingR006(ResultNzis.Text);
          end;
          C007:
          begin
            TMdnItem(NzisObject).ReceivingC008(ResultNzis.Text);
          end;
          R009:
          begin
            if NzisObject is TMnItem then
            begin
              TMnItem(NzisObject).ReceivingR010(ResultNzis.Text);
            end;
          end;
          R015:
          if NzisObject <> nil then
          begin
            if TMnItem(NzisObject).NRN <> '' then
            begin
              TMnItem(NzisObject).ReceivingR004(ResultNzis.Text);
            end
            else
            begin
              TMnItem(NzisObject).ReceivingR016(ResultNzis.Text);
            end;
          end
          else
          begin
            OnR0016Proc(ResultNzis.Text);
          end;
          R007:
          begin
            if NzisObject is TMdnItem then
            begin
              TMdnItem(NzisObject).ReceivingR008(ResultNzis.Text);
            end
            else
            if NzisObject is TMnItem then
            begin
              TMnItem(NzisObject).ReceivingR008(ResultNzis.Text);
            end
            else
            if NzisObject is TMn3AItem then
            begin
              TMn3AItem(NzisObject).ReceivingR008(ResultNzis.Text);
            end
            else
            if NzisObject is TMn6Item then
            begin
              TMn6Item(NzisObject).ReceivingR008(ResultNzis.Text);
            end
            else
            if NzisObject is TMnHospItem then
            begin
              TMnHospItem(NzisObject).ReceivingR008(ResultNzis.Text);
            end;
          end;
          R011: TMdnItem(NzisObject).ReceivingR012(ResultNzis.Text);
          R017: TMdnItem(NzisObject).ReceivingR018(ResultNzis.Text);
          H011: OnH011Proc(ResultNzis.Text);
          H001: OnH001Proc(ResultNzis.Text);

          C041:
          begin
            TMedBelItem(NzisObject).ReceivingC042(ResultNzis.Text);
          end;

          C045:
          begin
            TMedBelItem(NzisObject).ReceivingC046(ResultNzis.Text);
          end;
    //
    //      C015:
    //      begin
    //        CurrDoctor.ReceivingC016(syndtResult.Lines.Text, vtrDeput);
    //        vtrDeput.BeginUpdate;
    //        //vtrDeput.IterateSubtree(CurrDoctor.FNode, IterateDeletePeriod, nil);
    //        vtrDeput.IterateSubtree(CurrDoctor.FNode, IterateDeputats, nil);
    //        vtrDeput.EndUpdate;
    //      end;

        end;
      except
        ResultNzis.Text := 'Няма отговор от НЗИС.'
      end;
  except
    ResultNzis.Text := 'Няма отговор от НЗИС.'
  end;
end;

procedure TNZISMessages.UpdateAmbNRN_IncMDN(ambNrn, docUin, MDNnrn: string);
begin
  ibsqlCommand.Close;
  ibsqlCommand.SQL.Text :=
    'update inc_mdn imdn' + #13#10 +
    'set' + #13#10 +
    'imdn.amb_nrn = :amb_nrn' + #13#10 +
    'where' + #13#10 +
    'imdn.doctor_uin = :doctor_uin and' + #13#10 +
    'imdn.nrn = :nrn';
  ibsqlCommand.ParamByName('amb_nrn').AsString := ambNrn;
  ibsqlCommand.ParamByName('doctor_uin').AsString := docUin;
  ibsqlCommand.ParamByName('nrn').AsString := MDNnrn;
  ibsqlCommand.ExecQuery;
  ibsqlCommand.Transaction.CommitRetaining;
  ibsqlCommand.Close;
end;

end.
