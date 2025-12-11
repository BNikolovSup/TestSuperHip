unit Table.CL024;

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

TLogicalCL024 = (
    Is_);
TlogicalCL024Set = set of TLogicalCL024;


TCL024Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       CL024_Key
       , CL024_Description
       , CL024_DescriptionEn
       , CL024_old_key
       , CL024_cl028
       , CL024_cl022
       , CL024_ucum
       , CL024_cl032
       , CL024_loinc
       , CL024_units
       , CL024_snomed
       , CL024_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecCL024 = ^TRecCL024;
      TRecCL024 = record
        Key: AnsiString;
        Description: AnsiString;
        DescriptionEn: AnsiString;
        old_key: AnsiString;
        cl028: AnsiString;
        cl022: AnsiString;
        ucum: AnsiString;
        cl032: AnsiString;
        loinc: AnsiString;
        units: AnsiString;
        snomed: AnsiString;
        Logical: TlogicalCL024Set;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecCL024;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertCL024;
    procedure UpdateCL024;
    procedure SaveCL024(var dataPosition: Cardinal)overload;
	procedure SaveCL024(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
	procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
	procedure FillPropCL024(propindex: TPropertyIndex; stream: TStream);
  end;


  TCL024Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TCL024Item;
    function GetItem(Index: Integer): TCL024Item;
    procedure SetItem(Index: Integer; const Value: TCL024Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TCL024Item>;
    ListCL024Search: TList<TCL024Item>;
	PRecordSearch: ^TCL024Item.TRecCL024;
    ArrPropSearch: TArray<TCL024Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCL024Item.TPropertyIndex>;
	VisibleColl: TCL024Item.TSetProp;
	ArrayPropOrder: TArray<TCL024Item.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL024Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; CL024: TCL024Item; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; CL024: TCL024Item; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TCL024Item.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL024Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL024Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCL024Item.TPropertyIndex);
    property Items[Index: Integer]: TCL024Item read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalCL024Set);
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

procedure TCL024Item.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TCL024Item.GetCollType: TCollectionsType;
begin
  Result := ctCL024;
end;

function TCL024Item.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
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
            CL024_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL024_old_key: SaveData(PRecord.old_key, PropPosition, metaPosition, dataPosition);
            CL024_cl028: SaveData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL024_cl022: SaveData(PRecord.cl022, PropPosition, metaPosition, dataPosition);
            CL024_ucum: SaveData(PRecord.ucum, PropPosition, metaPosition, dataPosition);
            CL024_cl032: SaveData(PRecord.cl032, PropPosition, metaPosition, dataPosition);
            CL024_loinc: SaveData(PRecord.loinc, PropPosition, metaPosition, dataPosition);
            CL024_units: SaveData(PRecord.units, PropPosition, metaPosition, dataPosition);
            CL024_snomed: SaveData(PRecord.snomed, PropPosition, metaPosition, dataPosition);
            CL024_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TCL024Item.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TCL024Item.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TCL024Item;
begin
  Result := True;
  for i := 0 to Length(TCL024Coll(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TCL024Coll(coll).ArrPropSearchClc[i];
	ATempItem := TCL024Coll(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        CL024_Key: Result := IsFinded(ATempItem.PRecord.Key, buf, FPosDataADB, word(CL024_Key), cot);
            CL024_Description: Result := IsFinded(ATempItem.PRecord.Description, buf, FPosDataADB, word(CL024_Description), cot);
            CL024_DescriptionEn: Result := IsFinded(ATempItem.PRecord.DescriptionEn, buf, FPosDataADB, word(CL024_DescriptionEn), cot);
            CL024_old_key: Result := IsFinded(ATempItem.PRecord.old_key, buf, FPosDataADB, word(CL024_old_key), cot);
            CL024_cl028: Result := IsFinded(ATempItem.PRecord.cl028, buf, FPosDataADB, word(CL024_cl028), cot);
            CL024_cl022: Result := IsFinded(ATempItem.PRecord.cl022, buf, FPosDataADB, word(CL024_cl022), cot);
            CL024_ucum: Result := IsFinded(ATempItem.PRecord.ucum, buf, FPosDataADB, word(CL024_ucum), cot);
            CL024_cl032: Result := IsFinded(ATempItem.PRecord.cl032, buf, FPosDataADB, word(CL024_cl032), cot);
            CL024_loinc: Result := IsFinded(ATempItem.PRecord.loinc, buf, FPosDataADB, word(CL024_loinc), cot);
            CL024_units: Result := IsFinded(ATempItem.PRecord.units, buf, FPosDataADB, word(CL024_units), cot);
            CL024_snomed: Result := IsFinded(ATempItem.PRecord.snomed, buf, FPosDataADB, word(CL024_snomed), cot);
            CL024_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(CL024_Logical), cot);
      end;
    end;
  end;
end;

procedure TCL024Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds16: TLogicalData16;
  propindexCL024: TCL024Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData16);
  stream.Read(flds16, sizeof(TLogicalData16));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := TCL024Item.TSetProp(flds16);// тука се записва какво има като полета


  for propindexCL024 := Low(TCL024Item.TPropertyIndex) to High(TCL024Item.TPropertyIndex) do
  begin
    if not (propindexCL024 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexCL024);
      dataCmdProp.vid := vvCL024;
    end;
    self.FillPropCL024(propindexCL024, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCL024Item.FillPropCL024(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    CL024_Key:
        begin
          stream.Read(lenStr, 2);
          SetLength(Self.PRecord.Key, lenStr);
          stream.Read(Self.PRecord.Key[1], lenStr);
        end;
            CL024_Description:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.Description, lenStr);
              stream.Read(Self.PRecord.Description[1], lenStr);
            end;
            CL024_DescriptionEn:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.DescriptionEn, lenStr);
              stream.Read(Self.PRecord.DescriptionEn[1], lenStr);
            end;
            CL024_old_key:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.old_key, lenStr);
              stream.Read(Self.PRecord.old_key[1], lenStr);
            end;
            CL024_cl028:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.cl028, lenStr);
              stream.Read(Self.PRecord.cl028[1], lenStr);
            end;
            CL024_cl022:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.cl022, lenStr);
              stream.Read(Self.PRecord.cl022[1], lenStr);
            end;
            CL024_ucum:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.ucum, lenStr);
              stream.Read(Self.PRecord.ucum[1], lenStr);
            end;
            CL024_cl032:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.cl032, lenStr);
              stream.Read(Self.PRecord.cl032[1], lenStr);
            end;
            CL024_loinc:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.loinc, lenStr);
              stream.Read(Self.PRecord.loinc[1], lenStr);
            end;
            CL024_units:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.units, lenStr);
              stream.Read(Self.PRecord.units[1], lenStr);
            end;
            CL024_snomed:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.snomed, lenStr);
              stream.Read(Self.PRecord.snomed[1], lenStr);
            end;
            CL024_Logical: stream.Read(Self.PRecord.Logical, SizeOf(TLogicalData08));
  end;
end;

procedure TCL024Item.SaveCL024(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveCL024(dataPosition);
end;

procedure TCL024Item.SaveCL024(var dataPosition: Cardinal);
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
            CL024_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL024_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL024_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL024_old_key: SaveData(PRecord.old_key, PropPosition, metaPosition, dataPosition);
            CL024_cl028: SaveData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL024_cl022: SaveData(PRecord.cl022, PropPosition, metaPosition, dataPosition);
            CL024_ucum: SaveData(PRecord.ucum, PropPosition, metaPosition, dataPosition);
            CL024_cl032: SaveData(PRecord.cl032, PropPosition, metaPosition, dataPosition);
            CL024_loinc: SaveData(PRecord.loinc, PropPosition, metaPosition, dataPosition);
            CL024_units: SaveData(PRecord.units, PropPosition, metaPosition, dataPosition);
            CL024_snomed: SaveData(PRecord.snomed, PropPosition, metaPosition, dataPosition);
            CL024_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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
            CL024_DescriptionEn: UpdateData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL024_old_key: UpdateData(PRecord.old_key, PropPosition, metaPosition, dataPosition);
            CL024_cl028: UpdateData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL024_cl022: UpdateData(PRecord.cl022, PropPosition, metaPosition, dataPosition);
            CL024_ucum: UpdateData(PRecord.ucum, PropPosition, metaPosition, dataPosition);
            CL024_cl032: UpdateData(PRecord.cl032, PropPosition, metaPosition, dataPosition);
            CL024_loinc: UpdateData(PRecord.loinc, PropPosition, metaPosition, dataPosition);
            CL024_units: UpdateData(PRecord.units, PropPosition, metaPosition, dataPosition);
            CL024_snomed: UpdateData(PRecord.snomed, PropPosition, metaPosition, dataPosition);
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

function TCL024Coll.AddItemForSearch: Integer;
var
  ItemForSearch: TCL024Item;
begin
  ItemForSearch := TCL024Item.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TCL024Coll.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TCL024Item.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TCL024Coll.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvCL024Root, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TCL024Coll.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TCL024Item;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

      if (CL024_Key in tempItem.PRecord.setProp) and (tempItem.PRecord.Key <> Self.getAnsiStringMap(tempItem.DataPos, word(CL024_Key))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL024_Description in tempItem.PRecord.setProp) and (tempItem.PRecord.Description <> Self.getAnsiStringMap(tempItem.DataPos, word(CL024_Description))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL024_DescriptionEn in tempItem.PRecord.setProp) and (tempItem.PRecord.DescriptionEn <> Self.getAnsiStringMap(tempItem.DataPos, word(CL024_DescriptionEn))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL024_old_key in tempItem.PRecord.setProp) and (tempItem.PRecord.old_key <> Self.getAnsiStringMap(tempItem.DataPos, word(CL024_old_key))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL024_cl028 in tempItem.PRecord.setProp) and (tempItem.PRecord.cl028 <> Self.getAnsiStringMap(tempItem.DataPos, word(CL024_cl028))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL024_cl022 in tempItem.PRecord.setProp) and (tempItem.PRecord.cl022 <> Self.getAnsiStringMap(tempItem.DataPos, word(CL024_cl022))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL024_ucum in tempItem.PRecord.setProp) and (tempItem.PRecord.ucum <> Self.getAnsiStringMap(tempItem.DataPos, word(CL024_ucum))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL024_cl032 in tempItem.PRecord.setProp) and (tempItem.PRecord.cl032 <> Self.getAnsiStringMap(tempItem.DataPos, word(CL024_cl032))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL024_loinc in tempItem.PRecord.setProp) and (tempItem.PRecord.loinc <> Self.getAnsiStringMap(tempItem.DataPos, word(CL024_loinc))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL024_units in tempItem.PRecord.setProp) and (tempItem.PRecord.units <> Self.getAnsiStringMap(tempItem.DataPos, word(CL024_units))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL024_snomed in tempItem.PRecord.setProp) and (tempItem.PRecord.snomed <> Self.getAnsiStringMap(tempItem.DataPos, word(CL024_snomed))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL024_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(CL024_Logical))) then
      begin
        inc(cnt);
        exit;
      end;
    end;
  end;
end;


constructor TCL024Coll.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TCL024Item.Create(nil);
  ListCL024Search := TList<TCL024Item>.Create;
  ListForFinder := TList<TCL024Item>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TCL024Coll.destroy;
begin
  FreeAndNil(ListCL024Search);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TCL024Coll.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TCL024Item.TPropertyIndex(propIndex) of
    CL024_Key: Result := 'Key';
    CL024_Description: Result := 'Description';
    CL024_DescriptionEn: Result := 'DescriptionEn';
    CL024_old_key: Result := 'old_key';
    CL024_cl028: Result := 'cl028';
    CL024_cl022: Result := 'cl022';
    CL024_ucum: Result := 'ucum';
    CL024_cl032: Result := 'cl032';
    CL024_loinc: Result := 'loinc';
    CL024_units: Result := 'units';
    CL024_snomed: Result := 'snomed';
    CL024_Logical: Result := 'Logical';
  end;
end;

function TCL024Coll.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'Is_';
  else
    Result := '???';
  end;
end;


procedure TCL024Coll.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TCL024Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 12;
end;

function TCL024Coll.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvCL024Root then
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

function TCL024Coll.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TCL024Coll.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TCL024Coll.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TCL024Coll.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TCL024Item.TPropertyIndex;
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

procedure TCL024Coll.GetCellFromRecord(propIndex: word; CL024: TCL024Item; var AValue: String);
var
  str: string;
begin
  case TCL024Item.TPropertyIndex(propIndex) of
    CL024_Key: str := (CL024.PRecord.Key);
    CL024_Description: str := (CL024.PRecord.Description);
    CL024_DescriptionEn: str := (CL024.PRecord.DescriptionEn);
    CL024_old_key: str := (CL024.PRecord.old_key);
    CL024_cl028: str := (CL024.PRecord.cl028);
    CL024_cl022: str := (CL024.PRecord.cl022);
    CL024_ucum: str := (CL024.PRecord.ucum);
    CL024_cl032: str := (CL024.PRecord.cl032);
    CL024_loinc: str := (CL024.PRecord.loinc);
    CL024_units: str := (CL024.PRecord.units);
    CL024_snomed: str := (CL024.PRecord.snomed);
    CL024_Logical: str := CL024.Logical08ToStr(TLogicalData08(CL024.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TCL024Coll.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TCL024Item;
  ACol: Integer;
  prop: TCL024Item.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TCL024Item.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TCL024Coll.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TCL024Item.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TCL024Item.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
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

function TCL024Coll.GetCollType: TCollectionsType;
begin
  Result := ctCL024;
end;

function TCL024Coll.GetCollDelType: TCollectionsType;
begin
  Result := ctCL024Del;
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
    CL024_DescriptionEn: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_old_key: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_cl028: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_cl022: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_ucum: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_cl032: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_loinc: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_units: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_snomed: str :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL024_Logical: str :=  CL024.Logical08ToStr(CL024.getLogical08Map(Self.Buf, Self.posData, propIndex));
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
      CL024_DescriptionEn:
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
      CL024_snomed:
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

procedure TCL024Coll.IndexValueListNodes(propIndex: TCL024Item.TPropertyIndex);
begin

end;

function TCL024Coll.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TCL024Item.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TCL024Coll.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TCL024Item;
begin
  if index < 0 then
  begin
    Tempitem := TCL024Item.Create(nil);
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
procedure TCL024Coll.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TCL024Item.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TCL024Item.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TCL024Item.TPropertyIndex(Field) of
CL024_Key: ListForFinder[0].PRecord.Key := AText;
    CL024_Description: ListForFinder[0].PRecord.Description := AText;
    CL024_DescriptionEn: ListForFinder[0].PRecord.DescriptionEn := AText;
    CL024_old_key: ListForFinder[0].PRecord.old_key := AText;
    CL024_cl028: ListForFinder[0].PRecord.cl028 := AText;
    CL024_cl022: ListForFinder[0].PRecord.cl022 := AText;
    CL024_ucum: ListForFinder[0].PRecord.ucum := AText;
    CL024_cl032: ListForFinder[0].PRecord.cl032 := AText;
    CL024_loinc: ListForFinder[0].PRecord.loinc := AText;
    CL024_units: ListForFinder[0].PRecord.units := AText;
    CL024_snomed: ListForFinder[0].PRecord.snomed := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TCL024Coll.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL024Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TCL024Coll.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL024Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TCL024Coll.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TCL024Item.TPropertyIndex(Field) of
    CL024_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalCL024(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalCL024(logIndex))   
    end;
  end;
end;


procedure TCL024Coll.OnSetTextSearchLog(Log: TlogicalCL024Set);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TCL024Coll.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TCL024Coll.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TCL024Item.TPropertyIndex(propIndex) of
    CL024_Key: Result := actAnsiString;
    CL024_Description: Result := actAnsiString;
    CL024_DescriptionEn: Result := actAnsiString;
    CL024_old_key: Result := actAnsiString;
    CL024_cl028: Result := actAnsiString;
    CL024_cl022: Result := actAnsiString;
    CL024_ucum: Result := actAnsiString;
    CL024_cl032: Result := actAnsiString;
    CL024_loinc: Result := actAnsiString;
    CL024_units: Result := actAnsiString;
    CL024_snomed: Result := actAnsiString;
    CL024_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TCL024Coll.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TCL024Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL024: TCL024Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  CL024 := Items[ARow];
  if not Assigned(CL024.PRecord) then
  begin
    New(CL024.PRecord);
    CL024.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCL024Item.TPropertyIndex(ACol) of
      CL024_Key: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_Description: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_DescriptionEn: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_old_key: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_cl028: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_cl022: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_ucum: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_cl032: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_loinc: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_units: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL024_snomed: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
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
    CL024_DescriptionEn: CL024.PRecord.DescriptionEn := AValue;
    CL024_old_key: CL024.PRecord.old_key := AValue;
    CL024_cl028: CL024.PRecord.cl028 := AValue;
    CL024_cl022: CL024.PRecord.cl022 := AValue;
    CL024_ucum: CL024.PRecord.ucum := AValue;
    CL024_cl032: CL024.PRecord.cl032 := AValue;
    CL024_loinc: CL024.PRecord.loinc := AValue;
    CL024_units: CL024.PRecord.units := AValue;
    CL024_snomed: CL024.PRecord.snomed := AValue;
    CL024_Logical: CL024.PRecord.Logical := tlogicalCL024Set(CL024.StrToLogical08(AValue));
  end;
end;

procedure TCL024Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL024: TCL024Item;
begin
  if Count = 0 then Exit;
  isOld := False; 
  CL024 := Items[ARow];
  if not Assigned(CL024.PRecord) then
  begin
    New(CL024.PRecord);
    CL024.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCL024Item.TPropertyIndex(ACol) of
      CL024_Key: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_Description: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_DescriptionEn: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_old_key: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_cl028: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_cl022: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_ucum: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_cl032: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_loinc: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_units: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL024_snomed: isOld :=  CL024.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
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
    CL024_DescriptionEn: CL024.PRecord.DescriptionEn := AFieldText;
    CL024_old_key: CL024.PRecord.old_key := AFieldText;
    CL024_cl028: CL024.PRecord.cl028 := AFieldText;
    CL024_cl022: CL024.PRecord.cl022 := AFieldText;
    CL024_ucum: CL024.PRecord.ucum := AFieldText;
    CL024_cl032: CL024.PRecord.cl032 := AFieldText;
    CL024_loinc: CL024.PRecord.loinc := AFieldText;
    CL024_units: CL024.PRecord.units := AFieldText;
    CL024_snomed: CL024.PRecord.snomed := AFieldText;
    CL024_Logical: CL024.PRecord.Logical := tlogicalCL024Set(CL024.StrToLogical08(AFieldText));
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
      CL024_DescriptionEn:
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
      CL024_cl028:
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
      CL024_snomed:
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

procedure TCL024Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL024Item>);
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
  grid.Margins.Left := 100;
  grid.Margins.Left := 0;
  grid.Scrolling.Active := true;
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
      CL024_DescriptionEn: SortByIndexAnsiString;
      CL024_old_key: SortByIndexAnsiString;
      CL024_cl028: SortByIndexAnsiString;
      CL024_cl022: SortByIndexAnsiString;
      CL024_ucum: SortByIndexAnsiString;
      CL024_cl032: SortByIndexAnsiString;
      CL024_loinc: SortByIndexAnsiString;
      CL024_units: SortByIndexAnsiString;
      CL024_snomed: SortByIndexAnsiString;
  end;
end;

{NZIS_START}
procedure TCL024Coll.ImportXMLNzis(cl000: TObject);
var
 Acl000 : TCL000EntryCollection;
 entry : TCL000EntryItem;
 item : TCL024Item;
 i, idxOld, j: Integer;
 idx : array of Integer;
 propIdx: TCL024Item.TPropertyIndex;
 propName, xmlName, oldValue, newValue: string;
 kindDiff: TDiffKind; pCardinalData: PCardinal;
 dataPosition: Cardinal; IsNew: Boolean;
begin
  Acl000 := TCL000EntryCollection(cl000);
  IsNew := Count = 0;

  for i := 0 to Count - 1 do
  begin
    if PWord(PByte(Buf) + Items[i].DataPos - 4)^ = Ord(ctCL024Del) then
      Continue;
    PWord(PByte(Buf) + Items[i].DataPos - 4)^ := Ord(ctCL024Old);
  end;

  BuildKeyDict(Ord(CL024_Key));

  j := 0;
  SetLength(idx, 0);

  for propIdx := Low(TCL024Item.TPropertyIndex) to High(TCL024Item.TPropertyIndex) do
  begin
    propName := TRttiEnumerationType.GetName(propIdx);

    if SameText(propName, 'CL024_Key') then Continue;
    if SameText(propName, 'CL024_Description') then Continue;
    if SameText(propName, 'CL024_Logical') then Continue;

    xmlName := propName.Substring(Length('CL024_'));
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
      item := TCL024Item(Add);
      kindDiff := dkNew;
    end;

    if item.PRecord <> nil then
      Dispose(item.PRecord);
    New(item.PRecord);
    item.PRecord.setProp := [];

    newValue := entry.Key;
    oldValue := getAnsiStringMap(item.DataPos, Ord(CL024_Key));
    item.PRecord.Key := newValue;
    if oldValue <> newValue then Include(item.PRecord.setProp, CL024_Key);

    newValue := entry.Descr;
    oldValue := getAnsiStringMap(item.DataPos, Ord(CL024_Description));
    item.PRecord.Description := newValue;
    if oldValue <> newValue then Include(item.PRecord.setProp, CL024_Description);

    j := 0;
    // DescriptionEn
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL024_DescriptionEn));

      Item.PRecord.DescriptionEn := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL024_DescriptionEn);
    end;
    Inc(j);

    // old_key
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL024_old_key));

      Item.PRecord.old_key := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL024_old_key);
    end;
    Inc(j);

    // cl028
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL024_cl028));

      Item.PRecord.cl028 := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL024_cl028);
    end;
    Inc(j);

    // cl022
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL024_cl022));

      Item.PRecord.cl022 := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL024_cl022);
    end;
    Inc(j);

    // ucum
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL024_ucum));

      Item.PRecord.ucum := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL024_ucum);
    end;
    Inc(j);

    // cl032
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL024_cl032));

      Item.PRecord.cl032 := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL024_cl032);
    end;
    Inc(j);

    // loinc
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL024_loinc));

      Item.PRecord.loinc := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL024_loinc);
    end;
    Inc(j);

    // units
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL024_units));

      Item.PRecord.units := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL024_units);
    end;
    Inc(j);

    // snomed
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL024_snomed));

      Item.PRecord.snomed := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL024_snomed);
    end;
    Inc(j);

    // NEW
    if kindDiff = dkNew then
    begin
      if IsNew then
      begin
        item.InsertCL024;
        PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL024);
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
          item.SaveCL024(dataPosition);
          PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL024);
          Self.streamComm.Len := Self.streamComm.Size;
          Self.cmdFile.CopyFrom(Self.streamComm, 0);
          pCardinalData^ := dataPosition - PosData;
        end
        else
          PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL024);
      end
      else
      begin
        Dispose(item.PRecord);
        item.PRecord := nil;
        PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL024);
      end;
    end;
  end;
end;

procedure TCL024Coll.UpdateXMLNzis;
var
  i: Integer;
  pCardinalData: PCardinal;
  dataPosition: Cardinal;
begin
  for i := 0 to Count - 1 do
  begin
    if Items[i].PRecord = nil then
    begin
      if Pword(PByte(Buf) + Items[i].DataPos +  - 4)^ = ord(ctCL024Old) then
        Pword(PByte(Buf) + Items[i].DataPos +  - 4)^ := ord(ctCL024Del);
        Continue;
    end;


    if Items[i].DataPos = 0 then
    begin
      Items[i].InsertCL024;
      Self.streamComm.Len := Self.streamComm.Size;
      Self.cmdFile.CopyFrom(Self.streamComm, 0);
      Dispose(Items[i].PRecord);
      Items[i].PRecord := nil;
    end
    else
    begin
      pCardinalData := pointer(PByte(self.Buf) + 12);
      dataPosition := pCardinalData^ + self.PosData;
      Items[i].SaveCL024(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      pCardinalData := pointer(PByte(Buf) + 12);
      pCardinalData^  := dataPosition - self.PosData;
    end;

  end;
end;

procedure TCL024Coll.BuildKeyDict(PropIndex: Word);
var
  i      : Integer;
  item   : TCL024Item;
  keyStr : string;
  pIdx   : TCL024Item.TPropertyIndex;
begin
  // общата част – алокация / чистене на речника
  inherited BuildKeyDict(PropIndex);

  // кастваме Word > enum на генерирания клас
  pIdx := TCL024Item.TPropertyIndex(PropIndex);

  for i := 0 to Count - 1 do
  begin
    item := Items[i];
    if Pword(PByte(Buf) + item.DataPos +  - 4)^ = ord(ctCL024Del) then
      Continue;
    keyStr := self.getAnsiStringMap(item.datapos,PropIndex);

    if keyStr <> '' then
    begin
      // ако има дубликати – последният печели (полезно за "последна версия")
      KeyDict.AddOrSetValue(keyStr, i);
    end;
  end;
end;

function TCL024Coll.CellDiffKind(ACol, ARow: Integer): TDiffKind;
begin
  if (ARow > count) or (ARow < 0) then
    Exit;


  if items[ARow].DataPos = 0 then
  begin
    Result := dkNew;
    Exit;
  end;

  if (Pword(PByte(Buf) + items[ARow].DataPos +  - 4)^ = ord(ctCL024Old)) then
  begin
    Result := dkForDeleted;
    Exit;
  end;

  if (Pword(PByte(Buf) + items[ARow].DataPos +  - 4)^ = ord(ctCL024Del)) then
  begin
    Result := dkDeleted;
    Exit;
  end;

  if Items[ARow].PRecord = nil then
  begin
    Result := dkNone;
    Exit;
  end;

  if TCL024Item.TPropertyIndex(ACol) in Items[ARow].PRecord.setProp then
  begin
    Result := dkChanged;
    Exit;
  end;
  //test

end;

{NZIS_END}

end.