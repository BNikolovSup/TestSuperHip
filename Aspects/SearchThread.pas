unit SearchThread;
           //showmess
interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  system.Diagnostics, system.TimeSpan, Winapi.ActiveX, VirtualTrees, VirtualStringTreeAspect,
  VirtualStringTreeHipp, RealObj.RealHipp, System.Generics.Collections,
  Aspects.Types, Aspects.Collections, VCLTee.Grid, Vcl.Dialogs,
  Table.PatientNew, Table.PregledNew, Table.Doctor, Table.Diagnosis, Table.ExamImmunization,
  RTTI, Winapi.Windows
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
    FNodeADB: PVirtualNode;
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

    procedure SetNodeADB(const Value: PVirtualNode);
    procedure SetSearchedText(const Value: string);
    procedure SortListDataPos(ListDataPos: TList<PAspRec>);
    procedure SortListDataPosColl(ListDataPos: TList<PVirtualNode>);
    procedure SortListPropIndexColl(ListDataPos: TList<PVirtualNode>);
    procedure SortAnsiListPropIndexCollNew(Coll: TBaseCollection; propIndex: word; SortIsAsc: Boolean);
    procedure SortIntListPropIndexCollNew(Coll: TBaseCollection; propIndex: word; SortIsAsc: Boolean);
    procedure SortDateListPropIndexCollNew(Coll: TBaseCollection; propIndex: word; SortIsAsc: Boolean);
    procedure SortTimeListPropIndexCollNew(Coll: TBaseCollection; propIndex: word; SortIsAsc: Boolean);
    procedure SortLogical40ListPropIndexCollNew(Coll: TBaseCollection; propIndex: word; SortIsAsc: Boolean);

    procedure SortCollByPropertyAnsiStr(coll: TBaseCollection; SortAsc: boolean = true);
    procedure SetcollPreg(const Value: TPregledNewColl);
    procedure DoCollPregSort(senedr: TObject);
    procedure SetcollPat(const Value: TPatientNewColl);

  protected
    Stopwatch: TStopwatch;
    Elapsed: TTimeSpan;
    ArrVidSearch: TArray<TAspRec>;
    procedure Execute; override;
    procedure DoTerminate; override;
    procedure DoSearchVTR2;
    procedure CalcArrayPropSearch;

    procedure IterateChild(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);

  public
    RunItem: TRunItem;
    VTR_searched: TVirtualStringTreeHipp;
    CollForFind: TBaseCollection;


    CollExamImun: TExamImmunizationColl;
    //collPatForSearch: TPatientNewColl;
    //collPregForSearch: TRealPregledNewColl;
    //Tempitem: TBaseItem;
    //FieldForFind: Word;
    vtr: TVirtualStringTreeAspect;
    bufLink: Pointer;
    BufADB: Pointer;
    FPosData: Cardinal;
    grdSearch: TTeeGrid;


    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    procedure Start;

    //property SearchedText: string read FSearchedText write SetSearchedText;
    property collPreg: TPregledNewColl read FcollPreg write SetcollPreg;
    property collPat: TPatientNewColl read FCollPat write SetcollPat;

    property NodeADB_: PVirtualNode read FNodeADB write SetNodeADB;
    property OnShowGrid: TNotifyEvent read FOnShowGrid write FOnShowGrid;
    property IsClose: Boolean read FIsClose write FIsClose;
    property CntPregInPat: Integer read FCntPregInPat write FCntPregInPat;
    property CntDiagInPreg: Integer read FCntDiagInPreg write FCntDiagInPreg;
    property CntImunInPreg: Integer read FCntImunInPreg write FCntImunInPreg;
    property OnlySort: Boolean read FOnlySort write FOnlySort;
    property IsSorting: Boolean read FIsSorting write FIsSorting;
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
  SetLength(CollExamImun.ArrPropSearchClc, 0);
  for i := 0 to Length(CollExamImun.ArrPropSearch) - 1 do
  begin
    if CollExamImun.ArrPropSearch[i] in CollExamImun.PRecordSearch.setProp then
    begin
      SetLength(CollExamImun.ArrPropSearchClc, j + 1);
      CollExamImun.ArrPropSearchClc[j] := CollExamImun.ArrPropSearch[i];
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

constructor TSearchThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FNodeADB := nil;
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


procedure TSearchThread.DoCollPregSort(senedr: TObject);
begin
  Self.OnlySort := True;
  Self.Start;
end;

procedure TSearchThread.DoSearchVTR2;
var
  i, iVid, testCnt: Integer;
  linkPos: Cardinal;
  pCardinalData: ^Cardinal;
  FPosLinkData: Cardinal;
  FPosDataADB: Cardinal;
  data: PAspRec;

  node, patNode, pregNode, mkbNode: PVirtualNode;
  FindedPregNode: PVirtualNode;
  dataPat, dataRunPreg, dataDiag: PAspRec;
  dataPreg, dataTest: PAspRec;
  tempPat: TPatientNewItem;
  temppreg: TRealPregledNewItem;
  tempDoctor: TDoctorItem;
  tempDiag: TDiagnosisItem;
  tempImun: TRealExamImmunizationItem;
  egn, anamn, uin, diag: string;
  AcntPregInPat, AcntImunInPreg: Integer;
begin
  FStop := False;

  linkPos := 100;
  testCnt := 0;

  pCardinalData := pointer(PByte(bufLink));
  FPosLinkData := pCardinalData^;
  pCardinalData := pointer(PByte(BufADB) + 8);
  FPosDataADB := pCardinalData^;
  node := pointer(PByte(bufLink) + linkpos);
  data := pointer(PByte(node) + lenNode);

  //node := pointer(PByte(bufLink) + 100);

  tempPat := TPatientNewItem.Create(nil);
  //tempPat.CollFromSearch := collPatForSearch;
  temppreg := TRealPregledNewItem.Create(nil);
  //temppreg.CollFromSearch := collPregForSearch;
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
    if tempPat.IsFullFinded(Self.BufADB, FPosDataADB, FCollPat) then
    begin
      pregNode := patNode.FirstChild;
      FindedPregNode := pregNode;
      AcntPregInPat := 0;

      while pregNode <> nil do  // loop child
      begin
        dataRunPreg := pointer(PByte(pregNode) + lenNode);
        dataPreg := nil;
        case dataRunPreg.vid of
          vvPregled:   // ако е преглед
          begin
            FindedPregNode := pregNode;
            if FCollPat.Tag < 0 then
            begin
              FCollPat.Tag := 0;
            end;
            dataPreg := dataRunPreg;
            temppreg.DataPos := dataRunPreg.DataPos;
            if temppreg.IsFullFinded(Self.BufADB, FPosDataADB, FcollPreg) then
            begin
              AcntImunInPreg := 0;
              mkbNode := pregNode.FirstChild;
              //while mkbNode <> nil do // loop diag
//              begin
//                dataDiag := pointer(PByte(mkbNode) + lenNode);
//                case dataDiag.vid of
//                  vvDiag:
//                  begin
//                    //if FindedPregNode = nil then Break;
//
//                    tempDiag.DataPos := dataDiag.DataPos;
//                    if not tempDiag.IsFullFinded(Self.BufADB, FPosDataADB, nil) then
//                    begin
//                      FindedPregNode := nil;
//                    end
//                    else
//                    begin
//                      //inc(AcntPregInPat);
//                    end;
//                    //if tempDiag.IsFullFinded(Self.BufADB, FPosDataADB, nil) then
////                    begin
////                      collPreg.ListDataPos.Add(dataPreg);
////                      inc(AcntPregInPat);
////                      CollPat.Tag := CollPat.Tag + 1;
////                      Break;
////                    end;
//                  end;
//                  vvExamImun:
//                  begin
//                    //if FindedPregNode = nil then Break;
//                    tempImun.DataPos := dataDiag.DataPos;
//                    if not tempImun.IsFullFinded(Self.BufADB, FPosDataADB, CollExamImun) then
//                    begin
//                      FindedPregNode := nil;
//                    end
//                    else
//                    begin
//                      Inc(AcntImunInPreg)
//                    end;
//                  end;
//                end;
//                mkbNode := mkbNode.NextSibling;
//              end;
            end
            else
            begin
              FindedPregNode := nil;
            end;
          end;
          vvDoctor:
          begin
            tempDoctor.DataPos := dataRunPreg.DataPos;
            uin := tempDoctor.getAnsiStringMap(BufADB, FPosDataADB, word(Doctor_UIN));
          end;
        end;
        if FindedPregNode <> nil then
        begin
          //if (AcntImunInPreg > -1) and (dataPreg <> nil) then
          if (dataPreg <> nil) then
          begin

            FcollPreg.ListDataPos.Add(FindedPregNode);
            inc(testCnt);
            dataTest := Pointer(pbyte(FindedPregNode) + lenNode);
            if dataTest.vid <> vvPregled then
              uin := 'ddd';
            inc(AcntPregInPat);
          end;
          CollPat.Tag := CollPat.Tag + 1;
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
        //FCollPat.ListDataPos.Add(patNode);

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
    SortListDataPosColl(collPreg.ListDataPos);
    //SortListPropIndexCollNew(FcollPreg, Word(PregledNew_ANAMN));
    Elapsed := Stopwatch.Elapsed;
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

procedure TSearchThread.DoTerminate;
begin
  inherited;

end;

procedure TSearchThread.Execute;
var
  comInitStatus: THandle;
  fieldType: string;
  propIndex: Word;
  propType: TAsectTypeKind;
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

              case TVtrVid(grdSearch.Tag) of
                vvPregled:
                begin
                  propIndex := collPreg.ArrayPropOrderSearchOptions[collPreg.ColumnForSort];
                  propType := collPreg.PropType(propIndex);
                  case propType of
                    actAnsiString: SortAnsiListPropIndexCollNew(collPreg, propIndex, collPreg.SortAsc);
                    actInteger: SortIntListPropIndexCollNew(collPreg, propIndex, collPreg.SortAsc);
                    actTDate: SortDateListPropIndexCollNew(collPreg, propIndex, collPreg.SortAsc);
                    actTime: SortTimeListPropIndexCollNew(collPreg, propIndex, collPreg.SortAsc);
                    actLogical: SortLogical40ListPropIndexCollNew(collPreg, propIndex, collPreg.SortAsc);
                  end;

                end;
                vvPatient:
                begin
                  propIndex := collPat.ArrayPropOrderSearchOptions[collPat.ColumnForSort];
                  propType := collPat.PropType(propIndex);
                  case propType of
                    actAnsiString: SortAnsiListPropIndexCollNew(collPat, propIndex, collPat.SortAsc);
                    actInteger: SortIntListPropIndexCollNew(collPat, propIndex, collPat.SortAsc);
                    actTDate: SortDateListPropIndexCollNew(collPat, propIndex, collPat.SortAsc);
                    actTime: SortTimeListPropIndexCollNew(collPat, propIndex, collPat.SortAsc);
                    actLogical: SortLogical40ListPropIndexCollNew(collPat, propIndex, collPreg.SortAsc);
                  end;

                end;
              end;

              grdSearch.Repaint;
              FIsSorting := false;
              grdSearch.Cursor :=  crDefault;
              Elapsed := Stopwatch.Elapsed;
              fieldType := TRttiEnumerationType.GetName(TPregledNewItem.TPropertyIndex(collPreg.ColumnForSort));
             // ShowMessage(Format('sort %s за %f',[fieldType, Elapsed.TotalMilliseconds]));
            end;
            //mmoTest.Lines.Add( Format('grdSearchSelect за %f',[ Elapsed.TotalMilliseconds]));
          end
          else
            DoSearchVTR2;
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

procedure TSearchThread.SetNodeADB(const Value: PVirtualNode);
begin
  FNodeADB := Value;
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
end;

procedure TSearchThread.Start;
begin
  FStop:= True;

  IsStart := false;
end;

end.
