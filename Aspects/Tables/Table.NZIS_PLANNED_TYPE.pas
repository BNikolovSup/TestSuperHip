unit Table.NZIS_PLANNED_TYPE;

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


TNZIS_PLANNED_TYPEItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
  NZIS_PLANNED_TYPE_CL132_KEY
, NZIS_PLANNED_TYPE_ID
, NZIS_PLANNED_TYPE_PREGLED_ID
, NZIS_PLANNED_TYPE_StartDate
, NZIS_PLANNED_TYPE_EndDate
, NZIS_PLANNED_TYPE_CL132_DataPos
, NZIS_PLANNED_TYPE_NumberRep
);

      TSetProp = set of TPropertyIndex;
      PRecNZIS_PLANNED_TYPE = ^TRecNZIS_PLANNED_TYPE;
      TRecNZIS_PLANNED_TYPE = record
        CL132_KEY: AnsiString;
        ID: integer;
        PREGLED_ID: integer;
        StartDate: TDate;
        EndDate: TDate;
        CL132_DataPos: cardinal;
        NumberRep: Integer;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecNZIS_PLANNED_TYPE;
    IndexInt: Integer;
    IndexWord: Word;
    IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertNZIS_PLANNED_TYPE;
    procedure UpdateNZIS_PLANNED_TYPE;
    procedure SaveNZIS_PLANNED_TYPE(var dataPosition: Cardinal);
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TNZIS_PLANNED_TYPEColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TNZIS_PLANNED_TYPEItem;
    procedure SetItem(Index: Integer; const Value: TNZIS_PLANNED_TYPEItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TNZIS_PLANNED_TYPEItem;
	ListForFDB: TList<TNZIS_PLANNED_TYPEItem>;
    ListNZIS_PLANNED_TYPESearch: TList<TNZIS_PLANNED_TYPEItem>;
	PRecordSearch: ^TNZIS_PLANNED_TYPEItem.TRecNZIS_PLANNED_TYPE;
    ArrPropSearch: TArray<TNZIS_PLANNED_TYPEItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TNZIS_PLANNED_TYPEItem.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TNZIS_PLANNED_TYPEItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TNZIS_PLANNED_TYPEItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TNZIS_PLANNED_TYPEItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TNZIS_PLANNED_TYPEItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TNZIS_PLANNED_TYPEItem.TPropertyIndex);
    property Items[Index: Integer]: TNZIS_PLANNED_TYPEItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);

  end;

implementation

{ TNZIS_PLANNED_TYPEItem }

constructor TNZIS_PLANNED_TYPEItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TNZIS_PLANNED_TYPEItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TNZIS_PLANNED_TYPEItem.InsertNZIS_PLANNED_TYPE;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctNZIS_PLANNED_TYPE;
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
            NZIS_PLANNED_TYPE_CL132_KEY: SaveData(PRecord.CL132_KEY, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_PREGLED_ID: SaveData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_StartDate: SaveData(PRecord.StartDate, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_EndDate: SaveData(PRecord.EndDate, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_CL132_DataPos: SaveData(PRecord.CL132_DataPos, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_NumberRep: SaveData(PRecord.NumberRep, PropPosition, metaPosition, dataPosition);
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

function  TNZIS_PLANNED_TYPEItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TNZIS_PLANNED_TYPEItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TNZIS_PLANNED_TYPEItem;
begin
  Result := True;
  for i := 0 to Length(TNZIS_PLANNED_TYPEColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TNZIS_PLANNED_TYPEColl(coll).ArrPropSearchClc[i];
	ATempItem := TNZIS_PLANNED_TYPEColl(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        NZIS_PLANNED_TYPE_CL132_KEY: Result := IsFinded(ATempItem.PRecord.CL132_KEY, buf, FPosDataADB, word(NZIS_PLANNED_TYPE_CL132_KEY), cot);
        NZIS_PLANNED_TYPE_ID: Result := IsFinded(ATempItem.PRecord.ID, buf, FPosDataADB, word(NZIS_PLANNED_TYPE_ID), cot);
        NZIS_PLANNED_TYPE_PREGLED_ID: Result := IsFinded(ATempItem.PRecord.PREGLED_ID, buf, FPosDataADB, word(NZIS_PLANNED_TYPE_PREGLED_ID), cot);
        NZIS_PLANNED_TYPE_StartDate: Result := IsFinded(ATempItem.PRecord.StartDate, buf, FPosDataADB, word(NZIS_PLANNED_TYPE_StartDate), cot);
        NZIS_PLANNED_TYPE_EndDate: Result := IsFinded(ATempItem.PRecord.EndDate, buf, FPosDataADB, word(NZIS_PLANNED_TYPE_EndDate), cot);
        NZIS_PLANNED_TYPE_CL132_DataPos: Result := IsFinded(ATempItem.PRecord.CL132_DataPos, buf, FPosDataADB, word(NZIS_PLANNED_TYPE_CL132_DataPos), cot);
        NZIS_PLANNED_TYPE_NumberRep: Result := IsFinded(ATempItem.PRecord.NumberRep, buf, FPosDataADB, word(NZIS_PLANNED_TYPE_NumberRep), cot);
      end;
    end;
  end;
end;

procedure TNZIS_PLANNED_TYPEItem.SaveNZIS_PLANNED_TYPE(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNZIS_PLANNED_TYPE;
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
            NZIS_PLANNED_TYPE_CL132_KEY: SaveData(PRecord.CL132_KEY, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_PREGLED_ID: SaveData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_StartDate: SaveData(PRecord.StartDate, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_EndDate: SaveData(PRecord.EndDate, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_CL132_DataPos: SaveData(PRecord.CL132_DataPos, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_NumberRep: SaveData(PRecord.NumberRep, PropPosition, metaPosition, dataPosition);
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

procedure TNZIS_PLANNED_TYPEItem.UpdateNZIS_PLANNED_TYPE;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNZIS_PLANNED_TYPE;
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
            NZIS_PLANNED_TYPE_CL132_KEY: UpdateData(PRecord.CL132_KEY, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_PREGLED_ID: UpdateData(PRecord.PREGLED_ID, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_StartDate: UpdateData(PRecord.StartDate, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_EndDate: UpdateData(PRecord.EndDate, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_CL132_DataPos: UpdateData(PRecord.CL132_DataPos, PropPosition, metaPosition, dataPosition);
            NZIS_PLANNED_TYPE_NumberRep: UpdateData(PRecord.NumberRep, PropPosition, metaPosition, dataPosition);
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

{ TNZIS_PLANNED_TYPEColl }

function TNZIS_PLANNED_TYPEColl.AddItem(ver: word): TNZIS_PLANNED_TYPEItem;
begin
  Result := TNZIS_PLANNED_TYPEItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TNZIS_PLANNED_TYPEColl.AddItemForSearch: Integer;
var
  ItemForSearch: TNZIS_PLANNED_TYPEItem;
begin
  ItemForSearch := TNZIS_PLANNED_TYPEItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TNZIS_PLANNED_TYPEColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TNZIS_PLANNED_TYPEItem.Create(nil);
  ListNZIS_PLANNED_TYPESearch := TList<TNZIS_PLANNED_TYPEItem>.Create;
  ListForFDB := TList<TNZIS_PLANNED_TYPEItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TNZIS_PLANNED_TYPEColl.destroy;
begin
  FreeAndNil(ListNZIS_PLANNED_TYPESearch);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TNZIS_PLANNED_TYPEColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(propIndex) of
    NZIS_PLANNED_TYPE_CL132_KEY: Result := 'CL132_KEY';
    NZIS_PLANNED_TYPE_ID: Result := 'ID';
    NZIS_PLANNED_TYPE_PREGLED_ID: Result := 'PREGLED_ID';
    NZIS_PLANNED_TYPE_StartDate: Result := 'StartDate';
    NZIS_PLANNED_TYPE_EndDate: Result := 'EndDate';
    NZIS_PLANNED_TYPE_CL132_DataPos: Result := 'CL132_DataPos';
    NZIS_PLANNED_TYPE_NumberRep: Result := 'NumberRep';
  end;
end;

function TNZIS_PLANNED_TYPEColl.FieldCount: Integer;
begin
  inherited;
  Result := 6;
end;

procedure TNZIS_PLANNED_TYPEColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem;
  ACol: Integer;
  prop: TNZIS_PLANNED_TYPEItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NZIS_PLANNED_TYPE := Items[ARow];
  prop := TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol);
  if Assigned(NZIS_PLANNED_TYPE.PRecord) and (prop in NZIS_PLANNED_TYPE.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_PLANNED_TYPE, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_PLANNED_TYPE, AValue);
  end;
end;

procedure TNZIS_PLANNED_TYPEColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TNZIS_PLANNED_TYPEItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := ListDataPos[ARow].DataPos;
  prop := TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TNZIS_PLANNED_TYPEColl.GetCellFromRecord(propIndex: word; NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem; var AValue: String);
var
  str: string;
begin
  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(propIndex) of
    NZIS_PLANNED_TYPE_CL132_KEY: str := (NZIS_PLANNED_TYPE.PRecord.CL132_KEY);
    NZIS_PLANNED_TYPE_ID: str := inttostr(NZIS_PLANNED_TYPE.PRecord.ID);
    NZIS_PLANNED_TYPE_PREGLED_ID: str := inttostr(NZIS_PLANNED_TYPE.PRecord.PREGLED_ID);
    NZIS_PLANNED_TYPE_StartDate: str := DateToStr(NZIS_PLANNED_TYPE.PRecord.StartDate);
    NZIS_PLANNED_TYPE_EndDate: str := DateToStr(NZIS_PLANNED_TYPE.PRecord.EndDate);
    NZIS_PLANNED_TYPE_CL132_DataPos: str := IntToStr(NZIS_PLANNED_TYPE.PRecord.CL132_DataPos);
    NZIS_PLANNED_TYPE_NumberRep: str := inttostr(NZIS_PLANNED_TYPE.PRecord.NumberRep);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TNZIS_PLANNED_TYPEColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TNZIS_PLANNED_TYPEItem;
  ACol: Integer;
  prop: TNZIS_PLANNED_TYPEItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TNZIS_PLANNED_TYPEColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TNZIS_PLANNED_TYPEItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TNZIS_PLANNED_TYPEColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem;
  ACol: Integer;
  prop: TNZIS_PLANNED_TYPEItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NZIS_PLANNED_TYPE := ListNZIS_PLANNED_TYPESearch[ARow];
  prop := TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol);
  if Assigned(NZIS_PLANNED_TYPE.PRecord) and (prop in NZIS_PLANNED_TYPE.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_PLANNED_TYPE, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_PLANNED_TYPE, AValue);
  end;
end;

procedure TNZIS_PLANNED_TYPEColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem;
  prop: TNZIS_PLANNED_TYPEItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  NZIS_PLANNED_TYPE := Items[ARow];
  prop := TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol);
  if Assigned(NZIS_PLANNED_TYPE.PRecord) and (prop in NZIS_PLANNED_TYPE.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NZIS_PLANNED_TYPE, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NZIS_PLANNED_TYPE, AFieldText);
  end;
end;

procedure TNZIS_PLANNED_TYPEColl.GetCellFromMap(propIndex: word; ARow: Integer; NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem; var AValue: String);
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
  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(propIndex) of
    NZIS_PLANNED_TYPE_CL132_KEY: str :=  NZIS_PLANNED_TYPE.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NZIS_PLANNED_TYPE_ID: str :=  inttostr(NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_PLANNED_TYPE_PREGLED_ID: str :=  inttostr(NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, propIndex));
    NZIS_PLANNED_TYPE_StartDate: str :=  DateToStr(NZIS_PLANNED_TYPE.getDateMap(Self.Buf, Self.posData, propIndex));
    NZIS_PLANNED_TYPE_EndDate: str :=  DateToStr(NZIS_PLANNED_TYPE.getDateMap(Self.Buf, Self.posData, propIndex));
    NZIS_PLANNED_TYPE_CL132_DataPos: str :=  IntToStr(NZIS_PLANNED_TYPE.getCardMap(Self.Buf, Self.posData, propIndex));
    NZIS_PLANNED_TYPE_NumberRep: str :=  IntToStr(NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TNZIS_PLANNED_TYPEColl.GetItem(Index: Integer): TNZIS_PLANNED_TYPEItem;
begin
  Result := TNZIS_PLANNED_TYPEItem(inherited GetItem(Index));
end;


procedure TNZIS_PLANNED_TYPEColl.IndexValue(propIndex: TNZIS_PLANNED_TYPEItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TNZIS_PLANNED_TYPEItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      NZIS_PLANNED_TYPE_CL132_KEY:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      NZIS_PLANNED_TYPE_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      NZIS_PLANNED_TYPE_PREGLED_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      NZIS_PLANNED_TYPE_NumberRep: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;


     // NZIS_PLANNED_TYPE_StartDate: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
//      NZIS_PLANNED_TYPE_EndDate: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TNZIS_PLANNED_TYPEColl.IndexValueListNodes(propIndex: TNZIS_PLANNED_TYPEItem.TPropertyIndex);
begin

end;

procedure TNZIS_PLANNED_TYPEColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TNZIS_PLANNED_TYPEItem;
begin
  if index < 0 then
  begin
    Tempitem := TNZIS_PLANNED_TYPEItem.Create(nil);
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



function TNZIS_PLANNED_TYPEColl.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(propIndex) of
    NZIS_PLANNED_TYPE_CL132_KEY: Result := actAnsiString;
    NZIS_PLANNED_TYPE_ID: Result := actinteger;
    NZIS_PLANNED_TYPE_PREGLED_ID: Result := actinteger;
    NZIS_PLANNED_TYPE_StartDate: Result := actTDate;
    NZIS_PLANNED_TYPE_EndDate: Result := actTDate;
    NZIS_PLANNED_TYPE_CL132_DataPos: Result := actCardinal;
    NZIS_PLANNED_TYPE_NumberRep: Result := actinteger;
  else
    Result := actNone;
  end
end;

procedure TNZIS_PLANNED_TYPEColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  NZIS_PLANNED_TYPE := Items[ARow];
  if not Assigned(NZIS_PLANNED_TYPE.PRecord) then
  begin
    New(NZIS_PLANNED_TYPE.PRecord);
    NZIS_PLANNED_TYPE.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol) of
      NZIS_PLANNED_TYPE_CL132_KEY: isOld :=  NZIS_PLANNED_TYPE.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      NZIS_PLANNED_TYPE_ID: isOld :=  NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      NZIS_PLANNED_TYPE_PREGLED_ID: isOld :=  NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      NZIS_PLANNED_TYPE_StartDate: isOld :=  NZIS_PLANNED_TYPE.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
      NZIS_PLANNED_TYPE_EndDate: isOld :=  NZIS_PLANNED_TYPE.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
      NZIS_PLANNED_TYPE_CL132_DataPos: isOld :=  NZIS_PLANNED_TYPE.getCardMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
      NZIS_PLANNED_TYPE_NumberRep: isOld :=  NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(NZIS_PLANNED_TYPE.PRecord.setProp, TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol));
    if NZIS_PLANNED_TYPE.PRecord.setProp = [] then
    begin
      Dispose(NZIS_PLANNED_TYPE.PRecord);
      NZIS_PLANNED_TYPE.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NZIS_PLANNED_TYPE.PRecord.setProp, TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol));
  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol) of
    NZIS_PLANNED_TYPE_CL132_KEY: NZIS_PLANNED_TYPE.PRecord.CL132_KEY := AValue;
    NZIS_PLANNED_TYPE_ID: NZIS_PLANNED_TYPE.PRecord.ID := StrToInt(AValue);
    NZIS_PLANNED_TYPE_PREGLED_ID: NZIS_PLANNED_TYPE.PRecord.PREGLED_ID := StrToInt(AValue);
    NZIS_PLANNED_TYPE_StartDate: NZIS_PLANNED_TYPE.PRecord.StartDate := StrToDate(AValue);
    NZIS_PLANNED_TYPE_EndDate: NZIS_PLANNED_TYPE.PRecord.EndDate := StrToDate(AValue);
    NZIS_PLANNED_TYPE_CL132_DataPos: NZIS_PLANNED_TYPE.PRecord.CL132_DataPos := StrToInt(AValue);
    NZIS_PLANNED_TYPE_NumberRep: NZIS_PLANNED_TYPE.PRecord.NumberRep := StrToInt(AValue);
  end;
end;

procedure TNZIS_PLANNED_TYPEColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  NZIS_PLANNED_TYPE: TNZIS_PLANNED_TYPEItem;
begin
  if Count = 0 then Exit;

  NZIS_PLANNED_TYPE := Items[ARow];
  if not Assigned(NZIS_PLANNED_TYPE.PRecord) then
  begin
    New(NZIS_PLANNED_TYPE.PRecord);
    NZIS_PLANNED_TYPE.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol) of
      NZIS_PLANNED_TYPE_CL132_KEY: isOld :=  NZIS_PLANNED_TYPE.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      NZIS_PLANNED_TYPE_ID: isOld :=  NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
      NZIS_PLANNED_TYPE_PREGLED_ID: isOld :=  NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
      NZIS_PLANNED_TYPE_StartDate: isOld :=  NZIS_PLANNED_TYPE.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
      NZIS_PLANNED_TYPE_EndDate: isOld :=  NZIS_PLANNED_TYPE.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
      NZIS_PLANNED_TYPE_CL132_DataPos: isOld :=  NZIS_PLANNED_TYPE.getDateMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
      NZIS_PLANNED_TYPE_NumberRep: isOld :=  NZIS_PLANNED_TYPE.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(NZIS_PLANNED_TYPE.PRecord.setProp, TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol));
    if NZIS_PLANNED_TYPE.PRecord.setProp = [] then
    begin
      Dispose(NZIS_PLANNED_TYPE.PRecord);
      NZIS_PLANNED_TYPE.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NZIS_PLANNED_TYPE.PRecord.setProp, TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol));
  case TNZIS_PLANNED_TYPEItem.TPropertyIndex(ACol) of
    NZIS_PLANNED_TYPE_CL132_KEY: NZIS_PLANNED_TYPE.PRecord.CL132_KEY := AFieldText;
    NZIS_PLANNED_TYPE_ID: NZIS_PLANNED_TYPE.PRecord.ID := StrToInt(AFieldText);
    NZIS_PLANNED_TYPE_PREGLED_ID: NZIS_PLANNED_TYPE.PRecord.PREGLED_ID := StrToInt(AFieldText);
    NZIS_PLANNED_TYPE_StartDate: NZIS_PLANNED_TYPE.PRecord.StartDate := StrToDate(AFieldText);
    NZIS_PLANNED_TYPE_EndDate: NZIS_PLANNED_TYPE.PRecord.EndDate := StrToDate(AFieldText);
    NZIS_PLANNED_TYPE_CL132_DataPos: NZIS_PLANNED_TYPE.PRecord.CL132_DataPos := StrToInt(AFieldText);
    NZIS_PLANNED_TYPE_NumberRep: NZIS_PLANNED_TYPE.PRecord.NumberRep := StrToInt(AFieldText);
  end;
end;

procedure TNZIS_PLANNED_TYPEColl.SetItem(Index: Integer; const Value: TNZIS_PLANNED_TYPEItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TNZIS_PLANNED_TYPEColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListNZIS_PLANNED_TYPESearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TNZIS_PLANNED_TYPEItem.TPropertyIndex(self.FindedRes.PropIndex) of
	    NZIS_PLANNED_TYPE_CL132_KEY:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNZIS_PLANNED_TYPESearch.Add(self.Items[i]);
        end;
      end;
      NZIS_PLANNED_TYPE_ID:
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_PLANNED_TYPESearch.Add(self.Items[i]);
        end;
      end;
      NZIS_PLANNED_TYPE_PREGLED_ID:
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_PLANNED_TYPESearch.Add(self.Items[i]);
        end;
      end;
      NZIS_PLANNED_TYPE_StartDate:
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_PLANNED_TYPESearch.Add(self.Items[i]);
        end;
      end;
      NZIS_PLANNED_TYPE_EndDate:
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_PLANNED_TYPESearch.Add(self.Items[i]);
        end;
      end;
      NZIS_PLANNED_TYPE_CL132_DataPos:
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_PLANNED_TYPESearch.Add(self.Items[i]);
        end;
      end;
      NZIS_PLANNED_TYPE_NumberRep:
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListNZIS_PLANNED_TYPESearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TNZIS_PLANNED_TYPEColl.ShowGrid(Grid: TTeeGrid);
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

procedure TNZIS_PLANNED_TYPEColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TNZIS_PLANNED_TYPEItem>);
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

procedure TNZIS_PLANNED_TYPEColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListNZIS_PLANNED_TYPESearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListNZIS_PLANNED_TYPESearch.Count]);

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

procedure TNZIS_PLANNED_TYPEColl.SortByIndexAnsiString;
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

procedure TNZIS_PLANNED_TYPEColl.SortByIndexInt;
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

procedure TNZIS_PLANNED_TYPEColl.SortByIndexWord;
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

procedure TNZIS_PLANNED_TYPEColl.SortByIndexValue(propIndex: TNZIS_PLANNED_TYPEItem.TPropertyIndex);
begin
  case propIndex of
    NZIS_PLANNED_TYPE_CL132_KEY: SortByIndexAnsiString;
    NZIS_PLANNED_TYPE_ID: SortByIndexInt;
    NZIS_PLANNED_TYPE_PREGLED_ID: SortByIndexInt;
    NZIS_PLANNED_TYPE_StartDate: SortByIndexInt;
    NZIS_PLANNED_TYPE_EndDate: SortByIndexInt;
    NZIS_PLANNED_TYPE_CL132_DataPos: SortByIndexInt;
    NZIS_PLANNED_TYPE_NumberRep: SortByIndexInt;
  end;
end;

end.