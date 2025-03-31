unit Table.Role;

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


TRoleItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (Role_NAME
, Role_DESKR
, Role_PASS
, Role_PICRURE
);
      TSetProp = set of TPropertyIndex;
      PRecRole = ^TRecRole;
      TRecRole = record
        NAME: AnsiString;
        DESKR: AnsiString;
        PASS: boolean;
        PICRURE: Blob;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecRole;
	IndexInt: Integer;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertRole;
    procedure UpdateRole;
    procedure SaveRole(var dataPosition: Cardinal);
  end;


  TRoleColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TRoleItem;
    procedure SetItem(Index: Integer; const Value: TRoleItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListRoleSearch: TList<TRoleItem>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TRoleItem;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; Role: TRoleItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; Role: TRoleItem; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TRoleItem.TPropertyIndex);
    procedure SortByIndexInt;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer;
	procedure ShowGrid(Grid: TTeeGrid);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TRoleItem.TPropertyIndex);
    property Items[Index: Integer]: TRoleItem read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TRoleItem }

constructor TRoleItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TRoleItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TRoleItem.InsertRole;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctRole;
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
            Role_NAME: SaveData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Role_DESKR: SaveData(PRecord.DESKR, PropPosition, metaPosition, dataPosition);
            Role_PASS: SaveData(PRecord.PASS, PropPosition, metaPosition, dataPosition);
            Role_PICRURE: SaveData(PRecord.PICRURE, PropPosition, metaPosition, dataPosition);
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

procedure TRoleItem.SaveRole(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctRole;
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
            Role_NAME: SaveData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Role_DESKR: SaveData(PRecord.DESKR, PropPosition, metaPosition, dataPosition);
            Role_PASS: SaveData(PRecord.PASS, PropPosition, metaPosition, dataPosition);
            Role_PICRURE: SaveData(PRecord.PICRURE, PropPosition, metaPosition, dataPosition);
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

procedure TRoleItem.UpdateRole;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctRole;
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
            Role_NAME: UpdateData(PRecord.NAME, PropPosition, metaPosition, dataPosition);
            Role_DESKR: UpdateData(PRecord.DESKR, PropPosition, metaPosition, dataPosition);
            Role_PASS: UpdateData(PRecord.PASS, PropPosition, metaPosition, dataPosition);
            //Role_PICRURE: UpdateData(PRecord.PICRURE, PropPosition, metaPosition, dataPosition);
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

{ TRoleColl }

function TRoleColl.AddItem(ver: word): TRoleItem;
begin
  Result := TRoleItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TRoleColl.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListRoleSearch := TList<TRoleItem>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TRoleColl.destroy;
begin
  FreeAndNil(ListRoleSearch);
  inherited;
end;

function TRoleColl.DisplayName(propIndex: Word): string;
begin
  case TRoleItem.TPropertyIndex(propIndex) of
    Role_NAME: Result := 'NAME';
    Role_DESKR: Result := 'DESKR';
    Role_PASS: Result := 'PASS';
    Role_PICRURE: Result := 'PICRURE';
  end;
end;

procedure TRoleColl.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TRoleItem.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TRoleColl.FieldCount: Integer;
begin
  Result := 4;
end;

procedure TRoleColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Role: TRoleItem;
  ACol: Integer;
  prop: TRoleItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Role := Items[ARow];
  prop := TRoleItem.TPropertyIndex(ACol);
  if Assigned(Role.PRecord) and (prop in Role.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Role, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Role, AValue);
  end;
end;

procedure TRoleColl.GetCellFromRecord(propIndex: word; Role: TRoleItem; var AValue: String);
var
  str: string;
begin
  case TRoleItem.TPropertyIndex(propIndex) of
    Role_NAME: str := (Role.PRecord.NAME);
    Role_DESKR: str := (Role.PRecord.DESKR);
    Role_PASS: str := BoolToStr(Role.PRecord.PASS, True);
    Role_PICRURE: str := 'BLOB';
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TRoleColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  Role: TRoleItem;
  ACol: Integer;
  prop: TRoleItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  Role := ListRoleSearch[ARow];
  prop := TRoleItem.TPropertyIndex(ACol);
  if Assigned(Role.PRecord) and (prop in Role.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Role, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Role, AValue);
  end;
end;

procedure TRoleColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  Role: TRoleItem;
  prop: TRoleItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  Role := Items[ARow];
  prop := TRoleItem.TPropertyIndex(ACol);
  if Assigned(Role.PRecord) and (prop in Role.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, Role, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, Role, AFieldText);
  end;
end;

procedure TRoleColl.GetCellFromMap(propIndex: word; ARow: Integer; Role: TRoleItem; var AValue: String);
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
  case TRoleItem.TPropertyIndex(propIndex) of
    Role_NAME: str :=  Role.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Role_DESKR: str :=  Role.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    Role_PASS: str :=  BoolToStr(Role.getBooleanMap(Self.Buf, Self.posData, propIndex), true);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TRoleColl.GetItem(Index: Integer): TRoleItem;
begin
  Result := TRoleItem(inherited GetItem(Index));
end;


procedure TRoleColl.IndexValue(propIndex: TRoleItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TRoleItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      Role_NAME:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      Role_DESKR:
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

procedure TRoleColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  Role: TRoleItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  Role := Items[ARow];
  if not Assigned(Role.PRecord) then
  begin
    New(Role.PRecord);
    Role.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TRoleItem.TPropertyIndex(ACol) of
      Role_NAME: isOld :=  Role.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Role_DESKR: isOld :=  Role.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    Role_PASS: isOld :=  Role.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AValue);
    end;
  end;
  if isOld then
  begin
    Exclude(Role.PRecord.setProp, TRoleItem.TPropertyIndex(ACol));
    if Role.PRecord.setProp = [] then
    begin
      Dispose(Role.PRecord);
      Role.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Role.PRecord.setProp, TRoleItem.TPropertyIndex(ACol));
  case TRoleItem.TPropertyIndex(ACol) of
    Role_NAME: Role.PRecord.NAME := AValue;
    Role_DESKR: Role.PRecord.DESKR := AValue;
    Role_PASS: Role.PRecord.PASS := StrToBool(AValue);
    //Role_PICRURE: Role.PRecord.PICRURE := StrToBool(AValue);
  end;
end;

procedure TRoleColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  Role: TRoleItem;
begin
  if Count = 0 then Exit;

  Role := Items[ARow];
  if not Assigned(Role.PRecord) then
  begin
    New(Role.PRecord);
    Role.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TRoleItem.TPropertyIndex(ACol) of
      Role_NAME: isOld :=  Role.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Role_DESKR: isOld :=  Role.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    Role_PASS: isOld :=  Role.getBooleanMap(Self.Buf, Self.posData, ACol) = StrToBool(AFieldText);
    end;
  end;
  if isOld then
  begin
    Exclude(Role.PRecord.setProp, TRoleItem.TPropertyIndex(ACol));
    if Role.PRecord.setProp = [] then
    begin
      Dispose(Role.PRecord);
      Role.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(Role.PRecord.setProp, TRoleItem.TPropertyIndex(ACol));
  case TRoleItem.TPropertyIndex(ACol) of
    Role_NAME: Role.PRecord.NAME := AFieldText;
    Role_DESKR: Role.PRecord.DESKR := AFieldText;
    Role_PASS: Role.PRecord.PASS := StrToBool(AFieldText);
    //Role_PICRURE: Role.PRecord.PICRURE := StrToBool(AFieldText);
  end;
end;

procedure TRoleColl.SetItem(Index: Integer; const Value: TRoleItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRoleColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListRoleSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TRoleItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  Role_NAME:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListRoleSearch.Add(self.Items[i]);
  end;
end;
      Role_DESKR:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListRoleSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TRoleColl.ShowGrid(Grid: TTeeGrid);
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

procedure TRoleColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListRoleSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListRoleSearch.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TRoleColl.SortByIndexAnsiString;
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

procedure TRoleColl.SortByIndexInt;
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

procedure TRoleColl.SortByIndexValue(propIndex: TRoleItem.TPropertyIndex);
begin
  case propIndex of
    Role_NAME: SortByIndexAnsiString;
      Role_DESKR: SortByIndexAnsiString;
  end;
end;

end.