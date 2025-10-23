unit ThreadLoadDB;    //cl142  cmd  †

interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  system.Diagnostics, system.TimeSpan, IBX.IBSQL,
  Vcl.Forms, Vcl.ExtCtrls, Winapi.Windows, Vcl.Graphics, Vcl.ComCtrls, system.Math,
  System.Generics.Collections, DM, Winapi.ActiveX, system.Variants, VirtualTrees,
  Aspects.Types, Table.PatientNew, Table.Doctor, Table.Mkb, table.mdn,
  Table.PregledNew, Table.Unfav, Table.Practica, Table.AnalsNew,
  Table.ExamImmunization, Table.Procedures,Table.CL142, Table.KARTA_PROFILAKTIKA2017,
  Table.INC_MDN, Table.INC_NAPR, Table.Addres,
  RealObj.RealHipp, RealObj.NzisNomen, DbHelper, Aspects.Collections,
  RealNasMesto
  //DBCollection.Patient, DBCollection.Pregled, DBCollection.Diagnosis, DBCollection.MedNapr


  ;

type
  TNotyfyProgres = procedure(sender: TObject; CollType, progres: integer)of object;
  TNotifyCNT = procedure(sender: TObject; CollType, cnt: integer)of object;

TLoadDBThread = class(TThread)
  private
    FCntPregled: integer;
    FCntPatient: Integer;
    FOnProgres: TNotyfyProgres;
    FOnCnt: TNotifyCNT;
    FBuf: Pointer;
    FGuid: TGUID;
    FAdbNomen: TMappedFile;
    function GetComputerNam: string;
  protected
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    procedure Execute; override;
    procedure DoTerminate; override;
    procedure GetCountFromDB;
    procedure GetNewID;
    procedure SetUserHistory;
    procedure LinkAnalsToCollAnals;

    procedure AddPractica;
    procedure AddPregled;
    procedure AddPacient;
    procedure AddDoctor;
    procedure AddUnFav;
    procedure AddMDN;
    procedure AddEBL;
    procedure AddExamAnal;
    procedure AddExamImmun;

    procedure GetPregNumerator;



    
    procedure AddMedNapr;
    procedure AddMedNapr3A;
    procedure AddMedNaprHosp;
    procedure AddMedNaprLkk;
    procedure AddMkb;
    procedure AddProcedures;
    procedure AddProfCard;

    procedure AddIncMdn;
    procedure AddIncMN;
    procedure AddIncDoctor;

    procedure RemontCl142;
    procedure FillCl142InProcedures;
    procedure FillProceduresInPregledProcs;// попълва направените процедури с номенклатурните



    procedure UpdatePregled;
  public
    Fdm: TDUNzis;
    cmdFile: TFileStream;
    FDBHelper: TDbHelper;
    FNasMesto: TRealNasMestoAspects;
    //колекции
    PatientColl: TRealPatientNewColl;
    DoctorColl: TRealDoctorColl;
    PracticaColl: TPracticaColl;
    UnFavColl: TRealUnfavColl;
    PregledNewColl: TRealPregledNewColl;
    DiagColl: TRealDiagnosisColl;
    MkbColl: TMkbColl;
    ProcCollNomen: TRealProceduresColl;
    ProcCollPreg: TRealProceduresColl;
    DiagnosticReportColl: TRealDiagnosticReportColl;
    MDNColl: TRealMDNColl;
    EblColl: TRealExam_boln_listColl;
    ExamAnalColl: TRealExamAnalysisColl;
    ExamImunColl: TRealExamImmunizationColl;
    AnalsColl: TAnalsNewColl;
    Cl142Coll: TRealCL142Coll;
    KARTA_PROFILAKTIKA2017Coll: TRealKARTA_PROFILAKTIKA2017Coll;
    MedNaprColl: TRealBLANKA_MED_NAPRColl;
    MedNapr3AColl: TRealBLANKA_MED_NAPR_3AColl;
    MedNaprHospColl: TRealHOSPITALIZATIONColl;
    MedNaprLkkColl: TRealEXAM_LKKColl;
    IncMNColl: TRealINC_NAPRColl;
    OtherDoctorColl: TRealOtherDoctorColl;
    IncMdnColl: TRealINC_MDNColl;
    // дървета
    LinkAnals: TMappedFile;



//    FCollPreg: TPregledColl;
//    FCollPregVtor: TList<TPregledItem>;
    //FCollMKB: TDiagnosisColl;
//    FCollMedNapr: TMedNaprColl;
    constructor Create(CreateSuspended: Boolean; DbName: string);
    destructor Destroy; override;
    property CntPregled: integer read FCntPregled;
    property CntPatient: Integer read FCntPatient;
    property OnProgres: TNotyfyProgres read FOnProgres write FOnProgres;
    property OnCnt: TNotifyCNT read FOnCnt write FOnCnt;
    property Buf: Pointer read FBuf write FBuf;
    property AdbNomen: TMappedFile read FAdbNomen write FAdbNomen;
    property Guid: TGUID read FGuid write FGuid;

  end;

implementation

{ TLoadDBThread }

procedure TLoadDBThread.AddMedNapr;
var
  p: PInt;
  TempItem: TRealBLANKA_MED_NAPRItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqMedNapr: TIBSQL;
begin
  Stopwatch := TStopwatch.StartNew;
  ibsqMedNapr := Fdm.ibsqlMedNaprNew;
  ibsqMedNapr.ExecQuery;
  while not ibsqMedNapr.Eof do
  begin
    TempItem := TRealBLANKA_MED_NAPRItem(MedNaprColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    FDBHelper.InsertMedNaprField(ibsqMedNapr, TempItem); // otdeleno
    if (ibsqMedNapr.RecordCount mod 1000) = 0 then
    begin
      MedNaprColl.CntInADB := ibsqMedNapr.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(BLANKA_MED_NAPR), ibsqMedNapr.RecordCount);
      Sleep(1);
    end;
    TempItem.InsertBLANKA_MED_NAPR;

    MedNaprColl.streamComm.Len := MedNaprColl.streamComm.Size;
    CmdFile.CopyFrom(MedNaprColl.streamComm, 0);


    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqMedNapr.Next;

  end;
  pCardinalData := pointer(FBuf);
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  MedNaprColl.CntInADB := ibsqMedNapr.RecordCount;

  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(BLANKA_MED_NAPR), ibsqMedNapr.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddMedNapr3A;
var
  p: PInt;
  TempItem: TRealBLANKA_MED_NAPR_3AItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqMedNapr3A: TIBSQL;
begin
  Stopwatch := TStopwatch.StartNew;
  ibsqMedNapr3A := Fdm.ibsqlMedNapr3A;
  ibsqMedNapr3A.ExecQuery;
  while not ibsqMedNapr3A.Eof do
  begin
    TempItem := TRealBLANKA_MED_NAPR_3AItem(MedNapr3AColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    FDBHelper.InsertMedNapr3AField(ibsqMedNapr3A, TempItem); // otdeleno
    if (ibsqMedNapr3A.RecordCount mod 1000) = 0 then
    begin
      MedNapr3AColl.CntInADB := ibsqMedNapr3A.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(BLANKA_MED_NAPR_3A), ibsqMedNapr3A.RecordCount);
      Sleep(1);
    end;
    TempItem.InsertBLANKA_MED_NAPR_3A;

    MedNapr3AColl.streamComm.Len := MedNapr3AColl.streamComm.Size;
    CmdFile.CopyFrom(MedNapr3AColl.streamComm, 0);


    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqMedNapr3A.Next;

  end;
  pCardinalData := pointer(FBuf);
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  MedNapr3AColl.CntInADB := ibsqMedNapr3A.RecordCount;

  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(BLANKA_MED_NAPR_3A), ibsqMedNapr3A.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddMedNaprHosp;
var
  p: PInt;
  TempItem: TRealHOSPITALIZATIONItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqMedNaprHosp: TIBSQL;
begin
  Stopwatch := TStopwatch.StartNew;
  ibsqMedNaprHosp := Fdm.ibsqlMedNaprHosp;
  ibsqMedNaprHosp.ExecQuery;
  while not ibsqMedNaprHosp.Eof do
  begin
    TempItem := TRealHOSPITALIZATIONItem(MedNaprHospColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    FDBHelper.InsertMedNaprHospField(ibsqMedNaprHosp, TempItem); // otdeleno
    if (ibsqMedNaprHosp.RecordCount mod 1000) = 0 then
    begin
      MedNaprHospColl.CntInADB := ibsqMedNaprHosp.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(HOSPITALIZATION), ibsqMedNaprHosp.RecordCount);
      Sleep(1);
    end;
    TempItem.InsertHOSPITALIZATION;

    MedNaprHospColl.streamComm.Len := MedNaprHospColl.streamComm.Size;
    CmdFile.CopyFrom(MedNaprHospColl.streamComm, 0);


    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqMedNaprHosp.Next;

  end;
  pCardinalData := pointer(FBuf);
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  MedNaprHospColl.CntInADB := ibsqMedNaprHosp.RecordCount;

  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(HOSPITALIZATION), ibsqMedNaprHosp.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddMedNaprLkk;
var
  TempItem: TRealEXAM_LKKItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqMedNaprLkk: TIBSQL;
begin
  Stopwatch := TStopwatch.StartNew;
  ibsqMedNaprLkk := Fdm.ibsqlMedNaprLKK;
  ibsqMedNaprLkk.ExecQuery;
  while not ibsqMedNaprLkk.Eof do
  begin
    TempItem := TRealEXAM_LKKItem(MedNaprLkkColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    FDBHelper.InsertMedNaprLkkField(ibsqMedNaprLkk, TempItem); // otdeleno
    if (ibsqMedNaprLkk.RecordCount mod 1000) = 0 then
    begin
      MedNaprLkkColl.CntInADB := ibsqMedNaprLkk.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(EXAM_LKK), ibsqMedNaprLkk.RecordCount);
      Sleep(1);
    end;
    TempItem.InsertEXAM_LKK;

    MedNaprLkkColl.streamComm.Len := MedNaprLkkColl.streamComm.Size;
    CmdFile.CopyFrom(MedNaprLkkColl.streamComm, 0);


    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqMedNaprLkk.Next;

  end;
  pCardinalData := pointer(FBuf);
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  MedNaprLkkColl.CntInADB := ibsqMedNaprLkk.RecordCount;

  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(EXAM_LKK), ibsqMedNaprLkk.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddEBL;
var
  p: PInt;
  TempItem: TRealExam_boln_listItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqlEBLNew: TIBSQL;
begin

  Stopwatch := TStopwatch.StartNew;
  ibsqlEBLNew := Fdm.ibsqlEBLNew;
  ibsqlEBLNew.ExecQuery;
 // EblColl.cmdFile := cmdFile;
  while not ibsqlEBLNew.Eof do
  begin
    TempItem := TRealExam_boln_listItem(EblColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    FDBHelper.InsertEBLField(ibsqlEBLNew, TempItem); // otdeleno
    if (ibsqlEBLNew.RecordCount mod 1000) = 0 then
    begin
      EblColl.CntInADB := ibsqlEBLNew.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(EXAM_BOLN_LIST), ibsqlEBLNew.RecordCount);
      Sleep(1);
    end;
    TempItem.InsertExam_boln_list;

    EblColl.streamComm.Len := EblColl.streamComm.Size;
    CmdFile.CopyFrom(EblColl.streamComm, 0);


    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqlEBLNew.Next;

  end;
  pCardinalData := pointer(FBuf);
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  EblColl.CntInADB := ibsqlEBLNew.RecordCount;

  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(EXAM_BOLN_LIST), ibsqlEBLNew.RecordCount);
  Sleep(1);
end;



procedure TLoadDBThread.AddExamAnal;
var
  p: PInt;
  TempItem: TRealExamAnalysisItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqlExamAnal: TIBSQL;
begin

  Stopwatch := TStopwatch.StartNew;
  ibsqlExamAnal := Fdm.ibsqlExamAnalNew;
  ibsqlExamAnal.ExecQuery;
  //ExamAnalColl.cmdFile := cmdFile;
  while not ibsqlExamAnal.Eof do
  begin
    TempItem := TRealExamAnalysisItem(ExamAnalColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    FDBHelper.InsertExamAnalField(ibsqlExamAnal, TempItem); // otdeleno
    if (ibsqlExamAnal.RecordCount mod 1000) = 0 then
    begin
      ExamAnalColl.CntInADB := ibsqlExamAnal.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(EXAM_ANALYSIS), ibsqlExamAnal.RecordCount);
      Sleep(1);
    end;
    TempItem.InsertExamAnalysis;

    ExamAnalColl.streamComm.Len := ExamAnalColl.streamComm.Size;
    CmdFile.CopyFrom(ExamAnalColl.streamComm, 0);


    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqlExamAnal.Next;

  end;
  pCardinalData := pointer(FBuf);
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  ExamAnalColl.CntInADB := ibsqlExamAnal.RecordCount;

  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(EXAM_ANALYSIS), ibsqlExamAnal.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddExamImmun;
var
  p: PInt;
  TempItem: TRealExamImmunizationItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqlExamImun: TIBSQL;
begin

  Stopwatch := TStopwatch.StartNew;
  ibsqlExamImun := Fdm.ibsqlExamInun;
  ibsqlExamImun.ExecQuery;
 // ExamAnalColl.cmdFile := cmdFile;
  while not ibsqlExamImun.Eof do
  begin
    TempItem := TRealExamImmunizationItem(ExamImunColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    FDBHelper.InsertExamImunField(ibsqlExamImun, TempItem); // otdeleno
    if (ibsqlExamImun.RecordCount mod 1000) = 0 then
    begin
      ExamImunColl.CntInADB := ibsqlExamImun.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(EXAM_IMMUNIZATION), ibsqlExamImun.RecordCount);
      Sleep(1);
    end;
    TempItem.InsertExamImmunization;

    ExamImunColl.streamComm.Len := ExamImunColl.streamComm.Size;
    CmdFile.CopyFrom(ExamImunColl.streamComm, 0);


    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqlExamImun.Next;

  end;
  pCardinalData := pointer(FBuf);
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  ExamImunColl.CntInADB := ibsqlExamImun.RecordCount;

  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(EXAM_IMMUNIZATION), ibsqlExamImun.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddIncDoctor;
var
  TempItem: TRealOtherDoctorItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData: Cardinal;
  ibsqOtherDoctor: TIBSQL;
begin
  if  Fdm.IsGP then  Exit;

  Stopwatch := TStopwatch.StartNew;
  ibsqOtherDoctor := Fdm.ibsqlOtherDoctor;
  ibsqOtherDoctor.ExecQuery;
  while not ibsqOtherDoctor.Eof do
  begin
    TempItem := TRealOtherDoctorItem(OtherDoctorColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    FDBHelper.InsertIncDocField(ibsqOtherDoctor, TempItem); // otdeleno
    if (ibsqOtherDoctor.RecordCount mod 1000) = 0 then
    begin
      OtherDoctorColl.CntInADB := ibsqOtherDoctor.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(INC_NAPR), ibsqOtherDoctor.RecordCount);
      Sleep(1);
    end;
    TempItem.InsertOtherDoctor;

    OtherDoctorColl.streamComm.Len := OtherDoctorColl.streamComm.Size;
    CmdFile.CopyFrom(OtherDoctorColl.streamComm, 0);


    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqOtherDoctor.Next;

  end;
  pCardinalData := pointer(FBuf);
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  IncMNColl.CntInADB := ibsqOtherDoctor.RecordCount;

  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(INC_NAPR), ibsqOtherDoctor.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddIncMdn;
var
  p: PInt;
  TempItem: TRealINC_MDNItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqIncMdn: TIBSQL;
begin
  Exit;
  if Fdm.IsGP then  Exit;
  Stopwatch := TStopwatch.StartNew;
  ibsqIncMdn := Fdm.ibsqlIncMDN;
  ibsqIncMdn.ExecQuery;
  while not ibsqIncMdn.Eof do
  begin
    TempItem := TRealINC_MDNItem(IncMdnColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    FDBHelper.InsertIncMdnField(ibsqIncMdn, TempItem); // otdeleno
    if (ibsqIncMdn.RecordCount mod 1000) = 0 then
    begin
      IncMdnColl.CntInADB := ibsqIncMdn.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(INC_MDN), ibsqIncMdn.RecordCount);
      Sleep(1);
    end;
    TempItem.InsertINC_MDN;

    IncMdnColl.streamComm.Len := IncMdnColl.streamComm.Size;
    CmdFile.CopyFrom(IncMdnColl.streamComm, 0);


    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqIncMdn.Next;

  end;
  pCardinalData := pointer(FBuf);
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  IncMdnColl.CntInADB := ibsqIncMdn.RecordCount;

  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(INC_MDN), ibsqIncMdn.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddIncMN;
var
  TempItem: TRealINC_NAPRItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqIncNapr: TIBSQL;
begin
  if  Fdm.IsGP then  Exit;

  Stopwatch := TStopwatch.StartNew;
  ibsqIncNapr := Fdm.ibsqlIncMN;
  ibsqIncNapr.ExecQuery;
  while not ibsqIncNapr.Eof do
  begin
    TempItem := TRealINC_NAPRItem(IncMNColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    FDBHelper.InsertIncMNField(ibsqIncNapr, TempItem); // otdeleno
    if (ibsqIncNapr.RecordCount mod 1000) = 0 then
    begin
      IncMNColl.CntInADB := ibsqIncNapr.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(INC_NAPR), ibsqIncNapr.RecordCount);
      Sleep(1);
    end;
    TempItem.InsertINC_NAPR;

    IncMNColl.streamComm.Len := IncMNColl.streamComm.Size;
    CmdFile.CopyFrom(IncMNColl.streamComm, 0);


    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqIncNapr.Next;

  end;
  pCardinalData := pointer(FBuf);
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  IncMNColl.CntInADB := ibsqIncNapr.RecordCount;

  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(INC_NAPR), ibsqIncNapr.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddMDN;
var
  p: PInt;
  TempItem: TRealMDNItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqlMDN: TIBSQL;
begin
  ibsqlMDN := Fdm.ibsqlMDNNew;
  Stopwatch := TStopwatch.StartNew;
  ibsqlMDN.ExecQuery;


  while not ibsqlMDN.Eof do
  begin
    TempItem := TRealMDNItem(MdnColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];

    if not ibsqlMDN.Fields[0].IsNull then
    begin
      TempItem.PRecord.DATA := ibsqlMDN.Fields[0].AsDate;
      Include(TempItem.PRecord.setProp, MDN_DATA);
    end;
    if not ibsqlMDN.Fields[1].IsNull then
    begin
      TempItem.PRecord.ID := ibsqlMDN.Fields[1].AsInteger;
      Include(TempItem.PRecord.setProp, MDN_ID);
    end;
    if not ibsqlMDN.Fields[2].IsNull then
    begin
      TempItem.PRecord.NRN := ibsqlMDN.Fields[2].AsString;
      Include(TempItem.PRecord.setProp, MDN_NRN);
    end;
    if not ibsqlMDN.Fields[3].IsNull then
    begin
      TempItem.PRecord.NUMBER := ibsqlMDN.Fields[3].AsInteger;
      Include(TempItem.PRecord.setProp, MDN_NUMBER);
    end;

    TempItem.PregledID := ibsqlMDN.Fields[4].AsInteger;
    TempItem.MainMkb := ibsqlMDN.Fields[5].AsString;
    TempItem.AddMkb := ibsqlMDN.Fields[8].AsString;
    TempItem.MdnId := ibsqlMDN.Fields[1].AsInteger;



    TempItem.PRecord.Logical := [];

    if ibsqlMDN.Fields[6].AsString = 'Y' then
      Include(TempItem.PRecord.Logical, TLogicalMDN.IS_LKK);
    case ibsqlMDN.Fields[12].Asinteger  of
      0: Include(TempItem.PRecord.Logical, TLogicalMDN.NZIS_STATUS_None);
      3: Include(TempItem.PRecord.Logical, TLogicalMDN.NZIS_STATUS_Sended);
      5: Include(TempItem.PRecord.Logical, TLogicalMDN.NZIS_STATUS_Cancel);
    end;


    case ibsqlMDN.Fields[7].Asinteger  of
      1: Include(TempItem.PRecord.Logical, TLogicalMDN.MED_DIAG_NAPR_Ostro);
      2: Include(TempItem.PRecord.Logical, TLogicalMDN.MED_DIAG_NAPR_Hron);
      3: Include(TempItem.PRecord.Logical, TLogicalMDN.MED_DIAG_NAPR_Disp);
      4: Include(TempItem.PRecord.Logical, TLogicalMDN.MED_DIAG_NAPR_Prof);
      5: Include(TempItem.PRecord.Logical, TLogicalMDN.MED_DIAG_NAPR_Iskane_Telk);
      6: Include(TempItem.PRecord.Logical, TLogicalMDN.MED_DIAG_NAPR_Choice_Mother);
      7: Include(TempItem.PRecord.Logical, TLogicalMDN.MED_DIAG_NAPR_Choice_Child);
      9: Include(TempItem.PRecord.Logical, TLogicalMDN.MED_DIAG_NAPR_Eksp);
    end;
    if TempItem.PRecord.Logical <> [] then
    begin
      Include(TempItem.PRecord.setProp, MDN_Logical);
    end;

    if (ibsqlMDN.RecordCount mod 1000) = 0 then
    begin
      MDNColl.CntInADB := ibsqlMDN.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(BLANKA_MDN), ibsqlMDN.RecordCount);
      Sleep(1);
    end;

    TempItem.InsertMDN;
    MDNColl.streamComm.Len := MDNColl.streamComm.Size;
    CmdFile.CopyFrom(MDNColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqlMDN.Next;


  end;
  pCardinalData := pointer(PByte(FBuf));
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;

  MDNColl.CntInADB := ibsqlMDN.RecordCount;


  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(BLANKA_MDN), ibsqlMDN.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddMkb;
var
  p: PInt;
  TempItem: TMkbItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqlMkb: TIBSQL;
begin
  ibsqlMkb := Fdm.ibsqlMKBNew;
  Stopwatch := TStopwatch.StartNew;
  ibsqlMkb.ExecQuery;
  while not ibsqlMkb.Eof do
  begin
    TempItem := TMkbItem(MkbColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    if not ibsqlMkb.Fields[0].IsNull then
    begin
      TempItem.PRecord.CODE := ibsqlMkb.Fields[0].AsString;
      if TempItem.PRecord.CODE = '*' then
        TempItem.PRecord.CODE := '*';
      Include(TempItem.PRecord.setProp, Mkb_CODE);
    end;
    if not ibsqlMkb.Fields[1].IsNull then
    begin
      TempItem.PRecord.NAME := ibsqlMkb.Fields[1].AsString;
      Include(TempItem.PRecord.setProp, Mkb_NAME);
    end;
    if not ibsqlMkb.Fields[2].IsNull then
    begin
      TempItem.PRecord.NOTE := ibsqlMkb.Fields[2].AsString;
      Include(TempItem.PRecord.setProp, Mkb_NOTE);
    end;

    if (ibsqlMkb.RecordCount mod 1000) = 0 then
    begin
      MkbColl.CntInADB := ibsqlMkb.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(ICD10CM), ibsqlMkb.RecordCount);
      Sleep(1);
    end;

    TempItem.InsertMkb;
    MkbColl.streamComm.Len := MkbColl.streamComm.Size;
    CmdFile.CopyFrom(MkbColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqlMkb.Next;


  end;
  pCardinalData := pointer(PByte(FBuf));
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;

  MkbColl.CntInADB := ibsqlMkb.RecordCount;
  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(ICD10CM), ibsqlMkb.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddDoctor;
var
  p: PInt;
  TempItem: TRealDoctorItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqlDoctor: TIBSQL;
begin
  ibsqlDoctor := Fdm.ibsqlDoctorNew;
  Stopwatch := TStopwatch.StartNew;
  ibsqlDoctor.ExecQuery;
  while not ibsqlDoctor.Eof do
  begin
    TempItem := TRealDoctorItem(DoctorColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    if not ibsqlDoctor.Fields[0].IsNull then
    begin
      TempItem.PRecord.EGN := ibsqlDoctor.Fields[0].AsString;
      Include(TempItem.PRecord.setProp, Doctor_EGN);
    end;
    if not ibsqlDoctor.Fields[1].IsNull then
    begin
      TempItem.PRecord.FNAME := ibsqlDoctor.Fields[1].AsString;
      Include(TempItem.PRecord.setProp, Doctor_FNAME);
    end;
    if not ibsqlDoctor.Fields[2].IsNull then
    begin
       TempItem.PRecord.ID := ibsqlDoctor.Fields[2].AsInteger;
       Include(TempItem.PRecord.setProp, Doctor_ID);
    end;
    if not ibsqlDoctor.Fields[3].IsNull then
    begin
      TempItem.PRecord.LNAME := ibsqlDoctor.Fields[3].AsString;
      Include(TempItem.PRecord.setProp, Doctor_LNAME);
    end;
    if not ibsqlDoctor.Fields[4].IsNull then
    begin
      TempItem.PRecord.SNAME := ibsqlDoctor.Fields[4].AsString;
      Include(TempItem.PRecord.setProp, Doctor_SNAME);
    end;
    if not ibsqlDoctor.Fields[5].IsNull then
    begin
      TempItem.PRecord.UIN := ibsqlDoctor.Fields[5].AsString;
      Include(TempItem.PRecord.setProp, Doctor_UIN);
    end;

    TempItem.DoctorID := ibsqlDoctor.Fields[2].AsInteger;

    // TempItem.PregledID := ibsqlPregledNew.Fields[4].AsInteger;
//    TempItem.PatID := ibsqlPregledNew.Fields[28].AsInteger;
//    TempItem.MainMKB := ibsqlPregledNew.Fields[29].AsString;
//    TempItem.MAIN_DIAG_MKB_ADD := ibsqlPregledNew.Fields[30].AsString;
//    TempItem.MainMKB1 := ibsqlPregledNew.Fields[31].AsString;
//    TempItem.MAIN_DIAG_MKB_ADD1 := ibsqlPregledNew.Fields[32].AsString;
//    TempItem.MainMKB2 := ibsqlPregledNew.Fields[33].AsString;
//    TempItem.MAIN_DIAG_MKB_ADD2 := ibsqlPregledNew.Fields[34].AsString;
//    TempItem.MainMKB3 := ibsqlPregledNew.Fields[35].AsString;
//    TempItem.MAIN_DIAG_MKB_ADD3 := ibsqlPregledNew.Fields[36].AsString;
//    TempItem.MainMKB4 := ibsqlPregledNew.Fields[37].AsString;
//    TempItem.MAIN_DIAG_MKB_ADD4 := ibsqlPregledNew.Fields[38].AsString;

    //if true then
//    begin
//      TempItem.PRecord.Logical := [TLogicalPregledNew.IS_MANIPULATION, TLogicalPregledNew.INCIDENTALLY];
//      Include(TempItem.PRecord.setProp, PregledNew_Logical);
//    end;

    if (ibsqlDoctor.RecordCount mod 1000) = 0 then
    begin
      DoctorColl.CntInADB := ibsqlDoctor.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(DOCTOR), ibsqlDoctor.RecordCount);
      Sleep(1);
    end;

    TempItem.InsertDoctor;
    DoctorColl.streamComm.Len := DoctorColl.streamComm.Size;
    CmdFile.CopyFrom(DoctorColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqlDoctor.Next;


  end;
  pCardinalData := pointer(PByte(FBuf));
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  DoctorColl.CntInADB := ibsqlDoctor.RecordCount;
  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(DOCTOR), ibsqlDoctor.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddPacient;
var
  p: PInt;
  TempItem: TRealPatientNewItem;
  i, iEvn: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqlPatientNew: TIBSQL;
begin
  if Fdm.IsGP then
    ibsqlPatientNew := Fdm.ibsqlPatNew_GP
  else
    ibsqlPatientNew := Fdm.ibsqlPatNew_S;

  FDBHelper.cmdFile := cmdFile;
  Stopwatch := TStopwatch.StartNew;
  ibsqlPatientNew.ExecQuery;
  while not ibsqlPatientNew.Eof do
  begin
    TempItem := TRealPatientNewItem(PatientColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    FDBHelper.InsertPatientField(ibsqlPatientNew, TempItem);//otdelno
    if TempItem.FAdresi.Count > 0 then
    begin
      TempItem.FAdresi[0].InsertAddres;
      FNasMesto.addresColl.streamComm.Len := FNasMesto.addresColl.streamComm.Size;
      CmdFile.CopyFrom(FNasMesto.addresColl.streamComm, 0);
      Dispose( TempItem.FAdresi[0].PRecord);
      TempItem.FAdresi[0].PRecord := nil;
    end;

    if (ibsqlPatientNew.RecordCount mod 1000) = 0 then
    begin
      PatientColl.CntInADB := ibsqlPatientNew.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(PACIENT), ibsqlPatientNew.RecordCount);
    end;

    TempItem.InsertPatientNew;
    PatientColl.streamComm.Len := PatientColl.streamComm.Size;
    CmdFile.CopyFrom(PatientColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqlPatientNew.Next;
  end;
  pCardinalData := pointer(PByte(FBuf));
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  PatientColl.CntInADB := ibsqlPatientNew.RecordCount;


  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(PACIENT), ibsqlPatientNew.RecordCount);
end;

procedure TLoadDBThread.AddPractica;
var
  p: PInt;
  TempItem: TPracticaItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqlPractica: TIBSQL;
begin
  ibsqlPractica := Fdm.ibsqlPracNew;
  Stopwatch := TStopwatch.StartNew;
  ibsqlPractica.ExecQuery;
  while not ibsqlPractica.Eof do
  begin
    TempItem := TPracticaItem(PracticaColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];

       if not ibsqlPractica.Fields[0].IsNull then
    begin
      TempItem.PRecord.ADDRESS_ACT := ibsqlPractica.Fields[0].AsString;
      Include(TempItem.PRecord.setProp, Practica_ADDRESS_ACT);
    end;
    if not ibsqlPractica.Fields[1].IsNull then
    begin
      TempItem.PRecord.ADDRESS_DOGNZOK := ibsqlPractica.Fields[1].AsString;
      Include(TempItem.PRecord.setProp, Practica_ADDRESS_DOGNZOK);
    end;
    if not ibsqlPractica.Fields[2].IsNull then
    begin
      TempItem.PRecord.ADRES := ibsqlPractica.Fields[2].AsString;
      Include(TempItem.PRecord.setProp, Practica_ADRES);
    end;
    if not ibsqlPractica.Fields[3].IsNull then
    begin
      TempItem.PRecord.BANKA := ibsqlPractica.Fields[3].AsString;
      Include(TempItem.PRecord.setProp, Practica_BANKA);
    end;
    if not ibsqlPractica.Fields[4].IsNull then
    begin
      TempItem.PRecord.BANKOW_KOD := ibsqlPractica.Fields[4].AsString;
      Include(TempItem.PRecord.setProp, Practica_BANKOW_KOD);
    end;
    if not ibsqlPractica.Fields[5].IsNull then
    begin
      TempItem.PRecord.BULSTAT := ibsqlPractica.Fields[5].AsString;
      Include(TempItem.PRecord.setProp, Practica_BULSTAT);
    end;
    if not ibsqlPractica.Fields[6].IsNull then
    begin
      TempItem.PRecord.COMPANYNAME := ibsqlPractica.Fields[6].AsString;
      Include(TempItem.PRecord.setProp, Practica_COMPANYNAME);
    end;
    if not ibsqlPractica.Fields[7].IsNull then
    begin
      TempItem.PRecord.CONTRACT_DATE := ibsqlPractica.Fields[7].AsDate;
      Include(TempItem.PRecord.setProp, Practica_CONTRACT_DATE);
    end;
    if not ibsqlPractica.Fields[8].IsNull then
    begin
      TempItem.PRecord.CONTRACT_RZOK := ibsqlPractica.Fields[8].AsString;
      Include(TempItem.PRecord.setProp, Practica_CONTRACT_RZOK);
    end;
    if not ibsqlPractica.Fields[9].IsNull then
    begin
      TempItem.PRecord.CONTRACT_TYPE := ibsqlPractica.Fields[9].AsInteger;
      Include(TempItem.PRecord.setProp, Practica_CONTRACT_TYPE);
    end;
    if not ibsqlPractica.Fields[10].IsNull then
    begin
      TempItem.PRecord.DAN_NOMER := ibsqlPractica.Fields[10].AsString;
      Include(TempItem.PRecord.setProp, Practica_DAN_NOMER);
    end;
    if not ibsqlPractica.Fields[11].IsNull then
    begin
      TempItem.PRecord.EGN := ibsqlPractica.Fields[11].AsString;
      Include(TempItem.PRecord.setProp, Practica_EGN);
    end;
    if not ibsqlPractica.Fields[12].IsNull then
    begin
      TempItem.PRecord.FNAME := ibsqlPractica.Fields[12].AsString;
      Include(TempItem.PRecord.setProp, Practica_FNAME);
    end;
    if not ibsqlPractica.Fields[13].IsNull then
    begin
      TempItem.PRecord.FULLNAME := ibsqlPractica.Fields[13].AsString;
      Include(TempItem.PRecord.setProp, Practica_FULLNAME);
    end;
    if not ibsqlPractica.Fields[14].IsNull then
    begin
      TempItem.PRecord.INVOICECOMPANY := ibsqlPractica.Fields[14].AsString = 'Y';
      Include(TempItem.PRecord.setProp, Practica_INVOICECOMPANY);
    end;
    if not ibsqlPractica.Fields[15].IsNull then
    begin
      TempItem.PRecord.ISSUER_TYPE := ibsqlPractica.Fields[15].AsString = 'Y';
      Include(TempItem.PRecord.setProp, Practica_ISSUER_TYPE);
    end;
    if not ibsqlPractica.Fields[16].IsNull then
    begin
      TempItem.PRecord.IS_SAMOOSIG := ibsqlPractica.Fields[16].AsString = 'Y';
      Include(TempItem.PRecord.setProp, Practica_IS_SAMOOSIG);
    end;
    if not ibsqlPractica.Fields[17].IsNull then
    begin
      TempItem.PRecord.KOD_RAJON := ibsqlPractica.Fields[17].AsString;
      Include(TempItem.PRecord.setProp, Practica_KOD_RAJON);
    end;
    if not ibsqlPractica.Fields[18].IsNull then
    begin
      TempItem.PRecord.KOD_RZOK := ibsqlPractica.Fields[18].AsString;
      Include(TempItem.PRecord.setProp, Practica_KOD_RZOK);
    end;
    if not ibsqlPractica.Fields[19].IsNull then
    begin
      TempItem.PRecord.LNAME := ibsqlPractica.Fields[19].AsString;
      Include(TempItem.PRecord.setProp, Practica_LNAME);
    end;
    if not ibsqlPractica.Fields[20].IsNull then
    begin
      TempItem.PRecord.LNCH := ibsqlPractica.Fields[20].AsString;
      Include(TempItem.PRecord.setProp, Practica_LNCH);
    end;
    if not ibsqlPractica.Fields[21].IsNull then
    begin
      TempItem.PRecord.NAME := ibsqlPractica.Fields[21].AsString;
      Include(TempItem.PRecord.setProp, Practica_NAME);
    end;
    if not ibsqlPractica.Fields[22].IsNull then
    begin
      TempItem.PRecord.NAS_MQSTO := ibsqlPractica.Fields[22].AsString;
      Include(TempItem.PRecord.setProp, Practica_NAS_MQSTO);
    end;
    if not ibsqlPractica.Fields[24].IsNull then
    begin
      TempItem.PRecord.NOMER_LZ := ibsqlPractica.Fields[24].AsString;
      Include(TempItem.PRecord.setProp, Practica_NOMER_LZ);
    end;
    if not ibsqlPractica.Fields[25].IsNull then
    begin
      TempItem.PRecord.NOM_NAP := ibsqlPractica.Fields[25].AsString;
      Include(TempItem.PRecord.setProp, Practica_NOM_NAP);
    end;
    if not ibsqlPractica.Fields[26].IsNull then
    begin
      TempItem.PRecord.NZOK_NOMER := ibsqlPractica.Fields[26].AsString;
      Include(TempItem.PRecord.setProp, Practica_NZOK_NOMER);
    end;
    if not ibsqlPractica.Fields[27].IsNull then
    begin
      TempItem.PRecord.OBLAST := ibsqlPractica.Fields[27].AsString;
      Include(TempItem.PRecord.setProp, Practica_OBLAST);
    end;
    if not ibsqlPractica.Fields[28].IsNull then
    begin
      TempItem.PRecord.OBSHTINA := ibsqlPractica.Fields[28].AsString;
      Include(TempItem.PRecord.setProp, Practica_OBSHTINA);
    end;
    if not ibsqlPractica.Fields[29].IsNull then
    begin
      TempItem.PRecord.SELF_INSURED_DECLARATION := ibsqlPractica.Fields[29].AsString = 'Y';
      Include(TempItem.PRecord.setProp, Practica_SELF_INSURED_DECLARATION);
    end;
    if not ibsqlPractica.Fields[30].IsNull then
    begin
      TempItem.PRecord.SMETKA := ibsqlPractica.Fields[30].AsString;
      Include(TempItem.PRecord.setProp, Practica_SMETKA);
    end;
    if not ibsqlPractica.Fields[31].IsNull then
    begin
      TempItem.PRecord.SNAME := ibsqlPractica.Fields[31].AsString;
      Include(TempItem.PRecord.setProp, Practica_SNAME);
    end;
    if not ibsqlPractica.Fields[32].IsNull then
    begin
      TempItem.PRecord.UPRAVITEL := ibsqlPractica.Fields[32].AsString;
      Include(TempItem.PRecord.setProp, Practica_UPRAVITEL);
    end;
    if not ibsqlPractica.Fields[33].IsNull then
    begin
      TempItem.PRecord.VIDFIRMA := ibsqlPractica.Fields[33].AsString;
      Include(TempItem.PRecord.setProp, Practica_VIDFIRMA);
    end;
    if not ibsqlPractica.Fields[34].IsNull then
    begin
      TempItem.PRecord.VID_IDENT := ibsqlPractica.Fields[34].AsString;
      Include(TempItem.PRecord.setProp, Practica_VID_IDENT);
    end;
    if not ibsqlPractica.Fields[35].IsNull then
    begin
      TempItem.PRecord.VID_PRAKTIKA := ibsqlPractica.Fields[35].AsString;
      Include(TempItem.PRecord.setProp, Practica_VID_PRAKTIKA);
    end;
    if not ibsqlPractica.Fields[36].IsNull then
    begin
      TempItem.PRecord.HIP_TYPE := ibsqlPractica.Fields[36].AsString;
      Include(TempItem.PRecord.setProp, Practica_HIP_TYPE);
    end;

    TempItem.InsertPractica;
    PracticaColl.streamComm.Len := PracticaColl.streamComm.Size;
    CmdFile.CopyFrom(PracticaColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqlPractica.Next;
  end;
  pCardinalData := pointer(PByte(FBuf));
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  PracticaColl.CntInADB := ibsqlPractica.RecordCount;
  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(PRACTICA), ibsqlPractica.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddPregled;
var
  p: PInt;
  TempItem: TRealPregledNewItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqlPregledNew: TIBSQL;
begin

  Stopwatch := TStopwatch.StartNew;
  if Fdm.IsGP then
  begin
    ibsqlPregledNew := Fdm.ibsqlPregNew_GP;
  end
  else
  begin
    ibsqlPregledNew := Fdm.ibsqlPregNew_S;
  end;
  ibsqlPregledNew.ExecQuery;
  DiagColl.cmdFile := cmdFile;
 // DiagnosticReportColl.cmdFile := cmdFile;
  while not ibsqlPregledNew.Eof do
  begin
    TempItem := TRealPregledNewItem(PregledNewColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    FDBHelper.InsertPregledField(ibsqlPregledNew, TempItem); // otdeleno
    if (ibsqlPregledNew.RecordCount mod 1000) = 0 then
    begin
      PregledNewColl.CntInADB := ibsqlPregledNew.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(PREGLED), ibsqlPregledNew.RecordCount);
      Sleep(1);
    end;
    TempItem.InsertPregledNew;

    PregledNewColl.streamComm.Len := PregledNewColl.streamComm.Size;
    CmdFile.CopyFrom(PregledNewColl.streamComm, 0);


    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqlPregledNew.Next;

  end;
  pCardinalData := pointer(FBuf);
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  PregledNewColl.CntInADB := ibsqlPregledNew.RecordCount;

  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(PREGLED), ibsqlPregledNew.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddProcedures;
var
  p: PInt;
  TempItem: TRealProceduresItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqlProcedures: TIBSQL;
begin
  if Fdm.IsGP then
  begin
    ibsqlProcedures := Fdm.ibsqlProceduresGP;
  end
  else
  begin
    ibsqlProcedures := Fdm.ibsqlProcedures_S;
  end;
  Stopwatch := TStopwatch.StartNew;
  ibsqlProcedures.ExecQuery;
  while not ibsqlProcedures.Eof do
  begin
    TempItem := TRealProceduresItem(ProcCollNomen.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
        if not ibsqlProcedures.Fields[0].IsNull then
    begin
      TempItem.PRecord.ARTICLE_147 := ibsqlProcedures.Fields[0].AsString = 'Y';
      Include(TempItem.PRecord.setProp, Procedures_ARTICLE_147);
    end;
    if not ibsqlProcedures.Fields[1].IsNull then
    begin
      TempItem.PRecord.CODE := ibsqlProcedures.Fields[1].AsString;
      Include(TempItem.PRecord.setProp, Procedures_CODE);
    end;
    if not ibsqlProcedures.Fields[2].IsNull then
    begin
      TempItem.PRecord.EFFECTIVE := ibsqlProcedures.Fields[2].AsString = 'Y';
      Include(TempItem.PRecord.setProp, Procedures_EFFECTIVE);
    end;
    if not ibsqlProcedures.Fields[3].IsNull then
    begin
      TempItem.PRecord.FIZIO_GROUP := ibsqlProcedures.Fields[3].AsInteger;
      Include(TempItem.PRecord.setProp, Procedures_FIZIO_GROUP);
    end;
    if not ibsqlProcedures.Fields[4].IsNull then
    begin
      TempItem.PRecord.HI_EQUIPMENT := ibsqlProcedures.Fields[4].AsString;
      Include(TempItem.PRecord.setProp, Procedures_HI_EQUIPMENT);
    end;
    if not ibsqlProcedures.Fields[5].IsNull then
    begin
      TempItem.PRecord.HI_REQUIREMENTS := ibsqlProcedures.Fields[5].AsString;
      Include(TempItem.PRecord.setProp, Procedures_HI_REQUIREMENTS);
    end;
    if not ibsqlProcedures.Fields[6].IsNull then
    begin
      TempItem.PRecord.HI_SPECIALIZED := ibsqlProcedures.Fields[6].AsString = 'Y';
      Include(TempItem.PRecord.setProp, Procedures_HI_SPECIALIZED);
    end;
    if not ibsqlProcedures.Fields[7].IsNull then
    begin
       TempItem.PRecord.ID := ibsqlProcedures.Fields[7].AsInteger;
       Include(TempItem.PRecord.setProp, Procedures_ID);
    end;
    if not ibsqlProcedures.Fields[8].IsNull then
    begin
      TempItem.PRecord.IS_EXAM_TYPE := ibsqlProcedures.Fields[8].AsString = 'Y';
      Include(TempItem.PRecord.setProp, Procedures_IS_EXAM_TYPE);
    end;
    if not ibsqlProcedures.Fields[9].IsNull then
    begin
      TempItem.PRecord.IS_HOSPITAL := ibsqlProcedures.Fields[9].AsString = 'Y';
      Include(TempItem.PRecord.setProp, Procedures_IS_HOSPITAL);
    end;
    if not ibsqlProcedures.Fields[10].IsNull then
    begin
      TempItem.PRecord.KSMP := ibsqlProcedures.Fields[10].AsString;
      Include(TempItem.PRecord.setProp, Procedures_KSMP);
    end;
    if not ibsqlProcedures.Fields[11].IsNull then
    begin
      TempItem.PRecord.NAME := ibsqlProcedures.Fields[11].AsString;
      Include(TempItem.PRecord.setProp, Procedures_NAME);
    end;
    if not ibsqlProcedures.Fields[12].IsNull then
    begin
       TempItem.PRecord.PACKAGE_ID := ibsqlProcedures.Fields[12].AsInteger;
       Include(TempItem.PRecord.setProp, Procedures_PACKAGE_ID);
    end;

    TempItem.CodeOpis := ibsqlProcedures.Fields[14].AsString;

    TempItem.InsertProcedures;
    ProcCollNomen.streamComm.Len := ProcCollNomen.streamComm.Size;
    CmdFile.CopyFrom(ProcCollNomen.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqlProcedures.Next;


  end;
  pCardinalData := pointer(PByte(FBuf));
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;

  ProcCollNomen.CntInADB := ibsqlProcedures.RecordCount;
  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(PROCEDURES), ibsqlProcedures.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddProfCard;
var
  p: PInt;
  TempItem: TRealKARTA_PROFILAKTIKA2017Item;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqlKardProf: TIBSQL;
begin
  if not Fdm.IsGP then  Exit;
  Stopwatch := TStopwatch.StartNew;
  ibsqlKardProf := Fdm.ibsqlKardProf;
  ibsqlKardProf.ExecQuery;
  while not ibsqlKardProf.Eof do
  begin
    TempItem := TRealKARTA_PROFILAKTIKA2017Item(KARTA_PROFILAKTIKA2017Coll.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];
    FDBHelper.InsertKardProfField(ibsqlKardProf, TempItem); // otdeleno
    if (ibsqlKardProf.RecordCount mod 1000) = 0 then
    begin
      KARTA_PROFILAKTIKA2017Coll.CntInADB := ibsqlKardProf.RecordCount;
      if Assigned(FOnProgres) then
        FOnProgres(Self, Integer(KARTA_PROFILAKTIKA2017), ibsqlKardProf.RecordCount);
      Sleep(1);
    end;
    TempItem.InsertKARTA_PROFILAKTIKA2017;

    KARTA_PROFILAKTIKA2017Coll.streamComm.Len := KARTA_PROFILAKTIKA2017Coll.streamComm.Size;
    CmdFile.CopyFrom(KARTA_PROFILAKTIKA2017Coll.streamComm, 0);


    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqlKardProf.Next;

  end;
  pCardinalData := pointer(FBuf);
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
  KARTA_PROFILAKTIKA2017Coll.CntInADB := ibsqlKardProf.RecordCount;

  if Assigned(FOnProgres) then
    FOnProgres(Self, Integer(KARTA_PROFILAKTIKA2017), ibsqlKardProf.RecordCount);
  Sleep(1);
end;

procedure TLoadDBThread.AddUnFav;
var
  p: PInt;
  TempItem: TRealUnfavItem;
  i: Integer;
  pCardinalData: ^Cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  ibsqlUnFav: TIBSQL;
begin
  ibsqlUnFav := Fdm.ibsqlUnfavNew;
  Stopwatch := TStopwatch.StartNew;
  ibsqlUnFav.ExecQuery;
  while not ibsqlUnFav.Eof do
  begin
    TempItem := TRealUnfavItem(UnFavColl.Add);
    New(TempItem.PRecord);
    TempItem.PRecord.setProp := [];

    if not ibsqlUnfav.Fields[0].IsNull then
    begin
       TempItem.PRecord.ID := ibsqlUnfav.Fields[0].AsInteger;
       Include(TempItem.PRecord.setProp, Unfav_ID);
    end;
    if not ibsqlUnfav.Fields[1].IsNull then
    begin
      TempItem.PRecord.DOCTOR_ID_PRAC := ibsqlUnfav.Fields[1].AsInteger;
      Include(TempItem.PRecord.setProp, Unfav_DOCTOR_ID_PRAC);
    end;
    if not ibsqlUnfav.Fields[2].IsNull then
    begin
      TempItem.PRecord.YEAR_UNFAV := ibsqlUnfav.Fields[2].AsInteger;
      Include(TempItem.PRecord.setProp, Unfav_YEAR_UNFAV);
    end;
    if not ibsqlUnfav.Fields[3].IsNull then
    begin
      TempItem.PRecord.MONTH_UNFAV := ibsqlUnfav.Fields[3].AsInteger;
      Include(TempItem.PRecord.setProp, Unfav_MONTH_UNFAV);
    end;


    // TempItem.PregledID := ibsqlPregledNew.Fields[4].AsInteger;
//    TempItem.PatID := ibsqlPregledNew.Fields[28].AsInteger;
//    TempItem.MainMKB := ibsqlPregledNew.Fields[29].AsString;
//    TempItem.MAIN_DIAG_MKB_ADD := ibsqlPregledNew.Fields[30].AsString;
//    TempItem.MainMKB1 := ibsqlPregledNew.Fields[31].AsString;
//    TempItem.MAIN_DIAG_MKB_ADD1 := ibsqlPregledNew.Fields[32].AsString;
//    TempItem.MainMKB2 := ibsqlPregledNew.Fields[33].AsString;
//    TempItem.MAIN_DIAG_MKB_ADD2 := ibsqlPregledNew.Fields[34].AsString;
//    TempItem.MainMKB3 := ibsqlPregledNew.Fields[35].AsString;
//    TempItem.MAIN_DIAG_MKB_ADD3 := ibsqlPregledNew.Fields[36].AsString;
//    TempItem.MainMKB4 := ibsqlPregledNew.Fields[37].AsString;
//    TempItem.MAIN_DIAG_MKB_ADD4 := ibsqlPregledNew.Fields[38].AsString;

    //if true then
//    begin
//      TempItem.PRecord.Logical := [TLogicalPregledNew.IS_MANIPULATION, TLogicalPregledNew.INCIDENTALLY];
//      Include(TempItem.PRecord.setProp, PregledNew_Logical);
//    end;

    TempItem.InsertUnfav;
    UnFavColl.streamComm.Len := UnFavColl.streamComm.Size;
    CmdFile.CopyFrom(UnFavColl.streamComm, 0);
    Dispose(TempItem.PRecord);
    TempItem.PRecord := nil;
    ibsqlUnFav.Next;


  end;
  UnFavColl.CurrentYear := CurrentYear;
  pCardinalData := pointer(PByte(FBuf));
  FPosMetaData := pCardinalData^;
  Elapsed := Stopwatch.Elapsed;
end;

constructor TLoadDBThread.Create(CreateSuspended: Boolean; DbName: string);
begin
  inherited Create(CreateSuspended);
  Fdm := TDUNzis.Create(nil);
  Fdm.InitDb(DbName);
  AnalsColl := TAnalsNewColl.Create(TAnalsNewItem);
end;

destructor TLoadDBThread.Destroy;
begin
  FreeAndNil(fdm);
  FreeAndNil(AnalsColl);
  inherited;
end;

procedure TLoadDBThread.DoTerminate;
begin
  inherited;

end;

procedure TLoadDBThread.Execute;
var
  comInitStatus: THandle;
begin
  ReturnValue := 0;
  comInitStatus := S_FALSE;
  try
    comInitStatus := CoInitializeEx(nil, COINIT_MULTITHREADED);
    inherited;
    //while  not Terminated do
    begin
      FDBHelper.Fdm := Fdm;
      GetCountFromDB;
      PregledNewColl.FCollProceduresPreg := ProcCollPreg;

      AddPractica;
      AddDoctor;
      AddMkb;
      AddProfCard;
      FillCl142InProcedures;
      AddPacient;
      AddIncMN;
      AddIncDoctor;
      AddPregled; //  след добавянето на прегледите имам в тях списъци на процедурите им. В тях е и КодОпис-а
      AddIncMdn;

      FillProceduresInPregledProcs;

      AddMdn;
      AddEBL;
      AddExamAnal;
      AddExamImmun;
      AddMedNapr;
      AddMedNapr3A;
      AddMedNaprHosp;
      AddMedNaprLkk;
      DiagColl.FillMkb(MkbColl);

     // if not Fdm.IsGP then
//        AddUnFav;



      SetUserHistory;
      GetNewID;


    end;
  finally
    //if Assigned(OnTerminate) then
      //OnTerminate(Self);
    case comInitStatus of
      S_OK, S_FALSE: CoUninitialize;
    end;
  end;

end;


procedure TLoadDBThread.FillCl142InProcedures;
var
  iCl142, iProc: integer;
begin
  Cl142Coll.IndexValue(CL142_nhif_code);
  Cl142Coll.SortByIndexAnsiString;
  ProcCollNomen.IndexValue(Procedures_CODE);
  ProcCollNomen.SortByIndexAnsiString;
  Stopwatch := TStopwatch.StartNew;
  iCl142 := 0;
  iProc := 0;

  while (iCl142 < Cl142Coll.Count)  and (iProc < ProcCollNomen.Count) do
  begin
    if Cl142Coll.Items[iCl142].IndexAnsiStr1 = ProcCollNomen.Items[iProc].IndexAnsiStr1 then
    begin
      if Cl142Coll.Items[iCl142].IndexAnsiStr1 <> '' then
      begin
        ProcCollNomen.Items[iProc].FCl142 := Cl142Coll.Items[iCl142];
      end;
      inc(iCl142);
    end
    else if Cl142Coll.Items[iCl142].IndexAnsiStr1 > ProcCollNomen.Items[iProc].IndexAnsiStr1 then
    begin
      begin
        inc(iProc);

      end;
    end
    else if Cl142Coll.Items[iCl142].IndexAnsiStr1 < ProcCollNomen.Items[iProc].IndexAnsiStr1 then
    begin
      inc(iCl142);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  //mmotest.Lines.Add( 'fillPat ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TLoadDBThread.FillProceduresInPregledProcs;
var
  iNomenProc, iProcPreg, i, j, k: integer;
  PrevCodeOpis: string;
  lstUsersCodeOpis: TStringList;
  proc: TRealProceduresItem;
begin
  lstUsersCodeOpis := TStringList.Create;
  ProcCollNomen.SortByCodeOpis;
  ProcCollPreg.SortByCodeOpis;

  Stopwatch := TStopwatch.StartNew;
  iNomenProc := 0;
  iProcPreg := 0;

  while (iNomenProc < ProcCollNomen.Count)  and (iProcPreg < ProcCollPreg.Count) do
  begin
    if ProcCollNomen.Items[iNomenProc].CodeOpis = ProcCollPreg.Items[iProcPreg].CodeOpis then
    begin
      ProcCollPreg.Items[iProcPreg].FPregled.FProcedures.Add(ProcCollNomen.Items[iNomenProc]);
      PrevCodeOpis := ProcCollPreg.Items[iProcPreg].CodeOpis;
      inc(iProcPreg);
    end
    else if ProcCollNomen.Items[iNomenProc].CodeOpis > ProcCollPreg.Items[iProcPreg].CodeOpis then
    begin
      begin
        if ProcCollPreg.Items[iProcPreg].CodeOpis <> PrevCodeOpis then
        begin
          ProcCollPreg.Items[iProcPreg].FPregled.FCodeOpis.Add(ProcCollPreg.Items[iProcPreg].CodeOpis);
          lstUsersCodeOpis.Add(ProcCollPreg.Items[iProcPreg].CodeOpis);
        end;
        inc(iProcPreg);


      end;
    end
    else if ProcCollNomen.Items[iNomenProc].CodeOpis < ProcCollPreg.Items[iProcPreg].CodeOpis then
    begin
      inc(iNomenProc);
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  for i := lstUsersCodeOpis.Count - 1 downto 1 do
  begin
    if lstUsersCodeOpis[i] = lstUsersCodeOpis[i-1] then
      lstUsersCodeOpis.Delete(i);
  end;
  for i := 0 to lstUsersCodeOpis.Count - 1 do
  begin
    // Каквото има тука се записва в потребителска номенклатура
    proc := TRealProceduresItem(ProcCollNomen.Add);
    proc.CodeOpis := lstUsersCodeOpis[i];
    lstUsersCodeOpis.Objects[i] := proc;
  end;
  for i := 0 to PregledNewColl.Count - 1 do
  begin
    if PregledNewColl.Items[i].FCodeOpis.Count > 0 then
    begin
      for j := 0 to PregledNewColl.Items[i].FCodeOpis.Count - 1 do
      begin
        for k := 0 to lstUsersCodeOpis.Count - 1 do
        begin
          if lstUsersCodeOpis[k] = PregledNewColl.Items[i].FCodeOpis[j] then
          begin
            PregledNewColl.Items[i].FProcedures.Add(TRealProceduresItem(lstUsersCodeOpis.Objects[k]));
          end;
        end;

      end;
    end;
  end;
  lstUsersCodeOpis.Free;
end;

function TLoadDBThread.GetComputerNam: string;
var
  namSize: dword;
  compName: array[0..MAX_PATH] of AnsiChar;
begin
  namSize := MAX_PATH - 1;
  GetComputerNameA(compName, namSize);
  Result := compName;
end;

procedure TLoadDBThread.GetCountFromDB;
begin
  //Fdm.ibsqlCommandUdost.Close;
//  Fdm.ibsqlCommandUdost.SQL.Text :=
//      'update RDB$INDICES' + #13#10 +
//      'set RDB$STATISTICS = -1' + #13#10 +
//      '' + #13#10 +
//      'where RDB$RELATION_NAME in (''PREGLED'', ''PACIENT'');';
//  Fdm.ibsqlCommandUdost.ExecQuery;
//  Fdm.ibsqlCommandUdost.Transaction.CommitRetaining;

  Fdm.ibsqlCommandUdost.Close;
  Fdm.ibsqlCommandUdost.SQL.Text :=
      'select RDB$RELATIONS.RDB$RELATION_NAME,' + #13#10 +
             'case' + #13#10 +
               'when RDB$INDICES.RDB$STATISTICS = 0 then 0' + #13#10 +
               'else cast(1 / RDB$INDICES.RDB$STATISTICS as integer)' + #13#10 +
             'end' + #13#10 +
      'from RDB$RELATIONS' + #13#10 +
      'left join RDB$RELATION_CONSTRAINTS on RDB$RELATIONS.RDB$RELATION_NAME = RDB$RELATION_CONSTRAINTS.RDB$RELATION_NAME and' + #13#10 +
            'RDB$CONSTRAINT_TYPE = ''PRIMARY KEY''' + #13#10 +
      'left join RDB$INDICES on RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME = RDB$INDICES.RDB$INDEX_NAME' + #13#10 +
      'where RDB$VIEW_BLR is null and' + #13#10 +
            'RDB$RELATION_ID >= 128 and RDB$RELATIONS.RDB$RELATION_NAME in (''PREGLED'', ''PACIENT'')' + #13#10 +
      'order by 1;';
  Fdm.ibsqlCommandUdost.ExecQuery;
  FCntPatient := Fdm.ibsqlCommandUdost.Fields[1].AsInteger;
  if Assigned(FOnCnt) then
    FOnCnt(Self, Integer(vvPatient) , FCntPatient);
  Fdm.ibsqlCommandUdost.Next;
  FCntPregled := Fdm.ibsqlCommandUdost.Fields[1].AsInteger;
  if Assigned(FOnCnt) then
    FOnCnt(Self, Integer(vvPregled), FCntPregled);
end;

procedure TLoadDBThread.GetNewID;
var
  newId: Integer;
  pCardinalData: ^Cardinal;
begin
  Fdm.ibsqlCommand.Close;
  Fdm.ibsqlCommand.SQL.Text :=
          'select max(id) from history';
  Fdm.ibsqlCommand.ExecQuery;
  newId := Fdm.ibsqlCommand.Fields[0].AsInteger;
  Fdm.ibsqlCommand.Close;
  pCardinalData := pointer(PByte(FBuf) + 32);
  pCardinalData^  := NewID;
end;

procedure TLoadDBThread.GetPregNumerator;
var
  i: Integer;
begin
  PregledNewColl.IndexValue(PregledNew_START_DATE);
  PregledNewColl.SortByIndexInt;

end;

procedure TLoadDBThread.LinkAnalsToCollAnals;
begin
  //
end;

procedure TLoadDBThread.RemontCl142;
var
  i, j: Integer;
  cl142, TempItem: TCL142Item;
  nhifCode: string;
  ArrNhifCode: TArray<string>;
  datPos: Cardinal;
  pCardinalData: ^Cardinal;
  len: Word;
begin
  for i := 0 to Cl142Coll.Count - 1 do
  begin
    cl142 := Cl142Coll.Items[i];
    nhifCode := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_nhif_code));
    if (nhifCode.Contains(';')) or (nhifCode.Contains(',')) then
    begin
      ArrNhifCode := nhifCode.Split([';', ',']);
      for j := 0 to Length(ArrNhifCode) - 1 do
      begin
        if j = 0 then
        begin
          New(cl142.PRecord);
          cl142.PRecord.setProp := [CL142_nhif_code];
          cl142.PRecord.nhif_code := ArrNhifCode[j];
          datPos := AdbNomen.FPosData + AdbNomen.FLenData;
          cl142.SaveCL142(datPos);
          pCardinalData := pointer(PByte(AdbNomen.Buf) + 12);
          pCardinalData^  := datPos - self.AdbNomen.FPosData;
        end
        else
        begin
          TempItem := TCL142Item(Cl142Coll.Add);
          New(TempItem.PRecord);
          datPos := Cl142Coll.posData;
          TempItem.PRecord.setProp := [CL142_Key, CL142_Description];
          TempItem.PRecord.Key := cl142.getAnsiStringMap(Cl142Coll.Buf, datPos, word(CL142_Key));
          TempItem.PRecord.Description := cl142.getAnsiStringMap(Cl142Coll.Buf, datPos, word(CL142_Description));

          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_DescriptionEn), len) <> nil then
          begin
            TempItem.PRecord.DescriptionEn := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_DescriptionEn));
            include(TempItem.PRecord.setProp, CL142_DescriptionEn);
          end;
          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_achi_block), len) <> nil then
          begin
            TempItem.PRecord.DescriptionEn := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_achi_block));
            include(TempItem.PRecord.setProp, CL142_achi_block);
          end;
          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_achi_chapter), len) <> nil then
          begin
            TempItem.PRecord.DescriptionEn := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_achi_chapter));
            include(TempItem.PRecord.setProp, CL142_achi_chapter);
          end;
          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_achi_code), len) <> nil then
          begin
            TempItem.PRecord.DescriptionEn := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_achi_code));
            include(TempItem.PRecord.setProp, CL142_achi_code);
          end;
          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_nhif_code), len) <> nil then
          begin
            TempItem.PRecord.DescriptionEn := ArrNhifCode[j];
            include(TempItem.PRecord.setProp, CL142_nhif_code);
          end;
          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_cl048), len) <> nil then
          begin
            TempItem.PRecord.DescriptionEn := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_cl048));
            include(TempItem.PRecord.setProp, CL142_cl048);
          end;
          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_cl006), len) <> nil then
          begin
            TempItem.PRecord.DescriptionEn := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_cl006));
            include(TempItem.PRecord.setProp, CL142_cl006);
          end;
          if cl142.getPAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_highly), len) <> nil then
          begin
            TempItem.PRecord.DescriptionEn := cl142.getAnsiStringMap(Cl142Coll.Buf, Cl142Coll.posData, word(CL142_highly));
            include(TempItem.PRecord.setProp, CL142_highly);
          end;


          TempItem.InsertCL142;
          Dispose(TempItem.PRecord);
          TempItem.PRecord := nil;
        end;
      end;
    end;
  end;
end;

procedure TLoadDBThread.SetUserHistory;
begin
  Fdm.ibsqlCommand.Close;
  Fdm.ibsqlCommand.SQL.Text :=
          'UPDATE OR INSERT INTO HISTORY_USERS (COMP_NAME, GUID_ADB)' + #13#10 +
                             'VALUES (:CompName,:Guid)' + #13#10 +
                           'MATCHING (COMP_NAME, GUID_ADB);';
  Fdm.ibsqlCommand.ParamByName('CompName').AsString := GetComputerNam;
  Fdm.ibsqlCommand.ParamByName('Guid').AsString := Self.Guid.ToString;
  Fdm.ibsqlCommand.ExecQuery;
  Fdm.ibsqlCommand.Transaction.CommitRetaining;
  Fdm.ibsqlCommand.Close;
end;

procedure TLoadDBThread.UpdatePregled;
begin

end;

end.
