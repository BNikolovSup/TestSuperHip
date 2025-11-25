unit SearchThread;
           //debug   if PAspRecFilter(PByte(adbChild)+lenNode).vid = fdata.vid then
interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages, system.Math,
  system.Diagnostics, system.TimeSpan, Winapi.ActiveX, VirtualTrees, VirtualStringTreeAspect,
  VirtualStringTreeHipp, RealObj.RealHipp, System.Generics.Collections,
  Aspects.Types, Aspects.Collections, VCLTee.Grid, Vcl.Dialogs,
  Table.PatientNew, Table.PregledNew, Table.Doctor, Table.Diagnosis, Table.ExamImmunization,
  RTTI, Winapi.Windows, InterruptibleSort, Aspects.Functions, ADB_DataUnit
    ;

type
  TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;
  TRunItem = record
    RuningType: TVtrVid;
    ClassForFind: TClass;
    CollForRuning: TBaseCollection;
    childVid: TVtrVid;
    parentVid: TVtrVid;
  end;


  TSearchThread = class(TThread)
  private
    FAdbRoot: PVirtualNode;
    FStop: Boolean;
    FStoped: Boolean;

    IsStart: Boolean;
    FOnShowGrid: TNotifyEvent;
    FIsClose: Boolean;
    FCntPregInPat: Integer;
    FCntDiagInPreg: Integer;
    FCntImunInPreg: Integer;
    FOnlySort: Boolean;
    FcollPreg: TPregledNewColl;
    FCollPat: TPatientNewColl;
    ListAnsi: TList<AnsiString>;
    ListInt: TList<Integer>;
    ListDate: TList<TDate>;
    ListTime: TList<TTime>;
    ListLog40: TList<TLogicalData40>;
    FIsSorting: Boolean;
    FFilterRoot: PVirtualNode;
    testCNT: Integer;
    FAdb_DM: TADBDataModule;

    procedure SetAdbRoot(const Value: PVirtualNode);
    procedure SetSearchedText(const Value: string);
    procedure SortListDataPos(ListDataPos: TList<PAspRec>);
    procedure SortListDataPosColl(ListDataPos: TList<PVirtualNode>);
    procedure SortListPropIndexColl(ListDataPos: TList<PVirtualNode>);

    procedure SortAnsiListPropIndexCollNew(Coll: TBaseCollection; propIndex: word; SortIsAsc: Boolean);
    procedure SortIntListPropIndexCollNew(Coll: TBaseCollection; propIndex: word; SortIsAsc: Boolean);
    procedure SortDateListPropIndexCollNew(Coll: TBaseCollection; propIndex: word; SortIsAsc: Boolean);
    procedure SortTimeListPropIndexCollNew(Coll: TBaseCollection; propIndex: word; SortIsAsc: Boolean);
    procedure SortLogical40ListPropIndexCollNew(Coll: TBaseCollection; propIndex: word; SortIsAsc: Boolean);

    //procedure SortAnsiListPropIndexCollInter(
//          Coll: TBaseCollection; PropIndex: Word; SortAsc: Boolean);

    procedure SortCollByPropertyAnsiStr(coll: TBaseCollection; SortAsc: boolean = true);
    procedure SetcollPreg(const Value: TPregledNewColl);
    procedure DoCollPregSort(sender: TObject);
    procedure SetcollPat(const Value: TPatientNewColl);
    procedure SetFilterRoot(const Value: PVirtualNode);

  protected
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    ArrVidSearch: TArray<TAspRec>;
    procedure Execute; override;
    procedure DoTerminate; override;
    procedure DoSearchVTR2;



    function DoSearchVTR3(ADBNode, FilterNode: PVirtualNode): Boolean;
    function MatchNode(filterNode, adbNode: PVirtualNode): Boolean;
    function MatchRoot(FilterNode, ADBNode: PVirtualNode): Boolean;
    function MatchObjectFilter(FilterNode, ADBNode: PVirtualNode): Boolean;
    function MatchObjectOrGroup(FilterNode, ADBNode: PVirtualNode): Boolean;
    function MatchField(FilterNode, ADBNode: PVirtualNode): Boolean;
    function MatchFieldOrGroup(FilterNode, ADBNode: PVirtualNode): Boolean;
    function FindChildByVid(node: PVirtualNode; vid: TVtrVid): PVirtualNode;
    function FindRealChild(parentAdbNode: PVirtualNode; childVid: TVtrVid): PVirtualNode;
    function MatchFieldNode(filterFieldNode, adbObjectNode: PVirtualNode): Boolean;
    function MatchObjectNode(filterNode, adbNode: PVirtualNode): Boolean;
    function IsNodeActive(node: PVirtualNode): Boolean;
    function HasActiveFiltersInSubtree(node: PVirtualNode): Boolean;


    procedure CalcArrayPropSearch;

    procedure IterateChild(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);

  public
    RunItem: TRunItem;
    VTR_searched: TVirtualStringTreeHipp;
    CollForFind: TBaseCollection;


    //CollExamImun: TExamImmunizationColl;
    //collPatForSearch: TPatientNewColl;
    //collPregForSearch: TRealPregledNewColl;
    //Tempitem: TBaseItem;
    //FieldForFind: Word;
    vtr: TVirtualStringTreeAspect;
    bufLink: Pointer;
    //BufADB: Pointer;
    //FPosData: Cardinal;
    grdSearch: TTeeGrid;


    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    procedure Start;

    //property collPreg: TPregledNewColl read FcollPreg write SetcollPreg;
//    property collPat: TPatientNewColl read FCollPat write SetcollPat;

    property AdbRoot: PVirtualNode read FAdbRoot write SetAdbRoot;
    property FilterRoot: PVirtualNode read FFilterRoot write SetFilterRoot;
    property OnShowGrid: TNotifyEvent read FOnShowGrid write FOnShowGrid;
    property IsClose: Boolean read FIsClose write FIsClose;
    property CntPregInPat: Integer read FCntPregInPat write FCntPregInPat;
    property CntDiagInPreg: Integer read FCntDiagInPreg write FCntDiagInPreg;
    property CntImunInPreg: Integer read FCntImunInPreg write FCntImunInPreg;
    property OnlySort: Boolean read FOnlySort write FOnlySort;
    property IsSorting: Boolean read FIsSorting write FIsSorting;
    property Adb_DM: TADBDataModule read FAdb_DM write FAdb_DM;
  end;
implementation



{ TSearchThread }

procedure TSearchThread.CalcArrayPropSearch;
var
  i, j: Integer;
begin
  j := 0;
  SetLength(FCollPat.ArrPropSearchClc, 0);
  for i := 0 to Length(FCollPat.ArrPropSearch) - 1 do
  begin
    if FCollPat.ArrPropSearch[i] in FCollPat.PRecordSearch.setProp then
    begin
      SetLength(FCollPat.ArrPropSearchClc, j + 1);
      FCollPat.ArrPropSearchClc[j] := FCollPat.ArrPropSearch[i];
      inc(j);
    end;
  end;

  j := 0;
  SetLength(Adb_DM.CollExamImun.ArrPropSearchClc, 0);
  for i := 0 to Length(Adb_DM.CollExamImun.ArrPropSearch) - 1 do
  begin
    if Adb_DM.CollExamImun.ArrPropSearch[i] in Adb_DM.CollExamImun.PRecordSearch.setProp then
    begin
      SetLength(Adb_DM.CollExamImun.ArrPropSearchClc, j + 1);
      Adb_DM.CollExamImun.ArrPropSearchClc[j] := Adb_DM.CollExamImun.ArrPropSearch[i];
      inc(j);
    end;
  end;

  j := 0;
  SetLength(FcollPreg.ArrPropSearchClc, 0);
  for i := 0 to Length(FcollPreg.ArrPropSearch) - 1 do
  begin
    if FcollPreg.ArrPropSearch[i] in FcollPreg.PRecordSearch.setProp then
    begin
      SetLength(FcollPreg.ArrPropSearchClc, j + 1);
      FcollPreg.ArrPropSearchClc[j] := FcollPreg.ArrPropSearch[i];
      inc(j);
    end;
  end;
end;



//function TSearchThread.FindChildByVid(node: PVirtualNode; vid: TVtrVid): PVirtualNode;
//var
//  ch: PVirtualNode;
//  data: PAspRecFilter;
//begin
//  Result := nil;
//  ch := node.FirstChild;
//  while ch <> nil do
//  begin
//    data := Pointer(PByte(ch) + lenNode);
//    if data.vid = vid then
//      Exit(ch);
//    ch := ch.NextSibling;
//  end;
//end;


constructor TSearchThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FAdbRoot := nil;
  IsStart := true;
  FStop := True;
  FStoped := True;
  FIsClose := False;
  FcntPregInPat := -1;
  FCntImunInPreg := -1;
  FOnlySort := False;
  FIsSorting := False;
  ListAnsi := TList<AnsiString>.Create;
  ListInt := TList<Integer>.Create;
  ListDate := TList<Tdate>.Create;
  ListTime := TList<Ttime>.Create;
  ListLog40 := TList<TLogicalData40>.Create;


end;

destructor TSearchThread.Destroy;
begin

  inherited;
end;


procedure TSearchThread.DoCollPregSort(sender: TObject);
begin
  Self.OnlySort := True;
  Self.Start;
  CollForFind := TBaseCollection(sender);
end;

procedure TSearchThread.DoSearchVTR2;
var
  i, iVid, testCnt: Integer;
  linkPos: Cardinal;
  pCardinalData: ^Cardinal;
  FPosLinkData: Cardinal;
  FPosDataADB: Cardinal;
  data: PAspRec;

  node, patNode, pregNode, mkbNode, pregInIncNaprNode: PVirtualNode;
  FindedPregNode: PVirtualNode;
  dataPat, dataRunPreg, dataDiag, dataRunPregInIncNapr: PAspRec;
  dataPreg, dataTest: PAspRec;
  tempPat: TPatientNewItem;
  temppreg: TRealPregledNewItem;
  tempDoctor: TDoctorItem;
  tempDiag: TDiagnosisItem;
  tempImun: TRealExamImmunizationItem;
  egn, anamn, uin, diag: string;
  AcntPregInPat, AcntImunInPreg: Integer;
  BufADB: Pointer;
begin
  FStop := False;

  linkPos := 100;
  testCnt := 0;
  BufADB := Adb_DM.AdbMain.Buf;

  pCardinalData := pointer(PByte(bufLink));
  FPosLinkData := pCardinalData^;
  pCardinalData := pointer(PByte(BufADB) + 8);
  FPosDataADB := pCardinalData^;
  node := pointer(PByte(bufLink) + linkpos);
  data := pointer(PByte(node) + lenNode);

  tempPat := TPatientNewItem.Create(nil);
  temppreg := TRealPregledNewItem.Create(nil);
  tempDoctor := TDoctorItem.Create(nil);
  tempDiag := TDiagnosisItem.Create(nil);
  tempImun := TRealExamImmunizationItem.Create(nil);
  FcollPreg.ListDataPos.Clear;
  FCollPat.ListDataPos.Clear;
  CalcArrayPropSearch;

  patNode := node.FirstChild;
  while patNode <> nil do // loop pat
  begin
    if FStop then
    begin
      FcollPreg.ListDataPos.Clear;
      FCollPat.ListDataPos.Clear;
      if Assigned(FOnShowGrid) then
        FOnShowGrid(Self);
      Exit;
    end;
    FCollPat.Tag := -1;
    dataPat := pointer(PByte(patNode) + lenNode);
    tempPat.DataPos := dataPat.DataPos;
    egn := tempPat.getAnsiStringMap(BufADB, FPosDataADB, word(PatientNew_EGN));
    if tempPat.IsFullFinded(Adb_DM.AdbMain.Buf, FPosDataADB, FCollPat) then
    begin
      pregNode := patNode.FirstChild;
      FindedPregNode := pregNode;
      AcntPregInPat := 0;

      while pregNode <> nil do  // loop child
      begin
        dataRunPreg := pointer(PByte(pregNode) + lenNode);
        dataPreg := nil;
        case dataRunPreg.vid of
          vvIncMN:
          begin
            pregInIncNaprNode := pregNode.FirstChild;

            while pregInIncNaprNode <> nil do
            begin
              dataRunPregInIncNapr := pointer(PByte(pregInIncNaprNode) + lenNode);
              case dataRunPregInIncNapr.vid of
                vvPregled:
                begin
                  FindedPregNode := pregInIncNaprNode;
                  if FCollPat.Tag < 0 then
                  begin
                    FCollPat.Tag := 0;
                  end;
                  dataPreg := dataRunPregInIncNapr;
                  temppreg.DataPos := dataRunPregInIncNapr.DataPos;
                  if temppreg.IsFullFinded(Adb_DM.AdbMain.Buf, FPosDataADB, FcollPreg) then
                  begin
                    AcntImunInPreg := 0;
                    mkbNode := pregInIncNaprNode.FirstChild;

                  end
                  else
                  begin
                    FindedPregNode := nil;
                  end;
                end;
              end;
              pregInIncNaprNode := pregInIncNaprNode.NextSibling;
            end;
          end;
          vvPregled:   // ако е преглед
          begin
            FindedPregNode := pregNode;
            if FCollPat.Tag < 0 then
            begin
              FCollPat.Tag := 0;
            end;
            dataPreg := dataRunPreg;
            temppreg.DataPos := dataRunPreg.DataPos;
            if temppreg.IsFullFinded(Adb_DM.AdbMain.Buf, FPosDataADB, FcollPreg) then
            begin
              AcntImunInPreg := 0;
              mkbNode := pregNode.FirstChild;
            end
            else
            begin
              FindedPregNode := nil;
            end;
          end;
          vvDoctor:
          begin
            tempDoctor.DataPos := dataRunPreg.DataPos;
            uin := tempDoctor.getAnsiStringMap(Adb_DM.AdbMain.Buf, FPosDataADB, word(Doctor_UIN));
          end;
        end;
        if FindedPregNode <> nil then
        begin
          if (dataPreg <> nil) then
          begin

            FcollPreg.ListDataPos.Add(FindedPregNode);
            inc(testCnt);
            dataTest := Pointer(pbyte(FindedPregNode) + lenNode);
            if dataTest.vid <> vvPregled then
              uin := 'ddd';
            inc(AcntPregInPat);
          end;
          Adb_DM.CollPatient.Tag := Adb_DM.CollPatient.Tag + 1;
        end;
        pregNode := pregNode.NextSibling;
        FindedPregNode := nil;;
      end;
    end
    else
    begin
      Self.bufLink := Self.bufLink;
      FCollPat.Tag := -2;
    end;
    case FCollPat.tag of
      -2: //не е изпълнено условието за пациента
      begin
        FCollPat.Tag := -2;
      end;
      -1: //изпълнено е условието за пациента, но няма прегледи
      begin
        FCollPat.ListDataPos.Add(patNode);
      end;
      0: // има прегледи, но не е изпълнено условието за прегледите или по нататък
      begin
        FCollPat.Tag := 0;

      end;
    else
      begin
        if (FcntPregInPat > -1)  then
        begin
          if (FcntPregInPat = AcntPregInPat) then
          begin
            FCollPat.ListDataPos.Add(patNode);
          end
          else
          begin
            for I := 1 to AcntPregInPat do
            begin
              FcollPreg.ListDataPos.Delete(FcollPreg.ListDataPos.Count - 1);
            end;
          end;
        end
        else
        if (FCntImunInPreg > -1)  then
        begin
          if (FCntImunInPreg = ACntImunInPreg) then
          begin
            FCollPat.ListDataPos.Add(patNode);
          end
          else
          begin
            for I := 1 to ACntImunInPreg do
            begin
              FcollPreg.ListDataPos.Delete(FcollPreg.ListDataPos.Count - 1);
            end;
          end;
        end
        else
        begin
          FCollPat.ListDataPos.Add(patNode);
        end;
      end;

    end;

    patNode := patNode.NextSibling;
  end;

  if (FcollPreg.ListDataPos.Count > 0) or (FCollPat.ListDataPos.Count > 0) then
  begin
    Stopwatch := TStopwatch.StartNew;
    SortListDataPosColl(Adb_DM.CollPregled.ListDataPos);
    //Elapsed := Stopwatch.Elapsed;
    //mmoTest.Lines.Add( Format('grdSearchSelect за %f',[ Elapsed.TotalMilliseconds]));
    if Assigned(FOnShowGrid) then
      FOnShowGrid(Self);
  end
  else
  begin
    FCollPat.ListDataPos.Clear;
    FcollPreg.ListDataPos.Clear;
    if Assigned(FOnShowGrid) then
      FOnShowGrid(Self);
  end;

end;

//function TSearchThread.DoSearchVTR3(ADBNode, FilterNode: PVirtualNode): Boolean;
//var
//  adbChild: PVirtualNode;
//  cnt, cntTotal: Integer;
//begin
//  Stopwatch := TStopwatch.StartNew;
//  adbChild := AdbRoot.FirstChild;
//  cnt := 0;
//  cntTotal := 0;
//  testCNT := 0;
//  while adbChild <> nil do
//  begin
//    if MatchNode(FilterRoot, adbChild) then
//    begin
//      inc(cnt);
//      // → съвпада: добави в резултата
//    end;
//
//    adbChild := adbChild.NextSibling;
//    inc(testCNT);
//  end;
//  Elapsed := Stopwatch.Elapsed;
//  OutputDebugString(PChar(Format('DoSearchVTR3 %d бр за total=%f', [cnt, Elapsed.TotalMilliseconds])));
//end;


procedure TSearchThread.DoTerminate;
begin
  inherited;

end;

procedure TSearchThread.Execute;
var
  i: Integer;
  comInitStatus: THandle;
  fieldType: string;
  propIndex: Word;
  propType: TAspectTypeKind;
begin
  comInitStatus := S_FALSE;
  try
    comInitStatus := CoInitializeEx(nil, COINIT_MULTITHREADED);
    inherited;
    try
      while not Terminated do
      begin
        if (not IsStart)  then
        begin
          IsStart := True;
          if FOnlySort then
          begin
            Stopwatch := TStopwatch.StartNew;
            FOnlySort := false;
            //Sleep(10000);
            FStop := true;

            if FStoped then
            begin
              FIsSorting := True;
              FStop := False;
              grdSearch.Cursor :=  crHourGlass;

              if CollForFind.FSortFields.count = 1 then // една колона then
              begin
                propIndex := CollForFind.FSortFields[0].PropIndex;// това си е точно пропИндекс-а от колекцията
                propType := CollForFind.PropType(propIndex);
                case propType of
                  actAnsiString: CollForFind.SortAnsiPropInterruptible(propIndex, CollForFind.FSortFields[0].SortAsc, @FStop);
                  actInteger: CollForFind.SortIntegerPropInterruptible(propIndex, CollForFind.FSortFields[0].SortAsc, @FStop);
                  actTDate: CollForFind.SortDatePropInterruptible(propIndex, CollForFind.FSortFields[0].SortAsc, @FStop);
                  actTTime: CollForFind.SortDatePropInterruptible(propIndex, CollForFind.FSortFields[0].SortAsc, @FStop);
                  //actLogical: SortLogical40ListPropIndexCollNew(collPreg, propIndex, collPreg.SortAsc);
                end;
              end
              else
              begin
                CollForFind.SortMultiColumnsOptimized(@FStop);
              end;
              grdSearch.Repaint;
              FIsSorting := false;
              grdSearch.Cursor :=  crDefault;
              Elapsed := Stopwatch.Elapsed;
              fieldType := TRttiEnumerationType.GetName(TPregledNewItem.TPropertyIndex(Adb_DM.CollPregled.ColumnForSort));
             // ShowMessage(Format('sort %s за %f',[fieldType, Elapsed.TotalMilliseconds]));
            end;
            //mmoTest.Lines.Add( Format('grdSearchSelect за %f',[ Elapsed.TotalMilliseconds]));
          end
          else
            DoSearchVTR3(FAdbRoot, FFilterRoot);
        end;
        if FIsClose then
          Exit;
        Sleep(10);
      end;
    except
      Exit;
    end;
  finally
    case comInitStatus of
      S_OK, S_FALSE: CoUninitialize;
    end;
  end;
end;



procedure TSearchThread.IterateChild(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
var
  Adata: PAspRec;
begin
  if FStop then
    Abort := True;
  Adata := pointer(PByte(node) + lenNode);
  if Adata.vid = RunItem.childVid then
    CollForFind.ListDataPos.Add(node);
end;

//function TSearchThread.MatchField(FilterNode, ADBNode: PVirtualNode): Boolean;
//var
//  fdata, adata: PAspRecFilter;
//  adbField: PVirtualNode;
//begin
//  // Ако не е активен → все едно не съществува
//  if FilterNode.CheckState <> csCheckedNormal then
//    Exit(True);
//
//  fdata := Pointer(PByte(FilterNode) + lenNode);
//
//  // Търсим в ADBNode дете с *същото поле (Dummy)*
//  adbField := ADBNode.FirstChild;
//  while Assigned(adbField) do
//  begin
//    adata := Pointer(PByte(adbField) + lenNode);
//
//    // поле се определя единствено по Dummy (index на полето в колекцията)
//    if (adata.vid = fdata.vid) and (adbField.Dummy = FilterNode.Dummy) then
//      Exit(True);
//
//    adbField := adbField.NextSibling;
//     inc(testCNT);
//  end;
//
//  // Няма такова поле в ADB → FALSE
//  Result := False;
//end;
//
//
//
//function TSearchThread.MatchFieldOrGroup(FilterNode, ADBNode: PVirtualNode): Boolean;
//var
//  child: PVirtualNode;
//begin
//  child := FilterNode.FirstChild;
//
//  while Assigned(child) do
//  begin
//    if IsNodeActive(child) then
//    begin
//      // Полетата вътре в групата трябва да се проверяват като полета
//      if MatchField(child, ADBNode) then
//        Exit(True);
//    end;
//
//    child := child.NextSibling;
//  end;
//
//  // Нито едно поле не съвпадна → FALSE
//  Result := False;
//end;



//function TSearchThread.FindRealChild(parentAdbNode: PVirtualNode; childVid: TVtrVid): PVirtualNode;
//var
//  ch: PVirtualNode;
//  data: PAspRec;
//begin
//  Result := nil;
//  ch := parentAdbNode.FirstChild;
//
//  while Assigned(ch) do
//  begin
//    data := Pointer(PByte(ch) + lenNode);
//    if data.vid = childVid then
//      Exit(ch);
//
//    ch := ch.NextSibling;
//  end;
//end;



//function TSearchThread.MatchFieldNode(filterFieldNode, adbObjectNode: PVirtualNode): Boolean;
//begin
//  // Засега просто TRUE — ще се активира след FMX UI и операторите
//  Result := True;
//end;




//function TSearchThread.MatchObjectNode(filterNode, adbNode: PVirtualNode): Boolean;
//var
//  filterChild: PVirtualNode;
//  fdata: PAspRecFilter;
//  adbChild: PVirtualNode;
//  adbData: PAspRecFilter;
//  atLeastOneMatch: Boolean;
//begin
//  Result := True;
//
//  filterChild := filterNode.FirstChild;
//
//  while Assigned(filterChild) do
//  begin
//    fdata := Pointer(PByte(filterChild) + lenNode);
//
//    // ---- ПОЛЕТА ----
//    if (fdata.vid = vvFieldFilter) or (fdata.vid = vvFieldOrGroup) then
//    begin
//      if filterChild.CheckState = csCheckedNormal then
//        if not MatchFieldNode(filterChild, adbNode) then
//          Exit(False);
//
//      filterChild := filterChild.NextSibling;
//      Continue;
//    end;
//
//    // ---- ОБЕКТЕН ВЪЗЕЛ ----
//    if filterChild.CheckState <> csCheckedNormal then
//    begin
//      filterChild := filterChild.NextSibling;
//      Continue;
//    end;
//
//    atLeastOneMatch := False;
//
//    adbChild := adbNode.FirstChild;
//
//    while Assigned(adbChild) do
//    begin
//      adbData := Pointer(PByte(adbChild) + lenNode);
//
//      // Логваме какво сравняваме
//      //DebugMsg(Format(
////        '[CHECK] filter=%s   adb=%s   RESULT=%s',
////        [
////          TRttiEnumerationType.GetName(fdata.vid),
////          TRttiEnumerationType.GetName(adbData.vid),
////          BoolToStr(fdata.vid = adbData.vid, True)
////        ]
////      ));
//
//      if adbData.vid = fdata.vid then
//      begin
//        if MatchObjectNode(filterChild, adbChild) then
//        begin
//          atLeastOneMatch := True;
//          Break;
//        end;
//      end;
//
//      adbChild := adbChild.NextSibling;
//      inc(testCNT);
//    end;
//
//    if not atLeastOneMatch then
//    begin
//     // OutputDebugString(PChar(Format(
////      '[DROP] PatientID=%d  Missing object: %s',
////       [PAspRecFilter(PByte(adbNode)+lenNode).index,
////        TRttiEnumerationType.GetName(fdata.vid)
////       ])));
//      Exit(False);
//    end;
//
//    filterChild := filterChild.NextSibling;
//  end;
//end;


//function TSearchThread.HasActiveFiltersInSubtree(node: PVirtualNode): Boolean;
//var
//  ch: PVirtualNode;
//  data: PAspRec;
//begin
//  ch := node.FirstChild;
//  while Assigned(ch) do
//  begin
//    data := Pointer(PByte(ch) + lenNode);
//
//    if (data.vid = vvFieldFilter) and (ch.CheckState = csCheckedNormal) then
//      Exit(True);
//
//    if data.vid = vvFieldOrGroup then
//      Exit(True);
//
//    if HasActiveFiltersInSubtree(ch) then
//      Exit(True);
//
//    ch := ch.NextSibling;
//  end;
//
//  Result := False;
//end;



//function TSearchThread.IsNodeActive(node: PVirtualNode): Boolean;
//var
//  data: PAspRecFilter;
//  child: PVirtualNode;
//begin
//  Result := False;
//  if node = nil then Exit;
//
//  data := Pointer(PByte(node) + lenNode);
//
//  case data.vid of
//
//    // Поле — активно само ако е чекнато
//    vvFieldFilter:
//      Exit(node.CheckState = csCheckedNormal);
//
//    // OR група — ако поне едно дете е активно
//    vvFieldOrGroup:
//    begin
//      child := node.FirstChild;
//      while child <> nil do
//      begin
//        if IsNodeActive(child) then
//          Exit(True);
//        child := child.NextSibling;
//      end;
//      Exit(False);
//    end;
//
//    // Обектен възел — активен само ако Е ЧЕКНАТ
//    // и има поне едно активно поле/дете вътре
//    vvPatient, vvPregled, vvDoctor, vvDiag, vvAddres, vvIncMN:
//    begin
//      if node.CheckState <> csCheckedNormal then
//        Exit(False);
//
//      child := node.FirstChild;
//      while child <> nil do
//      begin
//        if IsNodeActive(child) then
//          Exit(True);
//        child := child.NextSibling;
//      end;
//
//      Exit(False);
//    end;
//
//
//    // Оператор — няма собствена активност (ще бъде използван на Стъпка 2)
//    vvOperator:
//      Exit(False);
//
//    // Root — активен ако съдържа активни деца
//    vvRootFilter:
//    begin
//      child := node.FirstChild;
//      while child <> nil do
//      begin
//        if IsNodeActive(child) then
//          Exit(True);
//        child := child.NextSibling;
//      end;
//      Exit(False);
//    end;
//
//  end;
//end;

//function TSearchThread.MatchNode(filterNode, adbNode: PVirtualNode): Boolean;
//var
//  test: string;
//
//begin
//  test := Format('MatchNode: filter=%s adb=%s',
//    [TRttiEnumerationType.GetName(PAspRec(PByte(filterNode) + lenNode).vid),
//     TRttiEnumerationType.GetName(PAspRec(PByte(adbNode) + lenNode).vid)]
//  );
//  OutputDebugString(PChar(test));
//  Result := True;
//end;


//function TSearchThread.MatchNode(filterNode, adbNode: PVirtualNode): Boolean;
//var
//  fdata: PAspRecFilter;
//begin
//  fdata := Pointer(PByte(filterNode) + lenNode);
//
//  // ROOT → директно влизаме в обектна проверка
//  if fdata.vid = vvRootFilter then
//    Exit(MatchObjectNode(filterNode, adbNode));
//
//  // Ако филтърният възел НЕ е активен → игнорираме го
//  // (той не участва в логиката за match)
//  if not IsNodeActive(filterNode) then
//    Exit(True);
//
//  // Ако е ОБЕКТЕН възел → MatchObjectNode го обработва
//  if (fdata.vid <> vvFieldFilter) and
//     (fdata.vid <> vvFieldOrGroup) and
//     (fdata.vid <> vvOperator) then
//    Exit(MatchObjectNode(filterNode, adbNode));
//
//  // Ако е ПОЛЕ или ГРУПА от полета
//  Result := MatchFieldNode(filterNode, adbNode);
//end;
//
//function TSearchThread.MatchObjectFilter(FilterNode, ADBNode: PVirtualNode): Boolean;
//var
//  child: PVirtualNode;
//begin
//  child := FilterNode.FirstChild;
//  while Assigned(child) do
//  begin
//    if child.CheckState = csCheckedNormal then
//      if not MatchNode(child, ADBNode) then
//        Exit(False);
//    child := child.NextSibling;
//  end;
//
//  Result := True;
//end;
//
//
//function TSearchThread.MatchObjectOrGroup(FilterNode, ADBNode: PVirtualNode): Boolean;
//var
//  child: PVirtualNode;
//begin
//  child := FilterNode.FirstChild;
//  while Assigned(child) do
//  begin
//    if child.CheckState = csCheckedNormal then
//      if MatchNode(child, ADBNode) then
//        Exit(True);
//    child := child.NextSibling;
//  end;
//
//  Result := False;
//end;
//
//
//function TSearchThread.MatchRoot(FilterNode, ADBNode: PVirtualNode): Boolean;
//var
//  child: PVirtualNode;
//begin
//  child := FilterNode.FirstChild;
//  while Assigned(child) do
//  begin
//    if child.CheckState = csCheckedNormal then
//      if not MatchNode(child, ADBNode) then
//        Exit(False);
//    child := child.NextSibling;
//  end;
//
//  Result := True;
//end;


procedure TSearchThread.SetcollPat(const Value: TPatientNewColl);
begin
  FCollPat := Value;
  FCollPat.OnSortCol := DoCollPregSort;
end;

procedure TSearchThread.SetcollPreg(const Value: TPregledNewColl);
begin
  FcollPreg := Value;
  FcollPreg.OnSortCol := DoCollPregSort;
end;

procedure TSearchThread.SetFilterRoot(const Value: PVirtualNode);
begin
  FFilterRoot := Value;
end;

procedure TSearchThread.SetAdbRoot(const Value: PVirtualNode);
begin
  FAdbRoot := Value;
end;

procedure TSearchThread.SetSearchedText(const Value: string);
begin

end;

procedure TSearchThread.SortCollByPropertyAnsiStr(coll: TBaseCollection; SortAsc: boolean);
var
  sc : TList<TCollectionItem>;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : TCollectionItem;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        if SortAsc then
        begin
          while coll.getAnsiStringMap(TBaseItem(coll.Items[I]).FDataPos, Word(PregledNew_ANAMN)) <
                coll.getAnsiStringMap(TBaseItem(coll.Items[P]).FDataPos, Word(PregledNew_ANAMN)) do Inc(I);
          while coll.getAnsiStringMap(TBaseItem(coll.Items[J]).FDataPos, Word(PregledNew_ANAMN))  >
                coll.getAnsiStringMap(TBaseItem(coll.Items[P]).FDataPos, Word(PregledNew_ANAMN)) do Dec(J);
        end
        else
        begin
          while coll.getAnsiStringMap(TBaseItem(coll.Items[I]).FDataPos, Word(PregledNew_ANAMN)) >
                coll.getAnsiStringMap(TBaseItem(coll.Items[P]).FDataPos, Word(PregledNew_ANAMN)) do Inc(I);
          while coll.getAnsiStringMap(TBaseItem(coll.Items[J]).FDataPos, Word(PregledNew_ANAMN))  <
                coll.getAnsiStringMap(TBaseItem(coll.Items[P]).FDataPos, Word(PregledNew_ANAMN)) do Dec(J);
        end;
        if I <= J then begin
          Save := sc.Items[I];
          sc.Items[I] := sc.Items[J];
          sc.Items[J] := Save;
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
  if (coll.count >1 ) then
  begin
    sc := TCollectionForSort(coll).FItems;
    QuickSort(0,coll.count-1);
  end;
end;

//procedure TSearchThread.SortAnsiListPropIndexCollInter(
//  Coll: TBaseCollection; PropIndex: Word; SortAsc: Boolean);
//var
//  Sorter: TInterruptibleQuickSort<Integer>;
//  CompareFunc: TFunc<Integer, Integer, Integer>;
//  ListDataPos: TList<PVirtualNode>;
//  ArrAnsi: TArray<AnsiString>;
//  i: Integer;
//  IndexList: TList<Integer>;
//  NewOrder: TList<PVirtualNode>;
//begin
//  Stopwatch.StartNew;
//  ListDataPos := Coll.ListDataPos;
//  if ListDataPos.Count <= 1 then
//    Exit;
//
//  // --- Кеширане в масив вместо TList ---
//  SetLength(ArrAnsi, ListDataPos.Count);
//  for i := 0 to High(ArrAnsi) do
//    ArrAnsi[i] :=
//      Coll.getAnsiStringMap(
//        PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos,
//        PropIndex
//      );
//
//  // --- Функция за сравнение ---
//  CompareFunc := TFunc<Integer, Integer, Integer>(
//    function(const A, B: Integer): Integer
//    begin
//      if FStop then Exit(0);
//
//      Result := StrComp(PAnsiChar(ArrAnsi[A]), PAnsiChar(ArrAnsi[B]));
//      if not SortAsc then
//        Result := -Result;
//    end);
//
//  IndexList := TList<Integer>.Create;
//  try
//    IndexList.Capacity := ListDataPos.Count;
//    for i := 0 to ListDataPos.Count - 1 do
//      IndexList.Add(i);
//
//    Sorter := TInterruptibleQuickSort<Integer>.Create(@FStop);
//    try
//      Sorter.Sort(IndexList, CompareFunc);
//    finally
//      Sorter.Free;
//    end;
//
//    // --- Пренареждане ---
//    NewOrder := TList<PVirtualNode>.Create;
//    try
//      NewOrder.Capacity := ListDataPos.Count;
//      for i := 0 to IndexList.Count - 1 do
//        NewOrder.Add(ListDataPos[IndexList[i]]);
//
//      ListDataPos.Clear;
//      ListDataPos.AddRange(NewOrder);
//    finally
//      NewOrder.Free;
//    end;
//  finally
//    IndexList.Free;
//  end;
//
//  FStoped := True;
//  Elapsed := Stopwatch.Elapsed;
//  OutputDebugString(PChar(Format('SortAnsiList (Array) total=%f', [Elapsed.TotalMilliseconds])));
//end;

procedure TSearchThread.SortDateListPropIndexCollNew(Coll: TBaseCollection;
  propIndex: word; SortIsAsc: Boolean);
var
 ListDataPos: TList<PVirtualNode>;
 i: Integer;

procedure QuickSort(L, R: Integer);
var
    I, J, P : Integer;
    Save : TDate;
    saveList: PVirtualNode;
  begin
    repeat
     // Sleep(1);//  за тесттване на бавно сортиране
      if FStop then
      begin
        ListDate.Clear;
        FStoped := True;
        Exit;
      end;
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        if SortIsAsc then
        begin
          while (ListDate[I])< (ListDate[P]) do Inc(I);
          while (ListDate[J]) > (ListDate[P]) do Dec(J);
        end
        else
        begin
          while (ListDate[I])> (ListDate[P]) do Inc(I);
          while (ListDate[J]) < (ListDate[P]) do Dec(J);
        end;
        if I <= J then begin
          Save := ListDate[I];
          saveList := ListDataPos[I];
          ListDate[I] := ListDate[J];
          ListDataPos[I] := ListDataPos[J];
          ListDate[J] := Save;
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
  ListDataPos := Coll.ListDataPos;
  if (ListDataPos.count >1 ) then
  begin
    for i := 0 to ListDataPos.Count - 1 do
      ListDate.Add(Coll.getDateMap(PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos, propIndex));
    QuickSort(0,ListDate.count-1);
    ListDate.Clear;
    FStoped := True;
  end;
end;

procedure TSearchThread.SortIntListPropIndexCollNew(Coll: TBaseCollection;
  propIndex: word; SortIsAsc: Boolean);
var
 ListDataPos: TList<PVirtualNode>;
 i: Integer;

procedure QuickSort(L, R: Integer);
var
    I, J, P : Integer;
    Save : integer;
    saveList: PVirtualNode;
  begin
    repeat
     // Sleep(1);//  за тесттване на бавно сортиране
      if FStop then
      begin
        ListInt.Clear;
        FStoped := True;
        Exit;
      end;
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        if SortIsAsc then
        begin
          while (ListInt[I])< (ListInt[P]) do Inc(I);
          while (ListInt[J]) > (ListInt[P]) do Dec(J);
        end
        else
        begin
          while (ListInt[I])> (ListInt[P]) do Inc(I);
          while (ListInt[J]) < (ListInt[P]) do Dec(J);
        end;
        if I <= J then begin
          Save := ListInt[I];
          saveList := ListDataPos[I];
          ListInt[I] := ListInt[J];
          ListDataPos[I] := ListDataPos[J];
          ListInt[J] := Save;
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
  ListDataPos := Coll.ListDataPos;
  if (ListDataPos.count >1 ) then
  begin
    for i := 0 to ListDataPos.Count - 1 do
      ListInt.Add(Coll.getIntMap(PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos, propIndex));
    QuickSort(0,ListInt.count-1);
    ListInt.Clear;
    FStoped := True;
  end;
end;

procedure TSearchThread.SortListDataPos(ListDataPos: TList<PAspRec>);
procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : PAspRec;
  begin
    if FStop then
    begin
      Exit;
    end;
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while FcollPreg.getAnsiStringMap(ListDataPos[I].DataPos, Word(PregledNew_NRN_LRN)) <
              FcollPreg.getAnsiStringMap(ListDataPos[P].DataPos, Word(PregledNew_NRN_LRN)) do Inc(I);
        while FcollPreg.getAnsiStringMap(ListDataPos[J].DataPos, Word(PregledNew_NRN_LRN))  >
              FcollPreg.getAnsiStringMap(ListDataPos[P].DataPos, Word(PregledNew_NRN_LRN)) do Dec(J);
        if I <= J then begin
          Save := ListDataPos[I];
          ListDataPos[I] := ListDataPos[J];
          ListDataPos[J] := Save;
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
  if (ListDataPos.count >1 ) then
  begin
    QuickSort(0,ListDataPos.count-1);
  end;
end;

procedure TSearchThread.SortListDataPosColl(ListDataPos: TList<PVirtualNode>);
procedure QuickSort(L, R: Integer);
  var
    I, J, P : Integer;
    Save : PVirtualNode;
  begin
    if FStop then
    begin
      Exit;
    end;
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while PAspRec(Pointer(PByte(ListDataPos[I]) + lenNode)).DataPos > PAspRec(Pointer(PByte(ListDataPos[P]) + lenNode)).DataPos do Inc(I);
        while PAspRec(Pointer(PByte(ListDataPos[J]) + lenNode)).DataPos < PAspRec(Pointer(PByte(ListDataPos[P]) + lenNode)).DataPos do Dec(J);
        if I <= J then begin
          Save := ListDataPos[I];
          ListDataPos[I] := ListDataPos[J];
          ListDataPos[J] := Save;
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
  if (ListDataPos.count >1 ) then
  begin
    QuickSort(0,ListDataPos.count-1);
  end;
end;

procedure TSearchThread.SortListPropIndexColl(ListDataPos: TList<PVirtualNode>);
  function conditionI(i, p: integer): Boolean;
  var
  datPosI, datPosP: Cardinal;
  begin
    datPosI := PAspRec(Pointer(PByte(ListDataPos[I]) + lenNode)).DataPos;
    datPosP := PAspRec(Pointer(PByte(ListDataPos[P]) + lenNode)).DataPos;
    Result := FcollPreg.getAnsiStringMap(datPosI, Word(PregledNew_NRN_LRN)) < FcollPreg.getAnsiStringMap(datPosP, Word(PregledNew_NRN_LRN));
  end;

  function conditionJ(j, p: integer): Boolean;
  var
  datPosJ, datPosP: Cardinal;
  begin
    datPosJ := PAspRec(Pointer(PByte(ListDataPos[J]) + lenNode)).DataPos;
    datPosP := PAspRec(Pointer(PByte(ListDataPos[P]) + lenNode)).DataPos;
    Result := FcollPreg.getAnsiStringMap(datPosJ, Word(PregledNew_NRN_LRN)) > FcollPreg.getAnsiStringMap(datPosP, Word(PregledNew_NRN_LRN));
  end;
procedure QuickSort(L, R: Integer);
var
    I, J, P : Integer;
    Save : PVirtualNode;

  begin
    if FStop then
    begin
      Exit;
    end;
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while conditionI(i, p) do
          Inc(i);
        while conditionJ(j, p) do
          Dec(J);
        if I <= J then begin
          Save := ListDataPos[I];
          ListDataPos[I] := ListDataPos[J];
          ListDataPos[J] := Save;
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
  if (ListDataPos.count >1 ) then
  begin
    QuickSort(0,ListDataPos.count-1);
  end;
end;

procedure TSearchThread.SortLogical40ListPropIndexCollNew(Coll: TBaseCollection;
  propIndex: word; SortIsAsc: Boolean);
var
 ListDataPos: TList<PVirtualNode>;
 i: Integer;

procedure QuickSort(L, R: Integer);
var
    I, J, P : Integer;
    Save : TLogicalData40;
    saveList: PVirtualNode;
  begin
    repeat
      //Sleep(1);//  за тесттване на бавно сортиране
      if FStop then
      begin
        ListLog40.Clear;
        FStoped := True;
        Exit;
      end;
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        if SortIsAsc then
        begin
          while ((ListLog40[I] <= ListLog40[P]) and (ListLog40[I] <> ListLog40[P])) do Inc(I);
          while ((ListLog40[J] >= ListLog40[P]) and (ListLog40[J] <> ListLog40[P])) do Dec(J);
        end
        else
        begin
          while ((ListLog40[i] >= ListLog40[P]) and (ListLog40[I] <> ListLog40[P])) do Inc(I);
          while ((ListLog40[J] <= ListLog40[P]) and (ListLog40[J] <> ListLog40[P]))  do Dec(J);
        end;
        if I <= J then begin
          Save := ListLog40[I];
          saveList := ListDataPos[I];
          ListLog40[I] := ListLog40[J];
          ListDataPos[I] := ListDataPos[J];
          ListLog40[J] := Save;
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
  ListDataPos := Coll.ListDataPos;
  if (ListDataPos.count >1 ) then
  begin
    for i := 0 to ListDataPos.Count - 1 do
      ListLog40.Add(Coll.getLogical40Map(PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos, propIndex));
    QuickSort(0,ListLog40.count-1);
    ListLog40.Clear;
    FStoped := True;
  end;
end;

procedure TSearchThread.SortTimeListPropIndexCollNew(Coll: TBaseCollection;
  propIndex: word; SortIsAsc: Boolean);
var
 ListDataPos: TList<PVirtualNode>;
 i: Integer;

procedure QuickSort(L, R: Integer);
var
    I, J, P : Integer;
    Save : TTime;
    saveList: PVirtualNode;
  begin
    repeat
      //Sleep(1);//  за тесттване на бавно сортиране
      if FStop then
      begin
        ListTime.Clear;
        FStoped := True;
        Exit;
      end;
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        if SortIsAsc then
        begin
          while (ListTime[I])< (ListTime[P]) do Inc(I);
          while (ListTime[J]) > (ListTime[P]) do Dec(J);
        end
        else
        begin
          while (ListTime[I])> (ListTime[P]) do Inc(I);
          while (ListTime[J]) < (ListTime[P]) do Dec(J);
        end;
        if I <= J then begin
          Save := ListTime[I];
          saveList := ListDataPos[I];
          ListTime[I] := ListTime[J];
          ListDataPos[I] := ListDataPos[J];
          ListTime[J] := Save;
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
  ListDataPos := Coll.ListDataPos;
  if (ListDataPos.count >1 ) then
  begin
    for i := 0 to ListDataPos.Count - 1 do
      ListTime.Add(Coll.getTimeMap(PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos, propIndex));
    QuickSort(0,ListTime.count-1);
    ListTime.Clear;
    FStoped := True;
  end;
end;

procedure TSearchThread.SortAnsiListPropIndexCollNew(Coll: TBaseCollection; propIndex: word; SortIsAsc: Boolean);
var
 ListDataPos: TList<PVirtualNode>;
 i: Integer;

procedure QuickSort(L, R: Integer);
var
    I, J, P : Integer;
    Save : AnsiString;
    saveList: PVirtualNode;
  begin
    repeat
     // Sleep(1);//  за тесттване на бавно сортиране
      if FStop then
      begin
        ListAnsi.Clear;
        //ListAnsi.Free;
        FStoped := True;
        Exit;
      end;
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
  Stopwatch.StartNew;
  ListDataPos := Coll.ListDataPos;
  if (ListDataPos.count >1 ) then
  begin
    for i := 0 to ListDataPos.Count - 1 do
      ListAnsi.Add(Coll.getAnsiStringMap(PAspRec(Pointer(PByte(ListDataPos[i]) + lenNode)).DataPos, propIndex));
    QuickSort(0,ListAnsi.count-1);
    ListAnsi.Clear;
    //ListAnsi.Free;
    FStoped := True;
  end;
  Elapsed := Stopwatch.Elapsed;
  //ShowMessage(Format('sortInter за %f',[ Elapsed.TotalMilliseconds]));
end;

procedure TSearchThread.Start;
begin
  FStop:= True;

  IsStart := false;
end;


// === DoSearchVTR3 и помощни функции (адаптирани за новата структура) ===

function TSearchThread.DoSearchVTR3(ADBNode, FilterNode: PVirtualNode): Boolean;
var
  adbChild: PVirtualNode;
  cnt: Integer;
begin
  Stopwatch := TStopwatch.StartNew;
  adbChild := ADBNode.FirstChild;
  cnt := 0;
  while adbChild <> nil do
  begin
    if MatchNode(FilterNode, adbChild) then
    begin
      Inc(cnt);
      // тук добави добавяне към резултатите
    end;
    adbChild := adbChild.NextSibling;
  end;
  Elapsed := Stopwatch.Elapsed;
  OutputDebugString(PChar(Format('DoSearchVTR3 %d бр за total=%f', [cnt, Elapsed.TotalMilliseconds])));
  Result := True;
end;


// ---------- Вътрешни функции ----------
function TSearchThread.MatchNode(filterNode, adbNode: PVirtualNode): Boolean;
var
  fdata: PAspRecFilter;
begin
  // празна защита
  if (filterNode = nil) or (adbNode = nil) then
    Exit(False);

  fdata := Pointer(PByte(filterNode) + lenNode);

  // Ако е vvRootFilter или vvFilterItem - тръгваме от корена
  case fdata.vid of
    vvRootFilter:
      Exit(MatchRoot(filterNode, adbNode));
    vvFilterItem:
      // тикнат/нетикнат не влияе тук - при избор на филтър той ще бъде подаден като FilterNode
      Exit(MatchRoot(filterNode, adbNode));
  end;

  // Ако филтърният възел не е активен - игнорираме го
  if not IsNodeActive(filterNode) then
    Exit(True);

  // Ако е поле/група/оператор - влизаме в специалните процедури
  case fdata.vid of
    vvFieldFilter, vvFieldOrGroup:
      Exit(MatchFieldOrGroup(filterNode, adbNode));
    vvObjectGroup:
      Exit(MatchObjectOrGroup(filterNode, adbNode));
  end;

  // Ако е обектен филтърен възел (vvPatient, vvPregled...) - трябва adbNode да има съответния вид
  // но ако adbNode е самият обект (в DoSearchVTR3 adbChild е едно ниво - пациент), сравняваме вида
  if PAspRec(PByte(adbNode) + lenNode).vid <> PAspRecFilter(PByte(filterNode) + lenNode).vid then
    Exit(False);

  // рекурсивно обработваме съдържанието на обектния възел
  Result := MatchObjectNode(filterNode, adbNode);
end;


function TSearchThread.MatchRoot(FilterNode, ADBNode: PVirtualNode): Boolean;
var
  child: PVirtualNode;
  fdata: PAspRecFilter;
begin
  // FilterNode е vvRootFilter или vvFilterItem: имаме да проверим само активните му директни обектни деца
  child := FilterNode.FirstChild;
  // Ако е vvFilterItem -> неговият първи child обикновено е object root (напр. vvPatient)
  while Assigned(child) do
  begin
    fdata := Pointer(PByte(child) + lenNode);
    // Пропускаме невидими/неактивни възли
    if IsNodeActive(child) then
    begin
      // Трябва adbNode да има такъв обект (в случаят adbNode е един пациент като ADBNode)
      // Това е покрито в MatchNode - като предадем child (filter), adbNode (реален)
      if not MatchNode(child, ADBNode) then
        Exit(False);
    end;
    child := child.NextSibling;
  end;

  Result := True;
end;


function TSearchThread.MatchObjectFilter(FilterNode, ADBNode: PVirtualNode): Boolean;
begin
  // запазено за backward-compat; използваме MatchObjectNode
  Result := MatchObjectNode(FilterNode, ADBNode);
end;


function TSearchThread.MatchObjectOrGroup(FilterNode, ADBNode: PVirtualNode): Boolean;
var
  child: PVirtualNode;
  grpState: TCheckState;
  actRequired: Boolean;
  anyMatch: Boolean;
  grpChild: PVirtualNode;
  dataChild: PAspRecFilter;
  realChild: PVirtualNode;
begin
  // FilterNode тук е vvObjectGroup
  if FilterNode = nil then Exit(True);

  grpState := FilterNode.CheckState;

  // Ако групата е unchecked -> игнорираме всички object children
  if grpState = csUncheckedNormal then
    Exit(True);

  // Трето състояние (csMixed) го третираме като активен (както каза)
  // AND-логиката: за всеки CHECKED child в групата трябва да има реален adb-child който да минава match
  grpChild := FilterNode.FirstChild;
  while Assigned(grpChild) do
  begin
    dataChild := Pointer(PByte(grpChild) + lenNode);

    // гледаме само активни (чекнати) object children
    if grpChild.CheckState = csCheckedNormal then
    begin
      // търсим реален child (в adb) с такъв vid
      realChild := FindRealChild(ADBNode, dataChild.vid);
      if realChild = nil then
        Exit(False); // липсва задължително обектно дете

      // ако е намерен, трябва да мине рекурсивно
      if not MatchObjectNode(grpChild, realChild) then
        Exit(False);
    end;

    grpChild := grpChild.NextSibling;
  end;

  // всички задължителни (чекнати) групови деца са намерени и минават
  Result := True;
end;


function TSearchThread.MatchField(FilterNode, ADBNode: PVirtualNode): Boolean;
begin
  // Фаза 1: само структура - поле е валидно ако е чекнато
  Result := (FilterNode.CheckState = csCheckedNormal);
end;


function TSearchThread.MatchFieldOrGroup(FilterNode, ADBNode: PVirtualNode): Boolean;
var
  child: PVirtualNode;
begin
  // vvFieldOrGroup = OR група от полета: ако някое дете е активно и match-ва -> True
  child := FilterNode.FirstChild;
  while Assigned(child) do
  begin
    if child.CheckState = csCheckedNormal then
      if MatchField(child, ADBNode) then
        Exit(True);
    child := child.NextSibling;
  end;
  Result := False;
end;


// Търси filter-child сред children на даден filter node (по vid)
function TSearchThread.FindChildByVid(node: PVirtualNode; vid: TVtrVid): PVirtualNode;
var
  ch: PVirtualNode;
  data: PAspRecFilter;
begin
  Result := nil;
  if node = nil then Exit;
  ch := node.FirstChild;
  while Assigned(ch) do
  begin
    data := Pointer(PByte(ch) + lenNode);
    if data.vid = vid then
      Exit(ch);
    ch := ch.NextSibling;
  end;
end;


// Търси реален adb-child (върху данни) с даден vid
function TSearchThread.FindRealChild(parentAdbNode: PVirtualNode; childVid: TVtrVid): PVirtualNode;
var
  ch: PVirtualNode;
  ad: PAspRec;
begin
  Result := nil;
  if parentAdbNode = nil then Exit;
  ch := parentAdbNode.FirstChild;
  while Assigned(ch) do
  begin
    ad := Pointer(PByte(ch) + lenNode);
    if ad.vid = childVid then
      Exit(ch);
    ch := ch.NextSibling;
  end;
end;


// Полето match-ва: за сега структура-only
function TSearchThread.MatchFieldNode(filterFieldNode, adbObjectNode: PVirtualNode): Boolean;
begin
  // Поле е проверено/непроверено в IsNodeActive / GetText - тук - ако е чекнато
  Result := (filterFieldNode.CheckState = csCheckedNormal);
end;


// РЕКУРСИВНА функция за обектен възел
function TSearchThread.MatchObjectNode(filterNode, adbNode: PVirtualNode): Boolean;
var
  child: PVirtualNode;
  data: PAspRecFilter;
  objGroupNode: PVirtualNode;
  // поле: като първо преминем полетата; после object-group
begin
  Result := True;
  if (filterNode = nil) or (adbNode = nil) then Exit(False);

  // 1) fields first - ако някое поле е активно и не е намерено/не минава - fail
  child := filterNode.FirstChild;
  while Assigned(child) do
  begin
    data := Pointer(PByte(child) + lenNode);

    // полетата са vvFieldFilter или vvFieldOrGroup
    if data.vid = vvFieldFilter then
    begin
      if child.CheckState = csCheckedNormal then
      begin
        if not MatchFieldNode(child, adbNode) then
          Exit(False);
      end;
    end
    else if data.vid = vvFieldOrGroup then
    begin
      if IsNodeActive(child) then
      begin
        if not MatchFieldOrGroup(child, adbNode) then
          Exit(False);
      end;
    end
    else if data.vid = vvObjectGroup then
    begin
      // encountered object-group - break to process it after fields
      objGroupNode := child;
      Break;
    end
    else
    begin
      // Най-вероятно след полетата няма други обекти (skip); ако обаче има обектен възел директно --
      // това означава че структурата е различна — да го обработим по общия начин
      if IsNodeActive(child) then
      begin
        // ако child е обектен възел, то трябва в adbNode да има такъв child
        if not MatchNode(child, adbNode) then
          Exit(False);
      end;
    end;

    child := child.NextSibling;
  end;

  // 2) AFTER fields: process object group (if any)
  if Assigned(objGroupNode) then
  begin
    if not MatchObjectOrGroup(objGroupNode, adbNode) then
      Exit(False);
  end;

  // 3) success
  Result := True;
end;


// Активност на възел: дали участва в логиката
function TSearchThread.IsNodeActive(node: PVirtualNode): Boolean;
var
  data: PAspRecFilter;
  ch: PVirtualNode;
begin
  Result := False;
  if node = nil then Exit;

  data := Pointer(PByte(node) + lenNode);

  case data.vid of
    vvFieldFilter:
      Exit(node.CheckState = csCheckedNormal);

    vvFieldOrGroup:
    begin
      ch := node.FirstChild;
      while Assigned(ch) do
      begin
        if IsNodeActive(ch) then Exit(True);
        ch := ch.NextSibling;
      end;
      Exit(False);
    end;

    vvObjectGroup:
    begin
      // Ако group е unchecked => не е активна
      if node.CheckState = csUncheckedNormal then
        Exit(False);
      // ако е checked или mixed => активна (ще се обработва)
      Exit(True);
    end;

    // обектен възел: активен ако някое поле вътре е активно или object-group е активно
    else
    begin
      ch := node.FirstChild;
      while Assigned(ch) do
      begin
        if IsNodeActive(ch) then Exit(True);
        ch := ch.NextSibling;
      end;
      Exit(False);
    end;
  end;
end;


// дали има активни филтри в дървото (helper)
function TSearchThread.HasActiveFiltersInSubtree(node: PVirtualNode): Boolean;
var
  ch: PVirtualNode;
begin
  if node = nil then Exit(False);
  ch := node.FirstChild;
  while Assigned(ch) do
  begin
    if IsNodeActive(ch) then Exit(True);
    if HasActiveFiltersInSubtree(ch) then Exit(True);
    ch := ch.NextSibling;
  end;
  Result := False;
end;


end.
