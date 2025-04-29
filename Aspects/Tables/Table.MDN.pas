unit Table.MDN;

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
TLogicalMDN = (
    IS_LKK,
    IS_PRINTED,
    TAKENFROMARENAL,
    NZIS_STATUS_None,
    NZIS_STATUS_Valid,
    NZIS_STATUS_NoValid,
    NZIS_STATUS_Sended,
    NZIS_STATUS_Err,
    NZIS_STATUS_Cancel,
    NZIS_STATUS_Edited,
    MED_DIAG_NAPR_Ostro,
    MED_DIAG_NAPR_Hron,
    MED_DIAG_NAPR_Izbor,
    MED_DIAG_NAPR_Disp,
    MED_DIAG_NAPR_Eksp,
    MED_DIAG_NAPR_Prof,
    MED_DIAG_NAPR_Iskane_Telk,
    MED_DIAG_NAPR_Choice_Mother,
    MED_DIAG_NAPR_Choice_Child,
    MED_DIAG_NAPR_PreChoice_Mother,
    MED_DIAG_NAPR_PreChoice_Child,
    MED_DIAG_NAPR_Podg_Telk );
TlogicalMDNSet = set of TLogicalMDN;


TMDNItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (MDN_DATA
, MDN_ID
, MDN_NRN
, MDN_NUMBER
, MDN_Logical
);
      TSetProp = set of TPropertyIndex;
      PRecMDN = ^TRecMDN;
      TRecMDN = record
        DATA: TDate;
        ID: integer;
        NRN: AnsiString;
        NUMBER: integer;
        Logical: TlogicalMDNSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecMDN;
	IndexInt: Integer;
	IndexWord: word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertMDN;
    procedure UpdateMDN;
    procedure SaveMDN(var dataPosition: Cardinal);
  end;


  TMDNColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TMDNItem;
    procedure SetItem(Index: Integer; const Value: TMDNItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TMDNItem;
    ListMDNSearch: TList<TMDNItem>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TMDNItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; MDN: TMDNItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; MDN: TMDNItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TMDNItem.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer;override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TMDNItem.TPropertyIndex);
    property Items[Index: Integer]: TMDNItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TMDNItem }

constructor TMDNItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TMDNItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TMDNItem.InsertMDN;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctMDN;
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
            MDN_DATA: SaveData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            MDN_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            MDN_NRN: SaveData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            MDN_NUMBER: SaveData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            MDN_Logical: SaveData(TLogicalData32(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TMDNItem.SaveMDN(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctMDN;
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
            MDN_DATA: SaveData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            MDN_ID: SaveData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            MDN_NRN: SaveData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            MDN_NUMBER: SaveData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
            MDN_Logical: SaveData(TLogicalData32(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TMDNItem.UpdateMDN;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctMDN;
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
            MDN_DATA: UpdateData(PRecord.DATA, PropPosition, metaPosition, dataPosition);
            MDN_ID: UpdateData(PRecord.ID, PropPosition, metaPosition, dataPosition);
            MDN_NRN: UpdateData(PRecord.NRN, PropPosition, metaPosition, dataPosition);
            MDN_NUMBER: UpdateData(PRecord.NUMBER, PropPosition, metaPosition, dataPosition);
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

{ TMDNColl }

function TMDNColl.AddItem(ver: word): TMDNItem;
begin
  Result := TMDNItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TMDNColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListMDNSearch := TList<TMDNItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  tempItem := TMDNItem.Create(nil);
end;

destructor TMDNColl.destroy;
begin
  FreeAndNil(ListMDNSearch);
  FreeAndNil(tempItem);
  inherited;
end;

function TMDNColl.DisplayName(propIndex: Word): string;
begin
  case TMDNItem.TPropertyIndex(propIndex) of
    MDN_DATA: Result := 'DATA';
    MDN_ID: Result := 'ID';
    MDN_NRN: Result := 'NRN';
    MDN_NUMBER: Result := 'NUMBER';
    MDN_Logical: Result := 'Logical';
  end;
end;

procedure TMDNColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TMDNItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TMDNColl.FieldCount: Integer;
begin
  Result := 5;
end;

procedure TMDNColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  MDN: TMDNItem;
  ACol: Integer;
  prop: TMDNItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  MDN := Items[ARow];
  prop := TMDNItem.TPropertyIndex(ACol);
  if Assigned(MDN.PRecord) and (prop in MDN.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, MDN, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, MDN, AValue);
  end;
end;

procedure TMDNColl.GetCellFromRecord(propIndex: word; MDN: TMDNItem; var AValue: String);
var
  str: string;
begin
  case TMDNItem.TPropertyIndex(propIndex) of
    MDN_DATA: str := DateToStr(MDN.PRecord.DATA);
    MDN_ID: str := inttostr(MDN.PRecord.ID);
    MDN_NRN: str := (MDN.PRecord.NRN);
    MDN_NUMBER: str := inttostr(MDN.PRecord.NUMBER);
    MDN_Logical: str := MDN.Logical32ToStr(TLogicalData32(MDN.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TMDNColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var

  ACol: Integer;
  prop: TMDNItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;

  tempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TMDNItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, tempItem, AValue);
end;

procedure TMDNColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  MDN: TMDNItem;
  ACol: Integer;
  prop: TMDNItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  MDN := ListMDNSearch[ARow];
  prop := TMDNItem.TPropertyIndex(ACol);
  if Assigned(MDN.PRecord) and (prop in MDN.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, MDN, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, MDN, AValue);
  end;
end;

procedure TMDNColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  MDN: TMDNItem;
  prop: TMDNItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  MDN := Items[ARow];
  prop := TMDNItem.TPropertyIndex(ACol);
  if Assigned(MDN.PRecord) and (prop in MDN.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, MDN, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, MDN, AFieldText);
  end;
end;

procedure TMDNColl.GetCellFromMap(propIndex: word; ARow: Integer; MDN: TMDNItem; var AValue: String);
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
  case TMDNItem.TPropertyIndex(propIndex) of
    MDN_DATA: str :=  DateToStr(MDN.getDateMap(Self.Buf, Self.posData, propIndex));
    MDN_ID: str :=  inttostr(MDN.getIntMap(Self.Buf, Self.posData, propIndex));
    MDN_NRN: str :=  MDN.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    MDN_NUMBER: str :=  inttostr(MDN.getIntMap(Self.Buf, Self.posData, propIndex));
    MDN_Logical: str :=  MDN.Logical32ToStr(MDN.getLogical32Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TMDNColl.GetItem(Index: Integer): TMDNItem;
begin
  Result := TMDNItem(inherited GetItem(Index));
end;


procedure TMDNColl.IndexValue(propIndex: TMDNItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TMDNItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      MDN_ID: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
      MDN_NRN:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      MDN_NUMBER: TempItem.IndexInt :=  TempItem.getPIntMap(Self.Buf, self.posData, word(propIndex))^;
    end;
  end;
end;

procedure TMDNColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  MDN: TMDNItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  MDN := Items[ARow];
  if not Assigned(MDN.PRecord) then
  begin
    New(MDN.PRecord);
    MDN.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TMDNItem.TPropertyIndex(ACol) of
      MDN_DATA: isOld :=  MDN.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AValue);
    MDN_ID: isOld :=  MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    MDN_NRN: isOld :=  MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    MDN_NUMBER: isOld :=  MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(MDN.PRecord.setProp, TMDNItem.TPropertyIndex(ACol));
    if MDN.PRecord.setProp = [] then
    begin
      Dispose(MDN.PRecord);
      MDN.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(MDN.PRecord.setProp, TMDNItem.TPropertyIndex(ACol));
  case TMDNItem.TPropertyIndex(ACol) of
    MDN_DATA: MDN.PRecord.DATA := StrToDate(AValue);
    MDN_ID: MDN.PRecord.ID := StrToInt(AValue);
    MDN_NRN: MDN.PRecord.NRN := AValue;
    MDN_NUMBER: MDN.PRecord.NUMBER := StrToInt(AValue);
    MDN_Logical: MDN.PRecord.Logical := tlogicalMDNSet(MDN.StrToLogical32(AValue));
  end;
end;

procedure TMDNColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  MDN: TMDNItem;
begin
  if Count = 0 then Exit;

  MDN := Items[ARow];
  if not Assigned(MDN.PRecord) then
  begin
    New(MDN.PRecord);
    MDN.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TMDNItem.TPropertyIndex(ACol) of
      MDN_DATA: isOld :=  MDN.getDateMap(Self.Buf, Self.posData, ACol) = StrToDate(AFieldText);
    MDN_ID: isOld :=  MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    MDN_NRN: isOld :=  MDN.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    MDN_NUMBER: isOld :=  MDN.getIntMap(Self.Buf, Self.posData, ACol) = StrToInt(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(MDN.PRecord.setProp, TMDNItem.TPropertyIndex(ACol));
    if MDN.PRecord.setProp = [] then
    begin
      Dispose(MDN.PRecord);
      MDN.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(MDN.PRecord.setProp, TMDNItem.TPropertyIndex(ACol));
  case TMDNItem.TPropertyIndex(ACol) of
    MDN_DATA: MDN.PRecord.DATA := StrToDate(AFieldText);
    MDN_ID: MDN.PRecord.ID := StrToInt(AFieldText);
    MDN_NRN: MDN.PRecord.NRN := AFieldText;
    MDN_NUMBER: MDN.PRecord.NUMBER := StrToInt(AFieldText);
    MDN_Logical: MDN.PRecord.Logical := tlogicalMDNSet(MDN.StrToLogical32(AFieldText));
  end;
end;

procedure TMDNColl.SetItem(Index: Integer; const Value: TMDNItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TMDNColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListMDNSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TMDNItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  MDN_ID: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListMDNSearch.Add(self.Items[i]);
        end;
      end;
      MDN_NRN:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListMDNSearch.Add(self.Items[i]);
        end;
      end;
      MDN_NUMBER: 
      begin
        if IntToStr(self.Items[i].IndexInt) = FSearchingValue then
        begin
          ListMDNSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TMDNColl.ShowGrid(Grid: TTeeGrid);
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

procedure TMDNColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListMDNSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListMDNSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TMDNColl.SortByIndexAnsiString;
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

procedure TMDNColl.SortByIndexInt;
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

procedure TMDNColl.SortByIndexWord;
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

procedure TMDNColl.SortByIndexValue(propIndex: TMDNItem.TPropertyIndex);
begin
  case propIndex of
    MDN_ID: SortByIndexInt;
      MDN_NRN: SortByIndexAnsiString;
      MDN_NUMBER: SortByIndexInt;
  end;
end;

end.