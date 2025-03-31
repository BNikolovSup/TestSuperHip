unit Table.Obshtina;

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


TObshtinaItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (Obshtina_ObshtinaName
, Obshtina_ObshtinaID
, Obshtina_RZOKR
, Obshtina_OblID
);
      TSetProp = set of TPropertyIndex;
      PRecObshtina = ^TRecObshtina;
      TRecObshtina = record
        ObshtinaName: AnsiString;
        ObshtinaID: integer;
        RZOKR: word;
        OblID: word;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecObshtina;
	IndexInt: Integer;
	IndexWord: word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertObshtina;
    procedure UpdateObshtina;
    procedure SaveObshtina(var dataPosition: Cardinal);
  end;


  TObshtinaColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TObshtinaItem;
    procedure SetItem(Index: Integer; const Value: TObshtinaItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListObshtinaSearch: TList<TObshtinaItem>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TObshtinaItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; Obshtina: TObshtinaItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Obshtina: TObshtinaItem; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TObshtinaItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TObshtinaItem.TPropertyIndex);
    property Items[Index: Integer]: TObshtinaItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TObshtinaItem }

constructor TObshtinaItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TObshtinaItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TObshtinaItem.InsertObshtina;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctObshtina;
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
            Obshtina_ObshtinaName: SaveData(PRecord.ObshtinaName, PropPosition, metaPosition, dataPosition);
            Obshtina_ObshtinaID: SaveData(PRecord.ObshtinaID, PropPosition, metaPosition, dataPosition);
            Obshtina_RZOKR: SaveData(PRecord.RZOKR, PropPosition, metaPosition, dataPosition);
            Obshtina_OblID: SaveData(PRecord.OblID, PropPosition, metaPosition, dataPosition);
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

procedure TObshtinaItem.SaveObshtina(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctObshtina;
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
            Obshtina_ObshtinaName: SaveData(PRecord.ObshtinaName, PropPosition, metaPosition, dataPosition);
            Obshtina_ObshtinaID: SaveData(PRecord.ObshtinaID, PropPosition, metaPosition, dataPosition);
            Obshtina_RZOKR: SaveData(PRecord.RZOKR, PropPosition, metaPosition, dataPosition);
            Obshtina_OblID: SaveData(PRecord.OblID, PropPosition, metaPosition, dataPosition);
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

procedure TObshtinaItem.UpdateObshtina;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctObshtina;
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
            Obshtina_ObshtinaName: UpdateData(PRecord.ObshtinaName, PropPosition, metaPosition, dataPosition);
            Obshtina_ObshtinaID: UpdateData(PRecord.ObshtinaID, PropPosition, metaPosition, dataPosition);
            Obshtina_RZOKR: UpdateData(PRecord.RZOKR, PropPosition, metaPosition, dataPosition);
            Obshtina_OblID: UpdateData(PRecord.OblID, PropPosition, metaPosition, dataPosition);
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

{ TObshtinaColl }

function TObshtinaColl.AddItem(ver: word): TObshtinaItem;
begin
  Result := TObshtinaItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TObshtinaColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListObshtinaSearch := TList<TObshtinaItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TObshtinaColl.destroy;
begin
  FreeAndNil(ListObshtinaSearch);
  inherited;
end;

function TObshtinaColl.DisplayName(propIndex: Word): string;
begin
  case TObshtinaItem.TPropertyIndex(propIndex) of
    Obshtina_ObshtinaName: Result := 'ObshtinaName';
    Obshtina_ObshtinaID: Result := 'ObshtinaID';
    Obshtina_RZOKR: Result := 'RZOKR';
    Obshtina_OblID: Result := 'OblID';
  end;
end;

procedure TObshtinaColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TObshtinaItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TObshtinaColl.FieldCount: Integer;
begin
  Result := 4;
end;

procedure TObshtinaColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Obshtina: TObshtinaItem;
  ACol: Integer;
  prop: TObshtinaItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Obshtina := Items[ARow];
  prop := TObshtinaItem.TPropertyIndex(ACol);
  if Assigned(Obshtina.PRecord) and (prop in Obshtina.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Obshtina, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Obshtina, AValue);
  end;
end;

procedure TObshtinaColl.GetCellFromRecord(propIndex: word; Obshtina: TObshtinaItem; var AValue: String);
var
  str: string;
begin
  case TObshtinaItem.TPropertyIndex(propIndex) of
    Obshtina_ObshtinaName: str := (Obshtina.PRecord.ObshtinaName);
    Obshtina_ObshtinaID: str := inttostr(Obshtina.PRecord.ObshtinaID);
    Obshtina_RZOKR: str := inttostr(Obshtina.PRecord.RZOKR);
    Obshtina_OblID: str := inttostr(Obshtina.PRecord.OblID);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TObshtinaColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Obshtina: TObshtinaItem;
  ACol: Integer;
  prop: TObshtinaItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Obshtina := ListObshtinaSearch[ARow];
  prop := TObshtinaItem.TPropertyIndex(ACol);
  if Assigned(Obshtina.PRecord) and (prop in Obshtina.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Obshtina, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Obshtina, AValue);
  end;
end;

procedure TObshtinaColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Obshtina: TObshtinaItem;
  prop: TObshtinaItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Obshtina := Items[ARow];
  prop := TObshtinaItem.TPropertyIndex(ACol);
  if Assigned(Obshtina.PRecord) and (prop in Obshtina.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Obshtina, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Obshtina, AFieldText);
  end;
end;

procedure TObshtinaColl.GetCellFromMap(propIndex: word; ARow: Integer; Obshtina: TObshtinaItem; var AValue: String);
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
  case TObshtinaItem.TPropertyIndex(propIndex) of
    Obshtina_ObshtinaName: str :=  Obshtina.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Obshtina_ObshtinaID: str :=  inttostr(Obshtina.getIntMap(Self.Buf, Self.posData, propIndex));
    Obshtina_RZOKR: str :=  inttostr(Obshtina.getWordMap(Self.Buf, Self.posData, propIndex));
    Obshtina_OblID: str :=  inttostr(Obshtina.getWordMap(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TObshtinaColl.GetItem(Index: Integer): TObshtinaItem;
begin
  Result := TObshtinaItem(inherited GetItem(Index));
end;


procedure TObshtinaColl.IndexValue(propIndex: TObshtinaItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TObshtinaItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Obshtina_ObshtinaName:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      Obshtina_ObshtinaID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Obshtina_RZOKR: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      Obshtina_OblID: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TObshtinaColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Obshtina: TObshtinaItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  Obshtina := Items[ARow];
  if not Assigned(Obshtina.PRecord) then
  begin
    New(Obshtina.PRecord);
    Obshtina.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TObshtinaItem.TPropertyIndex(ACol) of
      Obshtina_ObshtinaName: isOld :=  Obshtina.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Obshtina_ObshtinaID: isOld :=  Obshtina.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Obshtina_RZOKR: isOld :=  Obshtina.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Obshtina_OblID: isOld :=  Obshtina.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(Obshtina.PRecord.setProp, TObshtinaItem.TPropertyIndex(ACol));
    if Obshtina.PRecord.setProp = [] then
    begin
      Dispose(Obshtina.PRecord);
      Obshtina.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Obshtina.PRecord.setProp, TObshtinaItem.TPropertyIndex(ACol));
  case TObshtinaItem.TPropertyIndex(ACol) of
    Obshtina_ObshtinaName: Obshtina.PRecord.ObshtinaName := AValue;
    Obshtina_ObshtinaID: Obshtina.PRecord.ObshtinaID := StrToInt(AValue);
    Obshtina_RZOKR: Obshtina.PRecord.RZOKR := StrToInt(AValue);
    Obshtina_OblID: Obshtina.PRecord.OblID := StrToInt(AValue);
  end;
end;

procedure TObshtinaColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Obshtina: TObshtinaItem;
begin
  if Count = 0 then Exit;

  Obshtina := Items[ARow];
  if not Assigned(Obshtina.PRecord) then
  begin
    New(Obshtina.PRecord);
    Obshtina.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TObshtinaItem.TPropertyIndex(ACol) of
      Obshtina_ObshtinaName: isOld :=  Obshtina.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Obshtina_ObshtinaID: isOld :=  Obshtina.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Obshtina_RZOKR: isOld :=  Obshtina.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Obshtina_OblID: isOld :=  Obshtina.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(Obshtina.PRecord.setProp, TObshtinaItem.TPropertyIndex(ACol));
    if Obshtina.PRecord.setProp = [] then
    begin
      Dispose(Obshtina.PRecord);
      Obshtina.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Obshtina.PRecord.setProp, TObshtinaItem.TPropertyIndex(ACol));
  case TObshtinaItem.TPropertyIndex(ACol) of
    Obshtina_ObshtinaName: Obshtina.PRecord.ObshtinaName := AFieldText;
    Obshtina_ObshtinaID: Obshtina.PRecord.ObshtinaID := StrToInt(AFieldText);
    Obshtina_RZOKR: Obshtina.PRecord.RZOKR := StrToInt(AFieldText);
    Obshtina_OblID: Obshtina.PRecord.OblID := StrToInt(AFieldText);
  end;
end;

procedure TObshtinaColl.SetItem(Index: Integer; const Value: TObshtinaItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TObshtinaColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListObshtinaSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TObshtinaItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Obshtina_ObshtinaName:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListObshtinaSearch.Add(self.Items[i]);
  end;
end;
      Obshtina_ObshtinaID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListObshtinaSearch.Add(self.Items[i]);
        end;
      end;
      Obshtina_RZOKR: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListObshtinaSearch.Add(self.Items[i]);
        end;
      end;
      Obshtina_OblID: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListObshtinaSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TObshtinaColl.ShowGrid(Grid: TTeeGrid);
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

procedure TObshtinaColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListObshtinaSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListObshtinaSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TObshtinaColl.SortByIndexAnsiString;
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

procedure TObshtinaColl.SortByIndexInt;
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

procedure TObshtinaColl.SortByIndexWord;
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

procedure TObshtinaColl.SortByIndexValue(propIndex: TObshtinaItem.TPropertyIndex);
begin
  case propIndex of
    Obshtina_ObshtinaName: SortByIndexAnsiString;
      Obshtina_ObshtinaID: SortByIndexInt;
      Obshtina_RZOKR: SortByIndexWord;
      Obshtina_OblID: SortByIndexWord;
  end;
end;

end.