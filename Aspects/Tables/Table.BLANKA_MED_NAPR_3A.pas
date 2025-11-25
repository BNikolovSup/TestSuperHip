unit Table.BLANKA_MED_NAPR_3A;

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

TLogicalBLANKA_MED_NAPR_3A = (
    NZIS_STATUS_None,
    NZIS_STATUS_Valid,
    NZIS_STATUS_NoValid,
    NZIS_STATUS_Sended,
    NZIS_STATUS_Err,
    NZIS_STATUS_Cancel,
    NZIS_STATUS_Edited,
    MED_NAPR_3A_Ostro,
    MED_NAPR_3A_Hron,
    MED_NAPR_3A_Izbor,
    MED_NAPR_3A_Disp,
    MED_NAPR_3A_Eksp,
    MED_NAPR_3A_Prof,
    MED_NAPR_3A_Iskane_Telk,
    MED_NAPR_3A_Choice_Mother,
    MED_NAPR_3A_Choice_Child,
    MED_NAPR_3A_PreChoice_Mother,
    MED_NAPR_3A_PreChoice_Child,
    MED_NAPR_3A_Podg_Telk,
    IS_BOLNICHNA);
TlogicalBLANKA_MED_NAPR_3ASet = set of TLogicalBLANKA_MED_NAPR_3A;


TBLANKA_MED_NAPR_3AItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       BLANKA_MED_NAPR_3A_ATTACHED_DOCS
       , BLANKA_MED_NAPR_3A_ID
       , BLANKA_MED_NAPR_3A_ISSUE_DATE
       , BLANKA_MED_NAPR_3A_NRN
       , BLANKA_MED_NAPR_3A_NUMBER
       , BLANKA_MED_NAPR_3A_REASON
       , BLANKA_MED_NAPR_3A_SPECIALITY_ID
       , BLANKA_MED_NAPR_3A_VSD_CODE
       , BLANKA_MED_NAPR_3A_SpecDataPos
       , BLANKA_MED_NAPR_3A_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecBLANKA_MED_NAPR_3A = ^TRecBLANKA_MED_NAPR_3A;
      TRecBLANKA_MED_NAPR_3A = record
        ATTACHED_DOCS: AnsiString;
        ID: integer;
        ISSUE_DATE: TDate;
        NRN: AnsiString;
        NUMBER: integer;
        REASON: AnsiString;
        SPECIALITY_ID: integer;
        VSD_CODE: AnsiString;
        SpecDataPos: cardinal;
        Logical: TlogicalBLANKA_MED_NAPR_3ASet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecBLANKA_MED_NAPR_3A;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertBLANKA_MED_NAPR_3A;
    procedure UpdateBLANKA_MED_NAPR_3A;
    procedure SaveBLANKA_MED_NAPR_3A(var dataPosition: Cardinal)overload;
	procedure SaveBLANKA_MED_NAPR_3A(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TBLANKA_MED_NAPR_3AColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TBLANKA_MED_NAPR_3AItem;
    function GetItem(Index: Integer): TBLANKA_MED_NAPR_3AItem;
    procedure SetItem(Index: Integer; const Value: TBLANKA_MED_NAPR_3AItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TBLANKA_MED_NAPR_3AItem>;
    ListBLANKA_MED_NAPR_3ASearch: TList<TBLANKA_MED_NAPR_3AItem>;
	PRecordSearch: ^TBLANKA_MED_NAPR_3AItem.TRecBLANKA_MED_NAPR_3A;
    ArrPropSearch: TArray<TBLANKA_MED_NAPR_3AItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TBLANKA_MED_NAPR_3AItem.TPropertyIndex>;
	VisibleColl: TBLANKA_MED_NAPR_3AItem.TSetProp;
	ArrayPropOrder: TArray<TBLANKA_MED_NAPR_3AItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TBLANKA_MED_NAPR_3AItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; BLANKA_MED_NAPR_3A: TBLANKA_MED_NAPR_3AItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; BLANKA_MED_NAPR_3A: TBLANKA_MED_NAPR_3AItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TBLANKA_MED_NAPR_3AItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TBLANKA_MED_NAPR_3AItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TBLANKA_MED_NAPR_3AItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TBLANKA_MED_NAPR_3AItem.TPropertyIndex);
    property Items[Index: Integer]: TBLANKA_MED_NAPR_3AItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalBLANKA_MED_NAPR_3ASet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
  end;

implementation

{ TBLANKA_MED_NAPR_3AItem }

constructor TBLANKA_MED_NAPR_3AItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TBLANKA_MED_NAPR_3AItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TBLANKA_MED_NAPR_3AItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TBLANKA_MED_NAPR_3AItem.GetCollType: TCollectionsType;
begin
  Result := ctBLANKA_MED_NAPR_3A;
end;

function TBLANKA_MED_NAPR_3AItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TBLANKA_MED_NAPR_3AItem.InsertBLANKA_MED_NAPR_3A;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctBLANKA_MED_NAPR_3A;
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
            BLANKA_MED_NAPR_3A_ATTACHED_DOCS: SaveData(PRecord.ATTACHED_DOCS, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_ISSUE_DATE: SaveData(PRecord.ISSUE_DATE, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_NRN: SaveData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_NUMBER: SaveData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_REASON: SaveData(PRecord.REASON, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_SPECIALITY_ID: SaveData(PRecord.SPECIALITY_ID, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_VSD_CODE: SaveData(PRecord.VSD_CODE, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_SpecDataPos: SaveData(PRecord.SpecDataPos, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_Logical: SaveData(TLogicalData24(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TBLANKA_MED_NAPR_3AItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TBLANKA_MED_NAPR_3AItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TBLANKA_MED_NAPR_3AItem;
begin
  Result := True;
  for i := 0 to Length(TBLANKA_MED_NAPR_3AColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TBLANKA_MED_NAPR_3AColl(coll).ArrPropSearchClc[i];
	ATempItem := TBLANKA_MED_NAPR_3AColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        BLANKA_MED_NAPR_3A_ATTACHED_DOCS: Result := IsFinded(ATempItem.PRecord.ATTACHED_DOCS, buf, FPosDataADB, word(BLANKA_MED_NAPR_3A_ATTACHED_DOCS), cot);
            BLANKA_MED_NAPR_3A_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(BLANKA_MED_NAPR_3A_ID), cot);
            BLANKA_MED_NAPR_3A_ISSUE_DATE: Result := IsFinded(ATempItem.PRecord.ISSUE_DATE, buf, FPosDataADB, word(BLANKA_MED_NAPR_3A_ISSUE_DATE), cot);
            BLANKA_MED_NAPR_3A_NRN: Result := IsFinded(ATempItem.PRecord.NRN, buf, FPosDataADB, word(BLANKA_MED_NAPR_3A_NRN), cot);
            BLANKA_MED_NAPR_3A_NUMBER: Result := IsFinded(ATempItem.PRecord.NUMBER, buf, FPosDataADB, word(BLANKA_MED_NAPR_3A_NUMBER), cot);
            BLANKA_MED_NAPR_3A_REASON: Result := IsFinded(ATempItem.PRecord.REASON, buf, FPosDataADB, word(BLANKA_MED_NAPR_3A_REASON), cot);
            BLANKA_MED_NAPR_3A_SPECIALITY_ID: Result := IsFinded(ATempItem.PRecord.SPECIALITY_ID, buf, FPosDataADB, word(BLANKA_MED_NAPR_3A_SPECIALITY_ID), cot);
            BLANKA_MED_NAPR_3A_VSD_CODE: Result := IsFinded(ATempItem.PRecord.VSD_CODE, buf, FPosDataADB, word(BLANKA_MED_NAPR_3A_VSD_CODE), cot);
            BLANKA_MED_NAPR_3A_SpecDataPos: Result := IsFinded(ATempItem.PRecord.SpecDataPos, buf, FPosDataADB, word(BLANKA_MED_NAPR_3A_SpecDataPos), cot);
            BLANKA_MED_NAPR_3A_Logical: Result := IsFinded(TLogicalData24(ATempItem.PRecord.Logical), buf, FPosDataADB, word(BLANKA_MED_NAPR_3A_Logical), cot);
      end;
    end;
  end;
end;

procedure TBLANKA_MED_NAPR_3AItem.SaveBLANKA_MED_NAPR_3A(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveBLANKA_MED_NAPR_3A(dataPosition);
end;

procedure TBLANKA_MED_NAPR_3AItem.SaveBLANKA_MED_NAPR_3A(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctBLANKA_MED_NAPR_3A;
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
            BLANKA_MED_NAPR_3A_ATTACHED_DOCS: SaveData(PRecord.ATTACHED_DOCS, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_ISSUE_DATE: SaveData(PRecord.ISSUE_DATE, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_NRN: SaveData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_NUMBER: SaveData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_REASON: SaveData(PRecord.REASON, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_SPECIALITY_ID: SaveData(PRecord.SPECIALITY_ID, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_VSD_CODE: SaveData(PRecord.VSD_CODE, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_SpecDataPos: SaveData(PRecord.SpecDataPos, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_Logical: SaveData(TLogicalData24(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TBLANKA_MED_NAPR_3AItem.UpdateBLANKA_MED_NAPR_3A;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctBLANKA_MED_NAPR_3A;
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
            BLANKA_MED_NAPR_3A_ATTACHED_DOCS: UpdateData(PRecord.ATTACHED_DOCS, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_ISSUE_DATE: UpdateData(PRecord.ISSUE_DATE, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_NRN: UpdateData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_NUMBER: UpdateData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_REASON: UpdateData(PRecord.REASON, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_SPECIALITY_ID: UpdateData(PRecord.SPECIALITY_ID, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_VSD_CODE: UpdateData(PRecord.VSD_CODE, PropPosition, metaPosition, dataPosition);
            BLANKA_MED_NAPR_3A_SpecDataPos: UpdateData(PRecord.SpecDataPos, PropPosition, metaPosition, dataPosition);
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

{ TBLANKA_MED_NAPR_3AColl }

function TBLANKA_MED_NAPR_3AColl.AddItem(ver: word): TBLANKA_MED_NAPR_3AItem;
begin
  Result := TBLANKA_MED_NAPR_3AItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TBLANKA_MED_NAPR_3AColl.AddItemForSearch: Integer;
var
  ItemForSearch: TBLANKA_MED_NAPR_3AItem;
begin
  ItemForSearch := TBLANKA_MED_NAPR_3AItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TBLANKA_MED_NAPR_3AColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TBLANKA_MED_NAPR_3AItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TBLANKA_MED_NAPR_3AColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvBLANKA_MED_NAPR_3ARoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TBLANKA_MED_NAPR_3AColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TBLANKA_MED_NAPR_3AItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (BLANKA_MED_NAPR_3A_ATTACHED_DOCS in tempItem.PRecord.setProp) and (tempItem.PRecord.ATTACHED_DOCS <> Self.getAnsiStringMap(tempItem.DataPos, word(BLANKA_MED_NAPR_3A_ATTACHED_DOCS))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_3A_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.ID <> Self.getIntMap(tempItem.DataPos, word(BLANKA_MED_NAPR_3A_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_3A_ISSUE_DATE in tempItem.PRecord.setProp) and (tempItem.PRecord.ISSUE_DATE <> Self.getDateMap(tempItem.DataPos, word(BLANKA_MED_NAPR_3A_ISSUE_DATE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_3A_NRN in tempItem.PRecord.setProp) and (tempItem.PRecord.NRN <> Self.getAnsiStringMap(tempItem.DataPos, word(BLANKA_MED_NAPR_3A_NRN))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_3A_NUMBER in tempItem.PRecord.setProp) and (tempItem.PRecord.NUMBER <> Self.getIntMap(tempItem.DataPos, word(BLANKA_MED_NAPR_3A_NUMBER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_3A_REASON in tempItem.PRecord.setProp) and (tempItem.PRecord.REASON <> Self.getAnsiStringMap(tempItem.DataPos, word(BLANKA_MED_NAPR_3A_REASON))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_3A_SPECIALITY_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.SPECIALITY_ID <> Self.getIntMap(tempItem.DataPos, word(BLANKA_MED_NAPR_3A_SPECIALITY_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_3A_VSD_CODE in tempItem.PRecord.setProp) and (tempItem.PRecord.VSD_CODE <> Self.getAnsiStringMap(tempItem.DataPos, word(BLANKA_MED_NAPR_3A_VSD_CODE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_3A_SpecDataPos in tempItem.PRecord.setProp) and (tempItem.PRecord.SpecDataPos <> Self.getIntMap(tempItem.DataPos, word(BLANKA_MED_NAPR_3A_SpecDataPos))) then
  begin
    inc(cnt);
    exit;
  end;

  if (BLANKA_MED_NAPR_3A_Logical in tempItem.PRecord.setProp) and (TLogicalData24(tempItem.PRecord.Logical) <> Self.getLogical24Map(tempItem.DataPos, word(BLANKA_MED_NAPR_3A_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TBLANKA_MED_NAPR_3AColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TBLANKA_MED_NAPR_3AItem.Create(nil);
  ListBLANKA_MED_NAPR_3ASearch := TList<TBLANKA_MED_NAPR_3AItem>.Create;
  ListForFinder := TList<TBLANKA_MED_NAPR_3AItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TBLANKA_MED_NAPR_3AColl.destroy;
begin
  FreeAndNil(ListBLANKA_MED_NAPR_3ASearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TBLANKA_MED_NAPR_3AColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TBLANKA_MED_NAPR_3AItem.TPropertyIndex(propIndex) of
    BLANKA_MED_NAPR_3A_ATTACHED_DOCS: Result := 'ATTACHED_DOCS';
    BLANKA_MED_NAPR_3A_ID: Result := 'ID';
    BLANKA_MED_NAPR_3A_ISSUE_DATE: Result := 'ISSUE_DATE';
    BLANKA_MED_NAPR_3A_NRN: Result := 'NRN';
    BLANKA_MED_NAPR_3A_NUMBER: Result := 'NUMBER';
    BLANKA_MED_NAPR_3A_REASON: Result := 'REASON';
    BLANKA_MED_NAPR_3A_SPECIALITY_ID: Result := 'SPECIALITY_ID';
    BLANKA_MED_NAPR_3A_VSD_CODE: Result := 'VSD_CODE';
    BLANKA_MED_NAPR_3A_SpecDataPos: Result := 'SpecDataPos';
    BLANKA_MED_NAPR_3A_Logical: Result := 'Logical';
  end;
end;

function TBLANKA_MED_NAPR_3AColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'NZIS_STATUS_None';
    1: Result := 'NZIS_STATUS_Valid';
    2: Result := 'NZIS_STATUS_NoValid';
    3: Result := 'NZIS_STATUS_Sended';
    4: Result := 'NZIS_STATUS_Err';
    5: Result := 'NZIS_STATUS_Cancel';
    6: Result := 'NZIS_STATUS_Edited';
    7: Result := 'MED_NAPR_3A_Ostro';
    8: Result := 'MED_NAPR_3A_Hron';
    9: Result := 'MED_NAPR_3A_Izbor';
    10: Result := 'MED_NAPR_3A_Disp';
    11: Result := 'MED_NAPR_3A_Eksp';
    12: Result := 'MED_NAPR_3A_Prof';
    13: Result := 'MED_NAPR_3A_Iskane_Telk';
    14: Result := 'MED_NAPR_3A_Choice_Mother';
    15: Result := 'MED_NAPR_3A_Choice_Child';
    16: Result := 'MED_NAPR_3A_PreChoice_Mother';
    17: Result := 'MED_NAPR_3A_PreChoice_Child';
    18: Result := 'MED_NAPR_3A_Podg_Telk';
    19: Result := 'IS_BOLNICHNA';
  else
    Result := '???';
  end;
end;


procedure TBLANKA_MED_NAPR_3AColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TBLANKA_MED_NAPR_3AColl.FieldCount: Integer; 
begin
  inherited;
  Result := 10;
end;

function TBLANKA_MED_NAPR_3AColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvBLANKA_MED_NAPR_3ARoot then
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

function TBLANKA_MED_NAPR_3AColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TBLANKA_MED_NAPR_3AColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TBLANKA_MED_NAPR_3AColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TBLANKA_MED_NAPR_3AColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  BLANKA_MED_NAPR_3A: TBLANKA_MED_NAPR_3AItem;
  ACol: Integer;
  prop: TBLANKA_MED_NAPR_3AItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  BLANKA_MED_NAPR_3A := Items[ARow];
  prop := TBLANKA_MED_NAPR_3AItem.TPropertyIndex(ACol);
  if Assigned(BLANKA_MED_NAPR_3A.PRecord) and (prop in BLANKA_MED_NAPR_3A.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, BLANKA_MED_NAPR_3A, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, BLANKA_MED_NAPR_3A, AValue);
  end;
end;

procedure TBLANKA_MED_NAPR_3AColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TBLANKA_MED_NAPR_3AItem.TPropertyIndex;
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

procedure TBLANKA_MED_NAPR_3AColl.GetCellFromRecord(propIndex: word; BLANKA_MED_NAPR_3A: TBLANKA_MED_NAPR_3AItem; var AValue: String);
var
  str: string;
begin
  case TBLANKA_MED_NAPR_3AItem.TPropertyIndex(propIndex) of
    BLANKA_MED_NAPR_3A_ATTACHED_DOCS: str := (BLANKA_MED_NAPR_3A.PRecord.ATTACHED_DOCS);
    BLANKA_MED_NAPR_3A_ID: str := inttostr(BLANKA_MED_NAPR_3A.PRecord.ID);
    BLANKA_MED_NAPR_3A_ISSUE_DATE: str := AspDateToStr(BLANKA_MED_NAPR_3A.PRecord.ISSUE_DATE);
    BLANKA_MED_NAPR_3A_NRN: str := (BLANKA_MED_NAPR_3A.PRecord.NRN);
    BLANKA_MED_NAPR_3A_NUMBER: str := inttostr(BLANKA_MED_NAPR_3A.PRecord.NUMBER);
    BLANKA_MED_NAPR_3A_REASON: str := (BLANKA_MED_NAPR_3A.PRecord.REASON);
    BLANKA_MED_NAPR_3A_SPECIALITY_ID: str := inttostr(BLANKA_MED_NAPR_3A.PRecord.SPECIALITY_ID);
    BLANKA_MED_NAPR_3A_VSD_CODE: str := (BLANKA_MED_NAPR_3A.PRecord.VSD_CODE);
    BLANKA_MED_NAPR_3A_SpecDataPos: str := inttostr(BLANKA_MED_NAPR_3A.PRecord.SpecDataPos);
    BLANKA_MED_NAPR_3A_Logical: str := BLANKA_MED_NAPR_3A.Logical24ToStr(TLogicalData24(BLANKA_MED_NAPR_3A.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TBLANKA_MED_NAPR_3AColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TBLANKA_MED_NAPR_3AItem;
  ACol: Integer;
  prop: TBLANKA_MED_NAPR_3AItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TBLANKA_MED_NAPR_3AItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TBLANKA_MED_NAPR_3AColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TBLANKA_MED_NAPR_3AItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TBLANKA_MED_NAPR_3AItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TBLANKA_MED_NAPR_3AColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  BLANKA_MED_NAPR_3A: TBLANKA_MED_NAPR_3AItem;
  ACol: Integer;
  prop: TBLANKA_MED_NAPR_3AItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  BLANKA_MED_NAPR_3A := ListBLANKA_MED_NAPR_3ASearch[ARow];
  prop := TBLANKA_MED_NAPR_3AItem.TPropertyIndex(ACol);
  if Assigned(BLANKA_MED_NAPR_3A.PRecord) and (prop in BLANKA_MED_NAPR_3A.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, BLANKA_MED_NAPR_3A, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, BLANKA_MED_NAPR_3A, AValue);
  end;
end;

function TBLANKA_MED_NAPR_3AColl.GetCollType: TCollectionsType;
begin
  Result := ctBLANKA_MED_NAPR_3A;
end;

function TBLANKA_MED_NAPR_3AColl.GetCollDelType: TCollectionsType;
begin
  Result := ctBLANKA_MED_NAPR_3ADel;
end;

procedure TBLANKA_MED_NAPR_3AColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  BLANKA_MED_NAPR_3A: TBLANKA_MED_NAPR_3AItem;
  prop: TBLANKA_MED_NAPR_3AItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  BLANKA_MED_NAPR_3A := Items[ARow];
  prop := TBLANKA_MED_NAPR_3AItem.TPropertyIndex(ACol);
  if Assigned(BLANKA_MED_NAPR_3A.PRecord) and (prop in BLANKA_MED_NAPR_3A.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, BLANKA_MED_NAPR_3A, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, BLANKA_MED_NAPR_3A, AFieldText);
  end;
end;

procedure TBLANKA_MED_NAPR_3AColl.GetCellFromMap(propIndex: word; ARow: Integer; BLANKA_MED_NAPR_3A: TBLANKA_MED_NAPR_3AItem; var AValue: String);
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
  case TBLANKA_MED_NAPR_3AItem.TPropertyIndex(propIndex) of
    BLANKA_MED_NAPR_3A_ATTACHED_DOCS: str :=  BLANKA_MED_NAPR_3A.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    BLANKA_MED_NAPR_3A_ID: str :=  inttostr(BLANKA_MED_NAPR_3A.getIntMap(Self.Buf, Self.posData, propIndex));
    BLANKA_MED_NAPR_3A_ISSUE_DATE: str :=  AspDateToStr(BLANKA_MED_NAPR_3A.getDateMap(Self.Buf, Self.posData, propIndex));
    BLANKA_MED_NAPR_3A_NRN: str :=  BLANKA_MED_NAPR_3A.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    BLANKA_MED_NAPR_3A_NUMBER: str :=  inttostr(BLANKA_MED_NAPR_3A.getIntMap(Self.Buf, Self.posData, propIndex));
    BLANKA_MED_NAPR_3A_REASON: str :=  BLANKA_MED_NAPR_3A.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    BLANKA_MED_NAPR_3A_SPECIALITY_ID: str :=  inttostr(BLANKA_MED_NAPR_3A.getIntMap(Self.Buf, Self.posData, propIndex));
    BLANKA_MED_NAPR_3A_VSD_CODE: str :=  BLANKA_MED_NAPR_3A.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    BLANKA_MED_NAPR_3A_SpecDataPos: str :=  inttostr(BLANKA_MED_NAPR_3A.getIntMap(Self.Buf, Self.posData, propIndex));
    BLANKA_MED_NAPR_3A_Logical: str :=  BLANKA_MED_NAPR_3A.Logical24ToStr(BLANKA_MED_NAPR_3A.getLogical24Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TBLANKA_MED_NAPR_3AColl.GetItem(Index: Integer): TBLANKA_MED_NAPR_3AItem;
begin
  Result := TBLANKA_MED_NAPR_3AItem(inherited GetItem(Index));
end;


procedure TBLANKA_MED_NAPR_3AColl.IndexValue(propIndex: TBLANKA_MED_NAPR_3AItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TBLANKA_MED_NAPR_3AItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      BLANKA_MED_NAPR_3A_ATTACHED_DOCS:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      BLANKA_MED_NAPR_3A_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      BLANKA_MED_NAPR_3A_NRN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      BLANKA_MED_NAPR_3A_NUMBER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      BLANKA_MED_NAPR_3A_REASON:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      BLANKA_MED_NAPR_3A_SPECIALITY_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      BLANKA_MED_NAPR_3A_VSD_CODE:
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

procedure TBLANKA_MED_NAPR_3AColl.IndexValueListNodes(propIndex: TBLANKA_MED_NAPR_3AItem.TPropertyIndex);
begin

end;

function TBLANKA_MED_NAPR_3AColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TBLANKA_MED_NAPR_3AItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TBLANKA_MED_NAPR_3AColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TBLANKA_MED_NAPR_3AItem;
begin
  if index < 0 then
  begin
    Tempitem := TBLANKA_MED_NAPR_3AItem.Create(nil);
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
procedure TBLANKA_MED_NAPR_3AColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TBLANKA_MED_NAPR_3AItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TBLANKA_MED_NAPR_3AItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TBLANKA_MED_NAPR_3AItem.TPropertyIndex(Field) of
BLANKA_MED_NAPR_3A_ATTACHED_DOCS: ListForFinder[0].PRecord.ATTACHED_DOCS := AText;
    BLANKA_MED_NAPR_3A_NRN: ListForFinder[0].PRecord.NRN := AText;
    BLANKA_MED_NAPR_3A_REASON: ListForFinder[0].PRecord.REASON := AText;
    BLANKA_MED_NAPR_3A_VSD_CODE: ListForFinder[0].PRecord.VSD_CODE := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TBLANKA_MED_NAPR_3AColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TBLANKA_MED_NAPR_3AItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TBLANKA_MED_NAPR_3AItem.TPropertyIndex(Field) of
BLANKA_MED_NAPR_3A_ISSUE_DATE: ListForFinder[0].PRecord.ISSUE_DATE := Value;
  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TBLANKA_MED_NAPR_3AColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TBLANKA_MED_NAPR_3AItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TBLANKA_MED_NAPR_3AItem.TPropertyIndex(Field) of
BLANKA_MED_NAPR_3A_ID: ListForFinder[0].PRecord.ID := Value;
    BLANKA_MED_NAPR_3A_NUMBER: ListForFinder[0].PRecord.NUMBER := Value;
    BLANKA_MED_NAPR_3A_SPECIALITY_ID: ListForFinder[0].PRecord.SPECIALITY_ID := Value;
    BLANKA_MED_NAPR_3A_SpecDataPos: ListForFinder[0].PRecord.SpecDataPos := Value;
  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TBLANKA_MED_NAPR_3AColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TBLANKA_MED_NAPR_3AItem.TPropertyIndex(Field) of
    BLANKA_MED_NAPR_3A_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalBLANKA_MED_NAPR_3A(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalBLANKA_MED_NAPR_3A(logIndex))   
    end;
  end;
end;


procedure TBLANKA_MED_NAPR_3AColl.OnSetTextSearchLog(Log: TlogicalBLANKA_MED_NAPR_3ASet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TBLANKA_MED_NAPR_3AColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TBLANKA_MED_NAPR_3AColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TBLANKA_MED_NAPR_3AItem.TPropertyIndex(propIndex) of
    BLANKA_MED_NAPR_3A_ATTACHED_DOCS: Result := actAnsiString;
    BLANKA_MED_NAPR_3A_ID: Result := actinteger;
    BLANKA_MED_NAPR_3A_ISSUE_DATE: Result := actTDate;
    BLANKA_MED_NAPR_3A_NRN: Result := actAnsiString;
    BLANKA_MED_NAPR_3A_NUMBER: Result := actinteger;
    BLANKA_MED_NAPR_3A_REASON: Result := actAnsiString;
    BLANKA_MED_NAPR_3A_SPECIALITY_ID: Result := actinteger;
    BLANKA_MED_NAPR_3A_VSD_CODE: Result := actAnsiString;
    BLANKA_MED_NAPR_3A_SpecDataPos: Result := actcardinal;
    BLANKA_MED_NAPR_3A_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TBLANKA_MED_NAPR_3AColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TBLANKA_MED_NAPR_3AColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  BLANKA_MED_NAPR_3A: TBLANKA_MED_NAPR_3AItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  BLANKA_MED_NAPR_3A := Items[ARow];
  if not Assigned(BLANKA_MED_NAPR_3A.PRecord) then
  begin
    New(BLANKA_MED_NAPR_3A.PRecord);
    BLANKA_MED_NAPR_3A.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TBLANKA_MED_NAPR_3AItem.TPropertyIndex(ACol) of
      BLANKA_MED_NAPR_3A_ATTACHED_DOCS: isOld :=  BLANKA_MED_NAPR_3A.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    BLANKA_MED_NAPR_3A_ID: isOld :=  BLANKA_MED_NAPR_3A.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    BLANKA_MED_NAPR_3A_ISSUE_DATE: isOld :=  BLANKA_MED_NAPR_3A.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    BLANKA_MED_NAPR_3A_NRN: isOld :=  BLANKA_MED_NAPR_3A.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    BLANKA_MED_NAPR_3A_NUMBER: isOld :=  BLANKA_MED_NAPR_3A.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    BLANKA_MED_NAPR_3A_REASON: isOld :=  BLANKA_MED_NAPR_3A.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    BLANKA_MED_NAPR_3A_SPECIALITY_ID: isOld :=  BLANKA_MED_NAPR_3A.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    BLANKA_MED_NAPR_3A_VSD_CODE: isOld :=  BLANKA_MED_NAPR_3A.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    BLANKA_MED_NAPR_3A_SpecDataPos: isOld :=  BLANKA_MED_NAPR_3A.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(BLANKA_MED_NAPR_3A.PRecord.setProp, TBLANKA_MED_NAPR_3AItem.TPropertyIndex(ACol));
    if BLANKA_MED_NAPR_3A.PRecord.setProp = [] then
    begin
      Dispose(BLANKA_MED_NAPR_3A.PRecord);
      BLANKA_MED_NAPR_3A.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(BLANKA_MED_NAPR_3A.PRecord.setProp, TBLANKA_MED_NAPR_3AItem.TPropertyIndex(ACol));
  case TBLANKA_MED_NAPR_3AItem.TPropertyIndex(ACol) of
    BLANKA_MED_NAPR_3A_ATTACHED_DOCS: BLANKA_MED_NAPR_3A.PRecord.ATTACHED_DOCS := AValue;
    BLANKA_MED_NAPR_3A_ID: BLANKA_MED_NAPR_3A.PRecord.ID := StrToInt(AValue);
    BLANKA_MED_NAPR_3A_ISSUE_DATE: BLANKA_MED_NAPR_3A.PRecord.ISSUE_DATE := StrToDate(AValue);
    BLANKA_MED_NAPR_3A_NRN: BLANKA_MED_NAPR_3A.PRecord.NRN := AValue;
    BLANKA_MED_NAPR_3A_NUMBER: BLANKA_MED_NAPR_3A.PRecord.NUMBER := StrToInt(AValue);
    BLANKA_MED_NAPR_3A_REASON: BLANKA_MED_NAPR_3A.PRecord.REASON := AValue;
    BLANKA_MED_NAPR_3A_SPECIALITY_ID: BLANKA_MED_NAPR_3A.PRecord.SPECIALITY_ID := StrToInt(AValue);
    BLANKA_MED_NAPR_3A_VSD_CODE: BLANKA_MED_NAPR_3A.PRecord.VSD_CODE := AValue;
    BLANKA_MED_NAPR_3A_SpecDataPos: BLANKA_MED_NAPR_3A.PRecord.SpecDataPos := StrToInt(AValue);
    BLANKA_MED_NAPR_3A_Logical: BLANKA_MED_NAPR_3A.PRecord.Logical := tlogicalBLANKA_MED_NAPR_3ASet(BLANKA_MED_NAPR_3A.StrToLogical24(AValue));
  end;
end;

procedure TBLANKA_MED_NAPR_3AColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  BLANKA_MED_NAPR_3A: TBLANKA_MED_NAPR_3AItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  BLANKA_MED_NAPR_3A := Items[ARow];
  if not Assigned(BLANKA_MED_NAPR_3A.PRecord) then
  begin
    New(BLANKA_MED_NAPR_3A.PRecord);
    BLANKA_MED_NAPR_3A.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TBLANKA_MED_NAPR_3AItem.TPropertyIndex(ACol) of
      BLANKA_MED_NAPR_3A_ATTACHED_DOCS: isOld :=  BLANKA_MED_NAPR_3A.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    BLANKA_MED_NAPR_3A_ID: isOld :=  BLANKA_MED_NAPR_3A.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    BLANKA_MED_NAPR_3A_ISSUE_DATE: isOld :=  BLANKA_MED_NAPR_3A.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    BLANKA_MED_NAPR_3A_NRN: isOld :=  BLANKA_MED_NAPR_3A.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    BLANKA_MED_NAPR_3A_NUMBER: isOld :=  BLANKA_MED_NAPR_3A.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    BLANKA_MED_NAPR_3A_REASON: isOld :=  BLANKA_MED_NAPR_3A.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    BLANKA_MED_NAPR_3A_SPECIALITY_ID: isOld :=  BLANKA_MED_NAPR_3A.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    BLANKA_MED_NAPR_3A_VSD_CODE: isOld :=  BLANKA_MED_NAPR_3A.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    BLANKA_MED_NAPR_3A_SpecDataPos: isOld :=  BLANKA_MED_NAPR_3A.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(BLANKA_MED_NAPR_3A.PRecord.setProp, TBLANKA_MED_NAPR_3AItem.TPropertyIndex(ACol));
    if BLANKA_MED_NAPR_3A.PRecord.setProp = [] then
    begin
      Dispose(BLANKA_MED_NAPR_3A.PRecord);
      BLANKA_MED_NAPR_3A.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(BLANKA_MED_NAPR_3A.PRecord.setProp, TBLANKA_MED_NAPR_3AItem.TPropertyIndex(ACol));
  case TBLANKA_MED_NAPR_3AItem.TPropertyIndex(ACol) of
    BLANKA_MED_NAPR_3A_ATTACHED_DOCS: BLANKA_MED_NAPR_3A.PRecord.ATTACHED_DOCS := AFieldText;
    BLANKA_MED_NAPR_3A_ID: BLANKA_MED_NAPR_3A.PRecord.ID := StrToInt(AFieldText);
    BLANKA_MED_NAPR_3A_ISSUE_DATE: BLANKA_MED_NAPR_3A.PRecord.ISSUE_DATE := StrToDate(AFieldText);
    BLANKA_MED_NAPR_3A_NRN: BLANKA_MED_NAPR_3A.PRecord.NRN := AFieldText;
    BLANKA_MED_NAPR_3A_NUMBER: BLANKA_MED_NAPR_3A.PRecord.NUMBER := StrToInt(AFieldText);
    BLANKA_MED_NAPR_3A_REASON: BLANKA_MED_NAPR_3A.PRecord.REASON := AFieldText;
    BLANKA_MED_NAPR_3A_SPECIALITY_ID: BLANKA_MED_NAPR_3A.PRecord.SPECIALITY_ID := StrToInt(AFieldText);
    BLANKA_MED_NAPR_3A_VSD_CODE: BLANKA_MED_NAPR_3A.PRecord.VSD_CODE := AFieldText;
    BLANKA_MED_NAPR_3A_SpecDataPos: BLANKA_MED_NAPR_3A.PRecord.SpecDataPos := StrToInt(AFieldText);
    BLANKA_MED_NAPR_3A_Logical: BLANKA_MED_NAPR_3A.PRecord.Logical := tlogicalBLANKA_MED_NAPR_3ASet(BLANKA_MED_NAPR_3A.StrToLogical24(AFieldText));
  end;
end;

procedure TBLANKA_MED_NAPR_3AColl.SetItem(Index: Integer; const Value: TBLANKA_MED_NAPR_3AItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TBLANKA_MED_NAPR_3AColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListBLANKA_MED_NAPR_3ASearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TBLANKA_MED_NAPR_3AItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  BLANKA_MED_NAPR_3A_ATTACHED_DOCS:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListBLANKA_MED_NAPR_3ASearch.Add(self.Items[i]);
  end;
end;
      BLANKA_MED_NAPR_3A_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListBLANKA_MED_NAPR_3ASearch.Add(self.Items[i]);
        end;
      end;
      BLANKA_MED_NAPR_3A_NRN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListBLANKA_MED_NAPR_3ASearch.Add(self.Items[i]);
        end;
      end;
      BLANKA_MED_NAPR_3A_NUMBER: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListBLANKA_MED_NAPR_3ASearch.Add(self.Items[i]);
        end;
      end;
      BLANKA_MED_NAPR_3A_REASON:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListBLANKA_MED_NAPR_3ASearch.Add(self.Items[i]);
        end;
      end;
      BLANKA_MED_NAPR_3A_SPECIALITY_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListBLANKA_MED_NAPR_3ASearch.Add(self.Items[i]);
        end;
      end;
      BLANKA_MED_NAPR_3A_VSD_CODE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListBLANKA_MED_NAPR_3ASearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TBLANKA_MED_NAPR_3AColl.ShowGrid(Grid: TTeeGrid);
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

procedure TBLANKA_MED_NAPR_3AColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TBLANKA_MED_NAPR_3AItem>);
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

procedure TBLANKA_MED_NAPR_3AColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListBLANKA_MED_NAPR_3ASearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListBLANKA_MED_NAPR_3ASearch.Count]);

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

procedure TBLANKA_MED_NAPR_3AColl.SortByIndexAnsiString;
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

procedure TBLANKA_MED_NAPR_3AColl.SortByIndexInt;
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

procedure TBLANKA_MED_NAPR_3AColl.SortByIndexWord;
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

procedure TBLANKA_MED_NAPR_3AColl.SortByIndexValue(propIndex: TBLANKA_MED_NAPR_3AItem.TPropertyIndex);
begin
  case propIndex of
    BLANKA_MED_NAPR_3A_ATTACHED_DOCS: SortByIndexAnsiString;
      BLANKA_MED_NAPR_3A_ID: SortByIndexInt;
      BLANKA_MED_NAPR_3A_NRN: SortByIndexAnsiString;
      BLANKA_MED_NAPR_3A_NUMBER: SortByIndexInt;
      BLANKA_MED_NAPR_3A_REASON: SortByIndexAnsiString;
      BLANKA_MED_NAPR_3A_SPECIALITY_ID: SortByIndexInt;
      BLANKA_MED_NAPR_3A_VSD_CODE: SortByIndexAnsiString;
  end;
end;

end.