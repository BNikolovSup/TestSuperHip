unit ProfGraph;

interface
uses
  System.Generics.Collections, System.SysUtils, System.DateUtils, system.Classes,
  RealObj.NzisNomen, VirtualStringTreeHipp, dialogs, system.Diagnostics, System.timespan,
  VirtualTrees, Aspects.Types, Table.PatientNew, Table.PregledNew, Table.Diagnosis,
  Table.Cl132, table.PR001, table.CL050, table.cl134, table.cl139,
  table.CL022, Table.Cl038, table.CL142, table.cl088, Table.CL144,
  Table.CL037, table.cl006,
  Table.ExamAnalysis;

type
  TGraphPeriod132 = record
    Cl132: TRealCL132Item;
    startDate: TDate;
    endDate: TDate;
    repNumber: Integer;
  end;

  TProfGraph = class
  private
    FCurrDate: TDate;
    FSexMale: Boolean;
    isFilled: Boolean;
    FVisibleMinali: Boolean;
    FVisibleBudeshti: Boolean;
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    function DatStrToDays(currDay: TDate; str: string): TDate;
    procedure SetCurrDate(const Value: TDate);
  protected
    lstValid: TStringList;
    procedure FillPr001InCl132;
    procedure FillCl050;
    procedure FillCl050_1;
    procedure FillCL134;
    procedure FillCl142InPr001;
    procedure FillCl088InCL142;
    procedure FillCl144InCL142;
  public

    vtrGraph: TVirtualStringTreeHipp;

    collPat: TCollection;
    Adb_DM: TObject;

    constructor create;
    procedure GeneratePeriod1();
    function RuleCl132_PR001(cl132, pr001: TObject): Boolean;

    //procedure LoadVtrGraph1(Apat: TObject; patIndex: Integer);
    procedure LoadVtrGraphOutVtr1();
    property CurrDate: TDate read FCurrDate write SetCurrDate;
    property SexMale: Boolean read FSexMale write FSexMale;
    property VisibleMinali: Boolean read FVisibleMinali write FVisibleMinali;
    property VisibleBudeshti: Boolean read FVisibleBudeshti write FVisibleBudeshti;
  end;

implementation
uses
  RealObj.RealHipp,
  ADB_DataUnit;

{ TProfGraph }

constructor TProfGraph.create;
begin
  inherited create;
  isFilled := False;
  FVisibleBudeshti := true;
  FVisibleMinali := true;
  FSexMale := True;
  FCurrDate := UserDate;

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

function TProfGraph.DatStrToDays(currDay: TDate; str: string): TDate;
var
  ArrStr: Tarray<string>;
  Period: string;
  Count: Integer;
begin
  ArrStr := str.Split([' ']);

  Period := ArrStr[1];
  case Period[1] of
    'd':// days
    begin
      Count := StrToInt(ArrStr[0]);
      Result := IncDay(currDay, count);
    end;
    'w':// weeks
    begin
      Count := StrToInt(ArrStr[0]);
      Result := IncWeek(currDay, count);
    end;
    'm'://  months
    begin
      Count := StrToInt(ArrStr[0]);
      Result := IncMonth(currDay, count);
    end;
    'y'://years
    begin
      Count := StrToInt(ArrStr[0]);
      Result := IncYear(currDay, count);
    end;
    '+'://Recurring +1Y //zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
    begin
      Count := 100;
      Result := IncYear(currDay, count);
    end;
  end;
end;

procedure TProfGraph.FillCl050;
var
  iCL050, iPR001: Integer;
  test: AnsiString;
  CL050Coll: TCL050Coll;
  PR001Coll: TRealPR001Coll;

begin
  CL050Coll := TADBDataModule(Adb_DM).CL050Coll;
  PR001Coll := TADBDataModule(Adb_DM).PR001Coll;

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
  CL050Coll := TADBDataModule(Adb_DM).CL050Coll;
  PR001Coll := TADBDataModule(Adb_DM).PR001Coll;

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
  TADBDataModule(Adb_DM).CL142Coll.IndexValue(CL142_Key);
  TADBDataModule(Adb_DM).CL142Coll.SortByIndexAnsiString;

  TADBDataModule(Adb_DM).CL088Coll.IndexValue(CL088_cl142);
  TADBDataModule(Adb_DM).CL088Coll.SortByIndexAnsiString;

  iCL142 := 0;
  iCL088 := 0;
  while (iCL142 < TADBDataModule(Adb_DM).CL142Coll.Count) and (iCL088 < TADBDataModule(Adb_DM).CL088Coll.Count) do
  begin
    if trim(TADBDataModule(Adb_DM).CL142Coll.Items[iCL142].IndexAnsiStr1) = trim(TADBDataModule(Adb_DM).CL088Coll.Items[iCL088].IndexAnsiStr1) then
    begin
      TADBDataModule(Adb_DM).CL142Coll.Items[iCL142].FListCL088.Add(TADBDataModule(Adb_DM).CL088Coll.Items[iCL088]);
      inc(iCL088);
    end
    else
    if TADBDataModule(Adb_DM).CL142Coll.Items[iCL142].IndexAnsiStr1 < TADBDataModule(Adb_DM).CL088Coll.Items[iCL088].IndexAnsiStr1 then
    begin
      inc(iCL142);
    end
    else
    if TADBDataModule(Adb_DM).CL142Coll.Items[iCL142].IndexAnsiStr1 > TADBDataModule(Adb_DM).CL088Coll.Items[iCL088].IndexAnsiStr1 then
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
  CL134Coll :=  TADBDataModule(Adb_DM).CL134Coll;
  CL132Coll :=  TADBDataModule(Adb_DM).CL132Coll;
  PR001Coll :=  TADBDataModule(Adb_DM).PR001Coll;

  CL134Coll.IndexValue(CL134_CL133);
  CL134Coll.SortByIndexValue(CL134_CL133); // сортирам по цл133 (1, 2, 3...)


  for i := 0 to CL132Coll.Count - 1 do
  begin
    Cl132 := CL132Coll.Items[i];
    lstPR001 := Cl132.FListPr001;
    PR001Coll.SortListByActId(lstPR001);// сортирам списъка с дейности по ActId (там е 65-226 за антропометрията)
    iCL134 := 0;
    iPR001 := 0;
    while (iCL134 < TADBDataModule(Adb_DM).CL134Coll.Count) and (iPR001 < lstPR001.Count) do
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
        lstPR001[iPR001].LstCl134.Add(TADBDataModule(Adb_DM).CL134Coll.Items[iCL134]);

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

  TADBDataModule(Adb_DM).PR001Coll.IndexValue(PR001_Activity_ID);
  TADBDataModule(Adb_DM).PR001Coll.SortByIndexAnsiString;

  iPR001 := 0;
  iCL142 := 0;
  while (iPR001 < TADBDataModule(Adb_DM).PR001Coll.Count) and (iCL142 < TADBDataModule(Adb_DM).CL142Coll.Count) do
  begin

    if TADBDataModule(Adb_DM).PR001Coll.Items[iPR001].IndexAnsiStr1 = TADBDataModule(Adb_DM).CL142Coll.Items[iCL142].IndexAnsiStr1 then
    begin
      TADBDataModule(Adb_DM).PR001Coll.Items[iPR001].CL142 := TADBDataModule(Adb_DM).CL142Coll.Items[iCL142];
      begin
        inc(iPR001);
      end

    end
    else
    if TADBDataModule(Adb_DM).PR001Coll.Items[iPR001].IndexAnsiStr1 < TADBDataModule(Adb_DM).CL142Coll.Items[iCL142].IndexAnsiStr1 then
    begin
      inc(iPR001);
    end
    else
    if TADBDataModule(Adb_DM).PR001Coll.Items[iPR001].IndexAnsiStr1 > TADBDataModule(Adb_DM).CL142Coll.Items[iCL142].IndexAnsiStr1 then
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
  TADBDataModule(Adb_DM).CL142Coll.IndexValue(CL142_Key);
  TADBDataModule(Adb_DM).CL142Coll.SortByIndexAnsiString;

  TADBDataModule(Adb_DM).CL144Coll.IndexValue(CL144_cl142);
  TADBDataModule(Adb_DM).CL144Coll.SortByIndexAnsiString;

  iCL142 := 0;
  iCL144 := 0;
  while (iCL142 < TADBDataModule(Adb_DM).CL142Coll.Count) and (iCL144 < TADBDataModule(Adb_DM).CL144Coll.Count) do
  begin
    if trim(TADBDataModule(Adb_DM).CL142Coll.Items[iCL142].IndexAnsiStr1) = trim(TADBDataModule(Adb_DM).CL144Coll.Items[iCL144].IndexAnsiStr1) then
    begin
      TADBDataModule(Adb_DM).CL142Coll.Items[iCL142].FListCL144.Add(TADBDataModule(Adb_DM).CL144Coll.Items[iCL144]);
      inc(iCL144);
    end
    else
    if TADBDataModule(Adb_DM).CL142Coll.Items[iCL142].IndexAnsiStr1 < TADBDataModule(Adb_DM).CL144Coll.Items[iCL144].IndexAnsiStr1 then
    begin
      inc(iCL142);
    end
    else
    if TADBDataModule(Adb_DM).CL142Coll.Items[iCL142].IndexAnsiStr1 > TADBDataModule(Adb_DM).CL144Coll.Items[iCL144].IndexAnsiStr1 then
    begin
      inc(iCL144);
    end
  end;
end;

procedure TProfGraph.FillPr001InCl132;
var
  iCL132, iPR001: Integer;
begin
  TADBDataModule(Adb_DM).CL132Coll.IndexValue(CL132_Key);
  TADBDataModule(Adb_DM).CL132Coll.SortByIndexAnsiString;

  TADBDataModule(Adb_DM).PR001Coll.IndexValue(PR001_CL132);
  TADBDataModule(Adb_DM).PR001Coll.SortByIndexAnsiString;

  iCL132 := 0;
  iPR001 := 0;
  while (iCL132 < TADBDataModule(Adb_DM).CL132Coll.Count) and (iPR001 < TADBDataModule(Adb_DM).PR001Coll.Count) do
  begin
    if TADBDataModule(Adb_DM).CL132Coll.Items[iCL132].IndexAnsiStr1 = TADBDataModule(Adb_DM).PR001Coll.Items[iPR001].IndexAnsiStr1 then
    begin
      if RuleCl132_PR001(TADBDataModule(Adb_DM).CL132Coll.Items[iCL132], TADBDataModule(Adb_DM).PR001Coll.Items[iPR001]) then
      begin
        TADBDataModule(Adb_DM).CL132Coll.Items[iCL132].FListPr001.Add(TADBDataModule(Adb_DM).PR001Coll.Items[iPR001]);
      end;
      inc(iPR001);
    end
    else
    if TADBDataModule(Adb_DM).CL132Coll.Items[iCL132].IndexAnsiStr1 < TADBDataModule(Adb_DM).PR001Coll.Items[iPR001].IndexAnsiStr1 then
    begin
      inc(iCL132);
    end
    else
    if TADBDataModule(Adb_DM).CL132Coll.Items[iCL132].IndexAnsiStr1 > TADBDataModule(Adb_DM).PR001Coll.Items[iPR001].IndexAnsiStr1 then
    begin
      inc(iPR001);
    end
  end;
end;

procedure TProfGraph.GeneratePeriod1();
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
  if TADBDataModule(Adb_DM).AdbNomenNzis = nil then
    TADBDataModule(Adb_DM).OpenADBNomenNzis('NzisNomen.adb');
  CL132Coll := TADBDataModule(Adb_DM).CL132Coll;
  PR001Coll := TADBDataModule(Adb_DM).PR001Coll;
  CL134Coll := TADBDataModule(Adb_DM).CL134Coll;
  patColl := TADBDataModule(Adb_DM).CollPatient;
  pregColl := TADBDataModule(Adb_DM).CollPregled;

  if not isFilled then
  begin
    FillCl144InCL142;
    FillCl088InCL142;
    FillCl142InPr001;
    FillPr001InCl132;
    FillCL134;
    isFilled := True;
    CL132Coll.SortByDataPos;
    PR001Coll.sortByCl134(CL134Coll);
  end;
  Stopwatch := TStopwatch.StartNew;

  patNodes := TADBDataModule(Adb_DM).PatNodesBack;
  startMin := 0;
  currentMin := 0;
  startMax := 0;
  currentMax := 0;
  maxYear := 120;
  StartNzisData := EncodeDate(2021, 01, 01);
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
    if (egn = '0052120125') and (Key = 'V17') then
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
          patNodes.lstGraph.Add(gr);

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
          patNodes.lstGraph.Add(gr);
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
          patNodes.lstGraph.Add(gr);
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
          patNodes.lstGraph.Add(gr);
        end;
      end
      else
      begin
        //assert(repStr = '', Format('План %s, е без крайна дата и няма повторяемост. ', [Key]))
      end;


      if Key <> 'V16' then
      begin
        if  currentMax < maxLive then
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
            patNodes.lstGraph.Add(gr); // няма крайна дата и се повтаря до края на живота
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
          patNodes.lstGraph.Add(gr);
      end;
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  //gr.Cl132.test := ( 'rrrr ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TProfGraph.LoadVtrGraphOutVtr1;
var
  adbDM      : TADBDataModule;
  patNodes   : TPatNodes;
  BufNomen   : Pointer;
  BufMain    : Pointer;
  posCL132   : Cardinal;
  posPR001   : Cardinal;
  posMain    : Cardinal;
  i, j       : Integer;
  gr         : TGraphPeriod132;
  cl132Type  : string;
  cl132Key   : string;
  pregNode   : PVirtualNode;
  FillTree: Boolean;

  function IsPastProc(const AGr: TGraphPeriod132): Boolean;
  begin
    Result := UserDate > AGr.endDate;
  end;

  function IsFutureProc(const AGr: TGraphPeriod132): Boolean;
  begin
    Result := UserDate < AGr.startDate;
  end;

  function IsCurrent(const AGr: TGraphPeriod132): Boolean;
  begin
    Result := (UserDate >= AGr.startDate) and (UserDate <= AGr.endDate);
  end;

  /// Проверява има ли преглед в периода на плана и връща нода
  function HasPregledInPeriod(const AGr: TGraphPeriod132;
    out APregNode: PVirtualNode): Boolean;
  var
    k         : Integer;
    dataPreg  : PAspRec;
    prDate    : TDate;
  begin
    Result := False;
    APregNode := nil;

    for k := 0 to patNodes.pregs.Count - 1 do
    begin
      dataPreg := PAspRec(PByte(patNodes.pregs[k]) + lenNode);
      prDate   := adbDM.CollPregled.getDateMap(
                    dataPreg.DataPos,
                    word(PregledNew_START_DATE)
                  );
      if (prDate >= AGr.startDate) and (prDate <= AGr.endDate) then
      begin
        Result   := True;
        APregNode := patNodes.pregs[k];
        Exit;
      end;
    end;
  end;

  /// За CL132 тип „изследвания“ – обвързва изследванията с PR001
  procedure AttachExamAnalysesToPeriod(var AGr: TGraphPeriod132);
  var
    k, m        : Integer;
    NodeExam    : PVirtualNode;
    dataExam    : PAspRec;
    examDate    : TDate;
    cl22Exam    : string;
    cl22Pr1     : string;
    pr001       : TRealPR001Item;
  begin
    // Нулираме старите връзки за всеки PR001
    for m := 0 to AGr.Cl132.FListPr001.Count - 1 do
      AGr.Cl132.FListPr001[m].FExamAnalPos := 0;
    AGr.Cl132.FExamAnalPos := 0;

    for k := 0 to PatNodes.ExamAnals.Count - 1 do
    begin
      NodeExam := PatNodes.ExamAnals[k];
      dataExam := PAspRec(PByte(NodeExam) + lenNode);

      // дата на изследването от главния ADB
      examDate := adbDM.CollExamAnal.getDateMap(
                    dataExam.DataPos,
                    word(ExamAnalysis_DATA)
                  );

      // извън периода – не ни интересува
      if (examDate < AGr.startDate) or (examDate > AGr.endDate) then
        Continue;

      // !!! тук беше BUG – ползвано беше getDateMap вместо getAnsiStringMap
      cl22Exam := adbDM.CollExamAnal.getAnsiStringMap(
                    dataExam.DataPos,
                    word(ExamAnalysis_NZIS_CODE_CL22)
                  );

      // търсим съответствие по CL22 между PR001 и самото изследване
      for m := 0 to AGr.Cl132.FListPr001.Count - 1 do
      begin
        pr001 := AGr.Cl132.FListPr001[m];

        cl22Pr1 := pr001.getAnsiStringMap(
                      BufNomen,
                      adbDM.PR001Coll.posData,
                      word(PR001_Activity_ID)
                   );

        if cl22Pr1 = cl22Exam then
        begin
          // за конкретния PR001 – запомняме DataPos
          if pr001.FExamAnalPos = 0 then
            pr001.FExamAnalPos := dataExam.DataPos;

          // и общо за целия CL132 (поне едно изследване в периода)
          if AGr.Cl132.FExamAnalPos = 0 then
            AGr.Cl132.FExamAnalPos := dataExam.DataPos;

          // НЕ правим Break; – едно изследване може логически да покрие
          // няколко PR001 (ако в НЗИС така са го свързали)
        end;
      end;
    end;
  end;

  // ВРЕМЕННО: всеки преглед в периода се счита за изпълнение на плана.
  // По-късно тук ще филтрираме по вид преглед, МКБ, флагове и т.н.
  function PregledCountsForProf_All(const AGr: TGraphPeriod132;
    APregDataPos: Cardinal): Boolean;
  begin
    // Засега абсолютно всяко посещение "важи"
    Result := false;
  end;

var
  isPast, isFuture, isCurr : Boolean;
  dataPreg: PAspRec;
  prStartDate, AEndDate: TDate;
  IsPregForPerform: Boolean;
  dataNast_DataPos: Integer;
  // за дървото
  vPat, vNast, vGr: PAspRec;
  dataPat, dataNast, dataGr: PAspRec;
begin
  adbDM := TADBDataModule(Adb_DM);

  if adbDM.AdbNomenNzis = nil then
    adbDM.OpenADBNomenNzis('NzisNomen.adb');

  BufNomen := adbDM.AdbNomenNzis.Buf;
  BufMain  := adbDM.AdbMain.Buf;
  posCL132 := adbDM.CL132Coll.posData;
  posPR001 := adbDM.PR001Coll.posData;
  posMain  := adbDM.AdbMain.FPosData;

  patNodes := adbDM.PatNodesBack;

  // по подразбиране – нищо за правене
  patNodes.NoteProf          := 'Няма неизвършени дейности по профилактиката.';
  IsPregForPerform := False;
  dataNast_DataPos := MaxInt;
  patNodes.CurrentGraphIndex := -1;
  patNodes.ListCurrentProf.Clear;

  //да обходим всички периоди за пациента
  for i := 0 to patNodes.lstGraph.Count - 1 do
  begin
    gr := patNodes.lstGraph[i];

    // runtime-състояние за този CL132 – чистим всякакви стари връзки
    gr.Cl132.FPregNode := nil;

    isPast  := IsPastProc(gr);
    isFuture:= IsFutureProc(gr);
    isCurr  := IsCurrent(gr);

    // при нужда може да върнем и минали/бъдещи в други списъци;
    // засега работим само с текущите
    if isPast and (not FVisibleMinali) then
      Continue;
    if isFuture and (not FVisibleBudeshti) then
      Continue;
    if not isCurr then
      Continue;

    // всички текущи планове се пазят в ListCurrentProf
    patNodes.ListCurrentProf.Add(gr);


    cl132Type := gr.Cl132.getAnsiStringMap(
                   BufNomen,
                   posCL132,
                   word(CL132_cl136)
                 );
    if cl132Type = '' then
      Continue;

    cl132Key := gr.Cl132.getAnsiStringMap(
                  BufNomen,
                  posCL132,
                  word(CL132_Key)
                );

    case cl132Type[1] of
      // =========================
      // 1 – ПРЕГЛЕД
      // =========================
      '1': // ако е тип преглед
      begin
        gr.Cl132.FPregNode := nil; // зануляваме
        Cl132Key := gr.Cl132.getAnsiStringMap(
                      BufNomen,
                      TADBDataModule(Adb_DM).CL132Coll.posData,
                      word(CL132_Key)
                    );

        for j := 0 to PatNodes.pregs.Count - 1 do
        begin
          dataPreg := PAspRec(PByte(PatNodes.pregs[j]) + lenNode);
          prStartDate := adbDM.CollPregled.getDateMap(
                           dataPreg.DataPos,
                           word(PregledNew_START_DATE)
                         );

          // само по период – не гледаме нищо друго
          if (prStartDate < gr.startDate) or (prStartDate > gr.endDate) then
            Continue;

          // ТУК е мястото за бъдещия филтър; засега всичко минава
          if PregledCountsForProf_All(gr, dataPreg.DataPos) then
          begin
            gr.Cl132.FPregNode := PatNodes.pregs[j];
            PatNodes.CurrentGraphIndex := i;
            Break; // намерили сме един преглед в периода – приемаме, че плана е изпълнен
          end;
        end;

        // ако FPregNode е останал nil => за този период НЯМА преглед,
        // и съответно ще тръгнем по логиката "има неизвършени дейности"
        if gr.Cl132.FPregNode = nil then
        begin
          // тук си остава твоята логика с NzisPregNotPreg / IsPregForPerform /
          // NoteProf / ListCurrentProf – тя вече ще се задейства винаги
          // когато НЯМА НИТО ЕДИН преглед в периода
          if NzisPregNotPreg.Contains('|' + Cl132Key + '|') then
          begin
            PatNodes.ListCurrentProf.Add(gr);
          end
          else
          begin
            if IsPregForPerform then
            begin
              PatNodes.ListCurrentProf.Add(gr);
            end
            else
            begin
              IsPregForPerform := true;
              AEndDate := gr.endDate;
              if dataNast_DataPos = MaxInt then
              begin
                dataNast_DataPos := i;
                PatNodes.NoteProf :=
                  gr.Cl132.getAnsiStringMap(
                    BufNomen,
                    TADBDataModule(Adb_DM).CL132Coll.posData,
                    word(CL132_Description)
                  );
                PatNodes.CurrentGraphIndex := i;
                PatNodes.ListCurrentProf.Add(gr);
              end
              else
              begin
                ShowMessage('Има повече от един преглед');
              end;
            end;
          end;
        end
        else
        begin
          // намерен е поне един преглед в периода -> плана за прегледа се счита за покрит
          AEndDate := gr.endDate; // както си беше
        end;
      end;


      // =========================
      // 2 – ИЗСЛЕДВАНИЯ
      // =========================
      '2': // изследвания
      begin
        PatNodes.ListCurrentProf.Add(gr);
        AttachExamAnalysesToPeriod(gr);
      end;

      // =========================
      // 3 – ИМУНИЗАЦИИ
      // =========================
      '3':
      begin
        // засега само отбелязваме, че има текущ период с имунизации;
        // по-нататък можем да го вържем с e-immunization NRN
      end;
    end;
  end;

  // ако не е избран нито един неизвършен прегледен план,
  // NoteProf остава: „Няма неизвършени дейности по профилактиката.“
end;




function TProfGraph.RuleCl132_PR001(cl132, pr001: TObject): boolean;
var
  pr1Nomen: string;
  BufNomen: Pointer;
begin
  BufNomen := TADBDataModule(Adb_DM).AdbNomenNzis.Buf;
  Result := True;
  pr1Nomen := TRealPR001Item(pr001).getAnsiStringMap(BufNomen, TADBDataModule(Adb_DM).PR001Coll.posData, word(PR001_Nomenclature));
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

end.
