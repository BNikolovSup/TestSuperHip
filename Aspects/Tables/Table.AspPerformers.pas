unit Table.AspPerformers;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, DynWinPanel;

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


TAspPerformersItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
  AspPerformers_GUID
, AspPerformers_EIK
, AspPerformers_EGN
, AspPerformers_UIN
, AspPerformers_RCZ_NUMER
, AspPerformers_Name
);
      TSetProp = set of TPropertyIndex;
      PRecAspPerformers = ^TRecAspPerformers;
      TRecAspPerformers = record
        GUID: AnsiString;
        EIK: AnsiString;
        EGN: AnsiString;
        UIN: AnsiString;
        RCZ_NUMER: AnsiString;
        Name: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecAspPerformers;
	IndexInt: Integer;
	IndexWord: word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertAspPerformers;
    procedure UpdateAspPerformers;
    procedure SaveAspPerformers(var dataPosition: Cardinal);
  end;


  TAspPerformersColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TAspPerformersItem;
    procedure SetItem(Index: Integer; const Value: TAspPerformersItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListAspPerformersSearch: TList<TAspPerformersItem>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TAspPerformersItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; AspPerformers: TAspPerformersItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; AspPerformers: TAspPerformersItem; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TAspPerformersItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TAspPerformersItem.TPropertyIndex);
    property Items[Index: Integer]: TAspPerformersItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TAspPerformersItem }

constructor TAspPerformersItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TAspPerformersItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TAspPerformersItem.InsertAspPerformers;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctAspPerformers;
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
            AspPerformers_GUID: SaveData(PRecord.GUID, PropPosition, metaPosition, dataPosition);
            AspPerformers_EIK: SaveData(PRecord.EIK, PropPosition, metaPosition, dataPosition);
            AspPerformers_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            AspPerformers_UIN: SaveData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
            AspPerformers_RCZ_NUMER: SaveData(PRecord.RCZ_NUMER, PropPosition, metaPosition, dataPosition);
            AspPerformers_Name: SaveData(PRecord.Name, PropPosition, metaPosition, dataPosition);
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

procedure TAspPerformersItem.SaveAspPerformers(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctAspPerformers;
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
            AspPerformers_GUID: SaveData(PRecord.GUID, PropPosition, metaPosition, dataPosition);
            AspPerformers_EIK: SaveData(PRecord.EIK, PropPosition, metaPosition, dataPosition);
            AspPerformers_EGN: SaveData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            AspPerformers_UIN: SaveData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
            AspPerformers_RCZ_NUMER: SaveData(PRecord.RCZ_NUMER, PropPosition, metaPosition, dataPosition);
            AspPerformers_Name: SaveData(PRecord.Name, PropPosition, metaPosition, dataPosition);
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

procedure TAspPerformersItem.UpdateAspPerformers;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctAspPerformers;
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
            AspPerformers_GUID: UpdateData(PRecord.GUID, PropPosition, metaPosition, dataPosition);
            AspPerformers_EIK: UpdateData(PRecord.EIK, PropPosition, metaPosition, dataPosition);
            AspPerformers_EGN: UpdateData(PRecord.EGN, PropPosition, metaPosition, dataPosition);
            AspPerformers_UIN: UpdateData(PRecord.UIN, PropPosition, metaPosition, dataPosition);
            AspPerformers_RCZ_NUMER: UpdateData(PRecord.RCZ_NUMER, PropPosition, metaPosition, dataPosition);
            AspPerformers_Name: UpdateData(PRecord.Name, PropPosition, metaPosition, dataPosition);
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

{ TAspPerformersColl }

function TAspPerformersColl.AddItem(ver: word): TAspPerformersItem;
begin
  Result := TAspPerformersItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TAspPerformersColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListAspPerformersSearch := TList<TAspPerformersItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TAspPerformersColl.destroy;
begin
  FreeAndNil(ListAspPerformersSearch);
  inherited;
end;

function TAspPerformersColl.DisplayName(propIndex: Word): string;
begin
  case TAspPerformersItem.TPropertyIndex(propIndex) of
    AspPerformers_GUID: Result := 'GUID';
    AspPerformers_EIK: Result := 'EIK';
    AspPerformers_EGN: Result := 'EGN';
    AspPerformers_UIN: Result := 'UIN';
    AspPerformers_RCZ_NUMER: Result := 'RCZ_NUMER';
    AspPerformers_Name: Result := 'Name';
  end;
end;

procedure TAspPerformersColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TAspPerformersItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TAspPerformersColl.FieldCount: Integer;
begin
  Result := 6;
end;

procedure TAspPerformersColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AspPerformers: TAspPerformersItem;
  ACol: Integer;
  prop: TAspPerformersItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  AspPerformers := Items[ARow];
  prop := TAspPerformersItem.TPropertyIndex(ACol);
  if Assigned(AspPerformers.PRecord) and (prop in AspPerformers.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AspPerformers, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AspPerformers, AValue);
  end;
end;

procedure TAspPerformersColl.GetCellFromRecord(propIndex: word; AspPerformers: TAspPerformersItem; var AValue: String);
var
  str: string;
begin
  case TAspPerformersItem.TPropertyIndex(propIndex) of
    AspPerformers_GUID: str := (AspPerformers.PRecord.GUID);
    AspPerformers_EIK: str := (AspPerformers.PRecord.EIK);
    AspPerformers_EGN: str := (AspPerformers.PRecord.EGN);
    AspPerformers_UIN: str := (AspPerformers.PRecord.UIN);
    AspPerformers_RCZ_NUMER: str := (AspPerformers.PRecord.RCZ_NUMER);
    AspPerformers_Name: str := (AspPerformers.PRecord.Name);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TAspPerformersColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AspPerformers: TAspPerformersItem;
  ACol: Integer;
  prop: TAspPerformersItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  AspPerformers := ListAspPerformersSearch[ARow];
  prop := TAspPerformersItem.TPropertyIndex(ACol);
  if Assigned(AspPerformers.PRecord) and (prop in AspPerformers.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AspPerformers, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AspPerformers, AValue);
  end;
end;

procedure TAspPerformersColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  AspPerformers: TAspPerformersItem;
  prop: TAspPerformersItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  AspPerformers := Items[ARow];
  prop := TAspPerformersItem.TPropertyIndex(ACol);
  if Assigned(AspPerformers.PRecord) and (prop in AspPerformers.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AspPerformers, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AspPerformers, AFieldText);
  end;
end;

procedure TAspPerformersColl.GetCellFromMap(propIndex: word; ARow: Integer; AspPerformers: TAspPerformersItem; var AValue: String);
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
  case TAspPerformersItem.TPropertyIndex(propIndex) of
    AspPerformers_GUID: str :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    AspPerformers_EIK: str :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    AspPerformers_EGN: str :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    AspPerformers_UIN: str :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    AspPerformers_RCZ_NUMER: str :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    AspPerformers_Name: str :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TAspPerformersColl.GetItem(Index: Integer): TAspPerformersItem;
begin
  Result := TAspPerformersItem(inherited GetItem(Index));
end;


procedure TAspPerformersColl.IndexValue(propIndex: TAspPerformersItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TAspPerformersItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      AspPerformers_GUID:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      AspPerformers_EIK:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      AspPerformers_EGN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      AspPerformers_UIN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      AspPerformers_RCZ_NUMER:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      AspPerformers_Name:
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

procedure TAspPerformersColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  AspPerformers: TAspPerformersItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  AspPerformers := Items[ARow];
  if not Assigned(AspPerformers.PRecord) then
  begin
    New(AspPerformers.PRecord);
    AspPerformers.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TAspPerformersItem.TPropertyIndex(ACol) of
      AspPerformers_GUID: isOld :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    AspPerformers_EIK: isOld :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    AspPerformers_EGN: isOld :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    AspPerformers_UIN: isOld :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    AspPerformers_RCZ_NUMER: isOld :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    AspPerformers_Name: isOld :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(AspPerformers.PRecord.setProp, TAspPerformersItem.TPropertyIndex(ACol));
    if AspPerformers.PRecord.setProp = [] then
    begin
      Dispose(AspPerformers.PRecord);
      AspPerformers.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(AspPerformers.PRecord.setProp, TAspPerformersItem.TPropertyIndex(ACol));
  case TAspPerformersItem.TPropertyIndex(ACol) of
    AspPerformers_GUID: AspPerformers.PRecord.GUID := AValue;
    AspPerformers_EIK: AspPerformers.PRecord.EIK := AValue;
    AspPerformers_EGN: AspPerformers.PRecord.EGN := AValue;
    AspPerformers_UIN: AspPerformers.PRecord.UIN := AValue;
    AspPerformers_RCZ_NUMER: AspPerformers.PRecord.RCZ_NUMER := AValue;
    AspPerformers_Name: AspPerformers.PRecord.Name := AValue;
  end;
end;

procedure TAspPerformersColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  AspPerformers: TAspPerformersItem;
begin
  if Count = 0 then Exit;

  AspPerformers := Items[ARow];
  if not Assigned(AspPerformers.PRecord) then
  begin
    New(AspPerformers.PRecord);
    AspPerformers.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TAspPerformersItem.TPropertyIndex(ACol) of
      AspPerformers_GUID: isOld :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    AspPerformers_EIK: isOld :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    AspPerformers_EGN: isOld :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    AspPerformers_UIN: isOld :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    AspPerformers_RCZ_NUMER: isOld :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    AspPerformers_Name: isOld :=  AspPerformers.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(AspPerformers.PRecord.setProp, TAspPerformersItem.TPropertyIndex(ACol));
    if AspPerformers.PRecord.setProp = [] then
    begin
      Dispose(AspPerformers.PRecord);
      AspPerformers.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(AspPerformers.PRecord.setProp, TAspPerformersItem.TPropertyIndex(ACol));
  case TAspPerformersItem.TPropertyIndex(ACol) of
    AspPerformers_GUID: AspPerformers.PRecord.GUID := AFieldText;
    AspPerformers_EIK: AspPerformers.PRecord.EIK := AFieldText;
    AspPerformers_EGN: AspPerformers.PRecord.EGN := AFieldText;
    AspPerformers_UIN: AspPerformers.PRecord.UIN := AFieldText;
    AspPerformers_RCZ_NUMER: AspPerformers.PRecord.RCZ_NUMER := AFieldText;
    AspPerformers_Name: AspPerformers.PRecord.Name := AFieldText;
  end;
end;

procedure TAspPerformersColl.SetItem(Index: Integer; const Value: TAspPerformersItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TAspPerformersColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListAspPerformersSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TAspPerformersItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  AspPerformers_GUID:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListAspPerformersSearch.Add(self.Items[i]);
  end;
end;
      AspPerformers_EIK:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListAspPerformersSearch.Add(self.Items[i]);
        end;
      end;
      AspPerformers_EGN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListAspPerformersSearch.Add(self.Items[i]);
        end;
      end;
      AspPerformers_UIN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListAspPerformersSearch.Add(self.Items[i]);
        end;
      end;
      AspPerformers_RCZ_NUMER:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListAspPerformersSearch.Add(self.Items[i]);
        end;
      end;
      AspPerformers_Name:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListAspPerformersSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TAspPerformersColl.ShowGrid(Grid: TTeeGrid);
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

procedure TAspPerformersColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListAspPerformersSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListAspPerformersSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TAspPerformersColl.SortByIndexAnsiString;
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

procedure TAspPerformersColl.SortByIndexInt;
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

procedure TAspPerformersColl.SortByIndexWord;
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

procedure TAspPerformersColl.SortByIndexValue(propIndex: TAspPerformersItem.TPropertyIndex);
begin
  case propIndex of
    AspPerformers_GUID: SortByIndexAnsiString;
      AspPerformers_EIK: SortByIndexAnsiString;
      AspPerformers_EGN: SortByIndexAnsiString;
      AspPerformers_UIN: SortByIndexAnsiString;
      AspPerformers_RCZ_NUMER: SortByIndexAnsiString;
      AspPerformers_Name: SortByIndexAnsiString;
  end;
end;

end.