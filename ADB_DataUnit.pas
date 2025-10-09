unit ADB_DataUnit;
        //plannedType
interface
uses
  System.Classes, system.IniFiles, system.SysUtils, Winapi.Windows,
  System.Rtti, system.DateUtils, Xml.XMLIntf, System.Math,
  System.Generics.Collections, Vcl.Dialogs, system.Diagnostics, System.TimeSpan,
  Aspects.Collections, Aspects.Types, VirtualStringTreeAspect, VirtualTrees,
  Table.PregledNew, Table.PatientNew, Table.Doctor, Table.Diagnosis, Table.EventsManyTimes,
  Table.Practica, Table.CL132, Table.NZIS_PLANNED_TYPE, Table.NZIS_QUESTIONNAIRE_RESPONSE,
  Table.NZIS_QUESTIONNAIRE_ANSWER, Table.NZIS_ANSWER_VALUE, Table.CL139,
  Table.NZIS_DIAGNOSTIC_REPORT, Table.NZIS_RESULT_DIAGNOSTIC_REPORT, Table.CL144,
  Table.Certificates, Table.Mkb, Table.AnalsNew,
  ProfGraph, RealObj.NzisNomen
  , Nzis.Types, RealObj.RealHipp, L010, Xml.XMLDoc
  , SBxCertificateStorage;

  type

  TNzisMsgType = (NNNN,
                  C001, C003, C005, C007, C009, C011, C013, C015, C041, C023, C045,
                  X001, X003, X005, X007, X009, X011, X013,
                  R001, R003, R005, R007, R009, R011, R015, R017,
                  I001, I003, I005, I007, I009, I011, I013,
                  P001, P003, P005, P007, P009, P011, P013, P015,
                  H001, H011,
                  L009);


  TListNodes = TList<PVirtualNode>;
  TAnsws = class
    AnswNode: PVirtualNode;
    answValues: TListNodes;
    constructor create;
    destructor destroy; override;
  end;

  TQuests = class
    questNode: PVirtualNode;
    answs: TList<TAnsws>;
    constructor create;
    destructor destroy; override;
  end;

  //TResDiagRep = class
//    resNode: PVirtualNode;
//  end;

  TDiagRep = class
    DiagRepNode: PVirtualNode;
    ResDiagReps: TListNodes;
    constructor create;
    destructor destroy; override;
  end;

  TPregledNodes = class
    pregNode: PVirtualNode;
    perfNode: PVirtualNode;
    deputNode: PVirtualNode;
    patNode: PVirtualNode;
    docNode: PVirtualNode;
    diags: TListNodes;
    mkbs: TListNodes;
    evnts: TListNodes;
    Planeds: TListNodes;
    Quests: TList<TQuests>;
    DiagReps: TList<TDiagRep>;
    SourceAnsw: TSourceAnsw;
    log: string;
    constructor create;
    destructor destroy; override;

    function getRhifAreaNumber(buf: pointer; posdata: cardinal): string;
    function GetNZISPidType(buf: pointer; posdata: cardinal): TNZISidentifierType;
    function GetNzisGender(buf: pointer; posdata: cardinal): TNzisGender;
  end;

  TPatNodes = class
    patNode: PVirtualNode;
    docNode: PVirtualNode;
    evnts: TList<PVirtualNode>;
    ExamAnals: TList<PVirtualNode>;
    diags: TList<PVirtualNode>;
    pregs: TList<PVirtualNode>;
    CollDiag: TRealDiagnosisColl;

    constructor create;
    destructor destroy; override;

    function GetNZISPidType(buf: pointer; posdata: cardinal): TNZISidentifierType;
    function GetPrevProfPregled(dateNow: TDate; pregColl: TPregledNewColl; exceptPreg: TRealPregledNewItem = nil): Cardinal;
    procedure SortDiag(SortIsAsc: Boolean);
  end;

  TNodesSendedToNzis = class
    node: PVirtualNode;
    XmlResp: TStringList;
    XmlReq: TStringList;
    AdbLink: TMappedLinkFile;
    constructor create(AAdbLink: TMappedLinkFile);
    destructor destroy; override;
    procedure SaveToFile(filename: string);
    procedure LoadFromFile(filename: string);
    function GetLinkPos: cardinal;
    function SetNode(linkPos: cardinal): PVirtualNode;
  end;


  TADBDataModule = class(TObject)
  private
    FPatEgn: string;
    //FPatNodes: TPatNodes;
  protected
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    ver: string;
    procedure AddTagToStream(XmlStream: TXmlStream;NameTag, ValueTag :string; amp: Boolean = true; Node: PVirtualNode = nil);

    procedure FillXmlStreamHeader(XmlStream: TXmlStream; msgType: TNzisMsgType; SenderID: string);
    procedure FillXmlStreamPlannedType(XmlStream: TXmlStream; PregNodes: TPregledNodes);
    procedure FillXmlStreamDiag(XmlStream: TXmlStream; PregNodes: TPregledNodes);
    procedure FillXmlStreamMedicalHistory(XmlStream: TXmlStream; PregNodes: TPregledNodes);
    procedure FillXmlStreamObjectiveCondition(XmlStream: TXmlStream; PregNodes: TPregledNodes; logPat: TlogicalPatientNewSet);




  public
    listLog: TStringList;
    CollPrac: TPracticaColl;
    CollPatient: TRealPatientNewColl;
    CollDoc: TRealDoctorColl;
    CollCert: TCertificatesColl;
    CollPregled: TRealPregledNewColl;
    CollMDN: TRealMDNColl;
    CollMedNapr: TRealBLANKA_MED_NAPRColl;
    CollExamAnal: TRealExamAnalysisColl;
    CollExamImun: TRealExamImmunizationColl;
    CollEbl: TRealExam_boln_listColl;
    CollDiag: TRealDiagnosisColl;
    CollMkb: TMkbColl;
    CollAnalsNew: TAnalsNewColl;

    CollNZIS_PLANNED_TYPE: TRealNZIS_PLANNED_TYPEColl;
    CollNZIS_QUESTIONNAIRE_RESPONSE: TRealNZIS_QUESTIONNAIRE_RESPONSEColl;
    CollNZIS_QUESTIONNAIRE_ANSWER: TRealNZIS_QUESTIONNAIRE_ANSWERColl;
    CollNZIS_ANSWER_VALUEColl: TRealNZIS_ANSWER_VALUEColl;

    collNZIS_DIAGNOSTIC_REPORT:  TRealNZIS_DIAGNOSTIC_REPORTColl;
    collNZIS_RESULT_DIAGNOSTIC_REPORT:  TRealNZIS_RESULT_DIAGNOSTIC_REPORTColl;

    CollCL022: TRealCL022Coll;
    collCl139: TRealCL139Coll;
    collCl132: TRealCL132Coll;
    collCl144: TRealCL144Coll;

    AdbHip: TMappedFile;
    AdbLink: TMappedLinkFile;
    cmdFile: TFileStream;
    Vtr: TVirtualStringTreeAspect;
    strGuid: string;
    LstNodeSended: TList<TNodesSendedToNzis>;
    ListPrimDocuments: TList<TBaseCollection>;

    procedure AddNewDiag(vPreg: PVirtualNode; cl011, cl011Add: string; rank: integer; DataPosMkb: cardinal);

    //XmlStream: TXmlStream;
    constructor Create();
    destructor Destroy; override;
    function GetPatNodes(PatNode: PVirtualNode): TPatNodes;
    function GetPregNodes(PregNode: PVirtualNode): TPregledNodes;
    function GetURLFromMsgType(msgType: TNzisMsgType; IsTest: Boolean): string;
    procedure FillXmlStreamC001(XmlStream: TXmlStream; NomenID: string);

    procedure FillXmlStreamX001(XmlStream: TXmlStream; PregNode: PVirtualNode; var IndexInListSended: integer);
    procedure FillXmlStreamX003(XmlStream: TXmlStream; PregNode: PVirtualNode;var IndexInListSended: integer; correctionReason: string = '');
    procedure FillXmlStreamX005(XmlStream: TXmlStream; PregNode: PVirtualNode);
    procedure FillXmlStreamX009(XmlStream: TXmlStream; PregNode: PVirtualNode; var IndexInListSended: integer; correctionReason: string = 'Promqna');
    procedure FillXmlStreamX013(XmlStream: TXmlStream; PregNode: PVirtualNode);

    procedure FillXmlStreamI001(XmlStream: TXmlStream; ImmunNode: PVirtualNode);

    procedure FillXmlStreamL009(XmlStream: TXmlStream; PatNode: PVirtualNode);
    procedure FillXmlStreamL009Preg(XmlStream: TXmlStream; PregNode: PVirtualNode; var IndexInListSended: integer; var pregnodes: TPregledNodes);

    procedure ReadXmlL010(streamL010: TStream; ls: TStrings = nil);
    procedure ReadXmlL010Preg(streamL010: TStream; pregNodes: TPregledNodes);
    procedure ReadXmlL010PregTest(streamL010: TStream; pregNodes: TPregledNodes);

    procedure FormatingXML(stream: TStream);overload;
    procedure FormatingXML(ls: TStringList);overload;
    procedure InitPerformer(XmlStream: TXmlStream; PregNodes: TPregledNodes; var performer: TRealDoctorItem);

    property patEgn: string read FPatEgn;
    //property PatNodes: TPatNodes read FPatNodes;



  end;


implementation

function LibraryPath: String;
var  lpBuffer:   Array [0..MAX_PATH] of wideChar;
begin

  // Return the dll's path
  if IsLibrary then
  begin
     GetModuleFileName(hInstance, lpBuffer, SizeOf(lpBuffer));
     result:=ExcludeTrailingBackslash(ExtractFilePath(lpBuffer));
  end
  else
     // Not a library
     result:='';

end;

{ TADBDataModule }

procedure TADBDataModule.AddNewDiag(vPreg: PVirtualNode; cl011,
  cl011Add: string; rank: integer; DataPosMkb: cardinal);
var
  diag: TRealDiagnosisItem;
  vDiag, vPrevDiag, run: PVirtualNode;
  linkpos: Cardinal;
  i: Integer;
  dataRun: PAspRec;
begin
  vPrevDiag := nil;
  if rank > 0 then
  begin
    run := vPreg.FirstChild;
    while run <> nil do
    begin
      dataRun := Pointer(PByte(run) + lenNode);
      case dataRun.vid of
        vvDiag:
        begin
          if CollDiag.getWordMap(dataRun.DataPos, word(Diagnosis_rank)) = (rank - 1) then
          begin
            vPrevDiag := run;
            Break;
          end;
        end;
      end;
      run := run.NextSibling;
    end;
  end;
  diag := TRealDiagnosisItem(CollDiag.Add);// добавяне на диагноза в колекцията
  New(diag.PRecord);
  diag.PRecord.setProp := [Diagnosis_code_CL011, Diagnosis_rank, Diagnosis_MkbPos];
  diag.PRecord.code_CL011 := cl011;
  diag.PRecord.rank := rank;
  diag.PRecord.MkbPos := DataPosMkb;
  if DataPosMkb = 100 then
  begin
    for i := 0 to CollMkb.Count - 1 do
    begin
      if CollMkb.getAnsiStringMap( CollMkb.Items[i].DataPos, word(Diagnosis_code_CL011)) = cl011 then
      begin
        diag.PRecord.MkbPos := CollMkb.Items[i].DataPos;
        Break;
      end;
    end;
  end;

  if cl011Add <> '' then
  begin
    Include(diag.PRecord.setProp, Diagnosis_additionalCode_CL011);
    diag.PRecord.additionalCode_CL011 := cl011Add;
  end;

  diag.InsertDiagnosis;
  CollDiag.streamComm.Len := CollDiag.streamComm.Size;
  cmdFile.CopyFrom(CollDiag.streamComm, 0);
  Dispose(diag.PRecord);
  diag.PRecord := nil;

  if vPrevDiag = nil then
  begin
    AdbLink.AddNewNode(vvDiag, diag.DataPos, vPreg, amAddChildLast, vDiag, linkpos);
  end
  else
  begin
    AdbLink.AddNewNode(vvDiag, diag.DataPos, vPrevDiag, amInsertAfter, vDiag, linkpos);
  end;
  diag.Node := vDiag;
end;

procedure TADBDataModule.AddTagToStream(XmlStream: TXmlStream; NameTag, ValueTag: string; amp: Boolean; Node: PVirtualNode);
var
  buf, val: String;
  startPos: Integer;
  data: PAspRec;
begin
  val := ValueTag;
  if Val = '' then
    buf := '<'+(NameTag)+'>' + #13#10
  else
  begin
    if amp then
    begin
      Val:= Val.Replace('&', '&amp;', [rfReplaceAll]);
      Val := Val.Replace('<', '&lt;', [rfReplaceAll]);
      Val := Val.Replace('>', '&gt;', [rfReplaceAll]);
      Val := Val.Replace(#8, ' ', [rfReplaceAll]);
      Val := Val.Replace(#9, ' ', [rfReplaceAll]);
      Val := Val.Replace(#13#10, '&#xA;', [rfReplaceAll]);
      Val := Val.Replace(#10, '&#xA;', [rfReplaceAll]);
      //Val := Val.Replace('"', '&quot;', [rfReplaceAll]);

    end;
    buf :=  ('<'+(NameTag)+' '+(Val)+' />' + #13#10);
  end;
  XMLStream.WriteString(buf);
  XmlStream.CurrentLine := XmlStream.CurrentLine + 1;
  if Node <> nil then
  begin
    data := Pointer(PByte(Node) + lenNode);
    data.index := XmlStream.CurrentLine;
  end;
end;

constructor TADBDataModule.Create();
begin
  inherited;
  //FPatNodes.evnts := TList<PVirtualNode>.Create;
//  FPatNodes.ExamAnals := TList<PVirtualNode>.Create;
  //XMLStream := TXmlStream.Create('', TEncoding.UTF8);
  LstNodeSended := TList<TNodesSendedToNzis>.Create;
  listLog := TStringList.Create;
  ListPrimDocuments := TList<TBaseCollection>.create;
end;

destructor TADBDataModule.Destroy;
begin
  //FreeAndNil(XMLStream);
  FreeAndNil(LstNodeSended);
  FreeAndNil(listLog);
  FreeAndNil(ListPrimDocuments);
  inherited;
end;

procedure TADBDataModule.FillXmlStreamC001(XmlStream: TXmlStream; NomenID: string);
begin
  XmlStream.Clear;
  FillXmlStreamHeader(XmlStream, C001, '6810101723');
  AddTagToStream(XmlStream, 'nhis:contents', '', false);
  AddTagToStream(XmlStream, 'nhis:nomenclatureId', Format('value="%s"',[NomenID]), false);
  AddTagToStream(XmlStream, '/nhis:contents', '');
  AddTagToStream(XmlStream, '/nhis:message','');
  XmlStream.Position := 0;
end;

procedure TADBDataModule.FillXmlStreamDiag(XmlStream: TXmlStream; PregNodes: TPregledNodes);
var
  i: Integer;
  dataDiag: PAspRec;
  diagCode, diagCodeAdd, DiagDateStr: string;
  DiagRank, diagUs: word;
begin
  for i := 0 to PregNodes.diags.Count - 1 do
  begin
    dataDiag := Pointer(PByte(PregNodes.diags[i]) + lenNode);
    diagCode := CollDiag.getAnsiStringMap(dataDiag.DataPos, word(Diagnosis_code_CL011));
    //diagCode.Split([';'])[0];
    diagCodeAdd := CollDiag.getAnsiStringMap(dataDiag.DataPos, word(Diagnosis_additionalCode_CL011));
    DiagRank := CollDiag.getWordMap(dataDiag.DataPos, word(Diagnosis_rank));
    if DiagRank = 0 then
    begin
      diagUs := 3; // основна
    end
    else
    begin
      diagUs := 4;  // придружаваща
    end;
    AddTagToStream(XmlStream, 'nhis:diagnosis', '');
    AddTagToStream(XmlStream, 'nhis:code', Format('value="%s"',[diagCode.Split([';'])[0]]), false);// zzzzzzzzzzzzzzzzzzzzzzz


    if diagCodeAdd <> '' then
    begin
      AddTagToStream(XmlStream, 'nhis:additionalCode', Format('value="%s"',[diagCodeAdd]), false);
    end;
    AddTagToStream(XmlStream, 'nhis:use',  Format('value="%d"',[diagUs]));
    AddTagToStream(XmlStream, 'nhis:rank',  Format('value="%d"',[DiagRank]));
    AddTagToStream(XmlStream, 'nhis:clinicalStatus',  Format('value="%d"',[22]));
    AddTagToStream(XmlStream, 'nhis:verificationStatus',  Format('value="%d"',[20]));
    DiagDateStr := DateToISO8601(TTimeZone.Local.ToUniversalTime(Date));
    AddTagToStream(XmlStream, 'nhis:onsetDateTime', Format('value="%s"',[DiagDateStr]), false);


    AddTagToStream(XmlStream, '/nhis:diagnosis', '');
  end;
end;

procedure TADBDataModule.FillXmlStreamHeader(XmlStream: TXmlStream; msgType: TNzisMsgType; SenderID: string);
var
  MsgGuid: TGUID;
  strMsgGuid: string;
begin
  CreateGUID(MsgGuid);
  strMsgGuid := MsgGuid.ToString;
  strMsgGuid := Copy(strMsgGuid, 2, 36);

  XMLStream.Writestring(('<?xml version="1.0" encoding="UTF-8"?>' +#13#10));
  XMLStream.Writestring(('<nhis:message xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:nhis="https://www.his.bg">' +#13#10));// xsi:schemaLocation="https://www.his.bg https://www.his.bg/api/v1/NHIS-C001.xsd">' +#13#10));

  AddTagToStream(XmlStream, 'nhis:header', '', false);
  AddTagToStream(XmlStream, 'nhis:sender', 'value="1"', false);

  AddTagToStream(XmlStream, 'nhis:senderId', Format('value="%s"',[senderID]) , false);
  AddTagToStream(XmlStream, 'nhis:senderISName', Format('value="Hippocrates%s"',[ver]), false);
  AddTagToStream(XmlStream, 'nhis:recipient', 'value="4"', false);
  AddTagToStream(XmlStream, 'nhis:recipientId', 'value="NHIS"', false);

  AddTagToStream(XmlStream, 'nhis:messageId', Format('value="%s"',[strMsgGuid]), false);
  AddTagToStream(XmlStream, 'nhis:messageType', Format('value="%s"',[TRttiEnumerationType.GetName(msgType)]), false);
  AddTagToStream(XmlStream, 'nhis:createdOn', Format('value="%s"', [DateToISO8601(TTimeZone.Local.ToUniversalTime (now))]), false);
  AddTagToStream(XmlStream, '/nhis:header', '');


end;

procedure TADBDataModule.FillXmlStreamI001(XmlStream: TXmlStream; ImmunNode: PVirtualNode);
var
  preg: TRealPregledNewItem;
  performer: TRealDoctorItem;
  pat: TRealPatientNewItem;
  dataPreg: PAspRec;
  dataPerf: PAspRec;
  dataPat: PAspRec;
  buf: Pointer;
  posData: Cardinal;
  pregNode: PVirtualNode;
  PregNodes: TPregledNodes;

  SenderId: string;
  LRN, dateLrn, pregNrn: string;

  ОccurrenceDate: TDateTime;
  BrdDate: TDate;
  BrdDateStr: string;
  ОccurrenceDateStr: string;
  PregClass: TNzisPregledType;
  rhifAreaNumber: string;
  IdentifierNzis: string;
  patEgn: string;
  NzisPidType: TNZISidentifierType;
  NzisGender: TNzisGender;
  patFName, patSName, patLname: string;
  qualification, NhifCodeSpec: string;
  Nationality: string;
  NodeSended: TNodesSendedToNzis;
begin
  XmlStream.Clear;
  buf := AdbHip.Buf;
  posData := AdbHip.FPosData;
  pregNode := ImmunNode.Parent;
  dataPreg := pointer(PByte(PregNode) + lenNode);
  preg := TRealPregledNewItem.Create(nil);
  preg.DataPos := dataPreg.DataPos;
  preg.CalcTypes(buf, posData);
  PregNodes := GetPregNodes(PregNode);// обикаля дървото
  performer := TRealDoctorItem.Create(nil);
  if PregNodes.perfNode <> nil then
  begin
    dataPerf := pointer(PByte(PregNodes.perfNode) + lenNode);
  end
  else
  begin
    dataPerf := pointer(PByte(PregNodes.docNode) + lenNode);
  end;
  performer.DataPos := dataPerf.DataPos;
  pat := TRealPatientNewItem.Create(nil);
  dataPat := pointer(PByte(PregNodes.patNode) + lenNode);
  pat.DataPos := dataPat.DataPos;


  SenderId := performer.getAnsiStringMap(buf, posData, word(Doctor_UIN));
  FillXmlStreamHeader(XmlStream, I001, SenderId);
  addTagToStream(XmlStream, 'nhis:contents', '');
  AddTagToStream(XmlStream, 'nhis:immunization', '');
  lrn := Copy(CollPregled.GetAnsiStringMap(dataPreg.DataPos, Word(PregledNew_NRN_LRN)), 13, 36);
  pregNrn := Copy(CollPregled.GetAnsiStringMap(dataPreg.DataPos, Word(PregledNew_NRN_LRN)), 1, 12);
  AddTagToStream(XmlStream, 'nhis:lrn', Format('value="%s"',[LRN]), false);
  ОccurrenceDate := preg.getDateMap(buf, posData, word(PregledNew_START_DATE)) +
              preg.getDateMap(buf, posData, word(PregledNew_START_TIME));
  ОccurrenceDate := now;//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
  dateLrn := FormatDateTime('_YYYY.MM.DD ', ОccurrenceDate);
  //CollPreg.SetAnsiStringMap(dataPreg.DataPos, Word(PregledNew_NRN), dateLrn + lrn);
  ОccurrenceDateStr := DateToISO8601(TTimeZone.Local.ToUniversalTime(ОccurrenceDate));
  AddTagToStream(XmlStream, 'nhis:occurrence', Format('value="%s"',[ОccurrenceDateStr]), false);
  AddTagToStream(XmlStream, 'nhis:basedOn', Format('value="%s"',[pregNrn]));
  AddTagToStream(XmlStream, 'nhis:targetDisease', Format('value="%s"',['Z24.6']));//zzzzzzzzzzzzzz  даже може да са много
  AddTagToStream(XmlStream, '/nhis:immunization', '');

  AddTagToStream(XmlStream, 'nhis:subject', '');

  IdentifierNzis := pat.getAnsiStringMap(buf, posData, word(PatientNew_NZIS_PID));
  patEgn := pat.getAnsiStringMap(buf, posData, word(PatientNew_EGN));

  NzisPidType := PregNodes.GetNZISPidType(buf, posdata);

  if IdentifierNzis = '' then
  begin
    AddTagToStream(XmlStream, 'nhis:identifierType', Format('value="%d"',[Integer(NzisPidType)]), false);
    AddTagToStream(XmlStream, 'nhis:identifier', Format('value="%s"',[patEgn] ), false);
  end
  else
  begin
    AddTagToStream(XmlStream, 'nhis:identifierType', Format('value="%d"',[Integer(NzisPidType)]), false);
    AddTagToStream(XmlStream, 'nhis:identifier', Format('value="%s"',[IdentifierNzis] ), false);
  end;
  BrdDate := pat.getDateMap(buf, posData, word(PatientNew_BIRTH_DATE));
  BrdDateStr := FormatDateTime('YYYY-MM-DD', BrdDate);

  AddTagToStream(XmlStream, 'nhis:birthDate', Format('value="%s"',[BrdDateStr]));
  NzisGender := PregNodes.GetNzisGender(buf, posdata);
  AddTagToStream(XmlStream, 'nhis:gender', Format('value="%d"',[Integer(NzisGender)]));
  Nationality := 'BG';//  zzzzzzzzzzzzzzzzzzz pat.getAnsiStringMap(buf, posData, word(PatientNew_FNAME));
  AddTagToStream(XmlStream, 'nhis:nationality', Format('value="%s"',[Nationality]), false);


  AddTagToStream(XmlStream, 'nhis:name', '');
  patFName := pat.getAnsiStringMap(buf, posData, word(PatientNew_FNAME));
  patSName := pat.getAnsiStringMap(buf, posData, word(PatientNew_SNAME));
  patLname := pat.getAnsiStringMap(buf, posData, word(PatientNew_LNAME));
  AddTagToStream(XmlStream, 'nhis:given', Format('value="%s"',[patFName]), false);
  if Length(patSName) >1 then
  begin
    AddTagToStream(XmlStream, 'nhis:middle', Format('value="%s"',[patSName]), false);
  end;
  AddTagToStream(XmlStream, 'nhis:family', Format('value="%s"',[patLName]), false);
  AddTagToStream(XmlStream, '/nhis:name', '');

  AddTagToStream(XmlStream, 'nhis:address', '');
  AddTagToStream(XmlStream, 'nhis:country', Format('value="%s"',['BG']), false);
  AddTagToStream(XmlStream, 'nhis:county', Format('value="%s"',['BLG']), false);
  AddTagToStream(XmlStream, 'nhis:ekatte', Format('value="%s"',['04279']), false);
  AddTagToStream(XmlStream, 'nhis:city', Format('value="%s"',['Благоевград']), false);
  AddTagToStream(XmlStream, '/nhis:address', '');

  AddTagToStream(XmlStream, '/nhis:subject', '');

  AddTagToStream(XmlStream, 'nhis:performer', '');

  AddTagToStream(XmlStream, 'nhis:pmi', Format('value="%s"',[SenderId]), false);
//  if performer.Fdeput <> nil then
//  begin
//    AddTagToStream('nhis:pmiDeputy', Format('value="%s"',[self.Fdeput.FPmi]), false);
//  end;
  qualification := '1043';// performer.getAnsiStringMap(buf, posData, word(doct))
  NhifCodeSpec := '00';

  AddTagToStream(XmlStream, 'nhis:qualification', Format('value="%s" nhifCode="%s"',
        [qualification, NhifCodeSpec]), false);
//  if Self.Fdeput <> nil then
//    AddTagToStream('nhis:role', Format('value="%d"',[Integer(self.Fdeput.FRole)]), false)
//  else
    AddTagToStream(XmlStream, 'nhis:role', Format('value="%d"',[1]), false);
//  FillXmlStreamLKK;
  AddTagToStream(XmlStream, 'nhis:practiceNumber', Format('value="%s"',[CollPrac.Items[0].getAnsiStringMap(buf, posData, word(Practica_NOMER_LZ))]), false);

  AddTagToStream(XmlStream, '/nhis:performer', '');

  addTagToStream(XmlStream, '/nhis:contents', '');
  addTagToStream(XmlStream, '/nhis:message', '');

  NodeSended := TNodesSendedToNzis.create(AdbLink);
  NodeSended.node := PregNode;
  XmlStream.Position := 0;
  NodeSended.XmlReq.LoadFromStream(XmlStream, TEncoding.UTF8);
  //IndexInListSended := LstNodeSended.Add(NodeSended);


end;

procedure TADBDataModule.FillXmlStreamL009(XmlStream: TXmlStream; PatNode: PVirtualNode);
var
  pat: TRealPatientNewItem;
  patNodes: TPatNodes;
  doc: TRealDoctorItem;
  dataPat, dataDoc: PAspRec;
  buf: Pointer;
  posData: Cardinal;

  SenderId: string;
  IdentifierNzis: string;

  NzisPidType: TNZISidentifierType;
begin
  XmlStream.Clear;
  buf := AdbHip.Buf;
  posData := AdbHip.FPosData;
  dataPat := pointer(PByte(PatNode) + lenNode);
  pat := TRealPatientNewItem.Create(nil);
  pat.DataPos := dataPat.DataPos;

  patNodes := GetPatNodes(PatNode);// обикаля дървото
  doc := TRealDoctorItem.Create(nil);
  if patNodes.docNode <> nil then
  begin
    dataDoc := pointer(PByte(patNodes.docNode) + lenNode);
    doc.DataPos := dataDoc.DataPos;
    SenderId := doc.getAnsiStringMap(buf, posData, word(Doctor_UIN));
  end
  else
  begin
    SenderId := '0000000000';
  end;
  FillXmlStreamHeader(XmlStream, L009, SenderId);

  addTagToStream(XmlStream, 'nhis:contents', '');

  IdentifierNzis := pat.getAnsiStringMap(buf, posData, word(PatientNew_NZIS_PID));
  FpatEgn := pat.getAnsiStringMap(buf, posData, word(PatientNew_EGN));

  NzisPidType := patNodes.GetNZISPidType(buf, posdata);

  if IdentifierNzis = '' then
  begin
    AddTagToStream(XmlStream, 'nhis:identifierType', Format('value="%d"',[Integer(NzisPidType)]), false);
    AddTagToStream(XmlStream, 'nhis:identifier', Format('value="%s"',[FpatEgn]), false);
  end
  else
  begin
    AddTagToStream(XmlStream, 'nhis:identifierType', Format('value="%d"',[Integer(NzisPidType)]), false);
    AddTagToStream(XmlStream, 'nhis:identifier', Format('value="%s"',[IdentifierNzis]), false);
    //zzzzzzzzzzzzzzzzzzzzzzzzzzz да се добави нзис-киа пидТипе
  end;


  addTagToStream(XmlStream, '/nhis:contents', '');
  addTagToStream(XmlStream, '/nhis:message', '');

end;

procedure TADBDataModule.FillXmlStreamL009Preg(XmlStream: TXmlStream; PregNode: PVirtualNode; var IndexInListSended: integer; var pregnodes: TPregledNodes);
var
  pat: TRealPatientNewItem;
  patNodes: TPatNodes;
  performer: TRealDoctorItem;
  dataPat, dataPerf: PAspRec;
  buf: Pointer;
  posData: Cardinal;

  SenderId: string;
  IdentifierNzis: string;

  NzisPidType: TNZISidentifierType;
  NodeSended: TNodesSendedToNzis;

begin
  XmlStream.Clear;
  buf := AdbHip.Buf;
  posData := AdbHip.FPosData;
  PregNodes := GetPregNodes(PregNode);// обикаля дървото
  patNodes := GetPatNodes(pregnodes.patNode);

  InitPerformer(XmlStream, PregNodes, performer );

  pat := TRealPatientNewItem.Create(nil);
  dataPat := pointer(PByte(PregNodes.patNode) + lenNode);
  pat.DataPos := dataPat.DataPos;
  SenderId := performer.getAnsiStringMap(buf, posData, word(Doctor_UIN));
  FillXmlStreamHeader(XmlStream, L009, SenderId);

  addTagToStream(XmlStream, 'nhis:contents', '');

  IdentifierNzis := pat.getAnsiStringMap(buf, posData, word(PatientNew_NZIS_PID));
  FpatEgn := pat.getAnsiStringMap(buf, posData, word(PatientNew_EGN));

  NzisPidType := patNodes.GetNZISPidType(buf, posdata);

  if IdentifierNzis = '' then
  begin
    AddTagToStream(XmlStream, 'nhis:identifierType', Format('value="%d"',[Integer(NzisPidType)]), false);
    AddTagToStream(XmlStream, 'nhis:identifier', Format('value="%s"',[FpatEgn]), false);
  end
  else
  begin
    AddTagToStream(XmlStream, 'nhis:identifierType', Format('value="%d"',[Integer(NzisPidType)]), false);
    AddTagToStream(XmlStream, 'nhis:identifier', Format('value="%s"',[IdentifierNzis]), false);
    //zzzzzzzzzzzzzzzzzzzzzzzzzzz да се добави нзис-киа пидТипе
  end;


  addTagToStream(XmlStream, '/nhis:contents', '');
  addTagToStream(XmlStream, '/nhis:message', '');
  NodeSended := TNodesSendedToNzis.create(AdbLink);
  NodeSended.node := PregNode;
  XmlStream.Position := 0;
  NodeSended.XmlReq.LoadFromStream(XmlStream, TEncoding.UTF8);
  IndexInListSended := LstNodeSended.Add(NodeSended);
end;

procedure TADBDataModule.FillXmlStreamMedicalHistory(XmlStream: TXmlStream; PregNodes: TPregledNodes);
var
  i, j, k: Integer;
  dataQuest, dataAnsw, dataAnswVal, dataTest, dataPreg: PAspRec;
  quest133, answ134, valueQuant, valNomen, cl138Code, cl139Key, valueStr, valueDate: string;
  ques: TQuests;
  answ: TAnsws;
  valNode: PVirtualNode;
  NomenPos139: Cardinal;
  Cl028Code: Word;
  valDate: TDate;
  anamn: string;
begin
  AddTagToStream(XmlStream, 'nhis:medicalHistory', '');
  dataPreg := pointer(PByte(PregNodes.pregNode) + lenNode);
  for i := 0 to PregNodes.Quests.Count - 1 do
  begin
    AddTagToStream(XmlStream, 'nhis:questionnaire', '');
    ques := PregNodes.Quests[i];
    dataQuest := pointer(PByte(ques.questNode) + lenNode);
    quest133 :=  Copy(CollNZIS_QUESTIONNAIRE_RESPONSE.getAnsiStringMap(dataQuest.DataPos, word(NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY)), 7, 2);
    AddTagToStream(XmlStream, 'nhis:code',  Format('value="%s"',[quest133]));
    for j  := 0 to ques.answs.Count - 1 do
    begin
      answ := ques.answs[j];
      dataAnsw := pointer(PByte(answ.AnswNode) + lenNode);
      answ134 :=  CollNZIS_QUESTIONNAIRE_ANSWER.getAnsiStringMap(dataAnsw.DataPos, word(NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE));
      AddTagToStream(XmlStream, 'nhis:answer', '');
      AddTagToStream(XmlStream, 'nhis:code',  Format('value="%s"',[answ134]));
      if answ.answValues.Count = 0 then
      begin
        if (answ.AnswNode.CheckType = ctNone) and (answ.AnswNode.Dummy = 0) then
        begin
          case PregNodes.SourceAnsw of
            TSourceAnsw.saPatient: AddTagToStream(XmlStream, 'nhis:source',  Format('value="%d"',[5]), False, answ.AnswNode); // отказ
            TSourceAnsw.saOther: AddTagToStream(XmlStream, 'nhis:source',  Format('value="%d"',[5]), False, answ.AnswNode); // отказ
            TSourceAnsw.saDoktor: AddTagToStream(XmlStream, 'nhis:source',  Format('value="%d"',[4]), False, answ.AnswNode); // Не е приложим
          end;
        end
        else
        begin
          if answ.AnswNode.Dummy > 0 then
          begin
            AddTagToStream(XmlStream, 'nhis:source',  Format('value="%d"',[answ.AnswNode.Dummy]), False, answ.AnswNode);
          end
          else
          begin
            dataTest := Pointer(PByte(answ.AnswNode.parent) + lenNode);
            AddTagToStream(XmlStream, 'nhis:source',  Format('value="%d"',[answ.AnswNode.parent.Dummy]), False, answ.AnswNode);
          end;
          valNode := answ.AnswNode;
          dataAnswVal := pointer(PByte(valNode) + lenNode);
          //Cl028Code := CollNZIS_ANSWER_VALUEColl.getWordMap(dataAnswVal.DataPos, word(NZIS_ANSWER_VALUE_CL028));
          if (dataAnswVal.vid = vvNZIS_QUESTIONNAIRE_ANSWER) and (valNode.CheckType = ctCheckBox) then
          begin
            AddTagToStream(XmlStream, 'nhis:valueScale',  Format('value="%d"',[5]));
            if (csCheckedNormal = answ.AnswNode.CheckState) then
            begin
              AddTagToStream(XmlStream, 'nhis:valueBoolean',  Format('value="%s"',['true']));
            end
            else
            begin
               AddTagToStream(XmlStream, 'nhis:valueBoolean',  Format('value="%s"',['false']));
            end;
          end;
        end;
      end
      else
      begin
        for k := 0 to answ.answValues.Count - 1 do
        begin
          valNode := answ.answValues[k];
          dataAnswVal := pointer(PByte(valNode) + lenNode);
          Cl028Code := CollNZIS_ANSWER_VALUEColl.getWordMap(dataAnswVal.DataPos, word(NZIS_ANSWER_VALUE_CL028));
          case Cl028Code of
            1:
            begin
              valueQuant := Double.ToString(CollNZIS_ANSWER_VALUEColl.getDoubleMap(dataAnswVal.DataPos, word(NZIS_ANSWER_VALUE_ANSWER_QUANTITY)));
              //AddTagToStream(XmlStream, 'nhis:source',  Format('value="%d"',[answ.AnswNode.parent.Dummy]), False, answ.AnswNode);
              if answ.AnswNode.Dummy in[1, 2, 3]  then
              begin
                AddTagToStream(XmlStream, 'nhis:source',  Format('value="%d"',[answ.AnswNode.Dummy]), False, answ.AnswNode);
              end
              else
              begin
                AddTagToStream(XmlStream, 'nhis:source',  Format('value="%d"',[answ.AnswNode.parent.Dummy]), False, answ.AnswNode);
              end;
              AddTagToStream(XmlStream, 'nhis:valueScale',  Format('value="%d"',[Cl028Code]));
              AddTagToStream(XmlStream, 'nhis:valueQuantity',  Format('value="%s"',[valueQuant]));
            end;
            2:
            begin
              valNomen := CollNZIS_ANSWER_VALUEColl.getAnsiStringMap(dataAnswVal.DataPos, word(NZIS_ANSWER_VALUE_ANSWER_CODE));
              NomenPos139 := CollNZIS_ANSWER_VALUEColl.getCardMap(dataAnswVal.DataPos, word(NZIS_ANSWER_VALUE_NOMEN_POS));
              cl138Code := collCl139.getAnsiStringMap(NomenPos139, word(CL139_cl138));
              cl139Key := collCl139.getAnsiStringMap(NomenPos139, word(CL139_Key));
              if answ.AnswNode.Dummy in[1, 2, 3]  then
              begin
                AddTagToStream(XmlStream, 'nhis:source',  Format('value="%d"',[answ.AnswNode.Dummy]), False, answ.AnswNode);
              end
              else
              begin
                AddTagToStream(XmlStream, 'nhis:source',  Format('value="%d"',[answ.AnswNode.parent.Dummy]), False, answ.AnswNode);
              end;
              if answ.AnswNode.CheckType = ctCheckBox then
              begin
                AddTagToStream(XmlStream, 'nhis:valueScale',  Format('value="%d"',[Cl028Code]));
                AddTagToStream(XmlStream, 'nhis:valueNomenclature',  Format('value="%s"',[cl138Code]));
                AddTagToStream(XmlStream, 'nhis:valueCode',  Format('value="%s"',[cl139Key]));
              end;
            end;
            3:
            begin
              valueStr := CollNZIS_ANSWER_VALUEColl.getAnsiStringMap(dataAnswVal.DataPos, word(NZIS_ANSWER_VALUE_ANSWER_TEXT));
              if answ.AnswNode.Dummy in [1, 2, 3]then
              begin
                AddTagToStream(XmlStream, 'nhis:source',  Format('value="%d"',[answ.AnswNode.Dummy]), False, answ.AnswNode);
              end
              else
              begin
                AddTagToStream(XmlStream, 'nhis:source',  Format('value="%d"',[answ.AnswNode.parent.Dummy]), False, answ.AnswNode);
              end;
              AddTagToStream(XmlStream, 'nhis:valueScale',  Format('value="%d"',[Cl028Code]));
              AddTagToStream(XmlStream, 'nhis:valueString',  Format('value="%s"',[valueStr]), true);
            end;
            4:
            begin
              valDate := CollNZIS_ANSWER_VALUEColl.getDateMap(dataAnswVal.DataPos, word(NZIS_ANSWER_VALUE_ANSWER_DATE));
              valueDate := FormatDateTime('YYYY-MM-DD', valDate);
              //AddTagToStream(XmlStream, 'nhis:source',  Format('value="%d"',[answ.AnswNode.parent.Dummy]), False, answ.AnswNode);
              if answ.AnswNode.Dummy in[1, 2, 3]  then
              begin
                AddTagToStream(XmlStream, 'nhis:source',  Format('value="%d"',[answ.AnswNode.Dummy]), False, answ.AnswNode);
              end
              else
              begin
                AddTagToStream(XmlStream, 'nhis:source',  Format('value="%d"',[answ.AnswNode.parent.Dummy]), False, answ.AnswNode);
              end;
              AddTagToStream(XmlStream, 'nhis:valueScale',  Format('value="%d"',[Cl028Code]));
              AddTagToStream(XmlStream, 'nhis:valueDate',  Format('value="%s"',[valueDate]));
            end;
          end;
        end;
      end;

      AddTagToStream(XmlStream, '/nhis:answer', '');
    end;
    AddTagToStream(XmlStream, '/nhis:questionnaire', '');
  end;
  anamn := CollPregled.getAnsiStringMap(dataPreg.DataPos, word(PregledNew_ANAMN));
  AddTagToStream(XmlStream, 'nhis:note', Format('value="%s"',[anamn]), true);
  AddTagToStream(XmlStream, '/nhis:medicalHistory', '');
end;

procedure TADBDataModule.FillXmlStreamObjectiveCondition(XmlStream: TXmlStream;
  PregNodes: TPregledNodes; logPat: TlogicalPatientNewSet);
var
  i, j: Integer;
  DiagRep: TDiagRep;
  resDiagRepNode: PVirtualNode;
  IsRes: Boolean;
  dataDiagRep, dataResVal, dataResDiagRep: PAspRec;
  diagRep142, resDiagRep144, resDiagRep139, category012, valueUnit, valueStr, valueQuant: string;
  valNode: PVirtualNode;
  NomenPos144: Cardinal;
  Cl028Code: Word;
begin
  AddTagToStream(XmlStream, 'nhis:objectiveCondition', '');
  if SEX_TYPE_F in logPat then
  begin
    AddTagToStream(XmlStream, 'nhis:isPregnant', Format('value="%s"',['false']), false); //zzzzzzzzzzzzzzzzz
    AddTagToStream(XmlStream, 'nhis:isBreastFeeding', Format('value="%s"',['false']), false); //zzzzzzzzzzzzzzzzz
  end;


  for i := 0 to PregNodes.DiagReps.Count - 1 do
  begin
    DiagRep := PregNodes.DiagReps[i];
    IsRes := False;
    for j := 0 to DiagRep.ResDiagReps.Count - 1 do
    begin
      if (DiagRep.ResDiagReps[j].CheckState = csCheckedNormal) or (DiagRep.ResDiagReps[j].Parent.CheckState = csCheckedNormal) then
      begin
        IsRes := True;
        Break;
      end;
    end;
    if not  IsRes then Continue;

    AddTagToStream(XmlStream, 'nhis:diagnosticReport', '');

    dataDiagRep := pointer(PByte(DiagRep.DiagRepNode) + lenNode);
    diagRep142 :=  collNZIS_DIAGNOSTIC_REPORT.getAnsiStringMap(dataDiagRep.DataPos, word(NZIS_DIAGNOSTIC_REPORT_CL142_CODE));
    AddTagToStream(XmlStream, 'nhis:code',  Format('value="%s"',[diagRep142]));
    AddTagToStream(XmlStream, 'nhis:status',  Format('value="%d"',[10]));

    for j := 0 to DiagRep.ResDiagReps.Count - 1 do
    begin
      resDiagRepNode := DiagRep.ResDiagReps[j];
      if resDiagRepNode.FirstChild <> nil then
      begin
        valNode := resDiagRepNode.FirstChild;
        dataResVal := pointer(PByte(valNode) + lenNode);

        AddTagToStream(XmlStream, 'nhis:result', '');
        dataResDiagRep := pointer(PByte(resDiagRepNode) + lenNode);
        NomenPos144 := collNZIS_RESULT_DIAGNOSTIC_REPORT.getCardMap(dataResDiagRep.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
        category012 := collCl144.getAnsiStringMap(NomenPos144, word(CL144_cl012));
        //resDiagRep139 :=  collNZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(dataResDiagRep.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE));
        resDiagRep144 := collCl144.getAnsiStringMap(NomenPos144, word(CL144_Key));
        valueUnit := collCl144.getAnsiStringMap(NomenPos144, word(CL144_units));
        AddTagToStream(XmlStream, 'nhis:code',  Format('value="%s"',[resDiagRep144]));
        Cl028Code := collNZIS_RESULT_DIAGNOSTIC_REPORT.getWordMap(dataResDiagRep.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE));
        AddTagToStream(XmlStream, 'nhis:valueScale',  Format('value="%d"',[Cl028Code]));
        case Cl028Code  of
          1:
          begin
            valueQuant := Double.ToString(collNZIS_RESULT_DIAGNOSTIC_REPORT.getDoubleMap(dataResVal.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY)));
            AddTagToStream(XmlStream, 'nhis:valueQuantity',  Format('value="%s"',[valueQuant]));
            AddTagToStream(XmlStream, 'nhis:valueUnit',  Format('value="%s"',[valueUnit]));
          end;
          2:
          begin
            resDiagRep139 :=  collNZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(dataResVal.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE));
            resDiagRep144 := collCl144.getAnsiStringMap(NomenPos144, word(CL144_cl138));
            AddTagToStream(XmlStream, 'nhis:valueNomenclature',  Format('value="%s"',[resDiagRep144]));
            AddTagToStream(XmlStream, 'nhis:valueCode',  Format('value="%s"',[resDiagRep139]));
          end;
          3:
          begin
            valueStr := collNZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(dataResVal.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING));
            AddTagToStream(XmlStream, 'nhis:valueString',  Format('value="%s"',[valueStr]));
          end;
        end;
        AddTagToStream(XmlStream, 'nhis:category',  Format('value="%s"',[category012]));
        AddTagToStream(XmlStream, '/nhis:result', '');
      end
      else
      begin
        AddTagToStream(XmlStream, 'nhis:result', '');
        dataResDiagRep := pointer(PByte(resDiagRepNode) + lenNode);
        NomenPos144 := collNZIS_RESULT_DIAGNOSTIC_REPORT.getCardMap(dataResDiagRep.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS));
        category012 := collCl144.getAnsiStringMap(NomenPos144, word(CL144_cl012));
        resDiagRep144 := collCl144.getAnsiStringMap(NomenPos144, word(CL144_Key));
        valueUnit := collCl144.getAnsiStringMap(NomenPos144, word(CL144_units));
        AddTagToStream(XmlStream, 'nhis:code',  Format('value="%s"',[resDiagRep144]));
        Cl028Code := collNZIS_RESULT_DIAGNOSTIC_REPORT.getWordMap(dataResDiagRep.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE));
        AddTagToStream(XmlStream, 'nhis:valueScale',  Format('value="%d"',[Cl028Code]));
        case Cl028Code  of
          1:
          begin
            valueQuant := Double.ToString(collNZIS_RESULT_DIAGNOSTIC_REPORT.getDoubleMap(dataResDiagRep.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY)));
            AddTagToStream(XmlStream, 'nhis:valueQuantity',  Format('value="%s"',[valueQuant]));
            AddTagToStream(XmlStream, 'nhis:valueUnit',  Format('value="%s"',[valueUnit]));
          end;
          2:
          begin
            resDiagRep139 :=  collNZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(dataResDiagRep.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE));
            resDiagRep144 := collCl144.getAnsiStringMap(NomenPos144, word(CL144_cl138));
            AddTagToStream(XmlStream, 'nhis:valueNomenclature',  Format('value="%s"',[resDiagRep144]));
            AddTagToStream(XmlStream, 'nhis:valueCode',  Format('value="%s"',[resDiagRep139]));
          end;
          3:
          begin
            valueStr := collNZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(dataResDiagRep.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING));
            AddTagToStream(XmlStream, 'nhis:valueString',  Format('value="%s"',[valueStr]));
          end;
        end;
        AddTagToStream(XmlStream, 'nhis:category',  Format('value="%s"',[category012]));
        AddTagToStream(XmlStream, '/nhis:result', '');
      end;


    end;

    AddTagToStream(XmlStream, '/nhis:diagnosticReport', '');
  end;

  AddTagToStream(XmlStream, 'nhis:note', Format('value="%s"',['Obektivno']), false); //zzzzzzzzzzzzzzzzz
  AddTagToStream(XmlStream, '/nhis:objectiveCondition', '');

end;

procedure TADBDataModule.FillXmlStreamPlannedType(XmlStream: TXmlStream; PregNodes: TPregledNodes);
var
  i: Integer;
  dataPlaned: PAspRec;
  PlanType: string;
begin
  for i := 0 to PregNodes.Planeds.Count - 1 do // zzzzzzzzzzzzzzz да се пробират само тия с чекчета
  begin
    //PregNodes.pat
    dataPlaned := pointer(PByte(PregNodes.Planeds[i]) + lenNode);
    PlanType := CollNZIS_PLANNED_TYPE.getAnsiStringMap(dataPlaned.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY));
    AddTagToStream(XmlStream, 'nhis:plannedType',  Format('value="%s"',[PlanType]));
  end;
end;

procedure TADBDataModule.FillXmlStreamX001(XmlStream: TXmlStream; PregNode: PVirtualNode; var IndexInListSended: integer);
var
  preg: TRealPregledNewItem;
  performer: TRealDoctorItem;
  pat: TRealPatientNewItem;
  dataPreg: PAspRec;

  dataPat: PAspRec;
  buf: Pointer;
  posData: Cardinal;
  PregNodes: TPregledNodes;

  SenderId: string;
  LRN, dateLrn: string;
  OpenDate: TDateTime;
  BrdDate: TDate;
  BrdDateStr: string;
  OpenDateStr: string;
  PregClass: TNzisPregledType;
  rhifAreaNumber: string;
  IdentifierNzis: string;
  patEgn: string;
  NzisPidType: TNZISidentifierType;
  NzisGender: TNzisGender;
  patFName, patSName, patLname: string;
  qualification, NhifCodeSpec: string;
  Nationality: string;
  NodeSended: TNodesSendedToNzis;

  slotNom: Integer;
  i: Integer;
  pin: string;
begin
  XmlStream.Clear;
  buf := AdbHip.Buf;
  posData := AdbHip.FPosData;
  dataPreg := pointer(PByte(PregNode) + lenNode);
  preg := TRealPregledNewItem.Create(nil);
  preg.DataPos := dataPreg.DataPos;
  preg.CalcTypes(buf, posData);
  PregNodes := GetPregNodes(PregNode);// обикаля дървото

  InitPerformer(XmlStream, PregNodes, performer );


  pat := TRealPatientNewItem.Create(nil);
  dataPat := pointer(PByte(PregNodes.patNode) + lenNode);
  pat.DataPos := dataPat.DataPos;


  SenderId := performer.getAnsiStringMap(buf, posData, word(Doctor_UIN));
  FillXmlStreamHeader(XmlStream ,X001, SenderId);
  addTagToStream(XmlStream, 'nhis:contents', '');
  AddTagToStream(XmlStream, 'nhis:examination', '');
  lrn := Copy(CollPregled.GetAnsiStringMap(dataPreg.DataPos, Word(PregledNew_NRN_LRN)), 13, 36);
  AddTagToStream(XmlStream, 'nhis:lrn', Format('value="%s"',[LRN]), false);
  OpenDate := preg.getDateMap(buf, posData, word(PregledNew_START_DATE)) +
              preg.getDateMap(buf, posData, word(PregledNew_START_TIME));
  OpenDate := now;//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
  dateLrn := FormatDateTime('_YYYY.MM.DD ', OpenDate);
  CollPregled.SetAnsiStringMap(dataPreg.DataPos, Word(PregledNew_NRN_LRN), dateLrn + lrn);
  OpenDateStr := DateToISO8601(TTimeZone.Local.ToUniversalTime(OpenDate));
  AddTagToStream(XmlStream, 'nhis:openDate', Format('value="%s"',[OpenDateStr]), false);
  AddTagToStream(XmlStream, 'nhis:class', Format('value="%d"',[Integer(preg.clcClass)]));
  AddTagToStream(XmlStream, 'nhis:financingSource', Format('value="%d"',[Integer(preg.clcFinancingSource)]));
  rhifAreaNumber := PregNodes.getRhifAreaNumber(buf, posData);
  AddTagToStream(XmlStream, 'nhis:rhifAreaNumber', Format('value="%s"',[rhifAreaNumber]));
  AddTagToStream(XmlStream, '/nhis:examination', '');

  AddTagToStream(XmlStream, 'nhis:subject', '');

  IdentifierNzis := pat.getAnsiStringMap(buf, posData, word(PatientNew_NZIS_PID));
  patEgn := pat.getAnsiStringMap(buf, posData, word(PatientNew_EGN));

  NzisPidType := PregNodes.GetNZISPidType(buf, posdata);

  if IdentifierNzis = '' then
  begin
    AddTagToStream(XmlStream, 'nhis:identifierType', Format('value="%d"',[Integer(NzisPidType)]), false);
    AddTagToStream(XmlStream, 'nhis:identifier', Format('value="%s"',[patEgn] ), false);
  end
  else
  begin
    AddTagToStream(XmlStream, 'nhis:identifierType', Format('value="%d"',[Integer(NzisPidType)]), false);
    AddTagToStream(XmlStream, 'nhis:identifier', Format('value="%s"',[IdentifierNzis] ), false);
  end;
  BrdDate := pat.getDateMap(buf, posData, word(PatientNew_BIRTH_DATE));
  BrdDateStr := FormatDateTime('YYYY-MM-DD', BrdDate);

  AddTagToStream(XmlStream, 'nhis:birthDate', Format('value="%s"',[BrdDateStr]));
  NzisGender := PregNodes.GetNzisGender(buf, posdata);
  AddTagToStream(XmlStream, 'nhis:gender', Format('value="%d"',[Integer(NzisGender)]));
  Nationality := 'BG';//  zzzzzzzzzzzzzzzzzzz pat.getAnsiStringMap(buf, posData, word(PatientNew_FNAME));
  AddTagToStream(XmlStream, 'nhis:nationality', Format('value="%s"',[Nationality]), false);


  AddTagToStream(XmlStream, 'nhis:name', '');
  patFName := pat.getAnsiStringMap(buf, posData, word(PatientNew_FNAME));
  patSName := pat.getAnsiStringMap(buf, posData, word(PatientNew_SNAME));
  patLname := pat.getAnsiStringMap(buf, posData, word(PatientNew_LNAME));
  AddTagToStream(XmlStream, 'nhis:given', Format('value="%s"',[patFName]), false);
  if Length(patSName) >1 then
  begin
    AddTagToStream(XmlStream, 'nhis:middle', Format('value="%s"',[patSName]), false);
  end;
  AddTagToStream(XmlStream, 'nhis:family', Format('value="%s"',[patLName]), false);
  AddTagToStream(XmlStream, '/nhis:name', '');


  AddTagToStream(XmlStream, '/nhis:subject', '');

  AddTagToStream(XmlStream, 'nhis:performer', '');

  AddTagToStream(XmlStream, 'nhis:pmi', Format('value="%s"',[SenderId]), false);
//  if performer.Fdeput <> nil then
//  begin
//    AddTagToStream('nhis:pmiDeputy', Format('value="%s"',[self.Fdeput.FPmi]), false);
//  end;
  qualification := '1043';// performer.getAnsiStringMap(buf, posData, word(doct))
  NhifCodeSpec := '00';

  AddTagToStream(XmlStream, 'nhis:qualification', Format('value="%s" nhifCode="%s"',
        [qualification, NhifCodeSpec]), false);
//  if Self.Fdeput <> nil then
//    AddTagToStream('nhis:role', Format('value="%d"',[Integer(self.Fdeput.FRole)]), false)
//  else
    AddTagToStream(XmlStream, 'nhis:role', Format('value="%d"',[1]), false);
//  FillXmlStreamLKK;
  AddTagToStream(XmlStream, 'nhis:practiceNumber', Format('value="%s"',[CollPrac.Items[0].getAnsiStringMap(buf, posData, word(Practica_NOMER_LZ))]), false);

  AddTagToStream(XmlStream, '/nhis:performer', '');

  addTagToStream(XmlStream, '/nhis:contents', '');
  addTagToStream(XmlStream, '/nhis:message', '');

  NodeSended := TNodesSendedToNzis.create(AdbLink);
  NodeSended.node := PregNode;
  XmlStream.Position := 0;
  NodeSended.XmlReq.LoadFromStream(XmlStream, TEncoding.UTF8);
  IndexInListSended := LstNodeSended.Add(NodeSended);


end;

procedure TADBDataModule.FillXmlStreamX003(XmlStream: TXmlStream; PregNode: PVirtualNode; var IndexInListSended: integer; correctionReason: string);
var
  i, j, k: Integer;
  preg: TRealPregledNewItem;
  performer: TRealDoctorItem;
  pat: TRealPatientNewItem;
  dataPreg: PAspRec;
  dataPerf: PAspRec;
  dataPat: PAspRec;
  dataDiag: PAspRec;

  dataPlaned: PAspRec;
  dataQuest: PAspRec;
  dataAnsw: PAspRec;
  dataAnswVal: PAspRec;

  dataDiagRep: PAspRec;
  dataResDiagRep: PAspRec;


  buf: Pointer;
  posData: Cardinal;
  PregNodes: TPregledNodes;

  SenderId: string;
  LRN: string;
  OpenDate: TDateTime;
  BrdDate: TDate;
  BrdDateStr: string;
  OpenDateStr, CloseDateStr: string;
  PregClass: TNzisPregledType;
  rhifAreaNumber: string;
  IdentifierNzis: string;
  patEgn: string;
  NzisPidType: TNZISidentifierType;
  NzisGender: TNzisGender;
  patFName, patSName, patLname: string;
  qualification, NhifCodeSpec: string;
  Nationality: string;
  nrn: string;
  quest133, answ134, valNomen, cl138Code, cl139Key, valueQuant, valueStr, valueDate: string;
  diagRep142, resDiagRep144, resDiagRep139, category012, valueUnit: string;
  Cl028Code: Word;
  logPat: TlogicalPatientNewSet;
  ques: TQuests;
  answ: TAnsws;
  valNode: PVirtualNode;
  NomenPos139: Cardinal;
  valDate: TDate;

  DiagRep: TDiagRep;
  resDiagRepNode: PVirtualNode;
  dataResVal: PAspRec;
  NomenPos144: Cardinal;
  
  IsRes: Boolean;
  NodeSended: TNodesSendedToNzis;
begin
  XmlStream.Clear;
  XmlStream.CurrentLine := 2; // първите два реда са от създаването
  buf := AdbHip.Buf;
  posData := AdbHip.FPosData;
  dataPreg := pointer(PByte(PregNode) + lenNode);
  preg := TRealPregledNewItem.Create(nil);
  preg.DataPos := dataPreg.DataPos;
  preg.CalcTypes(buf, posData);
  PregNodes := GetPregNodes(PregNode);// обикаля дървото

  InitPerformer(XmlStream, PregNodes, performer );

  pat := TRealPatientNewItem.Create(nil);
  dataPat := pointer(PByte(PregNodes.patNode) + lenNode);
  pat.DataPos := dataPat.DataPos;
  nrn := Copy(CollPregled.getAnsiStringMap(dataPreg.DataPos, word(PregledNew_NRN_LRN)), 1, 12);

  logPat := TlogicalPatientNewSet(pat.getLogical32Map(buf, posData, word(PatientNew_Logical)));

  SenderId := performer.getAnsiStringMap(buf, posData, word(Doctor_UIN));
  if correctionReason = '' then
  begin
    FillXmlStreamHeader(XmlStream, X003, SenderId);
  end
  else
  begin
    FillXmlStreamHeader(XmlStream, X009, SenderId);
  end;
  addTagToStream(XmlStream, 'nhis:contents', '');
  AddTagToStream(XmlStream, 'nhis:examination', '');
  AddTagToStream(XmlStream, 'nhis:nrnExamination', Format('value="%s"',[nrn]), false);

  if correctionReason <> '' then
  begin
    lrn := Copy(CollPregled.GetAnsiStringMap(dataPreg.DataPos, Word(PregledNew_NRN_LRN)), 13, 36);
    AddTagToStream(XmlStream, 'nhis:lrn', Format('value="%s"',[LRN]), false);
  end;

  AddTagToStream(XmlStream, 'nhis:directedBy', Format('value="%d"',[8]), false);
  AddTagToStream(XmlStream, 'nhis:isSecondary', Format('value="%s"',['false']), false);
  CloseDateStr := DateToISO8601(TTimeZone.Local.ToUniversalTime(now));
  AddTagToStream(XmlStream, 'nhis:closeDate', Format('value="%s"',[CloseDateStr]), false);
  AddTagToStream(XmlStream, 'nhis:purpose',  Format('value="%d"',[Integer(preg.clcPorpuse)]));
  FillXmlStreamPlannedType(XmlStream, PregNodes);
  if correctionReason <> '' then
  begin
    AddTagToStream(XmlStream, 'nhis:correctionReason', Format('value="%s"',[correctionReason]), false);
    AddTagToStream(XmlStream, 'nhis:class', Format('value="%d"',[Integer(preg.clcClass)]));
    AddTagToStream(XmlStream, 'nhis:financingSource', Format('value="%d"',[Integer(preg.clcFinancingSource)]));
    rhifAreaNumber := PregNodes.getRhifAreaNumber(buf, posData);
    AddTagToStream(XmlStream, 'nhis:rhifAreaNumber', Format('value="%s"',[rhifAreaNumber]));
  end;
  AddTagToStream(XmlStream, 'nhis:incidentalVisit', Format('value="%s"',['false']), false);
  AddTagToStream(XmlStream, 'nhis:adverseConditions', Format('value="%s"',['false']), false);

  FillXmlStreamDiag(XmlStream, PregNodes);
  FillXmlStreamMedicalHistory(XmlStream, PregNodes);
  FillXmlStreamObjectiveCondition(XmlStream, PregNodes, logPat);





  AddTagToStream(XmlStream, '/nhis:examination', '');



  addTagToStream(XmlStream, '/nhis:contents', '');
  addTagToStream(XmlStream, '/nhis:message', '');

  NodeSended := TNodesSendedToNzis.create(AdbLink);
  NodeSended.node := PregNode;
  XmlStream.Position := 0;
  NodeSended.XmlReq.LoadFromStream(XmlStream);//, TEncoding.UTF8);
  IndexInListSended := LstNodeSended.Add(NodeSended);
end;

procedure TADBDataModule.FillXmlStreamX005(XmlStream: TXmlStream; PregNode: PVirtualNode);
var
  preg: TRealPregledNewItem;
  performer: TRealDoctorItem;
  pat: TRealPatientNewItem;
  dataPreg: PAspRec;
  dataPerf: PAspRec;
  dataPat: PAspRec;
  buf: Pointer;
  posData: Cardinal;
  PregNodes: TPregledNodes;

  SenderId: string;
  LRN, dateLrn: string;
  NrnLrn: string;
  OpenDate: TDateTime;
  BrdDate: TDate;
  BrdDateStr: string;
  OpenDateStr: string;
  PregClass: TNzisPregledType;
  rhifAreaNumber: string;
  IdentifierNzis: string;
  patEgn: string;
  NzisPidType: TNZISidentifierType;
  NzisGender: TNzisGender;
  patFName, patSName, patLname: string;
  qualification, NhifCodeSpec: string;
  Nationality: string;
  NodeSended: TNodesSendedToNzis;
begin
  XmlStream.Clear;
  buf := AdbHip.Buf;
  posData := AdbHip.FPosData;
  dataPreg := pointer(PByte(PregNode) + lenNode);
  preg := TRealPregledNewItem.Create(nil);
  preg.DataPos := dataPreg.DataPos;
  preg.CalcTypes(buf, posData);
  PregNodes := GetPregNodes(PregNode);// обикаля дървото
  performer := TRealDoctorItem.Create(nil);
  if PregNodes.perfNode <> nil then
  begin
    dataPerf := pointer(PByte(PregNodes.perfNode) + lenNode);
  end
  else
  begin
    dataPerf := pointer(PByte(PregNodes.docNode) + lenNode);
  end;
  performer.DataPos := dataPerf.DataPos;
  pat := TRealPatientNewItem.Create(nil);
  dataPat := pointer(PByte(PregNodes.patNode) + lenNode);
  pat.DataPos := dataPat.DataPos;


  SenderId := performer.getAnsiStringMap(buf, posData, word(Doctor_UIN));
  FillXmlStreamHeader(XmlStream, X005, SenderId);
  addTagToStream(XmlStream, 'nhis:contents', '');

  NrnLrn := CollPregled.GetAnsiStringMap(dataPreg.DataPos, Word(PregledNew_NRN_LRN));

  if NrnLrn.StartsWith('_') then
  begin
    lrn := Copy(NrnLrn, 13, 36);
    dateLrn := Copy (NrnLrn, 2, 10);
    dateLrn := dateLrn.Replace('.', '-');
  end
  else
  begin
    lrn := Copy(NrnLrn, 13, 36);
    OpenDate := preg.getDateMap(buf, posData, word(PregledNew_START_DATE));
    dateLrn := FormatDateTime('YYYY-MM-DD ', OpenDate);
  end;

  AddTagToStream(XmlStream, 'nhis:lrn', Format('value="%s"',[lrn]), false);
  AddTagToStream(XmlStream, 'nhis:openDate', Format('value="%s"',[dateLrn]), false);
  addTagToStream(XmlStream, '/nhis:contents', '');
  addTagToStream(XmlStream, '/nhis:message', '');

  NodeSended := TNodesSendedToNzis.create(AdbLink);
  NodeSended.node := PregNode;
  XmlStream.Position := 0;
  NodeSended.XmlReq.LoadFromStream(XmlStream, TEncoding.UTF8);
  //IndexInListSended := LstNodeSended.Add(NodeSended);


end;

procedure TADBDataModule.FillXmlStreamX009(XmlStream: TXmlStream; PregNode: PVirtualNode; var IndexInListSended: integer; correctionReason: string);
begin
  FillXmlStreamX003(XmlStream, PregNode, IndexInListSended, correctionReason);
end;

procedure TADBDataModule.FillXmlStreamX013(XmlStream: TXmlStream; PregNode: PVirtualNode);
var
  preg: TRealPregledNewItem;
  performer: TRealDoctorItem;
  pat: TRealPatientNewItem;
  dataPreg: PAspRec;
  dataPerf: PAspRec;
  dataPat: PAspRec;
  buf: Pointer;
  posData: Cardinal;
  PregNodes: TPregledNodes;

  SenderId: string;
  LRN, dateLrn: string;
  OpenDate: TDateTime;
  BrdDate: TDate;
  BrdDateStr: string;
  OpenDateStr, CloseDateStr: string;
  PregClass: TNzisPregledType;
  rhifAreaNumber: string;
  IdentifierNzis: string;
  patEgn: string;
  NzisPidType: TNZISidentifierType;
  NzisGender: TNzisGender;
  patFName, patSName, patLname: string;
  qualification, NhifCodeSpec: string;
  Nationality: string;
  NodeSended: TNodesSendedToNzis;
  logPat: TlogicalPatientNewSet;
begin
  XmlStream.Clear;
  buf := AdbHip.Buf;
  posData := AdbHip.FPosData;
  dataPreg := pointer(PByte(PregNode) + lenNode);
  preg := TRealPregledNewItem.Create(nil);
  preg.DataPos := dataPreg.DataPos;
  preg.CalcTypes(buf, posData);
  PregNodes := GetPregNodes(PregNode);// обикаля дървото
  performer := TRealDoctorItem.Create(nil);
  if PregNodes.perfNode <> nil then
  begin
    dataPerf := pointer(PByte(PregNodes.perfNode) + lenNode);
  end
  else
  begin
    dataPerf := pointer(PByte(PregNodes.docNode) + lenNode);
  end;
  performer.DataPos := dataPerf.DataPos;
  pat := TRealPatientNewItem.Create(nil);
  dataPat := pointer(PByte(PregNodes.patNode) + lenNode);
  pat.DataPos := dataPat.DataPos;
  logPat := TlogicalPatientNewSet(pat.getLogical32Map(buf, posData, word(PatientNew_Logical)));

  SenderId := performer.getAnsiStringMap(buf, posData, word(Doctor_UIN));
  FillXmlStreamHeader(XmlStream, X013, SenderId);
  addTagToStream(XmlStream, 'nhis:contents', '');
  AddTagToStream(XmlStream, 'nhis:examination', '');
  lrn := Copy(CollPregled.GetAnsiStringMap(dataPreg.DataPos, Word(PregledNew_NRN_LRN)), 13, 36);
  AddTagToStream(XmlStream, 'nhis:lrn', Format('value="%s"',[LRN]), false);
  OpenDate := preg.getDateMap(buf, posData, word(PregledNew_START_DATE)) +
              preg.getDateMap(buf, posData, word(PregledNew_START_TIME));
  OpenDate := UserDate;//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
  dateLrn := FormatDateTime('_YYYY.MM.DD ', OpenDate);
  CollPregled.SetAnsiStringMap(dataPreg.DataPos, Word(PregledNew_NRN_LRN), dateLrn + lrn);
  OpenDateStr := DateToISO8601(TTimeZone.Local.ToUniversalTime(OpenDate));
  AddTagToStream(XmlStream, 'nhis:openDate', Format('value="%s"',[OpenDateStr]), false);
  CloseDateStr := DateToISO8601(TTimeZone.Local.ToUniversalTime(UserDate));
  AddTagToStream(XmlStream, 'nhis:closeDate', Format('value="%s"',[CloseDateStr]), false);
  AddTagToStream(XmlStream, 'nhis:class', Format('value="%d"',[Integer(preg.clcClass)]));
  AddTagToStream(XmlStream, 'nhis:directedBy', Format('value="%d"',[8]), false);
  AddTagToStream(XmlStream, 'nhis:isSecondary', Format('value="%s"',['false']), false);
  AddTagToStream(XmlStream, 'nhis:financingSource', Format('value="%d"',[Integer(preg.clcFinancingSource)]));
  AddTagToStream(XmlStream, 'nhis:purpose',  Format('value="%d"',[Integer(preg.clcPorpuse)]));
  FillXmlStreamPlannedType(XmlStream, PregNodes);

  AddTagToStream(XmlStream, 'nhis:incidentalVisit', Format('value="%s"',['false']), false);
  AddTagToStream(XmlStream, 'nhis:adverseConditions', Format('value="%s"',['false']), false);




  rhifAreaNumber := PregNodes.getRhifAreaNumber(buf, posData);
  AddTagToStream(XmlStream, 'nhis:rhifAreaNumber', Format('value="%s"',[rhifAreaNumber]));

  AddTagToStream(XmlStream, 'nhis:incidentalVisit', Format('value="%s"',['false']), false);
  AddTagToStream(XmlStream, 'nhis:adverseConditions', Format('value="%s"',['false']), false);

  FillXmlStreamDiag(XmlStream, PregNodes);
  FillXmlStreamMedicalHistory(XmlStream, PregNodes);
  FillXmlStreamObjectiveCondition(XmlStream, PregNodes, logPat);

  AddTagToStream(XmlStream, '/nhis:examination', '');

  AddTagToStream(XmlStream, 'nhis:subject', '');

  IdentifierNzis := pat.getAnsiStringMap(buf, posData, word(PatientNew_NZIS_PID));
  patEgn := pat.getAnsiStringMap(buf, posData, word(PatientNew_EGN));

  NzisPidType := PregNodes.GetNZISPidType(buf, posdata);

  if IdentifierNzis = '' then
  begin
    AddTagToStream(XmlStream, 'nhis:identifierType', Format('value="%d"',[Integer(NzisPidType)]), false);
    AddTagToStream(XmlStream, 'nhis:identifier', Format('value="%s"',[patEgn] ), false);
  end
  else
  begin
    AddTagToStream(XmlStream, 'nhis:identifierType', Format('value="%d"',[Integer(NzisPidType)]), false);
    AddTagToStream(XmlStream, 'nhis:identifier', Format('value="%s"',[IdentifierNzis] ), false);
  end;
  BrdDate := pat.getDateMap(buf, posData, word(PatientNew_BIRTH_DATE));
  BrdDateStr := FormatDateTime('YYYY-MM-DD', BrdDate);

  AddTagToStream(XmlStream, 'nhis:birthDate', Format('value="%s"',[BrdDateStr]));
  NzisGender := PregNodes.GetNzisGender(buf, posdata);
  AddTagToStream(XmlStream, 'nhis:gender', Format('value="%d"',[Integer(NzisGender)]));
  Nationality := 'BG';//  zzzzzzzzzzzzzzzzzzz pat.getAnsiStringMap(buf, posData, word(PatientNew_FNAME));
  AddTagToStream(XmlStream, 'nhis:nationality', Format('value="%s"',[Nationality]), false);


  AddTagToStream(XmlStream, 'nhis:name', '');
  patFName := pat.getAnsiStringMap(buf, posData, word(PatientNew_FNAME));
  patSName := pat.getAnsiStringMap(buf, posData, word(PatientNew_SNAME));
  patLname := pat.getAnsiStringMap(buf, posData, word(PatientNew_LNAME));
  AddTagToStream(XmlStream, 'nhis:given', Format('value="%s"',[patFName]), false);
  if Length(patSName) >1 then
  begin
    AddTagToStream(XmlStream, 'nhis:middle', Format('value="%s"',[patSName]), false);
  end;
  AddTagToStream(XmlStream, 'nhis:family', Format('value="%s"',[patLName]), false);
  AddTagToStream(XmlStream, '/nhis:name', '');


  AddTagToStream(XmlStream, '/nhis:subject', '');

  AddTagToStream(XmlStream, 'nhis:performer', '');

  AddTagToStream(XmlStream, 'nhis:pmi', Format('value="%s"',[SenderId]), false);
//  if performer.Fdeput <> nil then
//  begin
//    AddTagToStream('nhis:pmiDeputy', Format('value="%s"',[self.Fdeput.FPmi]), false);
//  end;
  qualification := '1043';// performer.getAnsiStringMap(buf, posData, word(doct))
  NhifCodeSpec := '00';

  AddTagToStream(XmlStream, 'nhis:qualification', Format('value="%s" nhifCode="%s"',
        [qualification, NhifCodeSpec]), false);
//  if Self.Fdeput <> nil then
//    AddTagToStream('nhis:role', Format('value="%d"',[Integer(self.Fdeput.FRole)]), false)
//  else
    AddTagToStream(XmlStream, 'nhis:role', Format('value="%d"',[1]), false);
//  FillXmlStreamLKK;
  AddTagToStream(XmlStream, 'nhis:practiceNumber', Format('value="%s"',[CollPrac.Items[0].getAnsiStringMap(buf, posData, word(Practica_NOMER_LZ))]), false);

  AddTagToStream(XmlStream, '/nhis:performer', '');

  addTagToStream(XmlStream, '/nhis:contents', '');
  addTagToStream(XmlStream, '/nhis:message', '');

  //NodeSended := TNodesSendedToNzis.create;
//  NodeSended.node := PregNode;
//  XmlStream.Position := 0;
//  NodeSended.XmlReq.LoadFromStream(XmlStream, TEncoding.UTF8);
//  IndexInListSended := LstNodeSended.Add(NodeSended);


end;

procedure TADBDataModule.FormatingXML(stream: TStream);
var
  oXml: IXMLDocument;
  ls: TStringList;
begin
  try
    stream.Position := 0;
    ls := TStringList.Create;
    ls.LoadFromStream(stream, TEncoding.UTF8);
    oXml := TXMLDocument.Create(nil);
    oXml.LoadFromXML(Xml.XMLDoc.FormatXMLData(ls.Text));
    oXml.Encoding := 'UTF-8';
    stream.Size := 0;
    oXml.SaveToStream(stream);
    stream.Position := 0;
  finally
    if oXml.Active then
    begin
      oXml.ChildNodes.Clear;
      oXml.Active := False;
    end;
    oxml := nil;
    ls.Free;
  end;
end;

procedure TADBDataModule.FormatingXML(ls: TStringList);
var
  oXml: IXMLDocument;
begin
  try
    oXml := TXMLDocument.Create(nil);
    //oXml.Options := oXml.Options + [doNodeAutoIndent];
    //oXml.NodeIndentStr := '  ';
    oXml.LoadFromXML(ls.Text);
    oXml.Encoding := 'UTF-8';
    ls.Assign(oXml.XML);
  finally
    if oXml.Active then
    begin
      oXml.ChildNodes.Clear;
      oXml.Active := False;
    end;
    oxml := nil;
  end;
end;

function TADBDataModule.GetPatNodes(PatNode: PVirtualNode): TPatNodes;
var
  run, runMDN, runExamAnal: PVirtualNode;
  data, docData, dataMdn: PAspRec;
  i: Integer;
  doc, tempDoc: TRealDoctorItem;
  idDoc, idTempDoc: Integer;
begin
  Result := TPatNodes.create;
  Result.patNode := PatNode;
  run := patNode.FirstChild;// обикалям нещата в пациента
  while run <> nil do
  begin
    data := pointer(PByte(run) + lenNode);
    case data.vid of
      vvDoctor:
      begin
        Result.docNode := run;
        if data.Index < 0 then // не съм го търсил досега в колекцията
        begin
          for i := 0 to CollDoc.Count - 1 do
          begin
            doc := CollDoc.Items[i];
            if doc.DataPos = data.DataPos then
            begin
              data.index := i;
              Break;
            end;
          end;
        end;
      end;
      vvEvnt:
      begin
        Result.evnts.Add(run);
      end;
      vvPregled:
      begin
        Result.pregs.Add(run);
        runMDN := run.FirstChild;
        while runMDN <> nil do
        begin
          dataMdn := pointer(PByte(runMDN) + lenNode);
          case dataMdn.vid of
            vvMDN:
            begin
              runExamAnal := runMDN.FirstChild;
              while runExamAnal <> nil do
              begin
                result.ExamAnals.Add(runExamAnal);
                runExamAnal := runExamAnal.NextSibling;
              end;
            end;
            vvDiag:
            begin
              Result.diags.Add(runMDN);
            end;
          end;
          runMDN := runMDN.NextSibling;

        end;
      end;
    end;
    run := run.NextSibling;
  end;
end;

function TADBDataModule.GetPregNodes(PregNode: PVirtualNode): TPregledNodes;
var
  run, vPlaned, runPlaned, runQuest, runAnsw: PVirtualNode;
  runDiagRep: PVirtualNode;
  runPregled: PVirtualNode;
  data, docData, dataRunPlaned, dataRunQuest, dataRunAnsw: PAspRec;
  datarunPregled: PAspRec;
  i, idxQuest: Integer;
  doc, tempDoc: TRealDoctorItem;
  idDoc, idTempDoc: Integer;
  ques: TQuests;
  answ: TAnsws;

  diagRep: TDiagRep;
begin
  Stopwatch := TStopwatch.StartNew;
  Result := TPregledNodes.Create;
  Result.pregNode := PregNode;
  run := PregNode.FirstChild;// обикалям нещата в прегледа
  while run <> nil do
  begin
    data := pointer(PByte(run) + lenNode);
    case data.vid of
      vvPerformer:
      begin
        Result.perfNode := run;
        Result.deputNode := run.FirstChild;
        if data.Index < 0 then // не съм го търсил досега в колекцията
        begin
          for i := 0 to CollDoc.Count - 1 do
          begin
            doc := CollDoc.Items[i];
            if doc.DataPos = data.DataPos then
            begin
              data.index := i;
            end;
          end;
        end;
      end;
      vvDiag:
      begin
        Result.diags.Add(run);
      end;
      vvNZIS_PLANNED_TYPE:
      begin
        Result.Planeds.Add(run);
        vPlaned := run;
        runPlaned := vPlaned.FirstChild;
        while runPlaned <> nil do
        begin
          dataRunPlaned := pointer(PByte(runPlaned) + lenNode);
          case dataRunPlaned.vid of
            vvNZIS_QUESTIONNAIRE_RESPONSE:
            begin
              Result.SourceAnsw := TSourceAnsw(runPlaned.Dummy);
              ques := TQuests.create;
              ques.questNode := runPlaned;
              Result.Quests.Add(ques);
              runQuest := runPlaned.FirstChild;
              while runQuest <> nil do
              begin
                answ := TAnsws.create;
                answ.AnswNode := runQuest;
                ques.answs.Add(answ);
                runAnsw := runQuest.FirstChild;
                while runAnsw <> nil do  //  един въпрос може да има няколко отговора
                begin
                  answ.answValues.Add(runAnsw);
                  runAnsw := runAnsw.NextSibling;
                end;
                runQuest := runQuest.NextSibling;
              end;
            end;
            vvNZIS_DIAGNOSTIC_REPORT:
            begin
              diagRep := TDiagRep.create;
              diagRep.DiagRepNode := runPlaned;
              Result.DiagReps.Add(diagRep);
              runDiagRep := runPlaned.FirstChild;
              while runDiagRep <> nil do
              begin
                diagRep.ResDiagReps.Add(runDiagRep);

                runDiagRep := runDiagRep.NextSibling;
              end;
            end;
          end;
          runPlaned := runPlaned.NextSibling;
        end;
      end;
    end;
    run := run.NextSibling;
  end;
  Result.patNode := PregNode.Parent;
  run := Result.patNode.FirstChild;// обикалям нещата в пациента
  while run <> nil do
  begin
    data := pointer(PByte(run) + lenNode);
    case data.vid of
      vvDoctor:
      begin
        Result.docNode := run;
        if data.Index < 0 then // не съм го търсил досега в колекцията
        begin
          for i := 0 to CollDoc.Count - 1 do
          begin
            doc := CollDoc.Items[i];
            if doc.DataPos = data.DataPos then
            begin
              data.index := i;
              //data.index :=
            end;
          end;
        end;
      end;
      vvEvnt:
      begin
        Result.evnts.Add(run);
      end;
      vvPregled: // за сега само диагнозите ще търся
      begin
        runPregled := run.FirstChild;
        while runPregled <> nil do
        begin
          datarunPregled := pointer(PByte(runPregled) + lenNode);
          case datarunPregled.vid of
            vvDiag:
            begin
              Result.mkbs.Add(runPregled);
            end;
          end;
          runPregled := runPregled.NextSibling;
        end;
      end;
    end;
    run := run.NextSibling;
  end;
  Elapsed := Stopwatch.Elapsed;
  Result.log := FloatToStr(Elapsed.TotalMilliseconds);
end;

function TADBDataModule.GetURLFromMsgType(msgType: TNzisMsgType; IsTest: Boolean): string;
var
  str: AnsiString;
  url: string;
  ini: TIniFile;
  libPath, addUrl: string;
  isProxy: boolean;
begin
  addUrl := '';
  if IsTest then
  begin
    url := 'https://ptest-api.his.bg/';
  end
  else
  begin
    url := 'https://api.his.bg/';
  end;
  try
    libPath := LibraryPath;
    ini := TIniFile.Create(libPath + '\nzis.ini');
    isProxy := ini.ReadBool('Options', 'Proxy1', false);
    ini.Free;
    if isProxy then
      addUrl := 'download.kontrax.bg/proxy/';
    if IsTest then
    begin
      url := 'https://' + addUrl +'ptest-api.his.bg/';
    end
    else
    begin
      url := 'https://' + addUrl +'api.his.bg/';
    end;
  except

  end;

  try
    case msgType of
      C001: Result := url + 'v1/nomenclatures/all/get';
      C003: Result := url + 'v1/nomenclatures/all/vaccinelotnumber';
      C005: Result := url + 'v1/eimmunization/immunization/addreaction';
      C007:
      begin
        if (LoadStr(0) = 'NzisURL=') or (LoadStr(0) = '') then
        begin
           Result := url + 'v2/ereferral/laboratory/resultswitoutreferal';
        end
        else
        begin
          Result := LoadStr(0).Replace('NzisURL=', '');
        end;
      end;
      C009: Result := url + 'v2/ereferral/laboratory/batchexecution';
      C011: Result := url + 'v1/ereferral/laboratory/batchexecutionfetch';
      C013: Result := url + 'v1/commons/doctor/update-deputization';
      C015: Result := url + 'v1/commons/doctor/check-deputization';
      C041: Result := url + 'v3/commons/doctor/medical-notice-issue';
      C045: Result := url + 'v3/commons/doctor/medical-notice-cancel';

      X001: Result := url + 'v3/eexamination/examination/open';
      X003: Result := url + 'v3/eexamination/examination/close';
      X005: Result := url + 'v3/eexamination/examination/fetch';
      X007: Result := url + 'v3/eexamination/examination/cancel';
      X009: Result := url + 'v3/eexamination/examination/correct';
      X011: Result := url + 'v3/eexamination/examination/sickleave';
      X013: Result := url + 'v3/eexamination/examination/submit-offline';

      R001: Result := url + 'v2/ereferral/doctor/issue';
      R003: Result := url + 'v3/ereferral/laboratory/fetch';
      R005: Result := url + 'v2/ereferral/laboratory/results';
      R007: Result := url + 'v2/ereferral/doctor/cancel';
      R009: Result := url + 'v3/ereferral/doctor/check';
      R011: Result := url + 'v2/ereferral/laboratory/progress';
      R015: Result := url + 'v3/ereferral/doctor/fetch';
      R017: Result := url + 'v2/ereferral/doctor/reject';

      I001: Result := url + 'v1/eimmunization/immunization/issue';
      I003: Result := url + 'v1/eimmunization/immunization/fetch';
      I005: Result := url + 'v1/eimmunization/immunization/addreaction';
      I007: Result := url + '';
      I009: Result := url + '';
      I011: Result := url + 'v1/eimmunization/immunization/stornoimmunization';
      I013: Result := url + 'v1/eimmunization/immunization/certificate';

      P001: Result := url + 'v3/eprescription/doctor/issue';
      P003: Result := url + 'v3/eprescription/pharmacy/fetch';
      P005: Result := url + 'v3/eprescription/pharmacy/dispense';
      P007: Result := url + 'v3/eprescription/doctor/cancel';
      P009: Result := url + 'v3/eprescription/pharmacy/reject';
      P011: Result := url + 'v3/eprescription/pharmacy/dispense-offline';
      P013: Result := url + 'v3/eprescription/pharmacy/fetchdispense';
      P015: Result := url + 'v3/eprescription/pharmacy/canceldispense';

      H001: Result := url + 'v1/ehospitalization/hospitalization/fetch';
      H011: Result := url + 'v1/ehospitalization/hospitalization/fetch-births';

      L009: Result := url + 'v1/longterm-care/doctor/fetch-prophylactic-activities';
    end;
  finally
  end;

end;



procedure TADBDataModule.InitPerformer(XmlStream: TXmlStream; PregNodes: TPregledNodes; var performer: TRealDoctorItem);
var
  dataPerf: PAspRec;
  slotNom, i: Integer;
  pin: string;
begin
  //performer := TRealDoctorItem.Create(nil);
  if PregNodes.perfNode <> nil then
  begin
    dataPerf := pointer(PByte(PregNodes.perfNode) + lenNode);
  end
  else
  begin
    dataPerf := pointer(PByte(PregNodes.docNode) + lenNode);
  end;
  performer := CollDoc.FindDoctorFromDataPos(dataPerf.DataPos);
  if true then
  begin
    if performer.SlotTokenSerial = '' then
    begin
      ShowMessage('ne e pyhnata');
      Exit;
    end
    else
    begin
      if performer.CertStorage = nil then
      begin
        performer.CertStorage := TsbxCertificateStorage.Create(nil);
        performer.CertStorage.RuntimeLicense := '5342444641444E585246323032313132303443344D393232353000000000000000000000000000005A5036484E353744000038554650524E4839314636410000';
        slotNom := performer.SlotNom;
        for i := 0 to CollCert.Count - 1 do
        begin
          if Trim(CollCert.getAnsiStringMap(CollCert.Items[i].DataPos, Word(Certificates_SLOT_ID))) = performer.SlotTokenSerial then
          begin
            pin := Trim(CollCert.getAnsiStringMap(CollCert.Items[i].DataPos, Word(Certificates_Pin)));
            performer.CertStorage.Open (Format('pkcs11://user:%s@/C:\Windows\System32\eTPKCS11.dll?slot=%d&readonly=0', [pin, slotNom]));
            Break;
          end;
        end;
      end;
      XmlStream.performer := performer;
    end;
  end
  else
  begin
    XmlStream.performer := performer;
  end;
end;

procedure TADBDataModule.ReadXmlL010(streamL010: TStream; ls: TStrings);
var
  data: PAspRec;
  NRN: AnsiString;
  NzisStatus: word;
  AL010: L010.IXMLMessageType;
  xmlDoc: TXMLDocument;
  gr: TGraphPeriod132 ;
  i, j: Integer;
  grNzis: IXMLPlannedExaminationType;
  fs: TFormatSettings;
  lstGraph: TList<TGraphPeriod132>;
begin
  lstGraph := TList<TGraphPeriod132>.Create;
  fs := TFormatSettings.Create();
  fs.DateSeparator := '-';
  fs.ShortDateFormat := 'YYYY-MM-DD';
  xmlDoc := TXMLDocument.Create(nil);
  streamL010.Position := 0;
  xmlDoc.XML.LoadFromStream(streamL010);
  AL010 := L010.Getmessage(xmlDoc);
  if AL010.Header.MessageType.Value = 'L010' then
  begin
    for i := 0 to AL010.Contents.Count - 1 do
    begin
      ls.Add(#13#10);
      grNzis := AL010.Contents.PlannedExamination[i];



      ls.Add('CL132 ' + grNzis.PlannedType.Value);
      ls.Add('CL136 ' + IntToStr(grNzis.PlannedCategory.Value));
      ls.Add('CL141 ' + IntToStr(grNzis.PlannedStatus.Value));
      ls.Add('FromDate' + grNzis.FromDate.Value);
      gr.startDate := StrToDate(grNzis.FromDate.Value, fs);
      ls.Add('ToDate ' + grNzis.ToDate.Value);
      gr.endDate := StrToDate(grNzis.ToDate.Value, fs);
      gr.Cl132 := trealcl132Item.Create(nil);
      lstGraph.Add(gr);
      //gr.Cl132.
      //ls.Add('ToDate ' + grNzis.Activities.Value);
    end;
  end
  else
  begin
    Exit;
  end;
  //showmessage(DateTimeToStr(lstGraph[12].startDate));
end;

procedure TADBDataModule.ReadXmlL010Preg(streamL010: TStream; pregNodes: TPregledNodes);
var
  data: PAspRec;
  NRN: AnsiString;
  NzisStatus: word;
  AL010: L010.IXMLMessageType;
  xmlDoc: TXMLDocument;
  i, j, k: Integer;
  grNzis: IXMLPlannedExaminationType;
  fs: TFormatSettings;
  PlanType: TRealNZIS_PLANNED_TYPEItem;
  nodePlan: PVirtualNode;
  planeStatus: TPlanedStatusSet;
  nzisPlanAct: IXMLActivitiesType;
  startDate, enddate: TDate;
begin
  fs := TFormatSettings.Create();
  fs.DateSeparator := '-';
  fs.ShortDateFormat := 'YYYY-MM-DD';
  xmlDoc := TXMLDocument.Create(nil);
  streamL010.Position := 0;
  xmlDoc.XML.LoadFromStream(streamL010);
  AL010 := L010.Getmessage(xmlDoc);
  if AL010.Header.MessageType.Value = 'L010' then
  begin
    for i := 0 to AL010.Contents.Count - 1 do
    begin
      grNzis := AL010.Contents.PlannedExamination[i];
      PlanType := TRealNZIS_PLANNED_TYPEItem.Create(nil);
      New(PlanType.PRecord);
      PlanType.PRecord.CL132_KEY := grNzis.PlannedType.Value;
      PlanType.PRecord.StartDate := StrToDate(grNzis.FromDate.Value, fs);
      PlanType.PRecord.EndDate := StrToDate(grNzis.ToDate.Value, fs);
      PlanType.Status := grNzis.PlannedStatus.Value;
      for j := 0 to pregNodes.Planeds.Count - 1 do
      begin
        nodePlan := pregNodes.Planeds[j];
        data := Pointer(PByte(nodePlan) + lenNode);

        if CollNZIS_PLANNED_TYPE.getAnsiStringMap(data.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY)) = PlanType.PRecord.CL132_KEY then
        begin
          if floor(CollNZIS_PLANNED_TYPE.getDateMap(data.DataPos, word(NZIS_PLANNED_TYPE_StartDate))) <> Floor(PlanType.PRecord.StartDate) then
          begin
            listLog.Add(PlanType.PRecord.CL132_KEY);
          end;
          if floor(CollNZIS_PLANNED_TYPE.getDateMap(data.DataPos, word(NZIS_PLANNED_TYPE_EndDate))) <> Floor(PlanType.PRecord.EndDate) then
          begin
            listLog.Add(PlanType.PRecord.CL132_KEY);
          end;

          PlanType.DataPos := data.DataPos;
          planeStatus := TPlanedStatusSet(nodePlan.Dummy);
          Include(planeStatus, TPlanedStatus.psInNzis);
          case PlanType.Status of
            1:
            begin
              planeStatus := planeStatus - [TPlanedStatus.psNzisPartiallyCompleted, TPlanedStatus.psNzisCompleted];
              Include(planeStatus, TPlanedStatus.psNzisPending);
            end;
            2:
            begin
              planeStatus := planeStatus - [TPlanedStatus.psNzisPending, TPlanedStatus.psNzisCompleted];
              Include(planeStatus, TPlanedStatus.psNzisPartiallyCompleted);
            end;
            3:
            begin
              planeStatus := planeStatus - [TPlanedStatus.psNzisPending, TPlanedStatus.psNzisPartiallyCompleted];
              Include(planeStatus, TPlanedStatus.psNzisCompleted);
            end;
          end;

          nodePlan.Dummy := Byte(planeStatus);
          PlanType.Status := PlanType.Status + 100;
          for k := 0 to grNzis.Activities.Count - 1 do
          begin
            //nzisPlanAct.Nrn
          end;

          Break;
        end;
      end;
      if PlanType.Status < 100 then
      begin
        listLog.Add(PlanType.PRecord.CL132_KEY);
      end;
    end;
  end
  else
  begin
    Exit;
  end;
end;

procedure TADBDataModule.ReadXmlL010PregTest(streamL010: TStream;
  pregNodes: TPregledNodes);
var
  data: PAspRec;
  NRN: AnsiString;
  NzisStatus: word;
  AL010: L010.IXMLMessageType;
  xmlDoc: TXMLDocument;
  i, j, k: Integer;
  grNzis: IXMLPlannedExaminationType;
  fs: TFormatSettings;
  PlanType: TRealNZIS_PLANNED_TYPEItem;
  nodePlan: PVirtualNode;
  planeStatus: TPlanedStatusSet;
  nzisPlanAct: IXMLActivitiesType;
  startDate, enddate: TDate;
begin
  fs := TFormatSettings.Create();
  fs.DateSeparator := '-';
  fs.ShortDateFormat := 'YYYY-MM-DD';
  xmlDoc := TXMLDocument.Create(nil);
  streamL010.Position := 0;
  xmlDoc.XML.LoadFromStream(streamL010);
  AL010 := L010.Getmessage(xmlDoc);
  if AL010.Header.MessageType.Value = 'L010' then
  begin
      for i := 0 to pregNodes.Planeds.Count - 1 do
      begin
        nodePlan := pregNodes.Planeds[i];
        data := Pointer(PByte(nodePlan) + lenNode);
        for j := 0 to AL010.Contents.Count - 1 do
        begin
          grNzis := AL010.Contents.PlannedExamination[j];
          PlanType := TRealNZIS_PLANNED_TYPEItem.Create(nil);
          New(PlanType.PRecord);
          PlanType.PRecord.CL132_KEY := grNzis.PlannedType.Value;
          PlanType.PRecord.StartDate := StrToDate(grNzis.FromDate.Value, fs);
          PlanType.PRecord.EndDate := StrToDate(grNzis.ToDate.Value, fs);
          PlanType.Status := grNzis.PlannedStatus.Value;
          if CollNZIS_PLANNED_TYPE.getAnsiStringMap(data.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY)) = PlanType.PRecord.CL132_KEY then
          begin
            if floor(CollNZIS_PLANNED_TYPE.getDateMap(data.DataPos, word(NZIS_PLANNED_TYPE_StartDate))) <> Floor(PlanType.PRecord.StartDate) then
            begin
              listLog.Add(PlanType.PRecord.CL132_KEY);
            end;
            if floor(CollNZIS_PLANNED_TYPE.getDateMap(data.DataPos, word(NZIS_PLANNED_TYPE_EndDate))) <> Floor(PlanType.PRecord.EndDate) then
            begin
              listLog.Add(PlanType.PRecord.CL132_KEY);
            end;

            PlanType.DataPos := data.DataPos;
            planeStatus := TPlanedStatusSet(nodePlan.Dummy);
            Include(planeStatus, TPlanedStatus.psInNzis);
            case PlanType.Status of
              1:
              begin
                planeStatus := planeStatus - [TPlanedStatus.psNzisPartiallyCompleted, TPlanedStatus.psNzisCompleted];
                Include(planeStatus, TPlanedStatus.psNzisPending);
              end;
              2:
              begin
                planeStatus := planeStatus - [TPlanedStatus.psNzisPending, TPlanedStatus.psNzisCompleted];
                Include(planeStatus, TPlanedStatus.psNzisPartiallyCompleted);
              end;
              3:
              begin
                planeStatus := planeStatus - [TPlanedStatus.psNzisPending, TPlanedStatus.psNzisPartiallyCompleted];
                Include(planeStatus, TPlanedStatus.psNzisCompleted);
              end;
            end;

            nodePlan.Dummy := Byte(planeStatus);
            PlanType.Status := PlanType.Status + 100;
            //for k := 0 to grNzis.Activities.Count - 1 do
//            begin
//              //nzisPlanAct.Nrn
//            end;

            Break;
          end;
        end;
      end;
      if PlanType.Status < 100 then
      begin
        listLog.Add(PlanType.PRecord.CL132_KEY);
      end;
  end
  else
  begin
    Exit;
  end;
end;

{ TPregledNodes }

constructor TPregledNodes.create;
begin
  inherited;
  mkbs := TList<PVirtualNode>.Create;
  diags := TList<PVirtualNode>.Create;
  evnts := TList<PVirtualNode>.Create;
  Planeds := TList<PVirtualNode>.Create;
  Quests := TList<TQuests>.Create;
  DiagReps := TList<TDiagRep>.Create;
end;

destructor TPregledNodes.destroy;
begin
  FreeAndNil(mkbs);
  FreeAndNil(diags);
  FreeAndNil(evnts);
  FreeAndNil(Planeds);
  FreeAndNil(Quests);
  FreeAndNil(DiagReps);
  inherited;
end;

function TPregledNodes.GetNzisGender(buf: pointer; posdata: cardinal): TNzisGender;
var
  logPat: TlogicalPatientNewSet;
  dataPat: PAspRec;
  pat: TRealPatientNewItem;
begin
  dataPat := pointer(PByte(patNode) + lenNode);
  pat := TRealPatientNewItem.Create(nil);
  pat.DataPos := dataPat.DataPos;
  logPat := TlogicalPatientNewSet(pat.getLogical32Map(buf, posdata, word(PatientNew_Logical)));
  if SEX_TYPE_M in logPat then Result := TNzisGender.gbMale
  else if SEX_TYPE_F in logPat then Result := TNzisGender.gbFemale
  else  Result := TNzisGender.gbUnknown;
  FreeAndNil(pat);
end;

function TPregledNodes.GetNZISPidType(buf: pointer; posdata: cardinal): TNZISidentifierType;
var
  logPat: TlogicalPatientNewSet;
  dataPat: PAspRec;
  pat: TRealPatientNewItem;
begin
  dataPat := pointer(PByte(patNode) + lenNode);
  pat := TRealPatientNewItem.Create(nil);
  pat.DataPos := dataPat.DataPos;
  logPat := TlogicalPatientNewSet(pat.getLogical32Map(buf, posdata, word(PatientNew_Logical)));
  if PID_TYPE_E in logPat then Result := TNZISidentifierType.itbEGN
  else if PID_TYPE_B in logPat then Result := TNZISidentifierType.itbNBN
  else if PID_TYPE_F in logPat then Result := TNZISidentifierType.itbOther
  else if PID_TYPE_L in logPat then Result := TNZISidentifierType.itbLNZ
  else if PID_TYPE_S in logPat then Result := TNZISidentifierType.itbSSN;
  FreeAndNil(pat);
end;

function TPregledNodes.getRhifAreaNumber(buf: pointer; posdata: cardinal): string;
var
  rzokEvn, rzokREvn: string;
  i: Integer;
  dataEvn: PAspRec;
  EvnTemp: TRealEventsManyTimesItem;
  logEvnt: TlogicalEventsManyTimesSet;
  Aevnt: TLogicalEventsManyTimes;
begin

  for i := 0 to evnts.Count - 1 do
  begin
    dataEvn := pointer(PByte(evnts[i]) + lenNode);
    EvnTemp := TRealEventsManyTimesItem.Create(nil);
    EvnTemp.DataPos := dataEvn.DataPos;
    logEvnt := TlogicalEventsManyTimesSet(EvnTemp.getLogical24Map(buf, posData, word(EventsManyTimes_Logical)));
    for Aevnt in logEvnt do
    begin
      case Aevnt of
        RZOK:
        begin
          rzokEvn := EvnTemp.getAnsiStringMap(Buf, posData, word(EventsManyTimes_valAnsiString));
        end;
        RZOKR:
        begin
          rzokREvn := EvnTemp.getAnsiStringMap(Buf, posData, word(EventsManyTimes_valAnsiString));
        end;
      end;
    end;
  end;
  Result := rzokEvn + rzokREvn;
  Result := '0202';//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
  FreeAndNil(EvnTemp);
end;

{ TPatNodes }



constructor TPatNodes.create;
begin
  inherited;
  evnts := TList<PVirtualNode>.create;
  ExamAnals := TList<PVirtualNode>.create;
  diags := TList<PVirtualNode>.create;
  pregs := TList<PVirtualNode>.create;
end;

destructor TPatNodes.destroy;
begin
  FreeAndNil(evnts);
  FreeAndNil(ExamAnals);
  FreeAndNil(diags);
  FreeAndNil(pregs);
  inherited;
end;

function TPatNodes.GetNZISPidType(buf: pointer; posdata: cardinal): TNZISidentifierType;
var
  logPat: TlogicalPatientNewSet;
  dataPat: PAspRec;
  pat: TRealPatientNewItem;
begin
  dataPat := pointer(PByte(patNode) + lenNode);
  pat := TRealPatientNewItem.Create(nil);
  pat.DataPos := dataPat.DataPos;
  logPat := TlogicalPatientNewSet(pat.getLogical32Map(buf, posdata, word(PatientNew_Logical)));
  if PID_TYPE_E in logPat then Result := TNZISidentifierType.itbEGN
  else if PID_TYPE_B in logPat then Result := TNZISidentifierType.itbNBN
  else if PID_TYPE_F in logPat then Result := TNZISidentifierType.itbOther
  else if PID_TYPE_L in logPat then Result := TNZISidentifierType.itbLNZ
  else if PID_TYPE_S in logPat then Result := TNZISidentifierType.itbSSN;
  FreeAndNil(pat);
end;



function TPatNodes.GetPrevProfPregled(dateNow: TDate; pregColl: TPregledNewColl; exceptPreg: TRealPregledNewItem): Cardinal;
var
  i: Integer;
  data: PAspRec;
  delta: Word;
  datePreg: TDate;
  log40: TLogicalData40;
  profSet: set of TLogicalPregledNew;
begin
  Result := 0;
  delta := MAXWORD;
  profSet := [TLogicalPregledNew.IS_PREVENTIVE
            , TLogicalPregledNew.IS_PREVENTIVE_Maternal
            , TLogicalPregledNew.IS_PREVENTIVE_Childrens
            , TLogicalPregledNew.IS_PREVENTIVE_Adults];


  for i := 0 to pregs.Count -1 do
  begin
    data := Pointer(PByte(pregs[i]) + lenNode);
    if exceptPreg <> nil then
    begin
      if exceptPreg.DataPos = data.DataPos then
      begin
        Continue;
      end;
    end;
    datePreg := pregColl.getDateMap(data.DataPos, word(PregledNew_START_DATE));
    if datePreg > dateNow  then
      Continue;
    log40 := pregColl.getLogical40Map(data.DataPos, word(PregledNew_Logical));
    if (profSet  *  TlogicalPregledNewSet(log40))= [] then
      continue ;
    if (Floor(dateNow) - Floor(datePreg)) < delta then
    begin
      delta := (Floor(dateNow) - Floor(datePreg));
      Result := data.DataPos;
    end;
  end;
end;

procedure TPatNodes.SortDiag(SortIsAsc: Boolean);
var
 ListDataPos: TList<PVirtualNode>;
 i: Integer;
 ListAnsi: TList<AnsiString>;

procedure QuickSort(L, R: Integer);
var
    I, J, P : Integer;
    Save : AnsiString;
    saveList: PVirtualNode;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        if SortIsAsc then
        begin
          while (ListAnsi[I])< (ListAnsi[P]) do Inc(I);
          while (ListAnsi[J]) > (ListAnsi[P]) do Dec(J);
        end
        else
        begin
          while (ListAnsi[I])> (ListAnsi[P]) do Inc(I);
          while (ListAnsi[J]) < (ListAnsi[P]) do Dec(J);
        end;
        if I <= J then begin
          Save := ListAnsi[I];
          saveList := ListDataPos[I];
          ListAnsi[I] := ListAnsi[J];
          ListDataPos[I] := ListDataPos[J];
          ListAnsi[J] := Save;
          ListDataPos[J] := saveList;
          if P = I then
            P := J
          else if P = J then
            P := I;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then QuickSort(L, J);
      L := I;
    until I >= R;
  end;
begin
  ListDataPos := Self.diags;
  ListAnsi := TList<AnsiString>.Create;
  if (ListDataPos.count >1 ) then
  begin
    for i := 0 to ListDataPos.Count - 1 do
      ListAnsi.Add(CollDiag.getAnsiStringMap(PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos, word(Diagnosis_code_CL011)));
    QuickSort(0,ListAnsi.count-1);
    ListAnsi.Clear;
    ListAnsi.Free;
  end;
end;

{ TQuests }

constructor TQuests.create;
begin
  inherited;
  answs := TList<TAnsws>.Create;
end;

destructor TQuests.destroy;
begin
  FreeAndNil(answs);
  inherited;
end;

{ TAnsws }

constructor TAnsws.create;
begin
  inherited;
  answValues := TListNodes.Create;;
end;

destructor TAnsws.destroy;
begin
  FreeAndNil(answValues);
  inherited;
end;

{ TDiagRep }

constructor TDiagRep.create;
begin
  inherited;
  ResDiagReps := TListNodes.Create;
end;

destructor TDiagRep.destroy;
begin
  FreeAndNil(ResDiagReps);
  inherited;
end;

{ TNodesSendedToNzis }

constructor TNodesSendedToNzis.create(AAdbLink: TMappedLinkFile);
begin
  XmlResp := TStringList.Create();
  XmlReq := TStringList.Create;
  AdbLink := AAdbLink;
end;

destructor TNodesSendedToNzis.destroy;
begin
  FreeAndNil(XmlResp);
  FreeAndNil(XmlReq);
  inherited;
end;

function TNodesSendedToNzis.GetLinkPos: cardinal;
begin
  Result := cardinal(self.node) - Cardinal(AdbLink.Buf);
end;

procedure TNodesSendedToNzis.LoadFromFile(filename: string);
var
  FF: TFileStream;
  linkPos: Cardinal;
  len: Word;
  stream: TMemoryStream;
begin
  FF := TFileStream.Create(filename, fmOpenReadWrite);
  FF.Position := 0;
  FF.read(linkPos, 4);
  node := SetNode(linkPos);
  FF.read(len, 2);
  stream := TMemoryStream.Create;
  stream.CopyFrom(FF, len);
  stream.Position := 0;
  XmlReq.LoadFromStream(stream);
//  XmlReq.SaveToStream(ff, TEncoding.ANSI);
//  len := length(XmlResp.Text);
//  FF.Write(Len, 2);
//  XmlResp.SaveToStream(ff, TEncoding.ANSI);
  stream.Free;
  FF.Free;
end;

procedure TNodesSendedToNzis.SaveToFile(filename: string);
var
  FF: TFileStream;
  linkPos: Cardinal;
  len: Word;
begin
  FF := TFileStream.Create(filename, fmOpenReadWrite);
  FF.Position := FF.Size;
  linkPos := GetLinkPos;
  FF.Write(linkPos, 4);
  len := length(XmlReq.Text);
  FF.Write(Len, 2);
  XmlReq.SaveToStream(ff, TEncoding.ANSI);
  len := length(XmlResp.Text);
  FF.Write(Len, 2);
  XmlResp.SaveToStream(ff, TEncoding.ANSI);
  FF.Free;
end;

function TNodesSendedToNzis.SetNode(linkPos: cardinal): PVirtualNode;
begin
  Result := pointer(PByte(AdbLink.Buf) + linkPos);
end;

end.
