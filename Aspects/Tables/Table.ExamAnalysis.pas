unit Table.ExamAnalysis;

interface
uses
  Aspects.Collections, Aspects.Types, Aspects.Functions, Vcl.Dialogs,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control, System.Generics.Defaults;

type
TCollectionForSort = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList<TCollectionItem>;
  end;

TFindedResult = record
  PropIndex: Word;
  DataPos: Cardinal;
end;

TTeeGRD = class(VCLTee.Grid.TTeeGrid);

TLogicalExamAnalysis = (
    Is_);
TlogicalExamAnalysisSet = set of TLogicalExamAnalysis;


TExamAnalysisItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       ExamAnalysis_DATA
       , ExamAnalysis_ID
       , ExamAnalysis_NZIS_CODE_CL22
       , ExamAnalysis_NZIS_DESCRIPTION_CL22
       , ExamAnalysis_RESULT
       , ExamAnalysis_PosDataNomen
       , ExamAnalysis_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecExamAnalysis = ^TRecExamAnalysis;
      TRecExamAnalysis = record
        DATA: TDate;
        ID: integer;
        NZIS_CODE_CL22: AnsiString;
        NZIS_DESCRIPTION_CL22: AnsiString;
        RESULT: AnsiString;
        PosDataNomen: cardinal;
        Logical: TlogicalExamAnalysisSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecExamAnalysis;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertExamAnalysis;
    procedure UpdateExamAnalysis;
    procedure SaveExamAnalysis(var dataPosition: Cardinal)overload;
	procedure SaveExamAnalysis(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TExamAnalysisColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TExamAnalysisItem;
    function GetItem(Index: Integer): TExamAnalysisItem;
    procedure SetItem(Index: Integer; const Value: TExamAnalysisItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TExamAnalysisItem>;
    ListExamAnalysisSearch: TList<TExamAnalysisItem>;
	PRecordSearch: ^TExamAnalysisItem.TRecExamAnalysis;
    ArrPropSearch: TArray<TExamAnalysisItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TExamAnalysisItem.TPropertyIndex>;
	VisibleColl: TExamAnalysisItem.TSetProp;
	ArrayPropOrder: TArray<TExamAnalysisItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TExamAnalysisItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; ExamAnalysis: TExamAnalysisItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; ExamAnalysis: TExamAnalysisItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TExamAnalysisItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;
	procedure DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);override;

	function DisplayName(propIndex: Word): string; override;
	function DisplayLogicalName(flagIndex: Integer): string;
	function RankSortOption(propIndex: Word): cardinal; override;
    function FindRootCollOptionNode(): PVirtualNode; override;
    function FindSearchFieldCollOptionGridNode(): PVirtualNode;
    function FindSearchFieldCollOptionCOTNode(): PVirtualNode;
    function FindSearchFieldCollOptionNode(): PVirtualNode;
    function CreateRootCollOptionNode(): PVirtualNode;
    procedure OrderFieldsSearch1(Grid: TTeeGrid);override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TExamAnalysisItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TExamAnalysisItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TExamAnalysisItem.TPropertyIndex);
    property Items[Index: Integer]: TExamAnalysisItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalExamAnalysisSet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
  end;

implementation

{ TExamAnalysisItem }

constructor TExamAnalysisItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TExamAnalysisItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TExamAnalysisItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
var
  paramField: TParamProp;
  setPropPat: TSetProp;
  i: Integer;
  PropertyIndex: TPropertyIndex;
begin
  i := 0;
  for paramField in SetOfProp do
  begin
    PropertyIndex := TPropertyIndex(byte(paramField));
    Include(Self.PRecord.setProp, PropertyIndex);
    //case PropertyIndex of
      //PatientNew_EGN: Self.PRecord.EGN := arrstr[i];
    //end;
    inc(i);
  end;
end;

function TExamAnalysisItem.GetCollType: TCollectionsType;
begin
  Result := ctExamAnalysis;
end;

function TExamAnalysisItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TExamAnalysisItem.InsertExamAnalysis;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctExamAnalysis;
  pCardinalData := pointer(PByte(buf));
  FPosMetaData := pCardinalData^;
  pCardinalData := pointer(PByte(buf) + 4);
  FLenMetaData := pCardinalData^;
  metaPosition :=  FPosMetaData + FLenMetaData;

  pCardinalData := pointer(PByte(buf) + 8);
  FPosData := pCardinalData^;
  pCardinalData := pointer(PByte(buf) + 12);
  FLenData := pCardinalData^;
  dataPosition :=  FPosData + FLenData;
  SaveAnyStreamCommand(@PRecord.setProp, SizeOf(PRecord.setProp), CollType, toInsert, FVersion, metaPosition + 4);
  case FVersion of
    0:
    begin
      pWordData := pointer(PByte(buf) + metaPosition);
      pWordData^  := word(CollType);
      pWordData := pointer(PByte(buf) + metaPosition + 2);
      pWordData^  := FVersion;
      inc(metaPosition, 4);
	  Self.DataPos := metaPosition;
	  
      for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
      begin
        if Assigned(PRecord) and (propIndx in PRecord.setProp) then
        begin
          case propIndx of
            ExamAnalysis_DATA: SaveData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_NZIS_CODE_CL22: SaveData(PRecord.NZIS_CODE_CL22, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_NZIS_DESCRIPTION_CL22: SaveData(PRecord.NZIS_DESCRIPTION_CL22, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_RESULT: SaveData(PRecord.RESULT, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_PosDataNomen: SaveData(PRecord.PosDataNomen, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
          end;
        end
        else
        begin
          SaveNull(metaPosition);
        end;
      end;
      pCardinalData := pointer(PByte(buf) + 4);
      pCardinalData^  := metaPosition - FPosMetaData;
      pCardinalData := pointer(PByte(buf) + 12);
      pCardinalData^  := dataPosition - FPosData;
    end;
  end;
end;

function  TExamAnalysisItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TExamAnalysisItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TExamAnalysisItem;
begin
  Result := True;
  for i := 0 to Length(TExamAnalysisColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TExamAnalysisColl(coll).ArrPropSearchClc[i];
	ATempItem := TExamAnalysisColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        ExamAnalysis_DATA: Result := IsFinded(ATempItem.PRecord.DATA, buf, FPosDataADB, word(ExamAnalysis_DATA), cot);
            ExamAnalysis_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(ExamAnalysis_ID), cot);
            ExamAnalysis_NZIS_CODE_CL22: Result := IsFinded(ATempItem.PRecord.NZIS_CODE_CL22, buf, FPosDataADB, word(ExamAnalysis_NZIS_CODE_CL22), cot);
            ExamAnalysis_NZIS_DESCRIPTION_CL22: Result := IsFinded(ATempItem.PRecord.NZIS_DESCRIPTION_CL22, buf, FPosDataADB, word(ExamAnalysis_NZIS_DESCRIPTION_CL22), cot);
            ExamAnalysis_RESULT: Result := IsFinded(ATempItem.PRecord.RESULT, buf, FPosDataADB, word(ExamAnalysis_RESULT), cot);
            ExamAnalysis_PosDataNomen: Result := IsFinded(ATempItem.PRecord.PosDataNomen, buf, FPosDataADB, word(ExamAnalysis_PosDataNomen), cot);
            ExamAnalysis_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(ExamAnalysis_Logical), cot);
      end;
    end;
  end;
end;

procedure TExamAnalysisItem.SaveExamAnalysis(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveExamAnalysis(dataPosition);
end;

procedure TExamAnalysisItem.SaveExamAnalysis(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctExamAnalysis;
  SaveAnyStreamCommand(@PRecord.setProp, SizeOf(PRecord.setProp), CollType, toUpdate, FVersion, dataPosition);
  case FVersion of
    0:
    begin
      for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
      begin
        if propIndx in PRecord.setProp then
        begin
          SaveHeaderData(PropPosition, dataPosition);
          metaPosition := FDataPos + 4 * Integer(propIndx);
          case propIndx of
            ExamAnalysis_DATA: SaveData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_NZIS_CODE_CL22: SaveData(PRecord.NZIS_CODE_CL22, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_NZIS_DESCRIPTION_CL22: SaveData(PRecord.NZIS_DESCRIPTION_CL22, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_RESULT: SaveData(PRecord.RESULT, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_PosDataNomen: SaveData(PRecord.PosDataNomen, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
          end;
        end
        else
        begin
          //SaveNull(metaPosition);
        end;
      end;
      Dispose(PRecord);
      PRecord := nil;
    end;
  end;
end;

procedure TExamAnalysisItem.UpdateExamAnalysis;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctExamAnalysis;
  case FVersion of
    0:
    begin
      for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
      begin
        if propIndx in PRecord.setProp then
        begin
          UpdateHeaderData(PropPosition, dataPosition);
          metaPosition := FDataPos + 4 * Integer(propIndx);
          case propIndx of
            ExamAnalysis_DATA: UpdateData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_NZIS_CODE_CL22: UpdateData(PRecord.NZIS_CODE_CL22, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_NZIS_DESCRIPTION_CL22: UpdateData(PRecord.NZIS_DESCRIPTION_CL22, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_RESULT: UpdateData(PRecord.RESULT, PropPosition, metaPosition, dataPosition);
            ExamAnalysis_PosDataNomen: UpdateData(PRecord.PosDataNomen, PropPosition, metaPosition, dataPosition);
          end;
        end
        else
        begin
          //SaveNull(metaPosition);
        end;
      end;
      Dispose(PRecord);
      PRecord := nil;
    end;
  end;
end;

{ TExamAnalysisColl }

function TExamAnalysisColl.AddItem(ver: word): TExamAnalysisItem;
begin
  Result := TExamAnalysisItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TExamAnalysisColl.AddItemForSearch: Integer;
var
  ItemForSearch: TExamAnalysisItem;
begin
  ItemForSearch := TExamAnalysisItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TExamAnalysisColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
var
  run: PVirtualNode;
  data: PAspRec;
begin
  VisibleColl := [];

  run := RootNode.FirstChild;
  while run <> nil do
  begin
    data := PAspRec(PByte(run) + lenNode);

    if run.CheckState = csCheckedNormal then
      Include(VisibleColl, TExamAnalysisItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TExamAnalysisColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvExamAnalysisRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
  linkOptions.AddNewNode(vvOptionSearchGrid, 0, Result , amAddChildLast, vOptionSearchGrid, linkPos);
  linkOptions.AddNewNode(vvOptionSearchCot, 0, Result , amAddChildLast, vOptionSearchCOT, linkPos);

  vOptionSearchGrid.CheckType := ctTriStateCheckBox;

  if vOptionSearchGrid.ChildCount <> FieldCount then
  begin
    for i := 0 to FieldCount - 1 do
    begin
      linkOptions.AddNewNode(vvFieldSearchGridOption, 0, vOptionSearchGrid , amAddChildLast, run, linkPos);
      run.Dummy := i + 1;
	  run.CheckType := ctCheckBox;
      run.CheckState := csCheckedNormal;
    end;
  end
  else
  begin
    // при евентуално добавена колонка...
  end;  
end;

procedure TExamAnalysisColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TExamAnalysisItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (ExamAnalysis_DATA in tempItem.PRecord.setProp) and (tempItem.PRecord.DATA <> Self.getDateMap(tempItem.DataPos, word(ExamAnalysis_DATA))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamAnalysis_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.ID <> Self.getIntMap(tempItem.DataPos, word(ExamAnalysis_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamAnalysis_NZIS_CODE_CL22 in tempItem.PRecord.setProp) and (tempItem.PRecord.NZIS_CODE_CL22 <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamAnalysis_NZIS_CODE_CL22))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamAnalysis_NZIS_DESCRIPTION_CL22 in tempItem.PRecord.setProp) and (tempItem.PRecord.NZIS_DESCRIPTION_CL22 <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamAnalysis_NZIS_DESCRIPTION_CL22))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamAnalysis_RESULT in tempItem.PRecord.setProp) and (tempItem.PRecord.RESULT <> Self.getAnsiStringMap(tempItem.DataPos, word(ExamAnalysis_RESULT))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamAnalysis_PosDataNomen in tempItem.PRecord.setProp) and (tempItem.PRecord.PosDataNomen <> Self.getIntMap(tempItem.DataPos, word(ExamAnalysis_PosDataNomen))) then
  begin
    inc(cnt);
    exit;
  end;

  if (ExamAnalysis_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(ExamAnalysis_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TExamAnalysisColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TExamAnalysisItem.Create(nil);
  ListExamAnalysisSearch := TList<TExamAnalysisItem>.Create;
  ListForFinder := TList<TExamAnalysisItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TExamAnalysisColl.destroy;
begin
  FreeAndNil(ListExamAnalysisSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TExamAnalysisColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TExamAnalysisItem.TPropertyIndex(propIndex) of
    ExamAnalysis_DATA: Result := 'DATA';
    ExamAnalysis_ID: Result := 'ID';
    ExamAnalysis_NZIS_CODE_CL22: Result := 'NZIS_CODE_CL22';
    ExamAnalysis_NZIS_DESCRIPTION_CL22: Result := 'NZIS_DESCRIPTION_CL22';
    ExamAnalysis_RESULT: Result := 'RESULT';
    ExamAnalysis_PosDataNomen: Result := 'PosDataNomen';
    ExamAnalysis_Logical: Result := 'Logical';
  end;
end;

function TExamAnalysisColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'Is_';
  else
    Result := '???';
  end;
end;


procedure TExamAnalysisColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
var
  FieldCollOptionNode, run: PVirtualNode;
  pSource, pTarget: PVirtualNode;
begin
  inherited;
  if linkOptions = nil then Exit;

  FieldCollOptionNode := FindSearchFieldCollOptionGridNode;
  run := FieldCollOptionNode.FirstChild;
  pSource := nil;
  pTarget := nil;
  while run <> nil do
  begin
    if run.Index = NewPos - 1 then
    begin
      pTarget := run;
    end;
    if run.index = OldPos - 1 then
    begin
      pSource := run;
    end;
    run := run.NextSibling;
  end;

  if pTarget = nil then Exit;
  if pSource = nil then Exit;
  //ShowMessage(Format('pSource = %d, pTarget = %d', [pSource.Index, pTarget.Index]));
  if pSource.Index < pTarget.Index then
  begin
    linkOptions.FVTR.MoveTo(pSource, pTarget, amInsertAfter, False);
  end
  else
  begin
    linkOptions.FVTR.MoveTo(pSource, pTarget, amInsertBefore, False);
  end;
  run := FieldCollOptionNode.FirstChild;
  while run <> nil do
  begin
    ArrayPropOrderSearchOptions[run.index + 1] :=  run.Dummy - 1;
    run := run.NextSibling;
  end; 
end;


function TExamAnalysisColl.FieldCount: Integer; 
begin
  inherited;
  Result := 7;
end;

function TExamAnalysisColl.FindRootCollOptionNode(): PVirtualNode;
var
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  PosLinkData: Cardinal;
  Run: PVirtualNode;
  data: PAspRec;
begin
  Result := nil;
  linkPos := 100;
  pCardinalData := pointer(PByte(linkOptions.Buf));
  PosLinkData := pCardinalData^;

  while linkPos <= PosLinkData do
  begin
    Run := pointer(PByte(linkOptions.Buf) + linkpos);
    data := Pointer(PByte(Run)+ lenNode);
    if data.vid = vvExamAnalysisRoot then
    begin
      Result := Run;
	  data := Pointer(PByte(Result)+ lenNode);
      data.DataPos := Cardinal(Self);
      Exit;
    end;
    inc(linkPos, LenData);
  end;
  if Result = nil then
    Result := CreateRootCollOptionNode;
  if Result <> nil then
  begin
    data := Pointer(PByte(Result)+ lenNode);
    data.DataPos := Cardinal(Self);
  end;
end;

function TExamAnalysisColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
var
  run, vRootPregOptions: PVirtualNode;
  dataRun: PAspRec;
begin
  vRootPregOptions := self.FindRootCollOptionNode();
  result := nil;

  run := vRootPregOptions.FirstChild;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvOptionSearchCot: result := run;
    end;
    run := run.NextSibling;
  end;
end;

function TExamAnalysisColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
var
  run, vRootPregOptions: PVirtualNode;
  dataRun: PAspRec;
begin
  vRootPregOptions := self.FindRootCollOptionNode();

  result := nil;

  run := vRootPregOptions.FirstChild;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvOptionSearchGrid: result := run;
    end;
    run := run.NextSibling;
  end;
end;

function TExamAnalysisColl.FindSearchFieldCollOptionNode(): PVirtualNode;
var
  linkPos: Cardinal;
  run, vOptionSearchGrid, vOptionSearchCOT, vRootPregOptions: PVirtualNode;
  i: Integer;
  dataRun: PAspRec;
begin
  vRootPregOptions := self.FindRootCollOptionNode();
  if vRootPregOptions = nil then
    vRootPregOptions := CreateRootCollOptionNode;
  vOptionSearchGrid := nil;
  vOptionSearchCOT := nil;

  run := vRootPregOptions.FirstChild;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvOptionSearchGrid: vOptionSearchGrid := run;
      vvOptionSearchCot: vOptionSearchCOT := run;
    end;

    run := run.NextSibling;
  end;
  if vOptionSearchGrid = nil then
  begin
    linkOptions.AddNewNode(vvOptionSearchGrid, 0, vRootPregOptions , amAddChildLast, vOptionSearchGrid, linkPos);
  end;
  if vOptionSearchCOT = nil then
  begin
    linkOptions.AddNewNode(vvOptionSearchCot, 0, vRootPregOptions , amAddChildLast, vOptionSearchGrid, linkPos);
  end;

  Result := vOptionSearchGrid;
  if vOptionSearchGrid.ChildCount <> FieldCount then
  begin
    for i := 0 to FieldCount - 1 do
    begin
      linkOptions.AddNewNode(vvFieldSearchGridOption, 0, vOptionSearchGrid , amAddChildLast, run, linkPos);
      run.Dummy := i;
    end;
  end
  else
  begin
    // при евентуално добавена колонка...
  end;
end;

procedure TExamAnalysisColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ExamAnalysis: TExamAnalysisItem;
  ACol: Integer;
  prop: TExamAnalysisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  ExamAnalysis := Items[ARow];
  prop := TExamAnalysisItem.TPropertyIndex(ACol);
  if Assigned(ExamAnalysis.PRecord) and (prop in ExamAnalysis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, ExamAnalysis, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, ExamAnalysis, AValue);
  end;
end;

procedure TExamAnalysisColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TExamAnalysisItem.TPropertyIndex;
begin
  inherited;
 
  if ARow < 0 then
  begin
    AValue := 'hhhh';
    Exit;
  end;
  try
    if (ListDataPos.count - 1 - Self.offsetTop - Self.offsetBottom) < ARow then exit;
    RowSelect := ARow + Self.offsetTop;
    TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  except
    AValue := 'ddddd';
    Exit;
  end;

  GetCellFromMap(ArrayPropOrderSearchOptions[AColumn.Index], RowSelect, TempItem, AValue);
end;

procedure TExamAnalysisColl.GetCellFromRecord(propIndex: word; ExamAnalysis: TExamAnalysisItem; var AValue: String);
var
  str: string;
begin
  case TExamAnalysisItem.TPropertyIndex(propIndex) of
    ExamAnalysis_DATA: str := AspDateToStr(ExamAnalysis.PRecord.DATA);
    ExamAnalysis_ID: str := inttostr(ExamAnalysis.PRecord.ID);
    ExamAnalysis_NZIS_CODE_CL22: str := (ExamAnalysis.PRecord.NZIS_CODE_CL22);
    ExamAnalysis_NZIS_DESCRIPTION_CL22: str := (ExamAnalysis.PRecord.NZIS_DESCRIPTION_CL22);
    ExamAnalysis_RESULT: str := (ExamAnalysis.PRecord.RESULT);
    ExamAnalysis_PosDataNomen: str := inttostr(ExamAnalysis.PRecord.PosDataNomen);
    ExamAnalysis_Logical: str := ExamAnalysis.Logical08ToStr(TLogicalData08(ExamAnalysis.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TExamAnalysisColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TExamAnalysisItem;
  ACol: Integer;
  prop: TExamAnalysisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TExamAnalysisItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TExamAnalysisColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TExamAnalysisItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TExamAnalysisItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TExamAnalysisColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ExamAnalysis: TExamAnalysisItem;
  ACol: Integer;
  prop: TExamAnalysisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  ExamAnalysis := ListExamAnalysisSearch[ARow];
  prop := TExamAnalysisItem.TPropertyIndex(ACol);
  if Assigned(ExamAnalysis.PRecord) and (prop in ExamAnalysis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, ExamAnalysis, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, ExamAnalysis, AValue);
  end;
end;

function TExamAnalysisColl.GetCollType: TCollectionsType;
begin
  Result := ctExamAnalysis;
end;

function TExamAnalysisColl.GetCollDelType: TCollectionsType;
begin
  Result := ctExamAnalysisDel;
end;

procedure TExamAnalysisColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  ExamAnalysis: TExamAnalysisItem;
  prop: TExamAnalysisItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  ExamAnalysis := Items[ARow];
  prop := TExamAnalysisItem.TPropertyIndex(ACol);
  if Assigned(ExamAnalysis.PRecord) and (prop in ExamAnalysis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, ExamAnalysis, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, ExamAnalysis, AFieldText);
  end;
end;

procedure TExamAnalysisColl.GetCellFromMap(propIndex: word; ARow: Integer; ExamAnalysis: TExamAnalysisItem; var AValue: String);
var
  str: string;
  len: Word;
  int: PInt;
  wrd: PWord;
  bt: PByte;
  pstr: pchar;
  pDbl: PDouble;
  pbl: PBoolean;
begin
  case TExamAnalysisItem.TPropertyIndex(propIndex) of
    ExamAnalysis_DATA: str :=  AspDateToStr(ExamAnalysis.getDateMap(Self.Buf, Self.posData, propIndex));
    ExamAnalysis_ID: str :=  inttostr(ExamAnalysis.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamAnalysis_NZIS_CODE_CL22: str :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamAnalysis_NZIS_DESCRIPTION_CL22: str :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamAnalysis_RESULT: str :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    ExamAnalysis_PosDataNomen: str :=  inttostr(ExamAnalysis.getIntMap(Self.Buf, Self.posData, propIndex));
    ExamAnalysis_Logical: str :=  ExamAnalysis.Logical08ToStr(ExamAnalysis.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TExamAnalysisColl.GetItem(Index: Integer): TExamAnalysisItem;
begin
  Result := TExamAnalysisItem(inherited GetItem(Index));
end;


procedure TExamAnalysisColl.IndexValue(propIndex: TExamAnalysisItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TExamAnalysisItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      ExamAnalysis_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      ExamAnalysis_NZIS_CODE_CL22:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamAnalysis_NZIS_DESCRIPTION_CL22:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      ExamAnalysis_RESULT:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
    end;
  end;
end;

procedure TExamAnalysisColl.IndexValueListNodes(propIndex: TExamAnalysisItem.TPropertyIndex);
begin

end;

function TExamAnalysisColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TExamAnalysisItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TExamAnalysisColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TExamAnalysisItem;
begin
  if index < 0 then
  begin
    Tempitem := TExamAnalysisItem.Create(nil);
    Tempitem.DataPos := datapos;
    GetCellFromMap(field, -1, Tempitem, value);
    Tempitem.Free;
  end
  else
  begin
    Tempitem := Self.Items[index];
    if Assigned(Tempitem.PRecord) then
    begin
      GetCellFromRecord(field, Tempitem, value);
    end
    else
    begin
      GetCellFromMap(field, index, Tempitem, value);
    end;
  end;
end;

{=== TEXT SEARCH HANDLER ===}
procedure TExamAnalysisColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TExamAnalysisItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TExamAnalysisItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TExamAnalysisItem.TPropertyIndex(Field) of
ExamAnalysis_NZIS_CODE_CL22: ListForFinder[0].PRecord.NZIS_CODE_CL22 := AText;
    ExamAnalysis_NZIS_DESCRIPTION_CL22: ListForFinder[0].PRecord.NZIS_DESCRIPTION_CL22 := AText;
    ExamAnalysis_RESULT: ListForFinder[0].PRecord.RESULT := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TExamAnalysisColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TExamAnalysisItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TExamAnalysisItem.TPropertyIndex(Field) of
ExamAnalysis_DATA: ListForFinder[0].PRecord.DATA := Value;
  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TExamAnalysisColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TExamAnalysisItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TExamAnalysisItem.TPropertyIndex(Field) of
ExamAnalysis_ID: ListForFinder[0].PRecord.ID := Value;
    ExamAnalysis_PosDataNomen: ListForFinder[0].PRecord.PosDataNomen := Value;
  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TExamAnalysisColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TExamAnalysisItem.TPropertyIndex(Field) of
    ExamAnalysis_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalExamAnalysis(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalExamAnalysis(logIndex))   
    end;
  end;
end;


procedure TExamAnalysisColl.OnSetTextSearchLog(Log: TlogicalExamAnalysisSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TExamAnalysisColl.OrderFieldsSearch1(Grid: TTeeGrid);
var
  FieldCollOptionNode, run: PVirtualNode;
  Comparison: TComparison<PVirtualNode>;
  i, index, rank: Integer;
  ArrCol: TArray<TColumn>;
begin
  inherited;
  if linkOptions = nil then  Exit;

  FieldCollOptionNode := FindSearchFieldCollOptionNode;
  ApplyVisibilityFromTree(FieldCollOptionNode);
  run := FieldCollOptionNode.FirstChild;

  while run <> nil do
  begin
    Grid.Columns[run.index + 1].Header.Text := DisplayName(run.Dummy - 1);
    ArrayPropOrderSearchOptions[run.index + 1] :=  run.Dummy - 1;
    run := run.NextSibling;
  end;

end;

function TExamAnalysisColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TExamAnalysisItem.TPropertyIndex(propIndex) of
    ExamAnalysis_DATA: Result := actTDate;
    ExamAnalysis_ID: Result := actinteger;
    ExamAnalysis_NZIS_CODE_CL22: Result := actAnsiString;
    ExamAnalysis_NZIS_DESCRIPTION_CL22: Result := actAnsiString;
    ExamAnalysis_RESULT: Result := actAnsiString;
    ExamAnalysis_PosDataNomen: Result := actcardinal;
    ExamAnalysis_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TExamAnalysisColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TExamAnalysisColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  ExamAnalysis: TExamAnalysisItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  ExamAnalysis := Items[ARow];
  if not Assigned(ExamAnalysis.PRecord) then
  begin
    New(ExamAnalysis.PRecord);
    ExamAnalysis.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TExamAnalysisItem.TPropertyIndex(ACol) of
      ExamAnalysis_DATA: isOld :=  ExamAnalysis.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    ExamAnalysis_ID: isOld :=  ExamAnalysis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    ExamAnalysis_NZIS_CODE_CL22: isOld :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamAnalysis_NZIS_DESCRIPTION_CL22: isOld :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamAnalysis_RESULT: isOld :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    ExamAnalysis_PosDataNomen: isOld :=  ExamAnalysis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(ExamAnalysis.PRecord.setProp, TExamAnalysisItem.TPropertyIndex(ACol));
    if ExamAnalysis.PRecord.setProp = [] then
    begin
      Dispose(ExamAnalysis.PRecord);
      ExamAnalysis.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(ExamAnalysis.PRecord.setProp, TExamAnalysisItem.TPropertyIndex(ACol));
  case TExamAnalysisItem.TPropertyIndex(ACol) of
    ExamAnalysis_DATA: ExamAnalysis.PRecord.DATA := StrToDate(AValue);
    ExamAnalysis_ID: ExamAnalysis.PRecord.ID := StrToInt(AValue);
    ExamAnalysis_NZIS_CODE_CL22: ExamAnalysis.PRecord.NZIS_CODE_CL22 := AValue;
    ExamAnalysis_NZIS_DESCRIPTION_CL22: ExamAnalysis.PRecord.NZIS_DESCRIPTION_CL22 := AValue;
    ExamAnalysis_RESULT: ExamAnalysis.PRecord.RESULT := AValue;
    ExamAnalysis_PosDataNomen: ExamAnalysis.PRecord.PosDataNomen := StrToInt(AValue);
    ExamAnalysis_Logical: ExamAnalysis.PRecord.Logical := tlogicalExamAnalysisSet(ExamAnalysis.StrToLogical08(AValue));
  end;
end;

procedure TExamAnalysisColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  ExamAnalysis: TExamAnalysisItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  ExamAnalysis := Items[ARow];
  if not Assigned(ExamAnalysis.PRecord) then
  begin
    New(ExamAnalysis.PRecord);
    ExamAnalysis.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TExamAnalysisItem.TPropertyIndex(ACol) of
      ExamAnalysis_DATA: isOld :=  ExamAnalysis.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    ExamAnalysis_ID: isOld :=  ExamAnalysis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    ExamAnalysis_NZIS_CODE_CL22: isOld :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamAnalysis_NZIS_DESCRIPTION_CL22: isOld :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamAnalysis_RESULT: isOld :=  ExamAnalysis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    ExamAnalysis_PosDataNomen: isOld :=  ExamAnalysis.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(ExamAnalysis.PRecord.setProp, TExamAnalysisItem.TPropertyIndex(ACol));
    if ExamAnalysis.PRecord.setProp = [] then
    begin
      Dispose(ExamAnalysis.PRecord);
      ExamAnalysis.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(ExamAnalysis.PRecord.setProp, TExamAnalysisItem.TPropertyIndex(ACol));
  case TExamAnalysisItem.TPropertyIndex(ACol) of
    ExamAnalysis_DATA: ExamAnalysis.PRecord.DATA := StrToDate(AFieldText);
    ExamAnalysis_ID: ExamAnalysis.PRecord.ID := StrToInt(AFieldText);
    ExamAnalysis_NZIS_CODE_CL22: ExamAnalysis.PRecord.NZIS_CODE_CL22 := AFieldText;
    ExamAnalysis_NZIS_DESCRIPTION_CL22: ExamAnalysis.PRecord.NZIS_DESCRIPTION_CL22 := AFieldText;
    ExamAnalysis_RESULT: ExamAnalysis.PRecord.RESULT := AFieldText;
    ExamAnalysis_PosDataNomen: ExamAnalysis.PRecord.PosDataNomen := StrToInt(AFieldText);
    ExamAnalysis_Logical: ExamAnalysis.PRecord.Logical := tlogicalExamAnalysisSet(ExamAnalysis.StrToLogical08(AFieldText));
  end;
end;

procedure TExamAnalysisColl.SetItem(Index: Integer; const Value: TExamAnalysisItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TExamAnalysisColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListExamAnalysisSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TExamAnalysisItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  ExamAnalysis_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListExamAnalysisSearch.Add(self.Items[i]);
        end;
      end;
      ExamAnalysis_NZIS_CODE_CL22:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamAnalysisSearch.Add(self.Items[i]);
        end;
      end;
      ExamAnalysis_NZIS_DESCRIPTION_CL22:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamAnalysisSearch.Add(self.Items[i]);
        end;
      end;
      ExamAnalysis_RESULT:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListExamAnalysisSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TExamAnalysisColl.ShowGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := 'Ред';

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCell;
  TVirtualModeData(Grid.Data).OnSetValue:=self.SetCell;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 100;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 50;
  Grid.Columns[self.FieldCount].Index := 0;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width + 1;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width - 1;

end;

procedure TExamAnalysisColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TExamAnalysisItem>);
var
  i: word;

begin
  ListForFinder := LST;
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, LST.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := 'Ред';

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellList;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 100;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 50;
  Grid.Columns[self.FieldCount].Index := 0;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width + 1;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width - 1;

end;

procedure TExamAnalysisColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListExamAnalysisSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListExamAnalysisSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;
  grid.Margins.Left := 100;
  grid.Margins.Left := 0;
  grid.Scrolling.Active := true;
end;

procedure TExamAnalysisColl.SortByIndexAnsiString;
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
        while (Items[I].IndexAnsiStr1) < (Items[P].IndexAnsiStr1) do Inc(I);
        while (Items[J].IndexAnsiStr1) > (Items[P].IndexAnsiStr1) do Dec(J);
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
  if (count >1 ) then
  begin
    sc := TCollectionForSort(Self).FItems;
    QuickSort(0,count-1);
  end;
end;

procedure TExamAnalysisColl.SortByIndexInt;
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
        while (Items[I]).IndexInt < (Items[P]).IndexInt do Inc(I);
        while (Items[J]).IndexInt > (Items[P]).IndexInt do Dec(J);
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
  if (count >1 ) then
  begin
    sc := TCollectionForSort(Self).FItems;
    QuickSort(0,count-1);
  end;
end;

procedure TExamAnalysisColl.SortByIndexWord;
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
        while (Items[I]).IndexWord < (Items[P]).IndexWord do Inc(I);
        while (Items[J]).IndexWord > (Items[P]).IndexWord do Dec(J);
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
  if (count >1 ) then
  begin
    sc := TCollectionForSort(Self).FItems;
    QuickSort(0,count-1);
  end;
end;

procedure TExamAnalysisColl.SortByIndexValue(propIndex: TExamAnalysisItem.TPropertyIndex);
begin
  case propIndex of
    ExamAnalysis_ID: SortByIndexInt;
      ExamAnalysis_NZIS_CODE_CL22: SortByIndexAnsiString;
      ExamAnalysis_NZIS_DESCRIPTION_CL22: SortByIndexAnsiString;
      ExamAnalysis_RESULT: SortByIndexAnsiString;
  end;
end;

end.