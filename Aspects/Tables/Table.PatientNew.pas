unit Table.PatientNew;

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

TLogicalPatientNew = (
    BLOOD_TYPE_0,
    BLOOD_TYPE_A1,
    BLOOD_TYPE_A2,
    BLOOD_TYPE_B,
    BLOOD_TYPE_A1B,
    BLOOD_TYPE_A2B,
    BLOOD_TYPE_A,
    BLOOD_TYPE_AB,
    SEX_TYPE_F,
    SEX_TYPE_M,
    NZIS_PID_TYPE_1,
    NZIS_PID_TYPE_2,
    NZIS_PID_TYPE_3,
    NZIS_PID_TYPE_4,
    NZIS_PID_TYPE_5,
    EHRH_PATIENT,
    GDPR_PRINTED,
    KYRMA3MES,
    KYRMA6MES,
    PID_TYPE_B,
    PID_TYPE_E,
    PID_TYPE_L,
    PID_TYPE_S,
    PID_TYPE_F,
    RH_POS,
    RH_NEG,
    IS_NEBL_USL,
    OSIGUREN,
    PAT_KIND_REG,
    PAT_KIND_TEMP_REG,
    PAT_KIND_NOREG,
    RELATION_SELF,
    RELATION_PARENT,
    RELATION_NAST,
    RELATION_POPECHITEL);
TlogicalPatientNewSet = set of TLogicalPatientNew;


TPatientNewItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       PatientNew_BABY_NUMBER
       , PatientNew_BIRTH_DATE
       , PatientNew_DATE_ZAPISVANE
       , PatientNew_DIE_DATE
       , PatientNew_DIE_FROM
       , PatientNew_DOSIENOMER
       , PatientNew_DZI_NUMBER
       , PatientNew_EGN
       , PatientNew_EHIC_NO
       , PatientNew_FNAME
       , PatientNew_ID
       , PatientNew_LAK_NUMBER
       , PatientNew_LNAME
       , PatientNew_NZIS_BEBE
       , PatientNew_NZIS_PID
       , PatientNew_RACE
       , PatientNew_SNAME
       , PatientNew_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecPatientNew = ^TRecPatientNew;
      TRecPatientNew = record
        BABY_NUMBER: integer;
        BIRTH_DATE: TDate;
        DATE_ZAPISVANE: TDate;
        DIE_DATE: TDate;
        DIE_FROM: AnsiString;
        DOSIENOMER: AnsiString;
        DZI_NUMBER: AnsiString;
        EGN: AnsiString;
        EHIC_NO: AnsiString;
        FNAME: AnsiString;
        ID: integer;
        LAK_NUMBER: integer;
        LNAME: AnsiString;
        NZIS_BEBE: AnsiString;
        NZIS_PID: AnsiString;
        RACE: double;
        SNAME: AnsiString;
        Logical: TlogicalPatientNewSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecPatientNew;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertPatientNew;
    procedure UpdatePatientNew;
    procedure SavePatientNew(var dataPosition: Cardinal)overload;
	procedure SavePatientNew(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TPatientNewColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TPatientNewItem;
    function GetItem(Index: Integer): TPatientNewItem;
    procedure SetItem(Index: Integer; const Value: TPatientNewItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TPatientNewItem>;
    ListPatientNewSearch: TList<TPatientNewItem>;
	PRecordSearch: ^TPatientNewItem.TRecPatientNew;
    ArrPropSearch: TArray<TPatientNewItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TPatientNewItem.TPropertyIndex>;
	VisibleColl: TPatientNewItem.TSetProp;
	ArrayPropOrder: TArray<TPatientNewItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TPatientNewItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; PatientNew: TPatientNewItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; PatientNew: TPatientNewItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TPatientNewItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TPatientNewItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TPatientNewItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TPatientNewItem.TPropertyIndex);
    property Items[Index: Integer]: TPatientNewItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalPatientNewSet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
  end;

implementation

{ TPatientNewItem }

constructor TPatientNewItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TPatientNewItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TPatientNewItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TPatientNewItem.GetCollType: TCollectionsType;
begin
  Result := ctPatientNew;
end;

function TPatientNewItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TPatientNewItem.InsertPatientNew;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctPatientNew;
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
            PatientNew_BABY_NUMBER: SaveData(PRecord.BABY_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_BIRTH_DATE: SaveData(PRecord.BIRTH_DATE, PropPosition, metaPosition, dataPosition);
            PatientNew_DATE_ZAPISVANE: SaveData(PRecord.DATE_ZAPISVANE, PropPosition, metaPosition, dataPosition);
            PatientNew_DIE_DATE: SaveData(PRecord.DIE_DATE, PropPosition, metaPosition, dataPosition);
            PatientNew_DIE_FROM: SaveData(PRecord.DIE_FROM, PropPosition, metaPosition, dataPosition);
            PatientNew_DOSIENOMER: SaveData(PRecord.DOSIENOMER, PropPosition, metaPosition, dataPosition);
            PatientNew_DZI_NUMBER: SaveData(PRecord.DZI_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            PatientNew_EHIC_NO: SaveData(PRecord.EHIC_NO, PropPosition, metaPosition, dataPosition);
            PatientNew_FNAME: SaveData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            PatientNew_LAK_NUMBER: SaveData(PRecord.LAK_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_LNAME: SaveData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_NZIS_BEBE: SaveData(PRecord.NZIS_BEBE, PropPosition, metaPosition, dataPosition);
            PatientNew_NZIS_PID: SaveData(PRecord.NZIS_PID, PropPosition, metaPosition, dataPosition);
            PatientNew_RACE: SaveData(PRecord.RACE, PropPosition, metaPosition, dataPosition);
            PatientNew_SNAME: SaveData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_Logical: SaveData(TLogicalData40(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TPatientNewItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TPatientNewItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TPatientNewItem;
begin
  Result := True;
  for i := 0 to Length(TPatientNewColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TPatientNewColl(coll).ArrPropSearchClc[i];
	ATempItem := TPatientNewColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        PatientNew_BABY_NUMBER: Result := IsFinded(ATempItem.PRecord.BABY_NUMBER, buf, FPosDataADB, word(PatientNew_BABY_NUMBER), cot);
            PatientNew_BIRTH_DATE: Result := IsFinded(ATempItem.PRecord.BIRTH_DATE, buf, FPosDataADB, word(PatientNew_BIRTH_DATE), cot);
            PatientNew_DATE_ZAPISVANE: Result := IsFinded(ATempItem.PRecord.DATE_ZAPISVANE, buf, FPosDataADB, word(PatientNew_DATE_ZAPISVANE), cot);
            PatientNew_DIE_DATE: Result := IsFinded(ATempItem.PRecord.DIE_DATE, buf, FPosDataADB, word(PatientNew_DIE_DATE), cot);
            PatientNew_DIE_FROM: Result := IsFinded(ATempItem.PRecord.DIE_FROM, buf, FPosDataADB, word(PatientNew_DIE_FROM), cot);
            PatientNew_DOSIENOMER: Result := IsFinded(ATempItem.PRecord.DOSIENOMER, buf, FPosDataADB, word(PatientNew_DOSIENOMER), cot);
            PatientNew_DZI_NUMBER: Result := IsFinded(ATempItem.PRecord.DZI_NUMBER, buf, FPosDataADB, word(PatientNew_DZI_NUMBER), cot);
            PatientNew_EGN: Result := IsFinded(ATempItem.PRecord.EGN, buf, FPosDataADB, word(PatientNew_EGN), cot);
            PatientNew_EHIC_NO: Result := IsFinded(ATempItem.PRecord.EHIC_NO, buf, FPosDataADB, word(PatientNew_EHIC_NO), cot);
            PatientNew_FNAME: Result := IsFinded(ATempItem.PRecord.FNAME, buf, FPosDataADB, word(PatientNew_FNAME), cot);
            PatientNew_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(PatientNew_ID), cot);
            PatientNew_LAK_NUMBER: Result := IsFinded(ATempItem.PRecord.LAK_NUMBER, buf, FPosDataADB, word(PatientNew_LAK_NUMBER), cot);
            PatientNew_LNAME: Result := IsFinded(ATempItem.PRecord.LNAME, buf, FPosDataADB, word(PatientNew_LNAME), cot);
            PatientNew_NZIS_BEBE: Result := IsFinded(ATempItem.PRecord.NZIS_BEBE, buf, FPosDataADB, word(PatientNew_NZIS_BEBE), cot);
            PatientNew_NZIS_PID: Result := IsFinded(ATempItem.PRecord.NZIS_PID, buf, FPosDataADB, word(PatientNew_NZIS_PID), cot);
            PatientNew_RACE: Result := IsFinded(ATempItem.PRecord.RACE, buf, FPosDataADB, word(PatientNew_RACE), cot);
            PatientNew_SNAME: Result := IsFinded(ATempItem.PRecord.SNAME, buf, FPosDataADB, word(PatientNew_SNAME), cot);
            PatientNew_Logical: Result := IsFinded(TLogicalData40(ATempItem.PRecord.Logical), buf, FPosDataADB, word(PatientNew_Logical), cot);
      end;
    end;
  end;
end;

procedure TPatientNewItem.SavePatientNew(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SavePatientNew(dataPosition);
end;

procedure TPatientNewItem.SavePatientNew(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPatientNew;
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
            PatientNew_BABY_NUMBER: SaveData(PRecord.BABY_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_BIRTH_DATE: SaveData(PRecord.BIRTH_DATE, PropPosition, metaPosition, dataPosition);
            PatientNew_DATE_ZAPISVANE: SaveData(PRecord.DATE_ZAPISVANE, PropPosition, metaPosition, dataPosition);
            PatientNew_DIE_DATE: SaveData(PRecord.DIE_DATE, PropPosition, metaPosition, dataPosition);
            PatientNew_DIE_FROM: SaveData(PRecord.DIE_FROM, PropPosition, metaPosition, dataPosition);
            PatientNew_DOSIENOMER: SaveData(PRecord.DOSIENOMER, PropPosition, metaPosition, dataPosition);
            PatientNew_DZI_NUMBER: SaveData(PRecord.DZI_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            PatientNew_EHIC_NO: SaveData(PRecord.EHIC_NO, PropPosition, metaPosition, dataPosition);
            PatientNew_FNAME: SaveData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            PatientNew_LAK_NUMBER: SaveData(PRecord.LAK_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_LNAME: SaveData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_NZIS_BEBE: SaveData(PRecord.NZIS_BEBE, PropPosition, metaPosition, dataPosition);
            PatientNew_NZIS_PID: SaveData(PRecord.NZIS_PID, PropPosition, metaPosition, dataPosition);
            PatientNew_RACE: SaveData(PRecord.RACE, PropPosition, metaPosition, dataPosition);
            PatientNew_SNAME: SaveData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_Logical: SaveData(TLogicalData40(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TPatientNewItem.UpdatePatientNew;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctPatientNew;
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
            PatientNew_BABY_NUMBER: UpdateData(PRecord.BABY_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_BIRTH_DATE: UpdateData(PRecord.BIRTH_DATE, PropPosition, metaPosition, dataPosition);
            PatientNew_DATE_ZAPISVANE: UpdateData(PRecord.DATE_ZAPISVANE, PropPosition, metaPosition, dataPosition);
            PatientNew_DIE_DATE: UpdateData(PRecord.DIE_DATE, PropPosition, metaPosition, dataPosition);
            PatientNew_DIE_FROM: UpdateData(PRecord.DIE_FROM, PropPosition, metaPosition, dataPosition);
            PatientNew_DOSIENOMER: UpdateData(PRecord.DOSIENOMER, PropPosition, metaPosition, dataPosition);
            PatientNew_DZI_NUMBER: UpdateData(PRecord.DZI_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_EGN: UpdateData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            PatientNew_EHIC_NO: UpdateData(PRecord.EHIC_NO, PropPosition, metaPosition, dataPosition);
            PatientNew_FNAME: UpdateData(PRecord.FNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            PatientNew_LAK_NUMBER: UpdateData(PRecord.LAK_NUMBER, PropPosition, metaPosition, dataPosition);
            PatientNew_LNAME: UpdateData(PRecord.LNAME, PropPosition, metaPosition, dataPosition);
            PatientNew_NZIS_BEBE: UpdateData(PRecord.NZIS_BEBE, PropPosition, metaPosition, dataPosition);
            PatientNew_NZIS_PID: UpdateData(PRecord.NZIS_PID, PropPosition, metaPosition, dataPosition);
            PatientNew_RACE: UpdateData(PRecord.RACE, PropPosition, metaPosition, dataPosition);
            PatientNew_SNAME: UpdateData(PRecord.SNAME, PropPosition, metaPosition, dataPosition);
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

{ TPatientNewColl }

function TPatientNewColl.AddItem(ver: word): TPatientNewItem;
begin
  Result := TPatientNewItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TPatientNewColl.AddItemForSearch: Integer;
var
  ItemForSearch: TPatientNewItem;
begin
  ItemForSearch := TPatientNewItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TPatientNewColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TPatientNewItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TPatientNewColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvPatientNewRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TPatientNewColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TPatientNewItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (PatientNew_BABY_NUMBER in tempItem.PRecord.setProp) and (tempItem.PRecord.BABY_NUMBER <> Self.getIntMap(tempItem.DataPos, word(PatientNew_BABY_NUMBER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_BIRTH_DATE in tempItem.PRecord.setProp) and (tempItem.PRecord.BIRTH_DATE <> Self.getDateMap(tempItem.DataPos, word(PatientNew_BIRTH_DATE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_DATE_ZAPISVANE in tempItem.PRecord.setProp) and (tempItem.PRecord.DATE_ZAPISVANE <> Self.getDateMap(tempItem.DataPos, word(PatientNew_DATE_ZAPISVANE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_DIE_DATE in tempItem.PRecord.setProp) and (tempItem.PRecord.DIE_DATE <> Self.getDateMap(tempItem.DataPos, word(PatientNew_DIE_DATE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_DIE_FROM in tempItem.PRecord.setProp) and (tempItem.PRecord.DIE_FROM <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNew_DIE_FROM))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_DOSIENOMER in tempItem.PRecord.setProp) and (tempItem.PRecord.DOSIENOMER <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNew_DOSIENOMER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_DZI_NUMBER in tempItem.PRecord.setProp) and (tempItem.PRecord.DZI_NUMBER <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNew_DZI_NUMBER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_EGN in tempItem.PRecord.setProp) and (tempItem.PRecord.EGN <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNew_EGN))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_EHIC_NO in tempItem.PRecord.setProp) and (tempItem.PRecord.EHIC_NO <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNew_EHIC_NO))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_FNAME in tempItem.PRecord.setProp) and (tempItem.PRecord.FNAME <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNew_FNAME))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.ID <> Self.getIntMap(tempItem.DataPos, word(PatientNew_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_LAK_NUMBER in tempItem.PRecord.setProp) and (tempItem.PRecord.LAK_NUMBER <> Self.getIntMap(tempItem.DataPos, word(PatientNew_LAK_NUMBER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_LNAME in tempItem.PRecord.setProp) and (tempItem.PRecord.LNAME <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNew_LNAME))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_NZIS_BEBE in tempItem.PRecord.setProp) and (tempItem.PRecord.NZIS_BEBE <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNew_NZIS_BEBE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_NZIS_PID in tempItem.PRecord.setProp) and (tempItem.PRecord.NZIS_PID <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNew_NZIS_PID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_RACE in tempItem.PRecord.setProp) and (Abs(tempItem.PRecord.RACE - Self.getDoubleMap(tempItem.DataPos, word(PatientNew_RACE))) > 0.000001) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_SNAME in tempItem.PRecord.setProp) and (tempItem.PRecord.SNAME <> Self.getAnsiStringMap(tempItem.DataPos, word(PatientNew_SNAME))) then
  begin
    inc(cnt);
    exit;
  end;

  if (PatientNew_Logical in tempItem.PRecord.setProp) and (TLogicalData40(tempItem.PRecord.Logical) <> Self.getLogical40Map(tempItem.DataPos, word(PatientNew_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TPatientNewColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TPatientNewItem.Create(nil);
  ListPatientNewSearch := TList<TPatientNewItem>.Create;
  ListForFinder := TList<TPatientNewItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TPatientNewColl.destroy;
begin
  FreeAndNil(ListPatientNewSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TPatientNewColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TPatientNewItem.TPropertyIndex(propIndex) of
    PatientNew_BABY_NUMBER: Result := 'BABY_NUMBER';
    PatientNew_BIRTH_DATE: Result := 'BIRTH_DATE';
    PatientNew_DATE_ZAPISVANE: Result := 'DATE_ZAPISVANE';
    PatientNew_DIE_DATE: Result := 'DIE_DATE';
    PatientNew_DIE_FROM: Result := 'DIE_FROM';
    PatientNew_DOSIENOMER: Result := 'DOSIENOMER';
    PatientNew_DZI_NUMBER: Result := 'DZI_NUMBER';
    PatientNew_EGN: Result := 'EGN';
    PatientNew_EHIC_NO: Result := 'EHIC_NO';
    PatientNew_FNAME: Result := 'FNAME';
    PatientNew_ID: Result := 'ID';
    PatientNew_LAK_NUMBER: Result := 'LAK_NUMBER';
    PatientNew_LNAME: Result := 'LNAME';
    PatientNew_NZIS_BEBE: Result := 'NZIS_BEBE';
    PatientNew_NZIS_PID: Result := 'NZIS_PID';
    PatientNew_RACE: Result := 'RACE';
    PatientNew_SNAME: Result := 'SNAME';
    PatientNew_Logical: Result := 'Logical';
  end;
end;

function TPatientNewColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'BLOOD_TYPE_0';
    1: Result := 'BLOOD_TYPE_A1';
    2: Result := 'BLOOD_TYPE_A2';
    3: Result := 'BLOOD_TYPE_B';
    4: Result := 'BLOOD_TYPE_A1B';
    5: Result := 'BLOOD_TYPE_A2B';
    6: Result := 'BLOOD_TYPE_A';
    7: Result := 'BLOOD_TYPE_AB';
    8: Result := 'SEX_TYPE_F';
    9: Result := 'SEX_TYPE_M';
    10: Result := 'NZIS_PID_TYPE_1';
    11: Result := 'NZIS_PID_TYPE_2';
    12: Result := 'NZIS_PID_TYPE_3';
    13: Result := 'NZIS_PID_TYPE_4';
    14: Result := 'NZIS_PID_TYPE_5';
    15: Result := 'EHRH_PATIENT';
    16: Result := 'GDPR_PRINTED';
    17: Result := 'KYRMA3MES';
    18: Result := 'KYRMA6MES';
    19: Result := 'PID_TYPE_B';
    20: Result := 'PID_TYPE_E';
    21: Result := 'PID_TYPE_L';
    22: Result := 'PID_TYPE_S';
    23: Result := 'PID_TYPE_F';
    24: Result := 'RH_POS';
    25: Result := 'RH_NEG';
    26: Result := 'IS_NEBL_USL';
    27: Result := 'OSIGUREN';
    28: Result := 'PAT_KIND_REG';
    29: Result := 'PAT_KIND_TEMP_REG';
    30: Result := 'PAT_KIND_NOREG';
    31: Result := 'RELATION_SELF';
    32: Result := 'RELATION_PARENT';
    33: Result := 'RELATION_NAST';
    34: Result := 'RELATION_POPECHITEL';
  else
    Result := '???';
  end;
end;


procedure TPatientNewColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TPatientNewColl.FieldCount: Integer; 
begin
  inherited;
  Result := 18;
end;

function TPatientNewColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvPatientNewRoot then
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

function TPatientNewColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TPatientNewColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TPatientNewColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TPatientNewColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  PatientNew: TPatientNewItem;
  ACol: Integer;
  prop: TPatientNewItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  PatientNew := Items[ARow];
  prop := TPatientNewItem.TPropertyIndex(ACol);
  if Assigned(PatientNew.PRecord) and (prop in PatientNew.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PatientNew, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PatientNew, AValue);
  end;
end;

procedure TPatientNewColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TPatientNewItem.TPropertyIndex;
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

procedure TPatientNewColl.GetCellFromRecord(propIndex: word; PatientNew: TPatientNewItem; var AValue: String);
var
  str: string;
begin
  case TPatientNewItem.TPropertyIndex(propIndex) of
    PatientNew_BABY_NUMBER: str := inttostr(PatientNew.PRecord.BABY_NUMBER);
    PatientNew_BIRTH_DATE: str := AspDateToStr(PatientNew.PRecord.BIRTH_DATE);
    PatientNew_DATE_ZAPISVANE: str := AspDateToStr(PatientNew.PRecord.DATE_ZAPISVANE);
    PatientNew_DIE_DATE: str := AspDateToStr(PatientNew.PRecord.DIE_DATE);
    PatientNew_DIE_FROM: str := (PatientNew.PRecord.DIE_FROM);
    PatientNew_DOSIENOMER: str := (PatientNew.PRecord.DOSIENOMER);
    PatientNew_DZI_NUMBER: str := (PatientNew.PRecord.DZI_NUMBER);
    PatientNew_EGN: str := (PatientNew.PRecord.EGN);
    PatientNew_EHIC_NO: str := (PatientNew.PRecord.EHIC_NO);
    PatientNew_FNAME: str := (PatientNew.PRecord.FNAME);
    PatientNew_ID: str := inttostr(PatientNew.PRecord.ID);
    PatientNew_LAK_NUMBER: str := inttostr(PatientNew.PRecord.LAK_NUMBER);
    PatientNew_LNAME: str := (PatientNew.PRecord.LNAME);
    PatientNew_NZIS_BEBE: str := (PatientNew.PRecord.NZIS_BEBE);
    PatientNew_NZIS_PID: str := (PatientNew.PRecord.NZIS_PID);
    PatientNew_RACE: str := FloatToStr(PatientNew.PRecord.RACE);
    PatientNew_SNAME: str := (PatientNew.PRecord.SNAME);
    PatientNew_Logical: str := PatientNew.Logical40ToStr(TLogicalData40(PatientNew.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TPatientNewColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TPatientNewItem;
  ACol: Integer;
  prop: TPatientNewItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TPatientNewItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TPatientNewColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TPatientNewItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TPatientNewItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TPatientNewColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  PatientNew: TPatientNewItem;
  ACol: Integer;
  prop: TPatientNewItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  PatientNew := ListPatientNewSearch[ARow];
  prop := TPatientNewItem.TPropertyIndex(ACol);
  if Assigned(PatientNew.PRecord) and (prop in PatientNew.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PatientNew, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PatientNew, AValue);
  end;
end;

function TPatientNewColl.GetCollType: TCollectionsType;
begin
  Result := ctPatientNew;
end;

procedure TPatientNewColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  PatientNew: TPatientNewItem;
  prop: TPatientNewItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  PatientNew := Items[ARow];
  prop := TPatientNewItem.TPropertyIndex(ACol);
  if Assigned(PatientNew.PRecord) and (prop in PatientNew.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, PatientNew, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, PatientNew, AFieldText);
  end;
end;

procedure TPatientNewColl.GetCellFromMap(propIndex: word; ARow: Integer; PatientNew: TPatientNewItem; var AValue: String);
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
  case TPatientNewItem.TPropertyIndex(propIndex) of
    PatientNew_BABY_NUMBER: str :=  inttostr(PatientNew.getIntMap(Self.Buf, Self.posData, propIndex));
    PatientNew_BIRTH_DATE: str :=  AspDateToStr(PatientNew.getDateMap(Self.Buf, Self.posData, propIndex));
    PatientNew_DATE_ZAPISVANE: str :=  AspDateToStr(PatientNew.getDateMap(Self.Buf, Self.posData, propIndex));
    PatientNew_DIE_DATE: str :=  AspDateToStr(PatientNew.getDateMap(Self.Buf, Self.posData, propIndex));
    PatientNew_DIE_FROM: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_DOSIENOMER: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_DZI_NUMBER: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_EGN: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_EHIC_NO: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_FNAME: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_ID: str :=  inttostr(PatientNew.getIntMap(Self.Buf, Self.posData, propIndex));
    PatientNew_LAK_NUMBER: str :=  inttostr(PatientNew.getIntMap(Self.Buf, Self.posData, propIndex));
    PatientNew_LNAME: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_NZIS_BEBE: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_NZIS_PID: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_SNAME: str :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    PatientNew_Logical: str :=  PatientNew.Logical40ToStr(PatientNew.getLogical40Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TPatientNewColl.GetItem(Index: Integer): TPatientNewItem;
begin
  Result := TPatientNewItem(inherited GetItem(Index));
end;


procedure TPatientNewColl.IndexValue(propIndex: TPatientNewItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TPatientNewItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      PatientNew_BABY_NUMBER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      PatientNew_DIE_FROM:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_DOSIENOMER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_DZI_NUMBER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_EGN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_EHIC_NO:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_FNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      PatientNew_LAK_NUMBER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      PatientNew_LNAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_NZIS_BEBE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_NZIS_PID:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      PatientNew_SNAME:
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

procedure TPatientNewColl.IndexValueListNodes(propIndex: TPatientNewItem.TPropertyIndex);
begin

end;

function TPatientNewColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TPatientNewItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TPatientNewColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TPatientNewItem;
begin
  if index < 0 then
  begin
    Tempitem := TPatientNewItem.Create(nil);
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
procedure TPatientNewColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TPatientNewItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TPatientNewItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TPatientNewItem.TPropertyIndex(Field) of
PatientNew_DIE_FROM: ListForFinder[0].PRecord.DIE_FROM := AText;
    PatientNew_DOSIENOMER: ListForFinder[0].PRecord.DOSIENOMER := AText;
    PatientNew_DZI_NUMBER: ListForFinder[0].PRecord.DZI_NUMBER := AText;
    PatientNew_EGN: ListForFinder[0].PRecord.EGN := AText;
    PatientNew_EHIC_NO: ListForFinder[0].PRecord.EHIC_NO := AText;
    PatientNew_FNAME: ListForFinder[0].PRecord.FNAME := AText;
    PatientNew_LNAME: ListForFinder[0].PRecord.LNAME := AText;
    PatientNew_NZIS_BEBE: ListForFinder[0].PRecord.NZIS_BEBE := AText;
    PatientNew_NZIS_PID: ListForFinder[0].PRecord.NZIS_PID := AText;
    PatientNew_SNAME: ListForFinder[0].PRecord.SNAME := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TPatientNewColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TPatientNewItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TPatientNewItem.TPropertyIndex(Field) of
PatientNew_BIRTH_DATE: ListForFinder[0].PRecord.BIRTH_DATE := Value;
    PatientNew_DATE_ZAPISVANE: ListForFinder[0].PRecord.DATE_ZAPISVANE := Value;
    PatientNew_DIE_DATE: ListForFinder[0].PRecord.DIE_DATE := Value;
  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TPatientNewColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TPatientNewItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TPatientNewItem.TPropertyIndex(Field) of
PatientNew_BABY_NUMBER: ListForFinder[0].PRecord.BABY_NUMBER := Value;
    PatientNew_ID: ListForFinder[0].PRecord.ID := Value;
    PatientNew_LAK_NUMBER: ListForFinder[0].PRecord.LAK_NUMBER := Value;
    PatientNew_RACE: ListForFinder[0].PRecord.RACE := Value;
  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TPatientNewColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TPatientNewItem.TPropertyIndex(Field) of
    PatientNew_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalPatientNew(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalPatientNew(logIndex))   
    end;
  end;
end;


procedure TPatientNewColl.OnSetTextSearchLog(Log: TlogicalPatientNewSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TPatientNewColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TPatientNewColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TPatientNewItem.TPropertyIndex(propIndex) of
    PatientNew_BABY_NUMBER: Result := actinteger;
    PatientNew_BIRTH_DATE: Result := actTDate;
    PatientNew_DATE_ZAPISVANE: Result := actTDate;
    PatientNew_DIE_DATE: Result := actTDate;
    PatientNew_DIE_FROM: Result := actAnsiString;
    PatientNew_DOSIENOMER: Result := actAnsiString;
    PatientNew_DZI_NUMBER: Result := actAnsiString;
    PatientNew_EGN: Result := actAnsiString;
    PatientNew_EHIC_NO: Result := actAnsiString;
    PatientNew_FNAME: Result := actAnsiString;
    PatientNew_ID: Result := actinteger;
    PatientNew_LAK_NUMBER: Result := actinteger;
    PatientNew_LNAME: Result := actAnsiString;
    PatientNew_NZIS_BEBE: Result := actAnsiString;
    PatientNew_NZIS_PID: Result := actAnsiString;
    PatientNew_RACE: Result := actdouble;
    PatientNew_SNAME: Result := actAnsiString;
    PatientNew_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TPatientNewColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TPatientNewColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  PatientNew: TPatientNewItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  PatientNew := Items[ARow];
  if not Assigned(PatientNew.PRecord) then
  begin
    New(PatientNew.PRecord);
    PatientNew.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TPatientNewItem.TPropertyIndex(ACol) of
      PatientNew_BABY_NUMBER: isOld :=  PatientNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PatientNew_BIRTH_DATE: isOld :=  PatientNew.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    PatientNew_DATE_ZAPISVANE: isOld :=  PatientNew.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    PatientNew_DIE_DATE: isOld :=  PatientNew.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    PatientNew_DIE_FROM: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_DOSIENOMER: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_DZI_NUMBER: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_EGN: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_EHIC_NO: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_FNAME: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_ID: isOld :=  PatientNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PatientNew_LAK_NUMBER: isOld :=  PatientNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    PatientNew_LNAME: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_NZIS_BEBE: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_NZIS_PID: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    PatientNew_SNAME: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(PatientNew.PRecord.setProp, TPatientNewItem.TPropertyIndex(ACol));
    if PatientNew.PRecord.setProp = [] then
    begin
      Dispose(PatientNew.PRecord);
      PatientNew.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(PatientNew.PRecord.setProp, TPatientNewItem.TPropertyIndex(ACol));
  case TPatientNewItem.TPropertyIndex(ACol) of
    PatientNew_BABY_NUMBER: PatientNew.PRecord.BABY_NUMBER := StrToInt(AValue);
    PatientNew_BIRTH_DATE: PatientNew.PRecord.BIRTH_DATE := StrToDate(AValue);
    PatientNew_DATE_ZAPISVANE: PatientNew.PRecord.DATE_ZAPISVANE := StrToDate(AValue);
    PatientNew_DIE_DATE: PatientNew.PRecord.DIE_DATE := StrToDate(AValue);
    PatientNew_DIE_FROM: PatientNew.PRecord.DIE_FROM := AValue;
    PatientNew_DOSIENOMER: PatientNew.PRecord.DOSIENOMER := AValue;
    PatientNew_DZI_NUMBER: PatientNew.PRecord.DZI_NUMBER := AValue;
    PatientNew_EGN: PatientNew.PRecord.EGN := AValue;
    PatientNew_EHIC_NO: PatientNew.PRecord.EHIC_NO := AValue;
    PatientNew_FNAME: PatientNew.PRecord.FNAME := AValue;
    PatientNew_ID: PatientNew.PRecord.ID := StrToInt(AValue);
    PatientNew_LAK_NUMBER: PatientNew.PRecord.LAK_NUMBER := StrToInt(AValue);
    PatientNew_LNAME: PatientNew.PRecord.LNAME := AValue;
    PatientNew_NZIS_BEBE: PatientNew.PRecord.NZIS_BEBE := AValue;
    PatientNew_NZIS_PID: PatientNew.PRecord.NZIS_PID := AValue;
    PatientNew_RACE: PatientNew.PRecord.RACE := StrToFloat(AValue);
    PatientNew_SNAME: PatientNew.PRecord.SNAME := AValue;
    PatientNew_Logical: PatientNew.PRecord.Logical := tlogicalPatientNewSet(PatientNew.StrToLogical40(AValue));
  end;
end;

procedure TPatientNewColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  PatientNew: TPatientNewItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  PatientNew := Items[ARow];
  if not Assigned(PatientNew.PRecord) then
  begin
    New(PatientNew.PRecord);
    PatientNew.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TPatientNewItem.TPropertyIndex(ACol) of
      PatientNew_BABY_NUMBER: isOld :=  PatientNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PatientNew_BIRTH_DATE: isOld :=  PatientNew.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    PatientNew_DATE_ZAPISVANE: isOld :=  PatientNew.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    PatientNew_DIE_DATE: isOld :=  PatientNew.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    PatientNew_DIE_FROM: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_DOSIENOMER: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_DZI_NUMBER: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_EGN: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_EHIC_NO: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_FNAME: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_ID: isOld :=  PatientNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PatientNew_LAK_NUMBER: isOld :=  PatientNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    PatientNew_LNAME: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_NZIS_BEBE: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_NZIS_PID: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    PatientNew_SNAME: isOld :=  PatientNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(PatientNew.PRecord.setProp, TPatientNewItem.TPropertyIndex(ACol));
    if PatientNew.PRecord.setProp = [] then
    begin
      Dispose(PatientNew.PRecord);
      PatientNew.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(PatientNew.PRecord.setProp, TPatientNewItem.TPropertyIndex(ACol));
  case TPatientNewItem.TPropertyIndex(ACol) of
    PatientNew_BABY_NUMBER: PatientNew.PRecord.BABY_NUMBER := StrToInt(AFieldText);
    PatientNew_BIRTH_DATE: PatientNew.PRecord.BIRTH_DATE := StrToDate(AFieldText);
    PatientNew_DATE_ZAPISVANE: PatientNew.PRecord.DATE_ZAPISVANE := StrToDate(AFieldText);
    PatientNew_DIE_DATE: PatientNew.PRecord.DIE_DATE := StrToDate(AFieldText);
    PatientNew_DIE_FROM: PatientNew.PRecord.DIE_FROM := AFieldText;
    PatientNew_DOSIENOMER: PatientNew.PRecord.DOSIENOMER := AFieldText;
    PatientNew_DZI_NUMBER: PatientNew.PRecord.DZI_NUMBER := AFieldText;
    PatientNew_EGN: PatientNew.PRecord.EGN := AFieldText;
    PatientNew_EHIC_NO: PatientNew.PRecord.EHIC_NO := AFieldText;
    PatientNew_FNAME: PatientNew.PRecord.FNAME := AFieldText;
    PatientNew_ID: PatientNew.PRecord.ID := StrToInt(AFieldText);
    PatientNew_LAK_NUMBER: PatientNew.PRecord.LAK_NUMBER := StrToInt(AFieldText);
    PatientNew_LNAME: PatientNew.PRecord.LNAME := AFieldText;
    PatientNew_NZIS_BEBE: PatientNew.PRecord.NZIS_BEBE := AFieldText;
    PatientNew_NZIS_PID: PatientNew.PRecord.NZIS_PID := AFieldText;
    PatientNew_RACE: PatientNew.PRecord.RACE := StrToFloat(AFieldText);
    PatientNew_SNAME: PatientNew.PRecord.SNAME := AFieldText;
    PatientNew_Logical: PatientNew.PRecord.Logical := tlogicalPatientNewSet(PatientNew.StrToLogical40(AFieldText));
  end;
end;

procedure TPatientNewColl.SetItem(Index: Integer; const Value: TPatientNewItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TPatientNewColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListPatientNewSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TPatientNewItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  PatientNew_BABY_NUMBER: 
begin
  if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
  begin
    ListPatientNewSearch.Add(self.Items[i]);
  end;
end;
      PatientNew_DIE_FROM:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_DOSIENOMER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_DZI_NUMBER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_EGN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_EHIC_NO:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_FNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_LAK_NUMBER: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_LNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_NZIS_BEBE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_NZIS_PID:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
      PatientNew_SNAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListPatientNewSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TPatientNewColl.ShowGrid(Grid: TTeeGrid);
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

procedure TPatientNewColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TPatientNewItem>);
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

procedure TPatientNewColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListPatientNewSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListPatientNewSearch.Count]);

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

procedure TPatientNewColl.SortByIndexAnsiString;
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

procedure TPatientNewColl.SortByIndexInt;
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

procedure TPatientNewColl.SortByIndexWord;
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

procedure TPatientNewColl.SortByIndexValue(propIndex: TPatientNewItem.TPropertyIndex);
begin
  case propIndex of
    PatientNew_BABY_NUMBER: SortByIndexInt;
      PatientNew_DIE_FROM: SortByIndexAnsiString;
      PatientNew_DOSIENOMER: SortByIndexAnsiString;
      PatientNew_DZI_NUMBER: SortByIndexAnsiString;
      PatientNew_EGN: SortByIndexAnsiString;
      PatientNew_EHIC_NO: SortByIndexAnsiString;
      PatientNew_FNAME: SortByIndexAnsiString;
      PatientNew_ID: SortByIndexInt;
      PatientNew_LAK_NUMBER: SortByIndexInt;
      PatientNew_LNAME: SortByIndexAnsiString;
      PatientNew_NZIS_BEBE: SortByIndexAnsiString;
      PatientNew_NZIS_PID: SortByIndexAnsiString;
      PatientNew_SNAME: SortByIndexAnsiString;
  end;
end;

end.