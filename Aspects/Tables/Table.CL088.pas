unit Table.CL088;

interface
uses
  Aspects.Collections, Aspects.Types,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control ;


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


TCL088Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
CL088_Key
, CL088_Description
, CL088_DescriptionEn
, CL088_ucum
, CL088_cl050
, CL088_cl012
, CL088_cl028
, CL088_cl032
, CL088_cl138
, CL088_conclusion
, CL088_note
, CL088_cl142
);

      TSetProp = set of TPropertyIndex;
      PRecCL088 = ^TRecCL088;
      TRecCL088 = record
        Key: AnsiString;
        Description: AnsiString;
        DescriptionEn: AnsiString;
        ucum: AnsiString;
        cl050: AnsiString;
        cl012: AnsiString;
        cl028: AnsiString;
        cl032: AnsiString;
        cl138: AnsiString;
        conclusion: AnsiString;
        note: AnsiString;
        cl142: AnsiString;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL088;
  	IndexInt: Integer;
   	IndexWord: Word;
  	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL088;
    procedure UpdateCL088;
    procedure SaveCL088(var dataPosition: Cardinal);
  	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
    procedure FillPropCl088(propindex: TPropertyIndex; stream: TStream);
    procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
  end;


  TCL088Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
    function GetItem(Index: Integer): TCL088Item;
    procedure SetItem(Index: Integer; const Value: TCL088Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	tempItem: TCL088Item;
	ListForFDB: TList<TCL088Item>;
    ListCL088Search: TList<TCL088Item>;
	PRecordSearch: ^TCL088Item.TRecCL088;
    ArrPropSearch: TArray<TCL088Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCL088Item.TPropertyIndex>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL088Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; CL088: TCL088Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL088: TCL088Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
	procedure DynControlEnter(Sender: TObject);
    procedure SortByIndexValue(propIndex: TCL088Item.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;

	function DisplayName(propIndex: Word): string; override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL088Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL088Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCL088Item.TPropertyIndex);
    property Items[Index: Integer]: TCL088Item read GetItem write SetItem;
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    //procedure OnSetTextSearchLog(Log: TlogicalCL088Set);
  end;

implementation

{ TCL088Item }

constructor TCL088Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL088Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL088Item.FillPropCl088(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    CL088_Key:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Key, lenstr);
      stream.Read(Self.PRecord.Key[1], lenStr);
    end;
    CL088_Description:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.Description, lenstr);
      stream.Read(Self.PRecord.Description[1], lenStr);
    end;
    CL088_DescriptionEn:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.DescriptionEn, lenstr);
      stream.Read(Self.PRecord.DescriptionEn[1], lenStr);
    end;
    CL088_ucum:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.ucum, lenstr);
      stream.Read(Self.PRecord.ucum[1], lenStr);
    end;
    CL088_cl050:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl050, lenstr);
      stream.Read(Self.PRecord.cl050[1], lenStr);
    end;
    CL088_cl012:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl012, lenstr);
      stream.Read(Self.PRecord.cl012[1], lenStr);
    end;
    CL088_cl028:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl028, lenstr);
      stream.Read(Self.PRecord.cl028[1], lenStr);
    end;
    CL088_cl032:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl032, lenstr);
      stream.Read(Self.PRecord.cl032[1], lenStr);
    end;
    CL088_cl138:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl138, lenstr);
      stream.Read(Self.PRecord.cl138[1], lenStr);
    end;
    CL088_conclusion:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.conclusion, lenstr);
      stream.Read(Self.PRecord.conclusion[1], lenStr);
    end;
    CL088_note:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.note, lenstr);
      stream.Read(Self.PRecord.note[1], lenStr);
    end;
    CL088_cl142:
    begin
      stream.Read(lenStr, 2);
      setlength(Self.PRecord.cl142, lenstr);
      stream.Read(Self.PRecord.cl142[1], lenStr);
    end;
  end;
end;

procedure TCL088Item.InsertCL088;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL088;
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
            CL088_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL088_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL088_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL088_ucum: SaveData(PRecord.ucum, PropPosition, metaPosition, dataPosition);
            CL088_cl050: SaveData(PRecord.cl050, PropPosition, metaPosition, dataPosition);
            CL088_cl012: SaveData(PRecord.cl012, PropPosition, metaPosition, dataPosition);
            CL088_cl028: SaveData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL088_cl032: SaveData(PRecord.cl032, PropPosition, metaPosition, dataPosition);
            CL088_cl138: SaveData(PRecord.cl138, PropPosition, metaPosition, dataPosition);
            CL088_conclusion: SaveData(PRecord.conclusion, PropPosition, metaPosition, dataPosition);
            CL088_note: SaveData(PRecord.note, PropPosition, metaPosition, dataPosition);
            CL088_cl142: SaveData(PRecord.cl142, PropPosition, metaPosition, dataPosition);
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

function  TCL088Item.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TCL088Item.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TCL088Item;
begin
  Result := True;
  for i := 0 to Length(TCL088Coll(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TCL088Coll(coll).ArrPropSearchClc[i];
	ATempItem := TCL088Coll(coll).ListForFDB.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        CL088_Key: Result := IsFinded(ATempItem.PRecord.Key, buf, FPosDataADB, word(CL088_Key), cot);
            CL088_Description: Result := IsFinded(ATempItem.PRecord.Description, buf, FPosDataADB, word(CL088_Description), cot);
            CL088_DescriptionEn: Result := IsFinded(ATempItem.PRecord.DescriptionEn, buf, FPosDataADB, word(CL088_DescriptionEn), cot);
            CL088_ucum: Result := IsFinded(ATempItem.PRecord.ucum, buf, FPosDataADB, word(CL088_ucum), cot);
            CL088_cl050: Result := IsFinded(ATempItem.PRecord.cl050, buf, FPosDataADB, word(CL088_cl050), cot);
            CL088_cl012: Result := IsFinded(ATempItem.PRecord.cl012, buf, FPosDataADB, word(CL088_cl012), cot);
            CL088_cl028: Result := IsFinded(ATempItem.PRecord.cl028, buf, FPosDataADB, word(CL088_cl028), cot);
            CL088_cl032: Result := IsFinded(ATempItem.PRecord.cl032, buf, FPosDataADB, word(CL088_cl032), cot);
            CL088_cl138: Result := IsFinded(ATempItem.PRecord.cl138, buf, FPosDataADB, word(CL088_cl138), cot);
            CL088_conclusion: Result := IsFinded(ATempItem.PRecord.conclusion, buf, FPosDataADB, word(CL088_conclusion), cot);
            CL088_note: Result := IsFinded(ATempItem.PRecord.note, buf, FPosDataADB, word(CL088_note), cot);
            CL088_cl142: Result := IsFinded(ATempItem.PRecord.cl142, buf, FPosDataADB, word(CL088_cl142), cot);
      end;
    end;
  end;
end;

procedure TCL088Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds16: TLogicalData16;
  propindexcl088: Tcl088Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData16);
  stream.Read(flds16, sizeof(TLogicalData16));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := Tcl088Item.TSetProp(flds16);// тука се записва какво има като полета


  for propindexCl088 := Low(Tcl088Item.TPropertyIndex) to High(Tcl088Item.TPropertyIndex) do
  begin
    if not (propindexcl088 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexcl088);
      dataCmdProp.vid := vvCL088;
    end;
    self.FillPropCl088(propindexcl088, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCL088Item.SaveCL088(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL088;
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
            CL088_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL088_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL088_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL088_ucum: SaveData(PRecord.ucum, PropPosition, metaPosition, dataPosition);
            CL088_cl050: SaveData(PRecord.cl050, PropPosition, metaPosition, dataPosition);
            CL088_cl012: SaveData(PRecord.cl012, PropPosition, metaPosition, dataPosition);
            CL088_cl028: SaveData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL088_cl032: SaveData(PRecord.cl032, PropPosition, metaPosition, dataPosition);
            CL088_cl138: SaveData(PRecord.cl138, PropPosition, metaPosition, dataPosition);
            CL088_conclusion: SaveData(PRecord.conclusion, PropPosition, metaPosition, dataPosition);
            CL088_note: SaveData(PRecord.note, PropPosition, metaPosition, dataPosition);
            CL088_cl142: SaveData(PRecord.cl142, PropPosition, metaPosition, dataPosition);
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

procedure TCL088Item.UpdateCL088;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL088;
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
            CL088_Key: UpdateData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL088_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL088_DescriptionEn: UpdateData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL088_ucum: UpdateData(PRecord.ucum, PropPosition, metaPosition, dataPosition);
            CL088_cl050: UpdateData(PRecord.cl050, PropPosition, metaPosition, dataPosition);
            CL088_cl012: UpdateData(PRecord.cl012, PropPosition, metaPosition, dataPosition);
            CL088_cl028: UpdateData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL088_cl032: UpdateData(PRecord.cl032, PropPosition, metaPosition, dataPosition);
            CL088_cl138: UpdateData(PRecord.cl138, PropPosition, metaPosition, dataPosition);
            CL088_conclusion: UpdateData(PRecord.conclusion, PropPosition, metaPosition, dataPosition);
            CL088_note: UpdateData(PRecord.note, PropPosition, metaPosition, dataPosition);
            CL088_cl142: UpdateData(PRecord.cl142, PropPosition, metaPosition, dataPosition);
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

{ TCL088Coll }

function TCL088Coll.AddItem(ver: word): TCL088Item;
begin
  Result := TCL088Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TCL088Coll.AddItemForSearch: Integer;
var
  ItemForSearch: TCL088Item;
begin
  ItemForSearch := TCL088Item.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  //ItemForSearch.PRecord.Logical := [];
  Result := ListForFDB.Add(ItemForSearch);
end;

constructor TCL088Coll.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  tempItem := TCL088Item.Create(nil);
  ListCL088Search := TList<TCL088Item>.Create;
  ListForFDB := TList<TCL088Item>.Create;
  FindedRes.DataPos := 0;
  FindedRes.PropIndex := MAXWORD;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
end;

destructor TCL088Coll.destroy;
begin
  FreeAndNil(ListCL088Search);
  FreeAndNil(ListForFDB);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TCL088Coll.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TCL088Item.TPropertyIndex(propIndex) of
    CL088_Key: Result := 'Key';
    CL088_Description: Result := 'Description';
    CL088_DescriptionEn: Result := 'DescriptionEn';
    CL088_ucum: Result := 'ucum';
    CL088_cl050: Result := 'cl050';
    CL088_cl012: Result := 'cl012';
    CL088_cl028: Result := 'cl028';
    CL088_cl032: Result := 'cl032';
    CL088_cl138: Result := 'cl138';
    CL088_conclusion: Result := 'conclusion';
    CL088_note: Result := 'note';
    CL088_cl142: Result := 'cl142';
  end;
end;

procedure TCL088Coll.DynControlEnter(Sender: TObject);
begin
  self.FindedRes.DataPos := 0;
  //self.FindedRes.PropIndex := TBaseControl(sender).ColIndex;
  self.IndexValue(TCL088Item.TPropertyIndex(self.FindedRes.PropIndex));
end;

function TCL088Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 12;
end;

procedure TCL088Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL088: TCL088Item;
  ACol: Integer;
  prop: TCL088Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL088 := Items[ARow];
  prop := TCL088Item.TPropertyIndex(ACol);
  if Assigned(CL088.PRecord) and (prop in CL088.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL088, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL088, AValue);
  end;
end;

procedure TCL088Coll.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL088Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListDataPos.count - 1) < ARow then exit;

  TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  prop := TCL088Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL088Coll.GetCellFromRecord(propIndex: word; CL088: TCL088Item; var AValue: String);
var
  str: string;
begin
  case TCL088Item.TPropertyIndex(propIndex) of
    CL088_Key: str := (CL088.PRecord.Key);
    CL088_Description: str := (CL088.PRecord.Description);
    CL088_DescriptionEn: str := (CL088.PRecord.DescriptionEn);
    CL088_ucum: str := (CL088.PRecord.ucum);
    CL088_cl050: str := (CL088.PRecord.cl050);
    CL088_cl012: str := (CL088.PRecord.cl012);
    CL088_cl028: str := (CL088.PRecord.cl028);
    CL088_cl032: str := (CL088.PRecord.cl032);
    CL088_cl138: str := (CL088.PRecord.cl138);
    CL088_conclusion: str := (CL088.PRecord.conclusion);
    CL088_note: str := (CL088.PRecord.note);
    CL088_cl142: str := (CL088.PRecord.cl142);
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL088Coll.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TCL088Item;
  ACol: Integer;
  prop: TCL088Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFDB.Count = 0 then Exit;

  AtempItem := ListForFDB[ARow];
  prop := TCL088Item.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TCL088Coll.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL088Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TCL088Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL088Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL088: TCL088Item;
  ACol: Integer;
  prop: TCL088Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL088 := ListCL088Search[ARow];
  prop := TCL088Item.TPropertyIndex(ACol);
  if Assigned(CL088.PRecord) and (prop in CL088.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL088, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL088, AValue);
  end;
end;

procedure TCL088Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL088: TCL088Item;
  prop: TCL088Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL088 := Items[ARow];
  prop := TCL088Item.TPropertyIndex(ACol);
  if Assigned(CL088.PRecord) and (prop in CL088.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL088, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL088, AFieldText);
  end;
end;

procedure TCL088Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL088: TCL088Item; var AValue: String);
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
  case TCL088Item.TPropertyIndex(propIndex) of
    CL088_Key: str :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL088_Description: str :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL088_DescriptionEn: str :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL088_ucum: str :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL088_cl050: str :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL088_cl012: str :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL088_cl028: str :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL088_cl032: str :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL088_cl138: str :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL088_conclusion: str :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL088_note: str :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL088_cl142: str :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL088Coll.GetItem(Index: Integer): TCL088Item;
begin
  Result := TCL088Item(inherited GetItem(Index));
end;


procedure TCL088Coll.IndexValue(propIndex: TCL088Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL088Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL088_Key:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      CL088_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL088_DescriptionEn:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL088_ucum:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL088_cl050:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL088_cl012:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL088_cl028:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL088_cl032:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL088_cl138:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL088_conclusion:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL088_note:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL088_cl142:
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

procedure TCL088Coll.IndexValueListNodes(propIndex: TCL088Item.TPropertyIndex);
begin

end;

procedure TCL088Coll.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TCL088Item;
begin
  if index < 0 then
  begin
    Tempitem := TCL088Item.Create(nil);
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



//procedure TCL088Coll.OnSetTextSearchLog(Log: TlogicalCL088Set);
//begin
//  ListForFDB[0].PRecord.Logical := Log;
//end;

function TCL088Coll.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TCL088Item.TPropertyIndex(propIndex) of
    CL088_Key: Result := actAnsiString;
    CL088_Description: Result := actAnsiString;
    CL088_DescriptionEn: Result := actAnsiString;
    CL088_ucum: Result := actAnsiString;
    CL088_cl050: Result := actAnsiString;
    CL088_cl012: Result := actAnsiString;
    CL088_cl028: Result := actAnsiString;
    CL088_cl032: Result := actAnsiString;
    CL088_cl138: Result := actAnsiString;
    CL088_conclusion: Result := actAnsiString;
    CL088_note: Result := actAnsiString;
    CL088_cl142: Result := actAnsiString;
  else
    Result := actNone;
  end
end;

procedure TCL088Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL088: TCL088Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);

  CL088 := Items[ARow];
  if not Assigned(CL088.PRecord) then
  begin
    New(CL088.PRecord);
    CL088.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL088Item.TPropertyIndex(ACol) of
      CL088_Key: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL088_Description: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL088_DescriptionEn: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL088_ucum: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL088_cl050: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL088_cl012: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL088_cl028: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL088_cl032: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL088_cl138: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL088_conclusion: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL088_note: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL088_cl142: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL088.PRecord.setProp, TCL088Item.TPropertyIndex(ACol));
    if CL088.PRecord.setProp = [] then
    begin
      Dispose(CL088.PRecord);
      CL088.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL088.PRecord.setProp, TCL088Item.TPropertyIndex(ACol));
  case TCL088Item.TPropertyIndex(ACol) of
    CL088_Key: CL088.PRecord.Key := AValue;
    CL088_Description: CL088.PRecord.Description := AValue;
    CL088_DescriptionEn: CL088.PRecord.DescriptionEn := AValue;
    CL088_ucum: CL088.PRecord.ucum := AValue;
    CL088_cl050: CL088.PRecord.cl050 := AValue;
    CL088_cl012: CL088.PRecord.cl012 := AValue;
    CL088_cl028: CL088.PRecord.cl028 := AValue;
    CL088_cl032: CL088.PRecord.cl032 := AValue;
    CL088_cl138: CL088.PRecord.cl138 := AValue;
    CL088_conclusion: CL088.PRecord.conclusion := AValue;
    CL088_note: CL088.PRecord.note := AValue;
    CL088_cl142: CL088.PRecord.cl142 := AValue;
  end;
end;

procedure TCL088Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL088: TCL088Item;
begin
  if Count = 0 then Exit;

  CL088 := Items[ARow];
  if not Assigned(CL088.PRecord) then
  begin
    New(CL088.PRecord);
    CL088.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    isOld := False;
    case TCL088Item.TPropertyIndex(ACol) of
      CL088_Key: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL088_Description: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL088_DescriptionEn: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL088_ucum: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL088_cl050: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL088_cl012: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL088_cl028: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL088_cl032: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL088_cl138: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL088_conclusion: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL088_note: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL088_cl142: isOld :=  CL088.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL088.PRecord.setProp, TCL088Item.TPropertyIndex(ACol));
    if CL088.PRecord.setProp = [] then
    begin
      Dispose(CL088.PRecord);
      CL088.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL088.PRecord.setProp, TCL088Item.TPropertyIndex(ACol));
  case TCL088Item.TPropertyIndex(ACol) of
    CL088_Key: CL088.PRecord.Key := AFieldText;
    CL088_Description: CL088.PRecord.Description := AFieldText;
    CL088_DescriptionEn: CL088.PRecord.DescriptionEn := AFieldText;
    CL088_ucum: CL088.PRecord.ucum := AFieldText;
    CL088_cl050: CL088.PRecord.cl050 := AFieldText;
    CL088_cl012: CL088.PRecord.cl012 := AFieldText;
    CL088_cl028: CL088.PRecord.cl028 := AFieldText;
    CL088_cl032: CL088.PRecord.cl032 := AFieldText;
    CL088_cl138: CL088.PRecord.cl138 := AFieldText;
    CL088_conclusion: CL088.PRecord.conclusion := AFieldText;
    CL088_note: CL088.PRecord.note := AFieldText;
    CL088_cl142: CL088.PRecord.cl142 := AFieldText;
  end;
end;

procedure TCL088Coll.SetItem(Index: Integer; const Value: TCL088Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL088Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL088Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL088Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL088_Key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL088Search.Add(self.Items[i]);
  end;
end;
      CL088_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL088Search.Add(self.Items[i]);
        end;
      end;
      CL088_DescriptionEn:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL088Search.Add(self.Items[i]);
        end;
      end;
      CL088_ucum:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL088Search.Add(self.Items[i]);
        end;
      end;
      CL088_cl050:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL088Search.Add(self.Items[i]);
        end;
      end;
      CL088_cl012:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL088Search.Add(self.Items[i]);
        end;
      end;
      CL088_cl028:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL088Search.Add(self.Items[i]);
        end;
      end;
      CL088_cl032:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL088Search.Add(self.Items[i]);
        end;
      end;
      CL088_cl138:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL088Search.Add(self.Items[i]);
        end;
      end;
      CL088_conclusion:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL088Search.Add(self.Items[i]);
        end;
      end;
      CL088_note:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL088Search.Add(self.Items[i]);
        end;
      end;
      CL088_cl142:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL088Search.Add(self.Items[i]);
        end;
      end;

    end;
  end;
end;

procedure TCL088Coll.ShowGrid(Grid: TTeeGrid);
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

procedure TCL088Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL088Item>);
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

procedure TCL088Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL088Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL088Search.Count]);

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

procedure TCL088Coll.SortByIndexAnsiString;
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

procedure TCL088Coll.SortByIndexInt;
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

procedure TCL088Coll.SortByIndexWord;
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

procedure TCL088Coll.SortByIndexValue(propIndex: TCL088Item.TPropertyIndex);
begin
  case propIndex of
    CL088_Key: SortByIndexAnsiString;
      CL088_Description: SortByIndexAnsiString;
      CL088_DescriptionEn: SortByIndexAnsiString;
      CL088_ucum: SortByIndexAnsiString;
      CL088_cl050: SortByIndexAnsiString;
      CL088_cl012: SortByIndexAnsiString;
      CL088_cl028: SortByIndexAnsiString;
      CL088_cl032: SortByIndexAnsiString;
      CL088_cl138: SortByIndexAnsiString;
      CL088_conclusion: SortByIndexAnsiString;
      CL088_note: SortByIndexAnsiString;
      CL088_cl142: SortByIndexAnsiString;
  end;
end;

end.