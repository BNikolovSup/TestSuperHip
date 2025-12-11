unit Table.CL142;

interface
uses
  Aspects.Collections, Aspects.Types, Aspects.Functions, Vcl.Dialogs,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control, System.Generics.Defaults;

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

TLogicalCL142 = (
    IS_);
TlogicalCL142Set = set of TLogicalCL142;


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
       , CL142_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
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
        Logical: TlogicalCL142Set;
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
    procedure SaveCL142(var dataPosition: Cardinal)overload;
	procedure SaveCL142(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
  procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
  procedure FillPropCl142(propindex: TPropertyIndex; stream: TStream);
  end;


  TCL142Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TCL142Item;
    function GetItem(Index: Integer): TCL142Item;
    procedure SetItem(Index: Integer; const Value: TCL142Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TCL142Item>;
    ListCL142Search: TList<TCL142Item>;
	PRecordSearch: ^TCL142Item.TRecCL142;
    ArrPropSearch: TArray<TCL142Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCL142Item.TPropertyIndex>;
	VisibleColl: TCL142Item.TSetProp;
	ArrayPropOrder: TArray<TCL142Item.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL142Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; CL142: TCL142Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL142: TCL142Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TCL142Item.TPropertyIndex);
    procedure SortByIndexInt;
	procedure SortByIndexWord;
    procedure SortByIndexAnsiString;
	procedure DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);override;

	function DisplayName(propIndex: Word): string; override;
	function DisplayLogicalName(flagIndex: Integer): string;
	function RankSortOption(propIndex: Word): cardinal; override;
    function FindRootCollOptionNode(): PVirtualNode; override;
    function FindSearchFieldCollOptionGridNode(): PVirtualNode;
    function FindSearchFieldCollOptionCOTNode(): PVirtualNode;
    function FindSearchFieldCollOptionNode(): PVirtualNode;
    function CreateRootCollOptionNode(): PVirtualNode;
    procedure OrderFieldsSearch1(Grid: TTeeGrid);override;
	function FieldCount: Integer; override;
	procedure ShowGrid(Grid: TTeeGrid);override;
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL142Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL142Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCL142Item.TPropertyIndex);
    property Items[Index: Integer]: TCL142Item read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalCL142Set);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
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

procedure TCL142Item.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
var
  paramField: TParamProp;
  setPropPat: TSetProp;
  i: Integer;
  PropertyIndex: TPropertyIndex;
begin
  i := 0;
  for paramField in SetOfProp do
  begin
    PropertyIndex := TPropertyIndex(byte(paramField));
    Include(Self.PRecord.setProp, PropertyIndex);
    //case PropertyIndex of
      //PatientNew_EGN: Self.PRecord.EGN := arrstr[i];
    //end;
    inc(i);
  end;
end;

procedure TCL142Item.FillPropCl142(propindex: TPropertyIndex; stream: TStream);
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

function TCL142Item.GetCollType: TCollectionsType;
begin
  Result := ctCL142;
end;

function TCL142Item.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
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
            CL142_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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
	ATempItem := TCL142Coll(coll).ListForFinder.Items[0];
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
            CL142_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(CL142_Logical), cot);
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
      dataCmdProp.vid := vvCl144;
    end;
    self.FillPropCl142(propindexcl142, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCL142Item.SaveCL142(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveCL142(dataPosition);
end;

procedure TCL142Item.SaveCL142(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL142;
  SaveAnyStreamCommand(@PRecord.setProp, SizeOf(PRecord.setProp), CollType, toUpdate, FVersion, dataPosition);
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
            CL142_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TCL142Coll.ApplyVisibilityFromTree(RootNode: PVirtualNode);
var
  run: PVirtualNode;
  data: PAspRec;
begin
  VisibleColl := [];

  run := RootNode.FirstChild;
  while run <> nil do
  begin
    data := PAspRec(PByte(run) + lenNode);

    if run.CheckState = csCheckedNormal then
      Include(VisibleColl, TCL142Item.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TCL142Coll.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvCL142Root, 0, NodeRoot , amAddChildLast, result, linkPos);
  linkOptions.AddNewNode(vvOptionSearchGrid, 0, Result , amAddChildLast, vOptionSearchGrid, linkPos);
  linkOptions.AddNewNode(vvOptionSearchCot, 0, Result , amAddChildLast, vOptionSearchCOT, linkPos);

  vOptionSearchGrid.CheckType := ctTriStateCheckBox;

  if vOptionSearchGrid.ChildCount <> FieldCount then
  begin
    for i := 0 to FieldCount - 1 do
    begin
      linkOptions.AddNewNode(vvFieldSearchGridOption, 0, vOptionSearchGrid , amAddChildLast, run, linkPos);
      run.Dummy := i + 1;
	  run.CheckType := ctCheckBox;
      run.CheckState := csCheckedNormal;
    end;
  end
  else
  begin
    // при евентуално добавена колонка...
  end;  
end;

procedure TCL142Coll.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TCL142Item;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (CL142_Key in tempItem.PRecord.setProp) and (tempItem.PRecord.Key <> Self.getAnsiStringMap(tempItem.DataPos, word(CL142_Key))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL142_Description in tempItem.PRecord.setProp) and (tempItem.PRecord.Description <> Self.getAnsiStringMap(tempItem.DataPos, word(CL142_Description))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL142_DescriptionEn in tempItem.PRecord.setProp) and (tempItem.PRecord.DescriptionEn <> Self.getAnsiStringMap(tempItem.DataPos, word(CL142_DescriptionEn))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL142_achi_block in tempItem.PRecord.setProp) and (tempItem.PRecord.achi_block <> Self.getAnsiStringMap(tempItem.DataPos, word(CL142_achi_block))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL142_achi_chapter in tempItem.PRecord.setProp) and (tempItem.PRecord.achi_chapter <> Self.getAnsiStringMap(tempItem.DataPos, word(CL142_achi_chapter))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL142_achi_code in tempItem.PRecord.setProp) and (tempItem.PRecord.achi_code <> Self.getAnsiStringMap(tempItem.DataPos, word(CL142_achi_code))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL142_nhif_code in tempItem.PRecord.setProp) and (tempItem.PRecord.nhif_code <> Self.getAnsiStringMap(tempItem.DataPos, word(CL142_nhif_code))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL142_cl048 in tempItem.PRecord.setProp) and (tempItem.PRecord.cl048 <> Self.getAnsiStringMap(tempItem.DataPos, word(CL142_cl048))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL142_cl006 in tempItem.PRecord.setProp) and (tempItem.PRecord.cl006 <> Self.getAnsiStringMap(tempItem.DataPos, word(CL142_cl006))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL142_highly in tempItem.PRecord.setProp) and (tempItem.PRecord.highly <> Self.getAnsiStringMap(tempItem.DataPos, word(CL142_highly))) then
  begin
    inc(cnt);
    exit;
  end;

  if (CL142_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(CL142_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TCL142Coll.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TCL142Item.Create(nil);
  ListCL142Search := TList<TCL142Item>.Create;
  ListForFinder := TList<TCL142Item>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TCL142Coll.destroy;
begin
  FreeAndNil(ListCL142Search);
  FreeAndNil(ListForFinder);
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
    CL142_Logical: Result := 'Logical';
  end;
end;

function TCL142Coll.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'IS_';
  else
    Result := '???';
  end;
end;


procedure TCL142Coll.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
var
  FieldCollOptionNode, run: PVirtualNode;
  pSource, pTarget: PVirtualNode;
begin
  inherited;
  if linkOptions = nil then Exit;

  FieldCollOptionNode := FindSearchFieldCollOptionGridNode;
  run := FieldCollOptionNode.FirstChild;
  pSource := nil;
  pTarget := nil;
  while run <> nil do
  begin
    if run.Index = NewPos - 1 then
    begin
      pTarget := run;
    end;
    if run.index = OldPos - 1 then
    begin
      pSource := run;
    end;
    run := run.NextSibling;
  end;

  if pTarget = nil then Exit;
  if pSource = nil then Exit;
  //ShowMessage(Format('pSource = %d, pTarget = %d', [pSource.Index, pTarget.Index]));
  if pSource.Index < pTarget.Index then
  begin
    linkOptions.FVTR.MoveTo(pSource, pTarget, amInsertAfter, False);
  end
  else
  begin
    linkOptions.FVTR.MoveTo(pSource, pTarget, amInsertBefore, False);
  end;
  run := FieldCollOptionNode.FirstChild;
  while run <> nil do
  begin
    ArrayPropOrderSearchOptions[run.index + 1] :=  run.Dummy - 1;
    run := run.NextSibling;
  end; 
end;


function TCL142Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 11;
end;

function TCL142Coll.FindRootCollOptionNode(): PVirtualNode;
var
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  PosLinkData: Cardinal;
  Run: PVirtualNode;
  data: PAspRec;
begin
  Result := nil;
  linkPos := 100;
  pCardinalData := pointer(PByte(linkOptions.Buf));
  PosLinkData := pCardinalData^;

  while linkPos <= PosLinkData do
  begin
    Run := pointer(PByte(linkOptions.Buf) + linkpos);
    data := Pointer(PByte(Run)+ lenNode);
    if data.vid = vvCL142Root then
    begin
      Result := Run;
	  data := Pointer(PByte(Result)+ lenNode);
      data.DataPos := Cardinal(Self);
      Exit;
    end;
    inc(linkPos, LenData);
  end;
  if Result = nil then
    Result := CreateRootCollOptionNode;
  if Result <> nil then
  begin
    data := Pointer(PByte(Result)+ lenNode);
    data.DataPos := Cardinal(Self);
  end;
end;

function TCL142Coll.FindSearchFieldCollOptionCOTNode: PVirtualNode;
var
  run, vRootPregOptions: PVirtualNode;
  dataRun: PAspRec;
begin
  vRootPregOptions := self.FindRootCollOptionNode();
  result := nil;

  run := vRootPregOptions.FirstChild;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvOptionSearchCot: result := run;
    end;
    run := run.NextSibling;
  end;
end;

function TCL142Coll.FindSearchFieldCollOptionGridNode: PVirtualNode;
var
  run, vRootPregOptions: PVirtualNode;
  dataRun: PAspRec;
begin
  vRootPregOptions := self.FindRootCollOptionNode();

  result := nil;

  run := vRootPregOptions.FirstChild;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvOptionSearchGrid: result := run;
    end;
    run := run.NextSibling;
  end;
end;

function TCL142Coll.FindSearchFieldCollOptionNode(): PVirtualNode;
var
  linkPos: Cardinal;
  run, vOptionSearchGrid, vOptionSearchCOT, vRootPregOptions: PVirtualNode;
  i: Integer;
  dataRun: PAspRec;
begin
  vRootPregOptions := self.FindRootCollOptionNode();
  if vRootPregOptions = nil then
    vRootPregOptions := CreateRootCollOptionNode;
  vOptionSearchGrid := nil;
  vOptionSearchCOT := nil;

  run := vRootPregOptions.FirstChild;
  while run <> nil do
  begin
    dataRun := pointer(PByte(run) + lenNode);
    case dataRun.vid of
      vvOptionSearchGrid: vOptionSearchGrid := run;
      vvOptionSearchCot: vOptionSearchCOT := run;
    end;

    run := run.NextSibling;
  end;
  if vOptionSearchGrid = nil then
  begin
    linkOptions.AddNewNode(vvOptionSearchGrid, 0, vRootPregOptions , amAddChildLast, vOptionSearchGrid, linkPos);
  end;
  if vOptionSearchCOT = nil then
  begin
    linkOptions.AddNewNode(vvOptionSearchCot, 0, vRootPregOptions , amAddChildLast, vOptionSearchGrid, linkPos);
  end;

  Result := vOptionSearchGrid;
  if vOptionSearchGrid.ChildCount <> FieldCount then
  begin
    for i := 0 to FieldCount - 1 do
    begin
      linkOptions.AddNewNode(vvFieldSearchGridOption, 0, vOptionSearchGrid , amAddChildLast, run, linkPos);
      run.Dummy := i;
    end;
  end
  else
  begin
    // при евентуално добавена колонка...
  end;
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
  RowSelect: Integer;
  prop: TCL142Item.TPropertyIndex;
begin
  inherited;
 
  if ARow < 0 then
  begin
    AValue := 'hhhh';
    Exit;
  end;
  try
    if (ListDataPos.count - 1 - Self.offsetTop - Self.offsetBottom) < ARow then exit;
    RowSelect := ARow + Self.offsetTop;
    TempItem.DataPos := PAspRec(Pointer(PByte(ListDataPos[ARow]) + lenNode)).DataPos;
  except
    AValue := 'ddddd';
    Exit;
  end;

  GetCellFromMap(ArrayPropOrderSearchOptions[AColumn.Index], RowSelect, TempItem, AValue);
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
    CL142_Logical: str := CL142.Logical08ToStr(TLogicalData08(CL142.PRecord.Logical));
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
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
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

function TCL142Coll.GetCollType: TCollectionsType;
begin
  Result := ctCL142;
end;

function TCL142Coll.GetCollDelType: TCollectionsType;
begin
  Result := ctCL142Del;
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
    CL142_Logical: str :=  CL142.Logical08ToStr(CL142.getLogical08Map(Self.Buf, Self.posData, propIndex));
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

function TCL142Coll.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TCL142Item.TPropertyIndex(PropIndex) in  VisibleColl;
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

{=== TEXT SEARCH HANDLER ===}
procedure TCL142Coll.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TCL142Item.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TCL142Item.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TCL142Item.TPropertyIndex(Field) of
CL142_Key: ListForFinder[0].PRecord.Key := AText;
    CL142_Description: ListForFinder[0].PRecord.Description := AText;
    CL142_DescriptionEn: ListForFinder[0].PRecord.DescriptionEn := AText;
    CL142_achi_block: ListForFinder[0].PRecord.achi_block := AText;
    CL142_achi_chapter: ListForFinder[0].PRecord.achi_chapter := AText;
    CL142_achi_code: ListForFinder[0].PRecord.achi_code := AText;
    CL142_nhif_code: ListForFinder[0].PRecord.nhif_code := AText;
    CL142_cl048: ListForFinder[0].PRecord.cl048 := AText;
    CL142_cl006: ListForFinder[0].PRecord.cl006 := AText;
    CL142_highly: ListForFinder[0].PRecord.highly := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TCL142Coll.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL142Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  //case TCL142Item.TPropertyIndex(Field) of
//
//  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TCL142Coll.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL142Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  //case TCL142Item.TPropertyIndex(Field) of
//
//  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TCL142Coll.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TCL142Item.TPropertyIndex(Field) of
    CL142_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalCL142(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalCL142(logIndex))   
    end;
  end;
end;


procedure TCL142Coll.OnSetTextSearchLog(Log: TlogicalCL142Set);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TCL142Coll.OrderFieldsSearch1(Grid: TTeeGrid);
var
  FieldCollOptionNode, run: PVirtualNode;
  Comparison: TComparison<PVirtualNode>;
  i, index, rank: Integer;
  ArrCol: TArray<TColumn>;
begin
  inherited;
  if linkOptions = nil then  Exit;

  FieldCollOptionNode := FindSearchFieldCollOptionNode;
  ApplyVisibilityFromTree(FieldCollOptionNode);
  run := FieldCollOptionNode.FirstChild;

  while run <> nil do
  begin
    Grid.Columns[run.index + 1].Header.Text := DisplayName(run.Dummy - 1);
    ArrayPropOrderSearchOptions[run.index + 1] :=  run.Dummy - 1;
    run := run.NextSibling;
  end;

end;

function TCL142Coll.PropType(propIndex: Word): TAspectTypeKind;
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
    CL142_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TCL142Coll.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TCL142Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL142: TCL142Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  CL142 := Items[ARow];
  if not Assigned(CL142.PRecord) then
  begin
    New(CL142.PRecord);
    CL142.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
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
    CL142_Logical: CL142.PRecord.Logical := tlogicalCL142Set(CL142.StrToLogical08(AValue));
  end;
end;

procedure TCL142Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL142: TCL142Item;
begin
  if Count = 0 then Exit;
  isOld := False; 
  CL142 := Items[ARow];
  if not Assigned(CL142.PRecord) then
  begin
    New(CL142.PRecord);
    CL142.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
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
    CL142_Logical: CL142.PRecord.Logical := tlogicalCL142Set(CL142.StrToLogical08(AFieldText));
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
  ListForFinder := LST;
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
        while (Items[I].IndexAnsiStr1) < (Items[P].IndexAnsiStr1) do Inc(I);
        while (Items[J].IndexAnsiStr1) > (Items[P].IndexAnsiStr1) do Dec(J);
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