unit Table.NZIS_QUESTIONNAIRE_ANSWER;

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


TNZIS_QUESTIONNAIRE_ANSWERItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
  NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE
, NZIS_QUESTIONNAIRE_ANSWER_ID
, NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID
, NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS
);
	  
      TSetProp = set of TPropertyIndex;
      PRecNZIS_QUESTIONNAIRE_ANSWER = ^TRecNZIS_QUESTIONNAIRE_ANSWER;
      TRecNZIS_QUESTIONNAIRE_ANSWER = record
        CL134_QUESTION_CODE: AnsiString;
        ID: integer;
        QUESTIONNAIRE_RESPONSE_ID: integer;
        NOMEN_POS: Cardinal;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecNZIS_QUESTIONNAIRE_ANSWER;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertNZIS_QUESTIONNAIRE_ANSWER;
    procedure UpdateNZIS_QUESTIONNAIRE_ANSWER;
    procedure SaveNZIS_QUESTIONNAIRE_ANSWER(var dataPosition: Cardinal);
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TNZIS_QUESTIONNAIRE_ANSWERColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TNZIS_QUESTIONNAIRE_ANSWERItem;
    procedure SetItem(Index: Integer; const Value: TNZIS_QUESTIONNAIRE_ANSWERItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TNZIS_QUESTIONNAIRE_ANSWERItem;
	ListForFDB: TList<TNZIS_QUESTIONNAIRE_ANSWERItem>;
    ListNZIS_QUESTIONNAIRE_ANSWERSearch: TList<TNZIS_QUESTIONNAIRE_ANSWERItem>;
	PRecordSearch: ^TNZIS_QUESTIONNAIRE_ANSWERItem.TRecNZIS_QUESTIONNAIRE_ANSWER;
    ArrPropSearch: TArray<TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TNZIS_QUESTIONNAIRE_ANSWERItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; NZIS_QUESTIONNAIRE_ANSWER: TNZIS_QUESTIONNAIRE_ANSWERItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; NZIS_QUESTIONNAIRE_ANSWER: TNZIS_QUESTIONNAIRE_ANSWERItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TNZIS_QUESTIONNAIRE_ANSWERItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex);
    property Items[Index: Integer]: TNZIS_QUESTIONNAIRE_ANSWERItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
  end;

implementation

{ TNZIS_QUESTIONNAIRE_ANSWERItem }

constructor TNZIS_QUESTIONNAIRE_ANSWERItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TNZIS_QUESTIONNAIRE_ANSWERItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERItem.InsertNZIS_QUESTIONNAIRE_ANSWER;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctNZIS_QUESTIONNAIRE_ANSWER;
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
            NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE: SaveData(PRecord.CL134_QUESTION_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_ANSWER_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID: SaveData(PRecord.QUESTIONNAIRE_RESPONSE_ID, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS: SaveData(PRecord.NOMEN_POS, PropPosition, metaPosition, dataPosition);
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

function  TNZIS_QUESTIONNAIRE_ANSWERItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TNZIS_QUESTIONNAIRE_ANSWERItem;
begin
  Result := True;
  for i := 0 to Length(TNZIS_QUESTIONNAIRE_ANSWERColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TNZIS_QUESTIONNAIRE_ANSWERColl(coll).ArrPropSearchClc[i];
	ATempItem := TNZIS_QUESTIONNAIRE_ANSWERColl(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE: Result := IsFinded(ATempItem.PRecord.CL134_QUESTION_CODE, buf, FPosDataADB, word(NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE), cot);
        NZIS_QUESTIONNAIRE_ANSWER_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(NZIS_QUESTIONNAIRE_ANSWER_ID), cot);
        NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID: Result := IsFinded(ATempItem.PRecord.QUESTIONNAIRE_RESPONSE_ID, buf, FPosDataADB, word(NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID), cot);
        NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS: Result := IsFinded(ATempItem.PRecord.NOMEN_POS, buf, FPosDataADB, word(NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS), cot);
      end;
    end;
  end;
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERItem.SaveNZIS_QUESTIONNAIRE_ANSWER(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNZIS_QUESTIONNAIRE_ANSWER;
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
            NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE: SaveData(PRecord.CL134_QUESTION_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_ANSWER_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID: SaveData(PRecord.QUESTIONNAIRE_RESPONSE_ID, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS: SaveData(PRecord.NOMEN_POS, PropPosition, metaPosition, dataPosition);
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

procedure TNZIS_QUESTIONNAIRE_ANSWERItem.UpdateNZIS_QUESTIONNAIRE_ANSWER;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNZIS_QUESTIONNAIRE_ANSWER;
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
            NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE: UpdateData(PRecord.CL134_QUESTION_CODE, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_ANSWER_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID: UpdateData(PRecord.QUESTIONNAIRE_RESPONSE_ID, PropPosition, metaPosition, dataPosition);
            NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS: UpdateData(PRecord.NOMEN_POS, PropPosition, metaPosition, dataPosition);
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

{ TNZIS_QUESTIONNAIRE_ANSWERColl }

function TNZIS_QUESTIONNAIRE_ANSWERColl.AddItem(ver: word): TNZIS_QUESTIONNAIRE_ANSWERItem;
begin
  Result := TNZIS_QUESTIONNAIRE_ANSWERItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TNZIS_QUESTIONNAIRE_ANSWERColl.AddItemForSearch: Integer;
var
  ItemForSearch: TNZIS_QUESTIONNAIRE_ANSWERItem;
begin
  ItemForSearch := TNZIS_QUESTIONNAIRE_ANSWERItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TNZIS_QUESTIONNAIRE_ANSWERColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TNZIS_QUESTIONNAIRE_ANSWERItem.Create(nil);
  ListNZIS_QUESTIONNAIRE_ANSWERSearch := TList<TNZIS_QUESTIONNAIRE_ANSWERItem>.Create;
  ListForFDB := TList<TNZIS_QUESTIONNAIRE_ANSWERItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TNZIS_QUESTIONNAIRE_ANSWERColl.destroy;
begin
  FreeAndNil(ListNZIS_QUESTIONNAIRE_ANSWERSearch);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TNZIS_QUESTIONNAIRE_ANSWERColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(propIndex) of
    NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE: Result := 'CL134_QUESTION_CODE';
    NZIS_QUESTIONNAIRE_ANSWER_ID: Result := 'ID';
    NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID: Result := 'QUESTIONNAIRE_RESPONSE_ID';
    NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS: Result := 'NOMEN_POS';
  end;
end;

function TNZIS_QUESTIONNAIRE_ANSWERColl.FieldCount: Integer;
begin
  inherited;
  Result := 4;
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NZIS_QUESTIONNAIRE_ANSWER: TNZIS_QUESTIONNAIRE_ANSWERItem;
  ACol: Integer;
  prop: TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NZIS_QUESTIONNAIRE_ANSWER := Items[ARow];
  prop := TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(ACol);
  if Assigned(NZIS_QUESTIONNAIRE_ANSWER.PRecord) and (prop in NZIS_QUESTIONNAIRE_ANSWER.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_QUESTIONNAIRE_ANSWER, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_QUESTIONNAIRE_ANSWER, AValue);
  end;
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := ListDataPos[ARow].DataPos;
  prop := TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.GetCellFromRecord(propIndex: word; NZIS_QUESTIONNAIRE_ANSWER: TNZIS_QUESTIONNAIRE_ANSWERItem; var AValue: String);
var
  str: string;
begin
  case TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(propIndex) of
    NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE: str := (NZIS_QUESTIONNAIRE_ANSWER.PRecord.CL134_QUESTION_CODE);
    NZIS_QUESTIONNAIRE_ANSWER_ID: str := inttostr(NZIS_QUESTIONNAIRE_ANSWER.PRecord.ID);
    NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID: str := inttostr(NZIS_QUESTIONNAIRE_ANSWER.PRecord.QUESTIONNAIRE_RESPONSE_ID);
    NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS: str := inttostr(NZIS_QUESTIONNAIRE_ANSWER.PRecord.NOMEN_POS);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TNZIS_QUESTIONNAIRE_ANSWERItem;
  ACol: Integer;
  prop: TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NZIS_QUESTIONNAIRE_ANSWER: TNZIS_QUESTIONNAIRE_ANSWERItem;
  ACol: Integer;
  prop: TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NZIS_QUESTIONNAIRE_ANSWER := ListNZIS_QUESTIONNAIRE_ANSWERSearch[ARow];
  prop := TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(ACol);
  if Assigned(NZIS_QUESTIONNAIRE_ANSWER.PRecord) and (prop in NZIS_QUESTIONNAIRE_ANSWER.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_QUESTIONNAIRE_ANSWER, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_QUESTIONNAIRE_ANSWER, AValue);
  end;
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  NZIS_QUESTIONNAIRE_ANSWER: TNZIS_QUESTIONNAIRE_ANSWERItem;
  prop: TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  NZIS_QUESTIONNAIRE_ANSWER := Items[ARow];
  prop := TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(ACol);
  if Assigned(NZIS_QUESTIONNAIRE_ANSWER.PRecord) and (prop in NZIS_QUESTIONNAIRE_ANSWER.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_QUESTIONNAIRE_ANSWER, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_QUESTIONNAIRE_ANSWER, AFieldText);
  end;
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.GetCellFromMap(propIndex: word; ARow: Integer; NZIS_QUESTIONNAIRE_ANSWER: TNZIS_QUESTIONNAIRE_ANSWERItem; var AValue: String);
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
  case TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(propIndex) of
    NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE: str :=  NZIS_QUESTIONNAIRE_ANSWER.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NZIS_QUESTIONNAIRE_ANSWER_ID: str :=  inttostr(NZIS_QUESTIONNAIRE_ANSWER.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID: str :=  inttostr(NZIS_QUESTIONNAIRE_ANSWER.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS: str :=  inttostr(NZIS_QUESTIONNAIRE_ANSWER.getCardMap(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TNZIS_QUESTIONNAIRE_ANSWERColl.GetItem(Index: Integer): TNZIS_QUESTIONNAIRE_ANSWERItem;
begin
  Result := TNZIS_QUESTIONNAIRE_ANSWERItem(inherited GetItem(Index));
end;


procedure TNZIS_QUESTIONNAIRE_ANSWERColl.IndexValue(propIndex: TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TNZIS_QUESTIONNAIRE_ANSWERItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      NZIS_QUESTIONNAIRE_ANSWER_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS: TempItem.IndexInt :=  TempItem.getPCardMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.IndexValueListNodes(propIndex: TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex);
begin

end;

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TNZIS_QUESTIONNAIRE_ANSWERItem;
begin
  if index < 0 then
  begin
    Tempitem := TNZIS_QUESTIONNAIRE_ANSWERItem.Create(nil);
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



function TNZIS_QUESTIONNAIRE_ANSWERColl.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(propIndex) of
    NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE: Result := actAnsiString;
    NZIS_QUESTIONNAIRE_ANSWER_ID: Result := actinteger;
    NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID: Result := actinteger;
    NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS: Result := actCardinal;
  else
    Result := actNone;
  end
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  NZIS_QUESTIONNAIRE_ANSWER: TNZIS_QUESTIONNAIRE_ANSWERItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  NZIS_QUESTIONNAIRE_ANSWER := Items[ARow];
  if not Assigned(NZIS_QUESTIONNAIRE_ANSWER.PRecord) then
  begin
    New(NZIS_QUESTIONNAIRE_ANSWER.PRecord);
    NZIS_QUESTIONNAIRE_ANSWER.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(ACol) of
      NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE: isOld :=  NZIS_QUESTIONNAIRE_ANSWER.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      NZIS_QUESTIONNAIRE_ANSWER_ID: isOld :=  NZIS_QUESTIONNAIRE_ANSWER.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID: isOld :=  NZIS_QUESTIONNAIRE_ANSWER.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS: isOld :=  NZIS_QUESTIONNAIRE_ANSWER.getCardMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(NZIS_QUESTIONNAIRE_ANSWER.PRecord.setProp, TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(ACol));
    if NZIS_QUESTIONNAIRE_ANSWER.PRecord.setProp = [] then
    begin
      Dispose(NZIS_QUESTIONNAIRE_ANSWER.PRecord);
      NZIS_QUESTIONNAIRE_ANSWER.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NZIS_QUESTIONNAIRE_ANSWER.PRecord.setProp, TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(ACol));
  case TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(ACol) of
    NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE: NZIS_QUESTIONNAIRE_ANSWER.PRecord.CL134_QUESTION_CODE := AValue;
    NZIS_QUESTIONNAIRE_ANSWER_ID: NZIS_QUESTIONNAIRE_ANSWER.PRecord.ID := StrToInt(AValue);
    NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID: NZIS_QUESTIONNAIRE_ANSWER.PRecord.QUESTIONNAIRE_RESPONSE_ID := StrToInt(AValue);
    NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS: NZIS_QUESTIONNAIRE_ANSWER.PRecord.NOMEN_POS := StrToInt(AValue);
  end;
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  NZIS_QUESTIONNAIRE_ANSWER: TNZIS_QUESTIONNAIRE_ANSWERItem;
begin
  if Count = 0 then Exit;

  NZIS_QUESTIONNAIRE_ANSWER := Items[ARow];
  if not Assigned(NZIS_QUESTIONNAIRE_ANSWER.PRecord) then
  begin
    New(NZIS_QUESTIONNAIRE_ANSWER.PRecord);
    NZIS_QUESTIONNAIRE_ANSWER.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(ACol) of
      NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE: isOld :=  NZIS_QUESTIONNAIRE_ANSWER.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      NZIS_QUESTIONNAIRE_ANSWER_ID: isOld :=  NZIS_QUESTIONNAIRE_ANSWER.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
      NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID: isOld :=  NZIS_QUESTIONNAIRE_ANSWER.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
      NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS: isOld :=  NZIS_QUESTIONNAIRE_ANSWER.getCardMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(NZIS_QUESTIONNAIRE_ANSWER.PRecord.setProp, TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(ACol));
    if NZIS_QUESTIONNAIRE_ANSWER.PRecord.setProp = [] then
    begin
      Dispose(NZIS_QUESTIONNAIRE_ANSWER.PRecord);
      NZIS_QUESTIONNAIRE_ANSWER.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NZIS_QUESTIONNAIRE_ANSWER.PRecord.setProp, TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(ACol));
  case TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(ACol) of
    NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE: NZIS_QUESTIONNAIRE_ANSWER.PRecord.CL134_QUESTION_CODE := AFieldText;
    NZIS_QUESTIONNAIRE_ANSWER_ID: NZIS_QUESTIONNAIRE_ANSWER.PRecord.ID := StrToInt(AFieldText);
    NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID: NZIS_QUESTIONNAIRE_ANSWER.PRecord.QUESTIONNAIRE_RESPONSE_ID := StrToInt(AFieldText);
    NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS: NZIS_QUESTIONNAIRE_ANSWER.PRecord.NOMEN_POS := StrToInt(AFieldText);
  end;
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.SetItem(Index: Integer; const Value: TNZIS_QUESTIONNAIRE_ANSWERItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListNZIS_QUESTIONNAIRE_ANSWERSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex(self.FindedRes.PropIndex) of
      NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNZIS_QUESTIONNAIRE_ANSWERSearch.Add(self.Items[i]);
        end;
      end;
      NZIS_QUESTIONNAIRE_ANSWER_ID:
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_QUESTIONNAIRE_ANSWERSearch.Add(self.Items[i]);
        end;
      end;
      NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_QUESTIONNAIRE_ANSWERSearch.Add(self.Items[i]);
        end;
      end;
      NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS:
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_QUESTIONNAIRE_ANSWERSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.ShowGrid(Grid: TTeeGrid);
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

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TNZIS_QUESTIONNAIRE_ANSWERItem>);
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

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListNZIS_QUESTIONNAIRE_ANSWERSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListNZIS_QUESTIONNAIRE_ANSWERSearch.Count]);

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

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.SortByIndexAnsiString;
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

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.SortByIndexInt;
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

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.SortByIndexWord;
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

procedure TNZIS_QUESTIONNAIRE_ANSWERColl.SortByIndexValue(propIndex: TNZIS_QUESTIONNAIRE_ANSWERItem.TPropertyIndex);
begin
  case propIndex of
    NZIS_QUESTIONNAIRE_ANSWER_CL134_QUESTION_CODE: SortByIndexAnsiString;
    NZIS_QUESTIONNAIRE_ANSWER_ID: SortByIndexInt;
    NZIS_QUESTIONNAIRE_ANSWER_QUESTIONNAIRE_RESPONSE_ID: SortByIndexInt;
    NZIS_QUESTIONNAIRE_ANSWER_NOMEN_POS: SortByIndexInt;
  end;
end;

end.