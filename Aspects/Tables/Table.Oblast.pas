unit Table.Oblast;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees;

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


TOblastItem = class(TBaseItem)
  public
    type
      TPropertyIndex =
      (  Oblast_OblastName
       , Oblast_OblastID
      );
      TSetProp = set of TPropertyIndex;
      PRecOblast = ^TRecOblast;
      TRecOblast = record
        OblastName: AnsiString;
        OblastID: integer;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecOblast;
	IndexInt: Integer;
	IndexWord: word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertOblast;
    procedure UpdateOblast;
    procedure SaveOblast(var dataPosition: Cardinal);
  end;


  TOblastColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TOblastItem;
    procedure SetItem(Index: Integer; const Value: TOblastItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListOblastSearch: TList<TOblastItem>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TOblastItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; Oblast: TOblastItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Oblast: TOblastItem; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TOblastItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TOblastItem.TPropertyIndex);
    property Items[Index: Integer]: TOblastItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TOblastItem }

constructor TOblastItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TOblastItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TOblastItem.InsertOblast;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctOblast;
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
            Oblast_OblastName: SaveData(PRecord.OblastName, PropPosition, metaPosition, dataPosition);
            Oblast_OblastID: SaveData(PRecord.OblastID, PropPosition, metaPosition, dataPosition);
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

procedure TOblastItem.SaveOblast(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctOblast;
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
            Oblast_OblastName: SaveData(PRecord.OblastName, PropPosition, metaPosition, dataPosition);
            Oblast_OblastID: SaveData(PRecord.OblastID, PropPosition, metaPosition, dataPosition);
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

procedure TOblastItem.UpdateOblast;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctOblast;
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
            Oblast_OblastName: UpdateData(PRecord.OblastName, PropPosition, metaPosition, dataPosition);
            Oblast_OblastID: UpdateData(PRecord.OblastID, PropPosition, metaPosition, dataPosition);
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

{ TOblastColl }

function TOblastColl.AddItem(ver: word): TOblastItem;
begin
  Result := TOblastItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TOblastColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListOblastSearch := TList<TOblastItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TOblastColl.destroy;
begin
  FreeAndNil(ListOblastSearch);
  inherited;
end;

function TOblastColl.DisplayName(propIndex: Word): string;
begin
  case TOblastItem.TPropertyIndex(propIndex) of
    Oblast_OblastName: Result := 'OblastName';
    Oblast_OblastID: Result := 'OblastID';
  end;
end;

procedure TOblastColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TOblastItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TOblastColl.FieldCount: Integer;
begin
  Result := 2;
end;

procedure TOblastColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Oblast: TOblastItem;
  ACol: Integer;
  prop: TOblastItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Oblast := Items[ARow];
  prop := TOblastItem.TPropertyIndex(ACol);
  if Assigned(Oblast.PRecord) and (prop in Oblast.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Oblast, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Oblast, AValue);
  end;
end;

procedure TOblastColl.GetCellFromRecord(propIndex: word; Oblast: TOblastItem; var AValue: String);
var
  str: string;
begin
  case TOblastItem.TPropertyIndex(propIndex) of
    Oblast_OblastName: str := (Oblast.PRecord.OblastName);
    Oblast_OblastID: str := inttostr(Oblast.PRecord.OblastID);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TOblastColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Oblast: TOblastItem;
  ACol: Integer;
  prop: TOblastItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Oblast := ListOblastSearch[ARow];
  prop := TOblastItem.TPropertyIndex(ACol);
  if Assigned(Oblast.PRecord) and (prop in Oblast.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Oblast, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Oblast, AValue);
  end;
end;

procedure TOblastColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Oblast: TOblastItem;
  prop: TOblastItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Oblast := Items[ARow];
  prop := TOblastItem.TPropertyIndex(ACol);
  if Assigned(Oblast.PRecord) and (prop in Oblast.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Oblast, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Oblast, AFieldText);
  end;
end;

procedure TOblastColl.GetCellFromMap(propIndex: word; ARow: Integer; Oblast: TOblastItem; var AValue: String);
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
  case TOblastItem.TPropertyIndex(propIndex) of
    Oblast_OblastName: str :=  Oblast.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Oblast_OblastID: str :=  inttostr(Oblast.getIntMap(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TOblastColl.GetItem(Index: Integer): TOblastItem;
begin
  Result := TOblastItem(inherited GetItem(Index));
end;


procedure TOblastColl.IndexValue(propIndex: TOblastItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TOblastItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Oblast_OblastName:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      Oblast_OblastID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TOblastColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Oblast: TOblastItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  Oblast := Items[ARow];
  if not Assigned(Oblast.PRecord) then
  begin
    New(Oblast.PRecord);
    Oblast.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TOblastItem.TPropertyIndex(ACol) of
      Oblast_OblastName: isOld :=  Oblast.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Oblast_OblastID: isOld :=  Oblast.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(Oblast.PRecord.setProp, TOblastItem.TPropertyIndex(ACol));
    if Oblast.PRecord.setProp = [] then
    begin
      Dispose(Oblast.PRecord);
      Oblast.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Oblast.PRecord.setProp, TOblastItem.TPropertyIndex(ACol));
  case TOblastItem.TPropertyIndex(ACol) of
    Oblast_OblastName: Oblast.PRecord.OblastName := AValue;
    Oblast_OblastID: Oblast.PRecord.OblastID := StrToInt(AValue);
  end;
end;

procedure TOblastColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Oblast: TOblastItem;
begin
  if Count = 0 then Exit;

  Oblast := Items[ARow];
  if not Assigned(Oblast.PRecord) then
  begin
    New(Oblast.PRecord);
    Oblast.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TOblastItem.TPropertyIndex(ACol) of
      Oblast_OblastName: isOld :=  Oblast.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Oblast_OblastID: isOld :=  Oblast.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(Oblast.PRecord.setProp, TOblastItem.TPropertyIndex(ACol));
    if Oblast.PRecord.setProp = [] then
    begin
      Dispose(Oblast.PRecord);
      Oblast.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Oblast.PRecord.setProp, TOblastItem.TPropertyIndex(ACol));
  case TOblastItem.TPropertyIndex(ACol) of
    Oblast_OblastName: Oblast.PRecord.OblastName := AFieldText;
    Oblast_OblastID: Oblast.PRecord.OblastID := StrToInt(AFieldText);
  end;
end;

procedure TOblastColl.SetItem(Index: Integer; const Value: TOblastItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TOblastColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListOblastSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TOblastItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Oblast_OblastName:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListOblastSearch.Add(self.Items[i]);
  end;
end;
      Oblast_OblastID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListOblastSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TOblastColl.ShowGrid(Grid: TTeeGrid);
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

procedure TOblastColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListOblastSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListOblastSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TOblastColl.SortByIndexAnsiString;
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

procedure TOblastColl.SortByIndexInt;
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

procedure TOblastColl.SortByIndexWord;
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

procedure TOblastColl.SortByIndexValue(propIndex: TOblastItem.TPropertyIndex);
begin
  case propIndex of
    Oblast_OblastName: SortByIndexAnsiString;
      Oblast_OblastID: SortByIndexInt;
  end;
end;

end.