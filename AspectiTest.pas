unit AspectiTest;

interface

uses
  FMX.Forms,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, system.Diagnostics, system.TimeSpan,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.GIFImg, VirtualTrees, system.Rtti,
  System.Generics.Collections, System.DateUtils, System.Math,

  VirtualStringTreeAspect,
  Aspects.Types,
  ADB_DataUnit,
  Aspects.Collections,
  New,

  RealObj.RealHipp,
  Table.PregledNew,
  Table.PatientNew,
  Table.Certificates,
  Table.NzisToken,
  Table.Practica,
  Table.Mkb,


  Parnassus.FMXContainer, VCLTee.Control, VCLTee.Grid
  ;

type
  TForm5 = class(TForm)
    btnOpenLNK: TButton;
    mmoTest: TMemo;
    spl1: TSplitter;
    vtrPregledPat: TVirtualStringTreeAspect;
    spl2: TSplitter;
    pnlTop: TPanel;
    fmxCntrDyn: TFireMonkeyContainer;
    btnLoopLink: TButton;
    btnLoopTree: TButton;
    tgrd1: TTeeGrid;
    hntLek: TBalloonHint;
    btnCreateNewLink: TButton;
    btnOpenLnkOptions: TButton;
    procedure btnOpenLNKClick(Sender: TObject);
    procedure vtrPregledPatGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure fmxCntrDynCreateFMXForm(var Form: TCommonCustomForm);
    procedure btnLoopLinkClick(Sender: TObject);
    procedure btnLoopTreeClick(Sender: TObject);
    procedure vtrPregledPatChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tgrd1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlTopMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnCreateNewLinkClick(Sender: TObject);
    procedure btnOpenLnkOptionsClick(Sender: TObject);
  private
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    AspectsLinkPatPregFile: TMappedLinkFile;
    AspectsHipFile: TMappedFile;
    AspectsOptionsLinkFile: TMappedLinkFile;

    collPractica: TPracticaColl;
    CollPregled: TRealPregledNewColl;
    collPatient: TRealPatientNewColl;
    collDoctor: TRealDoctorColl;
    CollDiag: TRealDiagnosisColl;
    CollMDN: TRealMDNColl;
    CollEventsManyTimes: TRealEventsManyTimesColl;
    CollEbl: TRealExam_boln_listColl;
    CollExamAnal: TRealExamAnalysisColl;
    CollExamImun: TRealExamImmunizationColl;
    CollProceduresNomen: TRealProceduresColl;
    CollProceduresPreg: TRealProceduresColl;
    CollCardProf: TRealKARTA_PROFILAKTIKA2017Coll;
    CollMedNapr: TRealBLANKA_MED_NAPRColl;
    CollNZIS_PLANNED_TYPE: TRealNZIS_PLANNED_TYPEColl;
    CollNZIS_QUESTIONNAIRE_RESPONSE: TRealNZIS_QUESTIONNAIRE_RESPONSEColl;
    CollNZIS_QUESTIONNAIRE_ANSWER: TRealNZIS_QUESTIONNAIRE_ANSWERColl;
    CollNZIS_ANSWER_VALUE: TRealNZIS_ANSWER_VALUEColl;
    CollNZIS_DIAGNOSTIC_REPORT: TRealNZIS_DIAGNOSTIC_REPORTColl;
    CollNzis_RESULT_DIAGNOSTIC_REPORT: TRealNZIS_RESULT_DIAGNOSTIC_REPORTColl;

    CollNzisToken: TNzisTokenColl;
    CollCertificates: TCertificatesColl;

    CollMkb: TMkbColl;
  public
    Adb_DM: TADBDataModule;

    procedure OpenADB(ADB: TMappedFile);
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

{ TForm5 }

procedure TForm5.btnCreateNewLinkClick(Sender: TObject);
var
  fileNameLink: string;
  fileStr: TFileStream;
  Pg: PGUID;
  TreeLink: PVirtualNode;
  linkPos: Cardinal;
begin
  Stopwatch := TStopwatch.StartNew;
  fileNameLink := 'd:\LinkOptions.lnk';

  DeleteFile(fileNameLink);
  fileStr := TFileStream.Create(fileNameLink, fmCreate);
  fileStr.Size := 100000;
  fileStr.Free;

  AspectsOptionsLinkFile := TMappedLinkFile.Create(fileNameLink, true, TGUID.Empty);
  AspectsOptionsLinkFile.FVTR := vtrPregledPat;
  AspectsOptionsLinkFile.AddNewNode(vvRootOptions, 0, vtrPregledPat.RootNode, amAddChildFirst, TreeLink, linkPos);

  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( 'newLink ' + FloatToStr(Elapsed.TotalMilliseconds));

end;

procedure TForm5.btnLoopLinkClick(Sender: TObject);
var
  linkPos: cardinal;
  pCardinalData: PCardinal;
  PosLinkData: Cardinal;
  node: PVirtualNode;
  buf: Pointer;

  data: PAspRec;
  cntPreg: Integer;
  lstPreg: TList<PVirtualNode>;
  DatePreg, testDate: TDate;
  testTime: TTime;
  ofset: Cardinal;
  p: pcardinal;
  pData: ^tdate;
begin
  Stopwatch := TStopwatch.StartNew;
  buf := AspectsLinkPatPregFile.Buf;
  linkPos := 100;
  cntPreg := 0;
  testDate := EncodeDate(2023, 12, 02);
  testTime := EncodeTime(12, 00, 00, 00);
  pCardinalData := pointer(PByte(Buf));
  PosLinkData := pCardinalData^;
  lstPreg := TList<PVirtualNode>.create;

  while linkPos <= PosLinkData do
  begin
    node := pointer(PByte(Buf) + linkpos);
    data := Pointer(PByte(node)+ lenNode);
    case data.vid of
      vvPregled:
      begin
        p := pointer(PByte(AspectsHipFile.Buf) + data.dataPos + 4*Word(PregledNew_START_DATE));
        //pData := pointer(PByte(AspectsHipFile.buf) + p^ + AspectsHipFile.FPosData);
        if data.DataPos >= 300  then
          lstPreg.Add(node);
        //DatePreg := pdata^;
        //ofset := p^ ;//+ AspectsHipFile.FPosData;
        //DatePreg := CollPregled.getDateMapPos(Data.DataPos, Word(PregledNew_START_DATE));
        //ofset := data.dataPos + 4*Word(PregledNew_START_DATE);

        //if DatePreg >= testDate then
//        begin
//          if CollPregled.getDateMap(Data.DataPos, Word(PregledNew_START_TIME)) >= testTime then
//          begin
//            lstPreg.Add(node);
//          end;
//        end;
      end;
    end;
    Inc(linkPos, LenData);
  end;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('LoopLink за %f',[Elapsed.TotalMilliseconds]));
  mmoTest.Lines.Add( Format('Брой прегледи за %d',[lstPreg.Count]));
  lstPreg.Clear;
  lstPreg.Free;
end;

procedure TForm5.btnLoopTreeClick(Sender: TObject);
var
  patNode, run: PVirtualNode;
  data: PAspRec;
  lstPreg: TList<PVirtualNode>;
begin

  patNode := vtrPregledPat.GetFirstSelected();
  Stopwatch := TStopwatch.StartNew;
  lstPreg := TList<PVirtualNode>.Create;
  run := patNode.FirstChild;
  while run <> nil do
  begin
    data := Pointer(PByte(run)+ lenNode);
    case data.vid of
      vvPregled:
      begin
        lstPreg.Add(run);
      end;
    end;
    run := run.NextSibling;
  end;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('LoopTree %d за %f',[lstPreg.Count,  Elapsed.TotalMilliseconds]));
  lstPreg.Clear;
  lstPreg.Free;
end;

procedure TForm5.btnOpenLNKClick(Sender: TObject);
var
  fileLinkName, fileAdbName: string;
begin
  Stopwatch := TStopwatch.StartNew;
  fileLinkName := 'D:\VSS\Hippocrates40\bin\Hippocrates360\AspHip{1AA755B0-D6DF-4B98-BAC8-99036AD8009F}.lnk';
  fileAdbName := 'D:\VSS\Hippocrates40\bin\Hippocrates360\AspHip{1AA755B0-D6DF-4B98-BAC8-99036AD8009F}.adb';
  AspectsHipFile := TMappedFile.Create(fileAdbName, false, TGUID.Empty);
  AspectsLinkPatPregFile := TMappedLinkFile.Create(fileLinkName, false, TGUID.Empty);

  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('MapLink за %f',[Elapsed.TotalMilliseconds]));


  AspectsLinkPatPregFile.FVTR := vtrPregledPat;
  Stopwatch := TStopwatch.StartNew;
  AspectsLinkPatPregFile.OpenLinkFile;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('ЗарежданеLink %d за %f',[vtrPregledPat.RootNode.TotalCount,  Elapsed.TotalMilliseconds]));

  OpenADB(AspectsHipFile);
end;

procedure TForm5.btnOpenLnkOptionsClick(Sender: TObject);
var
  fileLinkOptName: string;
begin
  Stopwatch := TStopwatch.StartNew;
  fileLinkOptName := 'd:\LinkOptions.lnk';
  AspectsOptionsLinkFile := TMappedLinkFile.Create(fileLinkOptName, false, TGUID.Empty);

  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('MapLink за %f',[Elapsed.TotalMilliseconds]));


  AspectsOptionsLinkFile.FVTR := vtrPregledPat;
  Stopwatch := TStopwatch.StartNew;
  AspectsOptionsLinkFile.OpenLinkFile;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('ЗарежданеLink %d за %f',[vtrPregledPat.RootNode.TotalCount,  Elapsed.TotalMilliseconds]));

end;

procedure TForm5.fmxCntrDynCreateFMXForm(var Form: TCommonCustomForm);
begin
  if not Assigned(Form) then
  begin
    frmfmxNew := TfrmfmxNew.Create(nil);
    Form := frmfmxNew;
    frmfmxNew.Adb_DM := Adb_DM;
    
  end;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  CollPregled := TRealPregledNewColl.Create(TRealPregledNewItem);
  CollDoctor := TRealDoctorColl.Create(TRealDoctorItem);
  CollMkb := TMkbColl.Create(TMkbItem);
  CollPregled := TRealPregledNewColl.Create(TRealPregledNewItem);
  CollPatient := TRealPatientNewColl.Create(TRealPatientNewItem);
  CollDiag := TRealDiagnosisColl.Create(TRealDiagnosisItem);
  CollMDN := TRealMDNColl.Create(TRealMDNItem);
  CollEventsManyTimes := TRealEventsManyTimesColl.Create(TRealEventsManyTimesItem);
  CollPractica := TPracticaColl.Create(TPracticaItem);
  CollEbl := TRealExam_boln_listColl.Create(TRealExam_boln_listItem);
  CollExamAnal := TRealExamAnalysisColl.Create(TRealExamAnalysisItem);
  CollExamImun := TRealExamImmunizationColl.Create(TRealExamImmunizationItem);
  CollProceduresNomen := TRealProceduresColl.Create(TRealProceduresItem);
  CollProceduresPreg := TRealProceduresColl.Create(TRealProceduresItem);
  CollCardProf := TRealKARTA_PROFILAKTIKA2017Coll.Create(TRealKARTA_PROFILAKTIKA2017Item);
  CollMedNapr := TRealBLANKA_MED_NAPRColl.Create(TRealBLANKA_MED_NAPRItem);
  CollNzisToken := TNzisTokenColl.Create(TNzisTokenItem);
  CollCertificates := TCertificatesColl.Create(TCertificatesItem);

  CollNZIS_PLANNED_TYPE := TRealNZIS_PLANNED_TYPEColl.Create(TRealNZIS_PLANNED_TYPEItem);
  CollNZIS_QUESTIONNAIRE_RESPONSE := TRealNZIS_QUESTIONNAIRE_RESPONSEColl.Create(TRealNZIS_QUESTIONNAIRE_RESPONSEItem);
  CollNZIS_QUESTIONNAIRE_ANSWER := TRealNZIS_QUESTIONNAIRE_ANSWERColl.Create(TRealNZIS_QUESTIONNAIRE_ANSWERItem);
  CollNZIS_ANSWER_VALUE := TRealNZIS_ANSWER_VALUEColl.Create(TRealNZIS_ANSWER_VALUEItem);
  CollNZIS_DIAGNOSTIC_REPORT := TRealNZIS_DIAGNOSTIC_REPORTColl.Create(TRealNZIS_DIAGNOSTIC_REPORTItem);
  CollNzis_RESULT_DIAGNOSTIC_REPORT := TRealNZIS_RESULT_DIAGNOSTIC_REPORTColl.Create(TRealNZIS_RESULT_DIAGNOSTIC_REPORTItem);

  Adb_DM := TADBDataModule.Create;
  Adb_DM.AdbHip := AspectsHipFile;
  Adb_DM.AdbLink := AspectsLinkPatPregFile;
  Adb_DM.CollDoc := CollDoctor;
  Adb_DM.CollPrac := CollPractica;
  Adb_DM.CollCert := CollCertificates;
  Adb_DM.CollPreg := CollPregled;
  Adb_DM.CollDiag := CollDiag;
  Adb_DM.CollNZIS_PLANNED_TYPE := CollNZIS_PLANNED_TYPE;
  Adb_DM.CollNZIS_QUESTIONNAIRE_RESPONSE := CollNZIS_QUESTIONNAIRE_RESPONSE;
  Adb_DM.CollNZIS_QUESTIONNAIRE_ANSWER := CollNZIS_QUESTIONNAIRE_ANSWER;
  Adb_DM.CollNZIS_ANSWER_VALUEColl := CollNZIS_ANSWER_VALUE;

  Adb_DM.collNZIS_DIAGNOSTIC_REPORT := CollNZIS_DIAGNOSTIC_REPORT;
  Adb_DM.collNZIS_RESULT_DIAGNOSTIC_REPORT := CollNzis_RESULT_DIAGNOSTIC_REPORT;
end;

procedure TForm5.FormDestroy(Sender: TObject);
begin
  FreeAndNil(CollPregled);
  FreeAndNil(Adb_DM);
end;

procedure TForm5.OpenADB(ADB: TMappedFile);
var
  collType: TCollectionsType;
  aspVersion: Word;
  pCardinalData: ^Cardinal;
  aspPos: Cardinal;
  p: Pointer;
  pg: PGUID;
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
    mmoTest.Lines.Add(pg^.ToString);
    mmoTest.Lines.Add(inttostr(SizeOf(tguid)));

    aspPos := ADB.FPosMetaData;
    while aspPos < (ADB.FPosMetaData + ADB.FLenMetaData) do
    begin
      p := Pointer(pbyte(ADB.Buf) + aspPos);
      collType := TCollectionsType(p^);
      inc(aspPos, 2);

      p := Pointer(pbyte(ADB.Buf) + aspPos);
      aspVersion := word(p^);
      inc(aspPos, 2);

      case collType of // в зависимост от това какъв е типа на колекцията.
        ctPractica:
        begin
          CollPractica.OpenAdbFull(aspPos);
        end;
        ctPregledNew:
        begin
          Inc(aspPos, (CollPregled.FieldCount) * 4);
          CollPregled.IncCntInADB;
        end;
        ctPatientNew:
        begin
          Inc(aspPos, (CollPatient.FieldCount) * 4);
          CollPatient.IncCntInADB;
        end;
        //ctPatientNZOK:
//        begin
//          Inc(aspPos, (CollPatPis.FieldCount) * 4);
//          CollPatPis.IncCntInADB;
//        end;
        ctDiagnosis:
        begin
          Inc(aspPos, (CollDiag.FieldCount) * 4);
          CollDiag.IncCntInADB;
        end;
        ctDiagnosisDel:
        begin
          Inc(aspPos, (CollDiag.FieldCount) * 4);
        end;
        ctMDN:
        begin
          Inc(aspPos, (CollMDN.FieldCount) * 4);
          CollMDN.IncCntInADB;
        end;
        ctDoctor:
        begin
          CollDoctor.OpenAdbFull(aspPos);
        end;
        //ctUnfav:
       // begin
//          Inc(aspPos, (CollUnfav.FieldCount) * 4);
//          CollUnfav.IncCntInADB;
//        end;
        //ctUnfavDel:
//        begin
//          Inc(aspPos, (CollUnfav.FieldCount) * 4);
//        end;
        ctMkb:
        begin
          Inc(aspPos, (CollMkb.FieldCount) * 4);
          CollMkb.IncCntInADB;
        end;
        ctEventsManyTimes:
        begin
          Inc(aspPos, (CollEventsManyTimes.FieldCount) * 4);
          CollEventsManyTimes.IncCntInADB;
        end;
        ctExam_boln_list:
        begin
          Inc(aspPos, (CollEbl.FieldCount) * 4);
          CollEbl.IncCntInADB;
        end;
        ctExamAnalysis:
        begin
          Inc(aspPos, (CollExamAnal.FieldCount) * 4);
          CollExamAnal.IncCntInADB;
        end;
        ctExamImmunization:
        begin
          Inc(aspPos, (CollExamImun.FieldCount) * 4);
          CollExamImun.IncCntInADB;
        end;
        ctProcedures:
        begin
          Inc(aspPos, (CollProceduresNomen.FieldCount) * 4);
          CollProceduresNomen.IncCntInADB;
        end;
        ctKARTA_PROFILAKTIKA2017:
        begin
          Inc(aspPos, (CollCardProf.FieldCount) * 4);
          CollCardProf.IncCntInADB;
        end;
        ctBLANKA_MED_NAPR:
        begin
          Inc(aspPos, (CollMedNapr.FieldCount) * 4);
          CollMedNapr.IncCntInADB;
        end;
        ctNZIS_PLANNED_TYPE:
        begin
          Inc(aspPos, (CollNZIS_PLANNED_TYPE.FieldCount) * 4);
          CollNZIS_PLANNED_TYPE.IncCntInADB;
        end;
        ctNZIS_QUESTIONNAIRE_RESPONSE:
        begin
          Inc(aspPos, (CollNZIS_QUESTIONNAIRE_RESPONSE.FieldCount) * 4);
          CollNZIS_QUESTIONNAIRE_RESPONSE.IncCntInADB;
        end;
        ctNZIS_QUESTIONNAIRE_ANSWER:
        begin
          Inc(aspPos, (CollNZIS_QUESTIONNAIRE_ANSWER.FieldCount) * 4);
          CollNZIS_QUESTIONNAIRE_ANSWER.IncCntInADB;
        end;
        ctNZIS_DIAGNOSTIC_REPORT:
        begin
          Inc(aspPos, (CollNZIS_DIAGNOSTIC_REPORT.FieldCount) * 4);
          CollNZIS_DIAGNOSTIC_REPORT.IncCntInADB;
        end;
        ctNZIS_RESULT_DIAGNOSTIC_REPORT:
        begin
          Inc(aspPos, (CollNZIS_RESULT_DIAGNOSTIC_REPORT.FieldCount) * 4);
          CollNZIS_RESULT_DIAGNOSTIC_REPORT.IncCntInADB;
        end;
        ctNZIS_ANSWER_VALUE:
        begin
          Inc(aspPos, (CollNZIS_ANSWER_VALUE.FieldCount) * 4);
          CollNZIS_ANSWER_VALUE.IncCntInADB;
        end;
        ctNzisToken:
        begin
          CollNzisToken.OpenAdbFull(aspPos);
        end;
        ctCertificates:
        begin
          CollCertificates.OpenAdbFull(aspPos);
        end;
      end;
    end;


    CollPregled.Buf := ADB.Buf;
    CollPregled.posData := ADB.FPosData;
    frmfmxNew.collBase.Buf := AspectsHipFile.Buf;
    frmfmxNew.collBase.posData := AspectsHipFile.FPosData;
  end;


  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('Зареждане за %f',[Elapsed.TotalMilliseconds]));

end;



procedure TForm5.pnlTopMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  //hntLek.Title := 'ddd';
//  hntLek.Description := 'desk';
//  hntLek.HideAfter := 5000;
//  //if not hntLek.ShowingHint then
//  begin
//    hntLek.ShowHint(pnlTop.ClientToScreen(Point(x, y -200)));
//  end;
end;

procedure TForm5.tgrd1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Screen.Cursor:= crHourGlass;

  //tgrd1.Cursor := crHourGlass;
end;

procedure TForm5.vtrPregledPatChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  data: PAspRec;
begin
  data := Pointer(PByte(Node) + lenNode);
  case data.vid of
    vvPatient:
    begin
      frmfmxNew.FillPatient(node);
    end;
  end;
end;

procedure TForm5.vtrPregledPatGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data: PAspRec;
begin
  data := Pointer(PByte(Node) + lenNode);
  case Column of
    0:
    begin
      case data.vid of
        vvPregled:
        begin
          CellText := CollPregled.getAnsiStringMap(data.DataPos, word(PregledNew_TERAPY));
        end;
      end;
    end;
    1:
    begin
      CellText := IntToStr(Data.DataPos);
    end;
    2:
    begin
      CellText := TRttiEnumerationType.GetName(Data.vid);
    end;
  end;
end;

end.
