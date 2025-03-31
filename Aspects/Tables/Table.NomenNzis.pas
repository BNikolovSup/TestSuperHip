unit Table.NomenNzis;

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


TNomenNzisItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (NomenNzis_NomenID
, NomenNzis_NomenName
, NomenNzis_IsXML
, NomenNzis_IsExcel
, NomenNzis_StatusImport
);
      TSetProp = set of TPropertyIndex;
      PRecNomenNzis = ^TRecNomenNzis;
      TRecNomenNzis = record
        NomenID: AnsiString;
        NomenName: AnsiString;
        IsXML: boolean;
        IsExcel: boolean;
        StatusImport: word;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecNomenNzis;
	IndexInt: Integer;
	IndexWord: word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertNomenNzis;
    procedure UpdateNomenNzis;
    procedure SaveNomenNzis(var dataPosition: Cardinal);
  end;


  TNomenNzisColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TNomenNzisItem;
    procedure SetItem(Index: Integer; const Value: TNomenNzisItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListNomenNzisSearch: TList<TNomenNzisItem>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TNomenNzisItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; NomenNzis: TNomenNzisItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; NomenNzis: TNomenNzisItem; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TNomenNzisItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TNomenNzisItem.TPropertyIndex);
    property Items[Index: Integer]: TNomenNzisItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TNomenNzisItem }

constructor TNomenNzisItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TNomenNzisItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TNomenNzisItem.InsertNomenNzis;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctNomenNzis;
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
            NomenNzis_NomenID: SaveData(PRecord.NomenID, PropPosition, metaPosition, dataPosition);
            NomenNzis_NomenName: SaveData(PRecord.NomenName, PropPosition, metaPosition, dataPosition);
            NomenNzis_IsXML: SaveData(PRecord.IsXML, PropPosition, metaPosition, dataPosition);
            NomenNzis_IsExcel: SaveData(PRecord.IsExcel, PropPosition, metaPosition, dataPosition);
            NomenNzis_StatusImport: SaveData(PRecord.StatusImport, PropPosition, metaPosition, dataPosition);
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

procedure TNomenNzisItem.SaveNomenNzis(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;

begin
  CollType := ctNomenNzis;
  SaveStreamCommand(TLogicalData08(PRecord.setProp), CollType, toupdate, FVersion, dataPosition);
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
            NomenNzis_NomenID: SaveData(PRecord.NomenID, PropPosition, metaPosition, dataPosition);
            NomenNzis_NomenName: SaveData(PRecord.NomenName, PropPosition, metaPosition, dataPosition);
            NomenNzis_IsXML: SaveData(PRecord.IsXML, PropPosition, metaPosition, dataPosition);
            NomenNzis_IsExcel: SaveData(PRecord.IsExcel, PropPosition, metaPosition, dataPosition);
            NomenNzis_StatusImport: SaveData(PRecord.StatusImport, PropPosition, metaPosition, dataPosition);
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

procedure TNomenNzisItem.UpdateNomenNzis;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNomenNzis;
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
            NomenNzis_NomenID: UpdateData(PRecord.NomenID, PropPosition, metaPosition, dataPosition);
            NomenNzis_NomenName: UpdateData(PRecord.NomenName, PropPosition, metaPosition, dataPosition);
            NomenNzis_IsXML: UpdateData(PRecord.IsXML, PropPosition, metaPosition, dataPosition);
            NomenNzis_IsExcel: UpdateData(PRecord.IsExcel, PropPosition, metaPosition, dataPosition);
            NomenNzis_StatusImport: UpdateData(PRecord.StatusImport, PropPosition, metaPosition, dataPosition);
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

{ TNomenNzisColl }

function TNomenNzisColl.AddItem(ver: word): TNomenNzisItem;
begin
  Result := TNomenNzisItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TNomenNzisColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListNomenNzisSearch := TList<TNomenNzisItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TNomenNzisColl.destroy;
begin
  FreeAndNil(ListNomenNzisSearch);
  inherited;
end;

function TNomenNzisColl.DisplayName(propIndex: Word): string;
begin
  case TNomenNzisItem.TPropertyIndex(propIndex) of
    NomenNzis_NomenID: Result := 'NomenID';
    NomenNzis_NomenName: Result := 'NomenName';
    NomenNzis_IsXML: Result := 'IsXML';
    NomenNzis_IsExcel: Result := 'IsExcel';
    NomenNzis_StatusImport: Result := 'StatusImport';
  end;
end;

procedure TNomenNzisColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TNomenNzisItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TNomenNzisColl.FieldCount: Integer;
begin
  Result := 5;
end;

procedure TNomenNzisColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NomenNzis: TNomenNzisItem;
  ACol: Integer;
  prop: TNomenNzisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NomenNzis := Items[ARow];
  prop := TNomenNzisItem.TPropertyIndex(ACol);
  if Assigned(NomenNzis.PRecord) and (prop in NomenNzis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NomenNzis, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NomenNzis, AValue);
  end;
end;

procedure TNomenNzisColl.GetCellFromRecord(propIndex: word; NomenNzis: TNomenNzisItem; var AValue: String);
var
  str: string;
begin
  case TNomenNzisItem.TPropertyIndex(propIndex) of
    NomenNzis_NomenID: str := (NomenNzis.PRecord.NomenID);
    NomenNzis_NomenName: str := (NomenNzis.PRecord.NomenName);
    NomenNzis_IsXML: str := BoolToStr(NomenNzis.PRecord.IsXML, True);
    NomenNzis_IsExcel: str := BoolToStr(NomenNzis.PRecord.IsExcel, True);
    NomenNzis_StatusImport: str := inttostr(NomenNzis.PRecord.StatusImport);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TNomenNzisColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NomenNzis: TNomenNzisItem;
  ACol: Integer;
  prop: TNomenNzisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NomenNzis := ListNomenNzisSearch[ARow];
  prop := TNomenNzisItem.TPropertyIndex(ACol);
  if Assigned(NomenNzis.PRecord) and (prop in NomenNzis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NomenNzis, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NomenNzis, AValue);
  end;
end;

procedure TNomenNzisColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  NomenNzis: TNomenNzisItem;
  prop: TNomenNzisItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  NomenNzis := Items[ARow];
  prop := TNomenNzisItem.TPropertyIndex(ACol);
  if Assigned(NomenNzis.PRecord) and (prop in NomenNzis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NomenNzis, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NomenNzis, AFieldText);
  end;
end;

procedure TNomenNzisColl.GetCellFromMap(propIndex: word; ARow: Integer; NomenNzis: TNomenNzisItem; var AValue: String);
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
  case TNomenNzisItem.TPropertyIndex(propIndex) of
    NomenNzis_NomenID: str :=  NomenNzis.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NomenNzis_NomenName: str :=  NomenNzis.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NomenNzis_IsXML: str :=  BoolToStr(NomenNzis.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    NomenNzis_IsExcel: str :=  BoolToStr(NomenNzis.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
    NomenNzis_StatusImport: str :=  inttostr(NomenNzis.getWordMap(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TNomenNzisColl.GetItem(Index: Integer): TNomenNzisItem;
begin
  Result := TNomenNzisItem(inherited GetItem(Index));
end;


procedure TNomenNzisColl.IndexValue(propIndex: TNomenNzisItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TNomenNzisItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      NomenNzis_NomenID:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      NomenNzis_NomenName:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      NomenNzis_StatusImport: TempItem.IndexWord :=  TempItem.getPWordMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TNomenNzisColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  NomenNzis: TNomenNzisItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  NomenNzis := Items[ARow];
  if not Assigned(NomenNzis.PRecord) then
  begin
    New(NomenNzis.PRecord);
    NomenNzis.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TNomenNzisItem.TPropertyIndex(ACol) of
      NomenNzis_NomenID: isOld :=  NomenNzis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    NomenNzis_NomenName: isOld :=  NomenNzis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    NomenNzis_IsXML: isOld :=  NomenNzis.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);
    NomenNzis_IsExcel: isOld :=  NomenNzis.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);
    NomenNzis_StatusImport: isOld :=  NomenNzis.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(NomenNzis.PRecord.setProp, TNomenNzisItem.TPropertyIndex(ACol));
    if NomenNzis.PRecord.setProp = [] then
    begin
      Dispose(NomenNzis.PRecord);
      NomenNzis.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NomenNzis.PRecord.setProp, TNomenNzisItem.TPropertyIndex(ACol));
  case TNomenNzisItem.TPropertyIndex(ACol) of
    NomenNzis_NomenID: NomenNzis.PRecord.NomenID := AValue;
    NomenNzis_NomenName: NomenNzis.PRecord.NomenName := AValue;
    NomenNzis_IsXML: NomenNzis.PRecord.IsXML := StrToBool(AValue);
    NomenNzis_IsExcel: NomenNzis.PRecord.IsExcel := StrToBool(AValue);
    NomenNzis_StatusImport: NomenNzis.PRecord.StatusImport := StrToInt(AValue);
  end;
end;

procedure TNomenNzisColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  NomenNzis: TNomenNzisItem;
begin
  if Count = 0 then Exit;

  NomenNzis := Items[ARow];
  if not Assigned(NomenNzis.PRecord) then
  begin
    New(NomenNzis.PRecord);
    NomenNzis.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TNomenNzisItem.TPropertyIndex(ACol) of
      NomenNzis_NomenID: isOld :=  NomenNzis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    NomenNzis_NomenName: isOld :=  NomenNzis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    NomenNzis_IsXML: isOld :=  NomenNzis.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AFieldText);
    NomenNzis_IsExcel: isOld :=  NomenNzis.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AFieldText);
    NomenNzis_StatusImport: isOld :=  NomenNzis.getWordMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(NomenNzis.PRecord.setProp, TNomenNzisItem.TPropertyIndex(ACol));
    if NomenNzis.PRecord.setProp = [] then
    begin
      Dispose(NomenNzis.PRecord);
      NomenNzis.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NomenNzis.PRecord.setProp, TNomenNzisItem.TPropertyIndex(ACol));
  case TNomenNzisItem.TPropertyIndex(ACol) of
    NomenNzis_NomenID: NomenNzis.PRecord.NomenID := AFieldText;
    NomenNzis_NomenName: NomenNzis.PRecord.NomenName := AFieldText;
    NomenNzis_IsXML: NomenNzis.PRecord.IsXML := StrToBool(AFieldText);
    NomenNzis_IsExcel: NomenNzis.PRecord.IsExcel := StrToBool(AFieldText);
    NomenNzis_StatusImport: NomenNzis.PRecord.StatusImport := StrToInt(AFieldText);
  end;
end;

procedure TNomenNzisColl.SetItem(Index: Integer; const Value: TNomenNzisItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TNomenNzisColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListNomenNzisSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TNomenNzisItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  NomenNzis_NomenID:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListNomenNzisSearch.Add(self.Items[i]);
  end;
end;
      NomenNzis_NomenName:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNomenNzisSearch.Add(self.Items[i]);
        end;
      end;
      NomenNzis_StatusImport: 
      begin
        if IntToStr(self.Items[i].IndexWord) = FSearchingValue then
        begin
          ListNomenNzisSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TNomenNzisColl.ShowGrid(Grid: TTeeGrid);
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

procedure TNomenNzisColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListNomenNzisSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListNomenNzisSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TNomenNzisColl.SortByIndexAnsiString;
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

procedure TNomenNzisColl.SortByIndexInt;
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

procedure TNomenNzisColl.SortByIndexWord;
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

procedure TNomenNzisColl.SortByIndexValue(propIndex: TNomenNzisItem.TPropertyIndex);
begin
  case propIndex of
    NomenNzis_NomenID: SortByIndexAnsiString;
      NomenNzis_NomenName: SortByIndexAnsiString;
      NomenNzis_StatusImport: SortByIndexWord;
  end;
end;

end.