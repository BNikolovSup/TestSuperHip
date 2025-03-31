unit Table.AnalsNew;

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
TLogicalAnalsNew = (
    isPackage,
    isGroup,
    isAnal,
    isParameter);
TlogicalAnalsNewSet = set of TLogicalAnalsNew;


TAnalsNewItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (AnalsNew_AnalName
, AnalsNew_CL022_pos
, AnalsNew_Logical
);
      TSetProp = set of TPropertyIndex;
      PRecAnalsNew = ^TRecAnalsNew;
      TRecAnalsNew = record
        AnalName: AnsiString;
        CL022_pos: cardinal;
        Logical: TlogicalAnalsNewSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecAnalsNew;
	IndexInt: Integer;
	IndexWord: word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertAnalsNew;
    procedure UpdateAnalsNew;
    procedure SaveAnalsNew(var dataPosition: Cardinal);
  end;


  TAnalsNewColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TAnalsNewItem;
    procedure SetItem(Index: Integer; const Value: TAnalsNewItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListAnalsNewSearch: TList<TAnalsNewItem>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TAnalsNewItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; AnalsNew: TAnalsNewItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; AnalsNew: TAnalsNewItem; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TAnalsNewItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TAnalsNewItem.TPropertyIndex);
    property Items[Index: Integer]: TAnalsNewItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TAnalsNewItem }

constructor TAnalsNewItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TAnalsNewItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TAnalsNewItem.InsertAnalsNew;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctAnalsNew;
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
            AnalsNew_AnalName: SaveData(PRecord.AnalName, PropPosition, metaPosition, dataPosition);
            AnalsNew_CL022_pos: SaveData(PRecord.CL022_pos, PropPosition, metaPosition, dataPosition);
            AnalsNew_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TAnalsNewItem.SaveAnalsNew(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctAnalsNew;
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
            AnalsNew_AnalName: SaveData(PRecord.AnalName, PropPosition, metaPosition, dataPosition);
            AnalsNew_CL022_pos: SaveData(PRecord.CL022_pos, PropPosition, metaPosition, dataPosition);
            AnalsNew_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TAnalsNewItem.UpdateAnalsNew;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctAnalsNew;
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
            AnalsNew_AnalName: UpdateData(PRecord.AnalName, PropPosition, metaPosition, dataPosition);
            AnalsNew_CL022_pos: UpdateData(PRecord.CL022_pos, PropPosition, metaPosition, dataPosition);
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

{ TAnalsNewColl }

function TAnalsNewColl.AddItem(ver: word): TAnalsNewItem;
begin
  Result := TAnalsNewItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TAnalsNewColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListAnalsNewSearch := TList<TAnalsNewItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TAnalsNewColl.destroy;
begin
  FreeAndNil(ListAnalsNewSearch);
  inherited;
end;

function TAnalsNewColl.DisplayName(propIndex: Word): string;
begin
  case TAnalsNewItem.TPropertyIndex(propIndex) of
    AnalsNew_AnalName: Result := 'AnalName';
    AnalsNew_CL022_pos: Result := 'CL022_pos';
    AnalsNew_Logical: Result := 'Logical';
  end;
end;

procedure TAnalsNewColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TAnalsNewItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TAnalsNewColl.FieldCount: Integer;
begin
  Result := 3;
end;

procedure TAnalsNewColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AnalsNew: TAnalsNewItem;
  ACol: Integer;
  prop: TAnalsNewItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  AnalsNew := Items[ARow];
  prop := TAnalsNewItem.TPropertyIndex(ACol);
  if Assigned(AnalsNew.PRecord) and (prop in AnalsNew.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AnalsNew, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AnalsNew, AValue);
  end;
end;

procedure TAnalsNewColl.GetCellFromRecord(propIndex: word; AnalsNew: TAnalsNewItem; var AValue: String);
var
  str: string;
begin
  case TAnalsNewItem.TPropertyIndex(propIndex) of
    AnalsNew_AnalName: str := (AnalsNew.PRecord.AnalName);
    AnalsNew_CL022_pos: str := inttostr(AnalsNew.PRecord.CL022_pos);
    AnalsNew_Logical: str := AnalsNew.Logical16ToStr(TLogicalData08(AnalsNew.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TAnalsNewColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AnalsNew: TAnalsNewItem;
  ACol: Integer;
  prop: TAnalsNewItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  AnalsNew := ListAnalsNewSearch[ARow];
  prop := TAnalsNewItem.TPropertyIndex(ACol);
  if Assigned(AnalsNew.PRecord) and (prop in AnalsNew.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AnalsNew, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AnalsNew, AValue);
  end;
end;

procedure TAnalsNewColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  AnalsNew: TAnalsNewItem;
  prop: TAnalsNewItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  AnalsNew := Items[ARow];
  prop := TAnalsNewItem.TPropertyIndex(ACol);
  if Assigned(AnalsNew.PRecord) and (prop in AnalsNew.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AnalsNew, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AnalsNew, AFieldText);
  end;
end;

procedure TAnalsNewColl.GetCellFromMap(propIndex: word; ARow: Integer; AnalsNew: TAnalsNewItem; var AValue: String);
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
  case TAnalsNewItem.TPropertyIndex(propIndex) of
    AnalsNew_AnalName: str :=  AnalsNew.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    AnalsNew_CL022_pos: str :=  inttostr(AnalsNew.getIntMap(Self.Buf, Self.posData, propIndex));
    AnalsNew_Logical: str :=  AnalsNew.Logical32ToStr(AnalsNew.getLogical32Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TAnalsNewColl.GetItem(Index: Integer): TAnalsNewItem;
begin
  Result := TAnalsNewItem(inherited GetItem(Index));
end;


procedure TAnalsNewColl.IndexValue(propIndex: TAnalsNewItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TAnalsNewItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      AnalsNew_AnalName:
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

procedure TAnalsNewColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  AnalsNew: TAnalsNewItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  AnalsNew := Items[ARow];
  if not Assigned(AnalsNew.PRecord) then
  begin
    New(AnalsNew.PRecord);
    AnalsNew.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TAnalsNewItem.TPropertyIndex(ACol) of
      AnalsNew_AnalName: isOld :=  AnalsNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    AnalsNew_CL022_pos: isOld :=  AnalsNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(AnalsNew.PRecord.setProp, TAnalsNewItem.TPropertyIndex(ACol));
    if AnalsNew.PRecord.setProp = [] then
    begin
      Dispose(AnalsNew.PRecord);
      AnalsNew.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(AnalsNew.PRecord.setProp, TAnalsNewItem.TPropertyIndex(ACol));
  case TAnalsNewItem.TPropertyIndex(ACol) of
    AnalsNew_AnalName: AnalsNew.PRecord.AnalName := AValue;
    AnalsNew_CL022_pos: AnalsNew.PRecord.CL022_pos := StrToInt(AValue);
    AnalsNew_Logical: AnalsNew.PRecord.Logical := tlogicalAnalsNewSet(AnalsNew.StrToLogical08(AValue));
  end;
end;

procedure TAnalsNewColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  AnalsNew: TAnalsNewItem;
begin
  if Count = 0 then Exit;

  AnalsNew := Items[ARow];
  if not Assigned(AnalsNew.PRecord) then
  begin
    New(AnalsNew.PRecord);
    AnalsNew.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TAnalsNewItem.TPropertyIndex(ACol) of
      AnalsNew_AnalName: isOld :=  AnalsNew.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    AnalsNew_CL022_pos: isOld :=  AnalsNew.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(AnalsNew.PRecord.setProp, TAnalsNewItem.TPropertyIndex(ACol));
    if AnalsNew.PRecord.setProp = [] then
    begin
      Dispose(AnalsNew.PRecord);
      AnalsNew.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(AnalsNew.PRecord.setProp, TAnalsNewItem.TPropertyIndex(ACol));
  case TAnalsNewItem.TPropertyIndex(ACol) of
    AnalsNew_AnalName: AnalsNew.PRecord.AnalName := AFieldText;
    AnalsNew_CL022_pos: AnalsNew.PRecord.CL022_pos := StrToInt(AFieldText);
    AnalsNew_Logical: AnalsNew.PRecord.Logical := tlogicalAnalsNewSet(AnalsNew.StrToLogical08(AFieldText));
  end;
end;

procedure TAnalsNewColl.SetItem(Index: Integer; const Value: TAnalsNewItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TAnalsNewColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListAnalsNewSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TAnalsNewItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  AnalsNew_AnalName:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListAnalsNewSearch.Add(self.Items[i]);
  end;
end;
    end;
  end;
end;

procedure TAnalsNewColl.ShowGrid(Grid: TTeeGrid);
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

procedure TAnalsNewColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListAnalsNewSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListAnalsNewSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TAnalsNewColl.SortByIndexAnsiString;
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

procedure TAnalsNewColl.SortByIndexInt;
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

procedure TAnalsNewColl.SortByIndexWord;
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

procedure TAnalsNewColl.SortByIndexValue(propIndex: TAnalsNewItem.TPropertyIndex);
begin
  case propIndex of
    AnalsNew_AnalName: SortByIndexAnsiString;
  end;
end;

end.