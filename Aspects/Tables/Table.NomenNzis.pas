unit Table.NomenNzis;

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

TLogicalNomenNzis = (
    IsXML,
    IsExcel,
    StatusImport_none,
    StatusImport_xml,
    StatusImport_adb,
    StatusImport_save );
TlogicalNomenNzisSet = set of TLogicalNomenNzis;


TNomenNzisItem = class(TBaseItem)
  public
    type
      TPropertyIndex = (
       NomenNzis_NomenID
       , NomenNzis_NomenName
       , NomenNzis_Logical
       );
	  
      TSetProp = set of TPropertyIndex;
      PSetProp = ^TSetProp;
      PRecNomenNzis = ^TRecNomenNzis;
      TRecNomenNzis = record
        NomenID: AnsiString;
        NomenName: AnsiString;
        Logical: TlogicalNomenNzisSet;
        setProp: TSetProp;
      end;

  public
    PRecord: ^TRecNomenNzis;
	IndexInt: Integer;
	IndexWord: Word;
	IndexAnsiStr: PAnsiChar;
    IndexAnsiStr1: AnsiString;
    IndexField: TPropertyIndex;
	
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure InsertNomenNzis;
    procedure UpdateNomenNzis;
    procedure SaveNomenNzis(var dataPosition: Cardinal)overload;
	procedure SaveNomenNzis(Abuf: Pointer; var dataPosition: Cardinal)overload;
	function IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean; override;
	function GetPRecord: Pointer; override;
    procedure FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>); override;
    function GetCollType: TCollectionsType; override;
	procedure ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree; vCmd: PVirtualNode; CmdItem: TCmdItem);
	procedure FillPropNomenNzis(propindex: TPropertyIndex; stream: TStream);
  end;


  TNomenNzisColl = class(TBaseCollection)
  private
    FSearchingInt: Integer;
    FSearchingValue: string;
	tempItem: TNomenNzisItem;
    function GetItem(Index: Integer): TNomenNzisItem;
    procedure SetItem(Index: Integer; const Value: TNomenNzisItem);
    procedure SetSearchingValue(const Value: string);
  public
    FindedRes: TFindedResult;
	linkOptions: TMappedLinkFile;
	ListForFinder: TList<TNomenNzisItem>;
    ListNomenNzisSearch: TList<TNomenNzisItem>;
	PRecordSearch: ^TNomenNzisItem.TRecNomenNzis;
    ArrPropSearch: TArray<TNomenNzisItem.TPropertyIndex>;
    ArrPropSearchClc: TArray<TNomenNzisItem.TPropertyIndex>;
	VisibleColl: TNomenNzisItem.TSetProp;
	ArrayPropOrder: TArray<TNomenNzisItem.TPropertyIndex>;
    ArrayPropOrderSearchOptions: TArray<integer>;

    constructor Create(ItemClass: TCollectionItemClass);override;
    destructor destroy; override;

    function AddItem(ver: word):TNomenNzisItem;
	function AddItemForSearch: Integer;
    procedure GetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellSearch(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
    procedure GetCellDataPos(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    function PropType(propIndex: Word): TAspectTypeKind; override;
    procedure GetCellList(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetCellFromMap(propIndex: word; ARow: Integer; NomenNzis: TNomenNzisItem; var AValue:String);
    procedure GetCellFromRecord(propIndex: word; NomenNzis: TNomenNzisItem; var AValue:String);
	procedure GetCellListNodes(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);override;
    procedure SetCell(Sender:TObject; const AColumn:TColumn; const ARow:Integer; var AValue:String);
	procedure GetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SetFieldText(Sender:TObject; const ACol, ARow:Integer; var AFieldText:String);
    procedure SortByIndexValue(propIndex: TNomenNzisItem.TPropertyIndex);
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
	procedure ShowGridFromList(Grid: TTeeGrid; LST: TList<TNomenNzisItem>);
	procedure ShowSearchedGrid(Grid: TTeeGrid);
    
    procedure IndexValue(propIndex: TNomenNzisItem.TPropertyIndex);
	procedure IndexValueListNodes(propIndex:  TNomenNzisItem.TPropertyIndex);
    property Items[Index: Integer]: TNomenNzisItem read GetItem write SetItem;
	procedure OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
    property SearchingValue: string read FSearchingValue write SetSearchingValue;
    procedure OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
	procedure OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
    procedure OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
    procedure OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
    procedure OnSetTextSearchLog(Log: TlogicalNomenNzisSet);
	procedure CheckForSave(var cnt: Integer);
	function IsCollVisible(PropIndex: Word): Boolean; override;
    procedure ApplyVisibilityFromTree(RootNode: PVirtualNode);override;
	function GetCollType: TCollectionsType; override;
	function GetCollDelType: TCollectionsType; override;
  end;

implementation

{ TNomenNzisItem }

constructor TNomenNzisItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TNomenNzisItem.Destroy;
begin
  if Assigned(PRecord) then
    Dispose(PRecord);
  inherited;
end;

procedure TNomenNzisItem.FillPRecord(SetOfProp: TParamSetProp; arrstr: TArray<string>);
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

function TNomenNzisItem.GetCollType: TCollectionsType;
begin
  Result := ctNomenNzis;
end;

function TNomenNzisItem.GetPRecord: Pointer;
begin
  result := Pointer(PRecord);
end;

procedure TNomenNzisItem.InsertNomenNzis;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  FPosMetaData, FLenMetaData, FPosData, FLenData: Cardinal;
  propIndx: TPropertyIndex;
  pCardinalData: ^Cardinal;
  pWordData: ^Word;
begin
  CollType := Aspects.Types.TCollectionsType.ctNomenNzis;
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
            NomenNzis_NomenID: SaveData(PRecord.NomenID, PropPosition, metaPosition, dataPosition);
            NomenNzis_NomenName: SaveData(PRecord.NomenName, PropPosition, metaPosition, dataPosition);
            NomenNzis_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

function  TNomenNzisItem.IsFullFinded(buf: Pointer; FPosDataADB: Cardinal; coll: TCollection): Boolean;
var
  i: Integer;
  pidx:  TNomenNzisItem.TPropertyIndex;
  cot: TConditionSet;
  ATempItem: TNomenNzisItem;
begin
  Result := True;
  for i := 0 to Length(TNomenNzisColl(coll).ArrPropSearchClc) - 1 do
  begin
    if Result = false then
      Exit;
    pidx := TNomenNzisColl(coll).ArrPropSearchClc[i];
	ATempItem := TNomenNzisColl(coll).ListForFinder.Items[0];
    cot := ATempItem.ArrCondition[word(pidx)];
    begin
      case pidx of
        NomenNzis_NomenID: Result := IsFinded(ATempItem.PRecord.NomenID, buf, FPosDataADB, word(NomenNzis_NomenID), cot);
            NomenNzis_NomenName: Result := IsFinded(ATempItem.PRecord.NomenName, buf, FPosDataADB, word(NomenNzis_NomenName), cot);
            NomenNzis_Logical: Result := IsFinded(TLogicalData08(ATempItem.PRecord.Logical), buf, FPosDataADB, word(NomenNzis_Logical), cot);
      end;
    end;
  end;
end;

procedure TNomenNzisItem.ReadCmd(stream: TStream; vtrTemp: TVirtualStringTree;
  vCmd: PVirtualNode; CmdItem: TCmdItem);
var
  delta: integer;
  flds08: TLogicalData08;
  propindexNomenNzis: TNomenNzisItem.TPropertyIndex;
  vCmdProp: PVirtualNode;
  dataCmdProp: PAspRec;
begin
  delta := sizeof(TLogicalData128) - sizeof(TLogicalData08);
  stream.Read(flds08, sizeof(TLogicalData08));
  stream.Position := stream.Position + delta;
  New(self.PRecord);

  self.PRecord.setProp := TNomenNzisItem.TSetProp(flds08);// тука се записва какво има като полета


  for propindexNomenNzis := Low(TNomenNzisItem.TPropertyIndex) to High(TNomenNzisItem.TPropertyIndex) do
  begin
    if not (propindexNomenNzis in self.PRecord.setProp) then
      continue;
    if vtrTemp <> nil then
    begin
      vCmdProp := vtrTemp.AddChild(vCmd, nil);
      dataCmdProp := vtrTemp.GetNodeData(vCmdProp);
      dataCmdProp.index := word(propindexNomenNzis);
      dataCmdProp.vid := vvPregledNew;
    end;
    self.FillPropNomenNzis(propindexNomenNzis, stream);
  end;

  CmdItem.AdbItem := self;
end;

procedure TNomenNzisItem.FillPropNomenNzis(propindex: TPropertyIndex;
  stream: TStream);
var
  lenStr: Word;
begin
  case propindex of
    NomenNzis_NomenID:
        begin
          stream.Read(lenStr, 2);
          SetLength(Self.PRecord.NomenID, lenStr);
          stream.Read(Self.PRecord.NomenID[1], lenStr);
        end;
            NomenNzis_NomenName:
            begin
              stream.Read(lenStr, 2);
              SetLength(Self.PRecord.NomenName, lenStr);
              stream.Read(Self.PRecord.NomenName[1], lenStr);
            end;
            NomenNzis_Logical: stream.Read(Self.PRecord.Logical, SizeOf(TLogicalData08));
  end;
end;

procedure TNomenNzisItem.SaveNomenNzis(Abuf: Pointer; var dataPosition: Cardinal);
var
  pCardinalData: PCardinal;
  APosData, ALenData: Cardinal;
begin
  pCardinalData := pointer(PByte(ABuf) + 8);
  APosData := pCardinalData^;
  pCardinalData := pointer(PByte(ABuf) + 12);
  ALenData := pCardinalData^;
  dataPosition :=  ALenData + APosData;
  SaveNomenNzis(dataPosition);
end;

procedure TNomenNzisItem.SaveNomenNzis(var dataPosition: Cardinal);
var
  CollType: TCollectionsType;
  metaPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNomenNzis;
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
            NomenNzis_NomenID: SaveData(PRecord.NomenID, PropPosition, metaPosition, dataPosition);
            NomenNzis_NomenName: SaveData(PRecord.NomenName, PropPosition, metaPosition, dataPosition);
            NomenNzis_Logical: SaveData(TLogicalData08(PRecord.Logical), PropPosition, metaPosition, dataPosition);
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

procedure TNomenNzisItem.UpdateNomenNzis;
var
  CollType: TCollectionsType;
  metaPosition, dataPosition, PropPosition: cardinal;
  propIndx: TPropertyIndex;
begin
  CollType := ctNomenNzis;
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
            NomenNzis_NomenID: UpdateData(PRecord.NomenID, PropPosition, metaPosition, dataPosition);
            NomenNzis_NomenName: UpdateData(PRecord.NomenName, PropPosition, metaPosition, dataPosition);
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

{ TNomenNzisColl }

function TNomenNzisColl.AddItem(ver: word): TNomenNzisItem;
begin
  Result := TNomenNzisItem(add);
  Result.Version := ver;
  case ver of // в зависимост от версията на записа
    0:
    begin
    end;
  end;
end;

function TNomenNzisColl.AddItemForSearch: Integer;
var
  ItemForSearch: TNomenNzisItem;
begin
  ItemForSearch := TNomenNzisItem.Create(nil);
  SetLength(ItemForSearch.ArrCondition, self.FieldCount);

  New(ItemForSearch.PRecord);
  ItemForSearch.PRecord.setProp := [];
  ItemForSearch.PRecord.Logical := [];
  Result := ListForFinder.Add(ItemForSearch);
end;

procedure TNomenNzisColl.ApplyVisibilityFromTree(RootNode: PVirtualNode);
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
      Include(VisibleColl, TNomenNzisItem.TPropertyIndex(run.Dummy - 1));

    run := run.NextSibling;
  end;
end;


function TNomenNzisColl.CreateRootCollOptionNode(): PVirtualNode;
var
  NodeRoot, vOptionSearchGrid, vOptionSearchCOT, run: PVirtualNode;
  linkPos: Cardinal;
  pCardinalData: PCardinal;
  i: Integer;
begin
  NodeRoot := Pointer(PByte(linkOptions.Buf) + 100);
  linkOptions.AddNewNode(vvNomenNzisRoot, 0, NodeRoot , amAddChildLast, result, linkPos);
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

procedure TNomenNzisColl.CheckForSave(var cnt: Integer);
var
  i: Integer;
  tempItem: TNomenNzisItem;
begin
  for i := 0 to Self.Count - 1 do
  begin
    tempItem := Items[i];
    if tempItem.PRecord <> nil then
    begin
	  // === проверки за запазване (CheckForSave) ===

  if (NomenNzis_NomenID in tempItem.PRecord.setProp) and (tempItem.PRecord.NomenID <> Self.getAnsiStringMap(tempItem.DataPos, word(NomenNzis_NomenID))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NomenNzis_NomenName in tempItem.PRecord.setProp) and (tempItem.PRecord.NomenName <> Self.getAnsiStringMap(tempItem.DataPos, word(NomenNzis_NomenName))) then
  begin
    inc(cnt);
    exit;
  end;

  if (NomenNzis_Logical in tempItem.PRecord.setProp) and (TLogicalData08(tempItem.PRecord.Logical) <> Self.getLogical08Map(tempItem.DataPos, word(NomenNzis_Logical))) then
  begin
    inc(cnt);
    exit;
  end;
    end;
  end;
end;


constructor TNomenNzisColl.Create(ItemClass: TCollectionItemClass);
var
  i: Integer;
begin
  inherited;
  tempItem := TNomenNzisItem.Create(nil);
  ListNomenNzisSearch := TList<TNomenNzisItem>.Create;
  ListForFinder := TList<TNomenNzisItem>.Create;
  New(PRecordSearch);
  PRecordSearch.setProp := [];
  SetLength(ArrayPropOrderSearchOptions, FieldCount + 1);
  ArrayPropOrderSearchOptions[0] := FieldCount;
  for i := 1 to FieldCount do
  begin
    ArrayPropOrderSearchOptions[i] := i;
  end;

end;

destructor TNomenNzisColl.destroy;
begin
  FreeAndNil(ListNomenNzisSearch);
  FreeAndNil(ListForFinder);
  FreeAndNil(TempItem);
  Dispose(PRecordSearch);
  PRecordSearch := nil;
  inherited;
end;

function TNomenNzisColl.DisplayName(propIndex: Word): string;
begin
  inherited;
  case TNomenNzisItem.TPropertyIndex(propIndex) of
    NomenNzis_NomenID: Result := 'NomenID';
    NomenNzis_NomenName: Result := 'NomenName';
    NomenNzis_Logical: Result := 'Logical';
  end;
end;

function TNomenNzisColl.DisplayLogicalName(flagIndex: Integer): string;
begin
  case flagIndex of
0: Result := 'IsXML';
    1: Result := 'IsExcel';
    2: Result := 'StatusImport_none';
    3: Result := 'StatusImport_xml';
    4: Result := 'StatusImport_adb';
    5: Result := 'StatusImport_save';
  else
    Result := '???';
  end;
end;


procedure TNomenNzisColl.DoColMoved(const Acol: TColumn; const OldPos, NewPos: Integer);
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


function TNomenNzisColl.FieldCount: Integer; 
begin
  inherited;
  Result := 3;
end;

function TNomenNzisColl.FindRootCollOptionNode(): PVirtualNode;
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
    if data.vid = vvNomenNzisRoot then
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

function TNomenNzisColl.FindSearchFieldCollOptionCOTNode: PVirtualNode;
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

function TNomenNzisColl.FindSearchFieldCollOptionGridNode: PVirtualNode;
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

function TNomenNzisColl.FindSearchFieldCollOptionNode(): PVirtualNode;
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

procedure TNomenNzisColl.GetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NomenNzis: TNomenNzisItem;
  ACol: Integer;
  prop: TNomenNzisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NomenNzis := Items[ARow];
  prop := TNomenNzisItem.TPropertyIndex(ACol);
  if Assigned(NomenNzis.PRecord) and (prop in NomenNzis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NomenNzis, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NomenNzis, AValue);
  end;
end;

procedure TNomenNzisColl.GetCellDataPos(Sender: TObject; const AColumn: TColumn; const ARow:Integer; var AValue: String);
var
  RowSelect: Integer;
  prop: TNomenNzisItem.TPropertyIndex;
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

procedure TNomenNzisColl.GetCellFromRecord(propIndex: word; NomenNzis: TNomenNzisItem; var AValue: String);
var
  str: string;
begin
  case TNomenNzisItem.TPropertyIndex(propIndex) of
    NomenNzis_NomenID: str := (NomenNzis.PRecord.NomenID);
    NomenNzis_NomenName: str := (NomenNzis.PRecord.NomenName);
    NomenNzis_Logical: str := NomenNzis.Logical08ToStr(TLogicalData08(NomenNzis.PRecord.Logical));
  else
    begin
      str := '';
    end;
  end;
  AValue := str;
end;

procedure TNomenNzisColl.GetCellList(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  AtempItem: TNomenNzisItem;
  ACol: Integer;
  prop: TNomenNzisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if ListForFinder.Count = 0 then Exit;

  AtempItem := ListForFinder[ARow];
  prop := TNomenNzisItem.TPropertyIndex(ACol);
  if Assigned(AtempItem.PRecord) and (prop in AtempItem.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, AtempItem, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, AtempItem, AValue);
  end;
end;

procedure TNomenNzisColl.GetCellListNodes(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  ACol: Integer;
  prop: TNomenNzisItem.TPropertyIndex;
begin
  inherited;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if (ListNodes.count - 1) < ARow then exit;
  
  TempItem.DataPos := ListNodes[ARow].DataPos;
  prop := TNomenNzisItem.TPropertyIndex(ACol);
  GetCellFromMap(ACol, ARow, TempItem, AValue);
end;

procedure TNomenNzisColl.GetCellSearch(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  NomenNzis: TNomenNzisItem;
  ACol: Integer;
  prop: TNomenNzisItem.TPropertyIndex;
begin
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  if Count = 0 then Exit;

  NomenNzis := ListNomenNzisSearch[ARow];
  prop := TNomenNzisItem.TPropertyIndex(ACol);
  if Assigned(NomenNzis.PRecord) and (prop in NomenNzis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NomenNzis, AValue);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NomenNzis, AValue);
  end;
end;

function TNomenNzisColl.GetCollType: TCollectionsType;
begin
  Result := ctNomenNzis;
end;

function TNomenNzisColl.GetCollDelType: TCollectionsType;
begin
  Result := ctNomenNzisDel;
end;

procedure TNomenNzisColl.GetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  NomenNzis: TNomenNzisItem;
  prop: TNomenNzisItem.TPropertyIndex;
begin
  if Count = 0 then Exit;

  NomenNzis := Items[ARow];
  prop := TNomenNzisItem.TPropertyIndex(ACol);
  if Assigned(NomenNzis.PRecord) and (prop in NomenNzis.PRecord.setProp) then
  begin
    GetCellFromRecord(ACol, NomenNzis, AFieldText);
  end
  else
  begin
    GetCellFromMap(ACol, ARow, NomenNzis, AFieldText);
  end;
end;

procedure TNomenNzisColl.GetCellFromMap(propIndex: word; ARow: Integer; NomenNzis: TNomenNzisItem; var AValue: String);
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
  case TNomenNzisItem.TPropertyIndex(propIndex) of
    NomenNzis_NomenID: str :=  NomenNzis.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NomenNzis_NomenName: str :=  NomenNzis.getAnsiStringMap(Self.Buf, Self.posData, propIndex);
    NomenNzis_Logical: str :=  NomenNzis.Logical08ToStr(NomenNzis.getLogical08Map(Self.Buf, Self.posData, propIndex));
  else
    begin
      str := IntToStr(ARow + 1);
    end;
  end;
  AValue := str;
end;

function TNomenNzisColl.GetItem(Index: Integer): TNomenNzisItem;
begin
  Result := TNomenNzisItem(inherited GetItem(Index));
end;


procedure TNomenNzisColl.IndexValue(propIndex: TNomenNzisItem.TPropertyIndex);
var
  i: Integer;
  len: Word;
  TempItem: TNomenNzisItem;
begin
  for i := 0 to self.Count - 1 do
  begin
    TempItem := self.Items[i];
    case propIndex of
      NomenNzis_NomenID:
begin
  TempItem.IndexAnsiStr :=  TempItem.getPAnsiStringMap(Self.Buf, self.posData, word(propIndex), len);
  if TempItem.IndexAnsiStr <> nil then
  begin
    TempItem.IndexAnsiStr1 := AnsiString(TempItem.IndexAnsiStr);
  end
  else
    TempItem.IndexAnsiStr1 := '';
end;
      NomenNzis_NomenName:
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

procedure TNomenNzisColl.IndexValueListNodes(propIndex: TNomenNzisItem.TPropertyIndex);
begin

end;

function TNomenNzisColl.IsCollVisible(PropIndex: Word): Boolean;
begin
  Result  := TNomenNzisItem.TPropertyIndex(PropIndex) in  VisibleColl;
end;


procedure TNomenNzisColl.OnGetTextDynFMX(sender: TObject; field: Word; index: Integer; datapos: Cardinal; var value: string);
var
  Tempitem: TNomenNzisItem;
begin
  if index < 0 then
  begin
    Tempitem := TNomenNzisItem.Create(nil);
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
procedure TNomenNzisColl.OnSetTextSearchEDT(Text: string; field: Word; Condition: TConditionSet);
var
  AText: string;
begin
  if Text = '' then
  begin
    Exclude(ListForFinder[0].PRecord.setProp, TNomenNzisItem.TPropertyIndex(Field));
  end
  else
  begin
    if not (cotSens in Condition) then
      AText := AnsiUpperCase(Text)
    else
      AText := Text;

    Include(ListForFinder[0].PRecord.setProp, TNomenNzisItem.TPropertyIndex(Field));
  end;

  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  case TNomenNzisItem.TPropertyIndex(Field) of
NomenNzis_NomenID: ListForFinder[0].PRecord.NomenID := AText;
    NomenNzis_NomenName: ListForFinder[0].PRecord.NomenName := AText;
  end;
end;


{=== DATE SEARCH HANDLER ===}
procedure TNomenNzisColl.OnSetDateSearchEDT(Value: TDate; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TNomenNzisItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  //case TNomenNzisItem.TPropertyIndex(Field) of
//
//  end;
end;


{=== NUMERIC SEARCH HANDLER ===}
procedure TNomenNzisColl.OnSetNumSearchEDT(Value: Integer; field: Word; Condition: TConditionSet);
begin
  Include(ListForFinder[0].PRecord.setProp, TNomenNzisItem.TPropertyIndex(Field));
  Self.PRecordSearch.setProp := ListForFinder[0].PRecord.setProp;

  //case TNomenNzisItem.TPropertyIndex(Field) of
//
//  end;
end;


{=== LOGICAL (CHECKBOX) SEARCH HANDLER ===}
procedure TNomenNzisColl.OnSetLogicalSearchEDT(Value: Boolean; field, logIndex: Word);
begin
  case TNomenNzisItem.TPropertyIndex(Field) of
    NomenNzis_Logical:
    begin
      if value then
        Include(ListForFinder[0].PRecord.Logical, TlogicalNomenNzis(logIndex))
      else
        Exclude(ListForFinder[0].PRecord.Logical, TlogicalNomenNzis(logIndex))   
    end;
  end;
end;


procedure TNomenNzisColl.OnSetTextSearchLog(Log: TlogicalNomenNzisSet);
begin
  ListForFinder[0].PRecord.Logical := Log;
end;

procedure TNomenNzisColl.OrderFieldsSearch1(Grid: TTeeGrid);
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

function TNomenNzisColl.PropType(propIndex: Word): TAspectTypeKind;
begin
  inherited;
  case TNomenNzisItem.TPropertyIndex(propIndex) of
    NomenNzis_NomenID: Result := actAnsiString;
    NomenNzis_NomenName: Result := actAnsiString;
    NomenNzis_Logical: Result := actLogical;
  else
    Result := actNone;
  end
end;

function TNomenNzisColl.RankSortOption(propIndex: Word): cardinal;
begin
  //
end;

procedure TNomenNzisColl.SetCell(Sender: TObject; const AColumn: TColumn; const ARow: Integer; var AValue: String);
var
  isOld: Boolean;
  NomenNzis: TNomenNzisItem;
  ACol: Integer;
begin
  if Count = 0 then Exit;
  ACol := TVirtualModeData(Sender).IndexOf(AColumn);
  isOld := False;
  NomenNzis := Items[ARow];
  if not Assigned(NomenNzis.PRecord) then
  begin
    New(NomenNzis.PRecord);
    NomenNzis.PRecord.setProp := [];
	CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TNomenNzisItem.TPropertyIndex(ACol) of
      NomenNzis_NomenID: isOld :=  NomenNzis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    NomenNzis_NomenName: isOld :=  NomenNzis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AValue;
    end;
  end;
  if isOld then
  begin
    Exclude(NomenNzis.PRecord.setProp, TNomenNzisItem.TPropertyIndex(ACol));
    if NomenNzis.PRecord.setProp = [] then
    begin
      Dispose(NomenNzis.PRecord);
      NomenNzis.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NomenNzis.PRecord.setProp, TNomenNzisItem.TPropertyIndex(ACol));
  case TNomenNzisItem.TPropertyIndex(ACol) of
    NomenNzis_NomenID: NomenNzis.PRecord.NomenID := AValue;
    NomenNzis_NomenName: NomenNzis.PRecord.NomenName := AValue;
    NomenNzis_Logical: NomenNzis.PRecord.Logical := tlogicalNomenNzisSet(NomenNzis.StrToLogical08(AValue));
  end;
end;

procedure TNomenNzisColl.SetFieldText(Sender: TObject; const ACol, ARow: Integer; var AFieldText: String);
var
  isOld: Boolean;
  NomenNzis: TNomenNzisItem;
begin
  if Count = 0 then Exit;
  isOld := False; 
  NomenNzis := Items[ARow];
  if not Assigned(NomenNzis.PRecord) then
  begin
    New(NomenNzis.PRecord);
    NomenNzis.PRecord.setProp := [];
	  CntUpdates := CntUpdates + 1;
  end
  else
  begin
    case TNomenNzisItem.TPropertyIndex(ACol) of
      NomenNzis_NomenID: isOld :=  NomenNzis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    NomenNzis_NomenName: isOld :=  NomenNzis.getAnsiStringMap(Self.Buf, Self.posData, ACol) = AFieldText;
    end;
  end;
  if isOld then
  begin
    Exclude(NomenNzis.PRecord.setProp, TNomenNzisItem.TPropertyIndex(ACol));
    if NomenNzis.PRecord.setProp = [] then
    begin
      Dispose(NomenNzis.PRecord);
      NomenNzis.PRecord := nil;
      CntUpdates := CntUpdates - 1;
      Exit;
    end;
  end;
  Include(NomenNzis.PRecord.setProp, TNomenNzisItem.TPropertyIndex(ACol));
  case TNomenNzisItem.TPropertyIndex(ACol) of
    NomenNzis_NomenID: NomenNzis.PRecord.NomenID := AFieldText;
    NomenNzis_NomenName: NomenNzis.PRecord.NomenName := AFieldText;
    NomenNzis_Logical: NomenNzis.PRecord.Logical := tlogicalNomenNzisSet(NomenNzis.StrToLogical08(AFieldText));
  end;
end;

procedure TNomenNzisColl.SetItem(Index: Integer; const Value: TNomenNzisItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TNomenNzisColl.SetSearchingValue(const Value: string);
var
  i: Integer;
begin
  FSearchingValue := Value;
  ListNomenNzisSearch.Clear;
  for i := 0 to self.Count - 1 do
  begin
    case  TNomenNzisItem.TPropertyIndex(self.FindedRes.PropIndex) of
	  NomenNzis_NomenID:
begin
  if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
  begin
    ListNomenNzisSearch.Add(self.Items[i]);
  end;
end;
      NomenNzis_NomenName:
      begin
        if string(self.Items[i].IndexAnsiStr).StartsWith(FSearchingValue) then
        begin
          ListNomenNzisSearch.Add(self.Items[i]);
        end;
      end;
    end;
  end;
end;

procedure TNomenNzisColl.ShowGrid(Grid: TTeeGrid);
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

procedure TNomenNzisColl.ShowGridFromList(Grid: TTeeGrid; LST: TList<TNomenNzisItem>);
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

procedure TNomenNzisColl.ShowSearchedGrid(Grid: TTeeGrid);
var
  i: word;

begin
  Grid.Data:=TVirtualModeData.Create(self.FieldCount + 1, self.ListNomenNzisSearch.Count);
  for i := 0 to self.FieldCount - 1 do
  begin
    TVirtualModeData(Grid.Data).Headers[i] := self.DisplayName(i);
  end;
  TVirtualModeData(Grid.Data).Headers[self.FieldCount] := Format('Ред/%d бр.', [self.ListNomenNzisSearch.Count]);

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

procedure TNomenNzisColl.SortByIndexAnsiString;
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

procedure TNomenNzisColl.SortByIndexInt;
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

procedure TNomenNzisColl.SortByIndexWord;
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

procedure TNomenNzisColl.SortByIndexValue(propIndex: TNomenNzisItem.TPropertyIndex);
begin
  case propIndex of
    NomenNzis_NomenID: SortByIndexAnsiString;
      NomenNzis_NomenName: SortByIndexAnsiString;
  end;
end;

end.