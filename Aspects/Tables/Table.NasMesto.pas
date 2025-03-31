unit Table.NasMesto;

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


TNasMestoItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (NasMesto_NasMestoName
, NasMesto_ObshID
, NasMesto_OblID
, NasMesto_EKATTE
, NasMesto_ZIP
);
      TSetProp = set of TPropertyIndex;
      PRecNasMesto = ^TRecNasMesto;
      TRecNasMesto = record
        NasMestoName: AnsiString;
        ObshID: word;
        OblID: word;
        EKATTE: AnsiString;
        ZIP: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecNasMesto;
	IndexInt: Integer;
	IndexWord: word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertNasMesto;
    procedure UpdateNasMesto;
    procedure SaveNasMesto(var dataPosition: Cardinal);
  end;


  TNasMestoColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TNasMestoItem;
    procedure SetItem(Index: Integer; const Value: TNasMestoItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListNasMestoSearch: TList<TNasMestoItem>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TNasMestoItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; NasMesto: TNasMestoItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; NasMesto: TNasMestoItem; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TNasMestoItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TNasMestoItem.TPropertyIndex);
    property Items[Index: Integer]: TNasMestoItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TNasMestoItem }

constructor TNasMestoItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TNasMestoItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TNasMestoItem.InsertNasMesto;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctNasMesto;
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
            NasMesto_NasMestoName: SaveData(PRecord.NasMestoName, PropPosition, metaPosition, dataPosition);
            NasMesto_ObshID: SaveData(PRecord.ObshID, PropPosition, metaPosition, dataPosition);
            NasMesto_OblID: SaveData(PRecord.OblID, PropPosition, metaPosition, dataPosition);
            NasMesto_EKATTE: SaveData(PRecord.EKATTE, PropPosition, metaPosition, dataPosition);
            NasMesto_ZIP: SaveData(PRecord.ZIP, PropPosition, metaPosition, dataPosition);
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

procedure TNasMestoItem.SaveNasMesto(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNasMesto;
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
            NasMesto_NasMestoName: SaveData(PRecord.NasMestoName, PropPosition, metaPosition, dataPosition);
            NasMesto_ObshID: SaveData(PRecord.ObshID, PropPosition, metaPosition, dataPosition);
            NasMesto_OblID: SaveData(PRecord.OblID, PropPosition, metaPosition, dataPosition);
            NasMesto_EKATTE: SaveData(PRecord.EKATTE, PropPosition, metaPosition, dataPosition);
            NasMesto_ZIP: SaveData(PRecord.ZIP, PropPosition, metaPosition, dataPosition);
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

procedure TNasMestoItem.UpdateNasMesto;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNasMesto;
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
            NasMesto_NasMestoName: UpdateData(PRecord.NasMestoName, PropPosition, metaPosition, dataPosition);
            NasMesto_ObshID: UpdateData(PRecord.ObshID, PropPosition, metaPosition, dataPosition);
            NasMesto_OblID: UpdateData(PRecord.OblID, PropPosition, metaPosition, dataPosition);
            NasMesto_EKATTE: UpdateData(PRecord.EKATTE, PropPosition, metaPosition, dataPosition);
            NasMesto_ZIP: UpdateData(PRecord.ZIP, PropPosition, metaPosition, dataPosition);
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

{ TNasMestoColl }

function TNasMestoColl.AddItem(ver: word): TNasMestoItem;
begin
  Result := TNasMestoItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TNasMestoColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListNasMestoSearch := TList<TNasMestoItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TNasMestoColl.destroy;
begin
  FreeAndNil(ListNasMestoSearch);
  inherited;
end;

function TNasMestoColl.DisplayName(propIndex: Word): string;
begin
  case TNasMestoItem.TPropertyIndex(propIndex) of
    NasMesto_NasMestoName: Result := 'NasMestoName';
    NasMesto_ObshID: Result := 'ObshID';
    NasMesto_OblID: Result := 'OblID';
    NasMesto_EKATTE: Result := 'EKATTE';
    NasMesto_ZIP: Result := 'ZIP';
  end;
end;

procedure TNasMestoColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TNasMestoItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TNasMestoColl.FieldCount: Integer;
begin
  Result := 5;
end;

procedure TNasMestoColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NasMesto: TNasMestoItem;
  ACol: Integer;
  prop: TNasMestoItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NasMesto := Items[ARow];
  prop := TNasMestoItem.TPropertyIndex(ACol);
  if Assigned(NasMesto.PRecord) and (prop in NasMesto.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NasMesto, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NasMesto, AValue);
  end;
end;

procedure TNasMestoColl.GetCellFromRecord(propIndex: word; NasMesto: TNasMestoItem; var AValue: String);
var
  str: string;
begin
  case TNasMestoItem.TPropertyIndex(propIndex) of
    NasMesto_NasMestoName: str := (NasMesto.PRecord.NasMestoName);
    NasMesto_ObshID: str := inttostr(NasMesto.PRecord.ObshID);
    NasMesto_OblID: str := inttostr(NasMesto.PRecord.OblID);
    NasMesto_EKATTE: str := (NasMesto.PRecord.EKATTE);
    NasMesto_ZIP: str := (NasMesto.PRecord.ZIP);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TNasMestoColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NasMesto: TNasMestoItem;
  ACol: Integer;
  prop: TNasMestoItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NasMesto := ListNasMestoSearch[ARow];
  prop := TNasMestoItem.TPropertyIndex(ACol);
  if Assigned(NasMesto.PRecord) and (prop in NasMesto.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NasMesto, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NasMesto, AValue);
  end;
end;

procedure TNasMestoColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  NasMesto: TNasMestoItem;
  prop: TNasMestoItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  NasMesto := Items[ARow];
  prop := TNasMestoItem.TPropertyIndex(ACol);
  if Assigned(NasMesto.PRecord) and (prop in NasMesto.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NasMesto, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NasMesto, AFieldText);
  end;
end;

procedure TNasMestoColl.GetCellFromMap(propIndex: word; ARow: Integer; NasMesto: TNasMestoItem; var AValue: String);
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
  case TNasMestoItem.TPropertyIndex(propIndex) of
    NasMesto_NasMestoName: str :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NasMesto_ObshID: str :=  inttostr(NasMesto.getWordMap(Self.Buf, Self.posData, propIndex));
    NasMesto_OblID: str :=  inttostr(NasMesto.getWordMap(Self.Buf, Self.posData, propIndex));
    NasMesto_EKATTE: str :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NasMesto_ZIP: str :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TNasMestoColl.GetItem(Index: Integer): TNasMestoItem;
begin
  Result := TNasMestoItem(inherited GetItem(Index));
end;


procedure TNasMestoColl.IndexValue(propIndex: TNasMestoItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TNasMestoItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      NasMesto_NasMestoName:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      NasMesto_ObshID: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      NasMesto_OblID: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      NasMesto_EKATTE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      NasMesto_ZIP:
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

procedure TNasMestoColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  NasMesto: TNasMestoItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  NasMesto := Items[ARow];
  if not Assigned(NasMesto.PRecord) then
  begin
    New(NasMesto.PRecord);
    NasMesto.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TNasMestoItem.TPropertyIndex(ACol) of
      NasMesto_NasMestoName: isOld :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    NasMesto_ObshID: isOld :=  NasMesto.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    NasMesto_OblID: isOld :=  NasMesto.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    NasMesto_EKATTE: isOld :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    NasMesto_ZIP: isOld :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(NasMesto.PRecord.setProp, TNasMestoItem.TPropertyIndex(ACol));
    if NasMesto.PRecord.setProp = [] then
    begin
      Dispose(NasMesto.PRecord);
      NasMesto.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NasMesto.PRecord.setProp, TNasMestoItem.TPropertyIndex(ACol));
  case TNasMestoItem.TPropertyIndex(ACol) of
    NasMesto_NasMestoName: NasMesto.PRecord.NasMestoName := AValue;
    NasMesto_ObshID: NasMesto.PRecord.ObshID := StrToInt(AValue);
    NasMesto_OblID: NasMesto.PRecord.OblID := StrToInt(AValue);
    NasMesto_EKATTE: NasMesto.PRecord.EKATTE := AValue;
    NasMesto_ZIP: NasMesto.PRecord.ZIP := AValue;
  end;
end;

procedure TNasMestoColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  NasMesto: TNasMestoItem;
begin
  if Count = 0 then Exit;

  NasMesto := Items[ARow];
  if not Assigned(NasMesto.PRecord) then
  begin
    New(NasMesto.PRecord);
    NasMesto.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TNasMestoItem.TPropertyIndex(ACol) of
      NasMesto_NasMestoName: isOld :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    NasMesto_ObshID: isOld :=  NasMesto.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    NasMesto_OblID: isOld :=  NasMesto.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    NasMesto_EKATTE: isOld :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    NasMesto_ZIP: isOld :=  NasMesto.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(NasMesto.PRecord.setProp, TNasMestoItem.TPropertyIndex(ACol));
    if NasMesto.PRecord.setProp = [] then
    begin
      Dispose(NasMesto.PRecord);
      NasMesto.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NasMesto.PRecord.setProp, TNasMestoItem.TPropertyIndex(ACol));
  case TNasMestoItem.TPropertyIndex(ACol) of
    NasMesto_NasMestoName: NasMesto.PRecord.NasMestoName := AFieldText;
    NasMesto_ObshID: NasMesto.PRecord.ObshID := StrToInt(AFieldText);
    NasMesto_OblID: NasMesto.PRecord.OblID := StrToInt(AFieldText);
    NasMesto_EKATTE: NasMesto.PRecord.EKATTE := AFieldText;
    NasMesto_ZIP: NasMesto.PRecord.ZIP := AFieldText;
  end;
end;

procedure TNasMestoColl.SetItem(Index: Integer; const Value: TNasMestoItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TNasMestoColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListNasMestoSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TNasMestoItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  NasMesto_NasMestoName:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListNasMestoSearch.Add(self.Items[i]);
  end;
end;
      NasMesto_ObshID: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListNasMestoSearch.Add(self.Items[i]);
        end;
      end;
      NasMesto_OblID: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListNasMestoSearch.Add(self.Items[i]);
        end;
      end;
      NasMesto_EKATTE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNasMestoSearch.Add(self.Items[i]);
        end;
      end;
      NasMesto_ZIP:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNasMestoSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TNasMestoColl.ShowGrid(Grid: TTeeGrid);
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

procedure TNasMestoColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListNasMestoSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListNasMestoSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TNasMestoColl.SortByIndexAnsiString;
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

procedure TNasMestoColl.SortByIndexInt;
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

procedure TNasMestoColl.SortByIndexWord;
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

procedure TNasMestoColl.SortByIndexValue(propIndex: TNasMestoItem.TPropertyIndex);
begin
  case propIndex of
    NasMesto_NasMestoName: SortByIndexAnsiString;
      NasMesto_ObshID: SortByIndexWord;
      NasMesto_OblID: SortByIndexWord;
      NasMesto_EKATTE: SortByIndexAnsiString;
      NasMesto_ZIP: SortByIndexAnsiString;
  end;
end;

end.