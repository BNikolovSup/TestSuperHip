unit Table.Mkb;

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


TMkbItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
      Mkb_CODE
    , Mkb_NAME
    , Mkb_NOTE
    );
      TSetProp = set of TPropertyIndex;
      PRecMkb = ^TRecMkb;
      TRecMkb = record
        CODE: AnsiString;
        NAME: AnsiString;
        NOTE: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecMkb;
	IndexInt: Integer;
	IndexWord: word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertMkb;
    procedure UpdateMkb;
    procedure SaveMkb(var dataPosition: Cardinal);
  end;


  TMkbColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    FIsSortedMKB: Boolean;

    function GetItem(Index: Integer): TMkbItem;
    procedure SetItem(Index: Integer; const Value: TMkbItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListMkbSearch: TList<TMkbItem>;
    MkbGroups, MkbSubGroups: TStringList;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TMkbItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; Mkb: TMkbItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Mkb: TMkbItem; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TMkbItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

    function DisplayName(propIndex: Word): string;
    function FieldCount: Integer; override;
    procedure ShowGrid(Grid: TTeeGrid);override;
    procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TMkbItem.TPropertyIndex);
    property Items[Index: Integer]: TMkbItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    property IsSortedMKB: Boolean read FIsSortedMKB write FIsSortedMKB;
  end;

implementation

{ TMkbItem }

constructor TMkbItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TMkbItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TMkbItem.InsertMkb;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctMkb;
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
  SaveStreamCommand(TLogicalData08(PRecord.setProp), CollType, toInsert, FVersion, metaPosition + 4);
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
            Mkb_CODE:
            begin
              if PRecord.CODE = '*' then
                PRecord.CODE := '*';
              SaveData(PRecord.CODE, PropPosition, metaPosition, dataPosition);
            end;
            Mkb_NAME: SaveData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Mkb_NOTE: SaveData(PRecord.NOTE, PropPosition, metaPosition, dataPosition);
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

procedure TMkbItem.SaveMkb(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctMkb;
  SaveStreamCommand(TLogicalData08(PRecord.setProp), CollType, toInsert, FVersion, dataPosition);
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
            Mkb_CODE: SaveData(PRecord.CODE, PropPosition, metaPosition, dataPosition);
            Mkb_NAME: SaveData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Mkb_NOTE: SaveData(PRecord.NOTE, PropPosition, metaPosition, dataPosition);
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

procedure TMkbItem.UpdateMkb;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctMkb;
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
            Mkb_CODE: UpdateData(PRecord.CODE, PropPosition, metaPosition, dataPosition);
            Mkb_NAME: UpdateData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Mkb_NOTE: UpdateData(PRecord.NOTE, PropPosition, metaPosition, dataPosition);
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

{ TMkbColl }

function TMkbColl.AddItem(ver: word): TMkbItem;
begin
  Result := TMkbItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TMkbColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListMkbSearch := TList<TMkbItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  FIsSortedMKB := False;
  MkbGroups := TStringList.Create;
  MkbSubGroups := TStringList.Create;
end;

destructor TMkbColl.destroy;
begin
  FreeAndNil(ListMkbSearch);
  MkbGroups.Free;
  MkbSubGroups.Free;
  inherited;
end;

function TMkbColl.DisplayName(propIndex: Word): string;
begin
  case TMkbItem.TPropertyIndex(propIndex) of
    Mkb_CODE: Result := 'CODE';
    Mkb_NAME: Result := 'NAME';
    Mkb_NOTE: Result := 'NOTE';
  end;
end;

procedure TMkbColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TMkbItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TMkbColl.FieldCount: Integer;
begin
  Result := 3;
end;

procedure TMkbColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Mkb: TMkbItem;
  ACol: Integer;
  prop: TMkbItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Mkb := Items[ARow];
  prop := TMkbItem.TPropertyIndex(ACol);
  if Assigned(Mkb.PRecord) and (prop in Mkb.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Mkb, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Mkb, AValue);
  end;
end;

procedure TMkbColl.GetCellFromRecord(propIndex: word; Mkb: TMkbItem; var AValue: String);
var
  str: string;
begin
  case TMkbItem.TPropertyIndex(propIndex) of
    Mkb_CODE: str := (Mkb.PRecord.CODE);
    Mkb_NAME: str := (Mkb.PRecord.NAME);
    Mkb_NOTE: str := (Mkb.PRecord.NOTE);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TMkbColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Mkb: TMkbItem;
  ACol: Integer;
  prop: TMkbItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Mkb := ListMkbSearch[ARow];
  prop := TMkbItem.TPropertyIndex(ACol);
  if Assigned(Mkb.PRecord) and (prop in Mkb.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Mkb, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Mkb, AValue);
  end;
end;

procedure TMkbColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Mkb: TMkbItem;
  prop: TMkbItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Mkb := Items[ARow];
  prop := TMkbItem.TPropertyIndex(ACol);
  if Assigned(Mkb.PRecord) and (prop in Mkb.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Mkb, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Mkb, AFieldText);
  end;
end;

procedure TMkbColl.GetCellFromMap(propIndex: word; ARow: Integer; Mkb: TMkbItem; var AValue: String);
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
  case TMkbItem.TPropertyIndex(propIndex) of
    Mkb_CODE: str :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Mkb_NAME: str :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Mkb_NOTE: str :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TMkbColl.GetItem(Index: Integer): TMkbItem;
begin
  Result := TMkbItem(inherited GetItem(Index));
end;


procedure TMkbColl.IndexValue(propIndex: TMkbItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TMkbItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Mkb_CODE:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
          if TempItem.IndexAnsiStr1 = '*' then
            TempItem.IndexAnsiStr1 := '*';
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Mkb_NAME:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      Mkb_NOTE:
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

procedure TMkbColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Mkb: TMkbItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  Mkb := Items[ARow];
  if not Assigned(Mkb.PRecord) then
  begin
    New(Mkb.PRecord);
    Mkb.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TMkbItem.TPropertyIndex(ACol) of
      Mkb_CODE: isOld :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Mkb_NAME: isOld :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Mkb_NOTE: isOld :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(Mkb.PRecord.setProp, TMkbItem.TPropertyIndex(ACol));
    if Mkb.PRecord.setProp = [] then
    begin
      Dispose(Mkb.PRecord);
      Mkb.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Mkb.PRecord.setProp, TMkbItem.TPropertyIndex(ACol));
  case TMkbItem.TPropertyIndex(ACol) of
    Mkb_CODE: Mkb.PRecord.CODE := AValue;
    Mkb_NAME: Mkb.PRecord.NAME := AValue;
    Mkb_NOTE: Mkb.PRecord.NOTE := AValue;
  end;
end;

procedure TMkbColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Mkb: TMkbItem;
begin
  if Count = 0 then Exit;

  Mkb := Items[ARow];
  if not Assigned(Mkb.PRecord) then
  begin
    New(Mkb.PRecord);
    Mkb.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TMkbItem.TPropertyIndex(ACol) of
      Mkb_CODE: isOld :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Mkb_NAME: isOld :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Mkb_NOTE: isOld :=  Mkb.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(Mkb.PRecord.setProp, TMkbItem.TPropertyIndex(ACol));
    if Mkb.PRecord.setProp = [] then
    begin
      Dispose(Mkb.PRecord);
      Mkb.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Mkb.PRecord.setProp, TMkbItem.TPropertyIndex(ACol));
  case TMkbItem.TPropertyIndex(ACol) of
    Mkb_CODE: Mkb.PRecord.CODE := AFieldText;
    Mkb_NAME: Mkb.PRecord.NAME := AFieldText;
    Mkb_NOTE: Mkb.PRecord.NOTE := AFieldText;
  end;
end;

procedure TMkbColl.SetItem(Index: Integer; const Value: TMkbItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TMkbColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListMkbSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TMkbItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Mkb_CODE:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListMkbSearch.Add(self.Items[i]);
  end;
end;
      Mkb_NAME:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListMkbSearch.Add(self.Items[i]);
        end;
      end;
      Mkb_NOTE:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListMkbSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TMkbColl.ShowGrid(Grid: TTeeGrid);
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

procedure TMkbColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListMkbSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListMkbSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TMkbColl.SortByIndexAnsiString;
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

procedure TMkbColl.SortByIndexInt;
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

procedure TMkbColl.SortByIndexWord;
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

procedure TMkbColl.SortByIndexValue(propIndex: TMkbItem.TPropertyIndex);
begin
  case propIndex of
    Mkb_CODE: SortByIndexAnsiString;
    Mkb_NAME: SortByIndexAnsiString;
    Mkb_NOTE: SortByIndexAnsiString;
  end;
end;

end.