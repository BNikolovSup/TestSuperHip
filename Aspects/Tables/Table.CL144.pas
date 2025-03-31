unit Table.CL144;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control;

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


TCL144Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
CL144_Key
, CL144_Description
, CL144_DescriptionEn
, CL144_units
, CL144_cl142
, CL144_cl012
, CL144_cl028
, CL144_cl138
, CL144_conclusion
, CL144_note
);
	  
      TSetProp = set of TPropertyIndex;
      PRecCL144 = ^TRecCL144;
      TRecCL144 = record
        Key: AnsiString;
        Description: AnsiString;
        DescriptionEn: AnsiString;
        units: AnsiString;
        cl142: AnsiString;
        cl012: AnsiString;
        cl028: AnsiString;
        cl138: AnsiString;
        conclusion: AnsiString;
        note: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL144;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL144;
    procedure UpdateCL144;
    procedure SaveCL144(var dataPosition: Cardinal);
	  function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
    procedure FillPropCl142(propindex: TPropertyIndex; stream: TStream);
    procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
  end;


  TCL144Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TCL144Item;
    procedure SetItem(Index: Integer; const Value: TCL144Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TCL144Item;
	ListForFDB: TList<TCL144Item>;
    ListCL144Search: TList<TCL144Item>;
	PRecordSearch: ^TCL144Item.TRecCL144;
    ArrPropSearch: TArray<TCL144Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCL144Item.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL144Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; CL144: TCL144Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL144: TCL144Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TCL144Item.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL144Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL144Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCL144Item.TPropertyIndex);
    property Items[Index: Integer]: TCL144Item read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
  end;

implementation

{ TCL144Item }

constructor TCL144Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL144Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL144Item.FillPropCl142(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    CL144_Key:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Key, lenstr);
      stream.Read(Self.PRecord.Key[1], lenStr);
    end;
    CL144_Description:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Description, lenstr);
      stream.Read(Self.PRecord.Description[1], lenStr);
    end;
    CL144_DescriptionEn:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.DescriptionEn, lenstr);
      stream.Read(Self.PRecord.DescriptionEn[1], lenStr);
    end;
    CL144_units:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.units, lenstr);
      stream.Read(Self.PRecord.units[1], lenStr);
    end;

    CL144_cl142:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl142, lenstr);
      stream.Read(Self.PRecord.cl142[1], lenStr);
    end;
    CL144_cl012:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl012, lenstr);
      stream.Read(Self.PRecord.cl012[1], lenStr);
    end;
    CL144_cl028:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl028, lenstr);
      stream.Read(Self.PRecord.cl028[1], lenStr);
    end;
    CL144_cl138:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl138, lenstr);
      stream.Read(Self.PRecord.cl138[1], lenStr);
    end;

    CL144_conclusion:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.conclusion, lenstr);
      stream.Read(Self.PRecord.conclusion[1], lenStr);
    end;
    CL144_note:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.note, lenstr);
      stream.Read(Self.PRecord.note[1], lenStr);
    end;
  end;
end;

procedure TCL144Item.InsertCL144;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL144;
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
            CL144_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL144_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL144_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL144_units: SaveData(PRecord.units, PropPosition, metaPosition, dataPosition);
            CL144_cl142: SaveData(PRecord.cl142, PropPosition, metaPosition, dataPosition);
            CL144_cl012: SaveData(PRecord.cl012, PropPosition, metaPosition, dataPosition);
            CL144_cl028: SaveData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL144_cl138: SaveData(PRecord.cl138, PropPosition, metaPosition, dataPosition);
            CL144_conclusion: SaveData(PRecord.conclusion, PropPosition, metaPosition, dataPosition);
            CL144_note: SaveData(PRecord.note, PropPosition, metaPosition, dataPosition);
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

function  TCL144Item.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TCL144Item.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TCL144Item;
begin
  Result := True;
  for i := 0 to Length(TCL144Coll(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TCL144Coll(coll).ArrPropSearchClc[i];
	ATempItem := TCL144Coll(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        CL144_Key: Result := IsFinded(ATempItem.PRecord.Key, buf, FPosDataADB, word(CL144_Key), cot);
            CL144_Description: Result := IsFinded(ATempItem.PRecord.Description, buf, FPosDataADB, word(CL144_Description), cot);
            CL144_DescriptionEn: Result := IsFinded(ATempItem.PRecord.DescriptionEn, buf, FPosDataADB, word(CL144_DescriptionEn), cot);
            CL144_units: Result := IsFinded(ATempItem.PRecord.units, buf, FPosDataADB, word(CL144_units), cot);
            CL144_cl142: Result := IsFinded(ATempItem.PRecord.cl142, buf, FPosDataADB, word(CL144_cl142), cot);
            CL144_cl012: Result := IsFinded(ATempItem.PRecord.cl012, buf, FPosDataADB, word(CL144_cl012), cot);
            CL144_cl028: Result := IsFinded(ATempItem.PRecord.cl028, buf, FPosDataADB, word(CL144_cl028), cot);
            CL144_cl138: Result := IsFinded(ATempItem.PRecord.cl138, buf, FPosDataADB, word(CL144_cl138), cot);
            CL144_conclusion: Result := IsFinded(ATempItem.PRecord.conclusion, buf, FPosDataADB, word(CL144_conclusion), cot);
            CL144_note: Result := IsFinded(ATempItem.PRecord.note, buf, FPosDataADB, word(CL144_note), cot);
      end;
    end;
  end;
end;

procedure TCL144Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds16: TLogicalData16;
  propindexcl144: TCL144Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData16);
  stream.Read(flds16, sizeof(TLogicalData16));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := Tcl144Item.TSetProp(flds16);// тука се записва какво има като полета


  for propindexcl144 := Low(Tcl144Item.TPropertyIndex) to High(Tcl144Item.TPropertyIndex) do
  begin
    if not (propindexcl144 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexcl144);
      dataCmdProp.vid := vvCl144;
    end;
    self.FillPropCl142(propindexcl144, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCL144Item.SaveCL144(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL144;
  SaveAnyStreamCommand(@PRecord.setProp, SizeOf(PRecord.setProp), CollType, toUpdate, FVersion, FDataPos);
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
            CL144_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL144_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL144_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL144_units: SaveData(PRecord.units, PropPosition, metaPosition, dataPosition);
            CL144_cl142: SaveData(PRecord.cl142, PropPosition, metaPosition, dataPosition);
            CL144_cl012: SaveData(PRecord.cl012, PropPosition, metaPosition, dataPosition);
            CL144_cl028: SaveData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL144_cl138: SaveData(PRecord.cl138, PropPosition, metaPosition, dataPosition);
            CL144_conclusion: SaveData(PRecord.conclusion, PropPosition, metaPosition, dataPosition);
            CL144_note: SaveData(PRecord.note, PropPosition, metaPosition, dataPosition);
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

procedure TCL144Item.UpdateCL144;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL144;
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
            CL144_Key: UpdateData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL144_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL144_DescriptionEn: UpdateData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL144_units: UpdateData(PRecord.units, PropPosition, metaPosition, dataPosition);
            CL144_cl142: UpdateData(PRecord.cl142, PropPosition, metaPosition, dataPosition);
            CL144_cl012: UpdateData(PRecord.cl012, PropPosition, metaPosition, dataPosition);
            CL144_cl028: UpdateData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL144_cl138: UpdateData(PRecord.cl138, PropPosition, metaPosition, dataPosition);
            CL144_conclusion: UpdateData(PRecord.conclusion, PropPosition, metaPosition, dataPosition);
            CL144_note: UpdateData(PRecord.note, PropPosition, metaPosition, dataPosition);
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

{ TCL144Coll }

function TCL144Coll.AddItem(ver: word): TCL144Item;
begin
  Result := TCL144Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TCL144Coll.AddItemForSearch: Integer;
var
  ItemForSearch: TCL144Item;
begin
  ItemForSearch := TCL144Item.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TCL144Coll.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TCL144Item.Create(nil);
  ListCL144Search := TList<TCL144Item>.Create;
  ListForFDB := TList<TCL144Item>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TCL144Coll.destroy;
begin
  FreeAndNil(ListCL144Search);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TCL144Coll.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TCL144Item.TPropertyIndex(propIndex) of
    CL144_Key: Result := 'Key';
    CL144_Description: Result := 'Description';
    CL144_DescriptionEn: Result := 'DescriptionEn';
    CL144_units: Result := 'units';
    CL144_cl142: Result := 'cl142';
    CL144_cl012: Result := 'cl012';
    CL144_cl028: Result := 'cl028';
    CL144_cl138: Result := 'cl138';
    CL144_conclusion: Result := 'conclusion';
    CL144_note: Result := 'note';
  end;
end;

function TCL144Coll.FieldCount: Integer;
begin
  inherited;
  Result := 10;
end;

procedure TCL144Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL144: TCL144Item;
  ACol: Integer;
  prop: TCL144Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL144 := Items[ARow];
  prop := TCL144Item.TPropertyIndex(ACol);
  if Assigned(CL144.PRecord) and (prop in CL144.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL144, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL144, AValue);
  end;
end;

procedure TCL144Coll.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL144Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := ListDataPos[ARow].DataPos;
  prop := TCL144Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL144Coll.GetCellFromRecord(propIndex: word; CL144: TCL144Item; var AValue: String);
var
  str: string;
begin
  case TCL144Item.TPropertyIndex(propIndex) of
    CL144_Key: str := (CL144.PRecord.Key);
    CL144_Description: str := (CL144.PRecord.Description);
    CL144_DescriptionEn: str := (CL144.PRecord.DescriptionEn);
    CL144_units: str := (CL144.PRecord.units);
    CL144_cl142: str := (CL144.PRecord.cl142);
    CL144_cl012: str := (CL144.PRecord.cl012);
    CL144_cl028: str := (CL144.PRecord.cl028);
    CL144_cl138: str := (CL144.PRecord.cl138);
    CL144_conclusion: str := (CL144.PRecord.conclusion);
    CL144_note: str := (CL144.PRecord.note);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL144Coll.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TCL144Item;
  ACol: Integer;
  prop: TCL144Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TCL144Item.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TCL144Coll.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL144Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TCL144Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL144Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL144: TCL144Item;
  ACol: Integer;
  prop: TCL144Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL144 := ListCL144Search[ARow];
  prop := TCL144Item.TPropertyIndex(ACol);
  if Assigned(CL144.PRecord) and (prop in CL144.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL144, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL144, AValue);
  end;
end;

procedure TCL144Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL144: TCL144Item;
  prop: TCL144Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL144 := Items[ARow];
  prop := TCL144Item.TPropertyIndex(ACol);
  if Assigned(CL144.PRecord) and (prop in CL144.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL144, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL144, AFieldText);
  end;
end;

procedure TCL144Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL144: TCL144Item; var AValue: String);
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
  case TCL144Item.TPropertyIndex(propIndex) of
    CL144_Key: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_Description: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_DescriptionEn: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_units: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_cl142: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_cl012: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_cl028: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_cl138: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_conclusion: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_note: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL144Coll.GetItem(Index: Integer): TCL144Item;
begin
  Result := TCL144Item(inherited GetItem(Index));
end;


procedure TCL144Coll.IndexValue(propIndex: TCL144Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL144Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL144_Key:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL144_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL144_DescriptionEn:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL144_units:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL144_cl142:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL144_cl012:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL144_cl028:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL144_cl138:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL144_conclusion:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL144_note:
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

procedure TCL144Coll.IndexValueListNodes(propIndex: TCL144Item.TPropertyIndex);
begin

end;

procedure TCL144Coll.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TCL144Item;
begin
  if index < 0 then
  begin
    Tempitem := TCL144Item.Create(nil);
    Tempitem.DataPos := datapos;
    GetCellFromMap(field, -1, Tempitem, value);
    Tempitem.Free;
  end
  else
  begin
    Tempitem := Self.Items[index];
    if Assigned(Tempitem.PRecord) then
    begin
      GetCellFromRecord(field, Tempitem, value);
    end
    else
    begin
      GetCellFromMap(field, index, Tempitem, value);
    end;
  end;
end;





function TCL144Coll.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TCL144Item.TPropertyIndex(propIndex) of
    CL144_Key: Result := actAnsiString;
    CL144_Description: Result := actAnsiString;
    CL144_DescriptionEn: Result := actAnsiString;
    CL144_units: Result := actAnsiString;
    CL144_cl142: Result := actAnsiString;
    CL144_cl012: Result := actAnsiString;
    CL144_cl028: Result := actAnsiString;
    CL144_cl138: Result := actAnsiString;
    CL144_conclusion: Result := actAnsiString;
    CL144_note: Result := actAnsiString;
  else
    Result := actNone;
  end
end;

procedure TCL144Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL144: TCL144Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  CL144 := Items[ARow];
  if not Assigned(CL144.PRecord) then
  begin
    New(CL144.PRecord);
    CL144.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL144Item.TPropertyIndex(ACol) of
      CL144_Key: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_Description: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_DescriptionEn: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_units: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_cl142: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_cl012: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_cl028: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_cl138: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_conclusion: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_note: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL144.PRecord.setProp, TCL144Item.TPropertyIndex(ACol));
    if CL144.PRecord.setProp = [] then
    begin
      Dispose(CL144.PRecord);
      CL144.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL144.PRecord.setProp, TCL144Item.TPropertyIndex(ACol));
  case TCL144Item.TPropertyIndex(ACol) of
    CL144_Key: CL144.PRecord.Key := AValue;
    CL144_Description: CL144.PRecord.Description := AValue;
    CL144_DescriptionEn: CL144.PRecord.DescriptionEn := AValue;
    CL144_units: CL144.PRecord.units := AValue;
    CL144_cl142: CL144.PRecord.cl142 := AValue;
    CL144_cl012: CL144.PRecord.cl012 := AValue;
    CL144_cl028: CL144.PRecord.cl028 := AValue;
    CL144_cl138: CL144.PRecord.cl138 := AValue;
    CL144_conclusion: CL144.PRecord.conclusion := AValue;
    CL144_note: CL144.PRecord.note := AValue;
  end;
end;

procedure TCL144Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL144: TCL144Item;
begin
  if Count = 0 then Exit;

  CL144 := Items[ARow];
  if not Assigned(CL144.PRecord) then
  begin
    New(CL144.PRecord);
    CL144.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL144Item.TPropertyIndex(ACol) of
      CL144_Key: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_Description: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_DescriptionEn: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_units: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_cl142: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_cl012: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_cl028: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_cl138: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_conclusion: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_note: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL144.PRecord.setProp, TCL144Item.TPropertyIndex(ACol));
    if CL144.PRecord.setProp = [] then
    begin
      Dispose(CL144.PRecord);
      CL144.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL144.PRecord.setProp, TCL144Item.TPropertyIndex(ACol));
  case TCL144Item.TPropertyIndex(ACol) of
    CL144_Key: CL144.PRecord.Key := AFieldText;
    CL144_Description: CL144.PRecord.Description := AFieldText;
    CL144_DescriptionEn: CL144.PRecord.DescriptionEn := AFieldText;
    CL144_units: CL144.PRecord.units := AFieldText;
    CL144_cl142: CL144.PRecord.cl142 := AFieldText;
    CL144_cl012: CL144.PRecord.cl012 := AFieldText;
    CL144_cl028: CL144.PRecord.cl028 := AFieldText;
    CL144_cl138: CL144.PRecord.cl138 := AFieldText;
    CL144_conclusion: CL144.PRecord.conclusion := AFieldText;
    CL144_note: CL144.PRecord.note := AFieldText;
  end;
end;

procedure TCL144Coll.SetItem(Index: Integer; const Value: TCL144Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL144Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL144Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL144Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL144_Key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL144Search.Add(self.Items[i]);
  end;
end;
      CL144_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL144Search.Add(self.Items[i]);
        end;
      end;
      CL144_DescriptionEn:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL144Search.Add(self.Items[i]);
        end;
      end;
      CL144_units:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL144Search.Add(self.Items[i]);
        end;
      end;
      CL144_cl142:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL144Search.Add(self.Items[i]);
        end;
      end;
      CL144_cl012:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL144Search.Add(self.Items[i]);
        end;
      end;
      CL144_cl028:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL144Search.Add(self.Items[i]);
        end;
      end;
      CL144_cl138:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL144Search.Add(self.Items[i]);
        end;
      end;
      CL144_conclusion:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL144Search.Add(self.Items[i]);
        end;
      end;
      CL144_note:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL144Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCL144Coll.ShowGrid(Grid: TTeeGrid);
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

procedure TCL144Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL144Item>);
var
  i: word;

begin
  ListForFDB := LST;
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, LST.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := 'Ред';

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellList;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 100;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 50;
  Grid.Columns[self.FieldCount].Index := 0;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width + 1;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width - 1;

end;

procedure TCL144Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL144Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL144Search.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;
  grid.Margins.Left := 100;
  grid.Margins.Left := 0;
  grid.Scrolling.Active := true;
end;

procedure TCL144Coll.SortByIndexAnsiString;
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

procedure TCL144Coll.SortByIndexInt;
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

procedure TCL144Coll.SortByIndexWord;
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

procedure TCL144Coll.SortByIndexValue(propIndex: TCL144Item.TPropertyIndex);
begin
  case propIndex of
    CL144_Key: SortByIndexAnsiString;
      CL144_Description: SortByIndexAnsiString;
      CL144_DescriptionEn: SortByIndexAnsiString;
      CL144_units: SortByIndexAnsiString;
      CL144_cl142: SortByIndexAnsiString;
      CL144_cl012: SortByIndexAnsiString;
      CL144_cl028: SortByIndexAnsiString;
      CL144_cl138: SortByIndexAnsiString;
      CL144_conclusion: SortByIndexAnsiString;
      CL144_note: SortByIndexAnsiString;
  end;
end;

end.