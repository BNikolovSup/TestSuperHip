unit Table.BLANKA_MED_NAPR;

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

TLogicalBLANKA_MED_NAPR = (
    EXAMED_BY_SPECIALIST,
    IS_PRINTED,
    NZIS_STATUS_None,
    NZIS_STATUS_Valid,
    NZIS_STATUS_NoValid,
    NZIS_STATUS_Sended,
    NZIS_STATUS_Err,
    NZIS_STATUS_Cancel,
    NZIS_STATUS_Edited,
    MED_NAPR_Ostro,
    MED_NAPR_Hron,
    MED_NAPR_Izbor,
    MED_NAPR_Disp,
    MED_NAPR_Eksp,
    MED_NAPR_Prof,
    MED_NAPR_Iskane_Telk,
    MED_NAPR_Choice_Mother,
    MED_NAPR_Choice_Child,
    MED_NAPR_PreChoice_Mother,
    MED_NAPR_PreChoice_Child,
    MED_NAPR_Podg_Telk);
TlogicalBLANKA_MED_NAPRSet = set of TLogicalBLANKA_MED_NAPR;


TBLANKA_MED_NAPRItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       BLANKA_MED_NAPR_ID
       , BLANKA_MED_NAPR_ISSUE_DATE
       , BLANKA_MED_NAPR_NRN
       , BLANKA_MED_NAPR_NUMBER
       , BLANKA_MED_NAPR_PREGLED_ID
       , BLANKA_MED_NAPR_REASON
       , BLANKA_MED_NAPR_SPECIALITY_ID
       , BLANKA_MED_NAPR_SpecDataPos
       , BLANKA_MED_NAPR_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecBLANKA_MED_NAPR = ^TRecBLANKA_MED_NAPR;
      TRecBLANKA_MED_NAPR = record
        ID: integer;
        ISSUE_DATE: TDate;
        NRN: AnsiString;
        NUMBER: integer;
        PREGLED_ID: integer;
        REASON: AnsiString;
        SPECIALITY_ID: integer;
        SpecDataPos: Cardinal;
        Logical: TlogicalBLANKA_MED_NAPRSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecBLANKA_MED_NAPR;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertBLANKA_MED_NAPR;
    procedure UpdateBLANKA_MED_NAPR;
    procedure SaveBLANKA_MED_NAPR(var dataPosition: Cardinal)overload;
	procedure SaveBLANKA_MED_NAPR(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TBLANKA_MED_NAPRColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TBLANKA_MED_NAPRItem;
    function GetItem(Index: Integer): TBLANKA_MED_NAPRItem;
    procedure SetItem(Index: Integer; const Value: TBLANKA_MED_NAPRItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TBLANKA_MED_NAPRItem>;
    ListBLANKA_MED_NAPRSearch: TList<TBLANKA_MED_NAPRItem>;
	PRecordSearch: ^TBLANKA_MED_NAPRItem.TRecBLANKA_MED_NAPR;
    ArrPropSearch: TArray<TBLANKA_MED_NAPRItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TBLANKA_MED_NAPRItem.TPropertyIndex>;
	VisibleColl: TBLANKA_MED_NAPRItem.TSetProp;
	ArrayPropOrder: TArray<TBLANKA_MED_NAPRItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TBLANKA_MED_NAPRItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; BLANKA_MED_NAPR: TBLANKA_MED_NAPRItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; BLANKA_MED_NAPR: TBLANKA_MED_NAPRItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TBLANKA_MED_NAPRItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TBLANKA_MED_NAPRItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TBLANKA_MED_NAPRItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TBLANKA_MED_NAPRItem.TPropertyIndex);
    property Items[Index: Integer]: TBLANKA_MED_NAPRItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalBLANKA_MED_NAPRSet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
  end;

implementation

{ TBLANKA_MED_NAPRItem }

constructor TBLANKA_MED_NAPRItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TBLANKA_MED_NAPRItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TBLANKA_MED_NAPRItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TBLANKA_MED_NAPRItem.GetCollType: TCollectionsType;
begin
  Result := ctBLANKA_MED_NAPR;
end;

function TBLANKA_MED_NAPRItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TBLANKA_MED_NAPRItem.InsertBLANKA_MED_NAPR;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctBLANKA_MED_NAPR;
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
            BLANKA_MED_NAPR_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_ISSUE_DATE: SaveData(PRecord.ISSUE_DATE, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_NRN: SaveData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_NUMBER: SaveData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_PREGLED_ID: SaveData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_REASON: SaveData(PRecord.REASON, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_SPECIALITY_ID: SaveData(PRecord.SPECIALITY_ID, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_SpecDataPos: SaveData(PRecord.SpecDataPos, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_Logical: SaveData(TLogicalData24(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TBLANKA_MED_NAPRItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TBLANKA_MED_NAPRItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TBLANKA_MED_NAPRItem;
begin
  Result := True;
  for i := 0 to Length(TBLANKA_MED_NAPRColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TBLANKA_MED_NAPRColl(coll).ArrPropSearchClc[i];
	ATempItem := TBLANKA_MED_NAPRColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        BLANKA_MED_NAPR_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(BLANKA_MED_NAPR_ID), cot);
            BLANKA_MED_NAPR_ISSUE_DATE: Result := IsFinded(ATempItem.PRecord.ISSUE_DATE, buf, FPosDataADB, word(BLANKA_MED_NAPR_ISSUE_DATE), cot);
            BLANKA_MED_NAPR_NRN: Result := IsFinded(ATempItem.PRecord.NRN, buf, FPosDataADB, word(BLANKA_MED_NAPR_NRN), cot);
            BLANKA_MED_NAPR_NUMBER: Result := IsFinded(ATempItem.PRecord.NUMBER, buf, FPosDataADB, word(BLANKA_MED_NAPR_NUMBER), cot);
            BLANKA_MED_NAPR_PREGLED_ID: Result := IsFinded(ATempItem.PRecord.PREGLED_ID, buf, FPosDataADB, word(BLANKA_MED_NAPR_PREGLED_ID), cot);
            BLANKA_MED_NAPR_REASON: Result := IsFinded(ATempItem.PRecord.REASON, buf, FPosDataADB, word(BLANKA_MED_NAPR_REASON), cot);
            BLANKA_MED_NAPR_SPECIALITY_ID: Result := IsFinded(ATempItem.PRecord.SPECIALITY_ID, buf, FPosDataADB, word(BLANKA_MED_NAPR_SPECIALITY_ID), cot);
            BLANKA_MED_NAPR_SpecDataPos: Result := IsFinded(ATempItem.PRecord.SpecDataPos, buf, FPosDataADB, word(BLANKA_MED_NAPR_SpecDataPos), cot);
            BLANKA_MED_NAPR_Logical: Result := IsFinded(TLogicalData24(ATempItem.PRecord.Logical), buf, FPosDataADB, word(BLANKA_MED_NAPR_Logical), cot);
      end;
    end;
  end;
end;

procedure TBLANKA_MED_NAPRItem.SaveBLANKA_MED_NAPR(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveBLANKA_MED_NAPR(dataPosition);
end;

procedure TBLANKA_MED_NAPRItem.SaveBLANKA_MED_NAPR(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctBLANKA_MED_NAPR;
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
            BLANKA_MED_NAPR_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_ISSUE_DATE: SaveData(PRecord.ISSUE_DATE, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_NRN: SaveData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_NUMBER: SaveData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_PREGLED_ID: SaveData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_REASON: SaveData(PRecord.REASON, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_SPECIALITY_ID: SaveData(PRecord.SPECIALITY_ID, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_SpecDataPos: SaveData(PRecord.SpecDataPos, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_Logical: SaveData(TLogicalData24(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TBLANKA_MED_NAPRItem.UpdateBLANKA_MED_NAPR;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctBLANKA_MED_NAPR;
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
            BLANKA_MED_NAPR_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_ISSUE_DATE: UpdateData(PRecord.ISSUE_DATE, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_NRN: UpdateData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_NUMBER: UpdateData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_PREGLED_ID: UpdateData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_REASON: UpdateData(PRecord.REASON, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_SPECIALITY_ID: UpdateData(PRecord.SPECIALITY_ID, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_SpecDataPos: UpdateData(PRecord.SpecDataPos, PropPosition, metaPosition, dataPosition);
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

{ TBLANKA_MED_NAPRColl }

function TBLANKA_MED_NAPRColl.AddItem(ver: word): TBLANKA_MED_NAPRItem;
begin
  Result := TBLANKA_MED_NAPRItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TBLANKA_MED_NAPRColl.AddItemForSearch: Integer;
var
  ItemForSearch: TBLANKA_MED_NAPRItem;
begin
  ItemForSearch := TBLANKA_MED_NAPRItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TBLANKA_MED_NAPRColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TBLANKA_MED_NAPRItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TBLANKA_MED_NAPRColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvBLANKA_MED_NAPRRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TBLANKA_MED_NAPRColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TBLANKA_MED_NAPRItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (BLANKA_MED_NAPR_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.ID <> Self.getIntMap(tempItem.DataPos, word(BLANKA_MED_NAPR_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_ISSUE_DATE in tempItem.PRecord.setProp) and (tempItem.PRecord.ISSUE_DATE <> Self.getDateMap(tempItem.DataPos, word(BLANKA_MED_NAPR_ISSUE_DATE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_NRN in tempItem.PRecord.setProp) and (tempItem.PRecord.NRN <> Self.getAnsiStringMap(tempItem.DataPos, word(BLANKA_MED_NAPR_NRN))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_NUMBER in tempItem.PRecord.setProp) and (tempItem.PRecord.NUMBER <> Self.getIntMap(tempItem.DataPos, word(BLANKA_MED_NAPR_NUMBER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_PREGLED_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.PREGLED_ID <> Self.getIntMap(tempItem.DataPos, word(BLANKA_MED_NAPR_PREGLED_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_REASON in tempItem.PRecord.setProp) and (tempItem.PRecord.REASON <> Self.getAnsiStringMap(tempItem.DataPos, word(BLANKA_MED_NAPR_REASON))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_SPECIALITY_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.SPECIALITY_ID <> Self.getIntMap(tempItem.DataPos, word(BLANKA_MED_NAPR_SPECIALITY_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_SpecDataPos in tempItem.PRecord.setProp) and (tempItem.PRecord.SpecDataPos <> Self.getIntMap(tempItem.DataPos, word(BLANKA_MED_NAPR_SpecDataPos))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_Logical in tempItem.PRecord.setProp) and (TLogicalData24(tempItem.PRecord.Logical) <> Self.getLogical24Map(tempItem.DataPos, word(BLANKA_MED_NAPR_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TBLANKA_MED_NAPRColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TBLANKA_MED_NAPRItem.Create(nil);
  ListBLANKA_MED_NAPRSearch := TList<TBLANKA_MED_NAPRItem>.Create;
  ListForFinder := TList<TBLANKA_MED_NAPRItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TBLANKA_MED_NAPRColl.destroy;
begin
  FreeAndNil(ListBLANKA_MED_NAPRSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TBLANKA_MED_NAPRColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TBLANKA_MED_NAPRItem.TPropertyIndex(propIndex) of
    BLANKA_MED_NAPR_ID: Result := 'ID';
    BLANKA_MED_NAPR_ISSUE_DATE: Result := 'ISSUE_DATE';
    BLANKA_MED_NAPR_NRN: Result := 'NRN';
    BLANKA_MED_NAPR_NUMBER: Result := 'NUMBER';
    BLANKA_MED_NAPR_PREGLED_ID: Result := 'PREGLED_ID';
    BLANKA_MED_NAPR_REASON: Result := 'REASON';
    BLANKA_MED_NAPR_SPECIALITY_ID: Result := 'SPECIALITY_ID';
    BLANKA_MED_NAPR_SpecDataPos: Result := 'SpecDataPos';
    BLANKA_MED_NAPR_Logical: Result := 'Logical';
  end;
end;

function TBLANKA_MED_NAPRColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'EXAMED_BY_SPECIALIST';
    1: Result := 'IS_PRINTED';
    2: Result := 'NZIS_STATUS_None';
    3: Result := 'NZIS_STATUS_Valid';
    4: Result := 'NZIS_STATUS_NoValid';
    5: Result := 'NZIS_STATUS_Sended';
    6: Result := 'NZIS_STATUS_Err';
    7: Result := 'NZIS_STATUS_Cancel';
    8: Result := 'NZIS_STATUS_Edited';
    9: Result := 'MED_NAPR_Ostro';
    10: Result := 'MED_NAPR_Hron';
    11: Result := 'MED_NAPR_Izbor';
    12: Result := 'MED_NAPR_Disp';
    13: Result := 'MED_NAPR_Eksp';
    14: Result := 'MED_NAPR_Prof';
    15: Result := 'MED_NAPR_Iskane_Telk';
    16: Result := 'MED_NAPR_Choice_Mother';
    17: Result := 'MED_NAPR_Choice_Child';
    18: Result := 'MED_NAPR_PreChoice_Mother';
    19: Result := 'MED_NAPR_PreChoice_Child';
    20: Result := 'MED_NAPR_Podg_Telk';
  else
    Result := '???';
  end;
end;


procedure TBLANKA_MED_NAPRColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TBLANKA_MED_NAPRColl.FieldCount: Integer; 
begin
  inherited;
  Result := 9;
end;

function TBLANKA_MED_NAPRColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvBLANKA_MED_NAPRRoot then
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

function TBLANKA_MED_NAPRColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TBLANKA_MED_NAPRColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TBLANKA_MED_NAPRColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TBLANKA_MED_NAPRColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  BLANKA_MED_NAPR: TBLANKA_MED_NAPRItem;
  ACol: Integer;
  prop: TBLANKA_MED_NAPRItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  BLANKA_MED_NAPR := Items[ARow];
  prop := TBLANKA_MED_NAPRItem.TPropertyIndex(ACol);
  if Assigned(BLANKA_MED_NAPR.PRecord) and (prop in BLANKA_MED_NAPR.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, BLANKA_MED_NAPR, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, BLANKA_MED_NAPR, AValue);
  end;
end;

procedure TBLANKA_MED_NAPRColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TBLANKA_MED_NAPRItem.TPropertyIndex;
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

procedure TBLANKA_MED_NAPRColl.GetCellFromRecord(propIndex: word; BLANKA_MED_NAPR: TBLANKA_MED_NAPRItem; var AValue: String);
var
  str: string;
begin
  case TBLANKA_MED_NAPRItem.TPropertyIndex(propIndex) of
    BLANKA_MED_NAPR_ID: str := inttostr(BLANKA_MED_NAPR.PRecord.ID);
    BLANKA_MED_NAPR_ISSUE_DATE: str := AspDateToStr(BLANKA_MED_NAPR.PRecord.ISSUE_DATE);
    BLANKA_MED_NAPR_NRN: str := (BLANKA_MED_NAPR.PRecord.NRN);
    BLANKA_MED_NAPR_NUMBER: str := inttostr(BLANKA_MED_NAPR.PRecord.NUMBER);
    BLANKA_MED_NAPR_PREGLED_ID: str := inttostr(BLANKA_MED_NAPR.PRecord.PREGLED_ID);
    BLANKA_MED_NAPR_REASON: str := (BLANKA_MED_NAPR.PRecord.REASON);
    BLANKA_MED_NAPR_SPECIALITY_ID: str := inttostr(BLANKA_MED_NAPR.PRecord.SPECIALITY_ID);
    BLANKA_MED_NAPR_SpecDataPos: str := inttostr(BLANKA_MED_NAPR.PRecord.SpecDataPos);
    BLANKA_MED_NAPR_Logical: str := BLANKA_MED_NAPR.Logical24ToStr(TLogicalData24(BLANKA_MED_NAPR.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TBLANKA_MED_NAPRColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TBLANKA_MED_NAPRItem;
  ACol: Integer;
  prop: TBLANKA_MED_NAPRItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TBLANKA_MED_NAPRItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TBLANKA_MED_NAPRColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TBLANKA_MED_NAPRItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TBLANKA_MED_NAPRItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TBLANKA_MED_NAPRColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  BLANKA_MED_NAPR: TBLANKA_MED_NAPRItem;
  ACol: Integer;
  prop: TBLANKA_MED_NAPRItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  BLANKA_MED_NAPR := ListBLANKA_MED_NAPRSearch[ARow];
  prop := TBLANKA_MED_NAPRItem.TPropertyIndex(ACol);
  if Assigned(BLANKA_MED_NAPR.PRecord) and (prop in BLANKA_MED_NAPR.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, BLANKA_MED_NAPR, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, BLANKA_MED_NAPR, AValue);
  end;
end;

function TBLANKA_MED_NAPRColl.GetCollType: TCollectionsType;
begin
  Result := ctBLANKA_MED_NAPR;
end;

function TBLANKA_MED_NAPRColl.GetCollDelType: TCollectionsType;
begin
  Result := ctBLANKA_MED_NAPRDel;
end;

procedure TBLANKA_MED_NAPRColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  BLANKA_MED_NAPR: TBLANKA_MED_NAPRItem;
  prop: TBLANKA_MED_NAPRItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  BLANKA_MED_NAPR := Items[ARow];
  prop := TBLANKA_MED_NAPRItem.TPropertyIndex(ACol);
  if Assigned(BLANKA_MED_NAPR.PRecord) and (prop in BLANKA_MED_NAPR.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, BLANKA_MED_NAPR, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, BLANKA_MED_NAPR, AFieldText);
  end;
end;

procedure TBLANKA_MED_NAPRColl.GetCellFromMap(propIndex: word; ARow: Integer; BLANKA_MED_NAPR: TBLANKA_MED_NAPRItem; var AValue: String);
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
  case TBLANKA_MED_NAPRItem.TPropertyIndex(propIndex) of
    BLANKA_MED_NAPR_ID: str :=  inttostr(BLANKA_MED_NAPR.getIntMap(Self.Buf, Self.posData, propIndex));
    BLANKA_MED_NAPR_ISSUE_DATE: str :=  AspDateToStr(BLANKA_MED_NAPR.getDateMap(Self.Buf, Self.posData, propIndex));
    BLANKA_MED_NAPR_NRN: str :=  BLANKA_MED_NAPR.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    BLANKA_MED_NAPR_NUMBER: str :=  inttostr(BLANKA_MED_NAPR.getIntMap(Self.Buf, Self.posData, propIndex));
    BLANKA_MED_NAPR_PREGLED_ID: str :=  inttostr(BLANKA_MED_NAPR.getIntMap(Self.Buf, Self.posData, propIndex));
    BLANKA_MED_NAPR_REASON: str :=  BLANKA_MED_NAPR.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    BLANKA_MED_NAPR_SPECIALITY_ID: str :=  inttostr(BLANKA_MED_NAPR.getIntMap(Self.Buf, Self.posData, propIndex));
    BLANKA_MED_NAPR_Logical: str :=  BLANKA_MED_NAPR.Logical24ToStr(BLANKA_MED_NAPR.getLogical24Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TBLANKA_MED_NAPRColl.GetItem(Index: Integer): TBLANKA_MED_NAPRItem;
begin
  Result := TBLANKA_MED_NAPRItem(inherited GetItem(Index));
end;


procedure TBLANKA_MED_NAPRColl.IndexValue(propIndex: TBLANKA_MED_NAPRItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TBLANKA_MED_NAPRItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      BLANKA_MED_NAPR_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      BLANKA_MED_NAPR_NRN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      BLANKA_MED_NAPR_NUMBER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      BLANKA_MED_NAPR_PREGLED_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      BLANKA_MED_NAPR_REASON:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      BLANKA_MED_NAPR_SPECIALITY_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TBLANKA_MED_NAPRColl.IndexValueListNodes(propIndex: TBLANKA_MED_NAPRItem.TPropertyIndex);
begin

end;

function TBLANKA_MED_NAPRColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TBLANKA_MED_NAPRItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TBLANKA_MED_NAPRColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TBLANKA_MED_NAPRItem;
begin
  if index < 0 then
  begin
    Tempitem := TBLANKA_MED_NAPRItem.Create(nil);
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
procedure TBLANKA_MED_NAPRColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TBLANKA_MED_NAPRItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TBLANKA_MED_NAPRItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TBLANKA_MED_NAPRItem.TPropertyIndex(Field) of
BLANKA_MED_NAPR_NRN: ListForFinder[0].PRecord.NRN := AText;
    BLANKA_MED_NAPR_REASON: ListForFinder[0].PRecord.REASON := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TBLANKA_MED_NAPRColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TBLANKA_MED_NAPRItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TBLANKA_MED_NAPRItem.TPropertyIndex(Field) of
BLANKA_MED_NAPR_ISSUE_DATE: ListForFinder[0].PRecord.ISSUE_DATE := Value;
  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TBLANKA_MED_NAPRColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TBLANKA_MED_NAPRItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TBLANKA_MED_NAPRItem.TPropertyIndex(Field) of
BLANKA_MED_NAPR_ID: ListForFinder[0].PRecord.ID := Value;
    BLANKA_MED_NAPR_NUMBER: ListForFinder[0].PRecord.NUMBER := Value;
    BLANKA_MED_NAPR_PREGLED_ID: ListForFinder[0].PRecord.PREGLED_ID := Value;
    BLANKA_MED_NAPR_SPECIALITY_ID: ListForFinder[0].PRecord.SPECIALITY_ID := Value;
    BLANKA_MED_NAPR_SpecDataPos: ListForFinder[0].PRecord.SpecDataPos := Value;
  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TBLANKA_MED_NAPRColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TBLANKA_MED_NAPRItem.TPropertyIndex(Field) of
    BLANKA_MED_NAPR_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalBLANKA_MED_NAPR(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalBLANKA_MED_NAPR(logIndex))   
    end;
  end;
end;


procedure TBLANKA_MED_NAPRColl.OnSetTextSearchLog(Log: TlogicalBLANKA_MED_NAPRSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TBLANKA_MED_NAPRColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TBLANKA_MED_NAPRColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TBLANKA_MED_NAPRItem.TPropertyIndex(propIndex) of
    BLANKA_MED_NAPR_ID: Result := actinteger;
    BLANKA_MED_NAPR_ISSUE_DATE: Result := actTDate;
    BLANKA_MED_NAPR_NRN: Result := actAnsiString;
    BLANKA_MED_NAPR_NUMBER: Result := actinteger;
    BLANKA_MED_NAPR_PREGLED_ID: Result := actinteger;
    BLANKA_MED_NAPR_REASON: Result := actAnsiString;
    BLANKA_MED_NAPR_SPECIALITY_ID: Result := actinteger;
    BLANKA_MED_NAPR_SpecDataPos: Result := actCardinal;
    BLANKA_MED_NAPR_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TBLANKA_MED_NAPRColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TBLANKA_MED_NAPRColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  BLANKA_MED_NAPR: TBLANKA_MED_NAPRItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  BLANKA_MED_NAPR := Items[ARow];
  if not Assigned(BLANKA_MED_NAPR.PRecord) then
  begin
    New(BLANKA_MED_NAPR.PRecord);
    BLANKA_MED_NAPR.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TBLANKA_MED_NAPRItem.TPropertyIndex(ACol) of
      BLANKA_MED_NAPR_ID: isOld :=  BLANKA_MED_NAPR.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    BLANKA_MED_NAPR_ISSUE_DATE: isOld :=  BLANKA_MED_NAPR.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    BLANKA_MED_NAPR_NRN: isOld :=  BLANKA_MED_NAPR.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    BLANKA_MED_NAPR_NUMBER: isOld :=  BLANKA_MED_NAPR.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    BLANKA_MED_NAPR_PREGLED_ID: isOld :=  BLANKA_MED_NAPR.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    BLANKA_MED_NAPR_REASON: isOld :=  BLANKA_MED_NAPR.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    BLANKA_MED_NAPR_SPECIALITY_ID: isOld :=  BLANKA_MED_NAPR.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(BLANKA_MED_NAPR.PRecord.setProp, TBLANKA_MED_NAPRItem.TPropertyIndex(ACol));
    if BLANKA_MED_NAPR.PRecord.setProp = [] then
    begin
      Dispose(BLANKA_MED_NAPR.PRecord);
      BLANKA_MED_NAPR.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(BLANKA_MED_NAPR.PRecord.setProp, TBLANKA_MED_NAPRItem.TPropertyIndex(ACol));
  case TBLANKA_MED_NAPRItem.TPropertyIndex(ACol) of
    BLANKA_MED_NAPR_ID: BLANKA_MED_NAPR.PRecord.ID := StrToInt(AValue);
    BLANKA_MED_NAPR_ISSUE_DATE: BLANKA_MED_NAPR.PRecord.ISSUE_DATE := StrToDate(AValue);
    BLANKA_MED_NAPR_NRN: BLANKA_MED_NAPR.PRecord.NRN := AValue;
    BLANKA_MED_NAPR_NUMBER: BLANKA_MED_NAPR.PRecord.NUMBER := StrToInt(AValue);
    BLANKA_MED_NAPR_PREGLED_ID: BLANKA_MED_NAPR.PRecord.PREGLED_ID := StrToInt(AValue);
    BLANKA_MED_NAPR_REASON: BLANKA_MED_NAPR.PRecord.REASON := AValue;
    BLANKA_MED_NAPR_SPECIALITY_ID: BLANKA_MED_NAPR.PRecord.SPECIALITY_ID := StrToInt(AValue);
    BLANKA_MED_NAPR_SpecDataPos: BLANKA_MED_NAPR.PRecord.SpecDataPos := StrToInt(AValue);
    BLANKA_MED_NAPR_Logical: BLANKA_MED_NAPR.PRecord.Logical := tlogicalBLANKA_MED_NAPRSet(BLANKA_MED_NAPR.StrToLogical24(AValue));
  end;
end;

procedure TBLANKA_MED_NAPRColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  BLANKA_MED_NAPR: TBLANKA_MED_NAPRItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  BLANKA_MED_NAPR := Items[ARow];
  if not Assigned(BLANKA_MED_NAPR.PRecord) then
  begin
    New(BLANKA_MED_NAPR.PRecord);
    BLANKA_MED_NAPR.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TBLANKA_MED_NAPRItem.TPropertyIndex(ACol) of
      BLANKA_MED_NAPR_ID: isOld :=  BLANKA_MED_NAPR.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    BLANKA_MED_NAPR_ISSUE_DATE: isOld :=  BLANKA_MED_NAPR.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    BLANKA_MED_NAPR_NRN: isOld :=  BLANKA_MED_NAPR.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    BLANKA_MED_NAPR_NUMBER: isOld :=  BLANKA_MED_NAPR.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    BLANKA_MED_NAPR_PREGLED_ID: isOld :=  BLANKA_MED_NAPR.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    BLANKA_MED_NAPR_REASON: isOld :=  BLANKA_MED_NAPR.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    BLANKA_MED_NAPR_SPECIALITY_ID: isOld :=  BLANKA_MED_NAPR.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(BLANKA_MED_NAPR.PRecord.setProp, TBLANKA_MED_NAPRItem.TPropertyIndex(ACol));
    if BLANKA_MED_NAPR.PRecord.setProp = [] then
    begin
      Dispose(BLANKA_MED_NAPR.PRecord);
      BLANKA_MED_NAPR.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(BLANKA_MED_NAPR.PRecord.setProp, TBLANKA_MED_NAPRItem.TPropertyIndex(ACol));
  case TBLANKA_MED_NAPRItem.TPropertyIndex(ACol) of
    BLANKA_MED_NAPR_ID: BLANKA_MED_NAPR.PRecord.ID := StrToInt(AFieldText);
    BLANKA_MED_NAPR_ISSUE_DATE: BLANKA_MED_NAPR.PRecord.ISSUE_DATE := StrToDate(AFieldText);
    BLANKA_MED_NAPR_NRN: BLANKA_MED_NAPR.PRecord.NRN := AFieldText;
    BLANKA_MED_NAPR_NUMBER: BLANKA_MED_NAPR.PRecord.NUMBER := StrToInt(AFieldText);
    BLANKA_MED_NAPR_PREGLED_ID: BLANKA_MED_NAPR.PRecord.PREGLED_ID := StrToInt(AFieldText);
    BLANKA_MED_NAPR_REASON: BLANKA_MED_NAPR.PRecord.REASON := AFieldText;
    BLANKA_MED_NAPR_SPECIALITY_ID: BLANKA_MED_NAPR.PRecord.SPECIALITY_ID := StrToInt(AFieldText);
    BLANKA_MED_NAPR_SpecDataPos: BLANKA_MED_NAPR.PRecord.SpecDataPos := StrToInt(AFieldText);
    BLANKA_MED_NAPR_Logical: BLANKA_MED_NAPR.PRecord.Logical := tlogicalBLANKA_MED_NAPRSet(BLANKA_MED_NAPR.StrToLogical24(AFieldText));
  end;
end;

procedure TBLANKA_MED_NAPRColl.SetItem(Index: Integer; const Value: TBLANKA_MED_NAPRItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TBLANKA_MED_NAPRColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListBLANKA_MED_NAPRSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TBLANKA_MED_NAPRItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  BLANKA_MED_NAPR_ID: 
begin
  if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
  begin
    ListBLANKA_MED_NAPRSearch.Add(self.Items[i]);
  end;
end;
      BLANKA_MED_NAPR_NRN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListBLANKA_MED_NAPRSearch.Add(self.Items[i]);
        end;
      end;
      BLANKA_MED_NAPR_NUMBER: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListBLANKA_MED_NAPRSearch.Add(self.Items[i]);
        end;
      end;
      BLANKA_MED_NAPR_PREGLED_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListBLANKA_MED_NAPRSearch.Add(self.Items[i]);
        end;
      end;
      BLANKA_MED_NAPR_REASON:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListBLANKA_MED_NAPRSearch.Add(self.Items[i]);
        end;
      end;
      BLANKA_MED_NAPR_SPECIALITY_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListBLANKA_MED_NAPRSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TBLANKA_MED_NAPRColl.ShowGrid(Grid: TTeeGrid);
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

procedure TBLANKA_MED_NAPRColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TBLANKA_MED_NAPRItem>);
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

procedure TBLANKA_MED_NAPRColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListBLANKA_MED_NAPRSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListBLANKA_MED_NAPRSearch.Count]);

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

procedure TBLANKA_MED_NAPRColl.SortByIndexAnsiString;
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

procedure TBLANKA_MED_NAPRColl.SortByIndexInt;
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

procedure TBLANKA_MED_NAPRColl.SortByIndexWord;
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

procedure TBLANKA_MED_NAPRColl.SortByIndexValue(propIndex: TBLANKA_MED_NAPRItem.TPropertyIndex);
begin
  case propIndex of
    BLANKA_MED_NAPR_ID: SortByIndexInt;
      BLANKA_MED_NAPR_NRN: SortByIndexAnsiString;
      BLANKA_MED_NAPR_NUMBER: SortByIndexInt;
      BLANKA_MED_NAPR_PREGLED_ID: SortByIndexInt;
      BLANKA_MED_NAPR_REASON: SortByIndexAnsiString;
      BLANKA_MED_NAPR_SPECIALITY_ID: SortByIndexInt;
  end;
end;

end.