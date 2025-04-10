unit Table.NZIS_ANSWER_VALUE;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control;
  //fmx.EditDyn, DateEditDyn, CheckBoxDyn;

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


TNZIS_ANSWER_VALUEItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
NZIS_ANSWER_VALUE_ANSWER_BOOLEAN
, NZIS_ANSWER_VALUE_ANSWER_CODE
, NZIS_ANSWER_VALUE_ANSWER_DATE
, NZIS_ANSWER_VALUE_ANSWER_QUANTITY
, NZIS_ANSWER_VALUE_ANSWER_TEXT
, NZIS_ANSWER_VALUE_CL028
, NZIS_ANSWER_VALUE_ID
, NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID
, NZIS_ANSWER_VALUE_NOMEN_POS
);

      TSetProp = set of TPropertyIndex;
      PRecNZIS_ANSWER_VALUE = ^TRecNZIS_ANSWER_VALUE;
      TRecNZIS_ANSWER_VALUE = record
        ANSWER_BOOLEAN: boolean;
        ANSWER_CODE: AnsiString;
        ANSWER_DATE: TDate;
        ANSWER_QUANTITY: double;
        ANSWER_TEXT: AnsiString;
        CL028: word;
        ID: integer;
        QUESTIONNAIRE_ANSWER_ID: integer;
        NOMEN_POS: Cardinal;
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
    procedure InsertNZIS_ANSWER_VALUE; dynamic;
    procedure UpdateNZIS_ANSWER_VALUE;
    procedure SaveNZIS_ANSWER_VALUE(var dataPosition: Cardinal);
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TNZIS_ANSWER_VALUEColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TNZIS_ANSWER_VALUEItem;
    procedure SetItem(Index: Integer; const Value: TNZIS_ANSWER_VALUEItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TNZIS_ANSWER_VALUEItem;
	ListForFDB: TList<TNZIS_ANSWER_VALUEItem>;
    ListNZIS_ANSWER_VALUESearch: TList<TNZIS_ANSWER_VALUEItem>;
	PRecordSearch: ^TNZIS_ANSWER_VALUEItem.TRecNZIS_ANSWER_VALUE;
    ArrPropSearch: TArray<TNZIS_ANSWER_VALUEItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TNZIS_ANSWER_VALUEItem.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TNZIS_ANSWER_VALUEItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
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

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TNZIS_ANSWER_VALUEItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TNZIS_ANSWER_VALUEItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TNZIS_ANSWER_VALUEItem.TPropertyIndex);
    property Items[Index: Integer]: TNZIS_ANSWER_VALUEItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
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
            NZIS_ANSWER_VALUE_ANSWER_BOOLEAN: SaveData(PRecord.ANSWER_BOOLEAN, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_CODE: SaveData(PRecord.ANSWER_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_DATE: SaveData(PRecord.ANSWER_DATE, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_QUANTITY: SaveData(PRecord.ANSWER_QUANTITY, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_TEXT: SaveData(PRecord.ANSWER_TEXT, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_CL028: SaveData(PRecord.CL028, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: SaveData(PRecord.QUESTIONNAIRE_ANSWER_ID, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_NOMEN_POS: SaveData(PRecord.NOMEN_POS, PropPosition, metaPosition, dataPosition);
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
	ATempItem := TNZIS_ANSWER_VALUEColl(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        NZIS_ANSWER_VALUE_ANSWER_BOOLEAN: Result := IsFinded(ATempItem.PRecord.ANSWER_BOOLEAN, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_ANSWER_BOOLEAN), cot);
        NZIS_ANSWER_VALUE_ANSWER_CODE: Result := IsFinded(ATempItem.PRecord.ANSWER_CODE, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_ANSWER_CODE), cot);
        NZIS_ANSWER_VALUE_ANSWER_DATE: Result := IsFinded(ATempItem.PRecord.ANSWER_DATE, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_ANSWER_DATE), cot);
        NZIS_ANSWER_VALUE_ANSWER_QUANTITY: Result := IsFinded(ATempItem.PRecord.ANSWER_QUANTITY, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_ANSWER_QUANTITY), cot);
        NZIS_ANSWER_VALUE_ANSWER_TEXT: Result := IsFinded(ATempItem.PRecord.ANSWER_TEXT, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_ANSWER_TEXT), cot);
        NZIS_ANSWER_VALUE_CL028: Result := IsFinded(ATempItem.PRecord.CL028, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_CL028), cot);
        NZIS_ANSWER_VALUE_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_ID), cot);
        NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: Result := IsFinded(ATempItem.PRecord.QUESTIONNAIRE_ANSWER_ID, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID), cot);
        NZIS_ANSWER_VALUE_NOMEN_POS: Result := IsFinded(ATempItem.PRecord.NOMEN_POS, buf, FPosDataADB, word(NZIS_ANSWER_VALUE_ID), cot);
      end;
    end;
  end;
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
            NZIS_ANSWER_VALUE_ANSWER_BOOLEAN: SaveData(PRecord.ANSWER_BOOLEAN, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_CODE: SaveData(PRecord.ANSWER_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_DATE: SaveData(PRecord.ANSWER_DATE, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_QUANTITY: SaveData(PRecord.ANSWER_QUANTITY, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ANSWER_TEXT: SaveData(PRecord.ANSWER_TEXT, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_CL028: SaveData(PRecord.CL028, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: SaveData(PRecord.QUESTIONNAIRE_ANSWER_ID, PropPosition, metaPosition, dataPosition);
            NZIS_ANSWER_VALUE_NOMEN_POS: SaveData(PRecord.NOMEN_POS, PropPosition, metaPosition, dataPosition);
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
            NZIS_ANSWER_VALUE_ANSWER_BOOLEAN: UpdateData(PRecord.ANSWER_BOOLEAN, PropPosition, metaPosition, dataPosition);
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
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TNZIS_ANSWER_VALUEColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TNZIS_ANSWER_VALUEItem.Create(nil);
  ListNZIS_ANSWER_VALUESearch := TList<TNZIS_ANSWER_VALUEItem>.Create;
  ListForFDB := TList<TNZIS_ANSWER_VALUEItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TNZIS_ANSWER_VALUEColl.destroy;
begin
  FreeAndNil(ListNZIS_ANSWER_VALUESearch);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TNZIS_ANSWER_VALUEColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TNZIS_ANSWER_VALUEItem.TPropertyIndex(propIndex) of
    NZIS_ANSWER_VALUE_ANSWER_BOOLEAN: Result := 'ANSWER_BOOLEAN';
    NZIS_ANSWER_VALUE_ANSWER_CODE: Result := 'ANSWER_CODE';
    NZIS_ANSWER_VALUE_ANSWER_DATE: Result := 'ANSWER_DATE';
    NZIS_ANSWER_VALUE_ANSWER_QUANTITY: Result := 'ANSWER_QUANTITY';
    NZIS_ANSWER_VALUE_ANSWER_TEXT: Result := 'ANSWER_TEXT';
    NZIS_ANSWER_VALUE_CL028: Result := 'CL128';
    NZIS_ANSWER_VALUE_ID: Result := 'ID';
    NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: Result := 'QUESTIONNAIRE_ANSWER_ID';
    NZIS_ANSWER_VALUE_NOMEN_POS: Result := 'NOMEN_POS';
  end;
end;

function TNZIS_ANSWER_VALUEColl.FieldCount: Integer;
begin
  inherited;
  Result := 9;
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
  ACol: Integer;
  prop: TNZIS_ANSWER_VALUEItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  prop := TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TNZIS_ANSWER_VALUEColl.GetCellFromRecord(propIndex: word; NZIS_ANSWER_VALUE: TNZIS_ANSWER_VALUEItem; var AValue: String);
var
  str: string;
begin
  case TNZIS_ANSWER_VALUEItem.TPropertyIndex(propIndex) of
    NZIS_ANSWER_VALUE_ANSWER_BOOLEAN: str := BoolToStr(NZIS_ANSWER_VALUE.PRecord.ANSWER_BOOLEAN, True);
    NZIS_ANSWER_VALUE_ANSWER_CODE: str := NZIS_ANSWER_VALUE.PRecord.ANSWER_CODE;
    NZIS_ANSWER_VALUE_ANSWER_DATE: str := DateToStr(NZIS_ANSWER_VALUE.PRecord.ANSWER_DATE);
    NZIS_ANSWER_VALUE_ANSWER_QUANTITY: str := Double.ToString(NZIS_ANSWER_VALUE.PRecord.ANSWER_QUANTITY);
    NZIS_ANSWER_VALUE_ANSWER_TEXT: str := (NZIS_ANSWER_VALUE.PRecord.ANSWER_TEXT);
    NZIS_ANSWER_VALUE_CL028: str := inttostr(NZIS_ANSWER_VALUE.PRecord.CL028);
    NZIS_ANSWER_VALUE_ID: str := inttostr(NZIS_ANSWER_VALUE.PRecord.ID);
    NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: str := inttostr(NZIS_ANSWER_VALUE.PRecord.QUESTIONNAIRE_ANSWER_ID);
    NZIS_ANSWER_VALUE_NOMEN_POS: str := inttostr(NZIS_ANSWER_VALUE.PRecord.NOMEN_POS);
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
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
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
    NZIS_ANSWER_VALUE_ANSWER_BOOLEAN: str :=  BoolToStr(NZIS_ANSWER_VALUE.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    NZIS_ANSWER_VALUE_ANSWER_CODE: str :=  NZIS_ANSWER_VALUE.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NZIS_ANSWER_VALUE_ANSWER_DATE: str :=  DateToStr(NZIS_ANSWER_VALUE.getDateMap(Self.Buf, Self.posData, propIndex));
    NZIS_ANSWER_VALUE_ANSWER_QUANTITY: str := Double.ToString(NZIS_ANSWER_VALUE.getDoubleMap(Self.Buf, Self.posData, propIndex));
    NZIS_ANSWER_VALUE_ANSWER_TEXT: str :=  NZIS_ANSWER_VALUE.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NZIS_ANSWER_VALUE_CL028: str :=  inttostr(NZIS_ANSWER_VALUE.getWordMap(Self.Buf, Self.posData, propIndex));
    NZIS_ANSWER_VALUE_ID: str :=  inttostr(NZIS_ANSWER_VALUE.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: str :=  inttostr(NZIS_ANSWER_VALUE.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_ANSWER_VALUE_NOMEN_POS: str :=  inttostr(NZIS_ANSWER_VALUE.getCardMap(Self.Buf, Self.posData, propIndex));
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
      NZIS_ANSWER_VALUE_NOMEN_POS: TempItem.IndexInt :=  TempItem.getPCardMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TNZIS_ANSWER_VALUEColl.IndexValueListNodes(propIndex: TNZIS_ANSWER_VALUEItem.TPropertyIndex);
begin

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



function TNZIS_ANSWER_VALUEColl.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TNZIS_ANSWER_VALUEItem.TPropertyIndex(propIndex) of
    NZIS_ANSWER_VALUE_ANSWER_BOOLEAN: Result := actBool;
    NZIS_ANSWER_VALUE_ANSWER_CODE: Result := actAnsiString;
    NZIS_ANSWER_VALUE_ANSWER_DATE: Result := actTDate;
    NZIS_ANSWER_VALUE_ANSWER_QUANTITY: Result := actdouble;
    NZIS_ANSWER_VALUE_ANSWER_TEXT: Result := actAnsiString;
    NZIS_ANSWER_VALUE_CL028: Result := actword;
    NZIS_ANSWER_VALUE_ID: Result := actinteger;
    NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: Result := actinteger;
    NZIS_ANSWER_VALUE_NOMEN_POS: Result := actCardinal;
  else
    Result := actNone;
  end
end;

procedure TNZIS_ANSWER_VALUEColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  NZIS_ANSWER_VALUE: TNZIS_ANSWER_VALUEItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  NZIS_ANSWER_VALUE := Items[ARow];
  if not Assigned(NZIS_ANSWER_VALUE.PRecord) then
  begin
    New(NZIS_ANSWER_VALUE.PRecord);
    NZIS_ANSWER_VALUE.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol) of
      NZIS_ANSWER_VALUE_ANSWER_BOOLEAN: isOld :=  NZIS_ANSWER_VALUE.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);
      NZIS_ANSWER_VALUE_ANSWER_CODE: isOld :=  NZIS_ANSWER_VALUE.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      NZIS_ANSWER_VALUE_ANSWER_DATE: isOld :=  NZIS_ANSWER_VALUE.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
      NZIS_ANSWER_VALUE_ANSWER_TEXT: isOld :=  NZIS_ANSWER_VALUE.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      NZIS_ANSWER_VALUE_CL028: isOld :=  NZIS_ANSWER_VALUE.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      NZIS_ANSWER_VALUE_ID: isOld :=  NZIS_ANSWER_VALUE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: isOld :=  NZIS_ANSWER_VALUE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      NZIS_ANSWER_VALUE_NOMEN_POS: isOld :=  NZIS_ANSWER_VALUE.getCardMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
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
    NZIS_ANSWER_VALUE_ANSWER_BOOLEAN: NZIS_ANSWER_VALUE.PRecord.ANSWER_BOOLEAN := StrToBool(AValue);
    NZIS_ANSWER_VALUE_ANSWER_CODE: NZIS_ANSWER_VALUE.PRecord.ANSWER_CODE := (AValue);
    NZIS_ANSWER_VALUE_ANSWER_DATE: NZIS_ANSWER_VALUE.PRecord.ANSWER_DATE := StrToDate(AValue);
    NZIS_ANSWER_VALUE_ANSWER_QUANTITY: NZIS_ANSWER_VALUE.PRecord.ANSWER_QUANTITY := StrToFloat(AValue);
    NZIS_ANSWER_VALUE_ANSWER_TEXT: NZIS_ANSWER_VALUE.PRecord.ANSWER_TEXT := AValue;
    NZIS_ANSWER_VALUE_CL028: NZIS_ANSWER_VALUE.PRecord.CL028 := StrToInt(AValue);
    NZIS_ANSWER_VALUE_ID: NZIS_ANSWER_VALUE.PRecord.ID := StrToInt(AValue);
    NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: NZIS_ANSWER_VALUE.PRecord.QUESTIONNAIRE_ANSWER_ID := StrToInt(AValue);
    NZIS_ANSWER_VALUE_NOMEN_POS: NZIS_ANSWER_VALUE.PRecord.NOMEN_POS := StrToInt(AValue);
  end;
end;

procedure TNZIS_ANSWER_VALUEColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  NZIS_ANSWER_VALUE: TNZIS_ANSWER_VALUEItem;
begin
  if Count = 0 then Exit;

  NZIS_ANSWER_VALUE := Items[ARow];
  if not Assigned(NZIS_ANSWER_VALUE.PRecord) then
  begin
    New(NZIS_ANSWER_VALUE.PRecord);
    NZIS_ANSWER_VALUE.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TNZIS_ANSWER_VALUEItem.TPropertyIndex(ACol) of
      NZIS_ANSWER_VALUE_ANSWER_BOOLEAN: isOld :=  NZIS_ANSWER_VALUE.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AFieldText);
      NZIS_ANSWER_VALUE_ANSWER_CODE: isOld :=  NZIS_ANSWER_VALUE.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      NZIS_ANSWER_VALUE_ANSWER_DATE: isOld :=  NZIS_ANSWER_VALUE.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
      NZIS_ANSWER_VALUE_ANSWER_TEXT: isOld :=  NZIS_ANSWER_VALUE.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      NZIS_ANSWER_VALUE_CL028: isOld :=  NZIS_ANSWER_VALUE.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
      NZIS_ANSWER_VALUE_ID: isOld :=  NZIS_ANSWER_VALUE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
      NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: isOld :=  NZIS_ANSWER_VALUE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
      NZIS_ANSWER_VALUE_NOMEN_POS: isOld :=  NZIS_ANSWER_VALUE.getCardMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
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
    NZIS_ANSWER_VALUE_ANSWER_BOOLEAN: NZIS_ANSWER_VALUE.PRecord.ANSWER_BOOLEAN := StrToBool(AFieldText);
    NZIS_ANSWER_VALUE_ANSWER_CODE: NZIS_ANSWER_VALUE.PRecord.ANSWER_CODE := (AFieldText);
    NZIS_ANSWER_VALUE_ANSWER_DATE: NZIS_ANSWER_VALUE.PRecord.ANSWER_DATE := StrToDate(AFieldText);
    NZIS_ANSWER_VALUE_ANSWER_QUANTITY: NZIS_ANSWER_VALUE.PRecord.ANSWER_QUANTITY := StrToFloat(AFieldText);
    NZIS_ANSWER_VALUE_ANSWER_TEXT: NZIS_ANSWER_VALUE.PRecord.ANSWER_TEXT := AFieldText;
    NZIS_ANSWER_VALUE_CL028: NZIS_ANSWER_VALUE.PRecord.CL028 := StrToInt(AFieldText);
    NZIS_ANSWER_VALUE_ID: NZIS_ANSWER_VALUE.PRecord.ID := StrToInt(AFieldText);
    NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: NZIS_ANSWER_VALUE.PRecord.QUESTIONNAIRE_ANSWER_ID := StrToInt(AFieldText);
    NZIS_ANSWER_VALUE_NOMEN_POS: NZIS_ANSWER_VALUE.PRecord.NOMEN_POS := StrToInt(AFieldText);
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
      NZIS_ANSWER_VALUE_NOMEN_POS:
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
    NZIS_ANSWER_VALUE_ANSWER_TEXT: SortByIndexAnsiString;
      NZIS_ANSWER_VALUE_CL028: SortByIndexWord;
      NZIS_ANSWER_VALUE_ID: SortByIndexInt;
      NZIS_ANSWER_VALUE_QUESTIONNAIRE_ANSWER_ID: SortByIndexInt;
      NZIS_ANSWER_VALUE_NOMEN_POS: SortByIndexInt;
  end;
end;

end.