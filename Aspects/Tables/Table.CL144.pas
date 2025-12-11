unit Table.CL144;

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

TLogicalCL144 = (
    Is_);
TlogicalCL144Set = set of TLogicalCL144;


TCL144Item = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       CL144_Key
       , CL144_Description
       , CL144_note
       , CL144_cl142
       , CL144_units
       , CL144_cl012
       , CL144_cl028
       , CL144_cl138
       , CL144_conclusion
       , CL144_DescriptionEn
       , CL144_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecCL144 = ^TRecCL144;
      TRecCL144 = record
        Key: AnsiString;
        Description: AnsiString;
        note: AnsiString;
        cl142: AnsiString;
        units: AnsiString;
        cl012: AnsiString;
        cl028: AnsiString;
        cl138: AnsiString;
        conclusion: AnsiString;
        DescriptionEn: AnsiString;
        Logical: TlogicalCL144Set;
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
    procedure SaveCL144(var dataPosition: Cardinal)overload;
	procedure SaveCL144(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
	procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
	procedure FillPropCL144(propindex: TPropertyIndex; stream: TStream);
  end;


  TCL144Coll = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TCL144Item;
    function GetItem(Index: Integer): TCL144Item;
    procedure SetItem(Index: Integer; const Value: TCL144Item);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TCL144Item>;
    ListCL144Search: TList<TCL144Item>;
	PRecordSearch: ^TCL144Item.TRecCL144;
    ArrPropSearch: TArray<TCL144Item.TPropertyIndex>;
    ArrPropSearchClc: TArray<TCL144Item.TPropertyIndex>;
	VisibleColl: TCL144Item.TSetProp;
	ArrayPropOrder: TArray<TCL144Item.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TCL144Item;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL144Item>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TCL144Item.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TCL144Item.TPropertyIndex);
    property Items[Index: Integer]: TCL144Item read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalCL144Set);
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

procedure TCL144Item.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TCL144Item.GetCollType: TCollectionsType;
begin
  Result := ctCL144;
end;

function TCL144Item.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
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
            CL144_note: SaveData(PRecord.note, PropPosition, metaPosition, dataPosition);
            CL144_cl142: SaveData(PRecord.cl142, PropPosition, metaPosition, dataPosition);
            CL144_units: SaveData(PRecord.units, PropPosition, metaPosition, dataPosition);
            CL144_cl012: SaveData(PRecord.cl012, PropPosition, metaPosition, dataPosition);
            CL144_cl028: SaveData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL144_cl138: SaveData(PRecord.cl138, PropPosition, metaPosition, dataPosition);
            CL144_conclusion: SaveData(PRecord.conclusion, PropPosition, metaPosition, dataPosition);
            CL144_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL144_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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
	ATempItem := TCL144Coll(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        CL144_Key: Result := IsFinded(ATempItem.PRecord.Key, buf, FPosDataADB, word(CL144_Key), cot);
            CL144_Description: Result := IsFinded(ATempItem.PRecord.Description, buf, FPosDataADB, word(CL144_Description), cot);
            CL144_note: Result := IsFinded(ATempItem.PRecord.note, buf, FPosDataADB, word(CL144_note), cot);
            CL144_cl142: Result := IsFinded(ATempItem.PRecord.cl142, buf, FPosDataADB, word(CL144_cl142), cot);
            CL144_units: Result := IsFinded(ATempItem.PRecord.units, buf, FPosDataADB, word(CL144_units), cot);
            CL144_cl012: Result := IsFinded(ATempItem.PRecord.cl012, buf, FPosDataADB, word(CL144_cl012), cot);
            CL144_cl028: Result := IsFinded(ATempItem.PRecord.cl028, buf, FPosDataADB, word(CL144_cl028), cot);
            CL144_cl138: Result := IsFinded(ATempItem.PRecord.cl138, buf, FPosDataADB, word(CL144_cl138), cot);
            CL144_conclusion: Result := IsFinded(ATempItem.PRecord.conclusion, buf, FPosDataADB, word(CL144_conclusion), cot);
            CL144_DescriptionEn: Result := IsFinded(ATempItem.PRecord.DescriptionEn, buf, FPosDataADB, word(CL144_DescriptionEn), cot);
            CL144_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(CL144_Logical), cot);
      end;
    end;
  end;
end;

procedure TCL144Item.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds16: TLogicalData16;
  propindexCL144: TCL144Item.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData16);
  stream.Read(flds16, sizeof(TLogicalData16));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := TCL144Item.TSetProp(flds16);// тука се записва какво има като полета


  for propindexCL144 := Low(TCL144Item.TPropertyIndex) to High(TCL144Item.TPropertyIndex) do
  begin
    if not (propindexCL144 in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexCL144);
      dataCmdProp.vid := vvCL144;
    end;
    self.FillPropCL144(propindexCL144, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TCL144Item.FillPropCL144(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    CL144_Key:
        begin
          stream.Read(lenStr, 2);
          SetLength(Self.PRecord.Key, lenStr);
          stream.Read(Self.PRecord.Key[1], lenStr);
        end;
            CL144_Description:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.Description, lenStr);
              stream.Read(Self.PRecord.Description[1], lenStr);
            end;
            CL144_note:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.note, lenStr);
              stream.Read(Self.PRecord.note[1], lenStr);
            end;
            CL144_cl142:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.cl142, lenStr);
              stream.Read(Self.PRecord.cl142[1], lenStr);
            end;
            CL144_units:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.units, lenStr);
              stream.Read(Self.PRecord.units[1], lenStr);
            end;
            CL144_cl012:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.cl012, lenStr);
              stream.Read(Self.PRecord.cl012[1], lenStr);
            end;
            CL144_cl028:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.cl028, lenStr);
              stream.Read(Self.PRecord.cl028[1], lenStr);
            end;
            CL144_cl138:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.cl138, lenStr);
              stream.Read(Self.PRecord.cl138[1], lenStr);
            end;
            CL144_conclusion:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.conclusion, lenStr);
              stream.Read(Self.PRecord.conclusion[1], lenStr);
            end;
            CL144_DescriptionEn:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.DescriptionEn, lenStr);
              stream.Read(Self.PRecord.DescriptionEn[1], lenStr);
            end;
            CL144_Logical: stream.Read(Self.PRecord.Logical, SizeOf(TLogicalData08));
  end;
end;

procedure TCL144Item.SaveCL144(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveCL144(dataPosition);
end;

procedure TCL144Item.SaveCL144(var dataPosition: Cardinal);
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
            CL144_Key: SaveData(PRecord.Key, PropPosition, metaPosition, dataPosition);
            CL144_Description: SaveData(PRecord.Description, PropPosition, metaPosition, dataPosition);
            CL144_note: SaveData(PRecord.note, PropPosition, metaPosition, dataPosition);
            CL144_cl142: SaveData(PRecord.cl142, PropPosition, metaPosition, dataPosition);
            CL144_units: SaveData(PRecord.units, PropPosition, metaPosition, dataPosition);
            CL144_cl012: SaveData(PRecord.cl012, PropPosition, metaPosition, dataPosition);
            CL144_cl028: SaveData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL144_cl138: SaveData(PRecord.cl138, PropPosition, metaPosition, dataPosition);
            CL144_conclusion: SaveData(PRecord.conclusion, PropPosition, metaPosition, dataPosition);
            CL144_DescriptionEn: SaveData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
            CL144_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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
            CL144_note: UpdateData(PRecord.note, PropPosition, metaPosition, dataPosition);
            CL144_cl142: UpdateData(PRecord.cl142, PropPosition, metaPosition, dataPosition);
            CL144_units: UpdateData(PRecord.units, PropPosition, metaPosition, dataPosition);
            CL144_cl012: UpdateData(PRecord.cl012, PropPosition, metaPosition, dataPosition);
            CL144_cl028: UpdateData(PRecord.cl028, PropPosition, metaPosition, dataPosition);
            CL144_cl138: UpdateData(PRecord.cl138, PropPosition, metaPosition, dataPosition);
            CL144_conclusion: UpdateData(PRecord.conclusion, PropPosition, metaPosition, dataPosition);
            CL144_DescriptionEn: UpdateData(PRecord.DescriptionEn, PropPosition, metaPosition, dataPosition);
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
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TCL144Coll.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TCL144Item.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TCL144Coll.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvCL144Root, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TCL144Coll.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TCL144Item;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

      if (CL144_Key in tempItem.PRecord.setProp) and (tempItem.PRecord.Key <> Self.getAnsiStringMap(tempItem.DataPos, word(CL144_Key))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL144_Description in tempItem.PRecord.setProp) and (tempItem.PRecord.Description <> Self.getAnsiStringMap(tempItem.DataPos, word(CL144_Description))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL144_note in tempItem.PRecord.setProp) and (tempItem.PRecord.note <> Self.getAnsiStringMap(tempItem.DataPos, word(CL144_note))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL144_cl142 in tempItem.PRecord.setProp) and (tempItem.PRecord.cl142 <> Self.getAnsiStringMap(tempItem.DataPos, word(CL144_cl142))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL144_units in tempItem.PRecord.setProp) and (tempItem.PRecord.units <> Self.getAnsiStringMap(tempItem.DataPos, word(CL144_units))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL144_cl012 in tempItem.PRecord.setProp) and (tempItem.PRecord.cl012 <> Self.getAnsiStringMap(tempItem.DataPos, word(CL144_cl012))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL144_cl028 in tempItem.PRecord.setProp) and (tempItem.PRecord.cl028 <> Self.getAnsiStringMap(tempItem.DataPos, word(CL144_cl028))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL144_cl138 in tempItem.PRecord.setProp) and (tempItem.PRecord.cl138 <> Self.getAnsiStringMap(tempItem.DataPos, word(CL144_cl138))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL144_conclusion in tempItem.PRecord.setProp) and (tempItem.PRecord.conclusion <> Self.getAnsiStringMap(tempItem.DataPos, word(CL144_conclusion))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL144_DescriptionEn in tempItem.PRecord.setProp) and (tempItem.PRecord.DescriptionEn <> Self.getAnsiStringMap(tempItem.DataPos, word(CL144_DescriptionEn))) then
      begin
        inc(cnt);
        exit;
      end;

      if (CL144_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(CL144_Logical))) then
      begin
        inc(cnt);
        exit;
      end;
    end;
  end;
end;


constructor TCL144Coll.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TCL144Item.Create(nil);
  ListCL144Search := TList<TCL144Item>.Create;
  ListForFinder := TList<TCL144Item>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TCL144Coll.destroy;
begin
  FreeAndNil(ListCL144Search);
  FreeAndNil(ListForFinder);
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
    CL144_note: Result := 'note';
    CL144_cl142: Result := 'cl142';
    CL144_units: Result := 'units';
    CL144_cl012: Result := 'cl012';
    CL144_cl028: Result := 'cl028';
    CL144_cl138: Result := 'cl138';
    CL144_conclusion: Result := 'conclusion';
    CL144_DescriptionEn: Result := 'DescriptionEn';
    CL144_Logical: Result := 'Logical';
  end;
end;

function TCL144Coll.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'Is_';
  else
    Result := '???';
  end;
end;


procedure TCL144Coll.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TCL144Coll.FieldCount: Integer; 
begin
  inherited;
  Result := 11;
end;

function TCL144Coll.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvCL144Root then
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

function TCL144Coll.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TCL144Coll.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TCL144Coll.FindSearchFieldCollOptionNode(): PVirtualNode;
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
  RowSelect: Integer;
  prop: TCL144Item.TPropertyIndex;
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

procedure TCL144Coll.GetCellFromRecord(propIndex: word; CL144: TCL144Item; var AValue: String);
var
  str: string;
begin
  case TCL144Item.TPropertyIndex(propIndex) of
    CL144_Key: str := (CL144.PRecord.Key);
    CL144_Description: str := (CL144.PRecord.Description);
    CL144_note: str := (CL144.PRecord.note);
    CL144_cl142: str := (CL144.PRecord.cl142);
    CL144_units: str := (CL144.PRecord.units);
    CL144_cl012: str := (CL144.PRecord.cl012);
    CL144_cl028: str := (CL144.PRecord.cl028);
    CL144_cl138: str := (CL144.PRecord.cl138);
    CL144_conclusion: str := (CL144.PRecord.conclusion);
    CL144_DescriptionEn: str := (CL144.PRecord.DescriptionEn);
    CL144_Logical: str := CL144.Logical08ToStr(TLogicalData08(CL144.PRecord.Logical));
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
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
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

function TCL144Coll.GetCollType: TCollectionsType;
begin
  Result := ctCL144;
end;

function TCL144Coll.GetCollDelType: TCollectionsType;
begin
  Result := ctCL144Del;
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
    CL144_note: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_cl142: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_units: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_cl012: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_cl028: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_cl138: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_conclusion: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_DescriptionEn: str :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    CL144_Logical: str :=  CL144.Logical08ToStr(CL144.getLogical08Map(Self.Buf, Self.posData, propIndex));
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
    end;
  end;
end;

procedure TCL144Coll.IndexValueListNodes(propIndex: TCL144Item.TPropertyIndex);
begin

end;

function TCL144Coll.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TCL144Item.TPropertyIndex(PropIndex) in  VisibleColl;
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

{=== TEXT SEARCH HANDLER ===}
procedure TCL144Coll.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TCL144Item.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TCL144Item.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TCL144Item.TPropertyIndex(Field) of
CL144_Key: ListForFinder[0].PRecord.Key := AText;
    CL144_Description: ListForFinder[0].PRecord.Description := AText;
    CL144_note: ListForFinder[0].PRecord.note := AText;
    CL144_cl142: ListForFinder[0].PRecord.cl142 := AText;
    CL144_units: ListForFinder[0].PRecord.units := AText;
    CL144_cl012: ListForFinder[0].PRecord.cl012 := AText;
    CL144_cl028: ListForFinder[0].PRecord.cl028 := AText;
    CL144_cl138: ListForFinder[0].PRecord.cl138 := AText;
    CL144_conclusion: ListForFinder[0].PRecord.conclusion := AText;
    CL144_DescriptionEn: ListForFinder[0].PRecord.DescriptionEn := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TCL144Coll.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL144Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;
  
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TCL144Coll.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TCL144Item.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TCL144Coll.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TCL144Item.TPropertyIndex(Field) of
    CL144_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalCL144(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalCL144(logIndex))   
    end;
  end;
end;


procedure TCL144Coll.OnSetTextSearchLog(Log: TlogicalCL144Set);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TCL144Coll.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TCL144Coll.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TCL144Item.TPropertyIndex(propIndex) of
    CL144_Key: Result := actAnsiString;
    CL144_Description: Result := actAnsiString;
    CL144_note: Result := actAnsiString;
    CL144_cl142: Result := actAnsiString;
    CL144_units: Result := actAnsiString;
    CL144_cl012: Result := actAnsiString;
    CL144_cl028: Result := actAnsiString;
    CL144_cl138: Result := actAnsiString;
    CL144_conclusion: Result := actAnsiString;
    CL144_DescriptionEn: Result := actAnsiString;
    CL144_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TCL144Coll.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TCL144Coll.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  CL144: TCL144Item;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  CL144 := Items[ARow];
  if not Assigned(CL144.PRecord) then
  begin
    New(CL144.PRecord);
    CL144.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCL144Item.TPropertyIndex(ACol) of
      CL144_Key: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_Description: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_note: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_cl142: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_units: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_cl012: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_cl028: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_cl138: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_conclusion: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    CL144_DescriptionEn: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
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
    CL144_note: CL144.PRecord.note := AValue;
    CL144_cl142: CL144.PRecord.cl142 := AValue;
    CL144_units: CL144.PRecord.units := AValue;
    CL144_cl012: CL144.PRecord.cl012 := AValue;
    CL144_cl028: CL144.PRecord.cl028 := AValue;
    CL144_cl138: CL144.PRecord.cl138 := AValue;
    CL144_conclusion: CL144.PRecord.conclusion := AValue;
    CL144_DescriptionEn: CL144.PRecord.DescriptionEn := AValue;
    CL144_Logical: CL144.PRecord.Logical := tlogicalCL144Set(CL144.StrToLogical08(AValue));
  end;
end;

procedure TCL144Coll.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  CL144: TCL144Item;
begin
  if Count = 0 then Exit;
  isOld := False; 
  CL144 := Items[ARow];
  if not Assigned(CL144.PRecord) then
  begin
    New(CL144.PRecord);
    CL144.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TCL144Item.TPropertyIndex(ACol) of
      CL144_Key: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_Description: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_note: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_cl142: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_units: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_cl012: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_cl028: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_cl138: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_conclusion: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    CL144_DescriptionEn: isOld :=  CL144.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
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
    CL144_note: CL144.PRecord.note := AFieldText;
    CL144_cl142: CL144.PRecord.cl142 := AFieldText;
    CL144_units: CL144.PRecord.units := AFieldText;
    CL144_cl012: CL144.PRecord.cl012 := AFieldText;
    CL144_cl028: CL144.PRecord.cl028 := AFieldText;
    CL144_cl138: CL144.PRecord.cl138 := AFieldText;
    CL144_conclusion: CL144.PRecord.conclusion := AFieldText;
    CL144_DescriptionEn: CL144.PRecord.DescriptionEn := AFieldText;
    CL144_Logical: CL144.PRecord.Logical := tlogicalCL144Set(CL144.StrToLogical08(AFieldText));
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
      CL144_note:
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
      CL144_units:
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
      CL144_DescriptionEn:
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

procedure TCL144Coll.ShowGridFromList(Grid: TTeeGrid; LST: TList<TCL144Item>);
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
      CL144_note: SortByIndexAnsiString;
      CL144_cl142: SortByIndexAnsiString;
      CL144_units: SortByIndexAnsiString;
      CL144_cl012: SortByIndexAnsiString;
      CL144_cl028: SortByIndexAnsiString;
      CL144_cl138: SortByIndexAnsiString;
      CL144_conclusion: SortByIndexAnsiString;
      CL144_DescriptionEn: SortByIndexAnsiString;
  end;
end;

{NZIS_START}
procedure TCL144Coll.ImportXMLNzis(cl000: TObject);
var
 Acl000 : TCL000EntryCollection;
 entry : TCL000EntryItem;
 item : TCL144Item;
 i, idxOld, j: Integer;
 idx : array of Integer;
 propIdx: TCL144Item.TPropertyIndex;
 propName, xmlName, oldValue, newValue: string;
 kindDiff: TDiffKind; pCardinalData: PCardinal;
 dataPosition: Cardinal; IsNew: Boolean;
begin
  Acl000 := TCL000EntryCollection(cl000);
  IsNew := Count = 0;

  for i := 0 to Count - 1 do
  begin
    if PWord(PByte(Buf) + Items[i].DataPos - 4)^ = Ord(ctCL144Del) then
      Continue;
    PWord(PByte(Buf) + Items[i].DataPos - 4)^ := Ord(ctCL144Old);
  end;

  BuildKeyDict(Ord(CL144_Key));

  j := 0;
  SetLength(idx, 0);

  for propIdx := Low(TCL144Item.TPropertyIndex) to High(TCL144Item.TPropertyIndex) do
  begin
    propName := TRttiEnumerationType.GetName(propIdx);

    if SameText(propName, 'CL144_Key') then Continue;
    if SameText(propName, 'CL144_Description') then Continue;
    if SameText(propName, 'CL144_Logical') then Continue;

    xmlName := propName.Substring(Length('CL144_'));
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
      item := TCL144Item(Add);
      kindDiff := dkNew;
    end;

    if item.PRecord <> nil then
      Dispose(item.PRecord);
    New(item.PRecord);
    item.PRecord.setProp := [];

    newValue := entry.Key;
    oldValue := getAnsiStringMap(item.DataPos, Ord(CL144_Key));
    item.PRecord.Key := newValue;
    if oldValue <> newValue then Include(item.PRecord.setProp, CL144_Key);

    newValue := entry.Descr;
    oldValue := getAnsiStringMap(item.DataPos, Ord(CL144_Description));
    item.PRecord.Description := newValue;
    if oldValue <> newValue then Include(item.PRecord.setProp, CL144_Description);

    j := 0;
    // note
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL144_note));

      Item.PRecord.note := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL144_note);
    end;
    Inc(j);

    // cl142
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL144_cl142));

      Item.PRecord.cl142 := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL144_cl142);
    end;
    Inc(j);

    // units
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL144_units));

      Item.PRecord.units := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL144_units);
    end;
    Inc(j);

    // cl012
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL144_cl012));

      Item.PRecord.cl012 := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL144_cl012);
    end;
    Inc(j);

    // cl028
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL144_cl028));

      Item.PRecord.cl028 := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL144_cl028);
    end;
    Inc(j);

    // cl138
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL144_cl138));

      Item.PRecord.cl138 := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL144_cl138);
    end;
    Inc(j);

    // conclusion
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL144_conclusion));

      Item.PRecord.conclusion := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL144_conclusion);
    end;
    Inc(j);

    // DescriptionEn
    if (j < Length(idx)) and (entry.FMetaDataFields[idx[j]] <> nil) then
    begin
      newValue := entry.FMetaDataFields[idx[j]].Value;
      oldValue := getAnsiStringMap(item.DataPos, Ord(CL144_DescriptionEn));

      Item.PRecord.DescriptionEn := entry.FMetaDataFields[idx[j]].Value;
      if (oldValue <> newValue) then Include(item.PRecord.setProp, CL144_DescriptionEn);
    end;
    Inc(j);

    // NEW
    if kindDiff = dkNew then
    begin
      if IsNew then
      begin
        item.InsertCL144;
        PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL144);
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
          item.SaveCL144(dataPosition);
          PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL144);
          Self.streamComm.Len := Self.streamComm.Size;
          Self.cmdFile.CopyFrom(Self.streamComm, 0);
          pCardinalData^ := dataPosition - PosData;
        end
        else
          PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL144);
      end
      else
      begin
        Dispose(item.PRecord);
        item.PRecord := nil;
        PWord(PByte(Buf) + item.DataPos - 4)^ := Ord(ctCL144);
      end;
    end;
  end;
end;

procedure TCL144Coll.UpdateXMLNzis;
var
  i: Integer;
  pCardinalData: PCardinal;
  dataPosition: Cardinal;
begin
  for i := 0 to Count - 1 do
  begin
    if Items[i].PRecord = nil then
    begin
      if Pword(PByte(Buf) + Items[i].DataPos +  - 4)^ = ord(ctCL144Old) then
        Pword(PByte(Buf) + Items[i].DataPos +  - 4)^ := ord(ctCL144Del);
        Continue;
    end;


    if Items[i].DataPos = 0 then
    begin
      Items[i].InsertCL144;
      Self.streamComm.Len := Self.streamComm.Size;
      Self.cmdFile.CopyFrom(Self.streamComm, 0);
      Dispose(Items[i].PRecord);
      Items[i].PRecord := nil;
    end
    else
    begin
      pCardinalData := pointer(PByte(self.Buf) + 12);
      dataPosition := pCardinalData^ + self.PosData;
      Items[i].SaveCL144(dataPosition);
      self.streamComm.Len := self.streamComm.Size;
      Self.CmdFile.CopyFrom(self.streamComm, 0);
      pCardinalData := pointer(PByte(Buf) + 12);
      pCardinalData^  := dataPosition - self.PosData;
    end;

  end;
end;

procedure TCL144Coll.BuildKeyDict(PropIndex: Word);
var
  i      : Integer;
  item   : TCL144Item;
  keyStr : string;
  pIdx   : TCL144Item.TPropertyIndex;
begin
  // общата част – алокация / чистене на речника
  inherited BuildKeyDict(PropIndex);

  // кастваме Word > enum на генерирания клас
  pIdx := TCL144Item.TPropertyIndex(PropIndex);

  for i := 0 to Count - 1 do
  begin
    item := Items[i];
    if Pword(PByte(Buf) + item.DataPos +  - 4)^ = ord(ctCL144Del) then
      Continue;
    keyStr := self.getAnsiStringMap(item.datapos,PropIndex);

    if keyStr <> '' then
    begin
      // ако има дубликати – последният печели (полезно за "последна версия")
      KeyDict.AddOrSetValue(keyStr, i);
    end;
  end;
end;

function TCL144Coll.CellDiffKind(ACol, ARow: Integer): TDiffKind;
begin
  if (ARow > count) or (ARow < 0) then
    Exit;


  if items[ARow].DataPos = 0 then
  begin
    Result := dkNew;
    Exit;
  end;

  if (Pword(PByte(Buf) + items[ARow].DataPos +  - 4)^ = ord(ctCL144Old)) then
  begin
    Result := dkForDeleted;
    Exit;
  end;

  if (Pword(PByte(Buf) + items[ARow].DataPos +  - 4)^ = ord(ctCL144Del)) then
  begin
    Result := dkDeleted;
    Exit;
  end;

  if Items[ARow].PRecord = nil then
  begin
    Result := dkNone;
    Exit;
  end;

  if TCL144Item.TPropertyIndex(ACol) in Items[ARow].PRecord.setProp then
  begin
    Result := dkChanged;
    Exit;
  end;
  //test

end;

{NZIS_END}

end.