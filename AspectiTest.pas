unit AspectiTest;

interface

uses
  FMX.Forms,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, system.Diagnostics, system.TimeSpan,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.GIFImg, VirtualTrees, system.Rtti,
  System.Generics.Collections, System.DateUtils, System.Math, Winapi.ActiveX,

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


  Parnassus.FMXContainer, VCLTee.Control, VCLTee.Grid, Vcl.ComCtrls,
  Vcl.AppEvnts
  ;

type
  TForm5 = class(TForm)
    btnOpenLNK: TButton;
    mmoTest: TMemo;
    spl1: TSplitter;
    vtrLinkOptions: TVirtualStringTreeAspect;
    spl2: TSplitter;
    pnlTop: TPanel;
    fmxCntrDyn: TFireMonkeyContainer;
    btnLoopLink: TButton;
    btnLoopTree: TButton;
    tgrd1: TTeeGrid;
    hntLek: TBalloonHint;
    btnCreateNewLink: TButton;
    btnOpenLnkOptions: TButton;
    pnlMain: TPanel;
    pnlLeft: TPanel;
    pnlWork: TPanel;
    pgcWork: TPageControl;
    tsGrid: TTabSheet;
    tsVtrCreator: TTabSheet;
    dlgOpenLink: TOpenDialog;
    aplctnvnts1: TApplicationEvents;
    btnUp: TButton;
    tsNodeProperty: TTabSheet;
    cbbVtrVid: TComboBox;
    btnRootOptionPregled: TButton;
    btn1: TButton;
    btnRes: TButton;
    procedure btnOpenLNKClick(Sender: TObject);
    procedure OlenLink;
    procedure vtrLinkOptionsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure fmxCntrDynCreateFMXForm(var Form: TCommonCustomForm);
    procedure btnLoopLinkClick(Sender: TObject);
    procedure btnLoopTreeClick(Sender: TObject);
    procedure vtrLinkOptionsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tgrd1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlTopMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnCreateNewLinkClick(Sender: TObject);
    procedure btnOpenLnkOptionsClick(Sender: TObject);
    procedure vtrLinkOptionsDragOver(Sender: TBaseVirtualTree; Source: TObject;
      Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
      var Effect: Integer; var Accept: Boolean);
    procedure vtrLinkOptionsDragAllowed(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure vtrLinkOptionsCreateDragManager(Sender: TBaseVirtualTree;
      out DragManager: IVTDragManager);
    procedure vtrLinkOptionsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure fmxCntrDynEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure vtrLinkOptionsDragDropFMX(Sender: TObject; var IsDropted: Boolean);
    procedure btnUpClick(Sender: TObject);
    procedure vtrLinkOptionsAddToSelection(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vtrLinkOptionsDragDrop(Sender: TBaseVirtualTree; Source: TObject;
      DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
      Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure cbbVtrVidChange(Sender: TObject);
    procedure cbbVtrVidKeyPress(Sender: TObject; var Key: Char);
    procedure btnRootOptionPregledClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btnResClick(Sender: TObject);
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
    procedure FillComboVtrVid;
  public
    Adb_DM: TADBDataModule;
    DragObj: TDropFmxObject;
    procedure OpenADB(ADB: TMappedFile);
    procedure StartDragFMX(DragObject: TObject);
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

{ TForm5 }

procedure TForm5.btn1Click(Sender: TObject);
begin
  LoadKeyBoardLayout('00040402',1);
end;

procedure TForm5.btnCreateNewLinkClick(Sender: TObject);
var
  fileNameLink: string;
  fileStr: TFileStream;
  Pg: PGUID;
  TreeLink, TreeLink1, Run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  data: PAspRec;
  i: Integer;
begin
  Stopwatch := TStopwatch.StartNew;
  fileNameLink := 'd:\LinkOptions.lnk';

  DeleteFile(fileNameLink);
  fileStr := TFileStream.Create(fileNameLink, fmCreate);
  fileStr.Size := 7000000;
  fileStr.Free;

  vtrLinkOptions.BeginUpdate;
  AspectsOptionsLinkFile := TMappedLinkFile.Create(fileNameLink, true, TGUID.Empty);
  AspectsOptionsLinkFile.FVTR := vtrLinkOptions;
  linkpos := 100;
  AspectsOptionsLinkFile.AddNewNode(vvRootOptions, 0, vtrLinkOptions.RootNode, amAddChildLast, TreeLink, linkPos);
  for i := 0 to 100000 do
    AspectsOptionsLinkFile.AddNewNode(vvNone, 0, TreeLink, amAddChildLast, TreeLink1, linkPos);

  pCardinalData := pointer(PByte(AspectsOptionsLinkFile.Buf) + 4);
  pCardinalData^ := Cardinal(AspectsOptionsLinkFile.Buf);

  pCardinalData := pointer(PByte(AspectsOptionsLinkFile.Buf) + 8);
  pCardinalData^ := Cardinal(vtrLinkOptions.RootNode);

  vtrLinkOptions.EndUpdate;
  vtrLinkOptions.UpdateScrollBars(true);
  vtrLinkOptions.InvalidateToBottom(vtrLinkOptions.RootNode);

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

  patNode := vtrLinkOptions.GetFirstSelected();
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
  fileLinkName := 'D:\VSS\Hippocrates40\bin\Hippocrates360\AspHip{33ECAF02-6909-4F03-9C1E-F25F1AB438AC}.lnk';
  fileAdbName := 'D:\VSS\Hippocrates40\bin\Hippocrates360\AspHip{33ECAF02-6909-4F03-9C1E-F25F1AB438AC}.adb';
  AspectsHipFile := TMappedFile.Create(fileAdbName, false, TGUID.Empty);
  AspectsLinkPatPregFile := TMappedLinkFile.Create(fileLinkName, false, TGUID.Empty);

  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('MapLink за %f',[Elapsed.TotalMilliseconds]));


  AspectsLinkPatPregFile.FVTR := vtrLinkOptions;
  Stopwatch := TStopwatch.StartNew;
  //OlenLink;
  AspectsLinkPatPregFile.OpenLinkFile;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('ЗарежданеLink %d за %f',[vtrLinkOptions.RootNode.TotalCount,  Elapsed.TotalMilliseconds]));

  OpenADB(AspectsHipFile);
end;

procedure TForm5.btnOpenLnkOptionsClick(Sender: TObject);
var
  fileLinkOptName: string;
begin

  if not dlgOpenLink.Execute then Exit;
  Stopwatch := TStopwatch.StartNew;
  fileLinkOptName := dlgOpenLink.FileName;

  if AspectsOptionsLinkFile <> nil then
  begin
    vtrLinkOptions.InternalDisconnectNode(vtrLinkOptions.RootNode.FirstChild, false);
    AspectsOptionsLinkFile.Free;
    AspectsOptionsLinkFile := nil;
  end;



  AspectsOptionsLinkFile := TMappedLinkFile.Create(fileLinkOptName, false, TGUID.Empty);

  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('MapLink за %f',[Elapsed.TotalMilliseconds]));


  AspectsOptionsLinkFile.FVTR := vtrLinkOptions;
  Stopwatch := TStopwatch.StartNew;
  AspectsOptionsLinkFile.OpenLinkFile;
  CollPregled.linkOptions := AspectsOptionsLinkFile;
  Elapsed := Stopwatch.Elapsed;
  mmoTest.Lines.Add( Format('ЗарежданеLink %d за %f',[vtrLinkOptions.RootNode.TotalCount,  Elapsed.TotalMilliseconds]));

end;

procedure TForm5.btnResClick(Sender: TObject);
begin
 // UpdateResource()
end;

procedure TForm5.btnRootOptionPregledClick(Sender: TObject);
var
  nodePregRoot: PVirtualNode;
begin
  nodePregRoot := CollPregled.FindRootCollOptionNode();
  if nodePregRoot = nil then
  begin
    nodePregRoot := CollPregled.CreateRootCollOptionNode();
  end;
  nodePregRoot := CollPregled.FindSearchFieldCollOptionNode();
  vtrLinkOptions.Selected[nodePregRoot] := True;
end;

procedure TForm5.btnUpClick(Sender: TObject);
var
  vNode, vPrevNode: PVirtualNode;
begin
  vNode := vtrLinkOptions.GetFirstSelected();
  vPrevNode := vNode.PrevSibling;
  if vPrevNode <> nil then
  begin
    vtrLinkOptions.MoveTo(vPrevNode, vNode, amInsertAfter, false);
    btnUp.Enabled := (vNode.PrevSibling <> nil);
    //btnDown.Enabled := (vNode.NextSibling <> nil);
//    vTrAnal.FocusedNode := vNode;
//    vTrAnal.ScrollIntoView(vTrAnal.FocusedNode, true);
  end;

end;

procedure TForm5.cbbVtrVidChange(Sender: TObject);
begin
  //Caption := cbbVtrVid.Text;
end;

procedure TForm5.cbbVtrVidKeyPress(Sender: TObject; var Key: Char);
var
  node: PVirtualNode;
  data: PAspRec;
begin
  if Key = #13 then
  begin
    Caption := cbbVtrVid.Text;
    node := vtrLinkOptions.GetFirstSelected();
    if node = nil then Exit;
    data := Pointer(PByte(node) + lenNode);
    data.vid := TVtrVid(TRttiEnumerationType.GetValue<TVtrVid>(cbbVtrVid.Text));
  end;
end;

procedure TForm5.FillComboVtrVid;
var
  vtrVid: TVtrVid;
begin
  cbbVtrVid.Clear;
  for vtrVid := Low(TVtrVid) to  High(TVtrVid) do
  begin
    cbbVtrVid.Items.Add(TRttiEnumerationType.GetName(vtrVid));
  end;

end;

procedure TForm5.fmxCntrDynCreateFMXForm(var Form: TCommonCustomForm);
begin
  if not Assigned(Form) then
  begin
    frmfmxNew := TfrmfmxNew.Create(nil);
    Form := frmfmxNew;
    frmfmxNew.Adb_DM := Adb_DM;
    frmfmxNew.OnStartDragFMX  := StartDragFMX;

  end;
end;

procedure TForm5.fmxCntrDynEndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  //
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
  FillComboVtrVid;
end;

procedure TForm5.FormDestroy(Sender: TObject);
begin
  FreeAndNil(CollPregled);
  FreeAndNil(Adb_DM);
end;

procedure TForm5.FormDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  //
end;

procedure TForm5.OlenLink;
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
  vtrLinkOptions.BeginUpdate;

  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf) + 4);
  oldBuf := pCardinalData^;
  if Cardinal(AspectsLinkPatPregFile.Buf) >= oldBuf then
  begin
    deltaBuf := Cardinal(AspectsLinkPatPregFile.Buf) - oldBuf;
  end
  else
  begin
    deltaBuf := oldBuf - Cardinal(AspectsLinkPatPregFile.Buf);
  end;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf) + 4);
  pCardinalData^ := Cardinal(AspectsLinkPatPregFile.Buf);
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf) + 8);
  oldRoot := pCardinalData^;

  //mmotest.Lines.Add(Format('BufLink  = %d', [cardinal(AspectsLinkPatPregFile.Buf)]));

  linkPos := 100;
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  FPosLinkData := pCardinalData^;
  node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);

  Exclude(node.States, vsSelected);
  data := pointer(PByte(node) + lenNode);
  if not (data.vid in [vvPatientRevision]) then
    data.index := -1;
  i := 0;
  if Cardinal(AspectsLinkPatPregFile.Buf) > oldBuf then
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

      node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
      Exclude(node.States, vsSelected);
      //Node.States := node.States + [vsMultiline] + [vsHeightMeasured]; // zzzzzzzzzzzzzzzzzzz за опция за редове
      data := pointer(PByte(node) + lenNode);
      if not (data.vid in [vvPatientRevision]) then
        data.index := -1;
      if data.vid = vvEvntList then
      begin
        data.DataPos := data.DataPos + deltaBuf;
      end;

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
        node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
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
      end;
    end
    else
    begin
      //PregledColl.Capacity := 1000000;
      while linkPos <= FPosLinkData do
      begin
        Inc(linkPos, LenData);
        node := pointer(PByte(AspectsLinkPatPregFile.Buf) + linkpos);
        Exclude(node.States, vsSelected);
        //Node.States := node.States + [vsMultiline] + [vsHeightMeasured];  // zzzzzzzzzzzzzzzzzzz за опция за редове
        //Exclude(node.States, vsInitialized);
        data := pointer(PByte(node) + lenNode);
        //if data.vid <> vvPatient then
//          Exclude(node.States, vsFiltered);
        if not (data.vid in [vvPatientRevision]) then
          data.index := -1;
      end;
    end;
  end;


  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf));
  pCardinalData^ := linkpos;
  node := pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);

  vtrLinkOptions.InternalConnectNode_cmd(node, vtrLinkOptions.RootNode, vtrLinkOptions, amAddChildFirst);
  vtrLinkOptions.BufLink := AspectsLinkPatPregFile.Buf;
  //node := pointer(PByte(AspectsLinkPatPregFile.Buf) + 100);
  //vtrPregledPat.InternalDisconnectNode(node, false);
  pCardinalData := pointer(PByte(AspectsLinkPatPregFile.Buf) + 8);
  pCardinalData^ := Cardinal(vtrLinkOptions.RootNode);
  vtrLinkOptions.UpdateVerticalScrollBar(true);
  vtrLinkOptions.EndUpdate;
  Stopwatch.StartNew;
  //vtrPregledPat.Sort(vtrPregledPat.RootNode.FirstChild, 0, sdAscending, false);
  Elapsed := Stopwatch.Elapsed;
  AspectsLinkPatPregFile.FVTR := vtrLinkOptions;
  //AspectsLinkPatPregFile.FStreamCmdFile := streamCmdFile;
//  FDBHelper.AdbLink := AspectsLinkPatPregFile;
//  FmxProfForm.AspLink := AspectsLinkPatPregFile;
  mmoTest.Lines.Add( Format('ЗарежданеLink %d за %f',[vtrLinkOptions.RootNode.TotalCount,  Elapsed.TotalMilliseconds]));
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

procedure TForm5.StartDragFMX(DragObject: TObject);
begin
  DragObj := TDropFmxObject(DragObject);
end;

procedure TForm5.tgrd1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Screen.Cursor:= crHourGlass;

  //tgrd1.Cursor := crHourGlass;
end;

procedure TForm5.vtrLinkOptionsAddToSelection(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  btnUp.Enabled := (Node.PrevSibling <> nil);
end;

procedure TForm5.vtrLinkOptionsChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  data: PAspRec;
begin
  if Node = nil then Exit;

  data := Pointer(PByte(Node) + lenNode);
  case data.vid of
    vvPatient:
    begin
      frmfmxNew.FillPatient(node);
    end;
  end;
end;

procedure TForm5.vtrLinkOptionsCreateDragManager(Sender: TBaseVirtualTree;
  out DragManager: IVTDragManager);
begin
  //
end;

procedure TForm5.vtrLinkOptionsDragAllowed(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := True;
end;

procedure TForm5.vtrLinkOptionsDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  pSource, pTarget: PVirtualNode;
  attMode: TVTNodeAttachMode;
begin
  pSource := vtrLinkOptions.GetFirstSelected;
  pTarget := Sender.DropTargetNode;

  case Mode of
    dmNowhere: attMode := amNoWhere;
    dmAbove: attMode := amInsertBefore;
    dmBelow: attMode := amInsertAfter;
    dmOnNode: attMode := amAddChildLast;
  end;

  vtrLinkOptions.MoveTo(pSource, pTarget, attMode, False);
  //vtrPregledPat.MoveTo(vPrevNode, vNode, amInsertAfter, false);
end;

procedure TForm5.vtrLinkOptionsDragDropFMX(Sender: TObject;
  var IsDropted: Boolean);
var
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  TreeLink, TargetNode: PVirtualNode;
  AttachMode: TVTNodeAttachMode;
begin
  if DragObj <> nil then
  begin
    //vtrPregledPat.Selected[vtrPregledPat.DropTargetNode] := True;
    case DragObj.DropMode of
      dmNowhere: AttachMode := amAddChildLast;
      dmAbove: AttachMode := amInsertBefore;
      dmBelow: AttachMode := amInsertAfter;
      dmOnNode: AttachMode := amAddChildLast;
    end;
    TargetNode := vtrLinkOptions.DropTargetNode;
    if TargetNode = nil then
    begin
      TargetNode := vtrLinkOptions.RootNode.FirstChild;
    end;
    //caption := TRttiEnumerationType.GetName(DragObj.DropMode);

    Stopwatch := TStopwatch.StartNew;
    vtrLinkOptions.BeginUpdate;

    AspectsOptionsLinkFile.AddNewNode(TVtrVid(DragObj.VtrType), 0, TargetNode, AttachMode, TreeLink, linkPos);

    vtrLinkOptions.EndUpdate;
    //vtrPregledPat.UpdateScrollBars(true);
    //vtrPregledPat.InvalidateToBottom(vtrPregledPat.RootNode);

    Elapsed := Stopwatch.Elapsed;
    mmoTest.Lines.Add( 'newLinkNode ' + FloatToStr(Elapsed.TotalMilliseconds));
    vtrLinkOptions.DropTargetNode := nil;
    IsDropted := True;
    DragObj := nil;
  end
  else
    IsDropted := False;
end;

procedure TForm5.vtrLinkOptionsDragOver(Sender: TBaseVirtualTree;
  Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
  Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
  if DragObj <> nil then
  begin
    DragObj.DropMode := Mode;
  end
  else
    Caption := vtrLinkOptions.Text[vtrLinkOptions.GetFirstSelected, 0];
  Accept := True;
end;

procedure TForm5.vtrLinkOptionsGetText(Sender: TBaseVirtualTree;
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
          //if CollPregled <> nil then

          //CellText := CollPregled.getAnsiStringMap(data.DataPos, word(PregledNew_TERAPY));
        end;
        vvFieldSearchGridOption:
        begin
          CellText := CollPregled.DisplayName(node.Dummy);
        end
      else
        begin
          CellText := IntToStr(Cardinal(Pointer(PByte(Node) - PByte(AspectsOptionsLinkFile.Buf))));
        end;
      end;
    end;
    1:
    begin
      //CellText := IntToStr(Data.DataPos);
      CellText := format('index = %d  ;  rank = %d', [node.Dummy, Node.Index]); //IntToStr(node.Index);
    end;
    2:
    begin
      CellText := TRttiEnumerationType.GetName(Data.vid);
    end;
  end;
end;

procedure TForm5.vtrLinkOptionsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //
end;

end.
