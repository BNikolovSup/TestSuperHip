unit Table.CL142;

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


TCL142Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
CL142_Key
, CL142_Description
, CL142_DescriptionEn
, CL142_achi_block
, CL142_achi_chapter
, CL142_achi_code
, CL142_nhif_code
, CL142_cl048
, CL142_cl006
, CL142_highly
);
	  
      TSetProp = set of TPropertyIndex;
      PRecCL142 = ^TRecCL142;
      TRecCL142 = record
        Key: AnsiString;
        Description: AnsiString;
        DescriptionEn: AnsiString;
        achi_block: AnsiString;
        achi_chapter: AnsiString;
        achi_code: AnsiString;
        nhif_code: AnsiString;
        cl048: AnsiString;
        cl006: AnsiString;
        highly: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL142;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL142;
    procedure UpdateCL142;
    procedure SaveCL142(var dataPosition: Cardinal);
  	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
    procedure FillPropCl142(propindex: TPropertyIndex; stream: TStream);
    procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
  end;


  TCL142Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TCL142Item;
    procedure SetItem(Index: Integer; const Value: TCL142Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TCL142Item;
	ListForFDB: TList<TCL142Item>;
    ListCL142Search: TList<TCL142Item>;
	PRecordSearch: ^TCL142Item.TRecCL142;
    ArrPropSearch: TArray<TCL142Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCL142Item.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL142Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAsectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; CL142: TCL142Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL142: TCL142Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TCL142Item.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL142Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL142Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCL142Item.TPropertyIndex);
    property Items[Index: Integer]: TCL142Item read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
  end;

implementation

{ TCL142Item }

constructor TCL142Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL142Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL142Item.FillPropCl142(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    CL142_Key:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Key, lenstr);
      stream.Read(Self.PRecord.Key[1], lenStr);
    end;
    CL142_Description:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Description, lenstr);
      stream.Read(Self.PRecord.Description[1], lenStr);
    end;
    CL142_DescriptionEn:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.DescriptionEn, lenstr);
      stream.Read(Self.PRecord.DescriptionEn[1], lenStr);
    end;
    CL142_achi_block:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.achi_block, lenstr);
      stream.Read(Self.PRecord.achi_block[1], lenStr);
    end;

    CL142_achi_chapter:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.achi_chapter, lenstr);
      stream.Read(Self.PRecord.achi_chapter[1], lenStr);
    end;
    CL142_achi_code:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.achi_code, lenstr);
      stream.Read(Self.PRecord.achi_code[1], lenStr);
    end;
    CL142_nhif_code:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.nhif_code, lenstr);
      stream.Read(Self.PRecord.nhif_code[1], lenStr);
    end;
    CL142_cl048:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl048, lenstr);
      stream.Read(Self.PRecord.cl048[1], lenStr);
    end;

    CL142_cl006:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl006, lenstr);
      stream.Read(Self.PRecord.cl006[1], lenStr);
    end;
    CL142_highly:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.highly, lenstr);
      stream.Read(Self.PRecord.highly[1], lenStr);
    end;
  end;
end;

procedure TCL142Item.InsertCL142;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL142;
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
            CL142_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL142_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL142_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL142_achi_block: SaveData(PRecord.achi_block, PropPosition, metaPosition, dataPosition);
            CL142_achi_chapter: SaveData(PRecord.achi_chapter, PropPosition, metaPosition, dataPosition);
            CL142_achi_code: SaveData(PRecord.achi_code, PropPosition, metaPosition, dataPosition);
            CL142_nhif_code: SaveData(PRecord.nhif_code, PropPosition, metaPosition, dataPosition);
            CL142_cl048: SaveData(PRecord.cl048, PropPosition, metaPosition, dataPosition);
            CL142_cl006: SaveData(PRecord.cl006, PropPosition, metaPosition, dataPosition);
            CL142_highly: SaveData(PRecord.highly, PropPosition, metaPosition, dataPosition);
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

function  TCL142Item.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TCL142Item.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TCL142Item;
begin
  Result := True;
  for i := 0 to Length(TCL142Coll(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TCL142Coll(coll).ArrPropSearchClc[i];
	ATempItem := TCL142Coll(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        CL142_Key: Result := IsFinded(ATempItem.PRecord.Key, buf, FPosDataADB, word(CL142_Key), cot);
            CL142_Description: Result := IsFinded(ATempItem.PRecord.Description, buf, FPosDataADB, word(CL142_Description), cot);
            CL142_DescriptionEn: Result := IsFinded(ATempItem.PRecord.DescriptionEn, buf, FPosDataADB, word(CL142_DescriptionEn), cot);
            CL142_achi_block: Result := IsFinded(ATempItem.PRecord.achi_block, buf, FPosDataADB, word(CL142_achi_block), cot);
            CL142_achi_chapter: Result := IsFinded(ATempItem.PRecord.achi_chapter, buf, FPosDataADB, word(CL142_achi_chapter), cot);
            CL142_achi_code: Result := IsFinded(ATempItem.PRecord.achi_code, buf, FPosDataADB, word(CL142_achi_code), cot);
            CL142_nhif_code: Result := IsFinded(ATempItem.PRecord.nhif_code, buf, FPosDataADB, word(CL142_nhif_code), cot);
            CL142_cl048: Result := IsFinded(ATempItem.PRecord.cl048, buf, FPosDataADB, word(CL142_cl048), cot);
            CL142_cl006: Result := IsFinded(ATempItem.PRecord.cl006, buf, FPosDataADB, word(CL142_cl006), cot);
            CL142_highly: Result := IsFinded(ATempItem.PRecord.highly, buf, FPosDataADB, word(CL142_highly), cot);
      end;
    end;
  end;
end;

procedure TCL142Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds16: TLogicalData16;
  propindexcl142: TCL142Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData16);
  stream.Read(flds16, sizeof(TLogicalData16));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := Tcl142Item.TSetProp(flds16);// тука се записва какво има като полета


  for propindexcl142 := Low(Tcl142Item.TPropertyIndex) to High(Tcl142Item.TPropertyIndex) do
  begin
    if not (propindexcl142 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexcl142);
      dataCmdProp.vid := vvCl142;
    end;
    self.FillPropCl142(propindexcl142, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCL142Item.SaveCL142(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL142;
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
            CL142_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL142_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL142_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL142_achi_block: SaveData(PRecord.achi_block, PropPosition, metaPosition, dataPosition);
            CL142_achi_chapter: SaveData(PRecord.achi_chapter, PropPosition, metaPosition, dataPosition);
            CL142_achi_code: SaveData(PRecord.achi_code, PropPosition, metaPosition, dataPosition);
            CL142_nhif_code: SaveData(PRecord.nhif_code, PropPosition, metaPosition, dataPosition);
            CL142_cl048: SaveData(PRecord.cl048, PropPosition, metaPosition, dataPosition);
            CL142_cl006: SaveData(PRecord.cl006, PropPosition, metaPosition, dataPosition);
            CL142_highly: SaveData(PRecord.highly, PropPosition, metaPosition, dataPosition);
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

procedure TCL142Item.UpdateCL142;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL142;
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
            CL142_Key: UpdateData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL142_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL142_DescriptionEn: UpdateData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL142_achi_block: UpdateData(PRecord.achi_block, PropPosition, metaPosition, dataPosition);
            CL142_achi_chapter: UpdateData(PRecord.achi_chapter, PropPosition, metaPosition, dataPosition);
            CL142_achi_code: UpdateData(PRecord.achi_code, PropPosition, metaPosition, dataPosition);
            CL142_nhif_code: UpdateData(PRecord.nhif_code, PropPosition, metaPosition, dataPosition);
            CL142_cl048: UpdateData(PRecord.cl048, PropPosition, metaPosition, dataPosition);
            CL142_cl006: UpdateData(PRecord.cl006, PropPosition, metaPosition, dataPosition);
            CL142_highly: UpdateData(PRecord.highly, PropPosition, metaPosition, dataPosition);
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

{ TCL142Coll }

function TCL142Coll.AddItem(ver: word): TCL142Item;
begin
  Result := TCL142Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TCL142Coll.AddItemForSearch: Integer;
var
  ItemForSearch: TCL142Item;
begin
  ItemForSearch := TCL142Item.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  //ItemForSearch.PRecord.Logical := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TCL142Coll.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TCL142Item.Create(nil);
  ListCL142Search := TList<TCL142Item>.Create;
  ListForFDB := TList<TCL142Item>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TCL142Coll.destroy;
begin
  FreeAndNil(ListCL142Search);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TCL142Coll.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TCL142Item.TPropertyIndex(propIndex) of
    CL142_Key: Result := 'Key';
    CL142_Description: Result := 'Description';
    CL142_DescriptionEn: Result := 'DescriptionEn';
    CL142_achi_block: Result := 'achi_block';
    CL142_achi_chapter: Result := 'achi_chapter';
    CL142_achi_code: Result := 'achi_code';
    CL142_nhif_code: Result := 'nhif_code';
    CL142_cl048: Result := 'cl048';
    CL142_cl006: Result := 'cl006';
    CL142_highly: Result := 'highly';
  end;
end;

procedure TCL142Coll.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TCL142Item.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TCL142Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 10;
end;

procedure TCL142Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL142: TCL142Item;
  ACol: Integer;
  prop: TCL142Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL142 := Items[ARow];
  prop := TCL142Item.TPropertyIndex(ACol);
  if Assigned(CL142.PRecord) and (prop in CL142.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL142, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL142, AValue);
  end;
end;

procedure TCL142Coll.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL142Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  prop := TCL142Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL142Coll.GetCellFromRecord(propIndex: word; CL142: TCL142Item; var AValue: String);
var
  str: string;
begin
  case TCL142Item.TPropertyIndex(propIndex) of
    CL142_Key: str := (CL142.PRecord.Key);
    CL142_Description: str := (CL142.PRecord.Description);
    CL142_DescriptionEn: str := (CL142.PRecord.DescriptionEn);
    CL142_achi_block: str := (CL142.PRecord.achi_block);
    CL142_achi_chapter: str := (CL142.PRecord.achi_chapter);
    CL142_achi_code: str := (CL142.PRecord.achi_code);
    CL142_nhif_code: str := (CL142.PRecord.nhif_code);
    CL142_cl048: str := (CL142.PRecord.cl048);
    CL142_cl006: str := (CL142.PRecord.cl006);
    CL142_highly: str := (CL142.PRecord.highly);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL142Coll.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TCL142Item;
  ACol: Integer;
  prop: TCL142Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TCL142Item.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TCL142Coll.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL142Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TCL142Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL142Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL142: TCL142Item;
  ACol: Integer;
  prop: TCL142Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL142 := ListCL142Search[ARow];
  prop := TCL142Item.TPropertyIndex(ACol);
  if Assigned(CL142.PRecord) and (prop in CL142.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL142, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL142, AValue);
  end;
end;

procedure TCL142Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL142: TCL142Item;
  prop: TCL142Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL142 := Items[ARow];
  prop := TCL142Item.TPropertyIndex(ACol);
  if Assigned(CL142.PRecord) and (prop in CL142.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL142, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL142, AFieldText);
  end;
end;

procedure TCL142Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL142: TCL142Item; var AValue: String);
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
  case TCL142Item.TPropertyIndex(propIndex) of
    CL142_Key: str :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL142_Description: str :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL142_DescriptionEn: str :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL142_achi_block: str :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL142_achi_chapter: str :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL142_achi_code: str :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL142_nhif_code: str :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL142_cl048: str :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL142_cl006: str :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL142_highly: str :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL142Coll.GetItem(Index: Integer): TCL142Item;
begin
  Result := TCL142Item(inherited GetItem(Index));
end;


procedure TCL142Coll.IndexValue(propIndex: TCL142Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL142Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL142_Key:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL142_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL142_DescriptionEn:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL142_achi_block:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL142_achi_chapter:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL142_achi_code:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL142_nhif_code:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL142_cl048:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL142_cl006:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL142_highly:
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

procedure TCL142Coll.IndexValueListNodes(propIndex: TCL142Item.TPropertyIndex);
begin

end;

procedure TCL142Coll.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TCL142Item;
begin
  if index < 0 then
  begin
    Tempitem := TCL142Item.Create(nil);
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



function TCL142Coll.PropType(propIndex: Word): TAsectTypeKind;
begin
  inherited;
  case TCL142Item.TPropertyIndex(propIndex) of
    CL142_Key: Result := actAnsiString;
    CL142_Description: Result := actAnsiString;
    CL142_DescriptionEn: Result := actAnsiString;
    CL142_achi_block: Result := actAnsiString;
    CL142_achi_chapter: Result := actAnsiString;
    CL142_achi_code: Result := actAnsiString;
    CL142_nhif_code: Result := actAnsiString;
    CL142_cl048: Result := actAnsiString;
    CL142_cl006: Result := actAnsiString;
    CL142_highly: Result := actAnsiString;
  else
    Result := actNone;
  end
end;

procedure TCL142Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL142: TCL142Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  CL142 := Items[ARow];
  if not Assigned(CL142.PRecord) then
  begin
    New(CL142.PRecord);
    CL142.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL142Item.TPropertyIndex(ACol) of
      CL142_Key: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL142_Description: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL142_DescriptionEn: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL142_achi_block: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL142_achi_chapter: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL142_achi_code: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL142_nhif_code: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL142_cl048: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL142_cl006: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL142_highly: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL142.PRecord.setProp, TCL142Item.TPropertyIndex(ACol));
    if CL142.PRecord.setProp = [] then
    begin
      Dispose(CL142.PRecord);
      CL142.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL142.PRecord.setProp, TCL142Item.TPropertyIndex(ACol));
  case TCL142Item.TPropertyIndex(ACol) of
    CL142_Key: CL142.PRecord.Key := AValue;
    CL142_Description: CL142.PRecord.Description := AValue;
    CL142_DescriptionEn: CL142.PRecord.DescriptionEn := AValue;
    CL142_achi_block: CL142.PRecord.achi_block := AValue;
    CL142_achi_chapter: CL142.PRecord.achi_chapter := AValue;
    CL142_achi_code: CL142.PRecord.achi_code := AValue;
    CL142_nhif_code: CL142.PRecord.nhif_code := AValue;
    CL142_cl048: CL142.PRecord.cl048 := AValue;
    CL142_cl006: CL142.PRecord.cl006 := AValue;
    CL142_highly: CL142.PRecord.highly := AValue;
  end;
end;

procedure TCL142Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL142: TCL142Item;
begin
  if Count = 0 then Exit;

  CL142 := Items[ARow];
  if not Assigned(CL142.PRecord) then
  begin
    New(CL142.PRecord);
    CL142.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL142Item.TPropertyIndex(ACol) of
      CL142_Key: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL142_Description: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL142_DescriptionEn: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL142_achi_block: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL142_achi_chapter: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL142_achi_code: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL142_nhif_code: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL142_cl048: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL142_cl006: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL142_highly: isOld :=  CL142.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL142.PRecord.setProp, TCL142Item.TPropertyIndex(ACol));
    if CL142.PRecord.setProp = [] then
    begin
      Dispose(CL142.PRecord);
      CL142.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL142.PRecord.setProp, TCL142Item.TPropertyIndex(ACol));
  case TCL142Item.TPropertyIndex(ACol) of
    CL142_Key: CL142.PRecord.Key := AFieldText;
    CL142_Description: CL142.PRecord.Description := AFieldText;
    CL142_DescriptionEn: CL142.PRecord.DescriptionEn := AFieldText;
    CL142_achi_block: CL142.PRecord.achi_block := AFieldText;
    CL142_achi_chapter: CL142.PRecord.achi_chapter := AFieldText;
    CL142_achi_code: CL142.PRecord.achi_code := AFieldText;
    CL142_nhif_code: CL142.PRecord.nhif_code := AFieldText;
    CL142_cl048: CL142.PRecord.cl048 := AFieldText;
    CL142_cl006: CL142.PRecord.cl006 := AFieldText;
    CL142_highly: CL142.PRecord.highly := AFieldText;
  end;
end;

procedure TCL142Coll.SetItem(Index: Integer; const Value: TCL142Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL142Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL142Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL142Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL142_Key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL142Search.Add(self.Items[i]);
  end;
end;
      CL142_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL142Search.Add(self.Items[i]);
        end;
      end;
      CL142_DescriptionEn:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL142Search.Add(self.Items[i]);
        end;
      end;
      CL142_achi_block:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL142Search.Add(self.Items[i]);
        end;
      end;
      CL142_achi_chapter:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL142Search.Add(self.Items[i]);
        end;
      end;
      CL142_achi_code:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL142Search.Add(self.Items[i]);
        end;
      end;
      CL142_nhif_code:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL142Search.Add(self.Items[i]);
        end;
      end;
      CL142_cl048:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL142Search.Add(self.Items[i]);
        end;
      end;
      CL142_cl006:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL142Search.Add(self.Items[i]);
        end;
      end;
      CL142_highly:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL142Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCL142Coll.ShowGrid(Grid: TTeeGrid);
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

procedure TCL142Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL142Item>);
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

procedure TCL142Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL142Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL142Search.Count]);

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

procedure TCL142Coll.SortByIndexAnsiString;
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

procedure TCL142Coll.SortByIndexInt;
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

procedure TCL142Coll.SortByIndexWord;
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

procedure TCL142Coll.SortByIndexValue(propIndex: TCL142Item.TPropertyIndex);
begin
  case propIndex of
    CL142_Key: SortByIndexAnsiString;
      CL142_Description: SortByIndexAnsiString;
      CL142_DescriptionEn: SortByIndexAnsiString;
      CL142_achi_block: SortByIndexAnsiString;
      CL142_achi_chapter: SortByIndexAnsiString;
      CL142_achi_code: SortByIndexAnsiString;
      CL142_nhif_code: SortByIndexAnsiString;
      CL142_cl048: SortByIndexAnsiString;
      CL142_cl006: SortByIndexAnsiString;
      CL142_highly: SortByIndexAnsiString;
  end;
end;

end.