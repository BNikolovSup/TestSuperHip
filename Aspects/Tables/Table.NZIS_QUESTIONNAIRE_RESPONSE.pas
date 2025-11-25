unit Table.NZIS_QUESTIONNAIRE_RESPONSE;

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

TLogicalNZIS_QUESTIONNAIRE_RESPONSE = (
    IS_);
TlogicalNZIS_QUESTIONNAIRE_RESPONSESet = set of TLogicalNZIS_QUESTIONNAIRE_RESPONSE;


TNZIS_QUESTIONNAIRE_RESPONSEItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE
       , NZIS_QUESTIONNAIRE_RESPONSE_ID
       , NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID
       , NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY
       , NZIS_QUESTIONNAIRE_RESPONSE_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecNZIS_QUESTIONNAIRE_RESPONSE = ^TRecNZIS_QUESTIONNAIRE_RESPONSE;
      TRecNZIS_QUESTIONNAIRE_RESPONSE = record
        CL133_QUEST_RESPONSE_CODE: word;
        ID: integer;
        PLANNED_TYPE_ID: integer;
        PR001_KEY: AnsiString;
        Logical: TlogicalNZIS_QUESTIONNAIRE_RESPONSESet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecNZIS_QUESTIONNAIRE_RESPONSE;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertNZIS_QUESTIONNAIRE_RESPONSE;
    procedure UpdateNZIS_QUESTIONNAIRE_RESPONSE;
    procedure SaveNZIS_QUESTIONNAIRE_RESPONSE(var dataPosition: Cardinal)overload;
	procedure SaveNZIS_QUESTIONNAIRE_RESPONSE(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TNZIS_QUESTIONNAIRE_RESPONSEColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TNZIS_QUESTIONNAIRE_RESPONSEItem;
    function GetItem(Index: Integer): TNZIS_QUESTIONNAIRE_RESPONSEItem;
    procedure SetItem(Index: Integer; const Value: TNZIS_QUESTIONNAIRE_RESPONSEItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TNZIS_QUESTIONNAIRE_RESPONSEItem>;
    ListNZIS_QUESTIONNAIRE_RESPONSESearch: TList<TNZIS_QUESTIONNAIRE_RESPONSEItem>;
	PRecordSearch: ^TNZIS_QUESTIONNAIRE_RESPONSEItem.TRecNZIS_QUESTIONNAIRE_RESPONSE;
    ArrPropSearch: TArray<TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex>;
	VisibleColl: TNZIS_QUESTIONNAIRE_RESPONSEItem.TSetProp;
	ArrayPropOrder: TArray<TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TNZIS_QUESTIONNAIRE_RESPONSEItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; NZIS_QUESTIONNAIRE_RESPONSE: TNZIS_QUESTIONNAIRE_RESPONSEItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; NZIS_QUESTIONNAIRE_RESPONSE: TNZIS_QUESTIONNAIRE_RESPONSEItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TNZIS_QUESTIONNAIRE_RESPONSEItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex);
    property Items[Index: Integer]: TNZIS_QUESTIONNAIRE_RESPONSEItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalNZIS_QUESTIONNAIRE_RESPONSESet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
  end;

implementation

{ TNZIS_QUESTIONNAIRE_RESPONSEItem }

constructor TNZIS_QUESTIONNAIRE_RESPONSEItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TNZIS_QUESTIONNAIRE_RESPONSEItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TNZIS_QUESTIONNAIRE_RESPONSEItem.GetCollType: TCollectionsType;
begin
  Result := ctNZIS_QUESTIONNAIRE_RESPONSE;
end;

function TNZIS_QUESTIONNAIRE_RESPONSEItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEItem.InsertNZIS_QUESTIONNAIRE_RESPONSE;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctNZIS_QUESTIONNAIRE_RESPONSE;
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
            NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: SaveData(PRecord.CL133_QUEST_RESPONSE_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_RESPONSE_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: SaveData(PRecord.PLANNED_TYPE_ID, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY: SaveData(PRecord.PR001_KEY, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_RESPONSE_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TNZIS_QUESTIONNAIRE_RESPONSEItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TNZIS_QUESTIONNAIRE_RESPONSEItem;
begin
  Result := True;
  for i := 0 to Length(TNZIS_QUESTIONNAIRE_RESPONSEColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TNZIS_QUESTIONNAIRE_RESPONSEColl(coll).ArrPropSearchClc[i];
	ATempItem := TNZIS_QUESTIONNAIRE_RESPONSEColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: Result := IsFinded(ATempItem.PRecord.CL133_QUEST_RESPONSE_CODE, buf, FPosDataADB, word(NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE), cot);
            NZIS_QUESTIONNAIRE_RESPONSE_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(NZIS_QUESTIONNAIRE_RESPONSE_ID), cot);
            NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: Result := IsFinded(ATempItem.PRecord.PLANNED_TYPE_ID, buf, FPosDataADB, word(NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID), cot);
            NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY: Result := IsFinded(ATempItem.PRecord.PR001_KEY, buf, FPosDataADB, word(NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY), cot);
            NZIS_QUESTIONNAIRE_RESPONSE_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(NZIS_QUESTIONNAIRE_RESPONSE_Logical), cot);
      end;
    end;
  end;
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEItem.SaveNZIS_QUESTIONNAIRE_RESPONSE(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveNZIS_QUESTIONNAIRE_RESPONSE(dataPosition);
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEItem.SaveNZIS_QUESTIONNAIRE_RESPONSE(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNZIS_QUESTIONNAIRE_RESPONSE;
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
            NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: SaveData(PRecord.CL133_QUEST_RESPONSE_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_RESPONSE_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: SaveData(PRecord.PLANNED_TYPE_ID, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY: SaveData(PRecord.PR001_KEY, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_RESPONSE_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TNZIS_QUESTIONNAIRE_RESPONSEItem.UpdateNZIS_QUESTIONNAIRE_RESPONSE;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNZIS_QUESTIONNAIRE_RESPONSE;
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
            NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: UpdateData(PRecord.CL133_QUEST_RESPONSE_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_RESPONSE_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: UpdateData(PRecord.PLANNED_TYPE_ID, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY: UpdateData(PRecord.PR001_KEY, PropPosition, metaPosition, dataPosition);
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

{ TNZIS_QUESTIONNAIRE_RESPONSEColl }

function TNZIS_QUESTIONNAIRE_RESPONSEColl.AddItem(ver: word): TNZIS_QUESTIONNAIRE_RESPONSEItem;
begin
  Result := TNZIS_QUESTIONNAIRE_RESPONSEItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TNZIS_QUESTIONNAIRE_RESPONSEColl.AddItemForSearch: Integer;
var
  ItemForSearch: TNZIS_QUESTIONNAIRE_RESPONSEItem;
begin
  ItemForSearch := TNZIS_QUESTIONNAIRE_RESPONSEItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TNZIS_QUESTIONNAIRE_RESPONSEColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvNZIS_QUESTIONNAIRE_RESPONSERoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TNZIS_QUESTIONNAIRE_RESPONSEItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE in tempItem.PRecord.setProp) and (tempItem.PRecord.CL133_QUEST_RESPONSE_CODE <> Self.getIntMap(tempItem.DataPos, word(NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_QUESTIONNAIRE_RESPONSE_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.ID <> Self.getIntMap(tempItem.DataPos, word(NZIS_QUESTIONNAIRE_RESPONSE_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.PLANNED_TYPE_ID <> Self.getIntMap(tempItem.DataPos, word(NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY in tempItem.PRecord.setProp) and (tempItem.PRecord.PR001_KEY <> Self.getAnsiStringMap(tempItem.DataPos, word(NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_QUESTIONNAIRE_RESPONSE_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(NZIS_QUESTIONNAIRE_RESPONSE_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TNZIS_QUESTIONNAIRE_RESPONSEColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TNZIS_QUESTIONNAIRE_RESPONSEItem.Create(nil);
  ListNZIS_QUESTIONNAIRE_RESPONSESearch := TList<TNZIS_QUESTIONNAIRE_RESPONSEItem>.Create;
  ListForFinder := TList<TNZIS_QUESTIONNAIRE_RESPONSEItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TNZIS_QUESTIONNAIRE_RESPONSEColl.destroy;
begin
  FreeAndNil(ListNZIS_QUESTIONNAIRE_RESPONSESearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TNZIS_QUESTIONNAIRE_RESPONSEColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(propIndex) of
    NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: Result := 'CL133_QUEST_RESPONSE_CODE';
    NZIS_QUESTIONNAIRE_RESPONSE_ID: Result := 'ID';
    NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: Result := 'PLANNED_TYPE_ID';
    NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY: Result := 'PR001_KEY';
    NZIS_QUESTIONNAIRE_RESPONSE_Logical: Result := 'Logical';
  end;
end;

function TNZIS_QUESTIONNAIRE_RESPONSEColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'IS_';
  else
    Result := '???';
  end;
end;


procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TNZIS_QUESTIONNAIRE_RESPONSEColl.FieldCount: Integer; 
begin
  inherited;
  Result := 5;
end;

function TNZIS_QUESTIONNAIRE_RESPONSEColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvNZIS_QUESTIONNAIRE_RESPONSERoot then
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

function TNZIS_QUESTIONNAIRE_RESPONSEColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TNZIS_QUESTIONNAIRE_RESPONSEColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TNZIS_QUESTIONNAIRE_RESPONSEColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NZIS_QUESTIONNAIRE_RESPONSE: TNZIS_QUESTIONNAIRE_RESPONSEItem;
  ACol: Integer;
  prop: TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NZIS_QUESTIONNAIRE_RESPONSE := Items[ARow];
  prop := TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(ACol);
  if Assigned(NZIS_QUESTIONNAIRE_RESPONSE.PRecord) and (prop in NZIS_QUESTIONNAIRE_RESPONSE.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_QUESTIONNAIRE_RESPONSE, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_QUESTIONNAIRE_RESPONSE, AValue);
  end;
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex;
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

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.GetCellFromRecord(propIndex: word; NZIS_QUESTIONNAIRE_RESPONSE: TNZIS_QUESTIONNAIRE_RESPONSEItem; var AValue: String);
var
  str: string;
begin
  case TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(propIndex) of
    NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: str := inttostr(NZIS_QUESTIONNAIRE_RESPONSE.PRecord.CL133_QUEST_RESPONSE_CODE);
    NZIS_QUESTIONNAIRE_RESPONSE_ID: str := inttostr(NZIS_QUESTIONNAIRE_RESPONSE.PRecord.ID);
    NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: str := inttostr(NZIS_QUESTIONNAIRE_RESPONSE.PRecord.PLANNED_TYPE_ID);
    NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY: str := (NZIS_QUESTIONNAIRE_RESPONSE.PRecord.PR001_KEY);
    NZIS_QUESTIONNAIRE_RESPONSE_Logical: str := NZIS_QUESTIONNAIRE_RESPONSE.Logical08ToStr(TLogicalData08(NZIS_QUESTIONNAIRE_RESPONSE.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TNZIS_QUESTIONNAIRE_RESPONSEItem;
  ACol: Integer;
  prop: TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NZIS_QUESTIONNAIRE_RESPONSE: TNZIS_QUESTIONNAIRE_RESPONSEItem;
  ACol: Integer;
  prop: TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NZIS_QUESTIONNAIRE_RESPONSE := ListNZIS_QUESTIONNAIRE_RESPONSESearch[ARow];
  prop := TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(ACol);
  if Assigned(NZIS_QUESTIONNAIRE_RESPONSE.PRecord) and (prop in NZIS_QUESTIONNAIRE_RESPONSE.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_QUESTIONNAIRE_RESPONSE, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_QUESTIONNAIRE_RESPONSE, AValue);
  end;
end;

function TNZIS_QUESTIONNAIRE_RESPONSEColl.GetCollType: TCollectionsType;
begin
  Result := ctNZIS_QUESTIONNAIRE_RESPONSE;
end;

function TNZIS_QUESTIONNAIRE_RESPONSEColl.GetCollDelType: TCollectionsType;
begin
  Result := ctNZIS_QUESTIONNAIRE_RESPONSEDel;
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  NZIS_QUESTIONNAIRE_RESPONSE: TNZIS_QUESTIONNAIRE_RESPONSEItem;
  prop: TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  NZIS_QUESTIONNAIRE_RESPONSE := Items[ARow];
  prop := TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(ACol);
  if Assigned(NZIS_QUESTIONNAIRE_RESPONSE.PRecord) and (prop in NZIS_QUESTIONNAIRE_RESPONSE.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_QUESTIONNAIRE_RESPONSE, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_QUESTIONNAIRE_RESPONSE, AFieldText);
  end;
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.GetCellFromMap(propIndex: word; ARow: Integer; NZIS_QUESTIONNAIRE_RESPONSE: TNZIS_QUESTIONNAIRE_RESPONSEItem; var AValue: String);
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
  case TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(propIndex) of
    NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: str :=  inttostr(NZIS_QUESTIONNAIRE_RESPONSE.getWordMap(Self.Buf, Self.posData, propIndex));
    NZIS_QUESTIONNAIRE_RESPONSE_ID: str :=  inttostr(NZIS_QUESTIONNAIRE_RESPONSE.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: str :=  inttostr(NZIS_QUESTIONNAIRE_RESPONSE.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY: str :=  NZIS_QUESTIONNAIRE_RESPONSE.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NZIS_QUESTIONNAIRE_RESPONSE_Logical: str :=  NZIS_QUESTIONNAIRE_RESPONSE.Logical08ToStr(NZIS_QUESTIONNAIRE_RESPONSE.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TNZIS_QUESTIONNAIRE_RESPONSEColl.GetItem(Index: Integer): TNZIS_QUESTIONNAIRE_RESPONSEItem;
begin
  Result := TNZIS_QUESTIONNAIRE_RESPONSEItem(inherited GetItem(Index));
end;


procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.IndexValue(propIndex: TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TNZIS_QUESTIONNAIRE_RESPONSEItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      NZIS_QUESTIONNAIRE_RESPONSE_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY:
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

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.IndexValueListNodes(propIndex: TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex);
begin

end;

function TNZIS_QUESTIONNAIRE_RESPONSEColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TNZIS_QUESTIONNAIRE_RESPONSEItem;
begin
  if index < 0 then
  begin
    Tempitem := TNZIS_QUESTIONNAIRE_RESPONSEItem.Create(nil);
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
procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(Field) of
NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY: ListForFinder[0].PRecord.PR001_KEY := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  //case TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(Field) of
//
//  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(Field) of
NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: ListForFinder[0].PRecord.CL133_QUEST_RESPONSE_CODE := Value;
    NZIS_QUESTIONNAIRE_RESPONSE_ID: ListForFinder[0].PRecord.ID := Value;
    NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: ListForFinder[0].PRecord.PLANNED_TYPE_ID := Value;
  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(Field) of
    NZIS_QUESTIONNAIRE_RESPONSE_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalNZIS_QUESTIONNAIRE_RESPONSE(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalNZIS_QUESTIONNAIRE_RESPONSE(logIndex))   
    end;
  end;
end;


procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.OnSetTextSearchLog(Log: TlogicalNZIS_QUESTIONNAIRE_RESPONSESet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TNZIS_QUESTIONNAIRE_RESPONSEColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(propIndex) of
    NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: Result := actword;
    NZIS_QUESTIONNAIRE_RESPONSE_ID: Result := actinteger;
    NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: Result := actinteger;
    NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY: Result := actAnsiString;
    NZIS_QUESTIONNAIRE_RESPONSE_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TNZIS_QUESTIONNAIRE_RESPONSEColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  NZIS_QUESTIONNAIRE_RESPONSE: TNZIS_QUESTIONNAIRE_RESPONSEItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  NZIS_QUESTIONNAIRE_RESPONSE := Items[ARow];
  if not Assigned(NZIS_QUESTIONNAIRE_RESPONSE.PRecord) then
  begin
    New(NZIS_QUESTIONNAIRE_RESPONSE.PRecord);
    NZIS_QUESTIONNAIRE_RESPONSE.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(ACol) of
      NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: isOld :=  NZIS_QUESTIONNAIRE_RESPONSE.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    NZIS_QUESTIONNAIRE_RESPONSE_ID: isOld :=  NZIS_QUESTIONNAIRE_RESPONSE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: isOld :=  NZIS_QUESTIONNAIRE_RESPONSE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY: isOld :=  NZIS_QUESTIONNAIRE_RESPONSE.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(NZIS_QUESTIONNAIRE_RESPONSE.PRecord.setProp, TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(ACol));
    if NZIS_QUESTIONNAIRE_RESPONSE.PRecord.setProp = [] then
    begin
      Dispose(NZIS_QUESTIONNAIRE_RESPONSE.PRecord);
      NZIS_QUESTIONNAIRE_RESPONSE.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NZIS_QUESTIONNAIRE_RESPONSE.PRecord.setProp, TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(ACol));
  case TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(ACol) of
    NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: NZIS_QUESTIONNAIRE_RESPONSE.PRecord.CL133_QUEST_RESPONSE_CODE := StrToInt(AValue);
    NZIS_QUESTIONNAIRE_RESPONSE_ID: NZIS_QUESTIONNAIRE_RESPONSE.PRecord.ID := StrToInt(AValue);
    NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: NZIS_QUESTIONNAIRE_RESPONSE.PRecord.PLANNED_TYPE_ID := StrToInt(AValue);
    NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY: NZIS_QUESTIONNAIRE_RESPONSE.PRecord.PR001_KEY := AValue;
    NZIS_QUESTIONNAIRE_RESPONSE_Logical: NZIS_QUESTIONNAIRE_RESPONSE.PRecord.Logical := tlogicalNZIS_QUESTIONNAIRE_RESPONSESet(NZIS_QUESTIONNAIRE_RESPONSE.StrToLogical08(AValue));
  end;
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  NZIS_QUESTIONNAIRE_RESPONSE: TNZIS_QUESTIONNAIRE_RESPONSEItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  NZIS_QUESTIONNAIRE_RESPONSE := Items[ARow];
  if not Assigned(NZIS_QUESTIONNAIRE_RESPONSE.PRecord) then
  begin
    New(NZIS_QUESTIONNAIRE_RESPONSE.PRecord);
    NZIS_QUESTIONNAIRE_RESPONSE.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(ACol) of
      NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: isOld :=  NZIS_QUESTIONNAIRE_RESPONSE.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    NZIS_QUESTIONNAIRE_RESPONSE_ID: isOld :=  NZIS_QUESTIONNAIRE_RESPONSE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: isOld :=  NZIS_QUESTIONNAIRE_RESPONSE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY: isOld :=  NZIS_QUESTIONNAIRE_RESPONSE.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(NZIS_QUESTIONNAIRE_RESPONSE.PRecord.setProp, TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(ACol));
    if NZIS_QUESTIONNAIRE_RESPONSE.PRecord.setProp = [] then
    begin
      Dispose(NZIS_QUESTIONNAIRE_RESPONSE.PRecord);
      NZIS_QUESTIONNAIRE_RESPONSE.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NZIS_QUESTIONNAIRE_RESPONSE.PRecord.setProp, TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(ACol));
  case TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(ACol) of
    NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: NZIS_QUESTIONNAIRE_RESPONSE.PRecord.CL133_QUEST_RESPONSE_CODE := StrToInt(AFieldText);
    NZIS_QUESTIONNAIRE_RESPONSE_ID: NZIS_QUESTIONNAIRE_RESPONSE.PRecord.ID := StrToInt(AFieldText);
    NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: NZIS_QUESTIONNAIRE_RESPONSE.PRecord.PLANNED_TYPE_ID := StrToInt(AFieldText);
    NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY: NZIS_QUESTIONNAIRE_RESPONSE.PRecord.PR001_KEY := AFieldText;
    NZIS_QUESTIONNAIRE_RESPONSE_Logical: NZIS_QUESTIONNAIRE_RESPONSE.PRecord.Logical := tlogicalNZIS_QUESTIONNAIRE_RESPONSESet(NZIS_QUESTIONNAIRE_RESPONSE.StrToLogical08(AFieldText));
  end;
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.SetItem(Index: Integer; const Value: TNZIS_QUESTIONNAIRE_RESPONSEItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListNZIS_QUESTIONNAIRE_RESPONSESearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: 
begin
  if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
  begin
    ListNZIS_QUESTIONNAIRE_RESPONSESearch.Add(self.Items[i]);
  end;
end;
      NZIS_QUESTIONNAIRE_RESPONSE_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_QUESTIONNAIRE_RESPONSESearch.Add(self.Items[i]);
        end;
      end;
      NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_QUESTIONNAIRE_RESPONSESearch.Add(self.Items[i]);
        end;
      end;
      NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNZIS_QUESTIONNAIRE_RESPONSESearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.ShowGrid(Grid: TTeeGrid);
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

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TNZIS_QUESTIONNAIRE_RESPONSEItem>);
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

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListNZIS_QUESTIONNAIRE_RESPONSESearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListNZIS_QUESTIONNAIRE_RESPONSESearch.Count]);

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

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.SortByIndexAnsiString;
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

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.SortByIndexInt;
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

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.SortByIndexWord;
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

procedure TNZIS_QUESTIONNAIRE_RESPONSEColl.SortByIndexValue(propIndex: TNZIS_QUESTIONNAIRE_RESPONSEItem.TPropertyIndex);
begin
  case propIndex of
    NZIS_QUESTIONNAIRE_RESPONSE_CL133_QUEST_RESPONSE_CODE: SortByIndexWord;
      NZIS_QUESTIONNAIRE_RESPONSE_ID: SortByIndexInt;
      NZIS_QUESTIONNAIRE_RESPONSE_PLANNED_TYPE_ID: SortByIndexInt;
      NZIS_QUESTIONNAIRE_RESPONSE_PR001_KEY: SortByIndexAnsiString;
  end;
end;

end.