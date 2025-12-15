unit ProfGraph; //zzzzz

interface
uses
  System.Generics.Collections, System.SysUtils, System.DateUtils, system.Classes,
  Vcl.StdCtrls,
  ADB_DataUnit,
  RealObj.NzisNomen, VirtualStringTreeHipp, dialogs, system.Diagnostics, System.timespan,
  VirtualTrees, Aspects.Types, Aspects.Functions,
  Table.PatientNew, Table.PregledNew, Table.Diagnosis,
  Table.Cl132, table.PR001, table.CL050, table.cl134, table.cl139,
  table.CL022, Table.Cl038, table.CL142, table.cl088, Table.CL144,
  Table.CL037, table.cl006,
  Table.ExamAnalysis;

type
  

  TProfGraph = class
  private
    FCurrDate: TDate;
    FSexMale: Boolean;
    isFilled: Boolean;
    FVisibleMinali: Boolean;
    FVisibleBudeshti: Boolean;
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    FFillTree: Boolean;
    Adb_DM: TADBDataModule;
    //function DatStrToDays(currDay: TDate; str: string): TDate;
    procedure SetCurrDate(const Value: TDate);
    // --- HELPER МЕТОДИ ЗА ЛОГИКАТА ---

    function IsPastPeriod(const AGr: TGraphPeriod132): Boolean;
    function IsFuturePeriod(const AGr: TGraphPeriod132): Boolean;
    function IsCurrentPeriod(const AGr: TGraphPeriod132): Boolean;
    procedure ResetPeriodRuntimeState(var AGr: TGraphPeriod132);

    procedure AttachPregToPeriod(const lstIndex, indexGR: Integer;
      var AGr: TGraphPeriod132;
      var AIsPregForPerform: Boolean; var AFirstCurrentIndex: Cardinal;
      out AEndDate: TDate);

    procedure AttachExamAnalysesToPeriod(var AGr: TGraphPeriod132);

    procedure AttachCl088AndCl134(var AGr: TGraphPeriod132; parentNode: PVirtualNode);

    // --- HELPER МЕТОДИ ЗА ДЪРВОТО (засега малко / празни hooks) ---

    procedure BeginFillTree;
    procedure EndFillTree;


    procedure AddPatientNode(const indexList: Integer;out ANodePatient, ANodePast, ANodeCurr, ANodeFuture: PVirtualNode);

    procedure AddCl132Node(AParent: PVirtualNode; const AGr: TGraphPeriod132;
      AIndex: Integer; out ANode: PVirtualNode);

    procedure AddPr001Node(AParent: PVirtualNode; APr001: TRealPR001Item;
      AIndex: Integer; out ANode: PVirtualNode);

    procedure AddCl134Node(AParent: PVirtualNode; ACl134: TRealCl134Item;
      AIndex: Integer);

    procedure AddCl088Node(AParent: PVirtualNode; ACl088: TRealCl088Item;
      AIndex: Integer);


  protected
    lstValid: TStringList;
    procedure FillPr001InCl132;
    procedure FillCl050;
    procedure FillCl050_1;
    procedure FillCL134;
    procedure FillCl142InPr001;
    procedure FillCl088InCL142;
    procedure FillCl144InCL142;

    procedure vtrGraphGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
  public

    vtrGraph: TVirtualStringTreeHipp;
    mmoTest: tmemo;
    vRootGraph: PVirtualNode;
    lstAllGraph: TListsGraph;


    constructor create(adbDm: TObject);
    destructor destroy; override;
    procedure LoadVtr;


    procedure GeneratePeriod1(lstIndex: Integer);
    function RuleCl132_PR001(cl132, pr001: TObject): Boolean;

    //procedure LoadVtrGraph1(Apat: TObject; patIndex: Integer);

    procedure LoadVtrGraphOutVtr1(indexList: integer);
    property CurrDate: TDate read FCurrDate write SetCurrDate;
    property SexMale: Boolean read FSexMale write FSexMale;
    property VisibleMinali: Boolean read FVisibleMinali write FVisibleMinali;
    property VisibleBudeshti: Boolean read FVisibleBudeshti write FVisibleBudeshti;
    property FillTree: Boolean read FFillTree write FFillTree;
  end;

implementation
uses
  RealObj.RealHipp;


{ TProfGraph }

procedure TProfGraph.AddCl088Node(AParent: PVirtualNode;
  ACl088: TRealCl088Item; AIndex: Integer);
var
  data: PAspRec;
  Node: PVirtualNode;
begin
  if (not FFillTree) or (vtrGraph = nil) or (AParent = nil) then
    Exit;

  Node := vtrGraph.AddChild(AParent, nil);
  data := vtrGraph.GetNodeData(Node);
  data^.vid     := vvCL088;
  data^.index   := AIndex;
  data^.DataPos := ACl088.DataPos;
end;

procedure TProfGraph.AddCl132Node(AParent: PVirtualNode;
  const AGr: TGraphPeriod132; AIndex: Integer; out ANode: PVirtualNode);
var
  data: PAspRec;
begin
  ANode := nil;
  if (not FFillTree) or (vtrGraph = nil) or (AParent = nil) then
    Exit;

  ANode := vtrGraph.AddChild(AParent, nil);
  data := vtrGraph.GetNodeData(ANode);
  data^.vid     := vvCl132;
  data^.index   := AIndex;
  data^.DataPos := AGr.Cl132.DataPos;
end;

procedure TProfGraph.AddCl134Node(AParent: PVirtualNode;
  ACl134: TRealCl134Item; AIndex: Integer);
var
  data: PAspRec;
  Node: PVirtualNode;
begin
  if (not FFillTree) or (vtrGraph = nil) or (AParent = nil) then
    Exit;

  Node := vtrGraph.AddChild(AParent, nil);
  data := vtrGraph.GetNodeData(Node);
  data^.vid     := vvCl134;
  data^.index   := AIndex;
  data^.DataPos := ACl134.DataPos;
end;

procedure TProfGraph.AddPr001Node(AParent: PVirtualNode;
  APr001: TRealPR001Item; AIndex: Integer; out ANode: PVirtualNode);
var
  data: PAspRec;
begin
  ANode := nil;
  if (not FFillTree) or (vtrGraph = nil) or (AParent = nil) then
    Exit;

  ANode := vtrGraph.AddChild(AParent, nil);
  data := vtrGraph.GetNodeData(ANode);
  data^.vid     := vvPr001;
  data^.index   := AIndex;
  data^.DataPos := APr001.DataPos;
end;

procedure TProfGraph.AttachCl088AndCl134(var AGr: TGraphPeriod132; parentNode: PVirtualNode);
var
  j, k       : Integer;
  pr001      : TRealPR001Item;
  Rule88     : string;
  Cl088      : TRealCl088Item;
  ACL088_key : string;
  cl134      : TRealCl134Item;
  note       : string;
  Field_cl133: string;
  test       : string;
  pr001Node: PVirtualNode;
begin
  for j := 0 to AGr.Cl132.FListPr001.Count - 1 do
  begin
    pr001 := AGr.Cl132.FListPr001[j];
    if FFillTree then
    begin
      AddPr001Node(parentNode, pr001, j, pr001Node);
    end;
    if pr001.CL142 <> nil then
    begin
      Rule88 := Adb_DM.PR001Coll.getAnsiStringMap(pr001.DataPos, word(PR001_Rules));

      if pr001.CL142.FListCL088.Count > 1 then
      begin
        for k := 0 to pr001.CL142.FListCL088.Count - 1 do
        begin
          if Trim(Rule88) <> '' then
          begin
            Cl088 := pr001.CL142.FListCL088[k];
            ACL088_key := Adb_DM.CL088Coll.getAnsiStringMap(Cl088.DataPos,word(CL088_key));
            if Pos(ACL088_key, Rule88) = 0 then
              Continue;
            AddCl088Node(pr001Node, Cl088, k);
          end;

          // тук по-нататък можеш да извикаш AddCl088Node(..),
          // ако решиш да го показваш в дървото
        end;
      end;
    end;

    for k := 0 to pr001.LstCl134.Count - 1 do
    begin
      cl134 := pr001.LstCl134[k];
      note  := Adb_DM.CL132Coll.getAnsiStringMap(cl134.DataPos, word(CL134_Note));
      Field_cl133 := Adb_DM.CL134Coll.getAnsiStringMap(cl134.DataPos, word(CL134_CL133));

      if (note <> '') and (Field_cl133[1] in ['5', '6']) then
        test := Adb_DM.CL132Coll.getAnsiStringMap(AGr.Cl132.DataPos, word(CL132_Key)) + note
      else
        test := '';

      // тук при нужда – AddCl134Node(...)
    end;
  end;
end;


procedure TProfGraph.AttachExamAnalysesToPeriod(var AGr: TGraphPeriod132);
var
  k, m      : Integer;
  NodeExam  : PVirtualNode;
  dataExam  : PAspRec;
  examDate  : TDate;
  cl22Exam  : string;
  cl22Pr1   : string;
  pr001     : TRealPR001Item;
begin
  for k := 0 to Adb_DM.PatNodesBack.ExamAnals.Count - 1 do
  begin
    NodeExam := Adb_DM.PatNodesBack.ExamAnals[k];
    dataExam := PAspRec(PByte(NodeExam) + lenNode);

    examDate := Adb_DM.CollExamAnal.getDateMap(dataExam.DataPos, word(ExamAnalysis_DATA));

    // извън периода
    if (examDate < AGr.startDate) or (examDate > AGr.endDate) then
      Continue;

    cl22Exam :=  Adb_DM.CollExamAnal.getAnsiStringMap(dataExam.DataPos, word(ExamAnalysis_NZIS_CODE_CL22));

    for m := 0 to AGr.Cl132.FListPr001.Count - 1 do
    begin
      pr001 := AGr.Cl132.FListPr001[m];

      cl22Pr1 := Adb_DM.PR001Coll.getAnsiStringMap(pr001.DataPos, word(PR001_Activity_ID));

      if cl22Pr1 = cl22Exam then
      begin
        // връзка за конкретното PR001
        if pr001.FExamAnal = nil then
        begin
          pr001.FExamAnal := TRealExamAnalysisItem.Create(nil);
          TRealExamAnalysisItem(pr001.FExamAnal).DataPos := dataExam.DataPos;
        end;

        // и за целия CL132
        if AGr.Cl132.FExamAnal = nil then
        begin
          AGr.Cl132.FExamAnal := TRealExamAnalysisItem.Create(nil);
          TRealExamAnalysisItem(AGr.Cl132.FExamAnal).DataPos := dataExam.DataPos;
        end;
      end;
    end;
  end;
end;


procedure TProfGraph.AttachPregToPeriod(const lstIndex, indexGR: Integer;
  var AGr: TGraphPeriod132;
  var AIsPregForPerform: Boolean; var AFirstCurrentIndex: Cardinal;
  out AEndDate: TDate);
var
  j          : Integer;
  dataPreg   : PAspRec;
  prStartDate: TDate;
  Cl132Key   : string;
  NzisKeyStr : string;
begin
  AGr.Cl132.FPregNode := nil;

  Cl132Key := Adb_DM.CL132Coll.getAnsiStringMap(AGr.Cl132.DataPos, word(CL132_Key));

  // търсим преглед в периода
  for j := 0 to Adb_DM.PatNodesBack.pregs.Count - 1 do
  begin
    dataPreg := PAspRec(PByte(Adb_DM.PatNodesBack.pregs[j]) + lenNode);
    prStartDate := Adb_DM.CollPregled.getDateMap(dataPreg.DataPos, word(PregledNew_START_DATE));

    if (prStartDate >= AGr.startDate) and (prStartDate <= AGr.endDate) then
    begin
      AGr.Cl132.FPregNode := Adb_DM.PatNodesBack.pregs[j];
      Adb_DM.PatNodesBack.CurrentGraphIndex := indexGR;
      Break;
    end;
  end;

  // ако няма преглед в периода – това е план за изпълнение
  if AGr.Cl132.FPregNode = nil then
  begin
    NzisKeyStr := '|' + Cl132Key + '|';

    // тези планове не са „истински“ профилактични (C22 и др.)
    if NzisPregNotPreg.Contains(NzisKeyStr) then
      Exit;

    // само един „основен“ преглед за периода
    if AIsPregForPerform then
    begin
      // втори план със същия период – логически проблем,
      // но не вдигаме ShowMessage тук (оставяме ти го да прецениш)
      Exit;
    end;

    AIsPregForPerform := True;
    AEndDate          := AGr.endDate;

    if AFirstCurrentIndex = MaxInt then
    begin
      AFirstCurrentIndex := indexGR;
      Adb_DM.PatNodesBack.NoteProf := Adb_DM.CL132Coll.getAnsiStringMap(AGr.Cl132.DataPos, word(CL132_Description));
      Adb_DM.PatNodesBack.CurrentGraphIndex := AFirstCurrentIndex;
    end;
  end
  else
  begin
    // намерен е преглед – AEndDate остава края на периода
    AEndDate := AGr.endDate;
  end;
end;


procedure TProfGraph.BeginFillTree;
begin

end;

procedure TProfGraph.AddPatientNode(const indexList: Integer; out ANodePatient, ANodePast, ANodeCurr, ANodeFuture: PVirtualNode);
var
  dataPat, dataPatNode: PAspRec;
begin
  ANodePatient := nil;
  ANodePast    := nil;
  ANodeCurr    := nil;
  ANodeFuture  := nil;

  if (not FFillTree) or (vtrGraph = nil) then
    Exit;

  // взимаме DataPos на пациента от patNodes.patNode
  dataPatNode := PAspRec(PByte(Adb_DM.PatNodesBack.patNode) + lenNode);

  ANodePatient := vtrGraph.AddChild(vRootGraph, nil);
  dataPat := vtrGraph.GetNodeData(ANodePatient);
  dataPat^.vid     := vvPatient;
  dataPat^.DataPos := dataPatNode^.DataPos;
  dataPat^.index   := indexList;

  // периоди
  ANodePast   := vtrGraph.AddChild(ANodePatient, nil);
  dataPat := vtrGraph.GetNodeData(ANodePast);
  dataPat^.vid   := vvPeriodPast;
  dataPat^.index := -1;

  ANodeCurr   := vtrGraph.AddChild(ANodePatient, nil);
  dataPat := vtrGraph.GetNodeData(ANodeCurr);
  dataPat^.vid   := vvPeriodCurrent;
  dataPat^.index := -2;

  ANodeFuture := vtrGraph.AddChild(ANodePatient, nil);
  dataPat := vtrGraph.GetNodeData(ANodeFuture);
  dataPat^.vid   := vvPeriodFuture;
  dataPat^.index := -3;
end;

constructor TProfGraph.create(adbDm: TObject);
begin
  inherited create;
  isFilled := False;
  FVisibleBudeshti := true;
  FVisibleMinali := true;
  FSexMale := True;
  FCurrDate := UserDate;
  Adb_DM := TADBDataModule(adbDm);
  lstAllGraph := TListsGraph.Create;;

  lstValid := TStringList.Create;
  lstValid.Text :=
        'B010-1 месец' + #13#10 +
        'B020-1 месец' + #13#10 +
        'B11-2 месец' + #13#10 +
        'B22-3 месец' + #13#10 +
        'B33-4 месец' + #13#10 +
        'B44-5 месец' + #13#10 +
        'B55-6 месец' + #13#10 +
        'B6Около 6 месец' + #13#10 +
        'B77-9 месец' + #13#10 +
        'B87-9 месец' + #13#10 +
        'B97-9 месец' + #13#10 +
        'B1010-12 месец' + #13#10 +
        'B1110-12 месец' + #13#10 +
        'B1210-12 месец' + #13#10 +
        'C1112-15 месец' + #13#10 +
        'C1113-18 месец' + #13#10 +
        'C1119-24 месец' + #13#10 +
        'C1212-15 месец' + #13#10 +
        'C1213-18 месец' + #13#10 +
        'C1219-24 месец' + #13#10 +
        'C1312-15 месец' + #13#10 +
        'C1313-18 месец' + #13#10 +
        'C1319-24 месец' + #13#10 +
        'C1412-15 месец' + #13#10 +
        'C1413-18 месец' + #13#10 +
        'C1419-24 месец' + #13#10 +
        'C2112-15 месец' + #13#10 +
        'C2113-18 месец' + #13#10 +
        'C2119-24 месец' + #13#10 +
        'C2212-15 месец' + #13#10 +
        'C2213-18 месец' + #13#10 +
        'C2219-24 месец' + #13#10 +
        'C2312-15 месец' + #13#10 +
        'C2313-18 месец' + #13#10 +
        'C2319-24 месец' + #13#10 +
        'C2412-15 месец' + #13#10 +
        'C2413-18 месец' + #13#10 +
        'C2419-24 месец' + #13#10 +
        'C3125-36 месец' + #13#10 +
        'C3225-36 месец' + #13#10 +
        'C3325-36 месец';


end;



destructor TProfGraph.destroy;
begin
  FreeAndNil(lstAllGraph);
  lstValid.Free;
  inherited;
end;

procedure TProfGraph.EndFillTree;
begin

end;

procedure TProfGraph.FillCl050;
var
  iCL050, iPR001: Integer;
  test: AnsiString;
  CL050Coll: TCL050Coll;
  PR001Coll: TRealPR001Coll;

begin
  CL050Coll := Adb_DM.CL050Coll;
  PR001Coll := Adb_DM.PR001Coll;

  CL050Coll.IndexValue(CL050_Key);
  CL050Coll.SortByIndexValue(CL050_Key);

  PR001Coll.IndexValue(PR001_Activity_ID);
  PR001Coll.SortByIndexValue(PR001_Activity_ID);

  iCL050 := 0;
  iPR001 := 0;
  while (iCL050 < CL050Coll.Count) and (iPR001 <PR001Coll.Count) do
  begin //Items[iPR001]
    test := PR001Coll.getAnsiStringMap(PR001Coll.Items[iPR001].DataPos, word(PR001_Nomenclature));
    if test <> 'CL050' then
    begin
      inc(iPR001);
      continue;
    end;

    if CL050Coll.Items[iCL050].IndexAnsiStr1 = PR001Coll.Items[iPR001].IndexAnsiStr1 then
    begin
      //PR001Coll.Items[iPR001].CL050 := CL050Coll.Items[iCL050];
      inc(iPR001);
    end
    else
    if CL050Coll.Items[iCL050].IndexAnsiStr1 < PR001Coll.Items[iPR001].IndexAnsiStr1 then
    begin
      inc(iCL050);
    end
    else
    if CL050Coll.Items[iCL050].IndexAnsiStr1 > PR001Coll.Items[iPR001].IndexAnsiStr1 then
    begin
      inc(iPR001);
    end
  end;
end;

procedure TProfGraph.FillCl050_1;
var
  iCL050, iPR001: Integer;
  test: AnsiString;
  CL050Coll: TCL050Coll;
  PR001Coll: TRealPR001Coll;

begin
  CL050Coll := Adb_DM.CL050Coll;
  PR001Coll := Adb_DM.PR001Coll;

  CL050Coll.IndexValue(CL050_Key);
  CL050Coll.SortByIndexValue(CL050_Key);

  PR001Coll.IndexValue(PR001_Activity_ID);
  PR001Coll.SortByIndexValue(PR001_Activity_ID);


  iCL050 := 0;
  iPR001 := 0;
  while (iCL050 < CL050Coll.Count) and (iPR001 < PR001Coll.Count) do
  begin
    test := PR001Coll.getAnsiStringMap(PR001Coll.Items[iPR001].DataPos, word(PR001_Nomenclature));
    if test <> 'CL050' then
    begin
      inc(iPR001);
      continue;
    end;

    if CL050Coll.Items[iCL050].IndexAnsiStr1 = PR001Coll.Items[iPR001].IndexAnsiStr1 then
    begin
      //PR001Coll.Items[iPR001].CL050 := CL050Coll.Items[iCL050];
      inc(iPR001);
    end
    else
    if CL050Coll.Items[iCL050].IndexAnsiStr1 < PR001Coll.Items[iPR001].IndexAnsiStr1 then
    begin
      inc(iCL050);
    end
    else
    if CL050Coll.Items[iCL050].IndexAnsiStr1 > PR001Coll.Items[iPR001].IndexAnsiStr1 then
    begin
      inc(iPR001);
    end
  end;

end;

procedure TProfGraph.FillCl088InCL142;
var
  iCL142, iCL088: Integer;
  cl088_142: string;
begin
  Adb_DM.CL142Coll.IndexValue(CL142_Key);
  Adb_DM.CL142Coll.SortByIndexAnsiString;

  Adb_DM.CL088Coll.IndexValue(CL088_cl142);
  Adb_DM.CL088Coll.SortByIndexAnsiString;

  iCL142 := 0;
  iCL088 := 0;
  while (iCL142 < Adb_DM.CL142Coll.Count) and (iCL088 < Adb_DM.CL088Coll.Count) do
  begin
    if trim(Adb_DM.CL142Coll.Items[iCL142].IndexAnsiStr1) = trim(Adb_DM.CL088Coll.Items[iCL088].IndexAnsiStr1) then
    begin
      Adb_DM.CL142Coll.Items[iCL142].FListCL088.Add(Adb_DM.CL088Coll.Items[iCL088]);
      inc(iCL088);
    end
    else
    if Adb_DM.CL142Coll.Items[iCL142].IndexAnsiStr1 < Adb_DM.CL088Coll.Items[iCL088].IndexAnsiStr1 then
    begin
      inc(iCL142);
    end
    else
    if Adb_DM.CL142Coll.Items[iCL142].IndexAnsiStr1 > Adb_DM.CL088Coll.Items[iCL088].IndexAnsiStr1 then
    begin
      inc(iCL088);
    end
  end;
end;

procedure TProfGraph.FillCL134;
var
  iCL134, iPR001, i: Integer;
  test: AnsiString;
  cl133Str: AnsiString;
  lstPR001: TList<TRealPR001Item> ;
  Cl132: TRealCl132Item;
  CL134Coll: TRealCL134Coll;
  CL132Coll: TRealCL132Coll;
  PR001Coll: TRealPR001Coll;

begin
  CL134Coll :=  Adb_DM.CL134Coll;
  CL132Coll :=  Adb_DM.CL132Coll;
  PR001Coll :=  Adb_DM.PR001Coll;

  CL134Coll.IndexValue(CL134_CL133);
  CL134Coll.SortByIndexValue(CL134_CL133); // сортирам по цл133 (1, 2, 3...)


  for i := 0 to CL132Coll.Count - 1 do
  begin
    Cl132 := CL132Coll.Items[i];
    lstPR001 := Cl132.FListPr001;
    PR001Coll.SortListByActId(lstPR001);// сортирам списъка с дейности по ActId (там е 65-226 за антропометрията)
    iCL134 := 0;
    iPR001 := 0;
    while (iCL134 < Adb_DM.CL134Coll.Count) and (iPR001 < lstPR001.Count) do
    begin
      test := PR001Coll.getAnsiStringMap(lstPR001[iPR001].DataPos, word(PR001_Nomenclature));
      if test <> 'CL133' then
      begin
        inc(iPR001);
        continue;
      end;
      if CL134Coll.Items[iCL134].IndexAnsiStr1 = PR001Coll.getAnsiStringMap(lstPR001[iPR001].DataPos, word(PR001_Activity_ID)) then
      begin
        //if Cl132. then

        cl133Str := CL134Coll.getAnsiStringMap(CL134Coll.Items[iCL134].DataPos, word(CL134_CL133));
        lstPR001[iPR001].CL133 := TCL133(StrToInt(cl133Str));
        lstPR001[iPR001].LstCl134.Add(Adb_DM.CL134Coll.Items[iCL134]);

        inc(iCL134);
      end
      else
      if CL134Coll.Items[iCL134].IndexAnsiStr1 < PR001Coll.getAnsiStringMap(lstPR001[iPR001].DataPos, word(PR001_Activity_ID)) then
      begin
        inc(iCL134);
      end
      else
      if CL134Coll.Items[iCL134].IndexAnsiStr1 > PR001Coll.getAnsiStringMap(lstPR001[iPR001].DataPos, word(PR001_Activity_ID)) then
      begin
        inc(iPR001);
      end
    end;
  end;

end;

procedure TProfGraph.FillCl142InPr001;
var
  iPR001, iCL142: Integer;
begin
  //CL142Coll.IndexValue(CL142_Key);
  //CL142Coll.SortByIndexAnsiString;

  Adb_DM.PR001Coll.IndexValue(PR001_Activity_ID);
  Adb_DM.PR001Coll.SortByIndexAnsiString;

  iPR001 := 0;
  iCL142 := 0;
  while (iPR001 < Adb_DM.PR001Coll.Count) and (iCL142 < Adb_DM.CL142Coll.Count) do
  begin

    if Adb_DM.PR001Coll.Items[iPR001].IndexAnsiStr1 = Adb_DM.CL142Coll.Items[iCL142].IndexAnsiStr1 then
    begin
      Adb_DM.PR001Coll.Items[iPR001].CL142 := Adb_DM.CL142Coll.Items[iCL142];
      begin
        inc(iPR001);
      end

    end
    else
    if Adb_DM.PR001Coll.Items[iPR001].IndexAnsiStr1 < Adb_DM.CL142Coll.Items[iCL142].IndexAnsiStr1 then
    begin
      inc(iPR001);
    end
    else
    if Adb_DM.PR001Coll.Items[iPR001].IndexAnsiStr1 > Adb_DM.CL142Coll.Items[iCL142].IndexAnsiStr1 then
    begin
      inc(iCL142);
    end
  end;
end;

procedure TProfGraph.FillCl144InCL142;
var
  iCL142, iCL144: Integer;
  cl088_142: string;
begin
  Adb_DM.CL142Coll.IndexValue(CL142_Key);
  Adb_DM.CL142Coll.SortByIndexAnsiString;

  Adb_DM.CL144Coll.IndexValue(CL144_cl142);
  Adb_DM.CL144Coll.SortByIndexAnsiString;

  iCL142 := 0;
  iCL144 := 0;
  while (iCL142 < Adb_DM.CL142Coll.Count) and (iCL144 < Adb_DM.CL144Coll.Count) do
  begin
    if trim(Adb_DM.CL142Coll.Items[iCL142].IndexAnsiStr1) = trim(Adb_DM.CL144Coll.Items[iCL144].IndexAnsiStr1) then
    begin
      Adb_DM.CL142Coll.Items[iCL142].FListCL144.Add(Adb_DM.CL144Coll.Items[iCL144]);
      inc(iCL144);
    end
    else
    if Adb_DM.CL142Coll.Items[iCL142].IndexAnsiStr1 < Adb_DM.CL144Coll.Items[iCL144].IndexAnsiStr1 then
    begin
      inc(iCL142);
    end
    else
    if Adb_DM.CL142Coll.Items[iCL142].IndexAnsiStr1 > Adb_DM.CL144Coll.Items[iCL144].IndexAnsiStr1 then
    begin
      inc(iCL144);
    end
  end;
end;

procedure TProfGraph.FillPr001InCl132;
var
  iCL132, iPR001: Integer;
begin
  Adb_DM.CL132Coll.IndexValue(CL132_Key);
  Adb_DM.CL132Coll.SortByIndexAnsiString;

  Adb_DM.PR001Coll.IndexValue(PR001_CL132);
  Adb_DM.PR001Coll.SortByIndexAnsiString;

  iCL132 := 0;
  iPR001 := 0;
  while (iCL132 < Adb_DM.CL132Coll.Count) and (iPR001 < Adb_DM.PR001Coll.Count) do
  begin
    if Adb_DM.CL132Coll.Items[iCL132].IndexAnsiStr1 = Adb_DM.PR001Coll.Items[iPR001].IndexAnsiStr1 then
    begin
      if RuleCl132_PR001(Adb_DM.CL132Coll.Items[iCL132], Adb_DM.PR001Coll.Items[iPR001]) then
      begin
        Adb_DM.CL132Coll.Items[iCL132].FListPr001.Add(Adb_DM.PR001Coll.Items[iPR001]);
      end;
      inc(iPR001);
    end
    else
    if Adb_DM.CL132Coll.Items[iCL132].IndexAnsiStr1 < Adb_DM.PR001Coll.Items[iPR001].IndexAnsiStr1 then
    begin
      inc(iCL132);
    end
    else
    if Adb_DM.CL132Coll.Items[iCL132].IndexAnsiStr1 > Adb_DM.PR001Coll.Items[iPR001].IndexAnsiStr1 then
    begin
      inc(iPR001);
    end
  end;
end;

procedure TProfGraph.GeneratePeriod1(lstIndex: Integer);
var
  i, j, k, m: Integer;
  cl132i: TRealCL132Item;

  datStr, repStr: string;
  datTemp: TDate;
  startMin, startMax, currentMin, currentMax: TDate;
  rep: Integer;
  maxLive, maxYear, StartNzisData, BrthDate: TDate;
  Graph, Key, egn: string;
  gr: TGraphPeriod132;
  patNodes: TPatNodes;
  pregNodes: TPregledNodes;
  dataPat, dataPreg: PAspRec;

  CL132Coll: TRealCL132Coll;
  PR001Coll: TRealPR001Coll;
  CL134Coll: TRealCL134Coll;
  patColl: TRealPatientNewColl;
  pregColl: TRealPregledNewColl;
begin
  if Adb_DM.AdbNomenNzis = nil then
    Adb_DM.OpenADBNomenNzis('NzisNomen.adb');
  CL132Coll := Adb_DM.CL132Coll;
  PR001Coll := Adb_DM.PR001Coll;
  CL134Coll := Adb_DM.CL134Coll;
  patColl := Adb_DM.CollPatient;
  pregColl := Adb_DM.CollPregled;

  if not isFilled then
  begin
    FillCl144InCL142;
    FillCl088InCL142;
    FillCl142InPr001;
    FillPr001InCl132;
    FillCL134;
    isFilled := True;
    //CL132Coll.SortByDataPos;
    CL132Coll.SortByMinDate;
    PR001Coll.sortByCl134(CL134Coll);
  end;
  //Stopwatch := TStopwatch.StartNew;

  patNodes := Adb_DM.PatNodesBack;
  startMin := 0;
  currentMin := 0;
  startMax := 0;
  currentMax := 0;
  maxYear := 120;
  StartNzisData := EncodeDate(1821, 01, 01);
  dataPat := PAspRec(PByte(patNodes.patNode) + lenNode);
  BrthDate := patColl.getDateMap(dataPat.DataPos, word(PatientNew_BIRTH_DATE));
  maxLive := DatStrToDays(BrthDate, '120 year');
  for i := 0 to CL132Coll.Count - 1 do
  begin
    gr.repNumber := 0;
    cl132i := CL132Coll.Items[i];
    if FSexMale then
    begin
      if (CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Gender))[1]  = 'f') then
      begin
        //Caption := 'ffff';
        Continue;
      end;
    end
    else
    begin
      if (CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Gender))[1]  = 'm') then
      begin
        //Caption := 'mmmm';
        Continue;
      end;
    end;

    datStr := CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_min_age)); //измислили са датите да са в някаква странна форма
    Graph :=  CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Description));
    Key :=  CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Key));
    egn := patColl.getAnsiStringMap(dataPat.DataPos, word(PatientNew_EGN));
    if (egn <> '0052120125') and (Key = 'V17') then
      egn := '0052120125';  // за тестови цели. спирам си тук да видя какво става при такаова нещо

    currentMin := cl132i.StartDate;
    if currentMin = 0 then
    begin
      currentMin := DatStrToDays(BrthDate, datStr);
    end;

    if CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Event_Trigger))[1] = 'п' then  //при настъпване на 01.01. в годината, на която навършва възрастта
    begin
      currentMin := StartOfAYear(YearOf(currentMin));
    end;
    datStr := CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Max_Age));
    if (datStr <> '') and (Key <> 'V16') then  //  има крайна дата и не е V16. V16  е различно от другите, защото може да се направи във всеки момент от 17 до 25-тата година
    begin
      repStr := CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_repeat_years));
      if repStr <> '' then  // има повторение
      begin
        rep := StrToInt(repStr);
        if CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_cl136)) <> '3' then  // да не е ваксина.
        begin
          currentMax := endOfAYear(YearOf(IncYear((currentMin - 1), rep)));
        end
        else
        begin
          currentMax := endOfAYear(YearOf(IncYear((currentMin - 1), 1))); // за ваксините, без V16  правилото е "само в годината на настъпване.."
        end;
        maxYear := DatStrToDays(BrthDate, datStr)- 1;

        gr.startDate := currentMin;
        if CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Event_Trigger))[1] = 'п' then
        begin
          gr.endDate := currentMax;
        end
        else
        begin
          gr.endDate := currentMax - 1;
        end;
        gr.Cl132 := cl132i;
        if gr.startDate >= StartNzisData then
        begin
          Self.lstAllGraph[lstIndex].Add(gr);
          //Adb_DM.lstAllGraph[Adb_DM.lstAllGraph.Count -1].Add(gr);
          //mmoTest.Lines.add(CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Key)));
        end;

        while currentMax < maxYear do // до максималните години по номенклатурата JM1
        begin
          currentMin := IncYear(currentMin, rep);
          currentMax := IncYear(currentMax, rep);
          gr.startDate := currentMin;
          gr.endDate := currentMax;
          gr.repNumber := gr.repNumber + 1;

          if CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Event_Trigger))[1] = 'п' then
          begin
            currentMax := EndOfAYear(YearOf(currentMax - 1) );
          end;

          gr.startDate := currentMin;
          if CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Event_Trigger))[1] = 'п' then
          begin
            gr.endDate := currentMax;
          end
          else
          begin
            gr.endDate := currentMax - 1;
          end;

          gr.Cl132 := cl132i;
            if gr.startDate >= StartNzisData then
            begin
              Self.lstAllGraph[lstIndex].Add(gr);
              //Adb_DM.lstAllGraph[Adb_DM.lstAllGraph.Count -1].Add(gr);
              //mmoTest.Lines.add(CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Key)));
            end;
        end;

      end
      else  // не се повтарят
      begin
        currentMax := DatStrToDays(BrthDate, datStr);
        if CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Event_Trigger))[1] = 'п' then
        begin
          currentMax := EndOfAYear(YearOf(currentMax - 1) );
          if Key = 'J17' then
          begin
            currentMax := currentMax + (BrthDate - StartOfTheYear(BrthDate));
          end;
        end;

        gr.startDate := currentMin;
        if CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Event_Trigger))[1] = 'п' then
        begin
          gr.endDate := currentMax;
        end
        else
        begin
          gr.endDate := currentMax - 1;
        end;
        gr.repNumber := -1;
        gr.Cl132 := cl132i;
        if gr.startDate >= StartNzisData  then
        begin
          Self.lstAllGraph[lstIndex].Add(gr);
          //Adb_DM.lstAllGraph[Adb_DM.lstAllGraph.Count -1].Add(gr);
          //mmoTest.Lines.add(CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Key)));
        end;
      end;
    end
    else // няма крайна дата, но може да има, а да е ваксина V16
    begin
      repStr := CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_repeat_years));
      if repStr <> '' then
      begin
        rep := StrToInt(repStr);
        if CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_cl136)) <> '3' then  // да не е ваксина.
        begin
          currentMax := endOfAYear(YearOf(IncYear((currentMin - 1), rep)));
        end
        else
        begin
          if Key <> 'V16' then
          begin
            currentMax := endOfAYear(YearOf(IncYear((currentMin - 1), 1))); // за ваксините, без V16  правилото е "само в годината на настъпване.."
          end
          else
          begin
            currentMax := endOfAYear(YearOf(IncYear((currentMin - 1), rep)));
          end;
        end;
        gr.startDate := currentMin;
        if CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Event_Trigger))[1] = 'п' then
        begin
          gr.endDate := currentMax;
        end
        else
        begin
          gr.endDate := currentMax - 1;
        end;
        gr.Cl132 := cl132i;
        if gr.startDate >= StartNzisData then
        begin
          if (Key = 'A1') and (gr.repNumber = 0) then
          begin
            gr.startDate := gr.startDate + (BrthDate - StartOfTheYear(BrthDate));
          end;
          Self.lstAllGraph[lstIndex].Add(gr);
          //Adb_DM.lstAllGraph[Adb_DM.lstAllGraph.Count -1].Add(gr);
          //mmoTest.Lines.add(CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Key)));
        end;
      end
      else
      begin
        //assert(repStr = '', Format('План %s, е без крайна дата и няма повторяемост. ', [Key]))
      end;


      if Key <> 'V16' then
      begin
        if repStr = '' then
          mmoTest.Lines.Add('ddd');
        while  currentMax < maxLive do   // да се открие логиката
        begin
          currentMin := IncYear(currentMin, rep);
          currentMax := IncYear(currentMax, rep);
          gr.startDate := currentMin;
          if CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Event_Trigger))[1] = 'п' then
          begin
            gr.endDate := currentMax;
          end
          else
          begin
            gr.endDate := currentMax - 1;
          end;
          gr.repNumber := gr.repNumber + 1;
          case CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_cl136))[1] of
            '1': // преглед
            begin
              for k := 0 to patNodes.pregs.Count - 1 do
              begin
                dataPreg := PAspRec(PByte(patNodes.pregs[k]) + lenNode);
                datTemp := pregColl.getDateMap(dataPreg.DataPos, word(PregledNew_START_DATE));
                if (datTemp >= gr.startDate) and (datTemp <= gr.endDate)  then
                begin
                  //if pregNodes.Planeds = nil then
//                  begin
//                    break;
//                  end;
                end;
              end;
            end;
          end;
          gr.Cl132 := cl132i;
          if gr.startDate >= StartNzisData then
          begin
            Self.lstAllGraph[lstIndex].Add(gr); // няма крайна дата и се повтаря до края на живота
            //Adb_DM.lstAllGraph[Adb_DM.lstAllGraph.Count -1].Add(gr);
            //mmoTest.Lines.add(CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Key)));
          end;
          //Break;
        end;
      end
      else
      begin
        currentMax := DatStrToDays(BrthDate, '24 years');
        if CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Event_Trigger))[1] = 'п' then
        begin
          currentMax := EndOfAYear(YearOf(currentMax - 1) );
        end;

        gr.startDate := currentMin;
        if CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Event_Trigger))[1] = 'п' then
        begin
          gr.endDate := currentMax;
        end
        else
        begin
          gr.endDate := currentMax - 1;
        end;
        gr.repNumber := -1;
        gr.Cl132 := cl132i;
        if gr.startDate >= StartNzisData  then
        begin
          Self.lstAllGraph[lstIndex].Add(gr);
          //Adb_DM.lstAllGraph[Adb_DM.lstAllGraph.Count -1].Add(gr);
          //mmoTest.Lines.add(CL132Coll.getAnsiStringMap(cl132i.DataPos, word(CL132_Key)));
        end;
      end;
    end;
  end;
  //Elapsed := Stopwatch.Elapsed;
  //gr.Cl132.test := ( 'rrrr ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

function TProfGraph.IsCurrentPeriod(const AGr: TGraphPeriod132): Boolean;
begin
  Result := (UserDate >= AGr.startDate) and (UserDate <= AGr.endDate);
end;

function TProfGraph.IsFuturePeriod(const AGr: TGraphPeriod132): Boolean;
begin
  Result := (UserDate < AGr.startDate) and (UserDate < AGr.endDate);
end;

function TProfGraph.IsPastPeriod(const AGr: TGraphPeriod132): Boolean;
begin
  Result := UserDate > AGr.endDate;
end;

procedure TProfGraph.LoadVtr;
var
  i, j: Integer;

  dat: TDate;
  log: TlogicalPatientNewSet;
  dataGraph: PAspRec;
  node: PVirtualNode;

begin
  VisibleMinali := false;
  VisibleBudeshti := false;

  vtrGraph.BeginUpdate;
  vtrGraph.Clear;
  vtrGraph.OnGetText := vtrGraphGetText;
  vRootGraph := vtrGraph.AddChild(nil, nil);
  dataGraph := vtrGraph.GetNodeData(vRootGraph);
  dataGraph.vid := vvNone;
  dataGraph.index := -1;
  Adb_dm.CollPatient.FillListNodes(Adb_DM.AdbMainLink, vvPatient);
  Stopwatch := TStopwatch.StartNew;

  lstAllGraph.Clear;
  lstAllGraph.Count := Adb_dm.CollPatient.ListNodes.Count;
  for i := 0 to  Adb_dm.CollPatient.ListNodes.Count - 1 do
  begin
    node := pointer(PByte(Adb_dm.CollPatient.ListNodes[i]) - lenNode);
    Adb_DM.BuildPatNodes(node);
    dat := Adb_dm.CollPatient.getDateMap(Adb_dm.CollPatient.ListNodes[i].DataPos, word(PatientNew_BIRTH_DATE));
    log := TlogicalPatientNewSet(Adb_dm.CollPatient.getLogical40Map(Adb_dm.CollPatient.ListNodes[i].DataPos, word(PatientNew_Logical)));
    SexMale := (TLogicalPatientNew.SEX_TYPE_M in log) ;
    CurrDate := dat;
    FillTree := True;

    lstAllGraph[i] := TLstGraph.Create;
    GeneratePeriod1(i);

    LoadVtrGraphOutVtr1(i);
  end;

  Elapsed := Stopwatch.Elapsed;
  vtrGraph.EndUpdate;
  //vtrGraph.FullExpand();

  mmoTest.lines.add(Format('%d nodes за  проф: %f', [vtrGraph.TotalCount, Elapsed.TotalMilliseconds]));
end;

procedure TProfGraph.LoadVtrGraphOutVtr1(indexList: integer);
var
  i              : Integer;
  gr             : TGraphPeriod132;
  isPast         : Boolean;
  isFuture       : Boolean;
  isCurr         : Boolean;

  IsPregForPerform : Boolean;
  FirstCurrentIndex: Cardinal;
  AEndDate         : TDate;

  // за дървото (hooks)
  vPat, vPast, vCurr, vFuture: PVirtualNode;
  vCl132: PVirtualNode;
begin
  // по подразбиране – няма нищо за вършене
  Adb_DM.PatNodesBack.NoteProf          := 'Няма неизвършени дейности по профилактиката.';
  Adb_DM.PatNodesBack.CurrentGraphIndex := -1;
  Adb_DM.PatNodesBack.ListCurrentProf.Clear;

  IsPregForPerform := False;
  FirstCurrentIndex:= MaxInt;

  if FFillTree then
  begin
    BeginFillTree;
    AddPatientNode(indexList, vPat, vPast, vCurr, vFuture);
  end
  else
  begin
    vPat    := nil;
    vPast   := nil;
    vCurr   := nil;
    vFuture := nil;
  end;

  // минаваме през всички периоди за пациента
  for i := 0 to Self.lstAllGraph[indexList].Count - 1 do
  begin
    gr := Self.lstAllGraph[indexList][i];

    // чистим всякакво старо runtime състояние
    ResetPeriodRuntimeState(gr);

    isPast   := IsPastPeriod(gr);
    isFuture := IsFuturePeriod(gr);
    isCurr   := IsCurrentPeriod(gr);

    // филтър за минали/бъдещи
    if isPast and (not FVisibleMinali) then
      Continue;
    if isFuture and (not FVisibleBudeshti) then
      Continue;


    // --- дърво: добавяме CL132 възел (по желание) ---
    vCl132 := nil;
    if FFillTree then
    begin
      if isPast then
        AddCl132Node(vPast, gr, i, vCl132)
      else
      if isFuture then
        AddCl132Node(vFuture, gr, i, vCl132)
      else
        AddCl132Node(vCurr, gr, i, vCl132);
    end;

    if not isCurr then
      Continue;

    // текущите ги пазим в ListCurrentProf, за да ги вижда FMX-формата
      Adb_DM.PatNodesBack.ListCurrentProf.Add(gr);


    // --- тип на плана по CL132_cl136 ---
    case Adb_DM.CL132Coll.getAnsiStringMap(
           gr.Cl132.DataPos,
           word(CL132_cl136)
         )[1] of
      '1':  // преглед
      begin
        AttachPregToPeriod(
          indexList,
          i,
          gr,
          IsPregForPerform,
          FirstCurrentIndex,
          AEndDate
        );
      end;

      '2':  // изследвания
      begin
        AttachExamAnalysesToPeriod(gr);
      end;

      '3':  // имунизации – засега само ги отбелязваме
      begin
        // тук по-нататък ще вържем имунизации към периода
      end;
    else
      // други типове – засега ги игнорираме
    end;

    // за всяко PR001 добавяме CL088 / CL134 (логиката от стария код)
    AttachCl088AndCl134(gr, vCl132);
  end;

  if FFillTree then
    EndFillTree;
end;


//procedure TProfGraph.LoadVtrGraphOutVtr1(const FillTree: Boolean);
//var
//  adbDM      : TADBDataModule;
//  patNodes   : TPatNodes;
//  BufNomen   : Pointer;
//  BufMain    : Pointer;
//  posCL132   : Cardinal;
//  posPR001   : Cardinal;
//  posMain    : Cardinal;
//  i, j       : Integer;
//  gr         : TGraphPeriod132;
//  cl132Type  : string;
//  cl132Key   : string;
//  pregNode   : PVirtualNode;
//
//  function IsPastProc(const AGr: TGraphPeriod132): Boolean;
//  begin
//    Result := UserDate > AGr.endDate;
//  end;
//
//  function IsFutureProc(const AGr: TGraphPeriod132): Boolean;
//  begin
//    Result := UserDate < AGr.startDate;
//  end;
//
//  function IsCurrent(const AGr: TGraphPeriod132): Boolean;
//  begin
//    Result := (UserDate >= AGr.startDate) and (UserDate <= AGr.endDate);
//  end;
//
//  /// Проверява има ли преглед в периода на плана и връща нода
//  function HasPregledInPeriod(const AGr: TGraphPeriod132;
//    out APregNode: PVirtualNode): Boolean;
//  var
//    k         : Integer;
//    dataPreg  : PAspRec;
//    prDate    : TDate;
//  begin
//    Result := False;
//    APregNode := nil;
//
//    for k := 0 to patNodes.pregs.Count - 1 do
//    begin
//      dataPreg := PAspRec(PByte(patNodes.pregs[k]) + lenNode);
//      prDate   := adbDM.CollPregled.getDateMap(
//                    dataPreg.DataPos,
//                    word(PregledNew_START_DATE)
//                  );
//      if (prDate >= AGr.startDate) and (prDate <= AGr.endDate) then
//      begin
//        Result   := True;
//        APregNode := patNodes.pregs[k];
//        Exit;
//      end;
//    end;
//  end;
//
  /// За CL132 тип „изследвания“ – обвързва изследванията с PR001
  //procedure AttachExamAnalysesToPeriod(var AGr: TGraphPeriod132);
//  var
//    k, m        : Integer;
//    NodeExam    : PVirtualNode;
//    dataExam    : PAspRec;
//    examDate    : TDate;
//    cl22Exam    : string;
//    cl22Pr1     : string;
//    pr001       : TRealPR001Item;
//  begin
//    // Нулираме старите връзки за всеки PR001
//    for m := 0 to AGr.Cl132.FListPr001.Count - 1 do
//      AGr.Cl132.FListPr001[m].FExamAnalPos := 0;
//    AGr.Cl132.FExamAnalPos := 0;
//
//    for k := 0 to Adb_DM.PatNodesBack.ExamAnals.Count - 1 do
//    begin
//      NodeExam := Adb_DM.PatNodesBack.ExamAnals[k];
//      dataExam := PAspRec(PByte(NodeExam) + lenNode);
//
//      // дата на изследването от главния ADB
//      examDate := Adb_DM.CollExamAnal.getDateMap(
//                    dataExam.DataPos,
//                    word(ExamAnalysis_DATA)
//                  );
//
//      // извън периода – не ни интересува
//      if (examDate < AGr.startDate) or (examDate > AGr.endDate) then
//        Continue;
//
//      // !!! тук беше BUG – ползвано беше getDateMap вместо getAnsiStringMap
//      cl22Exam := Adb_DM.CollExamAnal.getAnsiStringMap(
//                    dataExam.DataPos,
//                    word(ExamAnalysis_NZIS_CODE_CL22)
//                  );
//
//      // търсим съответствие по CL22 между PR001 и самото изследване
//      for m := 0 to AGr.Cl132.FListPr001.Count - 1 do
//      begin
//        pr001 := AGr.Cl132.FListPr001[m];
//
//        cl22Pr1 := Adb_DM.PR001Coll.getAnsiStringMap(pr001.DataPos,word(PR001_Activity_ID));
//
//        if cl22Pr1 = cl22Exam then
//        begin
//          // за конкретния PR001 – запомняме DataPos
//          if pr001.FExamAnalPos = 0 then
//            pr001.FExamAnalPos := dataExam.DataPos;
//
//          // и общо за целия CL132 (поне едно изследване в периода)
//          if AGr.Cl132.FExamAnalPos = 0 then
//            AGr.Cl132.FExamAnalPos := dataExam.DataPos;
//
//          // НЕ правим Break; – едно изследване може логически да покрие
//          // няколко PR001 (ако в НЗИС така са го свързали)
//        end;
//      end;
//    end;
//  end;
//
//  // ВРЕМЕННО: всеки преглед в периода се счита за изпълнение на плана.
//  // По-късно тук ще филтрираме по вид преглед, МКБ, флагове и т.н.
//  function PregledCountsForProf_All(const AGr: TGraphPeriod132;
//    APregDataPos: Cardinal): Boolean;
//  begin
//    // Засега абсолютно всяко посещение "важи"
//    Result := true;
//  end;
//
//var
//  isPast, isFuture, isCurr : Boolean;
//  dataPreg: PAspRec;
//  prStartDate, AEndDate: TDate;
//  IsPregForPerform: Boolean;
//  dataNast_DataPos: Integer;
//  // за дървото
//  vPat, vNast, vGr: PAspRec;
//  dataPat, dataNast, dataGr: PAspRec;
//begin
//  adbDM := Adb_DM;
//
//  if adbDM.AdbNomenNzis = nil then
//    adbDM.OpenADBNomenNzis('NzisNomen.adb');
//
//  BufNomen := adbDM.AdbNomenNzis.Buf;
//  BufMain  := adbDM.AdbMain.Buf;
//  posCL132 := adbDM.CL132Coll.posData;
//  posPR001 := adbDM.PR001Coll.posData;
//  posMain  := adbDM.AdbMain.FPosData;
//
//  patNodes := adbDM.PatNodesBack;
//
//  // по подразбиране – нищо за правене
//  patNodes.NoteProf          := 'Няма неизвършени дейности по профилактиката.';
//  IsPregForPerform := False;
//  dataNast_DataPos := MaxInt;
//  patNodes.CurrentGraphIndex := -1;
//  patNodes.ListCurrentProf.Clear;
//
//  //да обходим всички периоди за пациента
//  for i := 0 to patNodes.lstGraph.Count - 1 do
//  begin
//    gr := patNodes.lstGraph[i];
//
//    // runtime-състояние за този CL132 – чистим всякакви стари връзки
//    gr.Cl132.FPregNode := nil;
//
//    isPast  := IsPastProc(gr);
//    isFuture:= IsFutureProc(gr);
//    isCurr  := IsCurrent(gr);
//
//    // при нужда може да върнем и минали/бъдещи в други списъци;
//    // засега работим само с текущите
//    if isPast and (not FVisibleMinali) then
//      Continue;
//    if isFuture and (not FVisibleBudeshti) then
//      Continue;
//    if not isCurr then
//      Continue;
//
//    // всички текущи планове се пазят в ListCurrentProf
//    patNodes.ListCurrentProf.Add(gr);
//
//
//    cl132Type := gr.Cl132.getAnsiStringMap(
//                   BufNomen,
//                   posCL132,
//                   word(CL132_cl136)
//                 );
//    if cl132Type = '' then
//      Continue;
//
//    cl132Key := gr.Cl132.getAnsiStringMap(
//                  BufNomen,
//                  posCL132,
//                  word(CL132_Key)
//                );
//
//    case cl132Type[1] of
//      // =========================
//      // 1 – ПРЕГЛЕД
//      // =========================
//      '1': // ако е тип преглед
//      begin
//        gr.Cl132.FPregNode := nil; // зануляваме
//        Cl132Key := gr.Cl132.getAnsiStringMap(
//                      BufNomen,
//                      Adb_DM.CL132Coll.posData,
//                      word(CL132_Key)
//                    );
//
//        for j := 0 to PatNodes.pregs.Count - 1 do
//        begin
//          dataPreg := PAspRec(PByte(PatNodes.pregs[j]) + lenNode);
//          prStartDate := adbDM.CollPregled.getDateMap(
//                           dataPreg.DataPos,
//                           word(PregledNew_START_DATE)
//                         );
//
//          // само по период – не гледаме нищо друго
//          if (prStartDate < gr.startDate) or (prStartDate > gr.endDate) then
//            Continue;
//
//          // ТУК е мястото за бъдещия филтър; засега всичко минава
//          if PregledCountsForProf_All(gr, dataPreg.DataPos) then
//          begin
//            gr.Cl132.FPregNode := PatNodes.pregs[j];
//            PatNodes.CurrentGraphIndex := i;
//            Break; // намерили сме един преглед в периода – приемаме, че плана е изпълнен
//          end;
//        end;
//
//        // ако FPregNode е останал nil => за този период НЯМА преглед,
//        // и съответно ще тръгнем по логиката "има неизвършени дейности"
//        if gr.Cl132.FPregNode = nil then
//        begin
//          // тук си остава твоята логика с NzisPregNotPreg / IsPregForPerform /
//          // NoteProf / ListCurrentProf – тя вече ще се задейства винаги
//          // когато НЯМА НИТО ЕДИН преглед в периода
//          if NzisPregNotPreg.Contains('|' + Cl132Key + '|') then
//          begin
//            PatNodes.ListCurrentProf.Add(gr);
//          end
//          else
//          begin
//            if IsPregForPerform then
//            begin
//              PatNodes.ListCurrentProf.Add(gr);
//            end
//            else
//            begin
//              IsPregForPerform := true;
//              AEndDate := gr.endDate;
//              if dataNast_DataPos = MaxInt then
//              begin
//                dataNast_DataPos := i;
//                PatNodes.NoteProf :=
//                  gr.Cl132.getAnsiStringMap(
//                    BufNomen,
//                    Adb_DM.CL132Coll.posData,
//                    word(CL132_Description)
//                  );
//                PatNodes.CurrentGraphIndex := i;
//                PatNodes.ListCurrentProf.Add(gr);
//              end
//              else
//              begin
//                ShowMessage('Има повече от един преглед');
//              end;
//            end;
//          end;
//        end
//        else
//        begin
//          // намерен е поне един преглед в периода -> плана за прегледа се счита за покрит
//          AEndDate := gr.endDate; // както си беше
//        end;
//      end;
//
//
//      // =========================
//      // 2 – ИЗСЛЕДВАНИЯ
//      // =========================
//      '2': // изследвания
//      begin
//        PatNodes.ListCurrentProf.Add(gr);
//        AttachExamAnalysesToPeriod(gr);
//      end;
//
//      // =========================
//      // 3 – ИМУНИЗАЦИИ
//      // =========================
//      '3':
//      begin
//        // засега само отбелязваме, че има текущ период с имунизации;
//        // по-нататък можем да го вържем с e-immunization NRN
//      end;
//    end;
//  end;
//
//  // ако не е избран нито един неизвършен прегледен план,
//  // NoteProf остава: „Няма неизвършени дейности по профилактиката.“
//end;
//



procedure TProfGraph.ResetPeriodRuntimeState(var AGr: TGraphPeriod132);
var
  j: Integer;
begin
  // чистим временните връзки към преглед и изследвания
  FreeAndNil(AGr.Cl132.FExamAnal);
  AGr.Cl132.FPregNode := nil;

  for j := 0 to AGr.Cl132.FListPr001.Count - 1 do
    FreeAndNil(AGr.Cl132.FListPr001[j].FExamAnal);
end;

function TProfGraph.RuleCl132_PR001(cl132, pr001: TObject): boolean;
var
  pr1Nomen: string;
  BufNomen: Pointer;
begin
  BufNomen := Adb_DM.AdbNomenNzis.Buf;
  Result := True;
  pr1Nomen := TRealPR001Item(pr001).getAnsiStringMap(BufNomen, Adb_DM.PR001Coll.posData, word(PR001_Nomenclature));
  if (TRealCl132Item(cl132).IndexAnsiStr1 = 'C22') and (pr1Nomen = 'CL133')then
  begin
    Result := false;
    Exit;
  end;
  if (TRealCl132Item(cl132).IndexAnsiStr1 = 'C32') and (pr1Nomen = 'CL133')then
  begin
    Result := false;
    Exit;
  end;
  if (TRealCl132Item(cl132).IndexAnsiStr1 = 'C42') and (pr1Nomen = 'CL133')then
  begin
    Result := false;
    Exit;
  end;
  if (TRealCl132Item(cl132).IndexAnsiStr1 = 'C52') and (pr1Nomen = 'CL133')then
  begin
    Result := false;
    Exit;
  end;
end;

procedure TProfGraph.SetCurrDate(const Value: TDate);
begin
  FCurrDate := Value;
end;

procedure TProfGraph.vtrGraphGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data, dataCL132, dataPr001, dataCl134, dataPeriod, dataPat: PAspRec;
  cl132: TRealCL132Item;
  cl134: TCL134Item;
  pr001: TRealPR001Item;
  CL142: TRealCl142Item;
  CL088: TRealCL088Item;
  preg: TRealPregledNewItem;
  pat: TRealPatientNewItem;
  i: integer;
  cl132_CL136Str: string;
  strtDate: TDate;
begin
  if node = nil then Exit;

  data := vtrGraph.GetNodeData(node);
  case Column of
    0:
    begin

      case data.vid of

        vvNone:
        begin
          CellText := 'Графици';
        end;
        vvPeriodPast: CellText := 'минали';
        vvPeriodCurrent: CellText := 'текущи';
        vvPeriodFuture: CellText := 'бъдещи';
        vvCl132:
        begin
          dataCL132 := vtrGraph.GetNodeData(node);
          //pat := ADB_DM.ACollPatGR.Items[dataPat.index];
//          cl132 := pat.lstGraph[data.index].Cl132;
          CellText := Adb_DM.CL132Coll.getAnsiStringMap(dataCL132.DataPos, word(CL132_Key));
          CellText := CellText + '  ' +  Adb_DM.CL132Coll.getAnsiStringMap(dataCL132.DataPos, word(CL132_Description));
        end;
        vvPr001:
        begin
          dataPr001 := vtrGraph.GetNodeData(node);
          CellText := Adb_DM.PR001Coll.getAnsiStringMap(dataPr001.DataPos, word(PR001_Description));
          //if (pr001.CL142 <> nil)  and (pr001.CL142.FListCL088.Count =1) then
//          begin
//            cl088 := pr001.CL142.FListCL088[0];
//            CellText  := CellText + ' cl088 ' + CL088.getAnsiStringMap(Adb_DM.AdbNomenNzis.Buf, ADB_DM.PR001Coll.posData, word(CL088_cl028));
//          end;
        end;
        vvCL088:
        begin
          dataPr001 := vtrGraph.GetNodeData(node.Parent);
          dataCL132 := vtrGraph.GetNodeData(node.Parent.Parent);
          dataPat := vtrGraph.GetNodeData(node.Parent.Parent.parent.parent);
          cl132 := pat.lstGraph[dataCL132.index].Cl132;
          pr001 := cl132.FListPr001[dataPr001.index];
          CL142 := pr001.CL142;
          cl088 := CL142.FListCL088[data.index];
          CellText := cl088.getAnsiStringMap(Adb_DM.AdbNomenNzis.Buf, ADB_DM.PR001Coll.posData, word(CL088_Description));
        end;
        vvCl134:
        begin
          dataCL132 := vtrGraph.GetNodeData(node.Parent.Parent);
          dataPr001 := vtrGraph.GetNodeData(node.Parent);
          dataPat := vtrGraph.GetNodeData(node.Parent.Parent.parent.parent);
          cl132 := pat.lstGraph[dataCL132.index].Cl132;
          pr001 := cl132.FListPr001[dataPr001.index];
          cl134 := pr001.LstCl134[data.index];
          CellText := cl134.getAnsiStringMap(Adb_DM.AdbNomenNzis.Buf, ADB_DM.PR001Coll.posData, word(CL134_Description));
        end;
        vvPatient:
        begin
          dataPat := vtrGraph.GetNodeData(node);
          CellText := Adb_DM.CollPatient.getAnsiStringMap(dataPat.DataPos, word(PatientNew_FNAME));
          CellText := CellText + ' ' + Adb_DM.CollPatient.getAnsiStringMap(dataPat.DataPos, word(PatientNew_SNAME));
          CellText := CellText + ' ' + Adb_DM.CollPatient.getAnsiStringMap(dataPat.DataPos, word(PatientNew_LNAME));
        end;
      end;
    end;
    1:
    begin
      case data.vid of
        vvnone:
        begin
          CellText := 'Брой пациенти: ' + inttostr(node.ChildCount);
        end;
        vvPatient:
        begin
          dataPat := vtrGraph.GetNodeData(node);
          //pat := ADB_DM.CollPatient.Items[dataPat.index];
          CellText := 'ЕГН ' + ADB_DM.CollPatient.getAnsiStringMap(dataPat.DataPos, word(PatientNew_EGN));
        end;
        vvCl132:
        begin
          dataPat := vtrGraph.GetNodeData(node.Parent.Parent);

          CellText := DateToStr(lstAllGraph[dataPat.index][data.index].startDate) + ' - ' +
                      DateToStr(lstAllGraph[dataPat.index][data.index].endDate);
          //cl132 := pat.lstGraph[data.index].Cl132;
//          cl132_CL136Str := cl132.getAnsiStringMap(Adb_DM.AdbNomenNzis.Buf, ADB_DM.PR001Coll.posData, word(cl132_CL136));
//          case cl132_CL136Str[1] of
//            '1':
//            begin
//              if cl132.FPregled <> nil then
//              begin
//                strtDate := TRealPregledNewItem(cl132.FPregled).getDateMap(Adb_DM.AdbMain.Buf, Adb_DM.AdbMain.FPosData, word(PregledNew_START_DATE));
//                CellText := DateToStr(strtDate) + #13#10 + CellText;
//              end;
//            end;
//          else
//            begin
//              pr001 := cl132.FListPr001[0];
//              CellText := CellText + #13#10 + pr001.getAnsiStringMap(Adb_DM.AdbNomenNzis.Buf, ADB_DM.PR001Coll.posData, word(PR001_Specialty_CL006));//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz ne e since a rule
//            end;
//          end;
        end;
//        vvPr001:
//        begin
//          if node.Parent.parent.parent = nil then
//          begin
//            CellText := 'errrrr';
//            exit;
//          end;
//          dataCL132 := vtrGraph.GetNodeData(node.Parent);
//          dataPat := vtrGraph.GetNodeData(node.Parent.Parent.parent);
//          pat := ADB_DM.ACollPatGR.Items[dataPat.index];
//          cl132 := pat.lstGraph[dataCL132.index].Cl132;
//          pr001 := cl132.FListPr001[data.index];
//          CellText := pr001.getAnsiStringMap(Adb_DM.AdbNomenNzis.Buf, ADB_DM.PR001Coll.posData, word(PR001_Activity_ID));
//
//          if pr001.CL142 <> nil then
//          begin
//            CellText := CellText + #13#10 + pr001.CL142.getAnsiStringMap(Adb_DM.AdbNomenNzis.Buf, ADB_DM.PR001Coll.posData, word(CL142_nhif_code));
//          end;
//          if pr001.FExamAnal <> nil then
//          begin
//            strtDate := TRealExamAnalysisItem(pr001.FExamAnal).getDateMap(Adb_DM.AdbMain.Buf, Adb_DM.AdbMain.FPosData, word(ExamAnalysis_DATA));
//            CellText := DateToStr(strtDate) + #13#10 + CellText;
//          end;
//        end;
//        vvCL088:
//        begin
//          dataPr001 := vtrGraph.GetNodeData(node.Parent);
//          dataCL132 := vtrGraph.GetNodeData(node.Parent.Parent);
//          dataPat := vtrGraph.GetNodeData(node.Parent.Parent.parent.parent);
//          pat := ADB_DM.ACollPatGR.Items[dataPat.index];
//          cl132 := pat.lstGraph[dataCL132.index].Cl132;
//          pr001 := cl132.FListPr001[dataPr001.index];
//          CL142 := pr001.CL142;
//          cl088 := CL142.FListCL088[data.index];
//          CellText := cl088.getAnsiStringMap(Adb_DM.AdbNomenNzis.Buf, ADB_DM.PR001Coll.posData, word(CL088_Description));
//        end;
//        vvCl134:
//        begin
//          dataCL132 := vtrGraph.GetNodeData(node.Parent.Parent);
//          dataPr001 := vtrGraph.GetNodeData(node.Parent);
//          dataPat := vtrGraph.GetNodeData(node.Parent.Parent.parent.parent);
//          pat := ADB_DM.ACollPatGR.Items[dataPat.index];
//          cl132 := pat.lstGraph[dataCL132.index].Cl132;
//          pr001 := cl132.FListPr001[dataPr001.index];
//          cl134 := pr001.LstCl134[data.index];
//          case cl134.getAnsiStringMap(Adb_DM.AdbNomenNzis.Buf, ADB_DM.PR001Coll.posData, word(CL134_CL028))[1] of
//            '1': CellText := 'Количествено представяне';
//            '2': CellText := 'Категоризация по номенклатура';
//            '3': CellText := 'Описателен метод';
//            '4': CellText := 'Конкретна дата';
//            '5': CellText := 'Положително или отрицателно';
//          end;
//        end;
      end;
    end;
//    2:
//    begin
//      //CellText := TRttiEnumerationType.GetName(Data.vid);
//      case data.vid of
//        vvPatient:
//        begin
//          dataPat := vtrGraph.GetNodeData(node);
//          pat := ADB_DM.ACollPatGR.Items[dataPat.index];
//          CellText := 'има общо: ' + IntToStr(pat.FPregledi.Count) + ' прегледа';
//        end;
//        vvCL088:
//        begin
//          dataPat := vtrGraph.GetNodeData(node.Parent.Parent.parent.parent);
//          pat := ADB_DM.ACollPatGR.Items[dataPat.index];
//          dataPr001 := vtrGraph.GetNodeData(node.Parent);
//          dataCL132 := vtrGraph.GetNodeData(node.Parent.Parent);
//          cl132 := pat.lstGraph[dataCL132.index].Cl132;
//          pr001 := cl132.FListPr001[dataPr001.index];
//          CL142 := pr001.CL142;
//          cl088 := CL142.FListCL088[data.index];
//          CellText := cl088.getAnsiStringMap(Adb_DM.AdbNomenNzis.Buf, ADB_DM.PR001Coll.posData, word(CL088_cl028));
//        end;
//        vvPr001:
//        begin
//          if node.Parent.parent.parent = nil then
//            begin
//              CellText := 'errrrr';
//              exit;
//            end;
//          dataCL132 := vtrGraph.GetNodeData(node.Parent);
//          dataPat := vtrGraph.GetNodeData(node.Parent.Parent.parent);
//          pat := ADB_DM.ACollPatGR.Items[dataPat.index];
//          cl132 := pat.lstGraph[dataCL132.index].Cl132;
//          pr001 := cl132.FListPr001[data.index];
//          begin
//            case pr001.getAnsiStringMap(Adb_DM.AdbNomenNzis.Buf, ADB_DM.PR001Coll.posData, word(PR001_Nomenclature))[5] of
//              '2': CellText := 'Изследвания';
//              '0': CellText := 'Дейност по профилактика';
//              '3': CellText := 'Въпроси';
//              '8': CellText := 'Имунизации';
//            end;
//          end;
//        end;
//        vvCl132:
//        begin
//          dataPeriod := vtrGraph.GetNodeData(node.Parent);
//          dataPat := vtrGraph.GetNodeData(node.Parent.Parent);
//          pat := ADB_DM.ACollPatGR.Items[dataPat.index];
//          case dataPeriod.index of
//            -1: //минали
//            begin
//              CellText := '++' + inttostr(DaysBetween(pat.lstGraph[data.index].endDate, UserDate));
//            end;
//            -2: //текущи
//            begin
//              cl132 := pat.lstGraph[data.index].Cl132;
//
//              CellText := '+' + inttostr(DaysBetween(pat.lstGraph[data.index].endDate, UserDate));
//            end;
//            -3: //бъдещи
//            begin
//              CellText := '-' + inttostr(DaysBetween(pat.lstGraph[data.index].startDate, UserDate));
//            end;
//          end;
//
//        end;
//      end;
//    end;
  end;

end;

end.
