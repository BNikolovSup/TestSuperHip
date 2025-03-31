unit Table.CL024;

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


TCL024Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (CL024_Key
, CL024_Description
, CL024_ucum
, CL024_cl032
, CL024_cl028
, CL024_old_key
, CL024_cl022
, CL024_loinc
, CL024_units
);
      TSetProp = set of TPropertyIndex;
      PRecCL024 = ^TRecCL024;
      TRecCL024 = record
        Key: AnsiString;
        Description: AnsiString;
        ucum: AnsiString;
        cl032: AnsiString;
        cl028: AnsiString;
        old_key: AnsiString;
        cl022: AnsiString;
        loinc: AnsiString;
        units: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL024;
	IndexInt: Integer;
	IndexWord: word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL024;
    procedure UpdateCL024;
    procedure SaveCL024(var dataPosition: Cardinal);
    procedure FillPropCl024(propindex: TPropertyIndex; stream: TStream);
    procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
  end;


  TCL024Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TCL024Item;
    procedure SetItem(Index: Integer; const Value: TCL024Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListCL024Search: TList<TCL024Item>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL024Item;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; CL024: TCL024Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL024: TCL024Item; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TCL024Item.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL024Item.TPropertyIndex);
    property Items[Index: Integer]: TCL024Item read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TCL024Item }

constructor TCL024Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL024Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL024Item.FillPropCl024(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    CL024_Key:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Key, lenstr);
      stream.Read(Self.PRecord.Key[1], lenStr);
    end;
    CL024_Description:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Description, lenstr);
      stream.Read(Self.PRecord.Description[1], lenStr);
    end;
    CL024_ucum:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.ucum, lenstr);
      stream.Read(Self.PRecord.ucum[1], lenStr);
    end;
    CL024_cl032:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl032, lenstr);
      stream.Read(Self.PRecord.cl032[1], lenStr);
    end;
    CL024_cl028:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl028, lenstr);
      stream.Read(Self.PRecord.cl028[1], lenStr);
    end;
    CL024_old_key:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.old_key, lenstr);
      stream.Read(Self.PRecord.old_key[1], lenStr);
    end;
    CL024_cl022:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl022, lenstr);
      stream.Read(Self.PRecord.cl022[1], lenStr);
    end;
    CL024_loinc:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.loinc, lenstr);
      stream.Read(Self.PRecord.loinc[1], lenStr);
    end;
    CL024_units:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.units, lenstr);
      stream.Read(Self.PRecord.units[1], lenStr);
    end;
  end;
end;

procedure TCL024Item.InsertCL024;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL024;
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
            CL024_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL024_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL024_ucum: SaveData(PRecord.ucum, PropPosition, metaPosition, dataPosition);
            CL024_cl032: SaveData(PRecord.cl032, PropPosition, metaPosition, dataPosition);
            CL024_cl028: SaveData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL024_old_key: SaveData(PRecord.old_key, PropPosition, metaPosition, dataPosition);
            CL024_cl022: SaveData(PRecord.cl022, PropPosition, metaPosition, dataPosition);
            CL024_loinc: SaveData(PRecord.loinc, PropPosition, metaPosition, dataPosition);
            CL024_units: SaveData(PRecord.units, PropPosition, metaPosition, dataPosition);
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

procedure TCL024Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds16: TLogicalData16;
  propindexcl024: TCL024Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData16);
  stream.Read(flds16, sizeof(TLogicalData16));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := Tcl024Item.TSetProp(flds16);// тука се записва какво има като полета


  for propindexcl024 := Low(Tcl024Item.TPropertyIndex) to High(Tcl024Item.TPropertyIndex) do
  begin
    if not (propindexcl024 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexcl024);
      dataCmdProp.vid := vvCl024;
    end;
    self.FillPropCl024(propindexcl024, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCL024Item.SaveCL024(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL024;
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
            CL024_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL024_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL024_ucum: SaveData(PRecord.ucum, PropPosition, metaPosition, dataPosition);
            CL024_cl032: SaveData(PRecord.cl032, PropPosition, metaPosition, dataPosition);
            CL024_cl028: SaveData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL024_old_key: SaveData(PRecord.old_key, PropPosition, metaPosition, dataPosition);
            CL024_cl022: SaveData(PRecord.cl022, PropPosition, metaPosition, dataPosition);
            CL024_loinc: SaveData(PRecord.loinc, PropPosition, metaPosition, dataPosition);
            CL024_units: SaveData(PRecord.units, PropPosition, metaPosition, dataPosition);
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

procedure TCL024Item.UpdateCL024;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL024;
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
            CL024_Key: UpdateData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL024_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL024_ucum: UpdateData(PRecord.ucum, PropPosition, metaPosition, dataPosition);
            CL024_cl032: UpdateData(PRecord.cl032, PropPosition, metaPosition, dataPosition);
            CL024_cl028: UpdateData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL024_old_key: UpdateData(PRecord.old_key, PropPosition, metaPosition, dataPosition);
            CL024_cl022: UpdateData(PRecord.cl022, PropPosition, metaPosition, dataPosition);
            CL024_loinc: UpdateData(PRecord.loinc, PropPosition, metaPosition, dataPosition);
            CL024_units: UpdateData(PRecord.units, PropPosition, metaPosition, dataPosition);
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

{ TCL024Coll }

function TCL024Coll.AddItem(ver: word): TCL024Item;
begin
  Result := TCL024Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TCL024Coll.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListCL024Search := TList<TCL024Item>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TCL024Coll.destroy;
begin
  FreeAndNil(ListCL024Search);
  inherited;
end;

function TCL024Coll.DisplayName(propIndex: Word): string;
begin
  case TCL024Item.TPropertyIndex(propIndex) of
    CL024_Key: Result := 'Key';
    CL024_Description: Result := 'Description';
    CL024_ucum: Result := 'ucum';
    CL024_cl032: Result := 'cl032';
    CL024_cl028: Result := 'cl028';
    CL024_old_key: Result := 'old_key';
    CL024_cl022: Result := 'cl022';
    CL024_loinc: Result := 'loinc';
    CL024_units: Result := 'units';
  end;
end;

procedure TCL024Coll.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TCL024Item.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TCL024Coll.FieldCount: Integer;
begin
  Result := 9;
end;

procedure TCL024Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL024: TCL024Item;
  ACol: Integer;
  prop: TCL024Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL024 := Items[ARow];
  prop := TCL024Item.TPropertyIndex(ACol);
  if Assigned(CL024.PRecord) and (prop in CL024.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL024, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL024, AValue);
  end;
end;

procedure TCL024Coll.GetCellFromRecord(propIndex: word; CL024: TCL024Item; var AValue: String);
var
  str: string;
begin
  case TCL024Item.TPropertyIndex(propIndex) of
    CL024_Key: str := (CL024.PRecord.Key);
    CL024_Description: str := (CL024.PRecord.Description);
    CL024_ucum: str := (CL024.PRecord.ucum);
    CL024_cl032: str := (CL024.PRecord.cl032);
    CL024_cl028: str := (CL024.PRecord.cl028);
    CL024_old_key: str := (CL024.PRecord.old_key);
    CL024_cl022: str := (CL024.PRecord.cl022);
    CL024_loinc: str := (CL024.PRecord.loinc);
    CL024_units: str := (CL024.PRecord.units);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL024Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL024: TCL024Item;
  ACol: Integer;
  prop: TCL024Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL024 := ListCL024Search[ARow];
  prop := TCL024Item.TPropertyIndex(ACol);
  if Assigned(CL024.PRecord) and (prop in CL024.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL024, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL024, AValue);
  end;
end;

procedure TCL024Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL024: TCL024Item;
  prop: TCL024Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL024 := Items[ARow];
  prop := TCL024Item.TPropertyIndex(ACol);
  if Assigned(CL024.PRecord) and (prop in CL024.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL024, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL024, AFieldText);
  end;
end;

procedure TCL024Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL024: TCL024Item; var AValue: String);
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
  case TCL024Item.TPropertyIndex(propIndex) of
    CL024_Key: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_Description: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_ucum: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_cl032: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_cl028: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_old_key: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_cl022: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_loinc: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_units: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL024Coll.GetItem(Index: Integer): TCL024Item;
begin
  Result := TCL024Item(inherited GetItem(Index));
end;


procedure TCL024Coll.IndexValue(propIndex: TCL024Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL024Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL024_Key:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      CL024_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL024_ucum:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL024_cl032:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL024_cl028:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL024_old_key:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL024_cl022:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL024_loinc:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL024_units:
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

procedure TCL024Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL024: TCL024Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  CL024 := Items[ARow];
  if not Assigned(CL024.PRecord) then
  begin
    New(CL024.PRecord);
    CL024.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL024Item.TPropertyIndex(ACol) of
      CL024_Key: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_Description: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_ucum: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_cl032: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_cl028: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_old_key: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_cl022: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_loinc: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_units: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL024.PRecord.setProp, TCL024Item.TPropertyIndex(ACol));
    if CL024.PRecord.setProp = [] then
    begin
      Dispose(CL024.PRecord);
      CL024.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL024.PRecord.setProp, TCL024Item.TPropertyIndex(ACol));
  case TCL024Item.TPropertyIndex(ACol) of
    CL024_Key: CL024.PRecord.Key := AValue;
    CL024_Description: CL024.PRecord.Description := AValue;
    CL024_ucum: CL024.PRecord.ucum := AValue;
    CL024_cl032: CL024.PRecord.cl032 := AValue;
    CL024_cl028: CL024.PRecord.cl028 := AValue;
    CL024_old_key: CL024.PRecord.old_key := AValue;
    CL024_cl022: CL024.PRecord.cl022 := AValue;
    CL024_loinc: CL024.PRecord.loinc := AValue;
    CL024_units: CL024.PRecord.units := AValue;
  end;
end;

procedure TCL024Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL024: TCL024Item;
begin
  if Count = 0 then Exit;

  CL024 := Items[ARow];
  if not Assigned(CL024.PRecord) then
  begin
    New(CL024.PRecord);
    CL024.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL024Item.TPropertyIndex(ACol) of
      CL024_Key: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_Description: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_ucum: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_cl032: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_cl028: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_old_key: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_cl022: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_loinc: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_units: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL024.PRecord.setProp, TCL024Item.TPropertyIndex(ACol));
    if CL024.PRecord.setProp = [] then
    begin
      Dispose(CL024.PRecord);
      CL024.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL024.PRecord.setProp, TCL024Item.TPropertyIndex(ACol));
  case TCL024Item.TPropertyIndex(ACol) of
    CL024_Key: CL024.PRecord.Key := AFieldText;
    CL024_Description: CL024.PRecord.Description := AFieldText;
    CL024_ucum: CL024.PRecord.ucum := AFieldText;
    CL024_cl032: CL024.PRecord.cl032 := AFieldText;
    CL024_cl028: CL024.PRecord.cl028 := AFieldText;
    CL024_old_key: CL024.PRecord.old_key := AFieldText;
    CL024_cl022: CL024.PRecord.cl022 := AFieldText;
    CL024_loinc: CL024.PRecord.loinc := AFieldText;
    CL024_units: CL024.PRecord.units := AFieldText;
  end;
end;

procedure TCL024Coll.SetItem(Index: Integer; const Value: TCL024Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL024Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL024Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL024Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL024_Key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL024Search.Add(self.Items[i]);
  end;
end;
      CL024_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL024Search.Add(self.Items[i]);
        end;
      end;
      CL024_ucum:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL024Search.Add(self.Items[i]);
        end;
      end;
      CL024_cl032:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL024Search.Add(self.Items[i]);
        end;
      end;
      CL024_cl028:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL024Search.Add(self.Items[i]);
        end;
      end;
      CL024_old_key:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL024Search.Add(self.Items[i]);
        end;
      end;
      CL024_cl022:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL024Search.Add(self.Items[i]);
        end;
      end;
      CL024_loinc:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL024Search.Add(self.Items[i]);
        end;
      end;
      CL024_units:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL024Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCL024Coll.ShowGrid(Grid: TTeeGrid);
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

procedure TCL024Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL024Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL024Search.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TCL024Coll.SortByIndexAnsiString;
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

procedure TCL024Coll.SortByIndexInt;
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

procedure TCL024Coll.SortByIndexWord;
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

procedure TCL024Coll.SortByIndexValue(propIndex: TCL024Item.TPropertyIndex);
begin
  case propIndex of
    CL024_Key: SortByIndexAnsiString;
      CL024_Description: SortByIndexAnsiString;
      CL024_ucum: SortByIndexAnsiString;
      CL024_cl032: SortByIndexAnsiString;
      CL024_cl028: SortByIndexAnsiString;
      CL024_old_key: SortByIndexAnsiString;
      CL024_cl022: SortByIndexAnsiString;
      CL024_loinc: SortByIndexAnsiString;
      CL024_units: SortByIndexAnsiString;
  end;
end;

end.