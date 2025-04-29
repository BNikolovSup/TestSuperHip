unit ProfGraph;   //d:\ няма 01.01.2020 current   c5

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
    //preg: TObject;
    //Pat: TRealPatientNewItem;
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
    CL132Coll: TRealCL132Coll;
    CL050Coll: TCL050Coll;
    CL006Coll: TRealCL006Coll;
    CL022Coll: TCL022Coll;
    CL037Coll: TCL037Coll;
    CL038Coll: TCL038Coll;
    CL088Coll: TRealCL088Coll;
    CL134Coll: TRealCL134Coll;
    CL139Coll: TCL139Coll;
    CL142Coll: TRealCL142Coll;
    CL144Coll: TRealCL144Coll;


    PR001Coll: TRealPR001Coll;
    BufNomen: Pointer;
    BufADB: Pointer;
    posDataADB: cardinal;
    vtrGraph: TVirtualStringTreeHipp;

    collPat: TCollection;
    Adb_DM: TObject;
    //NzisPregNotPreg: string; // прегледи според нзис, ама не са (Божинката)
//    RL090: string;

    constructor create;
    procedure GeneratePeriod(Apat: TObject);
    procedure GeneratePeriodOld(Apat: TObject);
    function RuleCl132_PR001(cl132, pr001: TObject): Boolean;

    procedure LoadVtrGraph(Apat: TObject; patIndex: Integer);
    property CurrDate: TDate read FCurrDate write FCurrDate;
    property SexMale: Boolean read FSexMale write FSexMale;
    property VisibleMinali: Boolean read FVisibleMinali write FVisibleMinali;
    property VisibleBudeshti: Boolean read FVisibleBudeshti write FVisibleBudeshti;
  end;

implementation
uses
  RealObj.RealHipp,
  SuperHipp,
  ADB_DataUnit;

{ TProfGraph }

constructor TProfGraph.create;
begin
  inherited create;
  isFilled := False;
  FVisibleBudeshti := true;
  FVisibleMinali := true;
  FSexMale := True;
  FCurrDate := Date;
  
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
begin
  CL050Coll.IndexValue(CL050_Key);
  CL050Coll.SortByIndexValue(CL050_Key);

  PR001Coll.IndexValue(PR001_Activity_ID);
  PR001Coll.SortByIndexValue(PR001_Activity_ID);

  iCL050 := 0;
  iPR001 := 0;
  while (iCL050 < CL050Coll.Count) and (iPR001 < PR001Coll.Count) do
  begin
    test := PR001Coll.Items[iPR001].getAnsiStringMap(BufNomen, PR001Coll.posData, word(PR001_Nomenclature));
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
begin
  CL050Coll.IndexValue(CL050_Key);
  CL050Coll.SortByIndexValue(CL050_Key);

  PR001Coll.IndexValue(PR001_Activity_ID);
  PR001Coll.SortByIndexValue(PR001_Activity_ID);

  iCL050 := 0;
  iPR001 := 0;
  while (iCL050 < CL050Coll.Count) and (iPR001 < PR001Coll.Count) do
  begin
    test := PR001Coll.Items[iPR001].getAnsiStringMap(BufNomen, PR001Coll.posData, word(PR001_Nomenclature));
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
  CL142Coll.IndexValue(CL142_Key);
  CL142Coll.SortByIndexAnsiString;

  CL088Coll.IndexValue(CL088_cl142);
  CL088Coll.SortByIndexAnsiString;

  iCL142 := 0;
  iCL088 := 0;
  while (iCL142 < CL142Coll.Count) and (iCL088 < CL088Coll.Count) do
  begin
    if trim(CL142Coll.Items[iCL142].IndexAnsiStr1) = trim(CL088Coll.Items[iCL088].IndexAnsiStr1) then
    begin
      CL142Coll.Items[iCL142].FListCL088.Add(CL088Coll.Items[iCL088]);
      inc(iCL088);
    end
    else
    if CL142Coll.Items[iCL142].IndexAnsiStr1 < CL088Coll.Items[iCL088].IndexAnsiStr1 then
    begin
      inc(iCL142);
    end
    else
    if CL142Coll.Items[iCL142].IndexAnsiStr1 > CL088Coll.Items[iCL088].IndexAnsiStr1 then
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
begin
  CL134Coll.IndexValue(CL134_CL133);
  CL134Coll.SortByIndexValue(CL134_CL133); // сортирам по цл133 (1, 2, 3...)


  for i := 0 to CL132Coll.Count - 1 do
  begin
    Cl132 := CL132Coll.Items[i];
    lstPR001 := Cl132.FListPr001;
    PR001Coll.SortListByActId(lstPR001);// сортирам списъка с дейности по ActId (там е 65-226 за антропометрията)
    iCL134 := 0;
    iPR001 := 0;
    while (iCL134 < CL134Coll.Count) and (iPR001 < lstPR001.Count) do
    begin
      test := lstPR001[iPR001].getAnsiStringMap(BufNomen, PR001Coll.posData, word(PR001_Nomenclature));
      if test <> 'CL133' then
      begin
        inc(iPR001);
        continue;
      end;
      //if test = 'CL050'  then
//      begin
//        test := 'CL050';
//      end;

      if CL134Coll.Items[iCL134].IndexAnsiStr1 = lstPR001[iPR001].getAnsiStringMap(BufNomen, PR001Coll.posData, word(PR001_Activity_ID)) then
      begin
        //if Cl132. then

        cl133Str := CL134Coll.Items[iCL134].getAnsiStringMap(BufNomen, PR001Coll.posData, word(CL134_CL133));
        lstPR001[iPR001].CL133 := TCL133(StrToInt(cl133Str));
        lstPR001[iPR001].LstCl134.Add(CL134Coll.Items[iCL134]);

        inc(iCL134);
      end
      else
      if CL134Coll.Items[iCL134].IndexAnsiStr1 < lstPR001[iPR001].getAnsiStringMap(BufNomen, PR001Coll.posData, word(PR001_Activity_ID)) then
      begin
        inc(iCL134);
      end
      else
      if CL134Coll.Items[iCL134].IndexAnsiStr1 > lstPR001[iPR001].getAnsiStringMap(BufNomen, PR001Coll.posData, word(PR001_Activity_ID)) then
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

  PR001Coll.IndexValue(PR001_Activity_ID);
  PR001Coll.SortByIndexAnsiString;

  iPR001 := 0;
  iCL142 := 0;
  while (iPR001 < PR001Coll.Count) and (iCL142 < CL142Coll.Count) do
  begin

    if PR001Coll.Items[iPR001].IndexAnsiStr1 = CL142Coll.Items[iCL142].IndexAnsiStr1 then
    begin
      PR001Coll.Items[iPR001].CL142 := CL142Coll.Items[iCL142];
      begin
        inc(iPR001);
      end

    end
    else
    if PR001Coll.Items[iPR001].IndexAnsiStr1 < CL142Coll.Items[iCL142].IndexAnsiStr1 then
    begin
      inc(iPR001);
    end
    else
    if PR001Coll.Items[iPR001].IndexAnsiStr1 > CL142Coll.Items[iCL142].IndexAnsiStr1 then
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
  CL142Coll.IndexValue(CL142_Key);
  CL142Coll.SortByIndexAnsiString;

  CL144Coll.IndexValue(CL144_cl142);
  CL144Coll.SortByIndexAnsiString;

  iCL142 := 0;
  iCL144 := 0;
  while (iCL142 < CL142Coll.Count) and (iCL144 < CL144Coll.Count) do
  begin
    if trim(CL142Coll.Items[iCL142].IndexAnsiStr1) = trim(CL144Coll.Items[iCL144].IndexAnsiStr1) then
    begin
      CL142Coll.Items[iCL142].FListCL144.Add(CL144Coll.Items[iCL144]);
      inc(iCL144);
    end
    else
    if CL142Coll.Items[iCL142].IndexAnsiStr1 < CL144Coll.Items[iCL144].IndexAnsiStr1 then
    begin
      inc(iCL142);
    end
    else
    if CL142Coll.Items[iCL142].IndexAnsiStr1 > CL144Coll.Items[iCL144].IndexAnsiStr1 then
    begin
      inc(iCL144);
    end
  end;
end;

procedure TProfGraph.FillPr001InCl132;
var
  iCL132, iPR001: Integer;
begin
  CL132Coll.IndexValue(CL132_Key);
  CL132Coll.SortByIndexAnsiString;

  PR001Coll.IndexValue(PR001_CL132);
  PR001Coll.SortByIndexAnsiString;

  iCL132 := 0;
  iPR001 := 0;
  while (iCL132 < CL132Coll.Count) and (iPR001 < PR001Coll.Count) do
  begin
    if CL132Coll.Items[iCL132].IndexAnsiStr1 = PR001Coll.Items[iPR001].IndexAnsiStr1 then
    begin
      if RuleCl132_PR001(CL132Coll.Items[iCL132], PR001Coll.Items[iPR001]) then
      begin
        CL132Coll.Items[iCL132].FListPr001.Add(PR001Coll.Items[iPR001]);
      end;
      inc(iPR001);
    end
    else
    if CL132Coll.Items[iCL132].IndexAnsiStr1 < PR001Coll.Items[iPR001].IndexAnsiStr1 then
    begin
      inc(iCL132);
    end
    else
    if CL132Coll.Items[iCL132].IndexAnsiStr1 > PR001Coll.Items[iPR001].IndexAnsiStr1 then
    begin
      inc(iPR001);
    end
  end;
end;

procedure TProfGraph.GeneratePeriod(Apat: TObject);
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
  pat: TRealPatientNewItem;
  preg: TRealPregledNewItem;
  pr001, pr001Temp: TRealPR001Item;

begin
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

  pat := TRealPatientNewItem(Apat);
  startMin := 0;
  currentMin := 0;
  startMax := 0;
  currentMax := 0;
  maxYear := 120;
  StartNzisData := EncodeDate(1821, 01, 01);
  BrthDate := pat.getDateMap(BufADB, posDataADB, word(PatientNew_BIRTH_DATE));
  maxLive := DatStrToDays(BrthDate, '120 year');
  for i := 0 to CL132Coll.Count - 1 do
  begin
    cl132i := CL132Coll.Items[i];
    if FSexMale then
    begin
      if (cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Gender))[1]  = 'f') then
      begin
        //Caption := 'ffff';
        Continue;
      end;
    end
    else
    begin
      if (cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Gender))[1]  = 'm') then
      begin
        //Caption := 'mmmm';
        Continue;
      end;
    end;

    datStr := cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Age)); //измислили са датите да са в някаква странна форма
    Graph :=  cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Description));
    Key :=  cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Key));

    pr001 := cl132i.FListPr001[0];  //zzzzzzzzzzzzzz  защо па само първото
    egn := pat.getAnsiStringMap(BufADB, posDataADB, word(PatientNew_EGN));
    if (egn = '0052120125') and (Key = 'V17') then
      egn := '0052120125';  // за тестови цели. спирам си тук да видя какво става при такаова нещо

    currentMin := cl132i.StartDate;
    if currentMin = 0 then
    begin
      currentMin := DatStrToDays(CurrDate, datStr);
    end;

    if cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Event_Trigger))[1] = 'п' then  //при настъпване на 01.01. в годината, на която навършва възрастта
    begin
      currentMin := StartOfAYear(YearOf(currentMin));
    end;
    datStr := cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Max_Age));
    if (datStr <> '') and (Key <> 'V16') then  //  има крайна дата и не е V16. V16  е различно от другите, защото може да се направи във всеки момент от 17 до 25-тата година
    begin
      repStr := cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Repeat_Every_x_Years));
      if repStr <> '' then  // има повторение
      begin
        rep := StrToInt(repStr);
        if cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_CL136_Mapping)) <> '3' then  // да не е ваксина.
        begin
          currentMax := endOfAYear(YearOf(IncYear((currentMin - 1), rep)));
        end
        else
        begin
          currentMax := endOfAYear(YearOf(IncYear((currentMin - 1), 1))); // за ваксините, без V16  правилото е "само в годината на настъпване.."
        end;
        maxYear := DatStrToDays(CurrDate, datStr)- 1;

        gr.startDate := currentMin;
        gr.endDate := currentMax;
        gr.repNumber := 0;
        gr.Cl132 := cl132i;
        if gr.startDate >= StartNzisData then
          pat.lstGraph.Add(gr);

        while currentMax < maxYear do // до максималните години по номенклатурата JM1
        begin
          currentMin := IncYear(currentMin, rep);
          currentMax := IncYear(currentMax, rep);
          gr.startDate := currentMin;
          gr.endDate := currentMax;
          gr.repNumber := gr.repNumber + 1;

          if cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Event_Trigger))[1] = 'п' then
          begin
            currentMax := EndOfAYear(YearOf(currentMax - 1) );
          end;

          gr.startDate := currentMin;
          gr.endDate := currentMax;

          gr.Cl132 := cl132i;
            if gr.startDate >= StartNzisData then
          pat.lstGraph.Add(gr);
        end;

      end
      else  // не се повтарят
      begin
        currentMax := DatStrToDays(BrthDate, datStr);
        if cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Event_Trigger))[1] = 'п' then
        begin
          currentMax := EndOfAYear(YearOf(currentMax - 1) );
          if Key = 'J17' then
          begin
            currentMax := currentMax + (BrthDate - StartOfTheYear(BrthDate));
          end;
        end;

        gr.startDate := currentMin;
        gr.endDate := currentMax;
        gr.repNumber := -1;
        gr.Cl132 := cl132i;
        if gr.startDate >= StartNzisData  then
          pat.lstGraph.Add(gr);
      end;
    end
    else // няма крайна дата, но може да има, а да е ваксина V16
    begin
      repStr := cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Repeat_Every_x_Years));
      if repStr <> '' then
      begin
        rep := StrToInt(repStr);
        if cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_CL136_Mapping)) <> '3' then  // да не е ваксина.
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
        gr.endDate := currentMax;
        gr.Cl132 := cl132i;
        if gr.startDate >= StartNzisData then
        begin
          if (Key = 'A1') and (gr.repNumber = 0) then
          begin
            gr.startDate := gr.startDate + (BrthDate - StartOfTheYear(BrthDate));
          end;
          pat.lstGraph.Add(gr);
        end;
      end
      else
      begin
        //assert(repStr = '', Format('План %s, е без крайна дата и няма повторяемост. ', [Key]))
      end;
      

      if Key <> 'V16' then
      begin
        while currentMax < maxLive do
        begin
          currentMin := IncYear(currentMin, rep);
          currentMax := IncYear(currentMax, rep);
          gr.startDate := currentMin;
          gr.endDate := currentMax;
          gr.repNumber := gr.repNumber + 1;
          case cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_CL136_Mapping))[1] of
            '1': // преглед
            begin
              for k := 0 to pat.FPregledi.Count - 1 do
              begin
                preg := pat.FPregledi[k];
                datTemp := preg.getDateMap(bufADB, posDataADB, word(PregledNew_START_DATE));
                if (datTemp >= gr.startDate) and (datTemp <= gr.endDate)  then
                begin
                  if preg.Cl132 = nil then
                  begin
                    preg.Cl132 := cl132i;
                    break;
                  end;
                end;
              end;
            end;
          end;
          gr.Cl132 := cl132i;
          if gr.startDate >= StartNzisData then
          begin
            pat.lstGraph.Add(gr); // няма крайна дата и се повтаря до края на живота
          end;
        end;
      end
      else
      begin
        currentMax := DatStrToDays(BrthDate, '24 years');
        if cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Event_Trigger))[1] = 'п' then
        begin
          currentMax := EndOfAYear(YearOf(currentMax - 1) );
        end;

        gr.startDate := currentMin;
        gr.endDate := currentMax;
        gr.repNumber := -1;
        gr.Cl132 := cl132i;
        if gr.startDate >= StartNzisData  then
          pat.lstGraph.Add(gr);
      end;
    end;
  end;
  Elapsed := Stopwatch.Elapsed;
  gr.Cl132.test := ( 'rrrr ' + FloatToStr(Elapsed.TotalMilliseconds));
end;

procedure TProfGraph.GeneratePeriodOld(Apat: TObject);
var
  i, j, k, m: Integer;
  cl132i: TRealCL132Item;

  datStr, repStr: string;
  datTemp: TDate;
  startMin, startMax, currentMin, currentMax: TDate;
  rep: Integer;
  maxLive, maxYear: TDate;
  Graph, Key, egn: string;
  gr: TGraphPeriod132;
  pat: TRealPatientNewItem;
  preg: TRealPregledNewItem;
  pr001, pr001Temp: TRealPR001Item;



begin
  if not isFilled then
  begin
    //FillCl050;
    FillCl144InCL142;
    FillCl088InCL142;
    FillCl142InPr001;
    FillPr001InCl132;
    FillCL134;
    isFilled := True;
    CL132Coll.SortByDataPos;
    PR001Coll.sortByCl134(CL134Coll);
  end;

  pat := TRealPatientNewItem(Apat);
  startMin := 0;
  currentMin := 0;
  startMax := 0;
  currentMax := 0;
  maxYear := 120;
  //CurrDate := dtp1.Date; //EncodeDate(2024, 02, 24); //24.07.1985
  maxLive := DatStrToDays(CurrDate, '120 year');

  //examAnal := TRealExamAnalysisItem.Create(nil);

  for i := 0 to CL132Coll.Count - 1 do
  begin
    cl132i := CL132Coll.Items[i];
    if FSexMale then
    begin
      if (cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Gender))[1]  = 'f') then
      begin
        //Caption := 'ffff';
        Continue;
      end;
    end
    else
    begin
      if (cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Gender))[1]  = 'm') then
      begin
        //Caption := 'mmmm';
        Continue;
      end;
    end;

    datStr := cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Age));
    Graph :=  cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Description));

    Key :=  cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Key));

    pr001 := cl132i.FListPr001[0];
   // egn := pr001.getAnsiStringMap(BufNomen, PR001Coll.posData, word(PR001_Description));
    egn := pat.getAnsiStringMap(BufADB, posDataADB, word(PatientNew_EGN));
    if (egn = '0143070030') and (Key = 'V16') then
      egn := '0143070030';

    currentMin := cl132i.StartDate;
    if currentMin = 0 then
    begin
      currentMin := DatStrToDays(CurrDate, datStr);
    end;

    if cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Event_Trigger))[1] = 'п' then
    begin
      currentMin := StartOfAYear(YearOf(currentMin));
    end;
    datStr := cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Max_Age));
    if (datStr <> '') and (datStr <> 'Recurring +1Y') then  //  има крайна дата
    begin
      repStr := cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Repeat_Every_x_Years));
      if repStr <> '' then
      begin
        rep := StrToInt(repStr);
        currentMax := endOfAYear(YearOf(IncYear((currentMin - rep), 1)));
        maxYear := DatStrToDays(CurrDate, datStr)- 1;
        while currentMax < maxYear do // до максималните години по номенклатурата
        begin
          currentMin := IncYear(currentMin, rep);
          currentMax := IncYear(currentMax, rep);
          gr.startDate := currentMin;
          gr.endDate := currentMax;
          gr.repNumber := 0;
          //case cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_CL136_Mapping))[1] of
//            '1': // преглед
//            begin
//              for k := 0 to pat.FPregledi.Count - 1 do
//              begin
//                preg := pat.FPregledi[k];
//                datTemp := preg.getDateMap(bufADB, posDataADB, word(PregledNew_START_DATE));
//                if (datTemp >= gr.startDate) and (datTemp <= gr.endDate)  then
//                begin
//                  if preg.Cl132 = nil then
//                  begin
//                    preg.Cl132 := cl132i;
//                    break;
//                  end;
//                end;
//              end;
//            end;
//
//          end;
          if cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Event_Trigger))[1] = 'п' then
          begin
            currentMax := EndOfAYear(YearOf(currentMax - 1) );
          end;

          gr.startDate := currentMin;
          gr.endDate := currentMax;

          //if not NzisPregNotPreg.Contains(Key) then
//          begin
//            if (cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_CL136_Mapping))[1] = '1') then
//            begin
//              for k := 0 to pat.FPregledi.Count - 1 do
//              begin
//                preg := pat.FPregledi[k];
//                datTemp := preg.getDateMap(bufADB, posDataADB, word(PregledNew_START_DATE));
//                if (datTemp >= gr.startDate) and (datTemp <= gr.endDate)  then
//                begin
//                  if preg.Cl132 = nil then
//                  begin
//                    preg.Cl132 := cl132i;
//                    break;
//                  end;
//                end;
//              end;
//            end;
//          end;
          gr.Cl132 := cl132i;
          //if gr.startDate > EncodeDate(2021, 01, 01) then
          pat.lstGraph.Add(gr);
        end;

      end  // ne se powtarqt
      else
      begin
        currentMax := DatStrToDays(CurrDate, datStr)- 1;
        if cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Event_Trigger))[1] = 'п' then
        begin
          currentMax := EndOfAYear(YearOf(currentMax - 1) );
        end;

        gr.startDate := currentMin;
        gr.endDate := currentMax;
        gr.repNumber := -1;
        if not NzisPregNotPreg.Contains('|' + Key + '|') then
        begin
          //if (cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_CL136_Mapping))[1] = '1') then
//          begin
//            for k := 0 to pat.FPregledi.Count - 1 do
//            begin
//              preg := pat.FPregledi[k];
//              datTemp := preg.getDateMap(bufADB, posDataADB, word(PregledNew_START_DATE));
//              if (datTemp >= gr.startDate) and (datTemp <= gr.endDate)  then
//              begin
//                if preg.Cl132 = nil then
//                begin
//                  preg.Cl132 := cl132i;
//                  break;
//                end;
//              end;
//            end;
//          end;
        end;
        gr.Cl132 := cl132i;
        //if gr.startDate > EncodeDate(2021, 01, 01) then
        pat.lstGraph.Add(gr);
      end;





      //mmoDDL.Lines.Add(key + '  ' + DateToStr(currentMin) + ' - ' + DateToStr(currentMax) + ' : ' + Graph);
    end
    else // няма крайна дата
    begin
      repStr := cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Repeat_Every_x_Years));
      if repStr <> '' then
      begin
        rep := StrToInt(repStr);
      end
      else
      begin
        rep := 10;
      end;
      currentMax := endOfAYear(YearOf(IncYear((currentMin - rep), 1))); //zzzzz

      gr.startDate := currentMin;
      gr.endDate := currentMax;
      //if cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_CL136_Mapping))[1] = '1' then
      //for k := 0 to pat.FPregledi.Count - 1 do
//      begin
//        preg := pat.FPregledi[k];
//        datTemp := preg.getDateMap(bufADB, posDataADB, word(PregledNew_START_DATE));
//        if (datTemp >= gr.startDate) and (datTemp <= gr.endDate)  then
//        begin
//          if preg.Cl132 = nil then
//          begin
//            preg.Cl132 := cl132i;
//            break;
//          end;
//        end;
//      end;
      gr.Cl132 := cl132i;
      //gr.startDate
//      gr.endDate
     //if gr.startDate > EncodeDate(2021, 01, 01) then
        pat.lstGraph.Add(gr);
      //mmoDDL.Lines.Add(key + '  ' + DateToStr(currentMin) + ' - ' + DateToStr(currentMax) + ' : ' + Graph);
      while currentMax < maxLive do
      begin
        currentMin := IncYear(currentMin, rep);
        currentMax := IncYear(currentMax, rep);
        //currentMax := endOfAYear(YearOf(currentMin));
        gr.startDate := currentMin;
        gr.endDate := currentMax;
        gr.repNumber := gr.repNumber + 1;
       // if cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_CL136_Mapping))[1] = '1' then //
        case cl132i.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_CL136_Mapping))[1] of
          '1': // преглед
          begin
            for k := 0 to pat.FPregledi.Count - 1 do
            begin
              preg := pat.FPregledi[k];
              datTemp := preg.getDateMap(bufADB, posDataADB, word(PregledNew_START_DATE));
              if (datTemp >= gr.startDate) and (datTemp <= gr.endDate)  then
              begin
                if preg.Cl132 = nil then
                begin
                  preg.Cl132 := cl132i;
                  break;
                end;
              end;
            end;
          end;
          //'2': // изследване
//          begin
//            for k := 0 to adbDM.PatNodes.ExamAnals.Count - 1 do
//            begin
//              NodeExamAnal := adbDM.PatNodes.ExamAnals[k];
//              dataExamAnal := pointer(PByte(NodeExamAnal) + lenNode);
//              examAnal.DataPos := dataExamAnal.DataPos;
//              cl22ExamAnal := examAnal.getAnsiStringMap(bufADB, posDataADB, word(ExamAnalysis_NZIS_CODE_CL22));
//              datTemp := examAnal.getDateMap(bufADB, posDataADB, word(ExamAnalysis_DATA));
//              for m := 0 to cl132i.FListPr001.Count - 1 do
//              begin
//                cl22Pr1 := cl132i.FListPr001[m].getAnsiStringMap(BufNomen, PR001Coll.posData, word(PR001_Activity_ID));
//
//                if (datTemp >= gr.startDate) and (datTemp <= gr.endDate)  then
//                begin
//
//
//                  if cl22Pr1 = cl22ExamAnal then
//                  begin
//                    if examAnal.Cl132 = nil then
//                    begin
//                      examAnal.Cl132 := cl132i;
//                    end;
//                  end;
//
//                end;
//              end;
//
//            end;
//          end;
        end;

        gr.Cl132 := cl132i;
        //if gr.startDate > EncodeDate(2021, 01, 01) then
        pat.lstGraph.Add(gr); // няма крайна дата и се повтаря до края на живота
        //mmoDDL.Lines.Add(key + '  ' + DateToStr(currentMin) + ' - ' + DateToStr(currentMax) + ' : ' + Graph);
      end;
    end;

  end;
  //Elapsed := Stopwatch.Elapsed;
  //mmoDDL.Lines.Add( 'genGraph ' + FloatToStr(Elapsed.TotalMilliseconds));
  //mmoDDL.Lines.EndUpdate;
end;

procedure TProfGraph.LoadVtrGraph(Apat: TObject; patIndex: Integer);
var
  i, j, k, m: Integer;
  gr: TGraphPeriod132;
  examAnal: TRealExamAnalysisItem;
  vPat, vMinali, vNast, vBudeshti, vCl132, vPr001, vCL134, vCL088, vRun: PVirtualNode;
  data, dataNast: PAspRec;
  cl134: TCL134Item;
  Cl132: TRealCl132Item;
  pr001: TRealPR001Item;
  Cl088: TRealCl088Item;
  test, note, Field_cl133: string;
  pat: TRealPatientNewItem;
  Rule88, ACL088_key, Cl132Key: string;
  AEndDate, datTemp: TDate;
  adbDM: TADBDataModule;

  prStartDate: TDate;
  IsPregForPerform: boolean;

  dataExamAnal: PAspRec;
  NodeExamAnal: PVirtualNode;
  cl22Pr1, cl22ExamAnal: string;
  PatNodes: TPatNodes;
begin
  adbDM := TADBDataModule(Adb_DM);


  vtrGraph.BeginUpdate;
  IsPregForPerform := False;
  pat := TRealPatientNewItem(Apat);
  PatNodes := adbDM.GetPatNodes(pat.FNode);
  pat.NoteProf := 'Няма неизвършени дейности по профилактиката.';
 // vtrGraph.DeleteChildren(vtrGraph.RootNode.FirstChild, true);
  vPat := vtrGraph.AddChild(vtrGraph.RootNode.FirstChild, nil);
  data := vtrGraph.GetNodeData(vPat);
  data.DataPos := pat.DataPos;
  data.index := patIndex;
  data.vid := vvPatient;

  vNast := vtrGraph.AddChild(vPat, nil);

  dataNast := vtrGraph.GetNodeData(vNast);
  dataNast.index := -2;
  dataNast.DataPos := MaxInt;

  if FVisibleMinali then
  begin
    vMinali := vtrGraph.AddChild(vPat, nil);
    data := vtrGraph.GetNodeData(vMinali);
    data.index := -1;
  end;

  if FVisibleBudeshti then
  begin
    vBudeshti := vtrGraph.AddChild(vPat, nil);
    data := vtrGraph.GetNodeData(vBudeshti);
    data.index := -3;
  end;
  pat.ListCurrentProf.Clear;
  for i := 0 to pat.lstGraph.Count - 1 do
  begin

    gr := pat.lstGraph[i];
    FreeAndNil(gr.Cl132.FExamAnal);
    for j := 0 to gr.Cl132.FListPr001.Count - 1 do
      FreeAndNil(gr.Cl132.FListPr001[j].FExamAnal);
    //Cl132Key := gr.Cl132.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Key));
    //SuperHipp.frmSuperHip.mmoTest.Lines.Add(DateToStr(gr.startDate) + '   ' + Cl132Key);
    if Date > gr.endDate then
    begin
      if not FVisibleMinali then Continue;
      vCl132 := vtrGraph.AddChild(vMinali, nil);
      vCl132.CheckType := ctCheckBox;
      vCl132.CheckState := csUncheckedNormal;
      data := vtrGraph.GetNodeData(vCl132);
      data.vid := vvCl132;
      data.index := i;
    end
    else
    if (Date < gr.endDate) and (Date < gr.startDate) then
    begin
      if not FVisibleBudeshti then Continue;
      vCl132 := vtrGraph.AddChild(vBudeshti, nil);
      data := vtrGraph.GetNodeData(vCl132);
      vCl132.CheckType := ctCheckBox;
      vCl132.CheckState := csUncheckedNormal;
      data.vid := vvCl132;
      data.index := i;
    end
    else
    if (Date <= gr.endDate) and (Date >= gr.startDate) then  // текущи
    begin
      vCl132 := vtrGraph.AddChild(vNast, nil);
      data := vtrGraph.GetNodeData(vCl132);

      //if gr.Cl132.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_CL136_Mapping)) = '1' then // ако е тип преглед
      case gr.Cl132.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_CL136_Mapping))[1]  of
        '1': //ако е тип преглед
        begin
          gr.Cl132.FPregled := nil;
          Cl132Key := gr.Cl132.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Key));
          for j := 0 to pat.FPregledi.Count - 1 do
          begin
            prStartDate := pat.FPregledi[j].getDateMap(BufADB, posDataADB, word(PregledNew_START_DATE));
            if (prStartDate <= gr.endDate) and ((prStartDate >= gr.startDate)) then
            begin

              if pat.FPregledi[j].Cl132 = gr.Cl132 then
              begin
                gr.Cl132.FPregled := pat.FPregledi[j];
                pat.FPregledi[j].Cl132 := gr.Cl132;
                pat.CurrentGraphIndex := i;
                Break;
              end;
            end;
          end;
          if True then//   gr.Cl132.FPregled = nil then // ако не е намерен направен преглед
          begin
            if NzisPregNotPreg.Contains('|' + Cl132Key + '|') then
            begin
              vCl132.CheckType := ctCheckBox;
              vCl132.CheckState := csUncheckedNormal;
              pat.ListCurrentProf.Add(gr);
            end
            else
            begin
              if IsPregForPerform then
              begin
                vCl132.CheckType := ctButton;
                vCl132.CheckState := csCheckedDisabled;
                pat.ListCurrentProf.Add(gr);
                //IsPregForPerform := true;
                //AEndDate := gr.endDate;
              end
              else
              begin
                vCl132.CheckType := ctCheckBox;
                vCl132.CheckState := csCheckedDisabled;
                IsPregForPerform := true;
                AEndDate := gr.endDate;
                if dataNast.DataPos = MaxInt then
                begin
                  dataNast.DataPos := i;
                  pat.NoteProf := gr.Cl132.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Description));
                  pat.CurrentGraphIndex := i;
                  pat.ListCurrentProf.Add(gr);
                end
                else
                begin
                  ShowMessage('Има повече от един преглед');
                end;
              end;
            end;
          end
          else  // намерен е преглед
          begin
            vCl132.CheckType := ctNone;
            //Include(vcl132.States, vsDisabled);
            //vCl132.CheckState := csUncheckedNormal;
            AEndDate := gr.endDate; //zzzzzzzzzzzzzzzzzzzzzzzzzzzzz дали ...
          end;
        end;
        '2': // изследвания
        begin
          pat.ListCurrentProf.Add(gr);
          //vCl132.CheckType := ctCheckBox;
          //Include(vCl132.States, vsExpanded);
          for k := 0 to PatNodes.ExamAnals.Count - 1 do
          begin
            NodeExamAnal := PatNodes.ExamAnals[k];
            dataExamAnal := pointer(PByte(NodeExamAnal) + lenNode);
            examAnal := TRealExamAnalysisItem.Create(nil);
            examAnal.DataPos := dataExamAnal.DataPos;
            cl22ExamAnal := examAnal.getAnsiStringMap(bufADB, posDataADB, word(ExamAnalysis_NZIS_CODE_CL22));
            datTemp := examAnal.getDateMap(bufADB, posDataADB, word(ExamAnalysis_DATA));
            for m := 0 to gr.Cl132.FListPr001.Count - 1 do
            begin
              cl22Pr1 := gr.Cl132.FListPr001[m].getAnsiStringMap(BufNomen, PR001Coll.posData, word(PR001_Activity_ID));
              if (datTemp >= gr.startDate) and (datTemp <= gr.endDate)  then
              begin
                if cl22Pr1 = cl22ExamAnal then
                begin
                  if examAnal.Cl132 = nil then
                  begin
                    //vCl132.CheckType := ctNone;
                    gr.Cl132.FListPr001[m].FExamAnal := TRealExamAnalysisItem.Create(nil);
                    TRealExamAnalysisItem(gr.Cl132.FListPr001[m].FExamAnal).DataPos := dataExamAnal.DataPos;
                    gr.Cl132.FExamAnal := TRealExamAnalysisItem.Create(nil);
                    TRealExamAnalysisItem(gr.Cl132.FExamAnal).DataPos := dataExamAnal.DataPos;
                    //pat.FExamAnals.Add()
                    //examAnal.Cl132 := gr.Cl132;
                  end;
                end;
              end;
            end;
          end;
        end;
        '3': // имунизации
        begin
          pat.ListCurrentProf.Add(gr);
        end
      else

      end;


     // begin
//        if gr.endDate = AEndDate then // ако другата дейност е със същия краен срок като прегледа
//        begin
//          vCl132.CheckType := ctCheckBox;
//          vCl132.CheckState := csCheckedDisabled;
//        end
//        else
//        begin
//          vCl132.CheckType := ctCheckBox;
//          vCl132.CheckState := csUncheckedNormal;
//        end;
//      end;
      data.vid := vvCl132;
      data.index := i;
    end;
    for j := 0 to gr.Cl132.FListPr001.Count - 1 do
    begin
      if vCl132 = nil then
      begin
        vCl132 := nil;
      end;
      vPr001 := vtrGraph.AddChild(vCl132, nil);
      data := vtrGraph.GetNodeData(vPr001);
      data.vid := vvPr001;
      data.index := j;

      pr001 := gr.Cl132.FListPr001[j];
      if pr001.FExamAnal <> nil then
      begin
        vPr001.CheckType := ctNone;
        Include(vPr001.States, vsDisabled);
      end
      else
      begin
        vPr001.CheckType := ctCheckBox;
      end;

      //pr001.

      if pr001.CL142 <> nil  then
      begin
        Rule88 := pr001.getAnsiStringMap(BufNomen, PR001Coll.posData, word(PR001_Rules));

        if pr001.CL142.FListCL088.Count > 1 then
        begin
          for k := 0 to pr001.CL142.FListCL088.Count - 1 do
          begin
            if Trim(Rule88) <> '' then
            begin
              Cl088 := pr001.CL142.FListCL088[k];
              ACL088_key := cl088.getAnsiStringMap(BufNomen, PR001Coll.posData, word(CL088_key));
              if Pos(ACL088_key, Rule88) = 0 then Continue;
            end;

            vCL088 := vtrGraph.AddChild(vPr001, nil);
            data := vtrGraph.GetNodeData(vCL088);
            data.vid := vvCL088;
            data.index := k;
          end;
        end;
      end;

      for k := 0 to gr.Cl132.FListPr001[j].LstCl134.Count - 1 do
      begin
        cl134 := gr.Cl132.FListPr001[j].LstCl134[k];
        note := cl134.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL134_Note));
        Field_cl133 := cl134.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL134_CL133));
        if (note <> '') and (Field_cl133[1] in ['5', '6']) then
        begin
          test := gr.Cl132.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL132_Key)) +
                   cl134.getAnsiStringMap(BufNomen, CL132Coll.posData, word(CL134_Note));
        end
        else
        begin
          test := '';
        end;

       // if (test = '')  or  (lstValid.Text.Contains(test)) then
        begin
          vCL134 := vtrGraph.AddChild(vPr001, nil);
          data := vtrGraph.GetNodeData(vCL134);
          data.vid := vvCl134;
          data.index := k;
        end;
      end;
    end;
  end;
  //vtrGraph.FullExpand();
  vtrGraph.Expanded[vNast] := True;
  vtrGraph.Expanded[vPat] := True;
  vtrGraph.Sort(vNast, 0, sdAscending, false);
  vtrGraph.Sort(vMinali, 0, sdAscending, false);
  vtrGraph.Sort(vBudeshti, 0, sdAscending, false);
  if vNast.FirstChild <> nil then
  begin
    vRun := vNast.FirstChild.NextSibling;
    while vRun <> nil do
    begin
      vtrGraph.Expanded[vRun] := True;
      vRun := vRun.NextSibling;
    end;
  end
  else
  begin
    ShowMessage('Няма никакъв план');
  end;

  //vtrGraph.FocusedNode := vtrGraph.RootNode.FirstChild;
  //vtrGraph.Selected[vtrGraph.RootNode.FirstChild] := True;
  vtrGraph.EndUpdate;
end;

function TProfGraph.RuleCl132_PR001(cl132, pr001: TObject): boolean;
var
  pr1Nomen: string;
begin
  Result := True;
  pr1Nomen := TRealPR001Item(pr001).getAnsiStringMap(BufNomen, PR001Coll.posData, word(PR001_Nomenclature));
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

end.
