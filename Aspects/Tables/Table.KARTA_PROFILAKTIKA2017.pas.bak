unit Table.KARTA_PROFILAKTIKA2017;

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

TLogicalKARTA_PROFILAKTIKA2017 = (
    ADENOMA61,
    ANTIHIPERTENZIVNI67,
    BENIGNMAMMARY19,
    CELIACDISEASE25,
    COLORECTALCARCINOMA21,
    CROHN63,
    DIABETESRELATIVES31,
    DIABETESRELATIVESSECOND70,
    DYNAMISMPSA28,
    DYSLIPIDAEMIA11,
    FRUITSVEGETABLES66,
    HPVVAKSINA69,
    ILLNESSIBS_MSB29,
    IMMUNOSUPPRESSED15,
    ISFULL,
    COLITIS64,
    IS_PRINTED,
    MENARCHE07,
    NEOCERVIX32,
    NEOREKTOSIGMOIDE35,
    POLYP62,
    PREDIABETIC10,
    PREGNANCY08,
    PREGNANCYCHILDBIRTH68,
    PROLONGEDHRT04,
    PROSTATECARCINOMA38,
    RELATIVESBREAST33,
    SEDENTARYLIFE02,
    TYPE1DIABETES65,
    TYPE2DIABETES09,
    WOMENCANCERS18);
TlogicalKARTA_PROFILAKTIKA2017Set = set of TLogicalKARTA_PROFILAKTIKA2017;


TKARTA_PROFILAKTIKA2017Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       KARTA_PROFILAKTIKA2017_BDDIASTOLNO43
       , KARTA_PROFILAKTIKA2017_BDGIRTWAIST44
       , KARTA_PROFILAKTIKA2017_BDHEIGHT39
       , KARTA_PROFILAKTIKA2017_BDITM41
       , KARTA_PROFILAKTIKA2017_BDSYSTOLNO42
       , KARTA_PROFILAKTIKA2017_BDWEIGHT40
       , KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71
       , KARTA_PROFILAKTIKA2017_FINDRISK
       , KARTA_PROFILAKTIKA2017_ISSUE_DATE
       , KARTA_PROFILAKTIKA2017_MDIGLUCOSE48
       , KARTA_PROFILAKTIKA2017_MDIHDL50
       , KARTA_PROFILAKTIKA2017_MDILDL45
       , KARTA_PROFILAKTIKA2017_MDINONHDL73
       , KARTA_PROFILAKTIKA2017_MDIPSA49
       , KARTA_PROFILAKTIKA2017_MDITG47
       , KARTA_PROFILAKTIKA2017_MDITH46
       , KARTA_PROFILAKTIKA2017_NOMER
       , KARTA_PROFILAKTIKA2017_PREGLED_ID
       , KARTA_PROFILAKTIKA2017_SCORE
       , KARTA_PROFILAKTIKA2017_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecKARTA_PROFILAKTIKA2017 = ^TRecKARTA_PROFILAKTIKA2017;
      TRecKARTA_PROFILAKTIKA2017 = record
        BDDIASTOLNO43: integer;
        BDGIRTWAIST44: integer;
        BDHEIGHT39: integer;
        BDITM41: double;
        BDSYSTOLNO42: integer;
        BDWEIGHT40: integer;
        CIGARETESCOUNT71: integer;
        FINDRISK: integer;
        ISSUE_DATE: TDate;
        MDIGLUCOSE48: double;
        MDIHDL50: double;
        MDILDL45: double;
        MDINONHDL73: double;
        MDIPSA49: double;
        MDITG47: double;
        MDITH46: double;
        NOMER: integer;
        PREGLED_ID: integer;
        SCORE: integer;
        Logical: TlogicalKARTA_PROFILAKTIKA2017Set;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecKARTA_PROFILAKTIKA2017;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertKARTA_PROFILAKTIKA2017;
    procedure UpdateKARTA_PROFILAKTIKA2017;
    procedure SaveKARTA_PROFILAKTIKA2017(var dataPosition: Cardinal)overload;
	procedure SaveKARTA_PROFILAKTIKA2017(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  end;


  TKARTA_PROFILAKTIKA2017Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TKARTA_PROFILAKTIKA2017Item;
    function GetItem(Index: Integer): TKARTA_PROFILAKTIKA2017Item;
    procedure SetItem(Index: Integer; const Value: TKARTA_PROFILAKTIKA2017Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TKARTA_PROFILAKTIKA2017Item>;
    ListKARTA_PROFILAKTIKA2017Search: TList<TKARTA_PROFILAKTIKA2017Item>;
	PRecordSearch: ^TKARTA_PROFILAKTIKA2017Item.TRecKARTA_PROFILAKTIKA2017;
    ArrPropSearch: TArray<TKARTA_PROFILAKTIKA2017Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TKARTA_PROFILAKTIKA2017Item.TPropertyIndex>;
	VisibleColl: TKARTA_PROFILAKTIKA2017Item.TSetProp;
	ArrayPropOrder: TArray<TKARTA_PROFILAKTIKA2017Item.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TKARTA_PROFILAKTIKA2017Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; KARTA_PROFILAKTIKA2017: TKARTA_PROFILAKTIKA2017Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; KARTA_PROFILAKTIKA2017: TKARTA_PROFILAKTIKA2017Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TKARTA_PROFILAKTIKA2017Item.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TKARTA_PROFILAKTIKA2017Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TKARTA_PROFILAKTIKA2017Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TKARTA_PROFILAKTIKA2017Item.TPropertyIndex);
    property Items[Index: Integer]: TKARTA_PROFILAKTIKA2017Item read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalKARTA_PROFILAKTIKA2017Set);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
  end;

implementation

{ TKARTA_PROFILAKTIKA2017Item }

constructor TKARTA_PROFILAKTIKA2017Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TKARTA_PROFILAKTIKA2017Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TKARTA_PROFILAKTIKA2017Item.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TKARTA_PROFILAKTIKA2017Item.GetCollType: TCollectionsType;
begin
  Result := ctKARTA_PROFILAKTIKA2017;
end;

function TKARTA_PROFILAKTIKA2017Item.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TKARTA_PROFILAKTIKA2017Item.InsertKARTA_PROFILAKTIKA2017;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctKARTA_PROFILAKTIKA2017;
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
            KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: SaveData(PRecord.BDDIASTOLNO43, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: SaveData(PRecord.BDGIRTWAIST44, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_BDHEIGHT39: SaveData(PRecord.BDHEIGHT39, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_BDITM41: SaveData(PRecord.BDITM41, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: SaveData(PRecord.BDSYSTOLNO42, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_BDWEIGHT40: SaveData(PRecord.BDWEIGHT40, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: SaveData(PRecord.CIGARETESCOUNT71, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_FINDRISK: SaveData(PRecord.FINDRISK, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_ISSUE_DATE: SaveData(PRecord.ISSUE_DATE, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDIGLUCOSE48: SaveData(PRecord.MDIGLUCOSE48, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDIHDL50: SaveData(PRecord.MDIHDL50, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDILDL45: SaveData(PRecord.MDILDL45, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDINONHDL73: SaveData(PRecord.MDINONHDL73, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDIPSA49: SaveData(PRecord.MDIPSA49, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDITG47: SaveData(PRecord.MDITG47, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDITH46: SaveData(PRecord.MDITH46, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_NOMER: SaveData(PRecord.NOMER, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_PREGLED_ID: SaveData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_SCORE: SaveData(PRecord.SCORE, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_Logical: SaveData(TLogicalData32(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TKARTA_PROFILAKTIKA2017Item.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TKARTA_PROFILAKTIKA2017Item.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TKARTA_PROFILAKTIKA2017Item;
begin
  Result := True;
  for i := 0 to Length(TKARTA_PROFILAKTIKA2017Coll(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TKARTA_PROFILAKTIKA2017Coll(coll).ArrPropSearchClc[i];
	ATempItem := TKARTA_PROFILAKTIKA2017Coll(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: Result := IsFinded(ATempItem.PRecord.BDDIASTOLNO43, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_BDDIASTOLNO43), cot);
            KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: Result := IsFinded(ATempItem.PRecord.BDGIRTWAIST44, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_BDGIRTWAIST44), cot);
            KARTA_PROFILAKTIKA2017_BDHEIGHT39: Result := IsFinded(ATempItem.PRecord.BDHEIGHT39, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_BDHEIGHT39), cot);
            KARTA_PROFILAKTIKA2017_BDITM41: Result := IsFinded(ATempItem.PRecord.BDITM41, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_BDITM41), cot);
            KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: Result := IsFinded(ATempItem.PRecord.BDSYSTOLNO42, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_BDSYSTOLNO42), cot);
            KARTA_PROFILAKTIKA2017_BDWEIGHT40: Result := IsFinded(ATempItem.PRecord.BDWEIGHT40, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_BDWEIGHT40), cot);
            KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: Result := IsFinded(ATempItem.PRecord.CIGARETESCOUNT71, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71), cot);
            KARTA_PROFILAKTIKA2017_FINDRISK: Result := IsFinded(ATempItem.PRecord.FINDRISK, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_FINDRISK), cot);
            KARTA_PROFILAKTIKA2017_ISSUE_DATE: Result := IsFinded(ATempItem.PRecord.ISSUE_DATE, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_ISSUE_DATE), cot);
            KARTA_PROFILAKTIKA2017_MDIGLUCOSE48: Result := IsFinded(ATempItem.PRecord.MDIGLUCOSE48, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_MDIGLUCOSE48), cot);
            KARTA_PROFILAKTIKA2017_MDIHDL50: Result := IsFinded(ATempItem.PRecord.MDIHDL50, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_MDIHDL50), cot);
            KARTA_PROFILAKTIKA2017_MDILDL45: Result := IsFinded(ATempItem.PRecord.MDILDL45, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_MDILDL45), cot);
            KARTA_PROFILAKTIKA2017_MDINONHDL73: Result := IsFinded(ATempItem.PRecord.MDINONHDL73, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_MDINONHDL73), cot);
            KARTA_PROFILAKTIKA2017_MDIPSA49: Result := IsFinded(ATempItem.PRecord.MDIPSA49, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_MDIPSA49), cot);
            KARTA_PROFILAKTIKA2017_MDITG47: Result := IsFinded(ATempItem.PRecord.MDITG47, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_MDITG47), cot);
            KARTA_PROFILAKTIKA2017_MDITH46: Result := IsFinded(ATempItem.PRecord.MDITH46, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_MDITH46), cot);
            KARTA_PROFILAKTIKA2017_NOMER: Result := IsFinded(ATempItem.PRecord.NOMER, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_NOMER), cot);
            KARTA_PROFILAKTIKA2017_PREGLED_ID: Result := IsFinded(ATempItem.PRecord.PREGLED_ID, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_PREGLED_ID), cot);
            KARTA_PROFILAKTIKA2017_SCORE: Result := IsFinded(ATempItem.PRecord.SCORE, buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_SCORE), cot);
            KARTA_PROFILAKTIKA2017_Logical: Result := IsFinded(TLogicalData32(ATempItem.PRecord.Logical), buf, FPosDataADB, word(KARTA_PROFILAKTIKA2017_Logical), cot);
      end;
    end;
  end;
end;

procedure TKARTA_PROFILAKTIKA2017Item.SaveKARTA_PROFILAKTIKA2017(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveKARTA_PROFILAKTIKA2017(dataPosition);
end;

procedure TKARTA_PROFILAKTIKA2017Item.SaveKARTA_PROFILAKTIKA2017(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctKARTA_PROFILAKTIKA2017;
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
            KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: SaveData(PRecord.BDDIASTOLNO43, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: SaveData(PRecord.BDGIRTWAIST44, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_BDHEIGHT39: SaveData(PRecord.BDHEIGHT39, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_BDITM41: SaveData(PRecord.BDITM41, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: SaveData(PRecord.BDSYSTOLNO42, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_BDWEIGHT40: SaveData(PRecord.BDWEIGHT40, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: SaveData(PRecord.CIGARETESCOUNT71, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_FINDRISK: SaveData(PRecord.FINDRISK, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_ISSUE_DATE: SaveData(PRecord.ISSUE_DATE, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDIGLUCOSE48: SaveData(PRecord.MDIGLUCOSE48, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDIHDL50: SaveData(PRecord.MDIHDL50, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDILDL45: SaveData(PRecord.MDILDL45, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDINONHDL73: SaveData(PRecord.MDINONHDL73, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDIPSA49: SaveData(PRecord.MDIPSA49, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDITG47: SaveData(PRecord.MDITG47, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDITH46: SaveData(PRecord.MDITH46, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_NOMER: SaveData(PRecord.NOMER, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_PREGLED_ID: SaveData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_SCORE: SaveData(PRecord.SCORE, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_Logical: SaveData(TLogicalData32(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TKARTA_PROFILAKTIKA2017Item.UpdateKARTA_PROFILAKTIKA2017;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctKARTA_PROFILAKTIKA2017;
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
            KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: UpdateData(PRecord.BDDIASTOLNO43, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: UpdateData(PRecord.BDGIRTWAIST44, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_BDHEIGHT39: UpdateData(PRecord.BDHEIGHT39, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_BDITM41: UpdateData(PRecord.BDITM41, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: UpdateData(PRecord.BDSYSTOLNO42, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_BDWEIGHT40: UpdateData(PRecord.BDWEIGHT40, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: UpdateData(PRecord.CIGARETESCOUNT71, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_FINDRISK: UpdateData(PRecord.FINDRISK, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_ISSUE_DATE: UpdateData(PRecord.ISSUE_DATE, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDIGLUCOSE48: UpdateData(PRecord.MDIGLUCOSE48, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDIHDL50: UpdateData(PRecord.MDIHDL50, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDILDL45: UpdateData(PRecord.MDILDL45, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDINONHDL73: UpdateData(PRecord.MDINONHDL73, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDIPSA49: UpdateData(PRecord.MDIPSA49, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDITG47: UpdateData(PRecord.MDITG47, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_MDITH46: UpdateData(PRecord.MDITH46, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_NOMER: UpdateData(PRecord.NOMER, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_PREGLED_ID: UpdateData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            KARTA_PROFILAKTIKA2017_SCORE: UpdateData(PRecord.SCORE, PropPosition, metaPosition, dataPosition);
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

{ TKARTA_PROFILAKTIKA2017Coll }

function TKARTA_PROFILAKTIKA2017Coll.AddItem(ver: word): TKARTA_PROFILAKTIKA2017Item;
begin
  Result := TKARTA_PROFILAKTIKA2017Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TKARTA_PROFILAKTIKA2017Coll.AddItemForSearch: Integer;
var
  ItemForSearch: TKARTA_PROFILAKTIKA2017Item;
begin
  ItemForSearch := TKARTA_PROFILAKTIKA2017Item.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TKARTA_PROFILAKTIKA2017Coll.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TKARTA_PROFILAKTIKA2017Coll.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvKARTA_PROFILAKTIKA2017Root, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TKARTA_PROFILAKTIKA2017Coll.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TKARTA_PROFILAKTIKA2017Item;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (KARTA_PROFILAKTIKA2017_BDDIASTOLNO43 in tempItem.PRecord.setProp) and (tempItem.PRecord.BDDIASTOLNO43 <> Self.getIntMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_BDDIASTOLNO43))) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_BDGIRTWAIST44 in tempItem.PRecord.setProp) and (tempItem.PRecord.BDGIRTWAIST44 <> Self.getIntMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_BDGIRTWAIST44))) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_BDHEIGHT39 in tempItem.PRecord.setProp) and (tempItem.PRecord.BDHEIGHT39 <> Self.getIntMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_BDHEIGHT39))) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_BDITM41 in tempItem.PRecord.setProp) and (Abs(tempItem.PRecord.BDITM41 - Self.getDoubleMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_BDITM41))) > 0.000001) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_BDSYSTOLNO42 in tempItem.PRecord.setProp) and (tempItem.PRecord.BDSYSTOLNO42 <> Self.getIntMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_BDSYSTOLNO42))) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_BDWEIGHT40 in tempItem.PRecord.setProp) and (tempItem.PRecord.BDWEIGHT40 <> Self.getIntMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_BDWEIGHT40))) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71 in tempItem.PRecord.setProp) and (tempItem.PRecord.CIGARETESCOUNT71 <> Self.getIntMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71))) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_FINDRISK in tempItem.PRecord.setProp) and (tempItem.PRecord.FINDRISK <> Self.getIntMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_FINDRISK))) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_ISSUE_DATE in tempItem.PRecord.setProp) and (tempItem.PRecord.ISSUE_DATE <> Self.getDateMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_ISSUE_DATE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_MDIGLUCOSE48 in tempItem.PRecord.setProp) and (Abs(tempItem.PRecord.MDIGLUCOSE48 - Self.getDoubleMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_MDIGLUCOSE48))) > 0.000001) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_MDIHDL50 in tempItem.PRecord.setProp) and (Abs(tempItem.PRecord.MDIHDL50 - Self.getDoubleMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_MDIHDL50))) > 0.000001) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_MDILDL45 in tempItem.PRecord.setProp) and (Abs(tempItem.PRecord.MDILDL45 - Self.getDoubleMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_MDILDL45))) > 0.000001) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_MDINONHDL73 in tempItem.PRecord.setProp) and (Abs(tempItem.PRecord.MDINONHDL73 - Self.getDoubleMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_MDINONHDL73))) > 0.000001) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_MDIPSA49 in tempItem.PRecord.setProp) and (Abs(tempItem.PRecord.MDIPSA49 - Self.getDoubleMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_MDIPSA49))) > 0.000001) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_MDITG47 in tempItem.PRecord.setProp) and (Abs(tempItem.PRecord.MDITG47 - Self.getDoubleMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_MDITG47))) > 0.000001) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_MDITH46 in tempItem.PRecord.setProp) and (Abs(tempItem.PRecord.MDITH46 - Self.getDoubleMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_MDITH46))) > 0.000001) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_NOMER in tempItem.PRecord.setProp) and (tempItem.PRecord.NOMER <> Self.getIntMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_NOMER))) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_PREGLED_ID in tempItem.PRecord.setProp) and (tempItem.PRecord.PREGLED_ID <> Self.getIntMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_PREGLED_ID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_SCORE in tempItem.PRecord.setProp) and (tempItem.PRecord.SCORE <> Self.getIntMap(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_SCORE))) then
  begin
    inc(cnt);
    exit;
  end;

  if (KARTA_PROFILAKTIKA2017_Logical in tempItem.PRecord.setProp) and (TLogicalData32(tempItem.PRecord.Logical) <> Self.getLogical32Map(tempItem.DataPos, word(KARTA_PROFILAKTIKA2017_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TKARTA_PROFILAKTIKA2017Coll.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TKARTA_PROFILAKTIKA2017Item.Create(nil);
  ListKARTA_PROFILAKTIKA2017Search := TList<TKARTA_PROFILAKTIKA2017Item>.Create;
  ListForFinder := TList<TKARTA_PROFILAKTIKA2017Item>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TKARTA_PROFILAKTIKA2017Coll.destroy;
begin
  FreeAndNil(ListKARTA_PROFILAKTIKA2017Search);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TKARTA_PROFILAKTIKA2017Coll.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(propIndex) of
    KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: Result := 'BDDIASTOLNO43';
    KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: Result := 'BDGIRTWAIST44';
    KARTA_PROFILAKTIKA2017_BDHEIGHT39: Result := 'BDHEIGHT39';
    KARTA_PROFILAKTIKA2017_BDITM41: Result := 'BDITM41';
    KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: Result := 'BDSYSTOLNO42';
    KARTA_PROFILAKTIKA2017_BDWEIGHT40: Result := 'BDWEIGHT40';
    KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: Result := 'CIGARETESCOUNT71';
    KARTA_PROFILAKTIKA2017_FINDRISK: Result := 'FINDRISK';
    KARTA_PROFILAKTIKA2017_ISSUE_DATE: Result := 'ISSUE_DATE';
    KARTA_PROFILAKTIKA2017_MDIGLUCOSE48: Result := 'MDIGLUCOSE48';
    KARTA_PROFILAKTIKA2017_MDIHDL50: Result := 'MDIHDL50';
    KARTA_PROFILAKTIKA2017_MDILDL45: Result := 'MDILDL45';
    KARTA_PROFILAKTIKA2017_MDINONHDL73: Result := 'MDINONHDL73';
    KARTA_PROFILAKTIKA2017_MDIPSA49: Result := 'MDIPSA49';
    KARTA_PROFILAKTIKA2017_MDITG47: Result := 'MDITG47';
    KARTA_PROFILAKTIKA2017_MDITH46: Result := 'MDITH46';
    KARTA_PROFILAKTIKA2017_NOMER: Result := 'NOMER';
    KARTA_PROFILAKTIKA2017_PREGLED_ID: Result := 'PREGLED_ID';
    KARTA_PROFILAKTIKA2017_SCORE: Result := 'SCORE';
    KARTA_PROFILAKTIKA2017_Logical: Result := 'Logical';
  end;
end;

function TKARTA_PROFILAKTIKA2017Coll.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'ADENOMA61';
    1: Result := 'ANTIHIPERTENZIVNI67';
    2: Result := 'BENIGNMAMMARY19';
    3: Result := 'CELIACDISEASE25';
    4: Result := 'COLORECTALCARCINOMA21';
    5: Result := 'CROHN63';
    6: Result := 'DIABETESRELATIVES31';
    7: Result := 'DIABETESRELATIVESSECOND70';
    8: Result := 'DYNAMISMPSA28';
    9: Result := 'DYSLIPIDAEMIA11';
    10: Result := 'FRUITSVEGETABLES66';
    11: Result := 'HPVVAKSINA69';
    12: Result := 'ILLNESSIBS_MSB29';
    13: Result := 'IMMUNOSUPPRESSED15';
    14: Result := 'ISFULL';
    15: Result := 'COLITIS64';
    16: Result := 'IS_PRINTED';
    17: Result := 'MENARCHE07';
    18: Result := 'NEOCERVIX32';
    19: Result := 'NEOREKTOSIGMOIDE35';
    20: Result := 'POLYP62';
    21: Result := 'PREDIABETIC10';
    22: Result := 'PREGNANCY08';
    23: Result := 'PREGNANCYCHILDBIRTH68';
    24: Result := 'PROLONGEDHRT04';
    25: Result := 'PROSTATECARCINOMA38';
    26: Result := 'RELATIVESBREAST33';
    27: Result := 'SEDENTARYLIFE02';
    28: Result := 'TYPE1DIABETES65';
    29: Result := 'TYPE2DIABETES09';
    30: Result := 'WOMENCANCERS18';
  else
    Result := '???';
  end;
end;


procedure TKARTA_PROFILAKTIKA2017Coll.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TKARTA_PROFILAKTIKA2017Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 20;
end;

function TKARTA_PROFILAKTIKA2017Coll.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvKARTA_PROFILAKTIKA2017Root then
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

function TKARTA_PROFILAKTIKA2017Coll.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TKARTA_PROFILAKTIKA2017Coll.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TKARTA_PROFILAKTIKA2017Coll.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TKARTA_PROFILAKTIKA2017Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  KARTA_PROFILAKTIKA2017: TKARTA_PROFILAKTIKA2017Item;
  ACol: Integer;
  prop: TKARTA_PROFILAKTIKA2017Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  KARTA_PROFILAKTIKA2017 := Items[ARow];
  prop := TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(ACol);
  if Assigned(KARTA_PROFILAKTIKA2017.PRecord) and (prop in KARTA_PROFILAKTIKA2017.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, KARTA_PROFILAKTIKA2017, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, KARTA_PROFILAKTIKA2017, AValue);
  end;
end;

procedure TKARTA_PROFILAKTIKA2017Coll.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TKARTA_PROFILAKTIKA2017Item.TPropertyIndex;
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

procedure TKARTA_PROFILAKTIKA2017Coll.GetCellFromRecord(propIndex: word; KARTA_PROFILAKTIKA2017: TKARTA_PROFILAKTIKA2017Item; var AValue: String);
var
  str: string;
begin
  case TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(propIndex) of
    KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: str := inttostr(KARTA_PROFILAKTIKA2017.PRecord.BDDIASTOLNO43);
    KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: str := inttostr(KARTA_PROFILAKTIKA2017.PRecord.BDGIRTWAIST44);
    KARTA_PROFILAKTIKA2017_BDHEIGHT39: str := inttostr(KARTA_PROFILAKTIKA2017.PRecord.BDHEIGHT39);
    KARTA_PROFILAKTIKA2017_BDITM41: str := FloatToStr(KARTA_PROFILAKTIKA2017.PRecord.BDITM41);
    KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: str := inttostr(KARTA_PROFILAKTIKA2017.PRecord.BDSYSTOLNO42);
    KARTA_PROFILAKTIKA2017_BDWEIGHT40: str := inttostr(KARTA_PROFILAKTIKA2017.PRecord.BDWEIGHT40);
    KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: str := inttostr(KARTA_PROFILAKTIKA2017.PRecord.CIGARETESCOUNT71);
    KARTA_PROFILAKTIKA2017_FINDRISK: str := inttostr(KARTA_PROFILAKTIKA2017.PRecord.FINDRISK);
    KARTA_PROFILAKTIKA2017_ISSUE_DATE: str := AspDateToStr(KARTA_PROFILAKTIKA2017.PRecord.ISSUE_DATE);
    KARTA_PROFILAKTIKA2017_MDIGLUCOSE48: str := FloatToStr(KARTA_PROFILAKTIKA2017.PRecord.MDIGLUCOSE48);
    KARTA_PROFILAKTIKA2017_MDIHDL50: str := FloatToStr(KARTA_PROFILAKTIKA2017.PRecord.MDIHDL50);
    KARTA_PROFILAKTIKA2017_MDILDL45: str := FloatToStr(KARTA_PROFILAKTIKA2017.PRecord.MDILDL45);
    KARTA_PROFILAKTIKA2017_MDINONHDL73: str := FloatToStr(KARTA_PROFILAKTIKA2017.PRecord.MDINONHDL73);
    KARTA_PROFILAKTIKA2017_MDIPSA49: str := FloatToStr(KARTA_PROFILAKTIKA2017.PRecord.MDIPSA49);
    KARTA_PROFILAKTIKA2017_MDITG47: str := FloatToStr(KARTA_PROFILAKTIKA2017.PRecord.MDITG47);
    KARTA_PROFILAKTIKA2017_MDITH46: str := FloatToStr(KARTA_PROFILAKTIKA2017.PRecord.MDITH46);
    KARTA_PROFILAKTIKA2017_NOMER: str := inttostr(KARTA_PROFILAKTIKA2017.PRecord.NOMER);
    KARTA_PROFILAKTIKA2017_PREGLED_ID: str := inttostr(KARTA_PROFILAKTIKA2017.PRecord.PREGLED_ID);
    KARTA_PROFILAKTIKA2017_SCORE: str := inttostr(KARTA_PROFILAKTIKA2017.PRecord.SCORE);
    KARTA_PROFILAKTIKA2017_Logical: str := KARTA_PROFILAKTIKA2017.Logical32ToStr(TLogicalData32(KARTA_PROFILAKTIKA2017.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TKARTA_PROFILAKTIKA2017Coll.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TKARTA_PROFILAKTIKA2017Item;
  ACol: Integer;
  prop: TKARTA_PROFILAKTIKA2017Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TKARTA_PROFILAKTIKA2017Coll.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TKARTA_PROFILAKTIKA2017Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TKARTA_PROFILAKTIKA2017Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  KARTA_PROFILAKTIKA2017: TKARTA_PROFILAKTIKA2017Item;
  ACol: Integer;
  prop: TKARTA_PROFILAKTIKA2017Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  KARTA_PROFILAKTIKA2017 := ListKARTA_PROFILAKTIKA2017Search[ARow];
  prop := TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(ACol);
  if Assigned(KARTA_PROFILAKTIKA2017.PRecord) and (prop in KARTA_PROFILAKTIKA2017.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, KARTA_PROFILAKTIKA2017, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, KARTA_PROFILAKTIKA2017, AValue);
  end;
end;

function TKARTA_PROFILAKTIKA2017Coll.GetCollType: TCollectionsType;
begin
  Result := ctKARTA_PROFILAKTIKA2017;
end;

function TKARTA_PROFILAKTIKA2017Coll.GetCollDelType: TCollectionsType;
begin
  Result := ctKARTA_PROFILAKTIKA2017Del;
end;

procedure TKARTA_PROFILAKTIKA2017Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  KARTA_PROFILAKTIKA2017: TKARTA_PROFILAKTIKA2017Item;
  prop: TKARTA_PROFILAKTIKA2017Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  KARTA_PROFILAKTIKA2017 := Items[ARow];
  prop := TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(ACol);
  if Assigned(KARTA_PROFILAKTIKA2017.PRecord) and (prop in KARTA_PROFILAKTIKA2017.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, KARTA_PROFILAKTIKA2017, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, KARTA_PROFILAKTIKA2017, AFieldText);
  end;
end;

procedure TKARTA_PROFILAKTIKA2017Coll.GetCellFromMap(propIndex: word; ARow: Integer; KARTA_PROFILAKTIKA2017: TKARTA_PROFILAKTIKA2017Item; var AValue: String);
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
  case TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(propIndex) of
    KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: str :=  inttostr(KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: str :=  inttostr(KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_BDHEIGHT39: str :=  inttostr(KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: str :=  inttostr(KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_BDWEIGHT40: str :=  inttostr(KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: str :=  inttostr(KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_FINDRISK: str :=  inttostr(KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_ISSUE_DATE: str :=  AspDateToStr(KARTA_PROFILAKTIKA2017.getDateMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_NOMER: str :=  inttostr(KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_PREGLED_ID: str :=  inttostr(KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_SCORE: str :=  inttostr(KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_Logical: str :=  KARTA_PROFILAKTIKA2017.Logical32ToStr(KARTA_PROFILAKTIKA2017.getLogical32Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TKARTA_PROFILAKTIKA2017Coll.GetItem(Index: Integer): TKARTA_PROFILAKTIKA2017Item;
begin
  Result := TKARTA_PROFILAKTIKA2017Item(inherited GetItem(Index));
end;


procedure TKARTA_PROFILAKTIKA2017Coll.IndexValue(propIndex: TKARTA_PROFILAKTIKA2017Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TKARTA_PROFILAKTIKA2017Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      KARTA_PROFILAKTIKA2017_BDHEIGHT39: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      KARTA_PROFILAKTIKA2017_BDWEIGHT40: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      KARTA_PROFILAKTIKA2017_FINDRISK: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      KARTA_PROFILAKTIKA2017_NOMER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      KARTA_PROFILAKTIKA2017_PREGLED_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      KARTA_PROFILAKTIKA2017_SCORE: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TKARTA_PROFILAKTIKA2017Coll.IndexValueListNodes(propIndex: TKARTA_PROFILAKTIKA2017Item.TPropertyIndex);
begin

end;

function TKARTA_PROFILAKTIKA2017Coll.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TKARTA_PROFILAKTIKA2017Coll.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TKARTA_PROFILAKTIKA2017Item;
begin
  if index < 0 then
  begin
    Tempitem := TKARTA_PROFILAKTIKA2017Item.Create(nil);
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
procedure TKARTA_PROFILAKTIKA2017Coll.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  //case TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(Field) of
//
//  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TKARTA_PROFILAKTIKA2017Coll.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(Field) of
KARTA_PROFILAKTIKA2017_ISSUE_DATE: ListForFinder[0].PRecord.ISSUE_DATE := Value;
  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TKARTA_PROFILAKTIKA2017Coll.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(Field) of
KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: ListForFinder[0].PRecord.BDDIASTOLNO43 := Value;
    KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: ListForFinder[0].PRecord.BDGIRTWAIST44 := Value;
    KARTA_PROFILAKTIKA2017_BDHEIGHT39: ListForFinder[0].PRecord.BDHEIGHT39 := Value;
    KARTA_PROFILAKTIKA2017_BDITM41: ListForFinder[0].PRecord.BDITM41 := Value;
    KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: ListForFinder[0].PRecord.BDSYSTOLNO42 := Value;
    KARTA_PROFILAKTIKA2017_BDWEIGHT40: ListForFinder[0].PRecord.BDWEIGHT40 := Value;
    KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: ListForFinder[0].PRecord.CIGARETESCOUNT71 := Value;
    KARTA_PROFILAKTIKA2017_FINDRISK: ListForFinder[0].PRecord.FINDRISK := Value;
    KARTA_PROFILAKTIKA2017_MDIGLUCOSE48: ListForFinder[0].PRecord.MDIGLUCOSE48 := Value;
    KARTA_PROFILAKTIKA2017_MDIHDL50: ListForFinder[0].PRecord.MDIHDL50 := Value;
    KARTA_PROFILAKTIKA2017_MDILDL45: ListForFinder[0].PRecord.MDILDL45 := Value;
    KARTA_PROFILAKTIKA2017_MDINONHDL73: ListForFinder[0].PRecord.MDINONHDL73 := Value;
    KARTA_PROFILAKTIKA2017_MDIPSA49: ListForFinder[0].PRecord.MDIPSA49 := Value;
    KARTA_PROFILAKTIKA2017_MDITG47: ListForFinder[0].PRecord.MDITG47 := Value;
    KARTA_PROFILAKTIKA2017_MDITH46: ListForFinder[0].PRecord.MDITH46 := Value;
    KARTA_PROFILAKTIKA2017_NOMER: ListForFinder[0].PRecord.NOMER := Value;
    KARTA_PROFILAKTIKA2017_PREGLED_ID: ListForFinder[0].PRecord.PREGLED_ID := Value;
    KARTA_PROFILAKTIKA2017_SCORE: ListForFinder[0].PRecord.SCORE := Value;
  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TKARTA_PROFILAKTIKA2017Coll.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(Field) of
    KARTA_PROFILAKTIKA2017_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalKARTA_PROFILAKTIKA2017(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalKARTA_PROFILAKTIKA2017(logIndex))   
    end;
  end;
end;


procedure TKARTA_PROFILAKTIKA2017Coll.OnSetTextSearchLog(Log: TlogicalKARTA_PROFILAKTIKA2017Set);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TKARTA_PROFILAKTIKA2017Coll.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TKARTA_PROFILAKTIKA2017Coll.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(propIndex) of
    KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: Result := actinteger;
    KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: Result := actinteger;
    KARTA_PROFILAKTIKA2017_BDHEIGHT39: Result := actinteger;
    KARTA_PROFILAKTIKA2017_BDITM41: Result := actdouble;
    KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: Result := actinteger;
    KARTA_PROFILAKTIKA2017_BDWEIGHT40: Result := actinteger;
    KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: Result := actinteger;
    KARTA_PROFILAKTIKA2017_FINDRISK: Result := actinteger;
    KARTA_PROFILAKTIKA2017_ISSUE_DATE: Result := actTDate;
    KARTA_PROFILAKTIKA2017_MDIGLUCOSE48: Result := actdouble;
    KARTA_PROFILAKTIKA2017_MDIHDL50: Result := actdouble;
    KARTA_PROFILAKTIKA2017_MDILDL45: Result := actdouble;
    KARTA_PROFILAKTIKA2017_MDINONHDL73: Result := actdouble;
    KARTA_PROFILAKTIKA2017_MDIPSA49: Result := actdouble;
    KARTA_PROFILAKTIKA2017_MDITG47: Result := actdouble;
    KARTA_PROFILAKTIKA2017_MDITH46: Result := actdouble;
    KARTA_PROFILAKTIKA2017_NOMER: Result := actinteger;
    KARTA_PROFILAKTIKA2017_PREGLED_ID: Result := actinteger;
    KARTA_PROFILAKTIKA2017_SCORE: Result := actinteger;
    KARTA_PROFILAKTIKA2017_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TKARTA_PROFILAKTIKA2017Coll.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TKARTA_PROFILAKTIKA2017Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  KARTA_PROFILAKTIKA2017: TKARTA_PROFILAKTIKA2017Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  KARTA_PROFILAKTIKA2017 := Items[ARow];
  if not Assigned(KARTA_PROFILAKTIKA2017.PRecord) then
  begin
    New(KARTA_PROFILAKTIKA2017.PRecord);
    KARTA_PROFILAKTIKA2017.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(ACol) of
      KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_BDHEIGHT39: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_BDWEIGHT40: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_FINDRISK: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_ISSUE_DATE: isOld :=  KARTA_PROFILAKTIKA2017.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    KARTA_PROFILAKTIKA2017_NOMER: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_PREGLED_ID: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_SCORE: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(KARTA_PROFILAKTIKA2017.PRecord.setProp, TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(ACol));
    if KARTA_PROFILAKTIKA2017.PRecord.setProp = [] then
    begin
      Dispose(KARTA_PROFILAKTIKA2017.PRecord);
      KARTA_PROFILAKTIKA2017.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(KARTA_PROFILAKTIKA2017.PRecord.setProp, TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(ACol));
  case TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(ACol) of
    KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: KARTA_PROFILAKTIKA2017.PRecord.BDDIASTOLNO43 := StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: KARTA_PROFILAKTIKA2017.PRecord.BDGIRTWAIST44 := StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_BDHEIGHT39: KARTA_PROFILAKTIKA2017.PRecord.BDHEIGHT39 := StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_BDITM41: KARTA_PROFILAKTIKA2017.PRecord.BDITM41 := StrToFloat(AValue);
    KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: KARTA_PROFILAKTIKA2017.PRecord.BDSYSTOLNO42 := StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_BDWEIGHT40: KARTA_PROFILAKTIKA2017.PRecord.BDWEIGHT40 := StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: KARTA_PROFILAKTIKA2017.PRecord.CIGARETESCOUNT71 := StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_FINDRISK: KARTA_PROFILAKTIKA2017.PRecord.FINDRISK := StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_ISSUE_DATE: KARTA_PROFILAKTIKA2017.PRecord.ISSUE_DATE := StrToDate(AValue);
    KARTA_PROFILAKTIKA2017_MDIGLUCOSE48: KARTA_PROFILAKTIKA2017.PRecord.MDIGLUCOSE48 := StrToFloat(AValue);
    KARTA_PROFILAKTIKA2017_MDIHDL50: KARTA_PROFILAKTIKA2017.PRecord.MDIHDL50 := StrToFloat(AValue);
    KARTA_PROFILAKTIKA2017_MDILDL45: KARTA_PROFILAKTIKA2017.PRecord.MDILDL45 := StrToFloat(AValue);
    KARTA_PROFILAKTIKA2017_MDINONHDL73: KARTA_PROFILAKTIKA2017.PRecord.MDINONHDL73 := StrToFloat(AValue);
    KARTA_PROFILAKTIKA2017_MDIPSA49: KARTA_PROFILAKTIKA2017.PRecord.MDIPSA49 := StrToFloat(AValue);
    KARTA_PROFILAKTIKA2017_MDITG47: KARTA_PROFILAKTIKA2017.PRecord.MDITG47 := StrToFloat(AValue);
    KARTA_PROFILAKTIKA2017_MDITH46: KARTA_PROFILAKTIKA2017.PRecord.MDITH46 := StrToFloat(AValue);
    KARTA_PROFILAKTIKA2017_NOMER: KARTA_PROFILAKTIKA2017.PRecord.NOMER := StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_PREGLED_ID: KARTA_PROFILAKTIKA2017.PRecord.PREGLED_ID := StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_SCORE: KARTA_PROFILAKTIKA2017.PRecord.SCORE := StrToInt(AValue);
    KARTA_PROFILAKTIKA2017_Logical: KARTA_PROFILAKTIKA2017.PRecord.Logical := tlogicalKARTA_PROFILAKTIKA2017Set(KARTA_PROFILAKTIKA2017.StrToLogical32(AValue));
  end;
end;

procedure TKARTA_PROFILAKTIKA2017Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  KARTA_PROFILAKTIKA2017: TKARTA_PROFILAKTIKA2017Item;
begin
  if Count = 0 then Exit;
  isOld := False; 
  KARTA_PROFILAKTIKA2017 := Items[ARow];
  if not Assigned(KARTA_PROFILAKTIKA2017.PRecord) then
  begin
    New(KARTA_PROFILAKTIKA2017.PRecord);
    KARTA_PROFILAKTIKA2017.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(ACol) of
      KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_BDHEIGHT39: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_BDWEIGHT40: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_FINDRISK: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_ISSUE_DATE: isOld :=  KARTA_PROFILAKTIKA2017.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    KARTA_PROFILAKTIKA2017_NOMER: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_PREGLED_ID: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_SCORE: isOld :=  KARTA_PROFILAKTIKA2017.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(KARTA_PROFILAKTIKA2017.PRecord.setProp, TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(ACol));
    if KARTA_PROFILAKTIKA2017.PRecord.setProp = [] then
    begin
      Dispose(KARTA_PROFILAKTIKA2017.PRecord);
      KARTA_PROFILAKTIKA2017.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(KARTA_PROFILAKTIKA2017.PRecord.setProp, TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(ACol));
  case TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(ACol) of
    KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: KARTA_PROFILAKTIKA2017.PRecord.BDDIASTOLNO43 := StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: KARTA_PROFILAKTIKA2017.PRecord.BDGIRTWAIST44 := StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_BDHEIGHT39: KARTA_PROFILAKTIKA2017.PRecord.BDHEIGHT39 := StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_BDITM41: KARTA_PROFILAKTIKA2017.PRecord.BDITM41 := StrToFloat(AFieldText);
    KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: KARTA_PROFILAKTIKA2017.PRecord.BDSYSTOLNO42 := StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_BDWEIGHT40: KARTA_PROFILAKTIKA2017.PRecord.BDWEIGHT40 := StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: KARTA_PROFILAKTIKA2017.PRecord.CIGARETESCOUNT71 := StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_FINDRISK: KARTA_PROFILAKTIKA2017.PRecord.FINDRISK := StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_ISSUE_DATE: KARTA_PROFILAKTIKA2017.PRecord.ISSUE_DATE := StrToDate(AFieldText);
    KARTA_PROFILAKTIKA2017_MDIGLUCOSE48: KARTA_PROFILAKTIKA2017.PRecord.MDIGLUCOSE48 := StrToFloat(AFieldText);
    KARTA_PROFILAKTIKA2017_MDIHDL50: KARTA_PROFILAKTIKA2017.PRecord.MDIHDL50 := StrToFloat(AFieldText);
    KARTA_PROFILAKTIKA2017_MDILDL45: KARTA_PROFILAKTIKA2017.PRecord.MDILDL45 := StrToFloat(AFieldText);
    KARTA_PROFILAKTIKA2017_MDINONHDL73: KARTA_PROFILAKTIKA2017.PRecord.MDINONHDL73 := StrToFloat(AFieldText);
    KARTA_PROFILAKTIKA2017_MDIPSA49: KARTA_PROFILAKTIKA2017.PRecord.MDIPSA49 := StrToFloat(AFieldText);
    KARTA_PROFILAKTIKA2017_MDITG47: KARTA_PROFILAKTIKA2017.PRecord.MDITG47 := StrToFloat(AFieldText);
    KARTA_PROFILAKTIKA2017_MDITH46: KARTA_PROFILAKTIKA2017.PRecord.MDITH46 := StrToFloat(AFieldText);
    KARTA_PROFILAKTIKA2017_NOMER: KARTA_PROFILAKTIKA2017.PRecord.NOMER := StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_PREGLED_ID: KARTA_PROFILAKTIKA2017.PRecord.PREGLED_ID := StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_SCORE: KARTA_PROFILAKTIKA2017.PRecord.SCORE := StrToInt(AFieldText);
    KARTA_PROFILAKTIKA2017_Logical: KARTA_PROFILAKTIKA2017.PRecord.Logical := tlogicalKARTA_PROFILAKTIKA2017Set(KARTA_PROFILAKTIKA2017.StrToLogical32(AFieldText));
  end;
end;

procedure TKARTA_PROFILAKTIKA2017Coll.SetItem(Index: Integer; const Value: TKARTA_PROFILAKTIKA2017Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TKARTA_PROFILAKTIKA2017Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListKARTA_PROFILAKTIKA2017Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: 
begin
  if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
  begin
    ListKARTA_PROFILAKTIKA2017Search.Add(self.Items[i]);
  end;
end;
      KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListKARTA_PROFILAKTIKA2017Search.Add(self.Items[i]);
        end;
      end;
      KARTA_PROFILAKTIKA2017_BDHEIGHT39: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListKARTA_PROFILAKTIKA2017Search.Add(self.Items[i]);
        end;
      end;
      KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListKARTA_PROFILAKTIKA2017Search.Add(self.Items[i]);
        end;
      end;
      KARTA_PROFILAKTIKA2017_BDWEIGHT40: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListKARTA_PROFILAKTIKA2017Search.Add(self.Items[i]);
        end;
      end;
      KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListKARTA_PROFILAKTIKA2017Search.Add(self.Items[i]);
        end;
      end;
      KARTA_PROFILAKTIKA2017_FINDRISK: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListKARTA_PROFILAKTIKA2017Search.Add(self.Items[i]);
        end;
      end;
      KARTA_PROFILAKTIKA2017_NOMER: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListKARTA_PROFILAKTIKA2017Search.Add(self.Items[i]);
        end;
      end;
      KARTA_PROFILAKTIKA2017_PREGLED_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListKARTA_PROFILAKTIKA2017Search.Add(self.Items[i]);
        end;
      end;
      KARTA_PROFILAKTIKA2017_SCORE: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListKARTA_PROFILAKTIKA2017Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TKARTA_PROFILAKTIKA2017Coll.ShowGrid(Grid: TTeeGrid);
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

procedure TKARTA_PROFILAKTIKA2017Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TKARTA_PROFILAKTIKA2017Item>);
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

procedure TKARTA_PROFILAKTIKA2017Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListKARTA_PROFILAKTIKA2017Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListKARTA_PROFILAKTIKA2017Search.Count]);

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

procedure TKARTA_PROFILAKTIKA2017Coll.SortByIndexAnsiString;
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

procedure TKARTA_PROFILAKTIKA2017Coll.SortByIndexInt;
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

procedure TKARTA_PROFILAKTIKA2017Coll.SortByIndexWord;
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

procedure TKARTA_PROFILAKTIKA2017Coll.SortByIndexValue(propIndex: TKARTA_PROFILAKTIKA2017Item.TPropertyIndex);
begin
  case propIndex of
    KARTA_PROFILAKTIKA2017_BDDIASTOLNO43: SortByIndexInt;
      KARTA_PROFILAKTIKA2017_BDGIRTWAIST44: SortByIndexInt;
      KARTA_PROFILAKTIKA2017_BDHEIGHT39: SortByIndexInt;
      KARTA_PROFILAKTIKA2017_BDSYSTOLNO42: SortByIndexInt;
      KARTA_PROFILAKTIKA2017_BDWEIGHT40: SortByIndexInt;
      KARTA_PROFILAKTIKA2017_CIGARETESCOUNT71: SortByIndexInt;
      KARTA_PROFILAKTIKA2017_FINDRISK: SortByIndexInt;
      KARTA_PROFILAKTIKA2017_NOMER: SortByIndexInt;
      KARTA_PROFILAKTIKA2017_PREGLED_ID: SortByIndexInt;
      KARTA_PROFILAKTIKA2017_SCORE: SortByIndexInt;
  end;
end;

end.