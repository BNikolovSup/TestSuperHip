unit Table.Unfav;

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


TUnfavItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (Unfav_ID
, Unfav_DOCTOR_ID_PRAC
, Unfav_YEAR_UNFAV
, Unfav_MONTH_UNFAV
);
      TSetProp = set of TPropertyIndex;
      PRecUnfav = ^TRecUnfav;
      TRecUnfav = record
        ID: integer;
        DOCTOR_ID_PRAC: word;
        YEAR_UNFAV: word;
        MONTH_UNFAV: word;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecUnfav;
	IndexInt: Integer;
	IndexWord: word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertUnfav;
    procedure UpdateUnfav;
    procedure SaveUnfav(var dataPosition: Cardinal);
  end;


  TUnfavColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TUnfavItem;
    procedure SetItem(Index: Integer; const Value: TUnfavItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListUnfavSearch: TList<TUnfavItem>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TUnfavItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; Unfav: TUnfavItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Unfav: TUnfavItem; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TUnfavItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TUnfavItem.TPropertyIndex);
    property Items[Index: Integer]: TUnfavItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TUnfavItem }

constructor TUnfavItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TUnfavItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TUnfavItem.InsertUnfav;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctUnfav;
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
  SaveStreamCommand(TLogicalData08(PRecord.setProp), CollType, toInsert, FVersion);
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
            Unfav_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Unfav_DOCTOR_ID_PRAC: SaveData(PRecord.DOCTOR_ID_PRAC, PropPosition, metaPosition, dataPosition);
            Unfav_YEAR_UNFAV: SaveData(PRecord.YEAR_UNFAV, PropPosition, metaPosition, dataPosition);
            Unfav_MONTH_UNFAV: SaveData(PRecord.MONTH_UNFAV, PropPosition, metaPosition, dataPosition);
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

procedure TUnfavItem.SaveUnfav(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctUnfav;
  SaveStreamCommand(TLogicalData08(PRecord.setProp), CollType, toInsert, FVersion);
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
            Unfav_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Unfav_DOCTOR_ID_PRAC: SaveData(PRecord.DOCTOR_ID_PRAC, PropPosition, metaPosition, dataPosition);
            Unfav_YEAR_UNFAV: SaveData(PRecord.YEAR_UNFAV, PropPosition, metaPosition, dataPosition);
            Unfav_MONTH_UNFAV: SaveData(PRecord.MONTH_UNFAV, PropPosition, metaPosition, dataPosition);
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

procedure TUnfavItem.UpdateUnfav;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctUnfav;
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
            Unfav_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            Unfav_DOCTOR_ID_PRAC: UpdateData(PRecord.DOCTOR_ID_PRAC, PropPosition, metaPosition, dataPosition);
            Unfav_YEAR_UNFAV: UpdateData(PRecord.YEAR_UNFAV, PropPosition, metaPosition, dataPosition);
            Unfav_MONTH_UNFAV: UpdateData(PRecord.MONTH_UNFAV, PropPosition, metaPosition, dataPosition);
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

{ TUnfavColl }

function TUnfavColl.AddItem(ver: word): TUnfavItem;
begin
  Result := TUnfavItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TUnfavColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListUnfavSearch := TList<TUnfavItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TUnfavColl.destroy;
begin
  FreeAndNil(ListUnfavSearch);
  inherited;
end;

function TUnfavColl.DisplayName(propIndex: Word): string;
begin
  case TUnfavItem.TPropertyIndex(propIndex) of
    Unfav_ID: Result := 'ID';
    Unfav_DOCTOR_ID_PRAC: Result := 'DOCTOR_ID_PRAC';
    Unfav_YEAR_UNFAV: Result := 'YEAR_UNFAV';
    Unfav_MONTH_UNFAV: Result := 'MONTH_UNFAV';
  end;
end;

procedure TUnfavColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TUnfavItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TUnfavColl.FieldCount: Integer;
begin
  Result := 4;
end;

procedure TUnfavColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Unfav: TUnfavItem;
  ACol: Integer;
  prop: TUnfavItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Unfav := Items[ARow];
  prop := TUnfavItem.TPropertyIndex(ACol);
  if Assigned(Unfav.PRecord) and (prop in Unfav.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Unfav, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Unfav, AValue);
  end;
end;

procedure TUnfavColl.GetCellFromRecord(propIndex: word; Unfav: TUnfavItem; var AValue: String);
var
  str: string;
begin
  case TUnfavItem.TPropertyIndex(propIndex) of
    Unfav_ID: str := inttostr(Unfav.PRecord.ID);
    Unfav_DOCTOR_ID_PRAC: str := inttostr(Unfav.PRecord.DOCTOR_ID_PRAC);
    Unfav_YEAR_UNFAV: str := inttostr(Unfav.PRecord.YEAR_UNFAV);
    Unfav_MONTH_UNFAV: str := inttostr(Unfav.PRecord.MONTH_UNFAV);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TUnfavColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Unfav: TUnfavItem;
  ACol: Integer;
  prop: TUnfavItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Unfav := ListUnfavSearch[ARow];
  prop := TUnfavItem.TPropertyIndex(ACol);
  if Assigned(Unfav.PRecord) and (prop in Unfav.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Unfav, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Unfav, AValue);
  end;
end;

procedure TUnfavColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Unfav: TUnfavItem;
  prop: TUnfavItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Unfav := Items[ARow];
  prop := TUnfavItem.TPropertyIndex(ACol);
  if Assigned(Unfav.PRecord) and (prop in Unfav.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Unfav, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Unfav, AFieldText);
  end;
end;

procedure TUnfavColl.GetCellFromMap(propIndex: word; ARow: Integer; Unfav: TUnfavItem; var AValue: String);
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
  case TUnfavItem.TPropertyIndex(propIndex) of
    Unfav_ID: str :=  inttostr(Unfav.getIntMap(Self.Buf, Self.posData, propIndex));
    Unfav_DOCTOR_ID_PRAC: str :=  inttostr(Unfav.getWordMap(Self.Buf, Self.posData, propIndex));
    Unfav_YEAR_UNFAV: str :=  inttostr(Unfav.getWordMap(Self.Buf, Self.posData, propIndex));
    Unfav_MONTH_UNFAV: str :=  inttostr(Unfav.getWordMap(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TUnfavColl.GetItem(Index: Integer): TUnfavItem;
begin
  Result := TUnfavItem(inherited GetItem(Index));
end;


procedure TUnfavColl.IndexValue(propIndex: TUnfavItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TUnfavItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Unfav_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      Unfav_DOCTOR_ID_PRAC: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      Unfav_YEAR_UNFAV: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
      Unfav_MONTH_UNFAV: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TUnfavColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Unfav: TUnfavItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  Unfav := Items[ARow];
  if not Assigned(Unfav.PRecord) then
  begin
    New(Unfav.PRecord);
    Unfav.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TUnfavItem.TPropertyIndex(ACol) of
      Unfav_ID: isOld :=  Unfav.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Unfav_DOCTOR_ID_PRAC: isOld :=  Unfav.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Unfav_YEAR_UNFAV: isOld :=  Unfav.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    Unfav_MONTH_UNFAV: isOld :=  Unfav.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(Unfav.PRecord.setProp, TUnfavItem.TPropertyIndex(ACol));
    if Unfav.PRecord.setProp = [] then
    begin
      Dispose(Unfav.PRecord);
      Unfav.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Unfav.PRecord.setProp, TUnfavItem.TPropertyIndex(ACol));
  case TUnfavItem.TPropertyIndex(ACol) of
    Unfav_ID: Unfav.PRecord.ID := StrToInt(AValue);
    Unfav_DOCTOR_ID_PRAC: Unfav.PRecord.DOCTOR_ID_PRAC := StrToInt(AValue);
    Unfav_YEAR_UNFAV: Unfav.PRecord.YEAR_UNFAV := StrToInt(AValue);
    Unfav_MONTH_UNFAV: Unfav.PRecord.MONTH_UNFAV := StrToInt(AValue);
  end;
end;

procedure TUnfavColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Unfav: TUnfavItem;
begin
  if Count = 0 then Exit;

  Unfav := Items[ARow];
  if not Assigned(Unfav.PRecord) then
  begin
    New(Unfav.PRecord);
    Unfav.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TUnfavItem.TPropertyIndex(ACol) of
      Unfav_ID: isOld :=  Unfav.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Unfav_DOCTOR_ID_PRAC: isOld :=  Unfav.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Unfav_YEAR_UNFAV: isOld :=  Unfav.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    Unfav_MONTH_UNFAV: isOld :=  Unfav.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(Unfav.PRecord.setProp, TUnfavItem.TPropertyIndex(ACol));
    if Unfav.PRecord.setProp = [] then
    begin
      Dispose(Unfav.PRecord);
      Unfav.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Unfav.PRecord.setProp, TUnfavItem.TPropertyIndex(ACol));
  case TUnfavItem.TPropertyIndex(ACol) of
    Unfav_ID: Unfav.PRecord.ID := StrToInt(AFieldText);
    Unfav_DOCTOR_ID_PRAC: Unfav.PRecord.DOCTOR_ID_PRAC := StrToInt(AFieldText);
    Unfav_YEAR_UNFAV: Unfav.PRecord.YEAR_UNFAV := StrToInt(AFieldText);
    Unfav_MONTH_UNFAV: Unfav.PRecord.MONTH_UNFAV := StrToInt(AFieldText);
  end;
end;

procedure TUnfavColl.SetItem(Index: Integer; const Value: TUnfavItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TUnfavColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListUnfavSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TUnfavItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Unfav_ID: 
begin
  if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
  begin
    ListUnfavSearch.Add(self.Items[i]);
  end;
end;
      Unfav_DOCTOR_ID_PRAC: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListUnfavSearch.Add(self.Items[i]);
        end;
      end;
      Unfav_YEAR_UNFAV: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListUnfavSearch.Add(self.Items[i]);
        end;
      end;
      Unfav_MONTH_UNFAV: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListUnfavSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TUnfavColl.ShowGrid(Grid: TTeeGrid);
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

procedure TUnfavColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListUnfavSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListUnfavSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TUnfavColl.SortByIndexAnsiString;
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

procedure TUnfavColl.SortByIndexInt;
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

procedure TUnfavColl.SortByIndexWord;
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

procedure TUnfavColl.SortByIndexValue(propIndex: TUnfavItem.TPropertyIndex);
begin
  case propIndex of
    Unfav_ID: SortByIndexInt;
      Unfav_DOCTOR_ID_PRAC: SortByIndexWord;
      Unfav_YEAR_UNFAV: SortByIndexWord;
      Unfav_MONTH_UNFAV: SortByIndexWord;
  end;
end;

end.