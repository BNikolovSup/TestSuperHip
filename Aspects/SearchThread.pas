unit SearchThread;
           //bot
interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Winapi.Messages,
  system.Diagnostics, system.TimeSpan, Winapi.ActiveX, VirtualTrees, VirtualStringTreeAspect,
  VirtualStringTreeHipp, RealObj.RealHipp, System.Generics.Collections,
  Aspects.Types, Aspects.Collections, VCLTee.Grid,
  Table.PatientNew, Table.PregledNew, Table.Doctor, Table.Diagnosis, Table.ExamImmunization

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

    procedure SetNodeADB(const Value: PVirtualNode);
    procedure SetSearchedText(const Value: string);
    procedure SortListDataPos(ListDataPos: TList<PAspRec>);
    procedure SortListDataPosColl(ListDataPos: TList<PAspRec>);
    procedure SortCollByPropertyAnsiStr(coll: TBaseCollection);

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
    CollPat: TPatientNewColl;
    collPreg: TPregledNewColl;
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
    property NodeADB_: PVirtualNode read FNodeADB write SetNodeADB;
    property OnShowGrid: TNotifyEvent read FOnShowGrid write FOnShowGrid;
    property IsClose: Boolean read FIsClose write FIsClose;
    property CntPregInPat: Integer read FCntPregInPat write FCntPregInPat;
    property CntDiagInPreg: Integer read FCntDiagInPreg write FCntDiagInPreg;
    property CntImunInPreg: Integer read FCntImunInPreg write FCntImunInPreg;
  end;
implementation

{ TSearchThread }

procedure TSearchThread.CalcArrayPropSearch;
var
  i, j: Integer;
begin
  j := 0;
  SetLength(collPat.ArrPropSearchClc, 0);
  for i := 0 to Length(collPat.ArrPropSearch) - 1 do
  begin
    if collPat.ArrPropSearch[i] in collPat.PRecordSearch.setProp then
    begin
      SetLength(collPat.ArrPropSearchClc, j + 1);
      collPat.ArrPropSearchClc[j] := collPat.ArrPropSearch[i];
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
  SetLength(collPreg.ArrPropSearchClc, 0);
  for i := 0 to Length(collPreg.ArrPropSearch) - 1 do
  begin
    if collPreg.ArrPropSearch[i] in collPreg.PRecordSearch.setProp then
    begin
      SetLength(collPreg.ArrPropSearchClc, j + 1);
      collPreg.ArrPropSearchClc[j] := collPreg.ArrPropSearch[i];
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
  FStoped := False;
  FIsClose := False;
  FcntPregInPat := -1;
  FCntImunInPreg := -1;

end;

destructor TSearchThread.Destroy;
begin

  inherited;
end;


procedure TSearchThread.DoSearchVTR2;
var
  i, iVid: Integer;
  linkPos: Cardinal;
  pCardinalData: ^Cardinal;
  FPosLinkData: Cardinal;
  FPosDataADB: Cardinal;
  data: PAspRec;

  node, patNode, pregNode, mkbNode: PVirtualNode;
  FindedPregNode: PVirtualNode;
  dataPat, dataRunPreg, dataDiag: PAspRec;
  dataPreg: PAspRec;
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
  collPreg.ListDataPos.Clear;
  collPat.ListDataPos.Clear;
  CalcArrayPropSearch;

  patNode := node.FirstChild;
  while patNode <> nil do // loop pat
  begin
    if FStop then
    begin
      collPreg.ListDataPos.Clear;
      collPat.ListDataPos.Clear;
      if Assigned(FOnShowGrid) then
        FOnShowGrid(Self);
      Exit;
    end;
    CollPat.Tag := -1;
    dataPat := pointer(PByte(patNode) + lenNode);
    tempPat.DataPos := dataPat.DataPos;
    egn := tempPat.getAnsiStringMap(BufADB, FPosDataADB, word(PatientNew_EGN));
    if tempPat.IsFullFinded(Self.BufADB, FPosDataADB, CollPat) then
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
            if CollPat.Tag < 0 then
            begin
              CollPat.Tag := 0;
            end;
            dataPreg := dataRunPreg;
            temppreg.DataPos := dataRunPreg.DataPos;
            if temppreg.IsFullFinded(Self.BufADB, FPosDataADB, collPreg) then
            begin
              AcntImunInPreg := 0;
              mkbNode := pregNode.FirstChild;
              while mkbNode <> nil do // loop diag
              begin
                dataDiag := pointer(PByte(mkbNode) + lenNode);
                case dataDiag.vid of
                  vvDiag:
                  begin
                    //if FindedPregNode = nil then Break;

                    tempDiag.DataPos := dataDiag.DataPos;
                    if not tempDiag.IsFullFinded(Self.BufADB, FPosDataADB, nil) then
                    begin
                      FindedPregNode := nil;
                    end
                    else
                    begin
                      //inc(AcntPregInPat);
                    end;
                    //if tempDiag.IsFullFinded(Self.BufADB, FPosDataADB, nil) then
//                    begin
//                      collPreg.ListDataPos.Add(dataPreg);
//                      inc(AcntPregInPat);
//                      CollPat.Tag := CollPat.Tag + 1;
//                      Break;
//                    end;
                  end;
                  vvExamImun:
                  begin
                    //if FindedPregNode = nil then Break;
                    tempImun.DataPos := dataDiag.DataPos;
                    if not tempImun.IsFullFinded(Self.BufADB, FPosDataADB, CollExamImun) then
                    begin
                      FindedPregNode := nil;
                    end
                    else
                    begin
                      Inc(AcntImunInPreg)
                    end;
                  end;
                end;
                mkbNode := mkbNode.NextSibling;
              end;
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
          if (AcntImunInPreg > -1) and (dataPreg <> nil) then
          begin
            collPreg.ListDataPos.Add(dataPreg);
            inc(AcntPregInPat);
          end;
          //CollPat.Tag := CollPat.Tag + 1;
        end;
        pregNode := pregNode.NextSibling;
        FindedPregNode := pregNode;
      end;
    end
    else
    begin
      Self.bufLink := Self.bufLink;
      CollPat.Tag := -2;
    end;
    case CollPat.tag of
      -2: //не е изпълнено условието за пациента
      begin
        CollPat.Tag := -2;
      end;
      -1: //изпълнено е условието за пациента, но няма прегледи
      begin
        collPat.ListDataPos.Add(dataPat);
      end;
      0: // има прегледи, но не е изпълнено условието за прегледите или по нататък
      begin
        CollPat.Tag := 0;
      end;
    else
      begin
        if (FcntPregInPat > -1)  then
        begin
          if (FcntPregInPat = AcntPregInPat) then
          begin
            collPat.ListDataPos.Add(dataPat);
          end
          else
          begin
            for I := 1 to AcntPregInPat do
            begin
              collPreg.ListDataPos.Delete(collPreg.ListDataPos.Count - 1);
            end;
          end;
        end
        else
        if (FCntImunInPreg > -1)  then
        begin
          if (FCntImunInPreg = ACntImunInPreg) then
          begin
            collPat.ListDataPos.Add(dataPat);
          end
          else
          begin
            for I := 1 to ACntImunInPreg do
            begin
              collPreg.ListDataPos.Delete(collPreg.ListDataPos.Count - 1);
            end;
          end;
        end
        else
        begin
          collPat.ListDataPos.Add(dataPat);
        end;
      end;

    end;

    patNode := patNode.NextSibling;
  end;

  if (collPreg.ListDataPos.Count > 0) or (CollPat.ListDataPos.Count > 0) then
  begin
    Stopwatch := TStopwatch.StartNew;
    SortListDataPosColl(collPreg.ListDataPos);
    Elapsed := Stopwatch.Elapsed;
    //mmoTest.Lines.Add( Format('grdSearchSelect за %f',[ Elapsed.TotalMilliseconds]));
    if Assigned(FOnShowGrid) then
      FOnShowGrid(Self);
  end
  else
  begin
    collPat.ListDataPos.Clear;
    collPreg.ListDataPos.Clear;
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
    CollForFind.ListDataPos.Add(Adata);
end;

procedure TSearchThread.SetNodeADB(const Value: PVirtualNode);
begin
  FNodeADB := Value;
end;

procedure TSearchThread.SetSearchedText(const Value: string);
begin

end;

procedure TSearchThread.SortCollByPropertyAnsiStr(coll: TBaseCollection);
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
        while coll.getAnsiStringMap(TBaseItem(coll.Items[I]).FDataPos, Word(PregledNew_ANAMN)) <
              coll.getAnsiStringMap(TBaseItem(coll.Items[P]).FDataPos, Word(PregledNew_ANAMN)) do Inc(I);
        while coll.getAnsiStringMap(TBaseItem(coll.Items[J]).FDataPos, Word(PregledNew_ANAMN))  >
              coll.getAnsiStringMap(TBaseItem(coll.Items[P]).FDataPos, Word(PregledNew_ANAMN)) do Dec(J);
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
        while collPreg.getAnsiStringMap(ListDataPos[I].DataPos, Word(PregledNew_NRN)) <
              collPreg.getAnsiStringMap(ListDataPos[P].DataPos, Word(PregledNew_NRN)) do Inc(I);
        while collPreg.getAnsiStringMap(ListDataPos[J].DataPos, Word(PregledNew_NRN))  >
              collPreg.getAnsiStringMap(ListDataPos[P].DataPos, Word(PregledNew_NRN)) do Dec(J);
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

procedure TSearchThread.SortListDataPosColl(ListDataPos: TList<PAspRec>);
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
        while (ListDataPos[I]).DataPos > (ListDataPos[P]).DataPos do Inc(I);
        while (ListDataPos[J]).DataPos < (ListDataPos[P]).DataPos do Dec(J);
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

procedure TSearchThread.Start;
begin
  FStop:= True;

  IsStart := false;
end;

end.
