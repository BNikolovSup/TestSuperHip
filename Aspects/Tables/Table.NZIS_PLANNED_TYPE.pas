unit Table.NZIS_PLANNED_TYPE;

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

TLogicalNZIS_PLANNED_TYPE = (
    Is_);
TlogicalNZIS_PLANNED_TYPESet = set of TLogicalNZIS_PLANNED_TYPE;


TNZIS_PLANNED_TYPEItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       NZIS_PLANNED_TYPE_CL132_KEY
       , NZIS_PLANNED_TYPE_ID
       , NZIS_PLANNED_TYPE_PREGLED_ID
       , NZIS_PLANNED_TYPE_StartDate
       , NZIS_PLANNED_TYPE_EndDate
       , NZIS_PLANNED_TYPE_CL132_DataPos
       , NZIS_PLANNED_TYPE_NumberRep
       , NZIS_PLANNED_TYPE_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecNZIS_PLANNED_TYPE = ^TRecNZIS_PLANNED_TYPE;
      TRecNZIS_PLANNED_TYPE = record
        CL132_KEY: AnsiString;
        ID: integer;
        PREGLED_ID: integer;
        StartDate: TDate;
        EndDate: TDate;
        CL132_DataPos: cardinal;
        NumberRep: Integer;
        Logical: TlogicalNZIS_PLANNED_TYPESet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecNZIS_PLANNED_TYPE;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertNZIS_PLANNED_TYPE;
    procedure UpdateNZIS_PLANNED_TYPE;
    procedure SaveNZIS_PLANNED_TYPE(var dataPosition: Cardinal)overload;
	procedure SaveNZIS_PLANNED_TYPE(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TNZIS_PLANNED_TYPEColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TNZIS_PLANNED_TYPEItem;
    function GetItem(Index: Integer): TNZIS_PLANNED_TYPEItem;
    procedure SetItem(Index: Integer; const Value: TNZIS_PLANNED_TYPEItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TNZIS_PLANNED_TYPEItem>;
    ListNZIS_PLANNED_TYPESearch: TList<TNZIS_PLANNED_TYPEItem>;
	PRecordSearch: ^TNZIS_PLANNED_TYPEItem.TRecNZIS_PLANNED_TYPE;
    ArrPropSearch: TArray<TNZIS_PLANNED_TYPEItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TNZIS_PLANNED_TYPEItem.TPropertyIndex>;
	VisibleColl: TNZIS_PLANNED_TYPEItem.TSetProp;
	ArrayPropOrder: TArray<TNZIS_PLANNED_TYPEItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TNZIS_PLANNED_TYPEItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TNZIS_PLANNED_TYPEItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TNZIS_PLANNED_TYPEItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TNZIS_PLANNED_TYPEItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TNZIS_PLANNED_TYPEItem.TPropertyIndex);
    property Items[Index: Integer]: TNZIS_PLANNED_TYPEItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalNZIS_PLANNED_TYPESet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
  end;

implementation

{ TNZIS_PLANNED_TYPEItem }

constructor TNZIS_PLANNED_TYPEItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TNZIS_PLANNED_TYPEItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TNZIS_PLANNED_TYPEItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TNZIS_PLANNED_TYPEItem.GetCollType: TCollectionsType;
begin
  Result := ctNZIS_PLANNED_TYPE;
end;

function TNZIS_PLANNED_TYPEItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TNZIS_PLANNED_TYPEItem.InsertNZIS_PLANNED_TYPE;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctNZIS_PLANNED_TYPE;
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
            NZIS_PLANNED_TYPE_CL132_KEY: SaveData(PRecord.CL132_KEY, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_PREGLED_ID: SaveData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_StartDate: SaveData(PRecord.StartDate, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_EndDate: SaveData(PRecord.EndDate, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_CL132_DataPos: SaveData(PRecord.CL132_DataPos, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_NumberRep: SaveData(PRecord.NumberRep, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TNZIS_PLANNED_TYPEItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TNZIS_PLANNED_TYPEItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TNZIS_PLANNED_TYPEItem;
begin
  Result := True;
  for i := 0 to Length(TNZIS_PLANNED_TYPEColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TNZIS_PLANNED_TYPEColl(coll).ArrPropSearchClc[i];
	ATempItem := TNZIS_PLANNED_TYPEColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        NZIS_PLANNED_TYPE_CL132_KEY: Result := IsFinded(ATempItem.PRecord.CL132_KEY, buf, FPosDataADB, word(NZIS_PLANNED_TYPE_CL132_KEY), cot);
            NZIS_PLANNED_TYPE_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(NZIS_PLANNED_TYPE_ID), cot);
            NZIS_PLANNED_TYPE_PREGLED_ID: Result := IsFinded(ATempItem.PRecord.PREGLED_ID, buf, FPosDataADB, word(NZIS_PLANNED_TYPE_PREGLED_ID), cot);
            NZIS_PLANNED_TYPE_StartDate: Result := IsFinded(ATempItem.PRecord.StartDate, buf, FPosDataADB, word(NZIS_PLANNED_TYPE_StartDate), cot);
            NZIS_PLANNED_TYPE_EndDate: Result := IsFinded(ATempItem.PRecord.EndDate, buf, FPosDataADB, word(NZIS_PLANNED_TYPE_EndDate), cot);
            NZIS_PLANNED_TYPE_CL132_DataPos: Result := IsFinded(ATempItem.PRecord.CL132_DataPos, buf, FPosDataADB, word(NZIS_PLANNED_TYPE_CL132_DataPos), cot);
            NZIS_PLANNED_TYPE_NumberRep: Result := IsFinded(ATempItem.PRecord.NumberRep, buf, FPosDataADB, word(NZIS_PLANNED_TYPE_NumberRep), cot);
            NZIS_PLANNED_TYPE_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(NZIS_PLANNED_TYPE_Logical), cot);
      end;
    end;
  end;
end;

procedure TNZIS_PLANNED_TYPEItem.SaveNZIS_PLANNED_TYPE(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveNZIS_PLANNED_TYPE(dataPosition);
end;

procedure TNZIS_PLANNED_TYPEItem.SaveNZIS_PLANNED_TYPE(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNZIS_PLANNED_TYPE;
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
            NZIS_PLANNED_TYPE_CL132_KEY: SaveData(PRecord.CL132_KEY, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_PREGLED_ID: SaveData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_StartDate: SaveData(PRecord.StartDate, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_EndDate: SaveData(PRecord.EndDate, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_CL132_DataPos: SaveData(PRecord.CL132_DataPos, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_NumberRep: SaveData(PRecord.NumberRep, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TNZIS_PLANNED_TYPEItem.UpdateNZIS_PLANNED_TYPE;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNZIS_PLANNED_TYPE;
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
            NZIS_PLANNED_TYPE_CL132_KEY: UpdateData(PRecord.CL132_KEY, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_PREGLED_ID: UpdateData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_StartDate: UpdateData(PRecord.StartDate, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_EndDate: UpdateData(PRecord.EndDate, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_CL132_DataPos: UpdateData(PRecord.CL132_DataPos, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_NumberRep: UpdateData(PRecord.NumberRep, PropPosition, metaPosition, dataPosition);
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

{ TNZIS_PLANNED_TYPEColl }

function TNZIS_PLANNED_TYPEColl.AddItem(ver: word): TNZIS_PLANNED_TYPEItem;
begin
  Result := TNZIS_PLANNED_TYPEItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TNZIS_PLANNED_TYPEColl.AddItemForSearch: Integer;
var
  ItemForSearch: TNZIS_PLANNED_TYPEItem;
begin
  ItemForSearch := TNZIS_PLANNED_TYPEItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TNZIS_PLANNED_TYPEColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TNZIS_PLANNED_TYPEItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TNZIS_PLANNED_TYPEColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvNZIS_PLANNED_TYPERoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TNZIS_PLANNED_TYPEColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TNZIS_PLANNED_TYPEItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (NZIS_PLANNED_TYPE_CL132_KEY in tempItem.PRecord.setProp) and (tempItem.PRecord.CL132_KEY <> Self.getAnsiStringMap(tempItem.DataPos, word(NZIS_PLANNED_TYPE_CL132_KEY))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_PLANNED_TYPE_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.ID <> Self.getIntMap(tempItem.DataPos, word(NZIS_PLANNED_TYPE_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_PLANNED_TYPE_PREGLED_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.PREGLED_ID <> Self.getIntMap(tempItem.DataPos, word(NZIS_PLANNED_TYPE_PREGLED_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_PLANNED_TYPE_StartDate in tempItem.PRecord.setProp) and (tempItem.PRecord.StartDate <> Self.getDateMap(tempItem.DataPos, word(NZIS_PLANNED_TYPE_StartDate))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_PLANNED_TYPE_EndDate in tempItem.PRecord.setProp) and (tempItem.PRecord.EndDate <> Self.getDateMap(tempItem.DataPos, word(NZIS_PLANNED_TYPE_EndDate))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_PLANNED_TYPE_CL132_DataPos in tempItem.PRecord.setProp) and (tempItem.PRecord.CL132_DataPos <> Self.getIntMap(tempItem.DataPos, word(NZIS_PLANNED_TYPE_CL132_DataPos))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_PLANNED_TYPE_NumberRep in tempItem.PRecord.setProp) and (tempItem.PRecord.NumberRep <> Self.getIntMap(tempItem.DataPos, word(NZIS_PLANNED_TYPE_NumberRep))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_PLANNED_TYPE_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(NZIS_PLANNED_TYPE_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TNZIS_PLANNED_TYPEColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TNZIS_PLANNED_TYPEItem.Create(nil);
  ListNZIS_PLANNED_TYPESearch := TList<TNZIS_PLANNED_TYPEItem>.Create;
  ListForFinder := TList<TNZIS_PLANNED_TYPEItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TNZIS_PLANNED_TYPEColl.destroy;
begin
  FreeAndNil(ListNZIS_PLANNED_TYPESearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TNZIS_PLANNED_TYPEColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(propIndex) of
    NZIS_PLANNED_TYPE_CL132_KEY: Result := 'CL132_KEY';
    NZIS_PLANNED_TYPE_ID: Result := 'ID';
    NZIS_PLANNED_TYPE_PREGLED_ID: Result := 'PREGLED_ID';
    NZIS_PLANNED_TYPE_StartDate: Result := 'StartDate';
    NZIS_PLANNED_TYPE_EndDate: Result := 'EndDate';
    NZIS_PLANNED_TYPE_CL132_DataPos: Result := 'CL132_DataPos';
    NZIS_PLANNED_TYPE_NumberRep: Result := 'NumberRep';
    NZIS_PLANNED_TYPE_Logical: Result := 'Logical';
  end;
end;

function TNZIS_PLANNED_TYPEColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'Is_';
  else
    Result := '???';
  end;
end;


procedure TNZIS_PLANNED_TYPEColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TNZIS_PLANNED_TYPEColl.FieldCount: Integer; 
begin
  inherited;
  Result := 8;
end;

function TNZIS_PLANNED_TYPEColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvNZIS_PLANNED_TYPERoot then
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

function TNZIS_PLANNED_TYPEColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TNZIS_PLANNED_TYPEColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TNZIS_PLANNED_TYPEColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TNZIS_PLANNED_TYPEColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem;
  ACol: Integer;
  prop: TNZIS_PLANNED_TYPEItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NZIS_PLANNED_TYPE := Items[ARow];
  prop := TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol);
  if Assigned(NZIS_PLANNED_TYPE.PRecord) and (prop in NZIS_PLANNED_TYPE.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_PLANNED_TYPE, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_PLANNED_TYPE, AValue);
  end;
end;

procedure TNZIS_PLANNED_TYPEColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TNZIS_PLANNED_TYPEItem.TPropertyIndex;
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

procedure TNZIS_PLANNED_TYPEColl.GetCellFromRecord(propIndex: word; NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem; var AValue: String);
var
  str: string;
begin
  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(propIndex) of
    NZIS_PLANNED_TYPE_CL132_KEY: str := (NZIS_PLANNED_TYPE.PRecord.CL132_KEY);
    NZIS_PLANNED_TYPE_ID: str := inttostr(NZIS_PLANNED_TYPE.PRecord.ID);
    NZIS_PLANNED_TYPE_PREGLED_ID: str := inttostr(NZIS_PLANNED_TYPE.PRecord.PREGLED_ID);
    NZIS_PLANNED_TYPE_StartDate: str := AspDateToStr(NZIS_PLANNED_TYPE.PRecord.StartDate);
    NZIS_PLANNED_TYPE_EndDate: str := AspDateToStr(NZIS_PLANNED_TYPE.PRecord.EndDate);
    NZIS_PLANNED_TYPE_CL132_DataPos: str := inttostr(NZIS_PLANNED_TYPE.PRecord.CL132_DataPos);
    NZIS_PLANNED_TYPE_NumberRep: str := inttostr(NZIS_PLANNED_TYPE.PRecord.NumberRep);
    NZIS_PLANNED_TYPE_Logical: str := NZIS_PLANNED_TYPE.Logical08ToStr(TLogicalData08(NZIS_PLANNED_TYPE.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TNZIS_PLANNED_TYPEColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TNZIS_PLANNED_TYPEItem;
  ACol: Integer;
  prop: TNZIS_PLANNED_TYPEItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TNZIS_PLANNED_TYPEColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TNZIS_PLANNED_TYPEItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TNZIS_PLANNED_TYPEColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem;
  ACol: Integer;
  prop: TNZIS_PLANNED_TYPEItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NZIS_PLANNED_TYPE := ListNZIS_PLANNED_TYPESearch[ARow];
  prop := TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol);
  if Assigned(NZIS_PLANNED_TYPE.PRecord) and (prop in NZIS_PLANNED_TYPE.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_PLANNED_TYPE, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_PLANNED_TYPE, AValue);
  end;
end;

function TNZIS_PLANNED_TYPEColl.GetCollType: TCollectionsType;
begin
  Result := ctNZIS_PLANNED_TYPE;
end;

function TNZIS_PLANNED_TYPEColl.GetCollDelType: TCollectionsType;
begin
  Result := ctNZIS_PLANNED_TYPEDel;
end;

procedure TNZIS_PLANNED_TYPEColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem;
  prop: TNZIS_PLANNED_TYPEItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  NZIS_PLANNED_TYPE := Items[ARow];
  prop := TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol);
  if Assigned(NZIS_PLANNED_TYPE.PRecord) and (prop in NZIS_PLANNED_TYPE.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_PLANNED_TYPE, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_PLANNED_TYPE, AFieldText);
  end;
end;

procedure TNZIS_PLANNED_TYPEColl.GetCellFromMap(propIndex: word; ARow: Integer; NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem; var AValue: String);
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
  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(propIndex) of
    NZIS_PLANNED_TYPE_CL132_KEY: str :=  NZIS_PLANNED_TYPE.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NZIS_PLANNED_TYPE_ID: str :=  inttostr(NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_PLANNED_TYPE_PREGLED_ID: str :=  inttostr(NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_PLANNED_TYPE_StartDate: str :=  AspDateToStr(NZIS_PLANNED_TYPE.getDateMap(Self.Buf, Self.posData, propIndex));
    NZIS_PLANNED_TYPE_EndDate: str :=  AspDateToStr(NZIS_PLANNED_TYPE.getDateMap(Self.Buf, Self.posData, propIndex));
    NZIS_PLANNED_TYPE_CL132_DataPos: str :=  inttostr(NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_PLANNED_TYPE_Logical: str :=  NZIS_PLANNED_TYPE.Logical08ToStr(NZIS_PLANNED_TYPE.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TNZIS_PLANNED_TYPEColl.GetItem(Index: Integer): TNZIS_PLANNED_TYPEItem;
begin
  Result := TNZIS_PLANNED_TYPEItem(inherited GetItem(Index));
end;


procedure TNZIS_PLANNED_TYPEColl.IndexValue(propIndex: TNZIS_PLANNED_TYPEItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TNZIS_PLANNED_TYPEItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      NZIS_PLANNED_TYPE_CL132_KEY:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      NZIS_PLANNED_TYPE_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      NZIS_PLANNED_TYPE_PREGLED_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TNZIS_PLANNED_TYPEColl.IndexValueListNodes(propIndex: TNZIS_PLANNED_TYPEItem.TPropertyIndex);
begin

end;

function TNZIS_PLANNED_TYPEColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TNZIS_PLANNED_TYPEItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TNZIS_PLANNED_TYPEColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TNZIS_PLANNED_TYPEItem;
begin
  if index < 0 then
  begin
    Tempitem := TNZIS_PLANNED_TYPEItem.Create(nil);
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
procedure TNZIS_PLANNED_TYPEColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TNZIS_PLANNED_TYPEItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TNZIS_PLANNED_TYPEItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(Field) of
NZIS_PLANNED_TYPE_CL132_KEY: ListForFinder[0].PRecord.CL132_KEY := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TNZIS_PLANNED_TYPEColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TNZIS_PLANNED_TYPEItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(Field) of
NZIS_PLANNED_TYPE_StartDate: ListForFinder[0].PRecord.StartDate := Value;
    NZIS_PLANNED_TYPE_EndDate: ListForFinder[0].PRecord.EndDate := Value;
  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TNZIS_PLANNED_TYPEColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TNZIS_PLANNED_TYPEItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(Field) of
NZIS_PLANNED_TYPE_ID: ListForFinder[0].PRecord.ID := Value;
    NZIS_PLANNED_TYPE_PREGLED_ID: ListForFinder[0].PRecord.PREGLED_ID := Value;
    NZIS_PLANNED_TYPE_CL132_DataPos: ListForFinder[0].PRecord.CL132_DataPos := Value;
    NZIS_PLANNED_TYPE_NumberRep: ListForFinder[0].PRecord.NumberRep := Value;
  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TNZIS_PLANNED_TYPEColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(Field) of
    NZIS_PLANNED_TYPE_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalNZIS_PLANNED_TYPE(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalNZIS_PLANNED_TYPE(logIndex))   
    end;
  end;
end;


procedure TNZIS_PLANNED_TYPEColl.OnSetTextSearchLog(Log: TlogicalNZIS_PLANNED_TYPESet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TNZIS_PLANNED_TYPEColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TNZIS_PLANNED_TYPEColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(propIndex) of
    NZIS_PLANNED_TYPE_CL132_KEY: Result := actAnsiString;
    NZIS_PLANNED_TYPE_ID: Result := actinteger;
    NZIS_PLANNED_TYPE_PREGLED_ID: Result := actinteger;
    NZIS_PLANNED_TYPE_StartDate: Result := actTDate;
    NZIS_PLANNED_TYPE_EndDate: Result := actTDate;
    NZIS_PLANNED_TYPE_CL132_DataPos: Result := actcardinal;
    NZIS_PLANNED_TYPE_NumberRep: Result := actInteger;
    NZIS_PLANNED_TYPE_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TNZIS_PLANNED_TYPEColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TNZIS_PLANNED_TYPEColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  NZIS_PLANNED_TYPE := Items[ARow];
  if not Assigned(NZIS_PLANNED_TYPE.PRecord) then
  begin
    New(NZIS_PLANNED_TYPE.PRecord);
    NZIS_PLANNED_TYPE.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol) of
      NZIS_PLANNED_TYPE_CL132_KEY: isOld :=  NZIS_PLANNED_TYPE.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    NZIS_PLANNED_TYPE_ID: isOld :=  NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    NZIS_PLANNED_TYPE_PREGLED_ID: isOld :=  NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    NZIS_PLANNED_TYPE_StartDate: isOld :=  NZIS_PLANNED_TYPE.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    NZIS_PLANNED_TYPE_EndDate: isOld :=  NZIS_PLANNED_TYPE.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    NZIS_PLANNED_TYPE_CL132_DataPos: isOld :=  NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(NZIS_PLANNED_TYPE.PRecord.setProp, TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol));
    if NZIS_PLANNED_TYPE.PRecord.setProp = [] then
    begin
      Dispose(NZIS_PLANNED_TYPE.PRecord);
      NZIS_PLANNED_TYPE.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NZIS_PLANNED_TYPE.PRecord.setProp, TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol));
  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol) of
    NZIS_PLANNED_TYPE_CL132_KEY: NZIS_PLANNED_TYPE.PRecord.CL132_KEY := AValue;
    NZIS_PLANNED_TYPE_ID: NZIS_PLANNED_TYPE.PRecord.ID := StrToInt(AValue);
    NZIS_PLANNED_TYPE_PREGLED_ID: NZIS_PLANNED_TYPE.PRecord.PREGLED_ID := StrToInt(AValue);
    NZIS_PLANNED_TYPE_StartDate: NZIS_PLANNED_TYPE.PRecord.StartDate := StrToDate(AValue);
    NZIS_PLANNED_TYPE_EndDate: NZIS_PLANNED_TYPE.PRecord.EndDate := StrToDate(AValue);
    NZIS_PLANNED_TYPE_CL132_DataPos: NZIS_PLANNED_TYPE.PRecord.CL132_DataPos := StrToInt(AValue);
    NZIS_PLANNED_TYPE_NumberRep: NZIS_PLANNED_TYPE.PRecord.NumberRep := StrToInt(AValue);
    NZIS_PLANNED_TYPE_Logical: NZIS_PLANNED_TYPE.PRecord.Logical := tlogicalNZIS_PLANNED_TYPESet(NZIS_PLANNED_TYPE.StrToLogical08(AValue));
  end;
end;

procedure TNZIS_PLANNED_TYPEColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  NZIS_PLANNED_TYPE := Items[ARow];
  if not Assigned(NZIS_PLANNED_TYPE.PRecord) then
  begin
    New(NZIS_PLANNED_TYPE.PRecord);
    NZIS_PLANNED_TYPE.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol) of
      NZIS_PLANNED_TYPE_CL132_KEY: isOld :=  NZIS_PLANNED_TYPE.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    NZIS_PLANNED_TYPE_ID: isOld :=  NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    NZIS_PLANNED_TYPE_PREGLED_ID: isOld :=  NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    NZIS_PLANNED_TYPE_StartDate: isOld :=  NZIS_PLANNED_TYPE.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    NZIS_PLANNED_TYPE_EndDate: isOld :=  NZIS_PLANNED_TYPE.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    NZIS_PLANNED_TYPE_CL132_DataPos: isOld :=  NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(NZIS_PLANNED_TYPE.PRecord.setProp, TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol));
    if NZIS_PLANNED_TYPE.PRecord.setProp = [] then
    begin
      Dispose(NZIS_PLANNED_TYPE.PRecord);
      NZIS_PLANNED_TYPE.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NZIS_PLANNED_TYPE.PRecord.setProp, TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol));
  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol) of
    NZIS_PLANNED_TYPE_CL132_KEY: NZIS_PLANNED_TYPE.PRecord.CL132_KEY := AFieldText;
    NZIS_PLANNED_TYPE_ID: NZIS_PLANNED_TYPE.PRecord.ID := StrToInt(AFieldText);
    NZIS_PLANNED_TYPE_PREGLED_ID: NZIS_PLANNED_TYPE.PRecord.PREGLED_ID := StrToInt(AFieldText);
    NZIS_PLANNED_TYPE_StartDate: NZIS_PLANNED_TYPE.PRecord.StartDate := StrToDate(AFieldText);
    NZIS_PLANNED_TYPE_EndDate: NZIS_PLANNED_TYPE.PRecord.EndDate := StrToDate(AFieldText);
    NZIS_PLANNED_TYPE_CL132_DataPos: NZIS_PLANNED_TYPE.PRecord.CL132_DataPos := StrToInt(AFieldText);
    NZIS_PLANNED_TYPE_NumberRep: NZIS_PLANNED_TYPE.PRecord.NumberRep := StrToInt(AFieldText);
    NZIS_PLANNED_TYPE_Logical: NZIS_PLANNED_TYPE.PRecord.Logical := tlogicalNZIS_PLANNED_TYPESet(NZIS_PLANNED_TYPE.StrToLogical08(AFieldText));
  end;
end;

procedure TNZIS_PLANNED_TYPEColl.SetItem(Index: Integer; const Value: TNZIS_PLANNED_TYPEItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TNZIS_PLANNED_TYPEColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListNZIS_PLANNED_TYPESearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TNZIS_PLANNED_TYPEItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  NZIS_PLANNED_TYPE_CL132_KEY:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListNZIS_PLANNED_TYPESearch.Add(self.Items[i]);
  end;
end;
      NZIS_PLANNED_TYPE_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_PLANNED_TYPESearch.Add(self.Items[i]);
        end;
      end;
      NZIS_PLANNED_TYPE_PREGLED_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_PLANNED_TYPESearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TNZIS_PLANNED_TYPEColl.ShowGrid(Grid: TTeeGrid);
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

procedure TNZIS_PLANNED_TYPEColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TNZIS_PLANNED_TYPEItem>);
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

procedure TNZIS_PLANNED_TYPEColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListNZIS_PLANNED_TYPESearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListNZIS_PLANNED_TYPESearch.Count]);

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

procedure TNZIS_PLANNED_TYPEColl.SortByIndexAnsiString;
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

procedure TNZIS_PLANNED_TYPEColl.SortByIndexInt;
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

procedure TNZIS_PLANNED_TYPEColl.SortByIndexWord;
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

procedure TNZIS_PLANNED_TYPEColl.SortByIndexValue(propIndex: TNZIS_PLANNED_TYPEItem.TPropertyIndex);
begin
  case propIndex of
    NZIS_PLANNED_TYPE_CL132_KEY: SortByIndexAnsiString;
      NZIS_PLANNED_TYPE_ID: SortByIndexInt;
      NZIS_PLANNED_TYPE_PREGLED_ID: SortByIndexInt;
  end;
end;

end.