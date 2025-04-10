unit Table.NZIS_RESULT_DIAGNOSTIC_REPORT;

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


TNZIS_RESULT_DIAGNOSTIC_REPORTItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE
, NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE
, NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE
, NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID
, NZIS_RESULT_DIAGNOSTIC_REPORT_ID
, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE
, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_DATE_TIME
, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY
, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING
, NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT
, NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS
);

      TSetProp = set of TPropertyIndex;
      PRecNZIS_RESULT_DIAGNOSTIC_REPORT = ^TRecNZIS_RESULT_DIAGNOSTIC_REPORT;
      TRecNZIS_RESULT_DIAGNOSTIC_REPORT = record
        CL028_VALUE_SCALE: word;
        CL138_VALUE_NOMENCLATURE: AnsiString;
        CL144_CODE: AnsiString;
        DIAGNOSTIC_REPORT_ID: integer;
        ID: integer;
        VALUE_CODE: AnsiString;
        VALUE_DATE_TIME: TDateTime;
        VALUE_QUANTITY: double;
        VALUE_STRING: AnsiString;
        VALUE_UNIT: AnsiString;
        NOMEN_POS: Cardinal;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecNZIS_RESULT_DIAGNOSTIC_REPORT;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertNZIS_RESULT_DIAGNOSTIC_REPORT;
    procedure UpdateNZIS_RESULT_DIAGNOSTIC_REPORT;
    procedure SaveNZIS_RESULT_DIAGNOSTIC_REPORT(var dataPosition: Cardinal);
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TNZIS_RESULT_DIAGNOSTIC_REPORTColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TNZIS_RESULT_DIAGNOSTIC_REPORTItem;
    procedure SetItem(Index: Integer; const Value: TNZIS_RESULT_DIAGNOSTIC_REPORTItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TNZIS_RESULT_DIAGNOSTIC_REPORTItem;
	ListForFDB: TList<TNZIS_RESULT_DIAGNOSTIC_REPORTItem>;
    ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch: TList<TNZIS_RESULT_DIAGNOSTIC_REPORTItem>;
	PRecordSearch: ^TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TRecNZIS_RESULT_DIAGNOSTIC_REPORT;
    ArrPropSearch: TArray<TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TNZIS_RESULT_DIAGNOSTIC_REPORTItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; NZIS_RESULT_DIAGNOSTIC_REPORT: TNZIS_RESULT_DIAGNOSTIC_REPORTItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; NZIS_RESULT_DIAGNOSTIC_REPORT: TNZIS_RESULT_DIAGNOSTIC_REPORTItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TNZIS_RESULT_DIAGNOSTIC_REPORTItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex);
    property Items[Index: Integer]: TNZIS_RESULT_DIAGNOSTIC_REPORTItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
  end;

implementation

{ TNZIS_RESULT_DIAGNOSTIC_REPORTItem }

constructor TNZIS_RESULT_DIAGNOSTIC_REPORTItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TNZIS_RESULT_DIAGNOSTIC_REPORTItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTItem.InsertNZIS_RESULT_DIAGNOSTIC_REPORT;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctNZIS_RESULT_DIAGNOSTIC_REPORT;
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
            NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE: SaveData(PRecord.CL028_VALUE_SCALE, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE: SaveData(PRecord.CL138_VALUE_NOMENCLATURE, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE: SaveData(PRecord.CL144_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID: SaveData(PRecord.DIAGNOSTIC_REPORT_ID, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE: SaveData(PRecord.VALUE_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_DATE_TIME: SaveData(PRecord.VALUE_DATE_TIME, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY: SaveData(PRecord.VALUE_QUANTITY, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING: SaveData(PRecord.VALUE_STRING, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT: SaveData(PRecord.VALUE_UNIT, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS: SaveData(PRecord.NOMEN_POS, PropPosition, metaPosition, dataPosition);
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

function  TNZIS_RESULT_DIAGNOSTIC_REPORTItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TNZIS_RESULT_DIAGNOSTIC_REPORTItem;
begin
  Result := True;
  for i := 0 to Length(TNZIS_RESULT_DIAGNOSTIC_REPORTColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TNZIS_RESULT_DIAGNOSTIC_REPORTColl(coll).ArrPropSearchClc[i];
	ATempItem := TNZIS_RESULT_DIAGNOSTIC_REPORTColl(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE: Result := IsFinded(ATempItem.PRecord.CL028_VALUE_SCALE, buf, FPosDataADB, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE), cot);
        NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE: Result := IsFinded(ATempItem.PRecord.CL138_VALUE_NOMENCLATURE, buf, FPosDataADB, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE), cot);
        NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE: Result := IsFinded(ATempItem.PRecord.CL144_CODE, buf, FPosDataADB, word(NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE), cot);
        NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID: Result := IsFinded(ATempItem.PRecord.DIAGNOSTIC_REPORT_ID, buf, FPosDataADB, word(NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID), cot);
        NZIS_RESULT_DIAGNOSTIC_REPORT_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(NZIS_RESULT_DIAGNOSTIC_REPORT_ID), cot);
        NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE: Result := IsFinded(ATempItem.PRecord.VALUE_CODE, buf, FPosDataADB, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE), cot);
        NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_DATE_TIME: Result := IsFinded(ATempItem.PRecord.VALUE_DATE_TIME, buf, FPosDataADB, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_DATE_TIME), cot);
        NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY: Result := IsFinded(ATempItem.PRecord.VALUE_QUANTITY, buf, FPosDataADB, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY), cot);
        NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING: Result := IsFinded(ATempItem.PRecord.VALUE_STRING, buf, FPosDataADB, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING), cot);
        NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT: Result := IsFinded(ATempItem.PRecord.VALUE_UNIT, buf, FPosDataADB, word(NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT), cot);
        NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS: Result := IsFinded(ATempItem.PRecord.NOMEN_POS, buf, FPosDataADB, word(NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS), cot);
      end;
    end;
  end;
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTItem.SaveNZIS_RESULT_DIAGNOSTIC_REPORT(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNZIS_RESULT_DIAGNOSTIC_REPORT;
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
            NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE: SaveData(PRecord.CL028_VALUE_SCALE, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE: SaveData(PRecord.CL138_VALUE_NOMENCLATURE, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE: SaveData(PRecord.CL144_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID: SaveData(PRecord.DIAGNOSTIC_REPORT_ID, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE: SaveData(PRecord.VALUE_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_DATE_TIME: SaveData(PRecord.VALUE_DATE_TIME, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY: SaveData(PRecord.VALUE_QUANTITY, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING: SaveData(PRecord.VALUE_STRING, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT: SaveData(PRecord.VALUE_UNIT, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS: SaveData(PRecord.NOMEN_POS, PropPosition, metaPosition, dataPosition);
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

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTItem.UpdateNZIS_RESULT_DIAGNOSTIC_REPORT;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNZIS_RESULT_DIAGNOSTIC_REPORT;
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
            NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE: UpdateData(PRecord.CL028_VALUE_SCALE, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE: UpdateData(PRecord.CL138_VALUE_NOMENCLATURE, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE: UpdateData(PRecord.CL144_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID: UpdateData(PRecord.DIAGNOSTIC_REPORT_ID, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE: UpdateData(PRecord.VALUE_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_DATE_TIME: UpdateData(PRecord.VALUE_DATE_TIME, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY: UpdateData(PRecord.VALUE_QUANTITY, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING: UpdateData(PRecord.VALUE_STRING, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT: UpdateData(PRecord.VALUE_UNIT, PropPosition, metaPosition, dataPosition);
            NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS: UpdateData(PRecord.NOMEN_POS, PropPosition, metaPosition, dataPosition);
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

{ TNZIS_RESULT_DIAGNOSTIC_REPORTColl }

function TNZIS_RESULT_DIAGNOSTIC_REPORTColl.AddItem(ver: word): TNZIS_RESULT_DIAGNOSTIC_REPORTItem;
begin
  Result := TNZIS_RESULT_DIAGNOSTIC_REPORTItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TNZIS_RESULT_DIAGNOSTIC_REPORTColl.AddItemForSearch: Integer;
var
  ItemForSearch: TNZIS_RESULT_DIAGNOSTIC_REPORTItem;
begin
  ItemForSearch := TNZIS_RESULT_DIAGNOSTIC_REPORTItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TNZIS_RESULT_DIAGNOSTIC_REPORTColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TNZIS_RESULT_DIAGNOSTIC_REPORTItem.Create(nil);
  ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch := TList<TNZIS_RESULT_DIAGNOSTIC_REPORTItem>.Create;
  ListForFDB := TList<TNZIS_RESULT_DIAGNOSTIC_REPORTItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TNZIS_RESULT_DIAGNOSTIC_REPORTColl.destroy;
begin
  FreeAndNil(ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TNZIS_RESULT_DIAGNOSTIC_REPORTColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(propIndex) of
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE: Result := 'CL028_VALUE_SCALE';
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE: Result := 'CL138_VALUE_NOMENCLATURE';
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE: Result := 'CL144_CODE';
    NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID: Result := 'DIAGNOSTIC_REPORT_ID';
    NZIS_RESULT_DIAGNOSTIC_REPORT_ID: Result := 'ID';
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE: Result := 'VALUE_CODE';
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_DATE_TIME: Result := 'VALUE_DATE_TIME';
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY: Result := 'VALUE_QUANTITY';
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING: Result := 'VALUE_STRING';
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT: Result := 'VALUE_UNIT';
    NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS: Result := 'NOMEN_POS';
  end;
end;

function TNZIS_RESULT_DIAGNOSTIC_REPORTColl.FieldCount: Integer;
begin
  inherited;
  Result := 11;
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NZIS_RESULT_DIAGNOSTIC_REPORT: TNZIS_RESULT_DIAGNOSTIC_REPORTItem;
  ACol: Integer;
  prop: TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NZIS_RESULT_DIAGNOSTIC_REPORT := Items[ARow];
  prop := TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(ACol);
  if Assigned(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord) and (prop in NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_RESULT_DIAGNOSTIC_REPORT, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_RESULT_DIAGNOSTIC_REPORT, AValue);
  end;
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  prop := TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.GetCellFromRecord(propIndex: word; NZIS_RESULT_DIAGNOSTIC_REPORT: TNZIS_RESULT_DIAGNOSTIC_REPORTItem; var AValue: String);
var
  str: string;
begin
  case TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(propIndex) of
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE: str := inttostr(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.CL028_VALUE_SCALE);
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE: str := (NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.CL138_VALUE_NOMENCLATURE);
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE: str := (NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.CL144_CODE);
    NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID: str := inttostr(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.DIAGNOSTIC_REPORT_ID);
    NZIS_RESULT_DIAGNOSTIC_REPORT_ID: str := inttostr(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.ID);
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE: str := (NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.VALUE_CODE);
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_DATE_TIME: str := DateTimeToStr(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.VALUE_DATE_TIME);
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY: str := FloatToStr(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.VALUE_QUANTITY);
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING: str := (NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.VALUE_STRING);
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT: str := (NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.VALUE_UNIT);
    NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS: str := inttostr(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.NOMEN_POS);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TNZIS_RESULT_DIAGNOSTIC_REPORTItem;
  ACol: Integer;
  prop: TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NZIS_RESULT_DIAGNOSTIC_REPORT: TNZIS_RESULT_DIAGNOSTIC_REPORTItem;
  ACol: Integer;
  prop: TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NZIS_RESULT_DIAGNOSTIC_REPORT := ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch[ARow];
  prop := TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(ACol);
  if Assigned(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord) and (prop in NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_RESULT_DIAGNOSTIC_REPORT, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_RESULT_DIAGNOSTIC_REPORT, AValue);
  end;
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  NZIS_RESULT_DIAGNOSTIC_REPORT: TNZIS_RESULT_DIAGNOSTIC_REPORTItem;
  prop: TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  NZIS_RESULT_DIAGNOSTIC_REPORT := Items[ARow];
  prop := TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(ACol);
  if Assigned(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord) and (prop in NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_RESULT_DIAGNOSTIC_REPORT, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_RESULT_DIAGNOSTIC_REPORT, AFieldText);
  end;
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.GetCellFromMap(propIndex: word; ARow: Integer; NZIS_RESULT_DIAGNOSTIC_REPORT: TNZIS_RESULT_DIAGNOSTIC_REPORTItem; var AValue: String);
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
  case TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(propIndex) of
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE: str :=  inttostr(NZIS_RESULT_DIAGNOSTIC_REPORT.getWordMap(Self.Buf, Self.posData, propIndex));
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE: str :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE: str :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID: str :=  inttostr(NZIS_RESULT_DIAGNOSTIC_REPORT.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_RESULT_DIAGNOSTIC_REPORT_ID: str :=  inttostr(NZIS_RESULT_DIAGNOSTIC_REPORT.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE: str :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_DATE_TIME: str := DateTimeToStr(NZIS_RESULT_DIAGNOSTIC_REPORT.getDoubleMap(Self.Buf, Self.posData, propIndex));
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING: str :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY: str := Double.ToString(NZIS_RESULT_DIAGNOSTIC_REPORT.getDoubleMap(Self.Buf, Self.posData, propIndex));
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT: str :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS: str :=  inttostr(NZIS_RESULT_DIAGNOSTIC_REPORT.getCardMap(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TNZIS_RESULT_DIAGNOSTIC_REPORTColl.GetItem(Index: Integer): TNZIS_RESULT_DIAGNOSTIC_REPORTItem;
begin
  Result := TNZIS_RESULT_DIAGNOSTIC_REPORTItem(inherited GetItem(Index));
end;


procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.IndexValue(propIndex: TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TNZIS_RESULT_DIAGNOSTIC_REPORTItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      NZIS_RESULT_DIAGNOSTIC_REPORT_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS: TempItem.IndexInt :=  TempItem.getPCardMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.IndexValueListNodes(propIndex: TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex);
begin

end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TNZIS_RESULT_DIAGNOSTIC_REPORTItem;
begin
  if index < 0 then
  begin
    Tempitem := TNZIS_RESULT_DIAGNOSTIC_REPORTItem.Create(nil);
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



function TNZIS_RESULT_DIAGNOSTIC_REPORTColl.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(propIndex) of
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE: Result := actword;
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE: Result := actAnsiString;
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE: Result := actAnsiString;
    NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID: Result := actinteger;
    NZIS_RESULT_DIAGNOSTIC_REPORT_ID: Result := actinteger;
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE: Result := actAnsiString;
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_DATE_TIME: Result := actTIMESTAMP;
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY: Result := actdouble;
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING: Result := actAnsiString;
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT: Result := actAnsiString;
    NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS: Result := actCardinal;
  else
    Result := actNone;
  end
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  NZIS_RESULT_DIAGNOSTIC_REPORT: TNZIS_RESULT_DIAGNOSTIC_REPORTItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  NZIS_RESULT_DIAGNOSTIC_REPORT := Items[ARow];
  if not Assigned(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord) then
  begin
    New(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord);
    NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(ACol) of
      NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      NZIS_RESULT_DIAGNOSTIC_REPORT_ID: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getCardMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.setProp, TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(ACol));
    if NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.setProp = [] then
    begin
      Dispose(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord);
      NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.setProp, TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(ACol));
  case TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(ACol) of
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.CL028_VALUE_SCALE := StrToInt(AValue);
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.CL138_VALUE_NOMENCLATURE := AValue;
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.CL144_CODE := AValue;
    NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.DIAGNOSTIC_REPORT_ID := StrToInt(AValue);
    NZIS_RESULT_DIAGNOSTIC_REPORT_ID: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.ID := StrToInt(AValue);
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.VALUE_CODE := AValue;
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_DATE_TIME: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.VALUE_DATE_TIME := StrToDateTime(AValue);
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.VALUE_QUANTITY := StrToFloat(AValue);
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.VALUE_STRING := AValue;
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.VALUE_UNIT := AValue;
    NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.NOMEN_POS := StrToInt(AValue);
  end;
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  NZIS_RESULT_DIAGNOSTIC_REPORT: TNZIS_RESULT_DIAGNOSTIC_REPORTItem;
begin
  if Count = 0 then Exit;

  NZIS_RESULT_DIAGNOSTIC_REPORT := Items[ARow];
  if not Assigned(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord) then
  begin
    New(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord);
    NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(ACol) of
      NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
      NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
      NZIS_RESULT_DIAGNOSTIC_REPORT_ID: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
      NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS: isOld :=  NZIS_RESULT_DIAGNOSTIC_REPORT.getCardMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);

    end;
  end;
  if isOld then
  begin
    Exclude(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.setProp, TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(ACol));
    if NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.setProp = [] then
    begin
      Dispose(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord);
      NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.setProp, TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(ACol));
  case TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(ACol) of
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.CL028_VALUE_SCALE := StrToInt(AFieldText);
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.CL138_VALUE_NOMENCLATURE := AFieldText;
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.CL144_CODE := AFieldText;
    NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.DIAGNOSTIC_REPORT_ID := StrToInt(AFieldText);
    NZIS_RESULT_DIAGNOSTIC_REPORT_ID: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.ID := StrToInt(AFieldText);
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.VALUE_CODE := AFieldText;
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_DATE_TIME: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.VALUE_DATE_TIME := StrToDateTime(AFieldText);
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_QUANTITY: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.VALUE_QUANTITY := StrToFloat(AFieldText);
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.VALUE_STRING := AFieldText;
    NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.VALUE_UNIT := AFieldText;
    NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS: NZIS_RESULT_DIAGNOSTIC_REPORT.PRecord.NOMEN_POS := StrToInt(AFieldText);
  end;
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.SetItem(Index: Integer; const Value: TNZIS_RESULT_DIAGNOSTIC_REPORTItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE: 
begin
  if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
  begin
    ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch.Add(self.Items[i]);
  end;
end;
      NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch.Add(self.Items[i]);
        end;
      end;
      NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch.Add(self.Items[i]);
        end;
      end;
      NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch.Add(self.Items[i]);
        end;
      end;
      NZIS_RESULT_DIAGNOSTIC_REPORT_ID:
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch.Add(self.Items[i]);
        end;
      end;
      NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch.Add(self.Items[i]);
        end;
      end;
      NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch.Add(self.Items[i]);
        end;
      end;
      NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch.Add(self.Items[i]);
        end;
      end;
      NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS:
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.ShowGrid(Grid: TTeeGrid);
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

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TNZIS_RESULT_DIAGNOSTIC_REPORTItem>);
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

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListNZIS_RESULT_DIAGNOSTIC_REPORTSearch.Count]);

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

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.SortByIndexAnsiString;
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

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.SortByIndexInt;
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

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.SortByIndexWord;
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

procedure TNZIS_RESULT_DIAGNOSTIC_REPORTColl.SortByIndexValue(propIndex: TNZIS_RESULT_DIAGNOSTIC_REPORTItem.TPropertyIndex);
begin
  case propIndex of
    NZIS_RESULT_DIAGNOSTIC_REPORT_CL028_VALUE_SCALE: SortByIndexWord;
      NZIS_RESULT_DIAGNOSTIC_REPORT_CL138_VALUE_NOMENCLATURE: SortByIndexAnsiString;
      NZIS_RESULT_DIAGNOSTIC_REPORT_CL144_CODE: SortByIndexAnsiString;
      NZIS_RESULT_DIAGNOSTIC_REPORT_DIAGNOSTIC_REPORT_ID: SortByIndexInt;
      NZIS_RESULT_DIAGNOSTIC_REPORT_ID: SortByIndexInt;
      NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_CODE: SortByIndexAnsiString;
      NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_STRING: SortByIndexAnsiString;
      NZIS_RESULT_DIAGNOSTIC_REPORT_VALUE_UNIT: SortByIndexAnsiString;
      NZIS_RESULT_DIAGNOSTIC_REPORT_NOMEN_POS: SortByIndexInt;
  end;
end;

end.