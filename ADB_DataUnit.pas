unit ADB_DataUnit;
        //plannedType
interface
uses
  System.Classes, system.IniFiles, system.SysUtils, Winapi.Windows,
  System.Rtti, system.DateUtils, Xml.XMLIntf, System.Math,
  System.Generics.Collections, Vcl.Dialogs, system.Diagnostics, System.TimeSpan,
  Aspects.Collections, Aspects.Types, VirtualStringTreeAspect, VirtualTrees,
  Table.PregledNew, Table.PatientNew, Table.Doctor, Table.Diagnosis, Table.Addres,
  Table.Practica, Table.CL132, Table.NZIS_PLANNED_TYPE, Table.NZIS_QUESTIONNAIRE_RESPONSE,
  Table.NZIS_QUESTIONNAIRE_ANSWER, Table.NZIS_ANSWER_VALUE, Table.CL139,
  Table.NZIS_DIAGNOSTIC_REPORT, Table.NZIS_RESULT_DIAGNOSTIC_REPORT, Table.CL144,
  Table.Certificates, Table.Mkb, Table.AnalsNew, Table.NasMesto, Table.BLANKA_MED_NAPR,
  Table.INC_NAPR,Table.NzisToken, Table.CL050, Table.NomenNzis, Table.NzisReqResp,
  ProfGraph, RealObj.NzisNomen, RealNasMesto
  , Nzis.Types, RealObj.RealHipp, L010, Xml.XMLDoc
  , SBxCertificateStorage, Nzis.Nomen.baseCL000, DM, Vcl.StdCtrls;

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

  TNomenNzisRec = class
  public
    Cl000Coll: TCL000EntryCollection;
    xmlStream: TMemoryStream;
    AspColl: TBaseCollection;
    nomenNzis: TNomenNzisItem;
    constructor Create;
    destructor Destroy;  override;
  end;

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
    Planeds: TListNodes;
    Quests: TList<TQuests>;
    DiagReps: TList<TDiagRep>;
    SourceAnsw: TSourceAnsw;
    incNaprNode: PVirtualNode;
    ReqesterNode: PVirtualNode;
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
    addresses: TList<PVirtualNode>;
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
    FAdbMain: TMappedFile;
    FAdbNomenNzis: TMappedFile;
    FAdbNomenNZOK: TMappedFile;
    FAdbNomenHip: TMappedFile;
    FAdbMainLink: TMappedLinkFile;
    FOnClearColl: TNotifyEvent;
    FFDM: TDUNzis;
    FNasMestaLink: TMappedLinkFile;
    FAdbOptionFileName: string;
    FAdbNzisNomenFileName: string;
    FAdbNasMestoFileName: string;
    FAdbNzokNomenFileName: string;
    FAdbMainFileName: string;
    FAdbHipNomenFileName: string;
    FmmoTest: Tmemo;
    procedure SetAdbMain(const Value: TMappedFile);
    procedure SetAdbNomenHip(const Value: TMappedFile);
    procedure SetAdbNomenNzis(const Value: TMappedFile);
    procedure SetAdbNomenNZOK(const Value: TMappedFile);
    //procedure SetNasMestaLink(const Value: TMappedLinkFile);
    procedure SetAdbHipNomenFileName(const Value: string);
    procedure SetAdbMainFileName(const Value: string);
    procedure SetAdbNasMestoFileName(const Value: string);
    procedure SetAdbNzisNomenFileName(const Value: string);
    procedure SetAdbNzokNomenFileName(const Value: string);
    procedure SetAdbOptionFileName(const Value: string);
    //FPatNodes: TPatNodes;
  protected
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    ver: string;
    streamCmdFile: TFileCmdStream;
    StreamCmdFileTemp: TFileCmdStream;
    streamCmdFileNomenNzis: TFileCmdStream;
    procedure AddTagToStream(XmlStream: TXmlStream;NameTag, ValueTag :string; amp: Boolean = true; Node: PVirtualNode = nil);

    procedure FillXmlStreamHeader(XmlStream: TXmlStream; msgType: TNzisMsgType; SenderID: string);
    procedure FillXmlStreamPlannedType(XmlStream: TXmlStream; PregNodes: TPregledNodes);
    procedure FillXmlStreamDiag(XmlStream: TXmlStream; PregNodes: TPregledNodes);
    procedure FillXmlStreamMedicalHistory(XmlStream: TXmlStream; PregNodes: TPregledNodes);
    procedure FillXmlStreamObjectiveCondition(XmlStream: TXmlStream; PregNodes: TPregledNodes; logPat: TlogicalPatientNewSet);
    procedure InitColl;
    procedure ReInitColl;
    procedure SetCmdColl;
    procedure FreeColl;
    procedure ClearColl;
    procedure OpenADB(ADB: TMappedFile);
    procedure OpenCmd(ADB: TMappedFile);
    procedure OpenLinkPatPreg(LNK: TMappedLinkFile);
    procedure AddToListNodes(data: PAspRec);

  public
    CollPregled: TRealPregledNewColl;
    CollPractica: TPracticaColl;
    CollDoctor: TRealDoctorColl;
    CollUnfav: TRealUnfavColl;
    CollPatient: TRealPatientNewColl;
    CollPatPis: TRealPatientNZOKColl;
    CollDiag: TRealDiagnosisColl;
    CollMDN: TRealMDNColl;
    CollEbl: TRealExam_boln_listColl;
    CollExamAnal: TRealExamAnalysisColl;
    CollExamImun: TRealExamImmunizationColl;
    CollProceduresPreg: TRealProceduresColl;
    CollCardProf: TRealKARTA_PROFILAKTIKA2017Coll;
    CollMedNapr: TRealBLANKA_MED_NAPRColl;
    CollMedNapr3A: TRealBLANKA_MED_NAPR_3AColl;
    CollMedNaprHosp: TRealHOSPITALIZATIONColl;
    CollMedNaprLkk: TRealEXAM_LKKColl;
    CollIncMdn: TRealINC_MDNColl;
    CollIncMN: TRealINC_NAPRColl;
    CollOtherDoctor: TRealOtherDoctorColl;
    CollNZIS_PLANNED_TYPE: TRealNZIS_PLANNED_TYPEColl;
    CollNZIS_QUESTIONNAIRE_RESPONSE: TRealNZIS_QUESTIONNAIRE_RESPONSEColl;
    CollNZIS_QUESTIONNAIRE_ANSWER: TRealNZIS_QUESTIONNAIRE_ANSWERColl;
    CollNZIS_ANSWER_VALUE: TRealNZIS_ANSWER_VALUEColl;
    CollNZIS_DIAGNOSTIC_REPORT: TRealNZIS_DIAGNOSTIC_REPORTColl;
    CollNzis_RESULT_DIAGNOSTIC_REPORT: TRealNZIS_RESULT_DIAGNOSTIC_REPORTColl;
    CollNzisToken: TNzisTokenColl;
    CollCertificates: TCertificatesColl;
    CollMkb: TRealMkbColl;
    CollAnalsNew: TAnalsNewColl;

    CL006Coll: TRealCL006Coll;
    CL009Coll: TRealCL009Coll;
    CL011Coll: TRealCL011Coll;
    CL022Coll: TRealCL022Coll;
    CL024Coll: TRealCL024Coll;
    CL037Coll: TRealCL037Coll;
    CL038Coll: TRealCL038Coll;
    CL050Coll: TCL050Coll;
    CL088Coll: TRealCL088Coll;
    CL132Coll: TRealCL132Coll;
    CL134Coll: TRealCL134Coll;
    CL139Coll: TRealCL139Coll;
    CL142Coll: TRealCL142Coll;
    CL144Coll: TRealCl144Coll;
    PR001Coll: TRealPR001Coll;
    NomenNzisColl: TNomenNzisColl;
    ProceduresNomenColl: TRealProceduresColl;

    AmsgColl: TNzisReqRespColl;
    ACollPatGR: TRealPatientNewColl;
    AcollpatFromDoctor: TRealPatientNewColl;
    ACollPatFDB: TRealPatientNewColl;
    ACollNovozapisani: TRealPatientNewColl;



    lstPatGraph: TList<TRealPatientNewItem>;
    ListPregledForFDB: TList<TPregledNewItem>;
    ListDoctorForFDB: TList<TDoctorItem>;
    ListPregledLinkForInsert: TList<PVirtualNode>;
    CollPregledVtor: TList<TRealPregledNewItem>;
    CollPregledPrim: TList<TRealPregledNewItem>;
    LstPatForExportDB: TList<TRealPatientNewItem>;
    LstPregForExportDB: TList<TRealPregledNewItem>;
    ListPatientForFDB: TList<TPatientNewItem>;
    ListNomenNzisNames: TList<TNomenNzisRec>;

  public
    listLog: TStringList;
    lstColl: TList<TBaseCollection>;

    //AdbMain: TMappedFile;
    AdbLink: TMappedLinkFile;
    NasMesto: TRealNasMestoAspects;
    cmdFile: TFileStream;
    VtrMain: TVirtualStringTreeAspect;
    VtrNasMesta: TVirtualStringTreeAspect;
    strGuid: string;
    LstNodeSended: TList<TNodesSendedToNzis>;
    ListPrimDocuments: TList<TBaseCollection>;

    procedure AddNewDiag(vPreg: PVirtualNode; cl011, cl011Add: string; rank: integer; DataPosMkb: cardinal);
    procedure AddNewPreg(OldPreg: TRealPregledNewItem; ParentNode: PVirtualNode;
         var treeLink: PVirtualNode; linkPos: Cardinal);
    procedure AddNewImportNzisPat(Pat: TRealPatientNewItem; treeLink: PVirtualNode);

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

    procedure OpenDB(FFDbName: string);
    procedure OpenADBNomenHip(FileName: string);
    procedure OpenADBNomenNzis(FileName: string);
    procedure OpenCmdNomenNzis(ADBNomenNzis: TMappedFile);
    procedure initDB(FFDbName: string);
    procedure FindLNK(AGUID: TGUID);
    procedure FindADB(AGUID: TList<TGUID>);

    property patEgn: string read FPatEgn;
    property AdbMain: TMappedFile read FAdbMain write SetAdbMain; // адб на главните колекции
    property AdbNomenNzis: TMappedFile read FAdbNomenNzis write SetAdbNomenNzis;// нзис-ка номенклатура
    property AdbNomenHip: TMappedFile read FAdbNomenHip write SetAdbNomenHip; // Наша номенклатура
    property AdbNomenNZOK: TMappedFile read FAdbNomenNZOK write SetAdbNomenNZOK; // НЗОК номенклатура

    property AdbMainLink: TMappedLinkFile read FAdbMainLink write FAdbMainLink;
    //property NasMestaLink: TMappedLinkFile read FNasMestaLink write SetNasMestaLink;
    property FDM: TDUNzis read FFDM write FFDM;

    property OnClearColl: TNotifyEvent read FOnClearColl write FOnClearColl;
    property mmoTest: Tmemo read FmmoTest write FmmoTest;

    //ADB файлове
    property AdbMainFileName: string  read FAdbMainFileName write SetAdbMainFileName;
    property AdbOptionFileName: string read FAdbOptionFileName write SetAdbOptionFileName;
    property AdbNasMestoFileName: string read FAdbNasMestoFileName write SetAdbNasMestoFileName;
    property AdbNzisNomenFileName: string read FAdbNzisNomenFileName write SetAdbNzisNomenFileName;
    property AdbHipNomenFileName: string read FAdbHipNomenFileName write SetAdbHipNomenFileName;
    property AdbNzokNomenFileName: string read FAdbNzokNomenFileName write SetAdbNzokNomenFileName;


  end;


implementation

uses
  system.IOUtils;

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

procedure TADBDataModule.AddNewImportNzisPat(Pat: TRealPatientNewItem; treeLink: PVirtualNode);
var
  newPat: TRealPatientNewItem;
  newAddres: TRealAddresItem;
  newIncMN: TRealINC_NAPRItem;
  newIncDoctor: TRealOtherDoctorItem;
  newPreg: TRealPregledNewItem;

  linkPos: Cardinal;
  PatNode, incMNNode, IncDocNode: PVirtualNode;
  i, j: Integer;
begin
  if Pat.DataPos <> 0 then
  begin
    for i := 0 to Pat.FIncMNs.Count - 1 do
    begin
      if Pat.FIncMNs[i].DataPos <> 0 then
        Continue;
      newIncMN := TRealINC_NAPRItem(CollIncMN.Add);
      newIncMN.FIncDoctor := Pat.FIncMNs[i].FIncDoctor;
      newIncMN.PRecord := Pat.FIncMNs[i].PRecord;
      newIncMN.InsertINC_NAPR;
      Dispose(newIncMN.PRecord);
      newIncMN.PRecord := nil;
      Pat.FIncMNs[i].DataPos := newIncMN.DataPos;
      AdbLink.AddNewNode(vvIncMN, newIncMN.DataPos, Pat.FNode, amAddChildFirst, incMNNode, linkPos);

      if newIncMN.FIncDoctor.DataPos = 0 then
      begin
        newIncDoctor := TRealOtherDoctorItem(CollOtherDoctor.Add);
        newIncDoctor.PRecord := newIncMN.FIncDoctor.PRecord;
        newIncDoctor.InsertOtherDoctor;
        Dispose(newIncDoctor.PRecord);
        newIncDoctor.PRecord := nil;
        AdbLink.AddNewNode(vvOtherDoctor, newIncDoctor.DataPos, incMNNode, amAddChildFirst, IncDocNode, linkPos);
      end
      else
      begin
        AdbLink.AddNewNode(vvOtherDoctor, newIncMN.FIncDoctor.DataPos, incMNNode, amAddChildFirst, IncDocNode, linkPos);
      end;

      for j := 0 to Pat.FIncMNs[i].FPregledi.Count - 1 do
      begin
        AddNewPreg(Pat.FIncMNs[i].FPregledi[j], incMNNode, treeLink, linkPos);
      end;
    end;

    for i := 0 to Pat.FPregledi.Count - 1 do
    begin
      AddNewPreg(Pat.FPregledi[i], Pat.FNode, treeLink, linkPos);
    end;
    Exit;
  end;
  newPat := TRealPatientNewItem(CollPatient.add);
  New(newPat.PRecord);
  newPat.PRecord.setProp :=
     [PatientNew_EGN, PatientNew_BIRTH_DATE, PatientNew_FNAME, PatientNew_SNAME, PatientNew_LNAME, PatientNew_Logical, PatientNew_ID];
  newPat.PRecord.EGN := Pat.PRecord.EGN;
  newPat.PRecord.BIRTH_DATE := Pat.PRecord.BIRTH_DATE;
  newPat.PRecord.FNAME := Pat.PRecord.FNAME;
  newPat.PRecord.SNAME := Pat.PRecord.SNAME;
  newPat.PRecord.LNAME := Pat.PRecord.LNAME;
  newPat.PRecord.ID := 0;
  newPat.PRecord.Logical := Pat.PRecord.Logical;
  newPat.InsertPatientNew;
  Dispose(newPat.PRecord);
  newPat.PRecord := nil;
  Pat.DataPos := newPat.DataPos;
  AdbLink.AddNewNode(vvPatient, newPat.DataPos, AdbLink.FVTR.RootNode.FirstChild, amAddChildFirst, patnode, linkPos);
  Pat.FNode := patnode;

  newAddres := TRealAddresItem(NasMesto.addresColl.Add);
  New(newAddres.PRecord);
  newAddres.PRecord.setProp :=
     [Addres_LinkPos];
  newAddres.PRecord.LinkPos := Pat.FAdresi[0].LinkNasMesto;
  newAddres.InsertAddres;
  Dispose(newAddres.PRecord);
  newAddres.PRecord := nil;
  AdbLink.AddNewNode(vvAddres, newAddres.DataPos, PatNode, amAddChildFirst, treeLink, linkPos);

  for i := 0 to Pat.FIncMNs.Count - 1 do
  begin
    if Pat.FIncMNs[i].DataPos <> 0 then
      Continue;
    newIncMN := TRealINC_NAPRItem(CollIncMN.Add);
    newIncMN.FIncDoctor := Pat.FIncMNs[i].FIncDoctor;
    newIncMN.PRecord := Pat.FIncMNs[i].PRecord;
    newIncMN.InsertINC_NAPR;
    Dispose(newIncMN.PRecord);
    newIncMN.PRecord := nil;
    Pat.FIncMNs[i].DataPos := newIncMN.DataPos;
    AdbLink.AddNewNode(vvIncMN, newIncMN.DataPos, Pat.FNode, amAddChildFirst, incMNNode, linkPos);

    if newIncMN.FIncDoctor.DataPos = 0 then
    begin
      newIncDoctor := TRealOtherDoctorItem(CollOtherDoctor.Add);
      newIncDoctor.PRecord := newIncMN.FIncDoctor.PRecord;
      newIncDoctor.InsertOtherDoctor;
      Dispose(newIncDoctor.PRecord);
      newIncDoctor.PRecord := nil;
      AdbLink.AddNewNode(vvOtherDoctor, newIncDoctor.DataPos, incMNNode, amAddChildFirst, IncDocNode, linkPos);
    end
    else
    begin
      AdbLink.AddNewNode(vvOtherDoctor, newIncMN.FIncDoctor.DataPos, incMNNode, amAddChildFirst, IncDocNode, linkPos);
    end;

    for j := 0 to Pat.FIncMNs[i].FPregledi.Count - 1 do
    begin
      AddNewPreg(Pat.FIncMNs[i].FPregledi[j], incMNNode, treeLink, linkPos);
    end;
  end;

  for i := 0 to Pat.FPregledi.Count - 1 do
  begin
    if Pat.FPregledi[i].DataPos <> 0 then
      Continue;
    if Pat.FPregledi[i].PRecord = nil then
    begin
      Continue;
    end;
    AddNewPreg(Pat.FPregledi[i], Pat.FNode, treeLink, linkPos);

  end;
end;

procedure TADBDataModule.AddNewPreg(OldPreg: TRealPregledNewItem;
  ParentNode: PVirtualNode; var treeLink: PVirtualNode; linkPos: Cardinal);
var
  newPreg: TRealPregledNewItem;
  newMdn: TRealMDNItem;
  newMN: TRealBLANKA_MED_NAPRItem;
  newMNHosp: TRealHOSPITALIZATIONItem;
  newMNLkk: TRealEXAM_LKKItem;
  newDiagMdn: TRealDiagnosisItem;
  newAnal: TRealExamAnalysisItem;
  i, j: Integer;
  diag: TRealDiagnosisItem;
  pregNode, mdnNode, diagNode: PVirtualNode;
begin
  if OldPreg.DataPos <> 0 then
    exit;
  newPreg := TRealPregledNewItem(CollPregled.Add);
  newPreg.PRecord := OldPreg.PRecord;
  newPreg.FDoctor := OldPreg.FDoctor;
  //newPreg.FDiagnosis
  newPreg.InsertPregledNew;
  Dispose(newPreg.PRecord);
  newPreg.PRecord := nil;
  OldPreg.DataPos := newPreg.DataPos;
  AdbLink.AddNewNode(vvPregledNew, newPreg.DataPos, ParentNode, amAddChildFirst, pregNode, linkPos);
  AdbLink.AddNewNode(vvPerformer, newPreg.FDoctor.DataPos, pregNode, amAddChildFirst, treeLink, linkPos);

  for i := 0 to OldPreg.FDiagnosis.Count - 1 do
  begin
    diag := OldPreg.FDiagnosis[i];
    //newPreg.FDiagnosis.Add(diag);
    AddNewDiag(pregNode, diag.MainMkb, diag.AddMkb, diag.Rank, 100);
  end;

  for i := 0 to OldPreg.FMdns.Count - 1 do
  begin
    try
      newMdn := TRealMDNItem(CollMDN.Add);
      newMdn.PRecord := OldPreg.FMdns[i].PRecord;
      if newMdn.PRecord = nil then
        Continue;
      newMdn.InsertMDN;
      Dispose(newMdn.PRecord);
      newMdn.PRecord := nil;
      OldPreg.FMdns[i].DataPos := newMdn.DataPos;

      AdbLink.AddNewNode(vvMDN, newMdn.DataPos, pregNode, amAddChildlast, mdnNode, linkPos);
      newDiagMdn := TRealDiagnosisItem(CollDiag.Add); //OldPreg.FMdns[i].FDiagnosis[0];
      New(newDiagMdn.PRecord);
      newDiagMdn.PRecord.setProp := [Diagnosis_code_CL011];
      newDiagMdn.PRecord.code_CL011 := OldPreg.FMdns[i].FDiagnosis[0].MainMkb;
      newDiagMdn.InsertDiagnosis;
      Dispose(newDiagMdn.PRecord);
      newDiagMdn.PRecord := nil;
      AdbLink.AddNewNode(vvdiag, newDiagMdn.DataPos, mdnNode, amAddChildlast, diagNode, linkPos);

      for j := 0 to OldPreg.FMdns[i].FExamAnals.Count - 1 do
      begin
        newAnal := TRealExamAnalysisItem(CollExamAnal.Add);
        newAnal.PRecord := OldPreg.FMdns[i].FExamAnals[j].PRecord;
        newAnal.InsertExamAnalysis;
        Dispose(newAnal.PRecord);
        newAnal.PRecord := nil;
        OldPreg.FMdns[i].FExamAnals[j].DataPos := newAnal.DataPos;
        AdbLink.AddNewNode(vvExamAnal, newAnal.DataPos, mdnNode, amAddChildlast, treeLink, linkPos);
      end;
    except
      Dispose(newMdn.PRecord);
      newMdn.PRecord := nil;
    end;
  end;

  for i := 0 to OldPreg.FMNs.Count - 1 do
  begin
    try
      newMN := TRealBLANKA_MED_NAPRItem(CollMedNapr.Add);
      newMN.PRecord := OldPreg.FMNs[i].PRecord;
      if newMN.PRecord = nil then
        Continue;
      newMN.InsertBLANKA_MED_NAPR;
      Dispose(newMN.PRecord);
      newMN.PRecord := nil;
      OldPreg.FMns[i].DataPos := newMN.DataPos;

      AdbLink.AddNewNode(vvMedNapr, newMN.DataPos, pregNode, amAddChildlast, treeLink, linkPos);
    except
      Dispose(newMN.PRecord);
      newMN.PRecord := nil;
    end;
  end;

  for i := 0 to OldPreg.FMNsHosp.Count - 1 do
  begin
    try
      newMNHosp := TRealHOSPITALIZATIONItem(CollMedNaprHosp.Add);
      newMNHosp.PRecord := OldPreg.FMNsHosp[i].PRecord;
      if newMNHosp.PRecord = nil then
        Continue;
      newMNHosp.InsertHOSPITALIZATION;
      Dispose(newMNHosp.PRecord);
      newMNHosp.PRecord := nil;
      OldPreg.FMNsHosp[i].DataPos := newMNHosp.DataPos;

      AdbLink.AddNewNode(vvMedNaprHosp, newMNHosp.DataPos, pregNode, amAddChildlast, treeLink, linkPos);
    except
      Dispose(newMNHosp.PRecord);
      newMNHosp.PRecord := nil;
    end;
  end;

  for i := 0 to OldPreg.FMNsLKK.Count - 1 do
  begin
    try
      newMNLkk := TRealEXAM_LKKItem(CollMedNaprLkk.Add);
      newMNLkk.PRecord := OldPreg.FMNsLKK[i].PRecord;
      if newMNLkk.PRecord = nil then
        Continue;
      newMNLkk.InsertEXAM_LKK;
      Dispose(newMNLkk.PRecord);
      newMNLkk.PRecord := nil;
      OldPreg.FMNsLKK[i].DataPos := newMNLkk.DataPos;

      AdbLink.AddNewNode(vvMedNaprLkk, newMNLkk.DataPos, pregNode, amAddChildlast, treeLink, linkPos);
    except
      Dispose(newMNLkk.PRecord);
      newMNLkk.PRecord := nil;
    end;
  end;
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

procedure TADBDataModule.AddToListNodes(data: PAspRec);
begin

end;

constructor TADBDataModule.Create();
begin
  inherited;
  //FPatNodes.evnts := TList<PVirtualNode>.Create;
//  FPatNodes.ExamAnals := TList<PVirtualNode>.Create;
  //XMLStream := TXmlStream.Create('', TEncoding.UTF8);

  //NasMesto := TRealNasMestoAspects.Create();

  lstColl := TList<TBaseCollection>.Create;
  LstNodeSended := TList<TNodesSendedToNzis>.Create;
  listLog := TStringList.Create;
  ListPrimDocuments := TList<TBaseCollection>.create;

  InitColl;
end;

destructor TADBDataModule.Destroy;
begin
  //FreeAndNil(XMLStream);
  FreeAndNil(LstNodeSended);
  FreeAndNil(listLog);
  FreeAndNil(ListPrimDocuments);
  FreeColl;
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
  buf := AdbMain.Buf;
  posData := AdbMain.FPosData;
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
  AddTagToStream(XmlStream, 'nhis:practiceNumber', Format('value="%s"',[CollPractica.Items[0].getAnsiStringMap(buf, posData, word(Practica_NOMER_LZ))]), false);

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
  buf := AdbMain.Buf;
  posData := AdbMain.FPosData;
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
  buf := AdbMain.Buf;
  posData := AdbMain.FPosData;
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
          Cl028Code := CollNZIS_ANSWER_VALUE.getWordMap(dataAnswVal.DataPos, word(NZIS_ANSWER_VALUE_CL028));
          case Cl028Code of
            1:
            begin
              valueQuant := Double.ToString(CollNZIS_ANSWER_VALUE.getDoubleMap(dataAnswVal.DataPos, word(NZIS_ANSWER_VALUE_ANSWER_QUANTITY)));
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
              valNomen := CollNZIS_ANSWER_VALUE.getAnsiStringMap(dataAnswVal.DataPos, word(NZIS_ANSWER_VALUE_ANSWER_CODE));
              NomenPos139 := CollNZIS_ANSWER_VALUE.getCardMap(dataAnswVal.DataPos, word(NZIS_ANSWER_VALUE_NOMEN_POS));
              cl138Code := CL139Coll.getAnsiStringMap(NomenPos139, word(CL139_cl138));
              cl139Key := CL139Coll.getAnsiStringMap(NomenPos139, word(CL139_Key));
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
              valueStr := CollNZIS_ANSWER_VALUE.getAnsiStringMap(dataAnswVal.DataPos, word(NZIS_ANSWER_VALUE_ANSWER_TEXT));
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
              valDate := CollNZIS_ANSWER_VALUE.getDateMap(dataAnswVal.DataPos, word(NZIS_ANSWER_VALUE_ANSWER_DATE));
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
        category012 := CL144Coll.getAnsiStringMap(NomenPos144, word(CL144_cl012));
        //resDiagRep139 :=  collNZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(dataResDiagRep.DataPos, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE));
        resDiagRep144 := CL144Coll.getAnsiStringMap(NomenPos144, word(CL144_Key));
        valueUnit := CL144Coll.getAnsiStringMap(NomenPos144, word(CL144_units));
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
            resDiagRep144 := CL144Coll.getAnsiStringMap(NomenPos144, word(CL144_cl138));
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
        category012 := CL144Coll.getAnsiStringMap(NomenPos144, word(CL144_cl012));
        resDiagRep144 := CL144Coll.getAnsiStringMap(NomenPos144, word(CL144_Key));
        valueUnit := CL144Coll.getAnsiStringMap(NomenPos144, word(CL144_units));
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
            resDiagRep144 := CL144Coll.getAnsiStringMap(NomenPos144, word(CL144_cl138));
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
  dataPreg, dataAddrs: PAspRec;


  dataPat: PAspRec;
  buf: Pointer;
  posData: Cardinal;
  PregNodes: TPregledNodes;
  PatNodes: TPatNodes;

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
  AddresLinkPos: Integer;

  slotNom: Integer;
  i: Integer;
  pin: string;
begin
  XmlStream.Clear;
  buf := AdbMain.Buf;
  posData := AdbMain.FPosData;
  dataPreg := pointer(PByte(PregNode) + lenNode);
  preg := TRealPregledNewItem.Create(nil);
  preg.DataPos := dataPreg.DataPos;
  preg.CalcTypes(buf, posData);
  PregNodes := GetPregNodes(PregNode);// обикаля дървото
  PatNodes := GetPatNodes(PregNodes.patNode);
  dataAddrs := pointer(PByte(PatNodes.addresses[0]) + lenNode); // ако има повече? zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz

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
  AddresLinkPos := NasMesto.addresColl.getIntMap(dataAddrs.DataPos, word(Addres_LinkPos));
  rhifAreaNumber := NasMesto.nasMestoColl.getAnsiStringMap(AddresLinkPos, word(NasMesto_RCZR));
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
  AddTagToStream(XmlStream, 'nhis:practiceNumber', Format('value="%s"',[CollPractica.Items[0].getAnsiStringMap(buf, posData, word(Practica_NOMER_LZ))]), false);

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
  dataPat, dataAddrs: PAspRec;
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
  patNodes: TPatNodes;

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
  AddresLinkPos: Integer;
begin
  XmlStream.Clear;
  XmlStream.CurrentLine := 2; // първите два реда са от създаването
  buf := AdbMain.Buf;
  posData := AdbMain.FPosData;
  dataPreg := pointer(PByte(PregNode) + lenNode);
  preg := TRealPregledNewItem.Create(nil);
  preg.DataPos := dataPreg.DataPos;
  preg.CalcTypes(buf, posData);
  PregNodes := GetPregNodes(PregNode);// обикаля дървото
  PatNodes := GetPatNodes(PregNodes.patNode);
  dataAddrs := pointer(PByte(PatNodes.addresses[0]) + lenNode); // ако има повече? zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz

  InitPerformer(XmlStream, PregNodes, performer );

  pat := TRealPatientNewItem.Create(nil);
  dataPat := pointer(PByte(PregNodes.patNode) + lenNode);
  pat.DataPos := dataPat.DataPos;
  nrn := Copy(CollPregled.getAnsiStringMap(dataPreg.DataPos, word(PregledNew_NRN_LRN)), 1, 12);

  logPat := TlogicalPatientNewSet(pat.getLogical40Map(buf, posData, word(PatientNew_Logical)));

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
    AddresLinkPos := NasMesto.addresColl.getIntMap(dataAddrs.DataPos, word(Addres_LinkPos));
    rhifAreaNumber := NasMesto.nasMestoColl.getAnsiStringMap(AddresLinkPos, word(NasMesto_RCZR));
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
  buf := AdbMain.Buf;
  posData := AdbMain.FPosData;
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
  buf := AdbMain.Buf;
  posData := AdbMain.FPosData;
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
  logPat := TlogicalPatientNewSet(pat.getLogical40Map(buf, posData, word(PatientNew_Logical)));

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
  AddTagToStream(XmlStream, 'nhis:practiceNumber', Format('value="%s"',[CollPractica.Items[0].getAnsiStringMap(buf, posData, word(Practica_NOMER_LZ))]), false);

  AddTagToStream(XmlStream, '/nhis:performer', '');

  addTagToStream(XmlStream, '/nhis:contents', '');
  addTagToStream(XmlStream, '/nhis:message', '');

  //NodeSended := TNodesSendedToNzis.create;
//  NodeSended.node := PregNode;
//  XmlStream.Position := 0;
//  NodeSended.XmlReq.LoadFromStream(XmlStream, TEncoding.UTF8);
//  IndexInListSended := LstNodeSended.Add(NodeSended);


end;

procedure TADBDataModule.FindADB(AGUID: TList<TGUID>);
var
  S: string;

  i, j: Integer;
  collType: TCollectionsType;
  aspVersion: Word;
  b: Byte;
  pByteData: ^Byte;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  pg: PGUID;

  AInt64: Int64;
  dirAdb: string;
  str1, str2: string;
begin
  if ParamStr(2) <> '' then
    dirAdb := ParamStr(2)
  else
    dirAdb := '.\';
  for S in TDirectory.GetFiles(dirAdb, '*.adb', TSearchOption.soAllDirectories) do
  begin
    Stopwatch := TStopwatch.StartNew;
    AdbMain := TMappedFile.Create(S, false, TGUID.Empty);
    Elapsed := Stopwatch.Elapsed;
   // mmotest.Lines.Add( S + ' Martin ' + FloatToStr(Elapsed.TotalMilliseconds));
    if AdbMain.Buf <> nil then
    begin
      pCardinalData := pointer(PByte(AdbMain.Buf));
      FPosMetaData := pCardinalData^;
      pCardinalData := pointer(PByte(AdbMain.Buf) + 4);
      FLenMetaData := pCardinalData^;
      pCardinalData := pointer(PByte(AdbMain.Buf) + 8);
      FPosData := pCardinalData^;
      pCardinalData := pointer(PByte(AdbMain.Buf) + 12);
      FLenData := pCardinalData^;
      Pg := pointer(PByte(AdbMain.Buf) + 16 );
      for j := 0 to AGUID.Count - 1 do
      begin
        str1 := AGUID[j].ToString;
        str2 := pg^.ToString;
        if AGUID[j] <> TGUID.Empty then
        begin
          if AGUID[j] = pg^ then
          begin

            //Panel1.Caption := 'dd';
            Exit;
          end;
        end;
      end;

      aspPos := FPosMetaData;
      AdbMain.Free;
      AdbMain := nil;  //zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
    end;
  end;
end;

procedure TADBDataModule.FindLNK(AGUID: TGUID);
var
  S: string;

  i, j: Integer;
  collType: TCollectionsType;
  aspVersion: Word;
  b: Byte;
  pByteData: ^Byte;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  pg: PGUID;

  AInt64: Int64;
  dirAdb: string;
begin
  if ParamStr(2) <> '' then
    dirAdb := ParamStr(2)
  else
    dirAdb := '.\';
  for S in TDirectory.GetFiles(dirAdb, '*Hip*.lnk', TSearchOption.soAllDirectories) do
  begin
    if FAdbMainLink <> nil then
      FAdbMainLink.Free;
    FAdbMainLink := TMappedLinkFile.Create(s, false, TGUID.Empty);
    if FAdbMainLink.Buf <> nil then
    begin
      //pCardinalData := pointer(PByte(AspectsHipFile.Buf));
//      FPosMetaData := pCardinalData^;
//      pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 4);
//      FLenMetaData := pCardinalData^;
//      pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 8);
//      FPosData := pCardinalData^;
//      pCardinalData := pointer(PByte(AspectsHipFile.Buf) + 12);
//      FLenData := pCardinalData^;
      Pg := pointer(PByte(FAdbMainLink.Buf) + 16 );
      if AGUID <> TGUID.Empty then
        begin
          if AGUID = pg^ then
          begin
            Exit;
          end;
        end;

      FAdbMainLink.Free;
      FAdbMainLink := nil;
    end;
  end;

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
          for i := 0 to CollDoctor.Count - 1 do
          begin
            doc := CollDoctor.Items[i];
            if doc.DataPos = data.DataPos then
            begin
              data.index := i;
              Break;
            end;
          end;
        end;
      end;
      vvAddres:
      begin
        Result.addresses.Add(run);
      end;
      vvPregledNew:
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
  runIncNapr: PVirtualNode;
  data, docData, dataRunPlaned, dataRunQuest, dataRunAnsw, dataParent, dataSender: PAspRec;
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
          for i := 0 to CollDoctor.Count - 1 do
          begin
            doc := CollDoctor.Items[i];
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
  dataParent := pointer(PByte(PregNode.Parent) + lenNode);
  case dataParent.vid of
    vvPatient: Result.patNode := PregNode.Parent;
    vvIncMN:
    begin
      Result.incNaprNode := PregNode.Parent;
      Result.patNode := PregNode.Parent.parent;
      runIncNapr := Result.incNaprNode.FirstChild;
      while runIncNapr <> nil do
      begin
        dataSender := pointer(PByte(runIncNapr) + lenNode);
        case dataSender.vid of
          vvOtherDoctor:
          begin
            Result.ReqesterNode := runIncNapr;
          end;
        end;
        runIncNapr := runIncNapr.NextSibling;
      end;
    end;
  end;

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
          for i := 0 to CollDoctor.Count - 1 do
          begin
            doc := CollDoctor.Items[i];
            if doc.DataPos = data.DataPos then
            begin
              data.index := i;
              //data.index :=
            end;
          end;
        end;
      end;
      //vvEvnt:
//      begin
//        Result.evnts.Add(run);
//      end;
      vvPregledNew: // за сега само диагнозите ще търся
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
  performer := CollDoctor.FindDoctorFromDataPos(dataPerf.DataPos);
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
        for i := 0 to CollCertificates.Count - 1 do
        begin
          if Trim(CollCertificates.getAnsiStringMap(CollCertificates.Items[i].DataPos, Word(Certificates_SLOT_ID))) = performer.SlotTokenSerial then
          begin
            pin := Trim(CollCertificates.getAnsiStringMap(CollCertificates.Items[i].DataPos, Word(Certificates_Pin)));
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

procedure TADBDataModule.OpenADB(ADB: TMappedFile);
var
  collType: TCollectionsType;
  aspVersion: Word;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  pg: PGUID;
  mkb: TMkbItem;
begin
  Stopwatch := TStopwatch.StartNew;
  if ADB.Buf <> nil then
  begin
    pCardinalData := pointer(PByte(ADB.Buf));
    ADB.FPosMetaData := pCardinalData^;
    pCardinalData := pointer(PByte(ADB.Buf) + 4);
    ADB.FLenMetaData := pCardinalData^;
    pCardinalData := pointer(PByte(ADB.Buf) + 8);
    ADB.FPosData := pCardinalData^;
    pCardinalData := pointer(PByte(ADB.Buf) + 12);
    ADB.FLenData := pCardinalData^;
    Pg := pointer(PByte(ADB.Buf) + 16 );
    ADB.GUID := pg^;

    aspPos := ADB.FPosMetaData;
    while aspPos < (ADB.FPosMetaData + ADB.FLenMetaData) do
    begin
      p := Pointer(pbyte(ADB.Buf) + aspPos);
      collType := TCollectionsType(p^);
      inc(aspPos, 2);

      p := Pointer(pbyte(ADB.Buf) + aspPos);
      aspVersion := word(p^);
      inc(aspPos, 2);

      case collType of

    // ===== FULL =====
        ctPractica,
        ctDoctor,
        ctOtherDoctor,
        ctMkb,
        ctNzisToken,
        ctCertificates:
          lstColl[ord(collType)].OpenAdbFull(aspPos);

        // ===== LAZY =====
        ctPregledNew,
        ctPatientNew,
        ctPatientNZOK,
        ctDiagnosis,
        ctMDN,
        ctUnfav,
        ctExam_boln_list,
        ctExamAnalysis,
        ctExamImmunization,
        ctProcedures,
        ctKARTA_PROFILAKTIKA2017,
        ctBLANKA_MED_NAPR,
        ctBLANKA_MED_NAPR_3A,
        ctHOSPITALIZATION,
        ctEXAM_LKK,
        ctINC_MDN,
        ctINC_NAPR,
        ctNZIS_PLANNED_TYPE,
        ctNZIS_QUESTIONNAIRE_RESPONSE,
        ctNZIS_QUESTIONNAIRE_ANSWER,
        ctNZIS_DIAGNOSTIC_REPORT,
        ctNZIS_RESULT_DIAGNOSTIC_REPORT,
        ctNZIS_ANSWER_VALUE:
          begin
            Inc(aspPos, lstColl[ord(collType)].FieldCount * 4);
            lstColl[ord(collType)].IncCntInADB;
          end;

        // ===== DELETED =====
        ctDiagnosisDel,
        ctUnfavDel,
        ctProceduresDel,
        ctKARTA_PROFILAKTIKA2017Del,
        ctBLANKA_MED_NAPRDel,
        ctBLANKA_MED_NAPR_3ADel,
        ctHOSPITALIZATIONDel,
        ctEXAM_LKKDel,
        ctINC_MDNDel,
        ctINC_NAPRDel,
        ctNZIS_PLANNED_TYPEDel,
        ctNZIS_QUESTIONNAIRE_RESPONSEDel,
        ctNZIS_QUESTIONNAIRE_ANSWERDel,
        ctNZIS_ANSWER_VALUEDel,
        ctOtherDoctorDel,
        ctCL142Del,
        ctPregledNewDel,
        ctCL006Del,
        ctCL022Del:
        begin
          Inc(aspPos, lstColl[ord(collType)].FieldCount * 4);
        end;

        //ctAddres:
//        begin
//          //Inc(aspPos, (FNasMesto.addresColl.FieldCount) * 4);
////          FNasMesto.addresColl.IncCntInADB;
//        end;
      else
        Inc(aspPos, lstColl[ord(collType)].FieldCount * 4);
        //raise Exception.Create('Непознат : collType' + TRttiEnumerationType.GetName(collType));
      end;
    end;
  end;


  //FNasMesto.addresColl.Buf := ADB.Buf;
//  FNasMesto.addresColl.posData := ADB.FPosData;


  Elapsed := Stopwatch.Elapsed;
  //mmoTest.Lines.Add( Format('Зареждане за %f',[Elapsed.TotalMilliseconds]));
  //mmoTest.Lines.endUpdate;

  //CalcStatusDB;
//  FDBHelper.AdbHip := ADB;
//  FDBHelper.Fdm := Fdm;
//  FDBHelper.NasMesto := FNasMesto;
//  FDBHelper.Adb_DM := Adb_DM;
//
//
//  FDBHelper.AdbLink := AspectsLinkPatPregFile;
//  Adb_DM.AdbMain := ADB;
//  Adb_DM.AdbLink := AspectsLinkPatPregFile;
//  Adb_DM.NasMesto := FNasMesto;

end;

procedure TADBDataModule.OpenADBNomenHip(FileName: string);
var
  i, j: Integer;
  collType: TCollectionsType;
  aspVersion: Word;
  b: Byte;
  pByteData: ^Byte;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  anal: TAnalsNewItem;

  AInt64: Int64;
begin
  if FAdbNomenHip <> nil then
    FAdbNomenHip.Free;
  FAdbNomenHip := TMappedFile.Create(FileName, false, TGUID.Empty);
  FPosData := FAdbNomenHip.FPosData;


  if FAdbNomenHip.Buf <> nil then
  begin
    CollAnalsNew.Buf := FAdbNomenHip.Buf;
    CollAnalsNew.posData := FAdbNomenHip.FPosData;


    pCardinalData := pointer(PByte(FAdbNomenHip.Buf));
    FPosMetaData := pCardinalData^;
    pCardinalData := pointer(PByte(FAdbNomenHip.Buf) + 4);
    FLenMetaData := pCardinalData^;
    pCardinalData := pointer(PByte(FAdbNomenHip.Buf) + 8);
    FPosData := pCardinalData^;
    pCardinalData := pointer(PByte(FAdbNomenHip.Buf) + 12);
    FLenData := pCardinalData^;
    aspPos := FPosMetaData;
    begin
      while aspPos < (FPosMetaData + FLenMetaData) do
      begin
        p := Pointer(pbyte(FAdbNomenHip.Buf) + aspPos);
        collType := TCollectionsType(p^);
        inc(aspPos, 2);

        p := Pointer(pbyte(FAdbNomenHip.Buf) + aspPos);
        aspVersion := word(p^);
        inc(aspPos, 2);

        case collType of
          ctAnalsNew:
          begin
            anal := TAnalsNewItem(CollAnalsNew.Add);
            anal.DataPos := aspPos;
            Inc(aspPos, (CollAnalsNew.FieldCount) * 4);
          end;

        end;
      end;
    end;
  end;
end;

procedure TADBDataModule.OpenADBNomenNzis(FileName: string);
var
  i, j: Integer;
  collType: TCollectionsType;
  aspVersion: Word;
  b: Byte;
  pByteData: ^Byte;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  //FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;

  NomenNzis: TNomenNzisItem;
  fileStr: TFileStream;

  AInt64: Int64;
begin
  Stopwatch := TStopwatch.StartNew;
  if FAdbNomenNzis <> nil then
    Exit;
    //AspectsNomFile.Free;
  try
    FAdbNomenNzis := TMappedFile.Create(FileName, false, TGUID.Empty);

  except

  end;


  if (FAdbNomenNzis <> nil) and (FAdbNomenNzis.Buf <> nil) then
  begin
    ReInitColl;
    pCardinalData := pointer(PByte(FAdbNomenNzis.Buf));
    FAdbNomenNzis.FPosMetaData := pCardinalData^;
    pCardinalData := pointer(PByte(FAdbNomenNzis.Buf) + 4);
    FAdbNomenNzis.FLenMetaData := pCardinalData^;
    pCardinalData := pointer(PByte(FAdbNomenNzis.Buf) + 8);
    FAdbNomenNzis.FPosData := pCardinalData^;
    pCardinalData := pointer(PByte(FAdbNomenNzis.Buf) + 12);
    FAdbNomenNzis.FLenData := pCardinalData^;
    aspPos := FAdbNomenNzis.FPosMetaData;
    begin
      while aspPos < (FAdbNomenNzis.FPosMetaData + FAdbNomenNzis.FLenMetaData) do
      begin
        p := Pointer(pbyte(FAdbNomenNzis.Buf) + aspPos);
        collType := TCollectionsType(p^);
        inc(aspPos, 2);

        p := Pointer(pbyte(FAdbNomenNzis.Buf) + aspPos);
        aspVersion := word(p^);
        inc(aspPos, 2);

        //try
//          lstColl[Ord(collType)].OpenAdbFull(aspPos);
//        except
//          ShowMessage('ddd');
//        end;

        case collType of
          ctCL132:
          begin
            //Cl132 := TCL132Item(CL132Coll.Add);
            //Cl132.DataPos := aspPos;
            Inc(aspPos, (CL132Coll.FieldCount) * 4);
          end;
          ctCL050:
          begin
            //Cl050 := TCL050Item(CL050Coll.Add);
//            Cl050.DataPos := aspPos;
            Inc(aspPos, (CL050Coll.FieldCount) * 4);
          end;
          ctCL006, ctCL006Del, ctCL006Old:
          begin
            lstColl[ord(ctCL006)].OpenAdbFull(aspPos);
          end;
          ctCl011, ctCL009:
          begin
            lstColl[ord(collType)].OpenAdbFull(aspPos);
          end;

          ctCL022:
          begin
            //Cl022 := TCL022Item(Adb_DM.CL022Coll.Add);
//            Cl022.DataPos := aspPos;
            Inc(aspPos, (CL022Coll.FieldCount) * 4);
          end;
          ctCL024:
          begin
            //Cl024 := TCL024Item(Adb_DM.CL024Coll.Add);
//            Cl024.DataPos := aspPos;
            Inc(aspPos, (CL024Coll.FieldCount) * 4);
          end;
          ctCL037:
          begin
            //Cl037 := TCL037Item(Adb_DM.CL037Coll.Add);
//            Cl037.DataPos := aspPos;
            Inc(aspPos, (CL037Coll.FieldCount) * 4);
          end;
          ctCL038:
          begin
            //Cl038 := TCL038Item(Adb_DM.CL038Coll.Add);
//            Cl038.DataPos := aspPos;
            Inc(aspPos, (CL038Coll.FieldCount) * 4);
          end;
          ctCL088:
          begin
            //Cl088 := TCL088Item(Adb_DM.CL088Coll.Add);
//            Cl088.DataPos := aspPos;
            Inc(aspPos, (CL088Coll.FieldCount) * 4);
          end;


          ctCL134:
          begin
            //Cl134 := TCl134Item(Adb_DM.Cl134Coll.Add);
//            Cl134.DataPos := aspPos;
            Inc(aspPos, (Cl134Coll.FieldCount) * 4);
          end;
          ctCL139:
          begin
            //Cl139 := TCl139Item(Adb_DM.Cl139Coll.Add);
//            Cl139.DataPos := aspPos;
            Inc(aspPos, (Cl139Coll.FieldCount) * 4);
          end;
          ctCL142:
          begin
            //Cl142 := TCl142Item(Adb_DM.Cl142Coll.Add);
//            Cl142.DataPos := aspPos;
            Inc(aspPos, (Cl142Coll.FieldCount) * 4);
          end;
          ctCL144:
          begin
            //Cl144 := TRealCl144Item(Adb_DM.Cl144Coll.Add);
//            Cl144.DataPos := aspPos;
            Inc(aspPos, (Cl144Coll.FieldCount) * 4);
          end;

          ctPR001:
          begin
            //PR001 := TPR001Item(Adb_DM.PR001Coll.Add);
//            PR001.DataPos := aspPos;
            Inc(aspPos, (PR001Coll.FieldCount) * 4);
          end;

          ctNomenNzis:
          begin
            //NomenNzis := TNomenNzisItem(NomenNzisColl.Add);
            //NomenNzis.DataPos := aspPos;
            Inc(aspPos, (NomenNzisColl.FieldCount) * 4);
          end;
        end;
      end;
    end;
  end
  else
  begin
    fileStr := TFileStream.Create(FileName, fmCreate);
    fileStr.Size := 20000000;
    fileStr.Free;
    FAdbNomenNzis := TMappedFile.Create(FileName, True, TGUID.Empty);
    ReInitColl;
  end;



  //Adb_DM.AdbNomenNzis := FAdbNomenNzis;
  //FDBHelper.AdbNomenNzis := FAdbNomenNzis;


  OpenCmdNomenNzis(FAdbNomenNzis);

  Elapsed := Stopwatch.Elapsed;
  mmoTest.lines.add(Format('зареждане от Nom: %f', [Elapsed.TotalMilliseconds]));
end;

procedure TADBDataModule.OpenCmd(ADB: TMappedFile);
var
  fileName, fileNameTemp: string;
begin

  fileName := ADB.FileName.Replace('.adb', '.cmd');

  if TFile.Exists (fileName) then
  begin
    streamCmdFile := TFileCMDStream.Create(fileName, fmOpenReadWrite + fmShareDenyNone);
    //FDBHelper.cmdFile := streamCmdFile;
    CollPregled.cmdFile := streamCmdFile;
    CollDoctor.cmdFile := streamCmdFile;
    CollNZIS_ANSWER_VALUE.cmdFile := streamCmdFile;
    CollNzis_RESULT_DIAGNOSTIC_REPORT.cmdFile := streamCmdFile;
    CollNZIS_DIAGNOSTIC_REPORT.cmdFile := streamCmdFile;
  end
  else
  begin
    streamCmdFile := TFileCmdStream.Create(fileName, fmCreate);
    streamCmdFile.Size := 100;
  end;
  streamCmdFile.Position := streamCmdFile.Size;

  fileNameTemp := ADB.FileName.Replace('.adb', '.tmp');
  if TFile.Exists (fileNameTemp) then
  begin
    streamCmdFileTemp := TFileCMDStream.Create(fileNameTemp, fmOpenReadWrite + fmShareDenyNone);
    streamCmdFileTemp.Guid := ADB.GUID;
    //FDBHelper.cmdFile := streamCmdFile;
    //CollPregled.cmdFile := streamCmdFile;
    CollDoctor.cmdFileTemp := streamCmdFileTemp;
    //CollNZIS_ANSWER_VALUE.cmdFile := streamCmdFile;
//    CollNzis_RESULT_DIAGNOSTIC_REPORT.cmdFile := streamCmdFile;
//    CollNZIS_DIAGNOSTIC_REPORT.cmdFile := streamCmdFile;
  end
  else
  begin
    streamCmdFileTemp := TFileCmdStream.Create(fileNameTemp, fmCreate);

    streamCmdFileTemp.Size := 100;

    CollDoctor.cmdFileTemp := streamCmdFileTemp;
  end;
  streamCmdFileTemp.Position := streamCmdFileTemp.Size;
  cmdFile := streamCmdFile;
end;

procedure TADBDataModule.OpenCmdNomenNzis(ADBNomenNzis: TMappedFile);
var
  fileName: string;
  TempPos: Cardinal;
begin

  fileName := ADBNomenNzis.FileName.Replace('.adb', '.cmd');

  if TFile.Exists (fileName) then
  begin
    streamCmdFileNomenNzis := TFileCmdStream.Create(fileName, fmOpenReadWrite + fmShareDenyNone);
    streamCmdFileNomenNzis.Position := 0;
    streamCmdFileNomenNzis.Read(TempPos, 4);
    streamCmdFileNomenNzis.AspectDataPos := TempPos;
  end
  else
  begin
    streamCmdFileNomenNzis := TFileCmdStream.Create(fileName, fmCreate + fmShareDenyNone);
    streamCmdFileNomenNzis.AspectDataPos := 0;
    streamCmdFileNomenNzis.Size := 100;
  end;

  streamCmdFileNomenNzis.Position := streamCmdFileNomenNzis.Size;
  SetCmdColl;
end;

procedure TADBDataModule.OpenDB(FFDbName: string);
var
  nodeLink: PVirtualNode;
begin
  if Assigned(AdbMain) then
    begin
      UnmapViewOfFile(AdbMain.Buf);
    end;
    if FAdbMainLink <> nil then
    begin
      FAdbMainLink.FVTR.BeginUpdate;
      nodeLink := pointer(PByte(FAdbMainLink.Buf) + 100);
      FAdbMainLink.FVTR.InternalDisconnectNode(nodeLink, false);
      UnmapViewOfFile(FAdbMainLink.Buf);
      FreeAndNil(FAdbMainLink);
      FAdbMainLink.FVTR.Selected[FAdbMainLink.FVTR.GetFirstSelected()] := False;
      FAdbMainLink.FVTR.CanClear := True;
      FAdbMainLink.FVTR.AddChild(nil, nil);

      FAdbMainLink.FVTR.CanClear := false;
      FAdbMainLink.FVTR.Repaint;
      FAdbMainLink.FVTR.endUpdate;
    end;

    ClearColl;
    if Assigned(FOnClearColl) then
      FOnClearColl(self);
    initDB(FFDbName);
end;

procedure TADBDataModule.OpenLinkPatPreg(LNK: TMappedLinkFile);
var
  i, j: Integer;
  collType: TCollectionsType;
  aspVersion: Word;
  b: Byte;
  pByteData: ^Byte;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  FPosLinkData: Cardinal;
  node: PVirtualNode;
  linkPos: Cardinal;
  deltaBuf, oldBuf: Cardinal;
  oldRoot: Cardinal;
  fileNameLink: string;
  AInt64: Int64;
  data: PAspRec;
  preg: TPregledNewItem;
  pat: TPatientNewItem;
begin
  Stopwatch := TStopwatch.StartNew;
  //ListNodes.Clear;
  LNK.FVTR.BeginUpdate;

  pCardinalData := pointer(PByte(LNK.Buf) + 4);
  oldBuf := pCardinalData^;
  if Cardinal(LNK.Buf) >= oldBuf then
  begin
    deltaBuf := Cardinal(LNK.Buf) - oldBuf;
  end
  else
  begin
    deltaBuf := oldBuf - Cardinal(LNK.Buf);
  end;
  pCardinalData := pointer(PByte(LNK.Buf) + 4);
  pCardinalData^ := Cardinal(LNK.Buf);
  pCardinalData := pointer(PByte(LNK.Buf) + 8);
  oldRoot := pCardinalData^;

  //mmotest.Lines.Add(Format('BufLink  = %d', [cardinal(AspectsLinkPatPregFile.Buf)]));

  linkPos := 100;
  pCardinalData := pointer(PByte(LNK.Buf));
  FPosLinkData := pCardinalData^;
  node := pointer(PByte(LNK.Buf) + linkpos);
  //node.NodeHeight := 27;

  Exclude(node.States, vsSelected);
  data := pointer(PByte(node) + lenNode);
  if not (data.vid in [vvPatientRevision]) then
    data.index := -1;
  AddToListNodes(data);
  i := 0;
  if Cardinal(LNK.Buf) > oldBuf then
  begin
    while linkPos <= FPosLinkData do
    begin
      if node.PrevSibling <> nil then
        node.PrevSibling := Pointer(Integer(deltaBuf) + Integer(node.PrevSibling));
      if node.NextSibling <> nil then
        node.NextSibling := Pointer(Integer(deltaBuf) + Integer(node.NextSibling));
      if node.FirstChild <> nil then
        node.FirstChild := Pointer(Integer(deltaBuf) + Integer(node.FirstChild));
      if node.LastChild <> nil then
        node.LastChild := Pointer(Integer(deltaBuf) + Integer(node.LastChild));

      if linkPos <> 100 then
      begin
        if (node.Parent <> nil)  then
          node.parent := Pointer(Integer(deltaBuf) + Integer(node.parent));
      end
      else
      begin
        node.parent := nil;
      end;
      Inc(linkPos, LenData);

      node := pointer(PByte(LNK.Buf) + linkpos);
      //node.NodeHeight := 27;
      Exclude(node.States, vsSelected);
      //Node.States := node.States + [vsMultiline] + [vsHeightMeasured]; // zzzzzzzzzzzzzzzzzzz за опция за редове
      data := pointer(PByte(node) + lenNode);
      if not (data.vid in [vvPatientRevision]) then
        data.index := -1;
      if data.vid = vvEvntList then
      begin
        data.DataPos := data.DataPos + deltaBuf;
      end;

      AddToListNodes(data);
    end;
  end
  else
  begin
    if deltaBuf <> 0 then
    begin
      while linkPos <= FPosLinkData do
      begin
        if node.PrevSibling <> nil then
            node.PrevSibling := Pointer(-Integer(deltaBuf) + Integer(node.PrevSibling));
        if node.NextSibling <> nil then
          node.NextSibling := Pointer(-Integer(deltaBuf) + Integer(node.NextSibling));
        if node.FirstChild <> nil then
          node.FirstChild := Pointer(-Integer(deltaBuf) + Integer(node.FirstChild));
        if node.LastChild <> nil then
          node.LastChild := Pointer(-Integer(deltaBuf) + Integer(node.LastChild));
        if linkPos <> 100 then
        begin
          if (node.Parent <> nil)  then
            node.parent := Pointer(-Integer(deltaBuf) + Integer(node.parent));
        end
        else
        begin
          node.Parent := nil;
        end;
        Inc(linkPos, LenData);
        node := pointer(PByte(LNK.Buf) + linkpos);
        Exclude(node.States, vsSelected);
        //Node.States := node.States + [vsMultiline] + [vsHeightMeasured]; // zzzzzzzzzzzzzzzzzzz за опция за редове
        data := pointer(PByte(node) + lenNode);
        if data.vid = vvEvntList then
        begin
          data.DataPos := data.DataPos - deltaBuf;
        end;
        if not (data.vid in [vvPatientRevision]) then
          data.index := -1;
        //if data.vid <> vvPatient then
//          Exclude(node.States, vsFiltered);
        AddToListNodes(data);
      end;
    end
    else
    begin
      //PregledColl.Capacity := 1000000;
      while linkPos <= FPosLinkData do
      begin
        Inc(linkPos, LenData);
        node := pointer(PByte(LNK.Buf) + linkpos);
        Exclude(node.States, vsSelected);
        //Node.States := node.States + [vsMultiline] + [vsHeightMeasured];  // zzzzzzzzzzzzzzzzzzz за опция за редове
        //Exclude(node.States, vsInitialized);
        data := pointer(PByte(node) + lenNode);
        //if data.vid <> vvPatient then
//          Exclude(node.States, vsFiltered);
        if not (data.vid in [vvPatientRevision]) then
          data.index := -1;
        AddToListNodes(data);
      end;
    end;
  end;


  //pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
//  pCardinalData^ := linkpos;
  node := pointer(PByte(LNK.Buf) + 100);
   //node.NodeHeight := 27;

  LNK.FVTR.InternalConnectNode_cmd(node, LNK.FVTR.RootNode, LNK.FVTR, amAddChildFirst);
  LNK.FVTR.BufLink := LNK.Buf;
  //node := pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);
  //vtrPregledPat.InternalDisconnectNode(node, false);
  pCardinalData := pointer(PByte(LNK.Buf) + 8);
  pCardinalData^ := Cardinal(LNK.FVTR.RootNode);
  LNK.FVTR.UpdateVerticalScrollBar(true);
  LNK.FVTR.EndUpdate;
  Stopwatch.StartNew;
  //vtrPregledPat.Sort(vtrPregledPat.RootNode.FirstChild, 0, sdAscending, false);
  Elapsed := Stopwatch.Elapsed;
  //LNK.FVTR := LNK.FVTR;
  LNK.FStreamCmdFile := streamCmdFile;
  //FDBHelper.AdbLink := LNK;
  //FmxProfForm.AspLink := LNK;
  AdbLink := LNK;

  //vtrPregledPat.ValidateNode(vtrPregledPat.RootNode.FirstChild.FirstChild,True);

  //vtrPregledPat.Selected[vtrPregledPat.GetLast()] := True;
  //vtrPregledPat.IsFiltered[vtrPregledPat.Getlast()] := True;
  //vtrPregledPat.ReinitNode(vtrPregledPat.GetFirst(), true);

  //Elapsed := Stopwatch.Elapsed;

  //mmoTest.Lines.Add( Format('ЗарежданеLink %d за %f',[vtrPregledPat.RootNode.TotalCount,  Elapsed.TotalMilliseconds]));
  //CalcStatusDB(GetFileSize(AfileLink, @Int64Rec(AInt64).Hi), 100, linkpos, 0, 0);
  //PregledColl.ShowGrid(TeeGrid1);

  //FindOldItemsForInsert;
  //CheckCollForSave;


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

{ Lifecycle methods for collections in TADBDataModule }

procedure TADBDataModule.InitColl;
begin
  // Create list container
  if lstColl = nil then
    lstColl := TList<TBaseCollection>.Create
  else
    lstColl.Clear;
  lstColl.Count := Ord(High(TCollectionsType)) + 1;

  // Create all collections (instances) — do NOT assign Buf/posData here
  CollPregled := TRealPregledNewColl.Create(TRealPregledNewItem);
  lstColl[Ord(CollPregled.GetCollType)] := CollPregled;

  CollPractica := TPracticaColl.Create(TPracticaItem);
  lstColl[Ord(CollPractica.GetCollType)] := CollPractica;

  CollDoctor := TRealDoctorColl.Create(TRealDoctorItem);
  lstColl[Ord(CollDoctor.GetCollType)] := CollDoctor;

  CollOtherDoctor := TRealOtherDoctorColl.Create(TRealOtherDoctorItem);
  lstColl[Ord(CollOtherDoctor.GetCollType)] := CollOtherDoctor;

  CollUnfav := TRealUnfavColl.Create(TRealUnfavItem);
  lstColl[Ord(CollUnfav.GetCollType)] := CollUnfav;

  CollPatient := TRealPatientNewColl.Create(TRealPatientNewItem);
  lstColl[Ord(CollPatient.GetCollType)] := CollPatient;

  CollPatPis := TRealPatientNZOKColl.Create(TRealPatientNZOKItem);
  lstColl[Ord(CollPatPis.GetCollType)] := CollPatPis;

  CollDiag := TRealDiagnosisColl.Create(TRealDiagnosisItem);
  lstColl[Ord(CollDiag.GetCollType)] := CollDiag;

  CollMDN := TRealMDNColl.Create(TRealMDNItem);
  lstColl[Ord(CollMDN.GetCollType)] := CollMDN;

  CollEbl := TRealExam_boln_listColl.Create(TRealExam_boln_listItem);
  lstColl[Ord(CollEbl.GetCollType)] := CollEbl;

  CollExamAnal := TRealExamAnalysisColl.Create(TRealExamAnalysisItem);
  lstColl[Ord(CollExamAnal.GetCollType)] := CollExamAnal;

  CollExamImun := TRealExamImmunizationColl.Create(TRealExamImmunizationItem);
  lstColl[Ord(CollExamImun.GetCollType)] := CollExamImun;

  CollProceduresPreg := TRealProceduresColl.Create(TRealProceduresItem);
  lstColl[Ord(CollProceduresPreg.GetCollType)] := CollProceduresPreg;

  CollCardProf := TRealKARTA_PROFILAKTIKA2017Coll.Create(TRealKARTA_PROFILAKTIKA2017Item);
  lstColl[Ord(CollCardProf.GetCollType)] := CollCardProf;

  CollMedNapr := TRealBLANKA_MED_NAPRColl.Create(TRealBLANKA_MED_NAPRItem);
  lstColl[Ord(CollMedNapr.GetCollType)] := CollMedNapr;

  CollMedNapr3A := TRealBLANKA_MED_NAPR_3AColl.Create(TRealBLANKA_MED_NAPR_3AItem);
  lstColl[Ord(CollMedNapr3A.GetCollType)] := CollMedNapr3A;

  CollMedNaprHosp := TRealHOSPITALIZATIONColl.Create(TRealHOSPITALIZATIONItem);
  lstColl[Ord(CollMedNaprHosp.GetCollType)] := CollMedNaprHosp;

  CollMedNaprLkk := TRealEXAM_LKKColl.Create(TRealEXAM_LKKItem);
  lstColl[Ord(CollMedNaprLkk.GetCollType)] := CollMedNaprLkk;

  CollIncMdn := TRealINC_MDNColl.Create(TRealINC_MDNItem);
  lstColl[Ord(CollIncMdn.GetCollType)] := CollIncMdn;

  CollIncMN := TRealINC_NAPRColl.Create(TRealINC_NAPRItem);
  lstColl[Ord(CollIncMN.GetCollType)] := CollIncMN;

  CollMkb := TRealMkbColl.Create(TRealMkbItem);
  lstColl[Ord(CollMkb.GetCollType)] := CollMkb;


  CollNZIS_PLANNED_TYPE := TRealNZIS_PLANNED_TYPEColl.Create(TRealNZIS_PLANNED_TYPEItem);
  lstColl[Ord(CollNZIS_PLANNED_TYPE.GetCollType)] := CollNZIS_PLANNED_TYPE;

  CollNZIS_QUESTIONNAIRE_RESPONSE := TRealNZIS_QUESTIONNAIRE_RESPONSEColl.Create(TRealNZIS_QUESTIONNAIRE_RESPONSEItem);
  lstColl[Ord(CollNZIS_QUESTIONNAIRE_RESPONSE.GetCollType)] := CollNZIS_QUESTIONNAIRE_RESPONSE;

  CollNZIS_QUESTIONNAIRE_ANSWER := TRealNZIS_QUESTIONNAIRE_ANSWERColl.Create(TRealNZIS_QUESTIONNAIRE_ANSWERItem);
  lstColl[Ord(CollNZIS_QUESTIONNAIRE_ANSWER.GetCollType)] := CollNZIS_QUESTIONNAIRE_ANSWER;

  CollNZIS_ANSWER_VALUE := TRealNZIS_ANSWER_VALUEColl.Create(TRealNZIS_ANSWER_VALUEItem);
  lstColl[Ord(CollNZIS_ANSWER_VALUE.GetCollType)] := CollNZIS_ANSWER_VALUE;

  CollNZIS_DIAGNOSTIC_REPORT := TRealNZIS_DIAGNOSTIC_REPORTColl.Create(TRealNZIS_DIAGNOSTIC_REPORTItem);
  lstColl[Ord(CollNZIS_DIAGNOSTIC_REPORT.GetCollType)] := CollNZIS_DIAGNOSTIC_REPORT;

  CollNzis_RESULT_DIAGNOSTIC_REPORT := TRealNZIS_RESULT_DIAGNOSTIC_REPORTColl.Create(TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem);
  lstColl[Ord(CollNzis_RESULT_DIAGNOSTIC_REPORT.GetCollType)] := CollNzis_RESULT_DIAGNOSTIC_REPORT;

  CollNzisToken := TNzisTokenColl.Create(TNzisTokenItem);
  lstColl[Ord(CollNzisToken.GetCollType)] := CollNzisToken;

  CollCertificates := TCertificatesColl.Create(TCertificatesItem);
  lstColl[Ord(CollCertificates.GetCollType)] := CollCertificates;



  CollAnalsNew := TAnalsNewColl.Create(TAnalsNewItem);
  lstColl[Ord(CollAnalsNew.GetCollType)] := CollAnalsNew;

  CL006Coll := TRealCL006Coll.Create(TRealCl006Item);
  lstColl[Ord(CL006Coll.GetCollType)] := CL006Coll;

  CL009Coll := TRealCL009Coll.Create(TRealCl009Item);
  lstColl[Ord(CL009Coll.GetCollType)] := CL009Coll;

  CL011Coll := TRealCL011Coll.Create(TRealCl011Item);
  lstColl[Ord(CL011Coll.GetCollType)] := CL011Coll;

  CL022Coll := TRealCL022Coll.Create(TRealCl022Item);
  lstColl[Ord(CL022Coll.GetCollType)] := CL022Coll;

  CL024Coll := TRealCL024Coll.Create(TRealCl024Item);
  lstColl[Ord(CL024Coll.GetCollType)] := CL024Coll;

  CL037Coll := TRealCL037Coll.Create(TRealCl037Item);
  lstColl[Ord(CL037Coll.GetCollType)] := CL037Coll;

  CL038Coll := TRealCL038Coll.Create(TRealCl038Item);
  lstColl[Ord(CL038Coll.GetCollType)] := CL038Coll;

  CL050Coll := TCL050Coll.Create(TCl050Item);
  lstColl[Ord(CL050Coll.GetCollType)] := CL050Coll;

  CL088Coll := TRealCL088Coll.Create(TRealCl088Item);
  lstColl[Ord(CL088Coll.GetCollType)] := CL088Coll;

  CL132Coll := TRealCL132Coll.Create(TRealCl132Item);
  lstColl[Ord(CL132Coll.GetCollType)] := CL132Coll;

  CL134Coll := TRealCL134Coll.Create(TRealCl134Item);
  lstColl[Ord(CL134Coll.GetCollType)] := CL134Coll;

  CL139Coll := TRealCL139Coll.Create(TRealCl139Item);
  lstColl[Ord(CL139Coll.GetCollType)] := CL134Coll;

  CL142Coll := TRealCL142Coll.Create(TRealCl142Item);
  lstColl[Ord(CL142Coll.GetCollType)] := CL142Coll;


  CL144Coll := TRealCl144Coll.Create(TRealCl144Item);
  lstColl[Ord(CL144Coll.GetCollType)] := CL144Coll;

  PR001Coll := TRealPR001Coll.Create(TRealPR001Item);
  lstColl[Ord(PR001Coll.GetCollType)] := PR001Coll;

  NomenNzisColl := TNomenNzisColl.Create(TNomenNzisItem);
  lstColl[Ord(NomenNzisColl.GetCollType)] := NomenNzisColl;

  ProceduresNomenColl:= TRealProceduresColl.Create(TRealCl006Item);
  lstColl[Ord(ProceduresNomenColl.GetCollType)] := ProceduresNomenColl;


  // ... добави тук другите колекции, ако имаш още полета в DM ...





  // Ensure internal lists are initialized inside each collection (if needed)
  // e.g. CollX.ListDataPos := TList<PVirtualNode>.Create; etc. (normally constructor does that)
  lstPatGraph := TList<TRealPatientNewItem>.create;
  ListPregledForFDB := TList<TPregledNewItem>.create;
  ListDoctorForFDB := TList<TDoctorItem>.create;
  ListPregledLinkForInsert := TList<PVirtualNode>.create;
  CollPregledVtor := TList<TRealPregledNewItem>.create;
  CollPregledPrim := TList<TRealPregledNewItem>.create;
  LstPatForExportDB := TList<TRealPatientNewItem>.create;
  LstPregForExportDB := TList<TRealPregledNewItem>.create;
  ListPatientForFDB := TList<TPatientNewItem>.create;
  ListNomenNzisNames := TList<TNomenNzisRec>.create;
end;

procedure TADBDataModule.initDB(FFDbName: string);
begin
  Stopwatch := TStopwatch.StartNew;
  mmoTest.Lines.BeginUpdate;
  if FFDM = nil then
  begin
    FFDM := TDUNzis.Create(nil);
  end;
  mmoTest.Lines.Add('FDbName =' + FFDbName);
  if FFDbName = '' then
    exit;
  FFDM.InitDb(FFDbName);
  if (FFDM.FGuidDB.Count > 0) then
  begin
    FindADB(FFDM.FGuidDB);
  end;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.lines.add(Format('nnnnn: %f', [Elapsed.TotalMilliseconds]));
  if AdbMain = nil then  // не е намерено адб отговарящо на гдб-то. трябва да се импортира.
  begin
    mmoTest.Lines.Add('не е намерено адб отговарящо на гдб-то. трябва да се импортира');
    //RolPnlDoktorOPL.Enabled := False;
    //RolPnlDoktorOPL.Repaint;
  end
  else  // намерено е адб отговарящо на гдб-то. Може да се отвори и зареди
  begin
    mmoTest.Lines.Add('намерено е адб отговарящо на гдб-то. Може да се отвори и зареди');
    //if AspectsNomFile = nil then
      //OpenBufNomenNzis(paramstr(2) + 'NzisNomen.adb');
    OpenADB(AdbMain);
    OpenCmd(AdbMain);
    FindLNK(AdbMain.GUID);
    if FAdbMainLink <> nil then
      OpenLinkPatPreg(FAdbMainLink);
    //StartHistoryThread(FDbName);
    //StartCertThread;
//    if chkAspectDistr.Checked then
//    begin
//      StartAspectPerformerThread;
//    end;

  end;
  mmoTest.Lines.EndUpdate;
end;

procedure TADBDataModule.ReInitColl;
var
  coll: TBaseCollection;
begin
  // Rebind buffers and posData according to which ADB file holds the collection.
  // Adapt mapping if you move collections between ADBs.
  for coll in lstColl do
  begin
    if coll = nil then Continue;

    case coll.GetCollType of
      // these are stored in AdbMain:
      // (list the collection types that live in AdbMain)
      ctPregledNew, ctPractica, ctDoctor, ctUnfav, ctPatientNew,
      ctPatientNZOK, ctDiagnosis, ctMDN, ctExam_boln_list,
      ctExamAnalysis, ctExamImmunization, ctProcedures,
      ctKARTA_PROFILAKTIKA2017, ctBLANKA_MED_NAPR, ctBLANKA_MED_NAPR_3A,
      ctHOSPITALIZATION, ctEXAM_LKK, ctINC_MDN, ctINC_NAPR,
      ctNZIS_PLANNED_TYPE, ctNZIS_QUESTIONNAIRE_RESPONSE,
      ctNZIS_QUESTIONNAIRE_ANSWER, ctNZIS_ANSWER_VALUE,
      ctNZIS_DIAGNOSTIC_REPORT, ctNZIS_RESULT_DIAGNOSTIC_REPORT,
      ctNzisToken, ctCertificates, ctMkb, ctAnalsNew:
      begin
        if Assigned(AdbMain) then
        begin
          coll.Buf := AdbMain.Buf;
          coll.posData := AdbMain.FPosData;
        end
        else
        begin
          coll.Buf := nil;
          coll.posData := 0;
        end;
      end;

      // collections that live in AdbNomenNzis (example list)
      // replace with real ct values for NZIS nomenclature collections
      ctCL006, ctCL022, ctCL024, ctCL037, ctCL038, ctCL011,
      ctCL050, ctCL088, ctCL132, ctCL134, ctCL139, ctCL009,
      ctCL142, ctCL144, ctPR001, ctNomenNzis:
      begin
        if Assigned(AdbNomenNzis) then
        begin
          coll.Buf := AdbNomenNzis.Buf;
          coll.posData := AdbNomenNzis.FPosData;
        end
        else
        begin
          coll.Buf := nil;
          coll.posData := 0;
        end;
      end;

      // (If you have other ADB containers, add more case branches:)
      // e.g. AdbNomenHip, AdbNomenNZOK ...
    else
      begin
        // Default: no ADB assigned
        coll.Buf := nil;
        coll.posData := 0;
      end;
    end;
  end;
end;

procedure TADBDataModule.ClearColl;
var
  coll: TBaseCollection;
begin
  // Stop any background processing first (search threads etc.) before calling ClearColl
  // ThreadSafe: ensure threads are paused/stopped elsewhere.

  for coll in lstColl do
  begin
    if not Assigned(coll) then Continue;

    // wipe runtime contents (important)
    try
      coll.Clear; // remove in-memory items/records
    except
      // ignore individual failures during clear to avoid partial state
    end;

    // clear auxiliary lists if exist
    if Assigned(coll.ListDataPos) then coll.ListDataPos.Clear;
    if Assigned(coll.ListNodes) then coll.ListNodes.Clear;
    //if Assigned(coll.ListForFinder) then coll.ListForFinder.Clear;

    // reset binding to ADB
    coll.Buf := nil;
    coll.posData := 0;
  end;
  lstPatGraph.Clear;
end;

procedure TADBDataModule.FreeColl;
var
  i: Integer;
  nomen: TNomenNzisRec;
begin
  // Free each collection instance
  if lstColl <> nil then
  begin
    for i := lstColl.Count - 1 downto 0 do
    begin
      //if Assigned(lstColl[i]) then
        //FreeAndNil(lstColl[i]);
    end;
    lstColl.Clear;
    FreeAndNil(lstColl);
  end;


  //CollPregled := nil;
//  CollPractica := nil;
//  CollDoctor := nil;
//  CollOtherDoctor := nil;
//  CollUnfav := nil;
//  CollPatient := nil;
//  CollPatPis := nil;
//  CollDiag := nil;
//  CollMDN := nil;
//  CollEbl := nil;
//  CollExamAnal := nil;
//  CollExamImun := nil;
//  CollProceduresPreg := nil;
//  CollCardProf := nil;
//  CollMedNapr := nil;
//  CollMedNapr3A := nil;
//  CollMedNaprHosp := nil;
//  CollMedNaprLkk := nil;
//  CollIncMdn := nil;
//  CollIncMN := nil;
//  CollNZIS_PLANNED_TYPE := nil;
//  CollNZIS_QUESTIONNAIRE_RESPONSE := nil;
//  CollNZIS_QUESTIONNAIRE_ANSWER := nil;
//  CollNZIS_ANSWER_VALUE := nil;
//  CollNZIS_DIAGNOSTIC_REPORT := nil;
//  CollNzis_RESULT_DIAGNOSTIC_REPORT := nil;
//  CollNzisToken := nil;
//  CollCertificates := nil;
//  CollMkb := nil;
//  CollAnalsNew := nil;
//
//  FreeandNil(CL006Coll);
//  FreeandNil(CL022Coll);
//  FreeandNil(CL024Coll);
//  FreeandNil(CL037Coll);
//  FreeandNil(CL038Coll);
//  FreeandNil(CL050Coll);
//  FreeandNil(CL088Coll);
//  FreeandNil(CL132Coll);
//  FreeandNil(CL134Coll);
//  FreeandNil(CL139Coll);
//  FreeandNil(CL142Coll);
//  FreeandNil(CL144Coll);
//  FreeandNil(PR001Coll);
//
//  FreeAndNil(lstPatGraph);
//  FreeAndNil(ListPregledForFDB);
//  FreeAndNil(ListDoctorForFDB);
//  FreeAndNil(ListPregledLinkForInsert);
//  FreeAndNil(CollPregledVtor);
//  FreeAndNil(CollPregledPrim);
//  FreeAndNil(LstPatForExportDB);
//  FreeAndNil(LstPregForExportDB);
//  FreeAndNil(ListPatientForFDB);
//  for i := 0 to ListNomenNzisNames.Count - 1 do
//  begin
//    nomen := ListNomenNzisNames[i];
//    FreeAndNil(nomen);
//  end;
//  FreeAndNil(ListNomenNzisNames);
end;

procedure TADBDataModule.SetAdbHipNomenFileName(const Value: string);
begin
  FAdbHipNomenFileName := Value;
end;

procedure TADBDataModule.SetAdbMain(const Value: TMappedFile);
begin
  // setter for AdbMain property: store value and re-bind buffers
  FAdbMain := Value;
  ReInitColl;
  // Optionally: if ADB is loaded, build indexes
  //if Assigned(FAdbMain) and (FAdbMain is TMappedLinkFile) then
//    TMappedLinkFile(FAdbMain).BuildPathIndex;
end;

procedure TADBDataModule.SetAdbMainFileName(const Value: string);
begin
  FAdbMainFileName := Value;
end;

procedure TADBDataModule.SetAdbNasMestoFileName(const Value: string);
begin
  FAdbNasMestoFileName := Value;
end;

procedure TADBDataModule.SetAdbNomenHip(const Value: TMappedFile);
begin
  FAdbNomenHip := Value;
end;

procedure TADBDataModule.SetAdbNomenNzis(const Value: TMappedFile);
begin
  FAdbNomenNzis := Value;
  ReInitColl;
end;

procedure TADBDataModule.SetAdbNomenNZOK(const Value: TMappedFile);
begin
  FAdbNomenNZOK := Value;
end;




procedure TADBDataModule.SetAdbNzisNomenFileName(const Value: string);
begin
  FAdbNzisNomenFileName := Value;
end;

procedure TADBDataModule.SetAdbNzokNomenFileName(const Value: string);
begin
  FAdbNzokNomenFileName := Value;
end;

procedure TADBDataModule.SetAdbOptionFileName(const Value: string);
begin
  FAdbOptionFileName := Value;
end;

procedure TADBDataModule.SetCmdColl;
var
  coll: TBaseCollection;
begin
  for coll in lstColl do
  begin
    if coll = nil then Continue;

    case coll.GetCollType of
      ctPregledNew, ctPractica, ctDoctor, ctUnfav, ctPatientNew,
      ctPatientNZOK, ctDiagnosis, ctMDN, ctExam_boln_list,
      ctExamAnalysis, ctExamImmunization, ctProcedures,
      ctKARTA_PROFILAKTIKA2017, ctBLANKA_MED_NAPR, ctBLANKA_MED_NAPR_3A,
      ctHOSPITALIZATION, ctEXAM_LKK, ctINC_MDN, ctINC_NAPR,
      ctNZIS_PLANNED_TYPE, ctNZIS_QUESTIONNAIRE_RESPONSE,
      ctNZIS_QUESTIONNAIRE_ANSWER, ctNZIS_ANSWER_VALUE,
      ctNZIS_DIAGNOSTIC_REPORT, ctNZIS_RESULT_DIAGNOSTIC_REPORT,
      ctNzisToken, ctCertificates, ctMkb, ctAnalsNew:
      begin
        if Assigned(AdbMain) then
        begin
          coll.cmdFile := streamCmdFile;
        end
        else
        begin
          coll.cmdFile := nil;
        end;
      end;

      ctCL006, ctCL022, ctCL024, ctCL037, ctCL038, ctCL011,
      ctCL050, ctCL088, ctCL132, ctCL134, ctCL139, ctCL009,
      ctCL142, ctCL144, ctPR001, ctNomenNzis:
      begin
        if Assigned(streamCmdFileNomenNzis) then
        begin
          coll.cmdFile := streamCmdFileNomenNzis;
        end
        else
        begin
          coll.cmdFile := nil;
        end;
      end;

    else
      begin
        coll.cmdFile := nil;
      end;
    end;
  end;
end;

//procedure TADBDataModule.SetNasMestaLink(const Value: TMappedLinkFile);
//begin
//  FNasMestaLink := Value;
//  //NasMesto := TRealNasMestoAspects.Create(FNasMestaLink);
//end;

{ TPregledNodes }

constructor TPregledNodes.create;
begin
  inherited;
  mkbs := TList<PVirtualNode>.Create;
  diags := TList<PVirtualNode>.Create;
 // evnts := TList<PVirtualNode>.Create;
  Planeds := TList<PVirtualNode>.Create;
  Quests := TList<TQuests>.Create;
  DiagReps := TList<TDiagRep>.Create;
  incNaprNode := nil;
end;

destructor TPregledNodes.destroy;
begin
  FreeAndNil(mkbs);
  FreeAndNil(diags);
  //FreeAndNil(evnts);
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
  logPat := TlogicalPatientNewSet(pat.getLogical40Map(buf, posdata, word(PatientNew_Logical)));
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
  logPat := TlogicalPatientNewSet(pat.getLogical40Map(buf, posdata, word(PatientNew_Logical)));
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
begin
  raise Exception.Create(' getRhifAreaNumber  не е довършен')
  //for i := 0 to evnts.Count - 1 do
//  begin
//    dataEvn := pointer(PByte(evnts[i]) + lenNode);
//    EvnTemp := TRealEventsManyTimesItem.Create(nil);
//    EvnTemp.DataPos := dataEvn.DataPos;
//    logEvnt := TlogicalEventsManyTimesSet(EvnTemp.getLogical24Map(buf, posData, word(EventsManyTimes_Logical)));
//    for Aevnt in logEvnt do
//    begin
//      case Aevnt of
//        RZOK:
//        begin
//          rzokEvn := EvnTemp.getAnsiStringMap(Buf, posData, word(EventsManyTimes_valAnsiString));
//        end;
//        RZOKR:
//        begin
//          rzokREvn := EvnTemp.getAnsiStringMap(Buf, posData, word(EventsManyTimes_valAnsiString));
//        end;
//      end;
//    end;
//  end;
//  Result := rzokEvn + rzokREvn;
//  Result := '0202';//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
//  FreeAndNil(EvnTemp);
end;

{ TPatNodes }



constructor TPatNodes.create;
begin
  inherited;
  addresses := TList<PVirtualNode>.create;
  ExamAnals := TList<PVirtualNode>.create;
  diags := TList<PVirtualNode>.create;
  pregs := TList<PVirtualNode>.create;
end;

destructor TPatNodes.destroy;
begin
  FreeAndNil(addresses);
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
  logPat := TlogicalPatientNewSet(pat.getLogical40Map(buf, posdata, word(PatientNew_Logical)));
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

{ TNomenNzisRec }

constructor TNomenNzisRec.Create;
begin
  inherited Create;
  Cl000Coll := TCL000EntryCollection.Create(nil);
  xmlStream := TMemoryStream.Create;
end;

destructor TNomenNzisRec.Destroy;
begin
  FreeAndNil(Cl000Coll);
  FreeAndNil(xmlStream);
  inherited;
end;

end.
