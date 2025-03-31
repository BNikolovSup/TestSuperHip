unit Table.KARTA_PROFILAKTIKA2017;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control;

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
    procedure SaveKARTA_PROFILAKTIKA2017(var dataPosition: Cardinal);
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TKARTA_PROFILAKTIKA2017Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TKARTA_PROFILAKTIKA2017Item;
    procedure SetItem(Index: Integer; const Value: TKARTA_PROFILAKTIKA2017Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TKARTA_PROFILAKTIKA2017Item;
	ListForFDB: TList<TKARTA_PROFILAKTIKA2017Item>;
    ListKARTA_PROFILAKTIKA2017Search: TList<TKARTA_PROFILAKTIKA2017Item>;
	PRecordSearch: ^TKARTA_PROFILAKTIKA2017Item.TRecKARTA_PROFILAKTIKA2017;
    ArrPropSearch: TArray<TKARTA_PROFILAKTIKA2017Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TKARTA_PROFILAKTIKA2017Item.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TKARTA_PROFILAKTIKA2017Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
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

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TKARTA_PROFILAKTIKA2017Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TKARTA_PROFILAKTIKA2017Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TKARTA_PROFILAKTIKA2017Item.TPropertyIndex);
    property Items[Index: Integer]: TKARTA_PROFILAKTIKA2017Item read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);

    procedure OnSetTextSearchLog(Log: TlogicalKARTA_PROFILAKTIKA2017Set);
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
	ATempItem := TKARTA_PROFILAKTIKA2017Coll(coll).ListForFDB.Items[0];
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
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TKARTA_PROFILAKTIKA2017Coll.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TKARTA_PROFILAKTIKA2017Item.Create(nil);
  ListKARTA_PROFILAKTIKA2017Search := TList<TKARTA_PROFILAKTIKA2017Item>.Create;
  ListForFDB := TList<TKARTA_PROFILAKTIKA2017Item>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TKARTA_PROFILAKTIKA2017Coll.destroy;
begin
  FreeAndNil(ListKARTA_PROFILAKTIKA2017Search);
  FreeAndNil(ListForFDB);
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



function TKARTA_PROFILAKTIKA2017Coll.FieldCount: Integer;
begin
  inherited;
  Result := 20;
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
  ACol: Integer;
  prop: TKARTA_PROFILAKTIKA2017Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := ListDataPos[ARow].DataPos;
  prop := TKARTA_PROFILAKTIKA2017Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
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
    KARTA_PROFILAKTIKA2017_ISSUE_DATE: str := DateToStr(KARTA_PROFILAKTIKA2017.PRecord.ISSUE_DATE);
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
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
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
    KARTA_PROFILAKTIKA2017_ISSUE_DATE: str :=  DateToStr(KARTA_PROFILAKTIKA2017.getDateMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_MDIHDL50: str :=  FloatToStr(KARTA_PROFILAKTIKA2017.getDoubleMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_MDILDL45: str :=  FloatToStr(KARTA_PROFILAKTIKA2017.getDoubleMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_MDINONHDL73: str :=  FloatToStr(KARTA_PROFILAKTIKA2017.getDoubleMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_MDIGLUCOSE48: str :=  FloatToStr(KARTA_PROFILAKTIKA2017.getDoubleMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_MDIPSA49: str :=  FloatToStr(KARTA_PROFILAKTIKA2017.getDoubleMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_MDITG47: str :=  FloatToStr(KARTA_PROFILAKTIKA2017.getDoubleMap(Self.Buf, Self.posData, propIndex));
    KARTA_PROFILAKTIKA2017_MDITH46: str :=  FloatToStr(KARTA_PROFILAKTIKA2017.getDoubleMap(Self.Buf, Self.posData, propIndex));
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





procedure TKARTA_PROFILAKTIKA2017Coll.OnSetTextSearchLog(Log: TlogicalKARTA_PROFILAKTIKA2017Set);
begin
  ListForFDB[0].PRecord.Logical := Log;
end;

function TKARTA_PROFILAKTIKA2017Coll.PropType(propIndex: Word): TAsectTypeKind;
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

procedure TKARTA_PROFILAKTIKA2017Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  KARTA_PROFILAKTIKA2017: TKARTA_PROFILAKTIKA2017Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  KARTA_PROFILAKTIKA2017 := Items[ARow];
  if not Assigned(KARTA_PROFILAKTIKA2017.PRecord) then
  begin
    New(KARTA_PROFILAKTIKA2017.PRecord);
    KARTA_PROFILAKTIKA2017.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
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
    KARTA_PROFILAKTIKA2017_Logical: KARTA_PROFILAKTIKA2017.PRecord.Logical := TlogicalKARTA_PROFILAKTIKA2017Set(KARTA_PROFILAKTIKA2017.StrToLogical32(AValue));
  end;
end;

procedure TKARTA_PROFILAKTIKA2017Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  KARTA_PROFILAKTIKA2017: TKARTA_PROFILAKTIKA2017Item;
begin
  if Count = 0 then Exit;

  KARTA_PROFILAKTIKA2017 := Items[ARow];
  if not Assigned(KARTA_PROFILAKTIKA2017.PRecord) then
  begin
    New(KARTA_PROFILAKTIKA2017.PRecord);
    KARTA_PROFILAKTIKA2017.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
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
    KARTA_PROFILAKTIKA2017_Logical: KARTA_PROFILAKTIKA2017.PRecord.Logical := TlogicalKARTA_PROFILAKTIKA2017Set(KARTA_PROFILAKTIKA2017.StrToLogical32(AFieldText));//KARTA_PROFILAKTIKA2017.PRecord.Logical := StrToInt(AFieldText);
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
  ListForFDB := LST;
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
        while ((Items[I]).IndexAnsiStr1) < ((Items[P]).IndexAnsiStr1) do Inc(I);
        while ((Items[J]).IndexAnsiStr1) > ((Items[P]).IndexAnsiStr1) do Dec(J);
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