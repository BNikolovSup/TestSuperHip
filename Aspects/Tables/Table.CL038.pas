unit Table.CL038;

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


TCL038Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (CL038_key
, CL038_description
, CL038_immun_type
, CL038_dose_number
, CL038_vaccine_code
, CL038_cl028
);
      TSetProp = set of TPropertyIndex;
      PRecCL038 = ^TRecCL038;
      TRecCL038 = record
        key: AnsiString;
        description: AnsiString;
        immun_type: AnsiString;
        dose_number: AnsiString;
        vaccine_code: AnsiString;
        cl028: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL038;
	IndexInt: Integer;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL038;
    procedure UpdateCL038;
    procedure SaveCL038(var dataPosition: Cardinal);
    procedure FillPropCl038(propindex: TPropertyIndex; stream: TStream);
    procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
  end;


  TCL038Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TCL038Item;
    procedure SetItem(Index: Integer; const Value: TCL038Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
    ListCL038Search: TList<TCL038Item>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL038Item;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellFromMap(propIndex: word; ARow: Integer; CL038: TCL038Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL038: TCL038Item; var AValue:String);
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TCL038Item.TPropertyIndex);
    procedure SortByIndexInt;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string;
	function FieldCount: Integer;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL038Item.TPropertyIndex);
    property Items[Index: Integer]: TCL038Item read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
  end;

implementation

{ TCL038Item }

constructor TCL038Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL038Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL038Item.FillPropCl038(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    CL038_key:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Key, lenstr);
      stream.Read(Self.PRecord.Key[1], lenStr);
    end;
    CL038_description:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Description, lenstr);
      stream.Read(Self.PRecord.Description[1], lenStr);
    end;
    CL038_immun_type:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.immun_type, lenstr);
      stream.Read(Self.PRecord.immun_type[1], lenStr);
    end;
    CL038_dose_number:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.dose_number, lenstr);
      stream.Read(Self.PRecord.dose_number[1], lenStr);
    end;
    CL038_vaccine_code:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.vaccine_code, lenstr);
      stream.Read(Self.PRecord.vaccine_code[1], lenStr);
    end;
    CL038_cl028:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl028, lenstr);
      stream.Read(Self.PRecord.cl028[1], lenStr);
    end;
  end;
end;

procedure TCL038Item.InsertCL038;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL038;
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
	  
      for propIndx := Low(TPropertyIndex) to High(TPropertyIndex) do
      begin
        if Assigned(PRecord) and (propIndx in PRecord.setProp) then
        begin
          case propIndx of
            CL038_key: SaveData(PRecord.key, PropPosition, metaPosition, dataPosition);
            CL038_description: SaveData(PRecord.description, PropPosition, metaPosition, dataPosition);
            CL038_immun_type: SaveData(PRecord.immun_type, PropPosition, metaPosition, dataPosition);
            CL038_dose_number: SaveData(PRecord.dose_number, PropPosition, metaPosition, dataPosition);
            CL038_vaccine_code: SaveData(PRecord.vaccine_code, PropPosition, metaPosition, dataPosition);
            CL038_cl028: SaveData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
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

procedure TCL038Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds08: TLogicalData08;
  propindexcl038: TCL038Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData08);
  stream.Read(flds08, sizeof(TLogicalData08));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := Tcl038Item.TSetProp(flds08);// тука се записва какво има като полета

  for propindexcl038 := Low(Tcl038Item.TPropertyIndex) to High(Tcl038Item.TPropertyIndex) do
  begin
    if not (propindexcl038 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexcl038);
      dataCmdProp.vid := vvCl038;
    end;
    self.FillPropCl038(propindexcl038, stream);
  end;
  CmdItem.AdbItem := self;
end;

procedure TCL038Item.SaveCL038(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL038;
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
            CL038_key: SaveData(PRecord.key, PropPosition, metaPosition, dataPosition);
            CL038_description: SaveData(PRecord.description, PropPosition, metaPosition, dataPosition);
            CL038_immun_type: SaveData(PRecord.immun_type, PropPosition, metaPosition, dataPosition);
            CL038_dose_number: SaveData(PRecord.dose_number, PropPosition, metaPosition, dataPosition);
            CL038_vaccine_code: SaveData(PRecord.vaccine_code, PropPosition, metaPosition, dataPosition);
            CL038_cl028: SaveData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
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

procedure TCL038Item.UpdateCL038;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL038;
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
            CL038_key: UpdateData(PRecord.key, PropPosition, metaPosition, dataPosition);
            CL038_description: UpdateData(PRecord.description, PropPosition, metaPosition, dataPosition);
            CL038_immun_type: UpdateData(PRecord.immun_type, PropPosition, metaPosition, dataPosition);
            CL038_dose_number: UpdateData(PRecord.dose_number, PropPosition, metaPosition, dataPosition);
            CL038_vaccine_code: UpdateData(PRecord.vaccine_code, PropPosition, metaPosition, dataPosition);
            CL038_cl028: UpdateData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
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

{ TCL038Coll }

function TCL038Coll.AddItem(ver: word): TCL038Item;
begin
  Result := TCL038Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;


constructor TCL038Coll.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  ListCL038Search := TList<TCL038Item>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
end;

destructor TCL038Coll.destroy;
begin
  FreeAndNil(ListCL038Search);
  inherited;
end;

function TCL038Coll.DisplayName(propIndex: Word): string;
begin
  case TCL038Item.TPropertyIndex(propIndex) of
    CL038_key: Result := 'key';
    CL038_description: Result := 'description';
    CL038_immun_type: Result := 'immun_type';
    CL038_dose_number: Result := 'dose_number';
    CL038_vaccine_code: Result := 'vaccine_code';
    CL038_cl028: Result := 'cl028';
  end;
end;

procedure TCL038Coll.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TCL038Item.TPropertyIndex(self.FindedRes.PropIndex));
  //Self.SortByIndexValue;
end;

function TCL038Coll.FieldCount: Integer;
begin
  Result := 6;
end;

procedure TCL038Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL038: TCL038Item;
  ACol: Integer;
  prop: TCL038Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL038 := Items[ARow];
  prop := TCL038Item.TPropertyIndex(ACol);
  if Assigned(CL038.PRecord) and (prop in CL038.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL038, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL038, AValue);
  end;
end;

procedure TCL038Coll.GetCellFromRecord(propIndex: word; CL038: TCL038Item; var AValue: String);
var
  str: string;
begin
  case TCL038Item.TPropertyIndex(propIndex) of
    CL038_key: str := (CL038.PRecord.key);
    CL038_description: str := (CL038.PRecord.description);
    CL038_immun_type: str := (CL038.PRecord.immun_type);
    CL038_dose_number: str := (CL038.PRecord.dose_number);
    CL038_vaccine_code: str := (CL038.PRecord.vaccine_code);
    CL038_cl028: str := (CL038.PRecord.cl028);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL038Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL038: TCL038Item;
  ACol: Integer;
  prop: TCL038Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL038 := ListCL038Search[ARow];
  prop := TCL038Item.TPropertyIndex(ACol);
  if Assigned(CL038.PRecord) and (prop in CL038.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL038, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL038, AValue);
  end;
end;

procedure TCL038Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL038: TCL038Item;
  prop: TCL038Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL038 := Items[ARow];
  prop := TCL038Item.TPropertyIndex(ACol);
  if Assigned(CL038.PRecord) and (prop in CL038.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL038, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL038, AFieldText);
  end;
end;

procedure TCL038Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL038: TCL038Item; var AValue: String);
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
  case TCL038Item.TPropertyIndex(propIndex) of
    CL038_key: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_description: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_immun_type: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_dose_number: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_vaccine_code: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL038_cl028: str :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL038Coll.GetItem(Index: Integer): TCL038Item;
begin
  Result := TCL038Item(inherited GetItem(Index));
end;


procedure TCL038Coll.IndexValue(propIndex: TCL038Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL038Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL038_key:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      CL038_description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL038_immun_type:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL038_dose_number:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL038_vaccine_code:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
     CL038_cl028:
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

procedure TCL038Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL038: TCL038Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  CL038 := Items[ARow];
  if not Assigned(CL038.PRecord) then
  begin
    New(CL038.PRecord);
    CL038.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL038Item.TPropertyIndex(ACol) of
      CL038_key: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      CL038_description: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      CL038_immun_type: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      CL038_dose_number: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      CL038_vaccine_code: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
      CL038_cl028: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL038.PRecord.setProp, TCL038Item.TPropertyIndex(ACol));
    if CL038.PRecord.setProp = [] then
    begin
      Dispose(CL038.PRecord);
      CL038.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL038.PRecord.setProp, TCL038Item.TPropertyIndex(ACol));
  case TCL038Item.TPropertyIndex(ACol) of
    CL038_key: CL038.PRecord.key := AValue;
    CL038_description: CL038.PRecord.description := AValue;
    CL038_immun_type: CL038.PRecord.immun_type := AValue;
    CL038_dose_number: CL038.PRecord.dose_number := AValue;
    CL038_vaccine_code: CL038.PRecord.vaccine_code := AValue;
    CL038_cl028: CL038.PRecord.cl028 := AValue;
  end;
end;

procedure TCL038Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL038: TCL038Item;
begin
  if Count = 0 then Exit;

  CL038 := Items[ARow];
  if not Assigned(CL038.PRecord) then
  begin
    New(CL038.PRecord);
    CL038.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL038Item.TPropertyIndex(ACol) of
      CL038_key: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      CL038_description: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      CL038_immun_type: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      CL038_dose_number: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      CL038_vaccine_code: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
      CL038_cl028: isOld :=  CL038.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL038.PRecord.setProp, TCL038Item.TPropertyIndex(ACol));
    if CL038.PRecord.setProp = [] then
    begin
      Dispose(CL038.PRecord);
      CL038.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL038.PRecord.setProp, TCL038Item.TPropertyIndex(ACol));
  case TCL038Item.TPropertyIndex(ACol) of
    CL038_key: CL038.PRecord.key := AFieldText;
    CL038_description: CL038.PRecord.description := AFieldText;
    CL038_immun_type: CL038.PRecord.immun_type := AFieldText;
    CL038_dose_number: CL038.PRecord.dose_number := AFieldText;
    CL038_vaccine_code: CL038.PRecord.vaccine_code := AFieldText;
    CL038_cl028: CL038.PRecord.cl028 := AFieldText;
  end;
end;

procedure TCL038Coll.SetItem(Index: Integer; const Value: TCL038Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL038Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL038Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL038Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL038_key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL038Search.Add(self.Items[i]);
  end;
end;
      CL038_description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL038Search.Add(self.Items[i]);
        end;
      end;
      CL038_immun_type:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL038Search.Add(self.Items[i]);
        end;
      end;
      CL038_dose_number:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL038Search.Add(self.Items[i]);
        end;
      end;
      CL038_vaccine_code:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL038Search.Add(self.Items[i]);
        end;
      end;
      CL038_cl028:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL038Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCL038Coll.ShowGrid(Grid: TTeeGrid);
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

end;

procedure TCL038Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL038Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL038Search.Count]);

  TVirtualModeData(Grid.Data).OnGetValue:=self.GetCellSearch;
  TVirtualModeData(Grid.Data).OnSetValue:=nil;

  for i := 0 to self.FieldCount - 1 do
  begin
    Grid.Columns[i].Width.Value := 110;
  end;

  Grid.Columns[self.FieldCount].Width.Value := 90;
  Grid.Columns[self.FieldCount].Index := 0;

end;

procedure TCL038Coll.SortByIndexAnsiString;
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

procedure TCL038Coll.SortByIndexInt;
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

procedure TCL038Coll.SortByIndexValue(propIndex: TCL038Item.TPropertyIndex);
begin
  case propIndex of
    CL038_key: SortByIndexAnsiString;
      CL038_description: SortByIndexAnsiString;
      CL038_immun_type: SortByIndexAnsiString;
      CL038_dose_number: SortByIndexAnsiString;
      CL038_vaccine_code: SortByIndexAnsiString;
      CL038_cl028: SortByIndexAnsiString;
  end;
end;

end.