unit Table.CL022;

interface
uses
  Aspects.Collections, Aspects.Types, Aspects.Functions, Vcl.Dialogs,
  VCLTee.Grid, Tee.Grid.Columns, Tee.GridData.Strings,
  classes, system.SysUtils, windows, System.Generics.Collections,
  VirtualTrees, VCLTee.Control, System.Generics.Defaults, Tee.Renders,
  uGridHelpers  ;

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

TLogicalCL022 = (
    Is_);
TlogicalCL022Set = set of TLogicalCL022;


TCL022Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       CL022_Key
       , CL022_Description
       , CL022_DescriptionEn
       , CL022_achi_code
       , CL022_achi_block
       , CL022_nhif_package
       , CL022_nhif_code
       , CL022_achi_chapter
       , CL022_loinc
       , CL022_snomed
       , CL022_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecCL022 = ^TRecCL022;
      TRecCL022 = record
        Key: AnsiString;
        Description: AnsiString;
        DescriptionEn: AnsiString;
        achi_code: AnsiString;
        achi_block: AnsiString;
        nhif_package: AnsiString;
        nhif_code: AnsiString;
        achi_chapter: AnsiString;
        loinc: AnsiString;
        snomed: AnsiString;
        Logical: TlogicalCL022Set;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL022;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL022;
    procedure UpdateCL022;
    procedure SaveCL022(var dataPosition: Cardinal)overload;
	procedure SaveCL022(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
	procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
	procedure FillPropCL022(propindex: TPropertyIndex; stream: TStream);
  end;


  TCL022Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TCL022Item;
    function GetItem(Index: Integer): TCL022Item;
    procedure SetItem(Index: Integer; const Value: TCL022Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TCL022Item>;
    ListCL022Search: TList<TCL022Item>;
	PRecordSearch: ^TCL022Item.TRecCL022;
    ArrPropSearch: TArray<TCL022Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCL022Item.TPropertyIndex>;
	VisibleColl: TCL022Item.TSetProp;
	ArrayPropOrder: TArray<TCL022Item.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL022Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; CL022: TCL022Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL022: TCL022Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TCL022Item.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL022Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL022Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCL022Item.TPropertyIndex);
    property Items[Index: Integer]: TCL022Item read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalCL022Set);
	procedure CheckForSave(var cnt: Integer); override;
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
	{NZIS_START}
	procedure ImportXMLNzis(cl000: TObject); override;
	procedure UpdateXMLNzis; override;
	function CellDiffKind(ACol, ARow: Integer): TDiffKind; override;
	procedure BuildKeyDict(PropIndex: Word);
	{NZIS_END}
  end;

implementation
{NZIS_START}
uses
  Nzis.Nomen.baseCL000, System.Rtti;
{NZIS_END}  

{ TCL022Item }

constructor TCL022Item.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TCL022Item.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TCL022Item.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TCL022Item.GetCollType: TCollectionsType;
begin
  Result := ctCL022;
end;

function TCL022Item.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TCL022Item.InsertCL022;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctCL022;
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
            CL022_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL022_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL022_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL022_achi_code: SaveData(PRecord.achi_code, PropPosition, metaPosition, dataPosition);
            CL022_achi_block: SaveData(PRecord.achi_block, PropPosition, metaPosition, dataPosition);
            CL022_nhif_package: SaveData(PRecord.nhif_package, PropPosition, metaPosition, dataPosition);
            CL022_nhif_code: SaveData(PRecord.nhif_code, PropPosition, metaPosition, dataPosition);
            CL022_achi_chapter: SaveData(PRecord.achi_chapter, PropPosition, metaPosition, dataPosition);
            CL022_loinc: SaveData(PRecord.loinc, PropPosition, metaPosition, dataPosition);
            CL022_snomed: SaveData(PRecord.snomed, PropPosition, metaPosition, dataPosition);
            CL022_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TCL022Item.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TCL022Item.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TCL022Item;
begin
  Result := True;
  for i := 0 to Length(TCL022Coll(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TCL022Coll(coll).ArrPropSearchClc[i];
	ATempItem := TCL022Coll(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        CL022_Key: Result := IsFinded(ATempItem.PRecord.Key, buf, FPosDataADB, word(CL022_Key), cot);
            CL022_Description: Result := IsFinded(ATempItem.PRecord.Description, buf, FPosDataADB, word(CL022_Description), cot);
            CL022_DescriptionEn: Result := IsFinded(ATempItem.PRecord.DescriptionEn, buf, FPosDataADB, word(CL022_DescriptionEn), cot);
            CL022_achi_code: Result := IsFinded(ATempItem.PRecord.achi_code, buf, FPosDataADB, word(CL022_achi_code), cot);
            CL022_achi_block: Result := IsFinded(ATempItem.PRecord.achi_block, buf, FPosDataADB, word(CL022_achi_block), cot);
            CL022_nhif_package: Result := IsFinded(ATempItem.PRecord.nhif_package, buf, FPosDataADB, word(CL022_nhif_package), cot);
            CL022_nhif_code: Result := IsFinded(ATempItem.PRecord.nhif_code, buf, FPosDataADB, word(CL022_nhif_code), cot);
            CL022_achi_chapter: Result := IsFinded(ATempItem.PRecord.achi_chapter, buf, FPosDataADB, word(CL022_achi_chapter), cot);
            CL022_loinc: Result := IsFinded(ATempItem.PRecord.loinc, buf, FPosDataADB, word(CL022_loinc), cot);
            CL022_snomed: Result := IsFinded(ATempItem.PRecord.snomed, buf, FPosDataADB, word(CL022_snomed), cot);
            CL022_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(CL022_Logical), cot);
      end;
    end;
  end;
end;

procedure TCL022Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds16: TLogicalData16;
  propindexCL022: TCL022Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData16);
  stream.Read(flds16, sizeof(TLogicalData16));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := TCL022Item.TSetProp(flds16);// тука се записва какво има като полета


  for propindexCL022 := Low(TCL022Item.TPropertyIndex) to High(TCL022Item.TPropertyIndex) do
  begin
    if not (propindexCL022 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexCL022);
      dataCmdProp.vid := vvCL022;
    end;
    self.FillPropCL022(propindexCL022, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCL022Item.FillPropCL022(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    CL022_Key:
        begin
          stream.Read(lenStr, 2);
          SetLength(Self.PRecord.Key, lenStr);
          stream.Read(Self.PRecord.Key[1], lenStr);
        end;
            CL022_Description:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.Description, lenStr);
              stream.Read(Self.PRecord.Description[1], lenStr);
            end;
            CL022_DescriptionEn:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.DescriptionEn, lenStr);
              stream.Read(Self.PRecord.DescriptionEn[1], lenStr);
            end;
            CL022_achi_code:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.achi_code, lenStr);
              stream.Read(Self.PRecord.achi_code[1], lenStr);
            end;
            CL022_achi_block:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.achi_block, lenStr);
              stream.Read(Self.PRecord.achi_block[1], lenStr);
            end;
            CL022_nhif_package:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.nhif_package, lenStr);
              stream.Read(Self.PRecord.nhif_package[1], lenStr);
            end;
            CL022_nhif_code:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.nhif_code, lenStr);
              stream.Read(Self.PRecord.nhif_code[1], lenStr);
            end;
            CL022_achi_chapter:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.achi_chapter, lenStr);
              stream.Read(Self.PRecord.achi_chapter[1], lenStr);
            end;
            CL022_loinc:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.loinc, lenStr);
              stream.Read(Self.PRecord.loinc[1], lenStr);
            end;
            CL022_snomed:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.snomed, lenStr);
              stream.Read(Self.PRecord.snomed[1], lenStr);
            end;
            CL022_Logical: stream.Read(Self.PRecord.Logical, SizeOf(TLogicalData08));
  end;
end;

procedure TCL022Item.SaveCL022(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveCL022(dataPosition);
end;

procedure TCL022Item.SaveCL022(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := PCollectionsType(PByte(Buf) + DataPos - 4)^;
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
            CL022_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL022_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL022_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL022_achi_code: SaveData(PRecord.achi_code, PropPosition, metaPosition, dataPosition);
            CL022_achi_block: SaveData(PRecord.achi_block, PropPosition, metaPosition, dataPosition);
            CL022_nhif_package: SaveData(PRecord.nhif_package, PropPosition, metaPosition, dataPosition);
            CL022_nhif_code: SaveData(PRecord.nhif_code, PropPosition, metaPosition, dataPosition);
            CL022_achi_chapter: SaveData(PRecord.achi_chapter, PropPosition, metaPosition, dataPosition);
            CL022_loinc: SaveData(PRecord.loinc, PropPosition, metaPosition, dataPosition);
            CL022_snomed: SaveData(PRecord.snomed, PropPosition, metaPosition, dataPosition);
            CL022_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TCL022Item.UpdateCL022;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctCL022;
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
            CL022_Key: UpdateData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL022_Description: UpdateData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL022_DescriptionEn: UpdateData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL022_achi_code: UpdateData(PRecord.achi_code, PropPosition, metaPosition, dataPosition);
            CL022_achi_block: UpdateData(PRecord.achi_block, PropPosition, metaPosition, dataPosition);
            CL022_nhif_package: UpdateData(PRecord.nhif_package, PropPosition, metaPosition, dataPosition);
            CL022_nhif_code: UpdateData(PRecord.nhif_code, PropPosition, metaPosition, dataPosition);
            CL022_achi_chapter: UpdateData(PRecord.achi_chapter, PropPosition, metaPosition, dataPosition);
            CL022_loinc: UpdateData(PRecord.loinc, PropPosition, metaPosition, dataPosition);
            CL022_snomed: UpdateData(PRecord.snomed, PropPosition, metaPosition, dataPosition);
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

{ TCL022Coll }

function TCL022Coll.AddItem(ver: word): TCL022Item;
begin
  Result := TCL022Item(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TCL022Coll.AddItemForSearch: Integer;
var
  ItemForSearch: TCL022Item;
begin
  ItemForSearch := TCL022Item.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TCL022Coll.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TCL022Item.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TCL022Coll.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvCL022Root, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TCL022Coll.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TCL022Item;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

      if (CL022_Key in tempItem.PRecord.setProp) and (tempItem.PRecord.Key <> Self.getAnsiStringMap(tempItem.DataPos, word(CL022_Key))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL022_Description in tempItem.PRecord.setProp) and (tempItem.PRecord.Description <> Self.getAnsiStringMap(tempItem.DataPos, word(CL022_Description))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL022_DescriptionEn in tempItem.PRecord.setProp) and (tempItem.PRecord.DescriptionEn <> Self.getAnsiStringMap(tempItem.DataPos, word(CL022_DescriptionEn))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL022_achi_code in tempItem.PRecord.setProp) and (tempItem.PRecord.achi_code <> Self.getAnsiStringMap(tempItem.DataPos, word(CL022_achi_code))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL022_achi_block in tempItem.PRecord.setProp) and (tempItem.PRecord.achi_block <> Self.getAnsiStringMap(tempItem.DataPos, word(CL022_achi_block))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL022_nhif_package in tempItem.PRecord.setProp) and (tempItem.PRecord.nhif_package <> Self.getAnsiStringMap(tempItem.DataPos, word(CL022_nhif_package))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL022_nhif_code in tempItem.PRecord.setProp) and (tempItem.PRecord.nhif_code <> Self.getAnsiStringMap(tempItem.DataPos, word(CL022_nhif_code))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL022_achi_chapter in tempItem.PRecord.setProp) and (tempItem.PRecord.achi_chapter <> Self.getAnsiStringMap(tempItem.DataPos, word(CL022_achi_chapter))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL022_loinc in tempItem.PRecord.setProp) and (tempItem.PRecord.loinc <> Self.getAnsiStringMap(tempItem.DataPos, word(CL022_loinc))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL022_snomed in tempItem.PRecord.setProp) and (tempItem.PRecord.snomed <> Self.getAnsiStringMap(tempItem.DataPos, word(CL022_snomed))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL022_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(CL022_Logical))) then
      begin
        inc(cnt);
        exit;
      end;
    end;
  end;
end;


constructor TCL022Coll.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TCL022Item.Create(nil);
  ListCL022Search := TList<TCL022Item>.Create;
  ListForFinder := TList<TCL022Item>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TCL022Coll.destroy;
begin
  FreeAndNil(ListCL022Search);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TCL022Coll.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TCL022Item.TPropertyIndex(propIndex) of
    CL022_Key: Result := 'Key';
    CL022_Description: Result := 'Description';
    CL022_DescriptionEn: Result := 'DescriptionEn';
    CL022_achi_code: Result := 'achi_code';
    CL022_achi_block: Result := 'achi_block';
    CL022_nhif_package: Result := 'nhif_package';
    CL022_nhif_code: Result := 'nhif_code';
    CL022_achi_chapter: Result := 'achi_chapter';
    CL022_loinc: Result := 'loinc';
    CL022_snomed: Result := 'snomed';
    CL022_Logical: Result := 'Logical';
  end;
end;

function TCL022Coll.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'Is_';
  else
    Result := '???';
  end;
end;


procedure TCL022Coll.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TCL022Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 11;
end;

function TCL022Coll.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvCL022Root then
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

function TCL022Coll.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TCL022Coll.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TCL022Coll.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TCL022Coll.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL022: TCL022Item;
  ACol: Integer;
  prop: TCL022Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL022 := Items[ARow];
  prop := TCL022Item.TPropertyIndex(ACol);
  if Assigned(CL022.PRecord) and (prop in CL022.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL022, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL022, AValue);
  end;
end;

procedure TCL022Coll.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TCL022Item.TPropertyIndex;
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

procedure TCL022Coll.GetCellFromRecord(propIndex: word; CL022: TCL022Item; var AValue: String);
var
  str: string;
begin
  case TCL022Item.TPropertyIndex(propIndex) of
    CL022_Key: str := (CL022.PRecord.Key);
    CL022_Description: str := (CL022.PRecord.Description);
    CL022_DescriptionEn: str := (CL022.PRecord.DescriptionEn);
    CL022_achi_code: str := (CL022.PRecord.achi_code);
    CL022_achi_block: str := (CL022.PRecord.achi_block);
    CL022_nhif_package: str := (CL022.PRecord.nhif_package);
    CL022_nhif_code: str := (CL022.PRecord.nhif_code);
    CL022_achi_chapter: str := (CL022.PRecord.achi_chapter);
    CL022_loinc: str := (CL022.PRecord.loinc);
    CL022_snomed: str := (CL022.PRecord.snomed);
    CL022_Logical: str := CL022.Logical08ToStr(TLogicalData08(CL022.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL022Coll.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TCL022Item;
  ACol: Integer;
  prop: TCL022Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TCL022Item.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TCL022Coll.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL022Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TCL022Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TCL022Coll.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  CL022: TCL022Item;
  ACol: Integer;
  prop: TCL022Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  CL022 := ListCL022Search[ARow];
  prop := TCL022Item.TPropertyIndex(ACol);
  if Assigned(CL022.PRecord) and (prop in CL022.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL022, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL022, AValue);
  end;
end;

function TCL022Coll.GetCollType: TCollectionsType;
begin
  Result := ctCL022;
end;

function TCL022Coll.GetCollDelType: TCollectionsType;
begin
  Result := ctCL022Del;
end;

procedure TCL022Coll.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  CL022: TCL022Item;
  prop: TCL022Item.TPropertyIndex;
begin
  if Count = 0 then Exit;

  CL022 := Items[ARow];
  prop := TCL022Item.TPropertyIndex(ACol);
  if Assigned(CL022.PRecord) and (prop in CL022.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, CL022, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, CL022, AFieldText);
  end;
end;

procedure TCL022Coll.GetCellFromMap(propIndex: word; ARow: Integer; CL022: TCL022Item; var AValue: String);
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
  case TCL022Item.TPropertyIndex(propIndex) of
    CL022_Key: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_Description: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_DescriptionEn: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_achi_code: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_achi_block: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_nhif_package: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_nhif_code: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_achi_chapter: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_loinc: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_snomed: str :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL022_Logical: str :=  CL022.Logical08ToStr(CL022.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TCL022Coll.GetItem(Index: Integer): TCL022Item;
begin
  Result := TCL022Item(inherited GetItem(Index));
end;


procedure TCL022Coll.IndexValue(propIndex: TCL022Item.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TCL022Item;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      CL022_Key:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      CL022_Description:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL022_DescriptionEn:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL022_achi_code:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL022_achi_block:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL022_nhif_package:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL022_nhif_code:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL022_achi_chapter:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL022_loinc:
      begin
        TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
        if TempItem.IndexAnsiStr <> nil then
        begin
          TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
        end
        else
          TempItem.IndexAnsiStr1 := '';
      end;
      CL022_snomed:
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

procedure TCL022Coll.IndexValueListNodes(propIndex: TCL022Item.TPropertyIndex);
begin

end;

function TCL022Coll.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TCL022Item.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TCL022Coll.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TCL022Item;
begin
  if index < 0 then
  begin
    Tempitem := TCL022Item.Create(nil);
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
procedure TCL022Coll.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TCL022Item.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TCL022Item.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TCL022Item.TPropertyIndex(Field) of
CL022_Key: ListForFinder[0].PRecord.Key := AText;
    CL022_Description: ListForFinder[0].PRecord.Description := AText;
    CL022_DescriptionEn: ListForFinder[0].PRecord.DescriptionEn := AText;
    CL022_achi_code: ListForFinder[0].PRecord.achi_code := AText;
    CL022_achi_block: ListForFinder[0].PRecord.achi_block := AText;
    CL022_nhif_package: ListForFinder[0].PRecord.nhif_package := AText;
    CL022_nhif_code: ListForFinder[0].PRecord.nhif_code := AText;
    CL022_achi_chapter: ListForFinder[0].PRecord.achi_chapter := AText;
    CL022_loinc: ListForFinder[0].PRecord.loinc := AText;
    CL022_snomed: ListForFinder[0].PRecord.snomed := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TCL022Coll.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL022Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TCL022Coll.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL022Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TCL022Coll.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TCL022Item.TPropertyIndex(Field) of
    CL022_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalCL022(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalCL022(logIndex))   
    end;
  end;
end;


procedure TCL022Coll.OnSetTextSearchLog(Log: TlogicalCL022Set);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TCL022Coll.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TCL022Coll.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TCL022Item.TPropertyIndex(propIndex) of
    CL022_Key: Result := actAnsiString;
    CL022_Description: Result := actAnsiString;
    CL022_DescriptionEn: Result := actAnsiString;
    CL022_achi_code: Result := actAnsiString;
    CL022_achi_block: Result := actAnsiString;
    CL022_nhif_package: Result := actAnsiString;
    CL022_nhif_code: Result := actAnsiString;
    CL022_achi_chapter: Result := actAnsiString;
    CL022_loinc: Result := actAnsiString;
    CL022_snomed: Result := actAnsiString;
    CL022_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TCL022Coll.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TCL022Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL022: TCL022Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  CL022 := Items[ARow];
  if not Assigned(CL022.PRecord) then
  begin
    New(CL022.PRecord);
    CL022.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCL022Item.TPropertyIndex(ACol) of
      CL022_Key: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_Description: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_DescriptionEn: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_achi_code: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_achi_block: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_nhif_package: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_nhif_code: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_achi_chapter: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_loinc: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL022_snomed: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(CL022.PRecord.setProp, TCL022Item.TPropertyIndex(ACol));
    if CL022.PRecord.setProp = [] then
    begin
      Dispose(CL022.PRecord);
      CL022.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL022.PRecord.setProp, TCL022Item.TPropertyIndex(ACol));
  case TCL022Item.TPropertyIndex(ACol) of
    CL022_Key: CL022.PRecord.Key := AValue;
    CL022_Description: CL022.PRecord.Description := AValue;
    CL022_DescriptionEn: CL022.PRecord.DescriptionEn := AValue;
    CL022_achi_code: CL022.PRecord.achi_code := AValue;
    CL022_achi_block: CL022.PRecord.achi_block := AValue;
    CL022_nhif_package: CL022.PRecord.nhif_package := AValue;
    CL022_nhif_code: CL022.PRecord.nhif_code := AValue;
    CL022_achi_chapter: CL022.PRecord.achi_chapter := AValue;
    CL022_loinc: CL022.PRecord.loinc := AValue;
    CL022_snomed: CL022.PRecord.snomed := AValue;
    CL022_Logical: CL022.PRecord.Logical := tlogicalCL022Set(CL022.StrToLogical08(AValue));
  end;
end;

procedure TCL022Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL022: TCL022Item;
begin
  if Count = 0 then Exit;
  isOld := False; 
  CL022 := Items[ARow];
  if not Assigned(CL022.PRecord) then
  begin
    New(CL022.PRecord);
    CL022.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCL022Item.TPropertyIndex(ACol) of
      CL022_Key: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_Description: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_DescriptionEn: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_achi_code: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_achi_block: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_nhif_package: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_nhif_code: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_achi_chapter: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_loinc: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL022_snomed: isOld :=  CL022.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(CL022.PRecord.setProp, TCL022Item.TPropertyIndex(ACol));
    if CL022.PRecord.setProp = [] then
    begin
      Dispose(CL022.PRecord);
      CL022.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(CL022.PRecord.setProp, TCL022Item.TPropertyIndex(ACol));
  case TCL022Item.TPropertyIndex(ACol) of
    CL022_Key: CL022.PRecord.Key := AFieldText;
    CL022_Description: CL022.PRecord.Description := AFieldText;
    CL022_DescriptionEn: CL022.PRecord.DescriptionEn := AFieldText;
    CL022_achi_code: CL022.PRecord.achi_code := AFieldText;
    CL022_achi_block: CL022.PRecord.achi_block := AFieldText;
    CL022_nhif_package: CL022.PRecord.nhif_package := AFieldText;
    CL022_nhif_code: CL022.PRecord.nhif_code := AFieldText;
    CL022_achi_chapter: CL022.PRecord.achi_chapter := AFieldText;
    CL022_loinc: CL022.PRecord.loinc := AFieldText;
    CL022_snomed: CL022.PRecord.snomed := AFieldText;
    CL022_Logical: CL022.PRecord.Logical := tlogicalCL022Set(CL022.StrToLogical08(AFieldText));
  end;
end;

procedure TCL022Coll.SetItem(Index: Integer; const Value: TCL022Item);
begin
  inherited SetItem(Index, Value);
end;

procedure TCL022Coll.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListCL022Search.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TCL022Item.TPropertyIndex(self.FindedRes.PropIndex) of
	  CL022_Key:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListCL022Search.Add(self.Items[i]);
  end;
end;
      CL022_Description:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
      CL022_DescriptionEn:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
      CL022_achi_code:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
      CL022_achi_block:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
      CL022_nhif_package:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
      CL022_nhif_code:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
      CL022_achi_chapter:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
      CL022_loinc:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
      CL022_snomed:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListCL022Search.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TCL022Coll.ShowGrid(Grid: TTeeGrid);
var
  i: word;
  clls: TDiffCellRenderer;
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
  
  clls := TDiffCellRenderer.Create(Grid.Cells.OnChange);
  clls.FGrid := Grid;
  clls.FCollAdb := Self;
  Grid.Cells := clls;

  Grid.Columns[self.FieldCount].Width.Value := 50;
  Grid.Columns[self.FieldCount].Index := 0;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width + 1;
  TTeeGRD(Grid).Width  := TTeeGRD(Grid).Width - 1;

end;

procedure TCL022Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL022Item>);
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

procedure TCL022Coll.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListCL022Search.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListCL022Search.Count]);

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

procedure TCL022Coll.SortByIndexAnsiString;
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

procedure TCL022Coll.SortByIndexInt;
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

procedure TCL022Coll.SortByIndexWord;
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

procedure TCL022Coll.SortByIndexValue(propIndex: TCL022Item.TPropertyIndex);
begin
  case propIndex of
    CL022_Key: SortByIndexAnsiString;
      CL022_Description: SortByIndexAnsiString;
      CL022_DescriptionEn: SortByIndexAnsiString;
      CL022_achi_code: SortByIndexAnsiString;
      CL022_achi_block: SortByIndexAnsiString;
      CL022_nhif_package: SortByIndexAnsiString;
      CL022_nhif_code: SortByIndexAnsiString;
      CL022_achi_chapter: SortByIndexAnsiString;
      CL022_loinc: SortByIndexAnsiString;
      CL022_snomed: SortByIndexAnsiString;
  end;
end;

{NZIS_START}
procedure TCL022Coll.ImportXMLNzis(cl000: TObject);
var
 Acl000 : TCL000EntryCollection;
 entry : TCL000EntryItem;
 item : TCL022Item;
 i, idxOld, j: Integer;
 idx : array of Integer;
 propIdx: TCL022Item.TPropertyIndex;
 propName, xmlName, oldValue, newValue: string;
 kindDiff: TDiffKind; pCardinalData: PCardinal;
 dataPosition: Cardinal; IsNew: Boolean;
begin
  Acl000 := TCL000EntryCollection(cl000);
  IsNew := Count = 0;

  for i := 0 to Count - 1 do
  begin
    if PWord(PByte(Buf) + Items[i].DataPos - 4)^ = Ord(ctCL022Del) then
      Continue;
    PWord(PByte(Buf) + Items[i].DataPos - 4)^ := Ord(ctCL022Old);
  end;

  BuildKeyDict(Ord(CL022_Key));

  j := 0;
  SetLength(idx, 0);

  for propIdx := Low(TCL022Item.TPropertyIndex) to High(TCL022Item.TPropertyIndex) do
  begin
    propName := TRttiEnumerationType.GetName(propIdx);

    if SameText(propName, 'CL022_Key') then Continue;
    if SameText(propName, 'CL022_Description') then Continue;
    if SameText(propName, 'CL022_Logical') then Continue;

    xmlName := propName.Substring(Length('CL022_'));
    xmlName := xmlName.Replace('_', ' ');

    for i := 0 to Acl000.FieldsNames.Count - 1 do
      if SameText(Acl000.FieldsNames[i], xmlName) or
         SameText(Acl000.FieldsNames[i], xmlName.Replace(' ', '_')) then
      begin
        SetLength(idx, Length(idx)+1);
        idx[High(idx)] := i;
        Break;
      end;
  end;

  for i := 0 to Acl000.Count - 1 do
  begin
    entry := Acl000.Items[i];

    if KeyDict.TryGetValue(entry.Key, idxOld) then
    begin
      item := Items[idxOld];
      kindDiff := dkChanged;
    end
    else
    begin
      item := TCL022Item(Add);
      kindDiff := dkNew;
    end;

    if item.PRecord <> nil then
      Dispose(item.PRecord);
    New(item.PRecord);
    item.PRecord.setProp := [];

    newValue := entry.Key;
    oldValue := getAnsiStringMap(item.DataPos, Ord(CL022_Key));
    item.PRecord.Key := newValue;
    if oldValue <> newValue then Include(item.PRecord.setProp, CL022_Key);

    newValue := entry.Descr;
    oldValue := getAnsiStringMap(item.DataPos, Ord(CL022_Description));
    item.PRecord.Description := newValue;
    if oldValue <> newValue then Include(item.PRecord.setProp, CL022_Description);

    j := 0;
    // DescriptionEn
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL022_DescriptionEn));

      Item.PRecord.DescriptionEn := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL022_DescriptionEn);
    end;
    Inc(j);

    // achi_code
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL022_achi_code));

      Item.PRecord.achi_code := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL022_achi_code);
    end;
    Inc(j);

    // achi_block
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL022_achi_block));

      Item.PRecord.achi_block := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL022_achi_block);
    end;
    Inc(j);

    // nhif_package
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL022_nhif_package));

      Item.PRecord.nhif_package := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL022_nhif_package);
    end;
    Inc(j);

    // nhif_code
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL022_nhif_code));

      Item.PRecord.nhif_code := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL022_nhif_code);
    end;
    Inc(j);

    // achi_chapter
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL022_achi_chapter));

      Item.PRecord.achi_chapter := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL022_achi_chapter);
    end;
    Inc(j);

    // loinc
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL022_loinc));

      Item.PRecord.loinc := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL022_loinc);
    end;
    Inc(j);

    // snomed
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL022_snomed));

      Item.PRecord.snomed := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL022_snomed);
    end;
    Inc(j);

    // NEW
    if kindDiff = dkNew then
    begin
      if IsNew then
      begin
        item.InsertCL022;
        PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL022);
        Self.streamComm.Len := Self.streamComm.Size;
        Self.cmdFile.CopyFrom(Self.streamComm, 0);
        Dispose(item.PRecord);
        item.PRecord := nil;
      end;
    end
    else
    begin
      // UPDATE
      if item.PRecord.setProp <> [] then
      begin
        if IsNew then
        begin
          pCardinalData := pointer(PByte(Buf) + 12);
          dataPosition := pCardinalData^ + PosData;
          item.SaveCL022(dataPosition);
          PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL022);
          Self.streamComm.Len := Self.streamComm.Size;
          Self.cmdFile.CopyFrom(Self.streamComm, 0);
          pCardinalData^ := dataPosition - PosData;
        end
        else
          PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL022);
      end
      else
      begin
        Dispose(item.PRecord);
        item.PRecord := nil;
        PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL022);
      end;
    end;
  end;
end;

procedure TCL022Coll.UpdateXMLNzis;
var
  i: Integer;
  pCardinalData: PCardinal;
  dataPosition: Cardinal;
begin
  for i := 0 to Count - 1 do
  begin
    if Items[i].PRecord = nil then
    begin
      if Pword(PByte(Buf) + Items[i].DataPos +  - 4)^ = ord(ctCL022Old) then
        Pword(PByte(Buf) + Items[i].DataPos +  - 4)^ := ord(ctCL022Del);
        Continue;
    end;


    if Items[i].DataPos = 0 then
    begin
      Items[i].InsertCL022;
      Self.streamComm.Len := Self.streamComm.Size;
      Self.cmdFile.CopyFrom(Self.streamComm, 0);
      Dispose(Items[i].PRecord);
      Items[i].PRecord := nil;
    end
    else
    begin
      pCardinalData := pointer(PByte(self.Buf) + 12);
      dataPosition := pCardinalData^ + self.PosData;
      Items[i].SaveCL022(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      pCardinalData := pointer(PByte(Buf) + 12);
      pCardinalData^  := dataPosition - self.PosData;
    end;

  end;
end;

procedure TCL022Coll.BuildKeyDict(PropIndex: Word);
var
  i      : Integer;
  item   : TCL022Item;
  keyStr : string;
  pIdx   : TCL022Item.TPropertyIndex;
begin
  // общата част – алокация / чистене на речника
  inherited BuildKeyDict(PropIndex);

  // кастваме Word > enum на генерирания клас
  pIdx := TCL022Item.TPropertyIndex(PropIndex);

  for i := 0 to Count - 1 do
  begin
    item := Items[i];
    if Pword(PByte(Buf) + item.DataPos +  - 4)^ = ord(ctCL022Del) then
      Continue;
    keyStr := self.getAnsiStringMap(item.datapos,PropIndex);

    if keyStr <> '' then
    begin
      // ако има дубликати – последният печели (полезно за "последна версия")
      KeyDict.AddOrSetValue(keyStr, i);
    end;
  end;
end;

function TCL022Coll.CellDiffKind(ACol, ARow: Integer): TDiffKind;
begin
  if (ARow > count) or (ARow < 0) then
    Exit;


  if items[ARow].DataPos = 0 then
  begin
    Result := dkNew;
    Exit;
  end;

  if (Pword(PByte(Buf) + items[ARow].DataPos +  - 4)^ = ord(ctCL022Old)) then
  begin
    Result := dkForDeleted;
    Exit;
  end;

  if (Pword(PByte(Buf) + items[ARow].DataPos +  - 4)^ = ord(ctCL022Del)) then
  begin
    Result := dkDeleted;
    Exit;
  end;

  if Items[ARow].PRecord = nil then
  begin
    Result := dkNone;
    Exit;
  end;

  if TCL022Item.TPropertyIndex(ACol) in Items[ARow].PRecord.setProp then
  begin
    Result := dkChanged;
    Exit;
  end;
  //test

end;

{NZIS_END}

end.