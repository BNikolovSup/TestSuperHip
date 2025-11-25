unit Table.NZIS_ANSWER_VALUE;

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

TLogicalNZIS_ANSWER_VALUE = (
    ANSWER_BOOLEAN);
TlogicalNZIS_ANSWER_VALUESet = set of TLogicalNZIS_ANSWER_VALUE;


TNZIS_ANSWER_VALUEItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       NZIS_ANSWER_VALUE_ANSWER_CODE
       , NZIS_ANSWER_VALUE_ANSWER_DATE
       , NZIS_ANSWER_VALUE_ANSWER_QUANTITY
       , NZIS_ANSWER_VALUE_ANSWER_TEXT
       , NZIS_ANSWER_VALUE_CL028
       , NZIS_ANSWER_VALUE_ID
       , NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID
       , NZIS_ANSWER_VALUE_NOMEN_POS
       , NZIS_ANSWER_VALUE_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecNZIS_ANSWER_VALUE = ^TRecNZIS_ANSWER_VALUE;
      TRecNZIS_ANSWER_VALUE = record
        ANSWER_CODE: AnsiString;
        ANSWER_DATE: TDate;
        ANSWER_QUANTITY: double;
        ANSWER_TEXT: AnsiString;
        CL028: word;
        ID: integer;
        QUESTIONNAIRE_ANSWER_ID: integer;
        NOMEN_POS: cardinal;
        Logical: TlogicalNZIS_ANSWER_VALUESet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecNZIS_ANSWER_VALUE;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertNZIS_ANSWER_VALUE;
    procedure UpdateNZIS_ANSWER_VALUE;
    procedure SaveNZIS_ANSWER_VALUE(var dataPosition: Cardinal)overload;
	procedure SaveNZIS_ANSWER_VALUE(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TNZIS_ANSWER_VALUEColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TNZIS_ANSWER_VALUEItem;
    function GetItem(Index: Integer): TNZIS_ANSWER_VALUEItem;
    procedure SetItem(Index: Integer; const Value: TNZIS_ANSWER_VALUEItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TNZIS_ANSWER_VALUEItem>;
    ListNZIS_ANSWER_VALUESearch: TList<TNZIS_ANSWER_VALUEItem>;
	PRecordSearch: ^TNZIS_ANSWER_VALUEItem.TRecNZIS_ANSWER_VALUE;
    ArrPropSearch: TArray<TNZIS_ANSWER_VALUEItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TNZIS_ANSWER_VALUEItem.TPropertyIndex>;
	VisibleColl: TNZIS_ANSWER_VALUEItem.TSetProp;
	ArrayPropOrder: TArray<TNZIS_ANSWER_VALUEItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TNZIS_ANSWER_VALUEItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; NZIS_ANSWER_VALUE: TNZIS_ANSWER_VALUEItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; NZIS_ANSWER_VALUE: TNZIS_ANSWER_VALUEItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TNZIS_ANSWER_VALUEItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TNZIS_ANSWER_VALUEItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TNZIS_ANSWER_VALUEItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TNZIS_ANSWER_VALUEItem.TPropertyIndex);
    property Items[Index: Integer]: TNZIS_ANSWER_VALUEItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalNZIS_ANSWER_VALUESet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
  end;

implementation

{ TNZIS_ANSWER_VALUEItem }

constructor TNZIS_ANSWER_VALUEItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TNZIS_ANSWER_VALUEItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TNZIS_ANSWER_VALUEItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TNZIS_ANSWER_VALUEItem.GetCollType: TCollectionsType;
begin
  Result := ctNZIS_ANSWER_VALUE;
end;

function TNZIS_ANSWER_VALUEItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TNZIS_ANSWER_VALUEItem.InsertNZIS_ANSWER_VALUE;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctNZIS_ANSWER_VALUE;
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
            NZIS_ANSWER_VALUE_ANSWER_CODE: SaveData(PRecord.ANSWER_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_DATE: SaveData(PRecord.ANSWER_DATE, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_QUANTITY: SaveData(PRecord.ANSWER_QUANTITY, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_TEXT: SaveData(PRecord.ANSWER_TEXT, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_CL028: SaveData(PRecord.CL028, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: SaveData(PRecord.QUESTIONNAIRE_ANSWER_ID, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_NOMEN_POS: SaveData(PRecord.NOMEN_POS, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TNZIS_ANSWER_VALUEItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TNZIS_ANSWER_VALUEItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TNZIS_ANSWER_VALUEItem;
begin
  Result := True;
  for i := 0 to Length(TNZIS_ANSWER_VALUEColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TNZIS_ANSWER_VALUEColl(coll).ArrPropSearchClc[i];
	ATempItem := TNZIS_ANSWER_VALUEColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        NZIS_ANSWER_VALUE_ANSWER_CODE: Result := IsFinded(ATempItem.PRecord.ANSWER_CODE, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_ANSWER_CODE), cot);
            NZIS_ANSWER_VALUE_ANSWER_DATE: Result := IsFinded(ATempItem.PRecord.ANSWER_DATE, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_ANSWER_DATE), cot);
            NZIS_ANSWER_VALUE_ANSWER_QUANTITY: Result := IsFinded(ATempItem.PRecord.ANSWER_QUANTITY, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_ANSWER_QUANTITY), cot);
            NZIS_ANSWER_VALUE_ANSWER_TEXT: Result := IsFinded(ATempItem.PRecord.ANSWER_TEXT, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_ANSWER_TEXT), cot);
            NZIS_ANSWER_VALUE_CL028: Result := IsFinded(ATempItem.PRecord.CL028, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_CL028), cot);
            NZIS_ANSWER_VALUE_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_ID), cot);
            NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: Result := IsFinded(ATempItem.PRecord.QUESTIONNAIRE_ANSWER_ID, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID), cot);
            NZIS_ANSWER_VALUE_NOMEN_POS: Result := IsFinded(ATempItem.PRecord.NOMEN_POS, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_NOMEN_POS), cot);
            NZIS_ANSWER_VALUE_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(NZIS_ANSWER_VALUE_Logical), cot);
      end;
    end;
  end;
end;

procedure TNZIS_ANSWER_VALUEItem.SaveNZIS_ANSWER_VALUE(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveNZIS_ANSWER_VALUE(dataPosition);
end;

procedure TNZIS_ANSWER_VALUEItem.SaveNZIS_ANSWER_VALUE(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNZIS_ANSWER_VALUE;
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
            NZIS_ANSWER_VALUE_ANSWER_CODE: SaveData(PRecord.ANSWER_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_DATE: SaveData(PRecord.ANSWER_DATE, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_QUANTITY: SaveData(PRecord.ANSWER_QUANTITY, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_TEXT: SaveData(PRecord.ANSWER_TEXT, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_CL028: SaveData(PRecord.CL028, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: SaveData(PRecord.QUESTIONNAIRE_ANSWER_ID, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_NOMEN_POS: SaveData(PRecord.NOMEN_POS, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TNZIS_ANSWER_VALUEItem.UpdateNZIS_ANSWER_VALUE;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNZIS_ANSWER_VALUE;
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
            NZIS_ANSWER_VALUE_ANSWER_CODE: UpdateData(PRecord.ANSWER_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_DATE: UpdateData(PRecord.ANSWER_DATE, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_QUANTITY: UpdateData(PRecord.ANSWER_QUANTITY, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_TEXT: UpdateData(PRecord.ANSWER_TEXT, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_CL028: UpdateData(PRecord.CL028, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: UpdateData(PRecord.QUESTIONNAIRE_ANSWER_ID, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_NOMEN_POS: UpdateData(PRecord.NOMEN_POS, PropPosition, metaPosition, dataPosition);
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

{ TNZIS_ANSWER_VALUEColl }

function TNZIS_ANSWER_VALUEColl.AddItem(ver: word): TNZIS_ANSWER_VALUEItem;
begin
  Result := TNZIS_ANSWER_VALUEItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TNZIS_ANSWER_VALUEColl.AddItemForSearch: Integer;
var
  ItemForSearch: TNZIS_ANSWER_VALUEItem;
begin
  ItemForSearch := TNZIS_ANSWER_VALUEItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TNZIS_ANSWER_VALUEColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TNZIS_ANSWER_VALUEItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TNZIS_ANSWER_VALUEColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvNZIS_ANSWER_VALUERoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TNZIS_ANSWER_VALUEColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TNZIS_ANSWER_VALUEItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (NZIS_ANSWER_VALUE_ANSWER_CODE in tempItem.PRecord.setProp) and (tempItem.PRecord.ANSWER_CODE <> Self.getAnsiStringMap(tempItem.DataPos, word(NZIS_ANSWER_VALUE_ANSWER_CODE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_ANSWER_VALUE_ANSWER_DATE in tempItem.PRecord.setProp) and (tempItem.PRecord.ANSWER_DATE <> Self.getDateMap(tempItem.DataPos, word(NZIS_ANSWER_VALUE_ANSWER_DATE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_ANSWER_VALUE_ANSWER_QUANTITY in tempItem.PRecord.setProp) and (Abs(tempItem.PRecord.ANSWER_QUANTITY - Self.getDoubleMap(tempItem.DataPos, word(NZIS_ANSWER_VALUE_ANSWER_QUANTITY))) > 0.000001) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_ANSWER_VALUE_ANSWER_TEXT in tempItem.PRecord.setProp) and (tempItem.PRecord.ANSWER_TEXT <> Self.getAnsiStringMap(tempItem.DataPos, word(NZIS_ANSWER_VALUE_ANSWER_TEXT))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_ANSWER_VALUE_CL028 in tempItem.PRecord.setProp) and (tempItem.PRecord.CL028 <> Self.getIntMap(tempItem.DataPos, word(NZIS_ANSWER_VALUE_CL028))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_ANSWER_VALUE_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.ID <> Self.getIntMap(tempItem.DataPos, word(NZIS_ANSWER_VALUE_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.QUESTIONNAIRE_ANSWER_ID <> Self.getIntMap(tempItem.DataPos, word(NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_ANSWER_VALUE_NOMEN_POS in tempItem.PRecord.setProp) and (tempItem.PRecord.NOMEN_POS <> Self.getIntMap(tempItem.DataPos, word(NZIS_ANSWER_VALUE_NOMEN_POS))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NZIS_ANSWER_VALUE_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(NZIS_ANSWER_VALUE_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TNZIS_ANSWER_VALUEColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TNZIS_ANSWER_VALUEItem.Create(nil);
  ListNZIS_ANSWER_VALUESearch := TList<TNZIS_ANSWER_VALUEItem>.Create;
  ListForFinder := TList<TNZIS_ANSWER_VALUEItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TNZIS_ANSWER_VALUEColl.destroy;
begin
  FreeAndNil(ListNZIS_ANSWER_VALUESearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TNZIS_ANSWER_VALUEColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TNZIS_ANSWER_VALUEItem.TPropertyIndex(propIndex) of
    NZIS_ANSWER_VALUE_ANSWER_CODE: Result := 'ANSWER_CODE';
    NZIS_ANSWER_VALUE_ANSWER_DATE: Result := 'ANSWER_DATE';
    NZIS_ANSWER_VALUE_ANSWER_QUANTITY: Result := 'ANSWER_QUANTITY';
    NZIS_ANSWER_VALUE_ANSWER_TEXT: Result := 'ANSWER_TEXT';
    NZIS_ANSWER_VALUE_CL028: Result := 'CL028';
    NZIS_ANSWER_VALUE_ID: Result := 'ID';
    NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: Result := 'QUESTIONNAIRE_ANSWER_ID';
    NZIS_ANSWER_VALUE_NOMEN_POS: Result := 'NOMEN_POS';
    NZIS_ANSWER_VALUE_Logical: Result := 'Logical';
  end;
end;

function TNZIS_ANSWER_VALUEColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'ANSWER_BOOLEAN';
  else
    Result := '???';
  end;
end;


procedure TNZIS_ANSWER_VALUEColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TNZIS_ANSWER_VALUEColl.FieldCount: Integer; 
begin
  inherited;
  Result := 9;
end;

function TNZIS_ANSWER_VALUEColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvNZIS_ANSWER_VALUERoot then
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

function TNZIS_ANSWER_VALUEColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TNZIS_ANSWER_VALUEColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TNZIS_ANSWER_VALUEColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TNZIS_ANSWER_VALUEColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NZIS_ANSWER_VALUE: TNZIS_ANSWER_VALUEItem;
  ACol: Integer;
  prop: TNZIS_ANSWER_VALUEItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NZIS_ANSWER_VALUE := Items[ARow];
  prop := TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol);
  if Assigned(NZIS_ANSWER_VALUE.PRecord) and (prop in NZIS_ANSWER_VALUE.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_ANSWER_VALUE, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_ANSWER_VALUE, AValue);
  end;
end;

procedure TNZIS_ANSWER_VALUEColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TNZIS_ANSWER_VALUEItem.TPropertyIndex;
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

procedure TNZIS_ANSWER_VALUEColl.GetCellFromRecord(propIndex: word; NZIS_ANSWER_VALUE: TNZIS_ANSWER_VALUEItem; var AValue: String);
var
  str: string;
begin
  case TNZIS_ANSWER_VALUEItem.TPropertyIndex(propIndex) of
    NZIS_ANSWER_VALUE_ANSWER_CODE: str := (NZIS_ANSWER_VALUE.PRecord.ANSWER_CODE);
    NZIS_ANSWER_VALUE_ANSWER_DATE: str := AspDateToStr(NZIS_ANSWER_VALUE.PRecord.ANSWER_DATE);
    NZIS_ANSWER_VALUE_ANSWER_QUANTITY: str := FloatToStr(NZIS_ANSWER_VALUE.PRecord.ANSWER_QUANTITY);
    NZIS_ANSWER_VALUE_ANSWER_TEXT: str := (NZIS_ANSWER_VALUE.PRecord.ANSWER_TEXT);
    NZIS_ANSWER_VALUE_CL028: str := inttostr(NZIS_ANSWER_VALUE.PRecord.CL028);
    NZIS_ANSWER_VALUE_ID: str := inttostr(NZIS_ANSWER_VALUE.PRecord.ID);
    NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: str := inttostr(NZIS_ANSWER_VALUE.PRecord.QUESTIONNAIRE_ANSWER_ID);
    NZIS_ANSWER_VALUE_NOMEN_POS: str := inttostr(NZIS_ANSWER_VALUE.PRecord.NOMEN_POS);
    NZIS_ANSWER_VALUE_Logical: str := NZIS_ANSWER_VALUE.Logical08ToStr(TLogicalData08(NZIS_ANSWER_VALUE.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TNZIS_ANSWER_VALUEColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TNZIS_ANSWER_VALUEItem;
  ACol: Integer;
  prop: TNZIS_ANSWER_VALUEItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TNZIS_ANSWER_VALUEColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TNZIS_ANSWER_VALUEItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TNZIS_ANSWER_VALUEColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NZIS_ANSWER_VALUE: TNZIS_ANSWER_VALUEItem;
  ACol: Integer;
  prop: TNZIS_ANSWER_VALUEItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NZIS_ANSWER_VALUE := ListNZIS_ANSWER_VALUESearch[ARow];
  prop := TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol);
  if Assigned(NZIS_ANSWER_VALUE.PRecord) and (prop in NZIS_ANSWER_VALUE.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_ANSWER_VALUE, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_ANSWER_VALUE, AValue);
  end;
end;

function TNZIS_ANSWER_VALUEColl.GetCollType: TCollectionsType;
begin
  Result := ctNZIS_ANSWER_VALUE;
end;

function TNZIS_ANSWER_VALUEColl.GetCollDelType: TCollectionsType;
begin
  Result := ctNZIS_ANSWER_VALUEDel;
end;

procedure TNZIS_ANSWER_VALUEColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  NZIS_ANSWER_VALUE: TNZIS_ANSWER_VALUEItem;
  prop: TNZIS_ANSWER_VALUEItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  NZIS_ANSWER_VALUE := Items[ARow];
  prop := TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol);
  if Assigned(NZIS_ANSWER_VALUE.PRecord) and (prop in NZIS_ANSWER_VALUE.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_ANSWER_VALUE, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_ANSWER_VALUE, AFieldText);
  end;
end;

procedure TNZIS_ANSWER_VALUEColl.GetCellFromMap(propIndex: word; ARow: Integer; NZIS_ANSWER_VALUE: TNZIS_ANSWER_VALUEItem; var AValue: String);
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
  case TNZIS_ANSWER_VALUEItem.TPropertyIndex(propIndex) of
    NZIS_ANSWER_VALUE_ANSWER_CODE: str :=  NZIS_ANSWER_VALUE.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NZIS_ANSWER_VALUE_ANSWER_DATE: str :=  AspDateToStr(NZIS_ANSWER_VALUE.getDateMap(Self.Buf, Self.posData, propIndex));
    NZIS_ANSWER_VALUE_ANSWER_TEXT: str :=  NZIS_ANSWER_VALUE.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NZIS_ANSWER_VALUE_CL028: str :=  inttostr(NZIS_ANSWER_VALUE.getWordMap(Self.Buf, Self.posData, propIndex));
    NZIS_ANSWER_VALUE_ID: str :=  inttostr(NZIS_ANSWER_VALUE.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: str :=  inttostr(NZIS_ANSWER_VALUE.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_ANSWER_VALUE_NOMEN_POS: str :=  inttostr(NZIS_ANSWER_VALUE.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_ANSWER_VALUE_Logical: str :=  NZIS_ANSWER_VALUE.Logical08ToStr(NZIS_ANSWER_VALUE.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TNZIS_ANSWER_VALUEColl.GetItem(Index: Integer): TNZIS_ANSWER_VALUEItem;
begin
  Result := TNZIS_ANSWER_VALUEItem(inherited GetItem(Index));
end;


procedure TNZIS_ANSWER_VALUEColl.IndexValue(propIndex: TNZIS_ANSWER_VALUEItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TNZIS_ANSWER_VALUEItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      NZIS_ANSWER_VALUE_ANSWER_CODE:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      NZIS_ANSWER_VALUE_ANSWER_TEXT:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      NZIS_ANSWER_VALUE_CL028: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      NZIS_ANSWER_VALUE_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TNZIS_ANSWER_VALUEColl.IndexValueListNodes(propIndex: TNZIS_ANSWER_VALUEItem.TPropertyIndex);
begin

end;

function TNZIS_ANSWER_VALUEColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TNZIS_ANSWER_VALUEItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TNZIS_ANSWER_VALUEColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TNZIS_ANSWER_VALUEItem;
begin
  if index < 0 then
  begin
    Tempitem := TNZIS_ANSWER_VALUEItem.Create(nil);
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
procedure TNZIS_ANSWER_VALUEColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TNZIS_ANSWER_VALUEItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TNZIS_ANSWER_VALUEItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TNZIS_ANSWER_VALUEItem.TPropertyIndex(Field) of
NZIS_ANSWER_VALUE_ANSWER_CODE: ListForFinder[0].PRecord.ANSWER_CODE := AText;
    NZIS_ANSWER_VALUE_ANSWER_TEXT: ListForFinder[0].PRecord.ANSWER_TEXT := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TNZIS_ANSWER_VALUEColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TNZIS_ANSWER_VALUEItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TNZIS_ANSWER_VALUEItem.TPropertyIndex(Field) of
NZIS_ANSWER_VALUE_ANSWER_DATE: ListForFinder[0].PRecord.ANSWER_DATE := Value;
  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TNZIS_ANSWER_VALUEColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TNZIS_ANSWER_VALUEItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TNZIS_ANSWER_VALUEItem.TPropertyIndex(Field) of
NZIS_ANSWER_VALUE_ANSWER_QUANTITY: ListForFinder[0].PRecord.ANSWER_QUANTITY := Value;
    NZIS_ANSWER_VALUE_CL028: ListForFinder[0].PRecord.CL028 := Value;
    NZIS_ANSWER_VALUE_ID: ListForFinder[0].PRecord.ID := Value;
    NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: ListForFinder[0].PRecord.QUESTIONNAIRE_ANSWER_ID := Value;
    NZIS_ANSWER_VALUE_NOMEN_POS: ListForFinder[0].PRecord.NOMEN_POS := Value;
  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TNZIS_ANSWER_VALUEColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TNZIS_ANSWER_VALUEItem.TPropertyIndex(Field) of
    NZIS_ANSWER_VALUE_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalNZIS_ANSWER_VALUE(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalNZIS_ANSWER_VALUE(logIndex))   
    end;
  end;
end;


procedure TNZIS_ANSWER_VALUEColl.OnSetTextSearchLog(Log: TlogicalNZIS_ANSWER_VALUESet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TNZIS_ANSWER_VALUEColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TNZIS_ANSWER_VALUEColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TNZIS_ANSWER_VALUEItem.TPropertyIndex(propIndex) of
    NZIS_ANSWER_VALUE_ANSWER_CODE: Result := actAnsiString;
    NZIS_ANSWER_VALUE_ANSWER_DATE: Result := actTDate;
    NZIS_ANSWER_VALUE_ANSWER_QUANTITY: Result := actdouble;
    NZIS_ANSWER_VALUE_ANSWER_TEXT: Result := actAnsiString;
    NZIS_ANSWER_VALUE_CL028: Result := actword;
    NZIS_ANSWER_VALUE_ID: Result := actinteger;
    NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: Result := actinteger;
    NZIS_ANSWER_VALUE_NOMEN_POS: Result := actcardinal;
    NZIS_ANSWER_VALUE_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TNZIS_ANSWER_VALUEColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TNZIS_ANSWER_VALUEColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  NZIS_ANSWER_VALUE: TNZIS_ANSWER_VALUEItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  NZIS_ANSWER_VALUE := Items[ARow];
  if not Assigned(NZIS_ANSWER_VALUE.PRecord) then
  begin
    New(NZIS_ANSWER_VALUE.PRecord);
    NZIS_ANSWER_VALUE.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol) of
      NZIS_ANSWER_VALUE_ANSWER_CODE: isOld :=  NZIS_ANSWER_VALUE.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    NZIS_ANSWER_VALUE_ANSWER_DATE: isOld :=  NZIS_ANSWER_VALUE.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    NZIS_ANSWER_VALUE_ANSWER_TEXT: isOld :=  NZIS_ANSWER_VALUE.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    NZIS_ANSWER_VALUE_CL028: isOld :=  NZIS_ANSWER_VALUE.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    NZIS_ANSWER_VALUE_ID: isOld :=  NZIS_ANSWER_VALUE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: isOld :=  NZIS_ANSWER_VALUE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    NZIS_ANSWER_VALUE_NOMEN_POS: isOld :=  NZIS_ANSWER_VALUE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(NZIS_ANSWER_VALUE.PRecord.setProp, TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol));
    if NZIS_ANSWER_VALUE.PRecord.setProp = [] then
    begin
      Dispose(NZIS_ANSWER_VALUE.PRecord);
      NZIS_ANSWER_VALUE.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NZIS_ANSWER_VALUE.PRecord.setProp, TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol));
  case TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol) of
    NZIS_ANSWER_VALUE_ANSWER_CODE: NZIS_ANSWER_VALUE.PRecord.ANSWER_CODE := AValue;
    NZIS_ANSWER_VALUE_ANSWER_DATE: NZIS_ANSWER_VALUE.PRecord.ANSWER_DATE := StrToDate(AValue);
    NZIS_ANSWER_VALUE_ANSWER_QUANTITY: NZIS_ANSWER_VALUE.PRecord.ANSWER_QUANTITY := StrToFloat(AValue);
    NZIS_ANSWER_VALUE_ANSWER_TEXT: NZIS_ANSWER_VALUE.PRecord.ANSWER_TEXT := AValue;
    NZIS_ANSWER_VALUE_CL028: NZIS_ANSWER_VALUE.PRecord.CL028 := StrToInt(AValue);
    NZIS_ANSWER_VALUE_ID: NZIS_ANSWER_VALUE.PRecord.ID := StrToInt(AValue);
    NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: NZIS_ANSWER_VALUE.PRecord.QUESTIONNAIRE_ANSWER_ID := StrToInt(AValue);
    NZIS_ANSWER_VALUE_NOMEN_POS: NZIS_ANSWER_VALUE.PRecord.NOMEN_POS := StrToInt(AValue);
    NZIS_ANSWER_VALUE_Logical: NZIS_ANSWER_VALUE.PRecord.Logical := tlogicalNZIS_ANSWER_VALUESet(NZIS_ANSWER_VALUE.StrToLogical08(AValue));
  end;
end;

procedure TNZIS_ANSWER_VALUEColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  NZIS_ANSWER_VALUE: TNZIS_ANSWER_VALUEItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  NZIS_ANSWER_VALUE := Items[ARow];
  if not Assigned(NZIS_ANSWER_VALUE.PRecord) then
  begin
    New(NZIS_ANSWER_VALUE.PRecord);
    NZIS_ANSWER_VALUE.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol) of
      NZIS_ANSWER_VALUE_ANSWER_CODE: isOld :=  NZIS_ANSWER_VALUE.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    NZIS_ANSWER_VALUE_ANSWER_DATE: isOld :=  NZIS_ANSWER_VALUE.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    NZIS_ANSWER_VALUE_ANSWER_TEXT: isOld :=  NZIS_ANSWER_VALUE.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    NZIS_ANSWER_VALUE_CL028: isOld :=  NZIS_ANSWER_VALUE.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    NZIS_ANSWER_VALUE_ID: isOld :=  NZIS_ANSWER_VALUE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: isOld :=  NZIS_ANSWER_VALUE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    NZIS_ANSWER_VALUE_NOMEN_POS: isOld :=  NZIS_ANSWER_VALUE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(NZIS_ANSWER_VALUE.PRecord.setProp, TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol));
    if NZIS_ANSWER_VALUE.PRecord.setProp = [] then
    begin
      Dispose(NZIS_ANSWER_VALUE.PRecord);
      NZIS_ANSWER_VALUE.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NZIS_ANSWER_VALUE.PRecord.setProp, TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol));
  case TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol) of
    NZIS_ANSWER_VALUE_ANSWER_CODE: NZIS_ANSWER_VALUE.PRecord.ANSWER_CODE := AFieldText;
    NZIS_ANSWER_VALUE_ANSWER_DATE: NZIS_ANSWER_VALUE.PRecord.ANSWER_DATE := StrToDate(AFieldText);
    NZIS_ANSWER_VALUE_ANSWER_QUANTITY: NZIS_ANSWER_VALUE.PRecord.ANSWER_QUANTITY := StrToFloat(AFieldText);
    NZIS_ANSWER_VALUE_ANSWER_TEXT: NZIS_ANSWER_VALUE.PRecord.ANSWER_TEXT := AFieldText;
    NZIS_ANSWER_VALUE_CL028: NZIS_ANSWER_VALUE.PRecord.CL028 := StrToInt(AFieldText);
    NZIS_ANSWER_VALUE_ID: NZIS_ANSWER_VALUE.PRecord.ID := StrToInt(AFieldText);
    NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: NZIS_ANSWER_VALUE.PRecord.QUESTIONNAIRE_ANSWER_ID := StrToInt(AFieldText);
    NZIS_ANSWER_VALUE_NOMEN_POS: NZIS_ANSWER_VALUE.PRecord.NOMEN_POS := StrToInt(AFieldText);
    NZIS_ANSWER_VALUE_Logical: NZIS_ANSWER_VALUE.PRecord.Logical := tlogicalNZIS_ANSWER_VALUESet(NZIS_ANSWER_VALUE.StrToLogical08(AFieldText));
  end;
end;

procedure TNZIS_ANSWER_VALUEColl.SetItem(Index: Integer; const Value: TNZIS_ANSWER_VALUEItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TNZIS_ANSWER_VALUEColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListNZIS_ANSWER_VALUESearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TNZIS_ANSWER_VALUEItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  NZIS_ANSWER_VALUE_ANSWER_CODE:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListNZIS_ANSWER_VALUESearch.Add(self.Items[i]);
  end;
end;
      NZIS_ANSWER_VALUE_ANSWER_TEXT:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNZIS_ANSWER_VALUESearch.Add(self.Items[i]);
        end;
      end;
      NZIS_ANSWER_VALUE_CL028: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListNZIS_ANSWER_VALUESearch.Add(self.Items[i]);
        end;
      end;
      NZIS_ANSWER_VALUE_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_ANSWER_VALUESearch.Add(self.Items[i]);
        end;
      end;
      NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_ANSWER_VALUESearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TNZIS_ANSWER_VALUEColl.ShowGrid(Grid: TTeeGrid);
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

procedure TNZIS_ANSWER_VALUEColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TNZIS_ANSWER_VALUEItem>);
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

procedure TNZIS_ANSWER_VALUEColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListNZIS_ANSWER_VALUESearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListNZIS_ANSWER_VALUESearch.Count]);

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

procedure TNZIS_ANSWER_VALUEColl.SortByIndexAnsiString;
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

procedure TNZIS_ANSWER_VALUEColl.SortByIndexInt;
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

procedure TNZIS_ANSWER_VALUEColl.SortByIndexWord;
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

procedure TNZIS_ANSWER_VALUEColl.SortByIndexValue(propIndex: TNZIS_ANSWER_VALUEItem.TPropertyIndex);
begin
  case propIndex of
    NZIS_ANSWER_VALUE_ANSWER_CODE: SortByIndexAnsiString;
      NZIS_ANSWER_VALUE_ANSWER_TEXT: SortByIndexAnsiString;
      NZIS_ANSWER_VALUE_CL028: SortByIndexWord;
      NZIS_ANSWER_VALUE_ID: SortByIndexInt;
      NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: SortByIndexInt;
  end;
end;

end.