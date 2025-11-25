unit Table.NzisToken;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control, DateUtils ;

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


TNzisTokenItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
NzisToken_Bearer
, NzisToken_fromDatTime
, NzisToken_ToDatTime
, NzisToken_CertID
);
	  
      TSetProp = set of TPropertyIndex;
      PRecNzisToken = ^TRecNzisToken;
      TRecNzisToken = record
        Bearer: AnsiString;
        fromDatTime: TDateTime;
        ToDatTime: TDateTime;
        CertID: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecNzisToken;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertNzisToken;
    procedure UpdateNzisToken;
    procedure SaveNzisToken(var dataPosition: Cardinal);
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
  end;


  TNzisTokenColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TNzisTokenItem;
    procedure SetItem(Index: Integer; const Value: TNzisTokenItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TNzisTokenItem;
	ListForFDB: TList<TNzisTokenItem>;
    ListNzisTokenSearch: TList<TNzisTokenItem>;
	PRecordSearch: ^TNzisTokenItem.TRecNzisToken;
    ArrPropSearch: TArray<TNzisTokenItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TNzisTokenItem.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TNzisTokenItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; NzisToken: TNzisTokenItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; NzisToken: TNzisTokenItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TNzisTokenItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TNzisTokenItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TNzisTokenItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TNzisTokenItem.TPropertyIndex);
    property Items[Index: Integer]: TNzisTokenItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
  end;

implementation

{ TNzisTokenItem }

constructor TNzisTokenItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TNzisTokenItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TNzisTokenItem.InsertNzisToken;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctNzisToken;
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
            NzisToken_Bearer: SaveData(PRecord.Bearer, PropPosition, metaPosition, dataPosition);
            NzisToken_fromDatTime: SaveData(PRecord.fromDatTime, PropPosition, metaPosition, dataPosition);
            NzisToken_ToDatTime: SaveData(PRecord.ToDatTime, PropPosition, metaPosition, dataPosition);
            NzisToken_CertID: SaveData(PRecord.CertID, PropPosition, metaPosition, dataPosition);
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

function  TNzisTokenItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TNzisTokenItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TNzisTokenItem;
begin
  Result := True;
  for i := 0 to Length(TNzisTokenColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TNzisTokenColl(coll).ArrPropSearchClc[i];
	ATempItem := TNzisTokenColl(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        NzisToken_Bearer: Result := IsFinded(ATempItem.PRecord.Bearer, buf, FPosDataADB, word(NzisToken_Bearer), cot);
            NzisToken_fromDatTime: Result := IsFinded(ATempItem.PRecord.fromDatTime, buf, FPosDataADB, word(NzisToken_fromDatTime), cot);
            NzisToken_ToDatTime: Result := IsFinded(ATempItem.PRecord.ToDatTime, buf, FPosDataADB, word(NzisToken_ToDatTime), cot);
            NzisToken_CertID: Result := IsFinded(ATempItem.PRecord.CertID, buf, FPosDataADB, word(NzisToken_CertID), cot);
      end;
    end;
  end;
end;

procedure TNzisTokenItem.SaveNzisToken(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNzisToken;
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
            NzisToken_Bearer: SaveData(PRecord.Bearer, PropPosition, metaPosition, dataPosition);
            NzisToken_fromDatTime: SaveData(PRecord.fromDatTime, PropPosition, metaPosition, dataPosition);
            NzisToken_ToDatTime: SaveData(PRecord.ToDatTime, PropPosition, metaPosition, dataPosition);
            NzisToken_CertID: SaveData(PRecord.CertID, PropPosition, metaPosition, dataPosition);
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

procedure TNzisTokenItem.UpdateNzisToken;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNzisToken;
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
            NzisToken_Bearer: UpdateData(PRecord.Bearer, PropPosition, metaPosition, dataPosition);
            NzisToken_fromDatTime: UpdateData(PRecord.fromDatTime, PropPosition, metaPosition, dataPosition);
            NzisToken_ToDatTime: UpdateData(PRecord.ToDatTime, PropPosition, metaPosition, dataPosition);
            NzisToken_CertID: UpdateData(PRecord.CertID, PropPosition, metaPosition, dataPosition);
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

{ TNzisTokenColl }

function TNzisTokenColl.AddItem(ver: word): TNzisTokenItem;
begin
  Result := TNzisTokenItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TNzisTokenColl.AddItemForSearch: Integer;
var
  ItemForSearch: TNzisTokenItem;
begin
  ItemForSearch := TNzisTokenItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TNzisTokenColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TNzisTokenItem.Create(nil);
  ListNzisTokenSearch := TList<TNzisTokenItem>.Create;
  ListForFDB := TList<TNzisTokenItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TNzisTokenColl.destroy;
begin
  FreeAndNil(ListNzisTokenSearch);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TNzisTokenColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TNzisTokenItem.TPropertyIndex(propIndex) of
    NzisToken_Bearer: Result := 'Bearer';
    NzisToken_fromDatTime: Result := 'fromDatTime';
    NzisToken_ToDatTime: Result := 'ToDatTime';
    NzisToken_CertID: Result := 'CertID';
  end;
end;


function TNzisTokenColl.FieldCount: Integer;
begin
  inherited;
  Result := 4;
end;

procedure TNzisTokenColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NzisToken: TNzisTokenItem;
  ACol: Integer;
  prop: TNzisTokenItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NzisToken := Items[ARow];
  prop := TNzisTokenItem.TPropertyIndex(ACol);
  if Assigned(NzisToken.PRecord) and (prop in NzisToken.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NzisToken, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NzisToken, AValue);
  end;
end;

procedure TNzisTokenColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TNzisTokenItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  prop := TNzisTokenItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TNzisTokenColl.GetCellFromRecord(propIndex: word; NzisToken: TNzisTokenItem; var AValue: String);
var
  str: string;
begin
  case TNzisTokenItem.TPropertyIndex(propIndex) of
    NzisToken_Bearer: str := (NzisToken.PRecord.Bearer);
    NzisToken_fromDatTime: str :=DateTimeToStr(NzisToken.PRecord.fromDatTime);
    NzisToken_ToDatTime: str := DateTimeToStr(NzisToken.PRecord.ToDatTime);
    NzisToken_CertID: str := (NzisToken.PRecord.CertID);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TNzisTokenColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TNzisTokenItem;
  ACol: Integer;
  prop: TNzisTokenItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TNzisTokenItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TNzisTokenColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TNzisTokenItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TNzisTokenItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TNzisTokenColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NzisToken: TNzisTokenItem;
  ACol: Integer;
  prop: TNzisTokenItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NzisToken := ListNzisTokenSearch[ARow];
  prop := TNzisTokenItem.TPropertyIndex(ACol);
  if Assigned(NzisToken.PRecord) and (prop in NzisToken.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NzisToken, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NzisToken, AValue);
  end;
end;

procedure TNzisTokenColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  NzisToken: TNzisTokenItem;
  prop: TNzisTokenItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  NzisToken := Items[ARow];
  prop := TNzisTokenItem.TPropertyIndex(ACol);
  if Assigned(NzisToken.PRecord) and (prop in NzisToken.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NzisToken, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NzisToken, AFieldText);
  end;
end;

procedure TNzisTokenColl.GetCellFromMap(propIndex: word; ARow: Integer; NzisToken: TNzisTokenItem; var AValue: String);
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
  case TNzisTokenItem.TPropertyIndex(propIndex) of
    NzisToken_Bearer: str :=  NzisToken.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NzisToken_fromDatTime: str :=  DateTimeToStr(NzisToken.getDateMap(Self.Buf, Self.posData, propIndex));
    NzisToken_ToDatTime: str :=  DateTimeToStr(NzisToken.getDateMap(Self.Buf, Self.posData, propIndex));
    NzisToken_CertID: str :=  NzisToken.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      if propIndex = 4 then // clc
      begin
        if Now < NzisToken.getDateMap(Self.Buf, Self.posData, word(NzisToken_ToDatTime)) then
        begin
          str  := IntToStr(MinutesBetween(Now, NzisToken.getDateMap(Self.Buf, Self.posData, word(NzisToken_ToDatTime))))+ ' мин.';
        end
        else
        begin
          str := 'изтекъл';
        end;
      end
      else
        str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TNzisTokenColl.GetItem(Index: Integer): TNzisTokenItem;
begin
  Result := TNzisTokenItem(inherited GetItem(Index));
end;


procedure TNzisTokenColl.IndexValue(propIndex: TNzisTokenItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TNzisTokenItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      NzisToken_Bearer:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      NzisToken_CertID:
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

procedure TNzisTokenColl.IndexValueListNodes(propIndex: TNzisTokenItem.TPropertyIndex);
begin

end;

procedure TNzisTokenColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TNzisTokenItem;
begin
  if index < 0 then
  begin
    Tempitem := TNzisTokenItem.Create(nil);
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







function TNzisTokenColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TNzisTokenItem.TPropertyIndex(propIndex) of
    NzisToken_Bearer: Result := actAnsiString;
    NzisToken_fromDatTime: Result := actTIMESTAMP;
    NzisToken_ToDatTime: Result := actTIMESTAMP;
    NzisToken_CertID: Result := actAnsiString;
  else
    Result := actNone;
  end
end;

procedure TNzisTokenColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  NzisToken: TNzisTokenItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  NzisToken := Items[ARow];
  if not Assigned(NzisToken.PRecord) then
  begin
    New(NzisToken.PRecord);
    NzisToken.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TNzisTokenItem.TPropertyIndex(ACol) of
      NzisToken_Bearer: isOld :=  NzisToken.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    NzisToken_fromDatTime: isOld :=  NzisToken.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    NzisToken_ToDatTime: isOld :=  NzisToken.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    NzisToken_CertID: isOld :=  NzisToken.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(NzisToken.PRecord.setProp, TNzisTokenItem.TPropertyIndex(ACol));
    if NzisToken.PRecord.setProp = [] then
    begin
      Dispose(NzisToken.PRecord);
      NzisToken.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NzisToken.PRecord.setProp, TNzisTokenItem.TPropertyIndex(ACol));
  case TNzisTokenItem.TPropertyIndex(ACol) of
    NzisToken_Bearer: NzisToken.PRecord.Bearer := AValue;
    //NzisToken_fromDatTime: NzisToken.PRecord.fromDatTime
    //NzisToken_ToDatTime: NzisToken.PRecord.ToDatTime :=
    NzisToken_CertID: NzisToken.PRecord.CertID := AValue;
  end;
end;

procedure TNzisTokenColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  NzisToken: TNzisTokenItem;
begin
  if Count = 0 then Exit;

  NzisToken := Items[ARow];
  if not Assigned(NzisToken.PRecord) then
  begin
    New(NzisToken.PRecord);
    NzisToken.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TNzisTokenItem.TPropertyIndex(ACol) of
      NzisToken_Bearer: isOld :=  NzisToken.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    NzisToken_fromDatTime: isOld :=  NzisToken.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    NzisToken_ToDatTime: isOld :=  NzisToken.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    NzisToken_CertID: isOld :=  NzisToken.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(NzisToken.PRecord.setProp, TNzisTokenItem.TPropertyIndex(ACol));
    if NzisToken.PRecord.setProp = [] then
    begin
      Dispose(NzisToken.PRecord);
      NzisToken.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NzisToken.PRecord.setProp, TNzisTokenItem.TPropertyIndex(ACol));
  case TNzisTokenItem.TPropertyIndex(ACol) of
    NzisToken_Bearer: NzisToken.PRecord.Bearer := AFieldText;
    //NzisToken_fromDatTime: NzisToken.PRecord.fromDatTime
    //NzisToken_ToDatTime: NzisToken.PRecord.ToDatTime
    NzisToken_CertID: NzisToken.PRecord.CertID := AFieldText;
  end;
end;

procedure TNzisTokenColl.SetItem(Index: Integer; const Value: TNzisTokenItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TNzisTokenColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListNzisTokenSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TNzisTokenItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  NzisToken_Bearer:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListNzisTokenSearch.Add(self.Items[i]);
  end;
end;
      NzisToken_CertID:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNzisTokenSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TNzisTokenColl.ShowGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1 + 1, self.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := 'Валиден още';
  TVirtualModeData(Grid.Data).Headers[self.FieldCount + 1] := 'Ред';

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCell;
  TVirtualModeData(Grid.Data).OnSetValue:=self.SetCell;

  for i := 0 to self.FieldCount - 1 do
  begin
    case i of
      0: Grid.Columns[i].Width.Value := 600;
    else
      Grid.Columns[i].Width.Value := 120;
    end;

  end;

  Grid.Columns[self.FieldCount + 1].Width.Value := 50;
  Grid.Columns[self.FieldCount + 1].Index := 0;
  grid.ScrollBars.Horizontal.Visible := Tee.Control.TScrollBarVisible.Show;

end;

procedure TNzisTokenColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TNzisTokenItem>);
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

procedure TNzisTokenColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListNzisTokenSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListNzisTokenSearch.Count]);

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

procedure TNzisTokenColl.SortByIndexAnsiString;
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

procedure TNzisTokenColl.SortByIndexInt;
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

procedure TNzisTokenColl.SortByIndexWord;
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

procedure TNzisTokenColl.SortByIndexValue(propIndex: TNzisTokenItem.TPropertyIndex);
begin
  case propIndex of
    NzisToken_Bearer: SortByIndexAnsiString;
      NzisToken_CertID: SortByIndexAnsiString;
  end;
end;

end.